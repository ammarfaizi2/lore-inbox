Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbWHKFJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWHKFJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWHKFJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:09:10 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:8722 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751512AbWHKFJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:09:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAI+t20QN
Message-Id: <20060811050611.530817371.dtor@insightbb.com>
References: <20060811050310.958962036.dtor@insightbb.com>
Date: Fri, 11 Aug 2006 01:03:15 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 5/6] Convert to use mutexes instead of semaphores
Content-Disposition: inline; filename=backlight-sem-to-mutex.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight: convert to use mutexes instead of semaphores

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/video/backlight/backlight.c |   89 +++++++++++++++++++++++-------------
 drivers/video/backlight/lcd.c       |   73 +++++++++++++++++++++--------
 include/linux/backlight.h           |    2 
 include/linux/lcd.h                 |    2 
 4 files changed, 112 insertions(+), 54 deletions(-)

Index: work/drivers/video/backlight/backlight.c
===================================================================
--- work.orig/drivers/video/backlight/backlight.c
+++ work/drivers/video/backlight/backlight.c
@@ -16,20 +16,23 @@
 
 static ssize_t backlight_show_power(struct class_device *cdev, char *buf)
 {
-	int rc = -ENXIO;
+	int rc;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
-	down(&bd->sem);
-	if (bd->props)
-		rc = sprintf(buf, "%d\n", bd->props->power);
-	up(&bd->sem);
+	rc = mutex_lock_interruptible(&bd->mutex);
+	if (rc)
+		return rc;
+
+	rc = bd->props ? sprintf(buf, "%d\n", bd->props->power) : -ENXIO;
+
+	mutex_unlock(&bd->mutex);
 
 	return rc;
 }
 
 static ssize_t backlight_store_power(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc = -ENXIO;
+	int rc;
 	char *endp;
 	struct backlight_device *bd = to_backlight_device(cdev);
 	int power = simple_strtoul(buf, &endp, 0);
@@ -40,35 +43,43 @@ static ssize_t backlight_store_power(str
 	if (size != count)
 		return -EINVAL;
 
-	down(&bd->sem);
+	rc = mutex_lock_interruptible(&bd->mutex);
+	if (rc)
+		return rc;
+
 	if (bd->props) {
 		pr_debug("backlight: set power to %d\n", power);
 		bd->props->power = power;
 		if (bd->props->update_status)
 			bd->props->update_status(bd);
 		rc = count;
-	}
-	up(&bd->sem);
+	} else
+		rc = -ENXIO;
+
+	mutex_unlock(&bd->mutex);
 
 	return rc;
 }
 
 static ssize_t backlight_show_brightness(struct class_device *cdev, char *buf)
 {
-	int rc = -ENXIO;
+	int rc;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
-	down(&bd->sem);
-	if (bd->props)
-		rc = sprintf(buf, "%d\n", bd->props->brightness);
-	up(&bd->sem);
+	rc = mutex_lock_interruptible(&bd->mutex);
+	if (rc)
+		return rc;
+
+	rc = bd->props ? sprintf(buf, "%d\n", bd->props->brightness) : -ENXIO;
+
+	mutex_unlock(&bd->mutex);
 
 	return rc;
 }
 
 static ssize_t backlight_store_brightness(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc = -ENXIO;
+	int rc;
 	char *endp;
 	struct backlight_device *bd = to_backlight_device(cdev);
 	int brightness = simple_strtoul(buf, &endp, 0);
@@ -79,7 +90,10 @@ static ssize_t backlight_store_brightnes
 	if (size != count)
 		return -EINVAL;
 
-	down(&bd->sem);
+	rc = mutex_lock_interruptible(&bd->mutex);
+	if (rc)
+		return rc;
+
 	if (bd->props) {
 		if (brightness > bd->props->max_brightness)
 			rc = -EINVAL;
@@ -91,21 +105,26 @@ static ssize_t backlight_store_brightnes
 				bd->props->update_status(bd);
 			rc = count;
 		}
-	}
-	up(&bd->sem);
+	} else
+		rc = -ENXIO;
+
+	mutex_unlock(&bd->mutex);
 
 	return rc;
 }
 
 static ssize_t backlight_show_max_brightness(struct class_device *cdev, char *buf)
 {
-	int rc = -ENXIO;
+	int rc;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
-	down(&bd->sem);
-	if (bd->props)
-		rc = sprintf(buf, "%d\n", bd->props->max_brightness);
-	up(&bd->sem);
+	rc = mutex_lock_interruptible(&bd->mutex);
+	if (rc)
+		return rc;
+
+	rc = bd->props ? sprintf(buf, "%d\n", bd->props->max_brightness) : -ENXIO;
+
+	mutex_unlock(&bd->mutex);
 
 	return rc;
 }
