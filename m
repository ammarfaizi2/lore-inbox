Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262723AbSI1Fqb>; Sat, 28 Sep 2002 01:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262731AbSI1Fqb>; Sat, 28 Sep 2002 01:46:31 -0400
Received: from waste.org ([209.173.204.2]:20625 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262723AbSI1FqD>;
	Sat, 28 Sep 2002 01:46:03 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] /dev/random cleanup: 04-pool-cleanup
Message-Id: <E17vAVd-0002Js-00@ash>
From: Oliver Xymoron <oxymoron@waste.org>
Date: Sat, 28 Sep 2002 00:51:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- more meaningful names for pools (predicting next patch)
- cleanup of pool structure
  - store name
  - point to poolinfo table rather than copying entry
  - alloc pool together with structure
- refactor pool creation and initialization
- kill pointless (double!) pool zeroing

diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2002-09-28 00:16:14.000000000 -0500
+++ work/drivers/char/random.c	2002-09-28 00:16:15.000000000 -0500
@@ -257,12 +257,6 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 
-/*
- * Configuration information
- */
-#define DEFAULT_POOL_SIZE 512
-#define SECONDARY_POOL_SIZE 128
-#define BATCH_ENTROPY_SIZE 256
 #define USE_SHA
 
 /*
@@ -287,8 +281,8 @@
  * get the twisting happening as fast as possible.
  */
 static struct poolinfo {
-	int	poolwords;
-	int	tap1, tap2, tap3, tap4, tap5;
+	int poolwords;
+	int tap1, tap2, tap3, tap4, tap5;
 } poolinfo_table[] = {
 	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
 	{ 2048,	1638,	1231,	819,	411,	1 },
@@ -387,8 +381,7 @@
 /*
  * Static global variables
  */
-static struct entropy_store *random_state; /* The default global store */
-static struct entropy_store *sec_random_state; /* secondary store */
+static struct entropy_store *input_pool, *blocking_pool;
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -396,7 +389,7 @@
  * Forward procedure declarations
  */
 #ifdef CONFIG_SYSCTL
-static void sysctl_init_random(struct entropy_store *random_state);
+static void sysctl_init_random(struct entropy_store *input_pool);
 #endif
 
 /*****************************************************************
@@ -441,24 +434,19 @@
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
+	__u32 pool[0];
 };
 
-/*
- * Initialize the entropy store.  The input argument is the size of
- * the random pool.
- *
- * Returns an negative error if there is a problem.
- */
-static int create_entropy_store(int size, struct entropy_store **ret_bucket)
+struct entropy_store *create_entropy_store(int size, const char *name)
 {
-	struct	entropy_store	*r;
-	struct	poolinfo	*p;
-	int	poolwords;
+	struct entropy_store	*r;
+	struct poolinfo	*p;
+	int poolwords;
 
 	poolwords = (size + 3) / 4; /* Convert bytes->words */
 	/* The pool size must be a multiple of 16 32-bit words */
@@ -469,43 +457,34 @@
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
+	r->name = name;
+	r->poolinfo = p;
 
-	r->pool = kmalloc(POOLBYTES, GFP_KERNEL);
-	if (!r->pool) {
-		kfree(r);
-		return -ENOMEM;
-	}
-	memset(r->pool, 0, POOLBYTES);
-	*ret_bucket = r;
-	return 0;
+	return r;
 }
 
-/* Clear the entropy pool and associated counters. */
+/* Clear the entropy pool counters. */
 static void clear_entropy_store(struct entropy_store *r)
 {
 	r->add_ptr = 0;
 	r->entropy_count = 0;
 	r->input_rotate = 0;
-	memset(r->pool, 0, r->poolinfo.POOLBYTES);
 }
 
 static void free_entropy_store(struct entropy_store *r)
 {
-	if (r->pool)
-		kfree(r->pool);
 	kfree(r);
 }
 
 /*
- * This function adds a word into the entropy "pool".  It does not
+ * This function adds words into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
  * credit_entropy_store if this is appropriate.
  * 
@@ -522,7 +501,7 @@
 		0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };
 	unsigned i;
 	int new_rotate;
-	int wordmask = r->poolinfo.poolwords - 1;
+	int wordmask = r->poolinfo->poolwords - 1;
 	__u32 w;
 
 	while (nwords--) {
@@ -540,11 +519,11 @@
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
@@ -559,15 +538,13 @@
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
 			DEBUG_ENT("%s added %d bits, now %d\n",
-				  r == sec_random_state ? "secondary" :
-				  r == random_state ? "primary" : "unknown",
-				  nbits, r->entropy_count);
+				  r->name, nbits, r->entropy_count);
 	}
 }
 
@@ -582,10 +559,10 @@
 static __u32 *batch_entropy_pool=0;
 static int batch_max, batch_pos, batch_credit, batch_samples;
 static struct tq_struct	batch_tqueue;
-static void batch_entropy_process(void *private_);
+static void batch_entropy_process(void *v);
 
 /* note: the size must be a power of 2 */
-static int __init batch_entropy_init(int size, struct entropy_store *r)
+static int __init batch_entropy_init(int size)
 {
 	batch_entropy_pool = kmalloc(size*sizeof(__u32), GFP_KERNEL);
 	if (!batch_entropy_pool)
@@ -594,7 +571,6 @@
 	batch_pos = batch_credit = batch_samples = 0;
 	batch_max = size;
 	batch_tqueue.routine = batch_entropy_process;
-	batch_tqueue.data = r;
 	return 0;
 }
 
@@ -624,27 +600,24 @@
 
 /*
  * Flush out the accumulated entropy operations, adding entropy to the
- * passed store (normally random_state). Alternate between randomizing
+ * passed store (normally input_pool). Alternate between randomizing
  * the data of the primary and secondary stores.
  */
 static void batch_entropy_process(void *private_)
 {
-	struct entropy_store *r	= (struct entropy_store *) private_;
+	struct entropy_store *r	= input_pool;
 	int samples, credit;
 	
 	if (!batch_max)
 		return;
 
-	/* switch pools if current full */
-	if (r->entropy_count >= r->poolinfo.POOLBITS) {
-		r = (r == sec_random_state) ? 
-			random_state : sec_random_state;
-	}
-
 	credit=batch_credit;
 	samples=batch_samples;
 	batch_pos = batch_credit = batch_samples = 0;
 
+	/* switch pools if current full */
+	if (r->entropy_count >= r->poolinfo->POOLBITS) r = blocking_pool;
+
 	/* Don't allow more credit BITS than pool WORDS */
 	if(credit > batch_max) credit=batch_max;
 	/* Check for pool wrap-around */
@@ -653,7 +626,7 @@
 	add_entropy_words(r, batch_entropy_pool, samples);
 	credit_entropy_store(r, credit);
 
-	if (r->entropy_count >= random_read_wakeup_thresh)
+	if (input_pool->entropy_count >= random_read_wakeup_thresh)
 		wake_up_interruptible(&random_read_wait);
 }
 
@@ -1200,21 +1173,18 @@
  * in the secondary pool.  The other is after we have extracted 1024 bytes,
  * at which point we do a "catastrophic reseeding".
  */
-static inline void xfer_secondary_pool(struct entropy_store *r,
-				       size_t nbytes)
+static void xfer_entropy(struct entropy_store *r, size_t nbytes)
 {
 	__u32 tmp[TMP_BUF_SIZE];
 
 	if (r->entropy_count < nbytes * 8 &&
-	    r->entropy_count < r->poolinfo.POOLBITS) {
+	    r->entropy_count < r->poolinfo->POOLBITS) {
 		int bytes = min_t(int, nbytes, sizeof(tmp));
 
 		DEBUG_ENT("xfer %d to %s (have %d, need %d)\n", 
-			  bytes * 8,
-			  r == sec_random_state ? "secondary" : "unknown",
-			  r->entropy_count, nbytes * 8);
+			  bytes * 8, r->name, r->entropy_count, nbytes * 8);
 
-		extract_entropy(random_state, tmp, bytes, 0);
+		extract_entropy(input_pool, tmp, bytes, 0);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
 	}
@@ -1241,16 +1211,14 @@
 	__u32 x;
 
 	/* Redundant, but just in case... */
-	if (r->entropy_count > r->poolinfo.POOLBITS)
-		r->entropy_count = r->poolinfo.POOLBITS;
+	if (r->entropy_count > r->poolinfo->POOLBITS)
+		r->entropy_count = r->poolinfo->POOLBITS;
 
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
 		xfer_secondary_pool(r, nbytes);
 
 	DEBUG_ENT("%s has %d bits, want %d bits\n",
-		  r == sec_random_state ? "secondary" :
-		  r == random_state ? "primary" : "unknown",
-		  r->entropy_count, nbytes * 8);
+		  r->name, r->entropy_count, nbytes * 8);
 
 	if (r->entropy_count / 8 >= nbytes)
 		r->entropy_count -= nbytes*8;
