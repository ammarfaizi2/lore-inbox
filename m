Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVFNVsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFNVsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVFNVsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:48:52 -0400
Received: from kanga.kvack.org ([66.96.29.28]:39647 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261358AbVFNVs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:48:27 -0400
Date: Tue, 14 Jun 2005 17:50:22 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] aio_down() for i386 and x86_64
Message-ID: <20050614215022.GC21286@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

The patch below (which applies on top of the previous wait_private patch 
and the do_sync_(read|write) fix) introduces a new pair of primatives for 
semaphores: aio_down() and aio_up().  The aio_down() function takes an 
iocb and locks the semaphore for use within the iocb's context.  If taking 
the semaphore would block, aio_down() returns -EIOCBRETRY and will do an 
kick_iocb() on the iocb once the semaphore is acquired.

This is a first pass patch, so please ignore the debugging printk()s.  
Any comments on the approach?

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler

... v2.6.12-rc6-aio_down-A0.diff
diff -purN 10_wait_private/arch/i386/kernel/semaphore.c aio_down-rc6.diff/arch/i386/kernel/semaphore.c
--- 10_wait_private/arch/i386/kernel/semaphore.c	2005-06-13 02:07:54.000000000 -0400
+++ aio_down-rc6.diff/arch/i386/kernel/semaphore.c	2005-06-14 16:59:56.723150064 -0400
@@ -91,6 +91,55 @@ static fastcall void __attribute_used__ 
 	tsk->state = TASK_RUNNING;
 }
 
+static int aio_down_wait(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	struct kiocb *iocb = io_wait_to_kiocb(wait);
+	struct semaphore *sem = wait->private;
+	int sleepers = sem->sleepers;
+
+	printk("aio_down_wait(%p, %p): contended\n", sem, iocb);
+	/*
+	 * Add "everybody else" into it. They aren't
+	 * playing, because we own the spinlock in
+	 * the wait_queue_head.
+	 */
+	if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		printk("aio_down_wait: got it!\n");
+		sem->sleepers = 0;
+		sem->aio_owner = iocb;
+		list_del_init(&wait->task_list);
+		wake_up_locked(&sem->wait);
+		kick_iocb(iocb);
+		return 1;
+	}
+	sem->sleepers = 1;	/* us - see -1 above */
+
+	return 1;
+}
+
+static fastcall int __attribute_used__ __sched __aio_down(struct kiocb *iocb, struct semaphore * sem)
+{
+	unsigned long flags;
+
+	printk("aio_down(%p, %p): contended\n", sem, iocb);
+	if (sem->aio_owner == iocb) {
+		printk("aio_down: own lock\n");
+		atomic_inc(&sem->count);	/* undo dec in aio_down() */
+		return 0;
+	}
+
+	spin_lock_irqsave(&sem->wait.lock, flags);
+	iocb->ki_wait.private = sem;
+	iocb->ki_wait.func = aio_down_wait;
+	add_wait_queue_exclusive_locked(&sem->wait, &iocb->ki_wait);
+
+	sem->sleepers++;
+
+	aio_down_wait(&iocb->ki_wait, 0, 0, NULL);
+	spin_unlock_irqrestore(&sem->wait.lock, flags);
+	return -EIOCBRETRY;
+}
+
 static fastcall int __attribute_used__ __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
