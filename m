Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVASI3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVASI3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVASI3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:29:25 -0500
Received: from waste.org ([216.27.176.166]:23980 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261664AbVASIQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:16:59 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7.64403262@selenic.com>
Message-Id: <8.64403262@selenic.com>
Subject: [PATCH 7/12] random pt3: Reseed pointer in pool struct
Date: Wed, 19 Jan 2005 00:17:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Put pointer to reseed pool in pool struct and automatically pull
entropy from it if it is set. This lets us remove the
EXTRACT_SECONDARY flag.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:39:34.550137752 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:39:47.360504569 -0800
@@ -406,12 +406,14 @@
  *
  **********************************************************************/
 
+struct entropy_store;
 struct entropy_store {
 	/* mostly-read data: */
 	struct poolinfo *poolinfo;
 	__u32 *pool;
 	const char *name;
 	int limit;
+	struct entropy_store *pull;
 
 	/* read-write data: */
 	spinlock_t lock ____cacheline_aligned_in_smp;
@@ -436,6 +438,7 @@
 	.poolinfo = &poolinfo_table[1],
 	.name = "blocking",
 	.limit = 1,
+	.pull = &input_pool,
 	.lock = SPIN_LOCK_UNLOCKED,
 	.pool = blocking_pool_data
 };
@@ -443,6 +446,7 @@
 static struct entropy_store nonblocking_pool = {
 	.poolinfo = &poolinfo_table[1],
 	.name = "nonblocking",
+	.pull = &input_pool,
 	.lock = SPIN_LOCK_UNLOCKED,
 	.pool = nonblocking_pool_data
 };
@@ -1180,7 +1184,6 @@
  *********************************************************************/
 
 #define EXTRACT_ENTROPY_USER		1
-#define EXTRACT_ENTROPY_SECONDARY	2
 #define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
@@ -1195,7 +1198,7 @@
 static inline void xfer_secondary_pool(struct entropy_store *r,
 				       size_t nbytes, __u32 *tmp)
 {
-	if (r->entropy_count < nbytes * 8 &&
+	if (r->pull && r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo->POOLBITS) {
 		int bytes = max_t(int, random_read_wakeup_thresh / 8,
 				min_t(int, nbytes, TMP_BUF_SIZE));
@@ -1205,7 +1208,7 @@
 			  "(%d of %d requested)\n",
 			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
-		bytes=extract_entropy(&input_pool, tmp, bytes,
+		bytes=extract_entropy(r->pull, tmp, bytes,
 				      random_read_wakeup_thresh / 8, rsvd, 0);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1219,10 +1222,6 @@
  * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
  * flag is given, then the buf pointer is assumed to be in user space.
  *
- * If the EXTRACT_ENTROPY_SECONDARY flag is given, then we are actually
- * extracting entropy from the secondary pool, and can refill from the
- * primary pool if needed.
- *
  * The min parameter specifies the minimum amount we can pull before
  * failing to avoid races that defeat catastrophic reseeding while the
  * reserved parameter indicates how much entropy we must leave in the
@@ -1242,8 +1241,7 @@
 	if (r->entropy_count > r->poolinfo->POOLBITS)
 		r->entropy_count = r->poolinfo->POOLBITS;
 
-	if (flags & EXTRACT_ENTROPY_SECONDARY)
-		xfer_secondary_pool(r, nbytes, tmp);
+	xfer_secondary_pool(r, nbytes, tmp);
 
 	/* Hold lock while accounting */
 	spin_lock_irqsave(&r->lock, cpuflags);
@@ -1358,8 +1356,7 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	extract_entropy(&nonblocking_pool, (char *) buf, nbytes, 0, 0,
-			EXTRACT_ENTROPY_SECONDARY);
+	extract_entropy(&nonblocking_pool, (char *) buf, nbytes, 0, 0, 0);
 }
 
 EXPORT_SYMBOL(get_random_bytes);
@@ -1449,8 +1446,7 @@
 		DEBUG_ENT("reading %d bits\n", n*8);
 
 		n = extract_entropy(&blocking_pool, buf, n, 0, 0,
-				    EXTRACT_ENTROPY_USER |
-				    EXTRACT_ENTROPY_SECONDARY);
+				    EXTRACT_ENTROPY_USER);
 
 		DEBUG_ENT("read got %d bits (%d still needed)\n",
 			  n*8, (nbytes-n)*8);
