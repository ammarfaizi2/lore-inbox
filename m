Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVASInT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVASInT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVASIdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:33:04 -0500
Received: from waste.org ([216.27.176.166]:20652 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261661AbVASIQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:16:56 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1.64403262@selenic.com>
Message-Id: <2.64403262@selenic.com>
Subject: [PATCH 1/12] random pt3: More meaningful pool names
Date: Wed, 19 Jan 2005 00:17:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Give pools more meaningful names.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:21:12.250668976 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:21:12.314660818 -0800
@@ -256,8 +256,8 @@
 /*
  * Configuration information
  */
-#define DEFAULT_POOL_SIZE 512
-#define SECONDARY_POOL_SIZE 128
+#define INPUT_POOL_WORDS 128
+#define OUTPUT_POOL_WORDS 32
 #define BATCH_ENTROPY_SIZE 256
 #define USE_SHA
 
@@ -279,7 +279,7 @@
  * samples to avoid wasting CPU time and reduce lock contention.
  */
 
-static int trickle_thresh = DEFAULT_POOL_SIZE * 7;
+static int trickle_thresh = INPUT_POOL_WORDS * 28;
 
 static DEFINE_PER_CPU(int, trickle_count) = 0;
 
@@ -382,9 +382,9 @@
 /*
  * Static global variables
  */
-static struct entropy_store *random_state; /* The default global store */
-static struct entropy_store *sec_random_state; /* secondary store */
-static struct entropy_store *urandom_state; /* For urandom */
+static struct entropy_store *input_pool; /* The default global store */
+static struct entropy_store *blocking_pool; /* secondary store */
+static struct entropy_store *nonblocking_pool; /* For urandom */
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -406,9 +406,9 @@
 #define DEBUG_ENT(fmt, arg...) do { if (debug) \
 	printk(KERN_DEBUG "random %04d %04d %04d: " \
 	fmt,\
-	random_state->entropy_count,\
-	sec_random_state->entropy_count,\
-	urandom_state->entropy_count,\
+	input_pool->entropy_count,\
+	blocking_pool->entropy_count,\
+	nonblocking_pool->entropy_count,\
 	## arg); } while (0)
 #else
 #define DEBUG_ENT(fmt, arg...) do {} while (0)
@@ -653,9 +653,9 @@
 }
 
 /*
- * Flush out the accumulated entropy operations, adding entropy to the passed
- * store (normally random_state).  If that store has enough entropy, alternate
- * between randomizing the data of the primary and secondary stores.
+ * Flush out the accumulated entropy operations, adding entropy to the
+ * input pool.  If that pool has enough entropy, alternate
+ * between randomizing the data of all pools.
  */
 static void batch_entropy_process(void *private_)
 {
@@ -682,8 +682,7 @@
 	p = r;
 	while (head != tail) {
 		if (r->entropy_count >= max_entropy) {
-			r = (r == sec_random_state) ? random_state :
-				sec_random_state;
+			r = (r == blocking_pool) ? input_pool : blocking_pool;
 			max_entropy = r->poolinfo.POOLBITS;
 		}
 		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
@@ -728,7 +727,7 @@
 
 	preempt_disable();
 	/* if over the trickle threshold, use only 1 in 4096 samples */
-	if (random_state->entropy_count > trickle_thresh &&
+	if (input_pool->entropy_count > trickle_thresh &&
 	    (__get_cpu_var(trickle_count)++ & 0xfff))
 		goto out;
 
@@ -1235,7 +1234,7 @@
 			  "(%d of %d requested)\n",
 			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
-		bytes=extract_entropy(random_state, tmp, bytes,
+		bytes=extract_entropy(input_pool, tmp, bytes,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1378,13 +1377,13 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	struct entropy_store *r = urandom_state;
+	struct entropy_store *r = nonblocking_pool;
 	int flags = EXTRACT_ENTROPY_SECONDARY;
 
 	if (!r)
-		r = sec_random_state;
+		r = blocking_pool;
 	if (!r) {
-		r = random_state;
+		r = input_pool;
 		flags = 0;
 	}
 	if (!r) {
@@ -1423,21 +1422,21 @@
 
 static int __init rand_initialize(void)
 {
-	if (create_entropy_store(DEFAULT_POOL_SIZE, "primary", &random_state))
+	if (create_entropy_store(INPUT_POOL_WORDS, "input", &input_pool))
 		goto err;
-	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
+	if (batch_entropy_init(BATCH_ENTROPY_SIZE, input_pool))
 		goto err;
-	if (create_entropy_store(SECONDARY_POOL_SIZE, "secondary",
-				 &sec_random_state))
+	if (create_entropy_store(OUTPUT_POOL_WORDS, "blocking",
+				 &blocking_pool))
 		goto err;
-	if (create_entropy_store(SECONDARY_POOL_SIZE, "urandom",
-				 &urandom_state))
+	if (create_entropy_store(OUTPUT_POOL_WORDS, "nonblocking",
+				 &nonblocking_pool))
 		goto err;
-	init_std_data(random_state);
-	init_std_data(sec_random_state);
-	init_std_data(urandom_state);
+	init_std_data(input_pool);
+	init_std_data(blocking_pool);
+	init_std_data(nonblocking_pool);
 #ifdef CONFIG_SYSCTL
-	sysctl_init_random(random_state);
+	sysctl_init_random(input_pool);
 #endif
 	return 0;
 err:
@@ -1493,7 +1492,7 @@
 
 		DEBUG_ENT("reading %d bits\n", n*8);
 
-		n = extract_entropy(sec_random_state, buf, n,
+		n = extract_entropy(blocking_pool, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT |
 				    EXTRACT_ENTROPY_SECONDARY);
@@ -1510,7 +1509,7 @@
 			DEBUG_ENT("sleeping?\n");
 
 			wait_event_interruptible(random_read_wait,
-				random_state->entropy_count >=
+				input_pool->entropy_count >=
 						 random_read_wakeup_thresh);
 
 			DEBUG_ENT("awake\n");
@@ -1550,12 +1549,12 @@
 	int flags = EXTRACT_ENTROPY_USER;
 	unsigned long cpuflags;
 
-	spin_lock_irqsave(&random_state->lock, cpuflags);
-	if (random_state->entropy_count > random_state->poolinfo.POOLBITS)
+	spin_lock_irqsave(&input_pool->lock, cpuflags);
+	if (input_pool->entropy_count > input_pool->poolinfo.POOLBITS)
 		flags |= EXTRACT_ENTROPY_SECONDARY;
-	spin_unlock_irqrestore(&random_state->lock, cpuflags);
+	spin_unlock_irqrestore(&input_pool->lock, cpuflags);
 
-	return extract_entropy(urandom_state, buf, nbytes, flags);
+	return extract_entropy(nonblocking_pool, buf, nbytes, flags);
 }
 
 static unsigned int
@@ -1566,9 +1565,9 @@
 	poll_wait(file, &random_read_wait, wait);
 	poll_wait(file, &random_write_wait, wait);
 	mask = 0;
-	if (random_state->entropy_count >= random_read_wakeup_thresh)
+	if (input_pool->entropy_count >= random_read_wakeup_thresh)
 		mask |= POLLIN | POLLRDNORM;
-	if (random_state->entropy_count < random_write_wakeup_thresh)
+	if (input_pool->entropy_count < random_write_wakeup_thresh)
 		mask |= POLLOUT | POLLWRNORM;
 	return mask;
 }
@@ -1594,7 +1593,7 @@
 		c -= bytes;
 		p += bytes;
 
-		add_entropy_words(random_state, buf, (bytes + 3) / 4);
+		add_entropy_words(input_pool, buf, (bytes + 3) / 4);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1615,7 +1614,7 @@
 
 	switch (cmd) {
 	case RNDGETENTCNT:
-		ent_count = random_state->entropy_count;
+		ent_count = input_pool->entropy_count;
 		if (put_user(ent_count, p))
 			return -EFAULT;
 		return 0;
@@ -1624,12 +1623,12 @@
 			return -EPERM;
 		if (get_user(ent_count, p))
 			return -EFAULT;
-		credit_entropy_store(random_state, ent_count);
+		credit_entropy_store(input_pool, ent_count);
 		/*
 		 * Wake up waiting processes if we have enough
 		 * entropy.
 		 */
-		if (random_state->entropy_count >= random_read_wakeup_thresh)
+		if (input_pool->entropy_count >= random_read_wakeup_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDADDENTROPY:
@@ -1645,12 +1644,12 @@
 				      size, &file->f_pos);
 		if (retval < 0)
 			return retval;
-		credit_entropy_store(random_state, ent_count);
+		credit_entropy_store(input_pool, ent_count);
 		/*
 		 * Wake up waiting processes if we have enough
 		 * entropy.
 		 */
-		if (random_state->entropy_count >= random_read_wakeup_thresh)
+		if (input_pool->entropy_count >= random_read_wakeup_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDZAPENTCNT:
@@ -1658,9 +1657,9 @@
 		/* Clear the entropy pool counters. */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		init_std_data(random_state);
-		init_std_data(sec_random_state);
-		init_std_data(urandom_state);
+		init_std_data(input_pool);
+		init_std_data(blocking_pool);
+		init_std_data(nonblocking_pool);
 		return 0;
 	default:
 		return -EINVAL;
@@ -1780,7 +1779,7 @@
 	return 1;
 }
 
-static int sysctl_poolsize = DEFAULT_POOL_SIZE;
+static int sysctl_poolsize = INPUT_POOL_WORDS * 32;
 ctl_table random_table[] = {
 	{
 		.ctl_name 	= RANDOM_POOLSIZE,
@@ -1839,12 +1838,12 @@
 	{ .ctl_name = 0 }
 };
 
-static void sysctl_init_random(struct entropy_store *random_state)
+static void sysctl_init_random(struct entropy_store *pool)
 {
 	min_read_thresh = 8;
 	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh = random_state->poolinfo.POOLBITS;
-	random_table[1].data = &random_state->entropy_count;
+	max_read_thresh = max_write_thresh = pool->poolinfo.POOLBITS;
+	random_table[1].data = &pool->entropy_count;
 }
 #endif 	/* CONFIG_SYSCTL */
 
