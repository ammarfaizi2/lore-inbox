Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267346AbUIEXuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267346AbUIEXuV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 19:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUIEXuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 19:50:21 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:41429 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267346AbUIEXuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 19:50:05 -0400
Message-ID: <9e473391040905165048798741@mail.gmail.com>
Date: Sun, 5 Sep 2004 19:50:04 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: multi-domain PCI and sysfs
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409041527.50136.jbarnes@engr.sgi.com>
	 <9e47339104090415451c1f454f@mail.gmail.com>
	 <200409041603.56324.jbarnes@engr.sgi.com>
	 <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So how do multiple root buses work? Since they are all in the same
domain it seems like a single IO operation would go to all of the root
bridges simultaneously. Then each root bridge matches to the address
and decides to send the IO operation on if there is a match.

Would the diagram be equivalent to having a single root bridge with
six transparent PCI bridges attached? The purpose of the six host
bridges is to let six PCI transactions happen in parallel, right?
Other that probing the PCI config space of the host bridges, is there
any way in software to know that there are six bridges, or is this
completely transparent?

When implementing the VGA control I'm running into the problem that
there is no root node in sysfs for the top of a domain. I need a
domain node to attach an attribute disabling all VGA devices in the
domain. In the zx1 diagram I could have vga devices on any of the
PCI-X or AGP buses.

With the xz1 sysfs would look like this:
/sys/devices/pci0000:00
/sys/devices/pci0000:01
/sys/devices/pci0000:02
/sys/devices/pci0000:03
/sys/devices/pci0000:04
/sys/devices/pci0000:05

would it make more sense if it looked like this?
/sys/devices/pci0000/00
/sys/devices/pci0000/01
/sys/devices/pci0000/02
/sys/devices/pci0000/03
/sys/devices/pci0000/04
/sys/devices/pci0000/05

Now I have a node for the top of the domain. I can make a vga
attribute like this:
/sys/devices/pci0000/vga
set it to zero and my code will disable all VGA devices in the domain.

My home system would switch from 
/sys/devices/pci0000:00
to
/sys/devices/pci0000/00

pp32 from
/sys/devices/pci0000:00
/sys/devices/pci0001:01
/sys/devices/pci0002:06
to
/sys/devices/pci0000/00
/sys/devices/pci0001/01
/sys/devices/pci0002/06

On Mon, 6 Sep 2004 00:04:25 +0100, Matthew Wilcox <willy@debian.org> wrote:
> 
> 
> On Sat, Sep 04, 2004 at 04:03:56PM -0700, Jesse Barnes wrote:
> > On Saturday, September 4, 2004 3:45 pm, Jon Smirl wrote:
> > > Is this a multipath configuration where pci0000:01 and pci0000:02 can
> > > both get to the same target bus? So both busses are top level busses?
> > >
> > > I'm trying to figure out where to stick the vga=0/1 attribute for
> > > disabling all the VGA devices in a domain. It's starting to look like
> > > there isn't a single node in sysfs that corresponds to a domain, in
> > > this case there are two for the same domain.
> >
> > Yes, I think that's the case.  Matthew would probably know for sure though.
> 
> Huh, eh, what?  There's no such thing as multipath PCI configurations.
> The important concepts in PCI are:
> 
>  - the function
>  - the device
>  - the bus
>  - the root bus
>  - the domain
>  - the machine
> 
> That is, a machine contains one or more PCI domains, each domain contains
> one or more root busses, each root bus may have bridges to a collection
> of other busses, each bus contains one or more devices, each device
> contains one or more functions.
> 
> Many people confuse the domain and the root bus.  HP has made many
> machines with multiple root busses in a single PCI domain, particularly
> in the PA-RISC line.  Frequently the topology of these machines looks
> like this: http://www.hp.com/products1/itanium/chipset/2-way_block.html
> 
> Each of the six chips labelled "hp zx1 I/O adapters" is a host to PCI
> bridge; thus this sample machine has 6 root busses.  Despite that, it's
> a single domain -- all the devices are numbered so as to not overlap.
> It's theoretically possible to communicate between devices under different
> I/O adapters, but this isn't a supported configuration.
> 
> HP's multiple domain machines (eg rx8620) look something like several
> of these tied together.  That's not really how it works, but that's a
> good way to imagine them.
> 
> I haven't really looked at the VGA attribute.  I think Ivan or Grant
> would be better equipped to help you on this front.  I remember them
> rehashing it 2-3 years ago.
> 
> --
> "Next the statesmen will invent cheap lies, putting the blame upon
> the nation that is attacked, and every man will be glad of those
> conscience-soothing falsities, and will diligently study them, and refuse
> to examine any refutations of them; and thus he will by and by convince
> himself that the war is just, and will thank God for the better sleep
> he enjoys after this process of grotesque self-deception." -- Mark Twain
> 



-- 
Jon Smirl
jonsmirl@gmail.com
