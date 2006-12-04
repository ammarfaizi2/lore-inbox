Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937100AbWLDQae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937100AbWLDQae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937102AbWLDQae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:30:34 -0500
Received: from [81.2.110.250] ([81.2.110.250]:41902 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
	id S937100AbWLDQad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:30:33 -0500
Date: Mon, 4 Dec 2006 16:36:05 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_ali: small fixes
Message-ID: <20061204163605.51dc4353@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to pci_get_bus_and_slot because some x86 systems seem to be
handing us a device with dev->bus = NULL. Also don't apply the isa fixup
to revision C6 and later of the chip. 

Really we need to work out wtf is handing us pdev->bus = NULL, but firstly
and more importantly we need the drivers working.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_ali.c linux-2.6.19-rc6-mm1/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_ali.c	2006-11-24 13:58:28.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_ali.c	2006-12-01 21:22:19.000000000 +0000
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.7.1"
+#define DRV_VERSION "0.7.2"
 
 /*
  *	Cable special cases
@@ -530,7 +530,7 @@
 		pci_read_config_byte(pdev, 0x4B, &tmp);
 		pci_write_config_byte(pdev, 0x4B, tmp | 0x08);
 	}
-	north = pci_get_slot(pdev->bus, PCI_DEVFN(0,0));
+	north = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
 	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
 
 	if (north && north->vendor == PCI_VENDOR_ID_AL && isa_bridge) {
@@ -539,7 +539,7 @@
 		pci_read_config_byte(isa_bridge, 0x79, &tmp);
 		if (rev == 0xC2)
 			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x04);
-		else if (rev > 0xC2)
+		else if (rev > 0xC2 && rev < 0xC5)
 			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x02);
 	}
 	if (rev >= 0x20) {
