Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbTIJG2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 02:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbTIJG2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 02:28:18 -0400
Received: from fmr06.intel.com ([134.134.136.7]:46548 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264917AbTIJG2M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 02:28:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [PATCH] Split futex global spinlock futex_lock
Date: Wed, 10 Sep 2003 13:23:47 +0800
Message-ID: <37FBBA5F3A361C41AB7CE44558C3448E01C0B69E@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Split futex global spinlock futex_lock
Thread-Index: AcN3W7KK2ztewjoDQ8i2dzjt41w6rA==
From: "Hu, Boris" <boris.hu@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2003 05:24:43.0463 (UTC) FILETIME=[D750C570:01C3775B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Split futex global spinlock futex_lock into hash bucket spinlocks.
Add bucket spinlock recursively lock check fixed by Jakub Jelinek.


--- bk-linux-2.6/kernel/futex.c	2003-09-10 13:16:54.000000000 +0800
+++ bk-linux-2.6.dev/kernel/futex.c	2003-09-10 13:09:52.000000000 +0800
@@ -79,9 +79,16 @@
 	struct file *filp;
 };
 
+/*
+ * Split the global futex_lock into every hash list lock.
+ */
+struct futex_hash_bucket {
+       struct list_head        chain;
+       spinlock_t              lock;
+};
+
 /* The key for the hash is the address + index + offset within page */
-static struct list_head futex_queues[1<<FUTEX_HASHBITS];
-static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
+static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
 
 /* Futex-fs vfsmount entry: */
 static struct vfsmount *futex_mnt;
@@ -89,7 +96,7 @@
 /*
  * We hash on the keys returned from get_futex_key (see below).
  */
-static inline struct list_head *hash_futex(union futex_key *key)
+static inline struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
 	return &futex_queues[hash_long(key->both.word
 				       + (unsigned long) key->both.ptr
@@ -214,6 +221,7 @@
 static int futex_wake(unsigned long uaddr, int num)
 {
 	struct list_head *i, *next, *head;
+	struct futex_hash_bucket *bh;
 	union futex_key key;
 	int ret;
 
@@ -223,9 +231,10 @@
 	if (unlikely(ret != 0))
 		goto out;
 
-	head = hash_futex(&key);
+	bh = hash_futex(&key);
+	spin_lock(&bh->lock);
+	head = &bh->chain;
 
-	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
@@ -239,7 +248,7 @@
 				break;
 		}
 	}
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 
 out:
 	up_read(&current->mm->mmap_sem);
@@ -254,6 +263,7 @@
 				int nr_wake, int nr_requeue)
 {
 	struct list_head *i, *next, *head1, *head2;
+	struct futex_hash_bucket *bh1, *bh2;
 	union futex_key key1, key2;
 	int ret;
 
@@ -266,10 +276,19 @@
 	if (unlikely(ret != 0))
 		goto out;
 
-	head1 = hash_futex(&key1);
-	head2 = hash_futex(&key2);
+	bh1 = hash_futex(&key1);
+	bh2 = hash_futex(&key2);
+	if (bh1 < bh2) {
+		spin_lock(&bh1->lock);
+		spin_lock(&bh2->lock);
+	} else {
+		spin_lock(&bh2->lock);
+		if (bh1 > bh2)
+			spin_lock(&bh1->lock);
+	}
+	head1 = &bh1->chain;
+	head2 = &bh2->chain;
 
-	spin_lock(&futex_lock);
 	list_for_each_safe(i, next, head1) {
 		struct futex_q *this = list_entry(i, struct futex_q, list);
 
@@ -291,8 +310,14 @@
 			}
 		}
 	}
-	spin_unlock(&futex_lock);
-
+	if (bh1 < bh2) {
+		spin_unlock(&bh2->lock);
+		spin_unlock(&bh1->lock);
+	} else {
+		if (bh1 > bh2)
+			spin_unlock(&bh1->lock);
+		spin_unlock(&bh2->lock);
+	}
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -301,28 +326,30 @@
 static inline void queue_me(struct futex_q *q, union futex_key *key,
 			    int fd, struct file *filp)
 {
-	struct list_head *head = hash_futex(key);
+	struct futex_hash_bucket *bh = hash_futex(key);
+	struct list_head *head = &bh->chain;
 
 	q->key = *key;
 	q->fd = fd;
 	q->filp = filp;
 
-	spin_lock(&futex_lock);
+	spin_lock(&bh->lock);
 	list_add_tail(&q->list, head);
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 }
 
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
 static inline int unqueue_me(struct futex_q *q)
 {
+	struct futex_hash_bucket *bh = hash_futex(&q->key);
 	int ret = 0;
 
-	spin_lock(&futex_lock);
+	spin_lock(&bh->lock);
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
 		ret = 1;
 	}
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 	return ret;
 }
 
@@ -332,6 +359,7 @@
 	int ret, curval;
 	union futex_key key;
 	struct futex_q q;
+	struct futex_hash_bucket *bh = NULL;
 
  try_again:
 	init_waitqueue_head(&q.waiters);
@@ -373,19 +401,20 @@
 	 * the waiter from the list.
 	 */
 	add_wait_queue(&q.waiters, &wait);
-	spin_lock(&futex_lock);
+	bh = hash_futex(&key);
+	spin_lock(&bh->lock);
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	if (unlikely(list_empty(&q.list))) {
 		/*
 		 * We were woken already.
 		 */
-		spin_unlock(&futex_lock);
+		spin_unlock(&bh->lock);
 		set_current_state(TASK_RUNNING);
 		return 0;
 	}
 
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 	time = schedule_timeout(time);
 	set_current_state(TASK_RUNNING);
 
@@ -435,13 +464,14 @@
 			       struct poll_table_struct *wait)
 {
 	struct futex_q *q = filp->private_data;
+	struct futex_hash_bucket *bh = hash_futex(&q->key);
 	int ret = 0;
 
 	poll_wait(filp, &q->waiters, wait);
-	spin_lock(&futex_lock);
+	spin_lock(&bh->lock);
 	if (list_empty(&q->list))
 		ret = POLLIN | POLLRDNORM;
-	spin_unlock(&futex_lock);
+	spin_unlock(&bh->lock);
 
 	return ret;
 }
@@ -587,8 +617,10 @@
 	register_filesystem(&futex_fs_type);
 	futex_mnt = kern_mount(&futex_fs_type);
 
-	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
-		INIT_LIST_HEAD(&futex_queues[i]);
+	for (i = 0; i < ARRAY_SIZE(futex_queues); i++) {
+		INIT_LIST_HEAD(&futex_queues[i].chain);
+		futex_queues[i].lock = SPIN_LOCK_UNLOCKED;
+	}
 	return 0;
 }
 __initcall(init);

Good Luck !
 
Boris Hu
(Hu Jiangtao)
----------------------------------
This email message contains solely 
my own personal views, and not 
necessarily those of my employer.
----------------------------------

