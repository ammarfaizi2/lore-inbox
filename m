Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVBAStU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVBAStU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVBAStU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:49:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62446 "EHLO
	prometheus.mvista.com") by vger.kernel.org with ESMTP
	id S261423AbVBASqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:46:54 -0500
Date: Tue, 1 Feb 2005 10:46:41 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: trini@kernel.crashing.org, ralf@linux-mips.org, mingo@elte.hu,
       mlachwani@mvista.com
Subject: [PATCH] Realtime preempt support for MIPS
Message-ID: <20050201184641.GA689@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi !

Attached patch incorporates real-time preempt support for MIPS. This patch applies over 
Ingo's real-time preempt patch: 

http://people.redhat.com/mingo/realtime-preempt/realtime-preempt-2.6.11-rc2-V0.7.37-01

This patch has been tested on the Broadcom Sibyte (UP and SMP) and the PMC-Sierra Ocelot3 (UP).

Thanks
Manish Lachwani


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_rt_mips-2611-rc2.patch"

Source: MontaVista Software, Inc. | http://source.mvista.com | Manish Lachwani <mlachwani@mvista.com>
Disposition: Submitted to Ingo Molnar (2.6.11-rc2)
Description:
	New patch for MIPS (UP and SMP) after incorporating Ingo's changes
Signed-off-by: Manish Lachwani <mlachwani@mvista.com>

Index: linux-2.6.11-rc2/arch/mips/kernel/time.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/time.c
+++ linux-2.6.11-rc2/arch/mips/kernel/time.c
@@ -53,8 +53,7 @@
  */
 extern volatile unsigned long wall_jiffies;
 
-spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
-
+raw_spinlock_t rtc_lock = RAW_SPIN_LOCK_UNLOCKED;
 /*
  * By default we provide the null RTC ops
  */
@@ -556,7 +555,7 @@
 
 static struct irqaction timer_irqaction = {
 	.handler = timer_interrupt,
-	.flags = SA_INTERRUPT,
+	.flags = SA_NODELAY | SA_INTERRUPT,
 	.name = "timer",
 };
 
Index: linux-2.6.11-rc2/arch/mips/kernel/signal32.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/signal32.c
+++ linux-2.6.11-rc2/arch/mips/kernel/signal32.c
@@ -765,6 +765,10 @@
 	siginfo_t info;
 	int signr;
 
+#ifdef CONFIG_PREEMPT_RT
+	local_irq_enable();
+	preempt_check_resched();
+#endif
 	/*
 	 * We want the common case to go fast, which is why we may in certain
 	 * cases get here from kernel mode. Just return without doing anything
Index: linux-2.6.11-rc2/arch/mips/kernel/traps.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/traps.c
+++ linux-2.6.11-rc2/arch/mips/kernel/traps.c
@@ -244,7 +244,7 @@
 	printk("\n");
 }
 
-static spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t die_lock = RAW_SPIN_LOCK_UNLOCKED;
 
 NORET_TYPE void __die(const char * str, struct pt_regs * regs,
 	const char * file, const char * func, unsigned long line)
Index: linux-2.6.11-rc2/arch/mips/kernel/irq.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/irq.c
+++ linux-2.6.11-rc2/arch/mips/kernel/irq.c
@@ -125,7 +125,10 @@
 		irq_desc[i].action  = NULL;
 		irq_desc[i].depth   = 1;
 		irq_desc[i].handler = &no_irq_type;
-		irq_desc[i].lock = SPIN_LOCK_UNLOCKED;
+		irq_desc[i].lock = RAW_SPIN_LOCK_UNLOCKED;
+#ifdef CONFIG_PREEMPT_HARDIRQS
+		irq_desc[i].thread = NULL;
+#endif
 	}
 
 	arch_init_irq();
Index: linux-2.6.11-rc2/arch/mips/kernel/process.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/process.c
+++ linux-2.6.11-rc2/arch/mips/kernel/process.c
@@ -58,6 +58,7 @@
 		while (!need_resched())
 			if (cpu_wait)
 				(*cpu_wait)();
+		local_irq_enable();
 		schedule();
 	}
 }
Index: linux-2.6.11-rc2/arch/mips/lib/dec_and_lock.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/lib/dec_and_lock.c
+++ linux-2.6.11-rc2/arch/mips/lib/dec_and_lock.c
@@ -28,7 +28,7 @@
  */
 
 #ifndef ATOMIC_DEC_AND_LOCK
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+int _atomic_dec_and_raw_spin_lock(atomic_t *atomic, raw_spinlock_t *lock)
 {
 	int counter;
 	int newcount;
@@ -44,12 +44,12 @@
 			return 0;
 	}
 
