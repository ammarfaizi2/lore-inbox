Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWHKFJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWHKFJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWHKFJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:09:11 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17844 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751190AbWHKFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:09:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAI+t20QN
Message-Id: <20060811050611.655659401.dtor@insightbb.com>
References: <20060811050310.958962036.dtor@insightbb.com>
Date: Fri, 11 Aug 2006 01:03:16 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 6/6] Move per-device data out of backlight_properties
Content-Disposition: inline; filename=backlight-move-data.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight: move per-device data out of backlight_properties

Data such as current brightness belongs to a device and should not
be part of a structure shared between several devices.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/video/backlight/backlight.c |   37 +++++++++---------------------------
 drivers/video/backlight/lcd.c       |    2 -
 include/linux/backlight.h           |   21 +++++++++++---------
 include/linux/lcd.h                 |    4 +--
 4 files changed, 25 insertions(+), 39 deletions(-)

Index: work/include/linux/backlight.h
===================================================================
--- work.orig/include/linux/backlight.h
+++ work/include/linux/backlight.h
@@ -26,15 +26,8 @@ struct backlight_properties {
 	   return 0 if not, !=0 if it is. If NULL, backlight always matches the fb. */
 	int (*check_fb)(struct fb_info *);
 
-	/* Current User requested brightness (0 - max_brightness) */
-	int brightness;
 	/* Maximal value for brightness (read-only) */
 	int max_brightness;
-	/* Current FB Power mode (0: full on, 1..3: power saving
-	   modes; 4: full off), see FB_BLANK_XXX */
-	int power;
-	/* FB Blanking active? (values as for power) */
-	int fb_blank;
 };
 
 struct backlight_device {
@@ -43,15 +36,25 @@ struct backlight_device {
 	   points to something in the body of that driver, it is also invalid. */
 	struct mutex mutex;
 	/* If this is NULL, the backing module is unloaded */
-	struct backlight_properties *props;
+	const struct backlight_properties *props;
+
 	/* The framebuffer notifier block */
 	struct notifier_block fb_notif;
+
+	/* Current User requested brightness (0 - max_brightness) */
+	int brightness;
+	/* Current FB Power mode (0: full on, 1..3: power saving
+	   modes; 4: full off), see FB_BLANK_XXX */
+	int power;
+	/* FB Blanking active? (values as for power) */
+	int fb_blank;
+
 	/* The class device structure */
 	struct class_device class_dev;
 };
 
 extern struct backlight_device *backlight_device_register(const char *name,
-	void *devdata, struct backlight_properties *bp);
+	void *devdata, const struct backlight_properties *bp);
 extern void backlight_device_unregister(struct backlight_device *bd);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, class_dev)
Index: work/drivers/video/backlight/backlight.c
===================================================================
--- work.orig/drivers/video/backlight/backlight.c
+++ work/drivers/video/backlight/backlight.c
@@ -16,18 +16,9 @@
 
 static ssize_t backlight_show_power(struct class_device *cdev, char *buf)
 {
-	int rc;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
-	rc = mutex_lock_interruptible(&bd->mutex);
-	if (rc)
-		return rc;
-
-	rc = bd->props ? sprintf(buf, "%d\n", bd->props->power) : -ENXIO;
-
-	mutex_unlock(&bd->mutex);
-
-	return rc;
+	return sprintf(buf, "%d\n", bd->power);
 }
 
 static ssize_t backlight_store_power(struct class_device *cdev, const char *buf, size_t count)
@@ -49,7 +40,7 @@ static ssize_t backlight_store_power(str
 
 	if (bd->props) {
 		pr_debug("backlight: set power to %d\n", power);
-		bd->props->power = power;
+		bd->power = power;
 		if (bd->props->update_status)
 			bd->props->update_status(bd);
 		rc = count;
@@ -63,18 +54,9 @@ static ssize_t backlight_store_power(str
 
 static ssize_t backlight_show_brightness(struct class_device *cdev, char *buf)
 {
-	int rc;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
-	rc = mutex_lock_interruptible(&bd->mutex);
-	if (rc)
-		return rc;
-
-	rc = bd->props ? sprintf(buf, "%d\n", bd->props->brightness) : -ENXIO;
-
-	mutex_unlock(&bd->mutex);
-
-	return rc;
+	return sprintf(buf, "%d\n", bd->brightness);
 }
 
 static ssize_t backlight_store_brightness(struct class_device *cdev, const char *buf, size_t count)
@@ -100,7 +82,7 @@ static ssize_t backlight_store_brightnes
 		else {
 			pr_debug("backlight: set brightness to %d\n",
 				 brightness);
-			bd->props->brightness = brightness;
+			bd->brightness = brightness;
 			if (bd->props->update_status)
 				bd->props->update_status(bd);
 			rc = count;
@@ -191,7 +173,7 @@ static int fb_notifier_callback(struct n
 	if (bd->props) {
 		if (!bd->props->check_fb ||
 		    bd->props->check_fb(evdata->info)) {
-			bd->props->fb_blank = *(int *)evdata->data;
+			bd->fb_blank = *(int *)evdata->data;
 			if (likely(bd->props && bd->props->update_status))
 				bd->props->update_status(bd);
 		}
@@ -213,8 +195,9 @@ static int fb_notifier_callback(struct n
  * Creates and registers new backlight class_device. Returns either an
  * ERR_PTR() or a pointer to the newly allocated device.
  */
-struct backlight_device *backlight_device_register(const char *name, void *devdata,
-						   struct backlight_properties *bp)
+struct backlight_device *
+backlight_device_register(const char *name, void *devdata,
+			  const struct backlight_properties *bp)
 {
 	int err;
 	struct backlight_device *new_bd;
@@ -264,8 +247,8 @@ void backlight_device_unregister(struct 
 
 	mutex_lock(&bd->mutex);
 	if (bd->props && bd->props->update_status) {
-		bd->props->brightness = 0;
-		bd->props->power = 0;
+		bd->brightness = 0;
+		bd->power = 0;
 		bd->props->update_status(bd);
 	}
 
Index: work/drivers/video/backlight/lcd.c
===================================================================
--- work.orig/drivers/video/backlight/lcd.c
+++ work/drivers/video/backlight/lcd.c
@@ -186,7 +186,7 @@ static int fb_notifier_callback(struct n
  * or a pointer to the newly allocated device.
  */
 struct lcd_device *lcd_device_register(const char *name, void *devdata,
-				       struct lcd_properties *lp)
+				       const struct lcd_properties *lp)
 {
 	int err;
 	struct lcd_device *new_ld;
Index: work/include/linux/lcd.h
===================================================================
--- work.orig/include/linux/lcd.h
+++ work/include/linux/lcd.h
@@ -38,7 +38,7 @@ struct lcd_device {
 	   points to something in the body of that driver, it is also invalid. */
 	struct mutex mutex;
 	/* If this is NULL, the backing module is unloaded */
-	struct lcd_properties *props;
+	const struct lcd_properties *props;
 	/* The framebuffer notifier block */
 	struct notifier_block fb_notif;
 	/* The class device structure */
@@ -46,7 +46,7 @@ struct lcd_device {
 };
 
 extern struct lcd_device *lcd_device_register(const char *name,
-	void *devdata, struct lcd_properties *lp);
+	void *devdata, const struct lcd_properties *lp);
 extern void lcd_device_unregister(struct lcd_device *ld);
 
 #define to_lcd_device(obj) container_of(obj, struct lcd_device, class_dev)
