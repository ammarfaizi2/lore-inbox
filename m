Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWCXP7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWCXP7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWCXP7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:59:43 -0500
Received: from havoc.gtf.org ([69.61.125.42]:51629 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932094AbWCXP7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:59:40 -0500
Date: Fri, 24 Mar 2006 10:59:37 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata updates
Message-ID: <20060324155937.GA833@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/ata_piix.c     |    6 
 drivers/scsi/libata-bmdma.c |  238 ++++++++++++++++++++++
 drivers/scsi/libata-core.c  |  469 +++++++++++++++-----------------------------
 drivers/scsi/libata-scsi.c  |   79 +++----
 drivers/scsi/sata_nv.c      |  181 +++++-----------
 drivers/scsi/sata_sil.c     |    2 
 drivers/scsi/sata_sil24.c   |   25 +-
 drivers/scsi/sata_uli.c     |   37 ++-
 drivers/scsi/sata_vsc.c     |    4 
 drivers/scsi/scsi_sysfs.c   |    2 
 include/linux/libata.h      |   12 -
 include/scsi/scsi_host.h    |    2 
 12 files changed, 551 insertions(+), 506 deletions(-)

Alan Cox:
      libata: add ata_dev_pair helper

Brian King:
      libata: ata_scsi_queuecmd cleanup
      libata: ata_scsi_ioctl cleanup
      libata: Remove dependence on host_set->dev for SAS

Jeff Garzik:
      [libata sata_sil24] cleanups: use pci_iomap(), kzalloc()
      [libata sata_nv] cleanups: convert #defines to enums; remove in-file history
      [libata sata_nv] eliminate duplicate codepaths with iomap
      [libata sata_uli] kill scr_addr abuse
      [libata] Move some bmdma-specific code to libata-bmdma.c
      [libata] export ata_dev_pair; trim trailing whitespace

Nigel Cunningham:
      Make libata not powerdown drivers on PM_EVENT_FREEZE.

Tejun Heo:
      libata: implement ata_unpack_xfermask()
      libata: add per-dev pio/mwdma/udma_mask
      libata: make per-dev transfer mode limits per-dev
      libata: check if port is disabled after internal command
      libata: implement ata_dev_disable()
      libata: use ata_dev_disable() in ata_bus_probe()
      libata: make ata_set_mode() responsible for failure handling

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index a74e23d..2d5be84 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -742,7 +742,7 @@ static int piix_disable_ahci(struct pci_
 /**
  *	piix_check_450nx_errata	-	Check for problem 450NX setup
  *	@ata_dev: the PCI device to check
- *	
+ *
  *	Check for the present of 450NX errata #19 and errata #25. If
  *	they are found return an error code so we can turn off DMA
  */
@@ -753,7 +753,7 @@ static int __devinit piix_check_450nx_er
 	u16 cfg;
 	u8 rev;
 	int no_piix_dma = 0;
-	
+
 	while((pdev = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454NX, pdev)) != NULL)
 	{
 		/* Look for 450NX PXB. Check for problem configurations
@@ -772,7 +772,7 @@ static int __devinit piix_check_450nx_er
 	if(no_piix_dma == 2)
 		dev_printk(KERN_WARNING, &ata_dev->dev, "A BIOS update may resolve this.\n");
 	return no_piix_dma;
-}		
+}
 
 static void __devinit piix_init_sata_map(struct pci_dev *pdev,
 					 struct ata_port_info *pinfo)
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 96b4d21..95d81d8 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -418,6 +418,240 @@ u8 ata_altstatus(struct ata_port *ap)
 	return inb(ap->ioaddr.altstatus_addr);
 }
 
+/**
+ *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	u8 dmactl;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+
+	/* load PRD table addr. */
+	mb();	/* make sure PRD table writes are visible to controller */
+	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
+
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	writeb(dmactl, mmio + ATA_DMA_CMD);
+
+	/* issue r/w command */
+	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+	u8 dmactl;
+
+	/* start host DMA transaction */
+	dmactl = readb(mmio + ATA_DMA_CMD);
+	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
+
+	/* Strictly, one may wish to issue a readb() here, to
+	 * flush the mmio write.  However, control also passes
+	 * to the hardware at this point, and it will interrupt
+	 * us when we are to resume control.  So, in effect,
+	 * we don't care when the mmio write flushes.
+	 * Further, a read of the DMA status register _immediately_
+	 * following the write may not be what certain flaky hardware
+	 * is expected, so I think it is best to not add a readb()
+	 * without first all the MMIO ATA cards/mobos.
+	 * Or maybe I'm just being paranoid.
+	 */
+}
+
+/**
+ *	ata_bmdma_setup_pio - Set up PCI IDE BMDMA transaction (PIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	u8 dmactl;
+
+	/* load PRD table addr. */
+	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+
+	/* issue r/w command */
+	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	ata_bmdma_start_pio - Start a PCI IDE BMDMA transaction (PIO)
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+static void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 dmactl;
+
+	/* start host DMA transaction */
+	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	outb(dmactl | ATA_DMA_START,
+	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+}
+
+
+/**
+ *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Writes the ATA_DMA_START flag to the DMA command register.
+ *
+ *	May be used as the bmdma_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_bmdma_start(struct ata_queued_cmd *qc)
+{
+	if (qc->ap->flags & ATA_FLAG_MMIO)
+		ata_bmdma_start_mmio(qc);
+	else
+		ata_bmdma_start_pio(qc);
+}
+
+
+/**
+ *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Writes address of PRD table to device's PRD Table Address
+ *	register, sets the DMA control register, and calls
+ *	ops->exec_command() to start the transfer.
+ *
+ *	May be used as the bmdma_setup() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	if (qc->ap->flags & ATA_FLAG_MMIO)
+		ata_bmdma_setup_mmio(qc);
+	else
+		ata_bmdma_setup_pio(qc);
+}
+
+
+/**
+ *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Clear interrupt and error flags in DMA status register.
+ *
+ *	May be used as the irq_clear() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_bmdma_irq_clear(struct ata_port *ap)
+{
+	if (!ap->ioaddr.bmdma_addr)
+		return;
+
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio =
+		      ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
+		writeb(readb(mmio), mmio);
+	} else {
+		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
+		outb(inb(addr), addr);
+	}
+}
+
+
+/**
+ *	ata_bmdma_status - Read PCI IDE BMDMA status
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Read and return BMDMA status register.
+ *
+ *	May be used as the bmdma_status() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+u8 ata_bmdma_status(struct ata_port *ap)
+{
+	u8 host_stat;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	return host_stat;
+}
+
+
+/**
+ *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
+ *	@qc: Command we are ending DMA for
+ *
+ *	Clears the ATA_DMA_START flag in the dma control register
+ *
+ *	May be used as the bmdma_stop() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
+
+		/* clear start/stop bit */
+		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+			mmio + ATA_DMA_CMD);
+	} else {
+		/* clear start/stop bit */
+		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+			ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	}
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_altstatus(ap);        /* dummy read */
+}
+
 #ifdef CONFIG_PCI
 static struct ata_probe_ent *
 ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
@@ -707,7 +941,7 @@ err_out:
  *	@pdev: PCI device
  *
  *	Some PCI ATA devices report simplex mode but in fact can be told to