-	spin_lock(lock);
+	_raw_spin_lock(lock);
 	if (atomic_dec_and_test(atomic))
 		return 1;
-	spin_unlock(lock);
+	_raw_spin_unlock(lock);
 	return 0;
 }
 
-EXPORT_SYMBOL(_atomic_dec_and_lock);
+EXPORT_SYMBOL(_atomic_dec_and_raw_spin_lock);
 #endif /* ATOMIC_DEC_AND_LOCK */
Index: linux-2.6.11-rc2/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/smp.c
+++ linux-2.6.11-rc2/arch/mips/kernel/smp.c
@@ -123,7 +123,22 @@
 	cpu_idle();
 }
 
-spinlock_t smp_call_lock = SPIN_LOCK_UNLOCKED;
+raw_spinlock_t smp_call_lock = RAW_SPIN_LOCK_UNLOCKED;
+
+/*
+ * this function sends a 'reschedule' IPI to all other CPUs.
+ * This is used when RT tasks are starving and other CPUs
+ * might be able to run them.
+ */
+void smp_send_reschedule_allbutself(void)
+{
+	int cpu = smp_processor_id();
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i) && i != cpu)
+			core_send_ipi(i, SMP_RESCHEDULE_YOURSELF);
+}
 
 struct call_data_struct *call_data;
 
@@ -302,6 +317,8 @@
 	return 0;
 }
 
+static DEFINE_RAW_SPINLOCK(tlbstate_lock);
+
 static void flush_tlb_all_ipi(void *info)
 {
 	local_flush_tlb_all();
@@ -333,6 +350,7 @@
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	preempt_disable();
+	spin_lock(&tlbstate_lock);
 
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
 		smp_call_function(flush_tlb_mm_ipi, (void *)mm, 1, 1);
@@ -342,6 +360,7 @@
 			if (smp_processor_id() != i)
 				cpu_context(i, mm) = 0;
 	}
+	spin_unlock(&tlbstate_lock);
 	local_flush_tlb_mm(mm);
 
 	preempt_enable();
@@ -365,6 +384,8 @@
 	struct mm_struct *mm = vma->vm_mm;
 
 	preempt_disable();
+	spin_lock(&tlbstate_lock);
+
 	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
 		struct flush_tlb_data fd;
 
@@ -378,6 +399,7 @@
 			if (smp_processor_id() != i)
 				cpu_context(i, mm) = 0;
 	}
+	spin_unlock(&tlbstate_lock);
 	local_flush_tlb_range(vma, start, end);
 	preempt_enable();
 }
@@ -408,6 +430,8 @@
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
 	preempt_disable();
+	spin_lock(&tlbstate_lock);
+
 	if ((atomic_read(&vma->vm_mm->mm_users) != 1) || (current->mm != vma->vm_mm)) {
 		struct flush_tlb_data fd;
 
@@ -420,6 +444,7 @@
 			if (smp_processor_id() != i)
 				cpu_context(i, vma->vm_mm) = 0;
 	}
+	spin_unlock(&tlbstate_lock);
 	local_flush_tlb_page(vma, page);
 	preempt_enable();
 }
Index: linux-2.6.11-rc2/arch/mips/kernel/Makefile
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/Makefile
+++ linux-2.6.11-rc2/arch/mips/kernel/Makefile
@@ -5,7 +5,7 @@
 extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
