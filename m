Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbREEFdh>; Sat, 5 May 2001 01:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbREEFd1>; Sat, 5 May 2001 01:33:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6769 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129282AbREEFdR>; Sat, 5 May 2001 01:33:17 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Edward Spidre <beamz_owl@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <Pine.LNX.4.21.0105041040340.521-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 May 2001 23:30:30 -0600
In-Reply-To: Linus Torvalds's message of "Fri, 4 May 2001 10:44:00 -0700 (PDT)"
Message-ID: <m1y9scmkg9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 4 May 2001, Eric W. Biederman wrote:
> > 
> > There are a couple of options here.
> > 1) read the MTRRs unless the BIOS is braindead it will set up that area as
> >    write-back.  At any rate we shouldn't ever try to allocate a pci region
> >    that is write-back cached.
> 
> This one I'd really hesitate to use. We do _not_ want to trust the BIOS
> any more than necessary (obviously trusting even the e820 was too much),
> and especially wrt MTRR's we know that there are too many buggy bioses
> already out there.

O.k.  I was simply thinking that if we weren't reprogramming the mtrrs, it
would be a good idea to make certain we didn't map any PCI drivers
into a write back area. 
 
> > 2) read the memory locations from the northbridge.  It's not possible
> >    on every chipset (lack of documentation) but with the linuxBIOS
> >    project we code for a couple of them, and we are working on more
> >    all of the time.
> 
> This will be easy.

O.k.  If it easy.  

Currently I can find information for some via chipsets.  One
serverworks chipset, practically every intel chipset, the AMD 750
& 760 chipsets, current SIS chipsets, and the alpha tsunami chipset.
There is probably more that is just what I have actually seen.

There are complications of memory reserved for AGP, and memory
holes.  But they shouldn't be too bad.

My only problem is I don't have the bandwidth to code it up at the
moment, but if it's the kind of patch that if done well you are
likely to accept I'll look at it.  

Since it is only likely to be 30-40 lines per chipset it should
only take an hour or two per chipset.  And after the first couple are
in the kernel others can clone the work. 

This has the nice side effect that once we know where the ram is on a
chipset we can reprogram the MTRRs correctly ourselves, correcting bad
BIOS's.

> In fact, we can easily "mix" different heuristics. Ie we'd do the simple
> thing I suggested in setup_arch(), and use that as a "base guess", and
> then we can have incremental improvements on that guess that might be
> chipset-specific or might depend on other information that is not
> necessarily generic (things like existing PCI programming etc).

That sounds reasonable.  Since we don't always have all the
documentation we need heuristics so we can run on boards where we are
just guessing.

On the not trusting the BIOS, would you accept patches to do more
of the lowlevel setup?  

There is a pnp-os spec that basically says you should only need to
initialize devices necessary for booting.  With linuxBIOS we are
working to take this to the extreme, and define devices necessary for
booting as:  RAM, the bootstrap CPU, the Flash ROM chip, and possibly
a serial port for debugging.  Currently I need to a little more setup
than this because of limitations in linux. 

The more of the lowlevel set we can get into linux, the less you need
to trust the BIOS and the less I need to code to get linuxBIOS up on
an individual motherboard.

Eric
