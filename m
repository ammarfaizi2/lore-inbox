Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTEMVgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEMVgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:36:00 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:28172 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261338AbTEMVff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:35:35 -0400
Date: Tue, 13 May 2003 22:48:18 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Framebuffer console fix
Message-ID: <Pine.LNX.4.44.0305132246450.12672-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a oops that happens when we map a framebuffer device to 
a non-existant console. Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1081  -> 1.1082 
#	drivers/video/console/fbcon.c	1.101   -> 1.102  
#	drivers/video/console/fbcon.h	1.30    -> 1.31   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	jsimmons@maxwell.earthlink.net	1.1082
# [FBCON] set_con2fb_map wasn't testing to see the VC we where mapping to actually exist. Now it does. 
# 
#         I add code to fbcon_cursor to reset the hotspot if it was changed by userland. 
# --------------------------------------------
#
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Mon May 12 16:38:57 2003
+++ b/drivers/video/console/fbcon.c	Mon May 12 16:38:57 2003
@@ -294,13 +294,16 @@
  *	Maps a virtual console @unit to a frame buffer device
  *	@newidx.
  */
-void set_con2fb_map(int unit, int newidx)
+int set_con2fb_map(int unit, int newidx)
 {
 	struct vc_data *vc = vc_cons[unit].d;
 
+	if (!vc)
+		return -ENODEV;
 	con2fb_map[unit] = newidx;
 	fbcon_is_default = (vc->vc_sw == &fb_con) ? 1 : 0;
 	take_over_console(&fb_con, unit, unit, fbcon_is_default);
+	return 0;
 }
 
 /*
@@ -990,6 +993,11 @@
 			cursor.image.height = vc->vc_font.height;
 			cursor.image.width = vc->vc_font.width;
 			cursor.set |= FB_CUR_SETSIZE;
+		}
+
+		if (info->cursor.hot.x || info->cursor.hot.y) {
+			cursor.hot.x = cursor.hot.y = 0;
+			cursor.set |= FB_CUR_SETHOT;
 		}
 
 		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)) {
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	Mon May 12 16:38:57 2003
+++ b/drivers/video/console/fbcon.h	Mon May 12 16:38:57 2003
@@ -38,7 +38,7 @@
 
 /* drivers/video/console/fbcon.c */
 extern char con2fb_map[MAX_NR_CONSOLES];
-extern void set_con2fb_map(int unit, int newidx);
+extern int set_con2fb_map(int unit, int newidx);
 
     /*
      *  Attribute Decoding

