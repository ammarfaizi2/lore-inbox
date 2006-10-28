Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWJ1SyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWJ1SyG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWJ1SyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:54:06 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:1691 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S932087AbWJ1SyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:54:03 -0400
Message-ID: <4543A73D.100@linuxtv.org>
Date: Sat, 28 Oct 2006 14:53:49 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: stable@kernel.org
CC: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christopher Pascoe <c.pascoe@itee.uq.edu.au>
Subject: [2.6.18.y PATCH] DVB: fix dvb_pll_attach for mt352/zl10353 in cx88-dvb,
 and nxt200x
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: fix dvb_pll_attach for mt352/zl10353 in cx88-dvb, and nxt200x

Typical wiring of MT352, ZL10353, NXT2002 and NXT2004 based tuners
differ from dvb-pll's expectation that the PLL is directly accessible.
On these boards, the PLL is actually hidden behind the demodulator, and
as such can only be accessed via the demodulator's interface.  It was
failing to communicate with the PLL during an attach test and
subsequently not connecting the tuner ops.

By passing a NULL I2C bus handle to dvb_pll_attach, this accessibility
check can be bypassed.  Do this for the affected boards.  Also fix a
possible NULL dereference at sleep time, which would otherwise be
exposed by this change.

This patch has been backported to the 2.6.18.y stable kernel series
from the original changesets from Chris Pascoe and Michael Krufky,
already present in the upstream 2.6.19 kernel tree.

Signed-off-by: Chris Pascoe <c.pascoe@itee.uq.edu.au>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

diff --git a/drivers/media/dvb/b2c2/flexcop-fe-tuner.c b/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
index 3be87c7..68bb56e 100644
--- a/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
+++ b/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
@@ -527,7 +527,7 @@ int flexcop_frontend_init(struct flexcop
 	/* try the air atsc 2nd generation (nxt2002) */
 	if ((fc->fe = nxt200x_attach(&samsung_tbmv_config, &fc->i2c_adap)) != NULL) {
 		fc->dev_type          = FC_AIR_ATSC2;
-		dvb_pll_attach(fc->fe, 0x61, &fc->i2c_adap, &dvb_pll_samsung_tbmv);
+		dvb_pll_attach(fc->fe, 0x61, NULL, &dvb_pll_samsung_tbmv);
 		info("found the nxt2002 at i2c address: 0x%02x",samsung_tbmv_config.demod_address);
 	} else
 	/* try the air atsc 3nd generation (lgdt3303) */
diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
index 2be33f2..887d6f4 100644
--- a/drivers/media/dvb/frontends/dvb-pll.c
+++ b/drivers/media/dvb/frontends/dvb-pll.c
@@ -493,6 +493,9 @@ static int dvb_pll_sleep(struct dvb_fron
 	int i;
 	int result;
 
+	if (priv->i2c == NULL)
+		return -EINVAL;
+
 	for (i = 0; i < priv->pll_desc->count; i++) {
 		if (priv->pll_desc->entries[i].limit == 0)
 			break;
diff --git a/drivers/media/video/cx88/cx88-dvb.c b/drivers/media/video/cx88/cx88-dvb.c
index afde378..fd3ef4c 100644
--- a/drivers/media/video/cx88/cx88-dvb.c
+++ b/drivers/media/video/cx88/cx88-dvb.c
@@ -576,7 +576,7 @@ #ifdef HAVE_MT352
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x60,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_thomson_dtt7579);
 			break;
 		}
@@ -587,7 +587,7 @@ #ifdef HAVE_ZL10353
 						   &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x60,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_thomson_dtt7579);
 		}
 #endif
@@ -600,7 +600,7 @@ #ifdef HAVE_MT352
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_thomson_dtt7579);
 			break;
 		}
@@ -611,7 +611,7 @@ #ifdef HAVE_ZL10353
 						   &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_thomson_dtt7579);
 		}
 #endif
@@ -623,7 +623,7 @@ #ifdef HAVE_MT352
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_lg_z201);
 		}
 		break;
@@ -634,7 +634,7 @@ #ifdef HAVE_MT352
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_unknown_1);
 		}
 		break;
@@ -757,7 +757,7 @@ #ifdef HAVE_NXT200X
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_tuv1236d);
 		}
 		break;
diff --git a/drivers/media/video/saa7134/saa7134-dvb.c b/drivers/media/video/saa7134/saa7134-dvb.c
index 279828b..449fe23 100644
--- a/drivers/media/video/saa7134/saa7134-dvb.c
+++ b/drivers/media/video/saa7134/saa7134-dvb.c
@@ -1158,13 +1158,13 @@ #ifdef HAVE_NXT200X
 	case SAA7134_BOARD_AVERMEDIA_AVERTVHD_A180:
 		dev->dvb.frontend = nxt200x_attach(&avertvhda180, &dev->i2c_adap);
 		if (dev->dvb.frontend) {
-			dvb_pll_attach(dev->dvb.frontend, 0x61, &dev->i2c_adap, &dvb_pll_tdhu2);
+			dvb_pll_attach(dev->dvb.frontend, 0x61, NULL, &dvb_pll_tdhu2);
 		}
 		break;
 	case SAA7134_BOARD_KWORLD_ATSC110:
 		dev->dvb.frontend = nxt200x_attach(&kworldatsc110, &dev->i2c_adap);
 		if (dev->dvb.frontend) {
-			dvb_pll_attach(dev->dvb.frontend, 0x61, &dev->i2c_adap, &dvb_pll_tuv1236d);
+			dvb_pll_attach(dev->dvb.frontend, 0x61, NULL, &dvb_pll_tuv1236d);
 		}
 		break;
 #endif
