Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031055AbWKURAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031055AbWKURAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031096AbWKURAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:00:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63424 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1031055AbWKURAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:00:50 -0500
Date: Tue, 21 Nov 2006 17:00:43 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] backlight: lcd: Remove dependenct from the framebuffer layer
Message-ID: <Pine.LNX.4.64.0611211641570.13421@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The backlight and layer should be independent from the framebuffer layer.
It can use the services offered by the framebuffer, but its absence should
not prevent the backlight/lcd layer from functioning. 

Signed-off-by: James Simmons <jsimmons@infradead.org>
---

 drivers/video/backlight/backlight.c |   85 ++++++++++++++++++++++-------------
 drivers/video/backlight/lcd.c       |   76 +++++++++++++++++++------------
 4 files changed, 103 insertions(+), 64 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 27597c5..6766dfb 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -14,6 +14,57 @@ #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/fb.h>
 
+
+#if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
+			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
+/* This callback gets called when something important happens inside a
+ * framebuffer driver. We're looking if that important event is blanking,
+ * and if it is, we're switching backlight power as well ...
+ */
+static int fb_notifier_callback(struct notifier_block *self,
+				unsigned long event, void *data)
+{
+	struct backlight_device *bd;
+	struct fb_event *evdata =(struct fb_event *)data;
+
+	/* If we aren't interested in this event, skip it immediately ... */
+	if (event != FB_EVENT_BLANK)
+		return 0;
+
+	bd = container_of(self, struct backlight_device, fb_notif);
+	down(&bd->sem);
+	if (bd->props)
+		if (!bd->props->check_fb ||
+		    bd->props->check_fb(evdata->info)) {
+			bd->props->fb_blank = *(int *)evdata->data;
+			if (likely(bd->props && bd->props->update_status))
+				bd->props->update_status(bd);
+		}
+	up(&bd->sem);
+	return 0;
+}
+
+static int backlight_register_fb(struct backlight_device *bd)
+{
+	memset(&bd->fb_notif, 0, sizeof(bd->fb_notif));
+	bd->fb_notif.notifier_call = fb_notifier_callback;
+
+	return fb_register_client(&bd->fb_notif);
+}
+
+static void backlight_unregister_fb(struct backlight_device *bd)
+{
+	fb_unregister_client(&bd->fb_notif);
+}
+#else
+static inline int backlight_register_fb(struct backlight_device *bd)
+{
+	return 0;
+}
+
+#define backlight_unregister_fb(...) do { } while (0)
+#endif /* CONFIG_FB */
+
 static ssize_t backlight_show_power(struct class_device *cdev, char *buf)
 {
 	int rc = -ENXIO;
@@ -151,33 +202,6 @@ static struct class_device_attribute bl_
 	DECLARE_ATTR(max_brightness, 0444, backlight_show_max_brightness, NULL),
 };
 
