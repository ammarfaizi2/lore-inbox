Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316846AbSFFHMj>; Thu, 6 Jun 2002 03:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316869AbSFFHMi>; Thu, 6 Jun 2002 03:12:38 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:54269 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316846AbSFFHMh>; Thu, 6 Jun 2002 03:12:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com
Subject: [PATCH] Futex update IV: use a waitqueue.
Date: Thu, 06 Jun 2002 17:15:37 +1000
Message-Id: <E17FrUg-0005GX-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Use a waitqueue, rather than a task ptr
Author: Rusty Russell
Status: Tested in 2.5.20
Depends: Futex/copy-from-user.patch.gz

D: This turns the simple task pointer into a waitqueue, which is
D: needed for the poll() patch.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.20.18954/kernel/futex.c linux-2.5.20.18954.updated/kernel/futex.c
--- linux-2.5.20.18954/kernel/futex.c	Thu Jun  6 17:12:20 2002
+++ linux-2.5.20.18954.updated/kernel/futex.c	Thu Jun  6 17:13:05 2002
@@ -49,7 +49,7 @@
    the relevent ones (hashed queues may be shared) */
 struct futex_q {
 	struct list_head list;
-	struct task_struct *task;
+	wait_queue_head_t waiters;
 	/* Page struct and offset within it. */
 	struct page *page;
 	unsigned int offset;
@@ -69,6 +69,11 @@
 	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
 }
 
+static inline void tell_waiter(struct futex_q *q)
+{
+	wake_up_all(&q->waiters);
+}
+
 static int futex_wake(struct list_head *head,
 		      struct page *page,
 		      unsigned int offset,
@@ -83,7 +88,7 @@
 
 		if (this->page == page && this->offset == offset) {
 			list_del_init(i);
-			wake_up_process(this->task);
+			tell_waiter(this);
 			num_woken++;
 			if (num_woken >= num) break;
 		}
@@ -94,11 +99,12 @@
 
 /* Add at end to avoid starvation */
 static inline void queue_me(struct list_head *head,
+			    wait_queue_t *wait,
 			    struct futex_q *q,
 			    struct page *page,
 			    unsigned int offset)
 {
-	q->task = current;
+	add_wait_queue(&q->waiters, wait);
 	q->page = page;
 	q->offset = offset;
 
@@ -150,10 +156,11 @@
 {
 	int curval;
 	struct futex_q q;
+	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
 
 	set_current_state(TASK_INTERRUPTIBLE);
-	queue_me(head, &q, page, offset);
+	queue_me(head, &wait, &q, page, offset);
 
 	/* Page is pinned, but may no longer be in this address space. */
 	if (get_user(curval, uaddr) != 0) {
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
