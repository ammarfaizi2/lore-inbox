Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbWJJPP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbWJJPP0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWJJPPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:15:25 -0400
Received: from havoc.gtf.org ([69.61.125.42]:7066 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750838AbWJJPPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:15:25 -0400
Date: Tue, 10 Oct 2006 11:15:21 -0400
From: Jeff Garzik <jeff@garzik.org>
To: rpurdie@rpsys.net, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/led: handle sysfs errors
Message-ID: <20061010151521.GA15618@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/leds/led-class.c     |   26 +++++++++++++++++++++-----
 drivers/leds/ledtrig-timer.c |   16 ++++++++++++++--

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index aecbbe2..3c17112 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -91,6 +91,8 @@ EXPORT_SYMBOL_GPL(led_classdev_resume);
  */
 int led_classdev_register(struct device *parent, struct led_classdev *led_cdev)
 {
+	int rc;
+
 	led_cdev->class_dev = class_device_create(leds_class, NULL, 0,
 						parent, "%s", led_cdev->name);
 	if (unlikely(IS_ERR(led_cdev->class_dev)))
@@ -99,8 +101,10 @@ int led_classdev_register(struct device 
 	class_set_devdata(led_cdev->class_dev, led_cdev);
 
 	/* register the attributes */
-	class_device_create_file(led_cdev->class_dev,
-				&class_device_attr_brightness);
+	rc = class_device_create_file(led_cdev->class_dev,
+				      &class_device_attr_brightness);
+	if (rc)
+		goto err_out;
 
 	/* add to the list of leds */
 	write_lock(&leds_list_lock);
@@ -110,16 +114,28 @@ int led_classdev_register(struct device 
 #ifdef CONFIG_LEDS_TRIGGERS
 	rwlock_init(&led_cdev->trigger_lock);
 
-	led_trigger_set_default(led_cdev);
+	rc = class_device_create_file(led_cdev->class_dev,
+				      &class_device_attr_trigger);
+	if (rc)
+		goto err_out_led_list;
 
-	class_device_create_file(led_cdev->class_dev,
-				&class_device_attr_trigger);
+	led_trigger_set_default(led_cdev);
 #endif
 
 	printk(KERN_INFO "Registered led device: %s\n",
 			led_cdev->class_dev->class_id);
 
 	return 0;
+
+#ifdef CONFIG_LEDS_TRIGGERS
+err_out_led_list:
+	class_device_remove_file(led_cdev->class_dev,
+				&class_device_attr_brightness);
+	list_del(&led_cdev->node);
+#endif
+err_out:
+	class_device_unregister(led_cdev->class_dev);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(led_classdev_register);
 
diff --git a/drivers/leds/ledtrig-timer.c b/drivers/leds/ledtrig-timer.c
index 179c287..29a8818 100644
--- a/drivers/leds/ledtrig-timer.c
+++ b/drivers/leds/ledtrig-timer.c
@@ -123,6 +123,7 @@ static CLASS_DEVICE_ATTR(delay_off, 0644
 static void timer_trig_activate(struct led_classdev *led_cdev)
 {
 	struct timer_trig_data *timer_data;
+	int rc;
 
 	timer_data = kzalloc(sizeof(struct timer_trig_data), GFP_KERNEL);
 	if (!timer_data)
@@ -134,10 +135,21 @@ static void timer_trig_activate(struct l
 	timer_data->timer.function = led_timer_function;
 	timer_data->timer.data = (unsigned long) led_cdev;
 
-	class_device_create_file(led_cdev->class_dev,
+	rc = class_device_create_file(led_cdev->class_dev,
 				&class_device_attr_delay_on);
-	class_device_create_file(led_cdev->class_dev,
+	if (rc) goto err_out;
+	rc = class_device_create_file(led_cdev->class_dev,
 				&class_device_attr_delay_off);
+	if (rc) goto err_out_delayon;
+
+	return;
+
+err_out_delayon:
+	class_device_remove_file(led_cdev->class_dev,
+				&class_device_attr_delay_on);
+err_out:
+	led_cdev->trigger_data = NULL;
+	kfree(timer_data);
 }
 
 static void timer_trig_deactivate(struct led_classdev *led_cdev)
