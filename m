Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319035AbSHWSWV>; Fri, 23 Aug 2002 14:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319036AbSHWSWV>; Fri, 23 Aug 2002 14:22:21 -0400
Received: from waste.org ([209.173.204.2]:51883 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S319035AbSHWSWU>;
	Fri, 23 Aug 2002 14:22:20 -0400
Date: Fri, 23 Aug 2002 13:26:29 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (1/7) entropy, take 2 - log2
Message-ID: <20020823182629.GA2224@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take 2 of my entropy patches. Includes minor cleanups and should
address concerns about headless systems.

Patch 1:

This simplifies and properly names the log function.

Note that this is effectively a branchless generic_{fls,ffs,flz,ffz}.
I'll experiment with using this approach there later.

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-07-20 14:11:07.000000000 -0500
+++ b/drivers/char/random.c	2002-08-23 12:43:20.000000000 -0500
@@ -253,6 +253,8 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/tqueue.h>
+#include <linux/kernel_stat.h>
+#include <linux/bitops.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -430,41 +432,19 @@
 #endif
 
 /*
- * More asm magic....
- * 
  * For entropy estimation, we need to do an integral base 2
  * logarithm.  
- *
- * Note the "12bits" suffix - this is used for numbers between
- * 0 and 4095 only.  This allows a few shortcuts.
  */
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
+static inline __u32 int_log2_16bits(__u32 word)
 {
 	/* Smear msbit right to make an n-bit mask */
 	word |= word >> 8;
 	word |= word >> 4;
 	word |= word >> 2;
 	word |= word >> 1;
-	/* Remove one bit to make this a logarithm */
-	word >>= 1;
-	/* Count the bits set in the word */
-	word -= (word >> 1) & 0x555;
-	word = (word & 0x333) + ((word >> 2) & 0x333);
-	word += (word >> 4);
-	word += (word >> 8);
-	return word & 15;
+
+	return hweight16(word)-1;
 }
-#endif
 
 #if 0
 #define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
@@ -782,7 +762,7 @@
 		delta >>= 1;
 		delta &= (1 << 12) - 1;
 
-		entropy = int_ln_12bits(delta);
+		entropy = int_log2_16bits(delta);
 	}
 	batch_entropy_store(num, time, entropy);
 }


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
