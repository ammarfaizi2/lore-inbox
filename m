Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUBBSoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUBBSoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:44:01 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:40083 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265802AbUBBSns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:43:48 -0500
Date: Mon, 2 Feb 2004 19:43:43 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 6/42]
Message-ID: <20040202184343.GF6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aty128fb.c:1066: warning: `aty128_set_crt_enable' defined but not used
aty128fb.c:1076: warning: `aty128_set_lcd_enable' defined but not used
aty128fb.c:2485: warning: unused variable `fb'
aty128fb.c:2486: warning: unused variable `value'
aty128fb.c:2487: warning: unused variable `rc'

aty128_set_crt_enable and  aty128_set_lcd_enable and  the vars  are used
only when CONFIG_PMAC_PBOOK is defined.

font and mode are used only when the driver is modular.

nomttr is used only when CONFIG_MTRR is defined.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/video/aty128fb.c linux-2.4/drivers/video/aty128fb.c
--- linux-2.4-vanilla/drivers/video/aty128fb.c	Tue Nov 11 17:51:39 2003
+++ linux-2.4/drivers/video/aty128fb.c	Sat Jan 31 16:45:23 2004
@@ -227,9 +227,10 @@
 static char fontname[40] __initdata = { 0 };
 
 static int  noaccel __initdata = 0;
+#ifdef MODULE
 static char *font __initdata = NULL;
 static char *mode __initdata = NULL;
-static int  nomtrr __initdata = 0;
+#endif
 
 static char *mode_option __initdata = NULL;
 
@@ -244,6 +245,7 @@
 #endif
 
 #ifdef CONFIG_MTRR
+static int nomtrr __initdata = 0;
 static int mtrr = 1;
 #endif
 
@@ -1061,6 +1063,7 @@
     return 0;
 }
 
+#ifdef CONFIG_PMAC_PBOOK
 static void
 aty128_set_crt_enable(struct fb_info_aty128 *info, int on)
 {
@@ -1096,6 +1099,7 @@
 	aty_st_le32(LVDS_GEN_CNTL, reg);
     }
 }
+#endif /* CONFIG_PMAC_PBOOK */
 
 static void
 aty128_set_pll(struct aty128_pll *pll, const struct fb_info_aty128 *info)
@@ -2482,12 +2486,12 @@
 static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 		       u_long arg, int con, struct fb_info *info)
 {
+#ifdef CONFIG_PMAC_PBOOK
     struct fb_info_aty128 *fb = (struct fb_info_aty128 *)info;
     u32 value;
     int rc;
     
     switch (cmd) {
-#ifdef CONFIG_PMAC_PBOOK
     case FBIO_ATY128_SET_MIRROR:
     	if (fb->chip_gen != rage_M3)
     		return -EINVAL;
@@ -2506,11 +2510,13 @@
     		return -EINVAL;
 	value = (fb->crt_on << 1) | fb->lcd_on;
     	return put_user(value, (__u32*)arg);
-#endif
     default:
 	return -EINVAL;
     }
     return 0;
+#else
+    return -EINVAL;
+#endif
 }
 
 #ifdef CONFIG_PMAC_BACKLIGHT

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Dicono che  il cane sia  il miglior  amico dell'uomo. Secondo me  non e`
vero. Quanti dei vostri amici avete fatto castrare, recentemente?
