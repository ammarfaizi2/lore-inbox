Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVEZKsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVEZKsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 06:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVEZKsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 06:48:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28873 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261279AbVEZKrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 06:47:15 -0400
Date: Thu, 26 May 2005 12:44:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>, linux-kernel@vger.kernel.org
Subject: [patch] smp_processor_id() cleanup, 2.6.12-rc5
Message-ID: <20050526104449.GA14289@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch implements a number of smp_processor_id() cleanup ideas that 
Arjan van de Ven and i came up with.

the previous __smp_processor_id/_smp_processor_id/smp_processor_id API 
spaghetti was hard to follow both on the implementational and on the 
usage side.

some of the complexity arose from picking wrong names, some of the 
complexity comes from the fact that not all architectures defined 
__smp_processor_id.

in the new code, there are two externally visible symbols:

 - smp_processor_id(): debug variant.

 - raw_smp_processor_id(): nondebug variant. Replaces all existing
   uses of _smp_processor_id() and __smp_processor_id(). Defined
   by every SMP architecture in include/asm-*/smp.h.

there is one new internal symbol, dependent on DEBUG_PREEMPT:

 - debug_smp_processor_id(): internal debug variant, mapped to
                             smp_processor_id().

also, i moved debug_smp_processor_id() from lib/kernel_lock.c into a new 
lib/smp_processor_id.c file. All related comments got updated and/or 
clarified.

i have build/boot tested the following 8 .config combinations on x86:

 {SMP,UP} x {PREEMPT,!PREEMPT} x {DEBUG_PREEMPT,!DEBUG_PREEMPT}

