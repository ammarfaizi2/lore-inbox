Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbUCZARk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbUCZAHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:07:08 -0500
Received: from waste.org ([209.173.204.2]:55193 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263831AbUCYX6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:08 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20.524465763@selenic.com>
Message-Id: <21.524465763@selenic.com>
Subject: [PATCH 20/22] /dev/random: cleanup rol bitop
Date: Thu, 25 Mar 2004 17:57:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  cleanup rol bitop

We've got three definitions of rotate_left. Remove x86 and duplicate
rotate definitions. Remaining definition is fixed up such that recent
gcc will generate rol instructions on x86 at least.


 tiny-mpm/drivers/char/random.c |   40 +++++++---------------------------------
 1 files changed, 7 insertions(+), 33 deletions(-)

diff -puN drivers/char/random.c~kill-rotate drivers/char/random.c
--- tiny/drivers/char/random.c~kill-rotate	2004-03-20 15:04:42.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 15:08:19.000000000 -0600
@@ -393,33 +393,10 @@ static DECLARE_WAIT_QUEUE_HEAD(random_wr
 static void sysctl_init_random(struct entropy_store *pool);
 #endif
 
-/*****************************************************************
- *
- * Utility functions, with some ASM defined functions for speed
- * purposes
- * 
- *****************************************************************/
-
-/*
- * Unfortunately, while the GCC optimizer for the i386 understands how
- * to optimize a static rotate left of x bits, it doesn't know how to
- * deal with a variable rotate of x bits.  So we use a bit of asm magic.
- */
-#if (!defined (__i386__))
-static inline __u32 rotate_left(int i, __u32 word)
+static inline __u32 rol32(__u32 word, int shift)
 {
-	return (word << i) | (word >> (32 - i));
-	
+	return (word << shift) | (word >> (32 - shift));
 }
-#else
-static inline __u32 rotate_left(int i, __u32 word)
-{
-	__asm__("roll %%cl,%0"
-		:"=r" (word)
-		:"0" (word),"c" (i));
-	return word;
-}
-#endif
 
 #if 0
 #define DEBUG_ENT(fmt, arg...) \
@@ -514,7 +491,7 @@ static void add_entropy_words(struct ent
 	spin_lock_irqsave(&r->lock, flags);
 
 	while (nwords--) {
-		w = rotate_left(r->input_rotate, *in++);
+		w = rol32(*in++, r->input_rotate);
 		i = r->add_ptr = (r->add_ptr - 1) & wordmask;
 		/*
 		 * Normally, we add 7 bits of rotation to the pool.
@@ -849,8 +826,6 @@ EXPORT_SYMBOL(add_disk_randomness);
 #define K3  0x8F1BBCDCL			/* Rounds 40-59: sqrt(5) * 2^30 */
 #define K4  0xCA62C1D6L			/* Rounds 60-79: sqrt(10) * 2^30 */
 
-#define ROTL(n,X)  ( ( ( X ) << n ) | ( ( X ) >> ( 32 - n ) ) )
-
 static void sha_transform(__u32 digest[85], __u32 const data[16])
 {
     __u32 A, B, C, D, E;     /* Local vars */
@@ -867,7 +842,7 @@ static void sha_transform(__u32 digest[8
     memcpy(W, data, 16*sizeof(__u32));
     for (i = 0; i < 64; i++) {
 	    TEMP = W[i] ^ W[i+2] ^ W[i+8] ^ W[i+13];
-	    W[i+16] = ROTL(1, TEMP);
+	    W[i+16] = rol32(TEMP, 1);
     }
 
     /* Set up first buffer and local data buffer */
@@ -890,8 +865,8 @@ static void sha_transform(__u32 digest[8
 	    else
 		TEMP = f4(B, C, D) + K4;
 	}
-	TEMP += ROTL(5, A) + E + W[i];
-	E = D; D = C; C = ROTL(30, B); B = A; A = TEMP;
+	TEMP += rol32(A, 5) + E + W[i];
+	E = D; D = C; C = rol32(B, 30); B = A; A = TEMP;
     }
 
     /* Build message digest */
@@ -905,7 +880,6 @@ static void sha_transform(__u32 digest[8
 #undef W
 }
 
-#undef ROTL
 #undef f1
 #undef f2
 #undef f3
@@ -1646,7 +1620,7 @@ __u32 halfMD4Transform(__u32 buf[4], __u
 		else
 			a += H(b,c,d) + K3;
 		a += in[(int)p[i]];
-		a = rotate_left(a, s[i]);
+		a = rol32(a, s[i]);
 		e = d; d = c; c = b; b = a; a = e;
 	}
 

_
