Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADBxC>; Wed, 3 Jan 2001 20:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRADBwl>; Wed, 3 Jan 2001 20:52:41 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:48859 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S129267AbRADBwi>;
	Wed, 3 Jan 2001 20:52:38 -0500
Message-ID: <3A53D863.53203DF4@sun.com>
Date: Wed, 03 Jan 2001 17:56:52 -0800
From: ludovic fernandez <ludovic.fernandez@sun.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-prerelease: preemptive kernel.
Content-Type: multipart/mixed;
 boundary="------------F89FD2B25564B3E58A0F3653"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F89FD2B25564B3E58A0F3653
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

For hackers,
The following patch makes the kernel preemptable.
It is against 2.4.0-prerelease on for i386 only.
It should work for UP and SMP even though I
didn't validate it on SMP.
Comments are welcome.

NOTES: since the lock implementation is modified,
you need obviously to re-compile all your modules.
I introduced a dependency between spinlock.h and sched.h
and this has some bad side effects: Some files will
generate warnings during the compilation complaining
that disable_preempt()/enable_preempt() are not defined.
The warnings should be harmless but I was too lazy to
fix all of them. If the compilation fails because of
that, there is big chance to fix things by including
sched.h in the cfile.

Ludo.


--------------F89FD2B25564B3E58A0F3653
Content-Type: text/plain; charset=us-ascii;
 name="preempt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="preempt.patch"

diff -u --recursive linux-2.4-prerelease.org/arch/i386/kernel/apic.c linux-2.4-prerelease/arch/i386/kernel/apic.c
--- linux-2.4-prerelease.org/arch/i386/kernel/apic.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/arch/i386/kernel/apic.c	Wed Jan  3 12:58:57 2001
@@ -726,6 +726,7 @@
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter(cpu, 0);
+	disable_preempt();
 	smp_local_timer_interrupt(regs);
 	irq_exit(cpu, 0);
 }
@@ -746,6 +747,8 @@
 	if (v & (1 << (SPURIOUS_APIC_VECTOR & 0x1f)))
 		ack_APIC_irq();
 
+	disable_preempt();
+
 	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
 	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
 			smp_processor_id());
@@ -776,6 +779,9 @@
 	   6: Received illegal vector
 	   7: Illegal register address
 	*/
