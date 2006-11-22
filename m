Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756004AbWKVRTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004AbWKVRTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756000AbWKVRTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:19:35 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30111 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1755994AbWKVRTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:19:35 -0500
Date: Wed, 22 Nov 2006 17:18:30 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_jmicron: fix JMB368 support, add suspend/resume
 handling
Message-ID: <20061122171830.4a3d48a7@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This (and the pci resume quirk code) get the JMicron controllers to
resume properly. Without this patch the drive mapping changes when you
suspend/resume which is not good at all....

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_jmicron.c linux-2.6.19-rc5-mm2/drivers/ata/pata_jmicron.c
--- linux.vanilla-2.6.19-rc5-mm2/drivers/ata/pata_jmicron.c	2006-11-15 13:26:00.000000000 +0000
+++ linux-2.6.19-rc5-mm2/drivers/ata/pata_jmicron.c	2006-11-22 14:44:15.350180064 +0000
@@ -19,7 +19,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_jmicron"
-#define DRV_VERSION	"0.1.2"
+#define DRV_VERSION	"0.1.4"
 
 typedef enum {
 	PORT_PATA0 = 0,
@@ -212,12 +212,11 @@
 
 		/* FIXME: We may want a way to override this in future */
 		pci_write_config_byte(pdev, 0x41, 0xa1);
-	}
-
-	/* PATA controller is fn 1, AHCI is fn 0 */
-	if (PCI_FUNC(pdev->devfn) != 1)
-		return -ENODEV;
 
+		/* PATA controller is fn 1, AHCI is fn 0 */
+		if (PCI_FUNC(pdev->devfn) != 1)
+			return -ENODEV;
+	}
 	if ( id->driver_data == 365 || id->driver_data == 366) {
 		/* The 365/66 have two PATA channels, redirect the second */
 		pci_read_config_dword(pdev, 0x80, &reg);
@@ -228,6 +227,27 @@
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
+static int jmicron_reinit_one(struct pci_dev *pdev)
+{
+	u32 reg;
+	
+	switch(pdev->device) {
+		case PCI_DEVICE_ID_JMICRON_JMB368:
+			break;
+		case PCI_DEVICE_ID_JMICRON_JMB365:
+		case PCI_DEVICE_ID_JMICRON_JMB366:
+			/* Restore mapping or disks swap and boy does it get ugly */
+			pci_read_config_dword(pdev, 0x80, &reg);
+			reg |= (1 << 24);	/* IDE1 to PATA IDE secondary */
+			pci_write_config_dword(pdev, 0x80, reg);
+			/* Fall through */
+		default:
+			/* Make sure AHCI is turned back on */
+			pci_write_config_byte(pdev, 0x41, 0xa1);
+	}
+	return ata_pci_device_resume(pdev);
+}
+
 static const struct pci_device_id jmicron_pci_tbl[] = {
 	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 361},
 	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 363},
@@ -243,6 +263,8 @@
 	.id_table		= jmicron_pci_tbl,
 	.probe			= jmicron_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= jmicron_reinit_one,
 };
 
 static int __init jmicron_init(void)

