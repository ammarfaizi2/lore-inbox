Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTIHKXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 06:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTIHKXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 06:23:16 -0400
Received: from dp.samba.org ([66.70.73.150]:32682 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261769AbTIHKXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 06:23:09 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes 
In-reply-to: Your message of "Sat, 06 Sep 2003 17:28:44 +0100."
             <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain> 
Date: Mon, 08 Sep 2003 16:45:47 +1000
Message-Id: <20030908102309.0AC4E2C013@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain> you write:
> While here, please let's also fix the get_futex_key VM_NONLINEAR
> case, which was returning the 1 from get_user_pages, taken as an
> error by its callers.  And save a few bytes and improve debuggability
> by uninlining the top-level futex_wake, futex_requeue, futex_wait.

OK, I've updated my patch on top of this.  Mainly cosmetic, please
review.

Name: Minor Tweaks To Jamie Lokier's Futex Patch
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk9
Depends: Misc/futex-hugh.patch.gz

D: Minor changes to Jamie's excellent futex patch.
D: 1) Remove obsolete comment above hash array decl.
D: 2) Semantics of futex on read-only pages unclear: require write perm.
D: 3) Clarify comment about TASK_INTERRUPTIBLE.
D: 4) Andrew Morton says spurious wakeup is a bug.  Catch it.
D: 5) Use Jenkins hash.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24731-linux-2.6.0-test4-bk9/kernel/futex.c .24731-linux-2.6.0-test4-bk9.updated/kernel/futex.c
--- .24731-linux-2.6.0-test4-bk9/kernel/futex.c	2003-09-08 10:44:26.000000000 +1000
+++ .24731-linux-2.6.0-test4-bk9.updated/kernel/futex.c	2003-09-08 12:01:23.000000000 +1000
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
+ * Don't rearrange without looking at hash_futex().
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
+static inline struct list_head *hash_futex(const union futex_key *key)
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
@@ -145,17 +146,13 @@ static int get_futex_key(unsigned long u
 	/*
 	 * Permissions.
 	 */
-	if (unlikely((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
-		return (vma->vm_flags & VM_IO) ? -EPERM : -EACCES;
+	if (unlikely(vma->vm_flags & VM_IO))
+		return -EPERM;
+	if (unlikely(vma->vm_flags & (VM_READ|VM_WRITE)) != (VM_READ|VM_WRITE))
+		return -EACCES;
 
 	/*
 	 * Private mappings are handled in a simple way.
-	 *
-	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
-	 * it's a read-only handle, it's expected that futexes attach to
-	 * the object not the particular process.  Therefore we use
-	 * VM_MAYSHARE here, not VM_SHARED which is restricted to shared
-	 * mappings of _writable_ handles.
 	 */
 	if (likely(!(vma->vm_flags & VM_MAYSHARE))) {
 		key->private.mm = mm;
@@ -333,7 +330,6 @@ static int futex_wait(unsigned long uadd
 	union futex_key key;
 	struct futex_q q;
 
- try_again:
 	init_waitqueue_head(&q.waiters);
 
 	down_read(&current->mm->mmap_sem);
@@ -367,10 +363,10 @@ static int futex_wait(unsigned long uadd
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
@@ -394,26 +390,19 @@ static int futex_wait(unsigned long uadd
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
 	if (signal_pending(current))
 		return -EINTR;
 
-	/*
-	 * No, it was a spurious wakeup.  Try again.  Should never happen. :)
-	 */
-	goto try_again;
+	/* A spurious wakeup.  Should never happen. */
+	BUG();
 
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
