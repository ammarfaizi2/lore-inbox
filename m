Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbUBXOHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUBXOHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:07:04 -0500
Received: from ns.suse.de ([195.135.220.2]:8384 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262151AbUBXOGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:06:49 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: IOMMUs was Re: Intel vs AMD x86-64
References: <Pine.LNX.4.44.0402231625220.9708-100000@chimarrao.boston.redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402231335430.3005@ppc970.osdl.org.suse.lists.linux.kernel>
	<20040223134853.5947a414.davem@redhat.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Feb 2004 15:06:47 +0100
In-Reply-To: <Pine.LNX.4.58.0402231359280.3005@ppc970.osdl.org.suse.lists.linux.kernel>
Message-ID: <p73r7wk607c.fsf_-_@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> In fact, I _think_ you could actually use the AGP bridge as a strange
> IOMMU. Of course, right now their AGP bridges are all 32-bit limited
> anyway, but the point being that they at least in theory would seem to
> have the capability to do this.

Actually AGPv3 is 40 bits capable (using a strange encoding, but it works).

On Opteron the IOMMU code (ab)uses the built in AGPv3 GART in the CPU, which 
was originally intended for AGP. AMD converted it to be able to remap
PCI especially for Linux, which I think deserves applause.

It works surprisingly well even though it was not designed as a real
IOMMU. Of course one of the main advantages of a real IOMMU -
preventing arbitary memory corruption from broken devices - is lost
because the remapping table is just a hole in the memory. I'm 
secretly hoping that when there is more support for Linux at 
chipset vendors they will someday add a bit to isolate all traffic
that doesn't go through the GART from the main memory. This way
you could get a much more reliable system that can tolerate broken
PCI devices at a moderate performance penalty.

One side effect of this is that the IOMMU TLB flush strategy is a bit
dumb, because it has to do config space accesses for it. This is
understandable because AGP rarely sets up new mappings. This is a bit
of a problem because the @#$@$-X server does direct PCI accesses on
its own and can race with an IOMMU TLB flush. But I hope this can get
fixed eventually e.g. with the new freedesktop.org X server. When
we get PCI Express memory mapped config space support this problem
will hopefully go away.

The bad message is that PCI Express will do away with GARTs, so 
they may not be there anymore in future chipsets. But I hope they
will at least keep it in the Opteron on CPU bridge.
 
> > Really, not having an IOMMU on a 64-bit platform these days is basically like
> > pulling out one's toenails with an ice pick.
> 
> Well, as long as they had that "64-bit is server" mentality, they can 
> honestly say that you just have to use 64-bit-capable PCI cards.
> 
> Now, the "server only" mentality is obviously crap, but since we haven't
> even seen the chipsets designed for the 64-bit chips, we shouldn't
> complain. At least yet.

What I find especially ironic is that exactly the same chipset
people who use these crap arguments put 32bit only USB and IDE 
devices into the same chips. USB and IDE are the major users
of the IOMMU. And yes, they're 32bit only even in the "highend"
Intel server chipsets. And they already have a mostly working IOMMU in the 
chipset for the GART, they just refuse to use it for PCI too.

> Now, I'm not above complaining about Intel (in fact, the Intel people seem
> to often think I hate them because I'm apparently the only person who gets
> quoted who complains about bad decisions publicly), but at least I try to
> avoid complaining before-the-fact ;)

Can you please complain a bit more about the chipset people and
get quoted so that Intel management hears you ? ;-)

-Andi
