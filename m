Return-Path: <linux-kernel-owner+w=401wt.eu-S932721AbWLaEV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbWLaEV0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 23:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWLaEV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 23:21:26 -0500
Received: from anchor-fallback-96.mail.demon.net ([194.217.242.83]:36663 "EHLO
	anchor-fallback-96.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932721AbWLaEVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 23:21:25 -0500
X-Greylist: delayed 3439 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Dec 2006 23:21:25 EST
Date: Sun, 31 Dec 2006 03:10:50 +0000
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Message-ID: <4E9DA5E8EB%linux@youmustbejoking.demon.co.uk>
User-Agent: Messenger-Pro/4.14b7 (MsgServe/3.26b1) (RISC-OS/4.02) POPstar/2.06+cvs
To: drzeus-mmc@drzeus.cx
Cc: linux-kernel@vger.kernel.org
Mail-Followup-To: linux@youmustbejoking.demon.co.uk, drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc2] Add a quirk to allow at least some ENE PCI SD card readers to work again
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Sun, 4870 Sep 1993 03:10:50 +0000
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk to allow at least some ENE PCI SD card readers to work again

Support for these devices was broken for 2.6.18-rc1 and later by commit
146ad66eac836c0b976c98f428d73e1f6a75270d, which added voltage level support.

This restores the previous behaviour for these devices (PCI ID 1524:0550).

Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>

diff -ur linux-2.6.20-rc.orig/drivers/mmc/sdhci.c linux-2.6.20-rc/drivers/mmc/sdhci.c
--- linux-2.6.20-rc.orig/drivers/mmc/sdhci.c	2006-12-30 15:34:11.000000000 +0000
+++ linux-2.6.20-rc/drivers/mmc/sdhci.c	2006-12-31 02:46:48.000000000 +0000
@@ -37,6 +37,7 @@
 #define SDHCI_QUIRK_FORCE_DMA				(1<<1)
 /* Controller doesn't like some resets when there is no card inserted. */
 #define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
+#define SDHCI_QUIRK_FORCE_POWER				(1<<3)
 
 static const struct pci_device_id pci_ids[] __devinitdata = {
 	{
@@ -65,6 +66,14 @@
 		.driver_data	= SDHCI_QUIRK_FORCE_DMA,
 	},
 
+	{
+		.vendor		= PCI_VENDOR_ID_ENE,
+		.device		= PCI_DEVICE_ID_ENE_CB712_SD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SDHCI_QUIRK_FORCE_POWER,
+	},
+
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
 	},
@@ -671,6 +680,12 @@
 {
 	u8 pwr;
 
+	if (host->chip->quirks & SDHCI_QUIRK_FORCE_POWER) {
+		writeb((power != (unsigned short) -1) ? 0xFF : 0,
+			host->ioaddr + SDHCI_POWER_CONTROL);
+		goto out;
+	}
+
 	if (host->power == power)
 		return;
 
diff -ur linux-2.6.20-rc.orig/include/linux/pci_ids.h linux-2.6.20-rc/include/linux/pci_ids.h
--- linux-2.6.20-rc.orig/include/linux/pci_ids.h	2006-12-30 15:34:21.000000000 +0000
+++ linux-2.6.20-rc/include/linux/pci_ids.h	2006-12-31 02:46:48.000000000 +0000
@@ -1968,6 +1968,7 @@
 #define PCI_DEVICE_ID_TOPIC_TP560	0x0000
 
 #define PCI_VENDOR_ID_ENE		0x1524
+#define PCI_DEVICE_ID_ENE_CB712_SD	0x0550
 #define PCI_DEVICE_ID_ENE_1211		0x1211
 #define PCI_DEVICE_ID_ENE_1225		0x1225
 #define PCI_DEVICE_ID_ENE_1410		0x1410

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Buy local produce. Try to walk or cycle. TRANSPORT CAUSES GLOBAL WARMING.

I think therefore I create bugs.
