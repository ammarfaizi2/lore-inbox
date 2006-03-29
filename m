Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWC2Oum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWC2Oum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 09:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWC2Oul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 09:50:41 -0500
Received: from rtr.ca ([64.26.128.89]:48870 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750742AbWC2Oul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 09:50:41 -0500
From: Mark Lord <lkml@rtr.ca>
To: IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net
Subject: [PATCH 2.6.16] sata_mv.c :: three bug fixes
Date: Wed, 29 Mar 2006 09:50:31 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603290950.32219.lkml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.6.16, and fixes three serious bugs in sata_mv.c.
The same fixes are applicable to 2.6.16-git*.

(1) A DMA transfer size of 0x10000 was not being written
as 0x0000 in the PRDs.  Fixed.

(1) The DEV_IRQ interrupt cause bit happens spuriously
during EDMA operation, and was not being ignored by the driver. 
This led to various "drive busy" errors being reported,
with associated unpredictable behaviour.  Fixed.

(2) If a SATA or PCI interrupt was received with no outstanding
command, the interrupt handler still attempted to invoke
ata_qc_complete(), triggering assert()/BUG_ON() behaviour
elsewhere in libata.  Fixed.

The driver still has issues with confusion after error-recovery,
but should now  be reliable in the absence of drive errors.
I will be looking more into the error-handling bugs next.

Signed-Off-By: Mark Lord <mlord@pobox.com>
---
--- linux-2.6.16/drivers/scsi/sata_mv.c	2006-03-21 15:33:50.000000000 -0500
+++ linux/drivers/scsi/sata_mv.c	2006-03-29 09:24:12.000000000 -0500
@@ -906,25 +906,25 @@
 
 		addr = sg_dma_address(sg);
 		sg_len = sg_dma_len(sg);
 
 		while (sg_len) {
 			offset = addr & MV_DMA_BOUNDARY;
 			len = sg_len;
 			if ((offset + sg_len) > 0x10000)
 				len = 0x10000 - offset;
 
 			pp->sg_tbl[i].addr = cpu_to_le32(addr & 0xffffffff);
 			pp->sg_tbl[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
-			pp->sg_tbl[i].flags_size = cpu_to_le32(len);
+			pp->sg_tbl[i].flags_size = cpu_to_le32(len & 0xffff);
 
 			sg_len -= len;
 			addr += len;
 
 			if (!sg_len && ata_sg_is_last(sg, qc))
 				pp->sg_tbl[i].flags_size |= cpu_to_le32(EPRD_FLAG_END_OF_TBL);
 
 			i++;
 		}
 	}
 }
 
@@ -1178,83 +1178,88 @@
  *      port error ints are reported in the higher level main
  *      interrupt status register and thus are passed in via the
  *      'relevant' argument.
  *
  *      LOCKING:
  *      Inherited from caller.
  */
 static void mv_host_intr(struct ata_host_set *host_set, u32 relevant,
 			 unsigned int hc)
 {
 	void __iomem *mmio = host_set->mmio_base;
 	void __iomem *hc_mmio = mv_hc_base(mmio, hc);
-	struct ata_port *ap;
 	struct ata_queued_cmd *qc;
 	u32 hc_irq_cause;
 	int shift, port, port0, hard_port, handled;
 	unsigned int err_mask;
 	u8 ata_status = 0;
 
 	if (hc == 0) {
 		port0 = 0;
 	} else {
 		port0 = MV_PORTS_PER_HC;
 	}
 
 	/* we'll need the HC success int register in most cases */
 	hc_irq_cause = readl(hc_mmio + HC_IRQ_CAUSE_OFS);
 	if (hc_irq_cause) {
 		writelfl(~hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
 	}
 
 	VPRINTK("ENTER, hc%u relevant=0x%08x HC IRQ cause=0x%08x\n",
 		hc,relevant,hc_irq_cause);
 
 	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
-		ap = host_set->ports[port];
+		struct ata_port *ap = host_set->ports[port];
+		struct mv_port_priv *pp = ap->private_data;
 		hard_port = port & MV_PORT_MASK;	/* range 0-3 */
 		handled = 0;	/* ensure ata_status is set if handled++ */
 
-		if ((CRPB_DMA_DONE << hard_port) & hc_irq_cause) {
-			/* new CRPB on the queue; just one at a time until NCQ
-			 */
-			ata_status = mv_get_crpb_status(ap);
-			handled++;
-		} else if ((DEV_IRQ << hard_port) & hc_irq_cause) {
-			/* received ATA IRQ; read the status reg to clear INTRQ
-			 */
-			ata_status = readb((void __iomem *)
+		/* Note that DEV_IRQ might happen spuriously during EDMA,
+		 * and should be ignored in such cases.  We could mask it,
+		 * but it's pretty rare and may not be worth the overhead.
+		 */ 
+		if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
+			/* EDMA: check for response queue interrupt */
+			if ((CRPB_DMA_DONE << hard_port) & hc_irq_cause) {
+				ata_status = mv_get_crpb_status(ap);
+				handled = 1;
+			}
+		} else {
+			/* PIO: check for device (drive) interrupt */
+			if ((DEV_IRQ << hard_port) & hc_irq_cause) {
+				ata_status = readb((void __iomem *)
 					   ap->ioaddr.status_addr);
-			handled++;
+				handled = 1;
+			}
 		}
 
-		if (ap &&
-		    (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)))
+		if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))
 			continue;
 
 		err_mask = ac_err_mask(ata_status);
 
 		shift = port << 1;		/* (port * 2) */
 		if (port >= MV_PORTS_PER_HC) {
 			shift++;	/* skip bit 8 in the HC Main IRQ reg */
 		}
 		if ((PORT0_ERR << shift) & relevant) {
 			mv_err_intr(ap);
 			err_mask |= AC_ERR_OTHER;
-			handled++;
+			handled = 1;
 		}
 
-		if (handled && ap) {
+		if (handled) {
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (NULL != qc) {
+			if (qc && (qc->flags & ATA_QCFLAG_ACTIVE)) {
 				VPRINTK("port %u IRQ found for qc, "
 					"ata_status 0x%x\n", port,ata_status);
 				/* mark qc status appropriately */
 				if (!(qc->tf.ctl & ATA_NIEN)) {
 					qc->err_mask |= err_mask;
 					ata_qc_complete(qc);
 				}
 			}
 		}
 	}
 	VPRINTK("EXIT\n");
 }