- *	enter non simplex mode. This implements the neccessary logic to 
+ *	enter non simplex mode. This implements the neccessary logic to
  *	perform the task on such devices. Calling it on other devices will
  *	have -undefined- behaviour.
  */
@@ -732,7 +966,7 @@ unsigned long ata_pci_default_filter(con
 {
 	/* Filter out DMA modes if the device has been configured by
 	   the BIOS as PIO only */
-	   
+
 	if (ap->ioaddr.bmdma_addr == 0)
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	return xfer_mask;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0314abd..d279666 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -64,9 +64,9 @@
 static unsigned int ata_dev_init_params(struct ata_port *ap,
 					struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
-static unsigned int ata_dev_xfermask(struct ata_port *ap,
-				     struct ata_device *dev);
+static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
+					 struct ata_device *dev);
+static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -190,7 +190,7 @@ static const u8 ata_rw_cmds[] = {
  *	ata_rwcmd_protocol - set taskfile r/w commands and protocol
  *	@qc: command to examine and configure
  *
- *	Examine the device configuration and tf->flags to calculate 
+ *	Examine the device configuration and tf->flags to calculate
  *	the proper read/write commands and protocol to use.
  *
  *	LOCKING:
@@ -203,7 +203,7 @@ int ata_rwcmd_protocol(struct ata_queued
 	u8 cmd;
 
 	int index, fua, lba48, write;
- 
+
 	fua = (tf->flags & ATA_TFLAG_FUA) ? 4 : 0;
 	lba48 = (tf->flags & ATA_TFLAG_LBA48) ? 2 : 0;
 	write = (tf->flags & ATA_TFLAG_WRITE) ? 1 : 0;
@@ -252,6 +252,29 @@ static unsigned int ata_pack_xfermask(un
 		((udma_mask << ATA_SHIFT_UDMA) & ATA_MASK_UDMA);
 }
 
+/**
+ *	ata_unpack_xfermask - Unpack xfer_mask into pio, mwdma and udma masks
+ *	@xfer_mask: xfer_mask to unpack
+ *	@pio_mask: resulting pio_mask
+ *	@mwdma_mask: resulting mwdma_mask
+ *	@udma_mask: resulting udma_mask
+ *
+ *	Unpack @xfer_mask into @pio_mask, @mwdma_mask and @udma_mask.
+ *	Any NULL distination masks will be ignored.
+ */
+static void ata_unpack_xfermask(unsigned int xfer_mask,
+				unsigned int *pio_mask,
+				unsigned int *mwdma_mask,
+				unsigned int *udma_mask)
+{
+	if (pio_mask)
+		*pio_mask = (xfer_mask & ATA_MASK_PIO) >> ATA_SHIFT_PIO;
+	if (mwdma_mask)
+		*mwdma_mask = (xfer_mask & ATA_MASK_MWDMA) >> ATA_SHIFT_MWDMA;
+	if (udma_mask)
+		*udma_mask = (xfer_mask & ATA_MASK_UDMA) >> ATA_SHIFT_UDMA;
+}
+
 static const struct ata_xfer_ent {
 	unsigned int shift, bits;
 	u8 base;
@@ -372,6 +395,15 @@ static const char *ata_mode_string(unsig
 	return "<n/a>";
 }
 
+static void ata_dev_disable(struct ata_port *ap, struct ata_device *dev)
+{
+	if (ata_dev_present(dev)) {
+		printk(KERN_WARNING "ata%u: dev %u disabled\n",
+		       ap->id, dev->devno);
+		dev->class++;
+	}
+}
+
 /**
  *	ata_pio_devchk - PATA device presence detection
  *	@ap: ATA channel to examine
@@ -987,6 +1019,22 @@ ata_exec_internal(struct ata_port *ap, s
 
 	ata_qc_free(qc);
 
+	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
+	 * Until those drivers are fixed, we detect the condition
+	 * here, fail the command with AC_ERR_SYSTEM and reenable the
+	 * port.
+	 *
+	 * Note that this doesn't change any behavior as internal
+	 * command failure results in disabling the device in the
+	 * higher layer for LLDDs without new reset/EH callbacks.
+	 *
+	 * Kill the following code as soon as those drivers are fixed.
+	 */
+	if (ap->flags & ATA_FLAG_PORT_DISABLED) {
+		err_mask |= AC_ERR_SYSTEM;
+		ata_port_probe(ap);
+	}
+
 	return err_mask;
 }
 
@@ -1007,7 +1055,7 @@ unsigned int ata_pio_need_iordy(const st
 		return 0;
 	if (speed > 2)
 		return 1;
-		
+
 	/* If we have no drive specific rule, then PIO 2 is non IORDY */
 
 	if (adev->id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE */
@@ -1305,7 +1353,7 @@ static int ata_dev_configure(struct ata_
 		if (print_info)
 			printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
 			       ap->id, dev->devno);
-		ap->udma_mask &= ATA_UDMA5;
+		dev->udma_mask &= ATA_UDMA5;
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
@@ -1316,8 +1364,6 @@ static int ata_dev_configure(struct ata_
 	return 0;
 
 err_out_nosup:
-	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
-	       ap->id, dev->devno);
 	DPRINTK("EXIT, err\n");
 	return rc;
 }
@@ -1384,7 +1430,7 @@ static int ata_bus_probe(struct ata_port
 		}
 
 		if (ata_dev_configure(ap, dev, 1)) {
-			dev->class++;	/* disable device */
+			ata_dev_disable(ap, dev);
 			continue;
 		}
 
@@ -1530,6 +1576,23 @@ void sata_phy_reset(struct ata_port *ap)
 }
 
 /**
+ *	ata_dev_pair		-	return other device on cable
+ *	@ap: port
+ *	@adev: device
+ *
+ *	Obtain the other device on the same cable, or if none is
+ *	present NULL is returned
+ */
+
+struct ata_device *ata_dev_pair(struct ata_port *ap, struct ata_device *adev)
+{
+	struct ata_device *pair = &ap->device[1 - adev->devno];
+	if (!ata_dev_present(pair))
+		return NULL;
+	return pair;
+}
+
+/**
  *	ata_port_disable - Disable port.
  *	@ap: Port to be disabled.
  *
@@ -1557,7 +1620,7 @@ void ata_port_disable(struct ata_port *a
  * PIO 0-5, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
  * These were taken from ATA/ATAPI-6 standard, rev 0a, except
  * for PIO 5, which is a nonstandard extension and UDMA6, which
- * is currently supported only by Maxtor drives. 
+ * is currently supported only by Maxtor drives.
  */
 
 static const struct ata_timing ata_timing[] = {
@@ -1572,11 +1635,11 @@ static const struct ata_timing ata_timin
 	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
 
 /*	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 }, */
-                                          
+
 	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
 	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
 	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
-                                          
+
 	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
 	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
 	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
@@ -1629,7 +1692,7 @@ static const struct ata_timing* ata_timi
 	for (t = ata_timing; t->mode != speed; t++)
 		if (t->mode == 0xFF)
 			return NULL;
-	return t; 
+	return t;
 }
 
 int ata_timing_compute(struct ata_device *adev, unsigned short speed,
@@ -1639,7 +1702,7 @@ int ata_timing_compute(struct ata_device
 	struct ata_timing p;
 
 	/*
-	 * Find the mode. 
+	 * Find the mode.
 	 */
 
 	if (!(s = ata_timing_find_mode(speed)))
@@ -1697,20 +1760,28 @@ int ata_timing_compute(struct ata_device
 	return 0;
 }
 
-static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
+static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
 {
-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
-		return;
+	unsigned int err_mask;
+	int rc;
 
 	if (dev->xfer_shift == ATA_SHIFT_PIO)
 		dev->flags |= ATA_DFLAG_PIO;
 
-	ata_dev_set_xfermode(ap, dev);
+	err_mask = ata_dev_set_xfermode(ap, dev);
+	if (err_mask) {
+		printk(KERN_ERR
+		       "ata%u: failed to set xfermode (err_mask=0x%x)\n",
+		       ap->id, err_mask);
+		return -EIO;
+	}
 
-	if (ata_dev_revalidate(ap, dev, 0)) {
-		printk(KERN_ERR "ata%u: failed to revalidate after set "
-		       "xfermode, disabled\n", ap->id);
-		ata_port_disable(ap);
+	rc = ata_dev_revalidate(ap, dev, 0);
+	if (rc) {
+		printk(KERN_ERR
+		       "ata%u: failed to revalidate after set xfermode\n",
+		       ap->id);
+		return rc;
 	}
 
 	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
@@ -1719,6 +1790,7 @@ static void ata_dev_set_mode(struct ata_
 	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
 	       ap->id, dev->devno,
 	       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
+	return 0;
 }
 
 static int ata_host_set_pio(struct ata_port *ap)
@@ -1778,16 +1850,19 @@ static void ata_set_mode(struct ata_port
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		unsigned int xfer_mask;
+		unsigned int pio_mask, dma_mask;
 
 		if (!ata_dev_present(dev))
 			continue;
 
-		xfer_mask = ata_dev_xfermask(ap, dev);
+		ata_dev_xfermask(ap, dev);
 
-		dev->pio_mode = ata_xfer_mask2mode(xfer_mask & ATA_MASK_PIO);
-		dev->dma_mode = ata_xfer_mask2mode(xfer_mask & (ATA_MASK_MWDMA |
-								ATA_MASK_UDMA));
+		/* TODO: let LLDD filter dev->*_mask here */
+
+		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
+		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
+		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
+		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 	}
 
 	/* step 2: always set host PIO timings */
@@ -1799,11 +1874,15 @@ static void ata_set_mode(struct ata_port
 	ata_host_set_dma(ap);
 
 	/* step 4: update devices' xfer mode */
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ata_dev_set_mode(ap, &ap->device[i]);
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
 
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
-		return;
+		if (!ata_dev_present(dev))
+			continue;
+
+		if (ata_dev_set_mode(ap, dev))
+			goto err_out;
+	}
 
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
@@ -1999,11 +2078,11 @@ static unsigned int ata_bus_softreset(st
 	 */
 	msleep(150);
 
-	
-	/* Before we perform post reset processing we want to see if 
+
+	/* Before we perform post reset processing we want to see if
 	   the bus shows 0xFF because the odd clown forgets the D7 pulldown
 	   resistor */
-	
+
 	if (ata_check_status(ap) == 0xFF)
 		return 1;	/* Positive is failure for some reason */
 
@@ -2572,22 +2651,22 @@ static const char * const ata_dma_blackl
 	"SanDisk SDP3B-64", NULL,
 	"SANYO CD-ROM CRD", NULL,
 	"HITACHI CDR-8", NULL,
-	"HITACHI CDR-8335", NULL, 
+	"HITACHI CDR-8335", NULL,
 	"HITACHI CDR-8435", NULL,
-	"Toshiba CD-ROM XM-6202B", NULL, 
-	"TOSHIBA CD-ROM XM-1702BC", NULL, 
-	"CD-532E-A", NULL, 
-	"E-IDE CD-ROM CR-840", NULL, 
-	"CD-ROM Drive/F5A", NULL, 
-	"WPI CDD-820", NULL, 
+	"Toshiba CD-ROM XM-6202B", NULL,
+	"TOSHIBA CD-ROM XM-1702BC", NULL,
+	"CD-532E-A", NULL,
+	"E-IDE CD-ROM CR-840", NULL,
+	"CD-ROM Drive/F5A", NULL,
+	"WPI CDD-820", NULL,
 	"SAMSUNG CD-ROM SC-148C", NULL,
-	"SAMSUNG CD-ROM SC", NULL, 
+	"SAMSUNG CD-ROM SC", NULL,
 	"SanDisk SDP3B-64", NULL,
 	"ATAPI CD-ROM DRIVE 40X MAXIMUM",NULL,
 	"_NEC DV5800A", NULL,
 	"SAMSUNG CD-ROM SN-124", "N001"
 };
- 
+
 static int ata_strim(char *s, size_t len)
 {
 	len = strnlen(s, len);
@@ -2630,18 +2709,15 @@ static int ata_dma_blacklisted(const str
  *	@ap: Port on which the device to compute xfermask for resides
  *	@dev: Device to compute xfermask for
  *
- *	Compute supported xfermask of @dev.  This function is
- *	responsible for applying all known limits including host
- *	controller limits, device blacklist, etc...
+ *	Compute supported xfermask of @dev and store it in
+ *	dev->*_mask.  This function is responsible for applying all
+ *	known limits including host controller limits, device
+ *	blacklist, etc...
  *
  *	LOCKING:
  *	None.
- *
- *	RETURNS:
- *	Computed xfermask.
  */
-static unsigned int ata_dev_xfermask(struct ata_port *ap,
-				     struct ata_device *dev)
+static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev)
 {
 	unsigned long xfer_mask;
 	int i;
@@ -2654,6 +2730,8 @@ static unsigned int ata_dev_xfermask(str
 		struct ata_device *d = &ap->device[i];
 		if (!ata_dev_present(d))
 			continue;
+		xfer_mask &= ata_pack_xfermask(d->pio_mask, d->mwdma_mask,
+					       d->udma_mask);
 		xfer_mask &= ata_id_xfermask(d->id);
 		if (ata_dma_blacklisted(d))
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
@@ -2663,7 +2741,8 @@ static unsigned int ata_dev_xfermask(str
 		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
 		       "disabling DMA\n", ap->id, dev->devno);
 
-	return xfer_mask;
+	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
+			    &dev->udma_mask);
 }
 
 /**
@@ -2676,11 +2755,16 @@ static unsigned int ata_dev_xfermask(str
  *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask otherwise.
  */
 
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
+static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
+					 struct ata_device *dev)
 {
 	struct ata_taskfile tf;
+	unsigned int err_mask;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
@@ -2692,13 +2776,10 @@ static void ata_dev_set_xfermode(struct 
 	tf.protocol = ATA_PROT_NODATA;
 	tf.nsect = dev->xfer_mode;
 
-	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
-		printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
-		       ap->id);
-		ata_port_disable(ap);
-	}
+	err_mask = ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0);
 
-	DPRINTK("EXIT\n");
+	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	return err_mask;
 }
 
 /**
@@ -2775,7 +2856,7 @@ static void ata_sg_clean(struct ata_queu
 
 	if (qc->flags & ATA_QCFLAG_SG) {
 		if (qc->n_elem)
-			dma_unmap_sg(ap->host_set->dev, sg, qc->n_elem, dir);
+			dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
 		/* restore last sg */
 		sg[qc->orig_n_elem - 1].length += qc->pad_len;
 		if (pad_buf) {
@@ -2786,7 +2867,7 @@ static void ata_sg_clean(struct ata_queu
 		}
 	} else {
 		if (qc->n_elem)
-			dma_unmap_single(ap->host_set->dev,
+			dma_unmap_single(ap->dev,
 				sg_dma_address(&sg[0]), sg_dma_len(&sg[0]),
 				dir);
 		/* restore sg */
@@ -2997,7 +3078,7 @@ static int ata_sg_setup_one(struct ata_q
 		goto skip_map;
 	}
 
-	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
+	dma_address = dma_map_single(ap->dev, qc->buf_virt,
 				     sg->length, dir);
 	if (dma_mapping_error(dma_address)) {
 		/* restore sg */
@@ -3085,7 +3166,7 @@ static int ata_sg_setup(struct ata_queue
 	}
 
 	dir = qc->dma_dir;
-	n_elem = dma_map_sg(ap->host_set->dev, sg, pre_n_elem, dir);
+	n_elem = dma_map_sg(ap->dev, sg, pre_n_elem, dir);
 	if (n_elem < 1) {
 		/* restore last sg */
 		lsg->length += qc->pad_len;
@@ -3616,7 +3697,7 @@ static void ata_pio_error(struct ata_por
 	if (qc->tf.command != ATA_CMD_PACKET)
 		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
 
-	/* make sure qc->err_mask is available to 
+	/* make sure qc->err_mask is available to
 	 * know what's wrong and recover
 	 */
 	WARN_ON(qc->err_mask == 0);
@@ -4065,240 +4146,6 @@ unsigned int ata_qc_issue_prot(struct at
 }
 
 /**
- *	ata_bmdma_setup_mmio - Set up PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 dmactl;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-
-	/* load PRD table addr. */
-	mb();	/* make sure PRD table writes are visible to controller */
-	writel(ap->prd_dma, mmio + ATA_DMA_TABLE_OFS);
-
-	/* specify data direction, triple-check start bit is clear */
-	dmactl = readb(mmio + ATA_DMA_CMD);
-	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
-	if (!rw)
-		dmactl |= ATA_DMA_WR;
-	writeb(dmactl, mmio + ATA_DMA_CMD);
-
-	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
-}
-
-/**
- *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_start_mmio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-	u8 dmactl;
-
-	/* start host DMA transaction */
-	dmactl = readb(mmio + ATA_DMA_CMD);
-	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
-
-	/* Strictly, one may wish to issue a readb() here, to
-	 * flush the mmio write.  However, control also passes
-	 * to the hardware at this point, and it will interrupt
-	 * us when we are to resume control.  So, in effect,
-	 * we don't care when the mmio write flushes.
-	 * Further, a read of the DMA status register _immediately_
-	 * following the write may not be what certain flaky hardware
-	 * is expected, so I think it is best to not add a readb()
-	 * without first all the MMIO ATA cards/mobos.
-	 * Or maybe I'm just being paranoid.
-	 */
-}
-
-/**
- *	ata_bmdma_setup_pio - Set up PCI IDE BMDMA transaction (PIO)
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_setup_pio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 dmactl;
-
-	/* load PRD table addr. */
-	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
-
-	/* specify data direction, triple-check start bit is clear */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
-	if (!rw)
-		dmactl |= ATA_DMA_WR;
-	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-
-	/* issue r/w command */
-	ap->ops->exec_command(ap, &qc->tf);
-}
-
-/**
- *	ata_bmdma_start_pio - Start a PCI IDE BMDMA transaction (PIO)
- *	@qc: Info associated with this ATA transaction.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-static void ata_bmdma_start_pio (struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	u8 dmactl;
-
-	/* start host DMA transaction */
-	dmactl = inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	outb(dmactl | ATA_DMA_START,
-	     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-}
-
-
-/**
- *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Writes the ATA_DMA_START flag to the DMA command register.
- *
- *	May be used as the bmdma_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-void ata_bmdma_start(struct ata_queued_cmd *qc)
-{
-	if (qc->ap->flags & ATA_FLAG_MMIO)
-		ata_bmdma_start_mmio(qc);
-	else
-		ata_bmdma_start_pio(qc);
-}
-
-
-/**
- *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Writes address of PRD table to device's PRD Table Address
- *	register, sets the DMA control register, and calls
- *	ops->exec_command() to start the transfer.
- *
- *	May be used as the bmdma_setup() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-void ata_bmdma_setup(struct ata_queued_cmd *qc)
-{
-	if (qc->ap->flags & ATA_FLAG_MMIO)
-		ata_bmdma_setup_mmio(qc);
-	else
-		ata_bmdma_setup_pio(qc);
-}
-
-
-/**
- *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
- *	@ap: Port associated with this ATA transaction.
- *
- *	Clear interrupt and error flags in DMA status register.
- *
- *	May be used as the irq_clear() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-void ata_bmdma_irq_clear(struct ata_port *ap)
-{
-	if (!ap->ioaddr.bmdma_addr)
-		return;
-
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio =
-		      ((void __iomem *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
-		writeb(readb(mmio), mmio);
-	} else {
-		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
-		outb(inb(addr), addr);
-	}
-}
-
-
-/**
- *	ata_bmdma_status - Read PCI IDE BMDMA status
- *	@ap: Port associated with this ATA transaction.
- *
- *	Read and return BMDMA status register.
- *
- *	May be used as the bmdma_status() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-u8 ata_bmdma_status(struct ata_port *ap)
-{
-	u8 host_stat;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-		host_stat = readb(mmio + ATA_DMA_STATUS);
-	} else
-		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	return host_stat;
-}
-
-
-/**
- *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
- *	@qc: Command we are ending DMA for
- *
- *	Clears the ATA_DMA_START flag in the dma control register
- *
- *	May be used as the bmdma_stop() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-void ata_bmdma_stop(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
-
-		/* clear start/stop bit */
-		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-			mmio + ATA_DMA_CMD);
-	} else {
-		/* clear start/stop bit */
-		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
-			ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-	}
-
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_altstatus(ap);        /* dummy read */
-}
-
-/**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
@@ -4506,14 +4353,15 @@ int ata_device_resume(struct ata_port *a
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
  */
-int ata_device_suspend(struct ata_port *ap, struct ata_device *dev)
+int ata_device_suspend(struct ata_port *ap, struct ata_device *dev, pm_message_t state)
 {
 	if (!ata_dev_present(dev))
 		return 0;
 	if (dev->class == ATA_DEV_ATA)
 		ata_flush_cache(ap, dev);
 
-	ata_standby_drive(ap, dev);
+	if (state.event != PM_EVENT_FREEZE)
+		ata_standby_drive(ap, dev);
 	ap->flags |= ATA_FLAG_SUSPENDED;
 	return 0;
 }
@@ -4533,7 +4381,7 @@ int ata_device_suspend(struct ata_port *
 
 int ata_port_start (struct ata_port *ap)
 {
-	struct device *dev = ap->host_set->dev;
+	struct device *dev = ap->dev;
 	int rc;
 
 	ap->prd = dma_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma, GFP_KERNEL);
@@ -4566,7 +4414,7 @@ int ata_port_start (struct ata_port *ap)
 
 void ata_port_stop (struct ata_port *ap)
 {
-	struct device *dev = ap->host_set->dev;
+	struct device *dev = ap->dev;
 
 	dma_free_coherent(dev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 	ata_pad_free(ap, dev);
@@ -4632,6 +4480,7 @@ static void ata_host_init(struct ata_por
 	ap->host = host;
 	ap->ctl = ATA_DEVCTL_OBS;
 	ap->host_set = host_set;
+	ap->dev = ent->dev;
 	ap->port_no = port_no;
 	ap->hard_port_no =
 		ent->legacy_mode ? ent->hard_port_no : port_no;
@@ -4647,8 +4496,13 @@ static void ata_host_init(struct ata_por
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->device[i].devno = i;
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		dev->devno = i;
+		dev->pio_mask = UINT_MAX;
+		dev->mwdma_mask = UINT_MAX;
+		dev->udma_mask = UINT_MAX;
+	}
 
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
@@ -4842,7 +4696,7 @@ err_free_ret:
  *	ata_host_set_remove - PCI layer callback for device removal
  *	@host_set: ATA host set that was removed
  *
- *	Unregister all objects associated with this host set. Free those 
+ *	Unregister all objects associated with this host set. Free those
  *	objects.
  *
  *	LOCKING:
@@ -5114,6 +4968,8 @@ EXPORT_SYMBOL_GPL(ata_std_postreset);
 EXPORT_SYMBOL_GPL(ata_std_probe_reset);
 EXPORT_SYMBOL_GPL(ata_drive_probe_reset);
 EXPORT_SYMBOL_GPL(ata_dev_revalidate);
+EXPORT_SYMBOL_GPL(ata_dev_classify);
+EXPORT_SYMBOL_GPL(ata_dev_pair);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
@@ -5124,7 +4980,6 @@ EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
-EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index a1259b2..628191b 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -256,7 +256,7 @@ int ata_task_ioctl(struct scsi_device *s
 	scsi_cmd[14] = args[0];
 
 	/* Good values for timeout and retries?  Values below
-	   from scsi_ioctl_send_command() for default case... */	
+	   from scsi_ioctl_send_command() for default case... */
 	if (scsi_execute_req(scsidev, scsi_cmd, DMA_NONE, NULL, 0, &sshdr,
 			     (10*HZ), 5))
 		rc = -EIO;
@@ -267,20 +267,8 @@ int ata_task_ioctl(struct scsi_device *s
 
 int ata_scsi_ioctl(struct scsi_device *scsidev, int cmd, void __user *arg)
 {
-	struct ata_port *ap;
-	struct ata_device *dev;
 	int val = -EINVAL, rc = -EINVAL;
 
-	ap = (struct ata_port *) &scsidev->host->hostdata[0];
-	if (!ap)
-		goto out;
-
-	dev = ata_scsi_find_dev(ap, scsidev);
-	if (!dev) {
-		rc = -ENODEV;
-		goto out;
-	}
-
 	switch (cmd) {
 	case ATA_IOC_GET_IO32:
 		val = 0;
@@ -309,7 +297,6 @@ int ata_scsi_ioctl(struct scsi_device *s
 		break;
 	}
 
-out:
 	return rc;
 }
 
@@ -414,12 +401,12 @@ int ata_scsi_device_resume(struct scsi_d
 	return ata_device_resume(ap, dev);
 }
 
-int ata_scsi_device_suspend(struct scsi_device *sdev)
+int ata_scsi_device_suspend(struct scsi_device *sdev, pm_message_t state)
 {
 	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
 	struct ata_device *dev = &ap->device[sdev->id];
 
-	return ata_device_suspend(ap, dev);
+	return ata_device_suspend(ap, dev, state);
 }
 
 /**
@@ -438,7 +425,7 @@ int ata_scsi_device_suspend(struct scsi_
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
-void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc, 
+void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
 			u8 *ascq)
 {
 	int i;
@@ -495,7 +482,7 @@ void ata_to_sense_error(unsigned id, u8 
 		/* Look for drv_err */
 		for (i = 0; sense_table[i][0] != 0xFF; i++) {
 			/* Look for best matches first */
-			if ((sense_table[i][0] & drv_err) == 
+			if ((sense_table[i][0] & drv_err) ==
 			    sense_table[i][0]) {
 				*sk = sense_table[i][1];
 				*asc = sense_table[i][2];
@@ -518,7 +505,7 @@ void ata_to_sense_error(unsigned id, u8 
 		}
 	}
 	/* No error?  Undecoded? */
-	printk(KERN_WARNING "ata%u: no sense translation for status: 0x%02x\n", 
+	printk(KERN_WARNING "ata%u: no sense translation for status: 0x%02x\n",
 	       id, drv_stat);
 
 	/* We need a sensible error return here, which is tricky, and one
@@ -1150,14 +1137,14 @@ static unsigned int ata_scsi_verify_xlat
 
 		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
 			(u32)block, track, cyl, head, sect);
-		
-		/* Check whether the converted CHS can fit. 
-		   Cylinder: 0-65535 
+
+		/* Check whether the converted CHS can fit.
+		   Cylinder: 0-65535
 		   Head: 0-15
 		   Sector: 1-255*/
-		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect)) 
+		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
 			goto out_of_range;
-		
+
 		tf->command = ATA_CMD_VERIFY;
 		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
 		tf->lbal = sect;
@@ -1289,7 +1276,7 @@ static unsigned int ata_scsi_rw_xlat(str
 		tf->lbal = block & 0xff;
 
 		tf->device |= ATA_LBA;
-	} else { 
+	} else {
 		/* CHS */
 		u32 sect, head, cyl, track;
 
@@ -1309,8 +1296,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
 			(u32)block, track, cyl, head, sect);
 
-		/* Check whether the converted CHS can fit. 
-		   Cylinder: 0-65535 
+		/* Check whether the converted CHS can fit.
+		   Cylinder: 0-65535
 		   Head: 0-15
 		   Sector: 1-255*/
 		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
@@ -1697,7 +1684,7 @@ unsigned int ata_scsiop_inq_83(struct at
 
 	if (buflen > (ATA_SERNO_LEN + num + 3)) {
 		/* piv=0, assoc=lu, code_set=ACSII, designator=vendor */
-		rbuf[num + 0] = 2;	
+		rbuf[num + 0] = 2;
 		rbuf[num + 3] = ATA_SERNO_LEN;
 		num += 4;
 		ata_id_string(args->id, (unsigned char *) rbuf + num,
@@ -1707,8 +1694,8 @@ unsigned int ata_scsiop_inq_83(struct at
 	if (buflen > (sat_model_serial_desc_len + num + 3)) {
 		/* SAT defined lu model and serial numbers descriptor */
 		/* piv=0, assoc=lu, code_set=ACSII, designator=t10 vendor id */
-		rbuf[num + 0] = 2;	
-		rbuf[num + 1] = 1;	
+		rbuf[num + 0] = 2;
+		rbuf[num + 1] = 1;
 		rbuf[num + 3] = sat_model_serial_desc_len;
 		num += 4;
 		memcpy(rbuf + num, "ATA     ", 8);
@@ -2597,6 +2584,21 @@ static inline void ata_scsi_dump_cdb(str
 #endif
 }
 
+static inline void __ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *),
+				       struct ata_port *ap, struct ata_device *dev)
+{
+	if (dev->class == ATA_DEV_ATA) {
+		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
+							      cmd->cmnd[0]);
+
+		if (xlat_func)
+			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
+		else
+			ata_scsi_simulate(ap, dev, cmd, done);
+	} else
+		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
+}
+
 /**
  *	ata_scsi_queuecmd - Issue SCSI cdb to libata-managed device
  *	@cmd: SCSI command to be sent
@@ -2631,24 +2633,13 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 	ata_scsi_dump_cdb(ap, cmd);
 
 	dev = ata_scsi_find_dev(ap, scsidev);
-	if (unlikely(!dev)) {
+	if (likely(dev))
+		__ata_scsi_queuecmd(cmd, done, ap, dev);
+	else {
 		cmd->result = (DID_BAD_TARGET << 16);
 		done(cmd);
-		goto out_unlock;
 	}
 
-	if (dev->class == ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      cmd->cmnd[0]);
-
-		if (xlat_func)
-			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
-		else
-			ata_scsi_simulate(ap, dev, cmd, done);
-	} else
-		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
-
-out_unlock:
 	spin_unlock(&ap->host_set->lock);
 	spin_lock(shost->host_lock);
 	return 0;
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index e5b20c6..f77bf18 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -29,34 +29,6 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
- *  0.10
- *     - Fixed spurious interrupts issue seen with the Maxtor 6H500F0 500GB
- *       drive.  Also made the check_hotplug() callbacks return whether there
- *       was a hotplug interrupt or not.  This was not the source of the
- *       spurious interrupts, but is the right thing to do anyway.
- *
- *  0.09
- *     - Fixed bug introduced by 0.08's MCP51 and MCP55 support.
- *
- *  0.08
- *     - Added support for MCP51 and MCP55.
- *
- *  0.07
- *     - Added support for RAID class code.
- *
- *  0.06
- *     - Added generic SATA support by using a pci_device_id that filters on
- *       the IDE storage class code.
- *
- *  0.03
- *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
- *       mmio_base, which is only set for the CK804/MCP04 case.
- *
- *  0.02
- *     - Added support for CK804 SATA controller.
- *
- *  0.01
- *     - Initial revision.
  */
 
 #include <linux/config.h>
@@ -74,53 +46,55 @@
 #define DRV_NAME			"sata_nv"
 #define DRV_VERSION			"0.8"
 
-#define NV_PORTS			2
-#define NV_PIO_MASK			0x1f
-#define NV_MWDMA_MASK			0x07
-#define NV_UDMA_MASK			0x7f
-#define NV_PORT0_SCR_REG_OFFSET		0x00
-#define NV_PORT1_SCR_REG_OFFSET		0x40
-
-#define NV_INT_STATUS			0x10
-#define NV_INT_STATUS_CK804		0x440
-#define NV_INT_STATUS_PDEV_INT		0x01
-#define NV_INT_STATUS_PDEV_PM		0x02
-#define NV_INT_STATUS_PDEV_ADDED	0x04
-#define NV_INT_STATUS_PDEV_REMOVED	0x08
-#define NV_INT_STATUS_SDEV_INT		0x10
-#define NV_INT_STATUS_SDEV_PM		0x20
-#define NV_INT_STATUS_SDEV_ADDED	0x40
-#define NV_INT_STATUS_SDEV_REMOVED	0x80
-#define NV_INT_STATUS_PDEV_HOTPLUG	(NV_INT_STATUS_PDEV_ADDED | \
-					NV_INT_STATUS_PDEV_REMOVED)
-#define NV_INT_STATUS_SDEV_HOTPLUG	(NV_INT_STATUS_SDEV_ADDED | \
-					NV_INT_STATUS_SDEV_REMOVED)
-#define NV_INT_STATUS_HOTPLUG		(NV_INT_STATUS_PDEV_HOTPLUG | \
-					NV_INT_STATUS_SDEV_HOTPLUG)
-
-#define NV_INT_ENABLE			0x11
-#define NV_INT_ENABLE_CK804		0x441
-#define NV_INT_ENABLE_PDEV_MASK		0x01
-#define NV_INT_ENABLE_PDEV_PM		0x02
-#define NV_INT_ENABLE_PDEV_ADDED	0x04
-#define NV_INT_ENABLE_PDEV_REMOVED	0x08
-#define NV_INT_ENABLE_SDEV_MASK		0x10
-#define NV_INT_ENABLE_SDEV_PM		0x20
-#define NV_INT_ENABLE_SDEV_ADDED	0x40
-#define NV_INT_ENABLE_SDEV_REMOVED	0x80
-#define NV_INT_ENABLE_PDEV_HOTPLUG	(NV_INT_ENABLE_PDEV_ADDED | \
-					NV_INT_ENABLE_PDEV_REMOVED)
-#define NV_INT_ENABLE_SDEV_HOTPLUG	(NV_INT_ENABLE_SDEV_ADDED | \
-					NV_INT_ENABLE_SDEV_REMOVED)
-#define NV_INT_ENABLE_HOTPLUG		(NV_INT_ENABLE_PDEV_HOTPLUG | \
-					NV_INT_ENABLE_SDEV_HOTPLUG)
-
-#define NV_INT_CONFIG			0x12
-#define NV_INT_CONFIG_METHD		0x01 // 0 = INT, 1 = SMI
-
-// For PCI config register 20
-#define NV_MCP_SATA_CFG_20		0x50
-#define NV_MCP_SATA_CFG_20_SATA_SPACE_EN	0x04
+enum {
+	NV_PORTS			= 2,
+	NV_PIO_MASK			= 0x1f,
+	NV_MWDMA_MASK			= 0x07,
+	NV_UDMA_MASK			= 0x7f,
+	NV_PORT0_SCR_REG_OFFSET		= 0x00,
+	NV_PORT1_SCR_REG_OFFSET		= 0x40,
+
+	NV_INT_STATUS			= 0x10,
+	NV_INT_STATUS_CK804		= 0x440,
+	NV_INT_STATUS_PDEV_INT		= 0x01,
+	NV_INT_STATUS_PDEV_PM		= 0x02,
+	NV_INT_STATUS_PDEV_ADDED	= 0x04,
+	NV_INT_STATUS_PDEV_REMOVED	= 0x08,
+	NV_INT_STATUS_SDEV_INT		= 0x10,
+	NV_INT_STATUS_SDEV_PM		= 0x20,
+	NV_INT_STATUS_SDEV_ADDED	= 0x40,
+	NV_INT_STATUS_SDEV_REMOVED	= 0x80,
+	NV_INT_STATUS_PDEV_HOTPLUG	= (NV_INT_STATUS_PDEV_ADDED |
+					   NV_INT_STATUS_PDEV_REMOVED),
+	NV_INT_STATUS_SDEV_HOTPLUG	= (NV_INT_STATUS_SDEV_ADDED |
+					   NV_INT_STATUS_SDEV_REMOVED),
+	NV_INT_STATUS_HOTPLUG		= (NV_INT_STATUS_PDEV_HOTPLUG |
+					   NV_INT_STATUS_SDEV_HOTPLUG),
+
+	NV_INT_ENABLE			= 0x11,
+	NV_INT_ENABLE_CK804		= 0x441,
+	NV_INT_ENABLE_PDEV_MASK		= 0x01,
+	NV_INT_ENABLE_PDEV_PM		= 0x02,
+	NV_INT_ENABLE_PDEV_ADDED	= 0x04,
+	NV_INT_ENABLE_PDEV_REMOVED	= 0x08,
+	NV_INT_ENABLE_SDEV_MASK		= 0x10,
+	NV_INT_ENABLE_SDEV_PM		= 0x20,
+	NV_INT_ENABLE_SDEV_ADDED	= 0x40,
+	NV_INT_ENABLE_SDEV_REMOVED	= 0x80,
+	NV_INT_ENABLE_PDEV_HOTPLUG	= (NV_INT_ENABLE_PDEV_ADDED |
+					   NV_INT_ENABLE_PDEV_REMOVED),
+	NV_INT_ENABLE_SDEV_HOTPLUG	= (NV_INT_ENABLE_SDEV_ADDED |
+					   NV_INT_ENABLE_SDEV_REMOVED),
+	NV_INT_ENABLE_HOTPLUG		= (NV_INT_ENABLE_PDEV_HOTPLUG |
+					   NV_INT_ENABLE_SDEV_HOTPLUG),
+
+	NV_INT_CONFIG			= 0x12,
+	NV_INT_CONFIG_METHD		= 0x01, // 0 = INT, 1 = SMI
+
+	// For PCI config register 20
+	NV_MCP_SATA_CFG_20		= 0x50,
+	NV_MCP_SATA_CFG_20_SATA_SPACE_EN = 0x04,
+};
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static irqreturn_t nv_interrupt (int irq, void *dev_instance,
@@ -175,8 +149,6 @@ static const struct pci_device_id nv_pci
 	{ 0, } /* terminate list */
 };
 
-#define NV_HOST_FLAGS_SCR_MMIO	0x00000001
-
 struct nv_host_desc
 {
 	enum nv_host_type	host_type;
@@ -332,36 +304,23 @@ static irqreturn_t nv_interrupt (int irq
 
 static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	struct ata_host_set *host_set = ap->host_set;
-	struct nv_host *host = host_set->private_data;
-
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		return readl((void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
-	else
-		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	return ioread32((void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
-	struct ata_host_set *host_set = ap->host_set;
-	struct nv_host *host = host_set->private_data;
-
 	if (sc_reg > SCR_CONTROL)
 		return;
 
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		writel(val, (void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
-	else
-		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	iowrite32(val, (void __iomem *)ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
 static void nv_host_stop (struct ata_host_set *host_set)
 {
 	struct nv_host *host = host_set->private_data;
-	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 
 	// Disable hotplug event interrupts.
 	if (host->host_desc->disable_hotplug)
@@ -369,8 +328,7 @@ static void nv_host_stop (struct ata_hos
 
 	kfree(host);
 
-	if (host_set->mmio_base)
-		pci_iounmap(pdev, host_set->mmio_base);
+	ata_pci_host_stop(host_set);
 }
 
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -382,6 +340,7 @@ static int nv_init_one (struct pci_dev *
 	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
+	unsigned long base;
 
         // Make sure this is a SATA controller by counting the number of bars
         // (NVIDIA SATA controllers will always have six bars).  Otherwise,
@@ -426,31 +385,16 @@ static int nv_init_one (struct pci_dev *
 
 	probe_ent->private_data = host;
 
-	if (pci_resource_flags(pdev, 5) & IORESOURCE_MEM)
-		host->host_flags |= NV_HOST_FLAGS_SCR_MMIO;
-
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
-		unsigned long base;
-
-		probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
-		if (probe_ent->mmio_base == NULL) {
-			rc = -EIO;
-			goto err_out_free_host;
-		}
+	probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
+	if (!probe_ent->mmio_base) {
+		rc = -EIO;
+		goto err_out_free_host;
+	}
 
-		base = (unsigned long)probe_ent->mmio_base;
+	base = (unsigned long)probe_ent->mmio_base;
 
-		probe_ent->port[0].scr_addr =
-			base + NV_PORT0_SCR_REG_OFFSET;
-		probe_ent->port[1].scr_addr =
-			base + NV_PORT1_SCR_REG_OFFSET;
-	} else {
-
-		probe_ent->port[0].scr_addr =
-			pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
-		probe_ent->port[1].scr_addr =
-			pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
-	}
+	probe_ent->port[0].scr_addr = base + NV_PORT0_SCR_REG_OFFSET;
+	probe_ent->port[1].scr_addr = base + NV_PORT1_SCR_REG_OFFSET;
 
 	pci_set_master(pdev);
 
@@ -467,8 +411,7 @@ static int nv_init_one (struct pci_dev *
 	return 0;
 
 err_out_iounmap:
-	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		pci_iounmap(pdev, probe_ent->mmio_base);
+	pci_iounmap(pdev, probe_ent->mmio_base);
 err_out_free_host:
 	kfree(host);
 err_out_free_ent:
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 3e75d67..18c296c 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -371,7 +371,7 @@ static void sil_dev_config(struct ata_po
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
 		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
 		       ap->id, dev->devno, model_num);
-		ap->udma_mask &= ATA_UDMA5;
+		dev->udma_mask &= ATA_UDMA5;
 		return;
 	}
 }
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 5d01e5c..068c98a 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -342,7 +342,7 @@ static struct ata_port_info sil24_port_i
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil24_ops,
 	},
-	/* sil_3132 */ 
+	/* sil_3132 */
 	{
 		.sht		= &sil24_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
@@ -842,9 +842,10 @@ static void sil24_port_stop(struct ata_p
 static void sil24_host_stop(struct ata_host_set *host_set)
 {
 	struct sil24_host_priv *hpriv = host_set->private_data;
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
 
-	iounmap(hpriv->host_base);
-	iounmap(hpriv->port_base);
+	pci_iounmap(pdev, hpriv->host_base);
+	pci_iounmap(pdev, hpriv->port_base);
 	kfree(hpriv);
 }
 
@@ -871,26 +872,23 @@ static int sil24_init_one(struct pci_dev
 		goto out_disable;
 
 	rc = -ENOMEM;
-	/* ioremap mmio registers */
-	host_base = ioremap(pci_resource_start(pdev, 0),
-			    pci_resource_len(pdev, 0));
+	/* map mmio registers */
+	host_base = pci_iomap(pdev, 0, 0);
 	if (!host_base)
 		goto out_free;
-	port_base = ioremap(pci_resource_start(pdev, 2),
-			    pci_resource_len(pdev, 2));
+	port_base = pci_iomap(pdev, 2, 0);
 	if (!port_base)
 		goto out_free;
 
 	/* allocate & init probe_ent and hpriv */
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent)
 		goto out_free;
 
-	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		goto out_free;
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
@@ -907,7 +905,6 @@ static int sil24_init_one(struct pci_dev
 	probe_ent->mmio_base = port_base;
 	probe_ent->private_data = hpriv;
 
-	memset(hpriv, 0, sizeof(*hpriv));
 	hpriv->host_base = host_base;
 	hpriv->port_base = port_base;
 
@@ -1011,9 +1008,9 @@ static int sil24_init_one(struct pci_dev
 
  out_free:
 	if (host_base)
-		iounmap(host_base);
+		pci_iounmap(pdev, host_base);
 	if (port_base)
-		iounmap(port_base);
+		pci_iounmap(pdev, port_base);
 	kfree(probe_ent);
 	kfree(hpriv);
 	pci_release_regions(pdev);
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
index 8f50257..7ac5a5f 100644
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -44,6 +44,8 @@ enum {
 	uli_5287		= 1,
 	uli_5281		= 2,
 
+	uli_max_ports		= 4,
+
 	/* PCI configuration registers */
 	ULI5287_BASE		= 0x90, /* sata0 phy SCR registers */
 	ULI5287_OFFS		= 0x10, /* offset from sata0->sata1 phy regs */
@@ -51,6 +53,10 @@ enum {
 	ULI5281_OFFS		= 0x60, /* offset from sata0->sata1 phy regs */
 };
 
+struct uli_priv {
+	unsigned int		scr_cfg_addr[uli_max_ports];
+};
+
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
@@ -137,7 +143,8 @@ MODULE_VERSION(DRV_VERSION);
 
 static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
 {
-	return ap->ioaddr.scr_addr + (4 * sc_reg);
+	struct uli_priv *hpriv = ap->host_set->private_data;
+	return hpriv->scr_cfg_addr[ap->port_no] + (4 * sc_reg);
 }
 
 static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
@@ -182,6 +189,7 @@ static int uli_init_one (struct pci_dev 
 	int rc;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
+	struct uli_priv *hpriv;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -210,10 +218,18 @@ static int uli_init_one (struct pci_dev 
 		goto err_out_regions;
 	}
 
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv) {
+		rc = -ENOMEM;
+		goto err_out_probe_ent;
+	}
+
+	probe_ent->private_data = hpriv;
+
 	switch (board_idx) {
 	case uli_5287:
-		probe_ent->port[0].scr_addr = ULI5287_BASE;
-		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
+		hpriv->scr_cfg_addr[0] = ULI5287_BASE;
+		hpriv->scr_cfg_addr[1] = ULI5287_BASE + ULI5287_OFFS;
        		probe_ent->n_ports = 4;
 
        		probe_ent->port[2].cmd_addr = pci_resource_start(pdev, 0) + 8;
@@ -221,27 +237,27 @@ static int uli_init_one (struct pci_dev 
 		probe_ent->port[2].ctl_addr =
 			(pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[2].bmdma_addr = pci_resource_start(pdev, 4) + 16;
-		probe_ent->port[2].scr_addr = ULI5287_BASE + ULI5287_OFFS*4;
+		hpriv->scr_cfg_addr[2] = ULI5287_BASE + ULI5287_OFFS*4;
 
 		probe_ent->port[3].cmd_addr = pci_resource_start(pdev, 2) + 8;
 		probe_ent->port[3].altstatus_addr =
 		probe_ent->port[3].ctl_addr =
 			(pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[3].bmdma_addr = pci_resource_start(pdev, 4) + 24;
-		probe_ent->port[3].scr_addr = ULI5287_BASE + ULI5287_OFFS*5;
+		hpriv->scr_cfg_addr[3] = ULI5287_BASE + ULI5287_OFFS*5;
 
 		ata_std_ports(&probe_ent->port[2]);
 		ata_std_ports(&probe_ent->port[3]);
 		break;
 
 	case uli_5289:
-		probe_ent->port[0].scr_addr = ULI5287_BASE;
-		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
+		hpriv->scr_cfg_addr[0] = ULI5287_BASE;
+		hpriv->scr_cfg_addr[1] = ULI5287_BASE + ULI5287_OFFS;
 		break;
 
 	case uli_5281:
-		probe_ent->port[0].scr_addr = ULI5281_BASE;
-		probe_ent->port[1].scr_addr = ULI5281_BASE + ULI5281_OFFS;
+		hpriv->scr_cfg_addr[0] = ULI5281_BASE;
+		hpriv->scr_cfg_addr[1] = ULI5281_BASE + ULI5281_OFFS;
 		break;
 
 	default:
@@ -258,9 +274,10 @@ static int uli_init_one (struct pci_dev 
 
 	return 0;
 
+err_out_probe_ent:
+	kfree(probe_ent);
 err_out_regions:
 	pci_release_regions(pdev);
-
 err_out:
 	if (!pci_dev_busy)
 		pci_disable_device(pdev);
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 9701a80..836bbbb 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -230,11 +230,11 @@ static irqreturn_t vsc_sata_interrupt (i
 					handled += ata_host_intr(ap, qc);
 				} else if (is_vsc_sata_int_err(i, int_status)) {
 					/*
-					 * On some chips (i.e. Intel 31244), an error 
+					 * On some chips (i.e. Intel 31244), an error
 					 * interrupt will sneak in at initialization
 					 * time (phy state changes).  Clearing the SCR
 					 * error register is not required, but it prevents
-					 * the phy state change interrupts from recurring 
+					 * the phy state change interrupts from recurring
 					 * later.
 					 */
 					u32 err_status;
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 8905549..a6fde52 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -286,7 +286,7 @@ static int scsi_bus_suspend(struct devic
 		return err;
 
 	if (sht->suspend)
-		err = sht->suspend(sdev);
+		err = sht->suspend(sdev, state);
 
 	return err;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7a54244..0471922 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -358,6 +358,11 @@ struct ata_device {
 	unsigned int		max_sectors;	/* per-device max sectors */
 	unsigned int		cdb_len;
 
+	/* per-dev xfer mask */
+	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
+	unsigned int		udma_mask;
+
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
@@ -395,6 +400,7 @@ struct ata_port {
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
+	struct device 		*dev;
 
 	struct work_struct	port_task;
 
@@ -515,9 +521,9 @@ extern void ata_eh_qc_retry(struct ata_q
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int ata_scsi_device_resume(struct scsi_device *);
-extern int ata_scsi_device_suspend(struct scsi_device *);
+extern int ata_scsi_device_suspend(struct scsi_device *, pm_message_t state);
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
-extern int ata_device_suspend(struct ata_port *, struct ata_device *);
+extern int ata_device_suspend(struct ata_port *, struct ata_device *, pm_message_t state);
 extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
@@ -568,6 +574,8 @@ extern int ata_std_bios_param(struct scs
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
+extern struct ata_device *ata_dev_pair(struct ata_port *ap, 
+				       struct ata_device *adev);
 
 /*
  * Timing helpers
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index a6cf3e5..dc6862d 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -286,7 +286,7 @@ struct scsi_host_template {
 	 * suspend support
 	 */
 	int (*resume)(struct scsi_device *);
-	int (*suspend)(struct scsi_device *);
+	int (*suspend)(struct scsi_device *, pm_message_t state);
 
 	/*
 	 * Name of proc directory
