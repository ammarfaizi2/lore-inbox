Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUCWCyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbUCWCyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:54:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:46571 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262194AbUCWCyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:54:52 -0500
Subject: Re: Issues with /proc/bus/pci
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040322183126.16fe76cc.davem@redhat.com>
References: <1080007613.22212.61.camel@gaston>
	 <20040322183126.16fe76cc.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1080009609.23717.81.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 13:40:11 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-23 at 13:31, David S. Miller wrote:
> On Tue, 23 Mar 2004 13:06:53 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > I could add the host bridge thing fairly easily, but I think it
> > is not very practical. Well, I probably have to add it anyway in
> > case any existing stuff uses that, but it's definitely not
> > practical when you have a bit of useralnd that knows the PCI ID
> > (domain/bus/devfn) of the card and wants to access the legacy IO
> > space of that bridge. The problem is finding which pci_dev is
> > the host bridge, if any since host bridges aren't required to
> > show up at all.
> 
> You have a problem.  You must implement this 'trick' because things
> like xfree86 domain stuff wants it too.

I know, but xfree is probably the only thing that matters and it
can probably still be changed if we go a different way... My main
issue is that there is no guarantee the host bridge shows up as
a PCI device as far as I know. It's not in the spec, some bridges
are currently hidden on some ppc 4xx embedded platforms (though
in that case, we could probably quirk to just hide the BARs since
those are the problem), but in general, I think it may be a
problem.

> I've been exporting the host PCI bridges to the usespace since day one,
> and one only needs walk the devfn/bus numbers properly to find the proper
> bridge for a given pci dev, right?

Well. On PowerMacs (and apparently on pSeries too), I usually have
the host bridge show up as a device, except of G5's hypertransport
(but that's fixable as it does exist, though with a weird config
space access method that I didn't bother implement yet). But it's
not obvious which device is the host bridge ;) In an ideal world,
we could say that you have to walk all devices in the system, and
find the one of class "host" with the same domain number. But
that assumes:

 - That the host bridge does show up as a pci device which isn't
required afaik
 - That the host bridges does have a PCI class of host bridge,
which may not be true (though that's quirk'able)
 - The actual "discovery" of it above from userland isn't that
simple, especially since for compatibility with existing userland,
our /proc/bus/pci/XX numbers don't show  the domain number (at
least on ppc32) since we renumber busses to not overlap. I will
change that in the 2.7 timeframe. So I need to actually open all
devices and ask for their domain number with the PCIIOC_CONTROLLER,

This overall makes the mecanism a bit fragile & non trivial imho,
it would be nice to have a simple way to go straight to the bus
mappings given the pci_dev (without having to even bothing "finding"
the host bridge) either with additional ioctl's or just by allowing
the "low IOs" mapping.

What do you think ?

Ben.


