Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263833AbUCZCBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 21:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbUCZCBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 21:01:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:26292 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263833AbUCZCBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 21:01:07 -0500
Date: Thu, 25 Mar 2004 18:00:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-Id: <20040325180014.29e40b65.akpm@osdl.org>
In-Reply-To: <16483.35656.864787.827149@napali.hpl.hp.com>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> The
>  patch below is updated to go on top of your patch and gives about the
>  same performance as I reported yesterday.  For now, I defined an
>  inline prefetch_range().  If and when all architectures get updated to
>  define this directly, we can simply remove prefetch_range() from the
>  driver.

We may as well stick prefetch_range() in prefetch.h.

And Matt's patch series is not a thing I want to take on board at present,
so let's stick with the straight scalability patch for now.

I moved the prefetch_range() call to outside the spinlock.  Does that make
sense?

 25-akpm/drivers/char/random.c    |   51 ++++++++++++++++++++++++++-------------
 25-akpm/include/linux/prefetch.h |   11 ++++++++
 2 files changed, 46 insertions(+), 16 deletions(-)

diff -puN drivers/char/random.c~urandom-scalability-fix drivers/char/random.c
--- 25/drivers/char/random.c~urandom-scalability-fix	2004-03-25 17:53:57.498675480 -0800
+++ 25-akpm/drivers/char/random.c	2004-03-25 17:57:39.795881168 -0800
@@ -490,12 +490,15 @@ static inline __u32 int_ln_12bits(__u32 
  **********************************************************************/
 
 struct entropy_store {
+	/* mostly-read data: */
+	struct poolinfo poolinfo;
+	__u32		*pool;
+
+	/* read-write data: */
+	spinlock_t lock ____cacheline_aligned;
 	unsigned	add_ptr;
 	int		entropy_count;
 	int		input_rotate;
-	struct poolinfo poolinfo;
-	__u32		*pool;
-	spinlock_t lock;
 };
 
 /*
@@ -571,38 +574,54 @@ static void add_entropy_words(struct ent
 	static __u32 const twist_table[8] = {
 		         0, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
-	unsigned i;
-	int new_rotate;
+	unsigned long i, add_ptr, tap1, tap2, tap3, tap4, tap5;
+	int new_rotate, input_rotate;
 	int wordmask = r->poolinfo.poolwords - 1;
-	__u32 w;
+	__u32 w, next_w;
 	unsigned long flags;
 
+	/* Taps are constant, so we can load them without holding r->lock.  */
+	tap1 = r->poolinfo.tap1;
+	tap2 = r->poolinfo.tap2;
+	tap3 = r->poolinfo.tap3;
+	tap4 = r->poolinfo.tap4;
+	tap5 = r->poolinfo.tap5;
+	next_w = *in++;
+
+	prefetch_range(r->pool, wordmask);
 	spin_lock_irqsave(&r->lock, flags);
+	input_rotate = r->input_rotate;
+	add_ptr = r->add_ptr;
 
 	while (nwords--) {
-		w = rotate_left(r->input_rotate, *in++);
-		i = r->add_ptr = (r->add_ptr - 1) & wordmask;
+		w = rotate_left(input_rotate, next_w);
+		if (nwords > 0)
+			next_w = *in++;
+		i = add_ptr = (add_ptr - 1) & wordmask;
 		/*
 		 * Normally, we add 7 bits of rotation to the pool.
 		 * At the beginning of the pool, add an extra 7 bits
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
-		w ^= r->pool[(i + r->poolinfo.tap1) & wordmask];
-		w ^= r->pool[(i + r->poolinfo.tap2) & wordmask];
-		w ^= r->pool[(i + r->poolinfo.tap3) & wordmask];
-		w ^= r->pool[(i + r->poolinfo.tap4) & wordmask];
-		w ^= r->pool[(i + r->poolinfo.tap5) & wordmask];
+		w ^= r->pool[(i + tap1) & wordmask];
+		w ^= r->pool[(i + tap2) & wordmask];
+		w ^= r->pool[(i + tap3) & wordmask];
+		w ^= r->pool[(i + tap4) & wordmask];
+		w ^= r->pool[(i + tap5) & wordmask];
 		w ^= r->pool[i];
 		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
 	}
 
+	r->input_rotate = input_rotate;
+	r->add_ptr = add_ptr;
+
 	spin_unlock_irqrestore(&r->lock, flags);
 }
 
diff -puN include/linux/prefetch.h~urandom-scalability-fix include/linux/prefetch.h
--- 25/include/linux/prefetch.h~urandom-scalability-fix	2004-03-25 17:54:27.279148160 -0800
+++ 25-akpm/include/linux/prefetch.h	2004-03-25 17:55:34.456935584 -0800
@@ -54,4 +54,15 @@ static inline void prefetchw(const void 
 #define PREFETCH_STRIDE (4*L1_CACHE_BYTES)
 #endif
 
+static inline void prefetch_range(void *addr, size_t len)
+{
+#ifdef ARCH_HAS_PREFETCH
+	char *cp;
+	char *end = addr + len;
+
+	for (cp = addr; cp < end; cp += PREFETCH_STRIDE)
+		prefetch(cp);
+#endif
+}
+
 #endif

_

