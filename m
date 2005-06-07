Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVFGCUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVFGCUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVFGCTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:19:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:20367 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261349AbVFGCRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:17:50 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Karsten Keil <kkeil@suse.de>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050606224645.GA23989@pingi3.kke.suse.de>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 12:15:44 +1000
Message-Id: <1118110545.6850.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 00:46 +0200, Karsten Keil wrote:
> Hi,
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

It should probably test for message state, it's not worth doing
pci_set_power_state(D3) if PMSG_FREEZE is passed... (just slows down
suspend to disk)

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

