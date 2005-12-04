Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVLDQbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVLDQbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVLDQbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:31:48 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:20584 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932261AbVLDQbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:31:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nrtTNulx+/39z3/uf6Jm2leC2sF47kL5noO4YOm3C3zsIjk3R9eHqofdiUzvDYdaXlocRogo9IzpvrzjXTUvOFU5Zjdos1pz5Hpu8whpFguDfzfz5i14c7y3eKciJvlCwLk/XeplNXyq13GNOOXZo2JXXjE1mxE3DJBOnEHK9b0=
Message-ID: <439319ED.8050303@gmail.com>
Date: Mon, 05 Dec 2005 01:31:41 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ethan Chen <thanatoz@ucla.edu>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] sata_sil: improved interrupt handling
References: <20051203054127.GA11208@havoc.gtf.org>
In-Reply-To: <20051203054127.GA11208@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff.

Jeff Garzik wrote:
> Just committed the following to the 'sii-irq' branch of libata-dev.git,
> and verified it on an Adaptec 1210SA (3112).
> 
> Haven't decided whether I will push it upstream or not, but I think I
> will.  It does a bit better job of handling handling errors, and should
> be more efficient (less CPU usage) than the standard ATA interrupt
> handler as well.
> 
> For users seeing sata_sil problems, this may make them happy.
> 

This patch doesn't make any difference on my sil3114 controller.  I'll 
write about it in the m15w thread.

Also, this patch doesn't implement proper handling of PIO protocols and 
thus breaks ALL branch.

It seems to me that the changes made by the new interrupt handler is not 
very sil3112 specific.  Is there any reason this change is sil3112 specific?

> 
> commit b6abf7755a79383f0e5f108d23a0394f156c54c1
> Author: Jeff Garzik <jgarzik@pobox.com>
> Date:   Sat Dec 3 00:30:57 2005 -0500
> 
>     [libata sata_sil] improved interrupt handling
> 
>  drivers/scsi/sata_sil.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
> index 3609186..37398a5 100644
> --- a/drivers/scsi/sata_sil.c
> +++ b/drivers/scsi/sata_sil.c
> @@ -85,6 +85,7 @@ static void sil_dev_config(struct ata_po
>  static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
>  static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
>  static void sil_post_set_mode (struct ata_port *ap);
> +static irqreturn_t sil_irq (int irq, void *dev_instance, struct pt_regs *regs);
>  
>  
>  static const struct pci_device_id sil_pci_tbl[] = {
> @@ -167,7 +168,7 @@ static const struct ata_port_operations 
>  	.qc_prep		= ata_qc_prep,
>  	.qc_issue		= ata_qc_issue_prot,
>  	.eng_timeout		= ata_eng_timeout,
> -	.irq_handler		= ata_interrupt,
> +	.irq_handler		= sil_irq,
>  	.irq_clear		= ata_bmdma_irq_clear,
>  	.scr_read		= sil_scr_read,
>  	.scr_write		= sil_scr_write,
> @@ -233,6 +234,121 @@ MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
>  MODULE_VERSION(DRV_VERSION);
>  
>  
> +static inline void sil_port_irq(struct ata_port *ap, void __iomem *mmio,
> +				u8 dma_stat, u8 dma_stat_mask)
> +{
> +	struct ata_queued_cmd *qc = NULL;
> +	unsigned int err_mask = AC_ERR_OTHER;
> +	int complete = 1;
> +	u8 dev_stat;
> +
> +	/* Exit now, if port or port's irqs are disabled */
> +	if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)) {
> +		complete = 0;
> +		goto out;
> +	}

Hmmm... By performing this test here, we end up reading bmdma status 
registers of all ports everytime an interrupt occurs.  Is this to 
prevent screaming IRQ problem?

> +
> +	/* Get active command */
> +	qc = ata_qc_from_tag(ap, ap->active_tag);
> +	if ((!qc) || (qc->tf.ctl & ATA_NIEN)) {
> +		complete = 0;
> +		goto out;
> +	}
> +
> +	/* Stop DMA, if doing DMA */
> +	switch (qc->tf.protocol) {
> +	case ATA_PROT_DMA:
> +	case ATA_PROT_ATAPI_DMA:
> +		ata_bmdma_stop(qc);
> +		break;
> +
> +	default:
> +		/* do nothing */
> +		break;
> +	}
> +
> +	/* Catch PCI bus errors */
> +	if (unlikely(dma_stat_mask & ATA_DMA_ERR)) {
> +		struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
> +		u16 pci_stat;
> +
> +		pci_read_config_word(pdev, PCI_STATUS, &pci_stat);
> +		pci_write_config_word(pdev, PCI_STATUS, pci_stat);
> +
> +		err_mask = AC_ERR_HOST_BUS;
> +
> +		printk(KERN_ERR "ata%u: PCI error, pci %x, dma %x\n",
> +			ap->id, pci_stat, dma_stat);
> +		goto out;
> +	}
> +
> +	/* Read device Status, clear device interrupt */
> +	dev_stat = ata_check_status(ap);
> +
> +	/* Let timeout handler handle stuck BSY */
> +	if (unlikely(dev_stat & ATA_BUSY)) {
> +		complete = 0;
> +		goto out;
> +	}
> +
> +	/* Did S/G table specify a size smaller than the transfer size?  */
> +	if (unlikely(dma_stat_mask == 0)) {
> +		printk(KERN_ERR "ata%u: BUG: SG size underflow\n", ap->id);
> +		err_mask = AC_ERR_OTHER; /* only occurs due to coder error? */
> +		goto out;
> +	}
> +
> +	/* Clear 311x DMA completion indicator */
> +	writeb(ATA_DMA_INTR, mmio + ATA_DMA_STATUS);
> +
> +	/* Finally, complete the ATA command transaction */
> +	ata_qc_complete(qc, ac_err_mask(dev_stat));
> +	return;
> +
> +out:
> +	ata_chk_status(ap);
> +	writeb(dma_stat_mask, mmio + ATA_DMA_STATUS);
> +	if (complete)
> +		ata_qc_complete(qc, err_mask);
> +}
> +
> +static irqreturn_t sil_irq (int irq, void *dev_instance, struct pt_regs *regs)
> +{
> +	struct ata_host_set *host_set = dev_instance;
> +	unsigned int i, handled = 0;
> +
> +	spin_lock(&host_set->lock);
> +
> +	for (i = 0; i < host_set->n_ports; i++) {
> +		struct ata_port *ap;
> +		void __iomem *mmio;
> +		u8 status, mask;
> +		u32 serr;
> +
> +		ap = host_set->ports[i];
> +		if (!ap)
> +			continue;
> +
> +		mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
> +		status = readb(mmio + ATA_DMA_STATUS);
> +		mask = status & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE);
> +		if (mask == ATA_DMA_ACTIVE)
> +			continue;
> +
> +		handled = 1;
> +
> +		sil_port_irq(ap, mmio, status, mask);
> +
> +		serr = sil_scr_read(ap, SCR_ERROR);
> +		if (serr)
> +			sil_scr_write(ap, SCR_ERROR, serr);
> +	}
> +
> +	spin_unlock(&host_set->lock);
> +
> +	return IRQ_RETVAL(handled);
> +}
> +
>  static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
>  {
>  	u8 cache_line = 0;
> 


-- 
tejun
