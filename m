Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbULHV42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbULHV42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbULHV42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:56:28 -0500
Received: from waste.org ([209.173.204.2]:30688 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261372AbULHV4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:56:22 -0500
Date: Wed, 8 Dec 2004 13:56:14 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041208215614.GA12189@waste.org>
References: <006001c4d4c2$14470880$6400a8c0@centrino> <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208192126.GA5769@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 02:21:27PM -0500, Theodore Ts'o wrote:
> On Tue, Dec 07, 2004 at 08:56:17PM -0500, Bernard Normier wrote:
> > In which version of 2.6 did this bug get fixed? I am seeing these 
> > duplicates with 2.6.9-1.667smp (FC3)?
> 
> SMP locking was added before 2.6.0 shipped (between 2.6.0-test7 and
> -test8).  But I see what happened; the problem is that the locking was
> added around add_entropy_words(), and not in the extract_entropy loop.
> Yes, extract_entropy() does call add_entropy_words() (which makes the
> fix more than just a two-line patch), but if two processors enter
> extract_entropy() at the same time, the locking turns out not to be
> sufficient.  

Oh, duh. Thought I'd looked at that race. Because of the locking in
add_entropy_words, each CPU is mixing "tmp" into r in a serialized
fashion. However, before grabbing the pool lock, they can be grabbing
the same tmp from the pool and then sending that off to userspace.

So the requirement is this: we have to extract data from the pool AND
change the pool state sufficiently to avoid identical extraction in
one atomic step. We can do either an entire pool mix atomically (which
is ideal, but expensive), or we can avoid using the same bits of the
pool for mixing/extraction with a mixing pointer. We don't care if the
mixing pointer wraps around because when that happens, we've done a
full mix.

Ted, I think this is a bit more straightforward than your patch, and
safer as it protects get_random_bytes() and internal extract_entropy()
users. And I'd be leery of your get_cpu() trick due to preempt
issues.

Index: linux/drivers/char/random.c
===================================================================
--- linux.orig/drivers/char/random.c	2004-10-18 14:53:11.000000000 -0700
+++ linux/drivers/char/random.c	2004-12-08 13:52:42.729730568 -0800
@@ -498,7 +498,7 @@
 
 	/* read-write data: */
 	spinlock_t lock ____cacheline_aligned_in_smp;
-	unsigned	add_ptr;
+	unsigned	add_ptr, mix_ptr;
 	int		entropy_count;
 	int		input_rotate;
 };
@@ -550,6 +550,7 @@
 static void clear_entropy_store(struct entropy_store *r)
 {
 	r->add_ptr = 0;
+	r->mix_ptr = 0;
 	r->entropy_count = 0;
 	r->input_rotate = 0;
 	memset(r->pool, 0, r->poolinfo.POOLBYTES);
@@ -572,7 +573,7 @@
  * it's cheap to do so and helps slightly in the expected case where
  * the entropy is concentrated in the low-order bits.
  */
-static void add_entropy_words(struct entropy_store *r, const __u32 *in,
+static void __add_entropy_words(struct entropy_store *r, const __u32 *in,
 			      int nwords)
 {
 	static __u32 const twist_table[8] = {
@@ -582,9 +583,7 @@
 	int new_rotate, input_rotate;
 	int wordmask = r->poolinfo.poolwords - 1;
 	__u32 w, next_w;
-	unsigned long flags;
 
-	/* Taps are constant, so we can load them without holding r->lock.  */
 	tap1 = r->poolinfo.tap1;
 	tap2 = r->poolinfo.tap2;
 	tap3 = r->poolinfo.tap3;
@@ -592,7 +591,6 @@
 	tap5 = r->poolinfo.tap5;
 	next_w = *in++;
 
-	spin_lock_irqsave(&r->lock, flags);
 	prefetch_range(r->pool, wordmask);
 	input_rotate = r->input_rotate;
 	add_ptr = r->add_ptr;
@@ -625,7 +623,14 @@
 
 	r->input_rotate = input_rotate;
 	r->add_ptr = add_ptr;
+}
 
+static void add_entropy_words(struct entropy_store *r, const __u32 *in,
+			      int nwords)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&r->lock, flags);
+	__add_entropy_words(r, in, nwords);
 	spin_unlock_irqrestore(&r->lock, flags);
 }
 
@@ -1425,12 +1430,22 @@
 		 * the state of the pool plus the current outputs, and
 		 * attempts to find previous ouputs), unless the hash
 		 * function can be inverted.
+		 *
+		 * We must hash and mix as an atomic operation to
+		 * avoid threads grabbing the same hash. The mix_ptr
+		 * lets us mix less than the whole pool and still pull
+		 * unique hashes.
 		 */
-		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
-			HASH_TRANSFORM(tmp, r->pool+i);
-			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
+		for (i = 0; i < r->poolinfo.poolwords/16; i++) {
+			spin_lock_irqsave(&r->lock, flags);
+			HASH_TRANSFORM(tmp, r->pool+r->mix_ptr);
+			r->mix_ptr = (r->mix_ptr + 16) &
+				(r->poolinfo.poolwords - 1);
+			__add_entropy_words(r,
+					    &tmp[(i*2)%HASH_BUFFER_SIZE], 1);
+			spin_unlock_irqrestore(&r->lock, flags);
 		}
-		
+
 		/*
 		 * In case the hash function has some recognizable
 		 * output pattern, we fold it in half.


-- 
Mathematics is the supreme nostalgia of our time.
