Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVFGAFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVFGAFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVFGAFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:05:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:43704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261789AbVFGACN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 20:02:13 -0400
Date: Mon, 6 Jun 2005 17:04:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Karsten Keil <kkeil@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix tulip suspend/resume
In-Reply-To: <20050606224645.GA23989@pingi3.kke.suse.de>
Message-ID: <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff, 
 this looks ok, but I'll leave the decision to you. Things like this often 
break.

Andrew, maybe at least a few days in -mm to see if there's some outcry?

		Linus

On Tue, 7 Jun 2005, Karsten Keil wrote:
> 
> following patch fix the suspend/resume for tulip based
> cards, so suspend on disk work now for me and tulip based
> cardbus cards.
> 
> 
> Signed-off-by: Karsten Keil <kkeil@suse.de>
> 
> --- linux/drivers/net/tulip/tulip_core.c.orig	2005-03-23 23:54:43.000000000 +0100
> +++ linux/drivers/net/tulip/tulip_core.c	2005-05-26 17:29:14.000000000 +0200
> @@ -1755,12 +1755,16 @@
>  static int tulip_suspend (struct pci_dev *pdev, pm_message_t state)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
> +	int err;
>  
> +	pci_save_state(pdev);
>  	if (dev && netif_running (dev) && netif_device_present (dev)) {
>  		netif_device_detach (dev);
>  		tulip_down (dev);
>  		/* pci_power_off(pdev, -1); */
>  	}
> +	if ((err = pci_set_power_state(pdev, PCI_D3hot)))
> +		printk(KERN_ERR "%s: pci_set_power_state D3hot return %d\n", dev->name, err);
>  	return 0;
>  }
>  
> @@ -1768,7 +1772,11 @@
>  static int tulip_resume(struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
> +	int err;
>  
> +	if ((err = pci_set_power_state(pdev, PCI_D0)))
> +		printk(KERN_ERR "%s: pci_set_power_state D0 return %d\n", dev->name, err);
> +	pci_restore_state(pdev);
>  	if (dev && netif_running (dev) && !netif_device_present (dev)) {
>  #if 1
>  		pci_enable_device (pdev);
> 
> -- 
> Karsten Keil
> SuSE Labs
> ISDN development
> 
