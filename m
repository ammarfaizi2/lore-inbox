Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVAUWbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVAUWbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVAUV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:57:57 -0500
Received: from waste.org ([216.27.176.166]:30169 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262533AbVAUVlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:22 -0500
Date: Fri, 21 Jan 2005 15:41:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9.314297600@selenic.com>
Message-Id: <10.314297600@selenic.com>
Subject: [PATCH 9/12] random pt4: Kill duplicate halfmd4 in ext3 htree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace duplicate halfMD4 code with call to lib/

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/fs/ext3/hash.c
===================================================================
--- rnd.orig/fs/ext3/hash.c	2005-01-12 21:27:14.191356048 -0800
+++ rnd/fs/ext3/hash.c	2005-01-12 21:28:28.916829361 -0800
@@ -13,6 +13,7 @@
 #include <linux/jbd.h>
 #include <linux/sched.h>
 #include <linux/ext3_fs.h>
+#include <linux/cryptohash.h>
 
 #define DELTA 0x9E3779B9
 
@@ -33,73 +34,6 @@
 	buf[1] += b1;
 }
 
-/* F, G and H are basic MD4 functions: selection, majority, parity */
-#define F(x, y, z) ((z) ^ ((x) & ((y) ^ (z))))
-#define G(x, y, z) (((x) & (y)) + (((x) ^ (y)) & (z)))
-#define H(x, y, z) ((x) ^ (y) ^ (z))
-
-/*
- * The generic round function.  The application is so specific that
- * we don't bother protecting all the arguments with parens, as is generally
- * good macro practice, in favor of extra legibility.
- * Rotation is separate from addition to prevent recomputation
- */
-#define ROUND(f, a, b, c, d, x, s)	\
-	(a += f(b, c, d) + x, a = (a << s) | (a >> (32-s)))
-#define K1 0
-#define K2 013240474631UL
-#define K3 015666365641UL
-
-/*
- * Basic cut-down MD4 transform.  Returns only 32 bits of result.
- */
-static void halfMD4Transform (__u32 buf[4], __u32 const in[])
-{
-	__u32	a = buf[0], b = buf[1], c = buf[2], d = buf[3];
-
-	/* Round 1 */
-	ROUND(F, a, b, c, d, in[0] + K1,  3);
-	ROUND(F, d, a, b, c, in[1] + K1,  7);
-	ROUND(F, c, d, a, b, in[2] + K1, 11);
-	ROUND(F, b, c, d, a, in[3] + K1, 19);
-	ROUND(F, a, b, c, d, in[4] + K1,  3);
-	ROUND(F, d, a, b, c, in[5] + K1,  7);
-	ROUND(F, c, d, a, b, in[6] + K1, 11);
-	ROUND(F, b, c, d, a, in[7] + K1, 19);
-
-	/* Round 2 */
-	ROUND(G, a, b, c, d, in[1] + K2,  3);
-	ROUND(G, d, a, b, c, in[3] + K2,  5);
-	ROUND(G, c, d, a, b, in[5] + K2,  9);
-	ROUND(G, b, c, d, a, in[7] + K2, 13);
-	ROUND(G, a, b, c, d, in[0] + K2,  3);
-	ROUND(G, d, a, b, c, in[2] + K2,  5);
-	ROUND(G, c, d, a, b, in[4] + K2,  9);
-	ROUND(G, b, c, d, a, in[6] + K2, 13);
-
-	/* Round 3 */
-	ROUND(H, a, b, c, d, in[3] + K3,  3);
-	ROUND(H, d, a, b, c, in[7] + K3,  9);
-	ROUND(H, c, d, a, b, in[2] + K3, 11);
-	ROUND(H, b, c, d, a, in[6] + K3, 15);
-	ROUND(H, a, b, c, d, in[1] + K3,  3);
-	ROUND(H, d, a, b, c, in[5] + K3,  9);
-	ROUND(H, c, d, a, b, in[0] + K3, 11);
-	ROUND(H, b, c, d, a, in[4] + K3, 15);
-
-	buf[0] += a;
-	buf[1] += b;
-	buf[2] += c;
-	buf[3] += d;
-}
-
-#undef ROUND
-#undef F
-#undef G
-#undef H
-#undef K1
-#undef K2
-#undef K3
 
 /* The old legacy hash */
 static __u32 dx_hack_hash (const char *name, int len)
@@ -187,7 +121,7 @@
 		p = name;
 		while (len > 0) {
 			str2hashbuf(p, len, in, 8);
-			halfMD4Transform(buf, in);
+			half_md4_transform(buf, in);
 			len -= 32;
 			p += 32;
 		}
Index: rnd/include/linux/cryptohash.h
===================================================================
--- rnd.orig/include/linux/cryptohash.h	2005-01-12 21:28:27.412021208 -0800
+++ rnd/include/linux/cryptohash.h	2005-01-12 21:28:28.917829233 -0800
@@ -7,6 +7,6 @@
 void sha_init(__u32 *buf);
 void sha_transform(__u32 *digest, const char *data, __u32 *W);
 
-__u32 half_md4_transform(__u32 const buf[4], __u32 const in[8]);
+__u32 half_md4_transform(__u32 buf[4], __u32 const in[8]);
 
 #endif
Index: rnd/lib/halfmd4.c
===================================================================
--- rnd.orig/lib/halfmd4.c	2005-01-12 21:28:27.410021462 -0800
+++ rnd/lib/halfmd4.c	2005-01-12 21:28:28.918829106 -0800
@@ -21,7 +21,7 @@
 /*
  * Basic cut-down MD4 transform.  Returns only 32 bits of result.
  */
-__u32 half_md4_transform(__u32 const buf[4], __u32 const in[8])
+__u32 half_md4_transform(__u32 buf[4], __u32 const in[8])
 {
 	__u32 a = buf[0], b = buf[1], c = buf[2], d = buf[3];
 
@@ -55,7 +55,11 @@
 	ROUND(H, c, d, a, b, in[0] + K3, 11);
 	ROUND(H, b, c, d, a, in[4] + K3, 15);
 
-	return buf[1] + b;	/* "most hashed" word */
-	/* Alternative: return sum of all words? */
+	buf[0] += a;
+	buf[1] += b;
+	buf[2] += c;
+	buf[3] += d;
+
+	return buf[1]; /* "most hashed" word */
 }
 
