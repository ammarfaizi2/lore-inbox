Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTEAR1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTEAR1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:27:46 -0400
Received: from mbox1.netikka.net ([213.250.81.202]:6322 "EHLO
	mbox1.netikka.net") by vger.kernel.org with ESMTP id S261500AbTEAR1m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:27:42 -0400
From: Thomas Backlund <tmb@iki.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Date: Thu, 1 May 2003 20:39:58 +0300
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EB0413D.2050200@superonline.com> <200305011801.39014.tmb@iki.fi> <1051800568.21442.16.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051800568.21442.16.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200305012039.58321.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viestissä Torstai 1. Toukokuuta 2003 17:49, Alan Cox kirjoitti:
> On Iau, 2003-05-01 at 16:01, Thomas Backlund wrote:
> > You mean the patch that only looks at videomode, dont you...
>
> I do
>
> > Well maybe it's best to use it as default, to avoid this bug
> > "out of the box"...
> >
> > But I will remake a patch to ovverride it so that the users who
> > need/want the extra memory to be able to allocate it...
> > since I like the idea of giving the user the choice...
>
> Sounds right to me

Yeah, so merging the two patches ends up like this:
----- cut -----
--- tmb3/Documentation/fb/vesafb.txt	2003-05-01 19:53:26.000000000 +0300
+++ tmb3/Documentation/fb/vesafb.txt.vram	2003-05-01 20:11:08.000000000 
+0300
@@ -146,6 +146,11 @@

 mtrr	setup memory type range registers for the vesafb framebuffer.

+vram:n  remap 'n' MiB of video RAM. If 0 or not specified, remap memory
+        according to video mode. (2.5.66 patch/idea by Antonino Daplas
+	reversed to give override possibility (allocate more fb memory
+	than the kernel would) to 2.4 by tmb@iki.fi)
+  
 
 Have fun!
 
--- tmb3/drivers/video/vesafb.c	2003-05-01 19:49:34.000000000 +0300
+++ tmb3/drivers/video/vesafb.c.vram	2003-05-01 20:07:57.000000000 +0300
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
@@ -520,7 +525,10 @@
 	video_width         = screen_info.lfb_width;
 	video_height        = screen_info.lfb_height;
 	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_size * 65536;
+	video_size          = screen_info.lfb_size * screen_info.lfb_height * 
video_bpp;
+	/* sets video_size according to boot option */
+        if (vram && vram * 1024 * 1024 > video_size)
+                video_size = vram * 1024 * 1024;
 	video_visual = (video_bpp == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
----- cut -----

And yes...
This is still without a "failsafe" since I don't have an upper limit,
but it occurred to me that maybe it isn't that easy after all...
 - I can't trust the videocard memory probe...,
 - to just calculate the video_size * 3 (for tripple buffering) is bad ;-)
 - videocards with everyhing between 256k and 256 MB of memory,
   makes choosing the limit somewhat impossible...
 - of course there is also endless range of installed system memory...

So, any thoughts...?
Or should one just leave it open due to:
" it's your system, feel free to break it..." ;-)

Oh well,
I'm building my testkernel now with the above patch, 
and will be testing different vram options to "kill" my system...

-- 
Thomas Backlund

tmb@iki.fi
www.iki.fi/tmb

