Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVASI2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVASI2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVASI0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:26:21 -0500
Received: from waste.org ([216.27.176.166]:29100 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261669AbVASIRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:17:03 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.64403262@selenic.com>
Message-Id: <3.64403262@selenic.com>
Subject: [PATCH 2/12] random pt3: Static allocation of pools
Date: Wed, 19 Jan 2005 00:17:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we no longer allow resizing of pools, it makes sense to allocate
and initialize them statically. Remove create_entropy_store and
simplify rand_initialize.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:22:06.531748727 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:34:46.175902338 -0800
@@ -295,42 +295,37 @@
 	int poolwords;
 	int tap1, tap2, tap3, tap4, tap5;
 } poolinfo_table[] = {
+	/* x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 -- 105 */
+	{ 128,	103,	76,	51,	25,	1 },
+	/* x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 -- 15 */
+	{ 32,	26,	20,	14,	7,	1 },
+#if 0
 	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
 	{ 2048,	1638,	1231,	819,	411,	1 },
 
 	/* x^1024 + x^817 + x^615 + x^412 + x^204 + x + 1 -- 290 */
 	{ 1024,	817,	615,	412,	204,	1 },
-#if 0				/* Alternate polynomial */
+
 	/* x^1024 + x^819 + x^616 + x^410 + x^207 + x^2 + 1 -- 115 */
 	{ 1024,	819,	616,	410,	207,	2 },
-#endif
 
 	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
 	{ 512,	411,	308,	208,	104,	1 },
-#if 0				/* Alternates */
+
 	/* x^512 + x^409 + x^307 + x^206 + x^102 + x^2 + 1 -- 95 */
 	{ 512,	409,	307,	206,	102,	2 },
 	/* x^512 + x^409 + x^309 + x^205 + x^103 + x^2 + 1 -- 95 */
 	{ 512,	409,	309,	205,	103,	2 },
-#endif
 
 	/* x^256 + x^205 + x^155 + x^101 + x^52 + x + 1 -- 125 */
 	{ 256,	205,	155,	101,	52,	1 },
 
-	/* x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 -- 105 */
-	{ 128,	103,	76,	51,	25,	1 },
-#if 0	/* Alternate polynomial */
 	/* x^128 + x^103 + x^78 + x^51 + x^27 + x^2 + 1 -- 70 */
 	{ 128,	103,	78,	51,	27,	2 },
-#endif
 
 	/* x^64 + x^52 + x^39 + x^26 + x^14 + x + 1 -- 15 */
 	{ 64,	52,	39,	26,	14,	1 },
-
-	/* x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 -- 15 */
-	{ 32,	26,	20,	14,	7,	1 },
-
-	{ 0,	0,	0,	0,	0,	0 },
+#endif
 };
 
 #define POOLBITS	poolwords*32
@@ -382,9 +377,6 @@
 /*
  * Static global variables
  */
-static struct entropy_store *input_pool; /* The default global store */
-static struct entropy_store *blocking_pool; /* secondary store */
-static struct entropy_store *nonblocking_pool; /* For urandom */
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -392,7 +384,8 @@
  * Forward procedure declarations
  */
 #ifdef CONFIG_SYSCTL
-static void sysctl_init_random(struct entropy_store *random_state);
+struct entropy_store;
+static void sysctl_init_random(struct entropy_store *pool);
 #endif
 
 static inline __u32 rol32(__u32 word, int shift)
