Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269301AbUHZSHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbUHZSHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269174AbUHZSA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:00:58 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:35301 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269147AbUHZRyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:54:17 -0400
Date: Thu, 26 Aug 2004 19:54:20 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Martin MOKREJ? <mmokrejs@natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb: cannot map FB
Message-ID: <20040826175420.GA10021@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040626224942.GA13345@dreamland.darkstar.lan> <Pine.OSF.4.51.0406272113190.111358@tao.natur.cuni.cz> <20040627203344.GA11474@dreamland.darkstar.lan> <Pine.OSF.4.51.0408261402230.174739@tao.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.51.0408261402230.174739@tao.natur.cuni.cz>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Aug 26, 2004 at 02:03:56PM +0200, Martin MOKREJ? ha scritto: 
> Hi,
>   I have just tested 2.4.28-pre2 and found this patch still isn't in. Could
> someone apply it to the official tree and tell me back to re-test? The fix
> works fine for me some time already.

The problem is that fix->smem_len is also used by the ioctl
FBIOGET_FSCREENINFO. With my patch userspace will be unable to know the
real amount of VRAM. A proper fix requires changes in the FB API; I'll
be on holiday for a couple of weeks and I'll try to make patch that's not
too intrusive.

> On Sun, 27 Jun 2004, Kronos wrote:
> 
> > Il Sun, Jun 27, 2004 at 09:16:34PM +0200, Martin MOKREJ? ha scritto:
> > > Hi,
> > >   yes, I have one GB and SMP kernel. It's interresting that I don't
> > > remember this bug with kernels around 2.4.23 or .24 - just a guess.
> >
> > Hum, I see a big DRM merge in .23 but it's unrelated to the fb driver.
> > Nothing else. Maybe you added another PCI card that used part of the
> > available address space?
> >
> > > If someone would be interrwested, and can check when did it appear for
> > > the first time. Otherwise, will be happy to get your patch.
> >
> > Patch follows. Compile with DEBUG 1 if something goes wrong.
> >
> > > I think the printk() lines could print out more debug info. For
> > > example the contents of some variables which were passed to preceeding
> > > functions ... ;)
> >
> > The old driver (ie. the one in 2.4 and the "old" one in 2.6) is not
> > developed anymore. The new reference point is the driver by BenH in 2.6.
> >
> >
> > --- linux-2.4/drivers/video/radeonfb.c.orig	2004-06-27 22:26:56.000000000 +0200
> > +++ linux-2.4/drivers/video/radeonfb.c	2004-06-27 22:29:49.000000000 +0200
> > @@ -176,7 +176,8 @@
> >  #define RTRACE		if(0) printk
> >  #endif
> >
> > -
> > +#define MAX_MAPPED_VRAM (2048*2048*4)
> > +#define MIN_MAPPED_VRAM (1024*768*1)
> >
> >  enum radeon_chips {
> >  	RADEON_QD,
> > @@ -499,7 +500,8 @@
> >
> >  	short chipset;
> >  	unsigned char arch;
> > -	int video_ram;
> > +	unsigned int video_ram;
> > +	unsigned int mapped_vram;
> >  	u8 rev;
> >  	int pitch, bpp, depth;
> >  	int xres, yres, pixclock;
> > @@ -1823,8 +1825,20 @@
> >  		}
> >  	}
> >
> > -	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
> > -				  		  rinfo->video_ram);
> > +	if (rinfo->video_ram < rinfo->mapped_vram)
> > +		rinfo->mapped_vram = rinfo->video_ram;
> > +	else
> > +		rinfo->mapped_vram = MAX_MAPPED_VRAM;
> > +	do {
> > +		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
> > +				  		  rinfo->mapped_vram);
> > +		if (rinfo->fb_base)
> > +			break;
> > +
> > +		RTRACE(KERN_INFO "radeonfb: cannot ioremap %dk of videoram\n", rinfo->mapped_vram);
> > +		rinfo->mapped_vram /= 2;
> > +	} while(rinfo->mapped_vram > MIN_MAPPED_VRAM);
> > +
> >  	if (!rinfo->fb_base) {
> >  		printk ("radeonfb: cannot map FB\n");
> >  		iounmap ((void*)rinfo->mmio_base);
> > @@ -1835,6 +1849,7 @@
> >  		kfree (rinfo);
> >  		return -ENODEV;
> >  	}
> > +	RTRACE(KERN_INFO "radeonfb: mapped %dk videoram\n", rinfo->mapped_vram/1024);
> >
> >  	/* currcon not yet configured, will be set by first switch */
> >  	rinfo->currcon = -1;
> > @@ -2261,7 +2276,7 @@
> >  	sprintf (fix->id, "ATI Radeon %s", rinfo->name);
> >
> >          fix->smem_start = rinfo->fb_base_phys;
> > -        fix->smem_len = rinfo->video_ram;
> > +        fix->smem_len = rinfo->mapped_vram;
> >
> >          fix->type = disp->type;
> >          fix->type_aux = disp->type_aux;
> > @@ -2429,6 +2444,9 @@
> >                          return -EINVAL;
> >          }
> >
> > +	if (((v.xres_virtual * v.yres_virtual * nom) / den) > rinfo->mapped_vram)
> > +		return -EINVAL;
> > +
> >          if (radeonfb_do_maximize(rinfo, var, &v, nom, den) < 0)
> >                  return -EINVAL;
> >
> >
> >
> > Luca

Luca
-- 
Home: http://kronoz.cjb.net
Un apostolo vedendo Gesu` camminare sulle acque:
- Cazzo se e` buono 'sto fumo!!!
