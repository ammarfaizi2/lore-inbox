Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131811AbQLQWPe>; Sun, 17 Dec 2000 17:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132430AbQLQWPY>; Sun, 17 Dec 2000 17:15:24 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3089 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S132538AbQLQWPT>; Sun, 17 Dec 2000 17:15:19 -0500
Date: Sun, 17 Dec 2000 22:44:52 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: random.c patch
Message-ID: <20001217224452.A8635@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places where the rotation yields garbage according to ANSI
C definition when called with 0 bit position argument.

diff -Pur linux_reference/drivers/char/random.c linux/drivers/char/random.c
--- linux_reference/drivers/char/random.c	Wed Jul 19 00:58:13 2000
+++ linux/drivers/char/random.c	Sun Dec 17 22:42:59 2000
@@ -411,7 +411,7 @@
 #if (!defined (__i386__))
 extern inline __u32 rotate_left(int i, __u32 word)
 {
-	return (word << i) | (word >> (32 - i));
+	return (word << i) | (word >> ((-i)&31));
 	
 }
 #else
@@ -857,7 +857,7 @@
 #define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
 #define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
 
-#define ROTL(n,X)  ( ( ( X ) << n ) | ( ( X ) >> ( 32 - n ) ) )
+#define ROTL(n,X)  ( ( ( X ) << n ) | ( ( X ) >> ( (- n)&31 ) ) )
 
 #define subRound(a, b, c, d, e, f, k, data) \
     ( e += ROTL( 5, a ) + f( b, c, d ) + k + data, b = ROTL( 30, b ) )
@@ -1087,7 +1087,7 @@
 
 /* This is the central step in the MD5 algorithm. */
 #define MD5STEP(f, w, x, y, z, data, s) \
-	( w += f(x, y, z) + data,  w = w<<s | w>>(32-s),  w += x )
+	( w += f(x, y, z) + data,  w = w<<s | w>>((-s)&31),  w += x )
 
 /*
  * The core of the MD5 algorithm, this alters an existing MD5 hash to
@@ -1883,7 +1883,7 @@
  * Rotation is separate from addition to prevent recomputation
  */
 #define ROUND(f, a, b, c, d, x, s)	\
-	(a += f(b, c, d) + x, a = (a << s) | (a >> (32-s)))
+	(a += f(b, c, d) + x, a = (a << s) | (a >> ((-s)&31)))
 #define K1 0
 #define K2 013240474631UL
 #define K3 015666365641UL

 Clock

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
