Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263202AbVGaMGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbVGaMGr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 08:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263218AbVGaMGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 08:06:47 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37820 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263202AbVGaMGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 08:06:47 -0400
Date: Sun, 31 Jul 2005 14:06:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13-rc4] framebuffer: new
 driver for cyberblade/i1 core
In-Reply-To: <42ECBB4D.6020306@gmail.com>
Message-ID: <Pine.LNX.4.62.0507311404410.31575@numbat.sonytel.be>
References: <42ECA05F.40401@t-online.de> <42ECBB4D.6020306@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2005, Antonino A. Daplas wrote:
> Knut Petersen wrote:
> > +    //
> > +    // interlaced modes are broken, fail if one is requested
> > +    //
> > +    if (var->vmode & FB_VMODE_INTERLACED)
> > +        return -EINVAL;
> 
> You are too strict :-)  You can always clear FB_VMODE_INTERLACED and
> return success.  This is acceptable behavior.

I would not try to modify the passed FB_VMODE_* flags.

> > +    //
> > +    // fail if requested resolution is higher than physical
> > +    // flatpanel resolution
> > +    //
> > +    if (flatpanel && nativex && var->xres > nativex)
> > +        return -EINVAL;
> > +
> 
> This is acceptable behavior, but you can always return
> with var->xres = nativex.
> 
> > +    //
> > +    // xres != xres_virtual is broken, fail if such an
> > +    // unusual mode is requested
> > +    //
> > +    if (var->xres != var->xres_virtual)
> > +        return -EINVAL;
> 
> Same here, var->xres = var->xres_virtual.

Only when rounding _up_. Rounding down is not allowed.

> > +    // calc max yres_virtual that would fit in memory
> > +    // and max yres_virtual that could be used for scrolling
> > +    // and use minimum of the results as maxvyres
> > +    //
> > +    // adjust vyres_virtual to maxvyres if necessary
> > +    // fail if requested yres is bigger than maxvyres
> > +    //
> > +    s = (0x1fffff / (var->xres * bpp/8)) + var->yres;
> > +    t = info->fix.smem_len / (var->xres * bpp/8);
> > +    maxvyres = t < s ? t : s;
> > +    if (maxvyres < var->yres_virtual)
> > +        var->yres_virtual=maxvyres;
> > +    if (maxvyres < var->yres)
> > +        return -EINVAL;
> > +
> > +    switch (bpp) {
> > +        case 8:
> > +            var->red.offset = 0;
> > +            var->green.offset = 0;
> > +            var->blue.offset = 0;
> > +            var->red.length = 6;
> > +            var->green.length = 6;
> > +            var->blue.length = 6;
> > +            break;
> > +        case 16:
> > +            var->red.offset = 11;
> > +            var->green.offset = 5;
> > +            var->blue.offset = 0;
> > +            var->red.length = 5;
> > +            var->green.length = 6;
> > +            var->blue.length = 5;
> > +            break;
> > +        case 32:
> > +            var->red.offset = 16;
> > +            var->green.offset = 8;
> > +            var->blue.offset = 0;
> > +            var->red.length = 8;
> > +            var->green.length = 8;
> > +            var->blue.length = 8;
> > +            break;
> > +        default:
> > +            return -EINVAL;
> 	Again, you can always round off bits_per_pixel to
> ones that the driver can support.

Only when rounding _up_.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
