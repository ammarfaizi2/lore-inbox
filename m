Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUKSRGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUKSRGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUKSRFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:05:23 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:29671 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261498AbUKSREM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:04:12 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 19 Nov 2004 17:57:23 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] tuner update
Message-ID: <20041119165723.GA2933@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update for the tuner module: add support for a new tuner chip.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/tda9887.c |    1 +
 drivers/media/video/tuner.c   |   16 ++++++++++++----
 include/media/tuner.h         |    1 +
 3 files changed, 14 insertions(+), 4 deletions(-)

diff -u linux-2.6.10/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.10/include/media/tuner.h	2004-11-17 18:41:07.000000000 +0100
+++ linux/include/media/tuner.h	2004-11-19 14:51:58.039802902 +0100
@@ -76,6 +76,7 @@
 #define TUNER_TNF_8831BGFF       48
 #define TUNER_MICROTUNE_4042FI5  49	/* FusionHDTV 3 Gold - 4042 FI5 (3X 8147) */
 #define TUNER_TCL_2002N          50
+#define TUNER_PHILIPS_FM1256_IH3   51
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
diff -u linux-2.6.10/drivers/media/video/tuner.c linux/drivers/media/video/tuner.c
--- linux-2.6.10/drivers/media/video/tuner.c	2004-11-17 18:42:27.000000000 +0100
+++ linux/drivers/media/video/tuner.c	2004-11-19 14:51:58.050800847 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner.c,v 1.29 2004/11/07 13:17:15 kraxel Exp $
+ * $Id: tuner.c,v 1.31 2004/11/10 11:07:24 kraxel Exp $
  */
 
 #include <linux/module.h>
@@ -262,6 +262,8 @@
 	  16*162.00,16*457.00,0xa2,0x94,0x31,0x8e,732},
         { "TCL 2002N", TCL, NTSC,
           16*172.00,16*448.00,0x01,0x02,0x08,0x8e,732},
+	{ "Philips PAL/SECAM_D (FM 1256 I-H3)", Philips, PAL,
+	  16*160.00,16*442.00,0x01,0x02,0x04,0x8e,623 },
 
 };
 #define TUNERS ARRAY_SIZE(tuners)
@@ -986,14 +988,18 @@
 
 	tun=&tuners[t->type];
 	div = freq + (int)(16*10.7);
-        buffer[0] = (div>>8) & 0x7f;
-        buffer[1] = div      & 0xff;
 	buffer[2] = tun->config;
+
 	switch (t->type) {
 	case TUNER_PHILIPS_FM1216ME_MK3:
 	case TUNER_PHILIPS_FM1236_MK3:
 		buffer[3] = 0x19;
 		break;
+	case TUNER_PHILIPS_FM1256_IH3:
+		div = (20 * freq)/16 + 333 * 2;
+	        buffer[2] = 0x80;
+		buffer[3] = 0x19;
+		break;
 	case TUNER_LG_PAL_FM:
 		buffer[3] = 0xa5;
 		break;
@@ -1001,6 +1007,8 @@
 		buffer[3] = 0xa4;
 		break;
 	}
+        buffer[0] = (div>>8) & 0x7f;
+        buffer[1] = div      & 0xff;
 
 	dprintk("tuner: radio 0x%02x 0x%02x 0x%02x 0x%02x\n",
 		buffer[0],buffer[1],buffer[2],buffer[3]);
@@ -1077,7 +1085,7 @@
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (t->type != UNSET) {
+	if (t->type != UNSET && t->type != TUNER_ABSENT) {
 		if (t->type != type)
 			printk("tuner: type already set to %d, "
 			       "ignoring request for %d\n", t->type, type);
diff -u linux-2.6.10/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.10/drivers/media/video/tda9887.c	2004-11-17 18:42:19.000000000 +0100
+++ linux/drivers/media/video/tda9887.c	2004-11-19 14:51:58.109789826 +0100
@@ -246,6 +246,7 @@
 	printk(PREFIX "read: 0x%2x\n", buf[0]);
 	printk("  after power on : %s\n", (buf[0] & 0x01) ? "yes" : "no");
 	printk("  afc            : %s\n", afc[(buf[0] >> 1) & 0x0f]);
+	printk("  fmif level     : %s\n", (buf[0] & 0x20) ? "high" : "low");
 	printk("  afc window     : %s\n", (buf[0] & 0x40) ? "in" : "out");
 	printk("  vfi level      : %s\n", (buf[0] & 0x80) ? "high" : "low");
 }

-- 
#define printk(args...) fprintf(stderr, ## args)
