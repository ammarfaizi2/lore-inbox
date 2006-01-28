Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWA1SZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWA1SZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWA1SZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:25:29 -0500
Received: from havoc.gtf.org ([69.61.125.42]:5867 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751610AbWA1SZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:25:26 -0500
Date: Sat, 28 Jan 2006 13:25:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libata queue updated
Message-ID: <20060128182522.GA31458@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Testing and merge point in Tejun's flood of patches :)  The patch
below is against current linux-2.6.git.




The 'upstream' branch of
rsync://rsync.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

contains the following updates:

 drivers/scsi/ahci.c         |  108 ++++---
 drivers/scsi/ata_piix.c     |   54 ++-
 drivers/scsi/libata-core.c  |  625 +++++++++++++++++++++++++++++++++-----------
 drivers/scsi/libata-scsi.c  |  140 ++++++---
 drivers/scsi/libata.h       |    2 
 drivers/scsi/pdc_adma.c     |    4 
 drivers/scsi/sata_mv.c      |   18 -
 drivers/scsi/sata_promise.c |  120 ++++++--
 drivers/scsi/sata_qstor.c   |    4 
 drivers/scsi/sata_sil24.c   |   16 -
 drivers/scsi/sata_sx4.c     |   16 -
 drivers/scsi/scsi_error.c   |    7 
 include/linux/ata.h         |   12 
 include/linux/libata.h      |   98 +++++-
 include/scsi/scsi_eh.h      |    3 
 15 files changed, 872 insertions(+), 355 deletions(-)

Albert Lee:
      libata CHS: LBA28/LBA48 optimization (revise #6)

Jeff Garzik:
      [libata ata_piix] Fix ICH6/7 map value interpretation

Luke Kosewski:
      [libata sata_promise] add correct read/write of hotplug registers for SATAII devices

Randy Dunlap:
      
      Various libata documentation updates.

Tejun Heo:
      libata: separate out ata_sata_print_link_status
      ahci: separate out ahci_stop/start_engine
      ahci: separate out ahci_dev_classify
      ata_piix: fix MAP VALUE interpretation for for ICH6/7
      libata: fold __ata_qc_complete() into ata_qc_free()
      libata: make the owner of a qc responsible for freeing it
      libata: fix ata_qc_issue() error handling
      ahci: fix err_mask setting in ahci_host_intr
      libata: add detailed AC_ERR_* flags
      libata: return AC_ERR_* from issue functions
      SCSI: export scsi_eh_finish_cmd() and scsi_eh_flush_done_q()
      libata: implement and apply ata_eh_qc_complete/retry()
      libata: create pio/atapi task queueing wrappers
      ahci: stop engine during hard reset
      ahci: add constants for SRST
      libata: export ata_busy_sleep
      libata: modify ata_dev_try_classify
      libata: new ->probe_reset operation
      libata: implement ata_drive_probe_reset()
      libata: implement standard reset component operations and ->probe_reset

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 19bd346..5caf6de 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -66,6 +66,8 @@ enum {
 	AHCI_IRQ_ON_SG		= (1 << 31),
 	AHCI_CMD_ATAPI		= (1 << 5),
 	AHCI_CMD_WRITE		= (1 << 6),
+	AHCI_CMD_RESET		= (1 << 8),
+	AHCI_CMD_CLR_BUSY	= (1 << 10),
 
 	RX_FIS_D2H_REG		= 0x40,	/* offset of D2H Register FIS data */
 
@@ -85,6 +87,7 @@ enum {
 
 	/* HOST_CAP bits */
 	HOST_CAP_64		= (1 << 31), /* PCI DAC (64-bit DMA) support */
+	HOST_CAP_CLO		= (1 << 24), /* Command List Override support */
 
 	/* registers for each SATA port */
 	PORT_LST_ADDR		= 0x00, /* command list DMA addr */
@@ -138,6 +141,7 @@ enum {
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
 	PORT_CMD_FIS_RX		= (1 << 4), /* Enable FIS receive DMA engine */
+	PORT_CMD_CLO		= (1 << 3), /* Command list override */
 	PORT_CMD_POWER_ON	= (1 << 2), /* Power up device */
 	PORT_CMD_SPIN_UP	= (1 << 1), /* Spin up device */
 	PORT_CMD_START		= (1 << 0), /* Enable port DMA engine */
@@ -184,7 +188,7 @@ struct ahci_port_priv {
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void ahci_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static int ahci_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 static void ahci_phy_reset(struct ata_port *ap);
 static void ahci_irq_clear(struct ata_port *ap);
@@ -446,25 +450,72 @@ static void ahci_scr_write (struct ata_p
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void ahci_phy_reset(struct ata_port *ap)
+static int ahci_stop_engine(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	int work;
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp &= ~PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+
+	/* wait for engine to stop.  TODO: this could be
+	 * as long as 500 msec
+	 */
+	work = 1000;
+	while (work-- > 0) {
+		tmp = readl(port_mmio + PORT_CMD);
+		if ((tmp & PORT_CMD_LIST_ON) == 0)
+			return 0;
+		udelay(10);
+	}
+
+	return -EIO;
+}
+
+static void ahci_start_engine(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->host_set->mmio_base;
+	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_CMD);
+	tmp |= PORT_CMD_START;
+	writel(tmp, port_mmio + PORT_CMD);
+	readl(port_mmio + PORT_CMD); /* flush */
+}
+
+static unsigned int ahci_dev_classify(struct ata_port *ap)
 {
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	struct ata_taskfile tf;
+	u32 tmp;
+
+	tmp = readl(port_mmio + PORT_SIG);
+	tf.lbah		= (tmp >> 24)	& 0xff;
+	tf.lbam		= (tmp >> 16)	& 0xff;
+	tf.lbal		= (tmp >> 8)	& 0xff;
+	tf.nsect	= (tmp)		& 0xff;
+
+	return ata_dev_classify(&tf);
+}
+
+static void ahci_phy_reset(struct ata_port *ap)
+{
+	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
 	struct ata_device *dev = &ap->device[0];
 	u32 new_tmp, tmp;
 
+	ahci_stop_engine(ap);
 	__sata_phy_reset(ap);
+	ahci_start_engine(ap);
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
 
-	tmp = readl(port_mmio + PORT_SIG);
-	tf.lbah		= (tmp >> 24)	& 0xff;
-	tf.lbam		= (tmp >> 16)	& 0xff;
-	tf.lbal		= (tmp >> 8)	& 0xff;
-	tf.nsect	= (tmp)		& 0xff;
-
-	dev->class = ata_dev_classify(&tf);
+	dev->class = ahci_dev_classify(ap);
 	if (!ata_dev_present(dev)) {
 		ata_port_disable(ap);
 		return;
@@ -572,7 +623,6 @@ static void ahci_restart_port(struct ata
 	void __iomem *mmio = ap->host_set->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	u32 tmp;
-	int work;
 
 	if ((ap->device[0].class != ATA_DEV_ATAPI) ||
 	    ((irq_stat & PORT_IRQ_TF_ERR) == 0))
@@ -588,20 +638,7 @@ static void ahci_restart_port(struct ata
 			readl(port_mmio + PORT_SCR_ERR));
 
 	/* stop DMA */
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= ~PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-
-	/* wait for engine to stop.  TODO: this could be
-	 * as long as 500 msec
-	 */
-	work = 1000;
-	while (work-- > 0) {
-		tmp = readl(port_mmio + PORT_CMD);
-		if ((tmp & PORT_CMD_LIST_ON) == 0)
-			break;
-		udelay(10);
-	}
+	ahci_stop_engine(ap);
 
 	/* clear SATA phy error, if any */
 	tmp = readl(port_mmio + PORT_SCR_ERR);
@@ -620,10 +657,7 @@ static void ahci_restart_port(struct ata
 	}
 
 	/* re-start DMA */
-	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START;
-	writel(tmp, port_mmio + PORT_CMD);
-	readl(port_mmio + PORT_CMD); /* flush */
+	ahci_start_engine(ap);
 }
 
 static void ahci_eng_timeout(struct ata_port *ap)
@@ -644,19 +678,13 @@ static void ahci_eng_timeout(struct ata_
 		       ap->id);
 	} else {
 		ahci_restart_port(ap, readl(port_mmio + PORT_IRQ_STAT));
-
-		/* hack alert!  We cannot use the supplied completion
-	 	 * function from inside the ->eh_strategy_handler() thread.
-	 	 * libata is the only user of ->eh_strategy_handler() in
-	 	 * any kernel, so the default scsi_done() assumes it is
-	 	 * not being called from the SCSI EH.
-	 	 */
-		qc->scsidone = scsi_finish_command;
-		qc->err_mask |= AC_ERR_OTHER;
-		ata_qc_complete(qc);
+		qc->err_mask |= AC_ERR_TIMEOUT;
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	if (qc)
+		ata_eh_qc_complete(qc);
 }
 
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
@@ -693,7 +721,7 @@ static inline int ahci_host_intr(struct 
 		ahci_restart_port(ap, status);
 
 		if (qc) {
-			qc->err_mask |= AC_ERR_OTHER;
+			qc->err_mask |= err_mask;
 			ata_qc_complete(qc);
 		}
 	}
@@ -772,7 +800,7 @@ static irqreturn_t ahci_interrupt (int i
 	return IRQ_RETVAL(handled);
 }
 
-static int ahci_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index fc3ca05..49cc420 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -101,9 +101,11 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
-	PIIX_FLAG_AHCI		= (1 << 28), /* AHCI possible */
-	PIIX_FLAG_CHECKINTR	= (1 << 29), /* make sure PCI INTx enabled */
-	PIIX_FLAG_COMBINED	= (1 << 30), /* combined mode possible */
+	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
+	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
+	PIIX_FLAG_COMBINED	= (1 << 29), /* combined mode possible */
+	/* ICH6/7 use different scheme for map value */
+	PIIX_FLAG_COMBINED_ICH6	= PIIX_FLAG_COMBINED | (1 << 30),
 
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
@@ -297,8 +299,8 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
-				  ATA_FLAG_SLAVE_POSS,
+				  PIIX_FLAG_COMBINED_ICH6 |
+				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -309,8 +311,9 @@ static struct ata_port_info piix_port_in
 	{
 		.sht		= &piix_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST |
-				  PIIX_FLAG_COMBINED | PIIX_FLAG_CHECKINTR |
-				  ATA_FLAG_SLAVE_POSS | PIIX_FLAG_AHCI,
+				  PIIX_FLAG_COMBINED_ICH6 |
+				  PIIX_FLAG_CHECKINTR | ATA_FLAG_SLAVE_POSS |
+				  PIIX_FLAG_AHCI,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -627,6 +630,7 @@ static int piix_disable_ahci(struct pci_
 
 /**
  *	piix_check_450nx_errata	-	Check for problem 450NX setup
+ *	@ata_dev: the PCI device to check
  *	
  *	Check for the present of 450NX errata #19 and errata #25. If
  *	they are found return an error code so we can turn off DMA
@@ -680,6 +684,7 @@ static int piix_init_one (struct pci_dev
 	struct ata_port_info *port_info[2];
 	unsigned int combined = 0;
 	unsigned int pata_chan = 0, sata_chan = 0;
+	unsigned long host_flags;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
@@ -692,7 +697,9 @@ static int piix_init_one (struct pci_dev
 	port_info[0] = &piix_port_info[ent->driver_data];
 	port_info[1] = &piix_port_info[ent->driver_data];
 
-	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
+	host_flags = port_info[0]->host_flags;
+
+	if (host_flags & PIIX_FLAG_AHCI) {
 		u8 tmp;
 		pci_read_config_byte(pdev, PIIX_SCC, &tmp);
 		if (tmp == PIIX_AHCI_DEVICE) {
@@ -702,16 +709,35 @@ static int piix_init_one (struct pci_dev
 		}
 	}
 
-	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {
+	if (host_flags & PIIX_FLAG_COMBINED) {
 		u8 tmp;
 		pci_read_config_byte(pdev, ICH5_PMR, &tmp);
 
-		if (tmp & PIIX_COMB) {
-			combined = 1;
-			if (tmp & PIIX_COMB_PATA_P0)
+		if (host_flags & PIIX_FLAG_COMBINED_ICH6) {
+			switch (tmp & 0x3) {
+			case 0:
+				break;
+			case 1:
+				combined = 1;
 				sata_chan = 1;
-			else
+				break;
+			case 2:
+				combined = 1;
 				pata_chan = 1;
+				break;
+			case 3:
+				dev_printk(KERN_WARNING, &pdev->dev,
+					   "invalid MAP value %u\n", tmp);
+				break;
+			}
+		} else {
+			if (tmp & PIIX_COMB) {
+				combined = 1;
+				if (tmp & PIIX_COMB_PATA_P0)
+					sata_chan = 1;
+				else
+					pata_chan = 1;
+			}
 		}
 	}
 
@@ -721,7 +747,7 @@ static int piix_init_one (struct pci_dev
 	 * MSI is disabled (and it is disabled, as we don't use
 	 * message-signalled interrupts currently).
 	 */
-	if (port_info[0]->host_flags & PIIX_FLAG_CHECKINTR)
+	if (host_flags & PIIX_FLAG_CHECKINTR)
 		pci_intx(pdev, 1);
 
 	if (combined) {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 46c4cdb..249e67f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -61,9 +61,6 @@
 
 #include "libata.h"
 
-static unsigned int ata_busy_sleep (struct ata_port *ap,
-				    unsigned long tmout_pat,
-			    	    unsigned long tmout);
 static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev);
 static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
@@ -73,7 +70,6 @@ static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(const struct ata_port *ap,
 				u8 *xfer_mode_out,
 				unsigned int *xfer_shift_out);
-static void __ata_qc_complete(struct ata_queued_cmd *qc);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -834,6 +830,7 @@ unsigned int ata_dev_classify(const stru
  *	ata_dev_try_classify - Parse returned ATA device signature
  *	@ap: ATA channel to examine
  *	@device: Device to examine (starting at zero)
+ *	@r_err: Value of error register on completion
  *
  *	After an event -- SRST, E.D.D., or SATA COMRESET -- occurs,
  *	an ATA/ATAPI-defined set of values is placed in the ATA
@@ -846,11 +843,14 @@ unsigned int ata_dev_classify(const stru
  *
  *	LOCKING:
  *	caller.
+ *
+ *	RETURNS:
+ *	Device type - %ATA_DEV_ATA, %ATA_DEV_ATAPI or %ATA_DEV_NONE.
  */
 
-static u8 ata_dev_try_classify(struct ata_port *ap, unsigned int device)
+static unsigned int
+ata_dev_try_classify(struct ata_port *ap, unsigned int device, u8 *r_err)
 {
-	struct ata_device *dev = &ap->device[device];
 	struct ata_taskfile tf;
 	unsigned int class;
 	u8 err;
@@ -861,8 +861,8 @@ static u8 ata_dev_try_classify(struct at
 
 	ap->ops->tf_read(ap, &tf);
 	err = tf.feature;
-
-	dev->class = ATA_DEV_NONE;
+	if (r_err)
+		*r_err = err;
 
 	/* see if device passed diags */
 	if (err == 1)
@@ -870,18 +870,16 @@ static u8 ata_dev_try_classify(struct at
 	else if ((device == 0) && (err == 0x81))
 		/* do nothing */ ;
 	else
-		return err;
+		return ATA_DEV_NONE;
 
-	/* determine if device if ATA or ATAPI */
+	/* determine if device is ATA or ATAPI */
 	class = ata_dev_classify(&tf);
+
 	if (class == ATA_DEV_UNKNOWN)
-		return err;
+		return ATA_DEV_NONE;
 	if ((class == ATA_DEV_ATA) && (ata_chk_status(ap) == 0))
-		return err;
-
-	dev->class = class;
-
-	return err;
+		return ATA_DEV_NONE;
+	return class;
 }
 
 /**
@@ -1073,24 +1071,30 @@ static unsigned int ata_pio_modes(const 
 	   timing API will get this right anyway */
 }
 
-struct ata_exec_internal_arg {
-	unsigned int err_mask;
-	struct ata_taskfile *tf;
-	struct completion *waiting;
-};
+static inline void
+ata_queue_packet_task(struct ata_port *ap)
+{
+	queue_work(ata_wq, &ap->packet_task);
+}
 
-int ata_qc_complete_internal(struct ata_queued_cmd *qc)
+static inline void
+ata_queue_pio_task(struct ata_port *ap)
 {
-	struct ata_exec_internal_arg *arg = qc->private_data;
-	struct completion *waiting = arg->waiting;
+	queue_work(ata_wq, &ap->pio_task);
+}
 
-	if (!(qc->err_mask & ~AC_ERR_DEV))
-		qc->ap->ops->tf_read(qc->ap, arg->tf);
-	arg->err_mask = qc->err_mask;
-	arg->waiting = NULL;
-	complete(waiting);
+static inline void
+ata_queue_delayed_pio_task(struct ata_port *ap, unsigned long delay)
+{
+	queue_delayed_work(ata_wq, &ap->pio_task, delay);
+}
 
-	return 0;
+void ata_qc_complete_internal(struct ata_queued_cmd *qc)
+{
+	struct completion *waiting = qc->private_data;
+
+	qc->ap->ops->tf_read(qc->ap, &qc->tf);
+	complete(waiting);
 }
 
 /**
@@ -1121,7 +1125,7 @@ ata_exec_internal(struct ata_port *ap, s
 	struct ata_queued_cmd *qc;
 	DECLARE_COMPLETION(wait);
 	unsigned long flags;
-	struct ata_exec_internal_arg arg;
+	unsigned int err_mask;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
@@ -1135,13 +1139,12 @@ ata_exec_internal(struct ata_port *ap, s
 		qc->nsect = buflen / ATA_SECT_SIZE;
 	}
 
-	arg.waiting = &wait;
-	arg.tf = tf;
-	qc->private_data = &arg;
+	qc->private_data = &wait;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	if (ata_qc_issue(qc))
-		goto issue_fail;
+	qc->err_mask = ata_qc_issue(qc);
+	if (qc->err_mask)
+		ata_qc_complete(qc);
 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
@@ -1154,8 +1157,8 @@ ata_exec_internal(struct ata_port *ap, s
 		 * before the caller cleans up, it will result in a
 		 * spurious interrupt.  We can live with that.
 		 */
-		if (arg.waiting) {
-			qc->err_mask = AC_ERR_OTHER;
+		if (qc->flags & ATA_QCFLAG_ACTIVE) {
+			qc->err_mask = AC_ERR_TIMEOUT;
 			ata_qc_complete(qc);
 			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
 			       ap->id, command);
@@ -1164,12 +1167,12 @@ ata_exec_internal(struct ata_port *ap, s
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 
-	return arg.err_mask;
+	*tf = qc->tf;
+	err_mask = qc->err_mask;
 
- issue_fail:
 	ata_qc_free(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-	return AC_ERR_OTHER;
+
+	return err_mask;
 }
 
 /**
@@ -1439,12 +1442,11 @@ static inline u8 ata_dev_knobble(const s
 }
 
 /**
- * 	ata_dev_config - Run device specific handlers and check for
- * 			 SATA->PATA bridges
- * 	@ap: Bus
- * 	@i:  Device
+ * ata_dev_config - Run device specific handlers & check for SATA->PATA bridges
+ * @ap: Bus
+ * @i:  Device
  *
- * 	LOCKING:
+ * LOCKING:
  */
 
 void ata_dev_config(struct ata_port *ap, unsigned int i)
@@ -1482,7 +1484,24 @@ static int ata_bus_probe(struct ata_port
 {
 	unsigned int i, found = 0;
 
-	ap->ops->phy_reset(ap);
+	if (ap->ops->probe_reset) {
+		unsigned int classes[ATA_MAX_DEVICES];
+		int rc;
+
+		ata_port_probe(ap);
+
+		rc = ap->ops->probe_reset(ap, classes);
+		if (rc == 0) {
+			for (i = 0; i < ATA_MAX_DEVICES; i++)
+				ap->device[i].class = classes[i];
+		} else {
+			printk(KERN_ERR "ata%u: probe reset failed, "
+			       "disabling port\n", ap->id);
+			ata_port_disable(ap);
+		}
+	} else
+		ap->ops->phy_reset(ap);
+
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out;
 
@@ -1526,6 +1545,41 @@ void ata_port_probe(struct ata_port *ap)
 }
 
 /**
+ *	sata_print_link_status - Print SATA link status
+ *	@ap: SATA port to printk link status about
+ *
+ *	This function prints link speed and status of a SATA link.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void sata_print_link_status(struct ata_port *ap)
+{
+	u32 sstatus, tmp;
+	const char *speed;
+
+	if (!ap->ops->scr_read)
+		return;
+
+	sstatus = scr_read(ap, SCR_STATUS);
+
+	if (sata_dev_present(ap)) {
+		tmp = (sstatus >> 4) & 0xf;
+		if (tmp & (1 << 0))
+			speed = "1.5";
+		else if (tmp & (1 << 1))
+			speed = "3.0";
+		else
+			speed = "<unknown>";
+		printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
+		       ap->id, speed, sstatus);
+	} else {
+		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
+		       ap->id, sstatus);
+	}
+}
+
+/**
  *	__sata_phy_reset - Wake/reset a low-level SATA PHY
  *	@ap: SATA port associated with target SATA PHY.
  *
@@ -1559,27 +1613,14 @@ void __sata_phy_reset(struct ata_port *a
 			break;
 	} while (time_before(jiffies, timeout));
 
-	/* TODO: phy layer with polling, timeouts, etc. */
-	sstatus = scr_read(ap, SCR_STATUS);
-	if (sata_dev_present(ap)) {
-		const char *speed;
-		u32 tmp;
+	/* print link status */
+	sata_print_link_status(ap);
 
-		tmp = (sstatus >> 4) & 0xf;
-		if (tmp & (1 << 0))
-			speed = "1.5";
-		else if (tmp & (1 << 1))
-			speed = "3.0";
-		else
-			speed = "<unknown>";
-		printk(KERN_INFO "ata%u: SATA link up %s Gbps (SStatus %X)\n",
-		       ap->id, speed, sstatus);
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (sata_dev_present(ap))
 		ata_port_probe(ap);
-	} else {
-		printk(KERN_INFO "ata%u: SATA link down (SStatus %X)\n",
-		       ap->id, sstatus);
+	else
 		ata_port_disable(ap);
-	}
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
@@ -1752,9 +1793,9 @@ int ata_timing_compute(struct ata_device
 	ata_timing_quantize(t, t, T, UT);
 
 	/*
-	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
-	 * and some other commands. We have to ensure that the DMA cycle timing is
-	 * slower/equal than the fastest PIO timing.
+	 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY,
+	 * S.M.A.R.T * and some other commands. We have to ensure that the
+	 * DMA cycle timing is slower/equal than the fastest PIO timing.
 	 */
 
 	if (speed > XFER_PIO_4) {
@@ -1763,7 +1804,7 @@ int ata_timing_compute(struct ata_device
 	}
 
 	/*
-	 * Lenghten active & recovery time so that cycle time is correct.
+	 * Lengthen active & recovery time so that cycle time is correct.
 	 */
 
 	if (t->act8b + t->rec8b < t->cyc8b) {
@@ -1882,7 +1923,6 @@ static void ata_host_set_dma(struct ata_
  *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
- *
  */
 static void ata_set_mode(struct ata_port *ap)
 {
@@ -1931,12 +1971,10 @@ err_out:
  *	or a timeout occurs.
  *
  *	LOCKING: None.
- *
  */
 
-static unsigned int ata_busy_sleep (struct ata_port *ap,
-				    unsigned long tmout_pat,
-			    	    unsigned long tmout)
+unsigned int ata_busy_sleep (struct ata_port *ap,
+			     unsigned long tmout_pat, unsigned long tmout)
 {
 	unsigned long timer_start, timeout;
 	u8 status;
@@ -2155,9 +2193,9 @@ void ata_bus_reset(struct ata_port *ap)
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
 	 */
-	err = ata_dev_try_classify(ap, 0);
+	ap->device[0].class = ata_dev_try_classify(ap, 0, &err);
 	if ((slave_possible) && (err != 0x81))
-		ata_dev_try_classify(ap, 1);
+		ap->device[1].class = ata_dev_try_classify(ap, 1, &err);
 
 	/* re-enable interrupts */
 	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
@@ -2192,6 +2230,296 @@ err_out:
 	DPRINTK("EXIT\n");
 }
 
+/**
+ *	ata_std_softreset - reset host port via ATA SRST
+ *	@ap: port to reset
+ *	@verbose: fail verbosely
+ *	@classes: resulting classes of attached devices
+ *
+ *	Reset host port using ATA SRST.  This function is to be used
+ *	as standard callback for ata_drive_*_reset() functions.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_std_softreset(struct ata_port *ap, int verbose, unsigned int *classes)
+{
+	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
+	unsigned int devmask = 0, err_mask;
+	u8 err;
+
+	DPRINTK("ENTER\n");
+
+	/* determine if device 0/1 are present */
+	if (ata_devchk(ap, 0))
+		devmask |= (1 << 0);
+	if (slave_possible && ata_devchk(ap, 1))
+		devmask |= (1 << 1);
+
+	/* devchk reports device presence without actual device on
+	 * most SATA controllers.  Check SStatus and turn devmask off
+	 * if link is offline.  Note that we should continue resetting
+	 * even when it seems like there's no device.
+	 */
+	if (ap->ops->scr_read && !sata_dev_present(ap))
+		devmask = 0;
+
+	/* select device 0 again */
+	ap->ops->dev_select(ap, 0);
+
+	/* issue bus reset */
+	DPRINTK("about to softreset, devmask=%x\n", devmask);
+	err_mask = ata_bus_softreset(ap, devmask);
+	if (err_mask) {
+		if (verbose)
+			printk(KERN_ERR "ata%u: SRST failed (err_mask=0x%x)\n",
+			       ap->id, err_mask);
+		else
+			DPRINTK("EXIT, softreset failed (err_mask=0x%x)\n",
+				err_mask);
+		return -EIO;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_dev_try_classify(ap, 0, &err);
+	if (slave_possible && err != 0x81)
+		classes[1] = ata_dev_try_classify(ap, 1, &err);
+
+	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	return 0;
+}
+
+/**
+ *	sata_std_hardreset - reset host port via SATA phy reset
+ *	@ap: port to reset
+ *	@verbose: fail verbosely
+ *	@class: resulting class of attached device
+ *
+ *	SATA phy-reset host port using DET bits of SControl register.
+ *	This function is to be used as standard callback for
+ *	ata_drive_*_reset().
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int sata_std_hardreset(struct ata_port *ap, int verbose, unsigned int *class)
+{
+	u32 sstatus, serror;
+	unsigned long timeout = jiffies + (HZ * 5);
+
+	DPRINTK("ENTER\n");
+
+	/* Issue phy wake/reset */
+	scr_write_flush(ap, SCR_CONTROL, 0x301);
+
+	/*
+	 * Couldn't find anything in SATA I/II specs, but AHCI-1.1
+	 * 10.4.2 says at least 1 ms.
+	 */
+	msleep(1);
+
+	scr_write_flush(ap, SCR_CONTROL, 0x300);
+
+	/* Wait for phy to become ready, if necessary. */
+	do {
+		msleep(200);
+		sstatus = scr_read(ap, SCR_STATUS);
+		if ((sstatus & 0xf) != 1)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	/* Clear SError */
+	serror = scr_read(ap, SCR_ERROR);
+	scr_write(ap, SCR_ERROR, serror);
+
+	/* TODO: phy layer with polling, timeouts, etc. */
+	if (!sata_dev_present(ap)) {
+		*class = ATA_DEV_NONE;
+		DPRINTK("EXIT, link offline\n");
+		return 0;
+	}
+
+	if (ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT)) {
+		if (verbose)
+			printk(KERN_ERR "ata%u: COMRESET failed "
+			       "(device not ready)\n", ap->id);
+		else
+			DPRINTK("EXIT, device not ready\n");
+		return -EIO;
+	}
+
+	*class = ata_dev_try_classify(ap, 0, NULL);
+
+	DPRINTK("EXIT, class=%u\n", *class);
+	return 0;
+}
+
+/**
+ *	ata_std_postreset - standard postreset callback
+ *	@ap: the target ata_port
+ *	@classes: classes of attached devices
+ *
+ *	This function is invoked after a successful reset.  Note that
+ *	the device might have been reset more than once using
+ *	different reset methods before postreset is invoked.
+ *	postreset is also reponsible for setting cable type.
+ *
+ *	This function is to be used as standard callback for
+ *	ata_drive_*_reset().
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_std_postreset(struct ata_port *ap, unsigned int *classes)
+{
+	DPRINTK("ENTER\n");
+
+	/* set cable type */
+	if (ap->cbl == ATA_CBL_NONE && ap->flags & ATA_FLAG_SATA)
+		ap->cbl = ATA_CBL_SATA;
+
+	/* print link status */
+	if (ap->cbl == ATA_CBL_SATA)
+		sata_print_link_status(ap);
+
+	/* bail out if no device is present */
+	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
+		DPRINTK("EXIT, no device\n");
+		return;
+	}
+
+	/* is double-select really necessary? */
+	if (classes[0] != ATA_DEV_NONE)
+		ap->ops->dev_select(ap, 1);
+	if (classes[1] != ATA_DEV_NONE)
+		ap->ops->dev_select(ap, 0);
+
+	/* re-enable interrupts & set up device control */
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_on(ap);
+
+	DPRINTK("EXIT\n");
+}
+
+/**
+ *	ata_std_probe_reset - standard probe reset method
+ *	@ap: prot to perform probe-reset
+ *	@classes: resulting classes of attached devices
+ *
+ *	The stock off-the-shelf ->probe_reset method.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int ata_std_probe_reset(struct ata_port *ap, unsigned int *classes)
+{
+	ata_reset_fn_t hardreset;
+
+	hardreset = NULL;
+	if (ap->cbl == ATA_CBL_SATA && ap->ops->scr_read)
+		hardreset = sata_std_hardreset;
+
+	return ata_drive_probe_reset(ap, ata_std_softreset, hardreset,
+				     ata_std_postreset, classes);
+}
+
+static int do_probe_reset(struct ata_port *ap, ata_reset_fn_t reset,
+			  ata_postreset_fn_t postreset,
+			  unsigned int *classes)
+{
+	int i, rc;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		classes[i] = ATA_DEV_UNKNOWN;
+
+	rc = reset(ap, 0, classes);
+	if (rc)
+		return rc;
+
+	/* If any class isn't ATA_DEV_UNKNOWN, consider classification
+	 * is complete and convert all ATA_DEV_UNKNOWN to
+	 * ATA_DEV_NONE.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (classes[i] != ATA_DEV_UNKNOWN)
+			break;
+
+	if (i < ATA_MAX_DEVICES)
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			if (classes[i] == ATA_DEV_UNKNOWN)
+				classes[i] = ATA_DEV_NONE;
+
+	if (postreset)
+		postreset(ap, classes);
+
+	return classes[0] != ATA_DEV_UNKNOWN ? 0 : -ENODEV;
+}
+
+/**
+ *	ata_drive_probe_reset - Perform probe reset with given methods
+ *	@ap: port to reset
+ *	@softreset: softreset method (can be NULL)
+ *	@hardreset: hardreset method (can be NULL)
+ *	@postreset: postreset method (can be NULL)
+ *	@classes: resulting classes of attached devices
+ *
+ *	Reset the specified port and classify attached devices using
+ *	given methods.  This function prefers softreset but tries all
+ *	possible reset sequences to reset and classify devices.  This
+ *	function is intended to be used for constructing ->probe_reset
+ *	callback by low level drivers.
+ *
+ *	Reset methods should follow the following rules.
+ *
+ *	- Return 0 on sucess, -errno on failure.
+ *	- If classification is supported, fill classes[] with
+ *	  recognized class codes.
+ *	- If classification is not supported, leave classes[] alone.
+ *	- If verbose is non-zero, print error message on failure;
+ *	  otherwise, shut up.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -EINVAL if no reset method is avaliable, -ENODEV
+ *	if classification fails, and any error code from reset
+ *	methods.
+ */
+int ata_drive_probe_reset(struct ata_port *ap,
+			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			  ata_postreset_fn_t postreset, unsigned int *classes)
+{
+	int rc = -EINVAL;
+
+	if (softreset) {
+		rc = do_probe_reset(ap, softreset, postreset, classes);
+		if (rc == 0)
+			return 0;
+	}
+
+	if (!hardreset)
+		return rc;
+
+	rc = do_probe_reset(ap, hardreset, postreset, classes);
+	if (rc == 0 || rc != -ENODEV)
+		return rc;
+
+	if (softreset)
+		rc = do_probe_reset(ap, softreset, postreset, classes);
+
+	return rc;
+}
+
 static void ata_pr_blacklisted(const struct ata_port *ap,
 			       const struct ata_device *dev)
 {
@@ -2869,7 +3197,7 @@ void ata_poll_qc_complete(struct ata_que
 }
 
 /**
- *	ata_pio_poll -
+ *	ata_pio_poll - poll using PIO, depending on current state
  *	@ap: the target ata_port
  *
  *	LOCKING:
@@ -2908,7 +3236,7 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
-			qc->err_mask |= AC_ERR_ATA_BUS;
+			qc->err_mask |= AC_ERR_TIMEOUT;
 			ap->hsm_task_state = HSM_ST_TMOUT;
 			return 0;
 		}
@@ -2976,7 +3304,7 @@ static int ata_pio_complete (struct ata_
 
 
 /**
- *	swap_buf_le16 - swap halves of 16-words in place
+ *	swap_buf_le16 - swap halves of 16-bit words in place
  *	@buf:  Buffer to swap
  *	@buf_words:  Number of 16-bit words in buffer.
  *
@@ -3286,7 +3614,7 @@ static void atapi_pio_bytes(struct ata_q
 err_out:
 	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
 	      ap->id, dev->devno);
-	qc->err_mask |= AC_ERR_ATA_BUS;
+	qc->err_mask |= AC_ERR_HSM;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
 
@@ -3344,7 +3672,7 @@ static void ata_pio_block(struct ata_por
 	} else {
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
-			qc->err_mask |= AC_ERR_ATA_BUS;
+			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 			return;
 		}
@@ -3406,7 +3734,7 @@ fsm_start:
 	}
 
 	if (timeout)
-		queue_delayed_work(ata_wq, &ap->pio_task, timeout);
+		ata_queue_delayed_pio_task(ap, timeout);
 	else if (!qc_completed)
 		goto fsm_start;
 }
@@ -3441,14 +3769,6 @@ static void ata_qc_timeout(struct ata_qu
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
-	/* hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
-	qc->scsidone = scsi_finish_command;
-
 	switch (qc->tf.protocol) {
 
 	case ATA_PROT_DMA:
@@ -3472,12 +3792,13 @@ static void ata_qc_timeout(struct ata_qu
 
 		/* complete taskfile transaction */
 		qc->err_mask |= ac_err_mask(drv_stat);
-		ata_qc_complete(qc);
 		break;
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
+	ata_eh_qc_complete(qc);
+
 	DPRINTK("EXIT\n");
 }
 
@@ -3571,21 +3892,6 @@ struct ata_queued_cmd *ata_qc_new_init(s
 	return qc;
 }
 
-static void __ata_qc_complete(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned int tag;
-
-	qc->flags = 0;
-	tag = qc->tag;
-	if (likely(ata_tag_valid(tag))) {
-		if (tag == ap->active_tag)
-			ap->active_tag = ATA_TAG_POISON;
-		qc->tag = ATA_TAG_POISON;
-		clear_bit(tag, &ap->qactive);
-	}
-}
-
 /**
  *	ata_qc_free - free unused ata_queued_cmd
  *	@qc: Command to complete
@@ -3598,9 +3904,19 @@ static void __ata_qc_complete(struct ata
  */
 void ata_qc_free(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
+	unsigned int tag;
+
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 
-	__ata_qc_complete(qc);
+	qc->flags = 0;
+	tag = qc->tag;
+	if (likely(ata_tag_valid(tag))) {
+		if (tag == ap->active_tag)
+			ap->active_tag = ATA_TAG_POISON;
+		qc->tag = ATA_TAG_POISON;
+		clear_bit(tag, &ap->qactive);
+	}
 }
 
 /**
@@ -3617,8 +3933,6 @@ void ata_qc_free(struct ata_queued_cmd *
 
 void ata_qc_complete(struct ata_queued_cmd *qc)
 {
-	int rc;
-
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
 
@@ -3632,17 +3946,7 @@ void ata_qc_complete(struct ata_queued_c
 	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* call completion callback */
-	rc = qc->complete_fn(qc);
-
-	/* if callback indicates not to complete command (non-zero),
-	 * return immediately
-	 */
-	if (rc != 0)
-		return;
-
-	__ata_qc_complete(qc);
-
-	VPRINTK("EXIT\n");
+	qc->complete_fn(qc);
 }
 
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
@@ -3682,20 +3986,20 @@ static inline int ata_should_dma_map(str
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
- *	Zero on success, negative on error.
+ *	Zero on success, AC_ERR_* mask on failure
  */
 
-int ata_qc_issue(struct ata_queued_cmd *qc)
+unsigned int ata_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
 	if (ata_should_dma_map(qc)) {
 		if (qc->flags & ATA_QCFLAG_SG) {
 			if (ata_sg_setup(qc))
-				goto err_out;
+				goto sg_err;
 		} else if (qc->flags & ATA_QCFLAG_SINGLE) {
 			if (ata_sg_setup_one(qc))
-				goto err_out;
+				goto sg_err;
 		}
 	} else {
 		qc->flags &= ~ATA_QCFLAG_DMAMAP;
@@ -3708,8 +4012,9 @@ int ata_qc_issue(struct ata_queued_cmd *
 
 	return ap->ops->qc_issue(qc);
 
-err_out:
-	return -1;
+sg_err:
+	qc->flags &= ~ATA_QCFLAG_DMAMAP;
+	return AC_ERR_SYSTEM;
 }
 
 
@@ -3728,10 +4033,10 @@ err_out:
  *	spin_lock_irqsave(host_set lock)
  *
  *	RETURNS:
- *	Zero on success, negative on error.
+ *	Zero on success, AC_ERR_* mask on failure
  */
 
-int ata_qc_issue_prot(struct ata_queued_cmd *qc)
+unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
@@ -3752,31 +4057,31 @@ int ata_qc_issue_prot(struct ata_queued_
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		ata_queue_pio_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI:
 		ata_qc_set_polling(qc);
 		ata_tf_to_host(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ata_tf_to_host(ap, &qc->tf);
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
 		ap->flags |= ATA_FLAG_NOINTR;
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
-		queue_work(ata_wq, &ap->packet_task);
+		ata_queue_packet_task(ap);
 		break;
 
 	default:
 		WARN_ON(1);
-		return -1;
+		return AC_ERR_SYSTEM;
 	}
 
 	return 0;
@@ -4166,14 +4471,14 @@ static void atapi_packet_task(void *_dat
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
 	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
-		qc->err_mask |= AC_ERR_ATA_BUS;
+		qc->err_mask |= AC_ERR_TIMEOUT;
 		goto err_out;
 	}
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
 	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
-		qc->err_mask |= AC_ERR_ATA_BUS;
+		qc->err_mask |= AC_ERR_HSM;
 		goto err_out;
 	}
 
@@ -4202,7 +4507,7 @@ static void atapi_packet_task(void *_dat
 
 		/* PIO commands are handled by polling */
 		ap->hsm_task_state = HSM_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		ata_queue_pio_task(ap);
 	}
 
 	return;
@@ -4212,19 +4517,6 @@ err_out:
 }
 
 
-/**
- *	ata_port_start - Set port up for dma.
- *	@ap: Port to initialize
- *
- *	Called just after data structures for each port are
- *	initialized.  Allocates space for PRD table.
- *
- *	May be used as the port_start() entry in ata_port_operations.
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
 /*
  * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
  * without filling any other registers
@@ -4276,6 +4568,8 @@ static int ata_start_drive(struct ata_po
 
 /**
  *	ata_device_resume - wakeup a previously suspended devices
+ *	@ap: port the device is connected to
+ *	@dev: the device to resume
  *
  *	Kick the drive back into action, by sending it an idle immediate
  *	command and making sure its transfer mode matches between drive
@@ -4298,10 +4592,11 @@ int ata_device_resume(struct ata_port *a
 
 /**
  *	ata_device_suspend - prepare a device for suspend
+ *	@ap: port the device is connected to
+ *	@dev: the device to suspend
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
- *
  */
 int ata_device_suspend(struct ata_port *ap, struct ata_device *dev)
 {
@@ -4315,6 +4610,19 @@ int ata_device_suspend(struct ata_port *
 	return 0;
 }
 
+/**
+ *	ata_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Called just after data structures for each port are
+ *	initialized.  Allocates space for PRD table.
+ *
+ *	May be used as the port_start() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 int ata_port_start (struct ata_port *ap)
 {
 	struct device *dev = ap->host_set->dev;
@@ -4430,6 +4738,7 @@ static void ata_host_init(struct ata_por
 
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
+	INIT_LIST_HEAD(&ap->eh_done_q);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		ap->device[i].devno = i;
@@ -4571,9 +4880,9 @@ int ata_device_add(const struct ata_prob
 
 		ap = host_set->ports[i];
 
-		DPRINTK("ata%u: probe begin\n", ap->id);
+		DPRINTK("ata%u: bus probe begin\n", ap->id);
 		rc = ata_bus_probe(ap);
-		DPRINTK("ata%u: probe end\n", ap->id);
+		DPRINTK("ata%u: bus probe end\n", ap->id);
 
 		if (rc) {
 			/* FIXME: do something useful here?
@@ -4597,7 +4906,7 @@ int ata_device_add(const struct ata_prob
 	}
 
 	/* probes are done, now scan each port's disk(s) */
-	DPRINTK("probe begin\n");
+	DPRINTK("host probe begin\n");
 	for (i = 0; i < count; i++) {
 		struct ata_port *ap = host_set->ports[i];
 
@@ -5161,8 +5470,14 @@ EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
 EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
+EXPORT_SYMBOL_GPL(ata_std_softreset);
+EXPORT_SYMBOL_GPL(sata_std_hardreset);
+EXPORT_SYMBOL_GPL(ata_std_postreset);
+EXPORT_SYMBOL_GPL(ata_std_probe_reset);
+EXPORT_SYMBOL_GPL(ata_drive_probe_reset);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
+EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
 EXPORT_SYMBOL_GPL(ata_scsi_error);
@@ -5173,6 +5488,8 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
+EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
+EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index cfbceb5..6df8293 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -151,7 +151,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	struct scsi_sense_hdr sshdr;
 	enum dma_data_direction data_dir;
 
-	if (NULL == (void *)arg)
+	if (arg == NULL)
 		return -EINVAL;
 
 	if (copy_from_user(args, arg, sizeof(args)))
@@ -201,7 +201,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	/* Need code to retrieve data from check condition? */
 
 	if ((argbuf)
-	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
+	 && copy_to_user(arg + sizeof(args), argbuf, argsize))
 		rc = -EFAULT;
 error:
 	if (argbuf)
@@ -228,7 +228,7 @@ int ata_task_ioctl(struct scsi_device *s
 	u8 args[7];
 	struct scsi_sense_hdr sshdr;
 
-	if (NULL == (void *)arg)
+	if (arg == NULL)
 		return -EINVAL;
 
 	if (copy_from_user(args, arg, sizeof(args)))
@@ -738,17 +738,64 @@ int ata_scsi_error(struct Scsi_Host *hos
 	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
-	/* TODO: this is per-command; when queueing is supported
-	 * this code will either change or move to a more
-	 * appropriate place
-	 */
-	host->host_failed--;
-	INIT_LIST_HEAD(&host->eh_cmd_q);
+	assert(host->host_failed == 0 && list_empty(&host->eh_cmd_q));
+
+	scsi_eh_flush_done_q(&ap->eh_done_q);
 
 	DPRINTK("EXIT\n");
 	return 0;
 }
 
+static void ata_eh_scsidone(struct scsi_cmnd *scmd)
+{
+	/* nada */
+}
+
+static void __ata_eh_qc_complete(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	qc->scsidone = ata_eh_scsidone;
+	ata_qc_complete(qc);
+	assert(!ata_tag_valid(qc->tag));
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
+}
+
+/**
+ *	ata_eh_qc_complete - Complete an active ATA command from EH
+ *	@qc: Command to complete
+ *
+ *	Indicate to the mid and upper layers that an ATA command has
+ *	completed.  To be used from EH.
+ */
+void ata_eh_qc_complete(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	scmd->retries = scmd->allowed;
+	__ata_eh_qc_complete(qc);
+}
+
+/**
+ *	ata_eh_qc_retry - Tell midlayer to retry an ATA command after EH
+ *	@qc: Command to retry
+ *
+ *	Indicate to the mid and upper layers that an ATA command
+ *	should be retried.  To be used from EH.
+ *
+ *	SCSI midlayer limits the number of retries to scmd->allowed.
+ *	This function might need to adjust scmd->retries for commands
+ *	which get retried due to unrelated NCQ failures.
+ */
+void ata_eh_qc_retry(struct ata_queued_cmd *qc)
+{
+	__ata_eh_qc_complete(qc);
+}
+
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
@@ -985,9 +1032,13 @@ static unsigned int ata_scsi_verify_xlat
 	if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |= ATA_TFLAG_LBA;
 
-		if (dev->flags & ATA_DFLAG_LBA48) {
-			if (n_block > (64 * 1024))
-				goto invalid_fld;
+		if (lba_28_ok(block, n_block)) {
+			/* use LBA28 */
+			tf->command = ATA_CMD_VERIFY;
+			tf->device |= (block >> 24) & 0xf;
+		} else if (lba_48_ok(block, n_block)) {
+			if (!(dev->flags & ATA_DFLAG_LBA48))
+				goto out_of_range;
 
 			/* use LBA48 */
 			tf->flags |= ATA_TFLAG_LBA48;
@@ -998,15 +1049,9 @@ static unsigned int ata_scsi_verify_xlat
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
-		} else {
-			if (n_block > 256)
-				goto invalid_fld;
-
-			/* use LBA28 */
-			tf->command = ATA_CMD_VERIFY;
-
-			tf->device |= (block >> 24) & 0xf;
-		}
+		} else
+			/* request too large even for LBA48 */
+			goto out_of_range;
 
 		tf->nsect = n_block & 0xff;
 
@@ -1019,8 +1064,8 @@ static unsigned int ata_scsi_verify_xlat
 		/* CHS */
 		u32 sect, head, cyl, track;
 
-		if (n_block > 256)
-			goto invalid_fld;
+		if (!lba_28_ok(block, n_block))
+			goto out_of_range;
 
 		/* Convert LBA to CHS */
 		track = (u32)block / dev->sectors;
@@ -1139,9 +1184,11 @@ static unsigned int ata_scsi_rw_xlat(str
 	if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |= ATA_TFLAG_LBA;
 
-		if (dev->flags & ATA_DFLAG_LBA48) {
-			/* The request -may- be too large for LBA48. */
-			if ((block >> 48) || (n_block > 65536))
+		if (lba_28_ok(block, n_block)) {
+			/* use LBA28 */
+			tf->device |= (block >> 24) & 0xf;
+		} else if (lba_48_ok(block, n_block)) {
+			if (!(dev->flags & ATA_DFLAG_LBA48))
 				goto out_of_range;
 
 			/* use LBA48 */
@@ -1152,15 +1199,9 @@ static unsigned int ata_scsi_rw_xlat(str
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
-		} else { 
-			/* use LBA28 */
-
-			/* The request -may- be too large for LBA28. */
-			if ((block >> 28) || (n_block > 256))
-				goto out_of_range;
-
-			tf->device |= (block >> 24) & 0xf;
-		}
+		} else
+			/* request too large even for LBA48 */
+			goto out_of_range;
 
 		if (unlikely(ata_rwcmd_protocol(qc) < 0))
 			goto invalid_fld;
@@ -1178,7 +1219,7 @@ static unsigned int ata_scsi_rw_xlat(str
 		u32 sect, head, cyl, track;
 
 		/* The request -may- be too large for CHS addressing. */
-		if ((block >> 28) || (n_block > 256))
+		if (!lba_28_ok(block, n_block))
 			goto out_of_range;
 
 		if (unlikely(ata_rwcmd_protocol(qc) < 0))
@@ -1225,7 +1266,7 @@ nothing_to_do:
 	return 1;
 }
 
-static int ata_scsi_qc_complete(struct ata_queued_cmd *qc)
+static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
@@ -1262,7 +1303,7 @@ static int ata_scsi_qc_complete(struct a
 
 	qc->scsidone(cmd);
 
-	return 0;
+	ata_qc_free(qc);
 }
 
 /**
@@ -1328,8 +1369,9 @@ static void ata_scsi_translate(struct at
 		goto early_finish;
 
 	/* select device, send command to hardware */
-	if (ata_qc_issue(qc))
-		goto err_did;
+	qc->err_mask = ata_qc_issue(qc);
+	if (qc->err_mask)
+		ata_qc_complete(qc);
 
 	VPRINTK("EXIT\n");
 	return;
@@ -1988,7 +2030,7 @@ void ata_scsi_badcmd(struct scsi_cmnd *c
 	done(cmd);
 }
 
-static int atapi_sense_complete(struct ata_queued_cmd *qc)
+static void atapi_sense_complete(struct ata_queued_cmd *qc)
 {
 	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0))
 		/* FIXME: not quite right; we don't want the
@@ -1999,7 +2041,7 @@ static int atapi_sense_complete(struct a
 		ata_gen_ata_desc_sense(qc);
 
 	qc->scsidone(qc->scsicmd);
-	return 0;
+	ata_qc_free(qc);
 }
 
 /* is it pointless to prefer PIO for "safety reasons"? */
@@ -2048,15 +2090,14 @@ static void atapi_request_sense(struct a
 
 	qc->complete_fn = atapi_sense_complete;
 
-	if (ata_qc_issue(qc)) {
-		qc->err_mask |= AC_ERR_OTHER;
+	qc->err_mask = ata_qc_issue(qc);
+	if (qc->err_mask)
 		ata_qc_complete(qc);
-	}
 
 	DPRINTK("EXIT\n");
 }
 
-static int atapi_qc_complete(struct ata_queued_cmd *qc)
+static void atapi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
@@ -2066,7 +2107,7 @@ static int atapi_qc_complete(struct ata_
 	if (unlikely(err_mask & AC_ERR_DEV)) {
 		cmd->result = SAM_STAT_CHECK_CONDITION;
 		atapi_request_sense(qc);
-		return 1;
+		return;
 	}
 
 	else if (unlikely(err_mask))
@@ -2106,7 +2147,7 @@ static int atapi_qc_complete(struct ata_
 	}
 
 	qc->scsidone(cmd);
-	return 0;
+	ata_qc_free(qc);
 }
 /**
  *	atapi_xlat - Initialize PACKET taskfile
@@ -2492,7 +2533,8 @@ out_unlock:
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@id: current IDENTIFY data for target device.
+ *	@ap: port the device is connected to
+ *	@dev: the target device
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e03ce48..9d76923 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -45,7 +45,7 @@ extern struct ata_queued_cmd *ata_qc_new
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-extern int ata_qc_issue(struct ata_queued_cmd *qc);
+extern unsigned int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index e8df0c9..3a6bf58 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -131,7 +131,7 @@ static void adma_host_stop(struct ata_ho
 static void adma_port_stop(struct ata_port *ap);
 static void adma_phy_reset(struct ata_port *ap);
 static void adma_qc_prep(struct ata_queued_cmd *qc);
-static int adma_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int adma_qc_issue(struct ata_queued_cmd *qc);
 static int adma_check_atapi_dma(struct ata_queued_cmd *qc);
 static void adma_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 adma_bmdma_status(struct ata_port *ap);
@@ -419,7 +419,7 @@ static inline void adma_packet_start(str
 	writew(aPIOMD4 | aGO, chan + ADMA_CONTROL);
 }
 
-static int adma_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int adma_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct adma_port_priv *pp = qc->ap->private_data;
 
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index cd54244..d9a554c 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -328,7 +328,7 @@ static void mv_host_stop(struct ata_host
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
-static int mv_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int mv_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t mv_interrupt(int irq, void *dev_instance,
 				struct pt_regs *regs);
 static void mv_eng_timeout(struct ata_port *ap);
@@ -1040,7 +1040,7 @@ static void mv_qc_prep(struct ata_queued
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int mv_qc_issue(struct ata_queued_cmd *qc)
 {
 	void __iomem *port_mmio = mv_ap_base(qc->ap);
 	struct mv_port_priv *pp = qc->ap->private_data;
@@ -1839,7 +1839,6 @@ static void mv_phy_reset(struct ata_port
 static void mv_eng_timeout(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
 
 	printk(KERN_ERR "ata%u: Entering mv_eng_timeout\n",ap->id);
 	DPRINTK("All regs @ start of eng_timeout\n");
@@ -1858,17 +1857,8 @@ static void mv_eng_timeout(struct ata_po
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
 	} else {
-		/* hack alert!  We cannot use the supplied completion
-	 	 * function from inside the ->eh_strategy_handler() thread.
-	 	 * libata is the only user of ->eh_strategy_handler() in
-	 	 * any kernel, so the default scsi_done() assumes it is
-	 	 * not being called from the SCSI EH.
-	 	 */
-		spin_lock_irqsave(&ap->host_set->lock, flags);
-		qc->scsidone = scsi_finish_command;
-		qc->err_mask |= AC_ERR_OTHER;
-		ata_qc_complete(qc);
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		qc->err_mask |= AC_ERR_TIMEOUT;
+		ata_eh_qc_complete(qc);
 	}
 }
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index b0b0a69..0950a8e 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -46,7 +46,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"1.03"
+#define DRV_VERSION	"1.04"
 
 
 enum {
@@ -58,6 +58,7 @@ enum {
 	PDC_GLOBAL_CTL		= 0x48, /* Global control/status (per port) */
 	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
 	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
+	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
 	PDC_SLEW_CTL		= 0x470, /* slew rate control reg */
 
 	PDC_ERR_MASK		= (1<<19) | (1<<20) | (1<<21) | (1<<22) |
@@ -67,8 +68,10 @@ enum {
 	board_20319		= 1,	/* FastTrak S150 TX4 */
 	board_20619		= 2,	/* FastTrak TX4000 */
 	board_20771		= 3,	/* FastTrak TX2300 */
+	board_2057x		= 4,	/* SATAII150 Tx2plus */
+	board_40518		= 5,	/* SATAII150 Tx4 */
 
-	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
+	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
@@ -82,6 +85,10 @@ struct pdc_port_priv {
 	dma_addr_t		pkt_dma;
 };
 
+struct pdc_host_priv {
+	int			hotplug_offset;
+};
+
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -95,7 +102,8 @@ static void pdc_qc_prep(struct ata_queue
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_irq_clear(struct ata_port *ap);
-static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
+static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
+static void pdc_host_stop(struct ata_host_set *host_set);
 
 
 static struct scsi_host_template pdc_ata_sht = {
@@ -137,7 +145,7 @@ static const struct ata_port_operations 
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= ata_pci_host_stop,
+	.host_stop		= pdc_host_stop,
 };
 
 static const struct ata_port_operations pdc_pata_ops = {
@@ -158,7 +166,7 @@ static const struct ata_port_operations 
 
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= ata_pci_host_stop,
+	.host_stop		= pdc_host_stop,
 };
 
 static const struct ata_port_info pdc_port_info[] = {
@@ -201,6 +209,26 @@ static const struct ata_port_info pdc_po
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_sata_ops,
 	},
+
+	/* board_2057x */
+	{
+		.sht		= &pdc_ata_sht,
+		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_sata_ops,
+	},
+
+	/* board_40518 */
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
@@ -217,9 +245,9 @@ static const struct pci_device_id pdc_at
 	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
+	  board_2057x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
+	  board_2057x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d73, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 
@@ -232,7 +260,7 @@ static const struct pci_device_id pdc_at
 	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20319 },
+	  board_40518 },
 
 	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20619 },
@@ -261,12 +289,11 @@ static int pdc_port_start(struct ata_por
 	if (rc)
 		return rc;
 
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp) {
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	memset(pp, 0, sizeof(*pp));
 
 	pp->pkt = dma_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
 	if (!pp->pkt) {
@@ -298,6 +325,16 @@ static void pdc_port_stop(struct ata_por
 }
 
 
+static void pdc_host_stop(struct ata_host_set *host_set)
+{
+	struct pdc_host_priv *hp = host_set->private_data;
+
+	ata_pci_host_stop(host_set);
+
+	kfree(hp);
+}
+
+
 static void pdc_reset_port(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT;
@@ -400,21 +437,12 @@ static void pdc_eng_timeout(struct ata_p
 		goto out;
 	}
 
-	/* hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
-	qc->scsidone = scsi_finish_command;
-
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 		drv_stat = ata_wait_idle(ap);
 		qc->err_mask |= __ac_err_mask(drv_stat);
-		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -424,12 +452,13 @@ static void pdc_eng_timeout(struct ata_p
 		       ap->id, qc->tf.command, drv_stat);
 
 		qc->err_mask |= ac_err_mask(drv_stat);
-		ata_qc_complete(qc);
 		break;
 	}
 
 out:
 	spin_unlock_irqrestore(&host_set->lock, flags);
+	if (qc)
+		ata_eh_qc_complete(qc);
 	DPRINTK("EXIT\n");
 }
 
@@ -495,14 +524,15 @@ static irqreturn_t pdc_interrupt (int ir
 		VPRINTK("QUICK EXIT 2\n");
 		return IRQ_NONE;
 	}
+
+	spin_lock(&host_set->lock);
+
 	mask &= 0xffff;		/* only 16 tags possible */
 	if (!mask) {
 		VPRINTK("QUICK EXIT 3\n");
-		return IRQ_NONE;
+		goto done_irq;
 	}
 
-	spin_lock(&host_set->lock);
-
 	writel(mask, mmio_base + PDC_INT_SEQMASK);
 
 	for (i = 0; i < host_set->n_ports; i++) {
@@ -519,10 +549,10 @@ static irqreturn_t pdc_interrupt (int ir
 		}
 	}
 
-        spin_unlock(&host_set->lock);
-
 	VPRINTK("EXIT\n");
 
+done_irq:
+	spin_unlock(&host_set->lock);
 	return IRQ_RETVAL(handled);
 }
 
@@ -544,7 +574,7 @@ static inline void pdc_packet_start(stru
 	readl((void __iomem *) ap->ioaddr.cmd_addr + PDC_PKT_SUBMIT); /* flush */
 }
 
-static int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -600,6 +630,8 @@ static void pdc_ata_setup_port(struct at
 static void pdc_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
 {
 	void __iomem *mmio = pe->mmio_base;
+	struct pdc_host_priv *hp = pe->private_data;
+	int hotplug_offset = hp->hotplug_offset;
 	u32 tmp;
 
 	/*
@@ -614,12 +646,12 @@ static void pdc_host_init(unsigned int c
 	writel(tmp, mmio + PDC_FLASH_CTL);
 
 	/* clear plug/unplug flags for all ports */
-	tmp = readl(mmio + PDC_SATA_PLUG_CSR);
-	writel(tmp | 0xff, mmio + PDC_SATA_PLUG_CSR);
+	tmp = readl(mmio + hotplug_offset);
+	writel(tmp | 0xff, mmio + hotplug_offset);
 
 	/* mask plug/unplug ints */
-	tmp = readl(mmio + PDC_SATA_PLUG_CSR);
-	writel(tmp | 0xff0000, mmio + PDC_SATA_PLUG_CSR);
+	tmp = readl(mmio + hotplug_offset);
+	writel(tmp | 0xff0000, mmio + hotplug_offset);
 
 	/* reduce TBG clock to 133 Mhz. */
 	tmp = readl(mmio + PDC_TBG_MODE);
@@ -641,6 +673,7 @@ static int pdc_ata_init_one (struct pci_
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
+	struct pdc_host_priv *hp;
 	unsigned long base;
 	void __iomem *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
@@ -671,13 +704,12 @@ static int pdc_ata_init_one (struct pci_
 	if (rc)
 		goto err_out_regions;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
@@ -688,6 +720,16 @@ static int pdc_ata_init_one (struct pci_
 	}
 	base = (unsigned long) mmio_base;
 
+	hp = kzalloc(sizeof(*hp), GFP_KERNEL);
+	if (hp == NULL) {
+		rc = -ENOMEM;
+		goto err_out_free_ent;
+	}
+
+	/* Set default hotplug offset */
+	hp->hotplug_offset = PDC_SATA_PLUG_CSR;
+	probe_ent->private_data = hp;
+
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
@@ -707,6 +749,10 @@ static int pdc_ata_init_one (struct pci_
 
 	/* notice 4-port boards */
 	switch (board_idx) {
+	case board_40518:
+		/* Override hotplug offset for SATAII150 */
+		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
+		/* Fall through */
 	case board_20319:
        		probe_ent->n_ports = 4;
 
@@ -716,6 +762,10 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
 		break;
+	case board_2057x:
+		/* Override hotplug offset for SATAII150 */
+		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
+		/* Fall through */
 	case board_2037x:
 		probe_ent->n_ports = 2;
 		break;
@@ -741,8 +791,10 @@ static int pdc_ata_init_one (struct pci_
 	/* initialize adapter */
 	pdc_host_init(board_idx, probe_ent);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
+	/* FIXME: Need any other frees than hp? */
+	if (!ata_device_add(probe_ent))
+		kfree(hp);
+
 	kfree(probe_ent);
 
 	return 0;
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index de05e28..2afbeb7 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -120,7 +120,7 @@ static void qs_host_stop(struct ata_host
 static void qs_port_stop(struct ata_port *ap);
 static void qs_phy_reset(struct ata_port *ap);
 static void qs_qc_prep(struct ata_queued_cmd *qc);
-static int qs_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int qs_qc_issue(struct ata_queued_cmd *qc);
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
 static void qs_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 qs_bmdma_status(struct ata_port *ap);
@@ -352,7 +352,7 @@ static inline void qs_packet_start(struc
 	readl(chan + QS_CCT_CFF);          /* flush */
 }
 
-static int qs_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int qs_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct qs_port_priv *pp = qc->ap->private_data;
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 9231301..7222fc7 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -251,7 +251,7 @@ static void sil24_scr_write(struct ata_p
 static void sil24_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void sil24_phy_reset(struct ata_port *ap);
 static void sil24_qc_prep(struct ata_queued_cmd *qc);
-static int sil24_qc_issue(struct ata_queued_cmd *qc);
+static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc);
 static void sil24_irq_clear(struct ata_port *ap);
 static void sil24_eng_timeout(struct ata_port *ap);
 static irqreturn_t sil24_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
@@ -557,7 +557,7 @@ static void sil24_qc_prep(struct ata_que
 		sil24_fill_sg(qc, sge);
 }
 
-static int sil24_qc_issue(struct ata_queued_cmd *qc)
+static unsigned int sil24_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
@@ -644,17 +644,9 @@ static void sil24_eng_timeout(struct ata
 		return;
 	}
 
-	/*
-	 * hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-	qc->scsidone = scsi_finish_command;
-	qc->err_mask |= AC_ERR_OTHER;
-	ata_qc_complete(qc);
+	qc->err_mask |= AC_ERR_TIMEOUT;
+	ata_eh_qc_complete(qc);
 
 	sil24_reset_controller(ap);
 }
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index bc87c16..9f992fb 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -174,7 +174,7 @@ static void pdc20621_get_from_dimm(struc
 static void pdc20621_put_to_dimm(struct ata_probe_ent *pe,
 				 void *psource, u32 offset, u32 size);
 static void pdc20621_irq_clear(struct ata_port *ap);
-static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
+static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
 
 
 static struct scsi_host_template pdc_sata_sht = {
@@ -678,7 +678,7 @@ static void pdc20621_packet_start(struct
 	}
 }
 
-static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc)
+static unsigned int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc)
 {
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -872,20 +872,11 @@ static void pdc_eng_timeout(struct ata_p
 		goto out;
 	}
 
-	/* hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
-	qc->scsidone = scsi_finish_command;
-
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 		qc->err_mask |= __ac_err_mask(ata_wait_idle(ap));
-		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -895,12 +886,13 @@ static void pdc_eng_timeout(struct ata_p
 		       ap->id, qc->tf.command, drv_stat);
 
 		qc->err_mask |= ac_err_mask(drv_stat);
-		ata_qc_complete(qc);
 		break;
 	}
 
 out:
 	spin_unlock_irqrestore(&host_set->lock, flags);
+	if (qc)
+		ata_eh_qc_complete(qc);
 	DPRINTK("EXIT\n");
 }
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index a2333d2..6bac3d2 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -584,8 +584,7 @@ static int scsi_request_sense(struct scs
  *    keep a list of pending commands for final completion, and once we
  *    are ready to leave error handling we handle completion for real.
  **/
-static void scsi_eh_finish_cmd(struct scsi_cmnd *scmd,
-			       struct list_head *done_q)
+void scsi_eh_finish_cmd(struct scsi_cmnd *scmd, struct list_head *done_q)
 {
 	scmd->device->host->host_failed--;
 	scmd->eh_eflags = 0;
@@ -597,6 +596,7 @@ static void scsi_eh_finish_cmd(struct sc
 	scsi_setup_cmd_retry(scmd);
 	list_move_tail(&scmd->eh_entry, done_q);
 }
+EXPORT_SYMBOL(scsi_eh_finish_cmd);
 
 /**
  * scsi_eh_get_sense - Get device sense data.
@@ -1425,7 +1425,7 @@ static void scsi_eh_ready_devs(struct Sc
  * @done_q:	list_head of processed commands.
  *
  **/
-static void scsi_eh_flush_done_q(struct list_head *done_q)
+void scsi_eh_flush_done_q(struct list_head *done_q)
 {
 	struct scsi_cmnd *scmd, *next;
 
@@ -1454,6 +1454,7 @@ static void scsi_eh_flush_done_q(struct 
 		}
 	}
 }
+EXPORT_SYMBOL(scsi_eh_flush_done_q);
 
 /**
  * scsi_unjam_host - Attempt to fix a host which has a cmd that failed.
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 94f77cc..a8155ca 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -302,4 +302,16 @@ static inline int ata_ok(u8 status)
 			== ATA_DRDY);
 }
 
+static inline int lba_28_ok(u64 block, u32 n_block)
+{
+	/* check the ending block number */
+	return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
+}
+
+static inline int lba_48_ok(u64 block, u32 n_block)
+{
+	/* check the ending block number */
+	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= 65536);
+}
+
 #endif /* __LINUX_ATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9e5db29..474cdfa 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -35,7 +35,8 @@
 #include <linux/workqueue.h>
 
 /*
- * compile-time options
+ * compile-time options: to be removed as soon as all the drivers are
+ * converted to the new debugging mechanism
  */
 #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
@@ -71,6 +72,38 @@
         }
 #endif
 
+/* NEW: debug levels */
+#define HAVE_LIBATA_MSG 1
+
+enum {
+	ATA_MSG_DRV	= 0x0001,
+	ATA_MSG_INFO	= 0x0002,
+	ATA_MSG_PROBE	= 0x0004,
+	ATA_MSG_WARN	= 0x0008,
+	ATA_MSG_MALLOC	= 0x0010,
+	ATA_MSG_CTL	= 0x0020,
+	ATA_MSG_INTR	= 0x0040,
+	ATA_MSG_ERR	= 0x0080,
+};
+
+#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
+#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
+#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
+#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
+#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
+#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
+#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
+#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
+
+static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
+{
+	if (dval < 0 || dval >= (sizeof(u32) * 8))
+		return default_msg_enable_bits; /* should be 0x1 - only driver info msgs */
+	if (!dval)
+		return 0;
+	return (1 << dval) - 1;
+}
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
@@ -115,9 +148,9 @@ enum {
 	ATA_FLAG_PORT_DISABLED	= (1 << 2), /* port is disabled, ignore it */
 	ATA_FLAG_SATA		= (1 << 3),
 	ATA_FLAG_NO_LEGACY	= (1 << 4), /* no legacy mode check */
-	ATA_FLAG_SRST		= (1 << 5), /* use ATA SRST, not E.D.D. */
+	ATA_FLAG_SRST		= (1 << 5), /* (obsolete) use ATA SRST, not E.D.D. */
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
-	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
+	ATA_FLAG_SATA_RESET	= (1 << 7), /* (obsolete) use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
 					     * proper HSM is in place. */
@@ -189,10 +222,15 @@ enum hsm_task_states {
 };
 
 enum ata_completion_errors {
-	AC_ERR_OTHER		= (1 << 0),
-	AC_ERR_DEV		= (1 << 1),
-	AC_ERR_ATA_BUS		= (1 << 2),
-	AC_ERR_HOST_BUS		= (1 << 3),
+	AC_ERR_DEV		= (1 << 0), /* device reported error */
+	AC_ERR_HSM		= (1 << 1), /* host state machine violation */
+	AC_ERR_TIMEOUT		= (1 << 2), /* timeout */
+	AC_ERR_MEDIA		= (1 << 3), /* media error */
+	AC_ERR_ATA_BUS		= (1 << 4), /* ATA bus error */
+	AC_ERR_HOST_BUS		= (1 << 5), /* host bus error */
+	AC_ERR_SYSTEM		= (1 << 6), /* system error */
+	AC_ERR_INVALID		= (1 << 7), /* invalid argument */
+	AC_ERR_OTHER		= (1 << 8), /* unknown */
 };
 
 /* forward declarations */
@@ -202,7 +240,9 @@ struct ata_port;
 struct ata_queued_cmd;
 
 /* typedefs */
-typedef int (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
+typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
+typedef int (*ata_reset_fn_t)(struct ata_port *, int, unsigned int *);
+typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *);
 
 struct ata_ioports {
 	unsigned long		cmd_addr;
@@ -359,6 +399,9 @@ struct ata_port {
 	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
 
+	u32			msg_enable;
+	struct list_head	eh_done_q;
+
 	void			*private_data;
 };
 
@@ -378,7 +421,9 @@ struct ata_port_operations {
 	u8   (*check_altstatus)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
-	void (*phy_reset) (struct ata_port *ap);
+	void (*phy_reset) (struct ata_port *ap); /* obsolete */
+	int (*probe_reset) (struct ata_port *ap, unsigned int *classes);
+
 	void (*post_set_mode) (struct ata_port *ap);
 
 	int (*check_atapi_dma) (struct ata_queued_cmd *qc);
@@ -387,7 +432,7 @@ struct ata_port_operations {
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 
 	void (*qc_prep) (struct ata_queued_cmd *qc);
-	int (*qc_issue) (struct ata_queued_cmd *qc);
+	unsigned int (*qc_issue) (struct ata_queued_cmd *qc);
 
 	void (*eng_timeout) (struct ata_port *ap);
 
@@ -435,6 +480,14 @@ extern void ata_port_probe(struct ata_po
 extern void __sata_phy_reset(struct ata_port *ap);
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
+extern int ata_drive_probe_reset(struct ata_port *ap,
+			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			ata_postreset_fn_t postreset, unsigned int *classes);
+extern int ata_std_softreset(struct ata_port *ap, int verbose,
+			     unsigned int *classes);
+extern int sata_std_hardreset(struct ata_port *ap, int verbose,
+			      unsigned int *class);
+extern void ata_std_postreset(struct ata_port *ap, unsigned int *classes);
 extern void ata_port_disable(struct ata_port *);
 extern void ata_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
@@ -450,6 +503,8 @@ extern int ata_scsi_detect(struct scsi_h
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_error(struct Scsi_Host *host);
+extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int ata_scsi_device_resume(struct scsi_device *);
@@ -457,6 +512,9 @@ extern int ata_scsi_device_suspend(struc
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
 extern int ata_device_suspend(struct ata_port *, struct ata_device *);
 extern int ata_ratelimit(void);
+extern unsigned int ata_busy_sleep(struct ata_port *ap,
+				   unsigned long timeout_pat,
+				   unsigned long timeout);
 
 /*
  * Default driver ops implementations
@@ -470,12 +528,13 @@ extern void ata_std_dev_select (struct a
 extern u8 ata_check_status(struct ata_port *ap);
 extern u8 ata_altstatus(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
+extern int ata_std_probe_reset(struct ata_port *ap, unsigned int *classes);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern void ata_host_stop (struct ata_host_set *host_set);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
-extern int ata_qc_issue_prot(struct ata_queued_cmd *qc);
+extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 extern void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf,
 		unsigned int buflen);
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -645,9 +704,9 @@ static inline u8 ata_wait_idle(struct at
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;
-		printk(KERN_WARNING
-		       "ATA: abnormal status 0x%X on port 0x%lX\n",
-		       status, l);
+		if (ata_msg_warn(ap))
+			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
+				status, l);
 	}
 
 	return status;
@@ -739,7 +798,8 @@ static inline u8 ata_irq_ack(struct ata_
 
 	status = ata_busy_wait(ap, bits, 1000);
 	if (status & bits)
-		DPRINTK("abnormal status 0x%X\n", status);
+		if (ata_msg_err(ap))
+			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -757,8 +817,10 @@ static inline u8 ata_irq_ack(struct ata_
 		post_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	}
 
-	VPRINTK("irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
-		host_stat, post_stat, status);
+	if (ata_msg_intr(ap))
+		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
+			__FUNCTION__,
+			host_stat, post_stat, status);
 
 	return status;
 }
@@ -795,7 +857,7 @@ static inline int ata_try_flush_cache(co
 static inline unsigned int ac_err_mask(u8 status)
 {
 	if (status & ATA_BUSY)
-		return AC_ERR_ATA_BUS;
+		return AC_ERR_HSM;
 	if (status & (ATA_ERR | ATA_DF))
 		return AC_ERR_DEV;
 	return 0;
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index fabd879..d160880 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -35,6 +35,9 @@ static inline int scsi_sense_valid(struc
 }
 
 
+extern void scsi_eh_finish_cmd(struct scsi_cmnd *scmd,
+			       struct list_head *done_q);
+extern void scsi_eh_flush_done_q(struct list_head *done_q);
 extern void scsi_report_bus_reset(struct Scsi_Host *, int);
 extern void scsi_report_device_reset(struct Scsi_Host *, int, int);
 extern int scsi_block_when_processing_errors(struct scsi_device *);
