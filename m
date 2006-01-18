Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWARCPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWARCPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWARCPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:15:31 -0500
Received: from havoc.gtf.org ([69.61.125.42]:3553 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751375AbWARCPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:15:30 -0500
Date: Tue, 17 Jan 2006 21:15:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata updates
Message-ID: <20060118021530.GA23108@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/pci/quirks.c        |    5 ++-
 drivers/scsi/ahci.c         |   10 ++++++
 drivers/scsi/ata_piix.c     |    3 +
 drivers/scsi/libata-core.c  |   73 +++++++++++++++++++++++++++++++++++++-------
 drivers/scsi/sata_promise.c |   16 +++++++++
 drivers/scsi/sata_svw.c     |    1 
 include/linux/libata.h      |   11 ++++--
 7 files changed, 105 insertions(+), 14 deletions(-)

Alan Cox:
      libata: Pre UDMA EIDE PIO mode selection
      libata: add a function to decide if we need iordy
      libata: Fix heuristic typos add LBA48PIO flag and support code, add IRQ flag for next diff
      libata: Fix sector lock to apply to both drives not drive 0 twice
      libata: Code for the IRQ mask flag

Jason Gaston:
      ahci: AHCI mode SATA patch for Intel ICH8
      Intel ICH8 SATA: add PCI device IDs

Oliver Weihe:
      [libata] sata_svw: add pci id

Yusuf Iskenderoglu:
      [libata] sata_promise: add pci id

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 605f0df..dda6099 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1142,6 +1142,9 @@ static void __devinit quirk_intel_ide_co
 	case 0x27c4:
 		ich = 7;
 		break;
+	case 0x2828:	/* ICH8M */
+		ich = 8;
+		break;
 	default:
 		/* we do not handle this PCI device */
 		return;
@@ -1161,7 +1164,7 @@ static void __devinit quirk_intel_ide_co
 		else
 			return;			/* not in combined mode */
 	} else {
-		WARN_ON((ich != 6) && (ich != 7));
+		WARN_ON((ich != 6) && (ich != 7) && (ich != 8));
 		tmp &= 0x3;  /* interesting bits 1:0 */
 		if (tmp & (1 << 0))
 			comb = (1 << 2);	/* PATA port 0, SATA port 1 */
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index d113290..19bd346 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -276,6 +276,16 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* ESB2 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7-M DH */
+	{ PCI_VENDOR_ID_INTEL, 0x2821, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8 */
+	{ PCI_VENDOR_ID_INTEL, 0x2822, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8 */
+	{ PCI_VENDOR_ID_INTEL, 0x2824, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8 */
+	{ PCI_VENDOR_ID_INTEL, 0x2829, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8M */
+	{ PCI_VENDOR_ID_INTEL, 0x282a, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH8M */
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 557788e..fc3ca05 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -157,6 +157,9 @@ static const struct pci_device_id piix_p
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
+	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 
 	{ }	/* terminate list */
 };
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 99bae83..46c4cdb 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -611,6 +611,10 @@ int ata_rwcmd_protocol(struct ata_queued
 	if (dev->flags & ATA_DFLAG_PIO) {
 		tf->protocol = ATA_PROT_PIO;
 		index = dev->multi_count ? 0 : 8;
+	} else if (lba48 && (qc->ap->flags & ATA_FLAG_PIO_LBA48)) {
+		/* Unable to use DMA due to host limitation */
+		tf->protocol = ATA_PROT_PIO;
+		index = dev->multi_count ? 0 : 4;
 	} else {
 		tf->protocol = ATA_PROT_DMA;
 		index = 16;
@@ -1051,18 +1055,22 @@ static unsigned int ata_pio_modes(const 
 {
 	u16 modes;
 
-	/* Usual case. Word 53 indicates word 88 is valid */
-	if (adev->id[ATA_ID_FIELD_VALID] & (1 << 2)) {
+	/* Usual case. Word 53 indicates word 64 is valid */
+	if (adev->id[ATA_ID_FIELD_VALID] & (1 << 1)) {
 		modes = adev->id[ATA_ID_PIO_MODES] & 0x03;
 		modes <<= 3;
 		modes |= 0x7;
 		return modes;
 	}
 
-	/* If word 88 isn't valid then Word 51 holds the PIO timing number
-	   for the maximum. Turn it into a mask and return it */
-	modes = (2 << (adev->id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
+	/* If word 64 isn't valid then Word 51 high byte holds the PIO timing
+	   number for the maximum. Turn it into a mask and return it */
+	modes = (2 << ((adev->id[ATA_ID_OLD_PIO_MODES] >> 8) & 0xFF)) - 1 ;
 	return modes;
+	/* But wait.. there's more. Design your standards by committee and
+	   you too can get a free iordy field to process. However its the 
+	   speeds not the modes that are supported... Note drivers using the
+	   timing API will get this right anyway */
 }
 
 struct ata_exec_internal_arg {
@@ -1165,6 +1173,39 @@ ata_exec_internal(struct ata_port *ap, s
 }
 
 /**
+ *	ata_pio_need_iordy	-	check if iordy needed
+ *	@adev: ATA device
+ *
+ *	Check if the current speed of the device requires IORDY. Used
+ *	by various controllers for chip configuration.
+ */
+
+unsigned int ata_pio_need_iordy(const struct ata_device *adev)
+{
+	int pio;
+	int speed = adev->pio_mode - XFER_PIO_0;
+
+	if (speed < 2)
+		return 0;
+	if (speed > 2)
+		return 1;
+		
+	/* If we have no drive specific rule, then PIO 2 is non IORDY */
+
+	if (adev->id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE */
+		pio = adev->id[ATA_ID_EIDE_PIO];
+		/* Is the speed faster than the drive allows non IORDY ? */
+		if (pio) {
+			/* This is cycle times not frequency - watch the logic! */
+			if (pio > 240)	/* PIO2 is 240nS per cycle */
+				return 1;
+			return 0;
+		}
+	}
+	return 0;
+}
+
+/**
  *	ata_dev_identify - obtain IDENTIFY x DEVICE page
  *	@ap: port on which device we wish to probe resides
  *	@device: device bus address, starting at zero
@@ -1415,7 +1456,7 @@ void ata_dev_config(struct ata_port *ap,
 		ap->udma_mask &= ATA_UDMA5;
 		ap->host->max_sectors = ATA_MAX_SECTORS;
 		ap->host->hostt->max_sectors = ATA_MAX_SECTORS;
-		ap->device->flags |= ATA_DFLAG_LOCK_SECTORS;
+		ap->device[i].flags |= ATA_DFLAG_LOCK_SECTORS;
 	}
 
 	if (ap->ops->dev_config)
@@ -3056,10 +3097,21 @@ static void ata_pio_data_xfer(struct ata
 static void ata_data_xfer(struct ata_port *ap, unsigned char *buf,
 			  unsigned int buflen, int do_write)
 {
-	if (ap->flags & ATA_FLAG_MMIO)
-		ata_mmio_data_xfer(ap, buf, buflen, do_write);
-	else
-		ata_pio_data_xfer(ap, buf, buflen, do_write);
+	/* Make the crap hardware pay the costs not the good stuff */
+	if (unlikely(ap->flags & ATA_FLAG_IRQ_MASK)) {
+		unsigned long flags;
+		local_irq_save(flags);
+		if (ap->flags & ATA_FLAG_MMIO)
+			ata_mmio_data_xfer(ap, buf, buflen, do_write);
+		else
+			ata_pio_data_xfer(ap, buf, buflen, do_write);
+		local_irq_restore(flags);
+	} else {
+		if (ap->flags & ATA_FLAG_MMIO)
+			ata_mmio_data_xfer(ap, buf, buflen, do_write);
+		else
+			ata_pio_data_xfer(ap, buf, buflen, do_write);
+	}
 }
 
 /**
@@ -5122,6 +5174,7 @@ EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
+EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
 EXPORT_SYMBOL_GPL(ata_timing_merge);
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 3d1ea09..b0b0a69 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -66,6 +66,7 @@ enum {
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
 	board_20619		= 2,	/* FastTrak TX4000 */
+	board_20771		= 3,	/* FastTrak TX2300 */
 
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
 
@@ -190,6 +191,16 @@ static const struct ata_port_info pdc_po
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_pata_ops,
 	},
+
+	/* board_20771 */
+	{
+		.sht		= &pdc_ata_sht,
+		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_sata_ops,
+	},
 };
 
 static const struct pci_device_id pdc_ata_pci_tbl[] = {
@@ -226,6 +237,8 @@ static const struct pci_device_id pdc_at
 	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20619 },
 
+	{ PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20771 },
 	{ }	/* terminate list */
 };
 
@@ -706,6 +719,9 @@ static int pdc_ata_init_one (struct pci_
 	case board_2037x:
 		probe_ent->n_ports = 2;
 		break;
+	case board_20771:
+		probe_ent->n_ports = 2;
+		break;
 	case board_20619:
 		probe_ent->n_ports = 4;
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 6683735..d847256 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -470,6 +470,7 @@ static const struct pci_device_id k2_sat
 	{ 0x1166, 0x0241, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
 	{ 0x1166, 0x0242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8 },
 	{ 0x1166, 0x024a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
+	{ 0x1166, 0x024b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
 	{ }
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a43c95f..9e5db29 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -126,16 +126,19 @@ enum {
 
 	ATA_FLAG_SUSPENDED	= (1 << 12), /* port is suspended */
 
+	ATA_FLAG_PIO_LBA48	= (1 << 13), /* Host DMA engine is LBA28 only */
+	ATA_FLAG_IRQ_MASK	= (1 << 14), /* Mask IRQ in PIO xfers */
+
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 
 	/* various lengths of time */
-	ATA_TMOUT_EDD		= 5 * HZ,	/* hueristic */
+	ATA_TMOUT_EDD		= 5 * HZ,	/* heuristic */
 	ATA_TMOUT_PIO		= 30 * HZ,
-	ATA_TMOUT_BOOT		= 30 * HZ,	/* hueristic */
-	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* hueristic */
+	ATA_TMOUT_BOOT		= 30 * HZ,	/* heuristic */
+	ATA_TMOUT_BOOT_QUICK	= 7 * HZ,	/* heuristic */
 	ATA_TMOUT_CDB		= 30 * HZ,
 	ATA_TMOUT_CDB_QUICK	= 5 * HZ,
 	ATA_TMOUT_INTERNAL	= 30 * HZ,
@@ -499,6 +502,8 @@ extern int ata_scsi_slave_config(struct 
 /*
  * Timing helpers
  */
+
+extern unsigned int ata_pio_need_iordy(const struct ata_device *);
 extern int ata_timing_compute(struct ata_device *, unsigned short,
 			      struct ata_timing *, int, int);
 extern void ata_timing_merge(const struct ata_timing *,
