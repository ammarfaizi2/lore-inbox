Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130475AbRCDSMt>; Sun, 4 Mar 2001 13:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130480AbRCDSMk>; Sun, 4 Mar 2001 13:12:40 -0500
Received: from hermes.cs.kuleuven.ac.be ([134.58.40.3]:37550 "EHLO
	hermes.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S130475AbRCDSMV>; Sun, 4 Mar 2001 13:12:21 -0500
Date: Sat, 3 Mar 2001 16:07:13 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Grant Grundler <grundler@cup.hp.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, "David S. Miller" <davem@redhat.com>
Subject: Re: IO issues vs. multiple busses 
In-Reply-To: <19350125201706.1788@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10103031601260.455-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2001, Benjamin Herrenschmidt wrote:
> With those two simple functions, we could at least
> 
>  - Have vgacon disable itself when there's no ISA memory (that can be
                                                ^^^^^^^^^^
> handled by
>    reserving the region and thus preventing request_region from working
                                              ^^^^^^^^^^^^^^
Do you mean request_mem_region()?

> too, well,
>    but that scheme would also simplify the various more/less hacked
> macros used
>    on all non-x86 archs to access the VGA memory).

request_mem_region() for ISA memory is another problem point. The few drivers
that use it seem to assume that the ISA memory base is 0. This won't work on
non-PC machines, since ISA memory may be somewhere else in the address space,
and more important, there already may be something different at address 0,
which breaks request_mem_region(). On a PC the first 16 MB of RAM (with some
holes at e.g. 0xa0000) overlap with ISA memory space, but not on other
architectures.

For ioremap() we have a hack on PPC (PReP/CHRP) that adds isa_mem_base if the
bus address to map falls in the first 16 MB area, but this cannot work for
request_mem_region(). I do have my full memory map (RAM) marked in /proc/iomem.

So once again I vote for the introduction of
isa_{request,release}_mem_region(), just like we already have isa_readb() and
friends.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

