Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUGDQlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUGDQlR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 12:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUGDQlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 12:41:17 -0400
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:56839 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S265199AbUGDQlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 12:41:11 -0400
Date: Sun, 4 Jul 2004 18:40:37 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Olaf Hering <olh@suse.de>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.7-bk16, mode-switch-in-fbcon_blank.patch breaks X on r128
Message-ID: <20040704164037.GA18255@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20040704160358.GA20970@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704160358.GA20970@suse.de>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <olh@suse.de>
Date: Sun, Jul 04, 2004 at 06:03:58PM +0200
> 
> This patch, which went into 2.6.7-bk16, breaks X on my ibook with r128
> chipset. X starts just fine, but the screen stays black. I can switch to
> a textconsole and the console login appears.
> 
> I see no errors in dmesg or XFree86.0.log. Its version 4.3.0 from SuSE 8.2.
> 

I also had problems (switching back from X to console rewrote my refresh
rate from 85 to 60 Hz) and this patch was posted in the
linux-fbdev-devel mailinglist which solved my problems.

could you try it and let Antonino A Daplas (adaplas @ pol.net) know if
this worked for you?

diff -Naur linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c linux-2.6.7-mm5/drivers/video/console/fbcon.c
--- linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c	2004-07-04 23:34:29.873322872 +0800
+++ linux-2.6.7-mm5/drivers/video/console/fbcon.c	2004-07-04 23:36:18.169859296 +0800
@@ -1679,8 +1679,7 @@
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
-	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh) ||
-	    (info->flags & FBINFO_MISC_MODESWITCH)) {
+	if (x_diff < 0 || x_diff > fw || (y_diff < 0 || y_diff > fh)) {
 		char mode[40];
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
@@ -1695,12 +1694,9 @@
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		if (CON_IS_VISIBLE(vc)) {
-			var.activate = FB_ACTIVATE_NOW |
-				(info->flags & FBINFO_MISC_MODESWITCH) ?
-				FB_ACTIVATE_FORCE : 0;
+			var.activate = FB_ACTIVATE_NOW;
 			fb_set_var(info, &var);
 		}
-		info->flags &= ~FBINFO_MISC_MODESWITCH;
 	}
 	updatescrollmode(p, info, vc);
 	return 0;
@@ -1752,6 +1748,13 @@
 	}
 
  	fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+
+	if (info->flags & FBINFO_MISC_MODESWITCH &&
+		info->fbops->fb_set_par) {
+		info->fbops->fb_set_par(info);
+	}
+	info->flags &= ~FBINFO_MISC_MODESWITCH;
+
 	switch (p->scrollmode) {
 	case SCROLL_WRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;

Good luck,
Jurriaan
-- 
If you ever need anything please don't hesitate to ask someone else
first.
        Nirvana
Debian (Unstable) GNU/Linux 2.6.7-mm5 2x6078 bogomips load 1.17
