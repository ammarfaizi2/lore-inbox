Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbTEALsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbTEALsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:48:17 -0400
Received: from main.gmane.org ([80.91.224.249]:49321 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261243AbTEALsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:48:11 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Thomas Backlund <tmb@iki.fi>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
Date: Thu, 01 May 2003 15:00:29 +0300
Message-ID: <b8r26l$he0$1@main.gmane.org>
References: <3EB0413D.2050200@superonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O.Sezer wrote:

> So far, so good...
> 
> I can happily boot, halt, play some opengl games, perform my daily
> routines, etc.  This should also be related to the bug recorded at
> Mandrake-bugzilla: http://qa.mandrakesoft.com/show_bug.cgi?id=3198 .
> I also reported this to kernel@mandrakesoft.com .
> 

No need ;-)....
We already have a (IMHO) better patch in current Cooker...
(and if you need it to install MDK 9.1, head over to www.iki.fi/tmb,
 grab the install disks, and follow the instructions...)

The problem with the patch you discussed, is that it allocates
framebuffer memory only according to the display mode...,
but there are programs that benefits from the "extra" memory...
this according to Antonino Daplas...
(AFAIK double/triple buffering is one thing...)

The patch that we have in current Cooker, allows the user to
request the size himself by a command line option...
and it does not change the setup/configuration for users that
does not suffer from this problem...


the patch works like this:

you request the framebuffer size with "video=vesa:vram:32"
where 32 is the requested size in MB... 
(you can choose the size yourself)
but a gemeric rule IMHO is to not go beyond the amount
of video memory you have... 

and when the system boots:

- if no vram option, boot as normal (like without the patch)
- if probed memory > requested, use requested
- if probed memory < requested, use probed (like without the patch)

As a test I used this "video=vesa:vram:32" on a card
with 64MB of ram, and on a card with only 4MB of ram
to se if I could mess it up, with the following results:

64MB card: allocated FB -> 32MB
(this is also confirmed on a 128MB card, by other Cooker users)
 4MB card: allocated FB ->  4MB 
(here the original probe worked, so we use it...)


So this way we wont break current systems, 
but have an option for those cards that has problem...
(seems to be AGP + >=128MB VideoRAM + >=1024MB system RAM only)

and finally... the patch itself:

----- cut -----
diff -Naru tmb7/Documentation/fb/vesafb.txt tmb9/Documentation/fb/vesafb.txt
--- tmb7/Documentation/fb/vesafb.txt    2000-07-28 22:50:51.000000000 +0300
+++ tmb9/Documentation/fb/vesafb.txt    2003-04-03 10:48:50.000000000 +0300
@@ -146,6 +146,10 @@

 mtrr   setup memory type range registers for the vesafb framebuffer.

+vram:n  remap 'n' MiB of video RAM. If 0 or not specified, remap all
+        available video RAM. (2.5.66 patch by Antonino Daplas backported
+       to 2.4 by tmb@iki.fi)
+

 Have fun!

diff -Naru tmb7/drivers/video/vesafb.c tmb9/drivers/video/vesafb.c
--- tmb7/drivers/video/vesafb.c 2002-11-29 01:53:15.000000000 +0200
+++ tmb9/drivers/video/vesafb.c 2003-04-03 10:46:52.000000000 +0300
@@ -94,6 +94,7 @@

 static int             inverse   = 0;
 static int             mtrr      = 0;
+static int      vram __initdata = 0; /* needed for vram boot option */
 static int             currcon   = 0;

 static int             pmi_setpal = 0; /* pmi for palette changes ??? */
@@ -479,6 +480,10 @@
                        pmi_setpal=1;
                else if (! strcmp(this_opt, "mtrr"))
                        mtrr=1;
+               /* checks for vram boot option */
+               else if (! strncmp(this_opt, "vram:", 5))
+                       vram = simple_strtoul(this_opt+5, NULL, 0);
+
                else if (!strncmp(this_opt, "font:", 5))
                        strcpy(fb_info.fontname, this_opt+5);
        }
@@ -521,6 +526,9 @@
        video_height        = screen_info.lfb_height;
        video_linelength    = screen_info.lfb_linelength;
        video_size          = screen_info.lfb_size * 65536;
+       /* sets video_size according to boot option */
+        if (vram && vram * 1024 * 1024 < video_size)
+                video_size = vram * 1024 * 1024;
        video_visual = (video_bpp == 8) ?
                FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
----- cut -----


Best Regards

Thomas Backlund

tmb@iki.fi
www.iki.fi/tmb

