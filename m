Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSIKFIZ>; Wed, 11 Sep 2002 01:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSIKFIZ>; Wed, 11 Sep 2002 01:08:25 -0400
Received: from waste.org ([209.173.204.2]:12180 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318310AbSIKFIQ>;
	Wed, 11 Sep 2002 01:08:16 -0400
Date: Wed, 11 Sep 2002 00:13:02 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/11] Entropy fixes - fls
Message-ID: <20020911051302.GP31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the improperly named "ln" function and replaces it with a
call to the potentially arch-optimized fls. This also adjusts the
entropy count appropriately taking into consideration the expected
entropy in sections of a scale-invariant distribution. Thanks to Arend
Bayer for additional help with this analysis.

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-07-20 14:11:07.000000000 -0500
+++ b/drivers/char/random.c	2002-09-07 19:20:20.000000000 -0500
@@ -253,6 +253,8 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/tqueue.h>
+#include <linux/kernel_stat.h>
+#include <linux/bitops.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -429,43 +431,6 @@
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
 #define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
 #else
@@ -774,15 +739,14 @@
 		if (delta > delta3)
 			delta = delta3;
 
-		/*
-		 * delta is now minimum absolute delta.
-		 * Round down by 1 bit on general principles,
-		 * and limit entropy entimate to 12 bits.
+		/* Numerical integration of exponential (scale
+		 * invariant) distribution suggests that x-bit numbers
+		 * have no more than x-2 bits of entropy across their
+		 * range. Throw out 3 bits to be safe and cap at 12
+		 * bits.
 		 */
-		delta >>= 1;
-		delta &= (1 << 12) - 1;
-
-		entropy = int_ln_12bits(delta);
+ 
+		entropy = fls((delta>>3) & 0xfff);
 	}
 	batch_entropy_store(num, time, entropy);
 }


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
