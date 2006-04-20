Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWDTNF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWDTNF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWDTNF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:05:59 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:34541 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750702AbWDTNF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:05:58 -0400
Date: Thu, 20 Apr 2006 15:05:45 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Simon Derr <Simon.Derr@bull.net>
Subject: [PATCH] 2.6.16-rt17 on IA64
Message-ID: <Pine.LNX.4.61.0604201446470.15050@openx3.frec.bull.fr>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/04/2006 15:08:28,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 20/04/2006 15:08:30,
	Serialize complete at 20/04/2006 15:08:30
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is a first version of my port of Ingo's -rt kernel to the IA64 arch.

So far the kernel boots with PREEMPT_RT enabled (on a 4-cpu tiger), and 
that's about it. I've not done extensive tests (only scripts/rt-tester), 
nor any measurements of any kind.

There's very probably many bugs I'm not aware of.

But there is already one thing I know should be fixed : I've changed the 
declaration of (struct zone).lock (in include/linux/mmzone.h) from 
spinlock_t to raw_spinlock_t. 

I did this because on IA64, cpu_idle(), which is not allowed to call 
schedule(), calls check_pgt_cache(). I guess this could be fixed by moving 
this call to another kernel thread... ideas are welcome.


	Simon.




Signed-off-by: Simon.Derr@bull.net

Index: rt17/arch/ia64/Kconfig
===================================================================
--- rt17.orig/arch/ia64/Kconfig	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/Kconfig	2006-04-20 11:29:42.000000000 +0200
@@ -32,6 +32,7 @@ config SWIOTLB
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
+	depends on !PREEMPT_RT
 	default y
 
 config GENERIC_CALIBRATE_DELAY
@@ -271,17 +272,15 @@ config SCHED_SMT
 	  Intel IA64 chips with MultiThreading at a cost of slightly increased
 	  overhead in some places. If unsure say N here.
 
-config PREEMPT
-	bool "Preemptible Kernel"
-        help
-          This option reduces the latency of the kernel when reacting to
-          real-time or interactive events by allowing a low priority process to
-          be preempted even if it is in kernel mode executing a system call.
-          This allows applications to run more reliably even when the system is
-          under load.
+source "kernel/Kconfig.preempt"
 
-          Say Y here if you are building a kernel for a desktop, embedded
-          or real-time system.  Say N if you are unsure.
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	depends on PREEMPT_RT
+	default y
+
+config PREEMPT
+	def_bool y if (PREEMPT_RT || PREEMPT_SOFTIRQS || PREEMPT_HARDIRQS || PREEMPT_VOLUNTARY || PREEMPT_DESKTOP)
 
 source "mm/Kconfig"
 
Index: rt17/arch/ia64/kernel/entry.S
===================================================================
--- rt17.orig/arch/ia64/kernel/entry.S	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/entry.S	2006-04-20 11:29:42.000000000 +0200
@@ -1105,23 +1105,25 @@ skip_rbs_switch:
 	tbit.nz p6,p0=r31,TIF_SIGDELAYED		// signal delayed from  MCA/INIT/NMI/PMI context?
 (p6)	br.cond.sptk.few .sigdelayed
 	;;
-	tbit.z p6,p0=r31,TIF_NEED_RESCHED		// current_thread_info()->need_resched==0?
+	tbit.nz p6,p0=r31,TIF_NEED_RESCHED		// current_thread_info()->need_resched==0?
+(p6)	br.cond.sptk.few .needresched
+	;;
+	tbit.z p6,p0=r31,TIF_NEED_RESCHED_DELAYED	// current_thread_info()->need_resched_delayed==0?
 (p6)	br.cond.sptk.few .notify
-#ifdef CONFIG_PREEMPT
-(pKStk) dep r21=-1,r0,PREEMPT_ACTIVE_BIT,1
+.needresched:
+
+(pKStk) br.cond.sptk.many .fromkernel
 	;;
-(pKStk) st4 [r20]=r21
 	ssm psr.i		// enable interrupts
-#endif
 	br.call.spnt.many rp=schedule
-.ret9:	cmp.eq p6,p0=r0,r0				// p6 <- 1
-	rsm psr.i		// disable interrupts
-	;;
-#ifdef CONFIG_PREEMPT
-(pKStk)	adds r20=TI_PRE_COUNT+IA64_TASK_SIZE,r13
+.ret9a:	rsm psr.i		// disable interrupts
 	;;
-(pKStk)	st4 [r20]=r0		// preempt_count() <- 0
-#endif
+	br.cond.sptk.many .endpreemptdep
+.fromkernel:
+	br.call.spnt.many rp=preempt_schedule_irq
+.ret9b:	rsm psr.i		// disable interrupts
+.endpreemptdep:
+	cmp.eq p6,p0=r0,r0				// p6 <- 1
 (pLvSys)br.cond.sptk.few  .work_pending_syscall_end
 	br.cond.sptk.many .work_processed_kernel	// re-check
 
@@ -1138,7 +1140,7 @@ skip_rbs_switch:
 
 .sigdelayed:
 	br.call.sptk.many rp=do_sigdelayed
-	cmp.eq p6,p0=r0,r0				// p6 <- 1, always re-check
+.ret10b: cmp.eq p6,p0=r0,r0				// p6 <- 1, always re-check
 (pLvSys)br.cond.sptk.few  .work_pending_syscall_end
 	br.cond.sptk.many .work_processed_kernel	// re-check
 
Index: rt17/arch/ia64/kernel/iosapic.c
===================================================================
--- rt17.orig/arch/ia64/kernel/iosapic.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/iosapic.c	2006-04-20 11:29:42.000000000 +0200
@@ -102,7 +102,7 @@
 #define NR_PREALLOCATE_RTE_ENTRIES	(PAGE_SIZE / sizeof(struct iosapic_rte_info))
 #define RTE_PREALLOCATED	(1)
 
-static DEFINE_SPINLOCK(iosapic_lock);
+static DEFINE_RAW_SPINLOCK(iosapic_lock);
 
 /* These tables map IA-64 vectors to the IOSAPIC pin that generates this vector. */
 
