Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVGKUNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVGKUNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVGKUME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:12:04 -0400
Received: from c120.apm.etc.tu-bs.de ([134.169.174.120]:4246 "EHLO
	thebe.orbit.homelinux.net") by vger.kernel.org with ESMTP
	id S262524AbVGKUJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:09:06 -0400
Date: Mon, 11 Jul 2005 22:09:11 +0200
From: Daniel Willmann <d.willmann@tu-bs.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Sladen <thinkpad@paul.sladen.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested?
 (Userspace accelerometer viewer)
Message-ID: <20050711220911.00da2396@elara.orbit.homelinux.net>
In-Reply-To: <1121092015.7407.68.camel@localhost.localdomain>
References: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net>
	<1121092015.7407.68.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.11 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=Multipart_Mon__11_Jul_2005_22_09_11_+0200_Uwqb54L_vMtjmdsL
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Mon__11_Jul_2005_22_09_11_+0200_Uwqb54L_vMtjmdsL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

On Mon, 11 Jul 2005 15:26:57 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Is the quality good enough to use it DEC itsy style as an input device
> for games like Marble madness ?

it sure is good enough to play neverball.

I have implemented an absolute input driver (aka joystick) on the
basis of Dave's 0.02 version of the driver. I attached the diff to this
mail or just get it from:
http://thebe.orbit.homelinux.net/~alphaone/ibm_hdaps_joystick.tar.gz

Before you can use your thinkpad as a joystick you have to set the
upper and lower bounds for both axis and if any of your axis are
reversed (like X40) through the files in 
/sys/devices/platform/ibm_hdaps/ I wrote a little python script to
calibrate and enable the joystick which is included in the tarball or
can be downloaded from 
http://thebe.orbit.homelinux.net/svn/ibm-hdaps/util/calibrate.py


Regards,
Daniel
--Multipart_Mon__11_Jul_2005_22_09_11_+0200_Uwqb54L_vMtjmdsL
Content-Type: text/x-patch; name=ibm_hdaps_joystick.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ibm_hdaps_joystick.patch

Index: ibm_hdaps.c
===================================================================
--- ibm_hdaps.c	(revision 23)
+++ ibm_hdaps.c	(revision 27)
@@ -5,6 +5,7 @@
  * http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
  *
  * Copyright (c) 2005  Jesper Juhl <jesper.juhl@gmail.com>
+ * Copyright (c) 2005  Daniel Willmann <d.willmann@tu-bs.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -356,18 +357,7 @@
  **************************************************************************/
 
 static struct input_dev hdaps_idev;
-static u16 restx = 0;
-static u16 resty = 0;
 
-static void hdaps_calibrate(void)
-{
-	struct hdaps_accel_data accel_data;
-	accelerometer_read(&accel_data);
-	restx = accel_data.x_accel;
-	resty = accel_data.y_accel;
-	printk("restx: %d resty: %d\n", restx, resty);
-}
-
 static struct miscdevice ibm_hdaps_dev = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "ibm_hdaps",
@@ -376,41 +366,64 @@
 
 static struct timer_list ibm_hdaps_poll_timer;
 
-static unsigned long ibm_hdaps_mousedev_fuzz = 4;
 static unsigned long ibm_hdaps_poll_int_msecs = 25;
-static void ibm_hdaps_mousedev_poll(unsigned long unused)
+static unsigned int ibm_hdaps_joystick_reversex = 0;
+static unsigned int ibm_hdaps_joystick_reversey = 0;
+static u16 lastx = 0, lasty = 0;
+
+static void ibm_hdaps_joystick_poll(unsigned long unused)
 {
-	int movex, movey;
+	int posx, posy;
 	struct hdaps_accel_data accel_data;
 
 	accelerometer_read(&accel_data);
-	movex = restx - accel_data.x_accel;
-	movey = resty - accel_data.y_accel;
-	if (abs(movex) > ibm_hdaps_mousedev_fuzz)
-		input_report_rel(&hdaps_idev, REL_Y, movex);
-	if (abs(movey) > ibm_hdaps_mousedev_fuzz)
-		input_report_rel(&hdaps_idev, REL_X, movey);
+	posx = accel_data.x_accel;
+	posy = accel_data.y_accel;
+
+	if (ibm_hdaps_joystick_reversex)
+		posy = hdaps_idev.absmax[ABS_X] + (hdaps_idev.absmin[ABS_X] - posy);
+	if (ibm_hdaps_joystick_reversey)
+		posx = hdaps_idev.absmax[ABS_Y] + (hdaps_idev.absmin[ABS_Y] - posx);
+
+	if (abs(posx-lastx) > 0)
+		input_report_abs(&hdaps_idev, ABS_Y, posx);
+	if (abs(posy-lasty) > 0)
+		input_report_abs(&hdaps_idev, ABS_X, posy);
 	input_sync(&hdaps_idev);
+	lastx = posx;
+	lasty = posy;
 
 	mod_timer(&ibm_hdaps_poll_timer,
 		  jiffies + msecs_to_jiffies(ibm_hdaps_poll_int_msecs));
 }
 
-static int calibrated = 0;
-static int ibm_hdaps_mousedev_registered = 0;
-static int ibm_hdaps_mousedev_enable(void)
+static int ibm_hdaps_joystick_registered = 0;
+
+static void ibm_hdaps_joystick_disable(void)
 {
-	printk("ibm_hdaps_mousedev_enable()\n");
+	if (!ibm_hdaps_joystick_registered)
+		return;
+
+	del_timer_sync(&ibm_hdaps_poll_timer);
+	input_unregister_device(&hdaps_idev);
+	ibm_hdaps_joystick_registered = 0;
+
+	return;
+}
+
+static int ibm_hdaps_joystick_enable(void)
+{
+	printk(KERN_DEBUG "ibm_hdaps_joystick_enable()\n");
 	hdaps_idev.dev = &ibm_hdaps_plat_dev.dev;
 	init_input_dev(&hdaps_idev);
-	hdaps_idev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
-	hdaps_idev.relbit[0] = BIT(REL_X) | BIT(REL_Y);
-	hdaps_idev.keybit[LONG(BTN_LEFT)] = BIT(BTN_LEFT);
+	hdaps_idev.name = "IBM Accelerometer";
+	hdaps_idev.evbit[0] = BIT(EV_ABS);
+	hdaps_idev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
 	input_register_device(&hdaps_idev);
-	ibm_hdaps_mousedev_registered = 1;
+	ibm_hdaps_joystick_registered = 1;
 
 	init_timer(&ibm_hdaps_poll_timer);
-	ibm_hdaps_poll_timer.function = ibm_hdaps_mousedev_poll;
+	ibm_hdaps_poll_timer.function = ibm_hdaps_joystick_poll;
 	ibm_hdaps_poll_timer.expires =
 		jiffies + msecs_to_jiffies(ibm_hdaps_poll_int_msecs);
 	add_timer(&ibm_hdaps_poll_timer);
@@ -418,39 +431,199 @@
 	return 1;
 }
 
-static void ibm_hdaps_mousedev_disable(void)
+static ssize_t
+hdaps_joystick_enable_read(struct device *dev, char *buf)
 {
-	if (!ibm_hdaps_mousedev_registered)
-		return;
+	if (ibm_hdaps_joystick_registered)
+	{
+		snprintf(buf, 256, "enabled\n");
+	}
+	else
+		snprintf(buf, 256, "disabled\n");
+	return strlen(buf)+1;
+}
 
-	del_timer_sync(&ibm_hdaps_poll_timer);
-	input_unregister_device(&hdaps_idev);
+static ssize_t
+hdaps_joystick_enable_store(struct device *dev, const char * buf, size_t count)
+{
+	if ((strncmp(buf, "1", 1) == 0)&&(!ibm_hdaps_joystick_registered))
+	{
+		ibm_hdaps_joystick_enable();
+	}
+	else if ((strncmp(buf, "0", 1) == 0)&&(ibm_hdaps_joystick_registered))
+	{
+		ibm_hdaps_joystick_disable();
+	}
+	return count;
+}
+static DEVICE_ATTR(joystick_enable, S_IWUGO | S_IRUGO, hdaps_joystick_enable_read, hdaps_joystick_enable_store);
 
-	return;
+static ssize_t
+hdaps_joystick_fuzzx_read(struct device *dev, char *buf)
+{
+	snprintf(buf, 256, "%hu\n", hdaps_idev.absfuzz[ABS_X]);
+	return strlen(buf)+1;
 }
 
 static ssize_t
-hdaps_mousedev_enable_store(struct device *dev, struct device_attribute *attr,
-		const char * buf, size_t count)
+hdaps_joystick_fuzzx_store(struct device *dev, const char * buf, size_t count)
 {
-	if (!calibrated)
+	uint16_t temp;
+	if (ibm_hdaps_joystick_registered)
 		return -EINVAL;
+	if (sscanf(buf, "%hu", &temp) == 1)
+	{
+		hdaps_idev.absfuzz[ABS_X] = temp;
+	}
+	return count;
+}
+static DEVICE_ATTR(joystick_fuzzx, S_IWUGO | S_IRUGO, hdaps_joystick_fuzzx_read, hdaps_joystick_fuzzx_store);
 
-	ibm_hdaps_mousedev_enable();
+static ssize_t
+hdaps_joystick_fuzzy_read(struct device *dev, char *buf)
+{
+	snprintf(buf, 256, "%hu\n", hdaps_idev.absfuzz[ABS_Y]);
+	return strlen(buf)+1;
+}
+
+static ssize_t
+hdaps_joystick_fuzzy_store(struct device *dev, const char * buf, size_t count)
+{
+	uint16_t temp;
+	if (ibm_hdaps_joystick_registered)
+		return -EINVAL;
+	if (sscanf(buf, "%hu", &temp) == 1)
+	{
+		hdaps_idev.absfuzz[ABS_Y] = temp;
+	}
 	return count;
 }
-static DEVICE_ATTR(mousedev_enable,S_IWUGO, NULL, hdaps_mousedev_enable_store);
+static DEVICE_ATTR(joystick_fuzzy, S_IWUGO | S_IRUGO, hdaps_joystick_fuzzy_read, hdaps_joystick_fuzzy_store);
 
-ssize_t hdaps_calibrate_store(struct device *dev,
-		struct device_attribute *attr,
-		const char * buf, size_t count)
+static ssize_t
+hdaps_joystick_minx_read(struct device *dev, char *buf)
 {
-	hdaps_calibrate();
-	calibrated = 1;
+	snprintf(buf, 256, "%hu\n", hdaps_idev.absmin[ABS_X]);
+	return strlen(buf)+1;
+}
+
+static ssize_t
+hdaps_joystick_minx_store(struct device *dev, const char * buf, size_t count)
+{
+	uint16_t temp;
+	if (ibm_hdaps_joystick_registered)
+		return -EINVAL;
+	if (sscanf(buf, "%hu", &temp) == 1)
+	{
+		hdaps_idev.absmin[ABS_X] = temp;
+	}
 	return count;
 }
-static DEVICE_ATTR(calibrate,S_IWUGO, NULL, hdaps_calibrate_store);
+static DEVICE_ATTR(joystick_minx, S_IWUGO | S_IRUGO, hdaps_joystick_minx_read, hdaps_joystick_minx_store);
 
+static ssize_t
+hdaps_joystick_miny_read(struct device *dev, char *buf)
+{
+	snprintf(buf, 256, "%hu\n", hdaps_idev.absmin[ABS_Y]);
+	return strlen(buf)+1;
+}
+
+static ssize_t
+hdaps_joystick_miny_store(struct device *dev, const char * buf, size_t count)
+{
+	uint16_t temp;
+	if (ibm_hdaps_joystick_registered)
+		return -EINVAL;
+	if (sscanf(buf, "%hu", &temp) == 1)
+	{
+		hdaps_idev.absmin[ABS_Y] = temp;
+	}
+	return count;
+}
+static DEVICE_ATTR(joystick_miny, S_IWUGO | S_IRUGO, hdaps_joystick_miny_read, hdaps_joystick_miny_store);
+
+static ssize_t
+hdaps_joystick_maxx_read(struct device *dev, char *buf)
+{
+	snprintf(buf, 256, "%hu\n", hdaps_idev.absmax[ABS_X]);
+	return strlen(buf)+1;
+}
+
+static ssize_t
+hdaps_joystick_maxx_store(struct device *dev, const char * buf, size_t count)
+{
+	uint16_t temp;
+	if (ibm_hdaps_joystick_registered)
+		return -EINVAL;
+	if (sscanf(buf, "%hu", &temp) == 1)
+	{
+		hdaps_idev.absmax[ABS_X] = temp;
+	}
+	return count;
+}
+static DEVICE_ATTR(joystick_maxx, S_IWUGO | S_IRUGO, hdaps_joystick_maxx_read, hdaps_joystick_maxx_store);
+
+static ssize_t
+hdaps_joystick_maxy_read(struct device *dev, char *buf)
+{
+	snprintf(buf, 256, "%hu\n", hdaps_idev.absmax[ABS_Y]);
+	return strlen(buf)+1;
+}
+
+static ssize_t
+hdaps_joystick_maxy_store(struct device *dev, const char * buf, size_t count)
+{
+	uint16_t temp;
+	if (ibm_hdaps_joystick_registered)
+		return -EINVAL;
+	if (sscanf(buf, "%hu", &temp) == 1)
+	{
+		hdaps_idev.absmax[ABS_Y] = temp;
+	}
+	return count;
+}
+static DEVICE_ATTR(joystick_maxy, S_IWUGO | S_IRUGO, hdaps_joystick_maxy_read, hdaps_joystick_maxy_store);
+
+static ssize_t
+hdaps_joystick_reversex_read(struct device *dev, char *buf)
+{
+	snprintf(buf, 256, "%hu\n", ibm_hdaps_joystick_reversex);
+	return strlen(buf)+1;
+}
+
+static ssize_t
+hdaps_joystick_reversex_store(struct device *dev, const char * buf, size_t count)
+{
+	if (ibm_hdaps_joystick_registered)
+		return -EINVAL;
+	if (strncmp(buf, "1", 1) == 0)
+		ibm_hdaps_joystick_reversex = 1;
+	else if (strncmp(buf, "0", 1) == 0)
+		ibm_hdaps_joystick_reversex = 0;
+	return count;
+}
+static DEVICE_ATTR(joystick_reversex, S_IWUGO | S_IRUGO, hdaps_joystick_reversex_read, hdaps_joystick_reversex_store);
+
+static ssize_t
+hdaps_joystick_reversey_read(struct device *dev, char *buf)
+{
+	snprintf(buf, 256, "%hu\n", ibm_hdaps_joystick_reversey);
+	return strlen(buf)+1;
+}
+
+static ssize_t
+hdaps_joystick_reversey_store(struct device *dev, const char * buf, size_t count)
+{
+	if (ibm_hdaps_joystick_registered)
+		return -EINVAL;
+	if (strncmp(buf, "1", 1) == 0)
+		ibm_hdaps_joystick_reversey = 1;
+	else if (strncmp(buf, "0", 1) == 0)
+		ibm_hdaps_joystick_reversey = 0;
+	return count;
+}
+static DEVICE_ATTR(joystick_reversey, S_IWUGO | S_IRUGO, hdaps_joystick_reversey_read, hdaps_joystick_reversey_store);
+
 static int ibm_hdaps_init(void)
 {
 	int retval;
@@ -475,8 +648,15 @@
 	
 	printk(KERN_DEBUG "ibm_hdaps_init: platform_dev_register\n");
 	platform_device_register(&ibm_hdaps_plat_dev);
-	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_calibrate);
-	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_mousedev_enable);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_enable);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_fuzzx);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_fuzzy);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_minx);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_miny);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_maxx);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_maxy);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_reversex);
+	device_create_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_reversey);
 
 	printk(KERN_DEBUG "ibm_hdaps_init: done\n");
 	return 0;
@@ -484,10 +664,17 @@
 
 static void ibm_hdaps_exit(void)
 {
-	ibm_hdaps_mousedev_disable();
+	ibm_hdaps_joystick_disable();
 
-	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_calibrate);
-	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_mousedev_enable);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_enable);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_fuzzx);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_fuzzy);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_minx);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_miny);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_maxx);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_maxy);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_reversex);
+	device_remove_file(&ibm_hdaps_plat_dev.dev, &dev_attr_joystick_reversey);
 	platform_device_unregister(&ibm_hdaps_plat_dev);
 
 	misc_deregister(&ibm_hdaps_dev);

--Multipart_Mon__11_Jul_2005_22_09_11_+0200_Uwqb54L_vMtjmdsL--
