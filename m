Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUAFJdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 04:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUAFJdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 04:33:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25770 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261774AbUAFJdL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 04:33:11 -0500
Message-ID: <3FFA80BE.2040205@pobox.com>
Date: Tue, 06 Jan 2004 04:32:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Mickael Marchand <marchand@kde.org>, "B. Gajdos" <brian@chem.sk>,
       linux-ide@vger.kernel.org
Subject: [PATCH] libata update
References: <200401041413.20573.marchand@kde.org>
In-Reply-To: <200401041413.20573.marchand@kde.org>
Content-Type: multipart/mixed;
 boundary="------------080708040906000101080208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080708040906000101080208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Ok, here is the latest libata, just a few Silicon Image updates (mainly 
thanks for Mikael).

Patch:
(attachment #2)

Changelog:
(attachment #1)

BK repo:
bk://gkernel.bkbits.net/libata-2.5



--------------080708040906000101080208
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

ChangeSet@1.1571, 2004-01-06 04:26:01-05:00, marchand@kde.org
  [libata sata_sil] add support for adaptec 1210sa, 4-port sii 3114

ChangeSet@1.1570, 2004-01-06 04:22:09-05:00, jgarzik@redhat.com
  [libata sata_svr] fix DRV_NAME to reflect actual driver filename

ChangeSet@1.1534.6.1, 2003-12-30 19:46:09-05:00, jgarzik@redhat.com
  [libata sata_sil] unmask interrupts during initialization
  
  Prudent in general, and needed for Adaptec BIOSes.


--------------080708040906000101080208
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	Tue Jan  6 04:29:01 2004
+++ b/drivers/scsi/sata_sil.c	Tue Jan  6 04:29:01 2004
@@ -34,11 +34,16 @@
 #include "hosts.h"
 #include <linux/libata.h>
 
-#define DRV_NAME	"ata_sil"
-#define DRV_VERSION	"0.51"
+#define DRV_NAME	"sata_sil"
+#define DRV_VERSION	"0.52"
 
 enum {
 	sil_3112		= 0,
+	sil_3114		= 1,
+
+	SIL_SYSCFG		= 0x48,
+	SIL_MASK_IDE0_INT	= (1 << 22),
+	SIL_MASK_IDE1_INT	= (1 << 23),
 
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
@@ -49,6 +54,16 @@
 	SIL_IDE1_CTL		= 0xCA,
 	SIL_IDE1_BMDMA		= 0x08,
 	SIL_IDE1_SCR		= 0x180,
+
+	SIL_IDE2_TF		= 0x280,
+	SIL_IDE2_CTL		= 0x28A,
+	SIL_IDE2_BMDMA		= 0x200,
+	SIL_IDE2_SCR		= 0x300,
+
+	SIL_IDE3_TF		= 0x2C0,
+	SIL_IDE3_CTL		= 0x2CA,
+	SIL_IDE3_BMDMA		= 0x208,
+	SIL_IDE3_SCR		= 0x380,
 };
 
 static void sil_set_piomode (struct ata_port *ap, struct ata_device *adev,
@@ -62,6 +77,8 @@
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ }	/* terminate list */
 };
 
@@ -120,6 +137,14 @@
 		.pio_mask	= 0x03,			/* pio3-4 */
 		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
 		.port_ops	= &sil_ops,
+	}, /* sil_3114 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x03,			/* pio3-4 */
+		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
+		.port_ops	= &sil_ops,
 	},
 };
 
@@ -236,6 +261,7 @@
 	unsigned long base;
 	void *mmio_base;
 	int rc;
+	u32 tmp;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -267,7 +293,7 @@
 	probe_ent->pdev = pdev;
 	probe_ent->port_ops = sil_port_info[ent->driver_data].port_ops;
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
-	probe_ent->n_ports = 2;
+	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
 	probe_ent->pio_mask = sil_port_info[ent->driver_data].pio_mask;
 	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
        	probe_ent->irq = pdev->irq;
@@ -295,6 +321,28 @@
 	probe_ent->port[1].bmdma_addr = base + SIL_IDE1_BMDMA;
 	probe_ent->port[1].scr_addr = base + SIL_IDE1_SCR;
 	ata_std_ports(&probe_ent->port[1]);
+
+	/* make sure IDE0/1 interrupts are not masked */
+	tmp = readl(mmio_base + SIL_SYSCFG);
+	if (tmp & (SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT)) {
+		tmp &= ~(SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT);
+		writel(tmp, mmio_base + SIL_SYSCFG);
+		readl(mmio_base + SIL_SYSCFG);	/* flush */
+	}
+
+	if (ent->driver_data == sil_3114) {
+		probe_ent->port[2].cmd_addr = base + SIL_IDE2_TF;
+		probe_ent->port[2].ctl_addr = base + SIL_IDE2_CTL;
+		probe_ent->port[2].bmdma_addr = base + SIL_IDE2_BMDMA;
+		probe_ent->port[2].scr_addr = base + SIL_IDE2_SCR;
+		ata_std_ports(&probe_ent->port[2]);
+
+		probe_ent->port[3].cmd_addr = base + SIL_IDE3_TF;
+		probe_ent->port[3].ctl_addr = base + SIL_IDE3_CTL;
+		probe_ent->port[3].bmdma_addr = base + SIL_IDE3_BMDMA;
+		probe_ent->port[3].scr_addr = base + SIL_IDE3_SCR;
+		ata_std_ports(&probe_ent->port[3]);
+	}
 
 	pci_set_master(pdev);
 
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	Tue Jan  6 04:29:01 2004
+++ b/drivers/scsi/sata_svw.c	Tue Jan  6 04:29:01 2004
@@ -43,7 +43,7 @@
 #include <asm/pci-bridge.h>
 #endif /* CONFIG_ALL_PPC */
 
-#define DRV_NAME	"ata_k2"
+#define DRV_NAME	"sata_svw"
 #define DRV_VERSION	"1.03"
 
 

--------------080708040906000101080208--

