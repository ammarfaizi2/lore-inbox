Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUBPApd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUBPApd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:45:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:16287 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265268AbUBPApP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:45:15 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: earny@net4u.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200402160138.02212.earny@net4u.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <1076889243.11392.130.camel@gaston> <200402160129.32011.earny@net4u.de>
	 <200402160138.02212.earny@net4u.de>
Content-Type: text/plain
Message-Id: <1076892215.6957.141.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 11:43:36 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 11:38, Ernst Herzberg wrote:
> On Montag, 16. Februar 2004 01:29, Ernst Herzberg wrote:
> 
> Haaaalt! Yes, works, __but__:
> 
> If you start X, the console is gone. No recovery but reboot possible.

Using ATI binary drivers or XFree ones ? What XFree version ? X
loves to screw things up on console save/restore in interesting
ways. I think it +/- puts the chip back into some VGA mode...

Another patch I posted earlier (copied below) _might_ help as it
force radeonfb to reprogram the mode. Let me know.

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
 


