Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286917AbSABKrB>; Wed, 2 Jan 2002 05:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286914AbSABKqm>; Wed, 2 Jan 2002 05:46:42 -0500
Received: from mx7.port.ru ([194.67.57.17]:29692 "EHLO mx7.port.ru")
	by vger.kernel.org with ESMTP id <S286918AbSABKqk>;
	Wed, 2 Jan 2002 05:46:40 -0500
Date: Wed, 2 Jan 2002 13:48:57 +0300
From: Nick Kurshev <nickols_k@mail.ru>
To: <whitney@math.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, ajoshi@unixbox.com
Subject: Re: radeonfb 0.1.3 (kernel 2.4.18-pre1) report
Message-Id: <20020102134857.4ea42695.nickols_k@mail.ru>
In-Reply-To: <Pine.LNX.4.33.0112300804410.4035-100000@mf1.private>
In-Reply-To: <Pine.LNX.4.33.0112300804410.4035-100000@mf1.private>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Wayne!

On Sun, 30 Dec 2001 08:53:19 -0800 (PST) you wrote:

Also try comment out such blocks:
/* XXX absurd hack for X to restore console */
It might help.
At least they are unapplicable for my branch.
> Hello,
> 
> A few comments on radeonfb 0.1.3, as included in kernel 2.4.18-pre1:
> 
> First, as someone previously noted, radeonfb.c fails to compile in
> 2.4.18-pre1.  The following symbols are undefined, apparently because they
> were omitted from radeon.h:
> 
> TMDS_TRANSMITTER_CNTL
> ICHCSEL
> TMDS_PLLRST
> LVDS_STATE_MASK
> 
> Not knowing what values the first three should be, I just commented out
> the code that uses them.  :-)  Since the last value is a mask applied
> against a 32-bit quantity, I set it to 0xFFFFFFFF.  Then with the patch
> appended below, I was able to get radeonfb.c to compile.
> 
> Second, it works!  Here are the log messages:
> 
> radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
> radeonfb: detected DFP panel size: 1280x1024
> Console: switching to colour frame buffer device 80x25
> radeonfb: ATI Radeon QY VE  DDR SGRAM 32 MB
> radeonfb: DVI port DFP monitor connected
> radeonfb: CRT port no monitor connected
> 
> As you can see, my setup is a Radeon VE with a 1280x1024 DFP on the DVI
> port and nothing on the VGA port.  No previous mailine radeonfb.c worked
> on this setup, although Nick Kurshev's radeonfb.c from the MPlayer project
> does work.
> 
> Third, I have to do a 'fbset 1280x1024-60' after loading the radeonfb
> driver to get an image--despite having detected a 1280x1024 DFP, the
> driver does not initialize the mode properly.  My DFP goes into power-save
> mode (no image to display) after loading radeonfb.o until I do the fbset.
> 
> Lastly, a few minor nits:  changing virtual consoles is quite slow--the
> DFP goes into power-save mode during the transition, even when both
> virtual consoles have the same mode.  Scrolling is very slow as well.  
> Also, using ^R in bash results in redraw errors.
> 
> I hope this report is of help.
> 
> Thanks, Wayne
> 
> 
> --- linux-2.4.18-pre1/drivers/video/radeonfb.c.orig	Sat Dec 29 20:48:07 2001
> +++ linux-2.4.18-pre1/drivers/video/radeonfb.c	Sat Dec 29 22:35:21 2001
> @@ -76,6 +76,7 @@
>  #include <video/fbcon-cfb32.h>
>  
>  #include "radeon.h"
> +#define LVDS_STATE_MASK 0xFFFFFFFF
>  
>  
>  #define DEBUG	0
> @@ -2280,7 +2281,7 @@
>  	save->lvds_gen_cntl = INREG(LVDS_GEN_CNTL);
>  	save->lvds_pll_cntl = INREG(LVDS_PLL_CNTL);
>  	save->tmds_crc = INREG(TMDS_CRC);
> -	save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL);
> +/*	save->tmds_transmitter_cntl = INREG(TMDS_TRANSMITTER_CNTL); */
>  }
>  
>  
> @@ -2557,8 +2558,8 @@
>  		} else {
>  			/* DFP */
>  			newmode.fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
> -			newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST |
> -							 ICHCSEL) & ~(TMDS_PLLRST);
> +/*			newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST |
> +							 ICHCSEL) & ~(TMDS_PLLRST); */
>  			newmode.crtc_ext_cntl &= ~CRTC_CRT_ON;
>  		}
>  
> @@ -2647,7 +2648,7 @@
>  		OUTREG(FP_VERT_STRETCH, mode->fp_vert_stretch);
>  		OUTREG(FP_GEN_CNTL, mode->fp_gen_cntl);
>  		OUTREG(TMDS_CRC, mode->tmds_crc);
> -		OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl);
> +/*		OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl); */
>  
>  		if (primary_mon == MT_LCD) {
>  			unsigned int tmp = INREG(LVDS_GEN_CNTL);
> 
> 


Best regards! Nick
