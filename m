Return-Path: <linux-kernel-owner+w=401wt.eu-S932637AbXAHIzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbXAHIzi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbXAHIzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:55:38 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51660 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932633AbXAHIzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:55:37 -0500
Date: Mon, 8 Jan 2007 09:55:26 +0100 (MET)
Message-Id: <200701080855.l088tQ6w001683@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jeff@garzik.org
Subject: Re: [PATCH 2.6.20-rc3] sata_promise: ATAPI support
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Jan 2007 20:50:48 -0500, Jeff Garzik wrote:
> > With this patch ATAPI will work on SATA ports on second-generation
> > chips, and on the first-generation PATA-only 20619. ATAPI on the
> > 2057x' PATA port will work automatically when #promise-sata-pata
> > is updated. ATAPI on the 2037x' PATA port is enabled by a followup
> > patch for the #promise-sata-pata branch.
> > 
> > Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
> 
> No objections, minor revision requests follow.
> 
> * general comment:  please combine the 'make first gen SATAPI work' 
> patch with this one.

Will do.

> > +static unsigned int pdc_wait_for_drq(struct ata_port *ap)
> > +{ 
> > +	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
> > +	unsigned int i;
> > +	unsigned int status;
> > +
> > +	/* Following pdc-ultra's WaitForDrq() we loop here until BSY
> > +	 * is clear and DRQ is set in altstatus. We could possibly call
> > +	 * ata_busy_wait() and loop until DRQ is set, but since we don't
> > +	 * know how much time a call to ata_busy_wait() took, we don't
> > +	 * know when to time out the outer loop.
> > +	 */
> > +	for(i = 0; i < 1000; ++i) {
> > +		status = readb(port_mmio + 0x38); /* altstatus */
> > +		if (status == 0xFF)
> > +			break;
> > +		if (status & ATA_BUSY)
> > +			;
> > +		else if (status & (ATA_DRQ | ATA_ERR))
> > +			break;
> > +		mdelay(1);
> > +	}
> 
> This really hurts to do this with spinlocks held.  Long term, ponder 
> ways to move this to a kernel thread that can sleep [if it takes too long?]

On the TODO list for a later update.

> > +static void pdc_issue_atapi_pkt_cmd(struct ata_queued_cmd *qc)
> > +{
> > +	struct ata_port *ap = qc->ap;
> > +	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
> > +	void __iomem *host_mmio = ap->host->mmio_base;
> > +	unsigned int nbytes;
> > +	unsigned int tmp;
> > +
> > +	/* disable INTA here, it will be re-enable when CAM use SEQ 0 for packets */
> 
> cut-n-pasted comment?  This is not CAM :)

Indeed :-) Will fix.

> > +	writeb(0x00, port_mmio + PDC_CTLSTAT); /* that the drive INT pass to SEQ 0*/
> > +	writeb(0x20, host_mmio + 0); /* but mask SEQ 0 INT */
> 
> please create named constants for these magic numbers

Will do (for this and the other places you pointed out).

/Mikael
