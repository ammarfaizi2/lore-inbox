Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUCZAEi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUCZADt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:03:49 -0500
Received: from waste.org ([209.173.204.2]:52633 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263827AbUCYX6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:05 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <18.524465763@selenic.com>
Message-Id: <19.524465763@selenic.com>
Subject: [PATCH 18/22] /dev/random: bitop cleanup
Date: Thu, 25 Mar 2004 17:57:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  bitop cleanup

Remove incorrectly named ln and x86 asm function and replace with fls
bitop.


 tiny-mpm/drivers/char/random.c |   42 -----------------------------------------
 1 files changed, 1 insertion(+), 41 deletions(-)

diff -puN drivers/char/random.c~ln-to-fls drivers/char/random.c
--- tiny/drivers/char/random.c~ln-to-fls	2004-03-20 13:38:38.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:38.000000000 -0600
@@ -420,43 +420,6 @@ static inline __u32 rotate_left(int i, _
 }
 #endif
 
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
 #define DEBUG_ENT(fmt, arg...) \
 printk(KERN_DEBUG "random %04d %04d %04d: " fmt,\
@@ -800,10 +763,7 @@ static void add_timer_randomness(struct 
 		 * Round down by 1 bit on general principles,
 		 * and limit entropy entimate to 12 bits.
 		 */
-		delta >>= 1;
-		delta &= (1 << 12) - 1;
-
-		entropy = int_ln_12bits(delta);
+		entropy = min_t(int, fls(delta>>1), 11);
 	}
 	batch_entropy_store(num, time, entropy);
 }

_
