Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTIIEET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 00:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbTIIEET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 00:04:19 -0400
Received: from dp.samba.org ([66.70.73.150]:46532 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263927AbTIIEEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 00:04:05 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] Re: today's futex changes 
In-reply-to: Your message of "Mon, 08 Sep 2003 18:51:40 +0100."
             <20030908175140.GC27097@mail.jlokier.co.uk> 
Date: Tue, 09 Sep 2003 13:58:13 +1000
Message-Id: <20030909040403.C1AA12C0FF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030908175140.GC27097@mail.jlokier.co.uk> you write:
> Rusty Russell wrote:
> > +	u32 hash = jhash2((u32*)&key->both.word,
> 
> Have you checked the code size?

Good point: it's bigger, and there are 4 call sites, so it should be
inlined.  Done.

> That does more work and has more code than is needed, especially on
> 32-bit archs.  On 32-bit, jhash_3words() is much better because it
> reduces to a single call to __jhash_mix(), instead of the two done by
> jhash2 (only one is required for good hashing afaict).
> 
> It is probably worth adding a jhash_3longs() to jhash.h, which does
> one call to __hash_mix() on 32-bit, two calls on 64-bit, and avoids
> the loop in both cases.

Well, I'm happy to let the compiler do this work 8)  In fact, it does
it quite well: the jhash_2words version is still 4 bytes shorter
though, gcc 3.2.3, but then the hashes are slightly different (length
isn't added in jhash_2words).

> [ Aside: For hashing individual integers, I prefer to use Thomas Wang's:
> 
> 	http://www.concentric.net/~Ttwang/tech/inthash.htm
> 
>   He mentions Jenkin's function, and derived an integer mixing function
>   from correspondence with Jenkins.

Interesting: we could sub this for the specific jhash_x functions if
someone wants to do the analysis.

> > -	if (unlikely((vma->vm_flags & (VM_IO|VM_READ)) != VM_READ))
> > -		return (vma->vm_flags & VM_IO) ? -EPERM : -EACCES;
> > +	if (unlikely(vma->vm_flags & VM_IO))
> > +		return -EPERM;
> > +	if (unlikely(vma->vm_flags & (VM_READ|VM_WRITE)) != (VM_READ|VM_WRITE))
> > +		return -EACCES;
> 
> Is there a good reason to disallow read-only waiters?
> I agree with Hugh that it seems like a regression.

Yes, I've reverted this part.

> > +	/* A spurious wakeup.  Should never happen. */
> > +	BUG();
> 
> :)
> 
> The rest of your changes seem fine.  I particularly appreciate your
> grammatical improvements to my comment :)

These days my biggest contribution to the futex code 8)

BTW, I'm guessing from your preference for multi-line comments that
you don't use a color-coding editor for source?  I must say that once
I got used to it, I really prefer comments in green.

Cheers,
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