@@ -1290,7 +1258,7 @@
 		 * attempts to find previous ouputs), unless the hash
 		 * function can be inverted.
 		 */
-		for (i = 0, x = 0; i < r->poolinfo.poolwords; i += 16, x+=2) {
+		for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
 			HASH_TRANSFORM(tmp, r->pool+i);
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
@@ -1335,11 +1303,11 @@
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
@@ -1382,17 +1350,15 @@
 
 void __init rand_initialize(void)
 {
-	if (create_entropy_store(DEFAULT_POOL_SIZE, &random_state))
-		return;		/* Error, return */
-	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
-		return;		/* Error, return */
-	if (create_entropy_store(SECONDARY_POOL_SIZE, &sec_random_state))
-		return;		/* Error, return */
-	clear_entropy_store(random_state);
-	clear_entropy_store(sec_random_state);
-	init_std_data(random_state);
+	input_pool = create_entropy_store(512, "input");
+	blocking_pool = create_entropy_store(128, "blocking");
+
+	if(!(input_pool && blocking_pool)) return;
+	if(batch_entropy_init(256)) return;
+
+	init_std_data(input_pool);
 #ifdef CONFIG_SYSCTL
-	sysctl_init_random(random_state);
+	sysctl_init_random(input_pool);
 #endif
 	generic_kbd = create_entropy_source(1);
 	generic_mouse = create_entropy_source(1);
@@ -1422,8 +1388,8 @@
 		n = nbytes;
 		if (n > SEC_XFER_SIZE)
 			n = SEC_XFER_SIZE;
-		if (n > random_state->entropy_count / 8)
-			n = random_state->entropy_count / 8;
+		if (n > blocking_pool->entropy_count / 8)
+			n = blocking_pool->entropy_count / 8;
 		if (n == 0) {
 			if (file->f_flags & O_NONBLOCK) {
 				retval = -EAGAIN;
@@ -1438,12 +1404,13 @@
 		}
 
 		DEBUG_ENT("extracting %d bits, p: %d s: %d\n",
-			  n*8, random_state->entropy_count,
-			  sec_random_state->entropy_count);
+			  n*8, input_pool->entropy_count,
+			  blocking_pool->entropy_count);
 
-		n = extract_entropy(sec_random_state, buf, n,
+		n = extract_entropy(blocking_pool, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_SECONDARY);
+
 		if (n < 0) {
 			retval = n;
 			break;
@@ -1471,7 +1438,7 @@
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(sec_random_state, buf, nbytes,
+	return extract_entropy(blocking_pool, buf, nbytes,
 			       EXTRACT_ENTROPY_USER |
 			       EXTRACT_ENTROPY_SECONDARY);
 }
@@ -1484,9 +1451,9 @@
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
@@ -1512,7 +1479,7 @@
 		c -= bytes;
 		p += bytes;
 
-		add_entropy_words(random_state, buf, (bytes + 3) / 4);
+		add_entropy_words(input_pool, buf, (bytes + 3) / 4);
 	}
 	if (p == buffer) {
 		return (ssize_t)ret;
@@ -1532,7 +1499,7 @@
 	
 	switch (cmd) {
 	case RNDGETENTCNT:
-		ent_count = random_state->entropy_count;
+		ent_count = input_pool->entropy_count;
 		if (put_user(ent_count, (int *) arg))
 			return -EFAULT;
 		return 0;
@@ -1541,28 +1508,28 @@
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
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		p = (int *) arg;
-		ent_count = random_state->entropy_count;
+		ent_count = input_pool->entropy_count;
 		if (put_user(ent_count, p++) ||
 		    get_user(size, p) ||
-		    put_user(random_state->poolinfo.poolwords, p++))
+		    put_user(input_pool->poolinfo->poolwords, p++))
 			return -EFAULT;
 		if (size < 0)
 			return -EINVAL;
-		if (size > random_state->poolinfo.poolwords)
-			size = random_state->poolinfo.poolwords;
-		if (copy_to_user(p, random_state->pool, size * 4))
+		if (size > input_pool->poolinfo->poolwords)
+			size = input_pool->poolinfo->poolwords;
+		if (copy_to_user(p, input_pool->pool, size * 4))
 			return -EFAULT;
 		return 0;
 	case RNDADDENTROPY:
@@ -1579,25 +1546,25 @@
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
@@ -1653,7 +1620,7 @@
 
 /*
  * This function handles a request from the user to change the pool size 
- * of the primary entropy store.
+ * of the input entropy store.
  */
 static int change_poolsize(int poolsize)
 {
@@ -1663,13 +1630,13 @@
 	if ((ret = create_entropy_store(poolsize, &new_store)))
 		return ret;
 
-	add_entropy_words(new_store, random_state->pool,
-			  random_state->poolinfo.poolwords);
-	credit_entropy_store(new_store, random_state->entropy_count);
+	add_entropy_words(new_store, input_pool->pool,
+			  input_pool->poolinfo->poolwords);
+	credit_entropy_store(new_store, input_pool->entropy_count);
 
 	sysctl_init_random(new_store);
-	old_store = random_state;
-	random_state = batch_tqueue.data = new_store;
+	old_store = input_pool;
+	input_pool = new_store;
 	free_entropy_store(old_store);
 	return 0;
 }
@@ -1679,11 +1646,11 @@
 {
 	int	ret;
 
-	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
+	sysctl_poolsize = input_pool->poolinfo->POOLBYTES;
 
 	ret = proc_dointvec(table, write, filp, buffer, lenp);
 	if (ret || !write ||
-	    (sysctl_poolsize == random_state->poolinfo.POOLBYTES))
+	    (sysctl_poolsize == input_pool->poolinfo->POOLBYTES))
 		return ret;
 
 	return change_poolsize(sysctl_poolsize);
@@ -1695,7 +1662,7 @@
 {
 	int	len;
 	
-	sysctl_poolsize = random_state->poolinfo.POOLBYTES;
+	sysctl_poolsize = input_pool->poolinfo->POOLBYTES;
 
 	/*
 	 * We only handle the write case, since the read case gets
@@ -1710,7 +1677,7 @@
 			return -EFAULT;
 	}
 
-	if (sysctl_poolsize != random_state->poolinfo.POOLBYTES)
+	if (sysctl_poolsize != input_pool->poolinfo->POOLBYTES)
 		return change_poolsize(sysctl_poolsize);
 
 	return 0;
@@ -1809,12 +1776,12 @@
 	{0}
 };
 
-static void sysctl_init_random(struct entropy_store *random_state)
+static void sysctl_init_random(struct entropy_store *pool)
 {
 	min_read_thresh = 8;
 	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh = random_state->poolinfo.POOLBITS;
-	random_table[1].data = &random_state->entropy_count;
+	max_read_thresh = max_write_thresh = pool->poolinfo->POOLBITS;
+	random_table[1].data = &pool->entropy_count;
 }
 #endif 	/* CONFIG_SYSCTL */
 
