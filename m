Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135213AbRDXKF4>; Tue, 24 Apr 2001 06:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbRDXKFg>; Tue, 24 Apr 2001 06:05:36 -0400
Received: from t2.redhat.com ([199.183.24.243]:41966 "EHLO
	warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132959AbRDXKF3>; Tue, 24 Apr 2001 06:05:29 -0400
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rw_semaphores, optimisations try #3 
In-Reply-To: Message from Linus Torvalds <torvalds@transmeta.com> 
   of "Mon, 23 Apr 2001 15:23:35 PDT." <Pine.LNX.4.31.0104231519120.13672-100000@penguin.transmeta.com> 
Date: Tue, 24 Apr 2001 11:05:20 +0100
Message-ID: <6182.988106720@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
> Note that the generic list structure already has support for "batching".
> It only does it for multiple adds right now (see the "list_splice"
> merging code), but there is nothing to stop people from doing it for
> multiple deletions too. The code is something like
> 
> 	static inline void list_remove_between(x,y)
> 	{
> 		n->next = y;
> 		y->prev = x;
> 	}
> 
> and notice how it's still just two unconditional stores for _any_ number
> of deleted entries.

Yes but the "struct rwsem_waiter" batch would have to be entirely deleted from
the list before any of them are woken, otherwise the waking processes may
destroy their "rwsem_waiter" blocks before they are dequeued (this destruction
is not guarded by a spinlock).

This would then reintroduce a second loop to find out which was the last block
we would be waking.

> Anyway, I've already applied your #2, how about a patch relative to that?

Attached.

David
=================================
diff -uNr linux-rwsem-opt2/include/linux/rwsem-spinlock.h linux/include/linux/rwsem-spinlock.h
--- linux-rwsem-opt2/include/linux/rwsem-spinlock.h	Tue Apr 24 10:51:58 2001
+++ linux/include/linux/rwsem-spinlock.h	Tue Apr 24 08:40:20 2001
@@ -1,6 +1,8 @@
 /* rwsem-spinlock.h: fallback C implementation
  *
  * Copyright (c) 2001   David Howells (dhowells@redhat.com).
+ * - Derived partially from ideas by Andrea Arcangeli <andrea@suse.de>
+ * - Derived also from comments by Linus
  */
 
 #ifndef _LINUX_RWSEM_SPINLOCK_H
@@ -11,6 +13,7 @@
 #endif
 
 #include <linux/spinlock.h>
+#include <linux/list.h>
 
 #ifdef __KERNEL__
 
@@ -19,14 +22,16 @@
 struct rwsem_waiter;
 
 /*
- * the semaphore definition
+ * the rw-semaphore definition
+ * - if activity is 0 then there are no active readers or writers
+ * - if activity is +ve then that is the number of active readers
+ * - if activity is -1 then there is one active writer
+ * - if wait_list is not empty, then there are processes waiting for the semaphore
  */
 struct rw_semaphore {
-	__u32			active;
-	__u32			waiting;
+	__s32			activity;
 	spinlock_t		wait_lock;
-	struct rwsem_waiter	*wait_front;
-	struct rwsem_waiter	**wait_back;
+	struct list_head	wait_list;
 #if RWSEM_DEBUG
 	int			debug;
 #endif
@@ -42,7 +47,7 @@
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ 0, 0, SPIN_LOCK_UNLOCKED, NULL, &(name).wait_front __RWSEM_DEBUG_INIT }
+{ 0, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) __RWSEM_DEBUG_INIT }
 
 #define DECLARE_RWSEM(name) \
 	struct rw_semaphore name = __RWSEM_INITIALIZER(name)
diff -uNr linux-rwsem-opt2/lib/rwsem-spinlock.c linux/lib/rwsem-spinlock.c
--- linux-rwsem-opt2/lib/rwsem-spinlock.c	Tue Apr 24 10:51:58 2001
+++ linux/lib/rwsem-spinlock.c	Tue Apr 24 08:40:20 2001
@@ -2,13 +2,15 @@
  *                                   implementation
  *
  * Copyright (c) 2001   David Howells (dhowells@redhat.com).
