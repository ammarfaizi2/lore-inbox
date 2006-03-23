Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWCWBQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWCWBQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWCWBQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:16:06 -0500
Received: from havoc.gtf.org ([69.61.125.42]:31625 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932193AbWCWBQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:16:03 -0500
Date: Wed, 22 Mar 2006 20:15:57 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata updates
Message-ID: <20060323011557.GA16563@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/Kconfig        |    4 -
 drivers/scsi/ahci.c         |  135 +++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-bmdma.c |   39 ++++++++++++
 drivers/scsi/libata-core.c  |  142 +++++++++++++++++++++++++++-----------------
 drivers/scsi/libata-scsi.c  |  138 ++++++++++++++++++++++++++----------------
 drivers/scsi/pdc_adma.c     |    2 
 drivers/scsi/sata_mv.c      |    5 +
 drivers/scsi/sata_svw.c     |   54 ++++++++--------
 drivers/scsi/sata_vsc.c     |  122 ++++++++++++++++++++-----------------
 include/linux/ata.h         |    7 +-
 include/linux/libata.h      |    4 -
 11 files changed, 459 insertions(+), 193 deletions(-)

Alan Cox:
      libata: Add the useful macros/constants needed for merging PATA stuff
      libata: pick a less confusion "um dunno" error
      libata: make code actually compile with debugging on
      libata: Note weakness in our PCI handling that one day wants fixing
      libata: two new PCI helpers
      libata: report which drive is causing mode problems
      libata: make irqtrap mode compile
      libata: note missing posting in mmio cmd write
      libata: Fix a drive detection problem
      Update libata DMA blacklist to cover versions, and resync with IDE layer
      libata: Symbol exports

Albert Lee:
      libata-dev: add flush task to ata_exec_internal()
      libata-dev: Remove ATA_PROT_PIO_MULT

Brian King:
      libata: Add some dummy noop functions
      libata: ata_scsi_slave_config cleanup

Dan Williams:
      [libata] sata_vsc: fix inconsistent NULL checking

Jeff Garzik:
      [libata] SCSI VPD page 0x83 fixes
      [libata] add prototypes for helpers
      [libata] fix oops on non-DMA bmdma hardware
      [libata sata_vsc, sata_svw] Convert #define'd constants to enums

Mark Lord:
      [libata] sata_mv: off-by-1 fix

Tejun Heo:
      libata: do not ignore PIO-only devices
      ahci: add softreset

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 5c94a5d..4035920 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -595,10 +595,10 @@ config SCSI_SATA_VIA
 	  If unsure, say N.
 
 config SCSI_SATA_VITESSE
-	tristate "VITESSE VSC-7174 SATA support"
+	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
 	depends on SCSI_SATA && PCI
 	help
-	  This option enables support for Vitesse VSC7174 Serial ATA.
+	  This option enables support for Vitesse VSC7174 and Intel 31244 Serial ATA.
 
 	  If unsure, say N.
 
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a1ddbba..ffba656 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -513,6 +513,138 @@ static void ahci_fill_cmd_slot(struct ah
 	pp->cmd_slot[0].tbl_addr_hi = cpu_to_le32((pp->cmd_tbl_dma >> 16) >> 16);
 }
 
+static int ahci_poll_register(void __iomem *reg, u32 mask, u32 val,
+			      unsigned long interval_msec,
+			      unsigned long timeout_msec)
+{
+	unsigned long timeout;
+	u32 tmp;
+
+	timeout = jiffies + (timeout_msec * HZ) / 1000;
+	do {
+		tmp = readl(reg);
+		if ((tmp & mask) == val)
+			return 0;
+		msleep(interval_msec);
+	} while (time_before(jiffies, timeout));
+
+	return -1;
+}
+
+static int ahci_softreset(struct ata_port *ap, int verbose, unsigned int *class)
+{
+	struct ahci_host_priv *hpriv = ap->host_set->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	const u32 cmd_fis_len = 5; /* five dwords */
+	const char *reason = NULL;
+	struct ata_taskfile tf;
+	u8 *fis;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* prepare for SRST (AHCI-1.1 10.4.1) */
+	rc = ahci_stop_engine(ap);
+	if (rc) {
+		reason = "failed to stop engine";
+		goto fail_restart;
+	}
+
+	/* check BUSY/DRQ, perform Command List Override if necessary */
+	ahci_tf_read(ap, &tf);
+	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
+		u32 tmp;
+
+		if (!(hpriv->cap & HOST_CAP_CLO)) {
+			rc = -EIO;
+			reason = "port busy but no CLO";
+			goto fail_restart;
+		}
+
+		tmp = readl(port_mmio + PORT_CMD);
+		tmp |= PORT_CMD_CLO;
+		writel(tmp, port_mmio + PORT_CMD);
+		readl(port_mmio + PORT_CMD); /* flush */
+
+		if (ahci_poll_register(port_mmio + PORT_CMD, PORT_CMD_CLO, 0x0,
+				       1, 500)) {
+			rc = -EIO;
+			reason = "CLO failed";
+			goto fail_restart;
+		}
+	}
+
+	/* restart engine */
+	ahci_start_engine(ap);
+
+	ata_tf_init(ap, &tf, 0);
+	fis = pp->cmd_tbl;
+
+	/* issue the first D2H Register FIS */
+	ahci_fill_cmd_slot(pp, cmd_fis_len | AHCI_CMD_RESET | AHCI_CMD_CLR_BUSY);
+
+	tf.ctl |= ATA_SRST;
+	ata_tf_to_fis(&tf, fis, 0);
+	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	if (ahci_poll_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x0, 1, 500)) {
+		rc = -EIO;
+		reason = "1st FIS failed";
+		goto fail;
+	}
+
+	/* spec says at least 5us, but be generous and sleep for 1ms */
+	msleep(1);
+
+	/* issue the second D2H Register FIS */
+	ahci_fill_cmd_slot(pp, cmd_fis_len);
+
+	tf.ctl &= ~ATA_SRST;
+	ata_tf_to_fis(&tf, fis, 0);
+	fis[1] &= ~(1 << 7);	/* turn off Command FIS bit */
+
+	writel(1, port_mmio + PORT_CMD_ISSUE);
+	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
+
+	/* spec mandates ">= 2ms" before checking status.
+	 * We wait 150ms, because that was the magic delay used for
+	 * ATAPI devices in Hale Landis's ATADRVR, for the period of time
+	 * between when the ATA command register is written, and then
+	 * status is checked.  Because waiting for "a while" before
+	 * checking status is fine, post SRST, we perform this magic
+	 * delay here as well.
+	 */
+	msleep(150);
+
+	*class = ATA_DEV_NONE;
+	if (sata_dev_present(ap)) {
+		if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+			rc = -EIO;
+			reason = "device not ready";
+			goto fail;
+		}
+		*class = ahci_dev_classify(ap);
+	}
+
+	DPRINTK("EXIT, class=%u\n", *class);
+	return 0;
+
+ fail_restart:
+	ahci_start_engine(ap);
+ fail:
+	if (verbose)
+		printk(KERN_ERR "ata%u: softreset failed (%s)\n",
+		       ap->id, reason);
+	else
+		DPRINTK("EXIT, rc=%d reason=\"%s\"\n", rc, reason);
+	return rc;
+}
+
 static int ahci_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
 {
 	int rc;
@@ -553,7 +685,8 @@ static void ahci_postreset(struct ata_po
 
 static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
 {
-	return ata_drive_probe_reset(ap, NULL, NULL, ahci_hardreset,
+	return ata_drive_probe_reset(ap, ata_std_probeinit,
+				     ahci_softreset, ahci_hardreset,
 				     ahci_postreset, classes);
 }
 
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index a93336a..96b4d21 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -214,6 +214,8 @@ static void ata_exec_command_pio(struct 
  *	Issues MMIO write to ATA command register, with proper
  *	synchronization with interrupt handler / other threads.
  *
+ *	FIXME: missing write posting for 400nS delay enforcement
+ *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
@@ -648,6 +650,7 @@ int ata_pci_init_one (struct pci_dev *pd
 		goto err_out_regions;
 	}
 
+	/* FIXME: If we get no DMA mask we should fall back to PIO */
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
 		goto err_out_regions;
@@ -699,5 +702,41 @@ err_out:
 	return rc;
 }
 
+/**
+ *	ata_pci_clear_simplex	-	attempt to kick device out of simplex
+ *	@pdev: PCI device
+ *
+ *	Some PCI ATA devices report simplex mode but in fact can be told to
+ *	enter non simplex mode. This implements the neccessary logic to 
+ *	perform the task on such devices. Calling it on other devices will
+ *	have -undefined- behaviour.
+ */
+
+int ata_pci_clear_simplex(struct pci_dev *pdev)
+{
+	unsigned long bmdma = pci_resource_start(pdev, 4);
+	u8 simplex;
+
+	if (bmdma == 0)
+		return -ENOENT;
+
+	simplex = inb(bmdma + 0x02);
+	outb(simplex & 0x60, bmdma + 0x02);
+	simplex = inb(bmdma + 0x02);
+	if (simplex & 0x80)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+unsigned long ata_pci_default_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long xfer_mask)
+{
+	/* Filter out DMA modes if the device has been configured by
+	   the BIOS as PIO only */
+	   
+	if (ap->ioaddr.bmdma_addr == 0)
+		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
+	return xfer_mask;
+}
+
 #endif /* CONFIG_PCI */
 
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 64dce00..0314abd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -962,6 +962,8 @@ ata_exec_internal(struct ata_port *ap, s
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
+		ata_port_flush_task(ap);
+
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 
 		/* We're racing with irq here.  If we lose, the
@@ -1219,13 +1221,6 @@ static int ata_dev_configure(struct ata_
 	 * common ATA, ATAPI feature tests
 	 */
 
-	/* we require DMA support (bits 8 of word 49) */
-	if (!ata_id_has_dma(id)) {
-		printk(KERN_DEBUG "ata%u: no dma\n", ap->id);
-		rc = -EINVAL;
-		goto err_out_nosup;
-	}
-
 	/* find max transfer mode; for printk only */
 	xfer_mask = ata_id_xfermask(id);
 
@@ -1737,7 +1732,7 @@ static int ata_host_set_pio(struct ata_p
 			continue;
 
 		if (!dev->pio_mode) {
-			printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
+			printk(KERN_WARNING "ata%u: no PIO support for device %d.\n", ap->id, i);
 			return -1;
 		}
 
@@ -1999,9 +1994,19 @@ static unsigned int ata_bus_softreset(st
 	 * status is checked.  Because waiting for "a while" before
 	 * checking status is fine, post SRST, we perform this magic
 	 * delay here as well.
+	 *
+	 * Old drivers/ide uses the 2mS rule and then waits for ready
 	 */
 	msleep(150);
 
+	
+	/* Before we perform post reset processing we want to see if 
+	   the bus shows 0xFF because the odd clown forgets the D7 pulldown
+	   resistor */
+	
+	if (ata_check_status(ap) == 0xFF)
+		return 1;	/* Positive is failure for some reason */
+
 	ata_bus_post_reset(ap, devmask);
 
 	return 0;
@@ -2551,48 +2556,72 @@ int ata_dev_revalidate(struct ata_port *
 }
 
 static const char * const ata_dma_blacklist [] = {
-	"WDC AC11000H",
-	"WDC AC22100H",
-	"WDC AC32500H",
-	"WDC AC33100H",
-	"WDC AC31600H",
-	"WDC AC32100H",
-	"WDC AC23200L",
-	"Compaq CRD-8241B",
-	"CRD-8400B",
-	"CRD-8480B",
-	"CRD-8482B",
- 	"CRD-84",
-	"SanDisk SDP3B",
-	"SanDisk SDP3B-64",
-	"SANYO CD-ROM CRD",
-	"HITACHI CDR-8",
-	"HITACHI CDR-8335",
-	"HITACHI CDR-8435",
-	"Toshiba CD-ROM XM-6202B",
-	"TOSHIBA CD-ROM XM-1702BC",
-	"CD-532E-A",
-	"E-IDE CD-ROM CR-840",
-	"CD-ROM Drive/F5A",
-	"WPI CDD-820",
-	"SAMSUNG CD-ROM SC-148C",
-	"SAMSUNG CD-ROM SC",
-	"SanDisk SDP3B-64",
-	"ATAPI CD-ROM DRIVE 40X MAXIMUM",
-	"_NEC DV5800A",
+	"WDC AC11000H", NULL,
+	"WDC AC22100H", NULL,
+	"WDC AC32500H", NULL,
+	"WDC AC33100H", NULL,
+	"WDC AC31600H", NULL,
+	"WDC AC32100H", "24.09P07",
+	"WDC AC23200L", "21.10N21",
+	"Compaq CRD-8241B",  NULL,
+	"CRD-8400B", NULL,
+	"CRD-8480B", NULL,
+	"CRD-8482B", NULL,
+ 	"CRD-84", NULL,
+	"SanDisk SDP3B", NULL,
+	"SanDisk SDP3B-64", NULL,
+	"SANYO CD-ROM CRD", NULL,
+	"HITACHI CDR-8", NULL,
+	"HITACHI CDR-8335", NULL, 
+	"HITACHI CDR-8435", NULL,
+	"Toshiba CD-ROM XM-6202B", NULL, 
+	"TOSHIBA CD-ROM XM-1702BC", NULL, 
+	"CD-532E-A", NULL, 
+	"E-IDE CD-ROM CR-840", NULL, 
+	"CD-ROM Drive/F5A", NULL, 
+	"WPI CDD-820", NULL, 
+	"SAMSUNG CD-ROM SC-148C", NULL,
+	"SAMSUNG CD-ROM SC", NULL, 
+	"SanDisk SDP3B-64", NULL,
+	"ATAPI CD-ROM DRIVE 40X MAXIMUM",NULL,
+	"_NEC DV5800A", NULL,
+	"SAMSUNG CD-ROM SN-124", "N001"
 };
+ 
+static int ata_strim(char *s, size_t len)
+{
+	len = strnlen(s, len);
+
+	/* ATAPI specifies that empty space is blank-filled; remove blanks */
+	while ((len > 0) && (s[len - 1] == ' ')) {
+		len--;
+		s[len] = 0;
+	}
+	return len;
+}
 
 static int ata_dma_blacklisted(const struct ata_device *dev)
 {
-	unsigned char model_num[41];
+	unsigned char model_num[40];
+	unsigned char model_rev[16];
+	unsigned int nlen, rlen;
 	int i;
 
-	ata_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS, sizeof(model_num));
-
-	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i++)
-		if (!strcmp(ata_dma_blacklist[i], model_num))
-			return 1;
-
+	ata_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
+			  sizeof(model_num));
+	ata_id_string(dev->id, model_rev, ATA_ID_FW_REV_OFS,
+			  sizeof(model_rev));
+	nlen = ata_strim(model_num, sizeof(model_num));
+	rlen = ata_strim(model_rev, sizeof(model_rev));
+
+	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i += 2) {
+		if (!strncmp(ata_dma_blacklist[i], model_num, nlen)) {
+			if (ata_dma_blacklist[i+1] == NULL)
+				return 1;
+			if (!strncmp(ata_dma_blacklist[i], model_rev, rlen))
+				return 1;
+		}
+	}
 	return 0;
 }
 
@@ -2863,6 +2892,8 @@ void ata_qc_prep(struct ata_queued_cmd *
 	ata_fill_sg(qc);
 }
 
+void ata_noop_qc_prep(struct ata_queued_cmd *qc) { }
+
 /**
  *	ata_sg_init_one - Associate command with memory buffer
  *	@qc: Command to be associated
@@ -3907,7 +3938,6 @@ static inline int ata_should_dma_map(str
 
 	case ATA_PROT_ATAPI:
 	case ATA_PROT_PIO:
-	case ATA_PROT_PIO_MULT:
 		if (ap->flags & ATA_FLAG_PIO_DMA)
 			return 1;
 
@@ -4199,14 +4229,17 @@ void ata_bmdma_setup(struct ata_queued_c
 
 void ata_bmdma_irq_clear(struct ata_port *ap)
 {
-    if (ap->flags & ATA_FLAG_MMIO) {
-        void __iomem *mmio = ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
-        writeb(readb(mmio), mmio);
-    } else {
-        unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
-        outb(inb(addr), addr);
-    }
+	if (!ap->ioaddr.bmdma_addr)
+		return;
 
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio =
+		      ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
+		writeb(readb(mmio), mmio);
+	} else {
+		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
+		outb(inb(addr), addr);
+	}
 }
 
 
@@ -4337,9 +4370,9 @@ idle_irq:
 
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
-		handled = 1;
 		ata_irq_ack(ap, 0); /* debug trap */
 		printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
+		return 1;
 	}
 #endif
 	return 0;	/* irq not handled */
@@ -5064,6 +5097,7 @@ EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_host_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
 EXPORT_SYMBOL_GPL(ata_qc_prep);
+EXPORT_SYMBOL_GPL(ata_noop_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup);
 EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
@@ -5109,6 +5143,8 @@ EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
 EXPORT_SYMBOL_GPL(ata_pci_device_suspend);
 EXPORT_SYMBOL_GPL(ata_pci_device_resume);
+EXPORT_SYMBOL_GPL(ata_pci_default_filter);
+EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
 EXPORT_SYMBOL_GPL(ata_device_suspend);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index bd9f217..a1259b2 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -521,13 +521,11 @@ void ata_to_sense_error(unsigned id, u8 
 	printk(KERN_WARNING "ata%u: no sense translation for status: 0x%02x\n", 
 	       id, drv_stat);
 
-	/* For our last chance pick, use medium read error because
-	 * it's much more common than an ATA drive telling you a write
-	 * has failed.
-	 */
-	*sk = MEDIUM_ERROR;
-	*asc = 0x11; /* "unrecovered read error" */
-	*ascq = 0x04; /*  "auto-reallocation failed" */
+	/* We need a sensible error return here, which is tricky, and one
+	   that won't cause people to do things like return a disk wrongly */
+	*sk = ABORTED_COMMAND;
+	*asc = 0x00;
+	*ascq = 0x00;
 
  translate_done:
 	printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
@@ -672,6 +670,41 @@ void ata_gen_fixed_sense(struct ata_queu
 	}
 }
 
+static void ata_scsi_sdev_config(struct scsi_device *sdev)
+{
+	sdev->use_10_for_rw = 1;
+	sdev->use_10_for_ms = 1;
+}
+
+static void ata_scsi_dev_config(struct scsi_device *sdev,
+				struct ata_device *dev)
+{
+	unsigned int max_sectors;
+
+	/* TODO: 2048 is an arbitrary number, not the
+	 * hardware maximum.  This should be increased to
+	 * 65534 when Jens Axboe's patch for dynamically
+	 * determining max_sectors is merged.
+	 */
+	max_sectors = ATA_MAX_SECTORS;
+	if (dev->flags & ATA_DFLAG_LBA48)
+		max_sectors = 2048;
+	if (dev->max_sectors)
+		max_sectors = dev->max_sectors;
+
+	blk_queue_max_sectors(sdev->request_queue, max_sectors);
+
+	/*
+	 * SATA DMA transfers must be multiples of 4 byte, so
+	 * we need to pad ATAPI transfers using an extra sg.
+	 * Decrement max hw segments accordingly.
+	 */
+	if (dev->class == ATA_DEV_ATAPI) {
+		request_queue_t *q = sdev->request_queue;
+		blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
+	}
+}
+
 /**
  *	ata_scsi_slave_config - Set SCSI device attributes
  *	@sdev: SCSI device to examine
@@ -686,41 +719,18 @@ void ata_gen_fixed_sense(struct ata_queu
 
 int ata_scsi_slave_config(struct scsi_device *sdev)
 {
-	sdev->use_10_for_rw = 1;
-	sdev->use_10_for_ms = 1;
+	ata_scsi_sdev_config(sdev);
 
 	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
 
 	if (sdev->id < ATA_MAX_DEVICES) {
 		struct ata_port *ap;
 		struct ata_device *dev;
-		unsigned int max_sectors;
 
 		ap = (struct ata_port *) &sdev->host->hostdata[0];
 		dev = &ap->device[sdev->id];
 
-		/* TODO: 2048 is an arbitrary number, not the
-		 * hardware maximum.  This should be increased to
-		 * 65534 when Jens Axboe's patch for dynamically
-		 * determining max_sectors is merged.
-		 */
-		max_sectors = ATA_MAX_SECTORS;
-		if (dev->flags & ATA_DFLAG_LBA48)
-			max_sectors = 2048;
-		if (dev->max_sectors)
-			max_sectors = dev->max_sectors;
-
-		blk_queue_max_sectors(sdev->request_queue, max_sectors);
-
-		/*
-		 * SATA DMA transfers must be multiples of 4 byte, so
-		 * we need to pad ATAPI transfers using an extra sg.
-		 * Decrement max hw segments accordingly.
-		 */
-		if (dev->class == ATA_DEV_ATAPI) {
-			request_queue_t *q = sdev->request_queue;
-			blk_queue_max_hw_segments(q, q->max_hw_segments - 1);
-		}
+		ata_scsi_dev_config(sdev, dev);
 	}
 
 	return 0;	/* scsi layer doesn't check return value, sigh */
