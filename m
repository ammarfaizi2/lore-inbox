Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292815AbSCMI6B>; Wed, 13 Mar 2002 03:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292840AbSCMI5w>; Wed, 13 Mar 2002 03:57:52 -0500
Received: from mail.sonytel.be ([193.74.243.200]:6569 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S292815AbSCMI5m>;
	Wed, 13 Mar 2002 03:57:42 -0500
Date: Wed, 13 Mar 2002 09:56:57 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] soft accels.
In-Reply-To: <Pine.LNX.4.10.10203121439340.14022-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0203130954160.17582-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, James Simmons wrote:
> > > This code provides software accels to replace all the fbcon-cfb* stuff.
> > > Gradually the fbdev drivers can be ported over to it. It is against
> > > 2.5.5-dj3. Please apply the patch.
> > 
> > I'm still wondering whether it's a good idea to assume all color values (e.g.
> > fb_fillrect.color) are palette indices. This means you cannot draw a rectangle
> > with an arbitrary color using cfb_fillrect().
> 
> Would we ever want to do that? Also using the color map regno is to a
> advantage for non packed pixel modes. 
>  
> > Furthermore this means that fillrect() and imageblit() (the color image case)
> > expect different formats: the former expects a palette index, the latter
> > expects the native frame buffer format (cfr. your comments in the code below).
> 
> I need to change that. I want to have the image blit function use the
> color palette. The most we will ever use is 256 colors for the penguin.
> Do we need to expand that more?  

I don't know. I'm just thinking about one day we want to do more with it in the
kernel.

> > The 17-entry (16 colors + 1 XOR mask) pseudo palette is actually something
> > related to the console, so I would not handle it in the low level drawing
> > routines, but in the frame buffer console layer. Of course the pseudo palette
> > still has to be initialized by the frame buffer device, since that is the part
> > that knows about the mapping from console palette indices to native pixel
> > values. This also means you'll have a pseudo palette for all modes, including
> > pseudocolor[*].
> > 
> > What do you think?
> 
> Hm. True pseudopalette is more a console thing. One of the reasons I made
> pseudo_palette a void was so anything type of data could be indexed to a
> color map regno. It really should be in a par struct for each driver.
> Personally I don't care for it and like to see it go away. Instead we
> could generate the color value from the fb_bitfields in struct
> fb_var_screeninfo and the red, green, blue etc from struct fb_cmap. The
> only thing preventing me from doing this is that it cost to generate those
> vlaues whereas we have the values already saved in pseudo_palette. The
> penalty tho only shows up when we draw each character.     

Or you can precalculate them on each mode change and fill some tables. This is
what I do in fbtest, to make things as generic as possible, without a too high
speed penalty.

> > [*] Or set pseudo_palette to NULL, and use
> > 
> >       pixval = pseudo_palette ? pseudo_palette[idx] : idx;
> >       
> >     and
> > 
> >       xormask = pseudo_palette ? pseudo_palette[16] : 15;
> 
> When we change from truecolor mode to pseudo color wouldn't we have to
> NULL the pseudo_palette pointer then?

Yes.

> > Color images are not yet implemented?
> 
> Not yet. I wanted to have font support first.  

OK.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

