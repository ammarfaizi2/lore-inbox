Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVAOAwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVAOAwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVAOAvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:51:02 -0500
Received: from waste.org ([216.27.176.166]:10721 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262074AbVAOAtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:16 -0500
Date: Fri, 14 Jan 2005 18:49:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <10.563253706@selenic.com>
Message-Id: <11.563253706@selenic.com>
Subject: [PATCH 10/10] random pt2: kill misnamed log2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove incorrectly named ln (it's log2!) and x86 asm function and
replace with fls bitop.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:28:07.768525540 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:08.700406735 -0800
@@ -395,54 +395,11 @@
 static void sysctl_init_random(struct entropy_store *random_state);
 #endif
 
-/*****************************************************************
- *
- * Utility functions, with some ASM defined functions for speed
- * purposes
- *
- *****************************************************************/
 static inline __u32 rol32(__u32 word, int shift)
 {
 	return (word << shift) | (word >> (32 - shift));
 }
 
-/*
- * More asm magic....
- *
- * For entropy estimation, we need to do an integral base 2
- * logarithm.
- *
- * Note the "12bits" suffix - this is used for numbers between
- * 0 and 4095 only.  This allows a few shortcuts.
- */
-#if 0	/* Slow but clear version */
-static inline __u32 int_ln_12bits(__u32 word)
-{
-	__u32 nbits = 0;
-
-	while (word >>= 1)
-		nbits++;
-	return nbits;
-}
-#else	/* Faster (more clever) version, courtesy Colin Plumb */
-static inline __u32 int_ln_12bits(__u32 word)
-{
-	/* Smear msbit right to make an n-bit mask */
-	word |= word >> 8;
-	word |= word >> 4;
-	word |= word >> 2;
-	word |= word >> 1;
-	/* Remove one bit to make this a logarithm */
-	word >>= 1;
-	/* Count the bits set in the word */
-	word -= (word >> 1) & 0x555;
-	word = (word & 0x333) + ((word >> 2) & 0x333);
-	word += (word >> 4);
-	word += (word >> 8);
-	return word & 15;
-}
-#endif
-
 #if 0
 static int debug = 0;
 module_param(debug, bool, 0644);
@@ -808,10 +765,7 @@
 		 * Round down by 1 bit on general principles,
 		 * and limit entropy entimate to 12 bits.
 		 */
-		delta >>= 1;
-		delta &= (1 << 12) - 1;
-
-		entropy = int_ln_12bits(delta);
+		entropy = min_t(int, fls(delta>>1), 11);
 	}
 
 	/*
