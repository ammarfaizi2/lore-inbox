Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272639AbTHBEbc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 00:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272676AbTHBEbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 00:31:32 -0400
Received: from waste.org ([209.173.204.2]:61867 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272639AbTHBEb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 00:31:26 -0400
Date: Fri, 1 Aug 2003 23:31:23 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2/2] random: accounting and sleeping fixes
Message-ID: <20030802043123.GE22824@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes several calculation errors and races in entropy accounting
that would allow /dev/random output to greatly exceed the measured
entropy collection. This doesn't include any of my more controversial
hardening, it just makes it behave as intended.

It also corrects the operation of the 'catastrophic reseeding' feature
so that it will actually prevent the state extension attack it's meant
to guard against.

And finally, it also fixes a couple missed wake-up and accidental
sleep bugs uncovered by the above fixes.

Debug instrumentation has been improved to help verify correctness.

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-08-01 22:19:06.000000000 -0500
+++ work/drivers/char/random.c	2003-08-01 22:23:56.000000000 -0500
@@ -267,9 +267,9 @@
 
 /*
  * The minimum number of bits of entropy before we wake up a read on
- * /dev/random.  Should always be at least 8, or at least 1 byte.
+ * /dev/random.  Should be enough to do a significant reseed.
  */
-static int random_read_wakeup_thresh = 8;
+static int random_read_wakeup_thresh = 64;
 
 /*
  * If the entropy count falls under this number of bits, then we
@@ -481,7 +481,6 @@
 	unsigned	add_ptr;
 	int		entropy_count;
 	int		input_rotate;
-	int		extract_count;
 	struct poolinfo poolinfo;
 	__u32		*pool;
 	spinlock_t lock;
@@ -534,7 +533,6 @@
 	r->add_ptr = 0;
 	r->entropy_count = 0;
 	r->input_rotate = 0;
-	r->extract_count = 0;
 	memset(r->pool, 0, r->poolinfo.POOLBYTES);
 }
 #ifdef CONFIG_SYSCTL
@@ -611,10 +609,12 @@
 	} else {
 		r->entropy_count += nbits;
 		if (nbits)
-			DEBUG_ENT("%s added %d bits, now %d\n",
+			DEBUG_ENT("%04d %04d : added %d bits to %s\n",
+				  random_state->entropy_count,
+				  sec_random_state->entropy_count,
+				  nbits,
 				  r == sec_random_state ? "secondary" :
-				  r == random_state ? "primary" : "unknown",
-				  nbits, r->entropy_count);
+				  r == random_state ? "primary" : "unknown");
 	}
 
 	spin_unlock(&r->lock);
@@ -1250,6 +1250,7 @@
 
 #define EXTRACT_ENTROPY_USER		1
 #define EXTRACT_ENTROPY_SECONDARY	2
+#define EXTRACT_ENTROPY_LIMIT		4
 #define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
@@ -1258,36 +1259,28 @@
 
 /*
  * This utility inline function is responsible for transfering entropy
- * from the primary pool to the secondary extraction pool.  We pull
- * randomness under two conditions; one is if there isn't enough entropy
- * in the secondary pool.  The other is after we have extracted 1024 bytes,
- * at which point we do a "catastrophic reseeding".
+ * from the primary pool to the secondary extraction pool. We make
+ * sure we pull enough for a 'catastrophic reseed'.
  */
 static inline void xfer_secondary_pool(struct entropy_store *r,
 				       size_t nbytes, __u32 *tmp)
 {
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
-		int nwords = min_t(int,
-				   r->poolinfo.poolwords - r->entropy_count/32,
-				   sizeof(tmp) / 4);
+		int bytes = max_t(int, random_read_wakeup_thresh / 8,
+				min_t(int, nbytes, TMP_BUF_SIZE));
 
-		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
-			  nwords * 32,
+		DEBUG_ENT("%04d %04d : going to reseed %s with %d bits "
+			  "(%d of %d requested)\n", 
+			  random_state->entropy_count,
+			  sec_random_state->entropy_count,
 			  r == sec_random_state ? "secondary" : "unknown",
-			  r->entropy_count, nbytes * 8);
+			  bytes * 8, nbytes * 8, r->entropy_count);
 
-		extract_entropy(random_state, tmp, nwords * 4, 0);
-		add_entropy_words(r, tmp, nwords);
-		credit_entropy_store(r, nwords * 32);
-	}
-	if (r->extract_count > 1024) {
-		DEBUG_ENT("reseeding %s with %d from primary\n",
-			  r == sec_random_state ? "secondary" : "unknown",
-			  sizeof(tmp) * 8);
-		extract_entropy(random_state, tmp, sizeof(tmp), 0);
-		add_entropy_words(r, tmp, sizeof(tmp) / 4);
-		r->extract_count = 0;
+		bytes=extract_entropy(random_state, tmp, bytes, 
+				      EXTRACT_ENTROPY_LIMIT);
+		add_entropy_words(r, tmp, bytes);
+		credit_entropy_store(r, bytes*8);
 	}
 }
 
