Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbVH3Jfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbVH3Jfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 05:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbVH3Jfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 05:35:45 -0400
Received: from [85.8.12.41] ([85.8.12.41]:26008 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751314AbVH3Jfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 05:35:45 -0400
Message-ID: <43142847.3020703@drzeus.cx>
Date: Tue, 30 Aug 2005 11:35:03 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-22587-1125394542-0001-2"
To: Andrew Morton <akpm@osdl.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: conditional scr sysfs entry
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-22587-1125394542-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Only show the scr file in sysfs for SD cards. Previously this was
present for all cards but had a contents of 0 for MMC cards.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>

--=_hermes.drzeus.cx-22587-1125394542-0001-2
Content-Type: text/x-patch; name="mmc-conditional-scr.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-conditional-scr.patch"

Index: linux-wbsd/drivers/mmc/mmc_sysfs.c
===================================================================
--- linux-wbsd/drivers/mmc/mmc_sysfs.c	(revision 157)
+++ linux-wbsd/drivers/mmc/mmc_sysfs.c	(working copy)
@@ -46,7 +46,6 @@
 static struct device_attribute mmc_dev_attrs[] = {
 	MMC_ATTR_RO(cid),
 	MMC_ATTR_RO(csd),
-	MMC_ATTR_RO(scr),
 	MMC_ATTR_RO(date),
 	MMC_ATTR_RO(fwrev),
 	MMC_ATTR_RO(hwrev),
@@ -57,6 +56,8 @@
 	__ATTR_NULL
 };
 
+static struct device_attribute mmc_dev_attr_scr = MMC_ATTR_RO(scr);
+
 
 static void mmc_release_card(struct device *dev)
 {
@@ -207,10 +208,20 @@
  */
 int mmc_register_card(struct mmc_card *card)
 {
+	int ret;
+
 	snprintf(card->dev.bus_id, sizeof(card->dev.bus_id),
 		 "%s:%04x", card->host->host_name, card->rca);
 
-	return device_add(&card->dev);
+	ret = device_add(&card->dev);
+	if (ret == 0) {
+		if (mmc_card_sd(card)) {
+			ret = device_create_file(&card->dev, &mmc_dev_attr_scr);
+			if (ret)
+				device_del(&card->dev);
+		}
+	}
+	return ret;
 }
 
 /*
@@ -219,8 +230,12 @@
  */
 void mmc_remove_card(struct mmc_card *card)
 {
-	if (mmc_card_present(card))
+	if (mmc_card_present(card)) {
+		if (mmc_card_sd(card))
+			device_remove_file(&card->dev, &mmc_dev_attr_scr);
+
 		device_del(&card->dev);
+	}
 
 	put_device(&card->dev);
 }

--=_hermes.drzeus.cx-22587-1125394542-0001-2--
