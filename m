Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbULJQhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbULJQhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbULJQhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:37:09 -0500
Received: from THUNK.ORG ([69.25.196.29]:59793 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261751AbULJQgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:36:09 -0500
Date: Fri, 10 Dec 2004 11:35:58 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matt Mackall <mpm@selenic.com>
Cc: Bernard Normier <bernard@zeroc.com>, linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041210163558.GB10639@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Matt Mackall <mpm@selenic.com>, Bernard Normier <bernard@zeroc.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org> <20041210044759.GQ8876@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210044759.GQ8876@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 08:47:59PM -0800, Matt Mackall wrote:
> 
> But it turns out that we can do this without hashing under the lock
> after all. What's important is that we mix and extract atomically.
> Something like this should be quite reasonable:

The core idea is good, but your patch has a bug in it; it bashes
add_ptr before it gets saved into r->add_ptr.  Also, it's a more
complicated than it needed to be (which makes it harder to analyze
it).  Finally, it won't work if the pool doesn't get initialized with
sufficient randomness in the init scripts, and there are too many
constant zero's in the pool.  But this is easily fixed by using a
different initialization pattern.

How about this?

						- Ted

This patch fixes a problem where /dev/urandom can return duplicate
values when two processors read from it at the same time.  It relies
on the fact that we already are taking a lock in add_entropy_words(),
and atomically hashes in some freshly mixed in data into the returned
randomness.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

--- 1.60/drivers/char/random.c	2004-11-18 17:23:14 -05:00
+++ edited/drivers/char/random.c	2004-12-10 11:23:55 -05:00
@@ -549,10 +549,13 @@ static int create_entropy_store(int size
 /* Clear the entropy pool and associated counters. */
 static void clear_entropy_store(struct entropy_store *r)
 {
+	int i;
+
 	r->add_ptr = 0;
 	r->entropy_count = 0;
 	r->input_rotate = 0;
-	memset(r->pool, 0, r->poolinfo.POOLBYTES);
+	for (i=0; i < r->poolinfo.poolwords; i++)
+		r->pool[i] = i;
 }
 #ifdef CONFIG_SYSCTL
 static void free_entropy_store(struct entropy_store *r)
@@ -572,8 +575,8 @@ static void free_entropy_store(struct en
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
@@ -626,9 +629,23 @@ static void add_entropy_words(struct ent
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
@@ -1342,7 +1359,7 @@ static ssize_t extract_entropy(struct en
 			       size_t nbytes, int flags)
 {
 	ssize_t ret, i;
-	__u32 tmp[TMP_BUF_SIZE];
+	__u32 tmp[TMP_BUF_SIZE], data[16];
 	__u32 x;
 	unsigned long cpuflags;
 
@@ -1422,7 +1439,15 @@ static ssize_t extract_entropy(struct en
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
