Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266339AbUHTE53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUHTE53 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 00:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUHTE53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 00:57:29 -0400
Received: from thunk.org ([140.239.227.29]:15020 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266339AbUHTE5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 00:57:18 -0400
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: [PATCH] [2/4] /dev/random: Add pool name to entropy store
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1By1Sm-0001TM-V7@thunk.org>
Date: Fri, 20 Aug 2004 00:57:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds a pool name to the entropy_store data structure, which
simplifies the debugging code, and makes the code more generic for
adding additional entropy pools.

patch-random-2-pool-name

--- random.c	2004/08/19 22:49:20	1.2
+++ random.c	2004/08/19 22:49:48	1.3
@@ -493,6 +493,7 @@
 	/* mostly-read data: */
 	struct poolinfo poolinfo;
 	__u32		*pool;
+	const char	*name;
 
 	/* read-write data: */
 	spinlock_t lock ____cacheline_aligned_in_smp;
@@ -507,7 +508,8 @@
  *
  * Returns an negative error if there is a problem.
  */
-static int create_entropy_store(int size, struct entropy_store **ret_bucket)
+static int create_entropy_store(int size, const char *name, 
+				struct entropy_store **ret_bucket)
 {
 	struct	entropy_store	*r;
 	struct	poolinfo	*p;
@@ -538,6 +540,7 @@
 	}
 	memset(r->pool, 0, POOLBYTES);
 	r->lock = SPIN_LOCK_UNLOCKED;
+	r->name = name;
 	*ret_bucket = r;
 	return 0;
 }
@@ -643,12 +646,8 @@
 	} else {
 		r->entropy_count += nbits;
 		if (nbits)
-			DEBUG_ENT("%04d %04d : added %d bits to %s\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count,
-				  nbits,
-				  r == sec_random_state ? "secondary" :
-				  r == random_state ? "primary" : "unknown");
+			DEBUG_ENT("Added %d entropy credits to %s, now %d\n",
+				  nbits, r->name, r->entropy_count);
 	}
 
 	spin_unlock_irqrestore(&r->lock, flags);
@@ -1328,8 +1327,7 @@
 			  "(%d of %d requested)\n",
 			  random_state->entropy_count,
 			  sec_random_state->entropy_count,
-			  r == sec_random_state ? "secondary" : "unknown",
-			  bytes * 8, nbytes * 8, r->entropy_count);
+			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(random_state, tmp, bytes,
 				      EXTRACT_ENTROPY_LIMIT);
@@ -1373,9 +1371,7 @@
 	DEBUG_ENT("%04d %04d : trying to extract %d bits from %s\n",
 		  random_state->entropy_count,
 		  sec_random_state->entropy_count,
-		  nbytes * 8,
-		  r == sec_random_state ? "secondary" :
-		  r == random_state ? "primary" : "unknown");
+		  nbytes * 8, r->name);
 
 	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8)
 		nbytes = r->entropy_count / 8;
@@ -1388,12 +1384,8 @@
 	if (r->entropy_count < random_write_wakeup_thresh)
 		wake_up_interruptible(&random_write_wait);
 
-	DEBUG_ENT("%04d %04d : debiting %d bits from %s%s\n",
-		  random_state->entropy_count,
-		  sec_random_state->entropy_count,
-		  nbytes * 8,
-		  r == sec_random_state ? "secondary" :
-		  r == random_state ? "primary" : "unknown",
+	DEBUG_ENT("Debiting %d entropy credits from %s%s\n",
+		  nbytes * 8, r->name,
 		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
 
 	spin_unlock_irqrestore(&r->lock, cpuflags);
@@ -1533,11 +1525,12 @@
 {
 	int i;
 
-	if (create_entropy_store(DEFAULT_POOL_SIZE, &random_state))
+	if (create_entropy_store(DEFAULT_POOL_SIZE, "primary", &random_state))
 		goto err;
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, random_state))
 		goto err;
-	if (create_entropy_store(SECONDARY_POOL_SIZE, &sec_random_state))
+	if (create_entropy_store(SECONDARY_POOL_SIZE, "secondary", 
+				 &sec_random_state))
 		goto err;
 	clear_entropy_store(random_state);
 	clear_entropy_store(sec_random_state);
@@ -1884,7 +1877,8 @@
 	struct entropy_store	*new_store, *old_store;
 	int			ret;
 	
-	if ((ret = create_entropy_store(poolsize, &new_store)))
+	if ((ret = create_entropy_store(poolsize, random_state->name, 
+					&new_store)))
 		return ret;
 
 	add_entropy_words(new_store, random_state->pool,
