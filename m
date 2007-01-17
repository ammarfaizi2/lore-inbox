Return-Path: <linux-kernel-owner+w=401wt.eu-S932096AbXAQJBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXAQJBe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXAQJBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:01:34 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:53370 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbXAQJBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:01:33 -0500
Message-ID: <45ADE593.8040809@bull.net>
Date: Wed, 17 Jan 2007 10:00:03 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>
Subject: [PATCH 2.6.20-rc5 1/4] futex priority based wakeup
References: <45ADDF60.5080704@bull.net>
In-Reply-To: <45ADDF60.5080704@bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 10:09:48,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/01/2007 10:09:49,
	Serialize complete at 17/01/2007 10:09:49
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today, all threads waiting for a given futex are woken in FIFO order (first
waiter woken first) instead of priority order.

This patch makes use of plist (pirotity ordered lists) instead of simple list in
futex_hash_bucket.

All non-RT threads are stored with priority MAX_RT_PRIO, causing them to be
woken last, in FIFO order (RT-threads are woken first, in priority order).

---

  futex.c |   78 ++++++++++++++++++++++++++++++++++++++++------------------------
  1 file changed, 49 insertions(+), 29 deletions(-)

---

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>
Signed-off-by: Pierre Peiffer <pierre.peiffer@bull.net>

