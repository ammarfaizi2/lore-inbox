Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVCHKyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVCHKyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVCHKyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:54:01 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:19691 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261978AbVCHKuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:50:09 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:45:08 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: tuner update
Message-ID: <20050308104508.GA30750@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor update for the tuner module:  Add some new entries,
fix a bug in the tda8290 driver.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/mt20xx.c       |    3 ++-
 drivers/media/video/tda8290.c      |    4 ++--
 drivers/media/video/tuner-simple.c |    9 ++++++++-
 include/media/tuner.h              |    4 ++++
 4 files changed, 16 insertions(+), 4 deletions(-)

Index: linux-2.6.11/include/media/tuner.h
===================================================================
--- linux-2.6.11.orig/include/media/tuner.h	2005-03-07 18:13:01.000000000 +0100
+++ linux-2.6.11/include/media/tuner.h	2005-03-08 10:32:50.000000000 +0100
@@ -93,6 +93,10 @@
 #define TUNER_THOMSON_DTT7610    52
 #define TUNER_PHILIPS_FQ1286     53
 #define TUNER_PHILIPS_TDA8290    54
+#define TUNER_LG_PAL_TAPE        55    /* Hauppauge PVR-150 PAL */
+
+#define TUNER_PHILIPS_FQ1216AME_MK4 56 /* Hauppauge PVR-150 PAL */
+#define TUNER_PHILIPS_FQ1236A_MK4 57   /* Hauppauge PVR-500MCE NTSC */
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
Index: linux-2.6.11/drivers/media/video/tuner-simple.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/tuner-simple.c	2005-03-07 18:13:01.000000000 +0100
+++ linux-2.6.11/drivers/media/video/tuner-simple.c	2005-03-08 10:32:50.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-simple.c,v 1.4 2005/02/15 15:59:35 kraxel Exp $
+ * $Id: tuner-simple.c,v 1.10 2005/03/08 08:38:00 kraxel Exp $
  *
  * i2c tv tuner chip device driver
  * controls all those simple 4-control-bytes style tuners.
@@ -204,6 +204,13 @@ static struct tunertype tuners[] = {
 	  16*160.00,16*454.00,0x41,0x42,0x04,0x8e,940}, // UHF band untested
 	{ "tda8290+75", Philips,PAL|NTSC,
 	  /* see tda8290.c for details */ },
+	{ "LG PAL (TAPE series)", LGINNOTEK, PAL,
+          16*170.00, 16*450.00, 0x01,0x02,0x08,0xce,623},
+
+        { "Philips PAL/SECAM multi (FQ1216AME MK4)", Philips, PAL,
+          16*160.00,16*442.00,0x01,0x02,0x04,0xce,623 },
+        { "Philips FQ1236A MK4", Philips, NTSC,
+          16*160.00,16*442.00,0x01,0x02,0x04,0x8e,732 },
 
 };
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
Index: linux-2.6.11/drivers/media/video/mt20xx.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/mt20xx.c	2005-03-07 18:13:01.000000000 +0100
+++ linux-2.6.11/drivers/media/video/mt20xx.c	2005-03-07 18:13:02.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: mt20xx.c,v 1.3 2005/02/15 15:59:35 kraxel Exp $
+ * $Id: mt20xx.c,v 1.4 2005/03/04 09:24:56 kraxel Exp $
  *
  * i2c tv tuner chip device driver
  * controls microtune tuners, mt2032 + mt2050 at the moment.
@@ -7,6 +7,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/videodev.h>
+#include <linux/moduleparam.h>
 #include <media/tuner.h>
 
 /* ---------------------------------------------------------------------- */
Index: linux-2.6.11/drivers/media/video/tda8290.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/tda8290.c	2005-03-07 18:13:01.000000000 +0100
+++ linux-2.6.11/drivers/media/video/tda8290.c	2005-03-07 18:13:02.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: tda8290.c,v 1.5 2005/02/15 15:59:35 kraxel Exp $
+ * $Id: tda8290.c,v 1.7 2005/03/07 12:01:51 kraxel Exp $
  *
  * i2c tv tuner chip device driver
  * controls the philips tda8290+75 tuner chip combo.
@@ -123,7 +123,7 @@ static int tda8290_tune(struct i2c_clien
 	struct i2c_msg easy_mode =
 		{ I2C_ADDR_TDA8290, 0, 2, t->i2c_easy_mode };
 	struct i2c_msg set_freq =
-		{ I2C_ADDR_TDA8290, 0, 8, t->i2c_set_freq  };
+		{ I2C_ADDR_TDA8275, 0, 8, t->i2c_set_freq  };
 
 	i2c_transfer(c->adapter, &easy_mode,      1);
 	i2c_transfer(c->adapter, i2c_msg_prolog, ARRAY_SIZE(i2c_msg_prolog));

-- 
#define printk(args...) fprintf(stderr, ## args)