@@ -379,6 +379,34 @@ iosapic_startup_level_irq (unsigned int 
 	return 0;
 }
 
+/*
+ * In the preemptible case mask the IRQ first then handle it and ack it.
+ */
+#ifdef CONFIG_PREEMPT_HARDIRQS
+
+static void
+iosapic_ack_level_irq (unsigned int irq)
+{
+	ia64_vector vec = irq_to_vector(irq);
+	struct iosapic_rte_info *rte;
+
+	move_irq(irq);
+	mask_irq(irq);
+	list_for_each_entry(rte, &iosapic_intr_info[vec].rtes, rte_list)
+		iosapic_eoi(rte->addr, vec);
+}
+
+static void
+iosapic_end_level_irq (unsigned int irq)
+{
+	if (!(irq_desc[irq].status & IRQ_INPROGRESS))
+		unmask_irq(irq);
+}
+
+#else /* !CONFIG_PREEMPT_HARDIRQS */
+
+#define iosapic_ack_level_irq		nop
+
 static void
 iosapic_end_level_irq (unsigned int irq)
 {
@@ -390,10 +418,12 @@ iosapic_end_level_irq (unsigned int irq)
 		iosapic_eoi(rte->addr, vec);
 }
 
+
+#endif 
+
 #define iosapic_shutdown_level_irq	mask_irq
 #define iosapic_enable_level_irq	unmask_irq
 #define iosapic_disable_level_irq	mask_irq
