Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271327AbTHIHQm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 03:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271385AbTHIHQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 03:16:42 -0400
Received: from waste.org ([209.173.204.2]:16557 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S271327AbTHIHQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 03:16:25 -0400
Date: Sat, 9 Aug 2003 02:16:18 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] random: cleanup pools
Message-ID: <20030809071618.GN31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the random pool infrastructure in preparation for
making /dev/urandom readers not starve /dev/random readers

- meaningful names for pools in pool struct
- simplified initialization
- simplify entropy transfer
- kill pool resizing via sysctl - racy, ugly to fix, and pretty much pointless
- compile out unused polynomials

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-08-07 21:06:29.000000000 -0500
+++ work/drivers/char/random.c	2003-08-07 21:07:27.000000000 -0500
@@ -262,8 +262,8 @@
 /*
  * Configuration information
  */
-#define DEFAULT_POOL_SIZE 512
-#define SECONDARY_POOL_SIZE 128
+#define INPUT_POOL_SIZE 512
+#define BLOCKING_POOL_SIZE 128
 #define BATCH_ENTROPY_SIZE 256
 #define USE_SHA
 
@@ -292,41 +292,37 @@
 	int	poolwords;
 	int	tap1, tap2, tap3, tap4, tap5;
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
-
 	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
 	{ 512,	411,	308,	208,	104,	1 },
-#if 0				/* Alternates */
+				/* Alternates */
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
+	/* Alternate polynomial */
 	/* x^128 + x^103 + x^78 + x^51 + x^27 + x^2 + 1 -- 70 */
 	{ 128,	103,	78,	51,	27,	2 },
-#endif
 
 	/* x^64 + x^52 + x^39 + x^26 + x^14 + x + 1 -- 15 */
 	{ 64,	52,	39,	26,	14,	1 },
-
-	/* x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 -- 15 */
-	{ 32,	26,	20,	14,	7,	1 },
-
+#endif
 	{ 0,	0,	0,	0,	0,	0 },
 };
 
@@ -389,17 +385,15 @@
 /*
  * Static global variables
  */
-static struct entropy_store *random_state; /* The default global store */
-static struct entropy_store *sec_random_state; /* secondary store */
+static struct entropy_store *input_pool; /* The default global store */
+static struct entropy_store *blocking_pool; /* secondary store */
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
 /*
  * Forward procedure declarations
  */
-#ifdef CONFIG_SYSCTL
-static void sysctl_init_random(struct entropy_store *random_state);
-#endif
+static void sysctl_init_random(struct entropy_store *pool);
 
 /*****************************************************************
  *
@@ -480,21 +474,16 @@
  **********************************************************************/
 
 struct entropy_store {
-	unsigned	add_ptr;
-	int		entropy_count;
-	int		input_rotate;
-	struct poolinfo poolinfo;
-	__u32		*pool;
+	const char *name;
+	unsigned add_ptr;
+	int entropy_count;
+	int input_rotate;
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
-static int create_entropy_store(int size, struct entropy_store **ret_bucket)
+static struct entropy_store *create_entropy_store(int size, const char *name)
 {
 	struct	entropy_store	*r;
 	struct	poolinfo	*p;
@@ -509,24 +498,17 @@
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
 
 	memset (r, 0, sizeof(struct entropy_store));
-	r->poolinfo = *p;
+	r->name = name;
+	r->poolinfo = p;
 
-	r->pool = kmalloc(POOLBYTES, GFP_KERNEL);
-	if (!r->pool) {
-		kfree(r);
-		return -ENOMEM;
-	}
-	memset(r->pool, 0, POOLBYTES);
-	r->lock = SPIN_LOCK_UNLOCKED;
-	*ret_bucket = r;
-	return 0;
+	return r;
 }
 
 /* Clear the entropy pool and associated counters. */
@@ -535,18 +517,11 @@
 	r->add_ptr = 0;
 	r->entropy_count = 0;
 	r->input_rotate = 0;
-	memset(r->pool, 0, r->poolinfo.POOLBYTES);
-}
-#ifdef CONFIG_SYSCTL
-static void free_entropy_store(struct entropy_store *r)
-{
-	if (r->pool)
-		kfree(r->pool);
-	kfree(r);
+	memset(r->pool, 0, r->poolinfo->POOLBYTES);
 }
