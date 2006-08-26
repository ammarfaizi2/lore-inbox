Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWHZQXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWHZQXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWHZQXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:23:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4487 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030236AbWHZQXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:23:23 -0400
Subject: Re: [patch 08/10] [TULIP] Handle pci_enable_device() errors in
	resume
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20060826000304.251263000@linux.intel.com>
References: <20060826000227.818796000@linux.intel.com>
	 <20060826000304.251263000@linux.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 26 Aug 2006 17:41:58 +0100
Message-Id: <1156610518.3007.287.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-25 am 17:02 -0700, ysgrifennodd Valerie Henson:
>  	pci_set_power_state(pdev, PCI_D0);
>  	pci_restore_state(pdev);
>  
> -	pci_enable_device(pdev);
> +	if ((retval = pci_enable_device(pdev))) {
> +		printk (KERN_ERR "tulip: pci_enable_device failed in resume\n");
> +		return retval;
> +	}
Should you not stick it back in D3 if you are being neat about this ?

 
>  	if ((retval = request_irq(dev->irq, &tulip_interrupt, IRQF_SHARED, dev->name, dev))) {
>  		printk (KERN_ERR "tulip: request_irq failed in resume\n");
> --- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/winbond-840.c
> +++ linux-2.6.18-rc4-mm1/drivers/net/tulip/winbond-840.c
> @@ -1626,14 +1626,18 @@ static int w840_resume (struct pci_dev *
>  {
>  	struct net_device *dev = pci_get_drvdata (pdev);
>  	struct netdev_private *np = netdev_priv(dev);
> +	int retval;
>  
>  	rtnl_lock();
>  	if (netif_device_present(dev))
>  		goto out; /* device not suspended */
>  	if (netif_running(dev)) {
> -		pci_enable_device(pdev);
> -	/*	pci_power_on(pdev); */
> -
> +		if ((retval = pci_enable_device(pdev))) {
> +			printk (KERN_ERR
> +				"%s: pci_enable_device failed in resume\n",
> +				dev->name);
> +			return retval;

NAK: What about rtnl_lock()

> +		}
>  		spin_lock_irq(&np->lock);
>  		iowrite32(1, np->base_addr+PCIBusCfg);
>  		ioread32(np->base_addr+PCIBusCfg);
> --- linux-2.6.18-rc4-mm1.orig/drivers/net/tulip/de2104x.c
> +++ linux-2.6.18-rc4-mm1/drivers/net/tulip/de2104x.c
> @@ -2138,17 +2138,21 @@ static int de_resume (struct pci_dev *pd
>  {
>  	struct net_device *dev = pci_get_drvdata (pdev);
>  	struct de_private *de = dev->priv;
> +	int retval;
>  
>  	rtnl_lock();
>  	if (netif_device_present(dev))
>  		goto out;
> -	if (netif_running(dev)) {
> -		pci_enable_device(pdev);
> -		de_init_hw(de);
> -		netif_device_attach(dev);
> -	} else {
> -		netif_device_attach(dev);
> +	if (!netif_running(dev))
> +		goto out_attach;
> +	if ((retval = pci_enable_device(pdev))) {
> +		printk (KERN_ERR "%s: pci_enable_device failed in resume\n",
> +			dev->name);
> +		return retval;

NAK again - rtnl_lock


