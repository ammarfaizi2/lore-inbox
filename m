Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVAUWC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVAUWC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVAUWAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:00:47 -0500
Received: from waste.org ([216.27.176.166]:30681 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262535AbVAUVlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:41:23 -0500
Date: Fri, 21 Jan 2005 15:41:07 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8.314297600@selenic.com>
Message-Id: <9.314297600@selenic.com>
Subject: [PATCH 8/12] random pt4: Move halfmd4 to lib
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move half-MD4 hash to /lib where we can share it with htree.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd2/drivers/char/random.c
===================================================================
--- rnd2.orig/drivers/char/random.c	2005-01-20 09:42:08.922390869 -0800
+++ rnd2/drivers/char/random.c	2005-01-20 09:50:02.465019321 -0800
@@ -1325,47 +1325,6 @@
 #define K2 013240474631UL
 #define K3 015666365641UL
 
-/*
- * Basic cut-down MD4 transform.  Returns only 32 bits of result.
- */
-static __u32 halfMD4Transform (__u32 const buf[4], __u32 const in[8])
-{
-	__u32 a = buf[0], b = buf[1], c = buf[2], d = buf[3];
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
-	return buf[1] + b;	/* "most hashed" word */
-	/* Alternative: return sum of all words? */
-}
-
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 
 static __u32 twothirdsMD4Transform (__u32 const buf[4], __u32 const in[12])
@@ -1550,7 +1509,7 @@
 	hash[2]=(sport << 16) + dport;
 	hash[3]=keyptr->secret[11];
 
-	seq = halfMD4Transform(hash, keyptr->secret) & HASH_MASK;
+	seq = half_md4_transform(hash, keyptr->secret) & HASH_MASK;
 	seq += keyptr->count;
 	/*
 	 *	As close as possible to RFC 793, which
@@ -1591,7 +1550,7 @@
 	hash[2] = keyptr->secret[10];
 	hash[3] = keyptr->secret[11];
 
-	return halfMD4Transform(hash, keyptr->secret);
+	return half_md4_transform(hash, keyptr->secret);
 }
 
 /* Generate secure starting point for ephemeral TCP port search */
@@ -1609,7 +1568,7 @@
 	hash[2] = dport ^ keyptr->secret[10];
 	hash[3] = keyptr->secret[11];
 
-	return halfMD4Transform(hash, keyptr->secret);
+	return half_md4_transform(hash, keyptr->secret);
 }
 
 #ifdef CONFIG_SYN_COOKIES
Index: rnd2/lib/halfmd4.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ rnd2/lib/halfmd4.c	2005-01-20 09:47:02.741932065 -0800
@@ -0,0 +1,61 @@
+#include <linux/kernel.h>
+#include <linux/cryptohash.h>
+
+/* F, G and H are basic MD4 functions: selection, majority, parity */
+#define F(x, y, z) ((z) ^ ((x) & ((y) ^ (z))))
+#define G(x, y, z) (((x) & (y)) + (((x) ^ (y)) & (z)))
+#define H(x, y, z) ((x) ^ (y) ^ (z))
+
+/*
+ * The generic round function.  The application is so specific that
+ * we don't bother protecting all the arguments with parens, as is generally
+ * good macro practice, in favor of extra legibility.
+ * Rotation is separate from addition to prevent recomputation
+ */
+#define ROUND(f, a, b, c, d, x, s)	\
+	(a += f(b, c, d) + x, a = (a << s) | (a >> (32 - s)))
+#define K1 0
+#define K2 013240474631UL
+#define K3 015666365641UL
+
+/*
+ * Basic cut-down MD4 transform.  Returns only 32 bits of result.
+ */
+__u32 half_md4_transform(__u32 const buf[4], __u32 const in[8])
+{
+	__u32 a = buf[0], b = buf[1], c = buf[2], d = buf[3];
+
+	/* Round 1 */
+	ROUND(F, a, b, c, d, in[0] + K1,  3);
+	ROUND(F, d, a, b, c, in[1] + K1,  7);
+	ROUND(F, c, d, a, b, in[2] + K1, 11);
+	ROUND(F, b, c, d, a, in[3] + K1, 19);
+	ROUND(F, a, b, c, d, in[4] + K1,  3);
+	ROUND(F, d, a, b, c, in[5] + K1,  7);
+	ROUND(F, c, d, a, b, in[6] + K1, 11);
+	ROUND(F, b, c, d, a, in[7] + K1, 19);
+
+	/* Round 2 */
+	ROUND(G, a, b, c, d, in[1] + K2,  3);
+	ROUND(G, d, a, b, c, in[3] + K2,  5);
+	ROUND(G, c, d, a, b, in[5] + K2,  9);
+	ROUND(G, b, c, d, a, in[7] + K2, 13);
+	ROUND(G, a, b, c, d, in[0] + K2,  3);
+	ROUND(G, d, a, b, c, in[2] + K2,  5);
+	ROUND(G, c, d, a, b, in[4] + K2,  9);
+	ROUND(G, b, c, d, a, in[6] + K2, 13);
+
+	/* Round 3 */
+	ROUND(H, a, b, c, d, in[3] + K3,  3);
+	ROUND(H, d, a, b, c, in[7] + K3,  9);
+	ROUND(H, c, d, a, b, in[2] + K3, 11);
+	ROUND(H, b, c, d, a, in[6] + K3, 15);
+	ROUND(H, a, b, c, d, in[1] + K3,  3);
+	ROUND(H, d, a, b, c, in[5] + K3,  9);
+	ROUND(H, c, d, a, b, in[0] + K3, 11);
+	ROUND(H, b, c, d, a, in[4] + K3, 15);
+
+	return buf[1] + b;	/* "most hashed" word */
+	/* Alternative: return sum of all words? */
+}
+
Index: rnd2/lib/Makefile
===================================================================
--- rnd2.orig/lib/Makefile	2005-01-20 09:42:08.920391124 -0800
+++ rnd2/lib/Makefile	2005-01-20 09:47:44.147653284 -0800
@@ -5,7 +5,8 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
-	 bitmap.o extable.o kobject_uevent.o prio_tree.o sha1.o
+	 bitmap.o extable.o kobject_uevent.o prio_tree.o \
+	 sha1.o halfmd4.o
 
 ifeq ($(CONFIG_DEBUG_KOBJECT),y)
 CFLAGS_kobject.o += -DDEBUG
Index: rnd2/include/linux/cryptohash.h
===================================================================
--- rnd2.orig/include/linux/cryptohash.h	2005-01-20 09:42:09.077371110 -0800
+++ rnd2/include/linux/cryptohash.h	2005-01-20 09:47:02.986900834 -0800
@@ -7,4 +7,6 @@
 void sha_init(__u32 *buf);
 void sha_transform(__u32 *digest, const char *data, __u32 *W);
 
+__u32 half_md4_transform(__u32 const buf[4], __u32 const in[8]);
+
 #endif