@@ -211,6 +260,28 @@ asm(
 asm(
 ".section .sched.text\n"
 ".align 4\n"
+".globl __aio_down_failed\n"
+"__aio_down_failed:\n\t"
+#if defined(CONFIG_FRAME_POINTER)
+	"pushl %ebp\n\t"
+	"movl  %esp,%ebp\n\t"
+#endif
+	"pushl %edx\n\t"
+	"pushl %ecx\n\t"
+	"call __aio_down\n\t"
+	"popl %ecx\n\t"
+	"popl %edx\n\t"
+#if defined(CONFIG_FRAME_POINTER)
+	"movl %ebp,%esp\n\t"
+	"popl %ebp\n\t"
+#endif
+	"ret"
+);
+EXPORT_SYMBOL(__aio_down_failed);
+
+asm(
+".section .sched.text\n"
+".align 4\n"
 ".globl __down_failed_interruptible\n"
 "__down_failed_interruptible:\n\t"
 #if defined(CONFIG_FRAME_POINTER)
diff -purN 10_wait_private/arch/x86_64/kernel/semaphore.c aio_down-rc6.diff/arch/x86_64/kernel/semaphore.c
--- 10_wait_private/arch/x86_64/kernel/semaphore.c	2005-06-13 02:07:56.000000000 -0400
+++ aio_down-rc6.diff/arch/x86_64/kernel/semaphore.c	2005-06-14 16:59:56.755145200 -0400
@@ -14,9 +14,8 @@
  */
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/err.h>
 #include <linux/init.h>
-#include <asm/errno.h>
-
 #include <asm/semaphore.h>
 
 /*
@@ -92,6 +91,55 @@ void __sched __down(struct semaphore * s
 	tsk->state = TASK_RUNNING;
 }
 
+static int aio_down_wait(wait_queue_t *wait, unsigned mode, int sync, void *key)
+{
+	struct kiocb *iocb = io_wait_to_kiocb(wait);
+	struct semaphore *sem = wait->private;
+	int sleepers = sem->sleepers;
+
+	printk("aio_down_wait(%p, %p): contended\n", sem, iocb);
+	/*
+	 * Add "everybody else" into it. They aren't
+	 * playing, because we own the spinlock in
+	 * the wait_queue_head.
+	 */
+	if (!atomic_add_negative(sleepers - 1, &sem->count)) {
+		printk("aio_down_wait: got it!\n");
+		sem->sleepers = 0;
+		sem->aio_owner = iocb;
+		list_del_init(&wait->task_list);
+		wake_up_locked(&sem->wait);
+		kick_iocb(iocb);
+		return 1;
+	}
+	sem->sleepers = 1;	/* us - see -1 above */
+
+	return 1;
+}
+
+long __aio_down(struct kiocb *iocb, struct semaphore * sem)
+{
+	unsigned long flags;
+
+	printk("aio_down(%p, %p): contended\n", sem, iocb);
+	if (sem->aio_owner == iocb) {
+		printk("aio_down: own lock\n");
+		atomic_inc(&sem->count);	/* undo dec in aio_down() */
+		return 0;
+	}
+
+	spin_lock_irqsave(&sem->wait.lock, flags);
+	iocb->ki_wait.private = sem;
+	iocb->ki_wait.func = aio_down_wait;
+	add_wait_queue_exclusive_locked(&sem->wait, &iocb->ki_wait);
+
+	sem->sleepers++;
+
+	aio_down_wait(&iocb->ki_wait, 0, 0, NULL);
+	spin_unlock_irqrestore(&sem->wait.lock, flags);
+	return -EIOCBRETRY;
+}
+
 int __sched __down_interruptible(struct semaphore * sem)
 {
 	int retval = 0;
diff -purN 10_wait_private/arch/x86_64/kernel/x8664_ksyms.c aio_down-rc6.diff/arch/x86_64/kernel/x8664_ksyms.c
--- 10_wait_private/arch/x86_64/kernel/x8664_ksyms.c	2005-06-13 02:07:56.000000000 -0400
+++ aio_down-rc6.diff/arch/x86_64/kernel/x8664_ksyms.c	2005-06-14 16:59:56.761144288 -0400
@@ -62,6 +62,7 @@ EXPORT_SYMBOL(pm_idle);
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);
 
+EXPORT_SYMBOL(__aio_down_failed);
 EXPORT_SYMBOL(__down_failed);
 EXPORT_SYMBOL(__down_failed_interruptible);
 EXPORT_SYMBOL(__down_failed_trylock);
diff -purN 10_wait_private/arch/x86_64/lib/thunk.S aio_down-rc6.diff/arch/x86_64/lib/thunk.S
--- 10_wait_private/arch/x86_64/lib/thunk.S	2004-12-24 16:34:44.000000000 -0500
+++ aio_down-rc6.diff/arch/x86_64/lib/thunk.S	2005-06-14 16:59:56.784140792 -0400
@@ -47,6 +47,7 @@
 	thunk __down_failed,__down
 	thunk_retrax __down_failed_interruptible,__down_interruptible
 	thunk_retrax __down_failed_trylock,__down_trylock
+	thunk_retrax __aio_down_failed,__aio_down
 	thunk __up_wakeup,__up
 	
 	/* SAVE_ARGS below is used only for the .cfi directives it contains. */
diff -purN 10_wait_private/include/asm-i386/semaphore.h aio_down-rc6.diff/include/asm-i386/semaphore.h
--- 10_wait_private/include/asm-i386/semaphore.h	2005-06-13 02:08:02.000000000 -0400
+++ aio_down-rc6.diff/include/asm-i386/semaphore.h	2005-06-14 16:59:56.787140336 -0400
@@ -41,10 +41,12 @@
 #include <linux/wait.h>
 #include <linux/rwsem.h>
 
+struct kiocb;
 struct semaphore {
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
+	struct kiocb *aio_owner;
 };
 
 
@@ -52,7 +54,8 @@ struct semaphore {
 {									\
 	.count		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
-	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+	.aio_owner	= NULL						\
 }
 
 #define __MUTEX_INITIALIZER(name) \
@@ -75,6 +78,7 @@ static inline void sema_init (struct sem
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
+	sem->aio_owner = NULL;
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -142,6 +146,32 @@ static inline int down_interruptible(str
 }
 
 /*
+ * Non-blockingly attempt to down() a semaphore for use with aio.
+ * Returns zero if we acquired it
+ */
+static inline int aio_down(struct kiocb *iocb, struct semaphore * sem)
+{
+	int result;
+
+	__asm__ __volatile__(
+		"# atomic aio down operation\n\t"
+		LOCK "decl %1\n\t"     /* --sem->count */
+		"js 2f\n\t"
+		"movl %3,%2\n"
+		"xorl %0,%0\n"
+		"1:\n"
+		LOCK_SECTION_START("")
+		"2:\tlea %1,%%edx\n\t"
+		"call __aio_down_failed\n\t"
+		"jmp 1b\n"
+		LOCK_SECTION_END
+		:"=a" (result), "+m" (sem->count), "=m" (sem->aio_owner)
+		:"0" (iocb)
+		:"memory","cc","dx");
+	return result;
+}
+
+/*
  * Non-blockingly attempt to down() a semaphore.
  * Returns zero if we acquired it
  */
@@ -190,5 +220,14 @@ static inline void up(struct semaphore *
 		:"memory","ax");
 }
 
+static inline void aio_up(struct kiocb *iocb, struct semaphore *sem)
+{
+#ifdef CONFIG_DEBUG_KERNEL
+	BUG_ON(sem->aio_owner != iocb);
+#endif
+	sem->aio_owner = NULL;
+	up(sem);
+}
+
 #endif
 #endif
diff -purN 10_wait_private/include/asm-x86_64/semaphore.h aio_down-rc6.diff/include/asm-x86_64/semaphore.h
--- 10_wait_private/include/asm-x86_64/semaphore.h	2004-12-24 16:33:48.000000000 -0500
+++ aio_down-rc6.diff/include/asm-x86_64/semaphore.h	2005-06-14 16:59:56.794139272 -0400
@@ -43,17 +43,20 @@
 #include <linux/rwsem.h>
 #include <linux/stringify.h>
 
+struct kiocb;
 struct semaphore {
 	atomic_t count;
 	int sleepers;
 	wait_queue_head_t wait;
+	struct kiocb *aio_owner;
 };
 
 #define __SEMAPHORE_INITIALIZER(name, n)				\
 {									\
 	.count		= ATOMIC_INIT(n),				\
 	.sleepers	= 0,						\
-	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)	\
+	.wait		= __WAIT_QUEUE_HEAD_INITIALIZER((name).wait),	\
+	.aio_owner	= NULL						\
 }
 
 #define __MUTEX_INITIALIZER(name) \
@@ -76,6 +79,7 @@ static inline void sema_init (struct sem
 	atomic_set(&sem->count, val);
 	sem->sleepers = 0;
 	init_waitqueue_head(&sem->wait);
+	sem->aio_owner = NULL;
 }
 
 static inline void init_MUTEX (struct semaphore *sem)
@@ -88,11 +92,13 @@ static inline void init_MUTEX_LOCKED (st
 	sema_init(sem, 0);
 }
 
+asmlinkage long __aio_down_failed(void /* special register calling convention */);
 asmlinkage void __down_failed(void /* special register calling convention */);
 asmlinkage int  __down_failed_interruptible(void  /* params in registers */);
 asmlinkage int  __down_failed_trylock(void  /* params in registers */);
 asmlinkage void __up_wakeup(void /* special register calling convention */);
 
+asmlinkage long __aio_down(struct kiocb *iocb, struct semaphore * sem);
 asmlinkage void __down(struct semaphore * sem);
 asmlinkage int  __down_interruptible(struct semaphore * sem);
 asmlinkage int  __down_trylock(struct semaphore * sem);
@@ -148,6 +154,32 @@ static inline int down_interruptible(str
 }
 
 /*
+ * Non-blockingly attempt to down() a semaphore for use with aio.
+ * Returns zero if we acquired it, -EIOCBRETRY if the operation was 
+ * queued and the iocb will receive a kick_iocb() on completion.
+ */
+static inline long aio_down(struct kiocb *iocb, struct semaphore * sem)
+{
+	long result;
+
+	__asm__ __volatile__(
+		"# atomic aio_down operation\n\t"
+		LOCK "decl %1\n\t"	/* --sem->count */
+		"js 2f\n\t"
+		"movq %3,%2\n"		/* sem->aio_owner = iocb */
+		"xorq %0,%0\n\t"
+		"1:\n"
+		LOCK_SECTION_START("")
+		"2:\tcall __aio_down_failed\n\t"
+		"jmp 1b\n"
+		LOCK_SECTION_END
+		:"=a" (result), "+m" (sem->count), "=m" (sem->aio_owner)
+		: "D" (iocb), "S" (sem)
+		:"memory");
+	return result;
+}
+
+/*
  * Non-blockingly attempt to down() a semaphore.
  * Returns zero if we acquired it
  */
@@ -192,5 +224,15 @@ static inline void up(struct semaphore *
 		:"D" (sem)
 		:"memory");
 }
+
+static inline void aio_up(struct kiocb *iocb, struct semaphore *sem)
+{
+#ifdef CONFIG_DEBUG_KERNEL
+	BUG_ON(sem->aio_owner != iocb);
+#endif
+	sem->aio_owner = NULL;
+	up(sem);
+}
+
 #endif /* __KERNEL__ */
 #endif
diff -purN 10_wait_private/mm/filemap.c aio_down-rc6.diff/mm/filemap.c
--- 10_wait_private/mm/filemap.c	2005-06-13 02:08:03.000000000 -0400
+++ aio_down-rc6.diff/mm/filemap.c	2005-06-14 17:22:10.530380544 -0400
@@ -2208,10 +2208,12 @@ ssize_t generic_file_aio_write(struct ki
 
 	BUG_ON(iocb->ki_pos != pos);
 
-	down(&inode->i_sem);
+	ret = aio_down(iocb, &inode->i_sem);
+	if (ret)
+		return ret;
 	ret = __generic_file_aio_write_nolock(iocb, &local_iov, 1,
 						&iocb->ki_pos);
-	up(&inode->i_sem);
+	aio_up(iocb, &inode->i_sem);
 
 	if (ret > 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
 		ssize_t err;
