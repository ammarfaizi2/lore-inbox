Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbULBStw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbULBStw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 13:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbULBStw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 13:49:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21981 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261724AbULBStj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 13:49:39 -0500
Date: Thu, 2 Dec 2004 10:43:33 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kronos <kronos@people.it>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.29-pre1] radeonfb: don't try to ioreamp the entire VRAM [was: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?]
Message-ID: <20041202124332.GB3180@dmt.cyclades>
References: <20041128184606.GA2537@middle.of.nowhere> <20041201161455.GA14817@dreamland.darkstar.lan> <Pine.GSO.4.61.0412011724010.26820@waterleaf.sonytel.be> <20041201203711.GA21008@dreamland.darkstar.lan> <Pine.GSO.4.61.0412012221420.2595@waterleaf.sonytel.be> <20041202152801.GA8868@dreamland.darkstar.lan> <Pine.GSO.4.61.0412021634540.11183@waterleaf.sonytel.be> <20041202155342.GA9863@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202155342.GA9863@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Applied, thanks Geert for your reviewing.

On Thu, Dec 02, 2004 at 04:53:43PM +0100, Kronos wrote:
<snip>
> Ok, here we go:
> 
> Make fb layer aware of the difference between the ioremap()'ed VRAM and
> total available VRAM.
> smem_len in struct fb_fix_screeninfo contains the amount of physical
> VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) while the new
> field mapped_vram in struct fb_info contains the amount of VRAM actually
> ioremap()'ed by drivers (used in read/write/mmap operations).
> If mapped_vram is not set it's assumed that the entire framebuffer is
> mapped, thus other drivers are unaffected by this patch.
> 
> Signed-off-by: Luca Tettamanti <kronos@people.it>
> 
> --- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
> +++ b/include/linux/fb.h	2004-12-02 14:20:50.000000000 +0100
> @@ -323,6 +323,7 @@
>     struct fb_cmap cmap;                 /* Current cmap */
>     struct fb_ops *fbops;
>     char *screen_base;                   /* Virtual address */
> +   u32 mapped_vram;			/* ioremap()'ed VRAM */
>     struct display *disp;		/* initial display variable */
>     struct vc_data *display_fg;		/* Console visible on this display */
>     char fontname[40];			/* default font name */
> --- a/drivers/video/fbmem.c	2004-11-30 18:30:00.000000000 +0100
> +++ b/drivers/video/fbmem.c	2004-12-02 14:29:44.000000000 +0100
> @@ -410,6 +410,7 @@
>  	struct fb_info *info = registered_fb[fbidx];
>  	struct fb_ops *fb = info->fbops;
>  	struct fb_fix_screeninfo fix;
> +	unsigned int size;
>  
>  	if (! fb || ! info->disp)
>  		return -ENODEV;
> @@ -418,10 +419,12 @@
>  		return -EINVAL;
>  
>  	fb->fb_get_fix(&fix,PROC_CONSOLE(info), info);
> -	if (p >= fix.smem_len)
> +	size = info->mapped_vram ? info->mapped_vram : fix.smem_len;
> +	
> +	if (p >= size)
>  	    return 0;
> -	if (count > fix.smem_len - p)
> -		count = fix.smem_len - p;
> +	if (count > size - p)
> +		count = size - p;
>  	if (count) {
>  	    char *base_addr;
>  
> @@ -444,6 +447,7 @@
>  	struct fb_ops *fb = info->fbops;
>  	struct fb_fix_screeninfo fix;
>  	int err;
> +	unsigned int size;
>  
>  	if (! fb || ! info->disp)
>  		return -ENODEV;
> @@ -452,11 +456,13 @@
>  		return -EINVAL;
>  
>  	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
> -	if (p > fix.smem_len)
> +	size = info->mapped_vram ? info->mapped_vram : fix.smem_len;
> +	
> +	if (p > size)
>  	    return -ENOSPC;
>  	err = 0;
> -	if (count > fix.smem_len - p) {
> -	    count = fix.smem_len - p;
> +	if (count > size - p) {
> +	    count = size - p;
>  	    err = -ENOSPC;
>  	}
>  	if (count) {
> @@ -619,7 +625,10 @@
>  
>  	/* frame buffer memory */
>  	start = fix.smem_start;
> -	len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.smem_len);
> +	if (info->mapped_vram)
> +		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->mapped_vram);
> +	else
> +		len = PAGE_ALIGN((start & ~PAGE_MASK) + fix.smem_len);
>  	if (off >= len) {
>  		/* memory mapped io */
>  		off -= len;
> --- a/drivers/video/radeonfb.c	2004-11-30 18:06:45.000000000 +0100
> +++ b/drivers/video/radeonfb.c	2004-12-02 14:28:10.000000000 +0100
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
> @@ -499,7 +500,7 @@
>  
>  	short chipset;
>  	unsigned char arch;
> -	int video_ram;
> +	unsigned int video_ram;
>  	u8 rev;
>  	int pitch, bpp, depth;
>  	int xres, yres, pixclock;
> @@ -1626,6 +1627,7 @@
>  				  const struct pci_device_id *ent)
>  {
>  	struct radeonfb_info *rinfo;
> +	struct fb_info *fb_info;
>  	struct radeon_chip_info *rci = &radeon_chip_info[ent->driver_data];
>  	u32 tmp;
>  	int i, j;
> @@ -1640,6 +1642,7 @@
>  
>  	memset (rinfo, 0, sizeof (struct radeonfb_info));
>  
> +	fb_info = (struct fb_info *)rinfo;
>  	rinfo->pdev = pdev;
>  	strncpy(rinfo->name, rci->name, 16);
>  	rinfo->arch = rci->arch;
> @@ -1824,8 +1827,16 @@
>  		}
>  	}
>  
> -	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
> -				  		  rinfo->video_ram);
> +	fb_info->mapped_vram = min_t(unsigned int, MAX_MAPPED_VRAM, rinfo->video_ram);
> +	do {
> +		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
> +				  		  fb_info->mapped_vram);
> +		if (rinfo->fb_base)
> +			break;
> +
> +		fb_info->mapped_vram /= 2;
> +	} while(fb_info->mapped_vram > MIN_MAPPED_VRAM);
> +	
>  	if (!rinfo->fb_base) {
>  		printk ("radeonfb: cannot map FB\n");
>  		iounmap ((void*)rinfo->mmio_base);
> @@ -1836,6 +1847,7 @@
>  		kfree (rinfo);
>  		return -ENODEV;
>  	}
> +	RTRACE(KERN_INFO "radeonfb: mapped %dk videoram\n", fb_info->mapped_vram/1024);
>  
>  	/* currcon not yet configured, will be set by first switch */
>  	rinfo->currcon = -1;
> @@ -2199,13 +2211,14 @@
>                  {-1, -1}
>          };
>          int i;
> +	struct fb_info *fb_info = (struct fb_info *)rinfo;
>                  
>          /* use highest possible virtual resolution */
>          if (v->xres_virtual == -1 && v->yres_virtual == -1) {
>                  printk("radeonfb: using max available virtual resolution\n");
>                  for (i=0; modes[i].xres != -1; i++) {
>                          if (modes[i].xres * nom / den * modes[i].yres <
> -                            rinfo->video_ram / 2)
> +                            fb_info->mapped_vram / 2)
>                                  break;
>                  }
>                  if (modes[i].xres == -1) {
> @@ -2218,15 +2231,15 @@
>                  printk("radeonfb: virtual resolution set to max of %dx%d\n",
>                          v->xres_virtual, v->yres_virtual);
>          } else if (v->xres_virtual == -1) {
> -                v->xres_virtual = (rinfo->video_ram * den /   
> +                v->xres_virtual = (fb_info->mapped_vram * den /   
>                                  (nom * v->yres_virtual * 2)) & ~15;
>          } else if (v->yres_virtual == -1) {
>                  v->xres_virtual = (v->xres_virtual + 15) & ~15;
> -                v->yres_virtual = rinfo->video_ram * den /
> +                v->yres_virtual = fb_info->mapped_vram * den /
>                          (nom * v->xres_virtual *2);
>          } else {
>                  if (v->xres_virtual * nom / den * v->yres_virtual >
> -                        rinfo->video_ram) {
> +                        fb_info->mapped_vram) {
>                          return -EINVAL;
>                  }
>          }
> @@ -2430,6 +2443,9 @@
>                          return -EINVAL;
>          }
>  
> +	if (((v.xres_virtual * v.yres_virtual * nom) / den) > info->mapped_vram)
> +		return -EINVAL;
> +
>          if (radeonfb_do_maximize(rinfo, var, &v, nom, den) < 0)
>                  return -EINVAL;  
>                  
> 
> Luca
> -- 
> Home: http://kronoz.cjb.net
> Una donna sposa un uomo sperando che cambi, e lui non cambiera`. Un
> uomo sposa una donna sperando che non cambi, e lei cambiera`.
