Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318332AbSIKFLe>; Wed, 11 Sep 2002 01:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318344AbSIKFLd>; Wed, 11 Sep 2002 01:11:33 -0400
Received: from waste.org ([209.173.204.2]:17812 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318332AbSIKFLa>;
	Wed, 11 Sep 2002 01:11:30 -0400
Date: Wed, 11 Sep 2002 00:16:16 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/11] Entropy fixes - xfer cleanup *important*
Message-ID: <20020911051616.GR31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a bug where entropy transfer takes more from the primary pool than
is there and credits the secondary with 1000 extra bits.

This also makes this code properly handle catastrophic reseeding by
raising the wakeup threshold from 8 to 64.

Consider the situation where the state of both pools is compromised
and is known at time T1. If 8 bits of entropy appear in the primary
pool, unblocking random_read, this function would transfer most of the
primary pool to the secondary, then give a byte of data to the user at
time T2. Given that byte and the known state at T1, the user can test
the possible 256 input bits to the primary pool, generate the 256
possible outputs from the secondary, and reduce the possible known
states at time T2 to a handful. This is dependent solely on the wakeup
threshold and not on the transfer size. Raising the wakeup threshold
to 64 means calculating 2^64 possible pool states, making state
extension unreasonably hard.

The second clause of the xfer function was intended to handle this
catastrophic reseeding, but given the weakness in the first clause, it
added nothing.

Large temporary buffers on stack made static.

diff -urN clean/drivers/char/random.c patched/drivers/char/random.c
--- clean/drivers/char/random.c	2002-09-10 23:27:55.000000000 -0500
+++ patched/drivers/char/random.c	2002-09-10 23:28:40.000000000 -0500
@@ -271,9 +271,9 @@
 
 /*
  * The minimum number of bits of entropy before we wake up a read on
- * /dev/random.  Should always be at least 8, or at least 1 byte.
+ * /dev/random.  Should be enough to do a significant reseed.
  */
-static int random_read_wakeup_thresh = 8;
+static int random_read_wakeup_thresh = 64;
 
 /*
  * If the entropy count falls under this number of bits, then we
@@ -448,7 +448,6 @@
 	unsigned	add_ptr;
 	int		entropy_count;
 	int		input_rotate;
-	int		extract_count;
 	struct poolinfo poolinfo;
 	__u32		*pool;
 };
@@ -499,7 +498,6 @@
 	r->add_ptr = 0;
 	r->entropy_count = 0;
 	r->input_rotate = 0;
-	r->extract_count = 0;
 	memset(r->pool, 0, r->poolinfo.POOLBYTES);
 }
 
@@ -1198,30 +1196,21 @@
 static inline void xfer_secondary_pool(struct entropy_store *r,
 				       size_t nbytes)
 {
-	__u32	tmp[TMP_BUF_SIZE];
+	static __u32 tmp[TMP_BUF_SIZE];
 
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
-		int nwords = min_t(int,
-				   r->poolinfo.poolwords - r->entropy_count/32,
-				   sizeof(tmp) / 4);
+		int bytes = min_t(int, nbytes - r->entropy_count/8,
+				   sizeof(tmp));
 
-		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
-			  nwords * 32,
+		DEBUG_ENT("xfer %d to %s (have %d, need %d)\n",
+			  bytes * 8,
 			  r == sec_random_state ? "secondary" : "unknown",
 			  r->entropy_count, nbytes * 8);
 
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
+		extract_entropy(random_state, tmp, bytes, 0);
+		add_entropy_words(r, tmp, bytes);
+		credit_entropy_store(r, bytes*8);
 	}
 }
 
@@ -1242,11 +1231,9 @@
 			       size_t nbytes, int flags)
 {
 	ssize_t ret, i;
-	__u32 tmp[TMP_BUF_SIZE];
+	static __u32 tmp[TMP_BUF_SIZE];
 	__u32 x;
 
-	add_timer_randomness(&extract_timer_state, nbytes);
-
 	/* Redundant, but just in case... */
 	if (r->entropy_count > r->poolinfo.POOLBITS)
 		r->entropy_count = r->poolinfo.POOLBITS;
@@ -1267,8 +1254,6 @@
 	if (r->entropy_count < random_write_wakeup_thresh)
 		wake_up_interruptible(&random_write_wait);
 
-	r->extract_count += nbytes;
-	
 	ret = 0;
 	while (nbytes) {
 		/*
@@ -1329,7 +1314,6 @@
 		nbytes -= i;
 		buf += i;
 		ret += i;
-		add_timer_randomness(&extract_timer_state, nbytes);
 	}
 
 	/* Wipe data just returned from memory */
@@ -1483,6 +1467,11 @@
 			schedule();
 			continue;
 		}
+
+		DEBUG_ENT("extracting %d bits, p: %d s: %d\n",
+			  n*8, random_state->entropy_count,
+			  sec_random_state->entropy_count);
+
 		n = extract_entropy(sec_random_state, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_SECONDARY);


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
