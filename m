Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVKAIWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVKAIWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVKAIWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:22:14 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:3173 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S965042AbVKAIPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:15:22 -0500
Message-ID: <436723F8.4000602@m1k.net>
Date: Tue, 01 Nov 2005 03:14:48 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 21/37] dvb: Add support for Air2PC/AirStar 2 ATSC 3rd generation
 (HD5000)
Content-Type: multipart/mixed;
 boundary="------------080706070606040903010205"
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
--------------080706070606040903010205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------080706070606040903010205
Content-Type: text/x-patch;
 name="2391.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2391.patch"

Added support for Air2PC/AirStar 2 ATSC 3rd generation (HD5000)

Signed-off-by: Taylor Jacob <rtjacob@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 drivers/media/dvb/b2c2/flexcop-fe-tuner.c |   53 ++++++++++++++++++++++++++++++
 drivers/media/dvb/b2c2/flexcop-misc.c     |    1 
 drivers/media/dvb/b2c2/flexcop-reg.h      |    1 
 drivers/media/dvb/b2c2/flexcop.c          |    1 
 drivers/media/dvb/frontends/dvb-pll.c     |    2 -
 drivers/media/dvb/frontends/lgdt330x.c    |   15 +++++++-
 drivers/media/dvb/frontends/lgdt330x.h    |    4 ++
 7 files changed, 74 insertions(+), 3 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
@@ -13,6 +13,8 @@
 #include "bcm3510.h"
 #include "stv0297_cs2.h"
 #include "mt312.h"
+#include "lgdt330x.h"
+#include "dvb-pll.h"
 
 /* lnb control */
 
@@ -295,6 +297,52 @@
 	return request_firmware(fw, name, fc->dev);
 }
 
+static int lgdt3303_pll_set(struct dvb_frontend* fe,
+                            struct dvb_frontend_parameters* params)
+{
+	struct flexcop_device *fc = fe->dvb->priv;
+	u8 buf[4];
+	struct i2c_msg msg =
+		{ .addr = 0x61, .flags = 0, .buf = buf, .len = 4 };
+	int err;
+
+	dvb_pll_configure(&dvb_pll_tdvs_tua6034,buf, params->frequency, 0);
+	dprintk(1, "%s: tuner at 0x%02x bytes: 0x%02x 0x%02x 0x%02x 0x%02x\n",
+			__FUNCTION__, msg.addr, buf[0],buf[1],buf[2],buf[3]);
+	if ((err = i2c_transfer(&fc->i2c_adap, &msg, 1)) != 1) {
+		printk(KERN_WARNING "lgdt3303: %s error "
+			   "(addr %02x <- %02x, err = %i)\n",
+			   __FUNCTION__, buf[0], buf[1], err);
+		if (err < 0)
+			return err;
+		else
+			return -EREMOTEIO;
+	}
+
+	buf[0] = 0x86 | 0x18;
+	buf[1] = 0x50;
+	msg.len = 2;
+	if ((err = i2c_transfer(&fc->i2c_adap, &msg, 1)) != 1) {
+		printk(KERN_WARNING "lgdt3303: %s error "
+			   "(addr %02x <- %02x, err = %i)\n",
+			   __FUNCTION__, buf[0], buf[1], err);
+		if (err < 0)
+			return err;
+		else
+			return -EREMOTEIO;
+	}
+
+        return 0;
+}
+
+static struct lgdt330x_config air2pc_atsc_hd5000_config = {
+	.demod_address       = 0x59,
+	.demod_chip          = LGDT3303,
+	.serial_mpeg         = 0x04,
+	.pll_set             = lgdt3303_pll_set,
+	.clock_polarity_flip = 1,
+};
+
 static struct nxt2002_config samsung_tbmv_config = {
 	.demod_address    = 0x0a,
 	.request_firmware = flexcop_fe_request_firmware,
@@ -406,6 +454,11 @@
 		fc->dev_type          = FC_AIR_ATSC2;
 		info("found the nxt2002 at i2c address: 0x%02x",samsung_tbmv_config.demod_address);
 	} else