-#endif
+
 /*
- * This function adds a byte into the entropy "pool".  It does not
+ * This function adds words into the entropy pool.  It does not
  * update the entropy estimate.  The caller should call
  * credit_entropy_store if this is appropriate.
  * 
@@ -563,7 +538,7 @@
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
 	unsigned i;
 	int new_rotate;
-	int wordmask = r->poolinfo.poolwords - 1;
+	int wordmask = r->poolinfo->poolwords - 1;
 	__u32 w;
 	unsigned long flags;
 
@@ -584,11 +559,11 @@
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
@@ -609,17 +584,16 @@
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
 			DEBUG_ENT("%04d %04d : added %d bits to %s\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count,
+				  input_pool->entropy_count,
+				  blocking_pool->entropy_count,
 				  nbits,
-				  r == sec_random_state ? "secondary" :
-				  r == random_state ? "primary" : "unknown");
+				  r->name);
 	}
 
 	spin_unlock_irqrestore(&r->lock, flags);
@@ -647,7 +621,7 @@
 static DECLARE_WORK(batch_work, batch_entropy_process, NULL);
 
 /* note: the size must be a power of 2 */
-static int __init batch_entropy_init(int size, struct entropy_store *r)
+static int __init batch_entropy_init(int size)
 {
 	batch_entropy_pool = kmalloc(size*sizeof(struct sample), GFP_KERNEL);
 	if (!batch_entropy_pool)
@@ -658,7 +632,6 @@
 		return -1;
 	}
 	batch_head = batch_tail = 0;
-	batch_work.data = r;
 	batch_max = size;
 	return 0;
 }
@@ -701,14 +674,13 @@
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
-	struct entropy_store *r	= (struct entropy_store *) private_, *p;
-	int max_entropy = r->poolinfo.POOLBITS;
+	struct entropy_store *r	= input_pool;
 	unsigned head, tail;
 
 	/* Mixing into the pool is expensive, so copy over the batch
@@ -727,18 +699,14 @@
 
 	spin_unlock_irq(&batch_lock);
 
-	p = r;
 	while (head != tail) {
-		if (r->entropy_count >= max_entropy) {
-			r = (r == sec_random_state) ?	random_state :
-							sec_random_state;
-			max_entropy = r->poolinfo.POOLBITS;
-		}
+		if (r->entropy_count >= r->poolinfo->POOLBITS)
+			r = blocking_pool;
 		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
 		credit_entropy_store(r, batch_entropy_copy[tail].credit);
 		tail = (tail+1) & (batch_max-1);
 	}
-	if (p->entropy_count >= random_read_wakeup_thresh)
+	if (input_pool->entropy_count >= random_read_wakeup_thresh)
 		wake_up_interruptible(&random_read_wait);
 }
 
@@ -757,7 +725,6 @@
 
 static struct timer_rand_state keyboard_timer_state;
 static struct timer_rand_state mouse_timer_state;
-static struct timer_rand_state extract_timer_state;
 static struct timer_rand_state *irq_timer_state[NR_IRQS];
 
 /*
@@ -1254,8 +1221,7 @@
  *********************************************************************/
 
 #define EXTRACT_ENTROPY_USER		1
-#define EXTRACT_ENTROPY_SECONDARY	2
-#define EXTRACT_ENTROPY_LIMIT		4
+#define EXTRACT_ENTROPY_LIMIT		2
 #define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
@@ -1263,26 +1229,24 @@
 			       size_t nbytes, int flags);
 
 /*
- * This utility inline function is responsible for transfering entropy
- * from the primary pool to the secondary extraction pool. We make
+ * This utility function is responsible for transfering entropy
+ * from the input pool to the extraction pool. We make
  * sure we pull enough for a 'catastrophic reseed'.
  */
