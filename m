Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTETMp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 08:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTETMp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 08:45:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64139 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S263765AbTETMpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 08:45:46 -0400
Date: Tue, 20 May 2003 14:56:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] futex patches, futex-2.5.69-A2
In-Reply-To: <20030520105116.A4609@infradead.org>
Message-ID: <Pine.LNX.4.44.0305201412260.10571-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 May 2003, Christoph Hellwig wrote:

> On Tue, May 20, 2003 at 11:03:36AM +0200, Ingo Molnar wrote:
> > have you all gone nuts??? It's not an option to break perfectly working
> > binaries out there.
> 
> Of course it is.  Linux has enough problem problems due to past mainline
> stupidities, now we don't need to codify vendor braindamages aswell.  

it's not vendor braindamage. First, sys_futex() was pretty much given as
an API, contributed by IBM (Rusty) around 2.5.8, mainly for NGPT. The
sys_futex() API would have gone into 2.6.0 with flying colors as-is if
NPTL hadnt been around.

You probably wouldnt even have noticed this uncleanliness in the API, if
not for my requeue patch from yesterday. (which is another feature to make
futexes more useful, also driven by NPTL, not some evil ploy.)

face it, there will always be mistakes when creating APIs. But removing
them arbitrarily just makes the mistake worse, two mistakes do not make a
correct move.

most of the time we catch crap before it gets into the mainline kernel.  
Sometimes it takes months to notice, sometimes it takes years. I certainly
saw no-one complaining since sys_futex() went into 2.5.8 or so, more than
a year ago!

i'd be the last one to complain about some system-utility API being
changed, but here we are talking about tons of user installations.

> And it's a lot of time to 2.6 anyway, don't tell me Jakub isn't smart
> enough to get a glibc rpm out by then that works with the new and the
> old futex stuff.

you dont understand, do you? There are very valid and perfectly working
glibc installations [and maybe NGPT installations, futex users, etc.] out
there that will break if you remove sys_futex(). No amount of rpm hacking
will fix them up.

what do you think the reaction would have been, if half a year ago, when i
sent the first NPTL patches, i had started off by rewriting the
sys_futex() API and break the hell out of NGPT installations, just for the
fun of having a slightly cleaner API. We'd still be stuck with
LinuxThreads, i'm quite sure.

hell, this is 20 lines of code and no strings attached, and i've done all
the work already, it's not a big issue. So stop this purist crap ...

full futex patch against BK-curr attached: it fixes the page count leaks,
cleans up the code, splits up the futex ops into separate syscalls, keeps
the compatibility syscall and adds the requeueing feature. FUTEX_FD is
still fully supported. (and there's a sys_futex_fd syscall) (The patch
also fixes some leftover uaddr2 parameter passing present in the previous
patches.)

(the patch compiles, boots & works on x86/SMP, with NPTL enabled and
disabled as well.)

i think it might be more productive to put all this energy into comments
directed at the new APIs this patch adds.

Eg. is this alignment check the best one we can get? Is this particular
requeue API really the one we want? Plus now is the right time to add or
remove any functionality from the new syscalls. Next time around it will
be too late.

	Ingo

--- linux/include/linux/futex.h.orig	
+++ linux/include/linux/futex.h	
@@ -2,10 +2,15 @@
 #define _LINUX_FUTEX_H
 
 /* Second argument to futex syscall */
-#define FUTEX_WAIT (0)
-#define FUTEX_WAKE (1)
-#define FUTEX_FD (2)
 
-extern asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime);
+asmlinkage long sys_futex_wait(u32 __user *__uaddr,int val,
+				struct timespec __user *utime);
+
+asmlinkage long sys_futex_wake(u32 __user *__uaddr, int nr_wake);
+
+asmlinkage long sys_futex_fd(u32 __user *__uaddr, int signal);
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
@@ -865,6 +865,9 @@ ENTRY(sys_call_table)
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
- 
+	.long sys_futex_wait
+	.long sys_futex_wake
+	.long sys_futex_fd		/* 270 */
+	.long sys_futex_requeue
  
 nr_syscalls=(.-sys_call_table)/4
--- linux/kernel/compat.c.orig	
+++ linux/kernel/compat.c	
@@ -211,7 +211,7 @@ asmlinkage long compat_sys_sigprocmask(i
 	return ret;
 }
 
