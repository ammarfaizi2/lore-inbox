Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313045AbSDJNDU>; Wed, 10 Apr 2002 09:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313047AbSDJNDT>; Wed, 10 Apr 2002 09:03:19 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:60935 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S313045AbSDJNDS>; Wed, 10 Apr 2002 09:03:18 -0400
Date: Wed, 10 Apr 2002 14:03:15 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radeon frame buffer driver
Message-ID: <20020410130315.GA1372@berserk.demon.co.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020410101913.GA975@berserk.demon.co.uk> <Pine.GSO.4.21.0204101305210.24941-100000@trillium.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 01:06:09PM +0200, Geert Uytterhoeven wrote:
> On Wed, 10 Apr 2002, Peter Horton wrote:
> > 
> > The colour map is only used by the kernel and the kernel only uses 16
> > entries so there isn't any reason to waste memory by making it any
> > larger. I checked a few other drivers and they do the same (aty128fb for
> > one).
> 
> However, this change will make the driver not save/restore all color map
> entries on VC switch in graphics mode.
> 

Well I thought this didn't matter because if we only use 16 entries they
will all be saved / restored. But there is a problem because the copy of
the entire palette that we keep is per card and will be lost on VC
switch, though the kernel will restore the first 16 entries.  Really we
need to keep a copy of the relevant part of the palette for each display
(256 for 8bpp, 32 for 15 bit mode, 64 for 16bpp and 256 for 32bpp).
Looking at a handful of drivers this seems to be a common error, so it
can't be causing users much grief. I don't think changing the size of
the colour map fixes this though (I need to look at the code when I get
home).

On a side note would you take a patch that changed the cursor xor value
in fbcon-cfb16/24/32 to the correct value if the display is DIRECTCOLOR
rather than TRUECOLOR? We could then avoid having to set spurious
palette indices to make the soft cursor work. I note that fbcon-cfb8
does the right thing.

I think the correct xor values are

	depth 15	0x3DEF
	depth 16	0x79EF
	depth 24/32	0x000F0F0F

P.
