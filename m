Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUAFA0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbUAFA0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:26:37 -0500
Received: from 202.46.136.55.interact.com.au ([202.46.136.55]:64368 "EHLO
	gaston") by vger.kernel.org with ESMTP id S265301AbUAFA0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:26:33 -0500
Subject: Get console sem on fbdev ioctls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073348711.761.165.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 11:25:12 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Along with my VT race fixes I sent earlier, this is a patch (that may
need to be applied manually, I hacked the patch file a bit since my
tree is so different from yours at this point). It takes the console
semaphore on userland initiated mode change, pan display, ... ioctls.

Maybe more are required... This is the basics for at least fbset operations
to be "safe" (vs. printk/blanking and vs. the console resize code).

Note that with that and the VT fixes, I can properly now call vc_resize
instead of fbcon_resize in fbcon when getting a mode changed callback,
and that works really better.

I basically do that if cols and rows are seen to have changed:

	vc_resize(vc->vc_num, cols, rows);
	if (CON_IS_VISIBLE(vc)) {
		accel_clear_margins(vc, info, 0);
		update_screen(vc->vc_num);
	}

Though for stty to work fine, I also had to do proper mode selection/validation
for which I added this FB_ACTIVATE_FIND option (see my other email on the subject)
along with proper support in radeonfb.


diff -urN linux-2.5/drivers/video/fbmem.c linuxppc-2.5-benh/drivers/video/fbmem.c
--- linux-2.5/drivers/video/fbmem.c	2004-01-06 10:05:18.708660576 +1100
+++ linuxppc-2.5-benh/drivers/video/fbmem.c	2003-12-31 12:38:25.000000000 +1100
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/linux_logo.h>
 #include <linux/proc_fs.h>
+#include <linux/console.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
@@ -984,7 +995,9 @@
 	case FBIOPUT_VSCREENINFO:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;
+		acquire_console_sem();
 		i = fb_set_var(info, &var);
+		release_console_sem();
 		if (i) return i;
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
 			return -EFAULT;
@@ -1003,7 +1016,10 @@
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
@@ -1039,7 +1055,10 @@
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

