Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbUBOHJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUBOHJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:09:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:32157 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264267AbUBOHJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:09:35 -0500
Subject: [PATCH] shield fbdev operations with console semaphore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1076828905.6957.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:08:26 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew !

This patch fixes the fbdev ioctl's and fbcon cursor management
with the console semaphore, which is the best we can do at this
point in 2.6, thus fixing a bunch of races where we could have,
for example, tried to blit while changing mode, etc..

Ben.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/15 15:39:51+11:00 benh@kernel.crashing.org 
#   Shield a bunch of fbdev operations with console semaphore
#   (and small cleanup of timer code)
# 
# drivers/video/fbmem.c
#   2004/02/15 15:36:49+11:00 benh@kernel.crashing.org +16 -4
#   Shield a bunch of fbdev operations with console semaphore
#   (and small cleanup of timer code)
# 
# drivers/video/console/fbcon.c
#   2004/02/15 15:36:49+11:00 benh@kernel.crashing.org +4 -3
#   Shield a bunch of fbdev operations with console semaphore
#   (and small cleanup of timer code)
# 
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Sun Feb 15 17:04:36 2004
+++ b/drivers/video/console/fbcon.c	Sun Feb 15 17:04:36 2004
@@ -198,8 +198,10 @@
 	/* Test to see if the cursor is erased but still on */
 	if (!info || (info->cursor.rop == ROP_COPY))
 		return;
+	acquire_console_sem();
 	info->cursor.enable ^= 1;
 	info->fbops->fb_cursor(info, &info->cursor);
+	release_console_sem();
 }
 
 #if (defined(__arm__) && defined(IRQ_VSYNCPULSE)) || defined(CONFIG_ATARI) || defined(CONFIG_MAC)
@@ -226,8 +228,7 @@
 	struct fb_info *info = (struct fb_info *) dev_addr;
 	
 	schedule_work(&info->queue);	
-	cursor_timer.expires = jiffies + HZ / 5;
-	add_timer(&cursor_timer);
+	mod_timer(&cursor_timer, jiffies + HZ/5);
 }
 
 int __init fb_console_setup(char *this_opt)
@@ -676,7 +677,7 @@
 	if (!info->queue.func) {
 		INIT_WORK(&info->queue, fb_flashcursor, info);
 		
-		cursor_timer.expires = jiffies + HZ / 50;
+		cursor_timer.expires = jiffies + HZ / 5;
 		cursor_timer.data = (unsigned long ) info;
 		add_timer(&cursor_timer);
 	}
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Sun Feb 15 17:04:36 2004
+++ b/drivers/video/fbmem.c	Sun Feb 15 17:04:36 2004
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/linux_logo.h>
 #include <linux/proc_fs.h>
+#include <linux/console.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
@@ -979,7 +980,7 @@
 	struct fb_con2fbmap con2fb;
 #endif
 	struct fb_cmap cmap;
-	int i;
+	int i, rc;
 	
 	if (!fb)
 		return -ENODEV;
@@ -990,7 +991,9 @@
 	case FBIOPUT_VSCREENINFO:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;
+		acquire_console_sem();
 		i = fb_set_var(info, &var);
+		release_console_sem();
 		if (i) return i;
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
 			return -EFAULT;
@@ -1009,13 +1012,19 @@
 	case FBIOPAN_DISPLAY:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;
-		if ((i = fb_pan_display(info, &var)))
+		acquire_console_sem();
+		i = fb_pan_display(info, &var);
+		release_console_sem();
+		if (i)
 			return i;
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
 			return -EFAULT;
 		return 0;
 	case FBIO_CURSOR:
-		return (fb_cursor(info, (struct fb_cursor *) arg));
+		acquire_console_sem();
+		rc = fb_cursor(info, (struct fb_cursor *) arg);
+		release_console_sem();
+		return rc;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 	case FBIOGET_CON2FBMAP:
 		if (copy_from_user(&con2fb, (void *)arg, sizeof(con2fb)))
@@ -1045,7 +1054,10 @@
 		return 0;
 #endif	/* CONFIG_FRAMEBUFFER_CONSOLE */
 	case FBIOBLANK:
-		return fb_blank(info, arg);
+		acquire_console_sem();
+		i = fb_blank(info, arg);
+		release_console_sem();
+		return i;
 	default:
 		if (fb->fb_ioctl == NULL)
 			return -EINVAL;


