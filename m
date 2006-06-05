Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750797AbWFEU4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWFEU4A (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWFEU4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:56:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50851 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750776AbWFEUz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:55:59 -0400
Date: Mon, 5 Jun 2006 13:53:09 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Greg KH <gregkh@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
        netdev@vger.kernel.org, mb@bu3sch.de, st3@riseup.net,
        linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
Message-ID: <20060605205309.GA31061@kroah.com>
References: <2005123213211@nnikde.cz> <20060605202007.B464FC7B73@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605202007.B464FC7B73@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 10:20:07PM +0200, Jiri Slaby wrote:
> bcm43xx avoid pci_find_device
> 
> Change pci_find_device to safer pci_get_device with support for more
> devices.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit 4b73c16f5411d97360d5f26f292ffddeb670ff75
> tree 6e43c8bd02498eb1ceec6bdc64277fa8408da9e2
> parent d59f9ea8489749f59cd0c7333a4784cab964daa8
> author Jiri Slaby <ku@bellona.localdomain> Mon, 05 Jun 2006 22:01:03 +0159
> committer Jiri Slaby <ku@bellona.localdomain> Mon, 05 Jun 2006 22:01:03 +0159
> 
>  drivers/net/wireless/bcm43xx/bcm43xx_main.c |   21 ++++++++++++++++-----
>  1 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> index 22b8fa6..d1a9975 100644
> --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> @@ -2133,6 +2133,13 @@ out:
>  	return err;
>  }
>  
> +#ifdef CONFIG_BCM947XX
> +static struct pci_device_id bcm43xx_47xx_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x4324) },
> +	{ 0 }
> +};
> +#endif
> +
>  static int bcm43xx_initialize_irq(struct bcm43xx_private *bcm)
>  {
>  	int res;
> @@ -2142,11 +2149,15 @@ static int bcm43xx_initialize_irq(struct
>  	bcm->irq = bcm->pci_dev->irq;
>  #ifdef CONFIG_BCM947XX
>  	if (bcm->pci_dev->bus->number == 0) {
> -		struct pci_dev *d = NULL;
> -		/* FIXME: we will probably need more device IDs here... */
> -		d = pci_find_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
> -		if (d != NULL) {
> -			bcm->irq = d->irq;
> +		struct pci_dev *d;
> +		struct pci_device_id *id;
> +		for (id = bcm43xx_47xx_ids; id->vendor; id++) {
> +			d = pci_get_device(id->vendor, id->device, NULL);
> +			if (d != NULL) {
> +				bcm->irq = d->irq;
> +				pci_dev_put(d);
> +				break;
> +			}

This will not work if you have more than one of the same devices in the
system.

Well, the original code will not either :(

Why not just use the proper pci interface?  Why poke around in another
pci device to steal an irq, when that irq might not even be valid?
(irqs are not valid until pci_enable_device() is called on them...)

thanks,

greg k-h
