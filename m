Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbULJEtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbULJEtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULJEtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:49:09 -0500
Received: from waste.org ([209.173.204.2]:49386 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261705AbULJEsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:48:04 -0500
Date: Thu, 9 Dec 2004 20:47:59 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041210044759.GQ8876@waste.org>
References: <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209212936.GO8876@waste.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 01:29:36PM -0800, Matt Mackall wrote:
> On Wed, Dec 08, 2004 at 08:57:05PM -0500, Theodore Ts'o wrote:
> > On Wed, Dec 08, 2004 at 01:56:14PM -0800, Matt Mackall wrote:
> > > 
> > > Ted, I think this is a bit more straightforward than your patch, and
> > > safer as it protects get_random_bytes() and internal extract_entropy()
> > > users. And I'd be leery of your get_cpu() trick due to preempt
> > > issues.
> > > 
> > 
> > I'm concerned that turning off interrupts during even a single SHA-1
> > transform will put us above the radar with respect to the preempt
> > latency statistics again.  We could use a separate spinlock that only
> > pretects the mix_ptr and mixing access to the pool, so we're at least
> > not disabling interrupts, but we still are holding a spinlock across a
> > cryptographic operation.
> 
> It's been suggested to me that a sequence lock might be the right
> approach to this, which I'll try to take a look at this evening. Also,
> I'm going to time the lock hold time in my previous more conventional
> patch and see what kind of neighborhood we're in.

Seqlock seems to not be a terribly good fit.

I benched SHATransform + add_entropy_works, and came up with ~2us on
1.8GHz P4M. I'm guessing this is under the latency radar. 

But it turns out that we can do this without hashing under the lock
after all. What's important is that we mix and extract atomically.
Something like this should be quite reasonable:

Index: random/drivers/char/random.c
===================================================================
--- random.orig/drivers/char/random.c	2004-12-08 18:17:21.000000000 -0800
+++ random/drivers/char/random.c	2004-12-10 02:43:10.280668659 -0800
@@ -573,7 +573,7 @@
  * the entropy is concentrated in the low-order bits.
  */
 static void add_entropy_words(struct entropy_store *r, const __u32 *in,
-			      int nwords)
+			      int nwords, __u32 out[16])
 {
 	static __u32 const twist_table[8] = {
 		         0, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
@@ -623,6 +623,13 @@
 		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
 	}
 
+	if (out) {
+		for (i = 0; i < 16; i++) {
+			out[i] = r->pool[add_ptr];
+			add_ptr = (add_ptr - 1) & wordmask;
+		}
+	}
+
 	r->input_rotate = input_rotate;
 	r->add_ptr = add_ptr;
 
@@ -763,7 +770,7 @@
 							sec_random_state;
 			max_entropy = r->poolinfo.POOLBITS;
 		}
-		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
+		add_entropy_words(r, batch_entropy_copy[tail].data, 2, NULL);
 		credit_entropy_store(r, batch_entropy_copy[tail].credit);
 		tail = (tail+1) & (batch_max-1);
 	}
@@ -1320,7 +1327,7 @@
 
 		bytes=extract_entropy(random_state, tmp, bytes,
 				      EXTRACT_ENTROPY_LIMIT);
-		add_entropy_words(r, tmp, bytes);
+		add_entropy_words(r, tmp, bytes, NULL);
 		credit_entropy_store(r, bytes*8);
 	}
 }
@@ -1342,7 +1349,7 @@
 			       size_t nbytes, int flags)
 {
 	ssize_t ret, i;
-	__u32 tmp[TMP_BUF_SIZE];
+	__u32 tmp[TMP_BUF_SIZE], data[16];
 	__u32 x;
 	unsigned long cpuflags;
 
@@ -1418,11 +1425,21 @@
 		 * attempts to find previous ouputs), unless the hash
 		 * function can be inverted.
 		 */
-		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
+		for (i = 16, x = 2; i < r->poolinfo.poolwords; i += 16, x+=2) {
 			HASH_TRANSFORM(tmp, r->pool+i);
-			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
+			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE],
+					  1, NULL);
 		}
-		
+
+		/*
+		 * To avoid duplicates, we hash the first block last,
+		 * atomically extract a portion of the pool while mixing,
+		 * and hash one final time.
+		 */
+		HASH_TRANSFORM(tmp, r->pool);
+		add_entropy_words(r, &tmp[0], 1, data);
+		HASH_TRANSFORM(tmp, data);
+
 		/*
 		 * In case the hash function has some recognizable
 		 * output pattern, we fold it in half.
@@ -1503,7 +1520,7 @@
 	do_gettimeofday(&tv);
 	words[0] = tv.tv_sec;
 	words[1] = tv.tv_usec;
-	add_entropy_words(r, words, 2);
+	add_entropy_words(r, words, 2, NULL);
 
 	/*
 	 *	This doesn't lock system.utsname. However, we are generating
@@ -1512,7 +1529,7 @@
 	p = (char *) &system_utsname;
 	for (i = sizeof(system_utsname) / sizeof(words); i; i--) {
 		memcpy(words, p, sizeof(words));
-		add_entropy_words(r, words, sizeof(words)/4);
+		add_entropy_words(r, words, sizeof(words)/4, NULL);
 		p += sizeof(words);
 	}
 }
@@ -1716,7 +1733,7 @@
 		c -= bytes;
 		p += bytes;
 
-		add_entropy_words(random_state, buf, (bytes + 3) / 4);
+		add_entropy_words(random_state, buf, (bytes + 3) / 4, NULL);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1855,7 +1872,7 @@
 		return ret;
 
 	add_entropy_words(new_store, random_state->pool,
-			  random_state->poolinfo.poolwords);
+			  random_state->poolinfo.poolwords, NULL);
 	credit_entropy_store(new_store, random_state->entropy_count);
 
 	sysctl_init_random(new_store);



-- 
Mathematics is the supreme nostalgia of our time.
