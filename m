Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTESKWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTESKWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:22:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51903 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S261801AbTESKWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:22:13 -0400
Date: Mon, 19 May 2003 12:30:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D4
In-Reply-To: <20030519032325.4ed2dea3.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0305191228090.6746-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 May 2003, Andrew Morton wrote:

> page1 is leaked.

doh, indeed. -D4 patch attached. It also fixes the line-wrap noticed by
Christoph Hellwig. Patch applies, compiles and boots fine.

	Ingo

--- linux/include/linux/futex.h.orig	
+++ linux/include/linux/futex.h	
@@ -5,7 +5,8 @@
 #define FUTEX_WAIT (0)
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
+#define FUTEX_REQUEUE (3)
 
-extern asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime);
+extern asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime, u32 __user *uaddr2);
 
 #endif
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -457,7 +457,7 @@ void mm_release(struct task_struct *tsk,
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0, tidptr);
-		sys_futex(tidptr, FUTEX_WAKE, 1, NULL);
+		sys_futex(tidptr, FUTEX_WAKE, 1, NULL, NULL);
 	}
 }
 
--- linux/kernel/compat.c.orig	
+++ linux/kernel/compat.c	
@@ -214,7 +214,7 @@ asmlinkage long compat_sys_sigprocmask(i
 extern long do_futex(unsigned long, int, int, unsigned long);
 
 asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
-		struct compat_timespec *utime)
+		struct compat_timespec *utime, u32 *uaddr2)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
@@ -224,7 +224,7 @@ asmlinkage long compat_sys_futex(u32 *ua
 			return -EFAULT;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
-	return do_futex((unsigned long)uaddr, op, val, timeout);
+	return do_futex((unsigned long)uaddr, op, val, timeout, (unsigned long)uaddr2);
 }
 
 asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit *rlim);
--- linux/kernel/futex.c.orig	
+++ linux/kernel/futex.c	
@@ -2,6 +2,9 @@
  *  Fast Userspace Mutexes (which I call "Futexes!").
  *  (C) Rusty Russell, IBM 2002
  *
+ *  Generalized futexes, futex requeueing, misc fixes by Ingo Molnar
+ *  (C) Copyright 2003 Red Hat Inc, All Rights Reserved
+ *
  *  Thanks to Ben LaHaise for yelling "hashed waitqueues" loudly
  *  enough at me, Linus for the original (flawed) idea, Matthew
  *  Kirkwood for proof-of-concept implementation.
@@ -9,9 +12,6 @@
  *  "The futexes are also cursed."
  *  "But they come in a choice of three flavours!"
  *
- *  Generalized futexes for every mapping type, Ingo Molnar, 2002
- *
- *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -216,6 +216,62 @@ static void futex_vcache_callback(vcache
 	spin_unlock(&futex_lock);
 }
 
+/*
+ * Requeue all waiters hashed on one physical page to another
+ * physical page.
+ */
+static int futex_requeue(unsigned long uaddr1, int offset1, unsigned long uaddr2, int offset2, int num)
+{
+	struct list_head *i, *next, *head1, *head2;
+	struct page *page1 = NULL, *page2 = NULL;
+	int ret = 0;
+
+	lock_futex_mm();
+
+	page1 = __pin_page(uaddr1 - offset1);
+	if (!page1)
+		goto out;
+	page2 = __pin_page(uaddr2 - offset2);
+	if (!page2)
+		goto out;
+
+	head1 = hash_futex(page1, offset1);
+	head2 = hash_futex(page2, offset2);
+
+	list_for_each_safe(i, next, head1) {
+		struct futex_q *this = list_entry(i, struct futex_q, list);
+
+		if (this->page == page1 && this->offset == offset1) {
+			list_del_init(i);
+			__detach_vcache(&this->vcache);
+			if (++ret <= num) {
+				wake_up_all(&this->waiters);
+				if (this->filp)
+					send_sigio(&this->filp->f_owner,
+							this->fd, POLL_IN);
+			} else {
+				unpin_page(this->page);
+				__pin_page_atomic (page2);
+				list_add_tail(i, head2);
+				__attach_vcache(&this->vcache, uaddr2,
+					current->mm, futex_vcache_callback);
+				this->offset = offset2;
+				this->page = page2;
+			}
+		}
+	}
+
+out:
+	unlock_futex_mm();
+
+	if (page1)
+		unpin_page(page1);
+	if (page2)
+		unpin_page(page2);
+
+	return ret;
+}
+
 static inline void __queue_me(struct futex_q *q, struct page *page,
 				unsigned long uaddr, int offset,
 				int fd, struct file *filp)
@@ -425,9 +481,9 @@ out:
 	return ret;
 }
 
-long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout)
+long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout, unsigned long uaddr2)
 {
-	unsigned long pos_in_page;
+	unsigned long pos_in_page, pos_in_page2;
 	int ret;
 
 	pos_in_page = uaddr % PAGE_SIZE;
@@ -443,6 +499,14 @@ long do_futex(unsigned long uaddr, int o
 	case FUTEX_WAKE:
 		ret = futex_wake(uaddr, pos_in_page, val);
 		break;
+	case FUTEX_REQUEUE:
+		pos_in_page2 = uaddr2 % PAGE_SIZE;
+
+		/* Must be "naturally" aligned */
+		if (pos_in_page2 % sizeof(u32))
+			return -EINVAL;
+		ret = futex_requeue(uaddr, pos_in_page, uaddr2, pos_in_page2, val);
+		break;
 	case FUTEX_FD:
 		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
 		ret = futex_fd(uaddr, pos_in_page, val);
@@ -453,7 +517,7 @@ long do_futex(unsigned long uaddr, int o
 	return ret;
 }
 
-asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime)
+asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime, u32 __user *uaddr2)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
@@ -463,7 +527,7 @@ asmlinkage long sys_futex(u32 __user *ua
 			return -EFAULT;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
-	return do_futex((unsigned long)uaddr, op, val, timeout);
+	return do_futex((unsigned long)uaddr, op, val, timeout, (unsigned long)uaddr2);
 }
 
 static struct super_block *

