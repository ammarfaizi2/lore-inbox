Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWFFLLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWFFLLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFFLLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:11:42 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:53140 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751244AbWFFLLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:11:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=EVQ7IaKow1NDD5ui7PbqfEbWSUX8gMEA4A3lspMtq8SMulV48/US/BPlIZrXUb4zGA/VglJ3I10nyxt/tcWOiC2Q5uK+QvuIQKMLn1Jca+yjgDFuZ3WGEAefZTt79F763QXEp0bj4RDC704rZISe7gphy98qncTnhC8PQjE7Q4U=
Message-ID: <4485624C.9070707@gmail.com>
Date: Tue, 06 Jun 2006 19:09:00 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] Detaching fbcon: Add capability to attach/detach fbcon
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to detach and attach the framebuffer console to and from
the vt layer. This is done by echo'ing any value to sysfs attributes located
in class/graphics/fbcon. The two attributes are:

      attach - bind fbcon to the vt layer
      detach - unbind fbcon from the vt layer

Once fbcon is detached from the vt layer, fbcon can be unloaded if compiled as
a module. This feature is quite useful for developers who work on the
framebuffer or console subsystem. This is also useful for users who want to
go to text mode or graphics mode without having to reboot.

Directly unloading the fbcon module is not possible because the vt layer
increments the module reference count for all bound consoles.  Detaching fbcon
decrements the module reference count to zero so unloading becomes possible.

Detaching fbcon may interfere with X and/or DRM.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |  155 ++++++++++++++++++++++++++---------------
 1 files changed, 97 insertions(+), 58 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index a8de822..b910eff 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -194,7 +194,8 @@ static void fbcon_redraw_move(struct vc_
 			      int line, int count, int dy);
 static void fbcon_modechanged(struct fb_info *info);
 static void fbcon_set_all_vcs(struct fb_info *info);
-
+static void fbcon_start(void);
+static void fbcon_exit(void);
 static struct class_device *fbcon_class_device;
 
 #ifdef CONFIG_MAC
@@ -391,15 +392,18 @@ static void fb_flashcursor(void *private
 	int c;
 	int mode;
 
-	if (ops->currcon != -1)
+	acquire_console_sem();
+	if (ops && ops->currcon != -1)
 		vc = vc_cons[ops->currcon].d;
 
 	if (!vc || !CON_IS_VISIBLE(vc) ||
 	    fbcon_is_inactive(vc, info) ||
  	    registered_fb[con2fb_map[vc->vc_num]] != info ||
-	    vc_cons[ops->currcon].d->vc_deccm != 1)
+	    vc_cons[ops->currcon].d->vc_deccm != 1) {
+		release_console_sem();
 		return;
-	acquire_console_sem();
+	}
+
 	p = &fb_display[vc->vc_num];
 	c = scr_readw((u16 *) vc->vc_pos);
 	mode = (!ops->cursor_flash || ops->cursor_state.enable) ?
@@ -2101,12 +2105,11 @@ static int fbcon_switch(struct vc_data *
 		if (info->fbops->fb_set_par)
 			info->fbops->fb_set_par(info);
 
-		if (old_info != info) {
+		if (old_info != info)
 			fbcon_del_cursor_timer(old_info);
-			fbcon_add_cursor_timer(info);
-		}
 	}
 
+	fbcon_add_cursor_timer(info);
 	set_blitting_type(vc, info);
 	ops->cursor_reset = 1;
 
@@ -2847,7 +2850,8 @@ static int fbcon_fb_registered(int idx)
 			ret = fbcon_takeover(1);
 	} else {
 		for (i = 0; i < MAX_NR_CONSOLES; i++) {
-			if (con2fb_map_boot[i] == idx)
+			if (con2fb_map_boot[i] == idx &&
+			    con2fb_map[i] == -1)
 				set_con2fb_map(i, idx, 0);
 		}
 	}
@@ -3046,9 +3050,32 @@ err:
 	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
 }
 
+static ssize_t store_attach(struct class_device *class_device,
+			    const char *buf, size_t count)
+{
+	if (info_idx == -1)
+		fbcon_start();
+
+	return count;
+}
+
+static ssize_t store_detach(struct class_device *class_device,
+			    const char *buf, size_t count)
+{
+	if (info_idx != -1) {
+		fbcon_exit();
+		give_up_console(&fb_con);
+	}
+
+	info_idx = -1;
+	return count;
+}
+
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
 	__ATTR(rotate_all, S_IWUSR, NULL, store_rotate_all),
+	__ATTR(attach, S_IWUSR, NULL, store_attach),
+	__ATTR(detach, S_IWUSR, NULL, store_detach),
 };
 
 static int fbcon_init_class_device(void)
