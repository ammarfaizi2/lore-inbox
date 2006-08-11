Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWHKFJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWHKFJE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWHKFJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:09:04 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17844 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751505AbWHKFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:09:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAI+t20QN
Message-Id: <20060811050611.030043094.dtor@insightbb.com>
References: <20060811050310.958962036.dtor@insightbb.com>
Date: Fri, 11 Aug 2006 01:03:11 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 1/6] Convert to use default class device attributes
Content-Disposition: inline; filename=backlight-attributes.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight: convert to use default class device attributes

Use provided by the driver core method of creating set of default
attributes for all devices belonging to a given class instead of
using homegrown code.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/video/backlight/backlight.c |   49 ++++++++----------------------------
 drivers/video/backlight/lcd.c       |   44 +++++++-------------------------
 2 files changed, 22 insertions(+), 71 deletions(-)

Index: work/drivers/video/backlight/backlight.c
===================================================================
--- work.orig/drivers/video/backlight/backlight.c
+++ work/drivers/video/backlight/backlight.c
@@ -130,25 +130,19 @@ static void backlight_class_release(stru
 	kfree(bd);
 }
 
-static struct class backlight_class = {
-	.name = "backlight",
-	.release = backlight_class_release,
+static struct class_device_attribute bl_class_device_attributes[] = {
+	__ATTR(power, 0644, backlight_show_power, backlight_store_power),
+	__ATTR(brightness, 0644,
+		backlight_show_brightness, backlight_store_brightness),
+	__ATTR(actual_brightness, 0444, backlight_show_actual_brightness, NULL),
+	__ATTR(max_brightness, 0444, backlight_show_max_brightness, NULL),
+	__ATTR_NULL
 };
 
-#define DECLARE_ATTR(_name,_mode,_show,_store)			\
-{							 	\
-	.attr	= { .name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _show,					\
-	.store	= _store,					\
-}
-
-static struct class_device_attribute bl_class_device_attributes[] = {
-	DECLARE_ATTR(power, 0644, backlight_show_power, backlight_store_power),
-	DECLARE_ATTR(brightness, 0644, backlight_show_brightness,
-		     backlight_store_brightness),
-	DECLARE_ATTR(actual_brightness, 0444, backlight_show_actual_brightness,
-		     NULL),
-	DECLARE_ATTR(max_brightness, 0444, backlight_show_max_brightness, NULL),
+static struct class backlight_class = {
+	.name			= "backlight",
+	.release		= backlight_class_release,
+	.class_dev_attrs	= bl_class_device_attributes,
 };
 
 /* This callback gets called when something important happens inside a
@@ -193,7 +187,7 @@ static int fb_notifier_callback(struct n
 struct backlight_device *backlight_device_register(const char *name, void *devdata,
 						   struct backlight_properties *bp)
 {
-	int i, rc;
+	int rc;
 	struct backlight_device *new_bd;
 
 	pr_debug("backlight_device_alloc: name=%s\n", name);
@@ -222,19 +216,6 @@ error:		kfree(new_bd);
 	if (unlikely(rc))
 		goto error;
 
-	for (i = 0; i < ARRAY_SIZE(bl_class_device_attributes); i++) {
-		rc = class_device_create_file(&new_bd->class_dev,
-					      &bl_class_device_attributes[i]);
-		if (unlikely(rc)) {
-			while (--i >= 0)
-				class_device_remove_file(&new_bd->class_dev,
-							 &bl_class_device_attributes[i]);
-			class_device_unregister(&new_bd->class_dev);
-			/* No need to kfree(new_bd) since release() method was called */
-			return ERR_PTR(rc);
-		}
-	}
-
 	return new_bd;
 }
 EXPORT_SYMBOL(backlight_device_register);
@@ -247,17 +228,11 @@ EXPORT_SYMBOL(backlight_device_register)
  */
 void backlight_device_unregister(struct backlight_device *bd)
 {
-	int i;
-
 	if (!bd)
 		return;
 
 	pr_debug("backlight_device_unregister: name=%s\n", bd->class_dev.class_id);
 
-	for (i = 0; i < ARRAY_SIZE(bl_class_device_attributes); i++)
-		class_device_remove_file(&bd->class_dev,
-					 &bl_class_device_attributes[i]);
-
 	down(&bd->sem);
 	if (likely(bd->props && bd->props->update_status)) {
 		bd->props->brightness = 0;
Index: work/drivers/video/backlight/lcd.c
===================================================================
--- work.orig/drivers/video/backlight/lcd.c
+++ work/drivers/video/backlight/lcd.c
@@ -109,22 +109,17 @@ static void lcd_class_release(struct cla
 	kfree(ld);
 }
 
-static struct class lcd_class = {
-	.name = "lcd",
-	.release = lcd_class_release,
+static struct class_device_attribute lcd_class_device_attributes[] = {
+	__ATTR(power, 0644, lcd_show_power, lcd_store_power),
+	__ATTR(contrast, 0644, lcd_show_contrast, lcd_store_contrast),
+	__ATTR(max_contrast, 0444, lcd_show_max_contrast, NULL),
+	__ATTR_NULL
 };
 
-#define DECLARE_ATTR(_name,_mode,_show,_store)			\
-{							 	\
-	.attr	= { .name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
-	.show	= _show,					\
-	.store	= _store,					\
-}
-
-static struct class_device_attribute lcd_class_device_attributes[] = {
-	DECLARE_ATTR(power, 0644, lcd_show_power, lcd_store_power),
-	DECLARE_ATTR(contrast, 0644, lcd_show_contrast, lcd_store_contrast),
-	DECLARE_ATTR(max_contrast, 0444, lcd_show_max_contrast, NULL),
+static struct class lcd_class = {
+	.name			= "lcd",
+	.release		= lcd_class_release,
+	.class_dev_attrs	= lcd_class_device_attributes,
 };
 
 /* This callback gets called when something important happens inside a
@@ -164,7 +159,7 @@ static int fb_notifier_callback(struct n
 struct lcd_device *lcd_device_register(const char *name, void *devdata,
 				       struct lcd_properties *lp)
 {
-	int i, rc;
+	int rc;
 	struct lcd_device *new_ld;
 
 	pr_debug("lcd_device_register: name=%s\n", name);
@@ -193,19 +188,6 @@ error:		kfree(new_ld);
 	if (unlikely(rc))
 		goto error;
 
-	for (i = 0; i < ARRAY_SIZE(lcd_class_device_attributes); i++) {
-		rc = class_device_create_file(&new_ld->class_dev,
-					      &lcd_class_device_attributes[i]);
-		if (unlikely(rc)) {
-			while (--i >= 0)
-				class_device_remove_file(&new_ld->class_dev,
-							 &lcd_class_device_attributes[i]);
-			class_device_unregister(&new_ld->class_dev);
-			/* No need to kfree(new_ld) since release() method was called */
-			return ERR_PTR(rc);
-		}
-	}
-
 	return new_ld;
 }
 EXPORT_SYMBOL(lcd_device_register);
@@ -218,17 +200,11 @@ EXPORT_SYMBOL(lcd_device_register);
  */
 void lcd_device_unregister(struct lcd_device *ld)
 {
-	int i;
-
 	if (!ld)
 		return;
 
 	pr_debug("lcd_device_unregister: name=%s\n", ld->class_dev.class_id);
 
-	for (i = 0; i < ARRAY_SIZE(lcd_class_device_attributes); i++)
-		class_device_remove_file(&ld->class_dev,
-					 &lcd_class_device_attributes[i]);
-
 	down(&ld->sem);
 	ld->props = NULL;
 	up(&ld->sem);
