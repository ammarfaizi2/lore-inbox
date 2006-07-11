Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWGKGzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWGKGzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWGKGzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:55:10 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:38361 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030184AbWGKGzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:55:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=j480YSHGgxeVZ+2NFbN0ouZqSRLj19xXcc9ERtVXzQWvWMbkbohz4pPB8q43wcBdLETrari93p/dTztjYg5fQpb3cj5Pcwd5eX6lB62HKxisV97AqOrUge6jg9hLIrNbU+zMtensxRJsioibETQFDRsSu/su0ziLACBIoHniMoE=
Message-ID: <44B34B10.2030605@gmail.com>
Date: Tue, 11 Jul 2006 14:54:08 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Matt Reuther <mreuther@umich.edu>, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, Andrew Zabolotny <zap@homelink.ru>
Subject: [PATCH] backlight: lcd: Remove dependency from the framebuffer layer
References: <200607100833.00461.mreuther@umich.edu>	<20060710113212.5ddn42t40ks44s00@engin.mail.umich.edu>	<44B27931.30609@gmail.com>	<200607102327.38426.mreuther@umich.edu> <20060710215253.1fcaab57.rdunlap@xenotime.net>
In-Reply-To: <20060710215253.1fcaab57.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The backlight and lcd layer should be independent from the framebuffer layer.
It can use the services offered by the framebuffer, but its absence should
not prevent the backlight/lcd layer from functioning.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Randy.Dunlap wrote:
>>>>> CONFIG_FB=n, CONFIG_BACKLIGHT_CLASS_DEVICE=m should not be possible in
>>>>> 2.6.18-rc1-mm1 and 2.6.18-rc1.  Can you run kconfig again?
>>>>>
>>>>> Tony
>>> I tested with make menuconfig, and it's not possible to set lcd/backlight
>>> options if CONFIG_FB is not set.
> 
> Tony, it is possiblle when the USB APPLEDISPLAY option is set and it selects
> backlight options without regard for FB.
>  
>> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko 
>> needs unknown symbol fb_unregister_client
>> WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/drivers/video/backlight/backlight.ko 
>> needs unknown symbol fb_register_client
> 
> This patch fixes it for me.  Is it the right thing to do?

In this case, yes.  But I think the better solution is to eliminate
framebuffer dependency.

Tony

 drivers/video/Kconfig               |    2 -
 drivers/video/backlight/Kconfig     |    4 +-
 drivers/video/backlight/backlight.c |   85 ++++++++++++++++++++++-------------
 drivers/video/backlight/lcd.c       |   76 +++++++++++++++++++------------
 4 files changed, 103 insertions(+), 64 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c51a54b..9d9d02a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1622,7 +1622,7 @@ if FB || SGI_NEWPORT_CONSOLE
 	source "drivers/video/logo/Kconfig"
 endif
 
-if FB && SYSFS
+if SYSFS
 	source "drivers/video/backlight/Kconfig"
 endif
 
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 022f9d3..02f1529 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -10,7 +10,7 @@ menuconfig BACKLIGHT_LCD_SUPPORT
 
 config BACKLIGHT_CLASS_DEVICE
         tristate "Lowlevel Backlight controls"
-	depends on BACKLIGHT_LCD_SUPPORT && FB
+	depends on BACKLIGHT_LCD_SUPPORT
 	default m
 	help
 	  This framework adds support for low-level control of the LCD
@@ -26,7 +26,7 @@ config BACKLIGHT_DEVICE
 
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
-	depends on BACKLIGHT_LCD_SUPPORT && FB
+	depends on BACKLIGHT_LCD_SUPPORT
 	default m
 	help
 	  This framework adds support for low-level control of LCD.
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 27597c5..fd22a7c 100644
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
+static int __deprecated fb_notifier_callback(struct notifier_block *self,
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

