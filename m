Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbUCZABl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263835AbUCZAAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:00:08 -0500
Received: from waste.org ([209.173.204.2]:48537 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263818AbUCYX6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.524465763@selenic.com>
Message-Id: <6.524465763@selenic.com>
Subject: [PATCH 5/22] /dev/random: pool struct cleanup and rename
Date: Thu, 25 Mar 2004 17:57:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  pool struct cleanup and rename

Give pools more meaningful names and embed name field in pool struct.
Preparation for multiple output pools.


 tiny-mpm/drivers/char/random.c |  118 +++++++++++++++++++----------------------
 1 files changed, 56 insertions(+), 62 deletions(-)

diff -puN drivers/char/random.c~pool-rename drivers/char/random.c
--- tiny/drivers/char/random.c~pool-rename	2004-03-20 13:38:16.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:16.000000000 -0600
@@ -263,8 +263,8 @@
 /*
  * Configuration information
  */
-#define DEFAULT_POOL_SIZE 512
-#define SECONDARY_POOL_SIZE 128
+#define INPUT_POOL_SIZE 512
+#define BLOCKING_POOL_SIZE 128
 #define BATCH_ENTROPY_SIZE 256
 #define USE_SHA
 
@@ -286,7 +286,7 @@ static int random_write_wakeup_thresh = 
  * samples to avoid wasting CPU time and reduce lock contention.
  */
 
-static int trickle_thresh = DEFAULT_POOL_SIZE * 7;
+static int trickle_thresh = INPUT_POOL_SIZE * 7;
 
 static DEFINE_PER_CPU(int, trickle_count) = 0;
 
@@ -399,8 +399,8 @@ static struct poolinfo {
 /*
  * Static global variables
  */
-static struct entropy_store *random_state; /* The default global store */
-static struct entropy_store *sec_random_state; /* secondary store */
+static struct entropy_store *input_pool; /* The default global store */
+static struct entropy_store *blocking_pool; /* secondary store */
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -408,7 +408,7 @@ static DECLARE_WAIT_QUEUE_HEAD(random_wr
  * Forward procedure declarations
  */
 #ifdef CONFIG_SYSCTL
-static void sysctl_init_random(struct entropy_store *random_state);
+static void sysctl_init_random(struct entropy_store *pool);
 #endif
 
 /*****************************************************************
@@ -478,8 +478,8 @@ static inline __u32 int_ln_12bits(__u32 
 
 #if 0
 #define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random %04d %04d: " fmt,\
-	random_state->entropy_count,\
-	sec_random_state->entropy_count,\
+	input_pool->entropy_count,\
+	blocking_pool->entropy_count,\
 	## arg)
 #else
 #define DEBUG_ENT(fmt, arg...) do {} while (0)
@@ -493,11 +493,12 @@ static inline __u32 int_ln_12bits(__u32 
  **********************************************************************/
 
 struct entropy_store {
-	unsigned	add_ptr;
-	int		entropy_count;
-	int		input_rotate;
+	const char *name;
+	unsigned add_ptr;
+	int entropy_count;
+	int input_rotate;
 	struct poolinfo poolinfo;
-	__u32		*pool;
+	__u32 *pool;
 	spinlock_t lock;
 };
 
@@ -507,7 +508,8 @@ struct entropy_store {
  *
  * Returns an negative error if there is a problem.
  */
-static int create_entropy_store(int size, struct entropy_store **ret_bucket)
+static int create_entropy_store(int size, const char *name,
+				struct entropy_store **ret_bucket)
 {
 	struct	entropy_store	*r;
 	struct	poolinfo	*p;
@@ -530,6 +532,7 @@ static int create_entropy_store(int size
 
 	memset (r, 0, sizeof(struct entropy_store));
 	r->poolinfo = *p;
+	r->name = name;
 
 	r->pool = kmalloc(POOLBYTES, GFP_KERNEL);
 	if (!r->pool) {
@@ -620,10 +623,7 @@ static void credit_entropy_store(struct 
 	} else {
 		r->entropy_count += nbits;
 		if (nbits)
-			DEBUG_ENT("added %d bits to %s\n",
-				  nbits,
-				  r == sec_random_state ? "secondary" :
-				  r == random_state ? "primary" : "unknown");
+			DEBUG_ENT("added %d bits to %s\n", nbits, r->name);
 	}
 
 	spin_unlock_irqrestore(&r->lock, flags);
@@ -707,9 +707,9 @@ void batch_entropy_store(u32 a, u32 b, i
 EXPORT_SYMBOL(batch_entropy_store);
 
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
@@ -736,8 +736,8 @@ static void batch_entropy_process(void *
 	p = r;
 	while (head != tail) {
 		if (r->entropy_count >= max_entropy) {
-			r = (r == sec_random_state) ?	random_state :
-							sec_random_state;
+			r = (r == blocking_pool) ? input_pool :
+							blocking_pool;
 			max_entropy = r->poolinfo.POOLBITS;
 		}
 		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
@@ -785,7 +785,7 @@ static void add_timer_randomness(struct 
 	int		entropy = 0;
 
 	/* if over the trickle threshold, use only 1 in 4096 samples */
-	if ( random_state->entropy_count > trickle_thresh &&
+	if ( input_pool->entropy_count > trickle_thresh &&
 	     (__get_cpu_var(trickle_count)++ & 0xfff))
 		return;
 
@@ -1295,11 +1295,10 @@ static inline void xfer_secondary_pool(s
 				min_t(int, nbytes, TMP_BUF_SIZE));
 
 		DEBUG_ENT("going to reseed %s with %d bits "
-			  "(%d of %d requested)\n",
-			  r == sec_random_state ? "secondary" : "unknown",
+			  "(%d of %d requested)\n", r->name,
 			  bytes * 8, nbytes * 8, r->entropy_count);
 
-		bytes=extract_entropy(random_state, tmp, bytes,
+		bytes=extract_entropy(input_pool, tmp, bytes,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1338,10 +1337,7 @@ static ssize_t extract_entropy(struct en
 	/* Hold lock while accounting */
 	spin_lock_irqsave(&r->lock, cpuflags);
 
-	DEBUG_ENT("trying to extract %d bits from %s\n",
-		  nbytes * 8,
-		  r == sec_random_state ? "secondary" :
-		  r == random_state ? "primary" : "unknown");
+	DEBUG_ENT("trying to extract %d bits from %s\n", nbytes * 8, r->name);
 
 	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8)
 		nbytes = r->entropy_count / 8;
@@ -1354,10 +1350,7 @@ static ssize_t extract_entropy(struct en
 	if (r->entropy_count < random_write_wakeup_thresh)
 		wake_up_interruptible(&random_write_wait);
 
-	DEBUG_ENT("debiting %d bits from %s%s\n",
-		  nbytes * 8,
-		  r == sec_random_state ? "secondary" :
-		  r == random_state ? "primary" : "unknown",
+	DEBUG_ENT("debiting %d bits from %s%s\n", nbytes * 8, r->name,
 		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
 
 	spin_unlock_irqrestore(&r->lock, cpuflags);
@@ -1438,11 +1431,11 @@ static ssize_t extract_entropy(struct en
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	if (sec_random_state)  
-		extract_entropy(sec_random_state, (char *) buf, nbytes, 
+	if (blocking_pool)
+		extract_entropy(blocking_pool, (char *) buf, nbytes,
 				EXTRACT_ENTROPY_SECONDARY);
-	else if (random_state)
-		extract_entropy(random_state, (char *) buf, nbytes, 0);
+	else if (input_pool)
+		extract_entropy(input_pool, (char *) buf, nbytes, 0);
 	else
 		printk(KERN_NOTICE "get_random_bytes called before "
 				   "random driver initialization\n");
@@ -1489,17 +1482,18 @@ static int __init rand_initialize(void)
 {
 	int i;
 
-	if (create_entropy_store(DEFAULT_POOL_SIZE, &random_state))
+	if (create_entropy_store(INPUT_POOL_SIZE, "input", &input_pool))
 		goto err;
-	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
+	if (batch_entropy_init(BATCH_ENTROPY_SIZE, input_pool))
 		goto err;
-	if (create_entropy_store(SECONDARY_POOL_SIZE, &sec_random_state))
+	if (create_entropy_store(BLOCKING_POOL_SIZE, "blocking",
+				 &blocking_pool))
 		goto err;
-	clear_entropy_store(random_state);
-	clear_entropy_store(sec_random_state);
-	init_std_data(random_state);
+	clear_entropy_store(input_pool);
+	clear_entropy_store(blocking_pool);
+	init_std_data(input_pool);
 #ifdef CONFIG_SYSCTL
-	sysctl_init_random(random_state);
+	sysctl_init_random(input_pool);
 #endif
 	for (i = 0; i < NR_IRQS; i++)
 		irq_timer_state[i] = NULL;
@@ -1561,7 +1555,7 @@ random_read(struct file * file, char * b
 
 		DEBUG_ENT("reading %d bits\n", n*8);
 
-		n = extract_entropy(sec_random_state, buf, n,
+		n = extract_entropy(blocking_pool, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT |
 				    EXTRACT_ENTROPY_SECONDARY);
@@ -1578,7 +1572,7 @@ random_read(struct file * file, char * b
 			DEBUG_ENT("sleeping?\n");
 
 			wait_event_interruptible(random_read_wait,
-				random_state->entropy_count >=
+				input_pool->entropy_count >=
 						 random_read_wakeup_thresh);
 
 			DEBUG_ENT("awake\n");
@@ -1615,7 +1609,7 @@ static ssize_t
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(sec_random_state, buf, nbytes,
+	return extract_entropy(blocking_pool, buf, nbytes,
 			       EXTRACT_ENTROPY_USER |
 			       EXTRACT_ENTROPY_SECONDARY);
 }
@@ -1628,9 +1622,9 @@ random_poll(struct file *file, poll_tabl
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
@@ -1656,7 +1650,7 @@ random_write(struct file * file, const c
 		c -= bytes;
 		p += bytes;
 
-		add_entropy_words(random_state, buf, (bytes + 3) / 4);
+		add_entropy_words(input_pool, buf, (bytes + 3) / 4);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1676,7 +1670,7 @@ random_ioctl(struct inode * inode, struc
 
 	switch (cmd) {
 	case RNDGETENTCNT:
-		ent_count = random_state->entropy_count;
+		ent_count = input_pool->entropy_count;
 		if (put_user(ent_count, (int *) arg))
 			return -EFAULT;
 		return 0;
@@ -1685,12 +1679,12 @@ random_ioctl(struct inode * inode, struc
 			return -EPERM;
 		if (get_user(ent_count, (int *) arg))
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
@@ -1707,25 +1701,25 @@ random_ioctl(struct inode * inode, struc
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
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		random_state->entropy_count = 0;
+		input_pool->entropy_count = 0;
 		return 0;
 	case RNDCLEARPOOL:
 		/* Clear the entropy pool and associated counters. */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		clear_entropy_store(random_state);
-		init_std_data(random_state);
+		clear_entropy_store(input_pool);
+		init_std_data(input_pool);
 		return 0;
 	default:
 		return -EINVAL;
@@ -1895,12 +1889,12 @@ ctl_table random_table[] = {
 	{ .ctl_name = 0 }
 };
 
-static void sysctl_init_random(struct entropy_store *random_state)
+static void sysctl_init_random(struct entropy_store *pool)
 {
 	min_read_thresh = 8;
 	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh = random_state->poolinfo.POOLBITS;
-	random_table[0].data = &random_state->entropy_count;
+	max_read_thresh = max_write_thresh = pool->poolinfo.POOLBITS;
+	random_table[0].data = &pool->entropy_count;
 }
 #endif 	/* CONFIG_SYSCTL */
 

_
