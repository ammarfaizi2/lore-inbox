Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTESMj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbTESMj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:39:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29666 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S262439AbTESMjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:39:53 -0400
Date: Mon, 19 May 2003 14:51:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
In-Reply-To: <Pine.LNX.4.44.0305191351570.9877-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0305191451300.10877-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


updated patch (the inlining changes were missing):

--- linux/include/linux/futex.h.orig	
+++ linux/include/linux/futex.h	
@@ -2,11 +2,13 @@
 #define _LINUX_FUTEX_H
 
 /* Second argument to futex syscall */
-#define FUTEX_WAIT (0)
-#define FUTEX_WAKE (1)
-#define FUTEX_FD (2)
-#define FUTEX_REQUEUE (3)
 
-extern asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime, u32 __user *uaddr2);
+asmlinkage long sys_futex_wait(u32 __user *__uaddr,int val,
+				struct timespec __user *utime);
+
+asmlinkage long sys_futex_wake(u32 __user *__uaddr, int val);
+
+asmlinkage long sys_futex_requeue(u32 __user *__uaddr1, u32 __user *__uaddr2,
+					int nr_wake);
 
 #endif
--- linux/arch/i386/kernel/entry.S.orig	
+++ linux/arch/i386/kernel/entry.S	
@@ -837,7 +837,7 @@ ENTRY(sys_call_table)
 	.long sys_fremovexattr
 	.long sys_tkill
 	.long sys_sendfile64
-	.long sys_futex		/* 240 */
+	.long old_futex		/* 240 */
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
@@ -865,6 +865,8 @@ ENTRY(sys_call_table)
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
- 
+	.long sys_futex_wait
+	.long sys_futex_wake
+	.long sys_futex_requeue		/* 270 */
  
 nr_syscalls=(.-sys_call_table)/4
--- linux/kernel/futex.c.orig	
+++ linux/kernel/futex.c	
@@ -98,13 +98,13 @@ static inline struct list_head *hash_fut
  *
  * Must be called with (and returns with) all futex-MM locks held.
  */
-static inline
-struct page *__pin_page_atomic (struct page *page)
+static inline struct page *__pin_page_atomic (struct page *page)
 {
 	if (!PageReserved(page))
 		get_page(page);
 	return page;
 }
