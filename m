Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVAUWTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVAUWTc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVAUWEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:04:46 -0500
Received: from waste.org ([216.27.176.166]:26585 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262525AbVAUVlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:18 -0500
Date: Fri, 21 Jan 2005 15:41:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.314297600@selenic.com>
Message-Id: <5.314297600@selenic.com>
Subject: [PATCH 4/12] random pt4: Cleanup SHA interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up SHA hash function for moving to lib/
Do proper endian conversion
Provide sha_init function
Add kerneldoc

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/drivers/char/random.c
===================================================================
--- rnd2.orig/drivers/char/random.c	2005-01-20 12:28:27.979725732 -0800
+++ rnd2/drivers/char/random.c	2005-01-20 12:28:34.506893589 -0800
@@ -671,29 +671,6 @@
 
 EXPORT_SYMBOL(add_disk_randomness);
 
-/******************************************************************
- *
- * Hash function definition
- *
- *******************************************************************/
-
-/*
- * This chunk of code defines a function
- * void sha_transform(__u32 digest[HASH_BUFFER_SIZE + HASH_EXTRA_SIZE],
- * 		__u32 const data[16])
- *
- * The function hashes the input data to produce a digest in the first
- * HASH_BUFFER_SIZE words of the digest[] array, and uses HASH_EXTRA_SIZE
- * more words for internal purposes.  (This buffer is exported so the
- * caller can wipe it once rather than this code doing it each call,
- * and tacking it onto the end of the digest[] array is the quick and
- * dirty way of doing it.)
- *
- * For /dev/random purposes, the length of the data being hashed is
- * fixed in length, so appending a bit count in the usual way is not
- * cryptographically necessary.
- */
-
 #define HASH_BUFFER_SIZE 5
 #define EXTRACT_SIZE 10
 #define HASH_EXTRA_SIZE 80
@@ -717,20 +694,32 @@
 #define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
 #define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
 
-static void sha_transform(__u32 digest[85], __u32 const data[16])
+/*
+ * sha_transform: single block SHA1 transform
+ *
+ * @digest: 160 bit digest to update
+ * @data:   512 bytes of data to hash
+ * @W:      80 words of workspace
+ *
+ * This function generates a SHA1 digest for a single. Be warned, it
+ * does not handle padding and message digest, do not confuse it with
+ * the full FIPS 180-1 digest algorithm for variable length messages.
+ */
+static void sha_transform(__u32 digest[5], const char *data, __u32 W[80])
 {
-	__u32 A, B, C, D, E;     /* Local vars */
+	__u32 A, B, C, D, E;
 	__u32 TEMP;
 	int i;
-#define W (digest + HASH_BUFFER_SIZE)	/* Expanded data array */
 
+	memset(W, 0, sizeof(W));
+	for (i = 0; i < 16; i++)
+		W[i] = be32_to_cpu(((const __u32 *)data)[i]);
 	/*
 	 * Do the preliminary expansion of 16 to 80 words.  Doing it
 	 * out-of-line line this is faster than doing it in-line on
 	 * register-starved machines like the x86, and not really any
 	 * slower on real processors.
 	 */
-	memcpy(W, data, 16*sizeof(__u32));
 	for (i = 0; i < 64; i++) {
 		TEMP = W[i] ^ W[i+2] ^ W[i+8] ^ W[i+13];
 		W[i+16] = rol32(TEMP, 1);
@@ -768,7 +757,6 @@
 	digest[4] += E;
 
 	/* W is wiped by the caller */
-#undef W
 }
 
 #undef f1
@@ -780,6 +768,20 @@
 #undef K3
 #undef K4
 
+/*
+ * sha_init: initialize the vectors for a SHA1 digest
+ *
+ * @buf: vector to initialize
+ */
+static void sha_init(__u32 *buf)
+{
+	buf[0] = 0x67452301;
+	buf[1] = 0xefcdab89;
+	buf[2] = 0x98badcfe;
+	buf[3] = 0x10325476;
+	buf[4] = 0xc3d2e1f0;
+}
+
 /*********************************************************************
  *
  * Entropy extraction routines
@@ -870,13 +872,7 @@
 	int i, x;
 	__u32 data[16], buf[85];
 
-	/* Hash the pool to get the output */
-	buf[0] = 0x67452301;
-	buf[1] = 0xefcdab89;
-	buf[2] = 0x98badcfe;
-	buf[3] = 0x10325476;
-	buf[4] = 0xc3d2e1f0;
-
+	sha_init(buf);
 	/*
 	 * As we hash the pool, we mix intermediate values of
 	 * the hash back into the pool.  This eliminates
@@ -886,7 +882,7 @@
 	 * function can be inverted.
 	 */
 	for (i = 0, x = 0; i < r->poolinfo->poolwords; i += 16, x+=2) {
-		sha_transform(buf, r->pool+i);
+		sha_transform(buf, (__u8 *)r->pool+i, buf + 5);
 		add_entropy_words(r, &buf[x % 5], 1);
 	}
 
@@ -896,7 +892,7 @@
 	 * final time.
 	 */
 	__add_entropy_words(r, &buf[x % 5], 1, data);
-	sha_transform(buf, data);
+	sha_transform(buf, (__u8 *)data, buf + 5);
 
 	/*
 	 * In case the hash function has some recognizable
@@ -1771,7 +1767,7 @@
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	sha_transform(tmp+16, tmp);
+	sha_transform(tmp+16, (__u8 *)tmp, tmp + 16 + 5);
 	seq = tmp[17] + sseq + (count << COOKIEBITS);
 
 	memcpy(tmp + 3, syncookie_secret[1], sizeof(syncookie_secret[1]));
@@ -1779,7 +1775,7 @@
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
 	tmp[3] = count;	/* minute counter */
-	sha_transform(tmp + 16, tmp);
+	sha_transform(tmp + 16, (__u8 *)tmp, tmp + 16 + 5);
 
 	/* Add in the second hash and the data */
 	return seq + ((tmp[17] + data) & COOKIEMASK);
@@ -1808,7 +1804,7 @@
 	tmp[0]=saddr;
 	tmp[1]=daddr;
 	tmp[2]=(sport << 16) + dport;
-	sha_transform(tmp + 16, tmp);
+	sha_transform(tmp + 16, (__u8 *)tmp, tmp + 16 + 5);
 	cookie -= tmp[17] + sseq;
 	/* Cookie is now reduced to (count * 2^24) ^ (hash % 2^24) */
 
