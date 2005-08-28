Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVH1Uss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVH1Uss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVH1Usq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:48:46 -0400
Received: from havoc.gtf.org ([69.61.125.42]:31130 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750719AbVH1Usp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:48:45 -0400
Date: Sun, 28 Aug 2005 16:48:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jeremy Higdon <jeremy@sgi.com>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sata_vsc: configure DMA bursts explicitly
Message-ID: <20050828204840.GA12790@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've always felt that the comment about "bug in chip related to cacheline
size" was somewhat questionable, since it really seemed like the driver
was obviously not configuring cacheline size and DMA burst length
correctly.

Is there anyone around at SGI, or anywhere else, that could test this?

Any additional info about the "bug" in the chip?

What follows is a COMPLETELY UNTESTED patch that attempts to configure
the chip more correctly.


diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -27,7 +27,16 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_vsc"
-#define DRV_VERSION	"1.0"
+#define DRV_VERSION	"1.1"
+
+enum vsc_pci_cfg_constants {
+	VSC_CFG				= 0x98, /* VSC7174 Configuration */
+	VSC_DMA				= 0xA0, /* DMA control / status */
+
+	VSC_DMA_NO_M			= (1 << 2), /* disable PCI MWI/MRM */
+	VSC_DMA_WCACHE			= (1 << 1), /* wr DMA cacheln align */
+	VSC_DMA_RCACHE			= (1 << 0), /* rd DMA cacheln align */
+};
 
 /* Interrupt register offsets (from chip base address) */
 #define VSC_SATA_INT_STAT_OFFSET	0x00
@@ -255,6 +264,33 @@ static void __devinit vsc_sata_setup_por
 	writel(0, base + VSC_SATA_UP_DATA_BUFFER_OFFSET);
 }
 
+static void vsc_pci_cfg_dma(struct pci_dev *pdev, int mwi)
+{
+	u32 dmacfg, new_dmacfg;
+	u8 clnsz = 0;
+
+	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &clnsz);
+	pci_read_config_dword(pdev, VSC_DMA, &dmacfg);
+
+	/* Set DMA burst length.  Should always be greater than
+	 * clnsz, except when we are at maximum (0x80)
+	 */
+
+	new_dmacfg = dmacfg & 0xffff00f8; /* Mask out DMA BL, low 3 bits */
+	if (clnsz > 0) {
+		if (clnsz >= 0x80)
+			new_dmacfg |= (0x80 << 8);
+		else
+			new_dmacfg |= ((clnsz * 2) << 8);
+		new_dmacfg |= VSC_DMA_WCACHE | VSC_DMA_RCACHE;
+	} else {
+		new_dmacfg |= (0x80 << 8);
+		new_dmacfg |= VSC_DMA_NO_M;	/* Disable PCI MRM/MWI */
+	}
+
+	if (new_dmacfg != dmacfg)
+		pci_write_config_dword(pdev, VSC_DMA, new_dmacfg);
+}
 
 static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -264,6 +300,7 @@ static int __devinit vsc_sata_init_one (
 	int pci_dev_busy = 0;
 	void *mmio_base;
 	int rc;
+	int mwi = 1;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -286,20 +323,24 @@ static int __devinit vsc_sata_init_one (
 		goto err_out;
 	}
 
+	rc = pci_set_mwi(pdev);
+	if (rc)
+		mwi = 0;
+
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
 	 */
 	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
-		goto err_out_regions;
+		goto err_out_mwi;
 	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
-		goto err_out_regions;
+		goto err_out_mwi;
 
 	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
-		goto err_out_regions;
+		goto err_out_mwi;
 	}
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
@@ -313,10 +354,7 @@ static int __devinit vsc_sata_init_one (
 	}
 	base = (unsigned long) mmio_base;
 
-	/*
-	 * Due to a bug in the chip, the default cache line size can't be used
-	 */
-	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
+	vsc_pci_cfg_dma(pdev, mwi);
 
 	probe_ent->sht = &vsc_sata_sht;
 	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
@@ -348,7 +386,7 @@ static int __devinit vsc_sata_init_one (
 	 * DPA mode.  If bit 28 is set, LED 0 reflects all ports' activity.
 	 * If bit 28 is clear, each port has its own LED.
 	 */
-	pci_write_config_dword(pdev, 0x98, 0);
+	pci_write_config_dword(pdev, VSC_CFG, 0);
 
 	/* FIXME: check ata_device_add return value */
 	ata_device_add(probe_ent);
@@ -358,7 +396,12 @@ static int __devinit vsc_sata_init_one (
 
 err_out_free_ent:
 	kfree(probe_ent);
-err_out_regions:
+err_out_mwi:
+	/* FIXME: create a custom PCI ->remove() hook, which calls
+	 * pci_clear_mwi() at ->remove time
+	 */
+	if (mwi)
+		pci_clear_mwi(pdev);
 	pci_release_regions(pdev);
 err_out:
 	if (!pci_dev_busy)
