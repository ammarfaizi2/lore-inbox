Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265719AbSKATgn>; Fri, 1 Nov 2002 14:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbSKATgn>; Fri, 1 Nov 2002 14:36:43 -0500
Received: from [203.167.79.9] ([203.167.79.9]:3599 "EHLO willow.compass.com.ph")
	by vger.kernel.org with ESMTP id <S265719AbSKATgl>;
	Fri, 1 Nov 2002 14:36:41 -0500
Subject: Re: [Linux-fbdev-devel] [BK fbdev updates]
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0210311258040.1721-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0210311258040.1721-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1036178902.572.33.camel@daplas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Nov 2002 03:41:33 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-01 at 05:03, James Simmons wrote:
> 
> Sorry about not producing a regular diff. The final changes really did a
> number on the framebuffer console code in fbcon.c so I had some massive
> work to do. I still have a massive amount of cleaning up to do. Also a lot
> of drivers stil haven't been ported.
> 
> So here is the regular diff against 2.5.45
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 

James,

I tried the patch, and it does produce a cleaner and smaller driver. 
Overall, I like it. Some observations:

1. Without the fb_set_var() hook, switching from X messes up the
console.  I would guess this will be addressed by the console?

2. Console panning/wrapping does not work.  updatevar includes a check
"if (con == info->currcon)", and my guess is info->currcon is obsoleted
so the check always fails.

3. fbdev can be loaded without taking over the console.  After running
an fb-based application, exiting fbdev messes up the vga console
(actually hangs the system).  Should the fbdev driver provide the
capability to restore the VGA state then, ie at info->fb_release?

4. The initial font loaded is 8x8. It seems that 8x16 fonts are limited
for the SGI console console only.  Any reason why?

5.  The cfb_* drawing functions still behave erratically, especially in
emacs.  Geert has made some versions that work correctly for me.  This
was discussed in a thread sometimes ago.

Some of the above problems may be from the driver side (ie. #3).

Tony

Attached is a diff that will allow the logo to be drawn at 8-bpp
pseudocolor:

diff -Naur linux-2.4.45-fbdev/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.4.45-fbdev/drivers/video/console/fbcon.c	Fri Nov  1 19:19:13 2002
+++ linux/drivers/video/console/fbcon.c	Fri Nov  1 19:20:00 2002
@@ -2281,12 +2281,12 @@
 		}
 		saved_palette = info->pseudo_palette;
 		info->pseudo_palette = palette;
-		image.width = LOGO_W;
-		image.height = LOGO_H;
-		image.depth = depth;
-		image.data = logo;
-		image.dy = 0;
 	}
+	image.width = LOGO_W;
+	image.height = LOGO_H;
+	image.depth = depth;
+	image.data = logo;
+	image.dy = 0;
 #endif
  
     for (x = 0; x < num_online_cpus() * (LOGO_W + 8) &&



  


 

