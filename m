Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287572AbSAEHQu>; Sat, 5 Jan 2002 02:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287573AbSAEHQn>; Sat, 5 Jan 2002 02:16:43 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:51673 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287572AbSAEHQ3>; Sat, 5 Jan 2002 02:16:29 -0500
Date: Fri, 4 Jan 2002 23:16:27 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.2-pre8/drivers/video kdev_t compilation fixes
Message-ID: <20020104231627.A24564@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Most (all?) of the frame buffer drivers in
linux-2.5.2-pre8/drivers/video have a kdev_t compilation error,
because they try to set their fb_info->node field to -1 (it is
a kdev_t).  Shortly thereafter, regsiter_framebuffer sets it to
a more useful value.  So far, I have been unable to spot any
code that relies on fb_info->node being initialized to a
particular value prior to the call to register_framebuffer,
although I have not looked very hard.  What I did see was
some "???" comments beside some of the initializations to -1.
I suspsect that this is just useless initialization.

	Anyhow, deleting all of those initializations to -1
allows all of the framebuffer drivers to compile, which is
that this patch does.  I have also included a tiny patch to
a commented out line in include/linux/fb.h, updating it to
use minor() instead of MINOR(), in case it is every uncommented.

	I am still a long way from getting pre8 to run, so I
have not tested change.  Can anyone point out a place in
drivers/framebuffer that relies on fb_info->node being set to -1,
or minor(fb_info->node) being -1?

	By the way, don't worry if a few of the line offsets in this
patch are off.  That's because of some other changes I have in my
drivers/framebuffer (which I have previous posted, specifically
PCI ID tables, fb font modularization with demand loading, and the
fb core as a loadable module).


-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="video.diff"

--- linux-2.5.2-pre8/include/linux/fb.h	Mon Dec 11 13:16:53 2000
+++ linux/include/linux/fb.h	Fri Jan  4 22:50:55 2002
@@ -246,7 +246,7 @@
 #if 1 /* to go away in 2.5.0 */
 extern int GET_FB_IDX(kdev_t rdev);
 #else
-#define GET_FB_IDX(node)	(MINOR(node))
+#define GET_FB_IDX(node)	(minor(node))
 #endif
 
 #include <linux/fs.h>
diff -u -r linux-2.5.2-pre8/drivers/video/S3triofb.c linux/drivers/video/S3triofb.c
--- linux-2.5.2-pre8/drivers/video/S3triofb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/S3triofb.c	Fri Jan  4 22:45:25 2002
@@ -554,7 +554,6 @@
 
     strcpy(fb_info.modename, "Trio64 ");
     strncat(fb_info.modename, dp->full_name, sizeof(fb_info.modename));
-    fb_info.node = -1;
     fb_info.fbops = &s3trio_ops;
 #if 0
     fb_info.fbvar_num = 1;
diff -u -r linux-2.5.2-pre8/drivers/video/amifb.c linux/drivers/video/amifb.c
--- linux-2.5.2-pre8/drivers/video/amifb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/amifb.c	Fri Jan  4 22:45:25 2002
@@ -1730,7 +1730,6 @@
 
 	strcpy(fb_info.modename, amifb_name);
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
 	fb_info.fbops = &amifb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &amifbcon_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/atafb.c linux/drivers/video/atafb.c
--- linux-2.5.2-pre8/drivers/video/atafb.c	Thu Oct 25 00:02:26 2001
+++ linux/drivers/video/atafb.c	Fri Jan  4 22:45:25 2002
@@ -2828,7 +2828,6 @@
 
 	strcpy(fb_info.modename, "Atari Builtin ");
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
 	fb_info.fbops = &atafb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &atafb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux-2.5.2-pre8/drivers/video/aty/atyfb_base.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/video/aty/atyfb_base.c	Fri Jan  4 22:53:08 2002
@@ -1986,7 +1986,6 @@
     disp = &info->disp;
 
     strcpy(info->fb_info.modename, atyfb_name);
