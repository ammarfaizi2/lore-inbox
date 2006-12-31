Return-Path: <linux-kernel-owner+w=401wt.eu-S933204AbWLaRK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933204AbWLaRK7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933205AbWLaRK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:10:58 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:1890 "EHLO
	anchor-post-32.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933204AbWLaRK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:10:58 -0500
Date: Sun, 31 Dec 2006 17:08:20 +0000
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: linux-kernel@vger.kernel.org, drzeus-mmc@drzeus.cx,
       sdhci-devel@list.drzeus.cx
Subject: [PATCH 2.6.20-rc2] Add a quirk to allow ENE PCI SD card readers to work again
Message-ID: <4E9DF295D4%linux@youmustbejoking.demon.co.uk>
References: <4E9DA5E8EB%linux@youmustbejoking.demon.co.uk> <4597A791.60007@drzeus.cx> <4E9DE7C297%linux@youmustbejoking.demon.co.uk>
In-Reply-To: <4E9DE7C297%linux@youmustbejoking.demon.co.uk>
User-Agent: Messenger-Pro/4.14b7 (MsgServe/3.26b1) (RISC-OS/4.02) POPstar/2.06+cvs
Mail-Followup-To: linux@youmustbejoking.demon.co.uk,linux-kernel@vger.kernel.org,drzeus-mmc@drzeus.cx,sdhci-devel@list.drzeus.cx
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Sun, 4870 Sep 1993 17:08:20 +0000
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk to allow ENE PCI SD card readers to work again

Support for these devices was broken for 2.6.18-rc1 and later by commit
146ad66eac836c0b976c98f428d73e1f6a75270d, which added voltage level support.

This restores the previous behaviour for these devices by ensuring that when
the voltage is changed, only one write to set the voltage is performed.

It may be that both writes are needed if the voltage is being changed between
two non-zero values or that it's safe to ensure that only one write is done
if the hardware only supports one voltage; I don't know whether either is the
case nor can I test since I have only the one SD reader (1524:0550), and it
supports just the one voltage.

Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>

diff -ur linux-2.6.20-rc2.orig/drivers/mmc/sdhci.c linux-2.6.20-rc2/drivers/mmc/sdhci.c
--- linux-2.6.20-rc2.orig/drivers/mmc/sdhci.c	2006-12-30 15:34:11.000000000 +0000
+++ linux-2.6.20-rc2/drivers/mmc/sdhci.c	2006-12-31 16:43:50.000000000 +0000
@@ -37,6 +37,7 @@
 #define SDHCI_QUIRK_FORCE_DMA				(1<<1)
 /* Controller doesn't like some resets when there is no card inserted. */
 #define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
+#define SDHCI_QUIRK_SINGLE_POWER_WRITE			(1<<3)
 
 static const struct pci_device_id pci_ids[] __devinitdata = {
 	{
@@ -65,6 +66,16 @@
 		.driver_data	= SDHCI_QUIRK_FORCE_DMA,
 	},
 
+	{
+		.class		= PCI_CLASS_SYSTEM_SDHCI << 8,
+		.class_mask	= 0xFFFF00,
+		.vendor		= PCI_VENDOR_ID_ENE,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= SDHCI_QUIRK_SINGLE_POWER_WRITE,
+	},
+
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
 	},
@@ -669,16 +680,17 @@
 
 static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
-	u8 pwr;
+	u8 pwr = 0;
 
 	if (host->power == power)
 		return;
 
-	writeb(0, host->ioaddr + SDHCI_POWER_CONTROL);
-
 	if (power == (unsigned short)-1)
 		goto out;
 
+	if ((host->chip->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE) == 0)
+		writeb(0, host->ioaddr + SDHCI_POWER_CONTROL);
+
 	pwr = SDHCI_POWER_ON;
 
 	switch (power) {

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
|   Kill all extremists!

Confucius say: Many pages make thick book.