@@ -113,13 +132,19 @@ static ssize_t backlight_show_max_bright
 static ssize_t backlight_show_actual_brightness(struct class_device *cdev,
 						char *buf)
 {
-	int rc = -ENXIO;
+	int rc;
 	struct backlight_device *bd = to_backlight_device(cdev);
 
-	down(&bd->sem);
+	rc = mutex_lock_interruptible(&bd->mutex);
+	if (rc)
+		return rc;
+
 	if (bd->props && bd->props->get_brightness)
 		rc = sprintf(buf, "%d\n", bd->props->get_brightness(bd));
-	up(&bd->sem);
+	else
+		rc = -ENXIO;
+
+	mutex_unlock(&bd->mutex);
 
 	return rc;
 }
@@ -161,7 +186,8 @@ static int fb_notifier_callback(struct n
 		return 0;
 
 	bd = container_of(self, struct backlight_device, fb_notif);
-	down(&bd->sem);
+
+	mutex_lock(&bd->mutex);
 	if (bd->props) {
 		if (!bd->props->check_fb ||
 		    bd->props->check_fb(evdata->info)) {
@@ -170,7 +196,8 @@ static int fb_notifier_callback(struct n
 				bd->props->update_status(bd);
 		}
 	}
-	up(&bd->sem);
+	mutex_unlock(&bd->mutex);
+
 	return 0;
 }
 
@@ -198,7 +225,7 @@ struct backlight_device *backlight_devic
 	if (!new_bd)
 		return ERR_PTR(-ENOMEM);
 
-	init_MUTEX(&new_bd->sem);
+	mutex_init(&new_bd->mutex);
 	new_bd->props = bp;
 	new_bd->class_dev.class = &backlight_class;
 	strlcpy(new_bd->class_dev.class_id, name, KOBJ_NAME_LEN);
@@ -235,7 +262,7 @@ void backlight_device_unregister(struct 
 
 	pr_debug("backlight_device_unregister: name=%s\n", bd->class_dev.class_id);
 
-	down(&bd->sem);
+	mutex_lock(&bd->mutex);
 	if (bd->props && bd->props->update_status) {
 		bd->props->brightness = 0;
 		bd->props->power = 0;
@@ -243,7 +270,7 @@ void backlight_device_unregister(struct 
 	}
 
 	bd->props = NULL;
-	up(&bd->sem);
+	mutex_unlock(&bd->mutex);
 
 	fb_unregister_client(&bd->fb_notif);
 	class_device_unregister(&bd->class_dev);
Index: work/drivers/video/backlight/lcd.c
===================================================================
--- work.orig/drivers/video/backlight/lcd.c
+++ work/drivers/video/backlight/lcd.c
@@ -16,20 +16,26 @@
 
 static ssize_t lcd_show_power(struct class_device *cdev, char *buf)
 {
-	int rc = -ENXIO;
+	int rc;
 	struct lcd_device *ld = to_lcd_device(cdev);
 
-	down(&ld->sem);
+	rc = mutex_lock_interruptible(&ld->mutex);
+	if (rc)
+		return rc;
+
 	if (ld->props && ld->props->get_power)
 		rc = sprintf(buf, "%d\n", ld->props->get_power(ld));
-	up(&ld->sem);
+	else
+		rc = -ENXIO;
+
+	mutex_unlock(&ld->mutex);
 
 	return rc;
 }
 
 static ssize_t lcd_store_power(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc = -ENXIO;
+	int rc;
 	char *endp;
 	struct lcd_device *ld = to_lcd_device(cdev);
 	int power = simple_strtoul(buf, &endp, 0);
@@ -40,33 +46,44 @@ static ssize_t lcd_store_power(struct cl
 	if (size != count)
 		return -EINVAL;
 
-	down(&ld->sem);
+	rc = mutex_lock_interruptible(&ld->mutex);
+	if (rc)
+		return rc;
+
 	if (ld->props && ld->props->set_power) {
 		pr_debug("lcd: set power to %d\n", power);
 		ld->props->set_power(ld, power);
 		rc = count;
-	}
-	up(&ld->sem);
+	} else
+		rc = -ENXIO;
+
+	mutex_unlock(&ld->mutex);
 
 	return rc;
 }
 
 static ssize_t lcd_show_contrast(struct class_device *cdev, char *buf)
 {
-	int rc = -ENXIO;
+	int rc;
 	struct lcd_device *ld = to_lcd_device(cdev);
 
-	down(&ld->sem);
+	rc = mutex_lock_interruptible(&ld->mutex);
+	if (rc)
+		return rc;
+
 	if (ld->props && ld->props->get_contrast)
 		rc = sprintf(buf, "%d\n", ld->props->get_contrast(ld));
-	up(&ld->sem);
+	else
+		rc = -ENXIO;
+
+	mutex_unlock(&ld->mutex);
 
 	return rc;
 }
 
 static ssize_t lcd_store_contrast(struct class_device *cdev, const char *buf, size_t count)
 {
-	int rc = -ENXIO;
+	int rc;
 	char *endp;
 	struct lcd_device *ld = to_lcd_device(cdev);
 	int contrast = simple_strtoul(buf, &endp, 0);
@@ -77,13 +94,18 @@ static ssize_t lcd_store_contrast(struct
 	if (size != count)
 		return -EINVAL;
 
-	down(&ld->sem);
+	rc = mutex_lock_interruptible(&ld->mutex);
+	if (rc)
+		return rc;
+
 	if (ld->props && ld->props->set_contrast) {
 		pr_debug("lcd: set contrast to %d\n", contrast);
 		ld->props->set_contrast(ld, contrast);
 		rc = count;
-	}
-	up(&ld->sem);
+	} else
+		rc = -ENXIO;
+
+	mutex_unlock(&ld->mutex);
 
 	return rc;
 }
@@ -93,10 +115,16 @@ static ssize_t lcd_show_max_contrast(str
 	int rc = -ENXIO;
 	struct lcd_device *ld = to_lcd_device(cdev);
 
-	down(&ld->sem);
+	rc = mutex_lock_interruptible(&ld->mutex);
+	if (rc)
+		return rc;
+
 	if (ld->props)
 		rc = sprintf(buf, "%d\n", ld->props->max_contrast);
-	up(&ld->sem);
+	else
+		rc = -ENXIO;
+
+	mutex_unlock(&ld->mutex);
 
 	return rc;
 }
@@ -104,6 +132,7 @@ static ssize_t lcd_show_max_contrast(str
 static void lcd_class_release(struct class_device *dev)
 {
 	struct lcd_device *ld = to_lcd_device(dev);
+
 	kfree(ld);
 }
 
@@ -135,11 +164,13 @@ static int fb_notifier_callback(struct n
 		return 0;
 
 	ld = container_of(self, struct lcd_device, fb_notif);
-	down(&ld->sem);
+
+	mutex_lock(&ld->mutex);
 	if (ld->props)
 		if (!ld->props->check_fb || ld->props->check_fb(evdata->info))
 			ld->props->set_power(ld, *(int *)evdata->data);
-	up(&ld->sem);
+	mutex_unlock(&ld->mutex);
+
 	return 0;
 }
 
@@ -166,7 +197,7 @@ struct lcd_device *lcd_device_register(c
 	if (!new_ld)
 		return ERR_PTR(-ENOMEM);
 
-	init_MUTEX(&new_ld->sem);
+	mutex_init(&new_ld->mutex);
 	new_ld->props = lp;
 	new_ld->class_dev.class = &lcd_class;
 	strlcpy(new_ld->class_dev.class_id, name, KOBJ_NAME_LEN);
@@ -203,9 +234,9 @@ void lcd_device_unregister(struct lcd_de
 
 	pr_debug("lcd_device_unregister: name=%s\n", ld->class_dev.class_id);
 
-	down(&ld->sem);
+	mutex_lock(&ld->mutex);
 	ld->props = NULL;
-	up(&ld->sem);
+	mutex_unlock(&ld->mutex);
 
 	fb_unregister_client(&ld->fb_notif);
 	class_device_unregister(&ld->class_dev);
Index: work/include/linux/backlight.h
===================================================================
--- work.orig/include/linux/backlight.h
+++ work/include/linux/backlight.h
@@ -41,7 +41,7 @@ struct backlight_device {
 	/* This protects the 'props' field. If 'props' is NULL, the driver that
 	   registered this device has been unloaded, and if class_get_devdata()
 	   points to something in the body of that driver, it is also invalid. */
-	struct semaphore sem;
+	struct mutex mutex;
 	/* If this is NULL, the backing module is unloaded */
 	struct backlight_properties *props;
 	/* The framebuffer notifier block */
Index: work/include/linux/lcd.h
===================================================================
--- work.orig/include/linux/lcd.h
+++ work/include/linux/lcd.h
@@ -36,7 +36,7 @@ struct lcd_device {
 	/* This protects the 'props' field. If 'props' is NULL, the driver that
 	   registered this device has been unloaded, and if class_get_devdata()
 	   points to something in the body of that driver, it is also invalid. */
-	struct semaphore sem;
+	struct mutex mutex;
 	/* If this is NULL, the backing module is unloaded */
 	struct lcd_properties *props;
 	/* The framebuffer notifier block */
