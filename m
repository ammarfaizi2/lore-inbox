Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbUCZBOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbUCZACr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:02:47 -0500
Received: from waste.org ([209.173.204.2]:50329 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263822AbUCYX6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:01 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6.524465763@selenic.com>
Message-Id: <7.524465763@selenic.com>
Subject: [PATCH 6/22] /dev/random: simplify pool initialization
Date: Thu, 25 Mar 2004 17:57:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  simplify pool initialization


 tiny-mpm/drivers/char/random.c |   86 ++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 51 deletions(-)

diff -puN drivers/char/random.c~pool-init drivers/char/random.c
--- tiny/drivers/char/random.c~pool-init	2004-03-20 13:38:19.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:19.000000000 -0600
@@ -497,19 +497,12 @@ struct entropy_store {
 	unsigned add_ptr;
 	int entropy_count;
 	int input_rotate;
-	struct poolinfo poolinfo;
-	__u32 *pool;
+	struct poolinfo *poolinfo;
 	spinlock_t lock;
+	__u32 pool[0];
 };
 
-/*
- * Initialize the entropy store.  The input argument is the size of
- * the random pool.
- *
- * Returns an negative error if there is a problem.
- */
-static int create_entropy_store(int size, const char *name,
-				struct entropy_store **ret_bucket)
+static struct entropy_store *create_entropy_store(int size, const char *name)
 {
 	struct	entropy_store	*r;
 	struct	poolinfo	*p;
@@ -524,25 +517,18 @@ static int create_entropy_store(int size
 			break;
 	}
 	if (p->poolwords == 0)
-		return -EINVAL;
+		return 0;
 
-	r = kmalloc(sizeof(struct entropy_store), GFP_KERNEL);
+	r = kmalloc(sizeof(struct entropy_store)+POOLBYTES, GFP_KERNEL);
 	if (!r)
-		return -ENOMEM;
+		return 0;
 
-	memset (r, 0, sizeof(struct entropy_store));
-	r->poolinfo = *p;
+	memset(r, 0, sizeof(struct entropy_store));
+	r->poolinfo = p;
 	r->name = name;
-
-	r->pool = kmalloc(POOLBYTES, GFP_KERNEL);
-	if (!r->pool) {
-		kfree(r);
-		return -ENOMEM;
-	}
-	memset(r->pool, 0, POOLBYTES);
 	r->lock = SPIN_LOCK_UNLOCKED;
-	*ret_bucket = r;
-	return 0;
+
+	return r;
 }
 
 /* Clear the entropy pool and associated counters. */
@@ -551,11 +537,11 @@ static void clear_entropy_store(struct e
 	r->add_ptr = 0;
 	r->entropy_count = 0;
 	r->input_rotate = 0;
-	memset(r->pool, 0, r->poolinfo.POOLBYTES);
+	memset(r->pool, 0, r->poolinfo->POOLBYTES);
 }
 
 /*
- * This function adds a byte into the entropy "pool".  It does not
+ * This function adds words into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
  * credit_entropy_store if this is appropriate.
  * 
@@ -572,7 +558,7 @@ static void add_entropy_words(struct ent
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
 	unsigned i;
 	int new_rotate;
-	int wordmask = r->poolinfo.poolwords - 1;
+	int wordmask = r->poolinfo->poolwords - 1;
 	__u32 w;
 	unsigned long flags;
 
@@ -593,11 +579,11 @@ static void add_entropy_words(struct ent
 		r->input_rotate = new_rotate & 31;
 
 		/* XOR in the various taps */
-		w ^= r->pool[(i + r->poolinfo.tap1) & wordmask];
-		w ^= r->pool[(i + r->poolinfo.tap2) & wordmask];
-		w ^= r->pool[(i + r->poolinfo.tap3) & wordmask];
-		w ^= r->pool[(i + r->poolinfo.tap4) & wordmask];
-		w ^= r->pool[(i + r->poolinfo.tap5) & wordmask];
+		w ^= r->pool[(i + r->poolinfo->tap1) & wordmask];
+		w ^= r->pool[(i + r->poolinfo->tap2) & wordmask];
+		w ^= r->pool[(i + r->poolinfo->tap3) & wordmask];
+		w ^= r->pool[(i + r->poolinfo->tap4) & wordmask];
+		w ^= r->pool[(i + r->poolinfo->tap5) & wordmask];
 		w ^= r->pool[i];
 		r->pool[i] = (w >> 3) ^ twist_table[w & 7];
 	}
