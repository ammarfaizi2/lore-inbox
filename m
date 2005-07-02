Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVGBSym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVGBSym (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 14:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVGBSym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 14:54:42 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:61785 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261257AbVGBSyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 14:54:31 -0400
Message-ID: <42C6E2EE.4030908@m1k.net>
Date: Sat, 02 Jul 2005 14:54:38 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mac Michaels <wmichaels1@earthlink.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH] v4l: add DVB support for DViCO FusionHDTV3 Gold-Q
Content-Type: multipart/mixed;
 boundary="------------050108050603060109040208"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108050603060109040208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch depends on:

dvb-frontend-add-driver-for-lgdt3302.patch

in -mm.

--------------050108050603060109040208
Content-Type: text/plain;
 name="v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-q.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l-add-dvb-support-for-dvico-fusionhdtv3-gold-q.patch"

Add dvb support in v4l for DViCO FusionHDTV3 Gold-Q
using lgdt3302 frontend.

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/video/cx88/cx88-cards.c |    1 
 linux/drivers/media/video/cx88/cx88-dvb.c   |   43 +++++++++++++++++++-
 linux/drivers/media/video/cx88/cx88-i2c.c   |    3 -
 linux/drivers/media/video/cx88/cx88-mpeg.c  |   13 ++++--
 4 files changed, 53 insertions(+), 7 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88-cards.c linux/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-cards.c	2005-07-02 13:19:07.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-cards.c	2005-07-02 14:06:32.000000000 +0000
@@ -485,6 +485,7 @@
 			.vmux   = 2,
 			.gpio0	= 0x0f00,
 		}},
+		.dvb            = 1,
 	},
         [CX88_BOARD_HAUPPAUGE_DVB_T1] = {
 		.name           = "Hauppauge Nova-T DVB-T",
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-i2c.c linux/drivers/media/video/cx88/cx88-i2c.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-i2c.c	2005-07-02 13:18:36.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-i2c.c	2005-07-02 14:06:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-i2c.c,v 1.23 2005/06/12 04:19:19 mchehab Exp $
+    $Id: cx88-i2c.c,v 1.24 2005/06/17 18:46:23 mkrufky Exp $
 
     cx88-i2c.c  --  all the i2c code is here
 
@@ -157,6 +157,7 @@
 };
 
 static char *i2c_devs[128] = {
+	[ 0x1c >> 1 ] = "lgdt3302",
 	[ 0x86 >> 1 ] = "tda9887/cx22702",
 	[ 0xa0 >> 1 ] = "eeprom",
 	[ 0xc0 >> 1 ] = "tuner (analog)",
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-mpeg.c linux/drivers/media/video/cx88/cx88-mpeg.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-mpeg.c	2005-07-02 13:18:36.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-mpeg.c	2005-07-02 14:06:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-mpeg.c,v 1.26 2005/06/03 13:31:51 mchehab Exp $
+ * $Id: cx88-mpeg.c,v 1.28 2005/06/20 03:36:00 mkrufky Exp $
  *
  *  Support for the mpeg transport stream transfers
  *  PCI function #2 of the cx2388x.
@@ -70,11 +70,16 @@
 
 	if (cx88_boards[core->board].dvb) {
 		/* negedge driven & software reset */
-		cx_write(TS_GEN_CNTRL, 0x40);
+		cx_write(TS_GEN_CNTRL, 0x0040 | dev->ts_gen_cntrl);
 		udelay(100);
 		cx_write(MO_PINMUX_IO, 0x00);
-		cx_write(TS_HW_SOP_CNTRL,47<<16|188<<4|0x00);
-		cx_write(TS_SOP_STAT,0x00);
+		if (core->board == CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q) {
+			cx_write(TS_HW_SOP_CNTRL,0x47<<16 | 188<<4 | 0x00);
+			cx_write(TS_SOP_STAT, 0<<16 | 0<<14 | 1<<13 | 0<<12);
+		} else {
+			cx_write(TS_HW_SOP_CNTRL,47<<16|188<<4|0x00);
+			cx_write(TS_SOP_STAT,0x00);
+		}
 		cx_write(TS_GEN_CNTRL, dev->ts_gen_cntrl);
 		udelay(100);
 	}
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-02 13:19:07.000000000 +0000
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-02 14:06:32.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.36 2005/06/21 06:08:12 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.37 2005/06/28 23:41:47 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -30,9 +30,10 @@
 #include <linux/file.h>
 #include <linux/suspend.h>
 
-/* those two frontends need merging via linuxtv cvs ... */
+/* these three frontends need merging via linuxtv cvs ... */
 #define HAVE_CX22702 1
 #define HAVE_OR51132 1
+#define HAVE_LGDT3302 1
 
 #include "cx88.h"
 #include "dvb-pll.h"
@@ -44,6 +45,9 @@
 #if HAVE_OR51132
 # include "or51132.h"
 #endif
+#if HAVE_LGDT3302
+# include "lgdt3302.h"
+#endif
 
 MODULE_DESCRIPTION("driver for cx2388x based DVB cards");
 MODULE_AUTHOR("Chris Pascoe <c.pascoe@itee.uq.edu.au>");
@@ -199,6 +203,25 @@
 };
 #endif
 
+#if HAVE_LGDT3302
+static int lgdt3302_set_ts_param(struct dvb_frontend* fe, int is_punctured)
+{
+	struct cx8802_dev *dev= fe->dvb->priv;
+	if (is_punctured)
+		dev->ts_gen_cntrl |= 0x04;
+	else
+		dev->ts_gen_cntrl &= ~0x04;
+	return 0;
+}
+
+static struct lgdt3302_config fusionhdtv_3_gold_q = {
+	.demod_address    = 0x0e,
+	.pll_address      = 0x61,
+	.pll_desc         = &dvb_pll_microtune_4042,
+	.set_ts_params    = lgdt3302_set_ts_param,
+};
+#endif
+
 static int dvb_register(struct cx8802_dev *dev)
 {
 	/* init struct videobuf_dvb */
@@ -243,6 +266,22 @@
 						 &dev->core->i2c_adap);
 		break;
 #endif
+#if HAVE_LGDT3302
+	case CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q:
+		dev->ts_gen_cntrl = 0x08;
+		{
+		/* Do a hardware reset of chip before using it. */
+		struct cx88_core *core = dev->core;
+
+		cx_clear(MO_GP0_IO, 1);
+		mdelay(100);
+		cx_set(MO_GP0_IO, 9); // ANT connector too FIXME
+		mdelay(200);
+		dev->dvb.frontend = lgdt3302_attach(&fusionhdtv_3_gold_q,
+						    &dev->core->i2c_adap);
+		}
+		break;
+#endif
 	default:
 		printk("%s: The frontend of your DVB/ATSC card isn't supported yet\n",
 		       dev->core->name);

--------------050108050603060109040208--