-#define iosapic_ack_level_irq		nop
 
 struct hw_interrupt_type irq_type_iosapic_level = {
 	.typename =	"IO-SAPIC-level",
Index: rt17/arch/ia64/kernel/mca.c
===================================================================
--- rt17.orig/arch/ia64/kernel/mca.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/mca.c	2006-04-20 11:29:42.000000000 +0200
@@ -151,7 +151,7 @@ ia64_mca_spin(const char *func)
 
 typedef struct ia64_state_log_s
 {
-	spinlock_t	isl_lock;
+	raw_spinlock_t	isl_lock;
 	int		isl_index;
 	unsigned long	isl_count;
 	ia64_err_rec_t  *isl_log[IA64_MAX_LOGS]; /* need space to store header + error log */
Index: rt17/arch/ia64/kernel/perfmon.c
===================================================================
--- rt17.orig/arch/ia64/kernel/perfmon.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/perfmon.c	2006-04-20 11:29:42.000000000 +0200
@@ -278,7 +278,7 @@ typedef struct {
  */
 
 typedef struct pfm_context {
-	spinlock_t		ctx_lock;		/* context protection */
+	raw_spinlock_t		ctx_lock;		/* context protection */
 
 	pfm_context_flags_t	ctx_flags;		/* bitmask of flags  (block reason incl.) */
 	unsigned int		ctx_state;		/* state: active/inactive (no bitfield) */
@@ -364,7 +364,7 @@ typedef struct pfm_context {
  * mostly used to synchronize between system wide and per-process
  */
 typedef struct {
-	spinlock_t		pfs_lock;		   /* lock the structure */
+	raw_spinlock_t		pfs_lock;		   /* lock the structure */
 
 	unsigned int		pfs_task_sessions;	   /* number of per task sessions */
 	unsigned int		pfs_sys_sessions;	   /* number of per system wide sessions */
@@ -505,7 +505,7 @@ static pfm_intr_handler_desc_t  *pfm_alt
 static struct proc_dir_entry 	*perfmon_dir;
 static pfm_uuid_t		pfm_null_uuid = {0,};
 
-static spinlock_t		pfm_buffer_fmt_lock;
+static raw_spinlock_t		pfm_buffer_fmt_lock;
 static LIST_HEAD(pfm_buffer_fmt_list);
 
 static pmu_config_t		*pmu_conf;
Index: rt17/arch/ia64/kernel/process.c
===================================================================
--- rt17.orig/arch/ia64/kernel/process.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/process.c	2006-04-20 11:29:42.000000000 +0200
@@ -98,6 +98,9 @@ show_stack (struct task_struct *task, un
 void
 dump_stack (void)
 {
+	if (irqs_disabled()) {
+		printk("Uh oh.. entering dump_stack() with irqs disabled.\n");
+	}
 	show_stack(NULL, NULL);
 }
 
@@ -201,7 +204,7 @@ void
 default_idle (void)
 {
 	local_irq_enable();
-	while (!need_resched()) {
+	while (!need_resched() && !need_resched_delayed()) {
 		if (can_do_pal_halt)
 			safe_halt();
 		else
@@ -277,7 +280,7 @@ cpu_idle (void)
 		else
 			set_thread_flag(TIF_POLLING_NRFLAG);
 
-		if (!need_resched()) {
+		if (!need_resched() && !need_resched_delayed()) {
 			void (*idle)(void);
 #ifdef CONFIG_SMP
 			min_xtp();
@@ -299,10 +302,12 @@ cpu_idle (void)
 			normal_xtp();
 #endif
 		}
-		preempt_enable_no_resched();
-		schedule();
+		__preempt_enable_no_resched();
+		__schedule();
+		
 		preempt_disable();
 		check_pgt_cache();
+
 		if (cpu_is_offline(cpu))
 			play_dead();
 	}
Index: rt17/arch/ia64/kernel/sal.c
===================================================================
--- rt17.orig/arch/ia64/kernel/sal.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/sal.c	2006-04-20 11:29:42.000000000 +0200
@@ -19,7 +19,7 @@
 #include <asm/sal.h>
 #include <asm/pal.h>
 
- __cacheline_aligned DEFINE_SPINLOCK(sal_lock);
+ __cacheline_aligned DEFINE_RAW_SPINLOCK(sal_lock);
 unsigned long sal_platform_features;
 
 unsigned short sal_revision;
Index: rt17/arch/ia64/kernel/salinfo.c
===================================================================
--- rt17.orig/arch/ia64/kernel/salinfo.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/salinfo.c	2006-04-20 11:29:42.000000000 +0200
@@ -141,7 +141,7 @@ enum salinfo_state {
 
 struct salinfo_data {
 	cpumask_t		cpu_event;	/* which cpus have outstanding events */
-	struct semaphore	mutex;
+	struct compat_semaphore	mutex;
 	u8			*log_buffer;
 	u64			log_size;
 	u8			*oemdata;	/* decoded oem data */
@@ -157,8 +157,8 @@ struct salinfo_data {
 
 static struct salinfo_data salinfo_data[ARRAY_SIZE(salinfo_log_name)];
 
-static DEFINE_SPINLOCK(data_lock);
-static DEFINE_SPINLOCK(data_saved_lock);
+static DEFINE_RAW_SPINLOCK(data_lock);
+static DEFINE_RAW_SPINLOCK(data_saved_lock);
 
 /** salinfo_platform_oemdata - optional callback to decode oemdata from an error
  * record.
Index: rt17/arch/ia64/kernel/semaphore.c
===================================================================
--- rt17.orig/arch/ia64/kernel/semaphore.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/semaphore.c	2006-04-20 11:29:42.000000000 +0200
@@ -40,12 +40,12 @@
  */
 
 void
-__up (struct semaphore *sem)
+__up (struct compat_semaphore *sem)
 {
 	wake_up(&sem->wait);
 }
 
-void __sched __down (struct semaphore *sem)
+void __sched __down (struct compat_semaphore *sem)
 {
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
@@ -82,7 +82,7 @@ void __sched __down (struct semaphore *s
 	tsk->state = TASK_RUNNING;
 }
 
-int __sched __down_interruptible (struct semaphore * sem)
+int __sched __down_interruptible (struct compat_semaphore * sem)
 {
 	int retval = 0;
 	struct task_struct *tsk = current;
@@ -142,7 +142,7 @@ int __sched __down_interruptible (struct
  * count.
  */
 int
-__down_trylock (struct semaphore *sem)
+__down_trylock (struct compat_semaphore *sem)
 {
 	unsigned long flags;
 	int sleepers;
Index: rt17/arch/ia64/kernel/signal.c
===================================================================
--- rt17.orig/arch/ia64/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/signal.c	2006-04-20 11:29:42.000000000 +0200
@@ -488,6 +488,14 @@ ia64_do_signal (sigset_t *oldset, struct
 	long errno = scr->pt.r8;
 #	define ERR_CODE(c)	(IS_IA32_PROCESS(&scr->pt) ? -(c) : (c))
 
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Fully-preemptible kernel does not need interrupts disabled:
+	 */
+	local_irq_enable();
+	preempt_check_resched();
+#endif
+
 	/*
 	 * In the ia64_leave_kernel code path, we want the common case to go fast, which
 	 * is why we may in certain cases get here from kernel mode. Just return without
Index: rt17/arch/ia64/kernel/smp.c
===================================================================
--- rt17.orig/arch/ia64/kernel/smp.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/smp.c	2006-04-20 11:29:42.000000000 +0200
@@ -222,6 +222,22 @@ smp_send_reschedule (int cpu)
 	platform_send_ipi(cpu, IA64_IPI_RESCHEDULE, IA64_IPI_DM_INT, 0);
 }
 
+/*
+ * this function sends a 'reschedule' IPI to all other CPUs.
+ * This is used when RT tasks are starving and other CPUs
+ * might be able to run them:
+ */
+void smp_send_reschedule_allbutself(void)
+{
+	unsigned int cpu;
+
+	for_each_online_cpu(cpu) {
+		if (cpu != smp_processor_id())
+			platform_send_ipi(cpu, IA64_IPI_RESCHEDULE, IA64_IPI_DM_INT, 0);
+	}
+}
+
+
 void
 smp_flush_tlb_all (void)
 {
Index: rt17/arch/ia64/kernel/traps.c
===================================================================
--- rt17.orig/arch/ia64/kernel/traps.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/traps.c	2006-04-20 11:29:42.000000000 +0200
@@ -25,7 +25,7 @@
 #include <asm/uaccess.h>
 #include <asm/kdebug.h>
 
-extern spinlock_t timerlist_lock;
+extern raw_spinlock_t timerlist_lock;
 
 fpswa_interface_t *fpswa_interface;
 EXPORT_SYMBOL(fpswa_interface);
@@ -86,11 +86,11 @@ void
 die (const char *str, struct pt_regs *regs, long err)
 {
 	static struct {
-		spinlock_t lock;
+		raw_spinlock_t lock;
 		u32 lock_owner;
 		int lock_owner_depth;
 	} die = {
-		.lock =			SPIN_LOCK_UNLOCKED,
+		.lock =			RAW_SPIN_LOCK_UNLOCKED,
 		.lock_owner =		-1,
 		.lock_owner_depth =	0
 	};
@@ -230,7 +230,7 @@ __kprobes ia64_bad_break (unsigned long 
  * access to fph by the time we get here, as the IVT's "Disabled FP-Register" handler takes
  * care of clearing psr.dfh.
  */
-static inline void
+void
 disabled_fph_fault (struct pt_regs *regs)
 {
 	struct ia64_psr *psr = ia64_psr(regs);
@@ -249,7 +249,7 @@ disabled_fph_fault (struct pt_regs *regs
 			= (struct task_struct *)ia64_get_kr(IA64_KR_FPU_OWNER);
 
 		if (ia64_is_local_fpu_owner(current)) {
-			preempt_enable_no_resched();
+			__preempt_enable_no_resched();
 			return;
 		}
 
@@ -269,7 +269,7 @@ disabled_fph_fault (struct pt_regs *regs
 		 */
 		psr->mfh = 1;
 	}
-	preempt_enable_no_resched();
+	__preempt_enable_no_resched();
 }
 
 static inline int
Index: rt17/arch/ia64/kernel/unwind.c
===================================================================
--- rt17.orig/arch/ia64/kernel/unwind.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/kernel/unwind.c	2006-04-20 11:29:42.000000000 +0200
@@ -81,7 +81,7 @@ typedef unsigned long unw_word;
 typedef unsigned char unw_hash_index_t;
 
 static struct {
-	spinlock_t lock;			/* spinlock for unwind data */
+	raw_spinlock_t lock;			/* spinlock for unwind data */
 
 	/* list of unwind tables (one per load-module) */
 	struct unw_table *tables;
@@ -145,7 +145,7 @@ static struct {
 # endif
 } unw = {
 	.tables = &unw.kernel_table,
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = RAW_SPIN_LOCK_UNLOCKED,
 	.save_order = {
 		UNW_REG_RP, UNW_REG_PFS, UNW_REG_PSP, UNW_REG_PR,
 		UNW_REG_UNAT, UNW_REG_LC, UNW_REG_FPSR, UNW_REG_PRI_UNAT_GR
Index: rt17/arch/ia64/mm/init.c
===================================================================
--- rt17.orig/arch/ia64/mm/init.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/mm/init.c	2006-04-20 11:29:42.000000000 +0200
@@ -37,7 +37,7 @@
 #include <asm/unistd.h>
 #include <asm/mca.h>
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+DEFINE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
 
 DEFINE_PER_CPU(unsigned long *, __pgtable_quicklist);
 DEFINE_PER_CPU(long, __pgtable_quicklist_size);
Index: rt17/arch/ia64/mm/tlb.c
===================================================================
--- rt17.orig/arch/ia64/mm/tlb.c	2006-03-20 06:53:29.000000000 +0100
+++ rt17/arch/ia64/mm/tlb.c	2006-04-20 11:29:42.000000000 +0200
@@ -33,7 +33,7 @@ static struct {
 } purge;
 
 struct ia64_ctx ia64_ctx = {
-	.lock =		SPIN_LOCK_UNLOCKED,
+	.lock =		RAW_SPIN_LOCK_UNLOCKED,
 	.next =		1,
 	.max_ctx =	~0U
 };
Index: rt17/drivers/char/blocker.c
===================================================================
--- rt17.orig/drivers/char/blocker.c	2006-04-20 11:28:26.000000000 +0200
+++ rt17/drivers/char/blocker.c	2006-04-20 11:29:42.000000000 +0200
@@ -4,7 +4,6 @@
 
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
-#include <asm/rtc.h>
 
 #define BLOCKER_MINOR		221
 
Index: rt17/include/asm-ia64/irqflags.h
===================================================================
--- rt17.orig/include/asm-ia64/irqflags.h	2006-04-20 15:21:54.995117026 +0200
+++ rt17/include/asm-ia64/irqflags.h	2006-04-20 11:29:42.000000000 +0200
@@ -0,0 +1,95 @@
+
+/*
+ * include/asm-i64/irqflags.h
+ *
+ * IRQ flags handling
+ *
+ * This file gets included from lowlevel asm headers too, to provide
+ * wrapped versions of the local_irq_*() APIs, based on the
+ * raw_local_irq_*() macros from the lowlevel headers.
+ */
+#ifndef _ASM_IRQFLAGS_H
+#define _ASM_IRQFLAGS_H
+
+/* For spinlocks etc */
+
+/*
+ * - clearing psr.i is implicitly serialized (visible by next insn)
+ * - setting psr.i requires data serialization
+ * - we need a stop-bit before reading PSR because we sometimes
+ *   write a floating-point register right before reading the PSR
+ *   and that writes to PSR.mfl
+ */
+#define __local_irq_save(x)			\
+do {						\
+	ia64_stop();				\
+	(x) = ia64_getreg(_IA64_REG_PSR);	\
+	ia64_stop();				\
+	ia64_rsm(IA64_PSR_I);			\
+} while (0)
+
+#define __local_irq_disable()			\
+do {						\
+	ia64_stop();				\
+	ia64_rsm(IA64_PSR_I);			\
+} while (0)
+
+#define __local_irq_restore(x)	ia64_intrin_local_irq_restore((x) & IA64_PSR_I)
+
+#ifdef CONFIG_IA64_DEBUG_IRQ
+
+  extern unsigned long last_cli_ip;
+
+# define __save_ip()		last_cli_ip = ia64_getreg(_IA64_REG_IP)
+
+# define raw_local_irq_save(x)					\
+do {								\
+	unsigned long psr;					\
+								\
+	__local_irq_save(psr);					\
+	if (psr & IA64_PSR_I)					\
+		__save_ip();					\
+	(x) = psr;						\
+} while (0)
+
+# define raw_local_irq_disable()	do { unsigned long x; local_irq_save(x); } while (0)
+
+# define raw_local_irq_restore(x)					\
+do {								\
+	unsigned long old_psr, psr = (x);			\
+								\
+	local_save_flags(old_psr);				\
+	__local_irq_restore(psr);				\
+	if ((old_psr & IA64_PSR_I) && !(psr & IA64_PSR_I))	\
+		__save_ip();					\
+} while (0)
+
+#else /* !CONFIG_IA64_DEBUG_IRQ */
+# define raw_local_irq_save(x)	__local_irq_save(x)
+# define raw_local_irq_disable()	__local_irq_disable()
+# define raw_local_irq_restore(x)	__local_irq_restore(x)
+#endif /* !CONFIG_IA64_DEBUG_IRQ */
+
+#define raw_local_irq_enable()	({ ia64_stop(); ia64_ssm(IA64_PSR_I); ia64_srlz_d(); })
+#define raw_local_save_flags(flags)	({ ia64_stop(); (flags) = ia64_getreg(_IA64_REG_PSR); })
+
+#define raw_irqs_disabled()				\
+({						\
+	unsigned long __ia64_id_flags;		\
+	local_save_flags(__ia64_id_flags);	\
+	(__ia64_id_flags & IA64_PSR_I) == 0;	\
+})
+
+#define raw_irqs_disabled_flags(flags) ((flags & IA64_PSR_I) == 0)
+
+
+#define raw_safe_halt()         ia64_pal_halt_light()    /* PAL_HALT_LIGHT */
+
+/* TBD... */
+# define TRACE_IRQS_ON
+# define TRACE_IRQS_OFF
+# define TRACE_IRQS_ON_STR
+# define TRACE_IRQS_OFF_STR
+
+#endif
+
Index: rt17/include/asm-ia64/mmu_context.h
===================================================================
--- rt17.orig/include/asm-ia64/mmu_context.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/mmu_context.h	2006-04-20 11:29:42.000000000 +0200
@@ -31,7 +31,7 @@
 #include <asm/processor.h>
 
 struct ia64_ctx {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned int next;	/* next context number to use */
 	unsigned int limit;     /* available free range */
 	unsigned int max_ctx;   /* max. context value supported by all CPUs */
Index: rt17/include/asm-ia64/percpu.h
===================================================================
--- rt17.orig/include/asm-ia64/percpu.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/percpu.h	2006-04-20 11:29:42.000000000 +0200
@@ -25,10 +25,17 @@
 #define DECLARE_PER_CPU(type, name)				\
 	extern __SMALL_ADDR_AREA __typeof__(type) per_cpu__##name
 
+#define DECLARE_PER_CPU_LOCKED(type, name)		\
+	extern spinlock_t per_cpu_lock__##name##_locked; \
+	extern __SMALL_ADDR_AREA __typeof__(type) per_cpu__##name##_locked
+
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name)				\
-	__attribute__((__section__(".data.percpu")))		\
-	__SMALL_ADDR_AREA __typeof__(type) per_cpu__##name
+	__attribute__((__section__(".data.percpu"))) __SMALL_ADDR_AREA __typeof__(type) per_cpu__##name
+
+#define DEFINE_PER_CPU_LOCKED(type, name)				\
+	__attribute__((__section__(".data.percpu"))) __SMALL_ADDR_AREA spinlock_t per_cpu_lock__##name##_locked = SPIN_LOCK_UNLOCKED; \
+	__attribute__((__section__(".data.percpu"))) __SMALL_ADDR_AREA __typeof__(type) per_cpu__##name##_locked
 
 /*
  * Pretty much a literal copy of asm-generic/percpu.h, except that percpu_modcopy() is an
@@ -44,6 +51,16 @@ DECLARE_PER_CPU(unsigned long, local_per
 #define per_cpu(var, cpu)  (*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, __ia64_per_cpu_var(local_per_cpu_offset)))
 
+#define per_cpu_lock(var, cpu) \
+	(*RELOC_HIDE(&per_cpu_lock__##var##_locked, __per_cpu_offset[cpu]))
+#define per_cpu_var_locked(var, cpu) \
+		(*RELOC_HIDE(&per_cpu__##var##_locked, __per_cpu_offset[cpu]))
+#define __get_cpu_lock(var, cpu) \
+		per_cpu_lock(var, cpu)
+#define __get_cpu_var_locked(var, cpu) \
+		per_cpu_var_locked(var, cpu)
+
+
 extern void percpu_modcopy(void *pcpudst, const void *src, unsigned long size);
 extern void setup_per_cpu_areas (void);
 extern void *per_cpu_init(void);
Index: rt17/include/asm-ia64/rtc.h
===================================================================
--- rt17.orig/include/asm-ia64/rtc.h	2006-04-20 15:21:54.995117026 +0200
+++ rt17/include/asm-ia64/rtc.h	2006-04-20 13:44:06.000000000 +0200
@@ -0,0 +1,7 @@
+#ifndef _IA64_RTC_H
+#define _IA64_RTC_H
+
+#error "no asm/rtc.h on IA64 !"
+
+#endif
+
Index: rt17/include/asm-ia64/rwsem.h
===================================================================
--- rt17.orig/include/asm-ia64/rwsem.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/rwsem.h	2006-04-20 11:29:42.000000000 +0200
@@ -29,7 +29,7 @@
 /*
  * the semaphore definition
  */
-struct rw_semaphore {
+struct compat_rw_semaphore {
 	signed long		count;
 	spinlock_t		wait_lock;
 	struct list_head	wait_list;
@@ -59,16 +59,16 @@ struct rw_semaphore {
 	  LIST_HEAD_INIT((name).wait_list) \
 	  __RWSEM_DEBUG_INIT }
 
-#define DECLARE_RWSEM(name) \
-	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
+#define COMPAT_DECLARE_RWSEM(name) \
+	struct compat_rw_semaphore name = __RWSEM_INITIALIZER(name)
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
+extern struct compat_rw_semaphore *rwsem_down_read_failed(struct compat_rw_semaphore *sem);
+extern struct compat_rw_semaphore *rwsem_down_write_failed(struct compat_rw_semaphore *sem);
+extern struct compat_rw_semaphore *rwsem_wake(struct compat_rw_semaphore *sem);
+extern struct compat_rw_semaphore *rwsem_downgrade_wake(struct compat_rw_semaphore *sem);
 
 static inline void
-init_rwsem (struct rw_semaphore *sem)
+compat_init_rwsem (struct compat_rw_semaphore *sem)
 {
 	sem->count = RWSEM_UNLOCKED_VALUE;
 	spin_lock_init(&sem->wait_lock);
@@ -82,7 +82,7 @@ init_rwsem (struct rw_semaphore *sem)
  * lock for reading
  */
 static inline void
-__down_read (struct rw_semaphore *sem)
+__down_read (struct compat_rw_semaphore *sem)
 {
 	long result = ia64_fetchadd8_acq((unsigned long *)&sem->count, 1);
 
@@ -94,7 +94,7 @@ __down_read (struct rw_semaphore *sem)
  * lock for writing
  */
 static inline void
-__down_write (struct rw_semaphore *sem)
+__down_write (struct compat_rw_semaphore *sem)
 {
 	long old, new;
 
@@ -111,7 +111,7 @@ __down_write (struct rw_semaphore *sem)
  * unlock after reading
  */
 static inline void
-__up_read (struct rw_semaphore *sem)
+__up_read (struct compat_rw_semaphore *sem)
 {
 	long result = ia64_fetchadd8_rel((unsigned long *)&sem->count, -1);
 
@@ -123,7 +123,7 @@ __up_read (struct rw_semaphore *sem)
  * unlock after writing
  */
 static inline void
-__up_write (struct rw_semaphore *sem)
+__up_write (struct compat_rw_semaphore *sem)
 {
 	long old, new;
 
@@ -140,7 +140,7 @@ __up_write (struct rw_semaphore *sem)
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
 static inline int
-__down_read_trylock (struct rw_semaphore *sem)
+__down_read_trylock (struct compat_rw_semaphore *sem)
 {
 	long tmp;
 	while ((tmp = sem->count) >= 0) {
@@ -155,7 +155,7 @@ __down_read_trylock (struct rw_semaphore
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
 static inline int
-__down_write_trylock (struct rw_semaphore *sem)
+__down_write_trylock (struct compat_rw_semaphore *sem)
 {
 	long tmp = cmpxchg_acq(&sem->count, RWSEM_UNLOCKED_VALUE,
 			      RWSEM_ACTIVE_WRITE_BIAS);
@@ -166,7 +166,7 @@ __down_write_trylock (struct rw_semaphor
  * downgrade write lock to read lock
  */
 static inline void
-__downgrade_write (struct rw_semaphore *sem)
+__downgrade_write (struct compat_rw_semaphore *sem)
 {
 	long old, new;
 
@@ -186,7 +186,7 @@ __downgrade_write (struct rw_semaphore *
 #define rwsem_atomic_add(delta, sem)	atomic64_add(delta, (atomic64_t *)(&(sem)->count))
 #define rwsem_atomic_update(delta, sem)	atomic64_add_return(delta, (atomic64_t *)(&(sem)->count))
 
-static inline int rwsem_is_locked(struct rw_semaphore *sem)
+static inline int compat_rwsem_is_locked(struct compat_rw_semaphore *sem)
 {
 	return (sem->count != 0);
 }
Index: rt17/include/asm-ia64/sal.h
===================================================================
--- rt17.orig/include/asm-ia64/sal.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/sal.h	2006-04-20 11:29:42.000000000 +0200
@@ -43,7 +43,7 @@
 #include <asm/system.h>
 #include <asm/fpu.h>
 
-extern spinlock_t sal_lock;
+extern raw_spinlock_t sal_lock;
 
 /* SAL spec _requires_ eight args for each call. */
 #define __SAL_CALL(result,a0,a1,a2,a3,a4,a5,a6,a7)	\
Index: rt17/include/asm-ia64/semaphore.h
===================================================================
--- rt17.orig/include/asm-ia64/semaphore.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/semaphore.h	2006-04-20 11:29:42.000000000 +0200
@@ -11,54 +11,65 @@
 
 #include <asm/atomic.h>
 
-struct semaphore {
+/*
+ * On !PREEMPT_RT all semaphores are compat:
+ */
+#ifndef CONFIG_PREEMPT_RT
+# define compat_semaphore semaphore
+#endif
+
+struct compat_semaphore {
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
 };
 
-#define __SEMAPHORE_INITIALIZER(name, n)				\
+#define __COMPAT_SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
 	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
 }
 
-#define __DECLARE_SEMAPHORE_GENERIC(name,count)					\
-	struct semaphore name = __SEMAPHORE_INITIALIZER(name, count)
+#define __COMPAT_DECLARE_SEMAPHORE_GENERIC(name,count)					\
+	struct compat_semaphore name = __COMPAT_SEMAPHORE_INITIALIZER(name, count)
 
-#define DECLARE_MUTEX(name)		__DECLARE_SEMAPHORE_GENERIC(name, 1)
-#define DECLARE_MUTEX_LOCKED(name)	__DECLARE_SEMAPHORE_GENERIC(name, 0)
+#define COMPAT_DECLARE_MUTEX(name)		__COMPAT_DECLARE_SEMAPHORE_GENERIC(name, 1)
+#define COMPAT_DECLARE_MUTEX_LOCKED(name)	__COMPAT_DECLARE_SEMAPHORE_GENERIC(name, 0)
+
+#define compat_sema_count(sem) atomic_read(&(sem)->count)
+
+asmlinkage int compat_sem_is_locked(struct compat_semaphore *sem);
 
 static inline void
-sema_init (struct semaphore *sem, int val)
+compat_sema_init (struct compat_semaphore *sem, int val)
 {
-	*sem = (struct semaphore) __SEMAPHORE_INITIALIZER(*sem, val);
+	*sem = (struct compat_semaphore) __COMPAT_SEMAPHORE_INITIALIZER(*sem, val);
 }
 
 static inline void
-init_MUTEX (struct semaphore *sem)
+compat_init_MUTEX (struct compat_semaphore *sem)
 {
-	sema_init(sem, 1);
+	compat_sema_init(sem, 1);
 }
 
 static inline void
-init_MUTEX_LOCKED (struct semaphore *sem)
+compat_init_MUTEX_LOCKED (struct compat_semaphore *sem)
 {
-	sema_init(sem, 0);
+	compat_sema_init(sem, 0);
 }
 
-extern void __down (struct semaphore * sem);
-extern int  __down_interruptible (struct semaphore * sem);
-extern int  __down_trylock (struct semaphore * sem);
-extern void __up (struct semaphore * sem);
+extern void __down (struct compat_semaphore * sem);
+extern int  __down_interruptible (struct compat_semaphore * sem);
+extern int  __down_trylock (struct compat_semaphore * sem);
+extern void __up (struct compat_semaphore * sem);
 
 /*
  * Atomically decrement the semaphore's count.  If it goes negative,
  * block the calling thread in the TASK_UNINTERRUPTIBLE state.
  */
 static inline void
-down (struct semaphore *sem)
+compat_down (struct compat_semaphore *sem)
 {
 	might_sleep();
 	if (ia64_fetchadd(-1, &sem->count.counter, acq) < 1)
@@ -70,7 +81,7 @@ down (struct semaphore *sem)
  * block the calling thread in the TASK_INTERRUPTIBLE state.
  */
 static inline int
-down_interruptible (struct semaphore * sem)
+compat_down_interruptible (struct compat_semaphore * sem)
 {
 	int ret = 0;
 
@@ -81,7 +92,7 @@ down_interruptible (struct semaphore * s
 }
 
 static inline int
-down_trylock (struct semaphore *sem)
+compat_down_trylock (struct compat_semaphore *sem)
 {
 	int ret = 0;
 
@@ -91,10 +102,12 @@ down_trylock (struct semaphore *sem)
 }
 
 static inline void
-up (struct semaphore * sem)
+compat_up (struct compat_semaphore * sem)
 {
 	if (ia64_fetchadd(1, &sem->count.counter, rel) <= -1)
 		__up(sem);
 }
 
+#include <linux/semaphore.h>
+
 #endif /* _ASM_IA64_SEMAPHORE_H */
Index: rt17/include/asm-ia64/spinlock.h
===================================================================
--- rt17.orig/include/asm-ia64/spinlock.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/spinlock.h	2006-04-20 11:29:42.000000000 +0200
@@ -17,8 +17,6 @@
 #include <asm/intrinsics.h>
 #include <asm/system.h>
 
-#define __raw_spin_lock_init(x)			((x)->lock = 0)
-
 #ifdef ASM_SUPPORTED
 /*
  * Try to get the lock.  If we fail to get the lock, make a non-standard call to
@@ -30,7 +28,7 @@
 #define IA64_SPINLOCK_CLOBBERS "ar.ccv", "ar.pfs", "p14", "p15", "r27", "r28", "r29", "r30", "b6", "memory"
 
 static inline void
-__raw_spin_lock_flags (raw_spinlock_t *lock, unsigned long flags)
+__raw_spin_lock_flags (__raw_spinlock_t *lock, unsigned long flags)
 {
 	register volatile unsigned int *ptr asm ("r31") = &lock->lock;
 
@@ -89,7 +87,7 @@ __raw_spin_lock_flags (raw_spinlock_t *l
 #define __raw_spin_lock(lock) __raw_spin_lock_flags(lock, 0)
 
 /* Unlock by doing an ordered store and releasing the cacheline with nta */
-static inline void __raw_spin_unlock(raw_spinlock_t *x) {
+static inline void __raw_spin_unlock(__raw_spinlock_t *x) {
 	barrier();
 	asm volatile ("st4.rel.nta [%0] = r0\n\t" :: "r"(x));
 }
@@ -109,7 +107,7 @@ do {											\
 		} while (ia64_spinlock_val);						\
 	}										\
 } while (0)
-#define __raw_spin_unlock(x)	do { barrier(); ((raw_spinlock_t *) x)->lock = 0; } while (0)
+#define __raw_spin_unlock(x)	do { barrier(); ((__raw_spinlock_t *) x)->lock = 0; } while (0)
 #endif /* !ASM_SUPPORTED */
 
 #define __raw_spin_is_locked(x)		((x)->lock != 0)
@@ -122,7 +120,7 @@ do {											\
 
 #define __raw_read_lock(rw)								\
 do {											\
-	raw_rwlock_t *__read_lock_ptr = (rw);						\
+	__raw_rwlock_t *__read_lock_ptr = (rw);						\
 											\
 	while (unlikely(ia64_fetchadd(1, (int *) __read_lock_ptr, acq) < 0)) {		\
 		ia64_fetchadd(-1, (int *) __read_lock_ptr, rel);			\
@@ -133,7 +131,7 @@ do {											\
 
 #define __raw_read_unlock(rw)					\
 do {								\
-	raw_rwlock_t *__read_lock_ptr = (rw);			\
+	__raw_rwlock_t *__read_lock_ptr = (rw);			\
 	ia64_fetchadd(-1, (int *) __read_lock_ptr, rel);	\
 } while (0)
 
@@ -165,7 +163,7 @@ do {										\
 	(result == 0);								\
 })
 
-static inline void __raw_write_unlock(raw_rwlock_t *x)
+static inline void __raw_write_unlock(__raw_rwlock_t *x)
 {
 	u8 *y = (u8 *)x;
 	barrier();
@@ -193,7 +191,7 @@ static inline void __raw_write_unlock(ra
 	(ia64_val == 0);						\
 })
 
-static inline void __raw_write_unlock(raw_rwlock_t *x)
+static inline void __raw_write_unlock(__raw_rwlock_t *x)
 {
 	barrier();
 	x->write_lock = 0;
@@ -201,10 +199,10 @@ static inline void __raw_write_unlock(ra
 
 #endif /* !ASM_SUPPORTED */
 
-static inline int __raw_read_trylock(raw_rwlock_t *x)
+static inline int __raw_read_trylock(__raw_rwlock_t *x)
 {
 	union {
-		raw_rwlock_t lock;
+		__raw_rwlock_t lock;
 		__u32 word;
 	} old, new;
 	old.lock = new.lock = *x;
Index: rt17/include/asm-ia64/spinlock_types.h
===================================================================
--- rt17.orig/include/asm-ia64/spinlock_types.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/spinlock_types.h	2006-04-20 11:29:42.000000000 +0200
@@ -7,14 +7,14 @@
 
 typedef struct {
 	volatile unsigned int lock;
-} raw_spinlock_t;
+} __raw_spinlock_t;
 
 #define __RAW_SPIN_LOCK_UNLOCKED	{ 0 }
 
 typedef struct {
 	volatile unsigned int read_counter	: 31;
 	volatile unsigned int write_lock	:  1;
-} raw_rwlock_t;
+} __raw_rwlock_t;
 
 #define __RAW_RW_LOCK_UNLOCKED		{ 0, 0 }
 
Index: rt17/include/asm-ia64/system.h
===================================================================
--- rt17.orig/include/asm-ia64/system.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/system.h	2006-04-20 11:29:42.000000000 +0200
@@ -106,81 +106,16 @@ extern struct ia64_boot_param {
 #define set_mb(var, value)	do { (var) = (value); mb(); } while (0)
 #define set_wmb(var, value)	do { (var) = (value); mb(); } while (0)
 
-#define safe_halt()         ia64_pal_halt_light()    /* PAL_HALT_LIGHT */
 
 /*
  * The group barrier in front of the rsm & ssm are necessary to ensure
  * that none of the previous instructions in the same group are
  * affected by the rsm/ssm.
  */
-/* For spinlocks etc */
 
-/*
- * - clearing psr.i is implicitly serialized (visible by next insn)
- * - setting psr.i requires data serialization
- * - we need a stop-bit before reading PSR because we sometimes
- *   write a floating-point register right before reading the PSR
- *   and that writes to PSR.mfl
- */
-#define __local_irq_save(x)			\
-do {						\
-	ia64_stop();				\
-	(x) = ia64_getreg(_IA64_REG_PSR);	\
-	ia64_stop();				\
-	ia64_rsm(IA64_PSR_I);			\
-} while (0)
-
-#define __local_irq_disable()			\
-do {						\
-	ia64_stop();				\
-	ia64_rsm(IA64_PSR_I);			\
-} while (0)
-
-#define __local_irq_restore(x)	ia64_intrin_local_irq_restore((x) & IA64_PSR_I)
-
-#ifdef CONFIG_IA64_DEBUG_IRQ
 
-  extern unsigned long last_cli_ip;
-
-# define __save_ip()		last_cli_ip = ia64_getreg(_IA64_REG_IP)
-
-# define local_irq_save(x)					\
-do {								\
-	unsigned long psr;					\
-								\
-	__local_irq_save(psr);					\
-	if (psr & IA64_PSR_I)					\
-		__save_ip();					\
-	(x) = psr;						\
-} while (0)
-
-# define local_irq_disable()	do { unsigned long x; local_irq_save(x); } while (0)
-
-# define local_irq_restore(x)					\
-do {								\
-	unsigned long old_psr, psr = (x);			\
-								\
-	local_save_flags(old_psr);				\
-	__local_irq_restore(psr);				\
-	if ((old_psr & IA64_PSR_I) && !(psr & IA64_PSR_I))	\
-		__save_ip();					\
-} while (0)
+#include <linux/trace_irqflags.h>
 
-#else /* !CONFIG_IA64_DEBUG_IRQ */
-# define local_irq_save(x)	__local_irq_save(x)
-# define local_irq_disable()	__local_irq_disable()
-# define local_irq_restore(x)	__local_irq_restore(x)
-#endif /* !CONFIG_IA64_DEBUG_IRQ */
-
-#define local_irq_enable()	({ ia64_stop(); ia64_ssm(IA64_PSR_I); ia64_srlz_d(); })
-#define local_save_flags(flags)	({ ia64_stop(); (flags) = ia64_getreg(_IA64_REG_PSR); })
-
-#define irqs_disabled()				\
-({						\
-	unsigned long __ia64_id_flags;		\
-	local_save_flags(__ia64_id_flags);	\
-	(__ia64_id_flags & IA64_PSR_I) == 0;	\
-})
 
 #ifdef __KERNEL__
 
Index: rt17/include/asm-ia64/thread_info.h
===================================================================
--- rt17.orig/include/asm-ia64/thread_info.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/thread_info.h	2006-04-20 11:29:42.000000000 +0200
@@ -94,6 +94,7 @@ struct thread_info {
 #define TIF_MEMDIE		17
 #define TIF_MCA_INIT		18	/* this task is processing MCA or INIT */
 #define TIF_DB_DISABLED		19	/* debug trap disabled for fsyscall */
+#define TIF_NEED_RESCHED_DELAYED 20	/* reschedule on return to userspace */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
Index: rt17/include/asm-ia64/tlb.h
===================================================================
--- rt17.orig/include/asm-ia64/tlb.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/asm-ia64/tlb.h	2006-04-20 11:29:42.000000000 +0200
@@ -41,6 +41,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
+#include <linux/percpu.h>
 
 #include <asm/pgalloc.h>
 #include <asm/processor.h>
@@ -62,11 +63,12 @@ struct mmu_gather {
 	unsigned char		need_flush;	/* really unmapped some PTEs? */
 	unsigned long		start_addr;
 	unsigned long		end_addr;
+	int cpu;
 	struct page 		*pages[FREE_PTE_NR];
 };
 
 /* Users of the generic TLB shootdown code must declare this storage space. */
-DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
+DECLARE_PER_CPU_LOCKED(struct mmu_gather, mmu_gathers);
 
 /*
  * Flush the TLB for address range START to END and, if not in fast mode, release the
@@ -128,8 +130,10 @@ ia64_tlb_flush_mmu (struct mmu_gather *t
 static inline struct mmu_gather *
 tlb_gather_mmu (struct mm_struct *mm, unsigned int full_mm_flush)
 {
-	struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
-
+	int cpu;
+	struct mmu_gather *tlb = &get_cpu_var_locked(mmu_gathers, &cpu);
+ 
+	tlb->cpu = cpu;
 	tlb->mm = mm;
 	/*
 	 * Use fast mode if only 1 CPU is online.
@@ -166,7 +170,7 @@ tlb_finish_mmu (struct mmu_gather *tlb, 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
 
-	put_cpu_var(mmu_gathers);
+	put_cpu_var_locked(mmu_gathers, tlb->cpu);
 }
 
 /*
Index: rt17/include/linux/mmzone.h
===================================================================
--- rt17.orig/include/linux/mmzone.h	2006-03-20 06:53:29.000000000 +0100
+++ rt17/include/linux/mmzone.h	2006-04-20 11:29:42.000000000 +0200
@@ -139,7 +139,12 @@ struct zone {
 	/*
 	 * free areas of different sizes
 	 */
+#ifdef CONFIG_IA64
+	/* IA64 calls check_pgt_cache from cpu_idle() */
+	raw_spinlock_t		lock;
+#else
 	spinlock_t		lock;
+#endif
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/* see spanned/present_pages for more description */
 	seqlock_t		span_seqlock;
Index: rt17/kernel/latency.c
===================================================================
--- rt17.orig/kernel/latency.c	2006-04-20 11:28:26.000000000 +0200
+++ rt17/kernel/latency.c	2006-04-20 11:29:59.000000000 +0200
@@ -23,7 +23,6 @@
 #include <linux/latency_hist.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
-#include <asm/rtc.h>
 
 #ifndef irqs_off
 # define irqs_off			irqs_disabled
@@ -53,6 +52,7 @@ int wakeup_timing = 1;
 
 #ifdef CONFIG_LATENCY_TIMING
 
+#include <asm/rtc.h>
 /*
  * Maximum preemption latency measured. Initialize to maximum,
  * we clear it after bootup.