-		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
+		   ptrace.o reset.o setup.o signal.o syscall.o \
 		   time.o traps.o unaligned.o
 
 ifdef CONFIG_MODULES
@@ -14,6 +14,8 @@
 obj-$(CONFIG_MIPS64)		+= module-elf64.o
 endif
 
+obj-$(CONFIG_ASM_SEMAPHORES)	+= semaphore.o
+
 obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_TX39XX)	+= r2300_fpu.o r2300_switch.o
 obj-$(CONFIG_CPU_TX49XX)	+= r4k_fpu.o r4k_switch.o
Index: linux-2.6.11-rc2/arch/mips/kernel/signal.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/signal.c
+++ linux-2.6.11-rc2/arch/mips/kernel/signal.c
@@ -568,6 +568,10 @@
 	}
 #endif
 
+#ifdef CONFIG_PREEMPT_RT
+	local_irq_enable();
+	preempt_check_resched();
+#endif
 	/*
 	 * We want the common case to go fast, which is why we may in certain
 	 * cases get here from kernel mode. Just return without doing anything
Index: linux-2.6.11-rc2/arch/mips/kernel/entry.S
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/entry.S
+++ linux-2.6.11-rc2/arch/mips/kernel/entry.S
@@ -48,6 +48,8 @@
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
+	lw	t0, kernel_preemption
+	beqz	t0, restore_all
 	lw	t0, TI_PRE_COUNT($28)
 	bnez	t0, restore_all
 need_resched:
@@ -57,12 +59,9 @@
 	LONG_L	t0, PT_STATUS(sp)		# Interrupts off?
 	andi	t0, 1
 	beqz	t0, restore_all
-	li	t0, PREEMPT_ACTIVE
-	sw	t0, TI_PRE_COUNT($28)
-	local_irq_enable t0
-	jal	schedule
-	sw	zero, TI_PRE_COUNT($28)
 	local_irq_disable t0
+	jal	preempt_schedule_irq
+	sw	zero, TI_PRE_COUNT($28)
 	b	need_resched
 #endif
 
@@ -92,6 +91,7 @@
 	andi	t0, a2, _TIF_NEED_RESCHED
 	beqz	t0, work_notifysig
 work_resched:
+	local_irq_enable  t0
 	jal	schedule
 
 	local_irq_disable t0		# make sure need_resched and
Index: linux-2.6.11-rc2/arch/mips/kernel/module.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/module.c
+++ linux-2.6.11-rc2/arch/mips/kernel/module.c
@@ -2,7 +2,7 @@
 #include <linux/spinlock.h>
 
 static LIST_HEAD(dbe_list);
-static spinlock_t dbe_lock = SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t dbe_lock = RAW_SPIN_LOCK_UNLOCKED;
 
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_dbetables(unsigned long addr)
Index: linux-2.6.11-rc2/arch/mips/sibyte/sb1250/irq.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/sibyte/sb1250/irq.c
+++ linux-2.6.11-rc2/arch/mips/sibyte/sb1250/irq.c
@@ -88,7 +88,7 @@
 /* Store the CPU id (not the logical number) */
 int sb1250_irq_owner[SB1250_NR_IRQS];
 
