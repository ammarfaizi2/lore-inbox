Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTJAFqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbTJAFqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:46:22 -0400
Received: from dp.samba.org ([66.70.73.150]:46266 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261947AbTJAFqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:46:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jamie Lokier <jamie@shareable.org>
Cc: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, "Hu, Boris" <boris.hu@intel.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: 2.6.0-test6 oops futex" 
In-reply-to: Your message of "Tue, 30 Sep 2003 21:53:08 +0100."
             <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain> 
Date: Wed, 01 Oct 2003 09:44:27 +1000
Message-Id: <20031001054619.976472C105@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain> you write:
> Consider unqueue_me on one cpu racing against this->key = key2 in
> futex_requeue on another.  unqueue_me finds the right bh to lock
> from q->key, but futex_requeue is shifting q->key beneath it.
> Although futex_requeue holds both the relevant spinlocks, during
> reassignment of key an irrelevant hashqueue may get calculated
> and locked instead.

Yes, the lack of global lock does make this problematic.  You end up
holding the lock on one queue and removing from another.  I think the
recycling scenario a more likely cause in this case, but this too must
be fixed.

The clearest fix (other than going back to one big lock) is to have a
lock per futex to protect its contents (vs. the hash bucket lock which
protects the hash chain itself).  But the following race-check is
sufficient (there are only two places where we call futex_hash on a
"live" futex):

Name: Futex Requeue Race
Author: Hugh Dickins, Typing by Rusty Russell
Status: Experimental

D: Consider unqueue_me on one cpu racing against this->key = key2 in
D: futex_requeue on another.  unqueue_me finds the right bh to lock
D: from q->key, but futex_requeue is shifting q->key beneath it.
D: Although futex_requeue holds both the relevant spinlocks, during
D: reassignment of key an irrelevant hashqueue may get calculated
D: and locked instead.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26056-linux-2.6.0-test6-bk2/kernel/futex.c .26056-linux-2.6.0-test6-bk2.updated/kernel/futex.c
--- .26056-linux-2.6.0-test6-bk2/kernel/futex.c	2003-09-29 10:26:06.000000000 +1000
+++ .26056-linux-2.6.0-test6-bk2.updated/kernel/futex.c	2003-10-01 09:40:58.000000000 +1000
@@ -342,10 +342,19 @@ static inline void queue_me(struct futex
 /* Return 1 if we were still queued (ie. 0 means we were woken) */
 static inline int unqueue_me(struct futex_q *q)
 {
-	struct futex_hash_bucket *bh = hash_futex(&q->key);
+	struct futex_hash_bucket *bh;
+	union futex_key key;
 	int ret = 0;
 
+again:
+	key = q->key;
+	bh = hash_futex(&key);
 	spin_lock(&bh->lock);
+	if (unlikely(!match_futex(&key, q->key)) {
+		/* Race against futex_requeue */
+		spin_unlock(&bh_lock);
+		goto again;
+	}
 	if (!list_empty(&q->list)) {
 		list_del(&q->list);
 		ret = 1;
@@ -455,11 +464,20 @@ static unsigned int futex_poll(struct fi
 			       struct poll_table_struct *wait)
 {
 	struct futex_q *q = filp->private_data;
-	struct futex_hash_bucket *bh = hash_futex(&q->key);
+	union futex_key key;
+	struct futex_hash_bucket *bh;
 	int ret = 0;
 
 	poll_wait(filp, &q->waiters, wait);
+again:
+	key = q->key;
+	bh = hash_futex(&key);
 	spin_lock(&bh->lock);
+	if (unlikely(!match_futex(&key, q->key)) {
+		/* Race against futex_requeue */
+		spin_unlock(&bh_lock);
+		goto again;
+	}
 	if (list_empty(&q->list))
 		ret = POLLIN | POLLRDNORM;
 	spin_unlock(&bh->lock);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