@@ -1552,7 +1562,7 @@ void ata_scsi_rbuf_fill(struct ata_scsi_
  *	@buflen: Response buffer length.
  *
  *	Returns standard device identification data associated
- *	with non-EVPD INQUIRY command output.
+ *	with non-VPD INQUIRY command output.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
@@ -1603,12 +1613,12 @@ unsigned int ata_scsiop_inq_std(struct a
 }
 
 /**
- *	ata_scsiop_inq_00 - Simulate INQUIRY EVPD page 0, list of pages
+ *	ata_scsiop_inq_00 - Simulate INQUIRY VPD page 0, list of pages
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
- *	Returns list of inquiry EVPD pages available.
+ *	Returns list of inquiry VPD pages available.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
@@ -1622,7 +1632,7 @@ unsigned int ata_scsiop_inq_00(struct at
 		0x80,	/* page 0x80, unit serial no page */
 		0x83	/* page 0x83, device ident page */
 	};
-	rbuf[3] = sizeof(pages);	/* number of supported EVPD pages */
+	rbuf[3] = sizeof(pages);	/* number of supported VPD pages */
 
 	if (buflen > 6)
 		memcpy(rbuf + 4, pages, sizeof(pages));
@@ -1631,7 +1641,7 @@ unsigned int ata_scsiop_inq_00(struct at
 }
 
 /**
- *	ata_scsiop_inq_80 - Simulate INQUIRY EVPD page 80, device serial number
+ *	ata_scsiop_inq_80 - Simulate INQUIRY VPD page 80, device serial number
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
@@ -1660,16 +1670,16 @@ unsigned int ata_scsiop_inq_80(struct at
 	return 0;
 }
 
-static const char * const inq_83_str = "Linux ATA-SCSI simulator";
-
 /**
- *	ata_scsiop_inq_83 - Simulate INQUIRY EVPD page 83, device identity
+ *	ata_scsiop_inq_83 - Simulate INQUIRY VPD page 83, device identity
  *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
- *	Returns device identification.  Currently hardcoded to
- *	return "Linux ATA-SCSI simulator".
+ *	Yields two logical unit device identification designators:
+ *	 - vendor specific ASCII containing the ATA serial number
+ *	 - SAT defined "t10 vendor id based" containing ASCII vendor
+ *	   name ("ATA     "), model and serial numbers.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
@@ -1678,16 +1688,39 @@ static const char * const inq_83_str = "
 unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf,
 			      unsigned int buflen)
 {
+	int num;
+	const int sat_model_serial_desc_len = 68;
+	const int ata_model_byte_len = 40;
+
 	rbuf[1] = 0x83;			/* this page code */
