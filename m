Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSJOT77>; Tue, 15 Oct 2002 15:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264708AbSJOT77>; Tue, 15 Oct 2002 15:59:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:2507 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264705AbSJOT7z>;
	Tue, 15 Oct 2002 15:59:55 -0400
Date: Tue, 15 Oct 2002 22:17:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: [patch] futex-2.5.42-A2
Message-ID: <Pine.LNX.4.44.0210152157001.21066-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is my current futex patchset against BK-curr. It mostly includes
must-have crash/correctness fixes from Martin Wirth, tested and reworked
somewhat by myself:

 - crash fix: futex_close did not detach from the vcache. Detach cleanups.
   (Martin Wirth)

 - memory leak fix: forgotten put_page() in a rare path in __pin_page().
   (Martin Wirth)

 - crash fix: do not do any quickcheck in unqueue_me(). (Martin, me)

 - correctness fix: the fastpath in __pin_page() now handles reserved
   pages the same way get_user_pages() does. (Martin Wirth)

 - queueing improvement: __attach_vcache() now uses list_add_tail() to
   avoid the reversal of the futex queue if a COW happens. (Martin Wirth)

 - simplified alignment check in sys_futex. (Martin Wirth)

 - comment fix: make it clear how the vcache hash quickcheck works. (me)

compiles, boots & works just fine on x86 SMP and UP.

	Ingo

--- linux/include/linux/vcache.h.orig	2002-10-15 21:35:55.000000000 +0200
+++ linux/include/linux/vcache.h	2002-10-15 21:36:07.000000000 +0200
@@ -18,7 +18,7 @@
 		struct mm_struct *mm,
 		void (*callback)(struct vcache_s *data, struct page *new_page));
 
-extern void detach_vcache(vcache_t *vcache);
+extern void __detach_vcache(vcache_t *vcache);
 
 extern void invalidate_vcache(unsigned long address, struct mm_struct *mm,
 				struct page *new_page);
--- linux/kernel/futex.c.orig	2002-10-15 21:35:55.000000000 +0200
+++ linux/kernel/futex.c	2002-10-15 21:41:06.000000000 +0200
@@ -115,8 +115,9 @@
 	 * Do a quick atomic lookup first - this is the fastpath.
 	 */
 	page = follow_page(mm, addr, 0);
-	if (likely(page != NULL)) {
-		get_page(page);
+	if (likely(page != NULL)) {	
+		if (!PageReserved(page))
+			get_page(page);
 		return page;
 	}
 
@@ -140,8 +141,10 @@
 	 * check for races:
 	 */
 	tmp = follow_page(mm, addr, 0);
-	if (tmp != page)
+	if (tmp != page) {
+		put_page(page);
 		goto repeat_lookup;
+	}
 
 	return page;
 }
@@ -176,6 +179,7 @@
 
 		if (this->page == page && this->offset == offset) {
 			list_del_init(i);
+			__detach_vcache(&this->vcache);
 			tell_waiter(this);
 			ret++;
 			if (ret >= num)
@@ -235,15 +239,15 @@
 {
 	int ret = 0;
 
-	detach_vcache(&q->vcache);
-
+	spin_lock(&vcache_lock);
 	spin_lock(&futex_lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
+		__detach_vcache(&q->vcache);
 		ret = 1;
 	}
 	spin_unlock(&futex_lock);
-
+	spin_unlock(&vcache_lock);
 	return ret;
 }
 
@@ -314,13 +318,7 @@
 {
 	struct futex_q *q = filp->private_data;
 
-	spin_lock(&futex_lock);
-	if (!list_empty(&q->list)) {
-		list_del(&q->list);
-		/* Noone can be polling on us now. */
-		BUG_ON(waitqueue_active(&q->waiters));
-	}
-	spin_unlock(&futex_lock);
+	unqueue_me(q);
 	unpin_page(q->page);
 	kfree(filp->private_data);
 	return 0;
@@ -436,9 +434,8 @@
 
 	pos_in_page = uaddr % PAGE_SIZE;
 
-	/* Must be "naturally" aligned, and not on page boundary. */
-	if ((pos_in_page % __alignof__(int)) != 0
-	    || pos_in_page + sizeof(int) > PAGE_SIZE)
+	/* Must be "naturally" aligned */
+	if (pos_in_page % sizeof(int))
 		return -EINVAL;
 
 	switch (op) {
--- linux/mm/vcache.c.orig	2002-10-15 21:35:55.000000000 +0200
+++ linux/mm/vcache.c	2002-10-15 21:36:07.000000000 +0200
@@ -41,14 +41,12 @@
 
 	hash_head = hash_vcache(address, mm);
 
-	list_add(&vcache->hash_entry, hash_head);
+	list_add_tail(&vcache->hash_entry, hash_head);
 }
 
-void detach_vcache(vcache_t *vcache)
+void __detach_vcache(vcache_t *vcache)
 {
-	spin_lock(&vcache_lock);
-	list_del(&vcache->hash_entry);
-	spin_unlock(&vcache_lock);
+	list_del_init(&vcache->hash_entry);
 }
 
 void invalidate_vcache(unsigned long address, struct mm_struct *mm,
@@ -61,12 +59,11 @@
 
 	hash_head = hash_vcache(address, mm);
 	/*
-	 * This is safe, because this path is called with the mm
-	 * semaphore read-held, and the add/remove path calls with the
-	 * mm semaphore write-held. So while other mm's might add new
-	 * entries in parallel, and *this* mm is locked out, so if the
-	 * list is empty now then we do not have to take the vcache
-	 * lock to see it's really empty.
+	 * This is safe, because this path is called with the pagetable
+	 * lock held. So while other mm's might add new entries in
+	 * parallel, *this* mm is locked out, so if the list is empty
+	 * now then we do not have to take the vcache lock to see it's
+	 * really empty.
 	 */
 	if (likely(list_empty(hash_head)))
 		return;



