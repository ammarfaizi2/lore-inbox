Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWBJLxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWBJLxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWBJLxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:53:14 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:50981 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751085AbWBJLxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:53:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h6SBdVbJSVmWqiwFFHyuZTiluOaWHhHasDEeWm/vWwfLbkmaXB7S8dO+TvrLuTg1KhuY+FsCiMt/NCqCbWX1VzUEstTmmxDwyr1gjcL2hDhULgQgJ8i30N1w1ngxRKu5E4uoT/NdVW4cAGVpaeyPgMM1GQy9nzH3FsTrzsYlBxs=
Message-ID: <43EC7EA7.5030105@gmail.com>
Date: Fri, 10 Feb 2006 19:53:11 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Christian Trefzer <ctrefzer@gmx.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] neofb: add more logic to determine sensibility of register
 readback
References: <20060208202207.GA26682@zeus.uziel.local> <20060210113616.GA17482@hermes.uziel.local>
In-Reply-To: <20060210113616.GA17482@hermes.uziel.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Trefzer wrote:
> Hello everyone,
> 
> testing my latest patches through productive use I noticed that we
> require a bit of a logic for the register read to not cause trouble at
> the time of unblanking. Thing is, blanking is implemented through
> deactivation of the LCD activation bit, so if we read back the register,
> the LCD backlight won't come back on until the LID is shut and reopened,
> effectively pushing the work to the BIOS.
> 
> The following patch is on top of my previous one, adding a variable to
> struct neofb_par to remember if we want to read the respective register
> values next time we (un)blank.
> 
> Logic depends on the assumption that we won't change display config in a
> blanked state, as a keypress should already be answered by unblanking.
> Essentially, we should read back the register values to variable on
> blank, and ignore them on unblank. Unfortunately, only checking for
> !blank_mode won't avoid the backlight remaining off, hence the
> additional checks. 
> 
> Signed-off-by: Christian Trefzer <ctrefzer@gmx.de>
> 
> 
> --- a/include/video/neomagic.h	2006-01-03 04:21:10.000000000 +0100
> +++ b/include/video/neomagic.h	2006-02-09 20:59:20.164839408 +0100
> @@ -159,6 +159,7 @@
>  	unsigned char PanelDispCntlReg1;
>  	unsigned char PanelDispCntlReg2;
>  	unsigned char PanelDispCntlReg3;
> +	unsigned char PanelDispCntlRegRead;
>  	unsigned char PanelVertCenterReg1;
>  	unsigned char PanelVertCenterReg2;
>  	unsigned char PanelVertCenterReg3;
> --- a/drivers/video/neofb.c	2006-02-08 21:24:05.000000000 +0100
> +++ b/drivers/video/neofb.c	2006-02-09 23:21:33.489914472 +0100
> @@ -1334,8 +1334,11 @@
>  	struct neofb_par *par = (struct neofb_par *)info->par;
>  	int seqflags, lcdflags, dpmsflags, reg;
>  
> -	/* Reload the value stored in the register, might have been changed via FN keystroke */
> -	par->PanelDispCntlReg1 = vga_rgfx(NULL, 0x20) & 0x03;
> +	/* Reload the value stored in the register, if sensible. It might have been
> +	 * changed via FN keystroke. */
> +	if (par->PanelDispCntlRegRead && !blank_mode) {
> +		par->PanelDispCntlReg1 = vga_rgfx(NULL, 0x20) & 0x03;
> +	}
>  	
>  	switch (blank_mode) {
>  	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */
> @@ -1355,21 +1358,25 @@
>  			tosh_smm(&regs);
>  		}
>  #endif
> +		par->PanelDispCntlRegRead = 0;
>  		break;
>  	case FB_BLANK_HSYNC_SUSPEND:		/* hsync off */
>  		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
>  		lcdflags = 0;			/* LCD off */
>  		dpmsflags = NEO_GR01_SUPPRESS_HSYNC;
> +		par->PanelDispCntlRegRead = 0;
>  		break;
>  	case FB_BLANK_VSYNC_SUSPEND:		/* vsync off */
>  		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
>  		lcdflags = 0;			/* LCD off */
>  		dpmsflags = NEO_GR01_SUPPRESS_VSYNC;
> +		par->PanelDispCntlRegRead = 0;
>  		break;
>  	case FB_BLANK_NORMAL:		/* just blank screen (backlight stays on) */
>  		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
>  		lcdflags = par->PanelDispCntlReg1 & 0x02; /* LCD normal */
>  		dpmsflags = 0x00;	/* no hsync/vsync suppression */
> +		par->PanelDispCntlRegRead = 0;
>  		break;
>  	case FB_BLANK_UNBLANK:		/* unblank */
>  		seqflags = 0;			/* Enable sequencer */
> @@ -1387,6 +1394,7 @@
>  			tosh_smm(&regs);
>  		}
>  #endif
> +		par->PanelDispCntlRegRead = 1;
>  		break;
>  	default:	/* Anything else we don't understand; return 1 to tell
>  			 * fb_blank we didn't aactually do anything */

You can save a few lines by

par->PanelDispCntlRegRead = (blank_mode) ? 0 : 1;

Tony
