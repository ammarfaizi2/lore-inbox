Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVGZS1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVGZS1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVGZSZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:25:21 -0400
Received: from kanga.kvack.org ([66.96.29.28]:46269 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261998AbVGZSYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:24:25 -0400
Date: Tue, 26 Jul 2005 14:25:01 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: [patch] unify x86/x86-64 semaphore code
Message-ID: <20050726182501.GA21883@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the common code in x86 and x86-64's semaphore.c into a 
single file in lib/semaphore-sleepers.c.  The arch specific asm stubs are 
left in the arch tree (in semaphore.c for i386 and in the asm for x86-64).  
There should be no changes in code/functionality with this patch.

Signed-off-by: Benjamin LaHaise <benjamin.c.lahaise@intel.com>
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -14,6 +14,10 @@ config X86
 	  486, 586, Pentiums, and various instruction-set-compatible chips by
 	  AMD, Cyrix, and others.
 
+config SEMAPHORE_SLEEPERS
+	bool
+	default y
+
 config MMU
 	bool
 	default y
diff --git a/arch/i386/kernel/semaphore.c b/arch/i386/kernel/semaphore.c
--- a/arch/i386/kernel/semaphore.c
+++ b/arch/i386/kernel/semaphore.c
@@ -13,171 +13,9 @@
  * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
  */
 #include <linux/config.h>
-#include <linux/sched.h>
-#include <linux/err.h>
-#include <linux/init.h>
 #include <asm/semaphore.h>
 
 /*
- * Semaphores are implemented using a two-way counter:
- * The "count" variable is decremented for each process
- * that tries to acquire the semaphore, while the "sleeping"
- * variable is a count of such acquires.
- *
- * Notably, the inline "up()" and "down()" functions can
- * efficiently test if they need to do any extra work (up
- * needs to do something only if count was negative before
- * the increment operation.
- *
- * "sleeping" and the contention routine ordering is protected
- * by the spinlock in the semaphore's waitqueue head.
- *
- * Note that these functions are only called when there is
- * contention on the lock, and as such all this is the
- * "non-critical" part of the whole semaphore business. The
- * critical part is the inline stuff in <asm/semaphore.h>
- * where we want to avoid any extra jumps and calls.
- */
-
-/*
- * Logic:
- *  - only on a boundary condition do we need to care. When we go
- *    from a negative count to a non-negative, we wake people up.
- *  - when we go from a non-negative count to a negative do we
- *    (a) synchronize with the "sleeper" count and (b) make sure
- *    that we're on the wakeup list before we synchronize so that
- *    we cannot lose wakeup events.
- */
-
-static fastcall void __attribute_used__  __up(struct semaphore *sem)
-{
-	wake_up(&sem->wait);
-}
-
-static fastcall void __attribute_used__ __sched __down(struct semaphore * sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-	unsigned long flags;
-
-	tsk->state = TASK_UNINTERRUPTIBLE;
-	spin_lock_irqsave(&sem->wait.lock, flags);
-	add_wait_queue_exclusive_locked(&sem->wait, &wait);
-
-	sem->sleepers++;
-	for (;;) {
-		int sleepers = sem->sleepers;
-
-		/*
-		 * Add "everybody else" into it. They aren't
-		 * playing, because we own the spinlock in
-		 * the wait_queue_head.
-		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
-			sem->sleepers = 0;
-			break;
-		}
-		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
-
-		spin_lock_irqsave(&sem->wait.lock, flags);
-		tsk->state = TASK_UNINTERRUPTIBLE;
-	}
-	remove_wait_queue_locked(&sem->wait, &wait);
-	wake_up_locked(&sem->wait);
-	spin_unlock_irqrestore(&sem->wait.lock, flags);
-	tsk->state = TASK_RUNNING;
-}
-
-static fastcall int __attribute_used__ __sched __down_interruptible(struct semaphore * sem)
-{
-	int retval = 0;
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-	unsigned long flags;
-
-	tsk->state = TASK_INTERRUPTIBLE;
-	spin_lock_irqsave(&sem->wait.lock, flags);
-	add_wait_queue_exclusive_locked(&sem->wait, &wait);
-
-	sem->sleepers++;
-	for (;;) {
-		int sleepers = sem->sleepers;
-
-		/*
-		 * With signals pending, this turns into
-		 * the trylock failure case - we won't be
-		 * sleeping, and we* can't get the lock as
-		 * it has contention. Just correct the count
-		 * and exit.
-		 */
-		if (signal_pending(current)) {
-			retval = -EINTR;
-			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
-			break;
-		}
-
-		/*
-		 * Add "everybody else" into it. They aren't
-		 * playing, because we own the spinlock in
-		 * wait_queue_head. The "-1" is because we're
-		 * still hoping to get the semaphore.
-		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
-			sem->sleepers = 0;
-			break;
-		}
-		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
-
-		spin_lock_irqsave(&sem->wait.lock, flags);
-		tsk->state = TASK_INTERRUPTIBLE;
-	}
-	remove_wait_queue_locked(&sem->wait, &wait);
-	wake_up_locked(&sem->wait);
-	spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-	tsk->state = TASK_RUNNING;
-	return retval;
-}
-
-/*
- * Trylock failed - make sure we correct for
- * having decremented the count.
- *
- * We could have done the trylock with a
- * single "cmpxchg" without failure cases,
- * but then it wouldn't work on a 386.
- */
-static fastcall int __attribute_used__ __down_trylock(struct semaphore * sem)
-{
-	int sleepers;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sem->wait.lock, flags);
-	sleepers = sem->sleepers + 1;
-	sem->sleepers = 0;
-
-	/*
-	 * Add "everybody else" and us into it. They aren't
-	 * playing, because we own the spinlock in the
-	 * wait_queue_head.
-	 */
-	if (!atomic_add_negative(sleepers, &sem->count)) {
-		wake_up_locked(&sem->wait);
-	}
-
-	spin_unlock_irqrestore(&sem->wait.lock, flags);
-	return 1;
-}
-
-
-/*
  * The semaphore operations have a special calling sequence that
  * allow us to do a simpler in-line version of them. These routines
  * need to convert that sequence back into the C sequence when
diff --git a/arch/um/Kconfig_i386 b/arch/um/Kconfig_i386
--- a/arch/um/Kconfig_i386
+++ b/arch/um/Kconfig_i386
@@ -6,6 +6,10 @@ config 64BIT
 	bool
 	default n
 
+config SEMAPHORE_SLEEPERS
+	bool
+	default y
+
 config TOP_ADDR
  	hex
  	default 0xc0000000 if !HOST_2G_2G
diff --git a/arch/um/Kconfig_x86_64 b/arch/um/Kconfig_x86_64
--- a/arch/um/Kconfig_x86_64
+++ b/arch/um/Kconfig_x86_64
@@ -6,6 +6,10 @@ config 64BIT
 	bool
 	default y
 
+config SEMAPHORE_SLEEPERS
+	bool
+	default y
+
 config TOP_ADDR
  	hex
 	default 0x80000000
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -24,6 +24,10 @@ config X86
 	bool
 	default y
 
+config SEMAPHORE_SLEEPERS
+	bool
+	default y
+
 config MMU
 	bool
 	default y
diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -4,7 +4,7 @@
 
 extra-y 	:= head.o head64.o init_task.o vmlinux.lds
 EXTRA_AFLAGS	:= -traditional
-obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
+obj-y	:= process.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
 		setup64.o bootflag.o e820.o reboot.o quirks.o
diff --git a/arch/x86_64/kernel/semaphore.c b/arch/x86_64/kernel/semaphore.c
deleted file mode 100644
--- a/arch/x86_64/kernel/semaphore.c
+++ /dev/null
@@ -1,180 +0,0 @@
-/*
- * x86_64 semaphore implementation.
- *
- * (C) Copyright 1999 Linus Torvalds
- *
- * Portions Copyright 1999 Red Hat, Inc.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
- */
-#include <linux/config.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <asm/errno.h>
-
-#include <asm/semaphore.h>
-
-/*
- * Semaphores are implemented using a two-way counter:
- * The "count" variable is decremented for each process
- * that tries to acquire the semaphore, while the "sleeping"
- * variable is a count of such acquires.
- *
- * Notably, the inline "up()" and "down()" functions can
- * efficiently test if they need to do any extra work (up
- * needs to do something only if count was negative before
- * the increment operation.
- *
- * "sleeping" and the contention routine ordering is protected
- * by the spinlock in the semaphore's waitqueue head.
- *
- * Note that these functions are only called when there is
- * contention on the lock, and as such all this is the
- * "non-critical" part of the whole semaphore business. The
- * critical part is the inline stuff in <asm/semaphore.h>
- * where we want to avoid any extra jumps and calls.
- */
-
-/*
- * Logic:
- *  - only on a boundary condition do we need to care. When we go
- *    from a negative count to a non-negative, we wake people up.
- *  - when we go from a non-negative count to a negative do we
- *    (a) synchronize with the "sleeper" count and (b) make sure
- *    that we're on the wakeup list before we synchronize so that
- *    we cannot lose wakeup events.
- */
-
-void __up(struct semaphore *sem)
-{
-	wake_up(&sem->wait);
-}
-
-void __sched __down(struct semaphore * sem)
-{
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-	unsigned long flags;
-
-	tsk->state = TASK_UNINTERRUPTIBLE;
-	spin_lock_irqsave(&sem->wait.lock, flags);
-	add_wait_queue_exclusive_locked(&sem->wait, &wait);
-
-	sem->sleepers++;
-	for (;;) {
-		int sleepers = sem->sleepers;
-
-		/*
-		 * Add "everybody else" into it. They aren't
-		 * playing, because we own the spinlock in
-		 * the wait_queue_head.
-		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
-			sem->sleepers = 0;
-			break;
-		}
-		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
-
-		spin_lock_irqsave(&sem->wait.lock, flags);
-		tsk->state = TASK_UNINTERRUPTIBLE;
-	}
-	remove_wait_queue_locked(&sem->wait, &wait);
-	wake_up_locked(&sem->wait);
-	spin_unlock_irqrestore(&sem->wait.lock, flags);
-	tsk->state = TASK_RUNNING;
-}
-
-int __sched __down_interruptible(struct semaphore * sem)
-{
-	int retval = 0;
-	struct task_struct *tsk = current;
-	DECLARE_WAITQUEUE(wait, tsk);
-	unsigned long flags;
-
-	tsk->state = TASK_INTERRUPTIBLE;
-	spin_lock_irqsave(&sem->wait.lock, flags);
-	add_wait_queue_exclusive_locked(&sem->wait, &wait);
-
-	sem->sleepers++;
-	for (;;) {
-		int sleepers = sem->sleepers;
-
-		/*
-		 * With signals pending, this turns into
-		 * the trylock failure case - we won't be
-		 * sleeping, and we* can't get the lock as
-		 * it has contention. Just correct the count
-		 * and exit.
-		 */
-		if (signal_pending(current)) {
-			retval = -EINTR;
-			sem->sleepers = 0;
-			atomic_add(sleepers, &sem->count);
-			break;
-		}
-
-		/*
-		 * Add "everybody else" into it. They aren't
-		 * playing, because we own the spinlock in
-		 * wait_queue_head. The "-1" is because we're
-		 * still hoping to get the semaphore.
-		 */
-		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
-			sem->sleepers = 0;
-			break;
-		}
-		sem->sleepers = 1;	/* us - see -1 above */
-		spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-		schedule();
-
-		spin_lock_irqsave(&sem->wait.lock, flags);
-		tsk->state = TASK_INTERRUPTIBLE;
-	}
-	remove_wait_queue_locked(&sem->wait, &wait);
-	wake_up_locked(&sem->wait);
-	spin_unlock_irqrestore(&sem->wait.lock, flags);
-
-	tsk->state = TASK_RUNNING;
-	return retval;
-}
-
-/*
- * Trylock failed - make sure we correct for
- * having decremented the count.
- *
- * We could have done the trylock with a
- * single "cmpxchg" without failure cases,
- * but then it wouldn't work on a 386.
- */
-int __down_trylock(struct semaphore * sem)
-{
-	int sleepers;
-	unsigned long flags;
-
-	spin_lock_irqsave(&sem->wait.lock, flags);
-	sleepers = sem->sleepers + 1;
-	sem->sleepers = 0;
-
-	/*
-	 * Add "everybody else" and us into it. They aren't
-	 * playing, because we own the spinlock in the
-	 * wait_queue_head.
-	 */
-	if (!atomic_add_negative(sleepers, &sem->count)) {
-		wake_up_locked(&sem->wait);
-	}
-
-	spin_unlock_irqrestore(&sem->wait.lock, flags);
-	return 1;
-}
-
-
diff --git a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -18,6 +18,7 @@ endif
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
+lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
diff --git a/lib/semaphore-sleepers.c b/lib/semaphore-sleepers.c
--- a/lib/semaphore-sleepers.c
+++ b/lib/semaphore-sleepers.c
@@ -0,0 +1,177 @@
+/*
+ * i386 and x86-64 semaphore implementation.
+ *
+ * (C) Copyright 1999 Linus Torvalds
+ *
+ * Portions Copyright 1999 Red Hat, Inc.
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
+ */
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <asm/semaphore.h>
+
+/*
+ * Semaphores are implemented using a two-way counter:
+ * The "count" variable is decremented for each process
+ * that tries to acquire the semaphore, while the "sleeping"
+ * variable is a count of such acquires.
+ *
+ * Notably, the inline "up()" and "down()" functions can
+ * efficiently test if they need to do any extra work (up
+ * needs to do something only if count was negative before
+ * the increment operation.
+ *
+ * "sleeping" and the contention routine ordering is protected
+ * by the spinlock in the semaphore's waitqueue head.
+ *
+ * Note that these functions are only called when there is
+ * contention on the lock, and as such all this is the
+ * "non-critical" part of the whole semaphore business. The
+ * critical part is the inline stuff in <asm/semaphore.h>
+ * where we want to avoid any extra jumps and calls.
+ */
+
+/*
+ * Logic:
+ *  - only on a boundary condition do we need to care. When we go
+ *    from a negative count to a non-negative, we wake people up.
+ *  - when we go from a non-negative count to a negative do we
+ *    (a) synchronize with the "sleeper" count and (b) make sure
+ *    that we're on the wakeup list before we synchronize so that
+ *    we cannot lose wakeup events.
+ */
+
+fastcall void __up(struct semaphore *sem)
+{
+	wake_up(&sem->wait);
+}
+
+fastcall void __sched __down(struct semaphore * sem)
+{
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+	unsigned long flags;
+
+	tsk->state = TASK_UNINTERRUPTIBLE;
+	spin_lock_irqsave(&sem->wait.lock, flags);
+	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+
+	sem->sleepers++;
+	for (;;) {
+		int sleepers = sem->sleepers;
+
+		/*
+		 * Add "everybody else" into it. They aren't
+		 * playing, because we own the spinlock in
+		 * the wait_queue_head.
+		 */
+		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+			sem->sleepers = 0;
+			break;
+		}
+		sem->sleepers = 1;	/* us - see -1 above */
+		spin_unlock_irqrestore(&sem->wait.lock, flags);
+
+		schedule();
+
+		spin_lock_irqsave(&sem->wait.lock, flags);
+		tsk->state = TASK_UNINTERRUPTIBLE;
+	}
+	remove_wait_queue_locked(&sem->wait, &wait);
+	wake_up_locked(&sem->wait);
+	spin_unlock_irqrestore(&sem->wait.lock, flags);
+	tsk->state = TASK_RUNNING;
+}
+
+fastcall int __sched __down_interruptible(struct semaphore * sem)
+{
+	int retval = 0;
+	struct task_struct *tsk = current;
+	DECLARE_WAITQUEUE(wait, tsk);
+	unsigned long flags;
+
+	tsk->state = TASK_INTERRUPTIBLE;
+	spin_lock_irqsave(&sem->wait.lock, flags);
+	add_wait_queue_exclusive_locked(&sem->wait, &wait);
+
+	sem->sleepers++;
+	for (;;) {
+		int sleepers = sem->sleepers;
+
+		/*
+		 * With signals pending, this turns into
+		 * the trylock failure case - we won't be
+		 * sleeping, and we* can't get the lock as
+		 * it has contention. Just correct the count
+		 * and exit.
+		 */
+		if (signal_pending(current)) {
+			retval = -EINTR;
+			sem->sleepers = 0;
+			atomic_add(sleepers, &sem->count);
+			break;
+		}
+
+		/*
+		 * Add "everybody else" into it. They aren't
+		 * playing, because we own the spinlock in
+		 * wait_queue_head. The "-1" is because we're
+		 * still hoping to get the semaphore.
+		 */
+		if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+			sem->sleepers = 0;
+			break;
+		}
+		sem->sleepers = 1;	/* us - see -1 above */
+		spin_unlock_irqrestore(&sem->wait.lock, flags);
+
+		schedule();
+
+		spin_lock_irqsave(&sem->wait.lock, flags);
+		tsk->state = TASK_INTERRUPTIBLE;
+	}
+	remove_wait_queue_locked(&sem->wait, &wait);
+	wake_up_locked(&sem->wait);
+	spin_unlock_irqrestore(&sem->wait.lock, flags);
+
+	tsk->state = TASK_RUNNING;
+	return retval;
+}
+
+/*
+ * Trylock failed - make sure we correct for
+ * having decremented the count.
+ *
+ * We could have done the trylock with a
+ * single "cmpxchg" without failure cases,
+ * but then it wouldn't work on a 386.
+ */
+fastcall int __down_trylock(struct semaphore * sem)
+{
+	int sleepers;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sem->wait.lock, flags);
+	sleepers = sem->sleepers + 1;
+	sem->sleepers = 0;
+
+	/*
+	 * Add "everybody else" and us into it. They aren't
+	 * playing, because we own the spinlock in the
+	 * wait_queue_head.
+	 */
+	if (!atomic_add_negative(sleepers, &sem->count)) {
+		wake_up_locked(&sem->wait);
+	}
+
+	spin_unlock_irqrestore(&sem->wait.lock, flags);
+	return 1;
+}
