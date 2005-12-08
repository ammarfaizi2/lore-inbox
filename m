Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbVLHWfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbVLHWfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVLHWfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:35:30 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:20082 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932681AbVLHWf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:35:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=UII5I13HcgnB10Ey6Pk37jRKfOvx3udm3FNDObkyUQ2PsQ/e8VgMv05cmhSUTBFJMSbgo2RNf77dzh+px55mCUp1Vn1W9LaUG2nCk1Ghrg5y93csuXxXZRkupmFe34btEqGt2hPkMp896XOT9FJ4BXKH/b1TQg6/0/5KeFFJZ34=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Decrease number of pointer derefs in flexcop-fe-tuner.c
Date: Thu, 8 Dec 2005 23:35:55 +0100
User-Agent: KMail/1.9
Cc: Patrick Boettcher <patrick.boettcher@desy.de>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512082335.55331.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a small patch to decrease the number of pointer derefs in
drivers/media/dvb/b2c2/flexcop-fe-tuner.c

Benefits of the patch:
 - Fewer pointer dereferences should make the code slightly faster.
 - Size of generated code is smaller
 - Improved readability

Please consider applying.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/media/dvb/b2c2/flexcop-fe-tuner.c |   31 ++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

orig:
   text    data     bss     dec     hex filename
   3072     424       0    3496     da8 drivers/media/dvb/b2c2/flexcop-fe-tuner.o

patched:
   text    data     bss     dec     hex filename
   3041     424       0    3465     d89 drivers/media/dvb/b2c2/flexcop-fe-tuner.o

--- linux-2.6.15-rc5-git1-orig/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2005-12-04 18:47:50.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2005-12-08 22:14:16.000000000 +0100
@@ -485,12 +485,16 @@ static struct stv0297_config alps_tdee4_
 /* try to figure out the frontend, each card/box can have on of the following list */
 int flexcop_frontend_init(struct flexcop_device *fc)
 {
+	struct dvb_frontend_ops *ops;
+
 	/* try the sky v2.6 (stv0299/Samsung tbmu24112(sl1935)) */
 	if ((fc->fe = stv0299_attach(&samsung_tbmu24112_config, &fc->i2c_adap)) != NULL) {
-		fc->fe->ops->set_voltage = flexcop_set_voltage;
+		ops = fc->fe->ops;
+		
+		ops->set_voltage = flexcop_set_voltage;
 
-		fc->fe_sleep             = fc->fe->ops->sleep;
-		fc->fe->ops->sleep       = flexcop_sleep;
+		fc->fe_sleep             = ops->sleep;
+		ops->sleep               = flexcop_sleep;
 
 		fc->dev_type          = FC_SKY;
 		info("found the stv0299 at i2c address: 0x%02x",samsung_tbmu24112_config.demod_address);
@@ -522,15 +526,17 @@ int flexcop_frontend_init(struct flexcop
 	} else
 	/* try the sky v2.3 (vp310/Samsung tbdu18132(tsa5059)) */
 	if ((fc->fe = vp310_attach(&skystar23_samsung_tbdu18132_config, &fc->i2c_adap)) != NULL) {
-		fc->fe->ops->diseqc_send_master_cmd = flexcop_diseqc_send_master_cmd;
-		fc->fe->ops->diseqc_send_burst      = flexcop_diseqc_send_burst;
-		fc->fe->ops->set_tone               = flexcop_set_tone;
-		fc->fe->ops->set_voltage            = flexcop_set_voltage;
+		ops = fc->fe->ops;
+		
+		ops->diseqc_send_master_cmd = flexcop_diseqc_send_master_cmd;
+		ops->diseqc_send_burst      = flexcop_diseqc_send_burst;
+		ops->set_tone               = flexcop_set_tone;
+		ops->set_voltage            = flexcop_set_voltage;
 
-		fc->fe_sleep                        = fc->fe->ops->sleep;
-		fc->fe->ops->sleep                  = flexcop_sleep;
+		fc->fe_sleep                = ops->sleep;
+		ops->sleep                  = flexcop_sleep;
 
-		fc->dev_type                        = FC_SKY_OLD;
+		fc->dev_type                = FC_SKY_OLD;
 		info("found the vp310 (aka mt312) at i2c address: 0x%02x",skystar23_samsung_tbdu18132_config.demod_address);
 	}
 
@@ -540,8 +546,9 @@ int flexcop_frontend_init(struct flexcop
 	} else {
 		if (dvb_register_frontend(&fc->dvb_adapter, fc->fe)) {
 			err("frontend registration failed!");
-			if (fc->fe->ops->release != NULL)
-				fc->fe->ops->release(fc->fe);
+			ops = fc->fe->ops;
+			if (ops->release != NULL)
+				ops->release(fc->fe);
 			fc->fe = NULL;
 			return -EINVAL;
 		}



