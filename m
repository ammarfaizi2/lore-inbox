Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291333AbSCMAbi>; Tue, 12 Mar 2002 19:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291340AbSCMAb3>; Tue, 12 Mar 2002 19:31:29 -0500
Received: from www.transvirtual.com ([206.14.214.140]:40722 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S291333AbSCMAbO>; Tue, 12 Mar 2002 19:31:14 -0500
Date: Tue, 12 Mar 2002 16:30:46 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] soft accels.
In-Reply-To: <Pine.GSO.4.21.0203121020400.23527-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10203121439340.14022-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This code provides software accels to replace all the fbcon-cfb* stuff.
> > Gradually the fbdev drivers can be ported over to it. It is against
> > 2.5.5-dj3. Please apply the patch.
> 
> I'm still wondering whether it's a good idea to assume all color values (e.g.
> fb_fillrect.color) are palette indices. This means you cannot draw a rectangle
> with an arbitrary color using cfb_fillrect().

Would we ever want to do that? Also using the color map regno is to a
advantage for non packed pixel modes. 
 
> Furthermore this means that fillrect() and imageblit() (the color image case)
> expect different formats: the former expects a palette index, the latter
> expects the native frame buffer format (cfr. your comments in the code below).

I need to change that. I want to have the image blit function use the
color palette. The most we will ever use is 256 colors for the penguin.
Do we need to expand that more?  

> The 17-entry (16 colors + 1 XOR mask) pseudo palette is actually something
> related to the console, so I would not handle it in the low level drawing
> routines, but in the frame buffer console layer. Of course the pseudo palette
> still has to be initialized by the frame buffer device, since that is the part
> that knows about the mapping from console palette indices to native pixel
> values. This also means you'll have a pseudo palette for all modes, including
> pseudocolor[*].
> 
> What do you think?

Hm. True pseudopalette is more a console thing. One of the reasons I made
pseudo_palette a void was so anything type of data could be indexed to a
color map regno. It really should be in a par struct for each driver.
Personally I don't care for it and like to see it go away. Instead we
could generate the color value from the fb_bitfields in struct
fb_var_screeninfo and the red, green, blue etc from struct fb_cmap. The
only thing preventing me from doing this is that it cost to generate those
vlaues whereas we have the values already saved in pseudo_palette. The
penalty tho only shows up when we draw each character.     

> [*] Or set pseudo_palette to NULL, and use
> 
>       pixval = pseudo_palette ? pseudo_palette[idx] : idx;
>       
>     and
> 
>       xormask = pseudo_palette ? pseudo_palette[16] : 15;

When we change from truecolor mode to pseudo color wouldn't we have to
NULL the pseudo_palette pointer then?

> Color images are not yet implemented?

Not yet. I wanted to have font support first.  

