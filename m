Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVASIdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVASIdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVASIb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:31:27 -0500
Received: from waste.org ([216.27.176.166]:22444 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261662AbVASIQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:16:57 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.64403262@selenic.com>
Message-Id: <6.64403262@selenic.com>
Subject: [PATCH 5/12] random pt3: Entropy reservation accounting
Date: Wed, 19 Jan 2005 00:17:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additional parameter to allow keeping an entropy reserve in the input
pool. Groundwork for proper /dev/urandom vs /dev/random starvation prevention.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:39:17.538306576 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:39:25.713264357 -0800
@@ -1183,7 +1183,7 @@
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int min, int flags);
+			       size_t nbytes, int min, int rsvd, int flags);
 
 /*
  * This utility inline function is responsible for transfering entropy
@@ -1203,7 +1203,7 @@
 			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(&input_pool, tmp, bytes,
-				      random_read_wakeup_thresh / 8,
+				      random_read_wakeup_thresh / 8, 0,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1221,13 +1221,15 @@
  * extracting entropy from the secondary pool, and can refill from the
  * primary pool if needed.
  *
- * If we have less than min bytes of entropy available, exit without
- * transferring any. This helps avoid racing when reseeding.
+ * The min parameter specifies the minimum amount we can pull before
+ * failing to avoid races that defeat catastrophic reseeding while the
+ * reserved parameter indicates how much entropy we must leave in the
+ * pool after each pull to avoid starving other readers.
  *
  * Note: extract_entropy() assumes that .poolwords is a multiple of 16 words.
  */
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int min, int flags)
+			       size_t nbytes, int min, int reserved, int flags)
 {
 	ssize_t ret, i;
 	__u32 tmp[TMP_BUF_SIZE], data[16];
@@ -1247,17 +1249,19 @@
 	DEBUG_ENT("trying to extract %d bits from %s\n",
 		  nbytes * 8, r->name);
 
-	if (r->entropy_count / 8 < min) {
+	/* Can we pull enough? */
+	if (r->entropy_count / 8 < min + reserved) {
 		nbytes = 0;
 	} else {
+		/* If limited, never pull more than available */
 		if (flags & EXTRACT_ENTROPY_LIMIT &&
-		    nbytes >= r->entropy_count / 8)
-			nbytes = r->entropy_count / 8;
+		    nbytes + reserved >= r->entropy_count / 8)
+			nbytes = r->entropy_count/8 - reserved;
 
-		if (r->entropy_count / 8 >= nbytes)
+		if(r->entropy_count / 8 >= nbytes + reserved)
 			r->entropy_count -= nbytes*8;
 		else
-			r->entropy_count = 0;
+			r->entropy_count = reserved;
 
 		if (r->entropy_count < random_write_wakeup_thresh)
 			wake_up_interruptible(&random_write_wait);
@@ -1354,7 +1358,7 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	extract_entropy(&nonblocking_pool, (char *) buf, nbytes, 0,
+	extract_entropy(&nonblocking_pool, (char *) buf, nbytes, 0, 0,
 			EXTRACT_ENTROPY_SECONDARY);
 }
 
@@ -1444,7 +1448,7 @@
 
 		DEBUG_ENT("reading %d bits\n", n*8);
 
-		n = extract_entropy(&blocking_pool, buf, n, 0,
+		n = extract_entropy(&blocking_pool, buf, n, 0, 0,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT |
 				    EXTRACT_ENTROPY_SECONDARY);
@@ -1506,7 +1510,7 @@
 		flags |= EXTRACT_ENTROPY_SECONDARY;
 	spin_unlock_irqrestore(&input_pool.lock, cpuflags);
 
-	return extract_entropy(&nonblocking_pool, buf, nbytes, 0, flags);
+	return extract_entropy(&nonblocking_pool, buf, nbytes, 0, 0, flags);
 }
 
 static unsigned int
