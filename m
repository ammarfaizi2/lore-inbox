Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310527AbSCLJjc>; Tue, 12 Mar 2002 04:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310532AbSCLJjW>; Tue, 12 Mar 2002 04:39:22 -0500
Received: from mail.sonytel.be ([193.74.243.200]:25569 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S310527AbSCLJjE>;
	Tue, 12 Mar 2002 04:39:04 -0500
Date: Tue, 12 Mar 2002 10:38:30 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@transvirtual.com>
cc: Dave Jones <davej@suse.de>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] soft accels.
In-Reply-To: <Pine.LNX.4.10.10203111620340.32670-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0203121020400.23527-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, James Simmons wrote:
> This code provides software accels to replace all the fbcon-cfb* stuff.
> Gradually the fbdev drivers can be ported over to it. It is against
> 2.5.5-dj3. Please apply the patch.

I'm still wondering whether it's a good idea to assume all color values (e.g.
fb_fillrect.color) are palette indices. This means you cannot draw a rectangle
with an arbitrary color using cfb_fillrect().

Furthermore this means that fillrect() and imageblit() (the color image case)
expect different formats: the former expects a palette index, the latter
expects the native frame buffer format (cfr. your comments in the code below).

The 17-entry (16 colors + 1 XOR mask) pseudo palette is actually something
related to the console, so I would not handle it in the low level drawing
routines, but in the frame buffer console layer. Of course the pseudo palette
still has to be initialized by the frame buffer device, since that is the part
that knows about the mapping from console palette indices to native pixel
values. This also means you'll have a pseudo palette for all modes, including
pseudocolor[*].

What do you think?

[*] Or set pseudo_palette to NULL, and use

      pixval = pseudo_palette ? pseudo_palette[idx] : idx;
      
    and

      xormask = pseudo_palette ? pseudo_palette[16] : 15;

> diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj3/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
> --- linux-2.5.5-dj3/drivers/video/cfbimgblt.c	Wed Dec 31 16:00:00 1969
> +++ linux/drivers/video/cfbimgblt.c	Mon Mar 11 14:29:37 2002

  [...]

> + *    This function copys a image from system memory to video memory. The
> + *  image can be a bitmap where each 0 represents the background color and
> + *  each 1 represents the foreground color. Great for font handling. It can
> + *  also be a color image. This is determined by image_depth. The color image
> + *  must be laid out exactly in the same format as the framebuffer. Yes I know
> + *  their are cards with hardware that coverts images of various depths to the
> + *  framebuffer depth. But not every card has this. All images must be rounded
> + *  up to the nearest byte. For example a bitmap 12 bits wide must be two 
> + *  bytes width. 

Color images are not yet implemented?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

