Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265364AbRGGSPV>; Sat, 7 Jul 2001 14:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266525AbRGGSPL>; Sat, 7 Jul 2001 14:15:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:43282 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265364AbRGGSPD>; Sat, 7 Jul 2001 14:15:03 -0400
Date: Sat, 7 Jul 2001 11:13:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>, <dhinds@zen.stanford.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Memory region check in drivers/pcmcia/rsrc_mgr.c
In-Reply-To: <15174.62880.772230.734585@tango.paulus.ozlabs.org>
Message-ID: <Pine.LNX.4.33.0107071103070.31249-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jul 2001, Paul Mackerras wrote:
>
> The patch below does this (and makes a similar correction for I/O
> space).  With this patch applied, the pcmcia stuff works fine on my
> powerbook, and I end up with something like this in /proc/iomem:

This is wrong.

The reason it currently uses the rather fascist check_resource() is that
the thing needs a completely _unallocated_ region.

By changing it to use "check_region" instead of "check_resource()", you
allow the PCMCIA code to use an already allocated (but not in use) PCI
region. That is not what the code is meant to do - you might find that the
yenta code suddenly starts allocating the PCMCIA resources inside another
PCI device that just hasn't marked its resources busy yet.

This is, in fact, exactly what happens for you: it allocates the resources
inside your PCI bridge mappings. Which happens to be what you want in this
case, but it's not right in general.

> Linus, would you apply this patch to your tree?

I don't think so.

HOWEVER, you can change the resource checking to use the proper "parent
resource" instead of using the root resource. I absolutely agree that
using the root resource is wrong per se - it depends (incorrectly) on the
fact that on all laptops the PCMCIA controller tends to be on the root
bus.

Note that the CardBus side gets this all right - I assume that a 32-bit
CardBus card with a PCI driver should work on your powerbook even without
this patch, no?

It's only the old-style PCMCIA resource management that is fairly broken.
It may be that you rpatch might be an acceptable band-aid, but I really
think that the problem should be solved differently.

		Linus

