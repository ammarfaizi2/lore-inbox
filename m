Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWGEGST@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWGEGST (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 02:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWGEGST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 02:18:19 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:22705 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750743AbWGEGSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 02:18:18 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20060705062033.6692.14131.sendpatchset@cherry.local>
Subject: [PATCH] release_firmware() fixes
Date: Wed,  5 Jul 2006 15:18:13 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use release_firmware() to free requested resources.

According to Documentation/firmware_class/README the request_firmware() call
should be followed by a release_firmware(). Some drivers do not however free
the firmware previously allocated with request_firmware(). This patch tries to
fix this by making sure that release_firmware() is used as expected.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

Apply on top of linux-2.6.17-git23. Compile-tested only.

 bluetooth/bcm203x.c               |    1 +
 media/dvb/frontends/nxt200x.c     |    4 ++--
 media/dvb/frontends/or51211.c     |    2 +-
 media/dvb/frontends/sp8870.c      |    2 +-
 media/dvb/frontends/sp887x.c      |    2 +-
 media/video/cx88/cx88-blackbird.c |    3 +++
 net/wireless/spectrum_cs.c        |   37 ++++++++++++++++---------------------
 7 files changed, 25 insertions(+), 26 deletions(-)

--- linux-2.6.17-git23/drivers/bluetooth/bcm203x.c
+++ linux-2.6.17-git23/drivers/bluetooth/bcm203x.c	2006-07-05 14:41:29.000000000 +0900
@@ -234,6 +234,7 @@ static int bcm203x_probe(struct usb_inte
 	data->fw_data = kmalloc(firmware->size, GFP_KERNEL);
 	if (!data->fw_data) {
 		BT_ERR("Can't allocate memory for firmware image");
+		release_firmware(firmware);
 		usb_free_urb(data->urb);
 		kfree(data->buffer);
 		kfree(data);
--- linux-2.6.17-git23/drivers/media/dvb/frontends/nxt200x.c
+++ linux-2.6.17-git23/drivers/media/dvb/frontends/nxt200x.c	2006-07-05 14:41:29.000000000 +0900
@@ -896,9 +896,9 @@ static int nxt2002_init(struct dvb_front
 	}
 
 	ret = nxt2002_load_firmware(fe, fw);
+	release_firmware(fw);
 	if (ret) {
 		printk("nxt2002: Writing firmware to device failed\n");
-		release_firmware(fw);
 		return ret;
 	}
 	printk("nxt2002: Firmware upload complete\n");
@@ -960,9 +960,9 @@ static int nxt2004_init(struct dvb_front
 	}
 
 	ret = nxt2004_load_firmware(fe, fw);
+	release_firmware(fw);
 	if (ret) {
 		printk("nxt2004: Writing firmware to device failed\n");
-		release_firmware(fw);
 		return ret;
 	}
 	printk("nxt2004: Firmware upload complete\n");
--- linux-2.6.17-git23/drivers/media/dvb/frontends/or51211.c
+++ linux-2.6.17-git23/drivers/media/dvb/frontends/or51211.c	2006-07-05 14:41:29.000000000 +0900
@@ -437,10 +437,10 @@ static int or51211_init(struct dvb_front
 		}
 
 		ret = or51211_load_firmware(fe, fw);
+		release_firmware(fw);
 		if (ret) {
 			printk(KERN_WARNING "or51211: Writing firmware to "
 			       "device failed!\n");
-			release_firmware(fw);
 			return ret;
 		}
 		printk(KERN_INFO "or51211: Firmware upload complete.\n");
--- linux-2.6.17-git23/drivers/media/dvb/frontends/sp8870.c
+++ linux-2.6.17-git23/drivers/media/dvb/frontends/sp8870.c	2006-07-05 14:41:29.000000000 +0900
@@ -318,7 +318,6 @@ static int sp8870_init (struct dvb_front
 	printk("sp8870: waiting for firmware upload (%s)...\n", SP8870_DEFAULT_FIRMWARE);
 	if (state->config->request_firmware(fe, &fw, SP8870_DEFAULT_FIRMWARE)) {
 		printk("sp8870: no firmware upload (timeout or file not found?)\n");
-		release_firmware(fw);
 		return -EIO;
 	}
 
@@ -327,6 +326,7 @@ static int sp8870_init (struct dvb_front
 		release_firmware(fw);
 		return -EIO;
 	}
+	release_firmware(fw);
 	printk("sp8870: firmware upload complete\n");
 
 	/* enable TS output and interface pins */
--- linux-2.6.17-git23/drivers/media/dvb/frontends/sp887x.c
+++ linux-2.6.17-git23/drivers/media/dvb/frontends/sp887x.c	2006-07-05 14:41:29.000000000 +0900
@@ -520,9 +520,9 @@ static int sp887x_init(struct dvb_fronte
 		}
 
 		ret = sp887x_initial_setup(fe, fw);
+		release_firmware(fw);
 		if (ret) {
 			printk("sp887x: writing firmware to device failed\n");
-			release_firmware(fw);
 			return ret;
 		}
 		printk("sp887x: firmware upload complete\n");
--- linux-2.6.17-git23/drivers/media/video/cx88/cx88-blackbird.c
+++ linux-2.6.17-git23/drivers/media/video/cx88/cx88-blackbird.c	2006-07-05 14:41:29.000000000 +0900
@@ -453,11 +453,13 @@ static int blackbird_load_firmware(struc
 	if (firmware->size != BLACKBIRD_FIRM_IMAGE_SIZE) {
 		dprintk(0, "ERROR: Firmware size mismatch (have %zd, expected %d)\n",
 			firmware->size, BLACKBIRD_FIRM_IMAGE_SIZE);
+		release_firmware(firmware);
 		return -1;
 	}
 
 	if (0 != memcmp(firmware->data, magic, 8)) {
 		dprintk(0, "ERROR: Firmware magic mismatch, wrong file?\n");
+		release_firmware(firmware);
 		return -1;
 	}
 
@@ -478,6 +480,7 @@ static int blackbird_load_firmware(struc
 	}
 	if (checksum) {
 		dprintk(0, "ERROR: Firmware load failed (checksum mismatch).\n");
+		release_firmware(firmware);
 		return -1;
 	}
 	release_firmware(firmware);
--- linux-2.6.17-git23/drivers/net/wireless/spectrum_cs.c
+++ linux-2.6.17-git23/drivers/net/wireless/spectrum_cs.c	2006-07-05 14:54:09.000000000 +0900
@@ -34,8 +34,6 @@
 
 #include "orinoco.h"
 
-static unsigned char *primsym;
-static unsigned char *secsym;
 static const char primary_fw_name[] = "symbol_sp24t_prim_fw";
 static const char secondary_fw_name[] = "symbol_sp24t_sec_fw";
 
@@ -440,7 +438,7 @@ spectrum_load_blocks(hermes_t *hw, const
  */
 static int
 spectrum_dl_image(hermes_t *hw, struct pcmcia_device *link,
-		  const unsigned char *image)
+		  const unsigned char *image, int secondary)
 {
 	int ret;
 	const unsigned char *ptr;
@@ -455,7 +453,7 @@ spectrum_dl_image(hermes_t *hw, struct p
 	first_block = (const struct dblock *) ptr;
 
 	/* Read the PDA */
-	if (image != primsym) {
+	if (secondary) {
 		ret = spectrum_read_pda(hw, pda, sizeof(pda));
 		if (ret)
 			return ret;
@@ -472,7 +470,7 @@ spectrum_dl_image(hermes_t *hw, struct p
 		return ret;
 
 	/* Write the PDA to the adapter */
-	if (image != primsym) {
+	if (secondary) {
 		ret = spectrum_apply_pda(hw, first_block, pda);
 		if (ret)
 			return ret;
@@ -487,7 +485,7 @@ spectrum_dl_image(hermes_t *hw, struct p
 	ret = hermes_init(hw);
 
 	/* hermes_reset() should return 0 with the secondary firmware */
-	if (image != primsym && ret != 0)
+	if (secondary && ret != 0)
 		return -ENODEV;
 
 	/* And this should work with any firmware */
@@ -509,33 +507,30 @@ spectrum_dl_firmware(hermes_t *hw, struc
 	const struct firmware *fw_entry;
 
 	if (request_firmware(&fw_entry, primary_fw_name,
-			     &handle_to_dev(link)) == 0) {
-		primsym = fw_entry->data;
-	} else {
+			     &handle_to_dev(link)) != 0) {
 		printk(KERN_ERR PFX "Cannot find firmware: %s\n",
 		       primary_fw_name);
 		return -ENOENT;
 	}
 
-	if (request_firmware(&fw_entry, secondary_fw_name,
-			     &handle_to_dev(link)) == 0) {
-		secsym = fw_entry->data;
-	} else {
-		printk(KERN_ERR PFX "Cannot find firmware: %s\n",
-		       secondary_fw_name);
-		return -ENOENT;
-	}
-
 	/* Load primary firmware */
-	ret = spectrum_dl_image(hw, link, primsym);
+	ret = spectrum_dl_image(hw, link, fw_entry->data, 0);
+	release_firmware(fw_entry);
 	if (ret) {
 		printk(KERN_ERR PFX "Primary firmware download failed\n");
 		return ret;
 	}
 
-	/* Load secondary firmware */
-	ret = spectrum_dl_image(hw, link, secsym);
+	if (request_firmware(&fw_entry, secondary_fw_name,
+			     &handle_to_dev(link)) != 0) {
+		printk(KERN_ERR PFX "Cannot find firmware: %s\n",
+		       secondary_fw_name);
+		return -ENOENT;
+	}
 
+	/* Load secondary firmware */
+	ret = spectrum_dl_image(hw, link, fw_entry->data, 1);
+	release_firmware(fw_entry);
 	if (ret) {
 		printk(KERN_ERR PFX "Secondary firmware download failed\n");
 	}
