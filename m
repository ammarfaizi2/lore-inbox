Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbTF0Liw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTF0Liw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:38:52 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:45510 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264192AbTF0Lit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:38:49 -0400
Date: Fri, 27 Jun 2003 13:51:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Backlund <tmb@iki.fi>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.4.21-rc8 vesafb memory remapping...
In-Reply-To: <200306122343.49563.tmb@iki.fi>
Message-ID: <Pine.GSO.4.21.0306271340000.2794-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Marcelo,

Can we please have a fix for vesafb in the next -pre*? Currently it maps 8
times too much memory due to a bits/bytes confusion.

For your convenience, I rediffed against the latest trees and appended the
patch below. This includes the fixed vram size handling and the documentation
for the new vram parameter.

Thanks!

On Thu, 12 Jun 2003, Thomas Backlund wrote:
> I noticed that the vesafb still remaps memory according to a calculation 
> done in bits, even if should be done in bytes...
> This will remap more memory than old cards actually have...
> 
> An example:
> My laptop has 8192 KB of videoram
> I use it with videomode 1024x768x16
> 
> With current vesafb that will translate to 12288 KB remapping
> 
> So here is my suggestion,
> either grab the complete "fix" from rc7-ac1 (wich calculates in bytes),
> or If you dont like that, my second suggestion is to use the
> old vesafb code to take care of old cards like this:
> 
> ----- cut -----
> #diff -u rc8/drivers/video/vesafb.c rc8/drivers/video/vesafb.c.new
> --- rc8/drivers/video/vesafb.c  2003-06-12 23:13:29.000000000 +0300
> +++ rc8/drivers/video/vesafb.c.new      2003-06-12 23:18:03.000000000 +0300
> @@ -521,6 +521,11 @@
>         video_height        = screen_info.lfb_height;
>         video_linelength    = screen_info.lfb_linelength;
>         video_size          = screen_info.lfb_width *   
> screen_info.lfb_height * video_bpp;
> +
> +       /* check that we don't remap more memory than old cards have */
> +       if (video_size > screen_info.lfb_size * 65536)
> +               video_size = screen_info.lfb_size * 65536;
> +
>         video_visual = (video_bpp == 8) ?
>                 FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
> 
> ----- cut -----
> 
> Like this we would keep both old and new systems happy AFAIK...
> 
> 
> -- 
> Regards
> 
> Thomas Backlund
> 
> http://www.iki.fi/tmb/
> tmb@iki.fi

--- linux-2.4.22-pre2/drivers/video/vesafb.c	Fri May  9 11:03:41 2003
+++ linux-2.4.21-ac3/drivers/video/vesafb.c	Fri Jun 27 13:46:11 2003
@@ -94,6 +94,7 @@
 
 static int             inverse   = 0;
 static int             mtrr      = 0;
+static int	 vram __initdata = 0;	/* needed for vram boot option */
 static int             currcon   = 0;
 
 static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
@@ -479,6 +480,10 @@
 			pmi_setpal=1;
 		else if (! strcmp(this_opt, "mtrr"))
 			mtrr=1;
+		/* checks for vram boot option */
+		else if (! strncmp(this_opt, "vram:", 5))
+			vram = simple_strtoul(this_opt+5, NULL, 0);
+
 		else if (!strncmp(this_opt, "font:", 5))
 			strcpy(fb_info.fontname, this_opt+5);
 	}
@@ -520,7 +525,20 @@
 	video_width         = screen_info.lfb_width;
 	video_height        = screen_info.lfb_height;
 	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp;
+
+	/* remap memory according to videomode, multiply by 2 to get space for doublebuffering */
+	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp / 8 * 2;
+
+	/* check that we don't remap more memory than old cards have */
+	if (video_size > screen_info.lfb_size * 65536)
+		video_size = screen_info.lfb_size * 65536;
+	
+	/* FIXME: Should we clip against declared size for banked devices ? */
+	
+	/* sets video_size according to vram boot option */
+	if (vram && vram * 1024 * 1024 != video_size)
+		video_size = vram * 1024 * 1024;
+		
 	video_visual = (video_bpp == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
--- linux-2.4.22-pre2/Documentation/fb/vesafb.txt	Fri Jul 28 21:50:51 2000
+++ linux-2.4.21-ac3/Documentation/fb/vesafb.txt	Fri Jun 27 13:45:47 2003
@@ -139,13 +139,17 @@
 redraw	scroll by redrawing the affected part of the screen, this
 	is the safe (and slow) default.
 
-
 vgapal	Use the standard vga registers for palette changes.
 	This is the default.
 pmipal	Use the protected mode interface for palette changes.
 
 mtrr	setup memory type range registers for the vesafb framebuffer.
 
+vram:n  remap 'n' MiB of video RAM. If 0 or not specified, remap memory
+        according to video mode. (2.5.66 patch/idea by Antonino Daplas
+	reversed to give override possibility (allocate more fb memory
+	than the kernel would) to 2.4 by tmb@iki.fi)
+  
 
 Have fun!
 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

