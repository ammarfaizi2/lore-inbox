Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSF2Wts>; Sat, 29 Jun 2002 18:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSF2Wtr>; Sat, 29 Jun 2002 18:49:47 -0400
Received: from p015.as-l031.contactel.cz ([212.65.234.207]:40832 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S314395AbSF2Wto>;
	Sat, 29 Jun 2002 18:49:44 -0400
Date: Sun, 30 Jun 2002 02:28:34 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] 2.5.24 matroxfb memory corruption
Message-ID: <20020630002834.GG25118@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Linus, please apply this. When James converted all drivers to unified
do_install_cmap(), he blindly changed also matroxfb, which happily
uses fbcon.currcon == -1. This caused memory corruption because of
memory before fb_display[] array was overwritten.
  Default do_install_cmap() also installed invalid default color map
in some matroxfb resolutions. Not all world have >= 4bpp.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	Fri Jun 21 00:53:55 2002
+++ linux/drivers/video/matrox/matroxfb_base.c	Sun Jun 30 02:19:15 2002
@@ -141,6 +141,19 @@
 
 
 /* --------------------------------------------------------------------- */
+static inline void my_install_cmap(WPMINFO2)
+{
+	/* Do not touch this code if you do not understand what it does! */
+	/* Never try to use do_install_cmap() instead. It is crap. */
+	struct fb_cmap* cmap = &ACCESS_FBINFO(currcon_display)->cmap;
+
+	if (cmap->len)
+		fb_set_cmap(cmap, 1, &ACCESS_FBINFO(fbcon));
+	else
+		fb_set_cmap(fb_default_cmap(ACCESS_FBINFO(curr.cmap_len)),
+			    1, &ACCESS_FBINFO(fbcon));
+}
+
 
 static void matrox_pan_var(WPMINFO struct fb_var_screeninfo *var) {
 	unsigned int pos;
@@ -869,7 +882,7 @@
 				up_read(&ACCESS_FBINFO(altout.lock));
 			}
 			matrox_cfbX_init(PMINFO display);
-			do_install_cmap(ACCESS_FBINFO(fbcon.currcon),&ACCESS_FBINFO(fbcon));
+			my_install_cmap(PMINFO2);
 #if defined(CONFIG_FB_COMPAT_XPMAC)
 			if (console_fb_info == &ACCESS_FBINFO(fbcon)) {
 				int vmode, cmode;
diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jun 21 00:53:48 2002
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	Sun Jun 30 02:19:15 2002
@@ -84,6 +84,19 @@
 #undef m2info
 }
 
+static inline void my_install_cmap(struct matroxfb_dh_fb_info* m2info)
+{
+	/* Do not touch this code if you do not understand what it does! */
+	/* Never try to use do_install_cmap() instead. It is crap. */
+	struct fb_cmap* cmap = &m2info->currcon_display->cmap;
+	
+	if (cmap->len)
+		fb_set_cmap(cmap, 1, &m2info->fbcon);
+	else
+		fb_set_cmap(fb_default_cmap(16), 1, &m2info->fbcon);
+}
+
+
 static void matroxfb_dh_restore(struct matroxfb_dh_fb_info* m2info,
 		struct my_timming* mt,
 		struct display* p,
@@ -439,7 +452,7 @@
 			up_read(&ACCESS_FBINFO(altout.lock));
 		}
 		matroxfb_dh_cfbX_init(m2info, p);
-		do_install_cmap(ACCESS_FBINFO(fbcon.currcon), &ACCESS_FBINFO(fbcon));
+		my_install_cmap(m2info);
 	}
 	return 0;
 #undef m2info
