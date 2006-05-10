Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWEJJWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWEJJWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWEJJWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:22:52 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:10948 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751041AbWEJJWv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:22:51 -0400
Date: Wed, 10 May 2006 11:27:06 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC][PATCH RT 2/2] futex-use-prio-list
Message-ID: <20060510112706.08abdf91@frecb000686>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2006 11:25:46,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2006 11:25:50,
	Serialize complete at 10/05/2006 11:25:50
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Tasks waiting on a futex are woken up in FIFO order (in the order they were
enqueued). For realtime systems needing SWSRPS (system wide strict realtime
priority scheduling), tasks should be woken up in priority order.

  This patch changes the futex_hash_bucket list into a plist. Tasks waiting on
a futex are inserted based on their priority so that they can be woken up in
priority order.

 futex.c |   61 +++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 33 insertions(+), 28 deletions(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.16-rt20/kernel/futex.c
===================================================================
--- linux-2.6.16-rt20.orig/kernel/futex.c	2006-05-04 10:58:55.000000000 +0200
+++ linux-2.6.16-rt20/kernel/futex.c	2006-05-04 10:59:00.000000000 +0200
@@ -112,7 +112,7 @@ struct futex_pi_state {
  * wake up q->waiters, then make the second condition true.
  */
 struct futex_q {
-	struct list_head list;
+	struct plist_node list;
 	wait_queue_head_t waiters;
 
 	/* Which hash list lock to use: */
@@ -135,7 +135,7 @@ struct futex_q {
  */
 struct futex_hash_bucket {
        spinlock_t              lock;
-       struct list_head       chain;
+       struct plist_head       chain;
 };
 
 static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
@@ -464,13 +464,13 @@ lookup_pi_state(u32 uval, struct futex_h
 {
 	struct futex_pi_state *pi_state = NULL;
 	struct futex_q *this, *next;
-	struct list_head *head;
+	struct plist_head *head;
 	struct task_struct *p;
 	pid_t pid;
 
 	head = &hb->chain;
 
-	list_for_each_entry_safe(this, next, head, list) {
+	plist_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &me->key)) {
 			/*
 			 * Another waiter already exists - bump up
@@ -522,9 +522,9 @@ lookup_pi_state(u32 uval, struct futex_h
  * The hash bucket lock must be held when this is called.
  * Afterwards, the futex_q must not be accessed.
  */
-static void wake_futex(struct futex_q *q)
+static void wake_futex(struct futex_q *q, struct plist_head *head)
 {
-	list_del_init(&q->list);
+	plist_del(&q->list, head);
 	if (q->filp)
 		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
 	/*
@@ -622,7 +622,7 @@ static int futex_wake(u32 __user *uaddr,
 {
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
-	struct list_head *head;
+	struct plist_head *head;
 	union futex_key key;
 	int ret;
 
@@ -636,11 +636,11 @@ static int futex_wake(u32 __user *uaddr,
 	spin_lock(&hb->lock);
 	head = &hb->chain;
 
-	list_for_each_entry_safe(this, next, head, list) {
+	plist_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key)) {
 			if (this->pi_state)
 				return -EINVAL;
-			wake_futex(this);
+			wake_futex(this, head);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -662,7 +662,7 @@ futex_wake_op(u32 __user *uaddr1, u32 __
 {
 	union futex_key key1, key2;
 	struct futex_hash_bucket *hb1, *hb2;
-	struct list_head *head;
+	struct plist_head *head;
 	struct futex_q *this, *next;
 	int ret, op_ret, attempt = 0;
 
@@ -737,9 +737,9 @@ retry:
 
 	head = &hb1->chain;
 
-	list_for_each_entry_safe(this, next, head, list) {
+	plist_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key1)) {
-			wake_futex(this);
+			wake_futex(this, head);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -749,9 +749,9 @@ retry:
 		head = &hb2->chain;
 
 		op_ret = 0;
-		list_for_each_entry_safe(this, next, head, list) {
+		plist_for_each_entry_safe(this, next, head, list) {
 			if (match_futex (&this->key, &key2)) {
-				wake_futex(this);
+				wake_futex(this, head);
 				if (++op_ret >= nr_wake2)
 					break;
 			}
@@ -776,7 +776,7 @@ static int futex_requeue(u32 __user *uad
 {
 	union futex_key key1, key2;
 	struct futex_hash_bucket *hb1, *hb2;
-	struct list_head *head1;
+	struct plist_head *head1;
 	struct futex_q *this, *next;
 	int ret, drop_count = 0;
 
@@ -829,18 +829,19 @@ static int futex_requeue(u32 __user *uad
 	}
 
 	head1 = &hb1->chain;
-	list_for_each_entry_safe(this, next, head1, list) {
+	plist_for_each_entry_safe(this, next, head1, list) {
 		if (!match_futex (&this->key, &key1))
 			continue;
 		if (++ret <= nr_wake) {
-			wake_futex(this);
+			wake_futex(this, head1);
 		} else {
 			/*
 			 * If key1 and key2 hash to the same bucket, no
 			 * need to requeue.
 			 */
 			if (likely(head1 != &hb2->chain)) {
-				list_move_tail(&this->list, &hb2->chain);
+				plist_del(&this->list, &hb1->chain);
+				plist_add(&this->list, &hb2->chain);
 				this->lock_ptr = &hb2->lock;
 			}
 			this->key = key2;
@@ -887,7 +888,8 @@ queue_lock(struct futex_q *q, int fd, st
 
 static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
 {
-	list_add_tail(&q->list, &hb->chain);
+	plist_node_init(&q->list, current->normal_prio);
+	plist_add(&q->list, &hb->chain);
 	q->task = current;
 	spin_unlock(&hb->lock);
 }
@@ -917,6 +919,7 @@ static void queue_me(struct futex_q *q, 
 static int unqueue_me(struct futex_q *q)
 {
 	spinlock_t *lock_ptr;
+	struct futex_hash_bucket *hb;
 	int ret = 0;
 
 	/* In the common case we don't take the spinlock, which is nice. */
@@ -941,8 +944,9 @@ static int unqueue_me(struct futex_q *q)
 			spin_unlock(lock_ptr);
 			goto retry;
 		}
-		WARN_ON(list_empty(&q->list));
-		list_del(&q->list);
+		hb = hash_futex(&q->key);
+		WARN_ON(plist_node_empty(&q->list));
+		plist_del(&q->list, &hb->chain);
 
 		BUG_ON(q->pi_state);
 
@@ -960,8 +964,8 @@ static int unqueue_me(struct futex_q *q)
  */
 static void unqueue_me_pi(struct futex_q *q, struct futex_hash_bucket *hb)
 {
-	WARN_ON(list_empty(&q->list));
-	list_del(&q->list);
+	WARN_ON(plist_node_empty(&q->list));
+	plist_del(&q->list, &hb->chain);
 
 	BUG_ON(!q->pi_state);
 	free_pi_state(q->pi_state);
@@ -1059,7 +1063,7 @@ static int futex_wait(u32 __user *uaddr,
 	 * !list_empty() is safe here without any lock.
 	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
 	 */
-	if (likely(!list_empty(&q.list))) {
+	if (likely(!plist_node_empty(&q.list))) {
 		unsigned long nosched_flag = current->flags & PF_NOSCHED;
 
 		current->flags &= ~PF_NOSCHED;
@@ -1360,7 +1364,7 @@ static int futex_unlock_pi(u32 __user *u
 	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
 	u32 uval;
-	struct list_head *head;
+	struct plist_head *head;
 	union futex_key key;
 	int ret, attempt = 0;
 
@@ -1409,7 +1413,7 @@ retry_locked:
 	 */
 	head = &hb->chain;
 
-	list_for_each_entry_safe(this, next, head, list) {
+	plist_for_each_entry_safe(this, next, head, list) {
 		if (!match_futex (&this->key, &key))
 			continue;
 		ret = wake_futex_pi(uaddr, uval, this);
@@ -1485,7 +1489,7 @@ static unsigned int futex_poll(struct fi
 	 * list_empty() is safe here without any lock.
 	 * q->lock_ptr != 0 is not safe, because of ordering against wakeup.
 	 */
-	if (list_empty(&q->list))
+	if (plist_node_empty(&q->list))
 		ret = POLLIN | POLLRDNORM;
 
 	return ret;
@@ -1822,7 +1826,8 @@ static int __init init(void)
 	futex_mnt = kern_mount(&futex_fs_type);
 
 	for (i = 0; i < ARRAY_SIZE(futex_queues); i++) {
-		INIT_LIST_HEAD(&futex_queues[i].chain);
+		plist_head_init(&futex_queues[i].chain,
+				NULL);
 		spin_lock_init(&futex_queues[i].lock);
 	}
 	return 0;
