Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbREULJx>; Mon, 21 May 2001 07:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbREULJn>; Mon, 21 May 2001 07:09:43 -0400
Received: from ns.suse.de ([213.95.15.193]:36112 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262468AbREULJb>;
	Mon, 21 May 2001 07:09:31 -0400
Date: Mon, 21 May 2001 13:08:35 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521130835.A3910@gruyere.muc.suse.de>
In-Reply-To: <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521112357.A1718@gruyere.muc.suse.de> <15112.57377.723591.710628@pizda.ninka.net> <20010521114216.A1968@gruyere.muc.suse.de> <15112.59192.613218.796909@pizda.ninka.net> <20010521122753.A2507@gruyere.muc.suse.de> <15112.61258.251051.960811@pizda.ninka.net> <20010521124225.A3417@gruyere.muc.suse.de> <15112.62483.731973.549006@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15112.62483.731973.549006@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 03:55:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:55:15AM -0700, David S. Miller wrote:
> The original claim is that the situation was not handled at all.  All
> I'm trying to say is simply that the net stack does check via
> illegal_highdma() the condition you stated was not being checked at
> all.  To me it sounded like you were claiming that HIGHMEM pages went
> totally unchecked through device transmit, and that is totally untrue.

Yes I was wrong on this one, but after looking at the acenic I think
the current solution is not very nice to driver authors.

> 
> If you were trying to point out the problem with what the Acenic
> driver is doind, just state that next time ok? :-)

It's more a generic problem with PCI DMA API, acenic just happens to
be the clearest victim of it @)

> Plainly, I'm going to be highly reluctant to make changes to the PCI
> dma API in 2.4.x  It is already hard enough to get all the PCI drivers
> in line and using it.  Suggesting this kind of change is similar to
> saying "let's change the arguments to request_irq()".  We would do it
> to fix a true "people actually hit this" kind of bug, of course.  Yet
> we would avoid it at all possible costs due to the disruption this
> would cause.

How about a new function (pci_nonrepresentable_address() or whatever) 
that returns true when page cache contains pages that are not representable
physically as void *. On IA32 it would return true only if CONFIG_PAE is 
true and there is memory >4GB. 

Then the network driver could do

	if (!pci_nonrepresentable_address()) 
		dev->features |= NETIF_F_HIGHDMA;

[in theory it would be possible to push it up into dev.c to avoid
bounces for highmem memory <4GB, but I don't want to teach such details
to the generic layer]

DAC support would be the next step, not necessarily one for 2.4, but perhaps
one that could be backported from 2.5 at some point.

-Andi
