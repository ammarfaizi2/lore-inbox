Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbULJV31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbULJV31 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbULJV30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:29:26 -0500
Received: from THUNK.ORG ([69.25.196.29]:14739 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261212AbULJV2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:28:25 -0500
Date: Fri, 10 Dec 2004 16:28:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: Bernard Normier <bernard@zeroc.com>, linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041210212815.GB25409@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>, Bernard Normier <bernard@zeroc.com>,
	linux-kernel@vger.kernel.org
References: <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org> <20041210044759.GQ8876@waste.org> <20041210163558.GB10639@thunk.org> <20041210182804.GT8876@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210182804.GT8876@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 10:28:04AM -0800, Matt Mackall wrote:
> 
> Fair enough. s/__add/mix/, please.
> 

Why?  Fundamentally, it's all about adding entropy to the pool.  I
don't have an strong objection to calling it __mix_entropy_words, but
if we're going to change it, we should change the non-__ variant for
consistency's sake, and I'd much rather do that in a separate patch if
we're going to do it all.  I don't see the point of the rename,
though.

> It won't work as in we'll still get duplicates? I don't see how that
> happens. The polynomial for the output pools is dense enough that even
> on the very next one word mix, we're getting 96 bits changed in the
> output and 32 new ones shifted in. And we're always doing at least
> three adds for each pull.

You're right, it should be OK.  I was concerned about the case where
some percentage of the pool was still all zero's, and what might
happen if two adjacent add_entropy_words() mixed in the same data (as
could still happen).  But one of the add_entropy_words() will be mixed
in first, and even if the other add_entropy_words mixes in the exact
same data, the data[] returned by first and second add_entropy_words()
will be different, and we should be OK.

Still, I'd feel better if we did initialize more data via
init_std_data(), and then cranked the LFSR some number of times so
that we don't have to worry about analyzing the case where a good
portion of the pool might contain consecutive zero values.  But yeah,
we can save that for another patch, as it's not absolutely essential.

Are we converging here?

						- Ted

This patch fixes a problem where /dev/urandom can return duplicate
values when two processors read from it at the same time.  It relies
on the fact that we already are taking a lock in add_entropy_words(),
and atomically hashes in some freshly mixed in data into the returned
randomness.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

--- 1.60/drivers/char/random.c	2004-11-18 17:23:14 -05:00
+++ edited/drivers/char/random.c	2004-12-10 16:26:51 -05:00
@@ -572,8 +572,8 @@ static void free_entropy_store(struct en
  * it's cheap to do so and helps slightly in the expected case where
  * the entropy is concentrated in the low-order bits.
  */
-static void add_entropy_words(struct entropy_store *r, const __u32 *in,
-			      int nwords)
+static void __add_entropy_words(struct entropy_store *r, const __u32 *in,
+				int nwords, __u32 out[16])
 {
 	static __u32 const twist_table[8] = {
 		         0, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
@@ -626,9 +626,23 @@ static void add_entropy_words(struct ent
 	r->input_rotate = input_rotate;
 	r->add_ptr = add_ptr;
 
+	if (out) {
+		for (i = 0; i < 16; i++) {
+			out[i] = r->pool[add_ptr];
+			add_ptr = (add_ptr - 1) & wordmask;
+		}
+	}
+
 	spin_unlock_irqrestore(&r->lock, flags);
 }
 
+static inline void add_entropy_words(struct entropy_store *r, const __u32 *in,
+				     int nwords)
+{
+	__add_entropy_words(r, in, nwords, NULL);
+}
+
+
 /*
  * Credit (or debit) the entropy store with n bits of entropy
  */
@@ -1342,7 +1356,7 @@ static ssize_t extract_entropy(struct en
 			       size_t nbytes, int flags)
 {
 	ssize_t ret, i;
-	__u32 tmp[TMP_BUF_SIZE];
+	__u32 tmp[TMP_BUF_SIZE], data[16];
 	__u32 x;
 	unsigned long cpuflags;
 
@@ -1422,7 +1436,15 @@ static ssize_t extract_entropy(struct en
 			HASH_TRANSFORM(tmp, r->pool+i);
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
-		
+
+		/*
+		 * To avoid duplicates, we atomically extract a
+		 * portion of the pool while mixing, and hash one
+		 * final time.
+		 */
+		__add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1, data);
+		HASH_TRANSFORM(tmp, data);
+
 		/*
 		 * In case the hash function has some recognizable
 		 * output pattern, we fold it in half.
