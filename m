Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVIDXhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVIDXhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVIDXhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:37:03 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:53889 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932111AbVIDXbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:00 -0400
Message-Id: <20050904232327.234883000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:28 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Svante Olofsson <svante@agentum.com>,
       Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-digitv-nxt6000.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 29/54] usb: digitv: support for nxt6000 demod
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svante Olofsson <svante@agentum.com>

Add support for the NXT6000-based digitv-box.
Add .get_tune_settings callback for the NXT6000 to have a min_tune_delay of 500ms.

Signed-off-by: Svante Olofsson <svante@agentum.com>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/digitv.c    |   40 ++++++++++++++++++++--------------
 drivers/media/dvb/frontends/nxt6000.c |    9 +++++++
 2 files changed, 33 insertions(+), 16 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/dvb-usb/digitv.c	2005-09-04 21:56:59.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/digitv.c	2005-09-04 22:28:22.000000000 +0200
@@ -113,31 +113,28 @@ static int digitv_mt352_demod_init(struc
 }
 
 static struct mt352_config digitv_mt352_config = {
-	.demod_address = 0x0, /* ignored by the digitv anyway */
 	.demod_init = digitv_mt352_demod_init,
 	.pll_set = dvb_usb_pll_set,
 };
 
-static struct nxt6000_config digitv_nxt6000_config = {
-	.demod_address = 0x0, /* ignored by the digitv anyway */
-	.clock_inversion = 0x0,
+static int digitv_nxt6000_pll_set(struct dvb_frontend *fe, struct dvb_frontend_parameters *fep)
+{
+	struct dvb_usb_device *d = fe->dvb->priv;
+	u8 b[5];
+	dvb_usb_pll_set(fe,fep,b);
+	return digitv_ctrl_msg(d,USB_WRITE_TUNER,0,&b[1],4,NULL,0);
+}
 
-	.pll_init = NULL,
-	.pll_set = NULL,
+static struct nxt6000_config digitv_nxt6000_config = {
+	.clock_inversion = 1,
+	.pll_set = digitv_nxt6000_pll_set,
 };
 
 static int digitv_frontend_attach(struct dvb_usb_device *d)
 {
-	if ((d->fe = mt352_attach(&digitv_mt352_config, &d->i2c_adap)) != NULL)
+	if ((d->fe = mt352_attach(&digitv_mt352_config, &d->i2c_adap)) != NULL ||
+		(d->fe = nxt6000_attach(&digitv_nxt6000_config, &d->i2c_adap)) != NULL)
 		return 0;
-	if ((d->fe = nxt6000_attach(&digitv_nxt6000_config, &d->i2c_adap)) != NULL) {
-
-		warn("nxt6000 support is not done yet, in fact you are one of the first "
-				"person who wants to use this device in Linux. Please report to "
-				"linux-dvb@linuxtv.org");
-
-		return 0;
-	}
 	return -EIO;
 }
 
@@ -175,7 +172,18 @@ static struct dvb_usb_properties digitv_
 static int digitv_probe(struct usb_interface *intf,
 		const struct usb_device_id *id)
 {
-	return dvb_usb_device_init(intf,&digitv_properties,THIS_MODULE,NULL);
+	struct dvb_usb_device *d;
+	int ret;
+	if ((ret = dvb_usb_device_init(intf,&digitv_properties,THIS_MODULE,&d)) == 0) {
+		u8 b[4] = { 0 };
+
+		b[0] = 1;
+		digitv_ctrl_msg(d,USB_WRITE_REMOTE_TYPE,0,b,4,NULL,0);
+
+		b[0] = 0;
+		digitv_ctrl_msg(d,USB_WRITE_REMOTE,0,b,4,NULL,0);
+	}
+	return ret;
 }
 
 static struct usb_device_id digitv_table [] = {
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/nxt6000.c	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/nxt6000.c	2005-09-04 22:28:22.000000000 +0200
@@ -482,6 +482,7 @@ static int nxt6000_set_frontend(struct d
 	if ((result = nxt6000_set_inversion(state, param->inversion)) < 0)
 		return result;
 
+	msleep(500);
 	return 0;
 }
 
@@ -525,6 +526,12 @@ static int nxt6000_read_signal_strength(
 	return 0;
 }
 
+static int nxt6000_fe_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings *tune)
+{
+	tune->min_delay_ms = 500;
+	return 0;
+}
+
 static struct dvb_frontend_ops nxt6000_ops;
 
 struct dvb_frontend* nxt6000_attach(const struct nxt6000_config* config,
@@ -577,6 +584,8 @@ static struct dvb_frontend_ops nxt6000_o
 	.release = nxt6000_release,
 
 	.init = nxt6000_init,
+	
+	.get_tune_settings = nxt6000_fe_get_tune_settings,
 
 	.set_frontend = nxt6000_set_frontend,
 

--

