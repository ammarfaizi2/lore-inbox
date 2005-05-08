Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVEHUYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVEHUYS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVEHUWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:22:31 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:64662 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262927AbVEHTKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:01 -0400
Message-Id: <20050508184348.058001000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:51 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-tda1004x-fw-versions.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 22/37] tda10046: support for different firmware versions
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

added support for different tda10046 firmware versions.
tested with v20, v21 and v25. (Andreas Oberritter)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 Documentation/dvb/get_dvb_firmware     |    4 +--
 drivers/media/dvb/frontends/tda1004x.c |   36 +++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/tda1004x.c	2005-05-08 16:29:28.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/tda1004x.c	2005-05-08 16:30:27.000000000 +0200
@@ -49,6 +49,7 @@ struct tda1004x_state {
 	/* private demod data */
 	u8 initialised;
 	enum tda1004x_demod demod_type;
+	u8 fw_version;
 };
 
 
@@ -380,6 +381,25 @@ static int tda10045_fwupload(struct dvb_
 	return tda1004x_check_upload_ok(state, 0x2c);
 }
 
+static int tda10046_get_fw_version(struct tda1004x_state *state,
+				   const struct firmware *fw)
+{
+	const unsigned char pattern[] = { 0x67, 0x00, 0x50, 0x62, 0x5e, 0x18, 0x67 };
+	unsigned int i;
+
+	/* area guessed from firmware v20, v21 and v25 */
+	for (i = 0x660; i < 0x700; i++) {
+		if (!memcmp(&fw->data[i], pattern, sizeof(pattern))) {
+			state->fw_version = fw->data[i + sizeof(pattern)];
+			printk(KERN_INFO "tda1004x: using firmware v%02x\n",
+					state->fw_version);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int tda10046_fwupload(struct dvb_frontend* fe)
 {
 	struct tda1004x_state* state = fe->demodulator_priv;
@@ -393,7 +413,7 @@ static int tda10046_fwupload(struct dvb_
 	msleep(100);
 
 	/* don't re-upload unless necessary */
-	if (tda1004x_check_upload_ok(state, 0x20) == 0)
+	if (tda1004x_check_upload_ok(state, state->fw_version) == 0)
 		return 0;
 
 	/* request the firmware, this will block until someone uploads it */
@@ -404,6 +424,17 @@ static int tda10046_fwupload(struct dvb_
 		return ret;
 	}
 
+	if (fw->size < 24478) { /* size of firmware v20, which is the smallest of v20, v21 and v25 */
+		printk("tda1004x: firmware file seems to be too small (%d bytes)\n", fw->size);
+		return -EINVAL;
+	}
+
+	ret = tda10046_get_fw_version(state, fw);
+	if (ret < 0) {
+		printk("tda1004x: unable to find firmware version\n");
+		return ret;
+	}
+
 	/* set parameters */
 	tda1004x_write_byteI(state, TDA10046H_CONFPLL2, 10);
 	tda1004x_write_byteI(state, TDA10046H_CONFPLL3, state->config->n_i2c);
@@ -427,7 +458,7 @@ static int tda10046_fwupload(struct dvb_
 		msleep(1);
 	}
 
-	return tda1004x_check_upload_ok(state, 0x20);
+	return tda1004x_check_upload_ok(state, state->fw_version);
 }
 
 static int tda1004x_encode_fec(int fec)
@@ -1185,6 +1216,7 @@ struct dvb_frontend* tda10046_attach(con
 	memcpy(&state->ops, &tda10046_ops, sizeof(struct dvb_frontend_ops));
 	state->initialised = 0;
 	state->demod_type = TDA1004X_DEMOD_TDA10046;
+	state->fw_version = 0x20;	/* dummy default value */
 
 	/* check if the demod is there */
 	if (tda1004x_read_byte(state, TDA1004X_CHIPID) != 0x46) {
Index: linux-2.6.12-rc4/Documentation/dvb/get_dvb_firmware
===================================================================
--- linux-2.6.12-rc4.orig/Documentation/dvb/get_dvb_firmware	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/Documentation/dvb/get_dvb_firmware	2005-05-08 16:30:27.000000000 +0200
@@ -107,7 +107,7 @@ sub tda10045 {
 sub tda10046 {
     my $sourcefile = "tt_budget_217g.zip";
     my $url = "http://www.technotrend.de/new/217g/$sourcefile";
-    my $hash = "a25b579e37109af60f4a36c37893957c";
+    my $hash = "6a7e1e2f2644b162ff0502367553c72d";
     my $outfile = "dvb-fe-tda10046.fw";
     my $tmpdir = tempdir(DIR => "/tmp", CLEANUP => 1);
 
@@ -115,7 +115,7 @@ sub tda10046 {
 
     wgetfile($sourcefile, $url);
     unzip($sourcefile, $tmpdir);
-    extract("$tmpdir/software/OEM/PCI/App/ttlcdacc.dll", 0x3f731, 24479, "$tmpdir/fwtmp");
+    extract("$tmpdir/software/OEM/PCI/App/ttlcdacc.dll", 0x3f731, 24478, "$tmpdir/fwtmp");
     verify("$tmpdir/fwtmp", $hash);
     copy("$tmpdir/fwtmp", $outfile);
 

--

