Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262727AbSI1FsF>; Sat, 28 Sep 2002 01:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262731AbSI1Fqs>; Sat, 28 Sep 2002 01:46:48 -0400
Received: from waste.org ([209.173.204.2]:21393 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262724AbSI1FqF>;
	Sat, 28 Sep 2002 01:46:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] /dev/random cleanup: 05-urandom-pool
Message-Id: <E17vAVf-0002Jy-00@ash>
From: Oliver Xymoron <oxymoron@waste.org>
Date: Sat, 28 Sep 2002 00:51:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop /dev/urandom readers from starving /dev/random for entropy by
creating a separate pool and not reseeding if doing so would prevent
/dev/random from reseeding.

This factors pool reseeding out of normal entropy transfer. This allows
different pools to have different policy on how to reseed.

This patch also makes random_read actually use the entropy count in
the secondary pool rather than tracking off the primary.

diff -urN -x '.patch*' -x '*.orig' orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2002-09-28 00:16:15.000000000 -0500
+++ work/drivers/char/random.c	2002-09-28 00:16:15.000000000 -0500
@@ -263,14 +263,14 @@
  * The minimum number of bits of entropy before we wake up a read on
  * /dev/random.  Should be enough to do a significant reseed.
  */
-static int random_read_wakeup_thresh = 64;
+static int read_thresh = 64;
 
 /*
  * If the entropy count falls under this number of bits, then we
  * should wake up processes which are selecting or polling on write
  * access to /dev/random.
  */
-static int random_write_wakeup_thresh = 128;
+static int write_thresh = 128;
 
 /*
  * A pool of size .poolwords is stirred with a primitive polynomial
@@ -381,7 +381,7 @@
 /*
  * Static global variables
  */
-static struct entropy_store *input_pool, *blocking_pool;
+static struct entropy_store *input_pool, *blocking_pool, *nonblocking_pool;
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -617,6 +617,7 @@
 
 	/* switch pools if current full */
 	if (r->entropy_count >= r->poolinfo->POOLBITS) r = blocking_pool;
+	if (r->entropy_count >= r->poolinfo->POOLBITS) r = nonblocking_pool;
 
 	/* Don't allow more credit BITS than pool WORDS */
 	if(credit > batch_max) credit=batch_max;
@@ -626,7 +627,7 @@
 	add_entropy_words(r, batch_entropy_pool, samples);
 	credit_entropy_store(r, credit);
 
-	if (input_pool->entropy_count >= random_read_wakeup_thresh)
+	if (input_pool->entropy_count >= read_thresh)
 		wake_up_interruptible(&random_read_wait);
 }
 
@@ -1159,37 +1160,9 @@
  *********************************************************************/
 
 #define EXTRACT_ENTROPY_USER		1
-#define EXTRACT_ENTROPY_SECONDARY	2
 #define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
