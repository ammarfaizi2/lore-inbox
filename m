Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282684AbRLBCur>; Sat, 1 Dec 2001 21:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282688AbRLBCuh>; Sat, 1 Dec 2001 21:50:37 -0500
Received: from zero.tech9.net ([209.61.188.187]:6924 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282684AbRLBCuW>;
	Sat, 1 Dec 2001 21:50:22 -0500
Subject: [PATCH] Preemptible kernel for SH
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: linuxsh-dev@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-Tukz68PADKhaLkBrCS82"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 01 Dec 2001 21:50:27 -0500
Message-Id: <1007261428.820.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tukz68PADKhaLkBrCS82
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached is the fully preemptible linux kernel patch, for the SH
arch.  This work is thanks to Jeremy Siegel of MontaVista.

You will need an SH-patched kernel tree, available from
http://sf.net/projects/linuxsh -- the CVS module "linux" has a drop-in
replacement for 2.4.16.

You will need the base preempt-kernel patch, available from
ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel

Feedback is desired.

	Robert Love

--=-Tukz68PADKhaLkBrCS82
Content-Disposition: attachment; filename=preempt-kernel-sh-2.4.16-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -urN linuxsh-2.4.14/arch/sh/config.in pass1/arch/sh/config.in
--- linuxsh-2.4.14/arch/sh/config.in	Fri Nov  9 13:16:54 2001
+++ pass1/arch/sh/config.in	Fri Nov  9 13:25:39 2001
@@ -124,6 +124,8 @@
    hex 'Physical memory start address' CONFIG_MEMORY_START 08000000
    hex 'Physical memory size' CONFIG_MEMORY_SIZE 00400000
 fi
+# Preemptible kernel feature
+bool 'Preemptible Kernel' CONFIG_PREEMPT
 endmenu
=20
 if [ "$CONFIG_SH_HP690" =3D "y" ]; then
diff -urN linuxsh-2.4.14/arch/sh/kernel/entry.S pass1/arch/sh/kernel/entry.=
S
--- linuxsh-2.4.14/arch/sh/kernel/entry.S	Fri Nov  9 13:16:54 2001
+++ pass1/arch/sh/kernel/entry.S	Fri Nov  9 14:15:30 2001
@@ -60,10 +60,18 @@
 /*
  * These are offsets into the task-struct.
  */
-flags		=3D  4
+preempt_count	=3D  4
 sigpending	=3D  8
 need_resched	=3D 20
 tsk_ptrace	=3D 24
+flags		=3D 84
+
+/*
+ * And these offsets are into irq_stat.
+ * (Find irq_cpustat_t in asm-sh/hardirq.h)
+ */
+local_irq_count =3D  8
+local_bh_count  =3D 12
=20
 PT_TRACESYS  =3D 0x00000002
 PF_USEDFPU   =3D 0x00100000
@@ -143,7 +151,7 @@
 	mov.l	__INV_IMASK, r11;	\
 	stc	sr, r10;		\
 	and	r11, r10;		\
-	stc	k_g_imask, r11;	\
+	stc	k_g_imask, r11;		\
 	or	r11, r10;		\
 	ldc	r10, sr
=20
@@ -304,8 +312,8 @@
 	mov.l	@(tsk_ptrace,r0), r0	! Is current PTRACE_SYSCALL'd?
 	mov	#PT_TRACESYS, r1
 	tst	r1, r0
-	bt	ret_from_syscall
-	bra	syscall_ret_trace
+	bf	syscall_ret_trace
+	bra	ret_from_syscall
 	 nop	=20
=20
 	.align	2
@@ -505,8 +513,6 @@
 	.long	syscall_ret_trace
 __syscall_ret:
 	.long	syscall_ret
-__INV_IMASK:
-	.long	0xffffff0f	! ~(IMASK)
=20
=20
 	.align	2
@@ -518,7 +524,84 @@
 	.align	2
 1:	.long	SYMBOL_NAME(schedule)
=20
+#ifdef CONFIG_PREEMPT=09
+	!
+	! Returning from interrupt during kernel mode: check if
+	! preempt_schedule should be called. If need_resched flag
+	! is set, preempt_count is zero, and we're not currently
+	! in an interrupt handler (local irq or bottom half) then
+	! call preempt_schedule.=20
+	!
+	! Increment preempt_count to prevent a nested interrupt
+	! from reentering preempt_schedule, then decrement after
+	! and drop through to regular interrupt return which will
+	! jump back and check again in case such an interrupt did
+	! come in (and didn't preempt due to preempt_count).
+	!
+	! NOTE:	because we just checked that preempt_count was
+	! zero before getting to the call, can't we use immediate
+	! values (1 and 0) rather than inc/dec? Also, rather than
+	! drop through to ret_from_irq, we already know this thread
+	! is kernel mode, can't we go direct to ret_from_kirq? In
+	! fact, with proper interrupt nesting and so forth could
+	! the loop simply be on the need_resched w/o checking the
+	! other stuff again? Optimize later...
+	!
+	.align	2
+ret_from_kirq:
+	! Nonzero preempt_count prevents scheduling
+	stc	k_current, r1
+	mov.l	@(preempt_count,r1), r0
+	cmp/eq	#0, r0
+	bf	restore_all
+	! Zero need_resched prevents scheduling
+	mov.l	@(need_resched,r1), r0
+	cmp/eq	#0, r0
+	bt	restore_all
+	! If in_interrupt(), don't schedule
+	mov.l	__irq_stat, r1
+	mov.l	@(local_irq_count,r1), r0
+	mov.l	@(local_bh_count,r1), r1
+	or	r1, r0
+	cmp/eq	#0, r0
+	bf	restore_all
+	! Allow scheduling using preempt_schedule
+	! Adjust preempt_count and SR as needed.
+	stc	k_current, r1
+	mov.l	@(preempt_count,r1), r0	! Could replace this ...
+	add	#1, r0			! ... and this w/mov #1?
+	mov.l	r0, @(preempt_count,r1)
+	STI()
+	mov.l	__preempt_schedule, r0
+	jsr	@r0
+	 nop=09
+	/* CLI */
+	stc	sr, r0
+	or	#0xf0, r0
+	ldc	r0, sr
+	!
+	stc	k_current, r1
+	mov.l	@(preempt_count,r1), r0	! Could replace this ...
+	add	#-1, r0			! ... and this w/mov #0?
+	mov.l	r0, @(preempt_count,r1)
+	! Maybe should bra ret_from_kirq, or loop over need_resched?
+	! For now, fall through to ret_from_irq again...
+#endif /* CONFIG_PREEMPT */
+=09
 ret_from_irq:
+	mov	#OFF_SR, r0
+	mov.l	@(r0,r15), r0	! get status register
+	shll	r0
+	shll	r0		! kernel space?
+#ifndef CONFIG_PREEMPT
+	bt	restore_all	! Yes, it's from kernel, go back soon
+#else /* CONFIG_PREEMPT */
+	bt	ret_from_kirq	! From kernel: maybe preempt_schedule
+#endif /* CONFIG_PREEMPT */
+	!
+	bra	ret_from_syscall
+	 nop
+
 ret_from_exception:
 	mov	#OFF_SR, r0
 	mov.l	@(r0,r15), r0	! get status register
@@ -564,6 +647,13 @@
 	.long	SYMBOL_NAME(do_signal)
 __irq_stat:
 	.long	SYMBOL_NAME(irq_stat)
+#ifdef CONFIG_PREEMPT
+__preempt_schedule:
+	.long	SYMBOL_NAME(preempt_schedule)
+#endif /* CONFIG_PREEMPT */=09
+__INV_IMASK:
+	.long	0xffffff0f	! ~(IMASK)
+
=20
 	.align 2
 restore_all:
@@ -679,7 +769,7 @@
 __fpu_prepare_fd:
 	.long	SYMBOL_NAME(fpu_prepare_fd)
 __init_task_flags:
-	.long	SYMBOL_NAME(init_task_union)+4
+	.long	SYMBOL_NAME(init_task_union)+flags
 __PF_USEDFPU:
 	.long	PF_USEDFPU
 #endif
diff -urN linuxsh-2.4.14/arch/sh/kernel/irq.c pass1/arch/sh/kernel/irq.c
--- linuxsh-2.4.14/arch/sh/kernel/irq.c	Fri Nov  9 13:16:54 2001
+++ pass1/arch/sh/kernel/irq.c	Fri Nov  9 14:22:07 2001
@@ -229,6 +229,16 @@
 	struct irqaction * action;
 	unsigned int status;
=20
+#ifdef CONFIG_PREEMPT
+	/*
+	 * At this point we're now about to actually call handlers,
+	 * and interrupts might get reenabled during them... bump
+	 * preempt_count to prevent any preemption while the handler
+	 * called here is pending...
+	 */
+	current->preempt_count +=3D 1;
+#endif /* CONFIG_PREEMPT */
+
 	/* Get IRQ number */
 	asm volatile("stc	r2_bank, %0\n\t"
 		     "shlr2	%0\n\t"
@@ -298,8 +308,19 @@
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
=20
+
 	if (softirq_pending(cpu))
 		do_softirq();
+
+#ifdef CONFIG_PREEMPT
+	/*
+	 * We're done with the handlers, interrupts should be
+	 * currently disabled; decrement preempt_count now so
+	 * as we return preemption may be allowed...
+	 */
+	current->preempt_count -=3D 1;
+#endif /* CONFIG_PREEMPT */
+
 	return 1;
 }
=20
diff -urN linuxsh-2.4.14/include/asm-sh/hardirq.h pass1/include/asm-sh/hard=
irq.h
--- linuxsh-2.4.14/include/asm-sh/hardirq.h	Fri Nov  9 13:16:02 2001
+++ pass1/include/asm-sh/hardirq.h	Fri Nov  9 13:38:34 2001
@@ -34,6 +34,8 @@
=20
 #define synchronize_irq()	barrier()
=20
+#define release_irqlock(cpu)	do { } while (0)
+
 #else
=20
 #error Super-H SMP is not available
diff -urN linuxsh-2.4.14/include/asm-sh/mmu_context.h pass1/include/asm-sh/=
mmu_context.h
--- linuxsh-2.4.14/include/asm-sh/mmu_context.h	Fri Nov  9 13:16:02 2001
+++ pass1/include/asm-sh/mmu_context.h	Fri Nov  9 14:30:40 2001
@@ -166,6 +166,10 @@
 				 struct mm_struct *next,
 				 struct task_struct *tsk, unsigned int cpu)
 {
+#ifdef CONFIG_PREEMPT
+	if (preempt_is_disabled() =3D=3D 0)
+		BUG();
+#endif
 	if (prev !=3D next) {
 		unsigned long __pgdir =3D (unsigned long)next->pgd;
=20
diff -urN linuxsh-2.4.14/include/asm-sh/smplock.h pass1/include/asm-sh/smpl=
ock.h
--- linuxsh-2.4.14/include/asm-sh/smplock.h	Fri Nov  9 13:16:02 2001
+++ pass1/include/asm-sh/smplock.h	Fri Nov  9 14:30:39 2001
@@ -9,15 +9,88 @@
=20
 #include <linux/config.h>
=20
-#ifndef CONFIG_SMP
-
+#if !defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT)
+/*
+ * Should never happen, since linux/smp_lock.h catches this case;
+ * but in case this file is included directly with neither SMP nor
+ * PREEMPT configuration, provide same dummys as linux/smp_lock.h
+ */
 #define lock_kernel()				do { } while(0)
 #define unlock_kernel()				do { } while(0)
-#define release_kernel_lock(task, cpu, depth)	((depth) =3D 1)
-#define reacquire_kernel_lock(task, cpu, depth)	do { } while(0)
+#define release_kernel_lock(task, cpu)		do { } while(0)
+#define reacquire_kernel_lock(task)		do { } while(0)
+#define kernel_locked()		1
+
+#else /* CONFIG_SMP || CONFIG_PREEMPT */
+
+#if CONFIG_SMP
+#error "We do not support SMP on SH yet"
+#endif
+/*
+ * Default SMP lock implementation (i.e. the i386 version)
+ */
+
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+extern spinlock_t kernel_flag;
+#define lock_bkl() spin_lock(&kernel_flag)
+#define unlock_bkl() spin_unlock(&kernel_flag)
=20
+#ifdef CONFIG_SMP
+#define kernel_locked()		spin_is_locked(&kernel_flag)
+#elif  CONFIG_PREEMPT
+#define kernel_locked()		preempt_is_disabled()
+#else  /* neither */
+#define kernel_locked()		1
+#endif
+
+/*
+ * Release global kernel lock and global interrupt lock
+ */
+#define release_kernel_lock(task, cpu) \
+do { \
+	if (task->lock_depth >=3D 0) \
+		spin_unlock(&kernel_flag); \
+	release_irqlock(cpu); \
+	__sti(); \
+} while (0)
+
+/*
+ * Re-acquire the kernel lock
+ */
+#define reacquire_kernel_lock(task) \
+do { \
+	if (task->lock_depth >=3D 0) \
+		spin_lock(&kernel_flag); \
+} while (0)
+
+/*
+ * Getting the big kernel lock.
+ *
+ * This cannot happen asynchronously,
+ * so we only need to worry about other
+ * CPU's.
+ */
+static __inline__ void lock_kernel(void)
+{
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth =3D=3D -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
 #else
-#error "We do not support SMP on SH"
-#endif /* CONFIG_SMP */
+	if (!++current->lock_depth)
+		spin_lock(&kernel_flag);
+#endif
+}
+
+static __inline__ void unlock_kernel(void)
+{
+	if (current->lock_depth < 0)
+		BUG();
+	if (--current->lock_depth < 0)
+		spin_unlock(&kernel_flag);
+}
+#endif /* CONFIG_SMP || CONFIG_PREEMPT */
=20
 #endif /* __ASM_SH_SMPLOCK_H */
diff -urN linuxsh-2.4.14/include/asm-sh/softirq.h pass1/include/asm-sh/soft=
irq.h
--- linuxsh-2.4.14/include/asm-sh/softirq.h	Fri Nov  9 13:16:02 2001
+++ pass1/include/asm-sh/softirq.h	Fri Nov  9 13:56:20 2001
@@ -6,6 +6,7 @@
=20
 #define local_bh_disable()			\
 do {						\
+	preempt_disable();			\
 	local_bh_count(smp_processor_id())++;	\
 	barrier();				\
 } while (0)
@@ -14,6 +15,7 @@
 do {						\
 	barrier();				\
 	local_bh_count(smp_processor_id())--;	\
+	preempt_enable();			\
 } while (0)
=20
 #define local_bh_enable()				\
@@ -22,6 +24,7 @@
 	if (!--local_bh_count(smp_processor_id())	\
 	    && softirq_pending(smp_processor_id())) {	\
 		do_softirq();				\
+	preempt_enable();				\
 	}						\
 } while (0)
=20

--=-Tukz68PADKhaLkBrCS82--

