Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291898AbSBNVPn>; Thu, 14 Feb 2002 16:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291908AbSBNVPZ>; Thu, 14 Feb 2002 16:15:25 -0500
Received: from skunk.directfb.org ([212.84.236.169]:1172 "EHLO
	skunk.convergence.de") by vger.kernel.org with ESMTP
	id <S291898AbSBNVPI>; Thu, 14 Feb 2002 16:15:08 -0500
Date: Thu, 14 Feb 2002 22:14:10 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NeoMagic FPU fix (2.5.5-pre1)
Message-ID: <20020214211410.GA17256@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

this is the NeoMagic floating foint removal patch
I posted previously for Linux 2.4.18-pre9-ac3.

This one applies against Linux 2.5.5-pre1 and
updates the driver to version 0.3.2.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

           convergence integrated media GmbH

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb-0.3.2-linux-2.5.5-pre1.diff"

diff -uraN linux-2.5.5-pre1/CREDITS linux/CREDITS
--- linux-2.5.5-pre1/CREDITS	Thu Feb 14 21:50:52 2002
+++ linux/CREDITS	Thu Feb 14 21:52:17 2002
@@ -1657,6 +1657,13 @@
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
diff -uraN linux-2.5.5-pre1/drivers/video/neofb.c linux/drivers/video/neofb.c
--- linux-2.5.5-pre1/drivers/video/neofb.c	Thu Feb 14 21:50:54 2002
+++ linux/drivers/video/neofb.c	Thu Feb 14 21:56:00 2002
@@ -12,6 +12,9 @@
  * archive for more details.
  *
  *
+ * 0.3.2
+ *  - got rid of all floating point (dok) 
+ *
  * 0.3.1
  *  - added module license (dok)
  *
@@ -71,7 +74,7 @@
 #include "neofb.h"
 
 
-#define NEOFB_VERSION "0.3.1"
+#define NEOFB_VERSION "0.3.2"
 
 /* --------------------------------------------------------------------- */
 
@@ -872,7 +875,7 @@
  *
  * Determine the closest clock frequency to the one requested.
  */
-#define REF_FREQ 14.31818
+#define REF_FREQ 0xe517  /* 14.31818 in 20.12 fixed point */
 #define MAX_N 127
 #define MAX_D 31
 #define MAX_F 1
@@ -880,17 +883,18 @@
 static void neoCalcVCLK (const struct neofb_info *info, struct neofb_par *par, long freq)
 {
   int n, d, f;
-  double f_out;
-  double f_diff;
   int n_best = 0, d_best = 0, f_best = 0;
-  double f_best_diff = 999999.0;
-  double f_target = freq/1000.0;
+  long f_best_diff = (0x7ffff << 12); /* 20.12 */
+  long f_target = (freq << 12) / 1000; /* 20.12 */
 
   for (f = 0; f <= MAX_F; f++)
     for (n = 0; n <= MAX_N; n++)
       for (d = 0; d <= MAX_D; d++)
 	{
-	  f_out = (n+1.0)/((d+1.0)*(1<<f))*REF_FREQ;
+          long f_out;  /* 20.12 */
+          long f_diff; /* 20.12 */
+
+	  f_out = ((((n+1) << 12)  /  ((d+1)*(1<<f))) >> 12)  *  REF_FREQ;
 	  f_diff = abs(f_out-f_target);
 	  if (f_diff < f_best_diff)
 	    {
@@ -917,12 +921,12 @@
   par->VCLK3Denominator = d_best;
 
 #ifdef NEOFB_DEBUG
-  printk ("neoVCLK: f:%f NumLow=%d NumHi=%d Den=%d Df=%f\n",
-	  f_target,
+  printk ("neoVCLK: f:%d NumLow=%d NumHi=%d Den=%d Df=%d\n",
+	  f_target >> 12,
 	  par->VCLK3NumeratorLow,
 	  par->VCLK3NumeratorHigh,
 	  par->VCLK3Denominator,
-	  f_best_diff);
+	  f_best_diff >> 12);
 #endif
 }
 

--NzB8fVQJ5HfG6fxh--
