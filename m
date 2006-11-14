Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933269AbWKNBId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269AbWKNBId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933299AbWKNBId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:08:33 -0500
Received: from elvis.mu.org ([192.203.228.196]:56261 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S933269AbWKNBIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:08:32 -0500
Message-ID: <45591706.3030106@FreeBSD.org>
Date: Mon, 13 Nov 2006 17:08:22 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Make the TSC safe to be used by gettimeofday().
References: <455916A5.2030402@FreeBSD.org>
In-Reply-To: <455916A5.2030402@FreeBSD.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is done by a per-cpu vxtime structure that stores the last TSC and HPET
values.

Whenever we switch to a userland process after a HLT instruction has been
executed or after the CPU frequency has changed, we force a new read of the
TSC, HPET and xtime so that we know the correct frequency we have to deal
with.

With this, we can safely use RDTSC in gettimeofday() in CPUs where the
TSCs are not synchronized, such as Opterons, instead of doing a very expensive
HPET read.

Signed-off-by: Suleiman Souhlal <suleiman@google.com>

---
 arch/x86_64/kernel/process.c     |   23 ++++++-
 arch/x86_64/kernel/time.c        |   38 ++++++++++--
 arch/x86_64/kernel/vmlinux.lds.S |    6 +-
 arch/x86_64/kernel/vsyscall.c    |  121 +++++++++++++++++++++++++++++++-------
 include/asm-x86_64/timex.h       |    2 +
 include/asm-x86_64/vsyscall.h    |   13 ++++
 include/linux/hrtimer.h          |    2 +
 7 files changed, 170 insertions(+), 35 deletions(-)

diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index 49f7fac..b80bc00 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -51,6 +51,7 @@ #include <asm/desc.h>
 #include <asm/proto.h>
 #include <asm/ia32.h>
 #include <asm/idle.h>
+#include <asm/vsyscall.h>
 
 asmlinkage extern void ret_from_fork(void);
 
@@ -109,15 +110,21 @@ void exit_idle(void)
  */
 static void default_idle(void)
 {
+	int cpu;
+
+	cpu = hard_smp_processor_id();
+
 	local_irq_enable();
 
 	current_thread_info()->status &= ~TS_POLLING;
 	smp_mb__after_clear_bit();
 	while (!need_resched()) {
 		local_irq_disable();
-		if (!need_resched())
+		if (!need_resched()) {
+			if (vxtime.pcpu[cpu].need_update == 0)
+				vxtime.pcpu[cpu].need_update = 1;
 			safe_halt();
-		else
+		} else
 			local_irq_enable();
 	}
 	current_thread_info()->status |= TS_POLLING;
@@ -560,7 +567,7 @@ __switch_to(struct task_struct *prev_p, 
 {
 	struct thread_struct *prev = &prev_p->thread,
 				 *next = &next_p->thread;
-	int cpu = smp_processor_id();  
+	int apicid, cpu = smp_processor_id();  
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
 	/* we're going to use this soon, after a few expensive things */
@@ -657,6 +664,16 @@ #endif
 	 */
 	if (next_p->fpu_counter>5)
 		math_state_restore();
+
+	apicid = hard_smp_processor_id();
+
+	/*
+	 * We will need to also do this when switching to kernel tasks if we
+	 * want to use the per-cpu monotonic_clock in the kernel
+	 */
+	if (vxtime.pcpu[apicid].need_update == 1 && next_p->mm != NULL)
+		vxtime_update_pcpu();
+
 	return prev_p;
 }
 
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 88722f1..55fefa2 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -118,14 +118,17 @@ unsigned int (*do_gettimeoffset)(void) =
 
 void do_gettimeofday(struct timeval *tv)
 {
-	unsigned long seq;
+	unsigned long seq, t, x;
  	unsigned int sec, usec;
+	int cpu;
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
+		preempt_disable();
+		cpu = hard_smp_processor_id();
 
-		sec = xtime.tv_sec;
-		usec = xtime.tv_nsec / NSEC_PER_USEC;
+		sec = vxtime.pcpu[cpu].tv_sec;
+		usec = vxtime.pcpu[cpu].tv_usec;
 
 		/* i386 does some correction here to keep the clock 
 		   monotonous even when ntpd is fixing drift.
@@ -135,9 +138,13 @@ void do_gettimeofday(struct timeval *tv)
 		   be found. Note when you fix it here you need to do the same
 		   in arch/x86_64/kernel/vsyscall.c and export all needed
 		   variables in vmlinux.lds. -AK */ 
-		usec += do_gettimeoffset();
+		t = get_cycles_sync();
+		x = (((t - vxtime.pcpu[cpu].last_tsc) *
+		    vxtime.pcpu[cpu].tsc_nsquot) >> NS_SCALE) / NSEC_PER_USEC;
+		usec += x;
 
 	} while (read_seqretry(&xtime_lock, seq));
+	preempt_enable();
 
 	tv->tv_sec = sec + usec / USEC_PER_SEC;
 	tv->tv_usec = usec % USEC_PER_SEC;
@@ -624,10 +631,20 @@ #endif
 		cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
 
 		cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
+		if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
+			int cpu;
+
+			cpu = cpu_physical_id(freq->cpu);
 			vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
+
+			vxtime.pcpu[cpu].tsc_nsquot = (NSEC_PER_SEC << NS_SCALE)
+			    / (cpufreq_scale(cpu_khz_ref, ref_freq, freq->new) *
+			    NSEC_PER_USEC);
+			if (vxtime.pcpu[cpu].need_update == 0)
+				vxtime.pcpu[cpu].need_update = 1;
+		}	
 	}
-	
+
 	set_cyc2ns_scale(cpu_khz_ref);
 
 	return 0;
@@ -887,6 +904,9 @@ time_cpu_notifier(struct notifier_block 
 
 void __init time_init(void)
 {
+	char *timename;
+	int i;
+
 	if (nohpet)
 		vxtime.hpet_address = 0;
 
@@ -931,13 +951,17 @@ #endif
 #ifndef CONFIG_SMP
 	time_init_gtod();
 #endif
+
+	for (i = 0; i < NR_CPUS; i++)
+		vxtime.pcpu[i].tsc_nsquot = (NSEC_PER_SEC << NS_SCALE)
+		    / (cpu_khz * NSEC_PER_USEC);
 }
 
 /*
  * Make an educated guess if the TSC is trustworthy and synchronized
  * over all CPUs.
  */
-__cpuinit int unsynchronized_tsc(void)
+int unsynchronized_tsc(void)
 {
 #ifdef CONFIG_SMP
 	if (apic_is_clustered_box())
diff --git a/arch/x86_64/kernel/vmlinux.lds.S b/arch/x86_64/kernel/vmlinux.lds.S
index edb24aa..b1a39d1 100644
--- a/arch/x86_64/kernel/vmlinux.lds.S
+++ b/arch/x86_64/kernel/vmlinux.lds.S
@@ -96,9 +96,6 @@ #define VVIRT(x) (ADDR(x) - VVIRT_OFFSET
   .xtime_lock : AT(VLOAD(.xtime_lock)) { *(.xtime_lock) }
   xtime_lock = VVIRT(.xtime_lock);
 
-  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
-  vxtime = VVIRT(.vxtime);
-
   .vgetcpu_mode : AT(VLOAD(.vgetcpu_mode)) { *(.vgetcpu_mode) }
   vgetcpu_mode = VVIRT(.vgetcpu_mode);
 
@@ -119,6 +116,9 @@ #define VVIRT(x) (ADDR(x) - VVIRT_OFFSET
   .vsyscall_2 ADDR(.vsyscall_0) + 2048: AT(VLOAD(.vsyscall_2)) { *(.vsyscall_2) }
   .vsyscall_3 ADDR(.vsyscall_0) + 3072: AT(VLOAD(.vsyscall_3)) { *(.vsyscall_3) }
 
+  .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
+  vxtime = VVIRT(.vxtime);
+
   . = VSYSCALL_VIRT_ADDR + 4096;
 
 #undef VSYSCALL_ADDR
diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index a98b460..9025699 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -27,6 +27,8 @@ #include <linux/seqlock.h>
 #include <linux/jiffies.h>
 #include <linux/sysctl.h>
 #include <linux/getcpu.h>
+#include <linux/smp.h>
+#include <linux/kthread.h>
 
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
@@ -37,6 +39,8 @@ #include <asm/io.h>
 #include <asm/segment.h>
 #include <asm/desc.h>
 #include <asm/topology.h>
+#include <asm/smp.h>
+#include <asm/proto.h>
 
 #define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
 
@@ -46,6 +50,12 @@ int __vgetcpu_mode __section_vgetcpu_mod
 
 #include <asm/unistd.h>
 
+#define	NS_SCALE 10
+#define NSEC_PER_TICK (NSEC_PER_SEC / HZ)
+extern unsigned long hpet_tick;
+
+extern unsigned long vxtime_hz;
+
 static __always_inline void timeval_normalize(struct timeval * tv)
 {
 	time_t __sec;
@@ -57,35 +67,107 @@ static __always_inline void timeval_norm
 	}
 }
 
+inline int apicid(void)
+{
+	int cpu;
+
+	__asm __volatile("cpuid" : "=b" (cpu) : "a" (1) : "cx", "dx");
+	return (cpu >> 24);
+}
+
 static __always_inline void do_vgettimeofday(struct timeval * tv)
 {
 	long sequence, t;
 	unsigned long sec, usec;
+	int cpu;
 
 	do {
 		sequence = read_seqbegin(&__xtime_lock);
-		
-		sec = __xtime.tv_sec;
-		usec = __xtime.tv_nsec / 1000;
-
-		if (__vxtime.mode != VXTIME_HPET) {
-			t = get_cycles_sync();
-			if (t < __vxtime.last_tsc)
-				t = __vxtime.last_tsc;
-			usec += ((t - __vxtime.last_tsc) *
-				 __vxtime.tsc_quot) >> 32;
-			/* See comment in x86_64 do_gettimeofday. */
-		} else {
-			usec += ((readl((void __iomem *)
-				   fix_to_virt(VSYSCALL_HPET) + 0xf0) -
-				  __vxtime.last) * __vxtime.quot) >> 32;
-		}
-	} while (read_seqretry(&__xtime_lock, sequence));
+		cpu = apicid();
+
+		sec = __vxtime.pcpu[cpu].tv_sec;
+		usec = __vxtime.pcpu[cpu].tv_usec;
+		rdtscll(t);
+
+		usec += (((t - __vxtime.pcpu[cpu].last_tsc) *
+		    __vxtime.pcpu[cpu].tsc_nsquot) >> NS_SCALE) / NSEC_PER_USEC;
+	} while (read_seqretry(&__xtime_lock, sequence) || apicid() != cpu);
 
 	tv->tv_sec = sec + usec / 1000000;
 	tv->tv_usec = usec % 1000000;
 }
 
+void vxtime_update_pcpu(void)
+{
+	unsigned long flags, offset, seq;
+	int cpu;
+	
+	write_seqlock_irqsave(&vxtime.vx_seq, flags);
+
+	cpu = hard_smp_processor_id();
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		vxtime.pcpu[cpu].tv_sec = xtime.tv_sec;
+		vxtime.pcpu[cpu].tv_usec = xtime.tv_nsec / 1000;
+		offset = hpet_readl(HPET_COUNTER) - vxtime.last;
+	} while (read_seqretry(&xtime_lock, seq));
+
+	vxtime.pcpu[cpu].tv_usec += (offset * vxtime.quot) >> 32;
+	vxtime.pcpu[cpu].last_tsc = get_cycles_sync();
+
+	if (vxtime.pcpu[cpu].need_update == 1)
+		vxtime.pcpu[cpu].need_update = 0;
+
+	write_sequnlock_irqrestore(&vxtime.vx_seq, flags);
+}
+
+static void _vxtime_update_pcpu(void *arg)
+{
+	vxtime_update_pcpu();
+}
+
+static int vxtime_periodic(void *arg)
+{
+	while (1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(msecs_to_jiffies(1000));
+
+		smp_call_function(_vxtime_update_pcpu, NULL, 1, 1);
+		_vxtime_update_pcpu(NULL);
+	}
+
+	return (0); /* NOTREACHED */
+}
+
+void clock_was_set(void)
+{
+	smp_call_function(_vxtime_update_pcpu, NULL, 1, 1);
+	_vxtime_update_pcpu(NULL);
+}
+	
+
+static __init int vxtime_init_pcpu(void)
+{
+	int i;
+
+	seqlock_init(&vxtime.vx_seq);
+
+	/*
+	 * Don't bother updating the per-cpu data after each HLT
+	 * if we don't need to.
+	 */
+	if (!unsynchronized_tsc())
+		for (i = 0; i < NR_CPUS; i++)
+			vxtime.pcpu[i].need_update = -1;
+	
+	kthread_create(vxtime_periodic, NULL, "vxtime_periodic");
+
+	return (0);
+}
+
+core_initcall(vxtime_init_pcpu);
+
 /* RED-PEN may want to readd seq locking, but then the variable should be write-once. */
 static __always_inline void do_get_tz(struct timezone * tz)
 {
@@ -174,11 +256,6 @@ vgetcpu(unsigned *cpu, unsigned *node, s
 	return 0;
 }
 
-long __vsyscall(3) venosys_1(void)
-{
-	return -ENOSYS;
-}
-
 #ifdef CONFIG_SYSCTL
 
 #define SYSCALL 0x050f
diff --git a/include/asm-x86_64/timex.h b/include/asm-x86_64/timex.h
index b9e5320..91bad25 100644
--- a/include/asm-x86_64/timex.h
+++ b/include/asm-x86_64/timex.h
@@ -46,4 +46,6 @@ #define ARCH_HAS_READ_CURRENT_TIMER	1
 
 extern struct vxtime_data vxtime;
 
+void clock_was_set(void);
+
 #endif
diff --git a/include/asm-x86_64/vsyscall.h b/include/asm-x86_64/vsyscall.h
index fd452fc..707353b 100644
--- a/include/asm-x86_64/vsyscall.h
+++ b/include/asm-x86_64/vsyscall.h
@@ -30,6 +30,14 @@ #define VXTIME_PMTMR	3
 #define VGETCPU_RDTSCP	1
 #define VGETCPU_LSL	2
 
+struct vxtime_pcpu {
+	time_t tv_sec;
+	long tv_usec;
+	unsigned long tsc_nsquot;
+	unsigned long last_tsc;
+	int need_update;
+};
+
 struct vxtime_data {
 	long hpet_address;	/* HPET base address */
 	int last;
@@ -37,6 +45,8 @@ struct vxtime_data {
 	long quot;
 	long tsc_quot;
 	int mode;
+	seqlock_t vx_seq;
+	struct vxtime_pcpu pcpu[NR_CPUS] ____cacheline_aligned;
 };
 
 #define hpet_readl(a)           readl((const void __iomem *)fix_to_virt(FIX_HPET_BASE) + a)
@@ -61,7 +71,10 @@ extern int sysctl_vsyscall;
 
 extern void vsyscall_set_cpu(int cpu);
 
+void vxtime_update_pcpu(void);
+
 #define ARCH_HAVE_XTIME_LOCK 1
+#define ARCH_HAVE_CLOCK_WAS_SET 1
 
 #endif /* __KERNEL__ */
 
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index fca9302..7f59619 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -95,12 +95,14 @@ struct hrtimer_base {
 	struct lock_class_key lock_key;
 };
 
+#ifndef ARCH_HAVE_CLOCK_WAS_SET
 /*
  * clock_was_set() is a NOP for non- high-resolution systems. The
  * time-sorted order guarantees that a timer does not expire early and
  * is expired in the next softirq when the clock was advanced.
  */
 #define clock_was_set()		do { } while (0)
+#endif
 
 /* Exported timer functions: */
 

