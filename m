Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbTKBTKb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 14:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTKBTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 14:10:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:29348 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261776AbTKBTKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 14:10:30 -0500
Date: Sun, 2 Nov 2003 11:12:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniele Venzano <webvenza@libero.it>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sorceforge.net
Subject: Re: [PATCH] Add PM support to sis900 network driver
Message-Id: <20031102111254.481bcbfd.akpm@osdl.org>
In-Reply-To: <20031102182852.GC18017@picchio.gall.it>
References: <20031102182852.GC18017@picchio.gall.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniele Venzano <webvenza@libero.it> wrote:
>
> The attached patch adds support for suspend/resume to the sis900 driver.

...

> +static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
>  +{
>  +	struct net_device *net_dev = pci_get_drvdata(pci_dev);
>  +	struct sis900_private *sis_priv = net_dev->priv;
>  +	long ioaddr = net_dev->base_addr;
>  +	unsigned long flags;
>  +
>  +	if(!netif_running(net_dev))
>  +		return 0;
>  +	netif_stop_queue(net_dev);
>  +	
>  +	netif_device_detach(net_dev);
>  +	spin_lock_irqsave(&sis_priv->lock, flags);
>  +
>  +	/* Stop the chip's Tx and Rx Status Machine */
>  +	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
>  +	
>  +	pci_set_power_state(pci_dev, 3);

pci_set_power_state() can sleep, so we shouldn't be calling it
under spin_lock_irqsave().  Is it necessary to hold the lock
here?
