Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVASIn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVASIn1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVASI22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:28:28 -0500
Received: from waste.org ([216.27.176.166]:30636 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261671AbVASIRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:17:05 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11.64403262@selenic.com>
Message-Id: <12.64403262@selenic.com>
Subject: [PATCH 11/12] random pt3: Clean up hash buffering
Date: Wed, 19 Jan 2005 00:17:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up buffer usage for SHA and reseed. This makes the code more
readable and reduces worst-case stack usage.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:42:39.078612373 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:45:13.176966505 -0800
@@ -255,6 +255,7 @@
 #define INPUT_POOL_WORDS 128
 #define OUTPUT_POOL_WORDS 32
 #define BATCH_ENTROPY_SIZE 256
+#define SEC_XFER_SIZE 512
 
 /*
  * The minimum number of bits of entropy before we wake up a read on
@@ -813,6 +814,7 @@
  */
 
 #define HASH_BUFFER_SIZE 5
+#define EXTRACT_SIZE 10
 #define HASH_EXTRA_SIZE 80
 
 /* Various size/speed tradeoffs are available.  Choose 0..3. */
@@ -1048,9 +1050,6 @@
  *
  *********************************************************************/
 
-#define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
-#define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
-
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
 			       size_t nbytes, int min, int rsvd);
 
@@ -1059,13 +1058,14 @@
  * from the primary pool to the secondary extraction pool. We make
  * sure we pull enough for a 'catastrophic reseed'.
  */
-static void xfer_secondary_pool(struct entropy_store *r,
-				       size_t nbytes, __u32 *tmp)
+static void xfer_secondary_pool(struct entropy_store *r, size_t nbytes)
 {
+	__u32 tmp[OUTPUT_POOL_WORDS];
+
 	if (r->pull && r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo->POOLBITS) {
 		int bytes = max_t(int, random_read_wakeup_thresh / 8,
-				min_t(int, nbytes, TMP_BUF_SIZE));
+				min_t(int, nbytes, sizeof(tmp)));
 		int rsvd = r->limit ? 0 : random_read_wakeup_thresh/4;
 
 		DEBUG_ENT("going to reseed %s with %d bits "
@@ -1129,10 +1129,10 @@
 	return nbytes;
 }
 
-static void extract_buf(struct entropy_store *r, __u32 *buf)
+static void extract_buf(struct entropy_store *r, __u8 *out)
 {
 	int i, x;
-	__u32 data[16];
+	__u32 data[16], buf[85];
 
 	/* Hash the pool to get the output */
 	buf[0] = 0x67452301;
@@ -1151,7 +1151,7 @@
 	 */
 	for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
 		sha_transform(buf, r->pool+i);
-		add_entropy_words(r, &buf[x%HASH_BUFFER_SIZE], 1);
+		add_entropy_words(r, &buf[x % 5], 1);
 	}
 
 	/*
@@ -1159,7 +1159,7 @@
 	 * portion of the pool while mixing, and hash one
 	 * final time.
 	 */
-	__add_entropy_words(r, &buf[x%HASH_BUFFER_SIZE], 1, data);
+	__add_entropy_words(r, &buf[x % 5], 1, data);
 	sha_transform(buf, data);
 
 	/*
@@ -1170,21 +1170,23 @@
 	buf[0] ^= buf[3];
 	buf[1] ^= buf[4];
 	buf[0] ^= rol32(buf[3], 16);
+	memcpy(out, buf, EXTRACT_SIZE);
+	memset(buf, 0, sizeof(buf));
 }
 
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
 			       size_t nbytes, int min, int reserved)
 {
 	ssize_t ret = 0, i;
-	__u32 tmp[TMP_BUF_SIZE];
+	__u8 tmp[EXTRACT_SIZE];
 
-	xfer_secondary_pool(r, nbytes, tmp);
+	xfer_secondary_pool(r, nbytes);
 	nbytes = account(r, nbytes, min, reserved);
 
 	while (nbytes) {
 		extract_buf(r, tmp);
-		i = min(nbytes, HASH_BUFFER_SIZE * sizeof(__u32) / 2);
-		memcpy(buf, (__u8 const *)tmp, i);
+		i = min_t(int, nbytes, EXTRACT_SIZE);
+		memcpy(buf, tmp, i);
 		nbytes -= i;
 		buf += i;
 		ret += i;
@@ -1200,9 +1202,9 @@
 				    size_t nbytes)
 {
 	ssize_t ret = 0, i;
-	__u32 tmp[TMP_BUF_SIZE];
+	__u8 tmp[EXTRACT_SIZE];
 
-	xfer_secondary_pool(r, nbytes, tmp);
+	xfer_secondary_pool(r, nbytes);
 	nbytes = account(r, nbytes, 0, 0);
 
 	while (nbytes) {
@@ -1216,7 +1218,7 @@
 		}
 
 		extract_buf(r, tmp);
-		i = min(nbytes, HASH_BUFFER_SIZE * sizeof(__u32) / 2);
+		i = min_t(int, nbytes, EXTRACT_SIZE);
 		if (copy_to_user(buf, tmp, i)) {
 			ret = -EFAULT;
 			break;
