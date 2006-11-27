Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756644AbWK0QLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644AbWK0QLk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757090AbWK0QLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:11:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23186 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1756644AbWK0QLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:11:37 -0500
Date: Mon, 27 Nov 2006 16:16:35 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [PATCH]: pata_serverworks suspend/resume
Message-ID: <20061127161635.7070ee59@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Serverworks chips need various fixups doing on a resume from RAM.
Conveniently the needed functions were already split out ready for re-use

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_serverworks.c linux-2.6.19-rc6-mm1/drivers/ata/pata_serverworks.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/pata_serverworks.c	2006-11-24 13:58:05.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/pata_serverworks.c	2006-11-24 14:24:59.000000000 +0000
@@ -41,7 +41,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_serverworks"
-#define DRV_VERSION "0.3.7"
+#define DRV_VERSION "0.3.9"
 
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
@@ -326,6 +326,8 @@
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
 };
 
 static struct ata_port_operations serverworks_osb4_port_ops = {
@@ -553,6 +555,30 @@
 	return ata_pci_init_one(pdev, port_info, ports);
 }
 
+static int serverworks_reinit_one(struct pci_dev *pdev)
+{
+	/* Force master latency timer to 64 PCI clocks */
+	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
+	
+	switch (pdev->device)
+	{
+		case PCI_DEVICE_ID_SERVERWORKS_OSB4IDE:
+			serverworks_fixup_osb4(pdev);
+			break;
+		case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
+			ata_pci_clear_simplex(pdev);
+			/* fall through */
+		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE:
+		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2:
+			serverworks_fixup_csb(pdev);
+			break;
+		case PCI_DEVICE_ID_SERVERWORKS_HT1000IDE:
+			serverworks_fixup_ht1000(pdev);
+			break;
+	}
+	return ata_pci_device_resume(pdev);
+}
+
 static const struct pci_device_id serverworks[] = {
 	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
 	{ PCI_VDEVICE(SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE), 2},
@@ -567,7 +593,9 @@
 	.name 		= DRV_NAME,
 	.id_table	= serverworks,
 	.probe 		= serverworks_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+	.suspend	= ata_pci_device_suspend,
+	.resume		= serverworks_reinit_one,
 };
 
 static int __init serverworks_init(void)
