Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVASIdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVASIdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVASIag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:30:36 -0500
Received: from waste.org ([216.27.176.166]:22956 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261663AbVASIQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:16:58 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6.64403262@selenic.com>
Message-Id: <7.64403262@selenic.com>
Subject: [PATCH 6/12] random pt3: Reservation flag in pool struct
Date: Wed, 19 Jan 2005 00:17:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the limit flag to the pool struct, begin process of eliminating
extract flags.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:39:25.713264357 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:39:34.550137752 -0800
@@ -411,6 +411,7 @@
 	struct poolinfo *poolinfo;
 	__u32 *pool;
 	const char *name;
+	int limit;
 
 	/* read-write data: */
 	spinlock_t lock ____cacheline_aligned_in_smp;
@@ -426,6 +427,7 @@
 static struct entropy_store input_pool = {
 	.poolinfo = &poolinfo_table[0],
 	.name = "input",
+	.limit = 1,
 	.lock = SPIN_LOCK_UNLOCKED,
 	.pool = input_pool_data
 };
@@ -433,6 +435,7 @@
 static struct entropy_store blocking_pool = {
 	.poolinfo = &poolinfo_table[1],
 	.name = "blocking",
+	.limit = 1,
 	.lock = SPIN_LOCK_UNLOCKED,
 	.pool = blocking_pool_data
 };
@@ -1178,7 +1181,6 @@
 
 #define EXTRACT_ENTROPY_USER		1
 #define EXTRACT_ENTROPY_SECONDARY	2
-#define EXTRACT_ENTROPY_LIMIT		4
 #define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
@@ -1197,14 +1199,14 @@
 	    r->entropy_count < r->poolinfo->POOLBITS) {
 		int bytes = max_t(int, random_read_wakeup_thresh / 8,
 				min_t(int, nbytes, TMP_BUF_SIZE));
+		int rsvd = r->limit ? 0 : random_read_wakeup_thresh/4;
 
 		DEBUG_ENT("going to reseed %s with %d bits "
 			  "(%d of %d requested)\n",
 			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(&input_pool, tmp, bytes,
-				      random_read_wakeup_thresh / 8, 0,
-				      EXTRACT_ENTROPY_LIMIT);
+				      random_read_wakeup_thresh / 8, rsvd, 0);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
 	}
@@ -1254,8 +1256,7 @@
 		nbytes = 0;
 	} else {
 		/* If limited, never pull more than available */
-		if (flags & EXTRACT_ENTROPY_LIMIT &&
-		    nbytes + reserved >= r->entropy_count / 8)
+		if (r->limit && nbytes + reserved >= r->entropy_count / 8)
 			nbytes = r->entropy_count/8 - reserved;
 
 		if(r->entropy_count / 8 >= nbytes + reserved)
@@ -1268,8 +1269,7 @@
 	}
 
 	DEBUG_ENT("debiting %d entropy credits from %s%s\n",
-		  nbytes * 8, r->name,
-		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
+		  nbytes * 8, r->name, r->limit ? "" : " (unlimited)");
 
 	spin_unlock_irqrestore(&r->lock, cpuflags);
 
@@ -1450,7 +1450,6 @@
 
 		n = extract_entropy(&blocking_pool, buf, n, 0, 0,
 				    EXTRACT_ENTROPY_USER |
-				    EXTRACT_ENTROPY_LIMIT |
 				    EXTRACT_ENTROPY_SECONDARY);
 
 		DEBUG_ENT("read got %d bits (%d still needed)\n",
@@ -1502,15 +1501,8 @@
 urandom_read(struct file * file, char __user * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	int flags = EXTRACT_ENTROPY_USER;
-	unsigned long cpuflags;
-
-	spin_lock_irqsave(&input_pool.lock, cpuflags);
-	if (input_pool.entropy_count > input_pool.poolinfo->POOLBITS)
-		flags |= EXTRACT_ENTROPY_SECONDARY;
-	spin_unlock_irqrestore(&input_pool.lock, cpuflags);
-
-	return extract_entropy(&nonblocking_pool, buf, nbytes, 0, 0, flags);
+	return extract_entropy(&nonblocking_pool, buf, nbytes, 0, 0,
+			       EXTRACT_ENTROPY_USER);
 }
 
 static unsigned int