-static inline void xfer_secondary_pool(struct entropy_store *r,
-				       size_t nbytes, __u32 *tmp)
+static void refill_entropy(struct entropy_store *r, size_t nbytes, __u32 *tmp)
 {
 	if (r->entropy_count < nbytes * 8 &&
-	    r->entropy_count < r->poolinfo.POOLBITS) {
+	    r->entropy_count < r->poolinfo->POOLBITS) {
 		int bytes = max_t(int, random_read_wakeup_thresh / 8,
 				min_t(int, nbytes, TMP_BUF_SIZE));
 
 		DEBUG_ENT("%04d %04d : going to reseed %s with %d bits "
 			  "(%d of %d requested)\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
-			  r == sec_random_state ? "secondary" : "unknown",
-			  bytes * 8, nbytes * 8, r->entropy_count);
+			  input_pool->entropy_count,
+			  blocking_pool->entropy_count,
+			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
-		bytes=extract_entropy(random_state, tmp, bytes,
+		bytes=extract_entropy(input_pool, tmp, bytes,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1296,10 +1260,6 @@
  * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
  * flag is given, then the buf pointer is assumed to be in user space.
  *
- * If the EXTRACT_ENTROPY_SECONDARY flag is given, then we are actually
- * extracting entropy from the secondary pool, and can refill from the
- * primary pool if needed.
- *
  * Note: extract_entropy() assumes that .poolwords is a multiple of 16 words.
  */
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
@@ -1310,23 +1270,20 @@
 	__u32 x;
 	unsigned long cpuflags;
 
-
 	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo.POOLBITS)
-		r->entropy_count = r->poolinfo.POOLBITS;
+	if (r->entropy_count > r->poolinfo->POOLBITS)
+		r->entropy_count = r->poolinfo->POOLBITS;
 
-	if (flags & EXTRACT_ENTROPY_SECONDARY)
-		xfer_secondary_pool(r, nbytes, tmp);
+	if (r != input_pool)
+		refill_entropy(r, nbytes, tmp);
 
 	/* Hold lock while accounting */
 	spin_lock_irqsave(&r->lock, cpuflags);
 
 	DEBUG_ENT("%04d %04d : trying to extract %d bits from %s\n",
-		  random_state->entropy_count,
-		  sec_random_state->entropy_count,
-		  nbytes * 8,
-		  r == sec_random_state ? "secondary" :
-		  r == random_state ? "primary" : "unknown");
+		  input_pool->entropy_count,
+		  blocking_pool->entropy_count,
+		  nbytes * 8, r->name);
 
 	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8)
 		nbytes = r->entropy_count / 8;
@@ -1340,11 +1297,11 @@
 		wake_up_interruptible(&random_write_wait);
 
 	DEBUG_ENT("%04d %04d : debiting %d bits from %s%s\n",
-		  random_state->entropy_count,
-		  sec_random_state->entropy_count,
+		  input_pool->entropy_count,
+		  blocking_pool->entropy_count,
 		  nbytes * 8,
-		  r == sec_random_state ? "secondary" :
-		  r == random_state ? "primary" : "unknown",
+		  r == blocking_pool ? "secondary" :
+		  r == input_pool ? "primary" : "unknown",
 		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
 
 	spin_unlock_irqrestore(&r->lock, cpuflags);
@@ -1362,14 +1319,14 @@
 			}
 
 			DEBUG_ENT("%04d %04d : extract feeling sleepy (%d bytes left)\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count, nbytes);
+				  input_pool->entropy_count,
+				  blocking_pool->entropy_count, nbytes);
 
 			schedule();
 
 			DEBUG_ENT("%04d %04d : extract woke up\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
+				  input_pool->entropy_count,
+				  blocking_pool->entropy_count);
 		}
 
 		/* Hash the pool to get the output */
@@ -1388,7 +1345,7 @@
 		 * attempts to find previous ouputs), unless the hash
 		 * function can be inverted.
 		 */
-		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
+		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
 			HASH_TRANSFORM(tmp, r->pool+i);
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
@@ -1433,11 +1390,10 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	if (sec_random_state)  
-		extract_entropy(sec_random_state, (char *) buf, nbytes, 
-				EXTRACT_ENTROPY_SECONDARY);
-	else if (random_state)
-		extract_entropy(random_state, (char *) buf, nbytes, 0);
+	if (blocking_pool)
+		extract_entropy(blocking_pool, (char *) buf, nbytes, 0);
+	else if (input_pool)
+		extract_entropy(input_pool, (char *) buf, nbytes, 0);
 	else
 		printk(KERN_NOTICE "get_random_bytes called before "
 				   "random driver initialization\n");
