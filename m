Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272872AbTG3NPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272881AbTG3NPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:15:34 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:32170 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S272872AbTG3NPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:15:24 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test2 wanXL driver
References: <m3lluhnj6e.fsf@defiant.pm.waw.pl>
	<20030730002959.A23749@electric-eye.fr.zoreil.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 30 Jul 2003 01:09:34 +0200
In-Reply-To: <20030730002959.A23749@electric-eye.fr.zoreil.com>
Message-ID: <m3u195lykx.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> writes:

> unsigned long timeout = jiffies + HZ;
> 
> do {
> ...
> } while (time_after(timeout, jiffies));

That's the same (my version deals with wraps too) but yes, time_after
looks nicer. I'll change it in next version.


> +	switch (pdev->device) {
> +	case PCI_DEVICE_ID_SBE_WANXL100: ports = 1; break;
> +	case PCI_DEVICE_ID_SBE_WANXL200: ports = 2; break;
> +	default: ports = 4;
> +	}
> 
> You can do it this way:
> static struct pci_device_id wanxl_pci_tbl[] __devinitdata = {
> 	{ PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL100, PCI_ANY_ID,
> 	  PCI_ANY_ID, 0, 0, 1 },
>         { PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL200, PCI_ANY_ID,
>           PCI_ANY_ID, 0, 0, 2 },
>         { PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL400, PCI_ANY_ID,
>           PCI_ANY_ID, 0, 0, 4 },
>         { 0, }
> };
> 
> ports = ent->driver_data;
> 
> (imho turning 1, 2, 4 into #define wouldn't be bad then)

Yes, but I like having the variable local to this function a little more.

> +	while ((stat = readl(card->plx + PLX_MAILBOX_0)) != 0) {
> +		if (jiffies - start >= 20 * HZ) {
> +			printk(KERN_WARNING "wanXL %s: timeout waiting for"
> +			       " PUTS to complete\n", card_name(pdev));
> +			return -ENODEV;
> 
> This return leaks kmalloced card_t *card, pci_requested_regions and
> ioremaped area (same thing for the return a few lines below in the
> same function).

Right. Will fix in next version.

> +	for (i = 0; i < RX_QUEUE_LENGTH; i++) {
> +		struct sk_buff *skb = dev_alloc_skb(BUFFER_LENGTH);
> +		card->rx_skbs[i] = skb;
> +		if (skb)
> +			card->rx_descs[i].address = virt_to_bus(skb->data);
> 
> dma_map_single() is probably preferred over virt_to_bus().

Never heard of it in fact :-)
Will check.

Thanks.
-- 
Krzysztof Halasa
Network Administrator
