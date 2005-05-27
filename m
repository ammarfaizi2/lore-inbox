Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVE0HhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVE0HhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbVE0Hbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:31:52 -0400
Received: from brick.kernel.dk ([62.242.22.158]:52183 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261939AbVE0H3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:29:20 -0400
Date: Fri, 27 May 2005 09:30:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050527073016.GO1435@suse.de>
References: <20050527070353.GL1435@suse.de> <4296CAA8.9060307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296CAA8.9060307@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Update the patch, it's against bleeding edge git (applies to 2.6.12-rc5
> >as well). Changes:
> 
> I'll throw this into libata-dev branch "ncq" right now.

Ok cool.

> >+static void ahci_host_ncq_intr_err(struct ata_port *ap)
> >+{
> >+	void *mmio = ap->host_set->mmio_base;
> >+	void *port_mmio = ahci_port_base(mmio, ap->port_no);
> >+	char *buffer;
> >+
> >+	printk(KERN_ERR "ata%u: ncq interrupt error\n", ap->id);
> >+
> >+	ahci_intr_error(ap, readl(port_mmio + PORT_IRQ_STAT));
> >+
> >+	buffer = kmalloc(512, GFP_KERNEL);
> 
> cannot use GFP_KERNEL in interrupt context

Duh of course, I moved this call from eh_strategy callback to interrupt
as well and forgot to change the allocation mask. I'll fix that up when
fixing the error handling.

> >@@ -2868,6 +2995,21 @@
> > int ata_qc_issue(struct ata_queued_cmd *qc)
> > {
> > 	struct ata_port *ap = qc->ap;
> >+	int rc = ATA_QC_ISSUE_FATAL;
> >+
> >+	/*
> >+	 * see if we can queue one more command at this point in time, see
> >+	 * comment at ata_qc_issue_ok(). NCQ commands typically originate 
> >from
> >+	 * the SCSI layer, we can ask the mid layer to defer those commands
> >+	 * similar to a QUEUE_FULL condition on a 'real' SCSI device
> >+	 */
> >+	if (!ata_qc_issue_ok(ap, qc, 0)) {
> >+		if (qc->flags & ATA_QCFLAG_DEFER)
> >+			return ATA_QC_ISSUE_DEFER;
> >+
> >+		ata_qc_issue_wait(ap, qc);
> >+		assert(ata_qc_issue_ok(ap, qc, 0));
> >+	}
> > 
> 
> This is too late.  We shouldn't get to this point and find out, "uh oh, 
> queue full."
> 
> ata_qc_new() should fail to obtain a qc if the queue is full, at which 
> point you may directly return queue-full.
> 
> If ata_qc_new() succeeds, but wish to wait for the queue to drain, add 
> that logic -much- earlier than the ata_qc_issue() call.  I would rather 
> have that logic at a higher level.

That is the typical case, ata_qc_new() succeeds but we cannot issue the
command yet. So where do you want this logic placed? You cannot drop the
host_lock in-between, as that could potentially change the situation.

> >+int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
> >+{
> >+	struct ata_port *ap;
> >+	struct ata_device *dev;
> >+	int max_depth;
> >+
> >+	if (sdev->id >= ATA_MAX_DEVICES)
> >+		return sdev->queue_depth;
> >+
> >+	ap = (struct ata_port *) &sdev->host->hostdata[0];
> >+	dev = &ap->device[sdev->id];
> >+
> >+	max_depth = min(sdev->host->can_queue, ata_id_queue_depth(dev->id));
> >+	if (queue_depth > max_depth)
> >+		queue_depth = max_depth;
> >+
> >+	scsi_adjust_queue_depth(sdev, MSG_SIMPLE_TAG, queue_depth);
> >+	return queue_depth;
> >+}
> 
> Please add this function immediately above, or below, 
> ata_scsi_slave_config().  That will make backporting to 2.4.x easier.

No problem, done.

> >===================================================================
> >--- 3ac9a34948049bff79a2b2ce49c0a3c84e35a748/include/linux/ata.h  
> >(mode:100644)
> >+++ uncommitted/include/linux/ata.h  (mode:100644)
> >@@ -79,7 +79,8 @@
> > 	ATA_NIEN		= (1 << 1),	/* disable-irq flag */
> > 	ATA_LBA			= (1 << 6),	/* LBA28 selector */
> > 	ATA_DEV1		= (1 << 4),	/* Select Device 1 (slave) */
> >-	ATA_DEVICE_OBS		= (1 << 7) | (1 << 5), /* obs bits in dev 
> >reg */
> >+	ATA_DEVICE_OBS		= (1 << 5), 	/* obs bits in dev reg */
> >+	ATA_FPDMA_FUA		= (1 << 7),	/* FUA cache bypass bit */
> > 	ATA_DEVCTL_OBS		= (1 << 3),	/* obsolete bit in devctl 
> > 	reg */
> > 	ATA_BUSY		= (1 << 7),	/* BSY status bit */
> > 	ATA_DRDY		= (1 << 6),	/* device ready */
> 
> Don't do this.  You can add ATA_FPDMA_FUA, but don't arbitrarily change 
> ATA_DEVICE_OBS.
> 
> This is something that may have to be done on a per-device basis.

Agree, I'll just remove it as FUA isn't used yet anyways.

-- 
Jens Axboe