@@ -406,9 +399,9 @@
 #define DEBUG_ENT(fmt, arg...) do { if (debug) \
 	printk(KERN_DEBUG "random %04d %04d %04d: " \
 	fmt,\
-	input_pool->entropy_count,\
-	blocking_pool->entropy_count,\
-	nonblocking_pool->entropy_count,\
+	input_pool.entropy_count,\
+	blocking_pool.entropy_count,\
+	nonblocking_pool.entropy_count,\
 	## arg); } while (0)
 #else
 #define DEBUG_ENT(fmt, arg...) do {} while (0)
@@ -423,7 +416,7 @@
 
 struct entropy_store {
 	/* mostly-read data: */
-	struct poolinfo poolinfo;
+	struct poolinfo *poolinfo;
 	__u32 *pool;
 	const char *name;
 
@@ -434,48 +427,30 @@
 	int input_rotate;
 };
 
-/*
- * Initialize the entropy store.  The input argument is the size of
- * the random pool.
- *
- * Returns an negative error if there is a problem.
- */
-static int create_entropy_store(int size, const char *name,
-				struct entropy_store **ret_bucket)
-{
-	struct entropy_store *r;
-	struct poolinfo *p;
-	int poolwords;
-
-	poolwords = (size + 3) / 4; /* Convert bytes->words */
-	/* The pool size must be a multiple of 16 32-bit words */
-	poolwords = ((poolwords + 15) / 16) * 16;
+static __u32 input_pool_data[INPUT_POOL_WORDS];
+static __u32 blocking_pool_data[OUTPUT_POOL_WORDS];
+static __u32 nonblocking_pool_data[OUTPUT_POOL_WORDS];
+
+static struct entropy_store input_pool = {
+	.poolinfo = &poolinfo_table[0],
+	.name = "input",
+	.lock = SPIN_LOCK_UNLOCKED,
+	.pool = input_pool_data
+};
 
-	for (p = poolinfo_table; p->poolwords; p++) {
-		if (poolwords == p->poolwords)
-			break;
-	}
-	if (p->poolwords == 0)
-		return -EINVAL;
+static struct entropy_store blocking_pool = {
+	.poolinfo = &poolinfo_table[1],
+	.name = "blocking",
+	.lock = SPIN_LOCK_UNLOCKED,
+	.pool = blocking_pool_data
+};
 
-	r = kmalloc(sizeof(struct entropy_store), GFP_KERNEL);
-	if (!r)
-		return -ENOMEM;
-
-	memset (r, 0, sizeof(struct entropy_store));
-	r->poolinfo = *p;
-
-	r->pool = kmalloc(POOLBYTES, GFP_KERNEL);
-	if (!r->pool) {
-		kfree(r);
-		return -ENOMEM;
-	}
-	memset(r->pool, 0, POOLBYTES);
-	r->lock = SPIN_LOCK_UNLOCKED;
-	r->name = name;
-	*ret_bucket = r;
-	return 0;
-}
+static struct entropy_store nonblocking_pool = {
+	.poolinfo = &poolinfo_table[1],
+	.name = "nonblocking",
+	.lock = SPIN_LOCK_UNLOCKED,
+	.pool = nonblocking_pool_data
+};
 
 /*
  * This function adds a byte into the entropy "pool".  It does not
@@ -495,16 +470,16 @@
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
 	unsigned long i, add_ptr, tap1, tap2, tap3, tap4, tap5;
 	int new_rotate, input_rotate;
-	int wordmask = r->poolinfo.poolwords - 1;
+	int wordmask = r->poolinfo->poolwords - 1;
 	__u32 w, next_w;
 	unsigned long flags;
 
 	/* Taps are constant, so we can load them without holding r->lock.  */
-	tap1 = r->poolinfo.tap1;
-	tap2 = r->poolinfo.tap2;
-	tap3 = r->poolinfo.tap3;
-	tap4 = r->poolinfo.tap4;
-	tap5 = r->poolinfo.tap5;
+	tap1 = r->poolinfo->tap1;
+	tap2 = r->poolinfo->tap2;
+	tap3 = r->poolinfo->tap3;
+	tap4 = r->poolinfo->tap4;
+	tap5 = r->poolinfo->tap5;
 	next_w = *in++;
 
 	spin_lock_irqsave(&r->lock, flags);
@@ -570,8 +545,8 @@
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
@@ -660,7 +635,7 @@
 static void batch_entropy_process(void *private_)
 {
 	struct entropy_store *r	= (struct entropy_store *) private_, *p;
-	int max_entropy = r->poolinfo.POOLBITS;
+	int max_entropy = r->poolinfo->POOLBITS;
 	unsigned head, tail;
 
 	/* Mixing into the pool is expensive, so copy over the batch
@@ -682,8 +657,9 @@
 	p = r;
 	while (head != tail) {
 		if (r->entropy_count >= max_entropy) {
-			r = (r == blocking_pool) ? input_pool : blocking_pool;
-			max_entropy = r->poolinfo.POOLBITS;
+			r = (r == &blocking_pool) ? &input_pool :
+				&blocking_pool;
+			max_entropy = r->poolinfo->POOLBITS;
 		}
 		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
 		credit_entropy_store(r, batch_entropy_copy[tail].credit);
@@ -727,7 +703,7 @@
 
 	preempt_disable();
 	/* if over the trickle threshold, use only 1 in 4096 samples */
-	if (input_pool->entropy_count > trickle_thresh &&
+	if (input_pool.entropy_count > trickle_thresh &&
 	    (__get_cpu_var(trickle_count)++ & 0xfff))
 		goto out;
 
@@ -1226,7 +1202,7 @@
 				       size_t nbytes, __u32 *tmp)
 {
 	if (r->entropy_count < nbytes * 8 &&
-	    r->entropy_count < r->poolinfo.POOLBITS) {
+	    r->entropy_count < r->poolinfo->POOLBITS) {
 		int bytes = max_t(int, random_read_wakeup_thresh / 8,
 				min_t(int, nbytes, TMP_BUF_SIZE));
 
@@ -1234,7 +1210,7 @@
 			  "(%d of %d requested)\n",
 			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
-		bytes=extract_entropy(input_pool, tmp, bytes,
+		bytes=extract_entropy(&input_pool, tmp, bytes,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1263,8 +1239,8 @@
 	unsigned long cpuflags;
 
 	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo.POOLBITS)
-		r->entropy_count = r->poolinfo.POOLBITS;
+	if (r->entropy_count > r->poolinfo->POOLBITS)
+		r->entropy_count = r->poolinfo->POOLBITS;
 
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
 		xfer_secondary_pool(r, nbytes, tmp);
@@ -1323,7 +1299,7 @@
 		 * attempts to find previous ouputs), unless the hash
 		 * function can be inverted.
 		 */
-		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
+		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
 			HASH_TRANSFORM(tmp, r->pool+i);
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
@@ -1377,21 +1353,8 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	struct entropy_store *r = nonblocking_pool;
-	int flags = EXTRACT_ENTROPY_SECONDARY;
-
-	if (!r)
-		r = blocking_pool;
-	if (!r) {
-		r = input_pool;
-		flags = 0;
-	}
-	if (!r) {
-		printk(KERN_NOTICE "get_random_bytes called before "
-				   "random driver initialization\n");
-		return;
-	}
-	extract_entropy(r, (char *) buf, nbytes, flags);
+	extract_entropy(&nonblocking_pool, (char *) buf, nbytes,
+			EXTRACT_ENTROPY_SECONDARY);
 }
 
 EXPORT_SYMBOL(get_random_bytes);
@@ -1422,21 +1385,13 @@
 
 static int __init rand_initialize(void)
 {
-	if (create_entropy_store(INPUT_POOL_WORDS, "input", &input_pool))
-		goto err;
-	if (batch_entropy_init(BATCH_ENTROPY_SIZE, input_pool))
-		goto err;
-	if (create_entropy_store(OUTPUT_POOL_WORDS, "blocking",
-				 &blocking_pool))
-		goto err;
-	if (create_entropy_store(OUTPUT_POOL_WORDS, "nonblocking",
-				 &nonblocking_pool))
+	if (batch_entropy_init(BATCH_ENTROPY_SIZE, &input_pool))
 		goto err;
-	init_std_data(input_pool);
-	init_std_data(blocking_pool);
-	init_std_data(nonblocking_pool);
+	init_std_data(&input_pool);
+	init_std_data(&blocking_pool);
+	init_std_data(&nonblocking_pool);
 #ifdef CONFIG_SYSCTL
-	sysctl_init_random(input_pool);
+	sysctl_init_random(&input_pool);
 #endif
 	return 0;
 err:
@@ -1492,7 +1447,7 @@
 
 		DEBUG_ENT("reading %d bits\n", n*8);
 
-		n = extract_entropy(blocking_pool, buf, n,
+		n = extract_entropy(&blocking_pool, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT |
 				    EXTRACT_ENTROPY_SECONDARY);
@@ -1509,7 +1464,7 @@
 			DEBUG_ENT("sleeping?\n");
 
 			wait_event_interruptible(random_read_wait,
-				input_pool->entropy_count >=
+				input_pool.entropy_count >=
 						 random_read_wakeup_thresh);
 
 			DEBUG_ENT("awake\n");
@@ -1549,12 +1504,12 @@
 	int flags = EXTRACT_ENTROPY_USER;
 	unsigned long cpuflags;
 
-	spin_lock_irqsave(&input_pool->lock, cpuflags);
-	if (input_pool->entropy_count > input_pool->poolinfo.POOLBITS)
+	spin_lock_irqsave(&input_pool.lock, cpuflags);
+	if (input_pool.entropy_count > input_pool.poolinfo->POOLBITS)
 		flags |= EXTRACT_ENTROPY_SECONDARY;
-	spin_unlock_irqrestore(&input_pool->lock, cpuflags);
+	spin_unlock_irqrestore(&input_pool.lock, cpuflags);
 
-	return extract_entropy(nonblocking_pool, buf, nbytes, flags);
+	return extract_entropy(&nonblocking_pool, buf, nbytes, flags);
 }
 
 static unsigned int
@@ -1565,9 +1520,9 @@
 	poll_wait(file, &random_read_wait, wait);
 	poll_wait(file, &random_write_wait, wait);
 	mask = 0;
-	if (input_pool->entropy_count >= random_read_wakeup_thresh)
+	if (input_pool.entropy_count >= random_read_wakeup_thresh)
 		mask |= POLLIN | POLLRDNORM;
-	if (input_pool->entropy_count < random_write_wakeup_thresh)
+	if (input_pool.entropy_count < random_write_wakeup_thresh)
 		mask |= POLLOUT | POLLWRNORM;
 	return mask;
 }
@@ -1593,7 +1548,7 @@
 		c -= bytes;
 		p += bytes;
 
-		add_entropy_words(input_pool, buf, (bytes + 3) / 4);
+		add_entropy_words(&input_pool, buf, (bytes + 3) / 4);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1614,7 +1569,7 @@
 
 	switch (cmd) {
 	case RNDGETENTCNT:
-		ent_count = input_pool->entropy_count;
+		ent_count = input_pool.entropy_count;
 		if (put_user(ent_count, p))
 			return -EFAULT;
 		return 0;
@@ -1623,12 +1578,12 @@
 			return -EPERM;
 		if (get_user(ent_count, p))
 			return -EFAULT;
-		credit_entropy_store(input_pool, ent_count);
+		credit_entropy_store(&input_pool, ent_count);
 		/*
 		 * Wake up waiting processes if we have enough
 		 * entropy.
 		 */
-		if (input_pool->entropy_count >= random_read_wakeup_thresh)
+		if (input_pool.entropy_count >= random_read_wakeup_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDADDENTROPY:
@@ -1644,12 +1599,12 @@
 				      size, &file->f_pos);
 		if (retval < 0)
 			return retval;
-		credit_entropy_store(input_pool, ent_count);
+		credit_entropy_store(&input_pool, ent_count);
 		/*
 		 * Wake up waiting processes if we have enough
 		 * entropy.
 		 */
-		if (input_pool->entropy_count >= random_read_wakeup_thresh)
+		if (input_pool.entropy_count >= random_read_wakeup_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDZAPENTCNT:
@@ -1657,9 +1612,9 @@
 		/* Clear the entropy pool counters. */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		init_std_data(input_pool);
-		init_std_data(blocking_pool);
-		init_std_data(nonblocking_pool);
+		init_std_data(&input_pool);
+		init_std_data(&blocking_pool);
+		init_std_data(&nonblocking_pool);
 		return 0;
 	default:
 		return -EINVAL;
@@ -1842,7 +1797,7 @@
 {
 	min_read_thresh = 8;
 	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh = pool->poolinfo.POOLBITS;
+	max_read_thresh = max_write_thresh = pool->poolinfo->POOLBITS;
 	random_table[1].data = &pool->entropy_count;
 }
 #endif 	/* CONFIG_SYSCTL */
