Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750735AbWFEUgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWFEUgP (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWFEUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:36:15 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:34753
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750730AbWFEUgO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:36:14 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
Date: Mon, 5 Jun 2006 22:35:28 +0200
User-Agent: KMail/1.9.1
References: <20060605201818.1239938CE036@bu3sch.de>
In-Reply-To: <20060605201818.1239938CE036@bu3sch.de>
Cc: Greg KH <gregkh@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
        netdev@vger.kernel.org, mb@bu3sch.de, st3@riseup.net,
        linville@tuxdriver.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200606052235.28687.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 June 2006 22:18, Jiri Slaby wrote:
> bcm43xx avoid pci_find_device
> 
> Change pci_find_device to safer pci_get_device with support for more
> devices.

I am wondering about the reference count.
>From docbook:

256  * pci_get_device - begin or continue searching for a PCI device by vendor/device id
257  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
258  * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
259  * @from: Previous PCI device found in search, or %NULL for new search.
260  *
261  * Iterates through the list of known PCI devices.  If a PCI device is
262  * found with a matching @vendor and @device, the reference count to the
                                                      ^^^^^^^^^^^^^^^^^^^^^^
263  * device is incremented and a pointer to its device structure is returned.
       ^^^^^^^^^^^^^^^^^^^^^
264  * Otherwise, %NULL is returned.  A new search is initiated by passing %NULL
265  * to the @from argument.  Otherwise if @from is not %NULL, searches continue
266  * from next device on the global list.  The reference count for @from is
267  * always decremented if it is not %NULL.

Who is going to decrement it, once the device is not used anymore.
"not used anymore" is ifconfig down in the case of bcm43xx.
You will call pci_get_device on each ifconfig up.

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
>  		}
>  	}
>  #endif
> 

-- 
Greetings Michael.
