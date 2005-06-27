Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVF0OC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVF0OC2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVF0OAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:00:14 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:33509 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262091AbVF0MRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:17:04 -0400
Message-Id: <20050627121411.529348000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:10 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>
Content-Disposition: inline; filename=dvb-add-missing-release_firmware.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 10/51] add missing release_firmware() calls
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anssi Hannula <anssi.hannula@gmail.com>

Add missing release_firmware() calls to fix memory leaks.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/frontends/tda1004x.c  |    2 ++
 drivers/media/dvb/ttusb-dec/ttusb_dec.c |   11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/frontends/tda1004x.c	2005-06-27 13:23:03.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/frontends/tda1004x.c	2005-06-27 13:23:04.000000000 +0200
@@ -385,6 +385,7 @@ static int tda10045_fwupload(struct dvb_
 	tda10045h_set_bandwidth(state, BANDWIDTH_8_MHZ);
 
 	ret = tda1004x_do_upload(state, fw->data, fw->size, TDA10045H_FWPAGE, TDA10045H_CODE_IN);
+	release_firmware(fw);
 	if (ret)
 		return ret;
 	printk(KERN_INFO "tda1004x: firmware upload complete\n");
@@ -452,6 +453,7 @@ static int tda10046_fwupload(struct dvb_
 		}
 		tda1004x_write_mask(state, TDA1004X_CONFC4, 8, 8); // going to boot from HOST
 		ret = tda1004x_do_upload(state, fw->data, fw->size, TDA10046H_CODE_CPT, TDA10046H_CODE_IN);
+		release_firmware(fw);
 		if (ret)
 			return ret;
 	} else {
Index: linux-2.6.12-git8/drivers/media/dvb/ttusb-dec/ttusb_dec.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2005-06-27 13:23:04.000000000 +0200
@@ -1281,6 +1281,7 @@ static int ttusb_dec_boot_dsp(struct ttu
 	if (firmware_size < 60) {
 		printk("%s: firmware size too small for DSP code (%zu < 60).\n",
 			__FUNCTION__, firmware_size);
+		release_firmware(fw_entry);
 		return -1;
 	}
 
@@ -1294,6 +1295,7 @@ static int ttusb_dec_boot_dsp(struct ttu
 		printk("%s: crc32 check of DSP code failed (calculated "
 		       "0x%08x != 0x%08x in file), file invalid.\n",
 			__FUNCTION__, crc32_csum, crc32_check);
+		release_firmware(fw_entry);
 		return -1;
 	}
 	memcpy(idstring, &firmware[36], 20);
@@ -1308,15 +1310,19 @@ static int ttusb_dec_boot_dsp(struct ttu
 
 	result = ttusb_dec_send_command(dec, 0x41, sizeof(b0), b0, NULL, NULL);
 
-	if (result)
+	if (result) {
+		release_firmware(fw_entry);
 		return result;
+	}
 
 	trans_count = 0;
 	j = 0;
 
 	b = kmalloc(ARM_PACKET_SIZE, GFP_KERNEL);
-	if (b == NULL)
+	if (b == NULL) {
+		release_firmware(fw_entry);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < firmware_size; i += COMMAND_PACKET_SIZE) {
 		size = firmware_size - i;
@@ -1345,6 +1351,7 @@ static int ttusb_dec_boot_dsp(struct ttu
 
 	result = ttusb_dec_send_command(dec, 0x43, sizeof(b1), b1, NULL, NULL);
 
+	release_firmware(fw_entry);
 	kfree(b);
 
 	return result;

--

