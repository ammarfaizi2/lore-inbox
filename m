Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTERGw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 02:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbTERGw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 02:52:29 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:44875 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261177AbTERGw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 02:52:27 -0400
Date: Sun, 18 May 2003 03:05:22 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200305180705.h4I75MT13787@devserv.devel.redhat.com>
To: Jes Sorensen <jes@wildopensource.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] support 64 bit pci_alloc_consistent
In-Reply-To: <mailman.1053231184.22467.linux-kernel2news@redhat.com>
References: <mailman.1053231184.22467.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The default mask for pci_alloc_consistent() is still 32 bit as there are
> 64 bit capable hardware out there that doesn't support 64 bit addresses
> for descripters etc.

I think this is a mix-up of concepts. You mean aic7xxx, right?
IMHO, it's an example of a device which needs various masks
for different allocations. As it happens, the driver uses
consistent allocations with one mask, streaming allocations
with other mask. This is a pure coincidence, however. Being
consistent or streaming is one thing, and asking for various
masks is another thing.

But I see that there may be practical differences if we suddenly
make pci_set_dma_mask act upon consistent allocations. So,
perhaps you're right... Let's add a call...

> @@ -94,6 +103,11 @@
>  
>  	int pci_set_dma_mask(struct pci_dev *pdev, u64 device_mask);
>  
> +The query for consistent allocations is performed via a a call to
> +pci_set_consistent_dma_mask():
> +
> +	int pci_set_consistent_dma_mask(struct pci_dev *pdev, u64 device_mask);

I think it's not a query, but a request, but I'm not a native
speaker.

> +pci_set_consistent_dma_mask() will always be able to set the same or a
> +smaller mask as pci_set_dma_mask(). However for the rare case that a
> +device driver only uses consistent allocations, one would have to
> +check the return value from pci_set_consistent().

pci_set_consistent_dma_mask, surely.

> +	dev->consistent_dma_mask = mask;
 
> +	u64		consistent_dma_mask;/* Like dma_mask, but for
> +					       pci_alloc_consistent mappings as
> +					       not all hardware supports
> +					       64 bit addresses for consistent
> +					       allocations such descriptors. */

> +int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);

This is cool, but where is the implementation?

I do not see anyone honouring the ->consistent_dma_mask
in the patch. I'm stupid, right?

-- Pete
