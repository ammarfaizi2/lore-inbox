Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVD1HXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVD1HXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVD1HXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:23:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:58337 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261901AbVD1HWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:22:40 -0400
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, bjorn.helgaas@hp.com,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <20050427235056.0bd09a94.davem@davemloft.net>
References: <1114493609.7183.55.camel@gaston>
	 <20050426163042.GE2612@colo.lackof.org> <1114555655.7183.81.camel@gaston>
	 <1114643616.7183.183.camel@gaston> <20050428053311.GH21784@colo.lackof.org>
	 <20050427223702.21051afc.davem@davemloft.net>
	 <1114670353.7182.246.camel@gaston>
	 <20050427235056.0bd09a94.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 17:21:19 +1000
Message-Id: <1114672880.7111.254.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes.
> 
> > Except from that page alignment thing ... which is the root of the
> > problem.
> 
> You can hide all of those problems in libpci.a or whatever.
> You page align the offset, but pass back to the user a pointer
> with his sub-page offset applied to it.
>
> The kernel wants pages, so just give it pages :-)

Oh, yes, I agree, but I don't want libpci to contain too much arch
specific code, so we must may sure that libpci has the mean of "knowing"
how to deal with that. When you mmap "resource0", you can't know that
there is an alignement/offset issue and that what you'll be getting is
actually not pointing to your actual resource but somewhere ... below.

In order to know that, libpci need to know the actual physical pointer
that was used by the kernel for the mmap before the page alignment so it
can figure out what offset to apply. So that is why I'm saying that
whatever we expose in "resources" and/or "/proc/bus/pci/devices" should
at be a CPU physical address, or at least contain the low PAGE_SHIFT
bits of it... even if the rest is a token...

> > Cleaning X.org is my goal, this is why I'm trying to clean the kernel
> > side first :) I'm also working separately on the problem of VGA access
> > arbitration (We'll probably do a joint session with the desktop summit
> > an the kernel summit about those issue).
> 
> Yeah, that one is all about enabling VGA forwarding in the bridges.

Oh, not only that ... also playing ping pong when several cards are
there, tracking who is having the ownership, but also allowing the
driver who can disable legacy decodign on the card to inform the arbiter
so that card stop beeing bothered and can keep interrupts enabled at all
time without bothering etc.. etc.. etc.. that includes fixing the kernel
vga console to deal with an arbiter, some fbdev stuffs as well, and
more.. an finally adapting userland things like X to use it.

The actual arbiter core itself is easy. Making things play nice with it
is the difficult part. I'll come up with various solutions that I wnat
to experience with before KS/DS and will present my results there so we
can decide what to do.

> Taking out all of the resource garbage in the X server, and replacing
> it with properly synchronized calls in the kernel for mapping ROMs
> and changing the current VGA forwarding seems to be the way to go.

It is, and the X.org people do agree, provided there is no loss in
functionality.

> Some scsi controllers have prefetchable set in their normal
> register BARs.  The sym53c8xx does if I remember correctly.

Hrm... do we have to worry about somebody in userland mmap'ing it's
register via /sys/*pci and breaking because of that ? :) I have a real
net big performance improvement on X by doing that trick ... the sysfs
mmap API doesn't really provide a mean to do it explicitely from
userland (unlike the ioctl with the old proc api)

> Anyways, what I'm trying to say is that blinding turning prefetchable
> BAR into "don't set side effect bit in PTE" might not be so wise.

Well, I'm still trying to find a case that would break. I'm not doing
that for in-kernel mapping. Oh well, it's done anyway, I'll see what
reports I'm getting from it...

> I really think it's a userlevel decision.  That's where all the ioctl()
> garbage came from for the /proc/bus/pci mmap() stuff.  It was for chossing
> IO vs MEM space, and also for setting these kinds of mapping attributes.

I know. I just don't see how to replace it with sysfs ... maybe mmap
pgprot flags...

Ben.