-	rbuf[3] = 4 + strlen(inq_83_str);	/* page len */
+	num = 4;
 
-	/* our one and only identification descriptor (vendor-specific) */
-	if (buflen > (strlen(inq_83_str) + 4 + 4 - 1)) {
-		rbuf[4 + 0] = 2;	/* code set: ASCII */
-		rbuf[4 + 3] = strlen(inq_83_str);
-		memcpy(rbuf + 4 + 4, inq_83_str, strlen(inq_83_str));
+	if (buflen > (ATA_SERNO_LEN + num + 3)) {
+		/* piv=0, assoc=lu, code_set=ACSII, designator=vendor */
+		rbuf[num + 0] = 2;	
+		rbuf[num + 3] = ATA_SERNO_LEN;
+		num += 4;
+		ata_id_string(args->id, (unsigned char *) rbuf + num,
+			      ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
+		num += ATA_SERNO_LEN;
 	}
-
+	if (buflen > (sat_model_serial_desc_len + num + 3)) {
+		/* SAT defined lu model and serial numbers descriptor */
+		/* piv=0, assoc=lu, code_set=ACSII, designator=t10 vendor id */
+		rbuf[num + 0] = 2;	
+		rbuf[num + 1] = 1;	
+		rbuf[num + 3] = sat_model_serial_desc_len;
+		num += 4;
+		memcpy(rbuf + num, "ATA     ", 8);
+		num += 8;
+		ata_id_string(args->id, (unsigned char *) rbuf + num,
+			      ATA_ID_PROD_OFS, ata_model_byte_len);
+		num += ata_model_byte_len;
+		ata_id_string(args->id, (unsigned char *) rbuf + num,
+			      ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
+		num += ATA_SERNO_LEN;
+	}
+	rbuf[3] = num - 4;    /* page len (assume less than 256 bytes) */
 	return 0;
 }
 
@@ -2366,9 +2399,6 @@ ata_scsi_map_proto(u8 byte1)
 
 		case 4:		/* PIO Data-in */
 		case 5:		/* PIO Data-out */
-			if (byte1 & 0xe0) {
-				return ATA_PROT_PIO_MULT;
-			}
 			return ATA_PROT_PIO;
 
 		case 10:	/* Device Reset */
@@ -2407,6 +2437,10 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
 		goto invalid_fld;
 
+	if (scsicmd[1] & 0xe0)
+		/* PIO multi not supported yet */
+		goto invalid_fld;
+
 	/*
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index b3dc5f8..3c85c4b 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -321,7 +321,7 @@ static int adma_fill_sg(struct ata_queue
 			= (pFLAGS & pEND) ? 0 : cpu_to_le32(pp->pkt_dma + i + 4);
 		i += 4;
 
-		VPRINTK("PRD[%u] = (0x%lX, 0x%X)\n", nelem,
+		VPRINTK("PRD[%u] = (0x%lX, 0x%X)\n", i/4,
 					(unsigned long)addr, len);
 	}
 	return i;
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 874c5be..275ed9b 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1262,6 +1262,7 @@ static u8 mv_get_crpb_status(struct ata_
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
 	u32 out_ptr;
+	u8 ata_status;
 
 	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
@@ -1269,6 +1270,8 @@ static u8 mv_get_crpb_status(struct ata_
 	WARN_ON(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
 		pp->rsp_consumer);
 
+	ata_status = pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT;
+
 	/* increment our consumer index... */
 	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
 
@@ -1283,7 +1286,7 @@ static u8 mv_get_crpb_status(struct ata_
 	writelfl(out_ptr, port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* Return ATA status register for completed CRPB */
-	return (pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT);
+	return ata_status;
 }
 
 /**
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
index 051e47d..724f0ed 100644
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -56,33 +56,35 @@
 #define DRV_NAME	"sata_svw"
 #define DRV_VERSION	"1.07"
 
-/* Taskfile registers offsets */
-#define K2_SATA_TF_CMD_OFFSET		0x00
-#define K2_SATA_TF_DATA_OFFSET		0x00
-#define K2_SATA_TF_ERROR_OFFSET		0x04
-#define K2_SATA_TF_NSECT_OFFSET		0x08
-#define K2_SATA_TF_LBAL_OFFSET		0x0c
-#define K2_SATA_TF_LBAM_OFFSET		0x10
-#define K2_SATA_TF_LBAH_OFFSET		0x14
-#define K2_SATA_TF_DEVICE_OFFSET	0x18
-#define K2_SATA_TF_CMDSTAT_OFFSET      	0x1c
-#define K2_SATA_TF_CTL_OFFSET		0x20
-
-/* DMA base */
-#define K2_SATA_DMA_CMD_OFFSET		0x30
-
-/* SCRs base */
-#define K2_SATA_SCR_STATUS_OFFSET	0x40
-#define K2_SATA_SCR_ERROR_OFFSET	0x44
-#define K2_SATA_SCR_CONTROL_OFFSET	0x48
-
-/* Others */
-#define K2_SATA_SICR1_OFFSET		0x80
-#define K2_SATA_SICR2_OFFSET		0x84
-#define K2_SATA_SIM_OFFSET		0x88
+enum {
+	/* Taskfile registers offsets */
+	K2_SATA_TF_CMD_OFFSET		= 0x00,
+	K2_SATA_TF_DATA_OFFSET		= 0x00,
+	K2_SATA_TF_ERROR_OFFSET		= 0x04,
+	K2_SATA_TF_NSECT_OFFSET		= 0x08,
+	K2_SATA_TF_LBAL_OFFSET		= 0x0c,
+	K2_SATA_TF_LBAM_OFFSET		= 0x10,
+	K2_SATA_TF_LBAH_OFFSET		= 0x14,
+	K2_SATA_TF_DEVICE_OFFSET	= 0x18,
+	K2_SATA_TF_CMDSTAT_OFFSET      	= 0x1c,
+	K2_SATA_TF_CTL_OFFSET		= 0x20,
+
+	/* DMA base */
+	K2_SATA_DMA_CMD_OFFSET		= 0x30,
+
+	/* SCRs base */
+	K2_SATA_SCR_STATUS_OFFSET	= 0x40,
+	K2_SATA_SCR_ERROR_OFFSET	= 0x44,
+	K2_SATA_SCR_CONTROL_OFFSET	= 0x48,
+
+	/* Others */
+	K2_SATA_SICR1_OFFSET		= 0x80,
+	K2_SATA_SICR2_OFFSET		= 0x84,
+	K2_SATA_SIM_OFFSET		= 0x88,
 
-/* Port stride */
-#define K2_SATA_PORT_OFFSET		0x100
+	/* Port stride */
+	K2_SATA_PORT_OFFSET		= 0x100,
+};
 
 static u8 k2_stat_check_status(struct ata_port *ap);
 
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index ee75b9b..9701a80 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -47,52 +47,58 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_vsc"
-#define DRV_VERSION	"1.1"
+#define DRV_VERSION	"1.2"
+
+enum {
+	/* Interrupt register offsets (from chip base address) */
+	VSC_SATA_INT_STAT_OFFSET	= 0x00,
+	VSC_SATA_INT_MASK_OFFSET	= 0x04,
+
+	/* Taskfile registers offsets */
+	VSC_SATA_TF_CMD_OFFSET		= 0x00,
+	VSC_SATA_TF_DATA_OFFSET		= 0x00,
+	VSC_SATA_TF_ERROR_OFFSET	= 0x04,
+	VSC_SATA_TF_FEATURE_OFFSET	= 0x06,
+	VSC_SATA_TF_NSECT_OFFSET	= 0x08,
+	VSC_SATA_TF_LBAL_OFFSET		= 0x0c,
+	VSC_SATA_TF_LBAM_OFFSET		= 0x10,
+	VSC_SATA_TF_LBAH_OFFSET		= 0x14,
+	VSC_SATA_TF_DEVICE_OFFSET	= 0x18,
+	VSC_SATA_TF_STATUS_OFFSET	= 0x1c,
+	VSC_SATA_TF_COMMAND_OFFSET	= 0x1d,
+	VSC_SATA_TF_ALTSTATUS_OFFSET	= 0x28,
+	VSC_SATA_TF_CTL_OFFSET		= 0x29,
+
+	/* DMA base */
+	VSC_SATA_UP_DESCRIPTOR_OFFSET	= 0x64,
+	VSC_SATA_UP_DATA_BUFFER_OFFSET	= 0x6C,
+	VSC_SATA_DMA_CMD_OFFSET		= 0x70,
+
+	/* SCRs base */
+	VSC_SATA_SCR_STATUS_OFFSET	= 0x100,
+	VSC_SATA_SCR_ERROR_OFFSET	= 0x104,
+	VSC_SATA_SCR_CONTROL_OFFSET	= 0x108,
+
+	/* Port stride */
+	VSC_SATA_PORT_OFFSET		= 0x200,
+
+	/* Error interrupt status bit offsets */
+	VSC_SATA_INT_ERROR_CRC		= 0x40,
+	VSC_SATA_INT_ERROR_T		= 0x20,
+	VSC_SATA_INT_ERROR_P		= 0x10,
+	VSC_SATA_INT_ERROR_R		= 0x8,
+	VSC_SATA_INT_ERROR_E		= 0x4,
+	VSC_SATA_INT_ERROR_M		= 0x2,
+	VSC_SATA_INT_PHY_CHANGE		= 0x1,
+	VSC_SATA_INT_ERROR = (VSC_SATA_INT_ERROR_CRC  | VSC_SATA_INT_ERROR_T | \
+			      VSC_SATA_INT_ERROR_P    | VSC_SATA_INT_ERROR_R | \
+			      VSC_SATA_INT_ERROR_E    | VSC_SATA_INT_ERROR_M | \
+			      VSC_SATA_INT_PHY_CHANGE),
+};
+
 
-/* Interrupt register offsets (from chip base address) */
-#define VSC_SATA_INT_STAT_OFFSET	0x00
-#define VSC_SATA_INT_MASK_OFFSET	0x04
-
-/* Taskfile registers offsets */
-#define VSC_SATA_TF_CMD_OFFSET		0x00
-#define VSC_SATA_TF_DATA_OFFSET		0x00
-#define VSC_SATA_TF_ERROR_OFFSET	0x04
-#define VSC_SATA_TF_FEATURE_OFFSET	0x06
-#define VSC_SATA_TF_NSECT_OFFSET	0x08
-#define VSC_SATA_TF_LBAL_OFFSET		0x0c
-#define VSC_SATA_TF_LBAM_OFFSET		0x10
-#define VSC_SATA_TF_LBAH_OFFSET		0x14
-#define VSC_SATA_TF_DEVICE_OFFSET	0x18
-#define VSC_SATA_TF_STATUS_OFFSET	0x1c
-#define VSC_SATA_TF_COMMAND_OFFSET	0x1d
-#define VSC_SATA_TF_ALTSTATUS_OFFSET	0x28
-#define VSC_SATA_TF_CTL_OFFSET		0x29
-
-/* DMA base */
-#define VSC_SATA_UP_DESCRIPTOR_OFFSET	0x64
-#define VSC_SATA_UP_DATA_BUFFER_OFFSET	0x6C
-#define VSC_SATA_DMA_CMD_OFFSET		0x70
-
-/* SCRs base */
-#define VSC_SATA_SCR_STATUS_OFFSET	0x100
-#define VSC_SATA_SCR_ERROR_OFFSET	0x104
-#define VSC_SATA_SCR_CONTROL_OFFSET	0x108
-
-/* Port stride */
-#define VSC_SATA_PORT_OFFSET		0x200
-
-/* Error interrupt status bit offsets */
-#define VSC_SATA_INT_ERROR_E_OFFSET	2
-#define VSC_SATA_INT_ERROR_P_OFFSET	4
-#define VSC_SATA_INT_ERROR_T_OFFSET	5
-#define VSC_SATA_INT_ERROR_M_OFFSET	1
 #define is_vsc_sata_int_err(port_idx, int_status) \
-	 (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 * port_idx))) | \
-		        (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 * port_idx))) | \
-		        (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 * port_idx))) | \
-		        (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 * port_idx)))   \
-		       )\
- 	 )
+	 (int_status & (VSC_SATA_INT_ERROR << (8 * port_idx)))
 
 
 static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