@@ -1482,24 +1438,22 @@
 {
 	int i;
 
-	if (create_entropy_store(DEFAULT_POOL_SIZE, &random_state))
-		return;		/* Error, return */
-	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
-		return;		/* Error, return */
-	if (create_entropy_store(SECONDARY_POOL_SIZE, &sec_random_state))
-		return;		/* Error, return */
-	clear_entropy_store(random_state);
-	clear_entropy_store(sec_random_state);
-	init_std_data(random_state);
-#ifdef CONFIG_SYSCTL
-	sysctl_init_random(random_state);
-#endif
+	input_pool = create_entropy_store(INPUT_POOL_SIZE, "input");
+	blocking_pool = create_entropy_store(BLOCKING_POOL_SIZE, "blocking");
+
+	if(!(input_pool && blocking_pool))
+		return;
+
+	if(batch_entropy_init(BATCH_ENTROPY_SIZE))
+		return;
+
+	init_std_data(input_pool);
+	sysctl_init_random(input_pool);
+
 	for (i = 0; i < NR_IRQS; i++)
 		irq_timer_state[i] = NULL;
 	memset(&keyboard_timer_state, 0, sizeof(struct timer_rand_state));
 	memset(&mouse_timer_state, 0, sizeof(struct timer_rand_state));
-	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
-	extract_timer_state.dont_count_entropy = 1;
 }
 
 void rand_initialize_irq(int irq)
@@ -1550,19 +1504,18 @@
 			n = SEC_XFER_SIZE;
 
 		DEBUG_ENT("%04d %04d : reading %d bits, p: %d s: %d\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
-			  n*8, random_state->entropy_count,
-			  sec_random_state->entropy_count);
+			  input_pool->entropy_count,
+			  blocking_pool->entropy_count,
+			  n*8, input_pool->entropy_count,
+			  blocking_pool->entropy_count);
 
-		n = extract_entropy(sec_random_state, buf, n,
+		n = extract_entropy(blocking_pool, buf, n,
 				    EXTRACT_ENTROPY_USER |
-				    EXTRACT_ENTROPY_LIMIT |
-				    EXTRACT_ENTROPY_SECONDARY);
+				    EXTRACT_ENTROPY_LIMIT);
 
 		DEBUG_ENT("%04d %04d : read got %d bits (%d still needed)\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
+			  input_pool->entropy_count,
+			  blocking_pool->entropy_count,
 			  n*8, (nbytes-n)*8);
 
 		if (n == 0) {
@@ -1576,21 +1529,21 @@
 			}
 
 			DEBUG_ENT("%04d %04d : sleeping?\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
+				  input_pool->entropy_count,
+				  blocking_pool->entropy_count);
 
 			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue(&random_read_wait, &wait);
 
-			if (sec_random_state->entropy_count / 8 == 0)
+			if (blocking_pool->entropy_count / 8 == 0)
 				schedule();
 
 			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&random_read_wait, &wait);
 
 			DEBUG_ENT("%04d %04d : waking up\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
+				  input_pool->entropy_count,
+				  blocking_pool->entropy_count);
 
 			continue;
 		}
@@ -1620,9 +1573,8 @@
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(sec_random_state, buf, nbytes,
-			       EXTRACT_ENTROPY_USER |
-			       EXTRACT_ENTROPY_SECONDARY);
+	return extract_entropy(blocking_pool, buf, nbytes,
+			       EXTRACT_ENTROPY_USER);
 }
 
 static unsigned int
@@ -1633,9 +1585,9 @@
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
@@ -1661,7 +1613,7 @@
 		c -= bytes;
 		p += bytes;
 
-		add_entropy_words(random_state, buf, (bytes + 3) / 4);
+		add_entropy_words(input_pool, buf, (bytes + 3) / 4);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1682,7 +1634,7 @@
 	
 	switch (cmd) {
 	case RNDGETENTCNT:
-		ent_count = random_state->entropy_count;
+		ent_count = input_pool->entropy_count;
 		if (put_user(ent_count, (int *) arg))
 			return -EFAULT;
 		return 0;
@@ -1691,12 +1643,12 @@
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
 	case RNDGETPOOL:
@@ -1704,12 +1656,12 @@
 			return -EPERM;
 		p = (int *) arg;
 		if (get_user(size, p) ||
-		    put_user(random_state->poolinfo.poolwords, p++))
+		    put_user(input_pool->poolinfo->poolwords, p++))
 			return -EFAULT;
 		if (size < 0)
 			return -EFAULT;
-		if (size > random_state->poolinfo.poolwords)
-			size = random_state->poolinfo.poolwords;
+		if (size > input_pool->poolinfo->poolwords)
+			size = input_pool->poolinfo->poolwords;
 
 		/* prepare to atomically snapshot pool */
 
