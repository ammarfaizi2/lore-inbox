Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUBPEDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUBPEDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:03:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:42399 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265362AbUBPEDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:03:24 -0500
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Eger <eger@theboonies.us>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
Content-Type: text/plain
Message-Id: <1076904084.12300.189.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 15:01:24 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hey ben - shouldn't radeonfb_set_par() have been called when we switched 
> out of X?  If that's not getting done, that explains the interlacing in 
> the other reports too -- the accel engine only gets reset if set_par() is 
> called to knock the video card back into console mode...

No, it's not. I posted a patch fixing that. Enclosed again below.

(Doesn't yet switch the case where a single console switches from
KD_GRAPHICS back to KD_TEXT but handle the case of switching from
a KD_GRAPHICS VT to a KD_TEXT VT).

> ps - hey ben, do we need both noaccel and radeonfb_noaccel? 
>       i don't get it...

The "non-static" value is radeonfb_noaccel (to avoid clashing
with other drivers exposing a "noaccel" variable). The module
param is "noaccel", I don't want to change it. Taht all sucks,
I know, I'll see if I can come up with a better solution.

Ben.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/16 09:02:33+11:00 benh@kernel.crashing.org 
#   fbcon resets engine on gfx -> text  switch
# 
# include/linux/fb.h
#   2004/02/16 09:02:20+11:00 benh@kernel.crashing.org +1 -0
#   fbcon resets engine on gfx -> text  switch
# 
# drivers/video/riva/fbdev.c
#   2004/02/16 09:02:19+11:00 benh@kernel.crashing.org +2 -1
#   fbcon resets engine on gfx -> text  switch
# 
# drivers/video/fbmem.c
#   2004/02/16 09:02:19+11:00 benh@kernel.crashing.org +2 -1
#   fbcon resets engine on gfx -> text  switch
# 
# drivers/video/console/fbcon.c
#   2004/02/16 09:02:19+11:00 benh@kernel.crashing.org +23 -6
#   fbcon resets engine on gfx -> text  switch
# 
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Mon Feb 16 09:03:33 2004
+++ b/drivers/video/console/fbcon.c	Mon Feb 16 09:03:33 2004
@@ -1598,8 +1598,8 @@
 			height, width);
 }
 
-static int fbcon_resize(struct vc_data *vc, unsigned int width, 
-			unsigned int height)
+static int fbcon_do_resize(struct vc_data *vc, unsigned int width, 
+			   unsigned int height, int force)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
@@ -1607,13 +1607,14 @@
 	int err; int x_diff, y_diff;
 	int fw = vc->vc_font.width;
 	int fh = vc->vc_font.height;
+	int rc = 0;
 
 	var.xres = width * fw;
 	var.yres = height * fh;
 	x_diff = info->var.xres - var.xres;
 	y_diff = info->var.yres - var.yres;
 	if (x_diff < 0 || x_diff > fw ||
-	   (y_diff < 0 || y_diff > fh)) {
+	    y_diff < 0 || y_diff > fh || force) {
 		var.activate = FB_ACTIVATE_TEST;
 		err = fb_set_var(info, &var);
 		if (err || width > var.xres/fw ||
@@ -1621,18 +1622,28 @@
 			return -EINVAL;
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		var.activate = FB_ACTIVATE_NOW;
-		fb_set_var(info, &var);
+		if (force)
+			var.activate |= FB_ACTIVATE_FORCE;
+		if (fb_set_var(info, &var) == 0)
+			rc = 1;
 	}
 	p->vrows = var.yres_virtual/fh;
 	if (var.yres > (fh * (height + 1)))
 		p->vrows -= (var.yres - (fh * height)) / fh;
-	return 0;
+	return rc;
+}
+
+static int fbcon_resize(struct vc_data *vc, unsigned int width, 
+			unsigned int height)
+{
+	return fbcon_do_resize(vc, width, height, 0);
 }
 
 static int fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
+	int gfx_to_text = 0;
 
 	if (softback_top) {
 		int l = fbcon_softback_size / vc->vc_size_row;
@@ -1659,7 +1670,13 @@
 	}
 	if (info)
 		info->var.yoffset = p->yscroll = 0;
-        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+
+	if (info->currcon == -1 ||
+	    (vt_cons[info->currcon]->vc_mode != KD_TEXT &&
+	     vt_cons[vc->vc_num]->vc_mode == KD_TEXT))
+		gfx_to_text = 1;
+
+        fbcon_do_resize(vc, vc->vc_cols, vc->vc_rows, gfx_to_text);
 	switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
 		scrollback_phys_max = p->vrows - vc->vc_rows;
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Mon Feb 16 09:03:33 2004
+++ b/drivers/video/fbmem.c	Mon Feb 16 09:03:33 2004
@@ -938,7 +938,8 @@
 {
 	int err;
 
-	if (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
+	if ((var->activate & FB_ACTIVATE_FORCE) ||
+	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
 		if (!info->fbops->fb_check_var) {
 			*var = info->var;
 			return 0;
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Mon Feb 16 09:03:33 2004
+++ b/drivers/video/riva/fbdev.c	Mon Feb 16 09:03:33 2004
@@ -1615,8 +1615,9 @@
 }
 
 #ifdef CONFIG_PPC_OF
-static int riva_get_EDID_OF(struct riva_par *par, struct pci_dev *pd)
+static int riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 {
+	struct riva_par *par = (struct riva_par *) info->par;
 	struct device_node *dp;
 	unsigned char *pedid = NULL;
 
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Mon Feb 16 09:03:33 2004
+++ b/include/linux/fb.h	Mon Feb 16 09:03:33 2004
@@ -152,6 +152,7 @@
 #define FB_ACTIVATE_VBL	       16	/* activate values on next vbl  */
 #define FB_CHANGE_CMAP_VBL     32	/* change colormap on vbl	*/
 #define FB_ACTIVATE_ALL	       64	/* change all VCs on this fb	*/
+#define FB_ACTIVATE_FORCE     128	/* force apply even when no change*/
 
 #define FB_ACCELF_TEXT		1	/* text mode acceleration */
 


