Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVH2AZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVH2AZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 20:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVH2AZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 20:25:56 -0400
Received: from havoc.gtf.org ([69.61.125.42]:22941 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750954AbVH2AZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 20:25:54 -0400
Date: Sun, 28 Aug 2005 20:25:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata updates
Message-ID: <20050829002553.GA22864@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from the 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the changes described in the following diffstat/shortlog/patch.

It's mostly fixes for uncommon paths (PIO, ATAPI), and new PCI IDs.
Stuff not urgent enough for 2.6.13.


 drivers/scsi/ahci.c         |   12 +-
 drivers/scsi/ata_piix.c     |   14 +-
 drivers/scsi/libata-core.c  |  249 ++++++++++++++++++++++++++++++++++++--------
 drivers/scsi/libata-scsi.c  |   66 +++++++++++
 drivers/scsi/libata.h       |    2 
 drivers/scsi/sata_nv.c      |   24 +++-
 drivers/scsi/sata_promise.c |   12 +-
 drivers/scsi/sata_qstor.c   |   12 +-
 drivers/scsi/sata_sil.c     |   36 ++++--
 drivers/scsi/sata_sis.c     |    2 
 drivers/scsi/sata_svw.c     |   10 -
 drivers/scsi/sata_sx4.c     |  146 +++++++++++++------------
 drivers/scsi/sata_uli.c     |    2 
 drivers/scsi/sata_via.c     |    2 
 drivers/scsi/sata_vsc.c     |    5 
 include/linux/ata.h         |    2 
 include/linux/libata.h      |    8 -
 include/linux/pci_ids.h     |    1 
 18 files changed, 451 insertions(+), 154 deletions(-)


Alan Cox:
  libata: typo
  libata: regularize dma_start/stop arguments

Albert Lee:
  libata ata_data_xfer() fix
  libata handle the case when device returns/needs extra data
  libata: Clear ATA_QCFLAG_ACTIVE flag before calling the completion callback

Daniel Drake:
  sata_nv: Support MCP51/MCP55 device IDs
  sata_promise: Add PDC40519 id

Douglas Gilbert:
  [libata scsi] add START STOP UNIT translation

Jason Gaston:
  ahci: AHCI mode SATA patch for Intel ICH7-M DH

Jeff Garzik:
  libata: trim trailing whitespace.
  libata: fix EH locking
  [libata sata_sil] list documentation URL, since its public
  libata: fix a few alan-isms
  [libata scsi] fix read/write translation edge cases

Martin Wilck:
  Fix HD activity LED with ahci

Otto Meier:
  sata_promise: Add PDC40718 id

Tejun Heo:
  fix atapi_packet_task vs. intr race (take 2)
  libata: implement ata_poll_qc_complete and use it in polling functions
  sil: apply M15W quirk selectively (take 2)



diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -269,6 +269,8 @@ static struct pci_device_id ahci_pci_tbl
 	  board_ahci }, /* ESB2 */
 	{ PCI_VENDOR_ID_INTEL, 0x2683, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ESB2 */
+	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7-M DH */
 	{ }	/* terminate list */
 };
 
@@ -584,12 +586,16 @@ static void ahci_intr_error(struct ata_p
 
 static void ahci_eng_timeout(struct ata_port *ap)
 {
-	void *mmio = ap->host_set->mmio_base;
+	struct ata_host_set *host_set = ap->host_set;
+	void *mmio = host_set->mmio_base;
 	void *port_mmio = ahci_port_base(mmio, ap->port_no);
 	struct ata_queued_cmd *qc;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
+	spin_lock_irqsave(&host_set->lock, flags);
+
 	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -607,6 +613,7 @@ static void ahci_eng_timeout(struct ata_
 		ata_qc_complete(qc, ATA_ERR);
 	}
 
+	spin_unlock_irqrestore(&host_set->lock, flags);
 }
 
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
@@ -696,9 +703,6 @@ static int ahci_qc_issue(struct ata_queu
 	struct ata_port *ap = qc->ap;
 	void *port_mmio = (void *) ap->ioaddr.cmd_addr;
 
-	writel(1, port_mmio + PORT_SCR_ACT);
-	readl(port_mmio + PORT_SCR_ACT);	/* flush */
-
 	writel(1, port_mmio + PORT_CMD_ISSUE);
 	readl(port_mmio + PORT_CMD_ISSUE);	/* flush */
 
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -629,13 +629,13 @@ static int piix_init_one (struct pci_dev
 	port_info[1] = NULL;
 
 	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
-               u8 tmp;
-               pci_read_config_byte(pdev, PIIX_SCC, &tmp);
-               if (tmp == PIIX_AHCI_DEVICE) {
-                       int rc = piix_disable_ahci(pdev);
-                       if (rc)
-                           return rc;
-               }
+		u8 tmp;
+		pci_read_config_byte(pdev, PIIX_SCC, &tmp);
+		if (tmp == PIIX_AHCI_DEVICE) {
+			int rc = piix_disable_ahci(pdev);
+			if (rc)
+				return rc;
+		}
 	}
 
 	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1304,12 +1304,12 @@ static inline u8 ata_dev_knobble(struct 
 /**
  * 	ata_dev_config - Run device specific handlers and check for
  * 			 SATA->PATA bridges
- * 	@ap: Bus 
+ * 	@ap: Bus
  * 	@i:  Device
  *
  * 	LOCKING:
  */
- 
+
 void ata_dev_config(struct ata_port *ap, unsigned int i)
 {
 	/* limit bridge transfers to udma5, 200 sectors */
@@ -2377,6 +2377,27 @@ static int ata_sg_setup(struct ata_queue
 }
 
 /**
+ *	ata_poll_qc_complete - turn irq back on and finish qc
+ *	@qc: Command to complete
+ *	@drv_stat: ATA status register content
+ *
+ *	LOCKING:
+ *	None.  (grabs host lock)
+ */
+
+void ata_poll_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	ap->flags &= ~ATA_FLAG_NOINTR;
+	ata_irq_on(ap);
+	ata_qc_complete(qc, drv_stat);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+}
+
+/**
  *	ata_pio_poll -
  *	@ap:
  *
@@ -2438,11 +2459,10 @@ static void ata_pio_complete (struct ata
 	u8 drv_stat;
 
 	/*
-	 * This is purely hueristic.  This is a fast path.
-	 * Sometimes when we enter, BSY will be cleared in
-	 * a chk-status or two.  If not, the drive is probably seeking
-	 * or something.  Snooze for a couple msecs, then
-	 * chk-status again.  If still busy, fall back to
+	 * This is purely heuristic.  This is a fast path.  Sometimes when
+	 * we enter, BSY will be cleared in a chk-status or two.  If not,
+	 * the drive is probably seeking or something.  Snooze for a couple
+	 * msecs, then chk-status again.  If still busy, fall back to
 	 * PIO_ST_POLL state.
 	 */
 	drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 10);
@@ -2467,9 +2487,7 @@ static void ata_pio_complete (struct ata
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
-	ata_irq_on(ap);
-
-	ata_qc_complete(qc, drv_stat);
+	ata_poll_qc_complete(qc, drv_stat);
 }
 
 
@@ -2494,6 +2512,20 @@ void swap_buf_le16(u16 *buf, unsigned in
 #endif /* __BIG_ENDIAN */
 }
 
+/**
+ *	ata_mmio_data_xfer - Transfer data by MMIO
+ *	@ap: port to read/write
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@do_write: read/write
+ *
+ *	Transfer data from/to the device data register by MMIO.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void ata_mmio_data_xfer(struct ata_port *ap, unsigned char *buf,
 			       unsigned int buflen, int write_data)
 {
@@ -2502,6 +2534,7 @@ static void ata_mmio_data_xfer(struct at
 	u16 *buf16 = (u16 *) buf;
 	void __iomem *mmio = (void __iomem *)ap->ioaddr.data_addr;
 
+	/* Transfer multiple of 2 bytes */
 	if (write_data) {
 		for (i = 0; i < words; i++)
 			writew(le16_to_cpu(buf16[i]), mmio);
@@ -2509,19 +2542,76 @@ static void ata_mmio_data_xfer(struct at
 		for (i = 0; i < words; i++)
 			buf16[i] = cpu_to_le16(readw(mmio));
 	}
+
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		u16 align_buf[1] = { 0 };
+		unsigned char *trailing_buf = buf + buflen - 1;
+
+		if (write_data) {
+			memcpy(align_buf, trailing_buf, 1);
+			writew(le16_to_cpu(align_buf[0]), mmio);
+		} else {
+			align_buf[0] = cpu_to_le16(readw(mmio));
+			memcpy(trailing_buf, align_buf, 1);
+		}
+	}
 }
 
+/**
+ *	ata_pio_data_xfer - Transfer data by PIO
+ *	@ap: port to read/write
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@do_write: read/write
+ *
+ *	Transfer data from/to the device data register by PIO.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void ata_pio_data_xfer(struct ata_port *ap, unsigned char *buf,
 			      unsigned int buflen, int write_data)
 {
-	unsigned int dwords = buflen >> 1;
+	unsigned int words = buflen >> 1;
 
+	/* Transfer multiple of 2 bytes */
 	if (write_data)
-		outsw(ap->ioaddr.data_addr, buf, dwords);
+		outsw(ap->ioaddr.data_addr, buf, words);
 	else
-		insw(ap->ioaddr.data_addr, buf, dwords);
+		insw(ap->ioaddr.data_addr, buf, words);
+
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		u16 align_buf[1] = { 0 };
+		unsigned char *trailing_buf = buf + buflen - 1;
+
+		if (write_data) {
+			memcpy(align_buf, trailing_buf, 1);
+			outw(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);
+		} else {
+			align_buf[0] = cpu_to_le16(inw(ap->ioaddr.data_addr));
+			memcpy(trailing_buf, align_buf, 1);
+		}
+	}
 }
 
