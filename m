Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWHJTfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWHJTfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWHJTfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:47 -0400
Received: from ns.suse.de ([195.135.220.2]:19856 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932484AbWHJTfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:43 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [27/145] x86_64: Add the vgetcpu vsyscall
Message-Id: <20060810193540.8CCCB13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:40 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Vojtech Pavlik <vojtech@suse.cz>

This patch adds a vgetcpu vsyscall, which depending on the CPU RDTSCP
capability uses either the RDTSCP or CPUID to obtain a CPU and node
numbers and pass them to the program.

AK: Lots of changes over Vojtech's original code:
Better prototype for vgetcpu()
It's better to pass the cpu / node numbers as separate arguments
to avoid mistakes when going from SMP to NUMA.
Also add a fast time stamp based cache using a user supplied
argument to speed things more up.
Use fast method from Chuck Ebbert to retrieve node/cpu from
GDT limit instead of CPUID
Made sure RDTSCP init is always executed after node is known.
Drop printk

TBD benchmark LSL vs RDTSCP

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/head.S        |    2 
 arch/x86_64/kernel/time.c        |   13 +++--
 arch/x86_64/kernel/vmlinux.lds.S |    3 +
 arch/x86_64/kernel/vsyscall.c    |   86 +++++++++++++++++++++++++++++++++++++--
 include/asm-x86_64/segment.h     |    5 +-
 include/asm-x86_64/smp.h         |   12 ++++-
 include/asm-x86_64/vsyscall.h    |    9 ++++
 include/linux/getcpu.h           |   16 +++++++
 8 files changed, 131 insertions(+), 15 deletions(-)

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -26,6 +26,7 @@
 #include <linux/seqlock.h>
 #include <linux/jiffies.h>
 #include <linux/sysctl.h>
+#include <linux/getcpu.h>
 
 #include <asm/vsyscall.h>
 #include <asm/pgtable.h>
@@ -33,11 +34,15 @@
 #include <asm/fixmap.h>
 #include <asm/errno.h>
 #include <asm/io.h>
+#include <asm/segment.h>
+#include <asm/desc.h>
+#include <asm/topology.h>
 
 #define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
 seqlock_t __xtime_lock __section_xtime_lock = SEQLOCK_UNLOCKED;
+int __vgetcpu_mode __section_vgetcpu_mode;
 
 #include <asm/unistd.h>
 
@@ -127,9 +132,46 @@ time_t __vsyscall(1) vtime(time_t *t)
 	return __xtime.tv_sec;
 }
 
-long __vsyscall(2) venosys_0(void)
-{
-	return -ENOSYS;
+/* Fast way to get current CPU and node.
+   This helps to do per node and per CPU caches in user space.
+   The result is not guaranteed without CPU affinity, but usually
+   works out because the scheduler tries to keep a thread on the same
+   CPU.
+
+   tcache must point to a two element sized long array.
+   All arguments can be NULL. */
+long __vsyscall(2)
+vgetcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+{
+	unsigned int dummy, p;
+	unsigned long j = 0;
+
+	/* Fast cache - only recompute value once per jiffies and avoid
+	   relatively costly rdtscp/cpuid otherwise.
+	   This works because the scheduler usually keeps the process
+	   on the same CPU and this syscall doesn't guarantee its
+	   results anyways.
+	   We do this here because otherwise user space would do it on
+	   its own in a likely inferior way (no access to jiffies).
+	   If you don't like it pass NULL. */
+	if (tcache && tcache->t0 == (j = __jiffies)) {
+		p = tcache->t1;
+	} else if (__vgetcpu_mode == VGETCPU_RDTSCP) {
+		/* Load per CPU data from RDTSCP */
+		rdtscp(dummy, dummy, p);
+	} else {
+		/* Load per CPU data from GDT */
+		asm("lsl %1,%0" : "=r" (p) : "r" (__PER_CPU_SEG));
+	}
+	if (tcache) {
+		tcache->t0 = j;
+		tcache->t1 = p;
+	}
+	if (cpu)
+		*cpu = p & 0xfff;
+	if (node)
+		*node = p >> 12;
+	return 0;
 }
 
 long __vsyscall(3) venosys_1(void)
@@ -200,6 +242,43 @@ static ctl_table kernel_root_table2[] = 
 
 #endif
 
+static void __cpuinit write_rdtscp_cb(void *info)
+{
+	write_rdtscp_aux((unsigned long)info);
+}
+
+void __cpuinit vsyscall_set_cpu(int cpu)
+{
+	unsigned long *d;
+	unsigned long node = 0;
+#ifdef CONFIG_NUMA
+	node = cpu_to_node[cpu];
+#endif
+	if (cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
+		void *info = (void *)((node << 12) | cpu);
+		/* Can happen on preemptive kernel */
+		if (get_cpu() == cpu)
+			write_rdtscp_cb(info);
+#ifdef CONFIG_SMP
+		else {
+			/* the notifier is unfortunately not executed on the
+			   target CPU */
+			smp_call_function_single(cpu,write_rdtscp_cb,info,0,1);
+		}
+#endif
+		put_cpu();
+	}
+
+	/* Store cpu number in limit so that it can be loaded quickly
+	   in user space in vgetcpu.
+	   12 bits for the CPU and 8 bits for the node. */
+	d = (unsigned long *)(cpu_gdt(cpu) + GDT_ENTRY_PER_CPU);
+	*d = 0x0f40000000000ULL;
+	*d |= cpu;
+	*d |= (node & 0xf) << 12;
+	*d |= (node >> 4) << 48;
+}
+
 static void __init map_vsyscall(void)
 {
 	extern char __vsyscall_0;
@@ -214,6 +293,7 @@ static int __init vsyscall_init(void)
 			VSYSCALL_ADDR(__NR_vgettimeofday)));
 	BUG_ON((unsigned long) &vtime != VSYSCALL_ADDR(__NR_vtime));
 	BUG_ON((VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE)));
