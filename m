Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265605AbRGCIjN>; Tue, 3 Jul 2001 04:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265611AbRGCIjD>; Tue, 3 Jul 2001 04:39:03 -0400
Received: from t2.redhat.com ([199.183.24.243]:5879 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265605AbRGCIiv>; Tue, 3 Jul 2001 04:38:51 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        David Howells <dhowells@redhat.com>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Message from Jeff Garzik <jgarzik@mandrakesoft.com> 
   of "Mon, 02 Jul 2001 22:06:29 EDT." <3B4128A5.636ED850@mandrakesoft.com> 
Date: Tue, 03 Jul 2001 09:38:49 +0100
Message-ID: <3993.994149529@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> Alan Cox wrote:
> > 
> > > > >       You pass a single cookie to the readb code
> > > > >       Odd platforms decode it
> > > >
> > > > Last time I checked, ioremap didn't work for inb() and outb().
> > >
> > > It should :)
> > 
> > it doesnt need to.
> > 
> > pci_find_device returns the io address and can return a cookie, ditto
> > isapnp etc
> 
> Is the idea here to mitigate the amount of driver code changes, or
> something else?

A number of things:

 * It ought to be easier to deal with having a number of ways of accessing
   resources if you just had an ops table with each struct resource. This
   would allow the bus driver to provide each resource of each device on that
   bus with a set of operations for accessing registers within that resource,
   no matter what the actual mechanism for doing so. For example:

	* direct I/O port accesses
	* direct memory-mapped I/O accesses
	* address port/data port accesses (eg: pcnet32, PCI config, etc.)
	* hide sparse I/O port accesses (eg: non-adjacent 16550 registers)
	* small-window CPU->PCI bus mapping
	* emulation of I/O port range through memory window

   Note that any number of these things can exist on the same architecture, or
   even the same platform (the GEODE GX1 & SC1200 being excellent examples).

 * It should make drivers easier to write: they don't have to worry about
   whether a resource refers to memory or to I/O or to something more exotic.

 * It makes some drivers more flexible. For example, the ne2k-pci driver has
   to be set at _compile_ time to use _either_ I/O ports _or_ memory. It'd
   make Linux installation more better if _both_ were supported.

 * It'd allow some drivers to be massively cleaned up (serial.c).

 * Permit transparent byte-swapping.

There are some other minor benefits too, but they're far less important (such
as I/O access tracing).

> If you are sticking a cookie in there behind the scenes, why go ahead
> and use ioremap?
> 
> We -already- have a system which does remapping and returns cookies and
> such for PCI mem regions.  Why not use it for I/O regions too?

You can't remap I/O ports into memory space on the i386. You can't easily
remap PCI devices if the all PCI devices peer through a small sliding window
in the CPU address space.

David
