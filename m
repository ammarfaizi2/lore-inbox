Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbULIC7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbULIC7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 21:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbULIC7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 21:59:03 -0500
Received: from waste.org ([209.173.204.2]:33179 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261444AbULIC6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 21:58:54 -0500
Date: Wed, 8 Dec 2004 18:58:31 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041209025831.GK8876@waste.org>
References: <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209015705.GB6978@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 08:57:05PM -0500, Theodore Ts'o wrote:
> On Wed, Dec 08, 2004 at 01:56:14PM -0800, Matt Mackall wrote:
> > 
> > Ted, I think this is a bit more straightforward than your patch, and
> > safer as it protects get_random_bytes() and internal extract_entropy()
> > users. And I'd be leery of your get_cpu() trick due to preempt
> > issues.
> 
> I'm concerned that turning off interrupts during even a single SHA-1
> transform will put us above the radar with respect to the preempt
> latency statistics again.  We could use a separate spinlock that only
> pretects the mix_ptr and mixing access to the pool, so we're at least
> not disabling interrupts, but we still are holding a spinlock across a
> cryptographic operation.

A big mixlock was my first thought, but it'd still have to be _irqsave
as we can reach extract_entropy from irq handlers.
 
> So I've come up with another trick which I think avoids needing to add
> additional locking altogether.  What we do is we diddle the initial
> HASH input values with the following values: initial the processor ID,
> the current task pointer, and preempt_count().  On an UP system with
> preemption, it won't matter if we get preempted, since on a UP system
> access to the pool is by definition serialized :-).  On a SMP system
> with preemption, while we could theoretically get preempted away and
> then scheduled on another CPU, just in time for another process to
> call extract_entropy(), the task identifier is enough to guarantee a
> unique starting point.  The reason for adding preempt_count() is so we
> can deal with the case where a process gets interrupted, and the
> bottom half handler calls get_random_bytes(), and at the same time
> said process gets preempted away to another CPU().  I think this
> covers all of the cases.....
> 
> Yeah, it would be simper to reason about things if we were to just put
> it under the spinlock, but everyone seems tp be on a reduce latency at
> all costs kick as of late.  :-)

I'd like to combine this with my approach of fiddling with the mixing
offset in a similar manner. In the duplicate case, we were basically
returning SHA(x[y]) twice and now we're returning SHA(x[y]^knowns).
This makes me a bit uneasy. I'd rather do SHA(x[knowns%sizeof(x)]^knowns2),
then we've at least got some different _unknowns_ in the hash from the
attacker's perspective, yes?

Something like:

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: random/drivers/char/random.c
===================================================================
--- random.orig/drivers/char/random.c	2004-12-08 18:17:21.000000000 -0800
+++ random/drivers/char/random.c	2004-12-08 18:47:17.914493794 -0800
@@ -1343,7 +1343,7 @@
 {
 	ssize_t ret, i;
 	__u32 tmp[TMP_BUF_SIZE];
-	__u32 x;
+	__u32 x, offset, wrap;
 	unsigned long cpuflags;
 
 
@@ -1402,14 +1402,35 @@
 				  sec_random_state->entropy_count);
 		}
 
-		/* Hash the pool to get the output */
-		tmp[0] = 0x67452301;
+		/*
+		 * Hash the pool to get the output.
+		 *
+		 * We diddle the initial inputs so that if two
+		 * processors are executing extract_entropy
+		 * concurrently, they will get different results. Even
+		 * if we get preempted and moved to another CPU, the
+		 * combination of initial CPU, task pointer, and
+		 * preempt count is good enough to avoid duplication.
+		 * We could instead use more locking here, but the
+		 * resulting latency is painful.
+		 */
+		tmp[0] = 0x67452301 ^ smp_processor_id();
 		tmp[1] = 0xefcdab89;
-		tmp[2] = 0x98badcfe;
+		tmp[2] = 0x98badcfe ^ preempt_count();
 		tmp[3] = 0x10325476;
 #ifdef USE_SHA
 		tmp[4] = 0xc3d2e1f0;
 #endif
+
+		/*
+		 * Generate an offset for mixing (multiple of 16) so
+		 * that we have different unknowns in the mix in the
+		 * concurrent case as well.
+		 */
+
+		wrap = r->poolinfo.poolwords;
+		offset = ((__u32)current * 8675309 % wrap) & ~15;
+
 		/*
 		 * As we hash the pool, we mix intermediate values of
 		 * the hash back into the pool.  This eliminates
@@ -1419,10 +1440,10 @@
 		 * function can be inverted.
 		 */
 		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
-			HASH_TRANSFORM(tmp, r->pool+i);
+			HASH_TRANSFORM(tmp, r->pool + (i + offset) % wrap);
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
-		
+
 		/*
 		 * In case the hash function has some recognizable
 		 * output pattern, we fold it in half.


-- 
Mathematics is the supreme nostalgia of our time.
