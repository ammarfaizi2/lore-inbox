Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWC0Rfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWC0Rfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWC0Rfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:35:47 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23455 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750804AbWC0Rfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:35:47 -0500
Subject: PATCH: libata. BMDMA handling updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 18:42:40 +0100
Message-Id: <1143481360.4970.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the minimal patch set to enable the current code to be used with
a controller following SFF (ie any PATA and early SATA controllers)
safely without crashes if there is no BMDMA area or if BMDMA is not
assigned by the BIOS for some reason.

Simplex status is recorded but not acted upon in this change, this isn't
a problem with the current drivers as none of them are for simplex
hardware. A following diff will deal with that.

The flags in the probe structure remain ->host_set_flags although Jeff
asked me to rename them, simply because the rename would break the usual
Linux rules that old code should break when there are changes. not
compile and run and then blow up/eat your computer/etc. Renaming this
later is a trivial exercise once a better name is chosen.

Alan

diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 95d81d8..835dff0 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -703,6 +703,7 @@ ata_pci_init_native_mode(struct pci_dev 
 	struct ata_probe_ent *probe_ent =
 		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	int p = 0;
+	unsigned long bmdma;
 
 	if (!probe_ent)
 		return NULL;
@@ -716,7 +717,12 @@ ata_pci_init_native_mode(struct pci_dev 
 		probe_ent->port[p].altstatus_addr =
 		probe_ent->port[p].ctl_addr =
 			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
-		probe_ent->port[p].bmdma_addr = pci_resource_start(pdev, 4);
+		bmdma = pci_resource_start(pdev, 4);
+		if (bmdma) {
+			if (inb(bmdma + 2) & 0x80)
+				probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+			probe_ent->port[p].bmdma_addr = bmdma;
+		}
 		ata_std_ports(&probe_ent->port[p]);
 		p++;
 	}
@@ -726,7 +732,13 @@ ata_pci_init_native_mode(struct pci_dev 
 		probe_ent->port[p].altstatus_addr =
 		probe_ent->port[p].ctl_addr =
 			pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
-		probe_ent->port[p].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+		bmdma = pci_resource_start(pdev, 4);
+		if (bmdma) {
+			bmdma += 8;
+			if(inb(bmdma + 2) & 0x80)
+			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+			probe_ent->port[p].bmdma_addr = bmdma;
+		}
 		ata_std_ports(&probe_ent->port[p]);
 		p++;
 	}
@@ -740,6 +752,7 @@ static struct ata_probe_ent *ata_pci_ini
 				struct ata_port_info *port, int port_num)
 {
 	struct ata_probe_ent *probe_ent;
+	unsigned long bmdma;
 
 	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port);
 	if (!probe_ent)
@@ -766,8 +779,13 @@ static struct ata_probe_ent *ata_pci_ini
 			break;
 	}
 
-	probe_ent->port[0].bmdma_addr =
-		pci_resource_start(pdev, 4) + 8 * port_num;
+	bmdma = pci_resource_start(pdev, 4);
+	if (bmdma != 0) {
+		bmdma += 8 * port_num;
+		probe_ent->port[0].bmdma_addr = bmdma;
+		if (inb(bmdma + 2) & 0x80)
+			probe_ent->host_set_flags |= ATA_HOST_SIMPLEX;
+	}
 	ata_std_ports(&probe_ent->port[0]);
 
 	return probe_ent;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9fcc061..26e0351 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -160,6 +161,9 @@ enum {
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 	ATA_QCFLAG_EH_SCHEDULED = (1 << 5), /* EH scheduled */
 
+	/* host set flags */
+	ATA_HOST_SIMPLEX	= (1 << 0),	/* Host is simplex, one DMA channel per host_set only */
+	
 	/* various lengths of time */
 	ATA_TMOUT_PIO		= 30 * HZ,
 	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
@@ -278,6 +282,7 @@ struct ata_probe_ent {
 	unsigned long		irq;
 	unsigned int		irq_flags;
 	unsigned long		host_flags;
+	unsigned long		host_set_flags;
 	void __iomem		*mmio_base;
 	void			*private_data;
 };

