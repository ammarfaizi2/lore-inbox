Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbVH3Gph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbVH3Gph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 02:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVH3Gph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 02:45:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:29911 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750961AbVH3Gpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 02:45:36 -0400
Subject: Re: Ignore disabled ROM resources at setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no
In-Reply-To: <Pine.LNX.4.58.0508292149260.3243@g5.osdl.org>
References: <200508261859.j7QIxT0I016917@hera.kernel.org>
	 <1125369485.11949.27.camel@gaston> <1125371996.11963.37.camel@gaston>
	 <Pine.LNX.4.58.0508292045590.3243@g5.osdl.org>
	 <1125376431.11949.47.camel@gaston>
	 <Pine.LNX.4.58.0508292149260.3243@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 16:40:48 +1000
Message-Id: <1125384049.11948.66.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 22:03 -0700, Linus Torvalds wrote:
> 
> On Tue, 30 Aug 2005, Benjamin Herrenschmidt wrote:
> > 
> > So what about fixing pci_map_rom() to call pcibios_resource_to_bus() and
> > then write the resource back to the BAR ? I'm still a bit annoyed that
> > we re-allocate the address while the original one was perfectly good
> > (though not enabled) but the above would work.
> 
> I just sent you a patch to try.
> 
> Btw, as to the re-allocation of an existing address: most of the PCI layer
> really does try to avoid re-allocating known good addresses. In fact, I 
> thought we did so for ROM resources too: at least pci_read_bases() does 
> read the ROM base, and saves it off into the resource structure.
> 
> We'll end up re-assigning that saved-off-address if there were resource
> clashes, though. And bugs always happen, especially since that code
> doesn't get much testing on x86 (there are almost never any interesting
> rom resources for _any_ device, and apparently the video device which is
> one of the few interesting ones always ends up using the shadow rom thing
> on x86 for the primary card).

>From my experience, we tend to re-allocate a lot more than necessary.
afaik, as soon as we hit a p2p bridge, we just blindly re-allocate
everything in my experience.

I have a lot of cases on ppc64 where calling
pci_assign_unassigned_resources() will simply screw everything up and
lead with a bus in a completely unuseable state, with things half
relocated, conflicting bits, etc... Ok, that was about 2.6.12 timeframe,
I never had time to fully debug that. Part of the problem was some
assumptions about the existence of a prefetchable range in a given
position in the resource array, or the kernel having a different idea
than the firmware on where such things should go.

I'll try to go back to it sooner or later. The problem on macs for
example is that we can't afford to have some devices moved at all (like
the Apple ASIC that contains the interrupt controller etc...). Those
bits are probed & the drivers are setup before we touch the PCI bus,
based on the open firmware device-tree. If we move them around, we are
screwed. There are other issues with the fact that the PCI probe will
temporarily cut access to thsoe devices during BAR sizing or bus
numbering, thus if you take an interrupt at the wrong time, you are
toast.

Finally, on ppc64, we also have the case of partitioned machines where
we aren't allowed to touch some busses at all (and the kernel really
tries to reconfigure p2p bridges all the time).

> If you find the thing that causes us to re-assign the address, holler.

I'll try to find out.

> (See drivers/pci/probe.c: pci_read_bases() for the code that probes the
> old address and saves it into the resource struct. It's called by
> pci_setup_device() from the device scanning routines).

Yes I know that part, I'm not sure yet why it gets reallocated.

I suppose paulus and I need to spend again some serious time on the PCI
code. We have to anyway with the pending merge of ppc32 and ppc64 so it
might be a good opportunity to try again getting the common code in
drivers/pci/setup-* working for us.

Ben.


