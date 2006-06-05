Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750701AbWFEU42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWFEU42 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWFEU42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:56:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:47797 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750777AbWFEU41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:56:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=S1hhC7Rxd3TrcoK65jQcmwxS1XgunHuh7JVFe/VvW8vOKXEUGD2Omk/bvLie9L/jfNoBB3TW8VIn+1KWshAMA5eY3c3aYSXely+3xlWrWi1aLBh9zU5c2Ap5sIUF+bwpaplZOEII5TP2SjtG2h7ZC/AkYB7LItICDa06dvL9F8Y=
Message-ID: <44849A7B.10307@gmail.com>
Date: Mon, 05 Jun 2006 22:56:04 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@atrey.karlin.mff.cuni.cz, jgarzik@pobox.com,
        netdev@vger.kernel.org, stevel@mvista.com, source@mvista.com
Subject: Re: [PATCH 3/3] pci: gt96100eth avoid pci_find_device
References: <448491ab.7fb59b32.690f.01c1SMTPIN_ADDED@mx.gmail.com>
In-Reply-To: <448491ab.7fb59b32.690f.01c1SMTPIN_ADDED@mx.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):
> gt96100eth avoid pci_find_device
> 
> Change pci_find_device to safer pci_get_device with support for more
> bridges.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> ---
> commit fd863b81ac491faf783ff7f2dcf6032177c5ab7f
> tree d7eb59f897505230023754f19ad7227eec39e676
> parent 4b73c16f5411d97360d5f26f292ffddeb670ff75
> author Jiri Slaby <ku@bellona.localdomain> Mon, 05 Jun 2006 22:01:20 +0159
> committer Jiri Slaby <ku@bellona.localdomain> Mon, 05 Jun 2006 22:01:20 +0159
> 
>  drivers/net/gt96100eth.c |   23 ++++++++++++++++++-----
>  1 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/gt96100eth.c b/drivers/net/gt96100eth.c
> index 2d24354..3066c86 100644
> --- a/drivers/net/gt96100eth.c
> +++ b/drivers/net/gt96100eth.c
> @@ -600,6 +600,11 @@ disable_ether_irq(struct net_device *dev
>  	GT96100ETH_WRITE(gp, GT96100_ETH_INT_MASK, 0);
>  }
>  
> +static struct pci_device_id gt96100_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT96100) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_GT96100A) },
> +	{ 0 }
> +};
>  
>  /*
>   * Init GT96100 ethernet controller driver
> @@ -607,16 +612,20 @@ disable_ether_irq(struct net_device *dev
>  static int gt96100_init_module(void)
>  {
>  	struct pci_dev *pci;
> +	struct pci_device_id *id;
>  	int i, retval=0;
>  	u32 cpuConfig;
>  
>  	/*
>  	 * Stupid probe because this really isn't a PCI device
>  	 */
> -	if (!(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> -	                            PCI_DEVICE_ID_MARVELL_GT96100, NULL)) &&
> -	    !(pci = pci_find_device(PCI_VENDOR_ID_MARVELL,
> -		                    PCI_DEVICE_ID_MARVELL_GT96100A, NULL))) {
> +	for (id = gt96100_ids; id->vendor; id++) {
> +		pci = pci_get_device(id->vendor, id->device, NULL);
> +		if (pci != NULL)
> +			break;
> +	}
I wonder if this is even better:
while ((pci = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci)) != NULL)
    if (pci_match_id(gt96100_ids, pci) != NULL)
         break;
What do you think?
> +
> +	if (!id->vendor) {
>  		printk(KERN_ERR __FILE__ ": GT96100 not found!\n");
>  		return -ENODEV;
>  	}
> @@ -625,12 +634,16 @@ static int gt96100_init_module(void)
>  	if (cpuConfig & (1<<12)) {
>  		printk(KERN_ERR __FILE__
>  		       ": must be in Big Endian mode!\n");
> -		return -ENODEV;
> +		retval = -ENODEV;
> +		goto err_pput;
>  	}
>  
>  	for (i=0; i < NUM_INTERFACES; i++)
>  		retval |= gt96100_probe1(pci, i);
>  
> +err_pput:
> +	pci_dev_put(pci);
> +
>  	return retval;
>  }
>  
> 


-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
