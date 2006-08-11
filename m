Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWHKFJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWHKFJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWHKFJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:09:08 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17844 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751510AbWHKFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:09:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAI+t20QN
Message-Id: <20060811050611.278227073.dtor@insightbb.com>
References: <20060811050310.958962036.dtor@insightbb.com>
Date: Fri, 11 Aug 2006 01:03:13 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 3/6] Get rid of excessive amount of likely()s
Content-Disposition: inline; filename=backlight-cleanup.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight: get rid of excessive amount of likely()s

There are no hot paths in the backlight core; do not litter the
code with likely()s and rely on compiler to do the right thing.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/video/backlight/backlight.c |   45 +++++++++++++++++-------------------
 drivers/video/backlight/lcd.c       |   37 ++++++++++++-----------------
 2 files changed, 38 insertions(+), 44 deletions(-)

Index: work/drivers/video/backlight/backlight.c
===================================================================
--- work.orig/drivers/video/backlight/backlight.c
+++ work/drivers/video/backlight/backlight.c
@@ -20,7 +20,7 @@ static ssize_t backlight_show_power(stru
 	struct backlight_device *bd = to_backlight_device(cdev);
 
 	down(&bd->sem);
-	if (likely(bd->props))
+	if (bd->props)
 		rc = sprintf(buf, "%d\n", bd->props->power);
 	up(&bd->sem);
 
@@ -41,10 +41,10 @@ static ssize_t backlight_store_power(str
 		return -EINVAL;
 
 	down(&bd->sem);
-	if (likely(bd->props)) {
+	if (bd->props) {
 		pr_debug("backlight: set power to %d\n", power);
 		bd->props->power = power;
-		if (likely(bd->props->update_status))
+		if (bd->props->update_status)
 			bd->props->update_status(bd);
 		rc = count;
 	}
@@ -59,7 +59,7 @@ static ssize_t backlight_show_brightness
 	struct backlight_device *bd = to_backlight_device(cdev);
 
 	down(&bd->sem);
-	if (likely(bd->props))
+	if (bd->props)
 		rc = sprintf(buf, "%d\n", bd->props->brightness);
 	up(&bd->sem);
 
@@ -80,14 +80,14 @@ static ssize_t backlight_store_brightnes
 		return -EINVAL;
 
 	down(&bd->sem);
-	if (likely(bd->props)) {
+	if (bd->props) {
 		if (brightness > bd->props->max_brightness)
 			rc = -EINVAL;
 		else {
 			pr_debug("backlight: set brightness to %d\n",
 				 brightness);
 			bd->props->brightness = brightness;
-			if (likely(bd->props->update_status))
+			if (bd->props->update_status)
 				bd->props->update_status(bd);
 			rc = count;
 		}
@@ -103,7 +103,7 @@ static ssize_t backlight_show_max_bright
 	struct backlight_device *bd = to_backlight_device(cdev);
 
 	down(&bd->sem);
-	if (likely(bd->props))
+	if (bd->props)
 		rc = sprintf(buf, "%d\n", bd->props->max_brightness);
 	up(&bd->sem);
 
@@ -117,7 +117,7 @@ static ssize_t backlight_show_actual_bri
 	struct backlight_device *bd = to_backlight_device(cdev);
 
 	down(&bd->sem);
-	if (likely(bd->props && bd->props->get_brightness))
+	if (bd->props && bd->props->get_brightness)
 		rc = sprintf(buf, "%d\n", bd->props->get_brightness(bd));
 	up(&bd->sem);
 
@@ -127,6 +127,7 @@ static ssize_t backlight_show_actual_bri
 static void backlight_class_release(struct class_device *dev)
 {
 	struct backlight_device *bd = to_backlight_device(dev);
+
 	kfree(bd);
 }
 
@@ -153,7 +154,7 @@ static int fb_notifier_callback(struct n
 				unsigned long event, void *data)
 {
 	struct backlight_device *bd;
-	struct fb_event *evdata =(struct fb_event *)data;
+	struct fb_event *evdata = data;
 
 	/* If we aren't interested in this event, skip it immediately ... */
 	if (event != FB_EVENT_BLANK)
@@ -161,13 +162,14 @@ static int fb_notifier_callback(struct n
 
 	bd = container_of(self, struct backlight_device, fb_notif);
 	down(&bd->sem);
-	if (bd->props)
+	if (bd->props) {
 		if (!bd->props->check_fb ||
 		    bd->props->check_fb(evdata->info)) {
 			bd->props->fb_blank = *(int *)evdata->data;
 			if (likely(bd->props && bd->props->update_status))
 				bd->props->update_status(bd);
 		}
+	}
 	up(&bd->sem);
 	return 0;
 }
@@ -187,35 +189,33 @@ static int fb_notifier_callback(struct n
 struct backlight_device *backlight_device_register(const char *name, void *devdata,
 						   struct backlight_properties *bp)
 {
-	int rc;
+	int err;
 	struct backlight_device *new_bd;
 
 	pr_debug("backlight_device_alloc: name=%s\n", name);
 
-	new_bd = kmalloc(sizeof(struct backlight_device), GFP_KERNEL);
-	if (unlikely(!new_bd))
+	new_bd = kzalloc(sizeof(struct backlight_device), GFP_KERNEL);
+	if (!new_bd)
 		return ERR_PTR(-ENOMEM);
 
 	init_MUTEX(&new_bd->sem);
 	new_bd->props = bp;
-	memset(&new_bd->class_dev, 0, sizeof(new_bd->class_dev));
 	new_bd->class_dev.class = &backlight_class;
 	strlcpy(new_bd->class_dev.class_id, name, KOBJ_NAME_LEN);
 	class_set_devdata(&new_bd->class_dev, devdata);
 
-	rc = class_device_register(&new_bd->class_dev);
-	if (unlikely(rc)) {
+	err = class_device_register(&new_bd->class_dev);
+	if (err) {
 		kfree(new_bd);
-		return ERR_PTR(rc);
+		return ERR_PTR(err);
 	}
 
-	memset(&new_bd->fb_notif, 0, sizeof(new_bd->fb_notif));
 	new_bd->fb_notif.notifier_call = fb_notifier_callback;
 
-	rc = fb_register_client(&new_bd->fb_notif);
-	if (unlikely(rc)) {
+	err = fb_register_client(&new_bd->fb_notif);
+	if (err) {
 		class_device_unregister(&new_bd->class_dev);
-		return ERR_PTR(rc);
+		return ERR_PTR(err);
 	}
 
 	return new_bd;
@@ -236,7 +236,7 @@ void backlight_device_unregister(struct 
 	pr_debug("backlight_device_unregister: name=%s\n", bd->class_dev.class_id);
 
 	down(&bd->sem);
-	if (likely(bd->props && bd->props->update_status)) {
+	if (bd->props && bd->props->update_status) {
 		bd->props->brightness = 0;
 		bd->props->power = 0;
 		bd->props->update_status(bd);
@@ -246,7 +246,6 @@ void backlight_device_unregister(struct 
 	up(&bd->sem);
 
 	fb_unregister_client(&bd->fb_notif);
-
 	class_device_unregister(&bd->class_dev);
 }
 EXPORT_SYMBOL(backlight_device_unregister);
Index: work/drivers/video/backlight/lcd.c
===================================================================
--- work.orig/drivers/video/backlight/lcd.c
+++ work/drivers/video/backlight/lcd.c
@@ -16,14 +16,12 @@
 
 static ssize_t lcd_show_power(struct class_device *cdev, char *buf)
 {
-	int rc;
+	int rc = -ENXIO;
 	struct lcd_device *ld = to_lcd_device(cdev);
 
 	down(&ld->sem);
-	if (likely(ld->props && ld->props->get_power))
+	if (ld->props && ld->props->get_power)
 		rc = sprintf(buf, "%d\n", ld->props->get_power(ld));
-	else
-		rc = -ENXIO;
 	up(&ld->sem);
 
 	return rc;
@@ -43,7 +41,7 @@ static ssize_t lcd_store_power(struct cl
 		return -EINVAL;
 
 	down(&ld->sem);
-	if (likely(ld->props && ld->props->set_power)) {
+	if (ld->props && ld->props->set_power) {
 		pr_debug("lcd: set power to %d\n", power);
 		ld->props->set_power(ld, power);
 		rc = count;
@@ -59,7 +57,7 @@ static ssize_t lcd_show_contrast(struct 
 	struct lcd_device *ld = to_lcd_device(cdev);
 
 	down(&ld->sem);
-	if (likely(ld->props && ld->props->get_contrast))
+	if (ld->props && ld->props->get_contrast)
 		rc = sprintf(buf, "%d\n", ld->props->get_contrast(ld));
 	up(&ld->sem);
 
@@ -80,7 +78,7 @@ static ssize_t lcd_store_contrast(struct
 		return -EINVAL;
 
 	down(&ld->sem);
-	if (likely(ld->props && ld->props->set_contrast)) {
+	if (ld->props && ld->props->set_contrast) {
 		pr_debug("lcd: set contrast to %d\n", contrast);
 		ld->props->set_contrast(ld, contrast);
 		rc = count;
@@ -96,7 +94,7 @@ static ssize_t lcd_show_max_contrast(str
 	struct lcd_device *ld = to_lcd_device(cdev);
 
 	down(&ld->sem);
-	if (likely(ld->props))
+	if (ld->props)
 		rc = sprintf(buf, "%d\n", ld->props->max_contrast);
 	up(&ld->sem);
 
@@ -130,7 +128,7 @@ static int fb_notifier_callback(struct n
 				 unsigned long event, void *data)
 {
 	struct lcd_device *ld;
-	struct fb_event *evdata =(struct fb_event *)data;
+	struct fb_event *evdata = data;
 
 	/* If we aren't interested in this event, skip it immediately ... */
 	if (event != FB_EVENT_BLANK)
@@ -159,35 +157,33 @@ static int fb_notifier_callback(struct n
 struct lcd_device *lcd_device_register(const char *name, void *devdata,
 				       struct lcd_properties *lp)
 {
-	int rc;
+	int err;
 	struct lcd_device *new_ld;
 
 	pr_debug("lcd_device_register: name=%s\n", name);
 
-	new_ld = kmalloc(sizeof(struct lcd_device), GFP_KERNEL);
-	if (unlikely(!new_ld))
+	new_ld = kzalloc(sizeof(struct lcd_device), GFP_KERNEL);
+	if (!new_ld)
 		return ERR_PTR(-ENOMEM);
 
 	init_MUTEX(&new_ld->sem);
 	new_ld->props = lp;
-	memset(&new_ld->class_dev, 0, sizeof(new_ld->class_dev));
 	new_ld->class_dev.class = &lcd_class;
 	strlcpy(new_ld->class_dev.class_id, name, KOBJ_NAME_LEN);
 	class_set_devdata(&new_ld->class_dev, devdata);
 
-	rc = class_device_register(&new_ld->class_dev);
-	if (unlikely(rc)) {
+	err = class_device_register(&new_ld->class_dev);
+	if (unlikely(err)) {
 		kfree(new_ld);
-		return ERR_PTR(rc);
+		return ERR_PTR(err);
 	}
 
-	memset(&new_ld->fb_notif, 0, sizeof(new_ld->fb_notif));
 	new_ld->fb_notif.notifier_call = fb_notifier_callback;
 
-	rc = fb_register_client(&new_ld->fb_notif);
-	if (unlikely(rc)) {
+	err = fb_register_client(&new_ld->fb_notif);
+	if (err) {
 		class_device_unregister(&new_ld->class_dev);
-		return ERR_PTR(rc);
+		return ERR_PTR(err);
 	}
 
 	return new_ld;
@@ -212,7 +208,6 @@ void lcd_device_unregister(struct lcd_de
 	up(&ld->sem);
 
 	fb_unregister_client(&ld->fb_notif);
-
 	class_device_unregister(&ld->class_dev);
 }
 EXPORT_SYMBOL(lcd_device_unregister);