+ * - Derived partially from idea by Andrea Arcangeli <andrea@suse.de>
+ * - Derived also from comments by Linus
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/module.h>
 
 struct rwsem_waiter {
-	struct rwsem_waiter	*next;
+	struct list_head	list;
 	struct task_struct	*task;
 	unsigned int		flags;
 #define RWSEM_WAITING_FOR_READ	0x00000001
@@ -19,7 +21,8 @@
 void rwsemtrace(struct rw_semaphore *sem, const char *str)
 {
 	if (sem->debug)
-		printk("[%d] %s({%d,%d})\n",current->pid,str,sem->active,sem->waiting);
+		printk("[%d] %s({%d,%d})\n",
+		       current->pid,str,sem->activity,list_empty(&sem->wait_list)?0:1);
 }
 #endif
 
@@ -28,11 +31,9 @@
  */
 void init_rwsem(struct rw_semaphore *sem)
 {
-	sem->active = 0;
-	sem->waiting = 0;
+	sem->activity = 0;
 	spin_lock_init(&sem->wait_lock);
-	sem->wait_front = NULL;
-	sem->wait_back = &sem->wait_front;
+	INIT_LIST_HEAD(&sem->wait_list);
 #if RWSEM_DEBUG
 	sem->debug = 0;
 #endif
@@ -48,60 +49,58 @@
  */
 static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
 {
-	struct rwsem_waiter *waiter, *next;
-	int woken, loop;
+	struct rwsem_waiter *waiter;
+	int woken;
 
 	rwsemtrace(sem,"Entering __rwsem_do_wake");
 
-	waiter = sem->wait_front;
-
-	if (!waiter)
-	  goto list_unexpectedly_empty;
-
-	next = NULL;
+	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
 
 	/* try to grant a single write lock if there's a writer at the front of the queue
 	 * - we leave the 'waiting count' incremented to signify potential contention
 	 */
 	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {
-		sem->active++;
-		next = waiter->next;
+		sem->activity = -1;
+		list_del(&waiter->list);
 		waiter->flags = 0;
 		wake_up_process(waiter->task);
-		goto discard_woken_processes;
+		goto out;
 	}
 
 	/* grant an infinite number of read locks to the readers at the front of the queue */
 	woken = 0;
 	do {
-		woken++;
-		waiter = waiter->next;
-	} while (waiter && waiter->flags&RWSEM_WAITING_FOR_READ);
-
-	sem->active += woken;
-	sem->waiting -= woken;
-
-	waiter = sem->wait_front;
-	for (loop=woken; loop>0; loop--) {
-		next = waiter->next;
+		list_del(&waiter->list);
 		waiter->flags = 0;
 		wake_up_process(waiter->task);
-		waiter = next;
-	}
+		woken++;
+		if (list_empty(&sem->wait_list))
+			break;
+		waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
+	} while (waiter->flags&RWSEM_WAITING_FOR_READ);
 
- discard_woken_processes:
-	sem->wait_front = next;
-	if (!next) sem->wait_back = &sem->wait_front;
+	sem->activity += woken;
 
  out:
 	rwsemtrace(sem,"Leaving __rwsem_do_wake");
 	return sem;
+}
+
+/*
+ * wake a single writer
+ */
+static inline struct rw_semaphore *__rwsem_wake_one_writer(struct rw_semaphore *sem)
+{
+	struct rwsem_waiter *waiter;
+
+	sem->activity = -1;
 
- list_unexpectedly_empty:
-	printk("__rwsem_do_wake(): wait_list unexpectedly empty\n");
-	printk("[%d] %p = { %d, %d })\n",current->pid,sem,sem->active,sem->waiting);
-	BUG();
-	goto out;
+	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
+	list_del(&waiter->list);
+
+	waiter->flags = 0;
+	wake_up_process(waiter->task);
+	return sem;
 }
 
 /*
@@ -110,29 +109,27 @@
 void __down_read(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
-	struct task_struct *tsk = current;
+	struct task_struct *tsk;
 
 	rwsemtrace(sem,"Entering __down_read");
 
 	spin_lock(&sem->wait_lock);
 
-	if (!sem->waiting) {
+	if (sem->activity>=0 && list_empty(&sem->wait_list)) {
 		/* granted */
-		sem->active++;
+		sem->activity++;
 		spin_unlock(&sem->wait_lock);
 		goto out;
 	}
-	sem->waiting++;
 
+	tsk = current;
 	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	waiter.next = NULL;
 	waiter.task = tsk;
 	waiter.flags = RWSEM_WAITING_FOR_READ;
 
-	*sem->wait_back = &waiter; /* add to back of queue */
-	sem->wait_back = &waiter.next;
+	list_add_tail(&waiter.list,&sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
 	spin_unlock(&sem->wait_lock);
@@ -158,30 +155,27 @@
 void __down_write(struct rw_semaphore *sem)
 {
 	struct rwsem_waiter waiter;
-	struct task_struct *tsk = current;
+	struct task_struct *tsk;
 
 	rwsemtrace(sem,"Entering __down_write");
 
 	spin_lock(&sem->wait_lock);
 
-	if (!sem->waiting && !sem->active) {
+	if (sem->activity==0 && list_empty(&sem->wait_list)) {
 		/* granted */
-		sem->active++;
-		sem->waiting++;
+		sem->activity = -1;
 		spin_unlock(&sem->wait_lock);
 		goto out;
 	}
-	sem->waiting++;
 
+	tsk = current;
 	set_task_state(tsk,TASK_UNINTERRUPTIBLE);
 
 	/* set up my own style of waitqueue */
-	waiter.next = NULL;
 	waiter.task = tsk;
 	waiter.flags = RWSEM_WAITING_FOR_WRITE;
 
-	*sem->wait_back = &waiter; /* add to back of queue */
-	sem->wait_back = &waiter.next;
+	list_add_tail(&waiter.list,&sem->wait_list);
 
 	/* we don't need to touch the semaphore struct anymore */
 	spin_unlock(&sem->wait_lock);
@@ -209,8 +203,8 @@
 
 	spin_lock(&sem->wait_lock);
 
-	if (--sem->active==0 && sem->waiting)
-		__rwsem_do_wake(sem);
+	if (--sem->activity==0 && !list_empty(&sem->wait_list))
+		sem = __rwsem_wake_one_writer(sem);
 
 	spin_unlock(&sem->wait_lock);
 
@@ -226,9 +220,9 @@
 
 	spin_lock(&sem->wait_lock);
 
-	sem->waiting--;
-	if (--sem->active==0 && sem->waiting)
-		__rwsem_do_wake(sem);
+	sem->activity = 0;
+	if (!list_empty(&sem->wait_list))
+		sem = __rwsem_do_wake(sem);
 
 	spin_unlock(&sem->wait_lock);
 