---
Index: linux-2.6/kernel/futex.c
===================================================================
--- linux-2.6.orig/kernel/futex.c	2007-01-17 09:39:57.000000000 +0100
+++ linux-2.6/kernel/futex.c	2007-01-17 09:44:25.000000000 +0100
@@ -106,12 +106,12 @@ struct futex_pi_state {
   * we can wake only the relevant ones (hashed queues may be shared).
   *
   * A futex_q has a woken state, just like tasks have TASK_RUNNING.
- * It is considered woken when list_empty(&q->list) || q->lock_ptr == 0.
+ * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr == 0.
   * The order of wakup is always to make the first condition true, then
   * wake up q->waiters, then make the second condition true.
   */
  struct futex_q {
-	struct list_head list;
+	struct plist_node list;
  	wait_queue_head_t waiters;

  	/* Which hash list lock to use: */
@@ -133,8 +133,8 @@ struct futex_q {
   * Split the global futex_lock into every hash list lock.
   */
  struct futex_hash_bucket {
-       spinlock_t              lock;
-       struct list_head       chain;
+	spinlock_t lock;
+	struct plist_head chain;
  };

  static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
@@ -465,13 +465,13 @@ lookup_pi_state(u32 uval, struct futex_h
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
  		if (match_futex(&this->key, &me->key)) {
  			/*
  			 * Another waiter already exists - bump up
@@ -535,12 +535,12 @@ lookup_pi_state(u32 uval, struct futex_h
   */
  static void wake_futex(struct futex_q *q)
  {
-	list_del_init(&q->list);
+	plist_del(&q->list, &q->list.plist);
  	if (q->filp)
  		send_sigio(&q->filp->f_owner, q->fd, POLL_IN);
  	/*
  	 * The lock in wake_up_all() is a crucial memory barrier after the
-	 * list_del_init() and also before assigning to q->lock_ptr.
+	 * plist_del() and also before assigning to q->lock_ptr.
  	 */
  	wake_up_all(&q->waiters);
  	/*
@@ -653,7 +653,7 @@ static int futex_wake(u32 __user *uaddr,
  {
  	struct futex_hash_bucket *hb;
  	struct futex_q *this, *next;
-	struct list_head *head;
+	struct plist_head *head;
  	union futex_key key;
  	int ret;

@@ -667,7 +667,7 @@ static int futex_wake(u32 __user *uaddr,
  	spin_lock(&hb->lock);
  	head = &hb->chain;

-	list_for_each_entry_safe(this, next, head, list) {
+	plist_for_each_entry_safe(this, next, head, list) {
  		if (match_futex (&this->key, &key)) {
  			if (this->pi_state) {
  				ret = -EINVAL;
@@ -695,7 +695,7 @@ futex_wake_op(u32 __user *uaddr1, u32 __
  {
  	union futex_key key1, key2;
  	struct futex_hash_bucket *hb1, *hb2;
-	struct list_head *head;
+	struct plist_head *head;
  	struct futex_q *this, *next;
  	int ret, op_ret, attempt = 0;

@@ -768,7 +768,7 @@ retry:

  	head = &hb1->chain;

-	list_for_each_entry_safe(this, next, head, list) {
+	plist_for_each_entry_safe(this, next, head, list) {
  		if (match_futex (&this->key, &key1)) {
  			wake_futex(this);
  			if (++ret >= nr_wake)
@@ -780,7 +780,7 @@ retry:
  		head = &hb2->chain;

  		op_ret = 0;
-		list_for_each_entry_safe(this, next, head, list) {
+		plist_for_each_entry_safe(this, next, head, list) {
  			if (match_futex (&this->key, &key2)) {
  				wake_futex(this);
  				if (++op_ret >= nr_wake2)
@@ -807,7 +807,7 @@ static int futex_requeue(u32 __user *uad
  {
  	union futex_key key1, key2;
  	struct futex_hash_bucket *hb1, *hb2;
-	struct list_head *head1;
+	struct plist_head *head1;
  	struct futex_q *this, *next;
  	int ret, drop_count = 0;

@@ -856,7 +856,7 @@ static int futex_requeue(u32 __user *uad
  	}

  	head1 = &hb1->chain;
-	list_for_each_entry_safe(this, next, head1, list) {
+	plist_for_each_entry_safe(this, next, head1, list) {
  		if (!match_futex (&this->key, &key1))
  			continue;
  		if (++ret <= nr_wake) {
@@ -867,9 +867,13 @@ static int futex_requeue(u32 __user *uad
  			 * requeue.
  			 */
  			if (likely(head1 != &hb2->chain)) {
-				list_move_tail(&this->list, &hb2->chain);
+				plist_del(&this->list, &hb1->chain);
+				plist_add(&this->list, &hb2->chain);
  				this->lock_ptr = &hb2->lock;
-			}
+#ifdef CONFIG_DEBUG_PI_LIST
+				this->list.plist.lock = &hb2->lock;
+#endif
+ 			}
  			this->key = key2;
  			get_key_refs(&key2);
  			drop_count++;
@@ -914,7 +918,23 @@ queue_lock(struct futex_q *q, int fd, st

  static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
  {
-	list_add_tail(&q->list, &hb->chain);
+	int prio;
+
+	/*
+	 * The priority used to register this element is
+	 * - either the real thread-priority for the real-time threads
+	 * (i.e. threads with a priority lower than MAX_RT_PRIO)
+	 * - or MAX_RT_PRIO for non-RT threads.
+	 * Thus, all RT-threads are woken first in priority order, and
+	 * the others are woken last, in FIFO order.
+	 */
+	prio = min(current->normal_prio, MAX_RT_PRIO);
+
+	plist_node_init(&q->list, prio);
+#ifdef CONFIG_DEBUG_PI_LIST
+	q->list.plist.lock = &hb->lock;
+#endif
+	plist_add(&q->list, &hb->chain);
  	q->task = current;
  	spin_unlock(&hb->lock);
  }
@@ -969,8 +989,8 @@ static int unqueue_me(struct futex_q *q)
  			spin_unlock(lock_ptr);
  			goto retry;
  		}
-		WARN_ON(list_empty(&q->list));
-		list_del(&q->list);
+		WARN_ON(plist_node_empty(&q->list));
+		plist_del(&q->list, &q->list.plist);

  		BUG_ON(q->pi_state);

@@ -988,8 +1008,8 @@ static int unqueue_me(struct futex_q *q)
   */
  static void unqueue_me_pi(struct futex_q *q, struct futex_hash_bucket *hb)
  {
-	WARN_ON(list_empty(&q->list));
-	list_del(&q->list);
+	WARN_ON(plist_node_empty(&q->list));
+	plist_del(&q->list, &q->list.plist);

  	BUG_ON(!q->pi_state);
  	free_pi_state(q->pi_state);
@@ -1082,10 +1102,10 @@ static int futex_wait(u32 __user *uaddr,
  	__set_current_state(TASK_INTERRUPTIBLE);
  	add_wait_queue(&q.waiters, &wait);
  	/*
-	 * !list_empty() is safe here without any lock.
+	 * !plist_node_empty() is safe here without any lock.
  	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
  	 */
-	if (likely(!list_empty(&q.list)))
+	if (likely(!plist_node_empty(&q.list)))
  		time = schedule_timeout(time);
  	__set_current_state(TASK_RUNNING);

@@ -1358,7 +1378,7 @@ static int futex_unlock_pi(u32 __user *u
  	struct futex_hash_bucket *hb;
  	struct futex_q *this, *next;
  	u32 uval;
-	struct list_head *head;
+	struct plist_head *head;
  	union futex_key key;
  	int ret, attempt = 0;

@@ -1409,7 +1429,7 @@ retry_locked:
  	 */
  	head = &hb->chain;

-	list_for_each_entry_safe(this, next, head, list) {
+	plist_for_each_entry_safe(this, next, head, list) {
  		if (!match_futex (&this->key, &key))
  			continue;
  		ret = wake_futex_pi(uaddr, uval, this);
@@ -1483,10 +1503,10 @@ static unsigned int futex_poll(struct fi
  	poll_wait(filp, &q->waiters, wait);

  	/*
-	 * list_empty() is safe here without any lock.
+	 * plist_node_empty() is safe here without any lock.
  	 * q->lock_ptr != 0 is not safe, because of ordering against wakeup.
  	 */
-	if (list_empty(&q->list))
+	if (plist_node_empty(&q->list))
  		ret = POLLIN | POLLRDNORM;

  	return ret;
@@ -1869,7 +1889,7 @@ static int __init init(void)
  	}

  	for (i = 0; i < ARRAY_SIZE(futex_queues); i++) {
-		INIT_LIST_HEAD(&futex_queues[i].chain);
+		plist_head_init(&futex_queues[i].chain, &futex_queues[i].lock);
  		spin_lock_init(&futex_queues[i].lock);
  	}
  	return 0;


-- 
Pierre