-spinlock_t sb1250_imr_lock = SPIN_LOCK_UNLOCKED;
+raw_spinlock_t sb1250_imr_lock = RAW_SPIN_LOCK_UNLOCKED;
 
 void sb1250_mask_irq(int cpu, int irq)
 {
@@ -267,7 +267,7 @@
 
 static struct irqaction sb1250_dummy_action = {
 	.handler = sb1250_dummy_handler,
-	.flags   = 0,
+	.flags   = SA_NODELAY,
 	.mask    = CPU_MASK_NONE,
 	.name    = "sb1250-private",
 	.next    = NULL,
Index: linux-2.6.11-rc2/arch/mips/kernel/semaphore.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/semaphore.c
+++ linux-2.6.11-rc2/arch/mips/kernel/semaphore.c
@@ -64,7 +64,7 @@
 		: "=&r" (old_count), "=&r" (tmp), "=m" (sem->count)
 		: "r" (incr), "m" (sem->count));
 	} else {
-		static spinlock_t semaphore_lock = SPIN_LOCK_UNLOCKED;
+		static raw_spinlock_t semaphore_lock = RAW_SPIN_LOCK_UNLOCKED;
 		unsigned long flags;
 
 		spin_lock_irqsave(&semaphore_lock, flags);
Index: linux-2.6.11-rc2/include/asm-mips/spinlock.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/spinlock.h
+++ linux-2.6.11-rc2/include/asm-mips/spinlock.h
@@ -9,26 +9,25 @@
 #ifndef _ASM_SPINLOCK_H
 #define _ASM_SPINLOCK_H
 
+#include <asm/atomic.h>
+#include <asm/page.h>
+
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/compiler.h>
 #include <asm/war.h>
 
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
  */
-
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} spinlock_t;
-
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
-
-#define spin_lock_init(x)	do { (x)->lock = 0; } while(0)
-
-#define spin_is_locked(x)	((x)->lock != 0)
-#define spin_unlock_wait(x)	do { barrier(); } while ((x)->lock)
-#define _raw_spin_lock_flags(lock, flags) _raw_spin_lock(lock)
+#define __RAW_SPIN_LOCK_UNLOCKED { 0 }
+#define RAW_SPIN_LOCK_UNLOCKED (raw_spinlock_t) __RAW_SPIN_LOCK_UNLOCKED
+#define __raw_spin_lock_init(x)        do { *(x) = RAW_SPIN_LOCK_UNLOCKED; } while(0)
+
+#define __raw_spin_is_locked(x)        ((x)->lock != 0)
+#define __raw_spin_unlock_wait(x) \
+	do { barrier(); } while (__raw_spin_is_locked(x))
+#define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
@@ -37,7 +36,7 @@
  * We make no fairness assumptions.  They have a cost.
  */
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	unsigned int tmp;
 
@@ -71,7 +70,7 @@
 	}
 }
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__asm__ __volatile__(
 	"	.set	noreorder	# _raw_spin_unlock	\n"
@@ -83,7 +82,7 @@
 	: "memory");
 }
 
-static inline unsigned int _raw_spin_trylock(spinlock_t *lock)
+static inline unsigned int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	unsigned int temp, res;
 
@@ -119,27 +118,13 @@
 	return res == 0;
 }
 
-/*
- * Read-write spinlocks, allowing multiple readers but only one writer.
- *
- * NOTE! it is quite common to have readers in interrupts but no interrupt
- * writers. For those circumstances we can "mix" irq-safe locks - any writer
- * needs to get a irq-safe write-lock, but readers can get non-irqsafe
- * read-locks.
- */
-
-typedef struct {
-	volatile unsigned int lock;
-#ifdef CONFIG_PREEMPT
-	unsigned int break_lock;
-#endif
-} rwlock_t;
-
-#define RW_LOCK_UNLOCKED (rwlock_t) { 0 }
+#define __RAW_RW_LOCK_UNLOCKED { 0 }
+#define RAW_RW_LOCK_UNLOCKED (raw_rwlock_t) __RAW_RW_LOCK_UNLOCKED
 
-#define rwlock_init(x)  do { *(x) = RW_LOCK_UNLOCKED; } while(0)
+#define __raw_rwlock_init(x) do { *(x) = RAW_RW_LOCK_UNLOCKED; } while(0)
+#define __raw_rwlock_is_locked(x)      ((x)->lock)
 
-static inline void _raw_read_lock(rwlock_t *rw)
+static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -176,7 +161,7 @@
 /* Note the use of sub, not subu which will make the kernel die with an
    overflow exception if we ever try to unlock an rwlock that is already
    unlocked or is being held by a writer.  */
-static inline void _raw_read_unlock(rwlock_t *rw)
+static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -205,7 +190,7 @@
 	}
 }
 
