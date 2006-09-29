Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWI2A1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWI2A1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWI2A1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:27:30 -0400
Received: from havoc.gtf.org ([69.61.125.42]:31623 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161214AbWI2A10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:27:26 -0400
Date: Thu, 28 Sep 2006 20:27:25 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/5] libata: minor PCI IDE probe fixes and cleanups
Message-ID: <20060929002725.GB7458@havoc.gtf.org>
References: <20060929002601.GA7397@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929002601.GA7397@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


commit c791c30670ea61f19eec390124128bf278e854fe
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Sep 28 03:40:11 2006 -0400

    [libata] minor PCI IDE probe fixes and cleanups

    * Replace needless 'n_ports > 2' check with a simple BUG_ON().
      No existing driver ever wants more than 2 ports.

    * Delete ATA_FLAG_NO_LEGACY check.  No current driver uses
      ata_pci_init_one(), that sets this flag.

    * Move PCI_CLASS_PROG register read below pci_enable_device()

    * Handle ata_device_add() failure

    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/ata/libata-sff.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

c791c30670ea61f19eec390124128bf278e854fe
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 08b3a40..a620e23 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -946,35 +946,21 @@ int ata_pci_init_one (struct pci_dev *pd
 {
 	struct ata_probe_ent *probe_ent = NULL;
 	struct ata_port_info *port[2];
-	u8 tmp8, mask;
+	u8 mask;
 	unsigned int legacy_mode = 0;
 	int disable_dev_on_err = 1;
 	int rc;
 
 	DPRINTK("ENTER\n");
 
+	BUG_ON(n_ports < 1 || n_ports > 2);
+
 	port[0] = port_info[0];
 	if (n_ports > 1)
 		port[1] = port_info[1];
 	else
 		port[1] = port[0];
 
-	if ((port[0]->flags & ATA_FLAG_NO_LEGACY) == 0
-	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
-		/* TODO: What if one channel is in native mode ... */
-		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-		mask = (1 << 2) | (1 << 0);
-		if ((tmp8 & mask) != mask)
-			legacy_mode = (1 << 3);
-	}
-
-	/* FIXME... */
-	if ((!legacy_mode) && (n_ports > 2)) {
-		printk(KERN_ERR "ata: BUG: native mode, n_ports > 2\n");
-		n_ports = 2;
-		/* For now */
-	}
-
 	/* FIXME: Really for ATA it isn't safe because the device may be
 	   multi-purpose and we want to leave it alone if it was already
 	   enabled. Secondly for shared use as Arjan says we want refcounting
@@ -987,6 +973,16 @@ int ata_pci_init_one (struct pci_dev *pd
 	if (rc)
 		return rc;
 
+	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
+		u8 tmp8;
+
+		/* TODO: What if one channel is in native mode ... */
+		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
+		mask = (1 << 2) | (1 << 0);
+		if ((tmp8 & mask) != mask)
+			legacy_mode = (1 << 3);
+	}
+
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
 		disable_dev_on_err = 0;
@@ -1039,7 +1035,7 @@ int ata_pci_init_one (struct pci_dev *pd
 		goto err_out_regions;
 	}
 
-	/* FIXME: If we get no DMA mask we should fall back to PIO */
+	/* TODO: If we get no DMA mask we should fall back to PIO */
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
 		goto err_out_regions;
@@ -1062,13 +1058,17 @@ int ata_pci_init_one (struct pci_dev *pd
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return */
-	ata_device_add(probe_ent);
+	if (!ata_device_add(probe_ent)) {
+		rc = -ENODEV;
+		goto err_out_ent;
+	}
 
 	kfree(probe_ent);
 
 	return 0;
 
+err_out_ent:
+	kfree(probe_ent);
 err_out_regions:
 	if (legacy_mode & ATA_PORT_PRIMARY)
 		release_region(ATA_PRIMARY_CMD, 8);
