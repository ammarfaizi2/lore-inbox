Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUBOH3N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 02:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUBOH3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 02:29:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:37277 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264286AbUBOH3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 02:29:06 -0500
Subject: [PATCH] fbcon notified of suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       James Simmons <jsimmons@infradead.org>
Content-Type: text/plain
Message-Id: <1076830083.6960.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 18:28:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch makes fbcon ask for notification of events from fbdev to
deal with suspend/resume (stop cursor on suspend, refresh screen on
resume). Could probably do more (like dealing better with the cursor
timer), but this simple implementation works fine enough for now.

Ben.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/15 18:19:47+11:00 benh@kernel.crashing.org 
#   fbcon request suspend/resume events from fbdev's and uses that
#   to refresh the display properly on wakeup
# 
# drivers/video/console/fbcon.c
#   2004/02/15 18:19:23+11:00 benh@kernel.crashing.org +52 -0
#   fbcon request suspend/resume events from fbdev's and uses that
#   to refresh the display properly on wakeup
# 
diff -Nru a/drivers/video/console/fbcon.c
b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Sun Feb 15 18:22:04 2004
+++ b/drivers/video/console/fbcon.c	Sun Feb 15 18:22:04 2004
@@ -2266,6 +2266,39 @@
 	return 0;
 }
 
+static void fbcon_suspended(struct fb_info *info)
+{
+	/* Clear cursor, restore saved data */
+	info->cursor.enable = 0;
+	info->fbops->fb_cursor(info, &info->cursor);
+}
+
+static void fbcon_resumed(struct fb_info *info)
+{
+	struct vc_data *vc;
+
+	if (info->currcon < 0)
+		return;
+	vc = vc_cons[info->currcon].d;
+
+	update_screen(vc->vc_num);
+}
+static int fbcon_event_notify(struct notifier_block *self, 
+			      unsigned long action, void *data)
+{
+	struct fb_info *info = (struct fb_info *) data;
+
+	switch(action) {
+	case FB_EVENT_SUSPEND:
+		fbcon_suspended(info);
+		break;
+	case FB_EVENT_RESUME:
+		fbcon_resumed(info);
+		break;
+	}
+	return 0;
+}
+
 /*
  *  The console `switch' structure for the frame buffer based console
  */
@@ -2292,16 +2325,35 @@
 	.con_resize             = fbcon_resize,
 };
 
+static struct notifier_block fbcon_event_notifer = {
+	.notifier_call	= fbcon_event_notify,
+};
+
+static int fbcon_event_notifier_registered;
+
 int __init fb_console_init(void)
 {
 	if (!num_registered_fb)
 		return -ENODEV;
 	take_over_console(&fb_con, first_fb_vc, last_fb_vc, fbcon_is_default);
+	acquire_console_sem();
+	if (!fbcon_event_notifier_registered) {
+		fb_register_client(&fbcon_event_notifer);
+		fbcon_event_notifier_registered = 1;
+	} 
+	release_console_sem();
+
 	return 0;
 }
 
 void __exit fb_console_exit(void)
 {
+	acquire_console_sem();
+	if (fbcon_event_notifier_registered) {
+		fb_unregister_client(&fbcon_event_notifer);
+		fbcon_event_notifier_registered = 0;
+	}
+	release_console_sem();
 	give_up_console(&fb_con);
 }	
 


