Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUBOHRP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUBOHRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:17:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:35229 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264278AbUBOHQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:16:49 -0500
Subject: [PATCH] fbdev state management
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1076829344.6960.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:15:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch add some "state" information for power management
to fbdev's, along with a notifier mecanism to inform clients
of state changes. It also "uses" this mecanism in the function
fb_set_suspend() which was an empty placeholder previously,
and "shields" various places that access the HW when state
isn't running. (It's best to not call them in the first place,
but the current state of fbcon makes that _very_ difficult)

Ben.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/15 17:06:41+11:00 benh@kernel.crashing.org 
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
# include/linux/fb.h
#   2004/02/15 17:06:27+11:00 benh@kernel.crashing.org +21 -0
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
# drivers/video/softcursor.c
#   2004/02/15 17:06:27+11:00 benh@kernel.crashing.org +3 -0
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
# drivers/video/fbmem.c
#   2004/02/15 17:06:27+11:00 benh@kernel.crashing.org +47 -2
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
# drivers/video/console/fbcon.c
#   2004/02/15 17:06:27+11:00 benh@kernel.crashing.org +8 -2
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
# drivers/video/cfbimgblt.c
#   2004/02/15 17:06:27+11:00 benh@kernel.crashing.org +3 -0
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
# drivers/video/cfbfillrect.c
#   2004/02/15 17:06:27+11:00 benh@kernel.crashing.org +3 -0
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
# drivers/video/cfbcopyarea.c
#   2004/02/15 17:06:27+11:00 benh@kernel.crashing.org +3 -0
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
# drivers/video/aty/radeon_accel.c
#   2004/02/15 17:06:27+11:00 benh@kernel.crashing.org +4 -4
#   Add fbdev "state" for power management, a notifer for clients to
#   be notified of states change, and shield some low level operations
#   when the fbdev state isn't running
# 
diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	Sun Feb 15 17:07:11 2004
+++ b/drivers/video/aty/radeon_accel.c	Sun Feb 15 17:07:11 2004
@@ -28,7 +28,7 @@
 	struct fb_fillrect modded;
 	int vxres, vyres;
   
