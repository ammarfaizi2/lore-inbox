Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbRCIVQy>; Fri, 9 Mar 2001 16:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130696AbRCIVQf>; Fri, 9 Mar 2001 16:16:35 -0500
Received: from front4.grolier.fr ([194.158.96.54]:26041 "EHLO
	front4.grolier.fr") by vger.kernel.org with ESMTP
	id <S130685AbRCIVQW> convert rfc822-to-8bit; Fri, 9 Mar 2001 16:16:22 -0500
Date: Fri, 9 Mar 2001 20:04:33 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: David Brownell <david-b@pacbell.net>
cc: Pete Zaitcev <zaitcev@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        "David S. Miller" <davem@redhat.com>,
        Russell King <rmk@arm.linux.org.uk>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch [RFC: API]
In-Reply-To: <069601c0a8d0$6091b680$6800000a@brownell.org>
Message-ID: <Pine.LNX.4.10.10103091943580.1564-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Mar 2001, David Brownell wrote:

> > > > > extern void *
> > > > > pci_pool_dma_to_cpu (struct pci_pool *pool, dma_addr_t handle);
> > > > 
> > > > Do lots of drivers need the reverse mapping? It wasn't on my todo list
> > > > yet.
> > > 
> > > Some hardware (like OHCI) talks to drivers using those dma handles.
> > 
> > I wonder if it may be feasible to allocate a bunch of contiguous
> > pages. Then, whenever the hardware returns a bus address, subtract
> > the remembered bus address of the zone start, add the offset to
> > the virtual and voila.
> 
> That's effectively what the implementation I posted is doing.
> 
> Simple math ... as soon as you get the right "logical page",
> and that page size could become a per-pool tunable.  Currently
> one logical page is PAGE_SIZE; there are some issues to
> deal with in terms of not crossing page boundaries.
> 
> There can be multiple such pages, known to the pool allocator
> and hidden from the device drivers.  I'd expect most USB host
> controllers wouldn't allocate more than one or two pages, so
> the cost of this function would typically be small.

Just for information to people that want to complexify the
pci_alloc_consistent() interface thats looks simple and elegant to me:
(Hopefully, I am not off topic here)

1) The sym53c8xx driver and friends expect this simple interface to 
   return naturally aligned memory chunks. It mostly allocates 1 page 
   at a time.

2) The sym* drivers use a very simple allocator that keeps track of bus 
   addresses for each chunk (page sized).
   The object file of the allocator as seen in sym2 is as tiny as 3.4K
   unstripped and 2.5K stripped.

3) The drivers need reverse virtual addresses for the DSA bus addresses
   and implements a simplistic hashed list that costs no more 
   than 10 lines of trivial C code.

Btw, as a result, if pci_alloc_consistent() will ever return not 
naturally aligned addresses the sym* drivers will be broken for 
Linux.

This leaves me very surprised by all this noise given the _no_ issue I
have seen using the pci_alloc_consistent() interface. It looked to me a
_lot_ more simple to use than the equivalent interfaces I have had to
suffer with other O/Ses.

Now, if modern programmers are expecting Java-like interfaces for writing
kernel software, it is indeed another story. :-)

  Gérard.

