Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268331AbRHFMuf>; Mon, 6 Aug 2001 08:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268332AbRHFMu1>; Mon, 6 Aug 2001 08:50:27 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:54023 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S268331AbRHFMuJ>; Mon, 6 Aug 2001 08:50:09 -0400
Date: Mon, 6 Aug 2001 14:50:01 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: <linux-kernel@vger.kernel.org>, <kaos@ocs.com.au>
Subject: Re: 2.4.8-pre4, lots of compile warnings
In-Reply-To: <200108061213.f76CDoE05527@ns.caldera.de>
Message-ID: <Pine.LNX.4.33.0108061430250.8689-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Christoph Hellwig wrote:

> There is another way to at lest use the pci tables without going for
> the full hotplug API.
> 
> Just replace code like:
> 
> 	if ((dev_avm = pci_find_device(PCI_VENDOR_ID_AVM,
> 			PCI_DEVICE_ID_AVM_A1,  dev_avm))) {
> 		/* initialize card */
> 	}
> 
> with something like:
> 
> 
> 	pci_for_each_dev(dev_avm) {
> 		if (pci_match_device(avm_pci_tbl, dev_avm)) {
> 			/* initialize card */
> 		}
> 	}
> 
> This will need per-card instead of the current global hisax pci tables,
> but I think it's a good cleanup.

Thanks for the suggestion.
It looks like a good idea, but I don't think it'll actually work, though.
First, note that dev_avm is static in the upper code fragment, because 
this probe routine will be called multiple times and is supposed to only 
initialize one card at a time.
Secondly, having per-card type pci tables doesn't mix well with 
MODULE_DEVICE_TABLE AFAICS, because that assumes that we can only have one 
device table per module.

> > I'll break this compatibility in 2.5, though.
> 
> Nice!  Does this mean the hisax subdrivers will finally be able to be
> individual modules?  Are there also other ISDN changes planned, e.g.
> going from the global cli/sti to better locking schemes?

Yes, hisax.o will only be the protocol layer. The actual hardware drivers
will be modules of their own, and use the new infrastructure. Code for
this already consists, and I have some new drivers pending, which will use
this approach in 2.4 already. I won't change the existing drivers in 2.4
for obvious reasons, though. Of course these new drivers are also supposed
to use proper SMP locking.

There is also the plan to declare the old "ISDN link layer" (isdn.o)  
obsolete and move to a CAPI (see www.capi.org) based system. This should
get us rid of the old messy and racy cruft in drivers/isdn.

--Kai