-static inline void _raw_write_lock(rwlock_t *rw)
+static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 
@@ -240,7 +225,7 @@
 	}
 }
 
-static inline void _raw_write_unlock(rwlock_t *rw)
+static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	__asm__ __volatile__(
 	"	sync			# _raw_write_unlock	\n"
@@ -250,9 +235,9 @@
 	: "memory");
 }
 
-#define _raw_read_trylock(lock) generic_raw_read_trylock(lock)
+#define __raw_read_trylock(lock) generic_raw_read_trylock(lock)
 
-static inline int _raw_write_trylock(rwlock_t *rw)
+static inline int __raw_write_trylock(raw_rwlock_t *rw)
 {
 	unsigned int tmp;
 	int ret;
Index: linux-2.6.11-rc2/include/asm-mips/system.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/system.h
+++ linux-2.6.11-rc2/include/asm-mips/system.h
@@ -421,6 +421,7 @@
 
 extern int stop_a_enabled;
 
+#ifndef CONFIG_PREEMPT_RT
 /*
  * Taken from include/asm-ia64/system.h; prevents deadlock on SMP
  * systems.
@@ -430,7 +431,8 @@
 	spin_lock(&(next)->switch_lock);	\
 	spin_unlock(&(rq)->lock);		\
 } while (0)
-#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(prev)->switch_lock)
+#define _finish_arch_switch(rq, prev)	spin_unlock(&(prev)->switch_lock)
 #define task_running(rq, p) 		((rq)->curr == (p) || spin_is_locked(&(p)->switch_lock))
+#endif
 
 #endif /* _ASM_SYSTEM_H */
Index: linux-2.6.11-rc2/include/asm-mips/semaphore.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/semaphore.h
+++ linux-2.6.11-rc2/include/asm-mips/semaphore.h
@@ -24,11 +24,18 @@
 
 #ifdef __KERNEL__
 
-#include <asm/atomic.h>
-#include <asm/system.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
+#ifdef CONFIG_PREEMPT_RT
+
+#include <linux/rt_lock.h>
+
+#else
+
+#include <asm/atomic.h>
+#include <asm/system.h>
+
 struct semaphore {
 	/*
 	 * Note that any negative value of count is equivalent to 0,
@@ -107,6 +114,8 @@
 		__up(sem);
 }
 
+#endif /* CONFIG_PREEMPT_RT */
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_SEMAPHORE_H */
Index: linux-2.6.11-rc2/include/asm-mips/atomic.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/atomic.h
+++ linux-2.6.11-rc2/include/asm-mips/atomic.h
@@ -18,15 +18,20 @@
  * main big wrapper ...
  */
 #include <linux/config.h>
-#include <linux/spinlock.h>
 
 #ifndef _ASM_ATOMIC_H
 #define _ASM_ATOMIC_H
 
 #include <asm/cpu-features.h>
 #include <asm/war.h>
+#include <asm/types.h>
+
+#ifndef CONFIG_NO_SPINLOCK
+
+#include <linux/spinlock.h>
+extern raw_spinlock_t atomic_lock;
 
-extern spinlock_t atomic_lock;
+#endif
 
 typedef struct { volatile int counter; } atomic_t;
 
@@ -78,13 +83,16 @@
 		"	beqz	%0, 1b					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
 		v->counter += i;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 }
 
 /*
@@ -116,13 +124,16 @@
 		"	beqz	%0, 1b					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
 		v->counter -= i;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 }
 
 /*
@@ -158,7 +169,9 @@
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
@@ -167,6 +180,7 @@
 		v->counter = result;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 
 	return result;
 }
@@ -201,7 +215,9 @@
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
@@ -210,6 +226,7 @@
 		v->counter = result;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 
 	return result;
 }
@@ -253,7 +270,9 @@
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
@@ -263,6 +282,7 @@
 			v->counter = result;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 
 	return result;
 }
@@ -383,13 +403,16 @@
 		"	beqz	%0, 1b					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
 		v->counter += i;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 }
 
 /*
@@ -421,13 +444,16 @@
 		"	beqz	%0, 1b					\n"
 		: "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter));
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
 		v->counter -= i;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 }
 
 /*
@@ -463,7 +489,9 @@
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
@@ -472,6 +500,7 @@
 		v->counter = result;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 
 	return result;
 }
@@ -506,7 +535,9 @@
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
@@ -515,6 +546,7 @@
 		v->counter = result;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 
 	return result;
 }
@@ -558,7 +590,9 @@
 		: "=&r" (result), "=&r" (temp), "=m" (v->counter)
 		: "Ir" (i), "m" (v->counter)
 		: "memory");
-	} else {
+	} 
+#ifndef CONFIG_NO_SPINLOCK
+	else {
 		unsigned long flags;
 
 		spin_lock_irqsave(&atomic_lock, flags);
@@ -568,6 +602,7 @@
 			v->counter = result;
 		spin_unlock_irqrestore(&atomic_lock, flags);
 	}
+#endif
 
 	return result;
 }
Index: linux-2.6.11-rc2/arch/mips/Kconfig
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/Kconfig
+++ linux-2.6.11-rc2/arch/mips/Kconfig
@@ -317,6 +317,7 @@
 config MOMENCO_OCELOT_3
 	bool "Support for Momentum Ocelot-3 board"
 	select DMA_NONCOHERENT
+	select NO_SPINLOCK
 	select HW_HAS_PCI
 	select IRQ_CPU
 	select IRQ_CPU_RM7K
@@ -612,6 +613,7 @@
 	bool "Support for Broadcom BCM1xxx SOCs (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
 	select DMA_COHERENT
+	select NO_SPINLOCK
 	select SWAP_IO_SPACE
 
 choice
@@ -845,12 +847,22 @@
 	bool "FPCIB0 Backplane Support"
 	depends on TOSHIBA_RBTX4927
 
+source "lib/Kconfig.RT"
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
+	depends on !PREEMPT_RT
 	default y
 
 config RWSEM_XCHGADD_ALGORITHM
 	bool
+	depends on !PREEMPT_RT
+	default y
+
+config ASM_SEMAPHORES
+	bool
+	depends on !PREEMPT_RT
+	default y
 
 config GENERIC_CALIBRATE_DELAY
 	bool
@@ -871,6 +883,9 @@
 config	DMA_COHERENT
 	bool
 
+config NO_SPINLOCK
+	bool
+
 config	DMA_IP27
 	bool
 
@@ -1398,15 +1413,6 @@
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
 
-config PREEMPT
-	bool "Preemptible Kernel"
-	help
-	  This option reduces the latency of the kernel when reacting to
-	  real-time or interactive events by allowing a low priority process to
-	  be preempted even if it is in kernel mode executing a system call.
-	  This allows applications to run more reliably even when the system is
-	  under load.
-
 config RTC_DS1742
 	bool "DS1742 BRAM/RTC support"
 	depends on TOSHIBA_JMR3927 || TOSHIBA_RBTX4927
@@ -1421,10 +1427,6 @@
 	  This will result in additional memory usage, so it is not
 	  recommended for normal users.
 
-config RWSEM_GENERIC_SPINLOCK
-	bool
-	default y
-
 endmenu
 
 menu "Bus options (PCI, PCMCIA, EISA, ISA, TC)"
Index: linux-2.6.11-rc2/include/asm-mips/linkage.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/linkage.h
+++ linux-2.6.11-rc2/include/asm-mips/linkage.h
@@ -1,6 +1,8 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
-/* Nothing to see here... */
+/* FASTCALL stuff */
+#define FASTCALL(x)	x
+#define fastcall
 
 #endif
Index: linux-2.6.11-rc2/arch/mips/kernel/i8259.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/kernel/i8259.c
+++ linux-2.6.11-rc2/arch/mips/kernel/i8259.c
@@ -31,7 +31,7 @@
  * moves to arch independent land
  */
 
-spinlock_t i8259A_lock = SPIN_LOCK_UNLOCKED;
+raw_spinlock_t i8259A_lock = RAW_SPIN_LOCK_UNLOCKED;
 
 static void end_8259A_irq (unsigned int irq)
 {
Index: linux-2.6.11-rc2/include/asm-mips/m48t35.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/m48t35.h
+++ linux-2.6.11-rc2/include/asm-mips/m48t35.h
@@ -6,7 +6,7 @@
 
 #include <linux/spinlock.h>
 
-extern spinlock_t rtc_lock;
+extern raw_spinlock_t rtc_lock;
 
 struct m48t35_rtc {
 	volatile u8	pad[0x7ff8];    /* starts at 0x7ff8 */
Index: linux-2.6.11-rc2/arch/mips/math-emu/cp1emu.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/math-emu/cp1emu.c
+++ linux-2.6.11-rc2/arch/mips/math-emu/cp1emu.c
@@ -1310,7 +1310,9 @@
 		if (sig)
 			break;
 
+		preempt_enable();
 		cond_resched();
+		preempt_disable();
 	} while (xcp->cp0_epc > prevepc);
 
 	/* SIGILL indicates a non-fpu instruction */
Index: linux-2.6.11-rc2/arch/mips/sibyte/sb1250/time.c
===================================================================
--- linux-2.6.11-rc2.orig/arch/mips/sibyte/sb1250/time.c
+++ linux-2.6.11-rc2/arch/mips/sibyte/sb1250/time.c
@@ -112,10 +112,12 @@
 		ll_timer_interrupt(irq, regs);
 	}
 
-	/*
-	 * every CPU should do profiling and process accouting
-	 */
-	ll_local_timer_interrupt(irq, regs);
+	if (cpu != 0) {
+		/*
+		 * every CPU should do profiling and process accouting
+		 */
+		ll_local_timer_interrupt(irq, regs);
+	}
 }
 
 /*
Index: linux-2.6.11-rc2/include/asm-mips/tlb.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/tlb.h
+++ linux-2.6.11-rc2/include/asm-mips/tlb.h
@@ -5,19 +5,28 @@
  * MIPS doesn't need any special per-pte or per-vma handling, except
  * we need to flush cache for area to be unmapped.
  */
