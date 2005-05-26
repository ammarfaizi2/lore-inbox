Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVEZRMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVEZRMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVEZRLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:11:36 -0400
Received: from brick.kernel.dk ([62.242.22.158]:8337 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261633AbVEZRGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:06:05 -0400
Date: Thu, 26 May 2005 19:07:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050526170658.GT1419@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4295F87B.9070106@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26 2005, Jeff Garzik wrote:
> > static void ahci_qc_prep(struct ata_queued_cmd *qc)
> > {
> > 	struct ahci_port_priv *pp = qc->ap->private_data;
> >-	u32 opts;
> >+	void *port_mmio = (void *) qc->ap->ioaddr.cmd_addr;
> > 	const u32 cmd_fis_len = 5; /* five dwords */
> >+	dma_addr_t cmd_tbl_dma;
> >+	u32 opts;
> >+	int offset;
> >+
> >+	if (qc->flags & ATA_QCFLAG_NCQ) {
> >+		pp->sactive |= (1 << qc->tag);
> >+
> >+		writel(1 << qc->tag, port_mmio + PORT_SCR_ACT);
> >+		readl(port_mmio + PORT_SCR_ACT);	/* flush */
> >+	}
> 
> Wrong, you should do this in ahci_qc_issue not here.

Are you sure, I moved this on purpose? I think the reason I did this was
the wording at the back of the the sata-ii spec (appendix b) that says
something ala 'preset the active bit and transmit a register FIS'. Feel
free to point me at the authoritative wording in the ACHI spec.

One thing that I definitely think _was_ wrong with the sactive bit
before, is that you set it unconditionally of whether this was an NCQ
command or not. The maxtor drives don't clear sactive on non-fpdma
commands, which confused me at first.

> >+static void ahci_host_ncq_intr_err(struct ata_port *ap)
> >+{
> >+	struct ahci_port_priv *pp = ap->private_data;
> >+	void *mmio = ap->host_set->mmio_base;
> >+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
> >+	unsigned long flags;
> >+	char *buffer;
> >+
> >+	printk(KERN_ERR "ata%u: ncq interrupt error\n", ap->id);
> >+
> >+	/*
> >+	 * error all io first
> >+	 */
> >+	spin_lock_irqsave(&ap->host_set->lock, flags);
> >+
> >+	while (pp->sactive) {
> >+		struct ata_queued_cmd *qc;
> >+		int tag = ffs(pp->sactive) - 1;
> >+
> >+		pp->sactive &= ~(1 << tag);
> >+		qc = ata_qc_from_tag(ap, tag);
> >+		if (qc)
> >+			ata_qc_complete(qc, ATA_ERR);
> 
> else printk error "I couldn't find the tag!"

Agree.

> >@@ -632,18 +767,27 @@
> > 	status = readl(port_mmio + PORT_IRQ_STAT);
> > 	writel(status, port_mmio + PORT_IRQ_STAT);
> > 
> >-	ci = readl(port_mmio + PORT_CMD_ISSUE);
> >-	if (likely((ci & 0x1) == 0)) {
> >-		if (qc) {
> >-			ata_qc_complete(qc, 0);
> >-			qc = NULL;
> >+	if (ap->ncq_depth) {
> >+		if (!serr)
> 
> incorrect test.  serr is not the only error indicator.

Yes, I'm aware of that. There are still quite a few loose ends wrt error
handling, as mentioned. I also don't check the irq fatal stat in the ncq
interrupt handler.

> >@@ -1139,6 +1143,10 @@
> > 			goto err_out_nosup;
> > 		}
> > 
> >+		if (ap->flags & ATA_FLAG_NCQ)
> >+			if (ata_id_queue_depth(dev->id) > 1)
> >+				dev->flags |= ATA_DFLAG_NCQ;
> 
> This will turn on queueing for older TCQ devices that are plugged into 
> an NCQ-capable board.

Yup, that is an error. At that time, I could not easily find what
feature bit encompassed NCQ, that needs to be added of course.

> >+int ata_read_log_page(struct ata_port *ap, unsigned int device, char page,
> >+		      char *buffer, unsigned int sectors)
> >+{
> >+	struct ata_device *dev = &ap->device[device];
> >+	DECLARE_COMPLETION(wait);
> >+	struct ata_queued_cmd *qc;
> >+	unsigned long flags;
> >+	u8 status;
> >+	int rc;
> >+
> >+	assert(dev->class == ATA_DEV_ATA);
> >+
> >+	ata_dev_select(ap, device, 1, 1);
> 
> is this needed?  These types of calls need to be removed, in general, as 
> they don't make sense on FIS-based hardware at all.

You tell me, this read_log_page() was mainly copy-pasted from the pio
driven function above it. I'll try and kill the select when doing error
testing.

> >+	printk("RLP issue\n");
> >+	spin_lock_irqsave(&ap->host_set->lock, flags);
> >+	rc = ata_qc_issue(qc);
> >+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
> >+	printk("RLP issue done\n");
> >+
> >+	if (rc)
> >+		return -EIO;
> >+
> >+	wait_for_completion(&wait);
> >+
> >+	printk("RLP wait done\n");
> >+
> >+	status = ata_chk_status(ap);
> >+	if (status & (ATA_ERR | ATA_ABORTED))
> >+		return -EIO;
> 
> we need to get rid of this too for AHCI-like devices

Can you expand on that?

> >@@ -2753,6 +2830,16 @@
> > 	struct ata_port *ap = qc->ap;
> > 	unsigned int tag, do_clear = 0;
> > 
> >+	if (likely(qc->flags & ATA_QCFLAG_ACCOUNT)) {
> >+		if (qc->flags & ATA_QCFLAG_NCQ) {
> >+			assert(ap->ncq_depth);
> >+			ap->ncq_depth--;
> >+		} else {
> >+			assert(ap->depth);
> >+			ap->depth--;
> >+		}
> >+	}
> 
> why is this accounting conditional?

Because if you free a qc before it has gone to the device, you don't
want to account it. Hmm, perhaps ACTIVE would work fine in fact. I'll
double check!

> > #ifdef CONFIG_PCI
> > EXPORT_SYMBOL_GPL(pci_test_config_bits);
> >Index: drivers/scsi/libata-scsi.c
> >===================================================================
> >--- f5c58b6b0cfd2a92fb3b1d1f4cbfdfb3df6f45d6/drivers/scsi/libata-scsi.c  
> >(mode:100644)
> >+++ uncommitted/drivers/scsi/libata-scsi.c  (mode:100644)
> >@@ -336,6 +336,7 @@
> > 	if (sdev->id < ATA_MAX_DEVICES) {
> > 		struct ata_port *ap;
> > 		struct ata_device *dev;
> >+		int depth;
> > 
> > 		ap = (struct ata_port *) &sdev->host->hostdata[0];
> > 		dev = &ap->device[sdev->id];
> >@@ -353,6 +354,13 @@
> > 			 */
> > 			blk_queue_max_sectors(sdev->request_queue, 2048);
> > 		}
> >+
> >+		if (dev->flags & ATA_DFLAG_NCQ) {
> >+			int ddepth = ata_id_queue_depth(dev->id) + 1;
> >+
> >+			depth = min(sdev->host->can_queue, ddepth);
> >+			scsi_adjust_queue_depth(sdev, MSG_ORDERED_TAG, 
> >depth);
> 
> For all hardware that uses SActive (all NCQ), the max is 31 not 32.

That's not true, the max is 32 counting 0 as a valid tag. So 31 is
indeed th max tag value, but 32 is the depth.

> 32 tags == 0xffffffff SActive, which is the same value as that which 
> occurs when the hardware is dead/unplugged/etc.

Well you would think you would notice the hardware going dead by other
means than just SActive, right? Seems silly to cap the depth because of
that.

> Also...  NCQ does not provide ordered tags.  I think MSG_SIMPLE_TAG is 
> more appropriate.

Yep indeed, thanks.

> >+	if (ncq)
> >+		qc->flags |= ATA_QCFLAG_NCQ;
> >+
> > 	if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
> >-		if (lba48) {
> >+		if (ncq) {
> >+			tf->hob_feature = scsicmd[7];
> >+			tf->feature = scsicmd[8];
> >+			tf->nsect = qc->tag << 3;
> >+			tf->hob_lbal = scsicmd[2];
> >+			qc->nsect = ((unsigned int)scsicmd[7] << 8) |
> >+					scsicmd[8];
> >+		} else if (lba48) {
> > 			tf->hob_nsect = scsicmd[7];
> > 			tf->hob_lbal = scsicmd[2];
> > 
> >@@ -569,7 +588,8 @@
> > 			qc->nsect = scsicmd[8];
> > 		}
> > 
> >-		tf->nsect = scsicmd[8];
> >+		if (!ncq)
> >+			tf->nsect = scsicmd[8];
> 
> the other changes seem fine, but this seem strange

How so? FPDMA has the tag in nsect, others store the bottom 8 bits of
lba.

> >@@ -308,6 +317,11 @@
> > 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
> > 	unsigned long		qactive;
> > 	unsigned int		active_tag;
> >+	int			ncq_depth;
> >+	int			depth;
> 
> I don't think we need two depths

The two depths were added because we need to differentiate between the
two for issuing new commands. ncq_depth > 0 is fine for issuing a new
FPDMA request, where as non-FPDMA commands need both !ncq_depth and
!depth.

Thanks for your comments!

-- 
Jens Axboe

