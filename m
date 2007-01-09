Return-Path: <linux-kernel-owner+w=401wt.eu-S1751276AbXAIKTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXAIKTX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbXAIKTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:19:23 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:33367 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbXAIKTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:19:22 -0500
Message-ID: <45A36C28.6040104@garzik.org>
Date: Tue, 09 Jan 2007 05:19:20 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc4 2/2] sata_promise: ATAPI support
References: <200701090951.l099pkPl011582@harpo.it.uu.se>
In-Reply-To: <200701090951.l099pkPl011582@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> +	for(i = 0; i < 1000; ++i) {
> +		status = readb(port_mmio + 0x38); /* altstatus */

magic number (0x38)


> +		if (status == 0xFF)
> +			break;
> +		if (status & ATA_BUSY)
> +			;
> +		else if (status & (ATA_DRQ | ATA_ERR))
> +			break;
> +		mdelay(1);
> +	}
> +	if (i >= 1000)
> +		ata_port_printk(ap, KERN_WARNING, "%s timed out", __FUNCTION__);
> +	return status;
> +}
> +
> +static void pdc_issue_atapi_pkt_cmd(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	void __iomem *port_mmio = (void __iomem *) ap->ioaddr.cmd_addr;
> +	void __iomem *host_mmio = ap->host->mmio_base;
> +	unsigned int nbytes;
> +	unsigned int tmp;
> +
> +	writeb(0x00, port_mmio + PDC_CTLSTAT); /* route drive INT to SEQ 0 */
> +	writeb(PDC_SEQCNTRL_INT_MASK, host_mmio + 0); /* but mask SEQ 0 INT */
> +
> +	/* select drive */
> +	if (sata_scr_valid(ap)) {
> +		tmp = PDC_DEVICE_SATA;
> +	} else {
> +		tmp = ATA_DEVICE_OBS;
> +		if (qc->dev->devno != 0)
> +			tmp |= ATA_DEV1;
> +	}
> +	writeb(tmp, port_mmio + PDC_DEVICE);
> +	ata_busy_wait(ap, ATA_BUSY, 1000);

any reason you don't check ata_busy_wait() return value?


> +	writeb(0x00, port_mmio + PDC_SECTOR_COUNT);
> +	writeb(0x00, port_mmio + PDC_SECTOR_NUMBER);
> +
> +	/* set feature and byte counter registers */
> +	if (qc->tf.protocol != ATA_PROT_ATAPI_DMA) {
> +		tmp = PDC_FEATURE_ATAPI_PIO;
> +		/* set byte counter register to real transfer byte count */
> +		nbytes = qc->nbytes;
> +		if (!nbytes)
> +			nbytes = qc->nsect << 9;
> +		if (nbytes > 0xffff)
> +			nbytes = 0xffff;
> +	} else {
> +		tmp = PDC_FEATURE_ATAPI_DMA;
> +		/* set byte counter register to 0 */
> +		nbytes = 0;
> +	}
> +	writeb(tmp, port_mmio + PDC_FEATURE);
> +	writeb(nbytes & 0xFF, port_mmio + PDC_CYLINDER_LOW);
> +	writeb((nbytes >> 8) & 0xFF, port_mmio + PDC_CYLINDER_HIGH);
> +
> +	/* send ATAPI packet command 0xA0 */
> +	writeb(ATA_CMD_PACKET, port_mmio + PDC_COMMAND);
> +
> +	/*
> +	 * At this point in the issuing of a packet command, the Promise
> +	 * driver busy-waits for INT (CTLSTAT bit 27) if it detected
> +	 * (at port init time) that the device interrupts with assertion
> +	 * of DRQ after receiving a packet command.
> +	 *
> +	 * XXX: Do we need to handle this case as well? Does libata detect
> +	 * this case for us, or do we have to do our own per-port init?
> +	 */

grep for ata_id_cdb_intr() and ATA_DFLAG_CDB_INTR

