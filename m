Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271385AbTHIHTY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 03:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271922AbTHIHTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 03:19:24 -0400
Received: from waste.org ([209.173.204.2]:24749 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S271385AbTHIHTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 03:19:15 -0400
Date: Sat, 9 Aug 2003 02:19:12 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] random: urandom pool
Message-ID: <20030809071912.GO31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents readers of /dev/urandom, get_random_bytes(), etc.
from starving readers of /dev/random by creating a second non-blocking
output pool.

- simplify entropy debugging messages
- make reseed logic smarter, handle reservations
- push reseeding calls up out of extraction routine
- simplify sleeping in random_read

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-08-07 21:31:09.000000000 -0500
+++ work/drivers/char/random.c	2003-08-07 21:42:47.000000000 -0500
@@ -271,14 +271,14 @@
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
@@ -385,8 +385,7 @@
 /*
  * Static global variables
  */
-static struct entropy_store *input_pool; /* The default global store */
-static struct entropy_store *blocking_pool; /* secondary store */
+static struct entropy_store *input_pool, *blocking_pool, *nonblocking_pool;
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -461,7 +460,9 @@
 #endif
 
 #if 0
-#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
+#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: %04d %04d %04d: " fmt,\
+  input_pool->entropy_count, blocking_pool->entropy_count,\
+   nonblocking_pool->entropy_count, ## arg)
 #else
 #define DEBUG_ENT(fmt, arg...) do {} while (0)
 #endif
@@ -589,11 +590,7 @@
 	} else {
 		r->entropy_count += nbits;
 		if (nbits)
-			DEBUG_ENT("%04d %04d : added %d bits to %s\n",
-				  input_pool->entropy_count,
-				  blocking_pool->entropy_count,
-				  nbits,
-				  r->name);
+			DEBUG_ENT("added %d bits to %s\n", nbits, r->name);
 	}
 
 	spin_unlock_irqrestore(&r->lock, flags);
@@ -702,11 +699,14 @@
 	while (head != tail) {
 		if (r->entropy_count >= r->poolinfo->POOLBITS)
 			r = blocking_pool;
+		if (r->entropy_count >= r->poolinfo->POOLBITS)
+			r = nonblocking_pool;
+
 		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
 		credit_entropy_store(r, batch_entropy_copy[tail].credit);
 		tail = (tail+1) & (batch_max-1);
 	}
-	if (input_pool->entropy_count >= random_read_wakeup_thresh)
+	if (input_pool->entropy_count >= read_thresh)
 		wake_up_interruptible(&random_read_wait);
 }
 
@@ -1233,24 +1233,29 @@
  * from the input pool to the extraction pool. We make
  * sure we pull enough for a 'catastrophic reseed'.
  */
-static void refill_entropy(struct entropy_store *r, size_t nbytes, __u32 *tmp)
+static void reseed_pool(struct entropy_store *r, int margin, int wanted)
 {
-	if (r->entropy_count < nbytes * 8 &&
-	    r->entropy_count < r->poolinfo->POOLBITS) {
-		int bytes = max_t(int, random_read_wakeup_thresh / 8,
-				min_t(int, nbytes, TMP_BUF_SIZE));
-
-		DEBUG_ENT("%04d %04d : going to reseed %s with %d bits "
-			  "(%d of %d requested)\n",
-			  input_pool->entropy_count,
-			  blocking_pool->entropy_count,
-			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
-
-		bytes=extract_entropy(input_pool, tmp, bytes,
-				      EXTRACT_ENTROPY_LIMIT);
-		add_entropy_words(r, tmp, bytes);
-		credit_entropy_store(r, bytes*8);
-	}
+	__u32 tmp[TMP_BUF_SIZE];
+	int bytes;
+
+	DEBUG_ENT("reseed %s wants %d bits (margin %d)\n",
+		  r->name, wanted*8, margin);
+
+	/* Never more than can fit in buffer */
+	bytes = min_t(int, wanted, sizeof(tmp));
+	/* Nor more than destination has room for */
+	bytes = min_t(int, bytes, (r->poolinfo->POOLBITS-r->entropy_count)/8);
+	/* Nor too much to starve other pools */
+	bytes = min_t(int, bytes, (input_pool->entropy_count - margin)/8);
+	/* And never less than catastrophic reseed threshold */
+	if(bytes < read_thresh/8)
+		return;
+
+	DEBUG_ENT("trying to reseed %s with %d bits\n", r->name, bytes*8);
+
+	bytes=extract_entropy(input_pool, tmp, bytes, EXTRACT_ENTROPY_LIMIT);
+	add_entropy_words(r, tmp, bytes);
+	credit_entropy_store(r, bytes*8);
 }
 
 /*
@@ -1274,16 +1279,10 @@
 	if (r->entropy_count > r->poolinfo->POOLBITS)
 		r->entropy_count = r->poolinfo->POOLBITS;
 
-	if (r != input_pool)
-		refill_entropy(r, nbytes, tmp);
-
 	/* Hold lock while accounting */
 	spin_lock_irqsave(&r->lock, cpuflags);
 
-	DEBUG_ENT("%04d %04d : trying to extract %d bits from %s\n",
-		  input_pool->entropy_count,
-		  blocking_pool->entropy_count,
-		  nbytes * 8, r->name);
+	DEBUG_ENT("trying to extract %d bits from %s\n", nbytes * 8, r->name);
 
 	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8)
 		nbytes = r->entropy_count / 8;
@@ -1293,15 +1292,10 @@
 	else
 		r->entropy_count = 0;
 
-	if (r->entropy_count < random_write_wakeup_thresh)
+	if (r->entropy_count < write_thresh)
 		wake_up_interruptible(&random_write_wait);
 
