Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSFNSva>; Fri, 14 Jun 2002 14:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSFNSv3>; Fri, 14 Jun 2002 14:51:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60944 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313537AbSFNSv2>; Fri, 14 Jun 2002 14:51:28 -0400
Date: Fri, 14 Jun 2002 11:51:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Osterlund <petero2@telia.com>
cc: Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <m2r8j9af1x.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.44.0206141134210.872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 14 Jun 2002, Peter Osterlund wrote:
>
> OK, with the patch below I get a little further. The kernel no longer
> complains about resource collisions, bringing up eth0 works, but the
> network card is still not usable:
>
>         eth0: Transmit timed out, status ffffffff, CSR12 ffffffff, resetting...
>         eth0: Out-of-sync dirty pointer, 0 vs. 17.

Some part of your resource isn't mapped through the cardbus bridge. Either
because the bridge resources themselves were wrong, or because we didn't
enable the resouce after we allocated it (the latter is unlikely, as any
"pci_enable_dev()" will do that part).

> Yenta IRQ list 0a98, PCI irq10
> Socket status: 30000068
> Yenta IRQ list 0a98, PCI irq10
> Socket status: 30000006
> cs: cb_alloc(bus 1): vendor 0x13d1, device 0xab02
> Scanning bus 01
> Found 01:00 [13d1/ab02] 000200 00
> PCI: Calling quirk c01d56a0 for 01:00.0
> Fixups for bus 01
> PCI: Scanning for ghost devices on bus 1
> Unknown bridge resource 0: assuming transparent
> Unknown bridge resource 1: assuming transparent
> Unknown bridge resource 2: assuming transparent

This is the problem.

The PCI code thinks that the parent of the network device doesn't have
resources allocated, so it will allocate the resources from the parent of
the parent.

Which is wrong, since it means that it will try to allocate the PCI
resources from outside the window that the cardbus controller is
exporting. Resulting in the fffff stuff.

HOWEVER, I don't see why that happens. yenta_allocate_resources() should
have made absolutely certain that we have all the necessary bridge
resources clearly allocated. Can you add debug code to the end of
"yenta_allocate_res()" that prints out the resource that got allocated?

Pat?

		Linus


