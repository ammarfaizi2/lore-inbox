Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbUCZABj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUCYX7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:59:15 -0500
Received: from waste.org ([209.173.204.2]:47769 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263812AbUCYX57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:57:59 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9.524465763@selenic.com>
Message-Id: <10.524465763@selenic.com>
Subject: [PATCH 9/22] /dev/random: more robust catastrophic reseed logic
Date: Thu, 25 Mar 2004 17:57:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  more robust catastrophic reseed logic

When reseeding, we always do a "catastrophic reseed" where we pull
enough new bits to make the new state unguessable from outputs even if we
knew the old state. So we must do the checks against the minimum
reseed amount under the pool lock in extract_entropy.


 tiny-mpm/drivers/char/random.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff -puN drivers/char/random.c~extract-min-max drivers/char/random.c
--- tiny/drivers/char/random.c~extract-min-max	2004-03-20 13:38:25.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:25.000000000 -0600
@@ -1264,7 +1264,7 @@ static void MD5Transform(__u32 buf[HASH_
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int flags);
+			       size_t nbytes, int min, int flags);
 
 /*
  * This utility inline function is responsible for transfering entropy
@@ -1276,14 +1276,14 @@ static inline void xfer_secondary_pool(s
 {
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo->POOLBITS) {
-		int bytes = max_t(int, random_read_wakeup_thresh / 8,
-				min_t(int, nbytes, TMP_BUF_SIZE));
+		int bytes = min_t(int, nbytes, TMP_BUF_SIZE);
 
 		DEBUG_ENT("going to reseed %s with %d bits "
 			  "(%d of %d requested)\n", r->name,
 			  bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(input_pool, tmp, bytes,
+				      random_read_wakeup_thresh / 8,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1297,10 +1297,13 @@ static inline void xfer_secondary_pool(s
  * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
  * flag is given, then the buf pointer is assumed to be in user space.
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
 	__u32 tmp[TMP_BUF_SIZE];
@@ -1320,16 +1323,21 @@ static ssize_t extract_entropy(struct en
 
 	DEBUG_ENT("trying to extract %d bits from %s\n", nbytes * 8, r->name);
 
-	if (flags & EXTRACT_ENTROPY_LIMIT && nbytes >= r->entropy_count / 8)
-		nbytes = r->entropy_count / 8;
+	if (r->entropy_count / 8 < min) {
+		nbytes = 0;
+	} else {
+		if (flags & EXTRACT_ENTROPY_LIMIT &&
+		    nbytes >= r->entropy_count / 8)
+			nbytes = r->entropy_count / 8;
 
-	if (r->entropy_count / 8 >= nbytes)
-		r->entropy_count -= nbytes*8;
-	else
-		r->entropy_count = 0;
+		if (r->entropy_count / 8 >= nbytes)
+			r->entropy_count -= nbytes*8;
+		else
+			r->entropy_count = 0;
 
-	if (r->entropy_count < random_write_wakeup_thresh)
-		wake_up_interruptible(&random_write_wait);
+		if (r->entropy_count < random_write_wakeup_thresh)
+			wake_up_interruptible(&random_write_wait);
+	}
 
 	DEBUG_ENT("debiting %d bits from %s%s\n", nbytes * 8, r->name,
 		  flags & EXTRACT_ENTROPY_LIMIT ? "" : " (unlimited)");
@@ -1413,7 +1421,7 @@ static ssize_t extract_entropy(struct en
 void get_random_bytes(void *buf, int nbytes)
 {
 	BUG_ON(!blocking_pool);
-	extract_entropy(blocking_pool, buf, nbytes, 0);
+	extract_entropy(blocking_pool, buf, nbytes, 0, 0);
 }
 
 EXPORT_SYMBOL(get_random_bytes);
@@ -1528,7 +1536,7 @@ random_read(struct file * file, char * b
 
 		DEBUG_ENT("reading %d bits\n", n*8);
 
-		n = extract_entropy(blocking_pool, buf, n,
+		n = extract_entropy(blocking_pool, buf, n, 0,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT);
 
@@ -1581,7 +1589,7 @@ static ssize_t
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(blocking_pool, buf, nbytes,
+	return extract_entropy(blocking_pool, buf, nbytes, 0,
 			       EXTRACT_ENTROPY_USER);
 }
 

_
