Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWFCUSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWFCUSD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 16:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWFCUSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 16:18:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35852 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751773AbWFCUSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 16:18:01 -0400
Date: Wed, 31 May 2006 01:01:09 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Rafa? Bilski <rafalbilski@interia.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI - Unnecessary high-level?
Message-ID: <20060531010108.GA4073@ucw.cz>
References: <4480ACC0.2020806@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4480ACC0.2020806@interia.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-06-06 23:25:20, Rafa? Bilski wrote:
> Why pci_device->suspend() is called with pm_message_t?
> IMO this is low-level PCI driver specific function.
> All drivers are calling pci_choose_state(). If this function
> would be called with pci_power_t maybe would be more PCI aware
> code compatible. Maybe code below would be better? 

No. Low-level drivers want to know difference between SUSPEND and
FREEZE, for example.
							Pavel

> 
> 
> --- linux-2.6.17-rc5/include/linux/pci.h.orig	2006-05-31 09:00:42.000000000 +0200
> +++ linux-2.6.17-rc5/include/linux/pci.h	2006-06-02 22:41:11.000000000 +0200
> @@ -342,7 +342,7 @@ struct pci_driver {
>  	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
>  	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
>  	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
> -	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
> +	int  (*suspend) (struct pci_dev *dev, pci_power_t state);	/* Device suspended */
>  	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
>  	int  (*enable_wake) (struct pci_dev *dev, pci_power_t state, int enable);   /* Enable wake event */
>  	void (*shutdown) (struct pci_dev *dev);
> 
> 
> --- linux-2.6.17-rc5/drivers/pci/pci-driver.c.orig	2006-05-31 09:00:31.000000000 +0200
> +++ linux-2.6.17-rc5/drivers/pci/pci-driver.c	2006-06-02 22:44:18.000000000 +0200
> @@ -272,7 +272,7 @@ static int pci_device_suspend(struct dev
>  	int i = 0;
>  
>  	if (drv && drv->suspend) {
> -		i = drv->suspend(pci_dev, state);
> +		i = drv->suspend( pci_dev, pci_choose_state(state) );
>  		suspend_report_result(drv->suspend, i);
>  	} else {
>  		pci_save_state(pci_dev);
> 
> 
> ----------------------------------------------------------------------
> Poznaj Stefana! Zmien komunikator! >>> http://link.interia.pl/f1924
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Thanks for all the (sleeping) penguins.
