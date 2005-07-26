Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVGZR0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVGZR0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGZR0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:26:02 -0400
Received: from mail.dvmed.net ([216.237.124.58]:43450 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261804AbVGZRZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:25:06 -0400
Message-ID: <42E671EE.7000309@pobox.com>
Date: Tue, 26 Jul 2005 13:25:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@gmail.com>
CC: linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3 RESEND] Add disk hotswap support to libata
References: <355e5e5e050722111141c0bf14@mail.gmail.com>
In-Reply-To: <355e5e5e050722111141c0bf14@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> Hey Jeff, everyone.
> 
> This is a resend of patch 3 of my libata hotswap series, wherein I
> found a silly flaw in my logic.  I don't know what kind of crack I was
> smoking, but I somehow turned "a = a & ~b" in the Promise driver into
> "a = a ^ b" in my hotswap code, which is clearly wrong.  I don't know
> how it worked through my testing, but I'm willing to bet this is a
> coincidence.  Please apply this patch instead of the previously sent
> patch 03.
> 
> Luke Kosewski
> Human Cannonball
> Net Integration Technologies
> 
> 
> ------------------------------------------------------------------------
> 
> 21.07.05  Luke Kosewski  <lkosewsk@nit.ca>
> 
> 	* A full implementation of hotplug on a libata controller, this being
> 	  the Promise Tx4/Tx2 Plus controller line (both SATA150 and SATAII150).
> 	  Almost all of the code pertaining to how to talk to the hotplug
> 	  registers has been stolen from the pdc-ulsata2 and ultra-1.0.8 Promise
> 	  drivers.  This involves detecting when we have an interrupt pending
> 	  and on what device, as well as the bit where a hard SATA reset gets
> 	  a SATAII150 controller to re-spew a plug interrupt.
> 	* Note that the hotplug handling code comes AFTER the normal interrupt
> 	  handling code in pdc_interrupt_common; this is because we're much
> 	  more likely to receive normal interrupts, so this drops the AVERAGE
> 	  interrupt handling time down a lot.
> 
> Signed-off-by:  Luke Kosewski <lkosewsk@nit.ca>
> 
> --- linux-2.6.13-rc3/drivers/scsi/sata_promise.c.old	2005-07-21 13:52:13.037895639 -0400
> +++ linux-2.6.13-rc3/drivers/scsi/sata_promise.c	2005-07-21 13:55:53.490964645 -0400
> @@ -84,6 +84,7 @@ static void pdc_eng_timeout(struct ata_p
>  static int pdc_port_start(struct ata_port *ap);
>  static void pdc_port_stop(struct ata_port *ap);
>  static void pdc_phy_reset(struct ata_port *ap);
> +static void pdc2_phy_reset(struct ata_port *ap);
>  static void pdc_pata_phy_reset(struct ata_port *ap);
>  static void pdc_pata_cbl_detect(struct ata_port *ap);
>  static void pdc_qc_prep(struct ata_queued_cmd *qc);
> @@ -139,7 +140,7 @@ static struct ata_port_operations pdc2_a
>  	.check_status		= ata_check_status,
>  	.exec_command		= pdc_exec_command_mmio,
>  	.dev_select		= ata_std_dev_select,
> -	.phy_reset		= pdc_phy_reset,
> +	.phy_reset		= pdc2_phy_reset,
>  	.qc_prep		= pdc_qc_prep,
>  	.qc_issue		= pdc_qc_issue_prot,
>  	.eng_timeout		= pdc_eng_timeout,
> @@ -325,6 +326,48 @@ static void pdc_phy_reset(struct ata_por
>  		pdc_pata_phy_reset(ap);
>  }
>  
> +/* Mask hotplug interrupts for one channel (ap) */
> +static inline void pdc2_disable_channel_hotplug_interrupts(struct ata_port *ap)
> +{
> +	void *mmio = ap->host_set->mmio_base + PDC2_SATA_PLUG_CSR + 2;
> +
> +	u8 maskflags = readb(mmio);
> +	maskflags |= (0x11 << (u8)ap->hard_port_no);
> +	writeb(maskflags, mmio);
> +}
> +
> +static inline void pdc2_enable_channel_hotplug_interrupts(struct ata_port *ap)
> +{
> +
> +	void *mmio = ap->host_set->mmio_base + PDC2_SATA_PLUG_CSR;
> +
> +	//Clear channel hotplug interrupts
> +	u8 maskflags = readb(mmio);
> +	maskflags = (0x11 << (u8)ap->hard_port_no);
> +	writeb(maskflags, mmio);
> +
> +	//Unmask channel hotplug interrupts
> +	maskflags = readb(mmio + 2);
> +	maskflags &= ~(0x11 << (u8)ap->hard_port_no);
> +	writeb(maskflags, mmio + 2);
> +}
> +
> +static void pdc2_phy_reset(struct ata_port *ap)
> +{
> +	/* As observed on the Promise SATAII150 Tx2 Plus/Tx4, giving the
> +	 * controller a hard reset triggers another hotplug interrupt.  So
> +	 * disable them for the hard reset, and re-enable afterwards.
> +	 *
> +	 * No PATA support here yet
> +	 */
> +	if (ap->flags & ATA_FLAG_SATA_RESET && ap->flags & ATA_FLAG_SATA) {
> +		pdc2_disable_channel_hotplug_interrupts(ap);
> +		pdc_phy_reset(ap);
> +		pdc2_enable_channel_hotplug_interrupts(ap);
> +	} else
> +		pdc_phy_reset(ap);
> +}

Don't special case this.  disable/enable hotplug interrupts for all 
controllers.


>  static void pdc_pata_cbl_detect(struct ata_port *ap)
>  {
>  	u8 tmp;
> @@ -483,6 +526,7 @@ static inline unsigned int pdc_interrupt
>  	struct ata_host_set *host_set = dev_instance;
>  	struct ata_port *ap;
>  	void *mmio_base;
> +	u8 plugdata, maskflags;
>  	u32 mask = 0;
>  	unsigned int i, tmp, handled = 0;
>  	unsigned long flags;
> @@ -492,21 +536,18 @@ static inline unsigned int pdc_interrupt
>  	}
>  
>  	mmio_base = host_set->mmio_base;
> -	
> +
>  	spin_lock_irqsave(&host_set->lock, flags);
>  
>  	/* reading should also clear interrupts */
>  	mask = readl(mmio_base + PDC_INT_SEQMASK);
>  
> -	if (mask == 0xffffffff) {
> -		VPRINTK("QUICK EXIT 2\n");
> -		goto done_irq;
> -	}
> +	if (mask == 0xffffffff)
> +		goto try_hotplug;

you are confusing controller hotplug (mask == 0xffffffff) and device 
hotplug.

controller hotplug should already be handled correct, by testing 
0xffffffff and supporting the PCI ->remove hook.


>  	mask &= 0xffff;		/* only 16 tags possible */
> -	if (!mask) {
> -		VPRINTK("QUICK EXIT 3\n");
> -		goto done_irq;
> -	}
> +	if (!mask)
> +		goto try_hotplug;
>  
>  	writel(mask, mmio_base + PDC_INT_SEQMASK);
>  
> @@ -522,7 +563,32 @@ static inline unsigned int pdc_interrupt
>  				handled += pdc_host_intr(ap, qc);
>  		}
>  	}
> -       
> +
> +	if (handled)
> +		goto done_irq;
> +
> +try_hotplug:
> +	plugdata = readb(mmio_base + hotplug_regs);
> +	maskflags = readb(mmio_base + hotplug_regs + 2);
> +	plugdata &= ~maskflags;
> +	if (plugdata) {
> +		writeb(plugdata, mmio_base + hotplug_regs);
> +		for (i = 0; i < host_set->n_ports; ++i) {
> +			ap = host_set->ports[i];
> +			if (!(ap->flags & ATA_FLAG_SATA))
> +				continue;  //No PATA support here... yet
> +			// Check unplug flag
> +			if (plugdata & 0x01) {
> +				ata_hotplug_unplug(ap);
> +				handled = 1;
> +			} else if ((plugdata >> 4) & 0x01) {  //Check plug flag
> +				ata_hotplug_plug(ap);
> +				handled = 1;
> +			}
> +			plugdata >>= 1;

you probably need a debounce timer; see the SiI email I am about to send.


>  done_irq:
>  	spin_unlock_irqrestore(&host_set->lock, flags);
>  	return handled;
> @@ -636,9 +702,9 @@ static void pdc_host_init(unsigned int c
>  	tmp = readl(offset);
>  	writel(tmp | 0xff, offset);
>  
> -	/* mask plug/unplug ints */
> +	/* unmask plug/unplug ints */
>  	tmp = readl(offset);
> -	writel(tmp | 0xff0000, offset);
> +	writel(tmp & 0xff00ffff, offset);
>  
>  	/* reduce TBG clock to 133 Mhz. */
>  	tmp = readl(mmio + PDC_TBG_MODE);

