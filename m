Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbUCZBY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 20:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263816AbUCZABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:01:46 -0500
Received: from waste.org ([209.173.204.2]:49817 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263821AbUCYX6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7.524465763@selenic.com>
Message-Id: <8.524465763@selenic.com>
Subject: [PATCH 7/22] /dev/random: simplify reseed logic
Date: Thu, 25 Mar 2004 17:57:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  simplify reseed logic

Automatically reseed from input pool when pulling from output pools.


 tiny-mpm/drivers/char/random.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff -puN drivers/char/random.c~kill-extract-secondary drivers/char/random.c
--- tiny/drivers/char/random.c~kill-extract-secondary	2004-03-20 13:38:20.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:20.000000000 -0600
@@ -1259,8 +1259,7 @@ static void MD5Transform(__u32 buf[HASH_
  *********************************************************************/
 
 #define EXTRACT_ENTROPY_USER		1
-#define EXTRACT_ENTROPY_SECONDARY	2
-#define EXTRACT_ENTROPY_LIMIT		4
+#define EXTRACT_ENTROPY_LIMIT		2
 #define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
@@ -1298,10 +1297,6 @@ static inline void xfer_secondary_pool(s
  * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
  * flag is given, then the buf pointer is assumed to be in user space.
  *
- * If the EXTRACT_ENTROPY_SECONDARY flag is given, then we are actually
- * extracting entropy from the secondary pool, and can refill from the
- * primary pool if needed.
- *
  * Note: extract_entropy() assumes that .poolwords is a multiple of 16 words.
  */
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
@@ -1317,7 +1312,7 @@ static ssize_t extract_entropy(struct en
 	if (r->entropy_count > r->poolinfo->POOLBITS)
 		r->entropy_count = r->poolinfo->POOLBITS;
 
-	if (flags & EXTRACT_ENTROPY_SECONDARY)
+	if (r != input_pool)
 		xfer_secondary_pool(r, nbytes, tmp);
 
 	/* Hold lock while accounting */
@@ -1418,10 +1413,9 @@ static ssize_t extract_entropy(struct en
 void get_random_bytes(void *buf, int nbytes)
 {
 	if (blocking_pool)
-		extract_entropy(blocking_pool, (char *) buf, nbytes,
-				EXTRACT_ENTROPY_SECONDARY);
+		extract_entropy(blocking_pool, buf, nbytes, 0);
 	else if (input_pool)
-		extract_entropy(input_pool, (char *) buf, nbytes, 0);
+		extract_entropy(input_pool, buf, nbytes, 0);
 	else
 		printk(KERN_NOTICE "get_random_bytes called before "
 				   "random driver initialization\n");
@@ -1541,8 +1535,7 @@ random_read(struct file * file, char * b
 
 		n = extract_entropy(blocking_pool, buf, n,
 				    EXTRACT_ENTROPY_USER |
-				    EXTRACT_ENTROPY_LIMIT |
-				    EXTRACT_ENTROPY_SECONDARY);
+				    EXTRACT_ENTROPY_LIMIT);
 
 		DEBUG_ENT("read got %d bits (%d still needed)\n",
 			  n*8, (nbytes-n)*8);
@@ -1594,8 +1587,7 @@ urandom_read(struct file * file, char * 
 		      size_t nbytes, loff_t *ppos)
 {
 	return extract_entropy(blocking_pool, buf, nbytes,
-			       EXTRACT_ENTROPY_USER |
-			       EXTRACT_ENTROPY_SECONDARY);
+			       EXTRACT_ENTROPY_USER);
 }
 
 static unsigned int

_