-	if (rinfo->asleep)
+	if (info->state != FBINFO_STATE_RUNNING)
 		return;
 	if (radeon_accel_disabled()) {
 		cfb_fillrect(info, region);
@@ -81,7 +81,7 @@
 	modded.width  = area->width;
 	modded.height = area->height;
   
-	if (rinfo->asleep)
+	if (info->state != FBINFO_STATE_RUNNING)
 		return;
 	if (radeon_accel_disabled()) {
 		cfb_copyarea(info, area);
@@ -108,7 +108,7 @@
 {
 	struct radeonfb_info *rinfo = info->par;
 
-	if (rinfo->asleep)
+	if (info->state != FBINFO_STATE_RUNNING)
 		return;
 	radeon_engine_idle();
 
@@ -119,7 +119,7 @@
 {
 	struct radeonfb_info *rinfo = info->par;
 
-	if (rinfo->asleep)
+	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
 	radeon_engine_idle();
 
diff -Nru a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
--- a/drivers/video/cfbcopyarea.c	Sun Feb 15 17:07:11 2004
+++ b/drivers/video/cfbcopyarea.c	Sun Feb 15 17:07:11 2004
@@ -346,6 +346,9 @@
 	int dst_idx = 0, src_idx = 0, rev_copy = 0;
 	unsigned long *dst = NULL, *src = NULL;
 
+	if (p->state != FBINFO_STATE_RUNNING)
+		return;
+
 	/* We want rotation but lack hardware to do it for us. */
 	if (!p->fbops->fb_rotate && p->var.rotate) {
 	}	
diff -Nru a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
--- a/drivers/video/cfbfillrect.c	Sun Feb 15 17:07:11 2004
+++ b/drivers/video/cfbfillrect.c	Sun Feb 15 17:07:11 2004
@@ -367,6 +367,9 @@
 	unsigned long *dst;
 	int dst_idx, left;
 
+	if (p->state != FBINFO_STATE_RUNNING)
+		return;
+
 	/* We want rotation but lack hardware to do it for us. */
 	if (!p->fbops->fb_rotate && p->var.rotate) {
 	}	
diff -Nru a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
--- a/drivers/video/cfbimgblt.c	Sun Feb 15 17:07:11 2004
+++ b/drivers/video/cfbimgblt.c	Sun Feb 15 17:07:11 2004
@@ -275,6 +275,9 @@
 	int x2, y2, vxres, vyres;
 	u8 *dst1;
 
+	if (p->state != FBINFO_STATE_RUNNING)
+		return;
+
 	vxres = p->var.xres_virtual;
 	vyres = p->var.yres_virtual;
 	/* 
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Sun Feb 15 17:07:11 2004
+++ b/drivers/video/console/fbcon.c	Sun Feb 15 17:07:11 2004
@@ -195,8 +195,8 @@
 {
 	struct fb_info *info = (struct fb_info *) private;
 
-	/* Test to see if the cursor is erased but still on */
-	if (!info || (info->cursor.rop == ROP_COPY))
+	if (!info || info->state != FBINFO_STATE_RUNNING ||
+	    info->cursor.rop == ROP_COPY)
 		return;
 	acquire_console_sem();
 	info->cursor.enable ^= 1;
@@ -939,6 +939,8 @@
 
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
 
 	if (!height || !width)
 		return;
@@ -963,6 +965,8 @@
 
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
 
 	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return;
@@ -977,6 +981,8 @@
 	struct display *p = &fb_display[vc->vc_num];
 
 	if (!info->fbops->fb_blank && console_blanked)
+		return;
+	if (info->state != FBINFO_STATE_RUNNING)
 		return;
 
 	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Sun Feb 15 17:07:11 2004
+++ b/drivers/video/fbmem.c	Sun Feb 15 17:07:11 2004
@@ -396,6 +396,7 @@
 
 static initcall_t pref_init_funcs[FB_MAX];
 static int num_pref_init_funcs __initdata = 0;
+static struct notifier_block *fb_notifier_list;
 struct fb_info *registered_fb[FB_MAX];
 int num_registered_fb;
 
@@ -695,8 +696,8 @@
 	struct fb_image image;
 	int x;
 
-	/* Return if the frame buffer is not mapped */
-	if (fb_logo.logo == NULL)
+	/* Return if the frame buffer is not mapped or suspended */
+	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
 	image.depth = fb_logo.depth;
@@ -788,6 +789,9 @@
 	if (!info || ! info->screen_base)
 		return -ENODEV;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
+
 	if (info->fbops->fb_read)
 		return info->fbops->fb_read(file, buf, count, ppos);
 	
@@ -823,6 +827,9 @@
 	if (!info || !info->screen_base)
 		return -ENODEV;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
+
 	if (info->fbops->fb_write)
 		return info->fbops->fb_write(file, buf, count, ppos);
 	
@@ -949,6 +956,8 @@
 			fb_pan_display(info, &info->var);
 
 			fb_set_cmap(&info->cmap, 1, info);
+
+			notifier_call_chain(&fb_notifier_list, FB_EVENT_MODE_CHANGE, info);
 		}
 	}
 	return 0;
@@ -1297,8 +1306,42 @@
 	return 0;
 }
 
+/**
+ *	fb_register_client - register a client notifier
+ *	@nb: notifier block to callback on events
+ */
+int fb_register_client(struct notifier_block *nb)
+{
+	return notifier_chain_register(&fb_notifier_list, nb);
+}
+
+/**
+ *	fb_unregister_client - unregister a client notifier
+ *	@nb: notifier block to callback on events
+ */
+int fb_unregister_client(struct notifier_block *nb)
+{
+	return notifier_chain_unregister(&fb_notifier_list, nb);
+}
+
+/**
+ *	fb_set_suspend - low level driver signals suspend
+ *	@info: framebuffer affected
+ *	@state: 0 = resuming, !=0 = suspending
+ *
+ *	This is meant to be used by low level drivers to
+ * 	signal suspend/resume to the core & clients.
+ *	It must be called with the console semaphore held
+ */
 void fb_set_suspend(struct fb_info *info, int state)
 {
+	if (state) {
+		notifier_call_chain(&fb_notifier_list, FB_EVENT_SUSPEND, info);
+		info->state = FBINFO_STATE_SUSPENDED;
+	} else {
+		info->state = FBINFO_STATE_RUNNING;
+		notifier_call_chain(&fb_notifier_list, FB_EVENT_RESUME, info);
+	}
 }
 
 /**
@@ -1415,5 +1458,7 @@
 EXPORT_SYMBOL(move_buf_unaligned);
 EXPORT_SYMBOL(move_buf_aligned);
 EXPORT_SYMBOL(fb_set_suspend);
+EXPORT_SYMBOL(fb_register_client);
+EXPORT_SYMBOL(fb_unregister_client);
 
 MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/softcursor.c b/drivers/video/softcursor.c
--- a/drivers/video/softcursor.c	Sun Feb 15 17:07:11 2004
+++ b/drivers/video/softcursor.c	Sun Feb 15 17:07:11 2004
@@ -48,6 +48,9 @@
 		info->cursor.image.depth = cursor->image.depth;
 	}	
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return 0;
+
 	s_pitch = (info->cursor.image.width + 7) >> 3;
 	dsize = s_pitch * info->cursor.image.height;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Sun Feb 15 17:07:11 2004
+++ b/include/linux/fb.h	Sun Feb 15 17:07:11 2004
@@ -340,6 +340,24 @@
 struct file;
 
 /*
+ * Register/unregister for framebuffer events
+ */
+
+/*	The resolution of the passed in fb_info about to change */ 
+#define FB_EVENT_MODE_CHANGE		0x01
+/*	The display on this fb_info is beeing suspended, no access to the
+ *	framebuffer is allowed any more after that call returns
+ */
+#define FB_EVENT_SUSPEND		0x02
+/*	The display on this fb_info was resumed, you can restore the display
+ *	if you own it
+ */
+#define FB_EVENT_RESUME			0x03
+
+extern int fb_register_client(struct notifier_block *nb);
+extern int fb_unregister_client(struct notifier_block *nb);
+
+/*
  * Pixmap structure definition
  *
  * The purpose of this structure is to translate data
@@ -447,6 +465,9 @@
 	struct vc_data *display_fg;	/* Console visible on this display */
 	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
+#define FBINFO_STATE_RUNNING	0
+#define FBINFO_STATE_SUSPENDED	1
+	u32 state;			/* Hardware state i.e suspend */
 	/* From here on everything is device dependent */
 	void *par;	
 };