+
+	disable_preempt();
+
 	printk (KERN_ERR "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 }
diff -u --recursive linux-2.4-prerelease.org/arch/i386/kernel/entry.S linux-2.4-prerelease/arch/i386/kernel/entry.S
--- linux-2.4-prerelease.org/arch/i386/kernel/entry.S	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/arch/i386/kernel/entry.S	Wed Jan  3 12:58:57 2001
@@ -79,6 +79,8 @@
 need_resched	= 20
 tsk_ptrace	= 24
 processor	= 52
+preemptable = 56
+
 
 ENOSYS = 38
 
@@ -203,6 +205,9 @@
 	call *SYMBOL_NAME(sys_call_table)(,%eax,4)
 	movl %eax,EAX(%esp)		# save the return value
 ENTRY(ret_from_sys_call)
+	movl $1, %edx
+	lock
+	xaddl %edx, preemptable(%ebx)
 #ifdef CONFIG_SMP
 	movl processor(%ebx),%eax
 	shll $CONFIG_X86_L1_CACHE_SHIFT,%eax
@@ -213,13 +218,22 @@
 	testl SYMBOL_NAME(irq_stat)+4,%ecx	# softirq_mask
 #endif
 	jne   handle_softirq
-	
+	cmpl $0, %edx			# task is preemptable ?
+	jne check_signal
 ret_with_reschedule:
 	cmpl $0,need_resched(%ebx)
 	jne reschedule
+check_signal:
+#if 0	
+	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
+	movb CS(%esp), %al
+	testl $(VM_MASK | 3), %eax	# return to user mode ?
+	je restore_all			# no bypass signal check
+#endif	
 	cmpl $0,sigpending(%ebx)
 	jne signal_return
 restore_all:
+	decl preemptable(%ebx)	
 	RESTORE_ALL
 
 	ALIGN
@@ -270,14 +284,22 @@
 #endif
 	jne   handle_softirq
 
+/*
+ * ret_from_intr is the common path used to return
+ * from interruptions (either hard of soft) and exceptions.
+ * At that point the preemption is disabled 
+ * (see do_IRQ and handle_softirq)
+ * Reenable the preemption, verify that the current thread 
+ * is preemptable and check for a pending scheduling request.
+ */ 		
 ENTRY(ret_from_intr)
 	GET_CURRENT(%ebx)
-	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
-	movb CS(%esp),%al
-	testl $(VM_MASK | 3),%eax	# return to VM86 mode or non-supervisor?
-	jne ret_with_reschedule
-	jmp restore_all
-
+	cmpl $1, preemptable(%ebx)
+	jne  restore_all
+	cmpl $0, state(%ebx)		# current task is running ?
+	jne restore_all
+	jmp ret_with_reschedule
+	
 	ALIGN
 handle_softirq:
 	call SYMBOL_NAME(do_softirq)
@@ -286,6 +308,7 @@
 	ALIGN
 reschedule:
 	call SYMBOL_NAME(schedule)    # test
+	decl preemptable(%ebx)
 	jmp ret_from_sys_call
 
 ENTRY(divide_error)
@@ -316,6 +339,13 @@
 	movl %edx,%ds
 	movl %edx,%es
 	GET_CURRENT(%ebx)
+/*
+ * All exceptions are called with the preemption disabled.
+ * In addition, some of them (page_fault) are not reentrant 
+ * and need to be atomic until the preemption can be disabled.
+ */
+	incl preemptable(%ebx)
+	sti	
 	call *%edi
 	addl $8,%esp
 	jmp ret_from_exception
@@ -334,6 +364,7 @@
 	pushl $-1		# mark this as an int
 	SAVE_ALL
 	GET_CURRENT(%ebx)
+	incl preemptable(%ebx)
 	pushl $ret_from_exception
 	movl %cr0,%eax
 	testl $0x4,%eax			# EM (math emulation bit)
diff -u --recursive linux-2.4-prerelease.org/arch/i386/kernel/irq.c linux-2.4-prerelease/arch/i386/kernel/irq.c
--- linux-2.4-prerelease.org/arch/i386/kernel/irq.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/arch/i386/kernel/irq.c	Wed Jan  3 12:58:57 2001
@@ -564,6 +564,12 @@
 	unsigned int status;
 
 	kstat.irqs[cpu][irq]++;
+	/*
+	 * Disable preemption for the current task.
+	 * ret_from_intr will reenable the preemption and
+	 * check for a scheduling request.
+	 */
+	disable_preempt();
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*
diff -u --recursive linux-2.4-prerelease.org/arch/i386/kernel/smp.c linux-2.4-prerelease/arch/i386/kernel/smp.c
--- linux-2.4-prerelease.org/arch/i386/kernel/smp.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/arch/i386/kernel/smp.c	Wed Jan  3 12:58:57 2001
@@ -277,6 +277,8 @@
 {
 	unsigned long cpu = smp_processor_id();
 
+	disable_preempt();
+
 	if (!test_bit(cpu, &flush_cpumask))
 		return;
 		/* 
@@ -518,6 +520,7 @@
 asmlinkage void smp_reschedule_interrupt(void)
 {
 	ack_APIC_irq();
+	disable_preempt();
 }
 
 asmlinkage void smp_call_function_interrupt(void)
@@ -532,6 +535,7 @@
 	 * about to execute the function
 	 */
 	atomic_inc(&call_data->started);
+	disable_preempt();
 	/*
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
diff -u --recursive linux-2.4-prerelease.org/arch/i386/kernel/traps.c linux-2.4-prerelease/arch/i386/kernel/traps.c
--- linux-2.4-prerelease.org/arch/i386/kernel/traps.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/arch/i386/kernel/traps.c	Wed Jan  3 12:58:57 2001
@@ -958,7 +958,7 @@
 	set_trap_gate(11,&segment_not_present);
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
-	set_trap_gate(14,&page_fault);
+	set_intr_gate(14,&page_fault);
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
 	set_trap_gate(17,&alignment_check);
diff -u --recursive linux-2.4-prerelease.org/arch/i386/lib/dec_and_lock.c linux-2.4-prerelease/arch/i386/lib/dec_and_lock.c
--- linux-2.4-prerelease.org/arch/i386/lib/dec_and_lock.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/arch/i386/lib/dec_and_lock.c	Wed Jan  3 12:58:57 2001
@@ -9,6 +9,7 @@
 
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
+#include <linux/sched.h>
 
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
diff -u --recursive linux-2.4-prerelease.org/arch/i386/mm/fault.c linux-2.4-prerelease/arch/i386/mm/fault.c
--- linux-2.4-prerelease.org/arch/i386/mm/fault.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/arch/i386/mm/fault.c	Wed Jan  3 12:58:57 2001
@@ -112,6 +112,8 @@
 	unsigned long page;
 	unsigned long fixup;
 	int write;
+	int ret;
+
 	siginfo_t info;
 
 	/* get the address */
@@ -193,7 +195,17 @@
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	switch (handle_mm_fault(mm, vma, address, write)) {
+
+	/*
+	 * Re-enable the preemption before calling the generic handler.
+	 * This is rather for fun and to validate things a bit since
+	 * the mm semaphore is hold at that point and that can cause
+	 * a lot of contentions.
+	 */
+	enable_preempt();
+	ret = handle_mm_fault(mm, vma, address, write);
+	disable_preempt();
+	switch (ret) {
 	case 1:
 		tsk->min_flt++;
 		break;
diff -u --recursive linux-2.4-prerelease.org/drivers/pcmcia/ds.c linux-2.4-prerelease/drivers/pcmcia/ds.c
--- linux-2.4-prerelease.org/drivers/pcmcia/ds.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/drivers/pcmcia/ds.c	Wed Jan  3 12:58:57 2001
@@ -880,7 +880,16 @@
     int i, ret;
     
     DEBUG(0, "%s\n", version);
- 
+#if 1
+    /*
+     * I got some problems with PCMCIA initialization and a
+     * preemptive kernel;
+     * init_pcmcia_ds() beeing called before the completion
+     * of pending scheduled tasks. I don't know if this is the
+     * right fix though.
+     */
+    flush_scheduled_tasks();
+#endif
     /*
      * Ugly. But we want to wait for the socket threads to have started up.
      * We really should let the drivers themselves drive some of this..
diff -u --recursive linux-2.4-prerelease.org/include/asm-i386/smplock.h linux-2.4-prerelease/include/asm-i386/smplock.h
--- linux-2.4-prerelease.org/include/asm-i386/smplock.h	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/include/asm-i386/smplock.h	Wed Jan  3 17:29:36 2001
@@ -17,6 +17,7 @@
  */
 #define release_kernel_lock(task, cpu) \
 do { \
+	disable_preempt(); \
 	if (task->lock_depth >= 0) \
 		spin_unlock(&kernel_flag); \
 	release_irqlock(cpu); \
@@ -30,6 +31,7 @@
 do { \
 	if (task->lock_depth >= 0) \
 		spin_lock(&kernel_flag); \
+	enable_preempt(); \
 } while (0)
 
 
@@ -43,6 +45,7 @@
 extern __inline__ void lock_kernel(void)
 {
 #if 1
+	disable_preempt();
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
 #else
@@ -63,6 +66,7 @@
 #if 1
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
+	enable_preempt();
 #else
 	__asm__ __volatile__(
 		"decl %1\n\t"
diff -u --recursive linux-2.4-prerelease.org/include/asm-i386/softirq.h linux-2.4-prerelease/include/asm-i386/softirq.h
--- linux-2.4-prerelease.org/include/asm-i386/softirq.h	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/include/asm-i386/softirq.h	Wed Jan  3 14:21:58 2001
@@ -7,8 +7,10 @@
 #define cpu_bh_disable(cpu)	do { local_bh_count(cpu)++; barrier(); } while (0)
 #define cpu_bh_enable(cpu)	do { barrier(); local_bh_count(cpu)--; } while (0)
 
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
-#define local_bh_enable()	cpu_bh_enable(smp_processor_id())
+#define local_bh_disable()	\
+do { disable_preempt(); cpu_bh_disable(smp_processor_id()); } while (0)
+#define local_bh_enable()	\
+do { cpu_bh_enable(smp_processor_id()); enable_preempt(); } while (0)
 
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
diff -u --recursive linux-2.4-prerelease.org/include/asm-i386/spinlock.h linux-2.4-prerelease/include/asm-i386/spinlock.h
--- linux-2.4-prerelease.org/include/asm-i386/spinlock.h	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/include/asm-i386/spinlock.h	Wed Jan  3 14:21:58 2001
@@ -65,7 +65,7 @@
 #define spin_unlock_string \
 	"movb $1,%0"
 
-static inline int spin_trylock(spinlock_t *lock)
+static inline int _spin_trylock(spinlock_t *lock)
 {
 	char oldval;
 	__asm__ __volatile__(
@@ -75,7 +75,7 @@
 	return oldval > 0;
 }
 
-static inline void spin_lock(spinlock_t *lock)
+static inline void _spin_lock(spinlock_t *lock)
 {
 #if SPINLOCK_DEBUG
 	__label__ here;
@@ -90,7 +90,7 @@
 		:"=m" (lock->lock) : : "memory");
 }
 
-static inline void spin_unlock(spinlock_t *lock)
+static inline void _spin_unlock(spinlock_t *lock)
 {
 #if SPINLOCK_DEBUG
 	if (lock->magic != SPINLOCK_MAGIC)
@@ -143,7 +143,7 @@
  */
 /* the spinlock helpers are in arch/i386/kernel/semaphore.c */
 
-static inline void read_lock(rwlock_t *rw)
+static inline void _read_lock(rwlock_t *rw)
 {
 #if SPINLOCK_DEBUG
 	if (rw->magic != RWLOCK_MAGIC)
@@ -152,7 +152,7 @@
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
-static inline void write_lock(rwlock_t *rw)
+static inline void _write_lock(rwlock_t *rw)
 {
 #if SPINLOCK_DEBUG
 	if (rw->magic != RWLOCK_MAGIC)
@@ -161,8 +161,8 @@
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-#define read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
-#define write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
+#define _read_unlock(rw)	asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
+#define _write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
 
 static inline int write_trylock(rwlock_t *lock)
 {
diff -u --recursive linux-2.4-prerelease.org/include/asm-i386/system.h linux-2.4-prerelease/include/asm-i386/system.h
--- linux-2.4-prerelease.org/include/asm-i386/system.h	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/include/asm-i386/system.h	Wed Jan  3 14:21:58 2001
@@ -306,6 +306,13 @@
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()
 
+static inline int local_irq_are_enabled(void)
+{
+	unsigned long flags;
+	__save_flags(flags);
+	return (flags & 0x00000200);
+}
+
 #ifdef CONFIG_SMP
 
 extern void __global_cli(void);
diff -u --recursive linux-2.4-prerelease.org/include/linux/sched.h linux-2.4-prerelease/include/linux/sched.h
--- linux-2.4-prerelease.org/include/linux/sched.h	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/include/linux/sched.h	Wed Jan  3 15:31:41 2001
@@ -296,6 +296,7 @@
 	unsigned long policy;
 	struct mm_struct *mm;
 	int has_cpu, processor;
+	atomic_t preemptable;
 	unsigned long cpus_allowed;
 	/*
 	 * (only the 'next' pointer fits into the cacheline, but
@@ -443,6 +444,7 @@
     policy:		SCHED_OTHER,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
+    preemptable:	ATOMIC_INIT(0),					\
     cpus_allowed:	-1,						\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
     next_task:		&tsk,						\
@@ -524,6 +526,7 @@
 extern void free_uid(struct user_struct *);
 
 #include <asm/current.h>
+#include <asm/hardirq.h>
 
 extern unsigned long volatile jiffies;
 extern unsigned long itimer_ticks;
@@ -634,6 +637,41 @@
 {
 	return (current->sas_ss_size == 0 ? SS_DISABLE
 		: on_sig_stack(sp) ? SS_ONSTACK : 0);
+}
+
+static inline void disable_preempt(void)
+{
+	atomic_inc(&current->preemptable);
+}
+
+static inline void enable_preempt(void)
+{
+	if (atomic_read(&current->preemptable) <= 0) {
+		BUG();
+	}
+	if (atomic_read(&current->preemptable) == 1) {
+		/*
+		 * At that point a scheduling is healthy iff:
+		 * - a scheduling request is pending.
+		 * - the task is in running state.
+		 * - this is not an interrupt context.
+		 * - local interrupts are enabled.
+		 */
+		if (current->need_resched == 1     &&
+		    current->state == TASK_RUNNING &&
+		    !in_interrupt()                &&
+		    local_irq_are_enabled())
+		{
+			schedule();
+		}
+	}
+	atomic_dec(&current->preemptable);
+}	
+
+static inline int preemptable(void)
+{
+	return (!in_interrupt() && 
+		!atomic_read(&current->preemptable));
 }
 
 extern int request_irq(unsigned int,
diff -u --recursive linux-2.4-prerelease.org/include/linux/smp_lock.h linux-2.4-prerelease/include/linux/smp_lock.h
--- linux-2.4-prerelease.org/include/linux/smp_lock.h	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/include/linux/smp_lock.h	Wed Jan  3 17:30:04 2001
@@ -5,11 +5,37 @@
 
 #ifndef CONFIG_SMP
 
-#define lock_kernel()				do { } while(0)
-#define unlock_kernel()				do { } while(0)
-#define release_kernel_lock(task, cpu)		do { } while(0)
-#define reacquire_kernel_lock(task)		do { } while(0)
-#define kernel_locked() 1
+/*
+ * Release global kernel lock.
+ * Regarding preemption, this actually does the reverse -
+ */
+#define release_kernel_lock(task, cpu) \
+do { \
+	disable_preempt();  \
+} while (0)
+
+/*
+ * Re-acquire the kernel lock
+ * Re-enable the preemption - see comments above.
+ * Note: enable_preempt() cannot not be called at
+ * that point (otherwise schedule() becomes reentrant). 
+ */
+#define reacquire_kernel_lock(task) \
+do { \
+	atomic_dec(&current->preemptable); \
+} while (0)
+
+#define lock_kernel() \
+do { \
+	disable_preempt(); \
+} while(0); 
+
+#define unlock_kernel() \
+do { \
+	enable_preempt(); \
+} while (0)
+
+#define kernel_locked()	(!preemptable())
 
 #else
 
diff -u --recursive linux-2.4-prerelease.org/include/linux/spinlock.h linux-2.4-prerelease/include/linux/spinlock.h
--- linux-2.4-prerelease.org/include/linux/spinlock.h	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/include/linux/spinlock.h	Wed Jan  3 14:21:58 2001
@@ -3,33 +3,72 @@
 
 #include <linux/config.h>
 
+static inline void disable_preempt(void);
+static inline void enable_preempt(void);
+
 /*
  * These are the generic versions of the spinlocks and read-write
  * locks..
  */
-#define spin_lock_irqsave(lock, flags)		do { local_irq_save(flags);       spin_lock(lock); } while (0)
-#define spin_lock_irq(lock)			do { local_irq_disable();         spin_lock(lock); } while (0)
-#define spin_lock_bh(lock)			do { local_bh_disable();          spin_lock(lock); } while (0)
-
-#define read_lock_irqsave(lock, flags)		do { local_irq_save(flags);       read_lock(lock); } while (0)
-#define read_lock_irq(lock)			do { local_irq_disable();         read_lock(lock); } while (0)
-#define read_lock_bh(lock)			do { local_bh_disable();          read_lock(lock); } while (0)
-
-#define write_lock_irqsave(lock, flags)		do { local_irq_save(flags);      write_lock(lock); } while (0)
-#define write_lock_irq(lock)			do { local_irq_disable();        write_lock(lock); } while (0)
-#define write_lock_bh(lock)			do { local_bh_disable();         write_lock(lock); } while (0)
-
-#define spin_unlock_irqrestore(lock, flags)	do { spin_unlock(lock);  local_irq_restore(flags); } while (0)
-#define spin_unlock_irq(lock)			do { spin_unlock(lock);  local_irq_enable();       } while (0)
-#define spin_unlock_bh(lock)			do { spin_unlock(lock);  local_bh_enable();        } while (0)
-
-#define read_unlock_irqrestore(lock, flags)	do { read_unlock(lock);  local_irq_restore(flags); } while (0)
-#define read_unlock_irq(lock)			do { read_unlock(lock);  local_irq_enable();       } while (0)
-#define read_unlock_bh(lock)			do { read_unlock(lock);  local_bh_enable();        } while (0)
-
-#define write_unlock_irqrestore(lock, flags)	do { write_unlock(lock); local_irq_restore(flags); } while (0)
-#define write_unlock_irq(lock)			do { write_unlock(lock); local_irq_enable();       } while (0)
-#define write_unlock_bh(lock)			do { write_unlock(lock); local_bh_enable();        } while (0)
+#define spin_lock_irqsave(lock, flags)	\
+	do { disable_preempt(); local_irq_save(flags); _spin_lock(lock); } while (0)
+#define spin_lock_irq(lock) \
+	do { disable_preempt(); local_irq_disable(); _spin_lock(lock); } while (0)
+#define spin_lock_bh(lock) \
+	do { disable_preempt(); local_bh_disable(); _spin_lock(lock); } while (0)
+
+#define read_lock_irqsave(lock, flags) \
+	do { disable_preempt(); local_irq_save(flags); _read_lock(lock); } while (0)
+#define read_lock_irq(lock) \
+	do { disable_preempt(); local_irq_disable(); _read_lock(lock); } while (0)
+#define read_lock_bh(lock) \
+	do { disable_preempt(); local_bh_disable(); _read_lock(lock); } while (0)
+
+#define write_lock_irqsave(lock, flags)	\
+	do { disable_preempt(); local_irq_save(flags); _write_lock(lock); } while (0)
+#define write_lock_irq(lock) \
+	do { disable_preempt(); local_irq_disable(); _write_lock(lock); } while (0)
+#define write_lock_bh(lock) \
+	do { disable_preempt(); local_bh_disable(); _write_lock(lock); } while (0)
+
+#define spin_unlock_irqrestore(lock, flags) \
+	do { _spin_unlock(lock); local_irq_restore(flags); enable_preempt(); } while (0)
+#define spin_unlock_irq(lock) \
+	do { _spin_unlock(lock); local_irq_enable(); enable_preempt(); } while (0)
+#define spin_unlock_bh(lock) \
+	do { _spin_unlock(lock); local_bh_enable(); enable_preempt(); } while (0)
+
+#define read_unlock_irqrestore(lock, flags) \
+	do { _read_unlock(lock); local_irq_restore(flags); enable_preempt(); } while (0)
+#define read_unlock_irq(lock) \
+	do { _read_unlock(lock); local_irq_enable(); enable_preempt(); } while (0)
+#define read_unlock_bh(lock) \
+	do { _read_unlock(lock); local_bh_enable(); enable_preempt(); } while (0)
+
+#define write_unlock_irqrestore(lock, flags) \
+	do { _write_unlock(lock); local_irq_restore(flags); enable_preempt(); } while (0)
+#define write_unlock_irq(lock) \
+	do { _write_unlock(lock); local_irq_enable(); enable_preempt(); } while (0)
+#define write_unlock_bh(lock) \
+	do { _write_unlock(lock); local_bh_enable(); enable_preempt(); } while (0)
+
+#define spin_lock(lock) \
+	do { disable_preempt(); _spin_lock(lock); } while (0)
+#define spin_unlock(lock) \
+	do { _spin_unlock(lock); enable_preempt(); } while (0)
+#define spin_trylock(lock) \
+	({disable_preempt(); _spin_trylock(lock)? 1: (enable_preempt(), 0);})
+
+#define read_lock(lock) \
+	do { disable_preempt(); _read_lock(lock); } while (0)
+#define read_unlock(lock) \
+	do { _read_unlock(lock); enable_preempt(); } while (0)
+
+#define write_lock(lock) \
+	do { disable_preempt(); _write_lock(lock); } while (0)
+#define write_unlock(lock) \
+	do { _write_unlock(lock); enable_preempt(); } while (0)
+
 
 #ifdef CONFIG_SMP
 #include <asm/spinlock.h>
@@ -40,8 +79,6 @@
 
 #if (DEBUG_SPINLOCKS < 1)
 
-#define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
-
 /*
  * Your basic spinlocks, allowing only a single CPU anywhere
  *
@@ -56,11 +93,11 @@
 #endif
 
 #define spin_lock_init(lock)	do { } while(0)
-#define spin_lock(lock)		(void)(lock) /* Not "unused variable". */
+#define _spin_lock(lock)	(void)(lock) /* Not "unused variable". */
 #define spin_is_locked(lock)	(0)
-#define spin_trylock(lock)	({1; })
+#define _spin_trylock(lock)	({1; })
 #define spin_unlock_wait(lock)	do { } while(0)
-#define spin_unlock(lock)	do { } while(0)
+#define _spin_unlock(lock)	do { } while(0)
 
 #elif (DEBUG_SPINLOCKS < 2)
 
@@ -71,11 +108,11 @@
 
 #define spin_lock_init(x)	do { (x)->lock = 0; } while (0)
 #define spin_is_locked(lock)	(test_bit(0,(lock)))
-#define spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
+#define _spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
 
-#define spin_lock(x)		do { (x)->lock = 1; } while (0)
+#define _spin_lock(x)		do { (x)->lock = 1; } while (0)
 #define spin_unlock_wait(x)	do { } while (0)
-#define spin_unlock(x)		do { (x)->lock = 0; } while (0)
+#define _spin_unlock(x)		do { (x)->lock = 0; } while (0)
 
 #else /* (DEBUG_SPINLOCKS >= 2) */
 
@@ -90,11 +127,11 @@
 
 #define spin_lock_init(x)	do { (x)->lock = 0; } while (0)
 #define spin_is_locked(lock)	(test_bit(0,(lock)))
-#define spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
+#define _spin_trylock(lock)	(!test_and_set_bit(0,(lock)))
 
-#define spin_lock(x)		do {unsigned long __spinflags; save_flags(__spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_lock(%s:%p) already locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} (x)->lock = 1; restore_flags(__spinflags);} while (0)
+#define _spin_lock(x)		do {unsigned long __spinflags; save_flags(__spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_lock(%s:%p) already locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} (x)->lock = 1; restore_flags(__spinflags);} while (0)
 #define spin_unlock_wait(x)	do {unsigned long __spinflags; save_flags(__spinflags); cli(); if ((x)->lock&&(x)->babble) {printk("%s:%d: spin_unlock_wait(%s:%p) deadlock\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} restore_flags(__spinflags);} while (0)
-#define spin_unlock(x)		do {unsigned long __spinflags; save_flags(__spinflags); cli(); if (!(x)->lock&&(x)->babble) {printk("%s:%d: spin_unlock(%s:%p) not locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} (x)->lock = 0; restore_flags(__spinflags);} while (0)
+#define _spin_unlock(x)		do {unsigned long __spinflags; save_flags(__spinflags); cli(); if (!(x)->lock&&(x)->babble) {printk("%s:%d: spin_unlock(%s:%p) not locked\n", __BASE_FILE__,__LINE__, (x)->module, (x));(x)->babble--;} (x)->lock = 0; restore_flags(__spinflags);} while (0)
 
 #endif	/* DEBUG_SPINLOCKS */
 
@@ -119,10 +156,10 @@
 #endif
 
 #define rwlock_init(lock)	do { } while(0)
-#define read_lock(lock)		(void)(lock) /* Not "unused variable". */
-#define read_unlock(lock)	do { } while(0)
-#define write_lock(lock)	(void)(lock) /* Not "unused variable". */
-#define write_unlock(lock)	do { } while(0)
+#define _read_lock(lock)		(void)(lock) /* Not "unused variable". */
+#define _read_unlock(lock)	do { } while(0)
+#define _write_lock(lock)	(void)(lock) /* Not "unused variable". */
+#define _write_unlock(lock)	do { } while(0)
 
 #endif /* !SMP */
 
diff -u --recursive linux-2.4-prerelease.org/kernel/fork.c linux-2.4-prerelease/kernel/fork.c
--- linux-2.4-prerelease.org/kernel/fork.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/kernel/fork.c	Wed Jan  3 17:27:38 2001
@@ -622,6 +622,7 @@
 	}
 #endif
 	p->lock_depth = -1;		/* -1 = no lock */
+	atomic_set(&p->preemptable, 0);
 	p->start_time = jiffies;
 
 	retval = -ENOMEM;
diff -u --recursive linux-2.4-prerelease.org/kernel/sched.c linux-2.4-prerelease/kernel/sched.c
--- linux-2.4-prerelease.org/kernel/sched.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/kernel/sched.c	Wed Jan  3 13:53:17 2001
@@ -550,6 +550,16 @@
 			del_from_runqueue(prev);
 		case TASK_RUNNING:
 	}
+	/*
+	 * Check if the context switch is still necessary.
+	 * This catches up things like if (need_resched) schedule()
+	 * that is not atomic and open a window with a preemptive
+	 * kernel where a task can be scheduled twice.
+	 */
+	if (prev->need_resched == 0 && prev->state == TASK_RUNNING) {
+		spin_unlock_irq(&runqueue_lock);
+		goto same_process;
+	}
 	prev->need_resched = 0;
 
 	/*
@@ -1150,7 +1160,7 @@
 		printk(" %5d\n", p->p_osptr->pid);
 	else
 		printk("\n");
-
+	printk("    preemptable : %d\n", atomic_read(&p->preemptable));
 	{
 		struct sigqueue *q;
 		char s[sizeof(sigset_t)*2+1], b[sizeof(sigset_t)*2+1]; 
diff -u --recursive linux-2.4-prerelease.org/lib/dec_and_lock.c linux-2.4-prerelease/lib/dec_and_lock.c
--- linux-2.4-prerelease.org/lib/dec_and_lock.c	Wed Jan  3 17:19:44 2001
+++ linux-2.4-prerelease/lib/dec_and_lock.c	Wed Jan  3 12:58:58 2001
@@ -1,5 +1,6 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
+#include <linux/sched.h>
 
 /*
  * This is an architecture-neutral, but slow,

--------------F89FD2B25564B3E58A0F3653--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
