Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTADWKg>; Sat, 4 Jan 2003 17:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbTADWKg>; Sat, 4 Jan 2003 17:10:36 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:9992 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S261615AbTADWKc>; Sat, 4 Jan 2003 17:10:32 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH][FBDEV]: fb_putcs() and
	fb_setfont() methods
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301042058240.24903-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301042058240.24903-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1041717978.1052.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Jan 2003 06:06:21 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-05 at 05:07, James Simmons wrote:
> 
> Rejected. I have put thought into it and the whole point was to not allow 

Personally, that's fine by me since I have no need for those 2
extensions.  But please apply the accel_putcs() buffer overrun patch.

BTW, attached is another patch that will change the resolution of the
console via tty ioctl TIOCSWINSZ.  I'm not sure if this is the correct
solution, but it's the only one I can think of without really adding a
lot of extra code.  This is implemented by adding a con_resize() hook to
fbcon, so the window size can be changed such as by using:

stty cols 128 rows 48 (1024x768 with font 8x16)

The new window size should also be preserved per console.  Still, there
are other fb parameters that can screw up the console (such as changing
yres_virtual and bits_per_pixel) but the window size is the most
important.

Tony 

diff -Naur linux-2.5.54/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.54/drivers/video/console/fbcon.c	2003-01-04 21:58:47.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-01-04 21:58:24.000000000 +0000
@@ -1871,6 +1871,25 @@
 }
 

+static int fbcon_resize(struct vc_data *vc, unsigned int width, 
+			unsigned int height)
+{
+	struct display *p = &fb_display[vc->vc_num];
+	struct fb_info *info = p->fb_info;
+	struct fb_var_screeninfo var = info->var;
+	int err;
+
+	var.xres = width * vc->vc_font.width;
+	var.yres = height * vc->vc_font.height;
+	var.activate = FB_ACTIVATE_NOW;
+
+	err = fb_set_var(&var, info);
+	return  (err || var.xres != info->var.xres ||
+		 var.yres != info->var.yres) ?
+		-EINVAL : 0;
+	  
+}
+
 static int fbcon_switch(struct vc_data *vc)
 {
 	int unit = vc->vc_num;
@@ -1920,6 +1939,7 @@
 
 	info->currcon = unit;
 	
+        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
 	update_var(unit, info);
 	
 	if (vt_cons[unit]->vc_mode == KD_TEXT)
@@ -2537,6 +2557,7 @@
 	.con_invert_region 	= fbcon_invert_region,
 	.con_screen_pos 	= fbcon_screen_pos,
 	.con_getxy 		= fbcon_getxy,
+	.con_resize             = fbcon_resize,
 };
 
 int __init fb_console_init(void)

