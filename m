Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbULAQ0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbULAQ0I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbULAQ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:26:08 -0500
Received: from witte.sonytel.be ([80.88.33.193]:17595 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261292AbULAQ0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:26:00 -0500
Date: Wed, 1 Dec 2004 17:25:52 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.29-pre1] radeonfb: don't try to ioreamp the entire
 VRAM [was: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but
 not in 2.4.29-pre1?]
In-Reply-To: <20041201161455.GA14817@dreamland.darkstar.lan>
Message-ID: <Pine.GSO.4.61.0412011724010.26820@waterleaf.sonytel.be>
References: <20041128184606.GA2537@middle.of.nowhere>
 <20041201161455.GA14817@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004, Kronos wrote:
> Il Sun, Nov 28, 2004 at 07:46:06PM +0100, Jurriaan ha scritto: 
> > The same radeonfb-setup works fine in every 2.6 kernel I can remember
> > (last tested with 2.6.10-rc2-mm3) but give the dreaded 'cannot map FB'
> > in 2.4.29-pre1.
> > 
> > The card has 128 MB of ram, and my system has 3 GB of RAM.
> > 
> > Is there any reason the ioremap() call works on 2.6, but doesn't on 2.4?
> > 
> > I've tried searching google for hints, but nothing has turned up.
> > 
> > Is there any way to test 2.4 with my radeonfb and all of my memory?
> 
> I sent you a patch a while ago but was discarded because introduced a
> subtle API change. This time should be ok :)
> 
> Make fb layer aware of the difference between the ioremap()'ed VRAM and
> total available VRAM.
> smem_len in struct fb_fix_screeninfo still contains the amount of
> physical VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) and
> the new field mapped_vram contains the amount of VRAM actually
> ioremap()'ed by drivers (used in read/write/mmap operations).
> Since there was unused padding at the end of struct fb_fix_screeninfo
> binary compatibility with userspace utilities is retained.
> If mapped_vram is not set it's assumed that the entire framebuffer is
> mapped, thus other drivers are unaffected by this patch.
> 
> The patch has been tested by Jurriaan <thunder7@xs4all.nl>.
> 
> Signed-off-by: Luca Tettamanti <kronos@people.it>
> 
> --- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
> +++ b/include/linux/fb.h	2004-11-30 18:33:00.000000000 +0100
> @@ -126,7 +126,8 @@
>  					/* (physical address) */
>  	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
>  	__u32 accel;			/* Type of acceleration available */
> -	__u16 reserved[3];		/* Reserved for future compatibility */
> +	__u32 mapped_vram;		/* Amount of ioremap()'ed VRAM */
> +	__u16 reserved[1];		/* Reserved for future compatibility */
>  };

I don't really like this patch. mapped_vram doesn't matter for user space at
all, so it does not belong to fb_fix_screeninfo.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