i have also build/boot tested x64 on UP/PREEMPT/DEBUG_PREEMPT. (Other 
architectures are untested, but should work just fine.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

 38 files changed, 121 insertions(+), 127 deletions(-)

--- linux/fs/xfs/linux-2.6/xfs_linux.h.orig
+++ linux/fs/xfs/linux-2.6/xfs_linux.h
@@ -145,10 +145,10 @@ static inline void set_buffer_unwritten_
 #define xfs_inherit_nosymlinks	xfs_params.inherit_nosym.val
 #define xfs_rotorstep		xfs_params.rotorstep.val
 
-#ifndef __smp_processor_id
-#define __smp_processor_id()	smp_processor_id()
+#ifndef raw_smp_processor_id
+#define raw_smp_processor_id()	smp_processor_id()
 #endif
-#define current_cpu()		__smp_processor_id()
+#define current_cpu()		raw_smp_processor_id()
 #define current_pid()		(current->pid)
 #define current_fsuid(cred)	(current->fsuid)
 #define current_fsgid(cred)	(current->fsgid)
--- linux/kernel/stop_machine.c.orig
+++ linux/kernel/stop_machine.c
@@ -100,7 +100,7 @@ static int stop_machine(void)
 	stopmachine_state = STOPMACHINE_WAIT;
 
 	for_each_online_cpu(i) {
-		if (i == _smp_processor_id())
+		if (i == raw_smp_processor_id())
 			continue;
 		ret = kernel_thread(stopmachine, (void *)(long)i,CLONE_KERNEL);
 		if (ret < 0)
@@ -182,7 +182,7 @@ struct task_struct *__stop_machine_run(i
 
 	/* If they don't care which CPU fn runs on, bind to any online one. */
 	if (cpu == NR_CPUS)
-		cpu = _smp_processor_id();
+		cpu = raw_smp_processor_id();
 
 	p = kthread_create(do_stop, &smdata, "kstopmachine");
 	if (!IS_ERR(p)) {
--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -3811,7 +3811,7 @@ EXPORT_SYMBOL(yield);
  */
 void __sched io_schedule(void)
 {
-	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
+	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
 
 	atomic_inc(&rq->nr_iowait);
 	schedule();
@@ -3822,7 +3822,7 @@ EXPORT_SYMBOL(io_schedule);
 
 long __sched io_schedule_timeout(long timeout)
 {
-	struct runqueue *rq = &per_cpu(runqueues, _smp_processor_id());
+	struct runqueue *rq = &per_cpu(runqueues, raw_smp_processor_id());
 	long ret;
 
 	atomic_inc(&rq->nr_iowait);
--- linux/kernel/module.c.orig
+++ linux/kernel/module.c
@@ -379,7 +379,7 @@ static void module_unload_init(struct mo
 	for (i = 0; i < NR_CPUS; i++)
 		local_set(&mod->ref[i].count, 0);
 	/* Hold reference count during initialization. */
-	local_set(&mod->ref[_smp_processor_id()].count, 1);
+	local_set(&mod->ref[raw_smp_processor_id()].count, 1);
 	/* Backwards compatibility macros put refcount during init. */
 	mod->waiter = current;
 }
--- linux/kernel/power/smp.c.orig
+++ linux/kernel/power/smp.c
@@ -48,11 +48,11 @@ void disable_nonboot_cpus(void)
 {
 	oldmask = current->cpus_allowed;
 	set_cpus_allowed(current, cpumask_of_cpu(0));
-	printk("Freezing CPUs (at %d)", _smp_processor_id());
+	printk("Freezing CPUs (at %d)", raw_smp_processor_id());
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(HZ);
 	printk("...");
-	BUG_ON(_smp_processor_id() != 0);
+	BUG_ON(raw_smp_processor_id() != 0);
 
 	/* FIXME: for this to work, all the CPUs must be running
 	 * "idle" thread (or we deadlock). Is that guaranteed? */
--- linux/arch/ppc/lib/locks.c.orig
+++ linux/arch/ppc/lib/locks.c
@@ -130,7 +130,7 @@ void _raw_read_lock(rwlock_t *rw)
 		while (!read_can_lock(rw)) {
 			if (--stuck == 0) {
 				printk("_read_lock(%p) CPU#%d lock %d\n",
-				       rw, _smp_processor_id(), rw->lock);
+				       rw, raw_smp_processor_id(), rw->lock);
 				stuck = INIT_STUCK;
 			}
 		}
@@ -158,7 +158,7 @@ void _raw_write_lock(rwlock_t *rw)
 		while (!write_can_lock(rw)) {
 			if (--stuck == 0) {
 				printk("write_lock(%p) CPU#%d lock %d)\n",
-				       rw, _smp_processor_id(), rw->lock);
+				       rw, raw_smp_processor_id(), rw->lock);
 				stuck = INIT_STUCK;
 			}
 		}
--- linux/arch/x86_64/lib/delay.c.orig
+++ linux/arch/x86_64/lib/delay.c
@@ -34,7 +34,7 @@ void __delay(unsigned long loops)
 
 inline void __const_udelay(unsigned long xloops)
 {
-	__delay(((xloops * cpu_data[_smp_processor_id()].loops_per_jiffy) >> 32) * HZ);
+	__delay(((xloops * cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32) * HZ);
 }
 
 void __udelay(unsigned long usecs)
--- linux/arch/ppc64/kernel/idle.c.orig
+++ linux/arch/ppc64/kernel/idle.c
@@ -294,7 +294,7 @@ static int native_idle(void)
 		if (need_resched())
 			schedule();
 
-		if (cpu_is_offline(_smp_processor_id()) &&
+		if (cpu_is_offline(raw_smp_processor_id()) &&
 		    system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
--- linux/arch/sparc64/lib/delay.c.orig
+++ linux/arch/sparc64/lib/delay.c
@@ -31,7 +31,7 @@ void __const_udelay(unsigned long n)
 {
 	n *= 4;
 
-	n *= (cpu_data(_smp_processor_id()).udelay_val * (HZ/4));
+	n *= (cpu_data(raw_smp_processor_id()).udelay_val * (HZ/4));
 	n >>= 32;
 
 	__delay(n + 1);
--- linux/arch/i386/kernel/traps.c.orig
+++ linux/arch/i386/kernel/traps.c
@@ -306,7 +306,7 @@ void die(const char * str, struct pt_reg
 	};
 	static int die_counter;
 
-	if (die.lock_owner != _smp_processor_id()) {
+	if (die.lock_owner != raw_smp_processor_id()) {
 		console_verbose();
 		spin_lock_irq(&die.lock);
 		die.lock_owner = smp_processor_id();
--- linux/arch/i386/lib/delay.c.orig
+++ linux/arch/i386/lib/delay.c
@@ -34,7 +34,7 @@ inline void __const_udelay(unsigned long
 	xloops *= 4;
 	__asm__("mull %0"
 		:"=d" (xloops), "=&a" (d0)
-		:"1" (xloops),"0" (cpu_data[_smp_processor_id()].loops_per_jiffy * (HZ/4)));
+		:"1" (xloops),"0" (cpu_data[raw_smp_processor_id()].loops_per_jiffy * (HZ/4)));
         __delay(++xloops);
 }
 
--- linux/arch/sh/lib/delay.c.orig
+++ linux/arch/sh/lib/delay.c
@@ -24,7 +24,7 @@ inline void __const_udelay(unsigned long
 	__asm__("dmulu.l	%0, %2\n\t"
 		"sts	mach, %0"
 		: "=r" (xloops)
-		: "0" (xloops), "r" (cpu_data[_smp_processor_id()].loops_per_jiffy)
+		: "0" (xloops), "r" (cpu_data[raw_smp_processor_id()].loops_per_jiffy)
 		: "macl", "mach");
 	__delay(xloops * HZ);
 }
--- linux/drivers/input/gameport/gameport.c.orig
+++ linux/drivers/input/gameport/gameport.c
@@ -134,7 +134,7 @@ static int gameport_measure_speed(struct
 	}
 
 	gameport_close(gameport);
-	return (cpu_data[_smp_processor_id()].loops_per_jiffy * (unsigned long)HZ / (1000 / 50)) / (tx < 1 ? 1 : tx);
+	return (cpu_data[raw_smp_processor_id()].loops_per_jiffy * (unsigned long)HZ / (1000 / 50)) / (tx < 1 ? 1 : tx);
 
 #else
 
--- linux/drivers/oprofile/buffer_sync.c.orig
+++ linux/drivers/oprofile/buffer_sync.c
@@ -62,7 +62,7 @@ static int task_exit_notify(struct notif
 	/* To avoid latency problems, we only process the current CPU,
 	 * hoping that most samples for the task are on this CPU
 	 */
-	sync_buffer(_smp_processor_id());
+	sync_buffer(raw_smp_processor_id());
   	return 0;
 }
 
@@ -86,7 +86,7 @@ static int munmap_notify(struct notifier
 		/* To avoid latency problems, we only process the current CPU,
 		 * hoping that most samples for the task are on this CPU
 		 */
-		sync_buffer(_smp_processor_id());
+		sync_buffer(raw_smp_processor_id());
 		return 0;
 	}
 
--- linux/drivers/scsi/qla2xxx/qla_isr.c.orig
+++ linux/drivers/scsi/qla2xxx/qla_isr.c
@@ -91,7 +91,7 @@ qla2100_intr_handler(int irq, void *dev_
 	}
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
-	ha->last_irq_cpu = _smp_processor_id();
+	ha->last_irq_cpu = raw_smp_processor_id();
 	ha->total_isr_cnt++;
 
 	if (test_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags) &&
@@ -200,7 +200,7 @@ qla2300_intr_handler(int irq, void *dev_
 	}
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
-	ha->last_irq_cpu = _smp_processor_id();
+	ha->last_irq_cpu = raw_smp_processor_id();
 	ha->total_isr_cnt++;
 
 	if (test_bit(MBX_INTR_WAIT, &ha->mbx_cmd_flags) &&
--- linux/drivers/acpi/processor_idle.c.orig
+++ linux/drivers/acpi/processor_idle.c
@@ -171,7 +171,7 @@ static void acpi_processor_idle (void)
 	int			sleep_ticks = 0;
 	u32			t1, t2 = 0;
 
-	pr = processors[_smp_processor_id()];
+	pr = processors[raw_smp_processor_id()];
 	if (!pr)
 		return;
 
--- linux/include/net/snmp.h.orig
+++ linux/include/net/snmp.h
@@ -128,18 +128,18 @@ struct linux_mib {
 #define SNMP_STAT_USRPTR(name)	(name[1])
 
 #define SNMP_INC_STATS_BH(mib, field) 	\
-	(per_cpu_ptr(mib[0], _smp_processor_id())->mibs[field]++)
+	(per_cpu_ptr(mib[0], raw_smp_processor_id())->mibs[field]++)
 #define SNMP_INC_STATS_OFFSET_BH(mib, field, offset)	\
-	(per_cpu_ptr(mib[0], _smp_processor_id())->mibs[field + (offset)]++)
+	(per_cpu_ptr(mib[0], raw_smp_processor_id())->mibs[field + (offset)]++)
 #define SNMP_INC_STATS_USER(mib, field) \
-	(per_cpu_ptr(mib[1], _smp_processor_id())->mibs[field]++)
+	(per_cpu_ptr(mib[1], raw_smp_processor_id())->mibs[field]++)
 #define SNMP_INC_STATS(mib, field) 	\
-	(per_cpu_ptr(mib[!in_softirq()], _smp_processor_id())->mibs[field]++)
+	(per_cpu_ptr(mib[!in_softirq()], raw_smp_processor_id())->mibs[field]++)
 #define SNMP_DEC_STATS(mib, field) 	\
-	(per_cpu_ptr(mib[!in_softirq()], _smp_processor_id())->mibs[field]--)
+	(per_cpu_ptr(mib[!in_softirq()], raw_smp_processor_id())->mibs[field]--)
 #define SNMP_ADD_STATS_BH(mib, field, addend) 	\
-	(per_cpu_ptr(mib[0], _smp_processor_id())->mibs[field] += addend)
+	(per_cpu_ptr(mib[0], raw_smp_processor_id())->mibs[field] += addend)
 #define SNMP_ADD_STATS_USER(mib, field, addend) 	\
-	(per_cpu_ptr(mib[1], _smp_processor_id())->mibs[field] += addend)
+	(per_cpu_ptr(mib[1], raw_smp_processor_id())->mibs[field] += addend)
 
 #endif
--- linux/include/net/route.h.orig
+++ linux/include/net/route.h
@@ -107,7 +107,7 @@ struct rt_cache_stat 
 
 extern struct rt_cache_stat *rt_cache_stat;
 #define RT_CACHE_STAT_INC(field)					  \
-		(per_cpu_ptr(rt_cache_stat, _smp_processor_id())->field++)
+		(per_cpu_ptr(rt_cache_stat, raw_smp_processor_id())->field++)
 
 extern struct ip_rt_acct *ip_rt_acct;
 
--- linux/include/asm-ia64/smp.h.orig
+++ linux/include/asm-ia64/smp.h
@@ -46,7 +46,7 @@ ia64_get_lid (void)
 #define SMP_IRQ_REDIRECTION	(1 << 0)
 #define SMP_IPI_REDIRECTION	(1 << 1)
 
-#define smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id() (current_thread_info()->cpu)
 
 extern struct smp_boot_data {
 	int cpu_count;
--- linux/include/asm-sparc/smp.h.orig
+++ linux/include/asm-sparc/smp.h
@@ -148,7 +148,7 @@ extern __inline__ int hard_smp_processor
 }
 #endif
 
-#define smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id()		(current_thread_info()->cpu)
 
 #define prof_multiplier(__cpu)		cpu_data(__cpu).multiplier
 #define prof_counter(__cpu)		cpu_data(__cpu).counter
--- linux/include/asm-arm/smp.h.orig
+++ linux/include/asm-arm/smp.h
@@ -21,7 +21,7 @@
 # error "<asm-arm/smp.h> included in non-SMP build"
 #endif
 
-#define smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id() (current_thread_info()->cpu)
 
 extern cpumask_t cpu_present_mask;
 #define cpu_possible_map cpu_present_mask
--- linux/include/asm-parisc/smp.h.orig
+++ linux/include/asm-parisc/smp.h
@@ -51,7 +51,7 @@ extern void smp_send_reschedule(int cpu)
 
 extern unsigned long cpu_present_mask;
 
-#define smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 #endif /* CONFIG_SMP */
 
--- linux/include/asm-sh/smp.h.orig
+++ linux/include/asm-sh/smp.h
@@ -25,7 +25,7 @@ extern cpumask_t cpu_possible_map;
 
 #define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
 
-#define smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 /* I've no idea what the real meaning of this is */
 #define PROC_CHANGE_PENALTY	20
--- linux/include/asm-s390/smp.h.orig
+++ linux/include/asm-s390/smp.h
@@ -47,7 +47,7 @@ extern int smp_call_function_on(void (*f
  
 #define PROC_CHANGE_PENALTY	20		/* Schedule penalty */
 
-#define smp_processor_id() (S390_lowcore.cpu_data.cpu_nr)
+#define raw_smp_processor_id()	(S390_lowcore.cpu_data.cpu_nr)
 
 extern int smp_get_cpu(cpumask_t cpu_map);
 extern void smp_put_cpu(int cpu);
--- linux/include/asm-m32r/smp.h.orig
+++ linux/include/asm-m32r/smp.h
@@ -66,7 +66,7 @@ extern volatile int cpu_2_physid[NR_CPUS
 #define physid_to_cpu(physid)	physid_2_cpu[physid]
 #define cpu_to_physid(cpu_id)	cpu_2_physid[cpu_id]
 
-#define smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
 #define cpu_possible_map cpu_callout_map
--- linux/include/asm-alpha/smp.h.orig
+++ linux/include/asm-alpha/smp.h
@@ -43,7 +43,7 @@ extern struct cpuinfo_alpha cpu_data[NR_
 #define PROC_CHANGE_PENALTY     20
 
 #define hard_smp_processor_id()	__hard_smp_processor_id()
-#define smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 extern cpumask_t cpu_present_mask;
 extern cpumask_t cpu_online_map;
--- linux/include/asm-ppc/smp.h.orig
+++ linux/include/asm-ppc/smp.h
@@ -44,7 +44,7 @@ extern void smp_message_recv(int, struct
 #define NO_PROC_ID		0xFF            /* No processor magic marker */
 #define PROC_CHANGE_PENALTY	20
 
-#define smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 extern int __cpu_up(unsigned int cpu);
 
--- linux/include/linux/mmzone.h.orig
+++ linux/include/linux/mmzone.h
@@ -381,7 +381,7 @@ int lowmem_reserve_ratio_sysctl_handler(
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
-#define numa_node_id()		(cpu_to_node(_smp_processor_id()))
+#define numa_node_id()		(cpu_to_node(raw_smp_processor_id()))
 
 #ifndef CONFIG_DISCONTIGMEM
 
--- linux/include/linux/smp.h.orig
+++ linux/include/linux/smp.h
@@ -92,10 +92,7 @@ void smp_prepare_boot_cpu(void);
 /*
  *	These macros fold the SMP functionality into a single CPU system
  */
-
-#if !defined(__smp_processor_id) || !defined(CONFIG_PREEMPT)
-# define smp_processor_id()			0
-#endif
+#define raw_smp_processor_id()			0
 #define hard_smp_processor_id()			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
@@ -106,30 +103,25 @@ static inline void smp_send_reschedule(i
 #endif /* !SMP */
 
 /*
- * DEBUG_PREEMPT support: check whether smp_processor_id() is being
- * used in a preemption-safe way.
+ * smp_processor_id(): get the current CPU ID.
  *
- * An architecture has to enable this debugging code explicitly.
- * It can do so by renaming the smp_processor_id() macro to
- * __smp_processor_id().  This should only be done after some minimal
- * testing, because usually there are a number of false positives
- * that an architecture will trigger.
+ * if DEBUG_PREEMPT is enabled the we check whether it is
+ * used in a preemption-safe way. (smp_processor_id() is safe
+ * if it's used in a preemption-off critical section, or in
+ * a thread that is bound to the current CPU.)
  *
- * To fix a false positive (i.e. smp_processor_id() use that the
- * debugging code reports but which use for some reason is legal),
- * change the smp_processor_id() reference to _smp_processor_id(),
- * which is the nondebug variant.  NOTE: don't use this to hack around
- * real bugs.
+ * NOTE: raw_smp_processor_id() is for internal use only
+ * (smp_processor_id() is the preferred variant), but in rare
+ * instances it might also be used to turn off false positives
+ * (i.e. smp_processor_id() use that the debugging code reports but
+ * which use for some reason is legal). Don't use this to hack around
+ * the warning message, as your code might not work under PREEMPT.
  */
-#ifdef __smp_processor_id
-# if defined(CONFIG_PREEMPT) && defined(CONFIG_DEBUG_PREEMPT)
-   extern unsigned int smp_processor_id(void);
-# else
-#  define smp_processor_id() __smp_processor_id()
-# endif
-# define _smp_processor_id() __smp_processor_id()
+#ifdef CONFIG_DEBUG_PREEMPT
+  extern unsigned int debug_smp_processor_id(void);
+# define smp_processor_id() debug_smp_processor_id()
 #else
-# define _smp_processor_id() smp_processor_id()
+# define smp_processor_id() raw_smp_processor_id()
 #endif
 
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
--- linux/include/asm-i386/smp.h.orig
+++ linux/include/asm-i386/smp.h
@@ -51,7 +51,7 @@ extern u8 x86_cpu_to_apicid[];
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define __smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() (current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;
--- linux/include/asm-um/smp.h.orig
+++ linux/include/asm-um/smp.h
@@ -8,7 +8,8 @@
 #include "asm/current.h"
 #include "linux/cpumask.h"
 
-#define smp_processor_id() (current_thread->cpu)
+#define raw_smp_processor_id() (current_thread->cpu)
+
 #define cpu_logical_map(n) (n)
 #define cpu_number_map(n) (n)
 #define PROC_CHANGE_PENALTY	15 /* Pick a number, any number */
--- linux/include/asm-ppc64/smp.h.orig
+++ linux/include/asm-ppc64/smp.h
@@ -45,7 +45,7 @@ void generic_cpu_die(unsigned int cpu);
 void generic_mach_cpu_die(void);
 #endif
 
-#define __smp_processor_id() (get_paca()->paca_index)
+#define raw_smp_processor_id()	(get_paca()->paca_index)
 #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
 
 extern cpumask_t cpu_sibling_map[NR_CPUS];
--- linux/include/asm-sparc64/smp.h.orig
+++ linux/include/asm-sparc64/smp.h
@@ -64,7 +64,7 @@ static __inline__ int hard_smp_processor
 	}
 }
 
-#define smp_processor_id() (current_thread_info()->cpu)
+#define raw_smp_processor_id() (current_thread_info()->cpu)
 
 #endif /* !(__ASSEMBLY__) */
 
--- linux/include/asm-x86_64/smp.h.orig
+++ linux/include/asm-x86_64/smp.h
@@ -68,7 +68,7 @@ static inline int num_booting_cpus(void)
 	return cpus_weight(cpu_callout_map);
 }
 
-#define __smp_processor_id() read_pda(cpunumber)
+#define raw_smp_processor_id() read_pda(cpunumber)
 
 extern __inline int hard_smp_processor_id(void)
 {
--- linux/include/asm-mips/smp.h.orig
+++ linux/include/asm-mips/smp.h
@@ -21,7 +21,7 @@
 #include <linux/cpumask.h>
 #include <asm/atomic.h>
 
-#define smp_processor_id()	(current_thread_info()->cpu)
+#define raw_smp_processor_id() (current_thread_info()->cpu)
 
 /* Map from cpu id to sequential logical cpu number.  This will only
    not be idempotent when cpus failed to come on-line.  */
--- linux/lib/smp_processor_id.c.orig
+++ linux/lib/smp_processor_id.c
@@ -0,0 +1,55 @@
+/*
+ * lib/kernel_lock.c
+ *
+ * DEBUG_PREEMPT variant of smp_processor_id.
+ */
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+
+unsigned int debug_smp_processor_id(void)
+{
+	unsigned long preempt_count = preempt_count();
+	int this_cpu = raw_smp_processor_id();
+	cpumask_t this_mask;
+
+	if (likely(preempt_count))
+		goto out;
+
+	if (irqs_disabled())
+		goto out;
+
+	/*
+	 * Kernel threads bound to a single CPU can safely use
+	 * smp_processor_id():
+	 */
+	this_mask = cpumask_of_cpu(this_cpu);
+
+	if (cpus_equal(current->cpus_allowed, this_mask))
+		goto out;
+
+	/*
+	 * It is valid to assume CPU-locality during early bootup:
+	 */
+	if (system_state != SYSTEM_RUNNING)
+		goto out;
+
+	/*
+	 * Avoid recursion:
+	 */
+	preempt_disable();
+
+	if (!printk_ratelimit())
+		goto out_enable;
+
+	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count(), current->comm, current->pid);
+	print_symbol("caller is %s\n", (long)__builtin_return_address(0));
+	dump_stack();
+
+out_enable:
+	preempt_enable_no_resched();
+out:
+	return this_cpu;
+}
+
+EXPORT_SYMBOL(debug_smp_processor_id);
+
--- linux/lib/kernel_lock.c.orig
+++ linux/lib/kernel_lock.c
@@ -9,61 +9,6 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 
-#if defined(CONFIG_PREEMPT) && defined(__smp_processor_id) && \
-		defined(CONFIG_DEBUG_PREEMPT)
-
-/*
- * Debugging check.
- */
-unsigned int smp_processor_id(void)
-{
-	unsigned long preempt_count = preempt_count();
-	int this_cpu = __smp_processor_id();
-	cpumask_t this_mask;
-
-	if (likely(preempt_count))
-		goto out;
-
-	if (irqs_disabled())
-		goto out;
-
-	/*
-	 * Kernel threads bound to a single CPU can safely use
-	 * smp_processor_id():
-	 */
-	this_mask = cpumask_of_cpu(this_cpu);
-
-	if (cpus_equal(current->cpus_allowed, this_mask))
-		goto out;
-
-	/*
-	 * It is valid to assume CPU-locality during early bootup:
-	 */
-	if (system_state != SYSTEM_RUNNING)
-		goto out;
-
-	/*
-	 * Avoid recursion:
-	 */
-	preempt_disable();
-
-	if (!printk_ratelimit())
-		goto out_enable;
-
-	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count(), current->comm, current->pid);
-	print_symbol("caller is %s\n", (long)__builtin_return_address(0));
-	dump_stack();
-
-out_enable:
-	preempt_enable_no_resched();
-out:
-	return this_cpu;
-}
-
-EXPORT_SYMBOL(smp_processor_id);
-
-#endif /* PREEMPT && __smp_processor_id && DEBUG_PREEMPT */
-
 #ifdef CONFIG_PREEMPT_BKL
 /*
  * The 'big kernel semaphore'
--- linux/lib/Makefile.orig
+++ linux/lib/Makefile
@@ -19,6 +19,7 @@ lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += 
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
+obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   lib-y += dec_and_lock.o
