Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbUCZBp5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbUCZBp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 20:45:57 -0500
Received: from palrel12.hp.com ([156.153.255.237]:6023 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263811AbUCZBps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 20:45:48 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16483.35656.864787.827149@napali.hpl.hp.com>
Date: Thu, 25 Mar 2004 17:45:44 -0800
To: Matt Mackall <mpm@selenic.com>
Cc: David Mosberger <davidm@napali.hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: potential /dev/urandom scalability improvement
In-Reply-To: <20040325224726.GB8366@waste.org>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 25 Mar 2004 16:47:27 -0600, Matt Mackall <mpm@selenic.com> said:

  >> I'm addressing this patch to you because you seem to have been
  >> the person who most recently made some performance improvements
  >> to the random driver.

  Matt> That was probably me, actually.

Sorry, that's what I get for trusting the BK log.

  Matt> However, I've got a few pending patches that touch the same
  Matt> areas and do some more critical cleanup that I've been sitting
  Matt> on since the 2.6.0 freeze. So perhaps I should start pushing
  Matt> those again and we can queue this behind them. David, if you
  Matt> get a chance, grab the latest copy of my linux-tiny tree from

  Matt>
  Matt> http://www.selenic.com/tiny/2.6.5-rc2-tiny1-broken-out.tar.bz2
  Matt> http://www.selenic.com/tiny/2.6.5-rc2-tiny1.patch.bz2

  Matt> and see how I've tweaked the pool structure and the locking
  Matt> and how your bits fit with it.

Not much left of the original bits!

  >> +#ifdef ARCH_HAS_PREFETCH

  Matt> Can we avoid adding this ifdef in some fashion? What does the
  Matt> compiler generate here when prefetch is a no-op? This seems to
  Matt> call for a prefetch_range(start, len) function/macro in any
  Matt> case.

Sounds reasonable, but I would prefer to do this in separate steps.

I tried your changes and performance was virtually unchanged.  The
patch below is updated to go on top of your patch and gives about the
same performance as I reported yesterday.  For now, I defined an
inline prefetch_range().  If and when all architectures get updated to
define this directly, we can simply remove prefetch_range() from the
driver.

Thanks

	--david

--
--- drivers/char/random.c	2004-03-25 17:41:54.432358997 -0800
+++ drivers/char/random.c-davidm	2004-03-25 17:34:59.040063215 -0800
@@ -421,14 +421,20 @@
  **********************************************************************/
 
 struct entropy_store {
+	/* mostly-read data: */
 	const char *name;
+	struct poolinfo *poolinfo;
+	__u32 *pool;
+	/*
+	 * read-write data (colocate with lock such that when we get
+	 * the lock, we get the other data for "free"; may cause some
+	 * extra bus-transactions, though):
+	 */
+	spinlock_t lock ____cacheline_aligned;
 	unsigned add_ptr;
 	int entropy_count;
 	int input_rotate;
 	int reserved;
-	struct poolinfo *poolinfo;
-	spinlock_t lock;
-	__u32 *pool;
 };
 
 static __u32 input_pool_data[INPUT_POOL_WORDS];
@@ -456,6 +462,16 @@
 	.pool = nonblocking_pool_data
 };
 
+static inline void
+prefetch_range (void *addr, size_t len)
+{
+#ifdef ARCH_HAS_PREFETCH
+	char *cp, *end = (char *) addr + len;
+	for (cp = addr; cp < end; cp += PREFETCH_STRIDE)
+		prefetch(cp);
+#endif
+}
+
 /*
  * This function adds words into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
@@ -472,17 +488,30 @@
 	static __u32 const twist_table[8] = {
 		         0, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
-	unsigned i;
-	int new_rotate;
-	int wordmask = r->poolinfo->poolwords - 1;
-	__u32 w;
-	unsigned long flags;
+	unsigned long i, add_ptr, tap1, tap2, tap3, tap4, tap5;
+	int new_rotate, input_rotate;
+	unsigned long flags, wordmask = r->poolinfo->poolwords - 1;
+	__u32 w, next_w, *pool = r->pool;
+
+	/* Taps are constant, so we can load them without holding r->lock.  */
+	tap1 = r->poolinfo->tap1;
+	tap2 = r->poolinfo->tap2;
+	tap3 = r->poolinfo->tap3;
+	tap4 = r->poolinfo->tap4;
+	tap5 = r->poolinfo->tap5;
+	next_w = *in++;
 
 	spin_lock_irqsave(&r->lock, flags);
 
+	prefetch_range(pool, 4 * (wordmask + 1));
+	input_rotate = r->input_rotate;
+	add_ptr = r->add_ptr;
+
 	while (nwords--) {
-		w = rol32(*in++, r->input_rotate);
-		i = r->add_ptr = (r->add_ptr - 1) & wordmask;
+		w = rol32(next_w, input_rotate);
+		if (nwords > 0)
+			next_w = *in++;
+		i = add_ptr = (add_ptr - 1) & wordmask;
 
 		/*
 		 * Normally, we add 7 bits of rotation to the pool.
@@ -490,21 +519,24 @@
 		 * rotation, so that successive passes spread the
 		 * input bits across the pool evenly.
 		 */
-		new_rotate = r->input_rotate + 14;
+		new_rotate = input_rotate + 14;
 		if (i)
-			new_rotate = r->input_rotate + 7;
-		r->input_rotate = new_rotate & 31;
+			new_rotate = input_rotate + 7;
+		input_rotate = new_rotate & 31;
 
 		/* XOR in the various taps */
-		w ^= r->pool[(i + r->poolinfo->tap1) & wordmask];
-		w ^= r->pool[(i + r->poolinfo->tap2) & wordmask];
-		w ^= r->pool[(i + r->poolinfo->tap3) & wordmask];
-		w ^= r->pool[(i + r->poolinfo->tap4) & wordmask];
-		w ^= r->pool[(i + r->poolinfo->tap5) & wordmask];
-		w ^= r->pool[i];
-		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
+		w ^= pool[(i + tap1) & wordmask];
+		w ^= pool[(i + tap2) & wordmask];
+		w ^= pool[(i + tap3) & wordmask];
+		w ^= pool[(i + tap4) & wordmask];
+		w ^= pool[(i + tap5) & wordmask];
+		w ^= pool[i];
+		pool[i] = (w >> 3) ^ twist_table[w & 7];
 	}
 
+	r->input_rotate = input_rotate;
+	r->add_ptr = add_ptr;
+
 	spin_unlock_irqrestore(&r->lock, flags);
 }
 
