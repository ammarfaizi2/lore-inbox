Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265825AbUGDWgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265825AbUGDWgu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUGDWgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:36:50 -0400
Received: from snickers.hotpop.com ([38.113.3.51]:9640 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP id S265825AbUGDWgp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:36:45 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Olaf Hering <olh@suse.de>, Jurriaan <thunder7@xs4all.nl>
Subject: Re: 2.6.7-bk16, mode-switch-in-fbcon_blank.patch breaks X on r128
Date: Mon, 5 Jul 2004 06:38:00 +0800
User-Agent: KMail/1.5.4
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
References: <20040704160358.GA20970@suse.de> <20040704164037.GA18255@middle.of.nowhere> <20040704171028.GA22469@suse.de>
In-Reply-To: <20040704171028.GA22469@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200407050638.00307.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olaf, Jurriaan

On Monday 05 July 2004 01:10, Olaf Hering wrote:
>  On Sun, Jul 04, Jurriaan wrote:
> > From: Olaf Hering <olh@suse.de>
> > Date: Sun, Jul 04, 2004 at 06:03:58PM +0200
> >
> > > This patch, which went into 2.6.7-bk16, breaks X on my ibook with r128
> > > chipset. X starts just fine, but the screen stays black. I can switch
> > > to a textconsole and the console login appears.
> > >
> > > I see no errors in dmesg or XFree86.0.log. Its version 4.3.0 from SuSE
> > > 8.2.
> >
> > I also had problems (switching back from X to console rewrote my refresh
> > rate from 85 to 60 Hz) and this patch was posted in the
> > linux-fbdev-devel mailinglist which solved my problems.
> >
> > could you try it and let Antonino A Daplas (adaplas @ pol.net) know if
> > this worked for you?
>
> No, this will not work, fbcon_resize() is called before fbcon_blank(). I
> think the removed code in fbcon_blank() is needed.

Yes, thanks.  It does seem that some Radeon cards need the set_var() code in
fbcon_blank, such as Olaf's, while others do okay with the set_var() code
in fbcon_switch()->fbcon_resize(), such as Jurriann's.  As to why, I'm not sure.

Can you try this patch?  It's ugly, but I have no reports of failure yet. It's just
the old code (pre-mm5/pre-bk16) -- do a set_var() code in fbcon_blank() -- 
combined with the new code (mm5 and bk16), as an option to do the set_var()
in fbcon_switch() -- needed by other cards such as rivafb.  

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

Ugly workaround.  When switching from KD_GRAPHICS to KD_TEXT, the 
event is captured at fbcon_blank() allowing fbcon to reinitialize the hardware.
However, some hardware requires the reinitialization to be done immediately,
others require it to be done later.  Others may need it to be done immediately
and later, this is the worst case. 

diff -Naur linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c linux-2.6.7-mm5/drivers/video/console/fbcon.c
--- linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c	2004-07-02 15:09:02.132667752 +0000
+++ linux-2.6.7-mm5/drivers/video/console/fbcon.c	2004-07-02 15:12:29.935076984 +0000
@@ -1802,8 +1802,31 @@
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
 
-	if (mode_switch)
-		info->flags |= FBINFO_MISC_MODESWITCH;
+	if (mode_switch) {
+		struct fb_var_screeninfo var = info->var;
+
+/* 
+ * HACK ALERT: Some hardware will require reinitializion at this stage,
+ *             others will require it to be done as late as possible.
+ *             For now, we differentiate this with the 
+ *             FBINFO_MISC_MODESWITCHLATE bitflag.  Worst case will be
+ *             hardware that requires it here and another one later.
+ *             A definitive solution may require fixing X or the VT
+ *             system.
+ */
+		if (info->flags & FBINFO_MISC_MODESWITCHLATE)
+			info->flags |= FBINFO_MISC_MODESWITCH;
+
+		if (blank) {
+		    fbcon_cursor(vc, CM_ERASE);
+		    return 0;
+		}
+
+		if (!(info->flags & FBINFO_MISC_MODESWITCHLATE)) {
+			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
+			fb_set_var(info, &var);
+		}
+	}
 
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 
diff -Naur linux-2.6.7-mm5-orig/drivers/video/riva/fbdev.c linux-2.6.7-mm5/drivers/video/riva/fbdev.c
--- linux-2.6.7-mm5-orig/drivers/video/riva/fbdev.c	2004-07-02 15:08:39.130164664 +0000
+++ linux-2.6.7-mm5/drivers/video/riva/fbdev.c	2004-07-02 15:12:27.322474160 +0000
@@ -1681,7 +1681,8 @@
 		    | FBINFO_HWACCEL_YPAN
 		    | FBINFO_HWACCEL_COPYAREA
 		    | FBINFO_HWACCEL_FILLRECT
-		    | FBINFO_HWACCEL_IMAGEBLIT;
+		    | FBINFO_HWACCEL_IMAGEBLIT
+	            | FBINFO_MISC_MODESWITCHLATE;
 	info->var = rivafb_default_var;
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
diff -Naur linux-2.6.7-mm5-orig/include/linux/fb.h linux-2.6.7-mm5/include/linux/fb.h
--- linux-2.6.7-mm5-orig/include/linux/fb.h	2004-07-02 15:09:17.062398088 +0000
+++ linux-2.6.7-mm5/include/linux/fb.h	2004-07-02 15:12:31.318866616 +0000
@@ -533,6 +533,7 @@
 #define FBINFO_MISC_MODECHANGEUSER     0x10000 /* mode change request
 						  from userspace */
 #define FBINFO_MISC_MODESWITCH         0x20000 /* mode switch */
+#define FBINFO_MISC_MODESWITCHLATE     0x40000 /* init hardware later */
 
 struct fb_info {
 	int node;