-/* This callback gets called when something important happens inside a
- * framebuffer driver. We're looking if that important event is blanking,
- * and if it is, we're switching backlight power as well ...
- */
-static int fb_notifier_callback(struct notifier_block *self,
-				unsigned long event, void *data)
-{
-	struct backlight_device *bd;
-	struct fb_event *evdata =(struct fb_event *)data;
-
-	/* If we aren't interested in this event, skip it immediately ... */
-	if (event != FB_EVENT_BLANK)
-		return 0;
-
-	bd = container_of(self, struct backlight_device, fb_notif);
-	down(&bd->sem);
-	if (bd->props)
-		if (!bd->props->check_fb ||
-		    bd->props->check_fb(evdata->info)) {
-			bd->props->fb_blank = *(int *)evdata->data;
-			if (likely(bd->props && bd->props->update_status))
-				bd->props->update_status(bd);
-		}
-	up(&bd->sem);
-	return 0;
-}
-
 /**
  * backlight_device_register - create and register a new object of
  *   backlight_device class.
@@ -215,10 +239,7 @@ error:		kfree(new_bd);
 		return ERR_PTR(rc);
 	}
 
-	memset(&new_bd->fb_notif, 0, sizeof(new_bd->fb_notif));
-	new_bd->fb_notif.notifier_call = fb_notifier_callback;
-
-	rc = fb_register_client(&new_bd->fb_notif);
+	rc = backlight_register_fb(new_bd);
 	if (unlikely(rc))
 		goto error;
 
@@ -268,7 +289,7 @@ void backlight_device_unregister(struct 
 	bd->props = NULL;
 	up(&bd->sem);
 
-	fb_unregister_client(&bd->fb_notif);
+	backlight_unregister_fb(bd);
 
 	class_device_unregister(&bd->class_dev);
 }
diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index bc8ab00..cab36a4 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -14,6 +14,51 @@ #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/fb.h>
 
+#if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
+			   defined(CONFIG_LCD_CLASS_DEVICE_MODULE))
+/* This callback gets called when something important happens inside a
+ * framebuffer driver. We're looking if that important event is blanking,
+ * and if it is, we're switching lcd power as well ...
+ */
+static int fb_notifier_callback(struct notifier_block *self,
+				 unsigned long event, void *data)
+{
+	struct lcd_device *ld;
+	struct fb_event *evdata =(struct fb_event *)data;
+
+	/* If we aren't interested in this event, skip it immediately ... */
+	if (event != FB_EVENT_BLANK)
+		return 0;
+
+	ld = container_of(self, struct lcd_device, fb_notif);
+	down(&ld->sem);
+	if (ld->props)
+		if (!ld->props->check_fb || ld->props->check_fb(evdata->info))
+			ld->props->set_power(ld, *(int *)evdata->data);
+	up(&ld->sem);
+	return 0;
+}
+
+static int lcd_register_fb(struct lcd_device *ld)
+{
+	memset(&ld->fb_notif, 0, sizeof(&ld->fb_notif));
+	ld->fb_notif.notifier_call = fb_notifier_callback;
+	return fb_register_client(&ld->fb_notif);
+}
+
+static void lcd_unregister_fb(struct lcd_device *ld)
+{
+	fb_unregister_client(&ld->fb_notif);
+}
+#else
+static int lcd_register_fb(struct lcd_device *ld)
+{
+	return 0;
+}
+
+#define lcd_unregister_fb(...) do { } while (0)
+#endif /* CONFIG_FB */
+
 static ssize_t lcd_show_power(struct class_device *cdev, char *buf)
 {
 	int rc;
@@ -127,29 +172,6 @@ static struct class_device_attribute lcd
 	DECLARE_ATTR(max_contrast, 0444, lcd_show_max_contrast, NULL),
 };
 
-/* This callback gets called when something important happens inside a
- * framebuffer driver. We're looking if that important event is blanking,
- * and if it is, we're switching lcd power as well ...
- */
-static int fb_notifier_callback(struct notifier_block *self,
-				 unsigned long event, void *data)
-{
-	struct lcd_device *ld;
-	struct fb_event *evdata =(struct fb_event *)data;
-
-	/* If we aren't interested in this event, skip it immediately ... */
-	if (event != FB_EVENT_BLANK)
-		return 0;
-
-	ld = container_of(self, struct lcd_device, fb_notif);
-	down(&ld->sem);
-	if (ld->props)
-		if (!ld->props->check_fb || ld->props->check_fb(evdata->info))
-			ld->props->set_power(ld, *(int *)evdata->data);
-	up(&ld->sem);
-	return 0;
-}
-
 /**
  * lcd_device_register - register a new object of lcd_device class.
  * @name: the name of the new object(must be the same as the name of the
@@ -186,10 +208,8 @@ error:		kfree(new_ld);
 		return ERR_PTR(rc);
 	}
 
-	memset(&new_ld->fb_notif, 0, sizeof(new_ld->fb_notif));
-	new_ld->fb_notif.notifier_call = fb_notifier_callback;
+	rc = lcd_register_fb(new_ld);
 
-	rc = fb_register_client(&new_ld->fb_notif);
 	if (unlikely(rc))
 		goto error;
 
@@ -232,9 +252,7 @@ void lcd_device_unregister(struct lcd_de
 	down(&ld->sem);
 	ld->props = NULL;
 	up(&ld->sem);
-
-	fb_unregister_client(&ld->fb_notif);
-
+	lcd_unregister_fb(ld);
 	class_device_unregister(&ld->class_dev);
 }
 EXPORT_SYMBOL(lcd_device_unregister);
-
