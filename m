Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTBTEJI>; Wed, 19 Feb 2003 23:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTBTEJI>; Wed, 19 Feb 2003 23:09:08 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29191
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264818AbTBTEJG>; Wed, 19 Feb 2003 23:09:06 -0500
Date: Wed, 19 Feb 2003 20:18:15 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: part fix the highpoint timing/overclock bug
In-Reply-To: <E18lCYo-0006ED-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10302192016580.11001-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That will deadlock it into a death spiral beause PIO is not setup either,
but I like the warning!


Andre Hedrick
LAD Storage Consulting Group

On Tue, 18 Feb 2003, Alan Cox wrote:

> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/hpt366.c linux-2.5.61-ac2/drivers/ide/pci/hpt366.c
> --- linux-2.5.61/drivers/ide/pci/hpt366.c	2003-02-10 18:38:43.000000000 +0000
> +++ linux-2.5.61-ac2/drivers/ide/pci/hpt366.c	2003-02-18 18:06:19.000000000 +0000
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/hpt366.c		Version 0.34	Sept 17, 2002
> + * linux/drivers/ide/pci/hpt366.c		Version 0.34	Sept 17, 2002
>   *
>   * Copyright (C) 1999-2002		Andre Hedrick <andre@linux-ide.org>
>   * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
> @@ -807,7 +807,7 @@
>  	} else if (freq < 0xc8) {
>  		pll = F_LOW_PCI_50;
>  		if (hpt_minimum_revision(dev,8))
> -			return -EOPNOTSUPP;
> +			pci_set_drvdata(dev, NULL);
>  		else if (hpt_minimum_revision(dev,5))
>  			pci_set_drvdata(dev, (void *) fifty_base_hpt372);
>  		else if (hpt_minimum_revision(dev,4))
> @@ -820,7 +820,7 @@
>  		if (hpt_minimum_revision(dev,8))
>  		{
>  			printk(KERN_ERR "HPT37x: 66MHz timings are not supported.\n");
> -			return -EOPNOTSUPP;
> +			pci_set_drvdata(dev, NULL);
>  		}
>  		else if (hpt_minimum_revision(dev,5))
>  			pci_set_drvdata(dev, (void *) sixty_six_base_hpt372);
> @@ -923,7 +923,7 @@
>  	if (!pci_get_drvdata(dev))
>  	{
>  		printk(KERN_ERR "hpt366: unknown bus timing.\n");
> -		return -EOPNOTSUPP;
> +		pci_set_drvdata(dev, NULL);
>  	}
>  	return 0;
>  }
> @@ -1061,6 +1061,12 @@
>  
>  	if (!dmabase)
>  		return;
> +		
> +	if(pci_get_drvdata(hwif->pci_dev) == NULL)
> +	{
> +		printk(KERN_WARNING "hpt: no known IDE timings, disabling DMA.\n");
> +		return;
> +	}
>  
>  	dma_old = hwif->INB(dmabase+2);
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