+/**
+ *	ata_data_xfer - Transfer data from/to the data register.
+ *	@ap: port to read/write
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@do_write: read/write
+ *
+ *	Transfer data from/to the device data register.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void ata_data_xfer(struct ata_port *ap, unsigned char *buf,
 			  unsigned int buflen, int do_write)
 {
@@ -2531,6 +2621,16 @@ static void ata_data_xfer(struct ata_por
 		ata_pio_data_xfer(ap, buf, buflen, do_write);
 }
 
+/**
+ *	ata_pio_sector - Transfer ATA_SECT_SIZE (512 bytes) of data.
+ *	@qc: Command on going
+ *
+ *	Transfer ATA_SECT_SIZE of data from/to the ATA device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+
 static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2569,6 +2669,18 @@ static void ata_pio_sector(struct ata_qu
 	kunmap(page);
 }
 
+/**
+ *	__atapi_pio_bytes - Transfer data from/to the ATAPI device.
+ *	@qc: Command on going
+ *	@bytes: number of bytes
+ *
+ *	Transfer Transfer data from/to the ATAPI device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 {
 	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
@@ -2578,10 +2690,33 @@ static void __atapi_pio_bytes(struct ata
 	unsigned char *buf;
 	unsigned int offset, count;
 
-	if (qc->curbytes == qc->nbytes - bytes)
+	if (qc->curbytes + bytes >= qc->nbytes)
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
+	if (unlikely(qc->cursg >= qc->n_elem)) {
+		/* 
+		 * The end of qc->sg is reached and the device expects
+		 * more data to transfer. In order not to overrun qc->sg
+		 * and fulfill length specified in the byte count register,
+		 *    - for read case, discard trailing data from the device
+		 *    - for write case, padding zero data to the device
+		 */
+		u16 pad_buf[1] = { 0 };
+		unsigned int words = bytes >> 1;
+		unsigned int i;
+
+		if (words) /* warning if bytes > 1 */
+			printk(KERN_WARNING "ata%u: %u bytes trailing data\n", 
+			       ap->id, bytes);
+
+		for (i = 0; i < words; i++)
+			ata_data_xfer(ap, (unsigned char*)pad_buf, 2, do_write);
+
+		ap->pio_task_state = PIO_ST_LAST;
+		return;
+	}
+
 	sg = &qc->sg[qc->cursg];
 
 	page = sg->page;
@@ -2615,11 +2750,21 @@ next_sg:
 
 	kunmap(page);
 
-	if (bytes) {
+	if (bytes)
 		goto next_sg;
-	}
 }
 
