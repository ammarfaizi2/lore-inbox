Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUIJD1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUIJD1R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUIJDZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:25:51 -0400
Received: from ozlabs.org ([203.10.76.45]:9933 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267679AbUIJDYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:24:49 -0400
Date: Fri, 10 Sep 2004 13:23:13 +1000
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910032313.GJ11358@krispykreme>
References: <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <20040909154259.GE11358@krispykreme> <20040909171954.GW3106@holomorphy.com> <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> All in all, about four lines of code changes (+ some movement to make it 
> all saner)

How does this look?

- create in_lock_functions() to match in_sched_functions(). Export it
  for use in oprofile.
- use char __lock_text_start[] instead of long __lock_text_start when
  declaring linker symbols. Rusty fixed a number of these a while ago
  based on advice from rth.
- Move __preempt_*_lock into kernel/spinlock.c and make it inline. This
  means locks are only one deep.
- Make in_sched_functions() check in_lock_functions()

I apologise if I have broken any architectures.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/arm/kernel/time.c~spinlockfix arch/arm/kernel/time.c
--- compat_affinity/arch/arm/kernel/time.c~spinlockfix	2004-09-10 13:13:50.266767502 +1000
+++ compat_affinity-anton/arch/arm/kernel/time.c	2004-09-10 13:13:50.347761276 +1000
@@ -57,8 +57,7 @@ unsigned long profile_pc(struct pt_regs 
 {
 	unsigned long fp, pc = instruction_pointer(regs);
 
-	if (pc >= (unsigned long)&__lock_text_start &&
-	    pc <= (unsigned long)&__lock_text_end) {
+	if (in_lock_functions(pc)) {
 		fp = thread_saved_fp(current);
 		pc = pc_pointer(((unsigned long *)fp)[-1]);
 	}
diff -puN arch/i386/kernel/time.c~spinlockfix arch/i386/kernel/time.c
--- compat_affinity/arch/i386/kernel/time.c~spinlockfix	2004-09-10 13:13:50.272767040 +1000
+++ compat_affinity-anton/arch/i386/kernel/time.c	2004-09-10 13:13:50.349761122 +1000
@@ -205,8 +205,7 @@ unsigned long profile_pc(struct pt_regs 
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	if (pc >= (unsigned long)&__lock_text_start &&
-	    pc <= (unsigned long)&__lock_text_end)
+	if (in_lock_functions(pc))
 		return *(unsigned long *)(regs->ebp + 4);
 
 	return pc;
diff -puN arch/ppc/kernel/time.c~spinlockfix arch/ppc/kernel/time.c
--- compat_affinity/arch/ppc/kernel/time.c~spinlockfix	2004-09-10 13:13:50.278766579 +1000
+++ compat_affinity-anton/arch/ppc/kernel/time.c	2004-09-10 13:13:50.350761045 +1000
@@ -113,8 +113,7 @@ unsigned long profile_pc(struct pt_regs 
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	if (pc >= (unsigned long)&__lock_text_start &&
-	    pc <= (unsigned long)&__lock_text_end)
+	if (in_lock_functions(pc))
 		return regs->link;
 
 	return pc;
diff -puN arch/ppc64/kernel/rtasd.c~spinlockfix arch/ppc64/kernel/rtasd.c
diff -puN arch/ppc64/kernel/time.c~spinlockfix arch/ppc64/kernel/time.c
--- compat_affinity/arch/ppc64/kernel/time.c~spinlockfix	2004-09-10 13:13:50.290765657 +1000
+++ compat_affinity-anton/arch/ppc64/kernel/time.c	2004-09-10 13:13:50.353760815 +1000
@@ -163,8 +163,7 @@ unsigned long profile_pc(struct pt_regs 
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	if (pc >= (unsigned long)&__lock_text_start &&
-	    pc <= (unsigned long)&__lock_text_end)
+	if (in_lock_functions(pc))
 		return regs->link;
 
 	return pc;
diff -puN arch/sparc/kernel/time.c~spinlockfix arch/sparc/kernel/time.c
--- compat_affinity/arch/sparc/kernel/time.c~spinlockfix	2004-09-10 13:13:50.296765196 +1000
+++ compat_affinity-anton/arch/sparc/kernel/time.c	2004-09-10 13:13:50.355760661 +1000
@@ -81,20 +81,22 @@ struct intersil *intersil_clock;
 
 unsigned long profile_pc(struct pt_regs *regs)
 {
-	extern int __copy_user_begin, __copy_user_end;
-	extern int __atomic_begin, __atomic_end;
-	extern int __bzero_begin, __bzero_end;
-	extern int __bitops_begin, __bitops_end;
+	extern char __copy_user_begin[], __copy_user_end[];
+	extern char __atomic_begin[], __atomic_end[];
+	extern char __bzero_begin[], __bzero_end[];
+	extern char __bitops_begin[], __bitops_end[];
+
 	unsigned long pc = regs->pc;
 
-	if ((pc >= (unsigned long) &__copy_user_begin &&
-	     pc < (unsigned long) &__copy_user_end) ||
-	    (pc >= (unsigned long) &__atomic_begin &&
-	     pc < (unsigned long) &__atomic_end) ||
-	    (pc >= (unsigned long) &__bzero_begin &&
-	     pc < (unsigned long) &__bzero_end) ||
-	    (pc >= (unsigned long) &__bitops_begin &&
-	     pc < (unsigned long) &__bitops_end))
+	if (in_lock_functions(pc) ||
+	    (pc >= (unsigned long) __copy_user_begin &&
+	     pc < (unsigned long) __copy_user_end) ||
+	    (pc >= (unsigned long) __atomic_begin &&
+	     pc < (unsigned long) __atomic_end) ||
+	    (pc >= (unsigned long) __bzero_begin &&
+	     pc < (unsigned long) __bzero_end) ||
+	    (pc >= (unsigned long) __bitops_begin &&
+	     pc < (unsigned long) __bitops_end))
 		pc = regs->u_regs[UREG_RETPC];
 	return pc;
 }
diff -puN arch/sparc64/kernel/time.c~spinlockfix arch/sparc64/kernel/time.c
--- compat_affinity/arch/sparc64/kernel/time.c~spinlockfix	2004-09-10 13:13:50.302764735 +1000
+++ compat_affinity-anton/arch/sparc64/kernel/time.c	2004-09-10 13:13:50.358760430 +1000
@@ -73,8 +73,7 @@ unsigned long profile_pc(struct pt_regs 
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	if (pc >= (unsigned long)&__lock_text_start &&
-	    pc <= (unsigned long)&__lock_text_end)
+	if (in_lock_functions(pc))
 		return regs->u_regs[UREG_RETPC];
 	return pc;
 }
diff -puN arch/x86_64/kernel/time.c~spinlockfix arch/x86_64/kernel/time.c
--- compat_affinity/arch/x86_64/kernel/time.c~spinlockfix	2004-09-10 13:13:50.308764273 +1000
+++ compat_affinity-anton/arch/x86_64/kernel/time.c	2004-09-10 13:13:50.361760200 +1000
@@ -184,8 +184,7 @@ unsigned long profile_pc(struct pt_regs 
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	if (pc >= (unsigned long)&__lock_text_start &&
-	    pc <= (unsigned long)&__lock_text_end)
+	if (in_lock_functions(pc))
 		return *(unsigned long *)regs->rbp;
 	return pc;
 }
diff -puN include/linux/spinlock.h~spinlockfix include/linux/spinlock.h
--- compat_affinity/include/linux/spinlock.h~spinlockfix	2004-09-10 13:13:50.314763812 +1000
+++ compat_affinity-anton/include/linux/spinlock.h	2004-09-10 13:13:50.363760046 +1000
@@ -68,11 +68,11 @@ void __lockfunc _write_unlock_irqrestore
 void __lockfunc _write_unlock_irq(rwlock_t *lock);
 void __lockfunc _write_unlock_bh(rwlock_t *lock);
 int __lockfunc _spin_trylock_bh(spinlock_t *lock);
-
-extern unsigned long __lock_text_start;
-extern unsigned long __lock_text_end;
+int in_lock_functions(unsigned long addr);
 #else
 
+#define in_lock_functions(ADDR) 0
+
 #if !defined(CONFIG_PREEMPT) && !defined(CONFIG_DEBUG_SPINLOCK)
 # define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
 # define ATOMIC_DEC_AND_LOCK
diff -puN kernel/sched.c~spinlockfix kernel/sched.c
--- compat_affinity/kernel/sched.c~spinlockfix	2004-09-10 13:13:50.321763274 +1000
+++ compat_affinity-anton/kernel/sched.c	2004-09-10 13:13:50.373759277 +1000
@@ -4672,8 +4672,9 @@ int in_sched_functions(unsigned long add
 {
 	/* Linker adds these: start and end of __sched functions */
 	extern char __sched_text_start[], __sched_text_end[];
-	return addr >= (unsigned long)__sched_text_start
-		&& addr < (unsigned long)__sched_text_end;
+	return in_lock_functions(addr) ||
+		(addr >= (unsigned long)__sched_text_start
+		&& addr < (unsigned long)__sched_text_end);
 }
 
 void __init sched_init(void)
@@ -4765,49 +4766,3 @@ void __might_sleep(char *file, int line)
 }
 EXPORT_SYMBOL(__might_sleep);
 #endif
-
-
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
-/*
- * This could be a long-held lock.  If another CPU holds it for a long time,
- * and that CPU is not asked to reschedule then *this* CPU will spin on the
- * lock for a long time, even if *this* CPU is asked to reschedule.
- *
- * So what we do here, in the slow (contended) path is to spin on the lock by
- * hand while permitting preemption.
- *
- * Called inside preempt_disable().
- */
-void __sched __preempt_spin_lock(spinlock_t *lock)
-{
-	if (preempt_count() > 1) {
-		_raw_spin_lock(lock);
-		return;
-	}
-	do {
-		preempt_enable();
-		while (spin_is_locked(lock))
-			cpu_relax();
-		preempt_disable();
-	} while (!_raw_spin_trylock(lock));
-}
-
-EXPORT_SYMBOL(__preempt_spin_lock);
-
-void __sched __preempt_write_lock(rwlock_t *lock)
-{
-	if (preempt_count() > 1) {
-		_raw_write_lock(lock);
-		return;
-	}
-
-	do {
-		preempt_enable();
-		while (rwlock_is_locked(lock))
-			cpu_relax();
-		preempt_disable();
-	} while (!_raw_write_trylock(lock));
-}
-
-EXPORT_SYMBOL(__preempt_write_lock);
-#endif /* defined(CONFIG_SMP) && defined(CONFIG_PREEMPT) */
diff -puN kernel/spinlock.c~spinlockfix kernel/spinlock.c
--- compat_affinity/kernel/spinlock.c~spinlockfix	2004-09-10 13:13:50.326762890 +1000
+++ compat_affinity-anton/kernel/spinlock.c	2004-09-10 13:19:40.103522704 +1000
@@ -33,7 +33,32 @@ int __lockfunc _write_trylock(rwlock_t *
 }
 EXPORT_SYMBOL(_write_trylock);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PREEMPT)
+#ifdef CONFIG_PREEMPT
+/*
+ * This could be a long-held lock.  If another CPU holds it for a long time,
+ * and that CPU is not asked to reschedule then *this* CPU will spin on the
+ * lock for a long time, even if *this* CPU is asked to reschedule.
+ *
+ * So what we do here, in the slow (contended) path is to spin on the lock by
+ * hand while permitting preemption.
+ *
+ * Called inside preempt_disable().
+ */
+static inline void __preempt_spin_lock(spinlock_t *lock)
+{
+	if (preempt_count() > 1) {
+		_raw_spin_lock(lock);
+		return;
+	}
+
+	do {
+		preempt_enable();
+		while (spin_is_locked(lock))
+			cpu_relax();
+		preempt_disable();
+	} while (!_raw_spin_trylock(lock));
+}
+
 void __lockfunc _spin_lock(spinlock_t *lock)
 {
 	preempt_disable();
@@ -41,6 +66,21 @@ void __lockfunc _spin_lock(spinlock_t *l
 		__preempt_spin_lock(lock);
 }
 
+static inline void __preempt_write_lock(rwlock_t *lock)
+{
+	if (preempt_count() > 1) {
+		_raw_write_lock(lock);
+		return;
+	}
+
+	do {
+		preempt_enable();
+		while (rwlock_is_locked(lock))
+			cpu_relax();
+		preempt_disable();
+	} while (!_raw_write_trylock(lock));
+}
+
 void __lockfunc _write_lock(rwlock_t *lock)
 {
 	preempt_disable();
@@ -256,3 +296,13 @@ int __lockfunc _spin_trylock_bh(spinlock
 	return 0;
 }
 EXPORT_SYMBOL(_spin_trylock_bh);
+
+int in_lock_functions(unsigned long addr)
+{
+	/* Linker adds these: start and end of __lockfunc functions */
+	extern char __lock_text_start[], __lock_text_end[];
+
+	return addr >= (unsigned long)__lock_text_start
+	&& addr < (unsigned long)__lock_text_end;
+}
+EXPORT_SYMBOL(in_lock_functions);
_
