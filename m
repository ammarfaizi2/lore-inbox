Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVKAINz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVKAINz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVKAINb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:13:31 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:38869 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964960AbVKAINH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:13:07 -0500
Message-ID: <4367236E.90008@m1k.net>
Date: Tue, 01 Nov 2005 03:12:30 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 04/37] dvb: Add ATSC support for DViCO FusionHDTV5 Lite
Content-Type: multipart/mixed;
 boundary="------------050202080108020809050806"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050202080108020809050806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------050202080108020809050806
Content-Type: text/x-patch;
 name="2361.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2361.patch"

Added ATSC support for DViCO FusionHDTV5 Lite.

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 drivers/media/dvb/bt8xx/Kconfig        |    4 +
 drivers/media/dvb/bt8xx/dvb-bt8xx.c    |   67 +++++++++++++++++++++++++++++++++
 drivers/media/dvb/bt8xx/dvb-bt8xx.h    |    1 
 drivers/media/dvb/frontends/lgdt330x.c |    1 
 4 files changed, 72 insertions(+), 1 deletion(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/Kconfig
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/Kconfig
@@ -6,10 +6,12 @@
 	select DVB_NXT6000
 	select DVB_CX24110
 	select DVB_OR51211
+	select DVB_LGDT330X
 	help
 	  Support for PCI cards based on the Bt8xx PCI bridge. Examples are
 	  the Nebula cards, the Pinnacle PCTV cards, the Twinhan DST cards,
-	  the pcHDTV HD2000 cards, and certain AVerMedia cards.
+	  the pcHDTV HD2000 cards, the DViCO FusionHDTV Lite cards, and
+	  some AVerMedia cards.
 
 	  Since these cards have no MPEG decoder onboard, they transmit
 	  only compressed MPEG data over the PCI bus, so you need
--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dvb-bt8xx.c
@@ -34,6 +34,7 @@
 #include "dvb_frontend.h"
 #include "dvb-bt8xx.h"
 #include "bt878.h"
+#include "dvb-pll.h"
 
 static int debug;
 
@@ -546,6 +547,55 @@
 	.pll_set = digitv_alps_tded4_pll_set,
 };
 
+static int tdvs_tua6034_pll_set(struct dvb_frontend* fe, struct dvb_frontend_parameters* params)
+{
+	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *) fe->dvb->priv;
+	u8 buf[4];
+	struct i2c_msg msg = { .addr = 0x61, .flags = 0, .buf = buf, .len = sizeof(buf) };
+	int err;
+
+	dvb_pll_configure(&dvb_pll_tdvs_tua6034, buf, params->frequency, 0);
+	dprintk("%s: tuner at 0x%02x bytes: 0x%02x 0x%02x 0x%02x 0x%02x\n",
+		__FUNCTION__, msg.addr, buf[0],buf[1],buf[2],buf[3]);
+	if ((err = i2c_transfer(card->i2c_adapter, &msg, 1)) != 1) {
+	        printk(KERN_WARNING "dvb-bt8xx: %s error "
+		        "(addr %02x <- %02x, err = %i)\n",
+		        __FUNCTION__, buf[0], buf[1], err);
+		if (err < 0)
+			return err;
+		else
+			return -EREMOTEIO;
+	}
+
+	/* Set the Auxiliary Byte. */
+	buf[2] &= ~0x20;
+	buf[2] |= 0x18;
+	buf[3] = 0x50;
+	i2c_transfer(card->i2c_adapter, &msg, 1);
+
+	return 0;
+}
+
+static struct lgdt330x_config tdvs_tua6034_config = {
+	.demod_address    = 0x0e,
+	.demod_chip       = LGDT3303,
+	.serial_mpeg      = 0x40, /* TPSERIAL for 3303 in TOP_CONTROL */
+	.pll_set          = tdvs_tua6034_pll_set,
+};
+
+static void lgdt330x_reset(struct dvb_bt8xx_card *bt)
+{
+	/* Set pin 27 of the lgdt3303 chip high to reset the frontend */
+
+	/* Pulse the reset line */
+	bttv_write_gpio(bt->bttv_nr, 0x00e00007, 0x00000001); /* High */
+	bttv_write_gpio(bt->bttv_nr, 0x00e00007, 0x00000000); /* Low  */
+	msleep(100);
+
+	bttv_write_gpio(bt->bttv_nr, 0x00e00007, 0x00000001); /* High */
+	msleep(100);
+}
+
 static void frontend_init(struct dvb_bt8xx_card *card, u32 type)
 {
 	int ret;
@@ -562,6 +612,15 @@
 		break;
 #endif
 
+#ifdef BTTV_DVICO_FUSIONHDTV_5_LITE
+	case BTTV_DVICO_FUSIONHDTV_5_LITE:
+		lgdt330x_reset(card);
+		card->fe = lgdt330x_attach(&tdvs_tua6034_config, card->i2c_adapter);
+		if (card->fe != NULL)
+			dprintk ("dvb_bt8xx: lgdt330x detected\n");
+		break;
+#endif
+
 #ifdef BTTV_TWINHAN_VP3021
 	case BTTV_TWINHAN_VP3021:
 #else
@@ -765,6 +824,14 @@
 		 * DA_APP(parallel) */
 		break;
 
+#ifdef BTTV_DVICO_FUSIONHDTV_5_LITE
+	case BTTV_DVICO_FUSIONHDTV_5_LITE:
+#endif
+		card->gpio_mode = 0x0400c060;
+		card->op_sync_orin = BT878_RISC_SYNC_MASK;
+		card->irq_err_ignore = BT878_AFBUS | BT878_AFDSR;
+		break;
+
 #ifdef BTTV_TWINHAN_VP3021
 	case BTTV_TWINHAN_VP3021:
 #else
--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.h
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dvb-bt8xx.h
@@ -35,6 +35,7 @@
 #include "nxt6000.h"
 #include "cx24110.h"
 #include "or51211.h"
+#include "lgdt330x.h"
 
 struct dvb_bt8xx_card {
 	struct semaphore lock;
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/lgdt330x.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/lgdt330x.c
@@ -26,6 +26,7 @@
  *   DViCO FusionHDTV 3 Gold-Q
  *   DViCO FusionHDTV 3 Gold-T
  *   DViCO FusionHDTV 5 Gold
+ *   DViCO FusionHDTV 5 Lite
  *
  * TODO:
  * signal strength always returns 0.


--------------050202080108020809050806--
