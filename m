Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVH3QTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVH3QTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVH3QTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:19:04 -0400
Received: from witte.sonytel.be ([80.88.33.193]:26502 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932201AbVH3QTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:19:02 -0400
Date: Tue, 30 Aug 2005 18:18:08 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
In-Reply-To: <43148610.70406@t-online.de>
Message-ID: <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
References: <43148610.70406@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Knut Petersen wrote:
> linux/drivers/video/console/bitblit.c
> --- linuxorig/drivers/video/console/bitblit.c	2005-08-29 01:41:01.000000000
> +0200
> +++ linux/drivers/video/console/bitblit.c	2005-08-30 17:19:57.000000000
> +0200
> @@ -114,7 +114,7 @@ static void bit_putcs(struct vc_data *vc
> 	unsigned int scan_align = info->pixmap.scan_align - 1;
> 	unsigned int buf_align = info->pixmap.buf_align - 1;
> 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
> -	unsigned int shift_high = 8, pitch, cnt, size, k;
> +	unsigned int shift_high = 8, pitch, cnt, size, i, k;
> 	unsigned int idx = vc->vc_font.width >> 3;
> 	unsigned int attribute = get_attribute(info, scr_readw(s));
> 	struct fb_image image;
> @@ -175,7 +175,11 @@ static void bit_putcs(struct vc_data *vc
> 					src = buf;
> 				}
> 
> -				fb_pad_aligned_buffer(dst, pitch, src, idx,
> image.height);
> +				if (idx == 1)
> +					for(i=0; i < image.height; i++)
> +						dst[pitch*i] = src[i];
                                                    ^^^^^^^
> +				else
> +					fb_pad_aligned_buffer(dst, pitch, src,
> idx, image.height);
> 				dst += width;
> 			}
> 		}

Probably you can make it even faster by avoiding the multiplication, like

    unsigned int offset = 0;
    for (i = 0; i < image.height; i++) {
	dst[offset] = src[i];
	offset += pitch;
    }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
