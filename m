Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265737AbUGDQEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265737AbUGDQEI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUGDQEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:04:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:49298 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265737AbUGDQEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:04:00 -0400
Date: Sun, 4 Jul 2004 18:03:58 +0200
From: Olaf Hering <olh@suse.de>
To: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: 2.6.7-bk16, mode-switch-in-fbcon_blank.patch breaks X on r128
Message-ID: <20040704160358.GA20970@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch, which went into 2.6.7-bk16, breaks X on my ibook with r128
chipset. X starts just fine, but the screen stays black. I can switch to
a textconsole and the console login appears.

I see no errors in dmesg or XFree86.0.log. Its version 4.3.0 from SuSE 8.2.



From: "Antonino A. Daplas" <adaplas@hotpop.com>

As we've discussed in another thread, below is a diff that will do a set_par()
as late as possible when there is KD_TEXT<->KD_GRAPHICS switch.  The set_par()
will be forced in fbcon_resize() instead.

Not sure if this has repercussions with the other drivers, but this patch
fixed the X nv driver hanging when switching to the console.  (I believe the
crash is actually caused by an early set_par() -- while in fbcon_blank. 
Removing the set_par in fbcon_blank fixed the hang but caused cursor sprite
and display corruption).

Signed-off-by: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/video/console/fbcon.c |   21 ++++++++-------------
 25-akpm/include/linux/fb.h            |    1 +
 2 files changed, 9 insertions(+), 13 deletions(-)

diff -puN drivers/video/console/fbcon.c~mode-switch-in-fbcon_blank drivers/video/console/fbcon.c
--- 25/drivers/video/console/fbcon.c~mode-switch-in-fbcon_blank	2004-06-29 22:32:49.969619360 -0700
+++ 25-akpm/drivers/video/console/fbcon.c	2004-06-29 22:32:49.976618296 -0700
@@ -1663,7 +1663,8 @@ static int fbcon_resize(struct vc_data *
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
-	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
+	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh) ||
+	    (info->flags & FBINFO_MISC_MODESWITCH)) {
 		char mode[40];
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
@@ -1678,9 +1679,12 @@ static int fbcon_resize(struct vc_data *
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		if (CON_IS_VISIBLE(vc)) {
-			var.activate = FB_ACTIVATE_NOW;
+			var.activate = FB_ACTIVATE_NOW |
+				(info->flags & FBINFO_MISC_MODESWITCH) ?
+				FB_ACTIVATE_FORCE : 0;
 			fb_set_var(info, &var);
 		}
+		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 	p->vrows = var.yres_virtual/fh;
 	if (var.yres > (fh * (height + 1)))
@@ -1788,17 +1792,8 @@ static int fbcon_blank(struct vc_data *v
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 
-	if (mode_switch) {
-		struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-		struct fb_var_screeninfo var = info->var;
-
-		if (blank) {
-			fbcon_cursor(vc, CM_ERASE);
-			return 0;
-		}
-		var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
-		fb_set_var(info, &var);
-	}
+	if (mode_switch)
+		info->flags |= FBINFO_MISC_MODESWITCH;
 
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 
diff -puN include/linux/fb.h~mode-switch-in-fbcon_blank include/linux/fb.h
--- 25/include/linux/fb.h~mode-switch-in-fbcon_blank	2004-06-29 22:32:49.970619208 -0700
+++ 25-akpm/include/linux/fb.h	2004-06-29 22:32:49.977618144 -0700
@@ -532,6 +532,7 @@ struct fb_ops {
 
 #define FBINFO_MISC_MODECHANGEUSER     0x10000 /* mode change request
 						  from userspace */
+#define FBINFO_MISC_MODESWITCH         0x20000 /* mode switch */
 
 struct fb_info {
 	int node;
_
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
