Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312532AbSDJNPA>; Wed, 10 Apr 2002 09:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSDJNO7>; Wed, 10 Apr 2002 09:14:59 -0400
Received: from mail.sonytel.be ([193.74.243.200]:46740 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S312532AbSDJNO6>;
	Wed, 10 Apr 2002 09:14:58 -0400
Date: Wed, 10 Apr 2002 15:14:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Radeon frame buffer driver
In-Reply-To: <20020410130315.GA1372@berserk.demon.co.uk>
Message-ID: <Pine.GSO.4.21.0204101509290.9914-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Peter Horton wrote:
> On Wed, Apr 10, 2002 at 01:06:09PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 10 Apr 2002, Peter Horton wrote:
> > > 
> > > The colour map is only used by the kernel and the kernel only uses 16
> > > entries so there isn't any reason to waste memory by making it any
> > > larger. I checked a few other drivers and they do the same (aty128fb for
> > > one).
> > 
> > However, this change will make the driver not save/restore all color map
> > entries on VC switch in graphics mode.
> 
> Well I thought this didn't matter because if we only use 16 entries they
> will all be saved / restored. But there is a problem because the copy of
> the entire palette that we keep is per card and will be lost on VC
> switch, though the kernel will restore the first 16 entries.  Really we
> need to keep a copy of the relevant part of the palette for each display
> (256 for 8bpp, 32 for 15 bit mode, 64 for 16bpp and 256 for 32bpp).
> Looking at a handful of drivers this seems to be a common error, so it
> can't be causing users much grief. I don't think changing the size of
> the colour map fixes this though (I need to look at the code when I get
> home).

Or: few fbdev applications expect a correct behavior.
IIRC XF68_FBDev also saves/restores the palette itself.

> On a side note would you take a patch that changed the cursor xor value
> in fbcon-cfb16/24/32 to the correct value if the display is DIRECTCOLOR
> rather than TRUECOLOR? We could then avoid having to set spurious
> 
> I think the correct xor values are
> 
> 	depth 15	0x3DEF
> 	depth 16	0x79EF
> 	depth 24/32	0x000F0F0F
> 
> P.

In general, this is not correct, since no one guarantees that in e.g. depth 32
the alpha bits are in the 8 most significant bits of the pixel value.
But in directcolor mode XORing with the 16th entry of the pseudo palette should
be OK. So yes, I guess we (cfr. the CC to linux-fbdev-devel) would take a
patch for that...

That's why for 2.5.x we plan to add a 17th entry to the pseudo palette, so the
fbdev can specify the correct XOR value.

> palette indices to make the soft cursor work. I note that fbcon-cfb8
> does the right thing.

Yes, but fbcon-cfb8 does the right thing for pseudocolor modes only :-( There
does exist non-pseudocolor depth 8 hardware (e.g. RGB332).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

