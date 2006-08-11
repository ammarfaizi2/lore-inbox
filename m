Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWHKFJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWHKFJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 01:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWHKFJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 01:09:05 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:8722 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1751504AbWHKFJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 01:09:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAI+t20QN
Message-Id: <20060811050611.142510849.dtor@insightbb.com>
References: <20060811050310.958962036.dtor@insightbb.com>
Date: Fri, 11 Aug 2006 01:03:12 -0400
From: Dmitry Torokhov <dtor@insightbb.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 2/6] Fix error handling when registering new device
Content-Disposition: inline; filename=backlight-fix-error-handling.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight: fix error handling when registering new device

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/video/backlight/backlight.c |    8 +++++---
 drivers/video/backlight/lcd.c       |    8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

Index: work/drivers/video/backlight/backlight.c
===================================================================
--- work.orig/drivers/video/backlight/backlight.c
+++ work/drivers/video/backlight/backlight.c
@@ -205,7 +205,7 @@ struct backlight_device *backlight_devic
 
 	rc = class_device_register(&new_bd->class_dev);
 	if (unlikely(rc)) {
-error:		kfree(new_bd);
+		kfree(new_bd);
 		return ERR_PTR(rc);
 	}
 
@@ -213,8 +213,10 @@ error:		kfree(new_bd);
 	new_bd->fb_notif.notifier_call = fb_notifier_callback;
 
 	rc = fb_register_client(&new_bd->fb_notif);
-	if (unlikely(rc))
-		goto error;
+	if (unlikely(rc)) {
+		class_device_unregister(&new_bd->class_dev);
+		return ERR_PTR(rc);
+	}
 
 	return new_bd;
 }
Index: work/drivers/video/backlight/lcd.c
===================================================================
--- work.orig/drivers/video/backlight/lcd.c
+++ work/drivers/video/backlight/lcd.c
@@ -177,7 +177,7 @@ struct lcd_device *lcd_device_register(c
 
 	rc = class_device_register(&new_ld->class_dev);
 	if (unlikely(rc)) {
-error:		kfree(new_ld);
+		kfree(new_ld);
 		return ERR_PTR(rc);
 	}
 
@@ -185,8 +185,10 @@ error:		kfree(new_ld);
 	new_ld->fb_notif.notifier_call = fb_notifier_callback;
 
 	rc = fb_register_client(&new_ld->fb_notif);
-	if (unlikely(rc))
-		goto error;
+	if (unlikely(rc)) {
+		class_device_unregister(&new_ld->class_dev);
+		return ERR_PTR(rc);
+	}
 
 	return new_ld;
 }
