Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWEZAff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWEZAff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 20:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWEZAff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 20:35:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59322 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965214AbWEZAfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 20:35:34 -0400
Message-ID: <44764D4B.6050105@pobox.com>
Date: Thu, 25 May 2006 20:35:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       mb@bu3sch.de, st3@riseup.net, linville@tuxdriver.com
Subject: Re: [PATCH 2/3] pci: bcm43xx avoid pci_find_device
References: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060526001053.D2349C7C58@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> bcm43xx avoid pci_find_device
> 
> Change pci_find_device to safer pci_get_device with support for more
> devices.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit 1d3b6caf027fe53351c645523587aeac40bc3e47
> tree ae37c86b633442cdf8a7a19ac287542724081c90
> parent ab3443d79c94d0ae6a9e020daefa4d29eccff50d
> author Jiri Slaby <ku@bellona.localdomain> Fri, 26 May 2006 01:49:12 +0159
> committer Jiri Slaby <ku@bellona.localdomain> Fri, 26 May 2006 01:49:12 +0159
> 
>  drivers/net/wireless/bcm43xx/bcm43xx_main.c |   20 ++++++++++++++++----
>  1 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_main.c b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> index b488f77..56d2fc6 100644
> --- a/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> +++ b/drivers/net/wireless/bcm43xx/bcm43xx_main.c
> @@ -2131,6 +2131,13 @@ out:
>  	return err;
>  }
>  
> +#ifdef CONFIG_BCM947XX
> +static struct pci_device_id bcm43xx_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, 0x4324) },
> +	{ 0 }
> +};
> +#endif
> +
>  static int bcm43xx_initialize_irq(struct bcm43xx_private *bcm)
>  {
>  	int res;
> @@ -2141,10 +2148,15 @@ static int bcm43xx_initialize_irq(struct
>  #ifdef CONFIG_BCM947XX
>  	if (bcm->pci_dev->bus->number == 0) {
>  		struct pci_dev *d = NULL;
> -		/* FIXME: we will probably need more device IDs here... */
> -		d = pci_find_device(PCI_VENDOR_ID_BROADCOM, 0x4324, NULL);
> -		if (d != NULL) {
> -			bcm->irq = d->irq;
> +		struct pci_device_id *id = bcm43xx_ids;
> +		while (id->vendor) {
> +			d = pci_get_device(id->vendor, id->device, NULL);
> +			if (d != NULL) {
> +				bcm->irq = d->irq;
> +				pci_dev_put(d);
> +				break;

You'll want to use pci_match_device() or pci_match_one_device()
[I forget which one]

	Jeff