+	BUG_ON((unsigned long) &vgetcpu != VSYSCALL_ADDR(__NR_vgetcpu));
 	map_vsyscall();
 #ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
Index: linux/include/asm-x86_64/vsyscall.h
===================================================================
--- linux.orig/include/asm-x86_64/vsyscall.h
+++ linux/include/asm-x86_64/vsyscall.h
@@ -6,6 +6,7 @@
 enum vsyscall_num {
 	__NR_vgettimeofday,
 	__NR_vtime,
+	__NR_vgetcpu,
 };
 
 #define VSYSCALL_START (-10UL << 20)
@@ -16,6 +17,7 @@ enum vsyscall_num {
 #ifdef __KERNEL__
 
 #define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
+#define __section_vgetcpu_mode __attribute__ ((unused, __section__ (".vgetcpu_mode"), aligned(16)))
 #define __section_wall_jiffies __attribute__ ((unused, __section__ (".wall_jiffies"), aligned(16)))
 #define __section_jiffies __attribute__ ((unused, __section__ (".jiffies"), aligned(16)))
 #define __section_sys_tz __attribute__ ((unused, __section__ (".sys_tz"), aligned(16)))
@@ -27,6 +29,9 @@ enum vsyscall_num {
 #define VXTIME_HPET	2
 #define VXTIME_PMTMR	3
 
+#define VGETCPU_RDTSCP	1
+#define VGETCPU_LSL	2
+
 struct vxtime_data {
 	long hpet_address;	/* HPET base address */
 	int last;
@@ -41,6 +46,7 @@ struct vxtime_data {
 
 /* vsyscall space (readonly) */
 extern struct vxtime_data __vxtime;
+extern int __vgetcpu_mode;
 extern struct timespec __xtime;
 extern volatile unsigned long __jiffies;
 extern unsigned long __wall_jiffies;
@@ -49,6 +55,7 @@ extern seqlock_t __xtime_lock;
 
 /* kernel space (writeable) */
 extern struct vxtime_data vxtime;
+extern int vgetcpu_mode;
 extern unsigned long wall_jiffies;
 extern struct timezone sys_tz;
 extern int sysctl_vsyscall;
@@ -56,6 +63,8 @@ extern seqlock_t xtime_lock;
 
 extern int sysctl_vsyscall;
 
+extern void vsyscall_set_cpu(int cpu);
+
 #define ARCH_HAVE_XTIME_LOCK 1
 
 #endif /* __KERNEL__ */
Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -899,12 +899,8 @@ static int __cpuinit
 time_cpu_notifier(struct notifier_block *nb, unsigned long action, void *hcpu)
 {
 	unsigned cpu = (unsigned long) hcpu;
-	if (action == CPU_ONLINE &&
-		cpu_has(&cpu_data[cpu], X86_FEATURE_RDTSCP)) {
-		unsigned p;
-		p = smp_processor_id() | (cpu_to_node(smp_processor_id())<<12);
-		write_rdtscp_aux(p);
-	}
+	if (action == CPU_ONLINE)
+		vsyscall_set_cpu(cpu);
 	return NOTIFY_DONE;
 }
 
@@ -993,6 +989,11 @@ void time_init_gtod(void)
 	if (unsynchronized_tsc())
 		notsc = 1;
 
+ 	if (cpu_has(&boot_cpu_data, X86_FEATURE_RDTSCP))
+		vgetcpu_mode = VGETCPU_RDTSCP;
+	else
+		vgetcpu_mode = VGETCPU_LSL;
+
 	if (vxtime.hpet_address && notsc) {
 		timetype = hpet_use_timer ? "HPET" : "PIT/HPET";
 		if (hpet_use_timer)
Index: linux/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux/arch/x86_64/kernel/vmlinux.lds.S
@@ -99,6 +99,9 @@ SECTIONS
   .vxtime : AT(VLOAD(.vxtime)) { *(.vxtime) }
   vxtime = VVIRT(.vxtime);
 
+  .vgetcpu_mode : AT(VLOAD(.vgetcpu_mode)) { *(.vgetcpu_mode) }
+  vgetcpu_mode = VVIRT(.vgetcpu_mode);
+
   .wall_jiffies : AT(VLOAD(.wall_jiffies)) { *(.wall_jiffies) }
   wall_jiffies = VVIRT(.wall_jiffies);
 
Index: linux/arch/x86_64/kernel/head.S
===================================================================
--- linux.orig/arch/x86_64/kernel/head.S
+++ linux/arch/x86_64/kernel/head.S
@@ -370,7 +370,7 @@ ENTRY(cpu_gdt_table)
 	.quad	0,0			/* TSS */
 	.quad	0,0			/* LDT */
 	.quad   0,0,0			/* three TLS descriptors */ 
-	.quad	0			/* unused */
+	.quad	0x0000f40000000000	/* node/CPU stored in limit */
 gdt_end:	
 	/* asm/segment.h:GDT_ENTRIES must match this */	
 	/* This should be a multiple of the cache line size */
Index: linux/include/asm-x86_64/segment.h
===================================================================
--- linux.orig/include/asm-x86_64/segment.h
+++ linux/include/asm-x86_64/segment.h
@@ -20,15 +20,16 @@
 #define __USER_CS     0x33   /* 6*8+3 */ 
 #define __USER32_DS	__USER_DS 
 
-#define GDT_ENTRY_TLS 1
 #define GDT_ENTRY_TSS 8	/* needs two entries */
 #define GDT_ENTRY_LDT 10 /* needs two entries */
 #define GDT_ENTRY_TLS_MIN 12
 #define GDT_ENTRY_TLS_MAX 14
-/* 15 free */
 
 #define GDT_ENTRY_TLS_ENTRIES 3
 
+#define GDT_ENTRY_PER_CPU 15	/* Abused to load per CPU data from limit */
+#define __PER_CPU_SEG	(GDT_ENTRY_PER_CPU * 8 + 3)
+
 /* TLS indexes for 64bit - hardcoded in arch_prctl */
 #define FS_TLS 0	
 #define GS_TLS 1	
Index: linux/include/asm-x86_64/smp.h
===================================================================
--- linux.orig/include/asm-x86_64/smp.h
+++ linux/include/asm-x86_64/smp.h
@@ -133,13 +133,19 @@ static __inline int logical_smp_processo
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
 }
-#endif
 
 #ifdef CONFIG_SMP
 #define cpu_physical_id(cpu)		x86_cpu_to_apicid[cpu]
 #else
 #define cpu_physical_id(cpu)		boot_cpu_id
-#endif
-
+static inline int smp_call_function_single(int cpuid, void (*func) (void *info),
+				void *info, int retry, int wait)
+{
+	/* Disable interrupts here? */
+	func(info);
+	return 0;
+}
+#endif /* !CONFIG_SMP */
+#endif /* !__ASSEMBLY */
 #endif
 
Index: linux/include/linux/getcpu.h
===================================================================
--- /dev/null
+++ linux/include/linux/getcpu.h
@@ -0,0 +1,16 @@
+#ifndef _LINUX_GETCPU_H
+#define _LINUX_GETCPU_H 1
+
+/* Cache for getcpu() to speed it up. Results might be upto a jiffie
+   out of date, but will be faster.
+   User programs should not refer to the contents of this structure.
+   It is only a cache for vgetcpu(). It might change in future kernels.
+   The user program must store this information per thread (__thread)
+   If you want 100% accurate information pass NULL instead. */
+struct getcpu_cache {
+	unsigned long t0;
+	unsigned long t1;
+	unsigned long res[4];
+};
+
+#endif
