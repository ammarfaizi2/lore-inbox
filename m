Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbTESIqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 04:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbTESIqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 04:46:36 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41345 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id S261678AbTESIqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 04:46:33 -0400
Date: Mon, 19 May 2003 10:58:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] futex-fixes-2.5.69-A0
Message-ID: <Pine.LNX.4.44.0305191054350.5302-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, fixes page pinning / vcache bugs in the futex code,
patch made by Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com> and
Saurabh Desai <sdesai@austin.ibm.com>. (I also removed the tell_waiter()
inline function, it was used only once.)

Compiles & boots on x86-SMP.

	Ingo

--- linux/kernel/futex.c.orig	
+++ linux/kernel/futex.c	
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
+static inline
+struct page *__pin_page_atomic (struct page *page)
+{
+	if (!PageReserved(page))
+		get_page(page);
+	return page;
+}
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
@@ -181,7 +177,9 @@ static int futex_wake(unsigned long uadd
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
@@ -208,7 +206,9 @@ static void futex_vcache_callback(vcache
 	spin_lock(&futex_lock);
 
 	if (!list_empty(&q->list)) {
+		unpin_page(q->page);
 		q->page = new_page;
+		__pin_page_atomic(new_page);
 		list_del(&q->list);
 		list_add_tail(&q->list, head);
 	}
@@ -273,14 +273,17 @@ static int futex_wait(unsigned long uadd
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
@@ -293,8 +296,10 @@ static int futex_wait(unsigned long uadd
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
@@ -310,7 +315,7 @@ out:
 	/* Were we woken up anyway? */
 	if (!unqueue_me(&q))
 		ret = 0;
-	unpin_page(page);
+	unpin_page(q.page);
 
 	return ret;
 }


