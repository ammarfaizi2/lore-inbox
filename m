Return-Path: <linux-kernel-owner+w=401wt.eu-S935310AbWLKO1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935310AbWLKO1U (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935226AbWLKO1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:27:20 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:2163 "EHLO
	jurassic.park.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935310AbWLKO1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:27:18 -0500
Date: Mon, 11 Dec 2006 17:27:37 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pci_assign_resource() inconsistency
Message-ID: <20061211172737.A26031@jurassic.park.msu.ru>
References: <1165808875.7260.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1165808875.7260.12.camel@localhost.localdomain>; from benh@kernel.crashing.org on Mon, Dec 11, 2006 at 02:47:55PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 02:47:55PM +1100, Benjamin Herrenschmidt wrote:
> So at first, an unassigned resource has the IORESOURCE_UNSET flag set
> (or is supposed to). pci_assign_resource() itself will clear that flag
> if it succeeds.
> 
> However, pretty much nothing else checks that flag, so it's mostly
> useful.

I doubt of the generic usefulness of that flag, as it would be mere
equivalent of resource->parent == NULL.
I think the IORESOURCE_UNSET flag came from PnP and PCI subsystem has
never used it.

> Now, we have drivers/pci/setup-bus.c doing:
> 
>                 if (pci_assign_resource(list->dev, idx)) {
>                         res->start = 0;
>                         res->end = 0;
>                         res->flags = 0;
>                 }
> 
> So it basically destroys the resource content utterly when
> pci_assign_resource() fails...

Yes, it's ugly. But, IIRC, this was the only way to prevent some drivers
and arch code from using an unassigned resource...

> There are questions raised here:
> 
>  - Shouldn't we instead fix things so that instead, we properly
> test for IORESOURCE_UNSET in pci_request_* & friends and just have
> pci_assign_resource() continue as it's doing now, that is not clear that
> flag if the assignment fails ?
> 
>  - setup-bus.c is a bit violent: As soon as it hits a p2p bridge, it
> will bluntly re-assign everybody, not trying to check wether a resource
> was already correctly assigned by the firmware or not. However, it never

No - it checks the resource->parent and doesn't touch the resources which
are already assigned.

> sets IORESOURCE_UNSET. Thus if we do the above, we should probably have
> it always set that bit before calling pci_assign_resource()...
> 
> Now the question is, what should I do in pci_32.c ... right now, we
> unconditionally clear IORESOURCE_UNSET, which isn't very correct, then
> call pci_assign_resource().
> 
> Should I do like the setup-bus.c and just completely wipe the resource
> if pci_assign_resource() fail ? Or should I just stop clearing
> IORESOURCE_UNSET (and thus rely on pci_assign_resource() to clear it
> only if it succeeds, which seems to work) in which case I see no point
> in making that function much check since there is nothing useful to do
> when it fails and it does printk already.

Well, as IORESOURCE_UNSET usage seems to be an exclusive PPC32 thing,
there is no much difference. ;-)
Though I agree that ignoring the return value of pci_assign_resource()
is entirely valid in most cases.

Ivan.
