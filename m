Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263940AbTIIEOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 00:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263941AbTIIEOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 00:14:12 -0400
Received: from dp.samba.org ([66.70.73.150]:7900 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263940AbTIIEOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 00:14:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, drepper@redhat.com, Jamie Lokier <jamie@shareable.org>,
       lk@tantalophile.demon.co.uk, shemminger@osdl.org,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: today's futex changes 
In-reply-to: Your message of "Mon, 08 Sep 2003 12:02:34 MST."
             <20030908120234.5d05cda9.akpm@osdl.org> 
Date: Tue, 09 Sep 2003 14:12:38 +1000
Message-Id: <20030909041403.77BC52C051@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030908120234.5d05cda9.akpm@osdl.org> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > D: 4) Andrew Morton says spurious wakeup is a bug.  Catch it.
> 
> Yes, but going BUG() is a bit rude.  We can detect the error, we can
> recover from it and it doesn't cause any user data corruption or anything.
> A rude printk is all that is needed here.

OK.  Changed.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Minor Tweaks To Jamie Lokier's Futex Patch
Author: Rusty Russell
Status: Booted on 2.6.0-test5

D: Minor changes to Jamie's excellent futex patch.
D: 1) Remove obsolete comment above hash array decl.
D: 2) Clarify comment about TASK_INTERRUPTIBLE.
D: 3) Andrew Morton says spurious wakeup is a bug.  Catch it.
D: 4) Try Jenkins hash.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9333-linux-2.6.0-test5/kernel/futex.c .9333-linux-2.6.0-test5.updated/kernel/futex.c
--- .9333-linux-2.6.0-test5/kernel/futex.c	2003-09-09 10:35:05.000000000 +1000
+++ .9333-linux-2.6.0-test5.updated/kernel/futex.c	2003-09-09 14:06:06.000000000 +1000
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
@@ -79,7 +80,6 @@ struct futex_q {
 	struct file *filp;
 };
 
-/* The key for the hash is the address + index + offset within page */
 static struct list_head futex_queues[1<<FUTEX_HASHBITS];
 static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;
 
@@ -89,11 +89,12 @@ static struct vfsmount *futex_mnt;
 /*
  * We hash on the keys returned from get_futex_key (see below).
  */
-static inline struct list_head *hash_futex(union futex_key *key)
+static struct list_head *hash_futex(const union futex_key *key)
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
@@ -333,7 +334,6 @@ static int futex_wait(unsigned long uadd
 	union futex_key key;
 	struct futex_q q;
 
- try_again:
 	init_waitqueue_head(&q.waiters);
 
 	down_read(&current->mm->mmap_sem);
@@ -367,10 +367,10 @@ static int futex_wait(unsigned long uadd
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
 	spin_lock(&futex_lock);
@@ -394,26 +394,17 @@ static int futex_wait(unsigned long uadd
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
