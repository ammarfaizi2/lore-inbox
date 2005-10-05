Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVJEVJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVJEVJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVJEVJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:09:18 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:43330 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S965009AbVJEVJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:09:17 -0400
From: Brett Russ <russb@emc.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Pasi Pirhonen <upi@papat.org>,
       Michael Madore <Michael.Madore@aslab.com>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>,
       scott olson <scotto701@yahoo.com>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>,
       Evgeny Rodichev <er@sai.msu.su>
Subject: [PATCH 2.6.14-rc2 1/2] libata: Marvell spinlock fixes and simplification
References: <20051005210610.EC31826369@lns1058.lss.emc.com>
In-Reply-To: <20051005210610.EC31826369@lns1058.lss.emc.com>
Message-Id: <20051005210842.F366B26369@lns1058.lss.emc.com>
Date: Wed,  5 Oct 2005 17:08:42 -0400 (EDT)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.10.5.25
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should fix up lockups that people were seeing due to
improper spinlock placement.  Also, the start/stop DMA routines put
guarded trust in the cached state of DMA.

Thanks,
BR

Signed-off-by: Brett Russ <russb@emc.com>


Index: linux-2.6.14-rc2/drivers/scsi/sata_mv.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/scsi/sata_mv.c
+++ linux-2.6.14-rc2/drivers/scsi/sata_mv.c
@@ -35,7 +35,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
-#define DRV_VERSION	"0.22"
+#define DRV_VERSION	"0.23"
 
 enum {
 	/* BAR's are enumerated in terms of pci_resource_start() terms */
@@ -406,40 +406,30 @@ static void mv_irq_clear(struct ata_port
 {
 }
 
-static void mv_start_dma(void __iomem *base, struct mv_port_priv *pp,
-			 struct ata_port *ap)
+static void mv_start_dma(void __iomem *base, struct mv_port_priv *pp)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	
-	writelfl(EDMA_EN, base + EDMA_CMD_OFS);
-	pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
-
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	if (!(MV_PP_FLAG_EDMA_EN & pp->pp_flags)) {
+		writelfl(EDMA_EN, base + EDMA_CMD_OFS);
+		pp->pp_flags |= MV_PP_FLAG_EDMA_EN;
+	}
+	assert(EDMA_EN & readl(base + EDMA_CMD_OFS));
 }
 
 static void mv_stop_dma(struct ata_port *ap)
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	struct mv_port_priv *pp	= ap->private_data;
-	unsigned long flags;
 	u32 reg;
 	int i;
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	
-	if (!(MV_PP_FLAG_EDMA_DS_ACT & pp->pp_flags) &&
-	    ((MV_PP_FLAG_EDMA_EN & pp->pp_flags) ||
-	     (EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)))) {
-		/* Disable EDMA if we're not already trying to disable it
-		 * and it is currently active.   The disable bit auto clears.
+	if (MV_PP_FLAG_EDMA_EN & pp->pp_flags) {
+		/* Disable EDMA if active.   The disable bit auto clears.
 		 */
-		pp->pp_flags |= MV_PP_FLAG_EDMA_DS_ACT;
 		writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
 		pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
-	}
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	} else {
+		assert(!(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS)));
+  	}
 	
 	/* now properly wait for the eDMA to stop */
 	for (i = 1000; i > 0; i--) {
@@ -450,12 +440,9 @@ static void mv_stop_dma(struct ata_port 
 		udelay(100);
 	}
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	pp->pp_flags &= ~MV_PP_FLAG_EDMA_DS_ACT;
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
 	if (EDMA_EN & reg) {
 		printk(KERN_ERR "ata%u: Unable to stop eDMA\n", ap->id);
+		/* FIXME: Consider doing a reset here to recover */
 	}
 }
 
@@ -716,8 +703,11 @@ static void mv_port_stop(struct ata_port
 {
 	struct device *dev = ap->host_set->dev;
 	struct mv_port_priv *pp = ap->private_data;
+	unsigned long flags;
 
+	spin_lock_irqsave(&ap->host_set->lock, flags);
 	mv_stop_dma(ap);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	ap->private_data = NULL;
 	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
@@ -867,11 +857,7 @@ static int mv_qc_issue(struct ata_queued
 
 	mv_inc_q_index(&pp->req_producer);	/* now incr producer index */
 
-	if (!(MV_PP_FLAG_EDMA_EN & pp->pp_flags)) {
-		/* turn on EDMA if not already on */
-		mv_start_dma(port_mmio, pp, qc->ap);
-	}
-	assert(EDMA_EN & readl(port_mmio + EDMA_CMD_OFS));
+	mv_start_dma(port_mmio, pp);
 
 	/* and write the request in pointer to kick the EDMA to life */
 	in_ptr &= EDMA_REQ_Q_BASE_LO_MASK;
@@ -921,8 +907,12 @@ static void mv_err_intr(struct ata_port 
 		serr = scr_read(ap, SCR_ERROR);
 		scr_write_flush(ap, SCR_ERROR, serr);
 	}
-	DPRINTK("port %u error; EDMA err cause: 0x%08x SERR: 0x%08x\n", 
-		ap->port_no, edma_err_cause, serr);
+	if (EDMA_ERR_SELF_DIS & edma_err_cause) {
+		struct mv_port_priv *pp	= ap->private_data;
+		pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
+	}
+	DPRINTK(KERN_ERR "ata%u: port error; EDMA err cause: 0x%08x "
+		"SERR: 0x%08x\n", ap->id, edma_err_cause, serr);
 
 	/* Clear EDMA now that SERR cleanup done */
 	writelfl(0, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
@@ -1034,7 +1024,7 @@ static irqreturn_t mv_interrupt(int irq,
 		printk(KERN_ERR DRV_NAME ": PCI ERROR; PCI IRQ cause=0x%08x\n",
 		       readl(mmio + PCI_IRQ_CAUSE_OFS));
 
-		VPRINTK("All regs @ PCI error\n");
+		DPRINTK("All regs @ PCI error\n");
 		mv_dump_all_regs(mmio, -1, to_pci_dev(host_set->dev));
 
 		writelfl(0, mmio + PCI_IRQ_CAUSE_OFS);
