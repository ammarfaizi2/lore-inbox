Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWETErL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWETErL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 00:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWETErL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 00:47:11 -0400
Received: from havoc.gtf.org ([69.61.125.42]:46782 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751202AbWETErJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 00:47:09 -0400
Date: Sat, 20 May 2006 00:47:07 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20060520044707.GA7866@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-core.c |    6 ++
 drivers/scsi/sata_mv.c     |  134 +++++++++++++++++++++++++--------------------
 2 files changed, 83 insertions(+), 57 deletions(-)

Mark Lord:
      sata_mv: prevent unnecessary double-resets
      sata_mv: deal with interrupt coalescing interrupts
      sata_mv: chip initialization fixes
      sata_mv: spurious interrupt workaround
      sata_mv: remove local copy of queue indexes
      sata_mv: endian fix
      sata_mv: version bump

Randy Dunlap:
      libata-core: fix current kernel-doc warnings

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bd14720..823dfa7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -864,6 +864,9 @@ static unsigned int ata_id_xfermask(cons
 /**
  *	ata_port_queue_task - Queue port_task
  *	@ap: The ata_port to queue port_task for
+ *	@fn: workqueue function to be scheduled
+ *	@data: data value to pass to workqueue function
+ *	@delay: delay time for workqueue function
  *
  *	Schedule @fn(@data) for execution after @delay jiffies using
  *	port_task.  There is one port_task per port and it's the
@@ -2739,6 +2742,8 @@ static unsigned int ata_dev_set_xfermode
  *	ata_dev_init_params - Issue INIT DEV PARAMS command
  *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
+ *	@heads: Number of heads (taskfile parameter)
+ *	@sectors: Number of sectors (taskfile parameter)
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -4302,6 +4307,7 @@ int ata_device_resume(struct ata_port *a
  *	ata_device_suspend - prepare a device for suspend
  *	@ap: port the device is connected to
  *	@dev: the device to suspend
+ *	@state: target power management state
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index d5fdcb9..9b8bca1 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -37,7 +37,7 @@ #include <linux/libata.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"0.6"
+#define DRV_VERSION	"0.7"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -50,6 +50,12 @@ enum {
 
 	MV_PCI_REG_BASE		= 0,
 	MV_IRQ_COAL_REG_BASE	= 0x18000,	/* 6xxx part only */
+	MV_IRQ_COAL_CAUSE		= (MV_IRQ_COAL_REG_BASE + 0x08),
+	MV_IRQ_COAL_CAUSE_LO		= (MV_IRQ_COAL_REG_BASE + 0x88),
+	MV_IRQ_COAL_CAUSE_HI		= (MV_IRQ_COAL_REG_BASE + 0x8c),
+	MV_IRQ_COAL_THRESHOLD		= (MV_IRQ_COAL_REG_BASE + 0xcc),
+	MV_IRQ_COAL_TIME_THRESHOLD	= (MV_IRQ_COAL_REG_BASE + 0xd0),
+
 	MV_SATAHC0_REG_BASE	= 0x20000,
 	MV_FLASH_CTL		= 0x1046c,
 	MV_GPIO_PORT_CTL	= 0x104f0,
@@ -302,9 +308,6 @@ struct mv_port_priv {
 	dma_addr_t		crpb_dma;
 	struct mv_sg		*sg_tbl;
 	dma_addr_t		sg_tbl_dma;
-
-	unsigned		req_producer;		/* cp of req_in_ptr */
-	unsigned		rsp_consumer;		/* cp of rsp_out_ptr */
 	u32			pp_flags;
 };
 
@@ -937,8 +940,6 @@ static int mv_port_start(struct ata_port
 	writelfl(pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK,
 		 port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
-	pp->req_producer = pp->rsp_consumer = 0;
-
 	/* Don't turn on EDMA here...do it before DMA commands only.  Else
 	 * we'll be unable to send non-data, PIO, etc due to restricted access
 	 * to shadow regs.
@@ -1022,16 +1023,16 @@ static void mv_fill_sg(struct ata_queued
 	}
 }
 
-static inline unsigned mv_inc_q_index(unsigned *index)
+static inline unsigned mv_inc_q_index(unsigned index)
 {
-	*index = (*index + 1) & MV_MAX_Q_DEPTH_MASK;
-	return *index;
+	return (index + 1) & MV_MAX_Q_DEPTH_MASK;
 }
 
 static inline void mv_crqb_pack_cmd(u16 *cmdw, u8 data, u8 addr, unsigned last)
 {
-	*cmdw = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
+	u16 tmp = data | (addr << CRQB_CMD_ADDR_SHIFT) | CRQB_CMD_CS |
 		(last ? CRQB_CMD_LAST : 0);
+	*cmdw = cpu_to_le16(tmp);
 }
 
 /**
@@ -1053,15 +1054,11 @@ static void mv_qc_prep(struct ata_queued
 	u16 *cw;
 	struct ata_taskfile *tf;
 	u16 flags = 0;
+	unsigned in_index;
 
  	if (ATA_PROT_DMA != qc->tf.protocol)
 		return;
 
-	/* the req producer index should be the same as we remember it */
-	WARN_ON(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
-		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->req_producer);
-
 	/* Fill in command request block
 	 */
 	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
@@ -1069,13 +1066,17 @@ static void mv_qc_prep(struct ata_queued
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
-	pp->crqb[pp->req_producer].sg_addr =
+	/* get current queue index from hardware */
+	in_index = (readl(mv_ap_base(ap) + EDMA_REQ_Q_IN_PTR_OFS)
+			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
+
+	pp->crqb[in_index].sg_addr =
 		cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
-	pp->crqb[pp->req_producer].sg_addr_hi =
+	pp->crqb[in_index].sg_addr_hi =
 		cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
-	pp->crqb[pp->req_producer].ctrl_flags = cpu_to_le16(flags);
+	pp->crqb[in_index].ctrl_flags = cpu_to_le16(flags);
 
-	cw = &pp->crqb[pp->req_producer].ata_cmd[0];
+	cw = &pp->crqb[in_index].ata_cmd[0];
 	tf = &qc->tf;
 
 	/* Sadly, the CRQB cannot accomodate all registers--there are
@@ -1144,16 +1145,12 @@ static void mv_qc_prep_iie(struct ata_qu
 	struct mv_port_priv *pp = ap->private_data;
 	struct mv_crqb_iie *crqb;
 	struct ata_taskfile *tf;
+	unsigned in_index;
 	u32 flags = 0;
 
  	if (ATA_PROT_DMA != qc->tf.protocol)
 		return;
 
-	/* the req producer index should be the same as we remember it */
-	WARN_ON(((readl(mv_ap_base(qc->ap) + EDMA_REQ_Q_IN_PTR_OFS) >>
-		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->req_producer);
-
 	/* Fill in Gen IIE command request block
 	 */
 	if (!(qc->tf.flags & ATA_TFLAG_WRITE))
@@ -1162,7 +1159,11 @@ static void mv_qc_prep_iie(struct ata_qu
 	WARN_ON(MV_MAX_Q_DEPTH <= qc->tag);
 	flags |= qc->tag << CRQB_TAG_SHIFT;
 
-	crqb = (struct mv_crqb_iie *) &pp->crqb[pp->req_producer];
+	/* get current queue index from hardware */
+	in_index = (readl(mv_ap_base(ap) + EDMA_REQ_Q_IN_PTR_OFS)
+			>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
+
+	crqb = (struct mv_crqb_iie *) &pp->crqb[in_index];
 	crqb->addr = cpu_to_le32(pp->sg_tbl_dma & 0xffffffff);
 	crqb->addr_hi = cpu_to_le32((pp->sg_tbl_dma >> 16) >> 16);
 	crqb->flags = cpu_to_le32(flags);
@@ -1210,6 +1211,7 @@ static unsigned int mv_qc_issue(struct a
 {
 	void __iomem *port_mmio = mv_ap_base(qc->ap);
 	struct mv_port_priv *pp = qc->ap->private_data;
+	unsigned in_index;
 	u32 in_ptr;
 
 	if (ATA_PROT_DMA != qc->tf.protocol) {
@@ -1221,23 +1223,20 @@ static unsigned int mv_qc_issue(struct a
 		return ata_qc_issue_prot(qc);
 	}
 
-	in_ptr = readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
+	in_ptr   = readl(port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
+	in_index = (in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 
-	/* the req producer index should be the same as we remember it */
-	WARN_ON(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->req_producer);
 	/* until we do queuing, the queue should be empty at this point */
-	WARN_ON(((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >>
-		  EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
+	WARN_ON(in_index != ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS)
+		>> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
-	mv_inc_q_index(&pp->req_producer);	/* now incr producer index */
+	in_index = mv_inc_q_index(in_index);	/* now incr producer index */
 
 	mv_start_dma(port_mmio, pp);
 
 	/* and write the request in pointer to kick the EDMA to life */
 	in_ptr &= EDMA_REQ_Q_BASE_LO_MASK;
-	in_ptr |= pp->req_producer << EDMA_REQ_Q_PTR_SHIFT;
+	in_ptr |= in_index << EDMA_REQ_Q_PTR_SHIFT;
 	writelfl(in_ptr, port_mmio + EDMA_REQ_Q_IN_PTR_OFS);
 
 	return 0;
@@ -1260,28 +1259,26 @@ static u8 mv_get_crpb_status(struct ata_
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp = ap->private_data;
+	unsigned out_index;
 	u32 out_ptr;
 	u8 ata_status;
 
-	out_ptr = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
+	out_ptr   = readl(port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
+	out_index = (out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK;
 
-	/* the response consumer index should be the same as we remember it */
-	WARN_ON(((out_ptr >> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->rsp_consumer);
-
-	ata_status = pp->crpb[pp->rsp_consumer].flags >> CRPB_FLAG_STATUS_SHIFT;
+	ata_status = le16_to_cpu(pp->crpb[out_index].flags)
+					>> CRPB_FLAG_STATUS_SHIFT;
 
 	/* increment our consumer index... */
-	pp->rsp_consumer = mv_inc_q_index(&pp->rsp_consumer);
+	out_index = mv_inc_q_index(out_index);
 
 	/* and, until we do NCQ, there should only be 1 CRPB waiting */
-	WARN_ON(((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS) >>
-		  EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) !=
-		pp->rsp_consumer);
+	WARN_ON(out_index != ((readl(port_mmio + EDMA_RSP_Q_IN_PTR_OFS)
+		>> EDMA_RSP_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK));
 
 	/* write out our inc'd consumer index so EDMA knows we're caught up */
 	out_ptr &= EDMA_RSP_Q_BASE_LO_MASK;
-	out_ptr |= pp->rsp_consumer << EDMA_RSP_Q_PTR_SHIFT;
+	out_ptr |= out_index << EDMA_RSP_Q_PTR_SHIFT;
 	writelfl(out_ptr, port_mmio + EDMA_RSP_Q_OUT_PTR_OFS);
 
 	/* Return ATA status register for completed CRPB */
@@ -1291,6 +1288,7 @@ static u8 mv_get_crpb_status(struct ata_
 /**
  *      mv_err_intr - Handle error interrupts on the port
  *      @ap: ATA channel to manipulate
+ *      @reset_allowed: bool: 0 == don't trigger from reset here
  *
  *      In most cases, just clear the interrupt and move on.  However,
  *      some cases require an eDMA reset, which is done right before
@@ -1301,7 +1299,7 @@ static u8 mv_get_crpb_status(struct ata_
  *      LOCKING:
  *      Inherited from caller.
  */
-static void mv_err_intr(struct ata_port *ap)
+static void mv_err_intr(struct ata_port *ap, int reset_allowed)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	u32 edma_err_cause, serr = 0;
@@ -1323,9 +1321,8 @@ static void mv_err_intr(struct ata_port 
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
 	/* check for fatal here and recover if needed */
-	if (EDMA_ERR_FATAL & edma_err_cause) {
+	if (reset_allowed && (EDMA_ERR_FATAL & edma_err_cause))
 		mv_stop_and_reset(ap);
-	}
 }
 
 /**
@@ -1374,12 +1371,12 @@ static void mv_host_intr(struct ata_host
 		struct ata_port *ap = host_set->ports[port];
 		struct mv_port_priv *pp = ap->private_data;
 
-		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
+		hard_port = mv_hardport_from_port(port); /* range 0..3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */
 
 		/* Note that DEV_IRQ might happen spuriously during EDMA,
-		 * and should be ignored in such cases.  We could mask it,
-		 * but it's pretty rare and may not be worth the overhead.
+		 * and should be ignored in such cases.
+		 * The cause of this is still under investigation.
 		 */ 
 		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
 			/* EDMA: check for response queue interrupt */
@@ -1393,6 +1390,11 @@ static void mv_host_intr(struct ata_host
 				ata_status = readb((void __iomem *)
 					   ap->ioaddr.status_addr);
 				handled = 1;
+				/* ignore spurious intr if drive still BUSY */
+				if (ata_status & ATA_BUSY) {
+					ata_status = 0;
+					handled = 0;
+				}
 			}
 		}
 
@@ -1406,7 +1408,7 @@ static void mv_host_intr(struct ata_host
 			shift++;	/* skip bit 8 in the HC Main IRQ reg */
 		}
 		if ((PORT0_ERR << shift) & relevant) {
-			mv_err_intr(ap);
+			mv_err_intr(ap, 1);
 			err_mask |= AC_ERR_OTHER;
 			handled = 1;
 		}
@@ -1448,6 +1450,7 @@ static irqreturn_t mv_interrupt(int irq,
 	struct ata_host_set *host_set = dev_instance;
 	unsigned int hc, handled = 0, n_hcs;
 	void __iomem *mmio = host_set->mmio_base;
+	struct mv_host_priv *hpriv;
 	u32 irq_stat;
 
 	irq_stat = readl(mmio + HC_MAIN_IRQ_CAUSE_OFS);
@@ -1469,6 +1472,17 @@ static irqreturn_t mv_interrupt(int irq,
 			handled++;
 		}
 	}
+
+	hpriv = host_set->private_data;
+	if (IS_60XX(hpriv)) {
+		/* deal with the interrupt coalescing bits */
+		if (irq_stat & (TRAN_LO_DONE | TRAN_HI_DONE | PORTS_0_7_COAL_DONE)) {
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE_LO);
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE_HI);
+			writelfl(0, mmio + MV_IRQ_COAL_CAUSE);
+		}
+	}
+
 	if (PCI_ERR & irq_stat) {
 		printk(KERN_ERR DRV_NAME ": PCI ERROR; PCI IRQ cause=0x%08x\n",
 		       readl(mmio + PCI_IRQ_CAUSE_OFS));
@@ -1867,7 +1881,8 @@ static void mv_channel_reset(struct mv_h
 
 	if (IS_60XX(hpriv)) {
 		u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
-		ifctl |= (1 << 12) | (1 << 7);
+		ifctl |= (1 << 7);		/* enable gen2i speed */
+		ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
 		writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
 	}
 
@@ -2031,11 +2046,14 @@ static void mv_eng_timeout(struct ata_po
 	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
 	       &qc->scsicmd->cmnd);
 
-	mv_err_intr(ap);
+	mv_err_intr(ap, 0);
 	mv_stop_and_reset(ap);
 
-	qc->err_mask |= AC_ERR_TIMEOUT;
-	ata_eh_qc_complete(qc);
+	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
+	if (qc->flags & ATA_QCFLAG_ACTIVE) {
+		qc->err_mask |= AC_ERR_TIMEOUT;
+		ata_eh_qc_complete(qc);
+	}
 }
 
 /**
@@ -2229,7 +2247,8 @@ static int mv_init_host(struct pci_dev *
 			void __iomem *port_mmio = mv_port_base(mmio, port);
 
 			u32 ifctl = readl(port_mmio + SATA_INTERFACE_CTL);
-			ifctl |= (1 << 12);
+			ifctl |= (1 << 7);		/* enable gen2i speed */
+			ifctl = (ifctl & 0xfff) | 0x9b1000; /* from chip spec */
 			writelfl(ifctl, port_mmio + SATA_INTERFACE_CTL);
 		}
 
@@ -2330,6 +2349,7 @@ static int mv_init_one(struct pci_dev *p
 	if (rc) {
 		return rc;
 	}
+	pci_set_master(pdev);
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
