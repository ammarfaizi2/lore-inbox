Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUIOQdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUIOQdR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 12:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUIOQbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 12:31:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:57234 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266725AbUIOQar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 12:30:47 -0400
Date: Wed, 15 Sep 2004 09:30:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Being more anal about iospace accesses..
In-Reply-To: <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a background mail mainly for driver writers and/or architecture
people. Or others that are just interested in really low-level hw access
details. Others - please feel free to ignore.

[ This has been discussed to some degree already on the architecture 
  mailing lists and obviously among the people who actually worked on it, 
  but I thought I'd bounce it off linux-kernel too, in order to make
  people more aware of what the new type-checking does. Most people may
  have seen it as only generating a ton of new warnings for some crufty
  device drivers. ]

The background for this iospace type-checking change is that we've long
had some serious confusion about how to access PCI memory mapped IO
(MMIO), mainly because on a PC (and some non-PC's too) that IO really does 
look like regular memory, so you can have a driver that just accesses a 
pointer directly, and it will actually work on most machines.

At the same time, we've had the proper "accessor" functions (read[bwl](), 
write[bwl]() and friends) that on purpose dropped all type information 
from the MMIO pointer, mostly just because of historical reasons, and as a 
result some drivers didn't use a pointer at all, but some kind of integer. 
Sometimes even one that couldn't _fit_ a MMIO address in it on a 64-bit 
machine.

In short, the PCI MMIO access case was largely the same as the user
pointer case, except the access functions were different (readb vs
get_user) and they were even less lax about checking for sanity. At least
the user access code required a pointer with the right size.

We've been very successful in annotating user pointers, and that found a
couple of bugs, and more importantly it made the kernel code much more
"aware" of what kind of pointer was passed around. In general, a big
success, I think. And an obvious example for what MMIO pointers should do.

So lately, the kernel infrastructure for MMIO accesses has become a _lot_
more strict about what it accepts. Not only do the MMIO access functions
want a real pointer (which is already more type-checking than we did
before, and causes gcc to spew out lots of warnings for some drivers), but 
as with user pointers, sparse annotations mark them as being in a 
different address space, and building the kernel with checking on will 
warn about mixing up address spaces. So far so good.

So right now the current snapshots (and 2.6.9-rc2) have this enabled, and
some drivers will be _very_ noisy when compiled. Most of the regular ones
are fine, so maybe people haven't even noticed it that much, but some of
them were using things like "u32" to store MMIO pointers, and are
generally extremely broken on anything but an x86.  We'll hopefully get
around to fixing them up eventually, but in the meantime this should at 
least explain the background for some of the new noise people may see.

Perhaps even more interesting is _another_ case of driver, though: one
that started warning not because it was ugly and broken, but because it
did something fairly rare but something that does happen occasionally: it
mixed PIO and MMIO accesses on purpose, because it drove hardware that
literally uses one or the other.

Sometimes such a "mixed interface" driver does it based on a compile
option that just #defines 'writel()' to 'inl()', sometimes it's a runtime
decision depending on the hardware or configuration. 

The anal typechecking obviously ended up being very unhappy about this, 
since it wants "void __iomem *" for MMIO pointers, and a normal "unsigned 
long" for PIO accesses. The compile-time option could have been easily 
fixed up by adding the proper cast when re-defining the IO accessor, but 
that doesn't work for the dynamic case.

Also, the compile-time switchers often really _wanted_ to be dynamic, but
it was just too painful with the regular Linux IO interfaces to duplicate 
the code and do things conditionally one way or the other.

To make a long story even longer: rather than scrapping the typechecking,
or requiring drivers to do strange and nasty casts all over the place,
there's now a new interface in town. It's called "iomap", because it
extends the old "ioremap()" interface to work on the PIO accesses too.

That way, the drivers that really want to mix both PIO and MMIO accesses
can very naturally do it: they just need to remap the PIO space too, the
same way that we've required people to remap the MMIO space for a long
long time.

For example, if you don't know (or, more importantly - don't care) what 
kind of IO interface you use, you can now do something like

	void __iomem * map = pci_iomap(dev, bar, maxbytes);
	...
	status = ioread32(map + DRIVER_STATUS_OFFSET);

and it will do the proper IO mapping for the named PCI BAR for that
device. Regardless of whether the BAR was an IO or MEM mapping. Very
convenient for cases where the hardware migt expose its IO window in
either (or sometimes both).

Nothing in the current tree actually uses this new interface, although
Jeff has patches for SATA for testing (and they clean up the code quite
noticeably, never mind getting rid of the warnings).  The interface has
been implemented by yours truly for x86 and ppc64, and David did a
first-pass version for sparc64 too (missing the "xxxx_rep()" functions
that were added a bit later, I believe).

So far experience seems to show that it's a very natural interface for
most non-x86 hardware - they all tend to map in both PIO and MMIO into one
address space _anyway_, so the two aren't really any different. It's
mainly just x86 and it's ilk that actually have two different interfaces
for the two kinds of PCI accesses, and at least in that case it's trivial
to encode the difference in the virtual ioremap pointer.

The best way to explain the interface is to just point you guys at the
<asm-generic/iomap.h> file, which isn't very big, has about as much
comments than code, and contains nothing but the necessary function
declarations. The actual meaning of the functions should be pretty
obvious even without the comments.

Feel free to flame or discuss rationally,

		Linus
