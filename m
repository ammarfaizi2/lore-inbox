Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWKHQQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWKHQQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWKHQQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:16:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26830 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161008AbWKHQQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:16:56 -0500
Subject: [PATCH] hpt37x: Check the enablebits
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 16:18:26 +0000
Message-Id: <1163002706.23956.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helps for PATA but SATA bridged devices lie and always set all the bits
so will need the error handling fixes from Tejun.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/drivers/ata/pata_hpt37x.c linux-2.6.19-rc4-mm1/drivers/ata/pata_hpt37x.c
--- linux.vanilla-2.6.19-rc4-mm1/drivers/ata/pata_hpt37x.c	2006-10-31 21:11:29.000000000 +0000
+++ linux-2.6.19-rc4-mm1/drivers/ata/pata_hpt37x.c	2006-11-03 11:26:29.000000000 +0000
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.5"
+#define DRV_VERSION	"0.5.1"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -453,7 +453,13 @@
 {
 	u8 scr2, ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
+	static const struct pci_bits hpt37x_enable_bits[] = {
+		{ 0x50, 1, 0x04, 0x04 },
+		{ 0x54, 1, 0x04, 0x04 }
+	};
+	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
+		return -ENOENT;
+		
 	pci_read_config_byte(pdev, 0x5B, &scr2);
 	pci_write_config_byte(pdev, 0x5B, scr2 & ~0x01);
 	/* Cable register now active */
@@ -488,10 +499,17 @@
 
 static int hpt374_pre_reset(struct ata_port *ap)
 {
+	static const struct pci_bits hpt37x_enable_bits[] = {
+		{ 0x50, 1, 0x04, 0x04 },
+		{ 0x54, 1, 0x04, 0x04 }
+	};
 	u16 mcr3, mcr6;
 	u8 ata66;
-
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
+		return -ENOENT;
+		
 	/* Do the extra channel work */
 	pci_read_config_word(pdev, 0x52, &mcr3);
 	pci_read_config_word(pdev, 0x56, &mcr6);

