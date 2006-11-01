Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946525AbWKAFlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946525AbWKAFlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946526AbWKAFk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:40:56 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:3730 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946518AbWKAFkS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:40:18 -0500
Message-Id: <20061101053944.080852000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:06 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Christopher Pascoe <c.pascoe@itee.uq.edu.au>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 26/61] DVB: fix dvb_pll_attach for mt352/zl10353 in cx88-dvb, and nxt200x
Content-Disposition: inline; filename=dvb-fix-dvb_pll_attach-for-mt352-zl10353-in-cx88-dvb-and-nxt200x.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Michael Krufky <mkrufky@linuxtv.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c |    2 +-
 drivers/media/dvb/frontends/dvb-pll.c     |    3 +++
 drivers/media/video/cx88/cx88-dvb.c       |   14 +++++++-------
 drivers/media/video/saa7134/saa7134-dvb.c |    4 ++--
 4 files changed, 13 insertions(+), 10 deletions(-)

--- linux-2.6.18.1.orig/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
+++ linux-2.6.18.1/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
@@ -527,7 +527,7 @@ int flexcop_frontend_init(struct flexcop
 	/* try the air atsc 2nd generation (nxt2002) */
 	if ((fc->fe = nxt200x_attach(&samsung_tbmv_config, &fc->i2c_adap)) != NULL) {
 		fc->dev_type          = FC_AIR_ATSC2;
-		dvb_pll_attach(fc->fe, 0x61, &fc->i2c_adap, &dvb_pll_samsung_tbmv);
+		dvb_pll_attach(fc->fe, 0x61, NULL, &dvb_pll_samsung_tbmv);
 		info("found the nxt2002 at i2c address: 0x%02x",samsung_tbmv_config.demod_address);
 	} else
 	/* try the air atsc 3nd generation (lgdt3303) */
--- linux-2.6.18.1.orig/drivers/media/dvb/frontends/dvb-pll.c
+++ linux-2.6.18.1/drivers/media/dvb/frontends/dvb-pll.c
@@ -493,6 +493,9 @@ static int dvb_pll_sleep(struct dvb_fron
 	int i;
 	int result;
 
+	if (priv->i2c == NULL)
+		return -EINVAL;
+
 	for (i = 0; i < priv->pll_desc->count; i++) {
 		if (priv->pll_desc->entries[i].limit == 0)
 			break;
--- linux-2.6.18.1.orig/drivers/media/video/cx88/cx88-dvb.c
+++ linux-2.6.18.1/drivers/media/video/cx88/cx88-dvb.c
@@ -576,7 +576,7 @@ static int dvb_register(struct cx8802_de
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x60,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_thomson_dtt7579);
 			break;
 		}
@@ -587,7 +587,7 @@ static int dvb_register(struct cx8802_de
 						   &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x60,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_thomson_dtt7579);
 		}
 #endif
@@ -600,7 +600,7 @@ static int dvb_register(struct cx8802_de
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_thomson_dtt7579);
 			break;
 		}
@@ -611,7 +611,7 @@ static int dvb_register(struct cx8802_de
 						   &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_thomson_dtt7579);
 		}
 #endif
@@ -623,7 +623,7 @@ static int dvb_register(struct cx8802_de
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_lg_z201);
 		}
 		break;
@@ -634,7 +634,7 @@ static int dvb_register(struct cx8802_de
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_unknown_1);
 		}
 		break;
@@ -757,7 +757,7 @@ static int dvb_register(struct cx8802_de
 						 &dev->core->i2c_adap);
 		if (dev->dvb.frontend != NULL) {
 			dvb_pll_attach(dev->dvb.frontend, 0x61,
-				       &dev->core->i2c_adap,
+				       NULL,
 				       &dvb_pll_tuv1236d);
 		}
 		break;
--- linux-2.6.18.1.orig/drivers/media/video/saa7134/saa7134-dvb.c
+++ linux-2.6.18.1/drivers/media/video/saa7134/saa7134-dvb.c
@@ -1158,13 +1158,13 @@ static int dvb_init(struct saa7134_dev *
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

--