-extern long do_futex(unsigned long, int, int, unsigned long);
+extern long do_old_futex(unsigned long uaddr, int op, int val, unsigned long timeout);
 
 asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
 		struct compat_timespec *utime)
--- linux/kernel/fork.c.orig	
+++ linux/kernel/fork.c	
@@ -457,7 +457,7 @@ void mm_release(struct task_struct *tsk,
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0, tidptr);
-		sys_futex(tidptr, FUTEX_WAKE, 1, NULL);
+		sys_futex_wake(tidptr, 1);
 	}
 }
 
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
@@ -93,19 +93,18 @@ static inline struct list_head *hash_fut
 							FUTEX_HASHBITS)];
 }
 
-/* Waiter either waiting in FUTEX_WAIT or poll(), or expecting signal */
-static inline void tell_waiter(struct futex_q *q)
-{
-	wake_up_all(&q->waiters);
-	if (q->filp)
-		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
-}
-
 /*
  * Get kernel address of the user page and pin it.
  *
  * Must be called with (and returns with) all futex-MM locks held.
  */
+static inline struct page *__pin_page_atomic (struct page *page)
+{
+	if (!PageReserved(page))
+		get_page(page);
+	return page;
+}
+
 static struct page *__pin_page(unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
@@ -116,11 +115,8 @@ static struct page *__pin_page(unsigned 
 	 * Do a quick atomic lookup first - this is the fastpath.
 	 */
 	page = follow_page(mm, addr, 0);
-	if (likely(page != NULL)) {	
-		if (!PageReserved(page))
-			get_page(page);
-		return page;
-	}
+	if (likely(page != NULL))
+		return __pin_page_atomic(page);
 
 	/*
 	 * No luck - need to fault in the page:
@@ -150,16 +146,11 @@ repeat_lookup:
 	return page;
 }
 
-static inline void unpin_page(struct page *page)
-{
-	put_page(page);
-}
-
 /*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static int futex_wake(unsigned long uaddr, int offset, int num)
+static inline int futex_wake(unsigned long uaddr, int offset, int num)
 {
 	struct list_head *i, *next, *head;
 	struct page *page;
@@ -181,7 +172,9 @@ static int futex_wake(unsigned long uadd
 		if (this->page == page && this->offset == offset) {
 			list_del_init(i);
 			__detach_vcache(&this->vcache);
-			tell_waiter(this);
+			wake_up_all(&this->waiters);
+			if (this->filp)
+				send_sigio(&this->filp->f_owner, this->fd, POLL_IN);
 			ret++;
 			if (ret >= num)
 				break;
@@ -189,7 +182,7 @@ static int futex_wake(unsigned long uadd
 	}
 
 	unlock_futex_mm();
-	unpin_page(page);
+	put_page(page);
 
 	return ret;
 }
@@ -208,7 +201,9 @@ static void futex_vcache_callback(vcache
 	spin_lock(&futex_lock);
 
 	if (!list_empty(&q->list)) {
+		put_page(q->page);
 		q->page = new_page;
+		__pin_page_atomic(new_page);
 		list_del(&q->list);
 		list_add_tail(&q->list, head);
 	}
@@ -216,6 +211,63 @@ static void futex_vcache_callback(vcache
 	spin_unlock(&futex_lock);
 }
 
+/*
+ * Requeue all waiters hashed on one physical page to another
+ * physical page.
+ */
+static inline int futex_requeue(unsigned long uaddr1, int offset1,
+		unsigned long uaddr2, int offset2, int num)
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
+				put_page(this->page);
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
+		put_page(page1);
+	if (page2)
+		put_page(page2);
+
+	return ret;
+}
+
 static inline void __queue_me(struct futex_q *q, struct page *page,
 				unsigned long uaddr, int offset,
 				int fd, struct file *filp)
@@ -252,7 +304,7 @@ static inline int unqueue_me(struct fute
 	return ret;
 }
 
-static int futex_wait(unsigned long uaddr,
+static inline int futex_wait(unsigned long uaddr,
 		      int offset,
 		      int val,
 		      unsigned long time)
@@ -273,14 +325,17 @@ static int futex_wait(unsigned long uadd
 	}
 	__queue_me(&q, page, uaddr, offset, -1, NULL);
 
-	unlock_futex_mm();
-
-	/* Page is pinned, but may no longer be in this address space. */
+	/*
+	 * Page is pinned, but may no longer be in this address space.
+	 * It cannot schedule, so we access it with the spinlock held.
+	 */
 	if (get_user(curval, (int *)uaddr) != 0) {
+		unlock_futex_mm();
 		ret = -EFAULT;
 		goto out;
 	}
 	if (curval != val) {
+		unlock_futex_mm();
 		ret = -EWOULDBLOCK;
 		goto out;
 	}
@@ -288,13 +343,15 @@ static int futex_wait(unsigned long uadd
 	 * The get_user() above might fault and schedule so we
 	 * cannot just set TASK_INTERRUPTIBLE state when queueing
 	 * ourselves into the futex hash. This code thus has to
-	 * rely on the FUTEX_WAKE code doing a wakeup after removing
+	 * rely on the futex_wake() code doing a wakeup after removing
 	 * the waiter from the list.
 	 */
 	add_wait_queue(&q.waiters, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);
-	if (!list_empty(&q.list))
+	if (!list_empty(&q.list)) {
+		unlock_futex_mm();
 		time = schedule_timeout(time);
+	}
 	set_current_state(TASK_RUNNING);
 	/*
 	 * NOTE: we don't remove ourselves from the waitqueue because
@@ -310,7 +367,7 @@ out:
 	/* Were we woken up anyway? */
 	if (!unqueue_me(&q))
 		ret = 0;
-	unpin_page(page);
+	put_page(q.page);
 
 	return ret;
 }
@@ -320,7 +377,7 @@ static int futex_close(struct inode *ino
 	struct futex_q *q = filp->private_data;
 
 	unqueue_me(q);
-	unpin_page(q->page);
+	put_page(q->page);
 	kfree(filp->private_data);
 	return 0;
 }
@@ -416,11 +473,76 @@ static int futex_fd(unsigned long uaddr,
 	page = NULL;
 out:
 	if (page)
-		unpin_page(page);
+		put_page(page);
 	return ret;
 }
 
-long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout)
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
+asmlinkage long sys_futex_wake(u32 __user *__uaddr, int nr_wake)
+{
+	unsigned long uaddr = (unsigned long)__uaddr;
+	unsigned long pos_in_page = uaddr % PAGE_SIZE;
+
+	/* Must be "naturally" aligned */
+	if (pos_in_page % sizeof(u32))
+		return -EINVAL;
+
+	return futex_wake(uaddr, pos_in_page, nr_wake);
+}
+
+asmlinkage long sys_futex_fd(u32 __user *__uaddr, int signal)
+{
+	unsigned long uaddr = (unsigned long)__uaddr;
+	unsigned long pos_in_page = uaddr % PAGE_SIZE;
+
+	/* Must be "naturally" aligned */
+	if (pos_in_page % sizeof(u32))
+		return -EINVAL;
+
+	return futex_fd(uaddr, pos_in_page, signal);
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
+}
+
+/*
+ * Compatibility code:
+ */
+#define OLD_FUTEX_WAIT (0)
+#define OLD_FUTEX_WAKE (1)
+#define OLD_FUTEX_FD (2)
+
+long do_old_futex(unsigned long uaddr, int op, int val, unsigned long timeout)
 {
 	unsigned long pos_in_page;
 	int ret;
@@ -432,13 +554,13 @@ long do_futex(unsigned long uaddr, int o
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
-	case FUTEX_FD:
+	case OLD_FUTEX_FD:
 		/* non-zero val means F_SETOWN(getpid()) & F_SETSIG(val) */
 		ret = futex_fd(uaddr, pos_in_page, val);
 		break;
@@ -448,17 +570,17 @@ long do_futex(unsigned long uaddr, int o
 	return ret;
 }
 
-asmlinkage long sys_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime)
+asmlinkage long old_futex(u32 __user *uaddr, int op, int val, struct timespec __user *utime)
 {
 	struct timespec t;
 	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
 
-	if ((op == FUTEX_WAIT) && utime) {
+	if ((op == OLD_FUTEX_WAIT) && utime) {
 		if (copy_from_user(&t, utime, sizeof(t)) != 0)
 			return -EFAULT;
 		timeout = timespec_to_jiffies(&t) + 1;
 	}
-	return do_futex((unsigned long)uaddr, op, val, timeout);
+	return do_old_futex((unsigned long)uaddr, op, val, timeout);
 }
 
 static struct super_block *

