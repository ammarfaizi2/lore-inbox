Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129840AbRCATuX>; Thu, 1 Mar 2001 14:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129845AbRCATuO>; Thu, 1 Mar 2001 14:50:14 -0500
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:58504 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129840AbRCATuE>; Thu, 1 Mar 2001 14:50:04 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The IO problem on multiple PCI busses
Date: Thu, 1 Mar 2001 20:49:41 +0100
Message-Id: <19350124132125.27547@smtp.wanadoo.fr>
In-Reply-To: <15006.40524.929644.25622@pizda.ninka.net>
In-Reply-To: <15006.40524.929644.25622@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm, of course open to any comments about this (in fact, I'd really like
> > some feedback). One thing is that we also need to find a way to pass
> > those infos to userland. Currently, we implement an arch-specific syscall
> > that allow to retreive the IO physical base of a given PCI bus. That may
> > be enough, but we may also want something that match more closely what we
> > do in the kernel.
>
>Same problem on sparc64.  Using a special PCI syscall is fine, _if_ we
>all end up using the same one.  However, I would prefer another
>mechanism...

Right, I remember we discussed this some monthes ago. Currently, we have
a syscall that is slightly different from the sparc/alpha ones but very
similar.

>I think a cleaner scheme is to allow mmap() on
>/proc/bus/pci/${BUS}/${DEVICE} nodes, that is much cleaner and solves
>transparently any "different word size between userland and kernel"
>issues (specifically 32-bit userlands executing on 64-bit kernels).
>
>I played around with something akin to this, and some of the necessary
>Xfree86-4.0.x hackery needed, some time ago.  But I never finished
>this.

I do agree with you on this. I didn't have time to really work on it so
far, I remember you posted a test patch but I was busy at that time with
other PCI issues we had with multiple bus systems.

Note that this is only the userland side of the story. For now, I'm more
concerned about finding a good solution to the kernel side.

Also, the problem of finding where the legacy ISA IOs of a given PCI bus
are is a bit different that simply mmap'ing a BAR. Some video cards
require some access to their VGA IOs without having a BAR covering them,
in some case it's necessary to switch the chip from VGA to MMIO mode.

I've looked at the parisc code (thanks Alan for pointing that out), and
it seem they implement all inb/outb as quite big functions that decypher
the address, retreive the bus, and do the proper IO call. Unfortunately,
that's a bit bloated, and I don't think I'll ever get other PPC
maintainers to agree with such a mecanism (everybody seem to be quite
concerned with IO speed, I admit including me).

Also, that wouldn't really help the case of legacy drivers or video
drivers using legacy addresses for VGA. In all cases, whatever solution
we end up having, those will have to be adapted. What I'd like is a
smooth path that allow unchanged drivers to still work with the default
bus, while adapted driver can be done so with minimum changes (mostly
ending up storing an io base and creating a virtual "ISA bus number"). 

That way, an ISA-like (legacy IO bus) can be mapped to either a PCI bus,
or whatever. Maybe "ISA" is not a proper word for it, it could be
"basic_io_bus" maybe.

Alan also pointed out that there may be similar issues with MMIOs. In
fact, as long as we are working with PCI devices, we can easily get
things fixed up by munging the resource structures at fixup time. The
_is_ however a similar issue with legacy ISA memory, especially since
some platform can simply not let you access it.

Looking at those in more details (other archs), it appears that the
problem happens on most non-x86 archs and is handled differently for each
of them, when it's handled at all.

So what would be a preferred way ? Create that fake ISA bus number and
provide functions for looking them up, getting their IO and mem bases,
and eventually mapping PCI busses to ISA busses ? Or does someone have a
better idea ? The goal is to try not to change the semantics of inb/outb
and friends so that most legacy drivers can still work using the
"default" IO bus if they are not upgraded to the new scheme.

Thanks for your feedback,

Regards, 
Ben.