-static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int flags);
-
-/*
- * This utility inline function is responsible for transfering entropy
- * from the primary pool to the secondary extraction pool.  We pull
- * randomness under two conditions; one is if there isn't enough entropy
- * in the secondary pool.  The other is after we have extracted 1024 bytes,
- * at which point we do a "catastrophic reseeding".
- */
-static void xfer_entropy(struct entropy_store *r, size_t nbytes)
-{
-	__u32 tmp[TMP_BUF_SIZE];
-
-	if (r->entropy_count < nbytes * 8 &&
-	    r->entropy_count < r->poolinfo->POOLBITS) {
-		int bytes = min_t(int, nbytes, sizeof(tmp));
-
-		DEBUG_ENT("xfer %d to %s (have %d, need %d)\n", 
-			  bytes * 8, r->name, r->entropy_count, nbytes * 8);
-
-		extract_entropy(input_pool, tmp, bytes, 0);
-		add_entropy_words(r, tmp, bytes);
-		credit_entropy_store(r, bytes*8);
-	}
-}
-
 /*
  * This function extracts randomness from the "entropy pool", and
  * returns it in a buffer.  This function computes how many remaining
@@ -1197,10 +1170,6 @@
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
@@ -1214,9 +1183,6 @@
 	if (r->entropy_count > r->poolinfo->POOLBITS)
 		r->entropy_count = r->poolinfo->POOLBITS;
 
-	if (flags & EXTRACT_ENTROPY_SECONDARY)
-		xfer_secondary_pool(r, nbytes);
-
 	DEBUG_ENT("%s has %d bits, want %d bits\n",
 		  r->name, r->entropy_count, nbytes * 8);
 
@@ -1225,7 +1191,7 @@
 	else
 		r->entropy_count = 0;
 
-	if (r->entropy_count < random_write_wakeup_thresh)
+	if (r->entropy_count < write_thresh)
 		wake_up_interruptible(&random_write_wait);
 
 	ret = 0;
@@ -1296,6 +1262,31 @@
 	return ret;
 }
 
+/* Reseed pool with pull bits from input pool, provided input pool has
+ * more than thresh bits available. Pullbits should be sufficient for a
+ * "catastrophic reseed" - enough to make the destination pool
+ * unguessable should it be compromised
+ */
+void reseed_pool(struct entropy_store *r, int thresh, int pullbits)
+{
+	__u32 tmp[TMP_BUF_SIZE];
+	int bytes;
+
+	if (r->entropy_count > 8 || 
+	    input_pool->entropy_count < thresh ||
+	    pullbits < 0)
+		return;
+
+	bytes = min_t(int, pullbits/8, sizeof(tmp));
+
+	DEBUG_ENT("xfer %d to %s (have %d, want %d)\n",
+		  bytes * 8, r->name, r->entropy_count, pullbits);
+
+	extract_entropy(input_pool, tmp, bytes, 0);
+	add_entropy_words(r, tmp, bytes);
+	credit_entropy_store(r, bytes*8);
+}
+
 /*
  * This function is the exported kernel interface.  It returns some
  * number of good random numbers, suitable for seeding TCP sequence
@@ -1303,14 +1294,16 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	if (blocking_pool)  
-		extract_entropy(blocking_pool, (char *) buf, nbytes, 
-				EXTRACT_ENTROPY_SECONDARY);
-	else if (input_pool)
-		extract_entropy(input_pool, (char *) buf, nbytes, 0);
-	else
-		printk(KERN_NOTICE "get_random_bytes called before "
-				   "random driver initialization\n");
+	if (!nonblocking_pool)  
+ 	{
+ 		printk(KERN_NOTICE "get_random_bytes called before "
+		       "random driver initialization\n");
+ 		return;
+ 	}
+
+	/* Leave enough for blocking pool to reseed itself */
+	reseed_pool(nonblocking_pool, read_thresh*2, read_thresh);
+	extract_entropy(nonblocking_pool, (char *) buf, nbytes, 0);
 }
 
 /*********************************************************************
@@ -1352,8 +1345,9 @@
 {
 	input_pool = create_entropy_store(512, "input");
 	blocking_pool = create_entropy_store(128, "blocking");
+	nonblocking_pool = create_entropy_store(128, "nonblocking");
 
-	if(!(input_pool && blocking_pool)) return;
+	if(!(input_pool && blocking_pool && nonblocking_pool)) return;
 	if(batch_entropy_init(256)) return;
 
 	init_std_data(input_pool);
@@ -1382,8 +1376,11 @@
 		return 0;
 
 	add_wait_queue(&random_read_wait, &wait);
+
 	while (nbytes > 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
+
+		reseed_pool(input_pool, read_thresh, read_thresh);
 		
 		n = nbytes;
 		if (n > SEC_XFER_SIZE)
@@ -1408,8 +1405,7 @@
 			  blocking_pool->entropy_count);
 
 		n = extract_entropy(blocking_pool, buf, n,
-				    EXTRACT_ENTROPY_USER |
-				    EXTRACT_ENTROPY_SECONDARY);
+				    EXTRACT_ENTROPY_USER);
 
 		if (n < 0) {
 			retval = n;
@@ -1438,9 +1434,10 @@
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(blocking_pool, buf, nbytes,
-			       EXTRACT_ENTROPY_USER |
-			       EXTRACT_ENTROPY_SECONDARY);
+	reseed_pool(nonblocking_pool, read_thresh*2, read_thresh);
+ 
+	return extract_entropy(blocking_pool, buf, nbytes, 
+			       EXTRACT_ENTROPY_USER);
 }
 
 static unsigned int
@@ -1451,9 +1448,9 @@
 	poll_wait(file, &random_read_wait, wait);
 	poll_wait(file, &random_write_wait, wait);
 	mask = 0;
-	if (input_pool->entropy_count >= random_read_wakeup_thresh)
+	if (input_pool->entropy_count >= read_thresh)
 		mask |= POLLIN | POLLRDNORM;
-	if (input_pool->entropy_count < random_write_wakeup_thresh)
+	if (input_pool->entropy_count < write_thresh)
 		mask |= POLLOUT | POLLWRNORM;
 	return mask;
 }
@@ -1513,7 +1510,7 @@
 		 * Wake up waiting processes if we have enough
 		 * entropy.
 		 */
-		if (input_pool->entropy_count >= random_read_wakeup_thresh)
+		if (input_pool->entropy_count >= read_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDGETPOOL:
@@ -1551,7 +1548,7 @@
 		 * Wake up waiting processes if we have enough
 		 * entropy.
 		 */
-		if (input_pool->entropy_count >= random_read_wakeup_thresh)
+		if (input_pool->entropy_count >= read_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDZAPENTCNT:
@@ -1756,11 +1753,11 @@
 	 NULL, sizeof(int), 0444, NULL,
 	 &proc_dointvec},
 	{RANDOM_READ_THRESH, "read_wakeup_threshold",
-	 &random_read_wakeup_thresh, sizeof(int), 0644, NULL,
+	 &read_thresh, sizeof(int), 0644, NULL,
 	 &proc_dointvec_minmax, &sysctl_intvec, 0,
 	 &min_read_thresh, &max_read_thresh},
 	{RANDOM_WRITE_THRESH, "write_wakeup_threshold",
-	 &random_write_wakeup_thresh, sizeof(int), 0644, NULL,
+	 &write_thresh, sizeof(int), 0644, NULL,
 	 &proc_dointvec_minmax, &sysctl_intvec, 0,
 	 &min_write_thresh, &max_write_thresh},
 	{RANDOM_BOOT_ID, "boot_id",