+
 static struct page *__pin_page(unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
@@ -155,7 +155,7 @@ static inline void unpin_page(struct pag
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int futex_wake(unsigned long uaddr, int offset, int num)
+static inline int futex_wake(unsigned long uaddr, int offset, int num)
 {
 	struct list_head *i, *next, *head;
 	struct page *page;
@@ -220,7 +220,8 @@ static void futex_vcache_callback(vcache
  * Requeue all waiters hashed on one physical page to another
  * physical page.
  */
-static int futex_requeue(unsigned long uaddr1, int offset1, unsigned long uaddr2, int offset2, int num)
+static inline int futex_requeue(unsigned long uaddr1, int offset1,
+		unsigned long uaddr2, int offset2, int num)
 {
 	struct list_head *i, *next, *head1, *head2;
 	struct page *page1 = NULL, *page2 = NULL;
@@ -308,7 +309,7 @@ static inline int unqueue_me(struct fute
 	return ret;
 }
 
-static int futex_wait(unsigned long uaddr,
+static inline int futex_wait(unsigned long uaddr,
 		      int offset,
 		      int val,
 		      unsigned long time)
@@ -347,7 +348,7 @@ static int futex_wait(unsigned long uadd
 	 * The get_user() above might fault and schedule so we
 	 * cannot just set TASK_INTERRUPTIBLE state when queueing
 	 * ourselves into the futex hash. This code thus has to
-	 * rely on the FUTEX_WAKE code doing a wakeup after removing
+	 * rely on the futex_wake() code doing a wakeup after removing
 	 * the waiter from the list.
 	 */
 	add_wait_queue(&q.waiters, &wait);
@@ -481,9 +482,13 @@ out:
 	return ret;
 }
 
-long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout, unsigned long uaddr2)
+#define OLD_FUTEX_WAIT (0)
+#define OLD_FUTEX_WAKE (1)
+#define OLD_FUTEX_FD (2)
+
+static long do_old_futex(unsigned long uaddr, int op, int val, unsigned long timeout, unsigned long uaddr2)
 {
-	unsigned long pos_in_page, pos_in_page2;
+	unsigned long pos_in_page;
 	int ret;
 
 	pos_in_page = uaddr % PAGE_SIZE;
@@ -493,21 +498,13 @@ long do_futex(unsigned long uaddr, int o
 		return -EINVAL;
 
 	switch (op) {
-	case FUTEX_WAIT:
+	case OLD_FUTEX_WAIT:
 		ret = futex_wait(uaddr, pos_in_page, val, timeout);
 		break;
-	case FUTEX_WAKE:
+	case OLD_FUTEX_WAKE:
 		ret = futex_wake(uaddr, pos_in_page, val);
 		break;
-	case FUTEX_REQUEUE:
-		pos_in_page2 = uaddr2 % PAGE_SIZE;
-
-		/* Must be "naturally" aligned */
-		if (pos_in_page2 % sizeof(u32))
-			return -EINVAL;
-		ret = futex_requeue(uaddr, pos_in_page, uaddr2, pos_in_page2, val);
-		break;
-	case FUTEX_FD:
+	case OLD_FUTEX_FD:
 		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
 		ret = futex_fd(uaddr, pos_in_page, val);
 		break;
@@ -517,17 +514,63 @@ long do_futex(unsigned long uaddr, int o
 	return ret;
 }
 
-asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime, u32 __user *uaddr2)
+asmlinkage long old_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime, u32 __user *uaddr2)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 
-	if ((op == FUTEX_WAIT) && utime) {
+	if ((op == OLD_FUTEX_WAIT) && utime) {
 		if (copy_from_user(&t, utime, sizeof(t)) != 0)
 			return -EFAULT;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
-	return do_futex((unsigned long)uaddr, op, val, timeout, (unsigned long)uaddr2);
+	return do_old_futex((unsigned long)uaddr, op, val, timeout, (unsigned long)uaddr2);
+}
+
+asmlinkage long sys_futex_wait(u32 __user *__uaddr, int val, struct timespec __user *utime)
+{
+	unsigned long uaddr = (unsigned long)__uaddr;
+	unsigned long pos_in_page = uaddr % PAGE_SIZE;
+	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+	struct timespec t;
+
+	/* Must be "naturally" aligned */
+	if (pos_in_page % sizeof(u32))
+		return -EINVAL;
+
+	if (utime) {
+		if (copy_from_user(&t, utime, sizeof(t)) != 0)
+			return -EFAULT;
+		timeout = timespec_to_jiffies(&t) + 1;
+	}
+	return futex_wait(uaddr, pos_in_page, val, timeout);
+}
+
+asmlinkage long sys_futex_wake(u32 __user *__uaddr, int val)
+{
+	unsigned long uaddr = (unsigned long)__uaddr;
+	unsigned long pos_in_page = uaddr % PAGE_SIZE;
+
+	/* Must be "naturally" aligned */
+	if (pos_in_page % sizeof(u32))
+		return -EINVAL;
+
+	return futex_wake(uaddr, pos_in_page, val);
+}
+
+asmlinkage long sys_futex_requeue(u32 __user *__uaddr1,
+				u32 __user *__uaddr2, int nr_wake)
+{
+	unsigned long uaddr1 = (unsigned long)__uaddr1,
+			uaddr2 = (unsigned long)__uaddr2;
+	unsigned long pos_in_page1 = uaddr1 % PAGE_SIZE,
+			pos_in_page2 = uaddr2 % PAGE_SIZE;
+
+	/* Must be "naturally" aligned */
+	if ((pos_in_page1 | pos_in_page2) % sizeof(u32))
+		return -EINVAL;
+
+	return futex_requeue(uaddr1, pos_in_page1, uaddr2, pos_in_page2, nr_wake);
 }
 
 static struct super_block *
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -457,7 +457,7 @@ void mm_release(struct task_struct *tsk,
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0, tidptr);
-		sys_futex(tidptr, FUTEX_WAKE, 1, NULL, NULL);
+		sys_futex_wake(tidptr, 1);
 	}
 }
 