+/**
+ *	atapi_pio_bytes - Transfer data from/to the ATAPI device.
+ *	@qc: Command on going
+ *
+ *	Transfer Transfer data from/to the ATAPI device.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ */
+
 static void atapi_pio_bytes(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -2692,9 +2837,7 @@ static void ata_pio_block(struct ata_por
 		if ((status & ATA_DRQ) == 0) {
 			ap->pio_task_state = PIO_ST_IDLE;
 
-			ata_irq_on(ap);
-
-			ata_qc_complete(qc, status);
+			ata_poll_qc_complete(qc, status);
 			return;
 		}
 
@@ -2724,9 +2867,7 @@ static void ata_pio_error(struct ata_por
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
-	ata_irq_on(ap);
-
-	ata_qc_complete(qc, drv_stat | ATA_ERR);
+	ata_poll_qc_complete(qc, drv_stat | ATA_ERR);
 }
 
 static void ata_pio_task(void *_data)
@@ -2832,8 +2973,10 @@ static void atapi_request_sense(struct a
 static void ata_qc_timeout(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_host_set *host_set = ap->host_set;
 	struct ata_device *dev = qc->dev;
 	u8 host_stat = 0, drv_stat;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
@@ -2844,7 +2987,9 @@ static void ata_qc_timeout(struct ata_qu
 		if (!(cmd->eh_eflags & SCSI_EH_CANCEL_CMD)) {
 
 			/* finish completing original command */
+			spin_lock_irqsave(&host_set->lock, flags);
 			__ata_qc_complete(qc);
+			spin_unlock_irqrestore(&host_set->lock, flags);
 
 			atapi_request_sense(ap, dev, cmd);
 
@@ -2855,6 +3000,8 @@ static void ata_qc_timeout(struct ata_qu
 		}
 	}
 
+	spin_lock_irqsave(&host_set->lock, flags);
+
 	/* hack alert!  We cannot use the supplied completion
 	 * function from inside the ->eh_strategy_handler() thread.
 	 * libata is the only user of ->eh_strategy_handler() in
@@ -2870,7 +3017,7 @@ static void ata_qc_timeout(struct ata_qu
 		host_stat = ap->ops->bmdma_status(ap);
 
 		/* before we do anything else, clear DMA-Start bit */
-		ap->ops->bmdma_stop(ap);
+		ap->ops->bmdma_stop(qc);
 
 		/* fall through */
 
@@ -2888,6 +3035,9 @@ static void ata_qc_timeout(struct ata_qu
 		ata_qc_complete(qc, drv_stat);
 		break;
 	}
+
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
 out:
 	DPRINTK("EXIT\n");
 }
@@ -3061,9 +3211,14 @@ void ata_qc_complete(struct ata_queued_c
 	if (likely(qc->flags & ATA_QCFLAG_DMAMAP))
 		ata_sg_clean(qc);
 
+	/* atapi: mark qc as inactive to prevent the interrupt handler
+	 * from completing the command twice later, before the error handler
+	 * is called. (when rc != 0 and atapi request sense is needed)
+	 */
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
+
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
-	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3193,11 +3348,13 @@ int ata_qc_issue_prot(struct ata_queued_
 		break;
 
 	case ATA_PROT_ATAPI_NODATA:
+		ap->flags |= ATA_FLAG_NOINTR;
 		ata_tf_to_host_nolock(ap, &qc->tf);
 		queue_work(ata_wq, &ap->packet_task);
 		break;
 
 	case ATA_PROT_ATAPI_DMA:
+		ap->flags |= ATA_FLAG_NOINTR;
 		ap->ops->tf_load(ap, &qc->tf);	 /* load tf registers */
 		ap->ops->bmdma_setup(qc);	    /* set up bmdma */
 		queue_work(ata_wq, &ap->packet_task);
@@ -3242,7 +3399,7 @@ static void ata_bmdma_setup_mmio (struct
 }
 
 /**
- *	ata_bmdma_start - Start a PCI IDE BMDMA transaction
+ *	ata_bmdma_start_mmio - Start a PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
  *	LOCKING:
@@ -3413,7 +3570,7 @@ u8 ata_bmdma_status(struct ata_port *ap)
 
 /**
  *	ata_bmdma_stop - Stop PCI IDE BMDMA transfer
- *	@ap: Port associated with this ATA transaction.
+ *	@qc: Command we are ending DMA for
  *
  *	Clears the ATA_DMA_START flag in the dma control register
  *
@@ -3423,8 +3580,9 @@ u8 ata_bmdma_status(struct ata_port *ap)
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_bmdma_stop(struct ata_port *ap)
+void ata_bmdma_stop(struct ata_queued_cmd *qc)
 {
+	struct ata_port *ap = qc->ap;
 	if (ap->flags & ATA_FLAG_MMIO) {
 		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 
@@ -3476,7 +3634,7 @@ inline unsigned int ata_host_intr (struc
 			goto idle_irq;
 
 		/* before we do anything else, clear DMA-Start bit */
-		ap->ops->bmdma_stop(ap);
+		ap->ops->bmdma_stop(qc);
 
 		/* fall through */
 
@@ -3551,7 +3709,8 @@ irqreturn_t ata_interrupt (int irq, void
 		struct ata_port *ap;
 
 		ap = host_set->ports[i];
-		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -3603,19 +3762,27 @@ static void atapi_packet_task(void *_dat
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
 	assert(ap->cdb_len >= 12);
-	ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
-
-	/* if we are DMA'ing, irq handler takes over from here */
-	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
-		ap->ops->bmdma_start(qc);	    /* initiate bmdma */
 
-	/* non-data commands are also handled via irq */
-	else if (qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
-		/* do nothing */
-	}
+	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
+	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
+		unsigned long flags;
+
+		/* Once we're done issuing command and kicking bmdma,
+		 * irq handler takes over.  To not lose irq, we need
+		 * to clear NOINTR flag before sending cdb, but
+		 * interrupt handler shouldn't be invoked before we're
+		 * finished.  Hence, the following locking.
+		 */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
+		ap->flags &= ~ATA_FLAG_NOINTR;
+		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
+			ap->ops->bmdma_start(qc);	/* initiate bmdma */
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	} else {
+		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
 
-	/* PIO commands are handled by polling */
-	else {
+		/* PIO commands are handled by polling */
 		ap->pio_task_state = PIO_ST;
 		queue_work(ata_wq, &ap->pio_task);
 	}
@@ -3623,7 +3790,7 @@ static void atapi_packet_task(void *_dat
 	return;
 
 err_out:
-	ata_qc_complete(qc, ATA_ERR);
+	ata_poll_qc_complete(qc, ATA_ERR);
 }
 
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -392,6 +392,60 @@ int ata_scsi_error(struct Scsi_Host *hos
 }
 
 /**
+ *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
+ *	@qc: Storage for translated ATA taskfile
+ *	@scsicmd: SCSI command to translate
+ *
+ *	Sets up an ATA taskfile to issue STANDBY (to stop) or READ VERIFY
+ *	(to start). Perhaps these commands should be preceded by
+ *	CHECK POWER MODE to see what power mode the device is already in.
+ *	[See SAT revision 5 at www.t10.org]
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
+ */
+
+static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc,
+					     u8 *scsicmd)
+{
+	struct ata_taskfile *tf = &qc->tf;
+
+	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf->protocol = ATA_PROT_NODATA;
+	if (scsicmd[1] & 0x1) {
+		;	/* ignore IMMED bit, violates sat-r05 */
+	}
+	if (scsicmd[4] & 0x2)
+		return 1;	/* LOEJ bit set not supported */
+	if (((scsicmd[4] >> 4) & 0xf) != 0)
+		return 1;	/* power conditions not supported */
+	if (scsicmd[4] & 0x1) {
+		tf->nsect = 1;	/* 1 sector, lba=0 */
+		tf->lbah = 0x0;
+		tf->lbam = 0x0;
+		tf->lbal = 0x0;
+		tf->device |= ATA_LBA;
+		tf->command = ATA_CMD_VERIFY;	/* READ VERIFY */
+	} else {
+		tf->nsect = 0;	/* time period value (0 implies now) */
+		tf->command = ATA_CMD_STANDBY;
+		/* Consider: ATA STANDBY IMMEDIATE command */
+	}
+	/*
+	 * Standby and Idle condition timers could be implemented but that
+	 * would require libata to implement the Power condition mode page
+	 * and allow the user to change it. Changing mode pages requires
+	 * MODE SELECT to be implemented.
+	 */
+
+	return 0;
+}
+
+
+/**
  *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
  *	@qc: Storage for translated ATA taskfile
  *	@scsicmd: SCSI command to translate (ignored)
@@ -576,11 +630,19 @@ static unsigned int ata_scsi_rw_xlat(str
 		tf->lbah = scsicmd[3];
 
 		VPRINTK("ten-byte command\n");
+		if (qc->nsect == 0) /* we don't support length==0 cmds */
+			return 1;
 		return 0;
 	}
 
 	if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
 		qc->nsect = tf->nsect = scsicmd[4];
+		if (!qc->nsect) {
+			qc->nsect = 256;
+			if (lba48)
+				tf->hob_nsect = 1;
+		}
+
 		tf->lbal = scsicmd[3];
 		tf->lbam = scsicmd[2];
 		tf->lbah = scsicmd[1] & 0x1f; /* mask out reserved bits */
@@ -620,6 +682,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		tf->lbah = scsicmd[7];
 
 		VPRINTK("sixteen-byte command\n");
+		if (qc->nsect == 0) /* we don't support length==0 cmds */
+			return 1;
 		return 0;
 	}
 
@@ -1435,6 +1499,8 @@ static inline ata_xlat_func_t ata_get_xl
 	case VERIFY:
 	case VERIFY_16:
 		return ata_scsi_verify_xlat;
+	case START_STOP:
+		return ata_scsi_start_stop_xlat;
 	}
 
 	return NULL;
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -72,7 +72,7 @@ extern unsigned int ata_scsiop_report_lu
 extern void ata_scsi_badcmd(struct scsi_cmnd *cmd,
 			    void (*done)(struct scsi_cmnd *),
 			    u8 asc, u8 ascq);
-extern void ata_scsi_rbuf_fill(struct ata_scsi_args *args, 
+extern void ata_scsi_rbuf_fill(struct ata_scsi_args *args,
                         unsigned int (*actor) (struct ata_scsi_args *args,
                                            u8 *rbuf, unsigned int buflen));
 
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -20,6 +20,12 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.08
+ *     - Added support for MCP51 and MCP55.
+ *
+ *  0.07
+ *     - Added support for RAID class code.
+ *
  *  0.06
  *     - Added generic SATA support by using a pci_device_id that filters on
  *       the IDE storage class code.
@@ -48,7 +54,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.6"
+#define DRV_VERSION			"0.8"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -116,7 +122,9 @@ enum nv_host_type
 	GENERIC,
 	NFORCE2,
 	NFORCE3,
-	CK804
+	CK804,
+	MCP51,
+	MCP55
 };
 
 static struct pci_device_id nv_pci_tbl[] = {
@@ -134,9 +142,18 @@ static struct pci_device_id nv_pci_tbl[]
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_STORAGE_RAID<<8, 0xffff00, GENERIC },
 	{ 0, } /* terminate list */
 };
 
@@ -274,7 +291,8 @@ static irqreturn_t nv_interrupt (int irq
 		struct ata_port *ap;
 
 		ap = host_set->ports[i];
-		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -181,6 +181,10 @@ static struct pci_device_id pdc_ata_pci_
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 
@@ -321,11 +325,15 @@ static void pdc_qc_prep(struct ata_queue
 
 static void pdc_eng_timeout(struct ata_port *ap)
 {
+	struct ata_host_set *host_set = ap->host_set;
 	u8 drv_stat;
 	struct ata_queued_cmd *qc;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
+	spin_lock_irqsave(&host_set->lock, flags);
+
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (!qc) {
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
@@ -359,6 +367,7 @@ static void pdc_eng_timeout(struct ata_p
 	}
 
 out:
+	spin_unlock_irqrestore(&host_set->lock, flags);
 	DPRINTK("EXIT\n");
 }
 
@@ -441,7 +450,8 @@ static irqreturn_t pdc_interrupt (int ir
 		VPRINTK("port %u\n", i);
 		ap = host_set->ports[i];
 		tmp = mask & (1 << (i + 1));
-		if (tmp && ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (tmp && ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -117,7 +117,7 @@ static void qs_phy_reset(struct ata_port
 static void qs_qc_prep(struct ata_queued_cmd *qc);
 static int qs_qc_issue(struct ata_queued_cmd *qc);
 static int qs_check_atapi_dma(struct ata_queued_cmd *qc);
-static void qs_bmdma_stop(struct ata_port *ap);
+static void qs_bmdma_stop(struct ata_queued_cmd *qc);
 static u8 qs_bmdma_status(struct ata_port *ap);
 static void qs_irq_clear(struct ata_port *ap);
 static void qs_eng_timeout(struct ata_port *ap);
@@ -198,7 +198,7 @@ static int qs_check_atapi_dma(struct ata
 	return 1;	/* ATAPI DMA not supported */
 }
 
-static void qs_bmdma_stop(struct ata_port *ap)
+static void qs_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	/* nothing */
 }
@@ -386,7 +386,8 @@ static inline unsigned int qs_intr_pkt(s
 			DPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
 					sff1, sff0, port_no, sHST, sDST);
 			handled = 1;
-			if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+			if (ap && !(ap->flags &
+				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
 				struct qs_port_priv *pp = ap->private_data;
 				if (!pp || pp->state != qs_state_pkt)
@@ -417,7 +418,8 @@ static inline unsigned int qs_intr_mmio(
 	for (port_no = 0; port_no < host_set->n_ports; ++port_no) {
 		struct ata_port *ap;
 		ap = host_set->ports[port_no];
-		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 			struct qs_port_priv *pp = ap->private_data;
 			if (!pp || pp->state != qs_state_mmio)
@@ -431,7 +433,7 @@ static inline unsigned int qs_intr_mmio(
 					continue;
 				DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
 					ap->id, qc->tf.protocol, status);
-		
+
 				/* complete taskfile transaction */
 				pp->state = qs_state_idle;
 				ata_qc_complete(qc, status);
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -24,6 +24,11 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  Documentation for SiI 3112:
+ *  http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
+ *
+ *  Other errata and documentation available under NDA.
+ *
  */
 
 #include <linux/kernel.h>
@@ -41,8 +46,11 @@
 #define DRV_VERSION	"0.9"
 
 enum {
+	SIL_FLAG_MOD15WRITE	= (1 << 30),
+
 	sil_3112		= 0,
-	sil_3114		= 1,
+	sil_3112_m15w		= 1,
+	sil_3114		= 2,
 
 	SIL_FIFO_R0		= 0x40,
 	SIL_FIFO_W0		= 0x41,
@@ -76,13 +84,13 @@ static void sil_scr_write (struct ata_po
 static void sil_post_set_mode (struct ata_port *ap);
 
 static struct pci_device_id sil_pci_tbl[] = {
-	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
-	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ }	/* terminate list */
 };
 
@@ -174,6 +182,16 @@ static struct ata_port_info sil_port_inf
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
+	}, /* sil_3112_15w - keep it sync'd w/ sil_3112 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  SIL_FLAG_MOD15WRITE,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil_ops,
 	}, /* sil_3114 */
 	{
 		.sht		= &sil_sht,
@@ -323,15 +341,15 @@ static void sil_dev_config(struct ata_po
 	while ((len > 0) && (s[len - 1] == ' '))
 		len--;
 
-	for (n = 0; sil_blacklist[n].product; n++) 
+	for (n = 0; sil_blacklist[n].product; n++)
 		if (!memcmp(sil_blacklist[n].product, s,
 			    strlen(sil_blacklist[n].product))) {
 			quirks = sil_blacklist[n].quirk;
 			break;
 		}
-	
+
 	/* limit requests to 15 sectors */
-	if (quirks & SIL_QUIRK_MOD15WRITE) {
+	if ((ap->flags & SIL_FLAG_MOD15WRITE) && (quirks & SIL_QUIRK_MOD15WRITE)) {
 		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
 		       ap->id, dev->devno);
 		ap->host->max_sectors = 15;
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -234,7 +234,7 @@ static int sis_init_one (struct pci_dev 
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
 	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
 		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
-	
+
 	/* if hardware thinks SCRs are in IO space, but there are
 	 * no IO resources assigned, change to PCI cfg space.
 	 */
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -195,18 +195,18 @@ static void k2_bmdma_start_mmio (struct 
 	/* start host DMA transaction */
 	dmactl = readb(mmio + ATA_DMA_CMD);
 	writeb(dmactl | ATA_DMA_START, mmio + ATA_DMA_CMD);
-	/* There is a race condition in certain SATA controllers that can 
-	   be seen when the r/w command is given to the controller before the 
+	/* There is a race condition in certain SATA controllers that can
+	   be seen when the r/w command is given to the controller before the
 	   host DMA is started. On a Read command, the controller would initiate
 	   the command to the drive even before it sees the DMA start. When there
-	   are very fast drives connected to the controller, or when the data request 
+	   are very fast drives connected to the controller, or when the data request
 	   hits in the drive cache, there is the possibility that the drive returns a part
 	   or all of the requested data to the controller before the DMA start is issued.
 	   In this case, the controller would become confused as to what to do with the data.
 	   In the worst case when all the data is returned back to the controller, the
 	   controller could hang. In other cases it could return partial data returning
 	   in data corruption. This problem has been seen in PPC systems and can also appear
-	   on an system with very fast disks, where the SATA controller is sitting behind a 
+	   on an system with very fast disks, where the SATA controller is sitting behind a
 	   number of bridges, and hence there is significant latency between the r/w command
 	   and the start command. */
 	/* issue r/w command if the access is to ATA*/
@@ -214,7 +214,7 @@ static void k2_bmdma_start_mmio (struct 
 		ap->ops->exec_command(ap, &qc->tf);
 }
 
-									      
+
 static u8 k2_stat_check_status(struct ata_port *ap)
 {
        	return readl((void *) ap->ioaddr.status_addr);
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -94,7 +94,7 @@ enum {
 	PDC_DIMM1_CONTROL_OFFSET      = 0x84,
 	PDC_SDRAM_CONTROL_OFFSET      = 0x88,
 	PDC_I2C_WRITE                 = 0x00000000,
-	PDC_I2C_READ                  = 0x00000040,	
+	PDC_I2C_READ                  = 0x00000040,
 	PDC_I2C_START                 = 0x00000080,
 	PDC_I2C_MASK_INT              = 0x00000020,
 	PDC_I2C_COMPLETE              = 0x00010000,
@@ -105,16 +105,16 @@ enum {
 	PDC_DIMM_SPD_COLUMN_NUM       = 4,
 	PDC_DIMM_SPD_MODULE_ROW       = 5,
 	PDC_DIMM_SPD_TYPE             = 11,
-	PDC_DIMM_SPD_FRESH_RATE       = 12,         
-	PDC_DIMM_SPD_BANK_NUM         = 17,	
+	PDC_DIMM_SPD_FRESH_RATE       = 12,
+	PDC_DIMM_SPD_BANK_NUM         = 17,
 	PDC_DIMM_SPD_CAS_LATENCY      = 18,
-	PDC_DIMM_SPD_ATTRIBUTE        = 21,    
+	PDC_DIMM_SPD_ATTRIBUTE        = 21,
 	PDC_DIMM_SPD_ROW_PRE_CHARGE   = 27,
-	PDC_DIMM_SPD_ROW_ACTIVE_DELAY = 28,      
+	PDC_DIMM_SPD_ROW_ACTIVE_DELAY = 28,
 	PDC_DIMM_SPD_RAS_CAS_DELAY    = 29,
 	PDC_DIMM_SPD_ACTIVE_PRECHARGE = 30,
 	PDC_DIMM_SPD_SYSTEM_FREQ      = 126,
-	PDC_CTL_STATUS		      = 0x08,	
+	PDC_CTL_STATUS		      = 0x08,
 	PDC_DIMM_WINDOW_CTLR	      = 0x0C,
 	PDC_TIME_CONTROL              = 0x3C,
 	PDC_TIME_PERIOD               = 0x40,
@@ -157,15 +157,15 @@ static void pdc_exec_command_mmio(struct
 static void pdc20621_host_stop(struct ata_host_set *host_set);
 static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe);
 static int pdc20621_detect_dimm(struct ata_probe_ent *pe);
-static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe, 
+static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe,
 				      u32 device, u32 subaddr, u32 *pdata);
 static int pdc20621_prog_dimm0(struct ata_probe_ent *pe);
 static unsigned int pdc20621_prog_dimm_global(struct ata_probe_ent *pe);
 #ifdef ATA_VERBOSE_DEBUG
-static void pdc20621_get_from_dimm(struct ata_probe_ent *pe, 
+static void pdc20621_get_from_dimm(struct ata_probe_ent *pe,
 				   void *psource, u32 offset, u32 size);
 #endif
-static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, 
+static void pdc20621_put_to_dimm(struct ata_probe_ent *pe,
 				 void *psource, u32 offset, u32 size);
 static void pdc20621_irq_clear(struct ata_port *ap);
 static int pdc20621_qc_issue_prot(struct ata_queued_cmd *qc);
@@ -825,7 +825,8 @@ static irqreturn_t pdc20621_interrupt (i
 			ap = host_set->ports[port_no];
 		tmp = mask & (1 << i);
 		VPRINTK("seq %u, port_no %u, ap %p, tmp %x\n", i, port_no, ap, tmp);
-		if (tmp && ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+		if (tmp && ap &&
+		    !(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -847,10 +848,14 @@ static irqreturn_t pdc20621_interrupt (i
 static void pdc_eng_timeout(struct ata_port *ap)
 {
 	u8 drv_stat;
+	struct ata_host_set *host_set = ap->host_set;
 	struct ata_queued_cmd *qc;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
+	spin_lock_irqsave(&host_set->lock, flags);
+
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	if (!qc) {
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
@@ -884,6 +889,7 @@ static void pdc_eng_timeout(struct ata_p
 	}
 
 out:
+	spin_unlock_irqrestore(&host_set->lock, flags);
 	DPRINTK("EXIT\n");
 }
 
@@ -922,7 +928,7 @@ static void pdc_sata_setup_port(struct a
 
 
 #ifdef ATA_VERBOSE_DEBUG
-static void pdc20621_get_from_dimm(struct ata_probe_ent *pe, void *psource, 
+static void pdc20621_get_from_dimm(struct ata_probe_ent *pe, void *psource,
 				   u32 offset, u32 size)
 {
 	u32 window_size;
@@ -936,9 +942,9 @@ static void pdc20621_get_from_dimm(struc
 	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
-	page_mask = 0x00;	
-   	window_size = 0x2000 * 4; /* 32K byte uchar size */  
-	idx = (u16) (offset / window_size); 
+	page_mask = 0x00;
+   	window_size = 0x2000 * 4; /* 32K byte uchar size */
+	idx = (u16) (offset / window_size);
 
 	writel(0x01, mmio + PDC_GENERAL_CTLR);
 	readl(mmio + PDC_GENERAL_CTLR);
@@ -947,19 +953,19 @@ static void pdc20621_get_from_dimm(struc
 
 	offset -= (idx * window_size);
 	idx++;
-	dist = ((long) (window_size - (offset + size))) >= 0 ? size : 
+	dist = ((long) (window_size - (offset + size))) >= 0 ? size :
 		(long) (window_size - offset);
-	memcpy_fromio((char *) psource, (char *) (dimm_mmio + offset / 4), 
+	memcpy_fromio((char *) psource, (char *) (dimm_mmio + offset / 4),
 		      dist);
 
-	psource += dist;    
+	psource += dist;
 	size -= dist;
 	for (; (long) size >= (long) window_size ;) {
 		writel(0x01, mmio + PDC_GENERAL_CTLR);
 		readl(mmio + PDC_GENERAL_CTLR);
 		writel(((idx) << page_mask), mmio + PDC_DIMM_WINDOW_CTLR);
 		readl(mmio + PDC_DIMM_WINDOW_CTLR);
-		memcpy_fromio((char *) psource, (char *) (dimm_mmio), 
+		memcpy_fromio((char *) psource, (char *) (dimm_mmio),
 			      window_size / 4);
 		psource += window_size;
 		size -= window_size;
@@ -971,14 +977,14 @@ static void pdc20621_get_from_dimm(struc
 		readl(mmio + PDC_GENERAL_CTLR);
 		writel(((idx) << page_mask), mmio + PDC_DIMM_WINDOW_CTLR);
 		readl(mmio + PDC_DIMM_WINDOW_CTLR);
-		memcpy_fromio((char *) psource, (char *) (dimm_mmio), 
+		memcpy_fromio((char *) psource, (char *) (dimm_mmio),
 			      size / 4);
 	}
 }
 #endif
 
 
-static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, void *psource, 
+static void pdc20621_put_to_dimm(struct ata_probe_ent *pe, void *psource,
 				 u32 offset, u32 size)
 {
 	u32 window_size;
@@ -989,16 +995,16 @@ static void pdc20621_put_to_dimm(struct 
 	struct pdc_host_priv *hpriv = pe->private_data;
 	void *dimm_mmio = hpriv->dimm_mmio;
 
-	/* hard-code chip #0 */   
+	/* hard-code chip #0 */
 	mmio += PDC_CHIP0_OFS;
 
-	page_mask = 0x00;	
-   	window_size = 0x2000 * 4;       /* 32K byte uchar size */  
+	page_mask = 0x00;
+   	window_size = 0x2000 * 4;       /* 32K byte uchar size */
 	idx = (u16) (offset / window_size);
 
 	writel(((idx) << page_mask), mmio + PDC_DIMM_WINDOW_CTLR);
 	readl(mmio + PDC_DIMM_WINDOW_CTLR);
-	offset -= (idx * window_size); 
+	offset -= (idx * window_size);
 	idx++;
 	dist = ((long)(s32)(window_size - (offset + size))) >= 0 ? size :
 		(long) (window_size - offset);
@@ -1006,12 +1012,12 @@ static void pdc20621_put_to_dimm(struct 
 	writel(0x01, mmio + PDC_GENERAL_CTLR);
 	readl(mmio + PDC_GENERAL_CTLR);
 
-	psource += dist;    
+	psource += dist;
 	size -= dist;
 	for (; (long) size >= (long) window_size ;) {
 		writel(((idx) << page_mask), mmio + PDC_DIMM_WINDOW_CTLR);
 		readl(mmio + PDC_DIMM_WINDOW_CTLR);
-		memcpy_toio((char *) (dimm_mmio), (char *) psource, 
+		memcpy_toio((char *) (dimm_mmio), (char *) psource,
 			    window_size / 4);
 		writel(0x01, mmio + PDC_GENERAL_CTLR);
 		readl(mmio + PDC_GENERAL_CTLR);
@@ -1019,7 +1025,7 @@ static void pdc20621_put_to_dimm(struct 
 		size -= window_size;
 		idx ++;
 	}
-    
+
 	if (size) {
 		writel(((idx) << page_mask), mmio + PDC_DIMM_WINDOW_CTLR);
 		readl(mmio + PDC_DIMM_WINDOW_CTLR);
@@ -1030,12 +1036,12 @@ static void pdc20621_put_to_dimm(struct 
 }
 
 
-static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe, u32 device, 
+static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe, u32 device,
 				      u32 subaddr, u32 *pdata)
 {
 	void *mmio = pe->mmio_base;
 	u32 i2creg  = 0;
-	u32 status;     
+	u32 status;
 	u32 count =0;
 
 	/* hard-code chip #0 */
@@ -1049,7 +1055,7 @@ static unsigned int pdc20621_i2c_read(st
 	readl(mmio + PDC_I2C_ADDR_DATA_OFFSET);
 
 	/* Write Control to perform read operation, mask int */
-	writel(PDC_I2C_READ | PDC_I2C_START | PDC_I2C_MASK_INT, 
+	writel(PDC_I2C_READ | PDC_I2C_START | PDC_I2C_MASK_INT,
 	       mmio + PDC_I2C_CONTROL_OFFSET);
 
 	for (count = 0; count <= 1000; count ++) {
@@ -1062,26 +1068,26 @@ static unsigned int pdc20621_i2c_read(st
 	}
 
 	*pdata = (status >> 8) & 0x000000ff;
-	return 1;           
+	return 1;
 }
 
 
 static int pdc20621_detect_dimm(struct ata_probe_ent *pe)
 {
 	u32 data=0 ;
-  	if (pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS, 
+  	if (pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS,
 			     PDC_DIMM_SPD_SYSTEM_FREQ, &data)) {
    		if (data == 100)
 			return 100;
   	} else
 		return 0;
- 	
+
    	if (pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS, 9, &data)) {
-		if(data <= 0x75) 
+		if(data <= 0x75)
 			return 133;
    	} else
 		return 0;
-   	
+
    	return 0;
 }
 
@@ -1091,15 +1097,15 @@ static int pdc20621_prog_dimm0(struct at
 	u32 spd0[50];
 	u32 data = 0;
    	int size, i;
-   	u8 bdimmsize; 
+   	u8 bdimmsize;
    	void *mmio = pe->mmio_base;
 	static const struct {
 		unsigned int reg;
 		unsigned int ofs;
 	} pdc_i2c_read_data [] = {
-		{ PDC_DIMM_SPD_TYPE, 11 },		
+		{ PDC_DIMM_SPD_TYPE, 11 },
 		{ PDC_DIMM_SPD_FRESH_RATE, 12 },
-		{ PDC_DIMM_SPD_COLUMN_NUM, 4 }, 
+		{ PDC_DIMM_SPD_COLUMN_NUM, 4 },
 		{ PDC_DIMM_SPD_ATTRIBUTE, 21 },
 		{ PDC_DIMM_SPD_ROW_NUM, 3 },
 		{ PDC_DIMM_SPD_BANK_NUM, 17 },
@@ -1108,7 +1114,7 @@ static int pdc20621_prog_dimm0(struct at
 		{ PDC_DIMM_SPD_ROW_ACTIVE_DELAY, 28 },
 		{ PDC_DIMM_SPD_RAS_CAS_DELAY, 29 },
 		{ PDC_DIMM_SPD_ACTIVE_PRECHARGE, 30 },
-		{ PDC_DIMM_SPD_CAS_LATENCY, 18 },       
+		{ PDC_DIMM_SPD_CAS_LATENCY, 18 },
 	};
 
 	/* hard-code chip #0 */
@@ -1116,17 +1122,17 @@ static int pdc20621_prog_dimm0(struct at
 
 	for(i=0; i<ARRAY_SIZE(pdc_i2c_read_data); i++)
 		pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS,
-				  pdc_i2c_read_data[i].reg, 
+				  pdc_i2c_read_data[i].reg,
 				  &spd0[pdc_i2c_read_data[i].ofs]);
-  
+
    	data |= (spd0[4] - 8) | ((spd0[21] != 0) << 3) | ((spd0[3]-11) << 4);
-   	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) | 
+   	data |= ((spd0[17] / 4) << 6) | ((spd0[5] / 2) << 7) |
 		((((spd0[27] + 9) / 10) - 1) << 8) ;
-   	data |= (((((spd0[29] > spd0[28]) 
-		    ? spd0[29] : spd0[28]) + 9) / 10) - 1) << 10; 
+   	data |= (((((spd0[29] > spd0[28])
+		    ? spd0[29] : spd0[28]) + 9) / 10) - 1) << 10;
    	data |= ((spd0[30] - spd0[29] + 9) / 10 - 2) << 12;
-   
-   	if (spd0[18] & 0x08) 
+
+   	if (spd0[18] & 0x08)
 		data |= ((0x03) << 14);
    	else if (spd0[18] & 0x04)
 		data |= ((0x02) << 14);
@@ -1135,7 +1141,7 @@ static int pdc20621_prog_dimm0(struct at
    	else
 		data |= (0 << 14);
 
-  	/* 
+  	/*
 	   Calculate the size of bDIMMSize (power of 2) and
 	   merge the DIMM size by program start/end address.
 	*/
@@ -1145,9 +1151,9 @@ static int pdc20621_prog_dimm0(struct at
    	data |= (((size / 16) - 1) << 16);
    	data |= (0 << 23);
 	data |= 8;
-   	writel(data, mmio + PDC_DIMM0_CONTROL_OFFSET); 
+   	writel(data, mmio + PDC_DIMM0_CONTROL_OFFSET);
 	readl(mmio + PDC_DIMM0_CONTROL_OFFSET);
-   	return size;                          
+   	return size;
 }
 
 
@@ -1167,12 +1173,12 @@ static unsigned int pdc20621_prog_dimm_g
 	  Refresh Enable (bit 17)
 	*/
 
-	data = 0x022259F1;   
+	data = 0x022259F1;
 	writel(data, mmio + PDC_SDRAM_CONTROL_OFFSET);
 	readl(mmio + PDC_SDRAM_CONTROL_OFFSET);
 
 	/* Turn on for ECC */
-	pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS, 
+	pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS,
 			  PDC_DIMM_SPD_TYPE, &spd0);
 	if (spd0 == 0x02) {
 		data |= (0x01 << 16);
@@ -1186,22 +1192,22 @@ static unsigned int pdc20621_prog_dimm_g
    	data |= (1<<19);
    	writel(data, mmio + PDC_SDRAM_CONTROL_OFFSET);
 
-   	error = 1;                     
+   	error = 1;
    	for (i = 1; i <= 10; i++) {   /* polling ~5 secs */
 		data = readl(mmio + PDC_SDRAM_CONTROL_OFFSET);
 		if (!(data & (1<<19))) {
 	   		error = 0;
-	   		break;     
+	   		break;
 		}
 		msleep(i*100);
    	}
    	return error;
 }
-	
+
 
 static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe)
 {
-	int speed, size, length; 
+	int speed, size, length;
 	u32 addr,spd0,pci_status;
 	u32 tmp=0;
 	u32 time_period=0;
@@ -1228,7 +1234,7 @@ static unsigned int pdc20621_dimm_init(s
 	/* Wait 3 seconds */
 	msleep(3000);
 
-	/* 
+	/*
 	   When timer is enabled, counter is decreased every internal
 	   clock cycle.
 	*/
@@ -1236,24 +1242,24 @@ static unsigned int pdc20621_dimm_init(s
 	tcount = readl(mmio + PDC_TIME_COUNTER);
 	VPRINTK("Time Counter Register (0x44): 0x%x\n", tcount);
 
-	/* 
+	/*
 	   If SX4 is on PCI-X bus, after 3 seconds, the timer counter
 	   register should be >= (0xffffffff - 3x10^8).
 	*/
 	if(tcount >= PCI_X_TCOUNT) {
 		ticks = (time_period - tcount);
 		VPRINTK("Num counters 0x%x (%d)\n", ticks, ticks);
-	
+
 		clock = (ticks / 300000);
 		VPRINTK("10 * Internal clk = 0x%x (%d)\n", clock, clock);
-		
+
 		clock = (clock * 33);
 		VPRINTK("10 * Internal clk * 33 = 0x%x (%d)\n", clock, clock);
 
 		/* PLL F Param (bit 22:16) */
 		fparam = (1400000 / clock) - 2;
 		VPRINTK("PLL F Param: 0x%x (%d)\n", fparam, fparam);
-		
+
 		/* OD param = 0x2 (bit 31:30), R param = 0x5 (bit 29:25) */
 		pci_status = (0x8a001824 | (fparam << 16));
 	} else
@@ -1264,21 +1270,21 @@ static unsigned int pdc20621_dimm_init(s
 	writel(pci_status, mmio + PDC_CTL_STATUS);
 	readl(mmio + PDC_CTL_STATUS);
 
-	/* 
+	/*
 	   Read SPD of DIMM by I2C interface,
 	   and program the DIMM Module Controller.
 	*/
  	if (!(speed = pdc20621_detect_dimm(pe))) {
-		printk(KERN_ERR "Detect Local DIMM Fail\n");  
+		printk(KERN_ERR "Detect Local DIMM Fail\n");
 		return 1;	/* DIMM error */
    	}
    	VPRINTK("Local DIMM Speed = %d\n", speed);
 
-   	/* Programming DIMM0 Module Control Register (index_CID0:80h) */ 
+   	/* Programming DIMM0 Module Control Register (index_CID0:80h) */
    	size = pdc20621_prog_dimm0(pe);
    	VPRINTK("Local DIMM Size = %dMB\n",size);
 
-   	/* Programming DIMM Module Global Control Register (index_CID0:88h) */ 
+   	/* Programming DIMM Module Global Control Register (index_CID0:88h) */
    	if (pdc20621_prog_dimm_global(pe)) {
 		printk(KERN_ERR "Programming DIMM Module Global Control Register Fail\n");
 		return 1;
@@ -1297,30 +1303,30 @@ static unsigned int pdc20621_dimm_init(s
 
 		pdc20621_put_to_dimm(pe, (void *) test_parttern1, 0x10040, 40);
 		pdc20621_get_from_dimm(pe, (void *) test_parttern2, 0x40, 40);
-		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0], 
+		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0],
 		       test_parttern2[1], &(test_parttern2[2]));
-		pdc20621_get_from_dimm(pe, (void *) test_parttern2, 0x10040, 
+		pdc20621_get_from_dimm(pe, (void *) test_parttern2, 0x10040,
 				       40);
-		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0], 
+		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0],
 		       test_parttern2[1], &(test_parttern2[2]));
 
 		pdc20621_put_to_dimm(pe, (void *) test_parttern1, 0x40, 40);
 		pdc20621_get_from_dimm(pe, (void *) test_parttern2, 0x40, 40);
-		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0], 
+		printk(KERN_ERR "%x, %x, %s\n", test_parttern2[0],
 		       test_parttern2[1], &(test_parttern2[2]));
 	}
 #endif
 
 	/* ECC initiliazation. */
 
-	pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS, 
+	pdc20621_i2c_read(pe, PDC_DIMM0_SPD_DEV_ADDRESS,
 			  PDC_DIMM_SPD_TYPE, &spd0);
 	if (spd0 == 0x02) {
 		VPRINTK("Start ECC initialization\n");
 		addr = 0;
 		length = size * 1024 * 1024;
 		while (addr < length) {
-			pdc20621_put_to_dimm(pe, (void *) &tmp, addr, 
+			pdc20621_put_to_dimm(pe, (void *) &tmp, addr,
 					     sizeof(u32));
 			addr += sizeof(u32);
 		}
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -214,7 +214,7 @@ static int uli_init_one (struct pci_dev 
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
-	
+
 	switch (board_idx) {
 	case uli_5287:
 		probe_ent->port[0].scr_addr = ULI5287_BASE;
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -347,7 +347,7 @@ static int svia_init_one (struct pci_dev
 		probe_ent = vt6420_init_probe_ent(pdev);
 	else
 		probe_ent = vt6421_init_probe_ent(pdev);
-	
+
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       pci_name(pdev));
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -173,7 +173,8 @@ static irqreturn_t vsc_sata_interrupt (i
 			struct ata_port *ap;
 
 			ap = host_set->ports[i];
-			if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+			if (ap && !(ap->flags &
+				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -342,7 +343,7 @@ static int __devinit vsc_sata_init_one (
 
 	pci_set_master(pdev);
 
-	/* 
+	/*
 	 * Config offset 0x98 is "Extended Control and Status Register 0"
 	 * Default value is (1 << 28).  All bits except bit 28 are reserved in
 	 * DPA mode.  If bit 28 is set, LED 0 reflects all ports' activity.
diff --git a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -108,6 +108,8 @@ enum {
 
 	/* ATA device commands */
 	ATA_CMD_CHK_POWER	= 0xE5, /* check power mode */
+	ATA_CMD_STANDBY		= 0xE2, /* place in standby power mode */
+	ATA_CMD_IDLE		= 0xE3, /* place in idle power mode */
 	ATA_CMD_EDD		= 0x90,	/* execute device diagnostic */
 	ATA_CMD_FLUSH		= 0xE7,
 	ATA_CMD_FLUSH_EXT	= 0xEA,
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -113,6 +113,8 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
+					     * proper HSM is in place. */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -363,7 +365,7 @@ struct ata_port_operations {
 
 	void (*host_stop) (struct ata_host_set *host_set);
 
-	void (*bmdma_stop) (struct ata_port *ap);
+	void (*bmdma_stop) (struct ata_queued_cmd *qc);
 	u8   (*bmdma_status) (struct ata_port *ap);
 };
 
@@ -424,7 +426,7 @@ extern void ata_dev_id_string(u16 *id, u
 extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
-extern void ata_bmdma_stop(struct ata_port *ap);
+extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat);
@@ -644,7 +646,7 @@ static inline void scr_write(struct ata_
 	ap->ops->scr_write(ap, reg, val);
 }
 
-static inline void scr_write_flush(struct ata_port *ap, unsigned int reg, 
+static inline void scr_write_flush(struct ata_port *ap, unsigned int reg,
 				   u32 val)
 {
 	ap->ops->scr_write(ap, reg, val);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1249,6 +1249,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA	0x0266
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2	0x0267
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_IDE	0x036E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA	0x036F
 #define PCI_DEVICE_ID_NVIDIA_NVENET_12		0x0268
 #define PCI_DEVICE_ID_NVIDIA_NVENET_13		0x0269
 #define PCI_DEVICE_ID_NVIDIA_MCP51_AUDIO	0x026B
