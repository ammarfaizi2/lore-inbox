Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264966AbUAFSiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 13:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUAFSha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 13:37:30 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:28175 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264931AbUAFSgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 13:36:44 -0500
Date: Tue, 6 Jan 2004 18:36:30 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: "Clifford T. Matthews" <ctm@ardi.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] 16bpp bugfix for CL-GD7548 Cirrus
 frame buffer
In-Reply-To: <15858.65287.855121.801382@newbie.ardi.com>
Message-ID: <Pine.LNX.4.44.0401061835380.19366-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adapted to 2.6.0 and applied. AT present I'm going threw my patch queue 
to clean it out.


> I have a Micron Millennium Transport laptop with Cirrus CL-GD7548
> based video.  It works fine in 16bpp using the Cirrus XFree86 4.2.0
> driver.  /dev/fb works fine at 8bpp, but didn't work at 16bpp.  I
> looked at the two drivers and made clgenfb.c do a few things the
> XFree86 driver was doing and now 16bpp appears to work fine on that
> laptop.
> 
> I don't subscribe to linux-fbdev-devel, but do read lkml via a
> leisurely Usenet feed.
> 
> --Cliff	Matthews	After some people managed to scale the wall,
> ctm@ardi.com		there was a ban on the sale of rope and twine.
> 
> diff -Naur linux-2.4.20/drivers/video/clgenfb.c linux-2.4.20-clpatch/drivers/video/clgenfb.c
> --- linux-2.4.20/drivers/video/clgenfb.c	2002-11-28 16:53:15.000000000 -0700
> +++ linux-2.4.20-clpatch/drivers/video/clgenfb.c	2002-12-07 23:34:54.000000000 -0700
> @@ -15,6 +15,9 @@
>   *	Lars Hecking:
>   *	Amiga updates and testing.
>   *
> + *	Cliff Matthews <ctm@ardi.com>:
> + *	16bpp fix for CL-GD7548 (uses info from XFree86 4.2.0 source)
> + *
>   * Original clgenfb author:  Frank Neumann
>   *
>   * Based on retz3fb.c and clgen.c:
> @@ -403,6 +406,9 @@
>  
>  #ifdef CONFIG_PCI
>  	struct pci_dev *pdev;
> +#define IS_7548(x) ((x)->pdev->device == PCI_DEVICE_ID_CIRRUS_7548)
> +#else
> +#define IS_7548(x) (FALSE)
>  #endif
>  };
>  
> @@ -970,7 +976,10 @@
>  
>  	DPRINTK ("desired pixclock: %ld kHz\n", freq);
>  
> -	maxclock = clgen_board_info[fb_info->btype].maxclock;
> +	if (IS_7548(fb_info))
> +		maxclock = 80100;
> +	else
> +		maxclock = clgen_board_info[fb_info->btype].maxclock;
>  	_par->multiplexing = 0;
>  
>  	/* If the frequency is greater than we can support, we might be able
> @@ -1478,10 +1487,17 @@
>  
>  		case BT_ALPINE:
>  			DPRINTK (" (for GD543x)\n");
> -			if (_par->HorizRes >= 1024)
> -				vga_wseq (fb_info->regs, CL_SEQR7, 0xa7);
> -			else
> -				vga_wseq (fb_info->regs, CL_SEQR7, 0xa3);
> +			if (IS_7548(fb_info)) {
> +				vga_wseq (fb_info->regs, CL_SEQR7, 
> +					  (vga_rseq (fb_info->regs, CL_SEQR7) & 0xE0)
> +					  | 0x17);
> +				WHDR (fb_info, 0xC1);
> +			} else {
> +				if (_par->HorizRes >= 1024)
> +					vga_wseq (fb_info->regs, CL_SEQR7, 0xa7);
> +				else
> +					vga_wseq (fb_info->regs, CL_SEQR7, 0xa3);
> +			}	
>  			clgen_set_mclk (fb_info, _par->mclk, _par->divMCLK);
>  			break;
>  
> @@ -1594,6 +1610,11 @@
>  			_par->var.bits_per_pixel);
>  	}
>  
> +	if (IS_7548(fb_info)) {
> +		vga_wseq (fb_info->regs, CL_SEQR2D, 
> +			vga_rseq (fb_info->regs, CL_SEQR2D) | 0xC0);
> +	}
> +
>  	vga_wcrt (fb_info->regs, VGA_CRTC_OFFSET, offset & 0xff);
>  	tmp = 0x22;
>  	if (offset & 0x100)
> diff -Naur linux-2.4.20/drivers/video/clgenfb.h linux-2.4.20-clpatch/drivers/video/clgenfb.h
> --- linux-2.4.20/drivers/video/clgenfb.h	2000-01-06 11:23:46.000000000 -0700
> +++ linux-2.4.20-clpatch/drivers/video/clgenfb.h	2002-12-07 20:50:43.000000000 -0700
> @@ -60,6 +60,7 @@
>  #define CL_SEQR1D	0x1d	/* VCLK2 Denominator and Post-Scalar Value */
>  #define CL_SEQR1E	0x1e	/* VCLK3 Denominator and Post-Scalar Value */
>  #define CL_SEQR1F	0x1f	/* BIOS ROM write enable and MCLK Select */
> +#define CL_SEQR2D	0x2d	/* unknown, snagged from XFree86 4.2.0 */
>  
>  /*** CRT Controller Registers ***/
>  #define CL_CRT22	0x22	/* Graphics Data Latches ReadBack */
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

