Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUBTHkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUBTHkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:40:51 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:924 "EHLO fed1mtao08.cox.net")
	by vger.kernel.org with ESMTP id S267703AbUBTHkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:40:49 -0500
Date: Fri, 20 Feb 2004 00:40:41 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB update for 2.6.3
Message-ID: <20040220074041.GA6680@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040220012802.GA16523@kroah.com> <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org> <1077256996.20789.1091.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077256996.20789.1091.camel@gaston>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 20 2004, at 17:03, Benjamin Herrenschmidt was caught saying:
> On Fri, 2004-02-20 at 16:58, Linus Torvalds wrote:
> > On Thu, 19 Feb 2004, Greg KH wrote:
> > > 
> > > Here are some USB patches for 2.6.3.  Here are the main types of changes:
> > > 	- switch usb code to use dmapools instead of pcipools which
> > > 	  makes the embedded people happy.
> > 
> > However, this makes the ppc64 people very unhappy.
> > 
> > I've just yesterday and today switched my main home machine to be ppc64, 
> > and this will not compile for me. Bad boy!
> > 
> > (And I haven't used ppc64 enough to be able to make sense of the DMA 
> > setup, so I can't even fix it myself yet. Aaarghh!)
> 
> Hehe ;)
> 
> Well, last I heard, people here were trying to make that work, but
> still, our dma mapping API will probably want the device passed in
> to be a pci_dev...
> 
> The problem with the generic API is that it makes it difficult
> for us to actually go back to the PCI device hosting the USB
> device we get passed in... Which we what we want (our IO MMU
> setup is based on what PCI device is there, for PCI at least,
> for VIO, it's a bit different, but the idea is the same).

Why can't you just do the following to  get to the PCI device?

if (dev->bus_type == &pci_bus_type) {
	struct pci_dev pci_usb_dev = to_pci_dev(dev);
	...
}

If you mean the USB target device itself, can't you walk the
tree until you find a device that is no longer on bus_type
usb to determine your root?

> A while ago, I've advertised making this API a set of function
> pointers attached to the struct device inherited from the bus
> parent, so the core code just set one for the root PCIs and
> everybody inherits them.... But of course, since x86 isn't
> affected, nobody cared ;)

You could stuff that into platform_data on PCI devices on your platforms.

> I think the "generic" DMA API is just not suitable at the moment
> to be really used. It gets passed "generic" struct device, which,
> due to the way Pat designed it, are almost useless alone (we
> can't quite match them to anything and don't have any kind of
> "inheritance" of methods via function pointers). There is no
> simple hook for archs to carry informations attached to struct
> devices neither, etc...

I think we're not quite there yet, but once you have the device
struct, in theory, you can walk up the tree to grab the platform_data
for say the device's parent and do any tweaks based on platform-specific
bus parameters.  With PCI, you could even stuff this into pci_bus->sysdata.

I think having a function pointer table for things like dma mapping
and ioremap on all devices would be a very good thing, but not sure
if the powers that be would allow that in 2.6.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