@@ -215,14 +221,6 @@ static irqreturn_t vsc_sata_interrupt (i
 
 			ap = host_set->ports[i];
 
-			if (is_vsc_sata_int_err(i, int_status)) {
-				u32 err_status;
-				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
-				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
-				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
-				handled++;
-			}
-
 			if (ap && !(ap->flags &
 				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
@@ -230,12 +228,26 @@ static irqreturn_t vsc_sata_interrupt (i
 				qc = ata_qc_from_tag(ap, ap->active_tag);
 				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					handled += ata_host_intr(ap, qc);
-				} else {
-					printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
+				} else if (is_vsc_sata_int_err(i, int_status)) {
+					/*
+					 * On some chips (i.e. Intel 31244), an error 
+					 * interrupt will sneak in at initialization
+					 * time (phy state changes).  Clearing the SCR
+					 * error register is not required, but it prevents
+					 * the phy state change interrupts from recurring 
+					 * later.
+					 */
+					u32 err_status;
+					err_status = vsc_sata_scr_read(ap, SCR_ERROR);
+					printk(KERN_DEBUG "%s: clearing interrupt, "
+					       "status %x; sata err status %x\n",
+					       __FUNCTION__,
+					       int_status, err_status);
+					vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+					/* Clear interrupt status */
 					ata_chk_status(ap);
 					handled++;
 				}
-
 			}
 		}
 	}
