Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSFNSFs>; Fri, 14 Jun 2002 14:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSFNSFs>; Fri, 14 Jun 2002 14:05:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3342 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313070AbSFNSFq>; Fri, 14 Jun 2002 14:05:46 -0400
Date: Fri, 14 Jun 2002 11:05:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Peter Osterlund <petero2@telia.com>, Patrick Mochel <mochel@osdl.org>,
        Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <20020614195337.A2623@ucw.cz>
Message-ID: <Pine.LNX.4.44.0206141057030.2576-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jun 2002, Vojtech Pavlik wrote:
>
> Could this be what has bitten us with new Intel IDE controllers on
> latest 2.5? They also were disabled due to 'resource collisions', and
> had some i/o not allocated at all - just size was nonzero. It was fixed
> in the quirks code by clearing the size fields, because the i/o space
> isn't needed ...

That's not this particular code - this code only handles PCMCIA.

But yes, it's the same issue: a resource that wasn't allocated by
the BIOS, and that the Linux boot sequence didn't bother to allocate
either. The PCI sequence _should_ allocate resources for non-PCMCIA
devices in pcibios_resource_survey(), where it does

	pcibios_assign_resources();

but the fact is, that that code is explicitly disabled for IDE
controllers. See pcibios_assign_resources() in arch/i386/pci/i386.c.

I suspect that forcing resource assignment into "pci_enable_device()"
should fix that too.

Although there should probably be some way for the driver to tell which
resources it cares about (some drivers care about the PCI ROM's, for
example, others don't. Some drivers don't care about the IO region, and
others don't care about the MEM region). So the _right_ answer might be to
pass in a bitmap to "pci_enable_device()", which tells the enable code
which parts the driver really cares about..

		Linus

