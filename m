Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291862AbSBNT5T>; Thu, 14 Feb 2002 14:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291861AbSBNT5K>; Thu, 14 Feb 2002 14:57:10 -0500
Received: from skunk.directfb.org ([212.84.236.169]:16787 "EHLO
	skunk.convergence.de") by vger.kernel.org with ESMTP
	id <S291859AbSBNT5C>; Thu, 14 Feb 2002 14:57:02 -0500
Date: Thu, 14 Feb 2002 20:56:03 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NeoMagic FPU fix (2.4.18-pre9-ac3)
Message-ID: <20020214195603.GA16688@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

here is a patch for my NeoMagic framebuffer driver that
removes all floating stuff. I also added me to CREDITS as
I forgot the last time. The driver version is 0.3.2 now.

It applies against Linux 2.4.18-pre9-ac3 which had version
0.3.0 of the driver while the last version was 0.3.1.

So this patch is not applyable to the 2.5 tree. I will do
another one for 2.5 and 2.5-dj, too. So that all trees have
the same version.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

           convergence integrated media GmbH

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb-0.3.2-linux-2.4.18-pre9-ac3.diff"

diff -uraN linux-2.4.18-pre9-ac3/CREDITS linux/CREDITS
--- linux-2.4.18-pre9-ac3/CREDITS	Thu Feb 14 18:38:28 2002
+++ linux/CREDITS	Thu Feb 14 20:44:42 2002
@@ -1656,6 +1656,13 @@
 S: San Antonio, Texas 78269-1886
 S: USA
 
+N: Denis O. Kropp
+E: dok@directfb.org
+D: NeoMagic framebuffer driver
+S: Badensche Str. 46
+S: 10715 Berlin
+S: Germany
+
 N: Andrzej M. Krzysztofowicz
 E: ankry@mif.pg.gda.pl
 D: Some 8-bit XT disk driver and devfs hacking 
diff -uraN linux-2.4.18-pre9-ac3/drivers/video/neofb.c linux/drivers/video/neofb.c
--- linux-2.4.18-pre9-ac3/drivers/video/neofb.c	Thu Feb 14 18:38:30 2002
+++ linux/drivers/video/neofb.c	Thu Feb 14 20:41:37 2002
@@ -12,9 +12,15 @@
  * archive for more details.
  *
  *
+ * 0.3.2
+ *  - got rid of all floating point (dok)
+ *
+ * 0.3.1
+ *  - added module license (dok)
+ *
  * 0.3
- *  - hardware accelerated clear and move for 2200 and above
- *  - maximum allowed dotclock is handled now
+ *  - hardware accelerated clear and move for 2200 and above (dok)
+ *  - maximum allowed dotclock is handled now (dok)
  *
  * 0.2.1
  *  - correct panning after X usage (dok)
@@ -29,10 +35,10 @@
  * - ioctl for internal/external switching
  * - blanking
  * - 32bit depth support, maybe impossible
- * - disable automatic pan on sync, need specs
+ * - disable pan-on-sync, need specs
  *
  * BUGS
- * - white margin on bootup (colormap problem?)
+ * - white margin on bootup like with tdfxfb (colormap problem?)
  *
  */
 
@@ -68,7 +74,7 @@
 #include "neofb.h"
 
 
-#define NEOFB_VERSION "0.3"
+#define NEOFB_VERSION "0.3.2"
 
 /* --------------------------------------------------------------------- */
 
@@ -81,7 +87,8 @@
 
 #ifdef MODULE
 
-MODULE_AUTHOR("(c) 2001  Denis Oliver Kropp <dok@convergence.de>");
+MODULE_AUTHOR("(c) 2001-2002  Denis Oliver Kropp <dok@convergence.de>");
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("FBDev driver for NeoMagic PCI Chips");
 MODULE_PARM(disabled, "i");
 MODULE_PARM_DESC(disabled, "Disable this driver's initialization.");
@@ -861,13 +868,12 @@
   return err;
 }
 
-#error "Floating point maths. This needs fixing before this driver is safe"
 /*
  * neoCalcVCLK --
  *
  * Determine the closest clock frequency to the one requested.
  */
-#define REF_FREQ 14.31818
+#define REF_FREQ 0xe5174  /* 14.31818 in 16.16 fixed point */
 #define MAX_N 127
 #define MAX_D 31
 #define MAX_F 1
@@ -875,17 +881,18 @@
 static void neoCalcVCLK (const struct neofb_info *info, struct neofb_par *par, long freq)
 {
   int n, d, f;
-  double f_out;
-  double f_diff;
   int n_best = 0, d_best = 0, f_best = 0;
-  double f_best_diff = 999999.0;
-  double f_target = freq/1000.0;
+  int f_best_diff = (999999 << 16); /* 16.16 */
+  int f_target = (freq << 16) / 1000; /* 16.16 */
 
   for (f = 0; f <= MAX_F; f++)
     for (n = 0; n <= MAX_N; n++)
       for (d = 0; d <= MAX_D; d++)
 	{
-	  f_out = (n+1.0)/((d+1.0)*(1<<f))*REF_FREQ;
+          int f_out;  /* 16.16 */
+          int f_diff; /* 16.16 */
+
+	  f_out = ((((n+1) << 16)  /  ((d+1)*(1<<f))) >> 16)  *  REF_FREQ;
 	  f_diff = abs(f_out-f_target);
 	  if (f_diff < f_best_diff)
 	    {
@@ -912,12 +919,12 @@
   par->VCLK3Denominator = d_best;
 
 #ifdef NEOFB_DEBUG
-  printk ("neoVCLK: f:%f NumLow=%d NumHi=%d Den=%d Df=%f\n",
-	  f_target,
+  printk ("neoVCLK: f:%d NumLow=%d NumHi=%d Den=%d Df=%d\n",
+	  f_target >> 16,
 	  par->VCLK3NumeratorLow,
 	  par->VCLK3NumeratorHigh,
 	  par->VCLK3Denominator,
-	  f_best_diff);
+	  f_best_diff >> 16);
 #endif
 }
 

--ZGiS0Q5IWpPtfppv--