@@ -1718,10 +1670,10 @@
 		if (!tmp)
 			return -EFAULT;
 
-		spin_lock_irqsave(&random_state->lock, flags);
-		ent_count = random_state->entropy_count;
-		memcpy(tmp, random_state->pool, size * sizeof(__u32));
-		spin_unlock_irqrestore(&random_state->lock, flags);
+		spin_lock_irqsave(&input_pool->lock, flags);
+		ent_count = input_pool->entropy_count;
+		memcpy(tmp, input_pool->pool, size * sizeof(__u32));
+		spin_unlock_irqrestore(&input_pool->lock, flags);
 
 		if (!copy_to_user(p, tmp, size * sizeof(__u32))) {
 			kfree(tmp);
@@ -1748,25 +1700,25 @@
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
@@ -1821,72 +1773,7 @@
 static char sysctl_bootid[16];
 
 /*
- * This function handles a request from the user to change the pool size 
- * of the primary entropy store.
- */
-static int change_poolsize(int poolsize)
-{
-	struct entropy_store	*new_store, *old_store;
-	int			ret;
-	
-	if ((ret = create_entropy_store(poolsize, &new_store)))
-		return ret;
-
-	add_entropy_words(new_store, random_state->pool,
-			  random_state->poolinfo.poolwords);
-	credit_entropy_store(new_store, random_state->entropy_count);
-
-	sysctl_init_random(new_store);
-	old_store = random_state;
-	random_state = batch_work.data = new_store;
-	free_entropy_store(old_store);
-	return 0;
-}
-
-static int proc_do_poolsize(ctl_table *table, int write, struct file *filp,
-			    void *buffer, size_t *lenp)
-{
-	int	ret;
-
-	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
-
-	ret = proc_dointvec(table, write, filp, buffer, lenp);
-	if (ret || !write ||
-	    (sysctl_poolsize == random_state->poolinfo.POOLBYTES))
-		return ret;
-
-	return change_poolsize(sysctl_poolsize);
-}
-
-static int poolsize_strategy(ctl_table *table, int *name, int nlen,
-			     void *oldval, size_t *oldlenp,
-			     void *newval, size_t newlen, void **context)
-{
-	int	len;
-	
-	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
-
-	/*
-	 * We only handle the write case, since the read case gets
-	 * handled by the default handler (and we don't care if the
-	 * write case happens twice; it's harmless).
-	 */
-	if (newval && newlen) {
-		len = newlen;
-		if (len > table->maxlen)
-			len = table->maxlen;
-		if (copy_from_user(table->data, newval, len))
-			return -EFAULT;
-	}
-
-	if (sysctl_poolsize != random_state->poolinfo.POOLBYTES)
-		return change_poolsize(sysctl_poolsize);
-
-	return 0;
-}
-
-/*
- * These functions is used to return both the bootid UUID, and random
+ * These functions are used to return both the bootid UUID and random
  * UUID.  The difference is in whether table->data is NULL; if it is,
  * then a new UUID is generated and returned to the user.
  * 
@@ -1952,8 +1839,8 @@
 
 ctl_table random_table[] = {
 	{RANDOM_POOLSIZE, "poolsize",
-	 &sysctl_poolsize, sizeof(int), 0644, NULL,
-	 &proc_do_poolsize, &poolsize_strategy},
+	 &sysctl_poolsize, sizeof(int), 0444, NULL,
+	 &proc_dointvec},
 	{RANDOM_ENTROPY_COUNT, "entropy_avail",
 	 NULL, sizeof(int), 0444, NULL,
 	 &proc_dointvec},
@@ -1973,15 +1860,17 @@
 	 &proc_do_uuid, &uuid_strategy},
 	{0}
 };
+#endif 	/* CONFIG_SYSCTL */
 
-static void sysctl_init_random(struct entropy_store *random_state)
+static void sysctl_init_random(struct entropy_store *pool)
 {
-	min_read_thresh = 8;
+#ifdef CONFIG_SYSCTL
+	min_read_thresh = 64;
 	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh = random_state->poolinfo.POOLBITS;
-	random_table[1].data = &random_state->entropy_count;
-}
+	max_read_thresh = max_write_thresh = pool->poolinfo->POOLBITS;
+	random_table[1].data = &pool->entropy_count;
 #endif 	/* CONFIG_SYSCTL */
+}
 
 /********************************************************************
  *


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
