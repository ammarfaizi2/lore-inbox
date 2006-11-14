Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755389AbWKNCAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbWKNCAt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304AbWKNCAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:00:49 -0500
Received: from gate.crashing.org ([63.228.1.57]:65001 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1752863AbWKNCAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:00:48 -0500
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org,
       airlied@gmail.com, idr@us.ibm.com, paulus@samba.org
In-Reply-To: <20061113.163138.98554015.davem@davemloft.net>
References: <1163405790.4982.289.camel@localhost.localdomain>
	 <20061113.163138.98554015.davem@davemloft.net>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 12:59:54 +1100
Message-Id: <1163469594.5940.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not on Sparc.  /dev/mem mmap()'s are basically verbotten on Sparc,
> period.
> 
> That's the whole reason I created /proc/bus/pci mmap().  So that
> X could simply read a BAR, open /proc/bus/pci/${DEVICE} and
> mmap() with some range within the BAR as the offset/size tuple.

Ok, well, that would be lovely if that API was followed by X for more
than just sparc :-) Basically, I started by fixing ppc to properly
accept BAR values in /proc/bus/pci/${DEVICE} and provide BAR values
in /proc/bus/pci/devices and that broke X.

The problem is that X expects a value in "devices" that it can pass
to /dev/mem :-( At least on ppc and other non-sparc platforms. Thus I
need to have /proc/bus/pci/devices provide "fixed" up values in
processor bus address space instead of BAR values, and what I provide in
that file is also what mmap expects as an offset for ${DEVICE} files,
thus I'm screwed... Unless I "disconnect" the two (possibly by passing
an argument to pci_resource_to_user() ...)

> If an application wants all of I/O space (to poke at VGA addresses for
> a domain, for example), it finds the root bridge for that domain and
> you can mmap()'s it's I/O space that way on platforms the implement
> I/O space via memory accesses.

Yeah, that's what X should do on ppc too, right now it doesn't. There's
Ian patches to completely overhaul X PCI that should fix all of that,
but in the meantime, I think I should look into turning all those ifdef
__sparc__ into if defined(__sparc__) || defined(__powerpc__) in X ! I'll
have a deeper look this week.

> The only thing X was (unfortunately) still using the "devices" file
> for is device existence, and this is obviously broken because there is
> zero domain information in that procfs file so it's impossible to use
> correctly. :-)

Yes, it's screwed when you start having domains. It also uses it to do
that horrible mmap trick I explained above. It basically takes a BAR
value, then reads the devices file entry for the device, and iterate the
BARs, reading them from the card to compare them to the value passed in,
and returning the base address in "devices" for use by mmap to /dev/mem.

> > X is still broken when built 32 bits on machines where PCI MMIO can be
> > above 32 bits space unfortunately. It looks like somebody (DaveM ?)
> > hacked a fix in X to handle long long resources and had the good idea
> > to wrap it in #ifdef __sparc__ :-(
> 
> Sorry, it was the only 32/64 platform at the time that old X code was
> written and the X maintainers at the time were unbelievably anal :-/

Yeah, I remember.

> So the gist of your change is that X isn't obtaining BAR values
> in the correct context on powerpc, and so you're going to hack up
> the "devices" files output to "help" X out.
>
> This doesn't sound sane to me.

Well, we've been hacking up the "devices" file for some time. I fact, it
seems like X code is written with the expectation that all archs do that
by providing a "fixed" value there, it seems to be the whole point of
the xf86GetPciOffsetFromOS() and xf86GetOSOffsetFromPCI() functions in
there. They do what I explained above, convering a BAR value into
something that can be passed to /dev/mem. This is broken, but this is
the only way to get X to work

If I "fix" the kernel to do the right thing, that is pass BAR values in
devices and expect BAR values in mmap, then I will break existing X
setups on machines where PCI is not mapped 1:1 (that is mostly CHRP
machines).

The problem I'm fixing in this patch is that while we were providing the
hacked up value in "devices", we were expecting the BAR value in mmap,
and there are apps expecting us to be consistent between the two, thus
the breakage.

> What sounds better to me is that X does the right thing, which is
> obtain the BAR from the PCI config space to determine what values to
> pass in to /proc/bus/pci mmap() calls.  And if it wants raw addresses
> to pass in to /dev/mem mmap()'s on platforms where that works (ie. not
> Sparc, to begin with) it should obtain those values from the "devices"
> file which must be values suitable as /dev/mem offsets.

Ok so you think I should stick to my old code that is passing "fixed"
values in "devices" and expect BAR values in mmap ? The problem if you
do that is that you break /sys then. Look at what pci-sysfs.c does:

         /* pci_mmap_page_range() expects the same kind of entry as coming
         * from /proc/bus/pci/ which is a "user visible" value. If this is
         * different from the resource itself, arch will do necessary fixup.
         */
        pci_resource_to_user(pdev, i, res, &start, &end);
        vma->vm_pgoff += start >> PAGE_SHIFT;

It calls pci_resource_to_user() which is the function used to display
the resouces both in /sys/*/resource and /proc/bus/pci/devices, and adds
that base to the offset before calling the arch pci_mmap_page_range()
function.

That function expects the same values as /proc/ mmap offsets. Thus that
means that /proc/ mmap offets haev to be the same as what
pci_resource_to_user() return which is also... waht is
in /proc/bus/pci/devices ! yuck !

The only way to actually get things right -and-
have /proc/bus/pci/devices expose "fixed up" values that can be used
with /dev/mem would be to add an argument to pci_resource_to_user() that
would be set differently depending on wether it's called by the /proc
code to populate "devices" or wether it's called by syfs to do the fixup
above.

> I strongly look forward to Ian's new X code, that is for sure :-)

Me too :-)

Cheers,
Ben.


