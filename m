Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUCZABf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbUCZABX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:01:23 -0500
Received: from waste.org ([209.173.204.2]:49305 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263820AbUCYX6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <10.524465763@selenic.com>
Message-Id: <11.524465763@selenic.com>
Subject: [PATCH 10/22] /dev/random: entropy reserve logic for starvation preve
Date: Thu, 25 Mar 2004 17:57:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  entropy reserve logic for starvation prevention

Additional parameter to allow keeping an entropy reserve in the input
pool. Groundwork for /dev/urandom vs /dev/random starvation prevention.

 tiny-mpm/drivers/char/random.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff -puN drivers/char/random.c~debit-entropy drivers/char/random.c
--- tiny/drivers/char/random.c~debit-entropy	2004-03-20 13:38:26.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:26.000000000 -0600
@@ -1264,7 +1264,7 @@ static void MD5Transform(__u32 buf[HASH_
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
-			       size_t nbytes, int min, int flags);
+			       size_t nbytes, int min, int rsvd, int flags);
 
 /*
  * This utility inline function is responsible for transfering entropy
@@ -1283,7 +1283,7 @@ static inline void xfer_secondary_pool(s
 			  bytes * 8, nbytes * 8, r->entropy_count);
 
 		bytes=extract_entropy(input_pool, tmp, bytes,
-				      random_read_wakeup_thresh / 8,
+				      random_read_wakeup_thresh / 8, 0,
 				      EXTRACT_ENTROPY_LIMIT);
 		add_entropy_words(r, tmp, bytes);
 		credit_entropy_store(r, bytes*8);
@@ -1297,13 +1297,15 @@ static inline void xfer_secondary_pool(s
  * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
  * flag is given, then the buf pointer is assumed to be in user space.
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
 	__u32 tmp[TMP_BUF_SIZE];
@@ -1323,17 +1325,19 @@ static ssize_t extract_entropy(struct en
 
 	DEBUG_ENT("trying to extract %d bits from %s\n", nbytes * 8, r->name);
 
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
@@ -1421,7 +1425,7 @@ static ssize_t extract_entropy(struct en
 void get_random_bytes(void *buf, int nbytes)
 {
 	BUG_ON(!blocking_pool);
-	extract_entropy(blocking_pool, buf, nbytes, 0, 0);
+	extract_entropy(blocking_pool, buf, nbytes, 0, 0, 0);
 }
 
 EXPORT_SYMBOL(get_random_bytes);
@@ -1536,7 +1540,7 @@ random_read(struct file * file, char * b
 
 		DEBUG_ENT("reading %d bits\n", n*8);
 
-		n = extract_entropy(blocking_pool, buf, n, 0,
+		n = extract_entropy(blocking_pool, buf, n, 0, 0,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT);
 
@@ -1589,7 +1593,7 @@ static ssize_t
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(blocking_pool, buf, nbytes, 0,
+	return extract_entropy(blocking_pool, buf, nbytes, 0, 0,
 			       EXTRACT_ENTROPY_USER);
 }
 

_
