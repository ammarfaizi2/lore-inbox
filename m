Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUF0VwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUF0VwY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 17:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUF0VwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 17:52:24 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:55824 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S264444AbUF0VwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 17:52:17 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Sun, 27 Jun 2004 23:51:38 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Kronos <kronos@kronoz.cjb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb: cannot map FB
In-Reply-To: <20040627203344.GA11474@dreamland.darkstar.lan>
Message-ID: <Pine.OSF.4.51.0406272347210.123582@tao.natur.cuni.cz>
References: <20040626224942.GA13345@dreamland.darkstar.lan>
 <Pine.OSF.4.51.0406272113190.111358@tao.natur.cuni.cz>
 <20040627203344.GA11474@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004, Kronos wrote:

Hi,
 thanks a lot, this has fixed my bug! Below is what I got with DEBUG=1:

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=12, xclk=20000 from BIOS
radeonfb: probed DDR SGRAM 131072k videoram
BIOS 4 scratch = 8000008
FP_GEN_CNTL: b430085, FP2_GEN_CNTL: 8
TMDS_TRANSMITTER_CNTL: 10000041, TMDS_CNTL: 1000000, LVDS_GEN_CNTL: 8000008
DAC_CNTL: ff606002, DAC_CNTL2: 0, CRTC_GEN_CNTL: 2000200
radeonfb: detected DFP panel size from BIOS: 1280x1024
radeonfb: mapped 16384k videoram
hStart = 1328, hEnd = 1440, hTotal = 1688
vStart = 1025, vEnd = 1028, vTotal = 1066
h_total_disp = 0x9f00d2    hsync_strt_wid = 0xe052a
v_total_disp = 0x3ff0429           vsync_strt_wid = 0x30400
pixclock = 9259
freq = 10800
post div = 0x2
fb_div = 0x60
ppll_div_3 = 0x10060
Console: switching to colour frame buffer device 160x64
radeonfb: ATI Radeon 9200 Ya DDR SGRAM 128 MB
radeonfb: DVI port DFP monitor connected
radeonfb: CRT port no monitor connected
radeonfb_pci_register END

Tha card has 128MB RAM, so the driver detects size properly.
Please include this fix in new RC.
Martin

> Il Sun, Jun 27, 2004 at 09:16:34PM +0200, Martin MOKREJ? ha scritto:
> > Hi,
> >   yes, I have one GB and SMP kernel. It's interresting that I don't
> > remember this bug with kernels around 2.4.23 or .24 - just a guess.
>
> Hum, I see a big DRM merge in .23 but it's unrelated to the fb driver.
> Nothing else. Maybe you added another PCI card that used part of the
> available address space?

Definitely not. Maybe changed setting in BIOS, otherwise physically same
box. But as I said, those kernel versions were just a guess. If you want,
I'll try several old kernels ...

> > If someone would be interrwested, and can check when did it appear for
> > the first time. Otherwise, will be happy to get your patch.
>
> Patch follows. Compile with DEBUG 1 if something goes wrong.
>
> > I think the printk() lines could print out more debug info. For
> > example the contents of some variables which were passed to preceeding
> > functions ... ;)
>
> The old driver (ie. the one in 2.4 and the "old" one in 2.6) is not
> developed anymore. The new reference point is the driver by BenH in 2.6.
>
>
> --- linux-2.4/drivers/video/radeonfb.c.orig	2004-06-27 22:26:56.000000000 +0200
> +++ linux-2.4/drivers/video/radeonfb.c	2004-06-27 22:29:49.000000000 +0200
> @@ -176,7 +176,8 @@
>  #define RTRACE		if(0) printk
>  #endif
>
> -
> +#define MAX_MAPPED_VRAM (2048*2048*4)
> +#define MIN_MAPPED_VRAM (1024*768*1)
>
>  enum radeon_chips {
>  	RADEON_QD,
> @@ -499,7 +500,8 @@
>
>  	short chipset;
>  	unsigned char arch;
> -	int video_ram;
> +	unsigned int video_ram;
> +	unsigned int mapped_vram;
>  	u8 rev;
>  	int pitch, bpp, depth;
>  	int xres, yres, pixclock;
> @@ -1823,8 +1825,20 @@
>  		}
>  	}
>
> -	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
> -				  		  rinfo->video_ram);
> +	if (rinfo->video_ram < rinfo->mapped_vram)
> +		rinfo->mapped_vram = rinfo->video_ram;
> +	else
> +		rinfo->mapped_vram = MAX_MAPPED_VRAM;
> +	do {
> +		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
> +				  		  rinfo->mapped_vram);
> +		if (rinfo->fb_base)
> +			break;
> +
> +		RTRACE(KERN_INFO "radeonfb: cannot ioremap %dk of videoram\n", rinfo->mapped_vram);
> +		rinfo->mapped_vram /= 2;
> +	} while(rinfo->mapped_vram > MIN_MAPPED_VRAM);
> +
>  	if (!rinfo->fb_base) {
>  		printk ("radeonfb: cannot map FB\n");
>  		iounmap ((void*)rinfo->mmio_base);
> @@ -1835,6 +1849,7 @@
>  		kfree (rinfo);
>  		return -ENODEV;
>  	}
> +	RTRACE(KERN_INFO "radeonfb: mapped %dk videoram\n", rinfo->mapped_vram/1024);
>
>  	/* currcon not yet configured, will be set by first switch */
>  	rinfo->currcon = -1;
> @@ -2261,7 +2276,7 @@
>  	sprintf (fix->id, "ATI Radeon %s", rinfo->name);
>
>          fix->smem_start = rinfo->fb_base_phys;
> -        fix->smem_len = rinfo->video_ram;
> +        fix->smem_len = rinfo->mapped_vram;
>
>          fix->type = disp->type;
>          fix->type_aux = disp->type_aux;
> @@ -2429,6 +2444,9 @@
>                          return -EINVAL;
>          }
>
> +	if (((v.xres_virtual * v.yres_virtual * nom) / den) > rinfo->mapped_vram)
> +		return -EINVAL;
> +
>          if (radeonfb_do_maximize(rinfo, var, &v, nom, den) < 0)
>                  return -EINVAL;
>
>
>
> Luca
>

-- 
Martin Mokrejs
GPG key is at http://www.natur.cuni.cz/~mmokrejs
