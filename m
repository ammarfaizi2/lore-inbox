Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVASIXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVASIXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVASIXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:23:01 -0500
Received: from waste.org ([216.27.176.166]:28588 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261667AbVASIRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:17:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.64403262@selenic.com>
Message-Id: <5.64403262@selenic.com>
Subject: [PATCH 4/12] random pt3: Catastrophic reseed checks
Date: Wed, 19 Jan 2005 00:17:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When reseeding, we must always do a "catastrophic reseed" where we
pull enough new bits to make the new state unguessable from outputs
even if we knew the old state. So we must do the checks against the
minimum reseed amount under the pool lock in extract_entropy.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:37:42.989360541 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:39:17.538306576 -0800
@@ -1183,7 +1183,7 @@
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int flags);
+			       size_t nbytes, int min, int flags);
 
 /*
  * This utility inline function is responsible for transfering entropy
@@ -1203,6 +1203,7 @@
 			  r->name, bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(&input_pool, tmp, bytes,
+				      random_read_wakeup_thresh / 8,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1220,10 +1221,13 @@
  * extracting entropy from the secondary pool, and can refill from the
  * primary pool if needed.
  *
+ * If we have less than min bytes of entropy available, exit without
+ * transferring any. This helps avoid racing when reseeding.
+ *
  * Note: extract_entropy() assumes that .poolwords is a multiple of 16 words.
  */
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int flags)
+			       size_t nbytes, int min, int flags)
 {
 	ssize_t ret, i;
 	__u32 tmp[TMP_BUF_SIZE], data[16];
@@ -1243,16 +1247,21 @@
 	DEBUG_ENT("trying to extract %d bits from %s\n",
 		  nbytes * 8, r->name);
 
-	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8)
-		nbytes = r->entropy_count / 8;
-
-	if (r->entropy_count / 8 >= nbytes)
-		r->entropy_count -= nbytes*8;
-	else
-		r->entropy_count = 0;
+	if (r->entropy_count / 8 < min) {
+		nbytes = 0;
+	} else {
+		if (flags & EXTRACT_ENTROPY_LIMIT &&
+		    nbytes >= r->entropy_count / 8)
+			nbytes = r->entropy_count / 8;
+
+		if (r->entropy_count / 8 >= nbytes)
+			r->entropy_count -= nbytes*8;
+		else
+			r->entropy_count = 0;
 
-	if (r->entropy_count < random_write_wakeup_thresh)
-		wake_up_interruptible(&random_write_wait);
+		if (r->entropy_count < random_write_wakeup_thresh)
+			wake_up_interruptible(&random_write_wait);
+	}
 
 	DEBUG_ENT("debiting %d entropy credits from %s%s\n",
 		  nbytes * 8, r->name,
@@ -1345,7 +1354,7 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	extract_entropy(&nonblocking_pool, (char *) buf, nbytes,
+	extract_entropy(&nonblocking_pool, (char *) buf, nbytes, 0,
 			EXTRACT_ENTROPY_SECONDARY);
 }
 
@@ -1435,7 +1444,7 @@
 
 		DEBUG_ENT("reading %d bits\n", n*8);
 
-		n = extract_entropy(&blocking_pool, buf, n,
+		n = extract_entropy(&blocking_pool, buf, n, 0,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT |
 				    EXTRACT_ENTROPY_SECONDARY);
@@ -1497,7 +1506,7 @@
 		flags |= EXTRACT_ENTROPY_SECONDARY;
 	spin_unlock_irqrestore(&input_pool.lock, cpuflags);
 
-	return extract_entropy(&nonblocking_pool, buf, nbytes, flags);
+	return extract_entropy(&nonblocking_pool, buf, nbytes, 0, flags);
 }
 
 static unsigned int
