Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVIJNqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVIJNqS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbVIJNqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:46:18 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:47633 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S1750842AbVIJNqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:46:18 -0400
Message-ID: <4322E3A3.5010903@roarinelk.homelinux.net>
Date: Sat, 10 Sep 2005 15:46:11 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
References: <20050908053042.6e05882f.akpm@osdl.org> <4322C741.9060808@roarinelk.homelinux.net> <4322D49D.5040506@pol.net>
In-Reply-To: <4322D49D.5040506@pol.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ah, yes, sorry about that.  Can you try this patch?
> 
> Fix kernel oops when CONFIG_FB_I810_I2C is set to 'n'.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
> diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
> --- a/drivers/video/i810/i810_main.c
> +++ b/drivers/video/i810/i810_main.c
> @@ -1830,7 +1830,7 @@ static void __devinit i810fb_find_init_m
>  {
>  	struct fb_videomode mode;
>  	struct fb_var_screeninfo var;
> -	struct fb_monspecs *specs = NULL;
> +	struct fb_monspecs *specs = &info->monspecs;
>  	int found = 0;
>  #ifdef CONFIG_FB_I810_I2C
>  	int i;
> @@ -1853,12 +1853,11 @@ static void __devinit i810fb_find_init_m
>  	if (!err)
>  		printk("i810fb_init_pci: DDC probe successful\n");
>  
> -	fb_edid_to_monspecs(par->edid, &info->monspecs);
> +	fb_edid_to_monspecs(par->edid, specs);
>  
> -	if (info->monspecs.modedb == NULL)
> +	if (specs->modedb == NULL)
>  		printk("i810fb_init_pci: Unable to get Mode Database\n");
>  
> -	specs = &info->monspecs;
>  	fb_videomode_to_modelist(specs->modedb, specs->modedb_len,
>  				 &info->modelist);
>  	if (specs->modedb != NULL) {

Thanks, it boots now, but doesnt set video mode. Spews
a bunch of "i810fb: invalid video mode" lines and defaults
to 640x480.

With I2C enabled:
i810-i2c: Probe DDC1 Bus
i810-i2c: Unable to read EDID block.
i810-i2c: Unable to read EDID block.
i810-i2c: Unable to read EDID block.
i810-i2c: Probe DDC2 Bus
i810-i2c: Unable to read EDID block.
i810-i2c: Unable to read EDID block.
i810-i2c: Unable to read EDID block.
i810-i2c: Probe DDC3 Bus
i810-i2c: Getting EDID from BIOS
i810fb_init_pci: DDC probe successful
i810fb_init_pci: Unable to get Mode Database
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
i810fb: invalid video mode
ringbuffer lockup!!!
IIR     : 0x0000
EIR     : 0x0000
PGTBL_ER: 0x0000
IPEIR   : 0x0001
IPEHR   : 0x0000
Console: switching to colour frame buffer device 80x25
I810FB: fb0         : Intel(R) 815 (Internal Graphics with AGP) Framebuffer Device v0.9.0
I810FB: Video RAM   : 4096K
I810FB: Monitor     : H: 40-80 KHz V: 60-60 Hz
I810FB: Mode        : 640x400-8bpp@69Hz

-- 
  Manuel Lauss