diff --git a/include/linux/ata.h b/include/linux/ata.h
index b02a16c..312a2c0 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -146,6 +146,8 @@ enum {
  	ATA_CMD_STANDBYNOW1	= 0xE0,
  	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
 	ATA_CMD_INIT_DEV_PARAMS	= 0x91,
+	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
+	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
@@ -204,7 +206,6 @@ enum ata_tf_protocols {
 	ATA_PROT_UNKNOWN,	/* unknown/invalid */
 	ATA_PROT_NODATA,	/* no data */
 	ATA_PROT_PIO,		/* PIO single sector */
-	ATA_PROT_PIO_MULT,	/* PIO multiple sector */
 	ATA_PROT_DMA,		/* DMA */
 	ATA_PROT_ATAPI,		/* packet command, PIO data xfer*/
 	ATA_PROT_ATAPI_NODATA,	/* packet command, no data */
@@ -247,18 +248,22 @@ struct ata_taskfile {
 };
 
 #define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
+#define ata_id_is_cfa(id)	((id)[0] == 0x848A)
 #define ata_id_is_sata(id)	((id)[93] == 0)
 #define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
 #define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
+#define ata_id_hpa_enabled(id)	((id)[85] & (1 << 10))
 #define ata_id_has_fua(id)	((id)[84] & (1 << 6))
 #define ata_id_has_flush(id)	((id)[83] & (1 << 12))
 #define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
 #define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
+#define ata_id_has_hpa(id)	((id)[82] & (1 << 10))
 #define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
 #define ata_id_has_pm(id)	((id)[82] & (1 << 3))
 #define ata_id_has_lba(id)	((id)[49] & (1 << 9))
 #define ata_id_has_dma(id)	((id)[49] & (1 << 8))
 #define ata_id_removeable(id)	((id)[0] & (1 << 7))
+#define ata_id_has_dword_io(id)	((id)[50] & (1 << 0))
 #define ata_id_u32(id,n)	\
 	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
 #define ata_id_u64(id,n)	\
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 204c37a..7a54244 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -502,6 +502,7 @@ extern int ata_pci_init_one (struct pci_
 extern void ata_pci_remove_one (struct pci_dev *pdev);
 extern int ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
 extern int ata_pci_device_resume(struct pci_dev *pdev);
+extern int ata_pci_clear_simplex(struct pci_dev *pdev);
 #endif /* CONFIG_PCI */
 extern int ata_device_add(const struct ata_probe_ent *ent);
 extern void ata_host_set_remove(struct ata_host_set *host_set);
@@ -542,6 +543,7 @@ extern void ata_port_stop (struct ata_po
 extern void ata_host_stop (struct ata_host_set *host_set);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
+extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 extern void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf,
 		unsigned int buflen);
@@ -608,7 +610,7 @@ extern void ata_pci_host_stop (struct at
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int portmask);
 extern int pci_test_config_bits(struct pci_dev *pdev, const struct pci_bits *bits);
-
+extern unsigned long ata_pci_default_filter(const struct ata_port *, struct ata_device *, unsigned long);
 #endif /* CONFIG_PCI */
 
 
