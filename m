Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945919AbWGNXpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945919AbWGNXpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 19:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945921AbWGNXpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 19:45:20 -0400
Received: from mx.pathscale.com ([64.160.42.68]:28590 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1945919AbWGNXpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 19:45:19 -0400
Subject: Re: [openib-general] Suggestions for how to remove bus_to_virt()
From: Ralph Campbell <ralphc@pathscale.com>
To: David Miller <davem@davemloft.net>
Cc: muli@il.ibm.com, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060714.153503.123972494.davem@davemloft.net>
References: <20060712.174013.95062313.davem@davemloft.net>
	 <20060713054658.GC5096@rhun.ibm.com>
	 <1152916027.4572.391.camel@brick.pathscale.com>
	 <20060714.153503.123972494.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 16:45:19 -0700
Message-Id: <1152920719.4572.398.camel@brick.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 15:35 -0700, David Miller wrote:
> From: Ralph Campbell <ralphc@pathscale.com>
> Date: Fri, 14 Jul 2006 15:27:07 -0700
> 
> > Note that the current design only supports one IOMMU type in a system.
> > This could support multiple IOMMU types at the same time.
> 
> This is not true, the framework allows multiply such types
> and in fact Sparc64 takes advantage of this.  We have about
> 4 or 5 different PCI controllers, and the IOMMUs are slightly
> different in each.

I see. It looks like dma_map_single() is an inline call to
pci_map_single() which is a function call that can then
look at the device and tell what IOMMU function to call.

> Even with the standard PCI DMA mapping calls, we can gather the
> platform private information necessary to program the IOMMU
> appropriately for a given chipset.
> 
> The dma_mapping_ops idea will never get accepted by folks like Linus,
> for reasons I've outlined in previous emails in this thread.  So, it's
> best to look elsewhere for solutions to your problem, such as the
> ideas used by the USB and IEE1394 device layers.

The USB code won't work in my case because the USB system is
the one doing the memory allocation and IOMMU setup so it
can remember the kernel virtual address or physical pages used
to create the mapping.

In my case, the infiniband (SRP) code is doing the mapping and
only passing the dma_addr_t to the device driver at which point
I have no way to convert it back to a kernel virtual address.
I need to either change the IB device API to include mapping functions
or intercept the dma_* functions so I can save the inputs.

