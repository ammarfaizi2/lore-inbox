Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbULAV1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbULAV1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbULAV1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:27:36 -0500
Received: from witte.sonytel.be ([80.88.33.193]:20915 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261477AbULAV1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:27:25 -0500
Date: Wed, 1 Dec 2004 22:25:38 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.29-pre1] radeonfb: don't try to ioreamp the entire
 VRAM [was: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but
 not in 2.4.29-pre1?]
In-Reply-To: <20041201203711.GA21008@dreamland.darkstar.lan>
Message-ID: <Pine.GSO.4.61.0412012221420.2595@waterleaf.sonytel.be>
References: <20041128184606.GA2537@middle.of.nowhere>
 <20041201161455.GA14817@dreamland.darkstar.lan>
 <Pine.GSO.4.61.0412011724010.26820@waterleaf.sonytel.be>
 <20041201203711.GA21008@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004, Kronos wrote:
> Il Wed, Dec 01, 2004 at 05:25:52PM +0100, Geert Uytterhoeven ha scritto: 
> > > Make fb layer aware of the difference between the ioremap()'ed VRAM and
> > > total available VRAM.
> > > smem_len in struct fb_fix_screeninfo still contains the amount of
> > > physical VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) and
> > > the new field mapped_vram contains the amount of VRAM actually
> > > ioremap()'ed by drivers (used in read/write/mmap operations).
> > > Since there was unused padding at the end of struct fb_fix_screeninfo
> > > binary compatibility with userspace utilities is retained.
> > > If mapped_vram is not set it's assumed that the entire framebuffer is
> > > mapped, thus other drivers are unaffected by this patch.
> > > 
> > > The patch has been tested by Jurriaan <thunder7@xs4all.nl>.
> > > 
> > > Signed-off-by: Luca Tettamanti <kronos@people.it>
> > > 
> > > --- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
> > > +++ b/include/linux/fb.h	2004-11-30 18:33:00.000000000 +0100
> > > @@ -126,7 +126,8 @@
> > >  					/* (physical address) */
> > >  	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
> > >  	__u32 accel;			/* Type of acceleration available */
> > > -	__u16 reserved[3];		/* Reserved for future compatibility */
> > > +	__u32 mapped_vram;		/* Amount of ioremap()'ed VRAM */
> > > +	__u16 reserved[1];		/* Reserved for future compatibility */
> > >  };
> > 
> > I don't really like this patch. mapped_vram doesn't matter for user space at
> > all, so it does not belong to fb_fix_screeninfo.
> 
> Hmm, it looked sensible to me since it's the max amount of data that
> userspace can read (or write) from /dev/fb%d.

That's not really a user space limitation, but a kernel `bug'.

I.e. it could be solved in the kernel if larger ioremap()s would be allowed, or
if some sliding window mapping would be used. User space shouldn't need to know
about this.

> Putting mapped_vram in fb_info would be acceptable?

That would make sure this stays in-kernel, but my other reasoning stays the
same: it's some kind of kernel bug.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
