Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314281AbSEDPtg>; Sat, 4 May 2002 11:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314360AbSEDPtf>; Sat, 4 May 2002 11:49:35 -0400
Received: from [203.167.79.9] ([203.167.79.9]:8211 "EHLO willow.compass.com.ph")
	by vger.kernel.org with ESMTP id <S314281AbSEDPtd>;
	Sat, 4 May 2002 11:49:33 -0400
Subject: Re: [Linux-fbdev-devel] Comments on fbgen.c and fbcon-accel.c
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@transvirtual.com>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10205031444260.9732-100000@www.transvirtual.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 May 2002 23:48:47 +0800
Message-Id: <1020527361.752.1.camel@daplas>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-05-04 at 05:47, James Simmons wrote:
> 
> > I have a few observations on fbgen and fbcon-accel.
> 
> Don't mix fbgen with fbcon-accel. The new gen_* stuff in fbgen.c is meant
> to replace the old fbgen_* stuff. That is why the below doesn't work.
>  
Okay, I've succeeded in rewriting the i810/i815 driver to use the gen_*
stuff instead of fbgen_*.  As far as I can tell everything works :) --
y-panning, accel, etc -- although gen_update_var() may not work
properly.  I'm still getting incorrect cursor colors in 8 bpp, but
that's probably my fault.  And you're right, it's actually easier to
write the driver using the gen_* stuff.  

> 
> > 2. Also, fbgen_switch basically just do an fbgen_do_set_var()
> > (decode_var(), followed by set_par()).  This is okay most times, but
> > it's probably better if fbgen_switch also does an encode_fix() since
> > fbcon's drawing functions also rely on fix->line_length.
> 
> Most likely that is also broken. I haven't thought about it since I plan
> to make all the old fbgen_* functions go away.
> 
fb_gen_switch may be broken, but I think gen_switch works just okay as
long as info->fix is updated in set_par().

> > If an fb_fix_screeninfo is not updated, display corruption occurs when
> > switching to another display with a different pixelformat.
> 
> Correct. That is why I require info->fix to be updated when set_par is
> called.
> 
Right.

The i810fb patch is at
http://prdownloads.sourceforge.net/i810fb/linux-2.5.13-i810fb.tar.bz2.

Tony

--- fbgen.c.orig	Sat May  4 14:35:32 2002
+++ fbgen.c	Sat May  4 15:02:37 2002
@@ -514,7 +514,8 @@
     
 	if (con == info->currcon) {
 		if (info->fbops->fb_pan_display) {
-			if ((err = info->fbops->fb_pan_display(&info->var, con, info)))
+		        /* Tony: offsets are still in disp->var, not info->var */
+			if ((err = info->fbops->fb_pan_display(&fb_display[con].var, con, info)))
 				return err;
 		}
 	}	