+	/* try the air atsc 3nd generation (lgdt3303) */
+	if ((fc->fe = lgdt330x_attach(&air2pc_atsc_hd5000_config, &fc->i2c_adap)) != NULL) {
+		fc->dev_type          = FC_AIR_ATSC3;
+		info("found the lgdt3303 at i2c address: 0x%02x",air2pc_atsc_hd5000_config.demod_address);
+	} else
 	/* try the air atsc 1nd generation (bcm3510)/panasonic ct10s */
 	if ((fc->fe = bcm3510_attach(&air2pc_atsc_first_gen_config, &fc->i2c_adap)) != NULL) {
 		fc->dev_type          = FC_AIR_ATSC1;
--- linux-2.6.14-git3.orig/drivers/media/dvb/b2c2/flexcop-misc.c
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/flexcop-misc.c
@@ -51,6 +51,7 @@
 	"Sky2PC/SkyStar 2 DVB-S",
 	"Sky2PC/SkyStar 2 DVB-S (old version)",
 	"Cable2PC/CableStar 2 DVB-C",
+	"Air2PC/AirStar 2 ATSC 3rd generation (HD5000)",
 };
 
 const char *flexcop_bus_names[] = {
--- linux-2.6.14-git3.orig/drivers/media/dvb/b2c2/flexcop-reg.h
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/flexcop-reg.h
@@ -26,6 +26,7 @@
 	FC_SKY,
 	FC_SKY_OLD,
 	FC_CABLE,
+	FC_AIR_ATSC3,
 } flexcop_device_type_t;
 
 typedef enum {
--- linux-2.6.14-git3.orig/drivers/media/dvb/b2c2/flexcop.c
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/flexcop.c
@@ -193,6 +193,7 @@
 	v204 = fc->read_ibi_reg(fc,misc_204);
 	v204.misc_204.Per_reset_sig = 0;
 	fc->write_ibi_reg(fc,misc_204,v204);
+	msleep(1);
 	v204.misc_204.Per_reset_sig = 1;
 	fc->write_ibi_reg(fc,misc_204,v204);
 }
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/lgdt330x.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/lgdt330x.c
@@ -27,6 +27,7 @@
  *   DViCO FusionHDTV 3 Gold-T
  *   DViCO FusionHDTV 5 Gold
  *   DViCO FusionHDTV 5 Lite
+ *   Air2PC/AirStar 2 ATSC 3rd generation (HD5000)
  *
  * TODO:
  * signal strength always returns 0.
@@ -223,6 +224,11 @@
 		0x4c, 0x14
 	};
 
+	static u8 flip_lgdt3303_init_data[] = {
+		0x4c, 0x14,
+		0x87, 0xf3
+	};
+
 	struct lgdt330x_state* state = fe->demodulator_priv;
 	char  *chip_name;
 	int    err;
@@ -235,8 +241,13 @@
 		break;
 	case LGDT3303:
 		chip_name = "LGDT3303";
-		err = i2c_write_demod_bytes(state, lgdt3303_init_data,
-					    sizeof(lgdt3303_init_data));
+		if (state->config->clock_polarity_flip) {
+			err = i2c_write_demod_bytes(state, flip_lgdt3303_init_data,
+						    sizeof(flip_lgdt3303_init_data));
+		} else {
+			err = i2c_write_demod_bytes(state, lgdt3303_init_data,
+						    sizeof(lgdt3303_init_data));
+		}
 		break;
 	default:
 		chip_name = "undefined";
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/lgdt330x.h
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/lgdt330x.h
@@ -47,6 +47,10 @@
 
 	/* Need to set device param for start_dma */
 	int (*set_ts_params)(struct dvb_frontend* fe, int is_punctured);
+
+	/* Flip the polarity of the mpeg data transfer clock using alternate init data
+	 * This option applies ONLY to LGDT3303 - 0:disabled (default) 1:enabled */
+	int clock_polarity_flip;
 };
 
 extern struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config* config,
--- linux-2.6.14-git3.orig/drivers/media/dvb/frontends/dvb-pll.c
+++ linux-2.6.14-git3/drivers/media/dvb/frontends/dvb-pll.c
@@ -226,7 +226,7 @@
 EXPORT_SYMBOL(dvb_pll_tua6034);
 
 /* Infineon TUA6034
- * used in LG Innotek TDVS-H062F
+ * used in LG TDVS H061F and LG TDVS H062F
  */
 struct dvb_pll_desc dvb_pll_tdvs_tua6034 = {
 	.name  = "LG/Infineon TUA6034",


--------------080706070606040903010205--
