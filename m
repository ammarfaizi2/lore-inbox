Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVI1TNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVI1TNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 15:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVI1TNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 15:13:23 -0400
Received: from mail.dvmed.net ([216.237.124.58]:37349 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750731AbVI1TNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 15:13:22 -0400
Message-ID: <433AEB4F.7010502@pobox.com>
Date: Wed, 28 Sep 2005 15:13:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/3] Add disk hotswap support to libata RESEND #5
References: <355e5e5e050926180156e58f59@mail.gmail.com>
In-Reply-To: <355e5e5e050926180156e58f59@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> Hey Jeff, all,
> 
> Patch 3/3 for libata hotswapping, the reference implementation for the
> API in Patch #2 for Promise SATA150 and SATAII150 Tx4 and Tx2 Plus
> controllers.  Seems to be working on UP machines (heavy, heavy
> testing) and SMP (2 processor Athlon machine, fairly heavy testing).
> 
> Lots of comments available in patch and header, please review and
> apply if you like it!
> 
> This patch depends on patch 1 to apply, and patch 1 and 2 to compile and work.
> 
> Luke Kosewski
> 
> 
> ------------------------------------------------------------------------
> 
> 26.09.05    Luke Kosewski   <lkosewsk@nit.ca>
> 
> 	* A patch to sata_promise.c (dependent on patches 1 and 2 in this
> 	  series) which makes it use the hotswap API in patch 2.  The Promise
> 	  controllers are fairly simple in terms of their hotplug mechanism,
> 	  so none of the funky 'janitor' functions are used here.
> 	  ata_hotplug_plug is called on a plug event, and ata_hotplug_unplug on
> 	  an unplug.  Simple, simple.
> 	* Pending some confirmation and suggestions from Jim Ramsay
> 	  (jim.ramsay@gmail.com) the interrupt handler might change to check for
> 	  DMA commands completing as WELL as hotplug events in the same pass.
> 
> diff -rpuN linux-2.6.14-rc1/drivers/scsi/sata_promise.c linux-2.6.14-rc1-new/drivers/scsi/sata_promise.c
> --- linux-2.6.14-rc1/drivers/scsi/sata_promise.c	2005-09-14 19:57:54.000000000 -0400
> +++ linux-2.6.14-rc1-new/drivers/scsi/sata_promise.c	2005-09-14 20:16:09.000000000 -0400
> @@ -332,10 +332,43 @@ static void pdc_reset_port(struct ata_po
>  	readl(mmio);	/* flush */
>  }
>  
> +/* Mask hotplug interrupts for one channel (ap) */
> +static inline void pdc_disable_channel_hotplug_interrupts(struct ata_port *ap)
> +{
> +	struct pdc_host_priv *hp = ap->host_set->private_data;
> +	void *mmio = ap->host_set->mmio_base + hp->hotplug_offset + 2;
> +
> +	u8 maskflags = readb(mmio);
> +	maskflags |= (0x11 << (u8)ap->hard_port_no);
> +	writeb(maskflags, mmio);
> +}
> +
> +/* Clear and unmask hotplug interrupts for one channel (ap) */
> +static inline void pdc_enable_channel_hotplug_interrupts(struct ata_port *ap)
> +{
> +	struct pdc_host_priv *hp = ap->host_set->private_data;
> +	void *mmio = ap->host_set->mmio_base + hp->hotplug_offset;
> +
> +	//Clear channel hotplug interrupts
> +	u8 maskflags = readb(mmio);
> +	maskflags |= (0x11 << (u8)ap->hard_port_no);
> +	writeb(maskflags, mmio);
> +
> +	//Unmask channel hotplug interrupts
> +	maskflags = readb(mmio + 2);
> +	maskflags &= ~(0x11 << (u8)ap->hard_port_no);
> +	writeb(maskflags, mmio + 2);
> +}

Rather than two functions, I prefer one function that takes an 'enable' 
boolean argument, just like pci_intx()

Also, the function names are way too long.


>  static void pdc_sata_phy_reset(struct ata_port *ap)
>  {
>  	pdc_reset_port(ap);
> -	sata_phy_reset(ap);
> +	if (ap->flags & ATA_FLAG_SATA_RESET) {
> +		pdc_disable_channel_hotplug_interrupts(ap);
> +		sata_phy_reset(ap);
> +		pdc_enable_channel_hotplug_interrupts(ap);
> +	} else
> +		sata_phy_reset(ap);

I don't see the point of this.  Might as well unconditionally disable 
hotplug interrupts.


>  }
>  
>  static void pdc_pata_phy_reset(struct ata_port *ap)
> @@ -485,11 +518,13 @@ static void pdc_irq_clear(struct ata_por
>  static irqreturn_t pdc_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
>  {
>  	struct ata_host_set *host_set = dev_instance;
> +	struct pdc_host_priv *hp = host_set->private_data;
>  	struct ata_port *ap;
>  	u32 mask = 0;
>  	unsigned int i, tmp;
> -	unsigned int handled = 0;
> +	unsigned int handled = 0, hotplug_offset = hp->hotplug_offset;
>  	void __iomem *mmio_base;
> +	u8 plugdata, maskflags;
>  
>  	VPRINTK("ENTER\n");
>  
> @@ -513,7 +548,7 @@ static irqreturn_t pdc_interrupt (int ir
>  	mask &= 0xffff;		/* only 16 tags possible */
>  	if (!mask) {
>  		VPRINTK("QUICK EXIT 3\n");
> -		goto done_irq;
> +		goto try_hotplug;
>  	}
>  
>  	writel(mask, mmio_base + PDC_INT_SEQMASK);
> @@ -532,7 +567,36 @@ static irqreturn_t pdc_interrupt (int ir
>  		}
>  	}
>  
> -	VPRINTK("EXIT\n");
> +	if (handled) {
> +		VPRINTK("EXIT 4\n");
> +		goto done_irq;
> +	}
> +
> +try_hotplug:
> +	plugdata = readb(mmio_base + hotplug_offset);
> +	maskflags = readb(mmio_base + hotplug_offset + 2);
> +	plugdata &= ~maskflags;
> +	if (plugdata) {
> +		writeb(plugdata, mmio_base + hotplug_offset);
> +		for (i = 0; i < host_set->n_ports; ++i) {
> +			ap = host_set->ports[i];
> +			if (!(ap->flags & ATA_FLAG_SATA))
> +				continue;  //No PATA support here... yet
> +			// Check unplug flag
> +			if (plugdata & 0x1) {
> +				/* Do stuff related to unplugging a device */
> +				ata_hotplug_unplug(ap);
> +				handled = 1;
> +			} else if ((plugdata >> 4) & 0x1) {  //Check plug flag
> +				/* Do stuff related to plugging in a device */
> +				ata_hotplug_plug(ap);
> +				handled = 1;

What happens if both bits are set?  Seems like that could happen, if a 
plug+unplug (cable blip?) occurs in rapid succession.

The rest seems OK to me.

	Jeff


