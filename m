Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVAUVpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVAUVpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVAUVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:45:16 -0500
Received: from waste.org ([216.27.176.166]:31193 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262537AbVAUVlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:24 -0500
Date: Fri, 21 Jan 2005 15:41:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.314297600@selenic.com>
Message-Id: <6.314297600@selenic.com>
Subject: [PATCH 5/12] random pt4: Move SHA code to lib/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move random SHA code to lib/.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/lib/Makefile
===================================================================
--- rnd2.orig/lib/Makefile	2005-01-20 09:41:30.000000000 -0800
+++ rnd2/lib/Makefile	2005-01-20 12:20:08.424413615 -0800
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o prio_tree.o
+	 bitmap.o extable.o kobject_uevent.o prio_tree.o sha1.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
Index: rnd2/drivers/char/random.c
===================================================================
--- rnd2.orig/drivers/char/random.c	2005-01-20 09:41:30.000000000 -0800
+++ rnd2/drivers/char/random.c	2005-01-20 12:20:08.424413615 -0800
@@ -218,9 +218,6 @@
  * Any flaws in the design are solely my responsibility, and should
  * not be attributed to the Phil, Colin, or any of authors of PGP.
  *
- * The code for SHA transform was taken from Peter Gutmann's
- * implementation, which has been placed in the public domain.
- *
  * Further background information on this topic may be obtained from
  * RFC 1750, "Randomness Recommendations for Security", by Donald
  * Eastlake, Steve Crocker, and Jeff Schiller.
@@ -242,6 +239,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/percpu.h>
+#include <linux/cryptohash.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -671,116 +669,7 @@
 
 EXPORT_SYMBOL(add_disk_randomness);
 
-#define HASH_BUFFER_SIZE 5
 #define EXTRACT_SIZE 10
-#define HASH_EXTRA_SIZE 80
-
-/*
- * SHA transform algorithm, taken from code written by Peter Gutmann,
- * and placed in the public domain.
- */
-
-/* The SHA f()-functions.  */
-
-#define f1(x,y,z)   (z ^ (x & (y ^ z)))		/* Rounds  0-19: x ? y : z */
-#define f2(x,y,z)   (x ^ y ^ z)			/* Rounds 20-39: XOR */
-#define f3(x,y,z)   ((x & y) + (z & (x ^ y)))	/* Rounds 40-59: majority */
-#define f4(x,y,z)   (x ^ y ^ z)			/* Rounds 60-79: XOR */
-
-/* The SHA Mysterious Constants */
-
-#define K1  0x5A827999L			/* Rounds  0-19: sqrt(2) * 2^30 */
-#define K2  0x6ED9EBA1L			/* Rounds 20-39: sqrt(3) * 2^30 */
-#define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
-#define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
-
-/*
- * sha_transform: single block SHA1 transform
- *
- * @digest: 160 bit digest to update
- * @data:   512 bytes of data to hash
- * @W:      80 words of workspace
- *
- * This function generates a SHA1 digest for a single. Be warned, it
- * does not handle padding and message digest, do not confuse it with
- * the full FIPS 180-1 digest algorithm for variable length messages.
- */
-static void sha_transform(__u32 digest[5], const char *data, __u32 W[80])
-{
-	__u32 A, B, C, D, E;
-	__u32 TEMP;
-	int i;
-
-	memset(W, 0, sizeof(W));
-	for (i = 0; i < 16; i++)
-		W[i] = be32_to_cpu(((const __u32 *)data)[i]);
-	/*
-	 * Do the preliminary expansion of 16 to 80 words.  Doing it
-	 * out-of-line line this is faster than doing it in-line on
-	 * register-starved machines like the x86, and not really any
-	 * slower on real processors.
-	 */
-	for (i = 0; i < 64; i++) {
-		TEMP = W[i] ^ W[i+2] ^ W[i+8] ^ W[i+13];
-		W[i+16] = rol32(TEMP, 1);
-	}
-
-	/* Set up first buffer and local data buffer */
-	A = digest[ 0 ];
-	B = digest[ 1 ];
-	C = digest[ 2 ];
-	D = digest[ 3 ];
-	E = digest[ 4 ];
-
-	/* Heavy mangling, in 4 sub-rounds of 20 iterations each. */
-	for (i = 0; i < 80; i++) {
-		if (i < 40) {
-			if (i < 20)
-				TEMP = f1(B, C, D) + K1;
-			else
-				TEMP = f2(B, C, D) + K2;
-		} else {
-			if (i < 60)
-				TEMP = f3(B, C, D) + K3;
-			else
-				TEMP = f4(B, C, D) + K4;
-		}
-		TEMP += rol32(A, 5) + E + W[i];
-		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
-	}
-
-	/* Build message digest */
-	digest[0] += A;
-	digest[1] += B;
-	digest[2] += C;
-	digest[3] += D;
-	digest[4] += E;
-
-	/* W is wiped by the caller */
-}
-
-#undef f1
-#undef f2
-#undef f3
-#undef f4
-#undef K1
-#undef K2
-#undef K3
-#undef K4
-
-/*
- * sha_init: initialize the vectors for a SHA1 digest
- *
- * @buf: vector to initialize
- */
-static void sha_init(__u32 *buf)
-{
-	buf[0] = 0x67452301;
-	buf[1] = 0xefcdab89;
-	buf[2] = 0x98badcfe;
-	buf[3] = 0x10325476;
-	buf[4] = 0xc3d2e1f0;
-}
 
 /*********************************************************************
  *
@@ -870,7 +759,7 @@
 static void extract_buf(struct entropy_store *r, __u8 *out)
 {
 	int i, x;
-	__u32 data[16], buf[85];
+	__u32 data[16], buf[5 + SHA_WORKSPACE_WORDS];
 
 	sha_init(buf);
 	/*
@@ -1736,12 +1625,12 @@
 #define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
 
 static int syncookie_init;
-static __u32 syncookie_secret[2][16-3+HASH_BUFFER_SIZE];
+static __u32 syncookie_secret[2][16-3+SHA_DIGEST_WORDS];
 
 __u32 secure_tcp_syn_cookie(__u32 saddr, __u32 daddr, __u16 sport,
 		__u16 dport, __u32 sseq, __u32 count, __u32 data)
 {
-	__u32 tmp[16 + HASH_BUFFER_SIZE + HASH_EXTRA_SIZE];
+	__u32 tmp[16 + 5 + SHA_WORKSPACE_WORDS];
 	__u32 seq;
 
 	/*
@@ -1793,7 +1682,7 @@
 __u32 check_tcp_syn_cookie(__u32 cookie, __u32 saddr, __u32 daddr, __u16 sport,
 		__u16 dport, __u32 sseq, __u32 count, __u32 maxdiff)
 {
-	__u32 tmp[16 + HASH_BUFFER_SIZE + HASH_EXTRA_SIZE];
+	__u32 tmp[16 + 5 + SHA_WORKSPACE_WORDS];
 	__u32 diff;
 
 	if (syncookie_init == 0)
Index: rnd2/include/linux/cryptohash.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ rnd2/include/linux/cryptohash.h	2005-01-20 12:20:08.424413615 -0800
@@ -0,0 +1,10 @@
+#ifndef __CRYPTOHASH_H
+#define __CRYPTOHASH_H
+
+#define SHA_DIGEST_WORDS 5
+#define SHA_WORKSPACE_WORDS 80
+
+void sha_init(__u32 *buf);
+void sha_transform(__u32 *digest, const char *data, __u32 *W);
+
+#endif
Index: rnd2/lib/sha1.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ rnd2/lib/sha1.c	2005-01-20 12:20:14.925584786 -0800
@@ -0,0 +1,102 @@
+/*
+ * SHA transform algorithm, taken from code written by Peter Gutmann,
+ * and placed in the public domain.
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/cryptohash.h>
+
+/* The SHA f()-functions.  */
+
+#define f1(x,y,z)   (z ^ (x & (y ^ z)))		/* Rounds  0-19: x ? y : z */
+#define f2(x,y,z)   (x ^ y ^ z)			/* Rounds 20-39: XOR */
+#define f3(x,y,z)   ((x & y) + (z & (x ^ y)))	/* Rounds 40-59: majority */
+#define f4(x,y,z)   (x ^ y ^ z)			/* Rounds 60-79: XOR */
+
+/* The SHA Mysterious Constants */
+
+#define K1  0x5A827999L			/* Rounds  0-19: sqrt(2) * 2^30 */
+#define K2  0x6ED9EBA1L			/* Rounds 20-39: sqrt(3) * 2^30 */
+#define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
+#define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
+
+/*
+ * sha_transform: single block SHA1 transform
+ *
+ * @digest: 160 bit digest to update
+ * @data:   512 bits of data to hash
+ * @W:      80 words of workspace
+ *
+ * This function generates a SHA1 digest for a single. Be warned, it
+ * does not handle padding and message digest, do not confuse it with
+ * the full FIPS 180-1 digest algorithm for variable length messages.
+ */
+void sha_transform(__u32 *digest, const char *data, __u32 *W)
+{
+	__u32 A, B, C, D, E;
+	__u32 TEMP;
+	int i;
+
+	memset(W, 0, sizeof(W));
+	for (i = 0; i < 16; i++)
+		W[i] = be32_to_cpu(((const __u32 *)data)[i]);
+	/*
+	 * Do the preliminary expansion of 16 to 80 words.  Doing it
+	 * out-of-line line this is faster than doing it in-line on
+	 * register-starved machines like the x86, and not really any
+	 * slower on real processors.
+	 */
+	for (i = 0; i < 64; i++) {
+		TEMP = W[i] ^ W[i+2] ^ W[i+8] ^ W[i+13];
+		W[i+16] = rol32(TEMP, 1);
+	}
+
+	/* Set up first buffer and local data buffer */
+	A = digest[ 0 ];
+	B = digest[ 1 ];
+	C = digest[ 2 ];
+	D = digest[ 3 ];
+	E = digest[ 4 ];
+
+	/* Heavy mangling, in 4 sub-rounds of 20 iterations each. */
+	for (i = 0; i < 80; i++) {
+		if (i < 40) {
+			if (i < 20)
+				TEMP = f1(B, C, D) + K1;
+			else
+				TEMP = f2(B, C, D) + K2;
+		} else {
+			if (i < 60)
+				TEMP = f3(B, C, D) + K3;
+			else
+				TEMP = f4(B, C, D) + K4;
+		}
+		TEMP += rol32(A, 5) + E + W[i];
+		E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
+	}
+
+	/* Build message digest */
+	digest[0] += A;
+	digest[1] += B;
+	digest[2] += C;
+	digest[3] += D;
+	digest[4] += E;
+
+	/* W is wiped by the caller */
+}
+
+/*
+ * sha_init: initialize the vectors for a SHA1 digest
+ *
+ * @buf: vector to initialize
+ */
+void sha_init(__u32 *buf)
+{
+	buf[0] = 0x67452301;
+	buf[1] = 0xefcdab89;
+	buf[2] = 0x98badcfe;
+	buf[3] = 0x10325476;
+	buf[4] = 0xc3d2e1f0;
+}
+