@@ -3061,67 +3088,31 @@ static int fbcon_init_class_device(void)
 	return 0;
 }
 
-static int __init fb_console_init(void)
+static void fbcon_start(void)
 {
-	int i;
-
-	acquire_console_sem();
-	fb_register_client(&fbcon_event_notifier);
-	release_console_sem();
-
-	fbcon_class_device =
-	    class_device_create(fb_class, NULL,
-				MKDEV(FB_MAJOR, FB_MAX), NULL,
-				"fbcon");
-	if (IS_ERR(fbcon_class_device)) {
-	    printk(KERN_WARNING "Unable to create class_device "
-		   "for fbcon; errno = %ld\n",
-		   PTR_ERR(fbcon_class_device));
-	    fbcon_class_device = NULL;
-	} else
-	    fbcon_init_class_device();
+	if (num_registered_fb) {
+		int i;
 
-	for (i = 0; i < MAX_NR_CONSOLES; i++)
-		con2fb_map[i] = -1;
+		acquire_console_sem();
 
-	if (num_registered_fb) {
 		for (i = 0; i < FB_MAX; i++) {
 			if (registered_fb[i] != NULL) {
 				info_idx = i;
 				break;
 			}
 		}
+
+		release_console_sem();
 		fbcon_takeover(0);
 	}
-
-	return 0;
-}
-
-module_init(fb_console_init);
-
-#ifdef MODULE
-
-static void __exit fbcon_deinit_class_device(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
-		class_device_remove_file(fbcon_class_device,
-					 &class_device_attrs[i]);
 }
 
-static void __exit fbcon_exit(void)
+static void fbcon_exit(void)
 {
 	struct fb_info *info;
 	int i, j, mapped;
 
-	for (i = 0; i < FB_MAX; i++) {
-		info = registered_fb[i];
-
-		if (info && info->fbcon_par)
-			fbcon_del_cursor_timer(info);
-	}
-
+	acquire_console_sem();
 #ifdef CONFIG_ATARI
 	free_irq(IRQ_AUTO_4, fbcon_vbl_handler);
 #endif
@@ -3131,6 +3122,7 @@ #ifdef CONFIG_MAC
 #endif
 
 	kfree((void *)softback_buf);
+	softback_buf = 0UL;
 
 	for (i = 0; i < FB_MAX; i++) {
 		mapped = 0;
@@ -3150,22 +3142,69 @@ #endif
 			if (info->fbops->fb_release)
 				info->fbops->fb_release(info, 0);
 			module_put(info->fbops->owner);
-			kfree(info->fbcon_par);
-			info->fbcon_par = NULL;
+
+			if (info->fbcon_par) {
+				fbcon_del_cursor_timer(info);
+				kfree(info->fbcon_par);
+				info->fbcon_par = NULL;
+			}
+
+			if (info->queue.func == fb_flashcursor)
+				info->queue.func = NULL;
+
 		}
 	}
 
-	fbcon_deinit_class_device();
-	class_device_destroy(fb_class, MKDEV(FB_MAJOR, FB_MAX));
+	release_console_sem();
+}
+
+static int __init fb_console_init(void)
+{
+	int i;
+
+	acquire_console_sem();
+	fb_register_client(&fbcon_event_notifier);
+	fbcon_class_device =
+	    class_device_create(fb_class, NULL,
+				MKDEV(FB_MAJOR, FB_MAX), NULL,
+				"fbcon");
+
+	if (IS_ERR(fbcon_class_device)) {
+		printk(KERN_WARNING "Unable to create class_device "
+		       "for fbcon; errno = %ld\n",
+		       PTR_ERR(fbcon_class_device));
+		fbcon_class_device = NULL;
+	} else
+		fbcon_init_class_device();
+
+	for (i = 0; i < MAX_NR_CONSOLES; i++)
+		con2fb_map[i] = -1;
+
+	release_console_sem();
+	fbcon_start();
+	return 0;
+}
+
+module_init(fb_console_init);
+
+#ifdef MODULE
+
+static void fbcon_deinit_class_device(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
+		class_device_remove_file(fbcon_class_device,
+					 &class_device_attrs[i]);
 }
 
 static void __exit fb_console_exit(void)
 {
 	acquire_console_sem();
 	fb_unregister_client(&fbcon_event_notifier);
-	fbcon_exit();
+	fbcon_deinit_class_device();
+	class_device_destroy(fb_class, MKDEV(FB_MAJOR, FB_MAX));
 	release_console_sem();
-	give_up_console(&fb_con);
 }	
 
 module_exit(fb_console_exit);