+#ifdef CONFIG_PREEMPT_RT
+#define tlb_start_vma(tlb, vma)		do { } while (0)
+#else
 #define tlb_start_vma(tlb, vma) 				\
 	do {							\
 		if (!tlb->fullmm)				\
 			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
 	}  while (0)
+#endif
+
 #define tlb_end_vma(tlb, vma) do { } while (0)
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
 /*
  * .. because we flush the whole mm when it fills up.
  */
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
+#define tlb_flush(tlb)	flush_tlb_mm(tlb_mm(tlb))
 
+#ifdef CONFIG_PREEMPT_RT
+#include <asm-generic/tlb-simple.h>
+#else
 #include <asm-generic/tlb.h>
+#endif
 
 #endif /* __ASM_TLB_H */
Index: linux-2.6.11-rc2/include/asm-mips/dma.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/dma.h
+++ linux-2.6.11-rc2/include/asm-mips/dma.h
@@ -150,7 +150,7 @@
 
 #define DMA_AUTOINIT	0x10
 
-extern spinlock_t  dma_spin_lock;
+extern raw_spinlock_t  dma_spin_lock;
 
 static __inline__ unsigned long claim_dma_lock(void)
 {
Index: linux-2.6.11-rc2/include/asm-mips/i8259.h
===================================================================
--- linux-2.6.11-rc2.orig/include/asm-mips/i8259.h
+++ linux-2.6.11-rc2/include/asm-mips/i8259.h
@@ -19,7 +19,7 @@
 
 #include <asm/io.h>
 
-extern spinlock_t i8259A_lock;
+extern raw_spinlock_t raw_i8259A_lock;
 
 extern void init_i8259_irqs(void);
 

--a8Wt8u1KmwUX3Y2C--
