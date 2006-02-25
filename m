Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWBYWDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWBYWDk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWBYWDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:03:40 -0500
Received: from havoc.gtf.org ([69.61.125.42]:61647 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750948AbWBYWDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:03:39 -0500
Date: Sat, 25 Feb 2006 17:03:38 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20060225220338.GA27217@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/sata_sil.c |   52 +++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 43 insertions(+), 9 deletions(-)

Tejun Heo:
      sata_sil: add board ID for 3512
      sata_sil: implement R_ERR on DMA activate FIS errata fix

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 17f74d3..9face3c 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -49,11 +49,13 @@
 #define DRV_VERSION	"0.9"
 
 enum {
+	SIL_FLAG_RERR_ON_DMA_ACT = (1 << 29),
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
 	sil_3112		= 0,
 	sil_3112_m15w		= 1,
-	sil_3114		= 2,
+	sil_3512		= 2,
+	sil_3114		= 3,
 
 	SIL_FIFO_R0		= 0x40,
 	SIL_FIFO_W0		= 0x41,
@@ -90,7 +92,7 @@ static void sil_post_set_mode (struct at
 static const struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
-	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
@@ -185,7 +187,8 @@ static const struct ata_port_info sil_po
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
-	}, /* sil_3112_15w - keep it sync'd w/ sil_3112 */
+	},
+	/* sil_3112_15w - keep it sync'd w/ sil_3112 */
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
@@ -195,11 +198,24 @@ static const struct ata_port_info sil_po
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
-	}, /* sil_3114 */
+	},
+	/* sil_3512 */
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  SIL_FLAG_RERR_ON_DMA_ACT,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil_ops,
+	},
+	/* sil_3114 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  SIL_FLAG_RERR_ON_DMA_ACT,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
@@ -216,12 +232,13 @@ static const struct {
 	unsigned long scr;	/* SATA control register block */
 	unsigned long sien;	/* SATA Interrupt Enable register */
 	unsigned long xfer_mode;/* data transfer mode register */
+	unsigned long sfis_cfg;	/* SATA FIS reception config register */
 } sil_port[] = {
 	/* port 0 ... */
-	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4 },
-	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4 },
-	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4 },
-	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4 },
+	{ 0x80, 0x8A, 0x00, 0x100, 0x148, 0xb4, 0x14c },
+	{ 0xC0, 0xCA, 0x08, 0x180, 0x1c8, 0xf4, 0x1cc },
+	{ 0x280, 0x28A, 0x200, 0x300, 0x348, 0x2b4, 0x34c },
+	{ 0x2C0, 0x2CA, 0x208, 0x380, 0x3c8, 0x2f4, 0x3cc },
 	/* ... port 3 */
 };
 
@@ -471,6 +488,23 @@ static int sil_init_one (struct pci_dev 
 		dev_printk(KERN_WARNING, &pdev->dev,
 			 "cache line size not set.  Driver may not function\n");
 
+	/* Apply R_ERR on DMA activate FIS errata workaround */
+	if (probe_ent->host_flags & SIL_FLAG_RERR_ON_DMA_ACT) {
+		int cnt;
+
+		for (i = 0, cnt = 0; i < probe_ent->n_ports; i++) {
+			tmp = readl(mmio_base + sil_port[i].sfis_cfg);
+			if ((tmp & 0x3) != 0x01)
+				continue;
+			if (!cnt)
+				dev_printk(KERN_INFO, &pdev->dev,
+					   "Applying R_ERR on DMA activate "
+					   "FIS errata fix\n");
+			writel(tmp & ~0x3, mmio_base + sil_port[i].sfis_cfg);
+			cnt++;
+		}
+	}
+
 	if (ent->driver_data == sil_3114) {
 		irq_mask = SIL_MASK_4PORT;
 
