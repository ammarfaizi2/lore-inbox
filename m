Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUHSCMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUHSCMA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUHSCMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:12:00 -0400
Received: from fmr05.intel.com ([134.134.136.6]:55525 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267958AbUHSCKj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:10:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: PATCH futex on fusyn 1/2: fusyn-2.3.1-00-misc-requeue.patch
Date: Wed, 18 Aug 2004 19:10:00 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F9423@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH futex on fusyn 1/2: fusyn-2.3.1-00-misc-requeue.patch
Thread-Index: AcR67KSkq2pUMRq9QeihuSVc82SjGgKme+MwAAK3kwA=
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Andrew Morton" <akpm@osdl.org>, <robustmutexes@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, "Ulrich Drepper" <drepper@redhat.com>
X-OriginalArrivalTime: 19 Aug 2004 02:10:06.0880 (UTC) FILETIME=[A5A19A00:01C48591]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add fuqueue_requeue support; fix silly mistakes; split
sys_ufuqueue_wait() to add in futex.c integration. 

 include/linux/fulock.h  |    5 -
 include/linux/fuqueue.h |   39 ++++++++++++
 include/linux/plist.h   |    2 
 kernel/fulock.c         |   16 ++---
 kernel/fuqueue.c        |   26 +++++++-
 kernel/ufulock.c        |    9 ++
 kernel/ufuqueue.c       |  146 +++++++++++++++++++++++++++++++++++++++++-------
 mm/vmscan.c             |    2 

 8 files changed, 206 insertions(+), 39 deletions(-)

diff -u -r1.1.2.82 -r1.1.2.83
--- linux/include/linux/fulock.h	20 Jul 2004 09:39:07 -0000
+++ linux/include/linux/fulock.h	6 Aug 2004 02:19:10 -0000
@@ -185,8 +185,7 @@
 extern void __fulock_unlock_unqueue (struct fulock *, struct fuqueue_waiter *,
 				     enum fulock_unlock_type);
 extern int __fulock_ctl (struct fulock *fulock, enum fulock_ctl ctl, void *);
-extern void __fulock_requeue (struct fuqueue *fuqueue,
-			      struct fulock *fulock, void *);
+extern void __fulock_requeue (struct fulock *, struct fuqueue *, void *);
 extern void __fulock_kill_message (struct fulock *);
 extern void exit_fulocks (struct task_struct *task);
 
@@ -268,7 +267,7 @@
 	spin_lock_irqsave (&fulock->fuqueue.lock, flags);
 	_raw_spin_lock (&fuqueue->lock);
 	if (!__fuqueue_empty (fuqueue))
-		__fulock_requeue (fuqueue, fulock, NULL);
+		__fulock_requeue (fulock, fuqueue, NULL);
 	_raw_spin_unlock (&fuqueue->lock);
 	spin_unlock_irqrestore (&fulock->fuqueue.lock, flags);
 }
diff -u -r1.1.2.48 -r1.1.2.49
--- linux/include/linux/fuqueue.h	19 Jul 2004 23:30:13 -0000
+++ linux/include/linux/fuqueue.h	6 Aug 2004 02:20:01 -0000
@@ -198,6 +198,8 @@
 /** Wait for a @fuqueue to be woken for as much as @timeout, @returns
  * wake up code */
 extern int fuqueue_wait (struct fuqueue *fuqueue, const struct timeout *);
