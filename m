Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTFOS7z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTFOS7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:59:55 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:51758 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262687AbTFOS7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:59:51 -0400
Date: Sun, 15 Jun 2003 21:10:30 +0200
Message-Id: <200306151910.h5FJAU0S008580@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fbcon fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fbcon:
  - Make PROC_CONSOLE() return -1 when the virtual console does not belong to
    the specified fbdev. This way we prevent messing with the wrong fb_info[i]
    later when running fbset from the `wrong' virtual console on multi-headed
    systems.
  - Validate the current cursor position before undrawing the cursor in
    fbcon_cursor(). If we just shrank the frame buffer size, the old cursor
    position may now lay outside the frame buffer region.

--- linux-2.4.x/drivers/video/fbcon.c.orig	Wed Apr  2 13:26:09 2003
+++ linux-2.4.x/drivers/video/fbcon.c	Wed Apr  9 15:33:07 2003
@@ -272,23 +272,22 @@
 int PROC_CONSOLE(const struct fb_info *info)
 {
         int fgc;
-        
-        if (info->display_fg != NULL)
-                fgc = info->display_fg->vc_num;
-        else
-                return -1;
-                
-        if (!current->tty)
-                return fgc;
-
-        if (current->tty->driver.type != TTY_DRIVER_TYPE_CONSOLE)
-                /* XXX Should report error here? */
-                return fgc;
 
-        if (MINOR(current->tty->device) < 1)
-                return fgc;
+	if (info->display_fg == NULL)
+		return -1;
 
-        return MINOR(current->tty->device) - 1;
+        if (!current->tty ||
+	    current->tty->driver.type != TTY_DRIVER_TYPE_CONSOLE ||
+	    MINOR(current->tty->device) < 1)
+		fgc = info->display_fg->vc_num;
+	else
+		fgc = MINOR(current->tty->device)-1;
+
+	/* Does this virtual console belong to the specified fbdev? */
+	if (fb_display[fgc].fb_info != info)
+		return -1;
+
+	return fgc;
 }
 
 
@@ -925,8 +924,9 @@
 	return;
 
     cursor_on = 0;
-    if (cursor_drawn)
-        p->dispsw->revc(p, p->cursor_x, real_y(p, p->cursor_y));
+    if (cursor_drawn && p->cursor_x < conp->vc_cols &&
+	p->cursor_y < conp->vc_rows)
+	p->dispsw->revc(p, p->cursor_x, real_y(p, p->cursor_y));
 
     p->cursor_x = conp->vc_x;
     p->cursor_y = y;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