-    info->fb_info.node = -1;
     info->fb_info.fbops = &atyfb_ops;
     info->fb_info.disp = disp;
     strcpy(info->fb_info.fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/aty128fb.c linux/drivers/video/aty128fb.c
--- linux-2.5.2-pre8/drivers/video/aty128fb.c	Sun Nov 11 10:09:37 2001
+++ linux/drivers/video/aty128fb.c	Fri Jan  4 22:46:54 2002
@@ -1704,7 +1728,6 @@
 
     /* fill in info */
     strcpy(info->fb_info.modename, aty128fb_name);
-    info->fb_info.node  = -1;
     info->fb_info.fbops = &aty128fb_ops;
     info->fb_info.disp  = &info->disp;
     strcpy(info->fb_info.fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/chipsfb.c linux/drivers/video/chipsfb.c
--- linux-2.5.2-pre8/drivers/video/chipsfb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/chipsfb.c	Fri Jan  4 22:45:25 2002
@@ -578,7 +578,6 @@
 	p->disp.scrollmode = SCROLL_YREDRAW;
 
 	strcpy(p->info.modename, p->fix.id);
-	p->info.node = -1;
 	p->info.fbops = &chipsfb_ops;
 	p->info.disp = &p->disp;
 	p->info.fontname[0] = 0;
diff -u -r linux-2.5.2-pre8/drivers/video/clgenfb.c linux/drivers/video/clgenfb.c
--- linux-2.5.2-pre8/drivers/video/clgenfb.c	Mon Nov 19 15:19:42 2001
+++ linux/drivers/video/clgenfb.c	Fri Jan  4 22:45:25 2002
@@ -2758,7 +2785,6 @@
 		 sizeof (fb_info->gen.info.modename));
 	fb_info->gen.info.modename [sizeof (fb_info->gen.info.modename) - 1] = 0;
 
-	fb_info->gen.info.node = -1;
 	fb_info->gen.info.fbops = &clgenfb_ops;
 	fb_info->gen.info.disp = &disp;
 	fb_info->gen.info.changevar = NULL;
diff -u -r linux-2.5.2-pre8/drivers/video/controlfb.c linux/drivers/video/controlfb.c
--- linux-2.5.2-pre8/drivers/video/controlfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/controlfb.c	Fri Jan  4 22:46:11 2002
@@ -1376,7 +1376,6 @@
 static void __init control_init_info(struct fb_info *info, struct fb_info_control *p)
 {
 	strcpy(info->modename, "control");
-	info->node = -1;	/* ??? danj */
 	info->fbops = &controlfb_ops;
 	info->disp = &p->display;
 	strcpy(info->fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/cyberfb.c linux/drivers/video/cyberfb.c
--- linux-2.5.2-pre8/drivers/video/cyberfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/cyberfb.c	Fri Jan  4 22:45:25 2002
@@ -1085,7 +1085,6 @@
 
 	    strcpy(fb_info.modename, cyberfb_name);
 	    fb_info.changevar = NULL;
-	    fb_info.node = -1;
 	    fb_info.fbops = &cyberfb_ops;
 	    fb_info.disp = &disp;
 	    fb_info.switch_con = &Cyberfb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/dn_cfb4.c linux/drivers/video/dn_cfb4.c
--- linux-2.5.2-pre8/drivers/video/dn_cfb4.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/video/dn_cfb4.c	Fri Jan  4 22:45:25 2002
@@ -305,7 +305,6 @@
 	fb_info.switch_con=&dnfbcon_switch;
 	fb_info.updatevar=&dnfbcon_updatevar;
 	fb_info.blank=&dnfbcon_blank;	
-	fb_info.node = -1;
 	fb_info.fbops = &dn_fb_ops;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;	
 
diff -u -r linux-2.5.2-pre8/drivers/video/dn_cfb8.c linux/drivers/video/dn_cfb8.c
--- linux-2.5.2-pre8/drivers/video/dn_cfb8.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/video/dn_cfb8.c	Fri Jan  4 22:45:25 2002
@@ -292,7 +292,6 @@
 	fb_info.switch_con=&dnfbcon_switch;
 	fb_info.updatevar=&dnfbcon_updatevar;
 	fb_info.blank=&dnfbcon_blank;	
-	fb_info.node = -1;
 	fb_info.fbops = &dn_fb_ops;
 	
 printk("dn_fb_init: register\n");
diff -u -r linux-2.5.2-pre8/drivers/video/dnfb.c linux/drivers/video/dnfb.c
--- linux-2.5.2-pre8/drivers/video/dnfb.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/video/dnfb.c	Fri Jan  4 22:45:25 2002
@@ -307,7 +307,6 @@
 	fb_info.switch_con=&dnfbcon_switch;
 	fb_info.updatevar=&dnfbcon_updatevar;
 	fb_info.blank=&dnfbcon_blank;	
-	fb_info.node = -1;
 	fb_info.fbops = &dn_fb_ops;
 	
         dn_fb_get_var(&disp[0].var,0, &fb_info);
diff -u -r linux-2.5.2-pre8/drivers/video/epson1355fb.c linux/drivers/video/epson1355fb.c
--- linux-2.5.2-pre8/drivers/video/epson1355fb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/epson1355fb.c	Fri Jan  4 22:45:25 2002
@@ -500,7 +500,6 @@
 	fb_info.gen.fbhw->detect();
 	strcpy(fb_info.gen.info.modename, "SED1355");
 	fb_info.gen.info.changevar = NULL;
-	fb_info.gen.info.node = -1;
 	fb_info.gen.info.fbops = &e1355fb_ops;
 	fb_info.gen.info.disp = &disp;
 	fb_info.gen.parsize = sizeof(struct e1355_par);
diff -u -r linux-2.5.2-pre8/drivers/video/fm2fb.c linux/drivers/video/fm2fb.c
--- linux-2.5.2-pre8/drivers/video/fm2fb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/fm2fb.c	Fri Jan  4 22:45:25 2002
@@ -401,7 +401,6 @@
 	disp.scrollmode = SCROLL_YREDRAW;
 
 	strcpy(fb_info.modename, fb_fix.id);
-	fb_info.node = -1;
 	fb_info.fbops = &fm2fb_ops;
 	fb_info.disp = &disp;
 	fb_info.fontname[0] = '\0';
diff -u -r linux-2.5.2-pre8/drivers/video/g364fb.c linux/drivers/video/g364fb.c
--- linux-2.5.2-pre8/drivers/video/g364fb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/g364fb.c	Fri Jan  4 22:45:25 2002
@@ -378,7 +378,6 @@
     disp.dispsw = &fbcon_g364cfb8;
 
     strcpy(fb_info.modename, fb_fix.id);
-    fb_info.node = -1;
     fb_info.fbops = &g364fb_ops;
     fb_info.disp = &disp;
     fb_info.fontname[0] = '\0';
diff -u -r linux-2.5.2-pre8/drivers/video/hgafb.c linux/drivers/video/hgafb.c
--- linux-2.5.2-pre8/drivers/video/hgafb.c	Mon Nov 12 09:46:25 2001
+++ linux/drivers/video/hgafb.c	Fri Jan  4 22:45:25 2002
@@ -742,7 +742,6 @@
 	disp.scrollmode = SCROLL_YREDRAW;
 	
 	strcpy (fb_info.modename, hga_fix.id);
-	fb_info.node = -1;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
 /*	fb_info.open = ??? */
 	fb_info.var = hga_default_var;
diff -u -r linux-2.5.2-pre8/drivers/video/hitfb.c linux/drivers/video/hitfb.c
--- linux-2.5.2-pre8/drivers/video/hitfb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/hitfb.c	Fri Jan  4 22:45:25 2002
@@ -344,7 +344,6 @@
 int __init hitfb_init(void)
 {
     strcpy(fb_info.gen.info.modename, "Hitachi HD64461");
-    fb_info.gen.info.node = -1;
     fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
     fb_info.gen.info.fbops = &hitfb_ops;
     fb_info.gen.info.disp = &fb_info.disp;
diff -u -r linux-2.5.2-pre8/drivers/video/hpfb.c linux/drivers/video/hpfb.c
--- linux-2.5.2-pre8/drivers/video/hpfb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/hpfb.c	Fri Jan  4 22:45:25 2002
@@ -328,7 +328,6 @@
 	 */
 	strcpy(fb_info.modename, "Topcat");
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
 	fb_info.fbops = &hpfb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &hpfb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/igafb.c linux/drivers/video/igafb.c
--- linux-2.5.2-pre8/drivers/video/igafb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/igafb.c	Fri Jan  4 22:45:25 2002
@@ -568,7 +591,6 @@
 	}
 
 	strcpy(info->fb_info.modename, igafb_name);
-	info->fb_info.node = -1;
 	info->fb_info.fbops = &igafb_ops;
 	info->fb_info.disp = &info->disp;
 	strcpy(info->fb_info.fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/imsttfb.c linux/drivers/video/imsttfb.c
--- linux-2.5.2-pre8/drivers/video/imsttfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/imsttfb.c	Fri Jan  4 22:45:25 2002
@@ -1866,7 +1866,6 @@
 
 	strcpy(p->info.modename, p->fix.id);
 	strcpy(p->info.fontname, fontname);
-	p->info.node = -1;
 	p->info.fbops = &imsttfb_ops;
 	p->info.disp = &p->disp;
 	p->info.changevar = 0;
diff -u -r linux-2.5.2-pre8/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux-2.5.2-pre8/drivers/video/matrox/matroxfb_base.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/matrox/matroxfb_base.c	Fri Jan  4 22:54:44 2002
@@ -1789,7 +1789,6 @@
 
 	strcpy(ACCESS_FBINFO(fbcon.modename), "MATROX VGA");
 	ACCESS_FBINFO(fbcon.changevar) = NULL;
-	ACCESS_FBINFO(fbcon.node) = -1;
 	ACCESS_FBINFO(fbcon.fbops) = &matroxfb_ops;
 	ACCESS_FBINFO(fbcon.disp) = d;
 	ACCESS_FBINFO(fbcon.switch_con) = &matroxfb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux-2.5.2-pre8/drivers/video/matrox/matroxfb_crtc2.c	Fri Nov  9 14:07:41 2001
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jan  4 22:54:14 2002
@@ -693,7 +693,6 @@
 
 	strcpy(m2info->fbcon.modename, "MATROX CRTC2");
 	m2info->fbcon.changevar = NULL;
-	m2info->fbcon.node = -1;
 	m2info->fbcon.fbops = &matroxfb_dh_ops;
 	m2info->fbcon.disp = d;
 	m2info->fbcon.switch_con = &matroxfb_dh_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/maxinefb.c linux/drivers/video/maxinefb.c
--- linux-2.5.2-pre8/drivers/video/maxinefb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/maxinefb.c	Fri Jan  4 22:45:25 2002
@@ -358,7 +358,6 @@
 	strcpy(fb_info.modename, "Maxine onboard graphics 1024x768x8");
 	/* fb_info.modename: maximum of 39 characters + trailing nullbyte, KM */
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
 	fb_info.fbops = &maxinefb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &maxinefb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/modedb.c linux/drivers/video/modedb.c
--- linux-2.5.2-pre8/drivers/video/modedb.c	Tue Nov 27 17:06:50 2001
+++ linux/drivers/video/modedb.c	Fri Jan  4 22:45:25 2002
@@ -421,3 +421,4 @@
 }
 
 EXPORT_SYMBOL(__fb_try_mode);
+EXPORT_SYMBOL(global_mode_option);
diff -u -r linux-2.5.2-pre8/drivers/video/offb.c linux/drivers/video/offb.c
--- linux-2.5.2-pre8/drivers/video/offb.c	Tue Oct  2 09:10:31 2001
+++ linux/drivers/video/offb.c	Fri Jan  4 22:45:25 2002
@@ -566,7 +566,6 @@
 
     strcpy(info->info.modename, "OFfb ");
     strncat(info->info.modename, full_name, sizeof(info->info.modename));
-    info->info.node = -1;
     info->info.fbops = &offb_ops;
     info->info.disp = disp;
     info->info.fontname[0] = '\0';
diff -u -r linux-2.5.2-pre8/drivers/video/platinumfb.c linux/drivers/video/platinumfb.c
--- linux-2.5.2-pre8/drivers/video/platinumfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/platinumfb.c	Fri Jan  4 22:45:25 2002
@@ -591,7 +591,6 @@
 	disp = &info->disp;
 
 	strcpy(info->fb_info.modename, "platinum");
-	info->fb_info.node = -1;
 	info->fb_info.fbops = &platinumfb_ops;
 	info->fb_info.disp = disp;
 	strcpy(info->fb_info.fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/pmag-ba-fb.c linux/drivers/video/pmag-ba-fb.c
--- linux-2.5.2-pre8/drivers/video/pmag-ba-fb.c	Fri Sep 14 14:04:07 2001
+++ linux/drivers/video/pmag-ba-fb.c	Fri Jan  4 22:45:25 2002
@@ -386,7 +386,6 @@
 	 */
 	strcpy(ip->info.modename, "PMAG-BA");
 	ip->info.changevar = NULL;
-	ip->info.node = -1;
 	ip->info.fbops = &pmagbafb_ops;
 	ip->info.disp = &disp;
 	ip->info.switch_con = &pmagbafb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/pmagb-b-fb.c linux/drivers/video/pmagb-b-fb.c
--- linux-2.5.2-pre8/drivers/video/pmagb-b-fb.c	Fri Sep 14 14:04:07 2001
+++ linux/drivers/video/pmagb-b-fb.c	Fri Jan  4 22:45:25 2002
@@ -389,7 +389,6 @@
 	 */
 	strcpy(ip->info.modename, "PMAGB-BA");
 	ip->info.changevar = NULL;
-	ip->info.node = -1;
 	ip->info.fbops = &pmagbbfb_ops;
 	ip->info.disp = &disp;
 	ip->info.switch_con = &pmagbbfb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/pvr2fb.c linux/drivers/video/pvr2fb.c
--- linux-2.5.2-pre8/drivers/video/pvr2fb.c	Mon Oct 15 13:36:48 2001
+++ linux/drivers/video/pvr2fb.c	Fri Jan  4 22:45:25 2002
@@ -1034,7 +1034,6 @@
 	
 	strcpy(fb_info.modename, pvr2fb_name);
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
 	fb_info.fbops = &pvr2fb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &pvr2fbcon_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/q40fb.c linux/drivers/video/q40fb.c
--- linux-2.5.2-pre8/drivers/video/q40fb.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/video/q40fb.c	Fri Jan  4 22:45:25 2002
@@ -331,7 +331,6 @@
 	fb_info.switch_con=&q40con_switch;
 	fb_info.updatevar=&q40con_updatevar;
 	fb_info.blank=&q40con_blank;	
-	fb_info.node = -1;
 	fb_info.fbops = &q40fb_ops;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;  /* not as module for now */
 	
diff -u -r linux-2.5.2-pre8/drivers/video/radeonfb.c linux/drivers/video/radeonfb.c
--- linux-2.5.2-pre8/drivers/video/radeonfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/radeonfb.c	Fri Jan  4 22:46:27 2002
@@ -1305,7 +1305,6 @@
 	info = &rinfo->info;
 
 	strcpy (info->modename, rinfo->name);
-        info->node = -1;
         info->flags = FBINFO_FLAG_DEFAULT;
         info->fbops = &radeon_fb_ops;
         info->display_fg = NULL;
diff -u -r linux-2.5.2-pre8/drivers/video/retz3fb.c linux/drivers/video/retz3fb.c
--- linux-2.5.2-pre8/drivers/video/retz3fb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/retz3fb.c	Fri Jan  4 22:46:01 2002
@@ -1422,7 +1422,6 @@
 
 		strcpy(fb_info->modename, retz3fb_name);
 		fb_info->changevar = NULL;
-		fb_info->node = -1;
 		fb_info->fbops = &retz3fb_ops;
 		fb_info->disp = &zinfo->disp;
 		fb_info->switch_con = &z3fb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.2-pre8/drivers/video/riva/fbdev.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/riva/fbdev.c	Fri Jan  4 22:54:11 2002
@@ -1811,7 +1811,6 @@
 	info = &rinfo->info;
 
 	strcpy(info->modename, rinfo->drvr_name);
-	info->node = -1;
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &riva_fb_ops;
 
diff -u -r linux-2.5.2-pre8/drivers/video/sbusfb.c linux/drivers/video/sbusfb.c
--- linux-2.5.2-pre8/drivers/video/sbusfb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/sbusfb.c	Fri Jan  4 22:45:25 2002
@@ -1019,7 +1019,6 @@
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	fix->visual = FB_VISUAL_PSEUDOCOLOR;
 	
-	fb->info.node = -1;
 	fb->info.fbops = &sbusfb_ops;
 	fb->info.disp = disp;
 	strcpy(fb->info.fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/sgivwfb.c linux/drivers/video/sgivwfb.c
--- linux-2.5.2-pre8/drivers/video/sgivwfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/sgivwfb.c	Fri Jan  4 22:45:25 2002
@@ -890,7 +890,6 @@
 
   strcpy(fb_info.modename, sgivwfb_name);
   fb_info.changevar = NULL;
-  fb_info.node = -1;
   fb_info.fbops = &sgivwfb_ops;
   fb_info.disp = &disp;
   fb_info.switch_con = &sgivwfbcon_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/sis/sis_main.c linux/drivers/video/sis/sis_main.c
--- linux-2.5.2-pre8/drivers/video/sis/sis_main.c	Fri Nov  9 14:11:14 2001
+++ linux/drivers/video/sis/sis_main.c	Fri Jan  4 22:54:19 2002
@@ -2766,7 +2766,6 @@
 	sisfb_crtc_to_var (&default_var);
 
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
 	fb_info.fbops = &sisfb_ops;
 	fb_info.disp = &disp;
 	fb_info.switch_con = &sisfb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/skeletonfb.c linux/drivers/video/skeletonfb.c
--- linux-2.5.2-pre8/drivers/video/skeletonfb.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/video/skeletonfb.c	Fri Jan  4 22:45:25 2002
@@ -306,7 +306,6 @@
     fb_info.gen.fbhw->detect();
     strcpy(fb_info.gen.info.modename, "XXX");
     fb_info.gen.info.changevar = NULL;
-    fb_info.gen.info.node = -1;
     fb_info.gen.info.fbops = &xxxfb_ops;
     fb_info.gen.info.disp = &disp;
     fb_info.gen.info.switch_con = &xxxfb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/sstfb.c linux/drivers/video/sstfb.c
--- linux-2.5.2-pre8/drivers/video/sstfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/sstfb.c	Fri Jan  4 22:52:22 2002
@@ -1797,7 +1797,6 @@
 		f_ddprintk("membase_phys: %#lx\n", fb_info.video.base);
 		f_ddprintk("fbbase_virt: %#lx\n", fb_info.video.vbase);
 
-		fb_info.info.node       = -1 ;
 		fb_info.info.flags      = FBINFO_FLAG_DEFAULT;
 		fb_info.info.fbops      = &sstfb_ops;
 		fb_info.info.disp       = &disp;
diff -u -r linux-2.5.2-pre8/drivers/video/stifb.c linux/drivers/video/stifb.c
--- linux-2.5.2-pre8/drivers/video/stifb.c	Fri Feb  9 11:30:23 2001
+++ linux/drivers/video/stifb.c	Fri Jan  4 22:45:25 2002
@@ -166,7 +166,6 @@
 	if ((fb_info.sti = sti_init_roms()) == NULL)
 		return -ENXIO;
 
-	fb_info.gen.info.node = -1;
 	fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
 	fb_info.gen.info.fbops = &stifb_ops;
 	fb_info.gen.info.disp = &disp;
diff -u -r linux-2.5.2-pre8/drivers/video/sun3fb.c linux/drivers/video/sun3fb.c
--- linux-2.5.2-pre8/drivers/video/sun3fb.c	Sun Sep 30 12:26:08 2001
+++ linux/drivers/video/sun3fb.c	Fri Jan  4 22:45:25 2002
@@ -573,7 +573,6 @@
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	fix->visual = FB_VISUAL_PSEUDOCOLOR;
 	
-	fb->info.node = -1;
 	fb->info.fbops = &sun3fb_ops;
 	fb->info.disp = disp;
 	strcpy(fb->info.fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/tdfxfb.c linux/drivers/video/tdfxfb.c
--- linux-2.5.2-pre8/drivers/video/tdfxfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/tdfxfb.c	Fri Jan  4 22:51:57 2002
@@ -1975,7 +1975,6 @@
 	strcpy(fb_info.fb_info.modename, "3Dfx "); 
 	strcat(fb_info.fb_info.modename, name);
 	fb_info.fb_info.changevar  = NULL;
-	fb_info.fb_info.node       = -1;
 	fb_info.fb_info.fbops      = &tdfxfb_ops;
 	fb_info.fb_info.disp       = &fb_info.disp;
 	strcpy(fb_info.fb_info.fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/tgafb.c linux/drivers/video/tgafb.c
--- linux-2.5.2-pre8/drivers/video/tgafb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/tgafb.c	Fri Jan  4 22:45:25 2002
@@ -937,7 +951,6 @@
 
     /* setup framebuffer */
 
-    fb_info.gen.info.node = -1;
     fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
     fb_info.gen.info.fbops = &tgafb_ops;
     fb_info.gen.info.disp = &disp;
diff -u -r linux-2.5.2-pre8/drivers/video/tx3912fb.c linux/drivers/video/tx3912fb.c
--- linux-2.5.2-pre8/drivers/video/tx3912fb.c	Fri Sep  7 09:28:38 2001
+++ linux/drivers/video/tx3912fb.c	Fri Jan  4 22:45:25 2002
@@ -397,7 +397,6 @@
 
 	strcpy(fb_info.modename, TX3912FB_NAME);
 	fb_info.changevar = NULL;
-	fb_info.node = -1;
 	fb_info.fbops = &tx3912fb_ops;
 	fb_info.disp = &global_disp;
 	fb_info.switch_con = &tx3912fbcon_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/valkyriefb.c linux/drivers/video/valkyriefb.c
--- linux-2.5.2-pre8/drivers/video/valkyriefb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/valkyriefb.c	Fri Jan  4 22:46:06 2002
@@ -779,7 +779,6 @@
 static void __init valkyrie_init_info(struct fb_info *info, struct fb_info_valkyrie *p)
 {
 	strcpy(info->modename, p->fix.id);
-	info->node = -1;	/* ??? danj */
 	info->fbops = &valkyriefb_ops;
 	info->disp = &p->disp;
 	strcpy(info->fontname, fontname);
diff -u -r linux-2.5.2-pre8/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux-2.5.2-pre8/drivers/video/vesafb.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/video/vesafb.c	Fri Jan  4 22:48:45 2002
@@ -648,7 +648,6 @@
 	
 	strcpy(fb_info.modename, "VESA VGA");
 	fb_info.changevar = NULL;
-	fb_info.node = NODEV;
 	fb_info.fbops = &vesafb_ops;
 	fb_info.disp=&disp;
 	fb_info.switch_con=&vesafb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/vfb.c linux/drivers/video/vfb.c
--- linux-2.5.2-pre8/drivers/video/vfb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/vfb.c	Fri Jan  4 22:45:25 2002
@@ -404,7 +404,6 @@
 
     strcpy(fb_info.modename, vfb_name);
     fb_info.changevar = NULL;
-    fb_info.node = -1;
     fb_info.fbops = &vfb_ops;
     fb_info.disp = &disp;
     fb_info.switch_con = &vfbcon_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/vga16fb.c linux/drivers/video/vga16fb.c
--- linux-2.5.2-pre8/drivers/video/vga16fb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/vga16fb.c	Fri Jan  4 22:45:25 2002
@@ -926,7 +926,6 @@
 	/* name should not depend on EGA/VGA */
 	strcpy(vga16fb.fb_info.modename, "VGA16 VGA");
 	vga16fb.fb_info.changevar = NULL;
-	vga16fb.fb_info.node = -1;
 	vga16fb.fb_info.fbops = &vga16fb_ops;
 	vga16fb.fb_info.disp=&disp;
 	vga16fb.fb_info.switch_con=&vga16fb_switch;
diff -u -r linux-2.5.2-pre8/drivers/video/virgefb.c linux/drivers/video/virgefb.c
--- linux-2.5.2-pre8/drivers/video/virgefb.c	Wed Nov 14 14:52:20 2001
+++ linux/drivers/video/virgefb.c	Fri Jan  4 22:45:25 2002
@@ -1168,7 +1168,6 @@
 
 	    strcpy(fb_info.modename, virgefb_name);
 	    fb_info.changevar = NULL;
-	    fb_info.node = -1;
 	    fb_info.fbops = &virgefb_ops;
 	    fb_info.disp = &disp;
 	    fb_info.switch_con = &Cyberfb_switch;

--ew6BAiZeqk4r7MaW--