@@ -618,8 +604,8 @@ static void credit_entropy_store(struct 
 		DEBUG_ENT("negative entropy/overflow (%d+%d)\n",
 			  r->entropy_count, nbits);
 		r->entropy_count = 0;
-	} else if (r->entropy_count + nbits > r->poolinfo.POOLBITS) {
-		r->entropy_count = r->poolinfo.POOLBITS;
+	} else if (r->entropy_count + nbits > r->poolinfo->POOLBITS) {
+		r->entropy_count = r->poolinfo->POOLBITS;
 	} else {
 		r->entropy_count += nbits;
 		if (nbits)
@@ -714,7 +700,7 @@ EXPORT_SYMBOL(batch_entropy_store);
 static void batch_entropy_process(void *private_)
 {
 	struct entropy_store *r	= (struct entropy_store *) private_, *p;
-	int max_entropy = r->poolinfo.POOLBITS;
+	int max_entropy = r->poolinfo->POOLBITS;
 	unsigned head, tail;
 
 	/* Mixing into the pool is expensive, so copy over the batch
@@ -738,7 +724,7 @@ static void batch_entropy_process(void *
 		if (r->entropy_count >= max_entropy) {
 			r = (r == blocking_pool) ? input_pool :
 							blocking_pool;
-			max_entropy = r->poolinfo.POOLBITS;
+			max_entropy = r->poolinfo->POOLBITS;
 		}
 		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
 		credit_entropy_store(r, batch_entropy_copy[tail].credit);
@@ -1290,7 +1276,7 @@ static inline void xfer_secondary_pool(s
 				       size_t nbytes, __u32 *tmp)
 {
 	if (r->entropy_count < nbytes * 8 &&
-	    r->entropy_count < r->poolinfo.POOLBITS) {
+	    r->entropy_count < r->poolinfo->POOLBITS) {
 		int bytes = max_t(int, random_read_wakeup_thresh / 8,
 				min_t(int, nbytes, TMP_BUF_SIZE));
 
@@ -1328,8 +1314,8 @@ static ssize_t extract_entropy(struct en
 
 
 	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo.POOLBITS)
-		r->entropy_count = r->poolinfo.POOLBITS;
+	if (r->entropy_count > r->poolinfo->POOLBITS)
+		r->entropy_count = r->poolinfo->POOLBITS;
 
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
 		xfer_secondary_pool(r, nbytes, tmp);
@@ -1386,7 +1372,7 @@ static ssize_t extract_entropy(struct en
 		 * attempts to find previous ouputs), unless the hash
 		 * function can be inverted.
 		 */
-		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
+		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
 			HASH_TRANSFORM(tmp, r->pool+i);
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
@@ -1482,15 +1468,15 @@ static int __init rand_initialize(void)
 {
 	int i;
 
-	if (create_entropy_store(INPUT_POOL_SIZE, "input", &input_pool))
-		goto err;
+	input_pool = create_entropy_store(INPUT_POOL_SIZE, "input");
+	blocking_pool = create_entropy_store(BLOCKING_POOL_SIZE, "blocking");
+
+	if (!(input_pool && blocking_pool))
+		return -1;
+
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, input_pool))
-		goto err;
-	if (create_entropy_store(BLOCKING_POOL_SIZE, "blocking",
-				 &blocking_pool))
-		goto err;
-	clear_entropy_store(input_pool);
-	clear_entropy_store(blocking_pool);
+		return -1;
+
 	init_std_data(input_pool);
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(input_pool);
@@ -1502,8 +1488,6 @@ static int __init rand_initialize(void)
 	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
 	extract_timer_state.dont_count_entropy = 1;
 	return 0;
-err:
-	return -1;
 }
 module_init(rand_initialize);
 
@@ -1893,7 +1877,7 @@ static void sysctl_init_random(struct en
 {
 	min_read_thresh = 8;
 	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh = pool->poolinfo.POOLBITS;
+	max_read_thresh = max_write_thresh = pool->poolinfo->POOLBITS;
 	random_table[0].data = &pool->entropy_count;
 }
 #endif 	/* CONFIG_SYSCTL */

_
