Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSJHPKV>; Tue, 8 Oct 2002 11:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJHPKV>; Tue, 8 Oct 2002 11:10:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:53996 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261268AbSJHPKT>;
	Tue, 8 Oct 2002 11:10:19 -0400
Date: Tue, 8 Oct 2002 17:26:09 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Martin Wirth <Martin.Wirth@dlr.de>
Subject: [patch] futex-2.5.41-A2
Message-ID: <Pine.LNX.4.44.0210081716300.24407-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.44.0210081716302.24407@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, mostly done by Martin Wirth, fixes the following bugs
in the futex/vcache code:

 - futex_close did not detach from the vcache. Detach cleanups.
   (Martin Wirth)

 - __attach_vcache() now uses list_add_tail() to avoid the reversal of the
   futex queue if a COW happens. (Martin Wirth)

 - the fastpath in __pin_page() now handles reserved pages the same way
   get_user_pages() does. (Martin Wirth)

 - comment update to make it clear how the vcache hash quickcheck works.

patch compiles, boots & works just fine on x86 UP and SMP.

	Ingo

--- linux/include/linux/vcache.h.orig	2002-10-08 10:18:45.000000000 +0200
+++ linux/include/linux/vcache.h	2002-10-08 17:01:26.000000000 +0200
@@ -18,7 +18,7 @@
 		struct mm_struct *mm,
 		void (*callback)(struct vcache_s *data, struct page *new_page));
 
-extern void detach_vcache(vcache_t *vcache);
+extern void __detach_vcache(vcache_t *vcache);
 
 extern void invalidate_vcache(unsigned long address, struct mm_struct *mm,
 				struct page *new_page);
--- linux/kernel/futex.c.orig	2002-10-08 10:18:49.000000000 +0200
+++ linux/kernel/futex.c	2002-10-08 17:01:26.000000000 +0200
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
 
@@ -176,6 +177,7 @@
 
 		if (this->page == page && this->offset == offset) {
 			list_del_init(i);
+			__detach_vcache(&this->vcache);
 			tell_waiter(this);
 			ret++;
 			if (ret >= num)
@@ -235,15 +237,18 @@
 {
 	int ret = 0;
 
-	detach_vcache(&q->vcache);
+	if (list_empty(&q->list))
+		return ret;
 
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
 
@@ -314,13 +319,7 @@
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
--- linux/mm/vcache.c.orig	2002-10-08 10:18:45.000000000 +0200
+++ linux/mm/vcache.c	2002-10-08 17:04:57.000000000 +0200
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