@@ -1311,7 +1304,6 @@
 	__u32 tmp[TMP_BUF_SIZE];
 	__u32 x;
 
-	add_timer_randomness(&extract_timer_state, nbytes);
 
 	/* Redundant, but just in case... */
 	if (r->entropy_count > r->poolinfo.POOLBITS)
@@ -1320,13 +1313,18 @@
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
 		xfer_secondary_pool(r, nbytes, tmp);
 
-	DEBUG_ENT("%s has %d bits, want %d bits\n",
-		  r == sec_random_state ? "secondary" :
 	/* Hold lock while accounting */
 	spin_lock(&r->lock);
 
-		  r == random_state ? "primary" : "unknown",
-		  r->entropy_count, nbytes * 8);
+	DEBUG_ENT("%04d %04d : trying to extract %d bits from %s\n",
+		  random_state->entropy_count,
+		  sec_random_state->entropy_count,
+		  nbytes * 8,
+		  r == sec_random_state ? "secondary" :
+		  r == random_state ? "primary" : "unknown");
+
+	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8)
+		nbytes = r->entropy_count / 8;
 
 	if (r->entropy_count / 8 >= nbytes)
 		r->entropy_count -= nbytes*8;
@@ -1336,7 +1334,13 @@
 	if (r->entropy_count < random_write_wakeup_thresh)
 		wake_up_interruptible(&random_write_wait);
 
-	r->extract_count += nbytes;
+	DEBUG_ENT("%04d %04d : debiting %d bits from %s%s\n",
+		  random_state->entropy_count,
+		  sec_random_state->entropy_count,
+		  nbytes * 8,
+		  r == sec_random_state ? "secondary" :
+		  r == random_state ? "primary" : "unknown", 
+		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
 
 	spin_unlock(&r->lock);
 	
@@ -1351,7 +1355,16 @@
 					ret = -ERESTARTSYS;
 				break;
 			}
+
+			DEBUG_ENT("%04d %04d : extract feeling sleepy (%d bytes left)\n",
+				  random_state->entropy_count,
+				  sec_random_state->entropy_count, nbytes);
+
 			schedule();
+
+			DEBUG_ENT("%04d %04d : extract woke up\n",
+				  random_state->entropy_count,
+				  sec_random_state->entropy_count);
 		}
 
 		/* Hash the pool to get the output */
@@ -1400,7 +1413,6 @@
 		nbytes -= i;
 		buf += i;
 		ret += i;
-		add_timer_randomness(&extract_timer_state, nbytes);
 	}
 
 	/* Wipe data just returned from memory */
@@ -1527,15 +1540,27 @@
 	if (nbytes == 0)
 		return 0;
 
-	add_wait_queue(&random_read_wait, &wait);
 	while (nbytes > 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		
 		n = nbytes;
 		if (n > SEC_XFER_SIZE)
 			n = SEC_XFER_SIZE;
-		if (n > random_state->entropy_count / 8)
-			n = random_state->entropy_count / 8;
+
+		DEBUG_ENT("%04d %04d : reading %d bits, p: %d s: %d\n",
+			  random_state->entropy_count,
+			  sec_random_state->entropy_count,
+			  n*8, random_state->entropy_count,
+			  sec_random_state->entropy_count);
+
+		n = extract_entropy(sec_random_state, buf, n,
+				    EXTRACT_ENTROPY_USER |
+				    EXTRACT_ENTROPY_LIMIT |
+				    EXTRACT_ENTROPY_SECONDARY);
+
+		DEBUG_ENT("%04d %04d : read got %d bits (%d still needed)\n",
+			  random_state->entropy_count,
+			  sec_random_state->entropy_count,
+			  n*8, (nbytes-n)*8);
+
 		if (n == 0) {
 			if (file->f_flags & O_NONBLOCK) {
 				retval = -EAGAIN;
@@ -1545,12 +1570,27 @@
 				retval = -ERESTARTSYS;
 				break;
 			}
-			schedule();
+
+			DEBUG_ENT("%04d %04d : sleeping?\n",
+				  random_state->entropy_count,
+				  sec_random_state->entropy_count);
+
+			set_current_state(TASK_INTERRUPTIBLE);
+			add_wait_queue(&random_read_wait, &wait);
+
+			if (sec_random_state->entropy_count / 8 == 0)
+				schedule();
+
+			set_current_state(TASK_RUNNING);
+			remove_wait_queue(&random_read_wait, &wait);
+
+			DEBUG_ENT("%04d %04d : waking up\n",
+				  random_state->entropy_count,
+				  sec_random_state->entropy_count);
+
 			continue;
 		}
-		n = extract_entropy(sec_random_state, buf, n,
-				    EXTRACT_ENTROPY_USER |
-				    EXTRACT_ENTROPY_SECONDARY);
+
 		if (n < 0) {
 			retval = n;
 			break;
@@ -1561,8 +1601,6 @@
 		break;		/* This break makes the device work */
 				/* like a named pipe */
 	}
-	current->state = TASK_RUNNING;
-	remove_wait_queue(&random_read_wait, &wait);
 
 	/*
 	 * If we gave the user some bytes, update the access time.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
