Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVEMWKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVEMWKU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVEMWKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:10:20 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:60064 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262567AbVEMWJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:09:58 -0400
Message-Id: <20050513220225.520542000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:24 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-mac.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 05/11] flexcop: fix MAC address reading
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

read MAC address directly into dvb_adapter->proposed_mac

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/b2c2/flexcop-common.h |    1 -
 drivers/media/dvb/b2c2/flexcop-eeprom.c |   10 +++-------
 drivers/media/dvb/b2c2/flexcop-usb.c    |    3 ++-
 drivers/media/dvb/b2c2/flexcop.c        |   10 ++++++----
 4 files changed, 11 insertions(+), 13 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-common.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-common.h	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-common.h	2005-05-12 01:30:26.000000000 +0200
@@ -57,7 +57,6 @@ struct flexcop_device {
 	int init_state;
 
 	/* device information */
-	u8 mac_address[6];
 	int has_32_hw_pid_filter;
 	flexcop_revision_t rev;
 	flexcop_device_type_t dev_type;
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-eeprom.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-eeprom.c	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-eeprom.c	2005-05-12 01:30:26.000000000 +0200
@@ -129,8 +129,6 @@ static int flexcop_eeprom_lrc_read(struc
 	return ret;
 }
 
-/* TODO how is it handled in USB */
-
 /* JJ's comment about extended == 1: it is not presently used anywhere but was
  * added to the low-level functions for possible support of EUI64
  */
@@ -139,18 +137,16 @@ int flexcop_eeprom_check_mac_addr(struct
 	u8 buf[8];
 	int ret = 0;
 
-	memset(fc->mac_address,0,6);
-
 	if ((ret = flexcop_eeprom_lrc_read(fc,0x3f8,buf,8,4)) == 0) {
 		if (extended != 0) {
 			err("TODO: extended (EUI64) MAC addresses aren't completely supported yet");
 			ret = -EINVAL;
-/*			memcpy(fc->mac_address,buf,3);
+/*			memcpy(fc->dvb_adapter.proposed_mac,buf,3);
 			mac[3] = 0xfe;
 			mac[4] = 0xff;
-			memcpy(&fc->mac_address[3],&buf[5],3); */
+			memcpy(&fc->dvb_adapter.proposed_mac[3],&buf[5],3); */
 		} else
-			memcpy(fc->mac_address,buf,6);
+			memcpy(fc->dvb_adapter.proposed_mac,buf,6);
 	}
 	return ret;
 }
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-usb.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-usb.c	2005-05-12 01:30:16.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-usb.c	2005-05-12 01:30:26.000000000 +0200
@@ -180,7 +180,8 @@ static int flexcop_usb_memory_req(struct
 
 static int flexcop_usb_get_mac_addr(struct flexcop_device *fc, int extended)
 {
-	return flexcop_usb_memory_req(fc->bus_specific,B2C2_USB_READ_V8_MEM,V8_MEMORY_PAGE_FLASH,0x1f010,1,fc->mac_address,6);
+	return flexcop_usb_memory_req(fc->bus_specific,B2C2_USB_READ_V8_MEM,
+			V8_MEMORY_PAGE_FLASH,0x1f010,1,fc->dvb_adapter.proposed_mac,6);
 }
 
 #if 0
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop.c	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop.c	2005-05-12 01:30:26.000000000 +0200
@@ -233,16 +233,18 @@ int flexcop_device_initialize(struct fle
 
 	flexcop_smc_ctrl(fc, 0);
 
+	if ((ret = flexcop_dvb_init(fc)))
+		goto error;
+
+	/* do the MAC address reading after initializing the dvb_adapter */
 	if (fc->get_mac_addr(fc, 0) == 0) {
-		u8 *b = fc->mac_address;
+		u8 *b = fc->dvb_adapter.proposed_mac;
 		info("MAC address = %02x:%02x:%02x:%02x:%02x:%02x", b[0],b[1],b[2],b[3],b[4],b[5]);
-		flexcop_set_mac_filter(fc,fc->mac_address);
+		flexcop_set_mac_filter(fc,b);
 		flexcop_mac_filter_ctrl(fc,1);
 	} else
 		warn("reading of MAC address failed.\n");
 
-	if ((ret = flexcop_dvb_init(fc)))
-		goto error;
 
 	if ((ret = flexcop_i2c_init(fc)))
 		goto error;

--