-	DEBUG_ENT("%04d %04d : debiting %d bits from %s%s\n",
-		  input_pool->entropy_count,
-		  blocking_pool->entropy_count,
-		  nbytes * 8,
-		  r == blocking_pool ? "secondary" :
-		  r == input_pool ? "primary" : "unknown",
+	DEBUG_ENT("debiting %d bits from %s%s\n", nbytes * 8, r->name,
 		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
 
 	spin_unlock_irqrestore(&r->lock, cpuflags);
@@ -1318,15 +1312,11 @@
 				break;
 			}
 
-			DEBUG_ENT("%04d %04d : extract feeling sleepy (%d bytes left)\n",
-				  input_pool->entropy_count,
-				  blocking_pool->entropy_count, nbytes);
+			DEBUG_ENT("extract sleep (%d bytes left)\n", nbytes);
 
 			schedule();
 
-			DEBUG_ENT("%04d %04d : extract woke up\n",
-				  input_pool->entropy_count,
-				  blocking_pool->entropy_count);
+			DEBUG_ENT("extract wake\n");
 		}
 
 		/* Hash the pool to get the output */
@@ -1390,13 +1380,16 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	if (blocking_pool)
-		extract_entropy(blocking_pool, (char *) buf, nbytes, 0);
-	else if (input_pool)
-		extract_entropy(input_pool, (char *) buf, nbytes, 0);
-	else
+	if (!nonblocking_pool)
+	{
 		printk(KERN_NOTICE "get_random_bytes called before "
 				   "random driver initialization\n");
+		return;
+	}
+
+	/* Leave enough for blocking pool to reseed itself */
+	reseed_pool(nonblocking_pool, read_thresh*2, nbytes);
+	extract_entropy(nonblocking_pool, (char *)buf, nbytes, 0);
 }
 
 /*********************************************************************
@@ -1440,8 +1433,10 @@
 
 	input_pool = create_entropy_store(INPUT_POOL_SIZE, "input");
 	blocking_pool = create_entropy_store(BLOCKING_POOL_SIZE, "blocking");
+	nonblocking_pool = create_entropy_store(BLOCKING_POOL_SIZE,
+						"nonblocking");
 
-	if(!(input_pool && blocking_pool))
+	if(!(input_pool && blocking_pool && nonblocking_pool))
 		return;
 
 	if(batch_entropy_init(BATCH_ENTROPY_SIZE))
@@ -1492,7 +1487,6 @@
 static ssize_t
 random_read(struct file * file, char * buf, size_t nbytes, loff_t *ppos)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	ssize_t			n, retval = 0, count = 0;
 	
 	if (nbytes == 0)
@@ -1503,48 +1497,32 @@
 		if (n > SEC_XFER_SIZE)
 			n = SEC_XFER_SIZE;
 
-		DEBUG_ENT("%04d %04d : reading %d bits, p: %d s: %d\n",
-			  input_pool->entropy_count,
-			  blocking_pool->entropy_count,
-			  n*8, input_pool->entropy_count,
-			  blocking_pool->entropy_count);
+		/* We can take all the entropy in the input pool */
+		reseed_pool(blocking_pool, 0, n);
+
+		DEBUG_ENT("reading %d bits\n", n*8);
 
 		n = extract_entropy(blocking_pool, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT);
 
-		DEBUG_ENT("%04d %04d : read got %d bits (%d still needed)\n",
-			  input_pool->entropy_count,
-			  blocking_pool->entropy_count,
-			  n*8, (nbytes-n)*8);
+		DEBUG_ENT("read got %d bits (%d left)\n", n*8, (nbytes-n)*8);
 
 		if (n == 0) {
 			if (file->f_flags & O_NONBLOCK) {
 				retval = -EAGAIN;
 				break;
 			}
+
+			wait_event_interruptible(
+				random_read_wait,
+				input_pool->entropy_count >= read_thresh);
+
 			if (signal_pending(current)) {
 				retval = -ERESTARTSYS;
 				break;
 			}
 
-			DEBUG_ENT("%04d %04d : sleeping?\n",
-				  input_pool->entropy_count,
-				  blocking_pool->entropy_count);
-
-			set_current_state(TASK_INTERRUPTIBLE);
-			add_wait_queue(&random_read_wait, &wait);
-
-			if (blocking_pool->entropy_count / 8 == 0)
-				schedule();
-
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&random_read_wait, &wait);
-
-			DEBUG_ENT("%04d %04d : waking up\n",
-				  input_pool->entropy_count,
-				  blocking_pool->entropy_count);
-
 			continue;
 		}
 
@@ -1573,7 +1551,8 @@
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(blocking_pool, buf, nbytes,
+	reseed_pool(nonblocking_pool, read_thresh*2, nbytes);
+	return extract_entropy(nonblocking_pool, buf, nbytes,
 			       EXTRACT_ENTROPY_USER);
 }
 
@@ -1585,9 +1564,9 @@
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
@@ -1648,7 +1627,7 @@
 		 * Wake up waiting processes if we have enough
 		 * entropy.
 		 */
-		if (input_pool->entropy_count >= random_read_wakeup_thresh)
+		if (input_pool->entropy_count >= read_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDGETPOOL:
@@ -1705,7 +1684,7 @@
 		 * Wake up waiting processes if we have enough
 		 * entropy.
 		 */
-		if (input_pool->entropy_count >= random_read_wakeup_thresh)
+		if (input_pool->entropy_count >= read_thresh)
 			wake_up_interruptible(&random_read_wait);
 		return 0;
 	case RNDZAPENTCNT:
@@ -1845,11 +1824,11 @@
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


-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
