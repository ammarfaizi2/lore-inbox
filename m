Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRCXJdk>; Sat, 24 Mar 2001 04:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRCXJdb>; Sat, 24 Mar 2001 04:33:31 -0500
Received: from gold.MUSKOKA.COM ([199.212.175.5]:22545 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S131562AbRCXJdP>;
	Sat, 24 Mar 2001 04:33:15 -0500
Message-ID: <3ABC6781.6FFEF3FA@yahoo.com>
Date: Sat, 24 Mar 2001 04:23:13 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.3-pre6 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mdacon needs to use __setup()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel command line setup function for MDA console support is
currently dangling in outer space and not called (and hence non
functional).  There was also a warning about a non used function
whose callers were half  /* */ 'ed out so I cleaned that up as well.

Patch should apply to any recent 2.4.x kernel.

Paul.

--- drivers/video/mdacon.c~	Wed Feb 14 02:41:44 2001
+++ drivers/video/mdacon.c	Mon Mar 12 19:37:21 2001
@@ -21,6 +21,9 @@
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive for
  *  more details.
+ *
+ *  Changelog:
+ *  Paul G. (03/2001) Fix mdacon= boot prompt to use __setup().
  */
 
 #include <linux/types.h>
@@ -129,6 +132,7 @@
 	spin_unlock_irqrestore(&mda_lock, flags);
 }
 
+#ifdef TEST_MDA_B
 static int test_mda_b(unsigned char val, unsigned char reg)
 {
 	unsigned long flags;
@@ -143,6 +147,7 @@
 	spin_unlock_irqrestore(&mda_lock, flags);
 	return val;
 }
+#endif
 
 static inline void mda_set_origin(unsigned int location)
 {
@@ -182,20 +187,27 @@
 
 
 #ifndef MODULE
-void __init mdacon_setup(char *str, int *ints)
+static int __init mdacon_setup(char *str)
 {
 	/* command line format: mdacon=<first>,<last> */
 
+	int ints[3];
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+
 	if (ints[0] < 2)
-		return;
+		return 0;
 
 	if (ints[1] < 1 || ints[1] > MAX_NR_CONSOLES || 
 	    ints[2] < 1 || ints[2] > MAX_NR_CONSOLES)
-		return;
+		return 0;
 
-	mda_first_vc = ints[1]-1;
-	mda_last_vc  = ints[2]-1;
+	mda_first_vc = ints[1];
+	mda_last_vc  = ints[2];
+	return 1;
 }
+
+__setup("mdacon=", mdacon_setup);
 #endif
 
 static int __init mda_detect(void)
@@ -237,17 +249,19 @@
 	 * memory location, so now we do an I/O port test.
 	 */
 
+#ifdef TEST_MDA_B
 	/* Edward: These two mess `tests' mess up my cursor on bootup */
 
 	/* cursor low register */
-	/* if (! test_mda_b(0x66, 0x0f)) {
+	if (! test_mda_b(0x66, 0x0f)) {
 		return 0;
-	} */
+	}
 
 	/* cursor low register */
-	/* if (! test_mda_b(0x99, 0x0f)) {
+	if (! test_mda_b(0x99, 0x0f)) {
 		return 0;
-	} */
+	}
+#endif
 
 	/* See if the card is a Hercules, by checking whether the vsync
 	 * bit of the status register is changing.  This test lasts for


