Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUA2Tao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUA2Tan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:30:43 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:61322 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S266314AbUA2T3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:29:44 -0500
Date: Thu, 29 Jan 2004 20:29:37 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Guido Guenther <agx@sigxcpu.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.2-rc2, rivafb]: GeForce4 440 Go 64M overflows fb_fix_screeninfo.id
Message-ID: <20040129192937.GI5681@vana.vc.cvut.cz>
References: <20040129172511.GA959@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129172511.GA959@bogon.ms20.nix>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 06:25:11PM +0100, Guido Guenther wrote:
> Hi,
> fb_fix_screeninfo has space for 15 characters but riva/fbdev.c tries to
> copy more into it in case of the above card (and therefore corrupts
> memory). The result looks like:
> rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (nVidiaGeForce4-4\224, 32MB @ 0x94000000)
>                                                                ^^^^^
> Possible fix attached. This also overwrites the initial "nVidia" in
> rivafb_fix.id making the output the same as in 2.4 (and using strlcpy
> makes sure we don't overflow again). With this patch:
> 
> rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (GeForce4-440-GO-M64, 32MB @ 0x94000000)
> 
> Can this go in?

No way. Second part (riva/fbdev.c) is OK, but first part is wrong. fb_fix_screeninfo
is part of ABI, and as such cannot be changed. No fb application is going to work
on your system - try 'fbset -i' (unless you rebuilt fbset binary after doing this change).

You'll have to live with 'GeForce4-440-GO' name.
							Petr Vandrovec

>  -- Guido

> --- ../benh-rsync-2.6-clean/include/linux/fb.h	2003-12-24 11:31:18.000000000 +0100
> +++ include/linux/fb.h	2004-01-28 20:35:24.000000000 +0100
> @@ -114,7 +114,7 @@
>  
>  
>  struct fb_fix_screeninfo {
> -	char id[16];			/* identification string eg "TT Builtin" */
> +	char id[32];			/* identification string eg "TT Builtin" */
>  	unsigned long smem_start;	/* Start of frame buffer mem */
>  					/* (physical address) */
>  	__u32 smem_len;			/* Length of frame buffer mem */
> --- ../benh-rsync-2.6-clean/drivers/video/riva/fbdev.c	2003-12-24 08:30:11.000000000 +0100
> +++ drivers/video/riva/fbdev.c	2004-01-28 21:04:29.000000000 +0100
> @@ -1867,7 +1867,7 @@
>  		goto err_out_kfree1;
>  	memset(info->pixmap.addr, 0, 64 * 1024);
>  
> -	strcat(rivafb_fix.id, rci->name);
> +	strlcpy(rivafb_fix.id, rci->name, sizeof(rivafb_fix.id));
>  	default_par->riva.Architecture = rci->arch_rev;
>  
>  	default_par->Chipset = (pd->vendor << 16) | pd->device;