+
+
 /**
  * Wait for a @fuqueue to be woken for as much as @timeout, @return
  * wake up code.
@@ -260,7 +262,7 @@
 
 
 /**
- * Wakes up a single waiter and cleans up it's task wait information.
+ * Unqueues a single waiter and cleans up it's task wait information.
  *
  * @returns 0 if the plist's priority didn't change, !0 otherwise.
  * 
@@ -361,6 +363,41 @@
 }
 
 
+extern void __fuqueue_waiter_requeue (struct fuqueue_waiter *w,
+				      struct fuqueue *fuqueue1,
+				      struct fuqueue *fuqueue0);
+
+/** Requeue all waiters from a @fuqueue0 to @fuqueue1. */
+static inline
+unsigned __fuqueue_requeue (struct fuqueue *fuqueue1,
+			    struct fuqueue *fuqueue0,
+			    size_t nr_wake)
+{
+	int prio_orig;
+	ftrace ("(%p, %p)\n", fuqueue0, fuqueue1);
+	
+	/*
+	 * FIXME: This sucks, is completely O(n) and slow as
+	 * hell--need to fix it in such a way so that just splicing
+	 * the waiter list [properly, not with the actual hack] does
+	 * it--the problem is that each waiter has a link to the
+	 * fuqueue it is waiting for...
+	 *
+	 * First step is to remove task->fuqueue_wait and embed it
+	 * into the fuqueue_waiter struct. This just moves it out of
+	 * the task_struct.
+	 */
+	prio_orig = plist_prio (&fuqueue1->wlist);
+	while (!__fuqueue_empty (fuqueue0))
+		__fuqueue_waiter_requeue (__fuqueue_first (fuqueue0),
+					  fuqueue1, fuqueue0);
+	plist_update_prio (&fuqueue0->wlist);
+	plist_update_prio (&fuqueue1->wlist);
+	if (nr_wake > 0)
+		__fuqueue_wake (fuqueue1, nr_wake, 0);
+	return prio_orig != plist_prio (&fuqueue1->wlist);
+}
+
 
 /** A waiting @task changed its priority, propagate it. */
 static inline
diff -u -r1.1.2.18 -r1.1.2.19
--- linux/include/linux/plist.h	20 Jul 2004 10:21:03 -0000
+++ linux/include/linux/plist.h	19 Aug 2004 00:27:23 -0000
@@ -251,7 +251,7 @@
 
 extern void __plist_splice (struct plist *dst, struct plist *src);
 
