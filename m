Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTIYCoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 22:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTIYCoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 22:44:32 -0400
Received: from dp.samba.org ([66.70.73.150]:32209 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261659AbTIYCo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 22:44:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: akpm@zip.com.au, "Hu, Boris" <boris.hu@intel.com>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>
Subject: [PATCH 2/2] Futex hash improv and minor cleanups
Date: Thu, 25 Sep 2003 12:37:25 +1000
Message-Id: <20030925024428.EB1402C0BD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-xmit.

Name: Minor Tweaks To Jamie Lokier & Hugh Dickins's Futex Patch
Author: Rusty Russell
Status: Booted on 2.6.0-test5-bk3
Depends: Misc/futex-split-lock.patch.gz

D: Minor changes to Jamie & Hugh's excellent futex patch.
D: 1) Remove obsolete comment above hash array decl.
D: 2) Clarify comment about TASK_INTERRUPTIBLE.
D: 3) Andrew Morton says spurious wakeup is a bug.  Catch it.
D: 4) Use Jenkins hash.
D: 5) Make hash function non-inline.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31053-linux-2.6.0-test5-bk3/kernel/futex.c .31053-linux-2.6.0-test5-bk3.updated/kernel/futex.c
--- .31053-linux-2.6.0-test5-bk3/kernel/futex.c	2003-09-17 10:27:05.000000000 +1000
+++ .31053-linux-2.6.0-test5-bk3.updated/kernel/futex.c	2003-09-17 10:28:20.000000000 +1000
@@ -33,7 +33,7 @@
 #include <linux/poll.h>
 #include <linux/fs.h>
 #include <linux/file.h>
-#include <linux/hash.h>
+#include <linux/jhash.h>
 #include <linux/init.h>
 #include <linux/futex.h>
 #include <linux/mount.h>
@@ -44,6 +44,7 @@
 /*
  * Futexes are matched on equal values of this key.
  * The key type depends on whether it's a shared or private mapping.
+ * Don't rearrange members without looking at hash_futex().
  */
 union futex_key {
 	struct {
@@ -87,7 +88,6 @@ struct futex_hash_bucket {
        struct list_head       chain;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct futex_hash_bucket futex_queues[1<<FUTEX_HASHBITS];
 
 /* Futex-fs vfsmount entry: */
@@ -96,11 +96,12 @@ static struct vfsmount *futex_mnt;
 /*
  * We hash on the keys returned from get_futex_key (see below).
  */
-static inline struct futex_hash_bucket *hash_futex(union futex_key *key)
+static struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
-	return &futex_queues[hash_long(key->both.word
-				       + (unsigned long) key->both.ptr
-				       + key->both.offset, FUTEX_HASHBITS)];
+	u32 hash = jhash2((u32*)&key->both.word,
+			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
+			  key->both.offset);
+	return &futex_queues[hash & ((1 << FUTEX_HASHBITS)-1)];
 }
 
 /*
@@ -361,7 +362,6 @@ static int futex_wait(unsigned long uadd
 	struct futex_q q;
 	struct futex_hash_bucket *bh = NULL;
 
- try_again:
 	init_waitqueue_head(&q.waiters);
 
 	down_read(&current->mm->mmap_sem);
@@ -395,10 +395,10 @@ static int futex_wait(unsigned long uadd
 	/*
 	 * There might have been scheduling since the queue_me(), as we
 	 * cannot hold a spinlock across the get_user() in case it
-	 * faults.  So we cannot just set TASK_INTERRUPTIBLE state when
+	 * faults, and we cannot just set TASK_INTERRUPTIBLE state when
 	 * queueing ourselves into the futex hash.  This code thus has to
-	 * rely on the futex_wake() code doing a wakeup after removing
-	 * the waiter from the list.
+	 * rely on the futex_wake() code removing us from hash when it
+	 * wakes us up.
 	 */
 	add_wait_queue(&q.waiters, &wait);
 	bh = hash_futex(&key);
@@ -423,26 +423,17 @@ static int futex_wait(unsigned long uadd
 	 * we are the only user of it.
 	 */
 
-	/*
-	 * Were we woken or interrupted for a valid reason?
-	 */
-	ret = unqueue_me(&q);
-	if (ret == 0)
+	/* If we were woken (and unqueued), we succeeded, whatever. */
+	if (!unqueue_me(&q))
 		return 0;
 	if (time == 0)
 		return -ETIMEDOUT;
-	if (signal_pending(current))
-		return -EINTR;
-
-	/*
-	 * No, it was a spurious wakeup.  Try again.  Should never happen. :)
-	 */
-	goto try_again;
+	/* A spurious wakeup should never happen. */
+	WARN_ON(!signal_pending(current));
+	return -EINTR;
 
  out_unqueue:
-	/*
-	 * Were we unqueued anyway?
-	 */
+	/* If we were woken (and unqueued), we succeeded, whatever. */
 	if (!unqueue_me(&q))
 		ret = 0;
  out_release_sem:

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