-/** Join @src plist to @src plist and reinitialise @src. @returns !0 */
+/** Join @src plist to @dst plist and reinitialise @dst. @returns !0 */
 static inline
 unsigned plist_splice_init (struct plist *dst, struct plist *src)
 {
diff -u -r1.1.2.96 -r1.1.2.97
--- linux/kernel/fulock.c	20 Jul 2004 09:40:17 -0000
+++ linux/kernel/fulock.c	6 Aug 2004 02:25:04 -0000
@@ -386,9 +386,9 @@
 /**
  * Requeue all waiters from a fuqueue to a fulock.
  *
- * @fuqueue:      Pointer to the fuqueue.
  * @fulock:	  Pointer to the fulock.
- * @fulock_flags: Flags for the fulock.
+ * @fuqueue:      Pointer to the fuqueue.
+ * @priv:         Private data for the fulock...
  * @returns: 0 if ok, < 0 errno code on error.
  *
  * We place all the waiters on the fuqueue in the ufulock's
@@ -404,8 +404,8 @@
  * Expects the fulock spinlocked, IRQs and preemption disabled. The
  * fuqueue should not be locked.
  */
-void __fulock_requeue (struct fuqueue *fuqueue,
-		       struct fulock *fulock, void *priv)
+void __fulock_requeue (struct fulock *fulock, struct fuqueue *fuqueue,
+		       void *priv)
 {
 	int code;
 	enum fulock_unlock_type unlock_type = FULOCK_UNLOCK_SERIAL;
@@ -414,11 +414,9 @@
 		container_of (fulock->fuqueue.ops, struct fulock_ops, fuqueue);
 	struct fuqueue_waiter *w;
 	
-	ftrace ("(%p, %p, %p)\n", fuqueue, fulock, priv);
-	
-	/* Move everybody, hop, hop! */
-	prio_changed = plist_splice_init (&fulock->fuqueue.wlist,
-					  &fuqueue->wlist);
+	ftrace ("(%p, %p, %p)\n", fulock, fuqueue, priv);
+
+	prio_changed = __fuqueue_requeue (&fulock->fuqueue, fuqueue, 0);
 	if (fulock->owner == NULL) {
 		/* Unlocked? Wake up the first guy */
 		w = __fuqueue_first (&fulock->fuqueue);
diff -u -r1.1.2.46 -r1.1.2.48
--- linux/kernel/fuqueue.c	19 Jul 2004 23:29:29 -0000
+++ linux/kernel/fuqueue.c	19 Aug 2004 00:36:19 -0000
@@ -12,8 +12,6 @@
  * see the doc in linux/fuqueue.h for some info.
  */
 
-#define DEBUG 8
-
 #include <linux/fuqueue.h>
 #include <linux/sched.h>
 #include <linux/plist.h>
@@ -123,6 +121,30 @@
 
 
 /**
+ * Move a waiter from fuqueue0 to fuqueue1
+ *
+ * FIXME: temporary, I hope this will not be that needed IANF
+ *
+ * Won't udpate fuqueue's wlist priorities!
+ * Needs both fuqueues locked!
+ */
+void __fuqueue_waiter_requeue (struct fuqueue_waiter *w,
+			       struct fuqueue *fuqueue1,
+			       struct fuqueue *fuqueue0)
+{
+	struct task_struct *task = w->task;
+	
+	ftrace ("(%p [%d])\n", w, w->task->pid);
+	
+	_raw_spin_lock (&task->fuqueue_wait_lock);
+	__plist_del (&w->wlist_node);
+	plist_add (&fuqueue1->wlist, &w->wlist_node);
+	task->fuqueue_wait = fuqueue1;
+	_raw_spin_unlock (&task->fuqueue_wait_lock);
+}
+
+
+/**
  * Wait for a @fuqueue to be woken for as much as @timeout, @returns
  * wake up code. See __fuqueue_waiter_block() for docs on @timeout.
  *
diff -u -r1.1.2.119 -r1.1.2.121
--- linux/kernel/ufulock.c	20 Jul 2004 09:33:52 -0000
+++ linux/kernel/ufulock.c	6 Aug 2004 02:25:41 -0000
@@ -874,6 +874,7 @@
  *  
  * USER CONTEXT ONLY
  */
+#warning FIXME: consistency: swap the order of fuqueue and fulock
 asmlinkage
 int sys_ufulock_requeue (volatile unsigned __user *_vfuqueue,
 			 unsigned val,
@@ -917,8 +918,12 @@
 	ufuqueue = container_of (vl_vfuqueue, struct ufuqueue, vlocator);
 
 	/* Map the vfulock area and sync the ufulock */
+retry:
 	spin_lock_irq (&ufulock->fulock.fuqueue.lock);
-	_raw_spin_lock (&ufuqueue->fuqueue.lock);
+	if (!_raw_spin_trylock (&ufuqueue->fuqueue.lock)) {	/* Spin dance... */
+		spin_unlock_irq (&ufulock->fulock.fuqueue.lock);
+		goto retry;
+	}
 	if (__fuqueue_empty (&ufuqueue->fuqueue))
 		goto out_spin_unlock;
 	vfulock = vfulock_kmap (page_vfulock, (unsigned long) _vfulock);
@@ -933,7 +938,7 @@
 	result = -EAGAIN;
 	if (value_vfuqueue == val) {
 		result = 0;
-		__fulock_requeue (&ufuqueue->fuqueue, &ufulock->fulock,
+		__fulock_requeue (&ufulock->fulock, &ufuqueue->fuqueue,
 				  (void *) vfulock);
 	}
 error_vfulock_sync:
diff -u -r1.1.2.24 -r1.1.2.26
--- linux/kernel/ufuqueue.c	18 Jul 2004 03:32:40 -0000
+++ linux/kernel/ufuqueue.c	19 Aug 2004 00:29:21 -0000
@@ -12,7 +12,6 @@
 
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/highmem.h>   /* kmap_atomic() */
 #include <linux/vlocator.h>
 #include <linux/fuqueue.h>
 #include <asm/uaccess.h>
@@ -96,9 +95,9 @@
  * This is just a thin shell that locates the kernel descriptors for
  * the fuqueue, places the timeout info in place, queues and blocks.
  */
-asmlinkage
-int sys_ufuqueue_wait (volatile unsigned __user *_vfuqueue, unsigned val,
-		       const struct timeout __user *_timeout)
+fastcall
+int ufuqueue_wait (volatile unsigned __user *_vfuqueue, unsigned val,
+		   const struct timeout *timeout)
 {
 	int result = -EINVAL;
 	struct ufuqueue *ufuqueue;
@@ -106,23 +105,10 @@
 	unsigned new_val;
 	struct vlocator *vl;
 	union vl_key key;
-	struct timeout *timeout, timeout_kernel;
 	struct fuqueue_waiter w = fuqueue_waiter_INIT (current);
 	struct mm_struct *mm = current->mm;
 	
-		
-	ftrace ("(%p, %x, %p)\n", _vfuqueue, val, _timeout);
-	might_sleep();
-
-	/* We are going to block on the ufuqueue, so get the timeout first */
-	if ((struct timeout *) _timeout == MAX_SCHEDULE_TIMEOUT_EXT)
-		timeout = MAX_SCHEDULE_TIMEOUT_EXT;
-	else {
-		result = -EFAULT;
-		timeout = &timeout_kernel;
-		if (copy_from_user (timeout, _timeout, sizeof (*timeout)))
-			goto error_copy;
-	}
+	ftrace ("(%p, %x, %p)\n", _vfuqueue, val, timeout);
 
 	/* Generate a key for the _vfuqueue, find the ufuqueue for it */
 	down_read (&mm->mmap_sem);
@@ -164,6 +150,45 @@
 	vl_page_put (page);
 error_key_create:
 	up_read (&mm->mmap_sem);
+	return result;
+}
+
+
+/**
+ * Wait on a fuqueue
+ *
+ * @_vfuqueue: address in user space
+ * @val: value of the _vfuqueue before we entered the kernel
+ * @_timeout: timeout information. ~0 means block for ever.
+ * 
+ * @returns: 0 if ok, < 0 errno code on error. If it returns
+ *           FUQUEUE_WAITER_GOT_LOCK (defined in linux/fuqueue.h) or
+ *           -EOWNERDEAD it means this fuqueue was requeued to a
+ *           fulock and when woken up, it has been assigned ownership
+ *           of the fulock.
+ *
+ * This is just a thin shell that locates the kernel descriptors for
+ * the fuqueue, places the timeout info in place, queues and blocks.
+ */
+asmlinkage
+int sys_ufuqueue_wait (volatile unsigned __user *_vfuqueue, unsigned val,
+		       const struct timeout __user *_timeout)
+{
+	int result = -EINVAL;
+	struct timeout *timeout, timeout_kernel;
+		
+	ftrace ("(%p, %x, %p)\n", _vfuqueue, val, _timeout);
+
+	/* We are going to block on the ufuqueue, so get the timeout first */
+	if ((struct timeout *) _timeout == MAX_SCHEDULE_TIMEOUT_EXT)
+		timeout = MAX_SCHEDULE_TIMEOUT_EXT;
+	else {
+		result = -EFAULT;
+		timeout = &timeout_kernel;
+		if (copy_from_user (timeout, _timeout, sizeof (*timeout)))
+			goto error_copy;
+	}
+	result = ufuqueue_wait (_vfuqueue, val, timeout);
 error_copy:
 	return result;
 }
@@ -189,7 +214,6 @@
 	struct ufuqueue *ufuqueue;
 	
 	ftrace ("(%p, %u)\n", _vfuqueue, howmany);
-	might_sleep();
 	
 	/* Generate a key for the _vfuqueue, find the ufuqueue for it */
 	down_read (&mm->mmap_sem);
@@ -212,9 +236,91 @@
 error_key_create:
 	up_read (&mm->mmap_sem);
 	return result;
-}
+}	
 
+
+/**
+ * Requeue all waiters from a fuqueue0 to fuqueue1
+ *
+ * FIXME
+ *  
+ * USER CONTEXT ONLY
+ */
+asmlinkage
+int sys_ufuqueue_requeue (volatile unsigned __user *_vfuqueue1,
+			  volatile unsigned __user *_vfuqueue0,
+			  unsigned val0,
+			  size_t nr_wake, int do_cmp)
+{
+	int result;
+	struct mm_struct *mm = current->mm;
+	struct page *page[2];
+	union vl_key key[2];
+	struct vlocator *vl[2];
+	struct ufuqueue *ufuqueue[2];
+	unsigned val0_new;
 	
+	ftrace ("(%p, %u, %p)\n", _vfuqueue0, val0, _vfuqueue1);
+
+	down_read (&mm->mmap_sem);
+
+	/* Generate a key for the _vfuqueue1, find the ufuqueue for it */
+	result = vl_key_create (&page[1], &key[1], current,
+				(unsigned long) _vfuqueue1);
+	if (unlikely (result < 0))
+		goto error_1_key_create;
+	result = vl_find_or_create (&vl[1], &key[1], &ufuqueue_vl_ops, 0);
+	if (unlikely (result < 0))
+		goto error_1_find;
+	ufuqueue[1] = container_of (vl[1], struct ufuqueue, vlocator);
+
+	/* Generate a key for the _vfuqueue0, find the ufuqueue for it */
+	result = vl_key_create (&page[0], &key[0], current,
+				(unsigned long) _vfuqueue0);
+	if (unlikely (result < 0))
+		goto error_0_key_create;
+	result = vl_find (&vl[0], &key[0], &ufuqueue_vl_ops);
+	if (unlikely (result < 0))
+		goto error_0_find;
+	ufuqueue[0] = container_of (vl[0], struct ufuqueue, vlocator);
+
+retry:
+	spin_lock_irq (&ufuqueue[0]->fuqueue.lock);
+	if (__fuqueue_empty (&ufuqueue[0]->fuqueue))
+		goto out_spin_unlock;
+	if (!_raw_spin_trylock (&ufuqueue[1]->fuqueue.lock)) {	/* Spin dance... */
+		spin_unlock_irq (&ufuqueue[0]->fuqueue.lock);
+		goto retry;
+	}
+	/* The page is pinned in memory, so we can get_user() without
+	 * atomicity issues--as well, we are sure it is mapped, so no
+	 * errors should happen. */
+	if (get_user (val0_new, _vfuqueue0))
+		BUG();
+	result = -EAGAIN;
+	if (!do_cmp || val0_new == val0) {
+		result = 0;
+		__fuqueue_requeue (&ufuqueue[1]->fuqueue,
+				   &ufuqueue[0]->fuqueue, nr_wake);
+	}
+	_raw_spin_unlock (&ufuqueue[1]->fuqueue.lock);
+out_spin_unlock:
+	spin_unlock_irq (&ufuqueue[0]->fuqueue.lock);
+	vl_put (vl[0]);
+error_0_find:
+	vl_key_put (&key[0]);
+	vl_page_put (page[0]);
+error_0_key_create:
+	vl_put (vl[1]);
+error_1_find:
+	vl_key_put (&key[1]);
+	vl_page_put (page[1]);
+error_1_key_create:
+	up_read (&mm->mmap_sem);
+	return result;
+}
+
+
 /**
  * Control operations on a fuqueue
  *
diff -u -r1.1.1.1.2.5 -r1.1.1.1.2.6
--- linux/mm/vmscan.c	27 Jul 2004 02:21:01 -0000
+++ linux/mm/vmscan.c	4 Aug 2004 18:22:03 -0000
@@ -1153,7 +1153,7 @@
 	wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
 }
 
-#ifdef CONFIG_PM
+#if defined (CONFIG_PM) || defined (CONFIG_UFULOCK)
 /*
  * Try to free `nr_pages' of memory, system-wide.  Returns the number of freed
  * pages.



Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
