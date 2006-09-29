Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161444AbWI2Ghy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161444AbWI2Ghy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWI2Ghy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:37:54 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:39269 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932544AbWI2Ghx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:37:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=qESRRjCGpkTl5BdiMZP694ofRnTNJcMXKVEnYFwo/uhzS6LoFqBDZSloK4kQJmquhM56Gbr8mc8e8/O7rnkx/XYN5Q3x7ftJb0JGC2ZIEVwi8oS/qOXX0tGwLgWXERLEy/Fet52NGAg14bdr8JUvi57inQQNHxovXPriggrxG3g=  ;
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [PATCH 2.6.18-git] constify rtc_class_ops, update drivers
Date: Thu, 28 Sep 2006 23:37:49 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609282337.50077.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update RTC framework so that drivers can constify their method tables,
moving them from ".data" to ".rodata".  Then update the drivers.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/include/linux/rtc.h
===================================================================
--- g26.orig/include/linux/rtc.h	2006-09-27 16:06:11.000000000 -0700
+++ g26/include/linux/rtc.h	2006-09-28 11:00:08.000000000 -0700
@@ -141,7 +141,7 @@ struct rtc_device
 	int id;
 	char name[RTC_DEVICE_NAME_SIZE];
 
-	struct rtc_class_ops *ops;
+	const struct rtc_class_ops *ops;
 	struct mutex ops_lock;
 
 	struct class_device *rtc_dev;
@@ -172,7 +172,7 @@ struct rtc_device
 
 extern struct rtc_device *rtc_device_register(const char *name,
 					struct device *dev,
-					struct rtc_class_ops *ops,
+					const struct rtc_class_ops *ops,
 					struct module *owner);
 extern void rtc_device_unregister(struct rtc_device *rdev);
 extern int rtc_interface_register(struct class_interface *intf);
Index: g26/drivers/rtc/class.c
===================================================================
--- g26.orig/drivers/rtc/class.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/class.c	2006-09-28 11:00:08.000000000 -0700
@@ -39,7 +39,7 @@ static void rtc_device_release(struct cl
  * Returns the pointer to the new struct class device.
  */
 struct rtc_device *rtc_device_register(const char *name, struct device *dev,
-					struct rtc_class_ops *ops,
+					const struct rtc_class_ops *ops,
 					struct module *owner)
 {
 	struct rtc_device *rtc;
Index: g26/drivers/rtc/rtc-proc.c
===================================================================
--- g26.orig/drivers/rtc/rtc-proc.c	2006-09-28 10:58:28.000000000 -0700
+++ g26/drivers/rtc/rtc-proc.c	2006-09-28 11:00:08.000000000 -0700
@@ -23,7 +23,7 @@ static int rtc_proc_show(struct seq_file
 {
 	int err;
 	struct class_device *class_dev = seq->private;
-	struct rtc_class_ops *ops = to_rtc_device(class_dev)->ops;
+	const struct rtc_class_ops *ops = to_rtc_device(class_dev)->ops;
 	struct rtc_wkalrm alrm;
 	struct rtc_time tm;
 
Index: g26/drivers/rtc/rtc-dev.c
===================================================================
--- g26.orig/drivers/rtc/rtc-dev.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-dev.c	2006-09-28 11:00:08.000000000 -0700
@@ -24,7 +24,7 @@ static int rtc_dev_open(struct inode *in
 	int err;
 	struct rtc_device *rtc = container_of(inode->i_cdev,
 					struct rtc_device, char_dev);
-	struct rtc_class_ops *ops = rtc->ops;
+	const struct rtc_class_ops *ops = rtc->ops;
 
 	/* We keep the lock as long as the device is in use
 	 * and return immediately if busy
@@ -209,7 +209,7 @@ static int rtc_dev_ioctl(struct inode *i
 	int err = 0;
 	struct class_device *class_dev = file->private_data;
 	struct rtc_device *rtc = to_rtc_device(class_dev);
-	struct rtc_class_ops *ops = rtc->ops;
+	const struct rtc_class_ops *ops = rtc->ops;
 	struct rtc_time tm;
 	struct rtc_wkalrm alarm;
 	void __user *uarg = (void __user *) arg;
Index: g26/drivers/rtc/rtc-at91.c
===================================================================
--- g26.orig/drivers/rtc/rtc-at91.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-at91.c	2006-09-28 11:00:08.000000000 -0700
@@ -267,7 +267,7 @@ static irqreturn_t at91_rtc_interrupt(in
 	return IRQ_NONE;		/* not handled */
 }
 
-static struct rtc_class_ops at91_rtc_ops = {
+static const struct rtc_class_ops at91_rtc_ops = {
 	.ioctl		= at91_rtc_ioctl,
 	.read_time	= at91_rtc_readtime,
 	.set_time	= at91_rtc_settime,
Index: g26/drivers/rtc/rtc-sa1100.c
===================================================================
--- g26.orig/drivers/rtc/rtc-sa1100.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-sa1100.c	2006-09-28 11:00:08.000000000 -0700
@@ -303,7 +303,7 @@ static int sa1100_rtc_proc(struct device
 	return 0;
 }
 
-static struct rtc_class_ops sa1100_rtc_ops = {
+static const struct rtc_class_ops sa1100_rtc_ops = {
 	.open = sa1100_rtc_open,
 	.read_callback = sa1100_rtc_read_callback,
 	.release = sa1100_rtc_release,
Index: g26/drivers/rtc/rtc-m48t86.c
===================================================================
--- g26.orig/drivers/rtc/rtc-m48t86.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-m48t86.c	2006-09-28 11:00:08.000000000 -0700
@@ -138,7 +138,7 @@ static int m48t86_rtc_proc(struct device
 	return 0;
 }
 
-static struct rtc_class_ops m48t86_rtc_ops = {
+static const struct rtc_class_ops m48t86_rtc_ops = {
 	.read_time	= m48t86_rtc_read_time,
 	.set_time	= m48t86_rtc_set_time,
 	.proc		= m48t86_rtc_proc,
Index: g26/drivers/rtc/rtc-rs5c372.c
===================================================================
--- g26.orig/drivers/rtc/rtc-rs5c372.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-rs5c372.c	2006-09-28 11:00:08.000000000 -0700
@@ -160,7 +160,7 @@ static int rs5c372_rtc_proc(struct devic
 	return 0;
 }
 
-static struct rtc_class_ops rs5c372_rtc_ops = {
+static const struct rtc_class_ops rs5c372_rtc_ops = {
 	.proc		= rs5c372_rtc_proc,
 	.read_time	= rs5c372_rtc_read_time,
 	.set_time	= rs5c372_rtc_set_time,
Index: g26/drivers/rtc/rtc-pcf8563.c
===================================================================
--- g26.orig/drivers/rtc/rtc-pcf8563.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-pcf8563.c	2006-09-28 11:00:08.000000000 -0700
@@ -227,7 +227,7 @@ static int pcf8563_rtc_set_time(struct d
 	return pcf8563_set_datetime(to_i2c_client(dev), tm);
 }
 
-static struct rtc_class_ops pcf8563_rtc_ops = {
+static const struct rtc_class_ops pcf8563_rtc_ops = {
 	.read_time	= pcf8563_rtc_read_time,
 	.set_time	= pcf8563_rtc_set_time,
 };
Index: g26/drivers/rtc/rtc-ds1672.c
===================================================================
--- g26.orig/drivers/rtc/rtc-ds1672.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-ds1672.c	2006-09-28 11:00:08.000000000 -0700
@@ -156,7 +156,7 @@ static ssize_t show_control(struct devic
 }
 static DEVICE_ATTR(control, S_IRUGO, show_control, NULL);
 
-static struct rtc_class_ops ds1672_rtc_ops = {
+static const struct rtc_class_ops ds1672_rtc_ops = {
 	.read_time	= ds1672_rtc_read_time,
 	.set_time	= ds1672_rtc_set_time,
 	.set_mmss	= ds1672_rtc_set_mmss,
Index: g26/drivers/rtc/rtc-ds1553.c
===================================================================
--- g26.orig/drivers/rtc/rtc-ds1553.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-ds1553.c	2006-09-28 11:00:08.000000000 -0700
@@ -250,7 +250,7 @@ static int ds1553_rtc_ioctl(struct devic
 	return 0;
 }
 
-static struct rtc_class_ops ds1553_rtc_ops = {
+static const struct rtc_class_ops ds1553_rtc_ops = {
 	.read_time	= ds1553_rtc_read_time,
 	.set_time	= ds1553_rtc_set_time,
 	.read_alarm	= ds1553_rtc_read_alarm,
Index: g26/drivers/rtc/rtc-pcf8583.c
===================================================================
--- g26.orig/drivers/rtc/rtc-pcf8583.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-pcf8583.c	2006-09-28 11:00:08.000000000 -0700
@@ -273,7 +273,7 @@ static int pcf8583_rtc_set_time(struct d
 	return ret;
 }
 
-static struct rtc_class_ops pcf8583_rtc_ops = {
+static const struct rtc_class_ops pcf8583_rtc_ops = {
 	.read_time	= pcf8583_rtc_read_time,
 	.set_time	= pcf8583_rtc_set_time,
 };
Index: g26/drivers/rtc/rtc-x1205.c
===================================================================
--- g26.orig/drivers/rtc/rtc-x1205.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-x1205.c	2006-09-28 11:00:08.000000000 -0700
@@ -460,7 +460,7 @@ static int x1205_rtc_proc(struct device 
 	return 0;
 }
 
-static struct rtc_class_ops x1205_rtc_ops = {
+static const struct rtc_class_ops x1205_rtc_ops = {
 	.proc		= x1205_rtc_proc,
 	.read_time	= x1205_rtc_read_time,
 	.set_time	= x1205_rtc_set_time,
Index: g26/drivers/rtc/rtc-s3c.c
===================================================================
--- g26.orig/drivers/rtc/rtc-s3c.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-s3c.c	2006-09-28 11:00:08.000000000 -0700
@@ -386,7 +386,7 @@ static void s3c_rtc_release(struct devic
 	free_irq(s3c_rtc_tickno, rtc_dev);
 }
 
-static struct rtc_class_ops s3c_rtcops = {
+static const struct rtc_class_ops s3c_rtcops = {
 	.open		= s3c_rtc_open,
 	.release	= s3c_rtc_release,
 	.ioctl		= s3c_rtc_ioctl,
Index: g26/drivers/rtc/rtc-rs5c348.c
===================================================================
--- g26.orig/drivers/rtc/rtc-rs5c348.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-rs5c348.c	2006-09-28 11:00:08.000000000 -0700
@@ -140,7 +140,7 @@ rs5c348_rtc_read_time(struct device *dev
 	return 0;
 }
 
-static struct rtc_class_ops rs5c348_rtc_ops = {
+static const struct rtc_class_ops rs5c348_rtc_ops = {
 	.read_time	= rs5c348_rtc_read_time,
 	.set_time	= rs5c348_rtc_set_time,
 };
Index: g26/drivers/rtc/rtc-test.c
===================================================================
--- g26.orig/drivers/rtc/rtc-test.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-test.c	2006-09-28 11:00:08.000000000 -0700
@@ -75,7 +75,7 @@ static int test_rtc_ioctl(struct device 
 	}
 }
 
-static struct rtc_class_ops test_rtc_ops = {
+static const struct rtc_class_ops test_rtc_ops = {
 	.proc = test_rtc_proc,
 	.read_time = test_rtc_read_time,
 	.set_time = test_rtc_set_time,
Index: g26/drivers/rtc/rtc-pl031.c
===================================================================
--- g26.orig/drivers/rtc/rtc-pl031.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-pl031.c	2006-09-28 11:00:08.000000000 -0700
@@ -128,7 +128,7 @@ static int pl031_set_alarm(struct device
 	return 0;
 }
 
-static struct rtc_class_ops pl031_ops = {
+static const struct rtc_class_ops pl031_ops = {
 	.open = pl031_open,
 	.release = pl031_release,
 	.ioctl = pl031_ioctl,
Index: g26/drivers/rtc/rtc-max6902.c
===================================================================
--- g26.orig/drivers/rtc/rtc-max6902.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-max6902.c	2006-09-28 11:00:08.000000000 -0700
@@ -207,7 +207,7 @@ static int max6902_set_time(struct devic
 	return max6902_set_datetime(dev, tm);
 }
 
-static struct rtc_class_ops max6902_rtc_ops = {
+static const struct rtc_class_ops max6902_rtc_ops = {
 	.read_time	= max6902_read_time,
 	.set_time	= max6902_set_time,
 };
Index: g26/drivers/rtc/rtc-ds1307.c
===================================================================
--- g26.orig/drivers/rtc/rtc-ds1307.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-ds1307.c	2006-09-28 11:00:08.000000000 -0700
@@ -178,7 +178,7 @@ static int ds1307_set_time(struct device
 	return 0;
 }
 
-static struct rtc_class_ops ds13xx_rtc_ops = {
+static const struct rtc_class_ops ds13xx_rtc_ops = {
 	.read_time	= ds1307_get_time,
 	.set_time	= ds1307_set_time,
 };
Index: g26/drivers/rtc/rtc-vr41xx.c
===================================================================
--- g26.orig/drivers/rtc/rtc-vr41xx.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-vr41xx.c	2006-09-28 11:00:08.000000000 -0700
@@ -296,7 +296,7 @@ static irqreturn_t rtclong1_interrupt(in
 	return IRQ_HANDLED;
 }
 
-static struct rtc_class_ops vr41xx_rtc_ops = {
+static const struct rtc_class_ops vr41xx_rtc_ops = {
 	.release	= vr41xx_rtc_release,
 	.ioctl		= vr41xx_rtc_ioctl,
 	.read_time	= vr41xx_rtc_read_time,
Index: g26/drivers/rtc/rtc-ep93xx.c
===================================================================
--- g26.orig/drivers/rtc/rtc-ep93xx.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-ep93xx.c	2006-09-28 11:00:08.000000000 -0700
@@ -73,7 +73,7 @@ static int ep93xx_rtc_proc(struct device
 	return 0;
 }
 
-static struct rtc_class_ops ep93xx_rtc_ops = {
+static const struct rtc_class_ops ep93xx_rtc_ops = {
 	.read_time	= ep93xx_rtc_read_time,
 	.set_time	= ep93xx_rtc_set_time,
 	.set_mmss	= ep93xx_rtc_set_mmss,
Index: g26/drivers/rtc/rtc-isl1208.c
===================================================================
--- g26.orig/drivers/rtc/rtc-isl1208.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-isl1208.c	2006-09-28 11:00:08.000000000 -0700
@@ -390,7 +390,7 @@ static int isl1208_rtc_read_alarm(struct
 	return isl1208_i2c_read_alarm(to_i2c_client(dev), alarm);
 }
 
-static struct rtc_class_ops isl1208_rtc_ops = {
+static const struct rtc_class_ops isl1208_rtc_ops = {
 	.proc		= isl1208_rtc_proc,
 	.read_time	= isl1208_rtc_read_time,
 	.set_time	= isl1208_rtc_set_time,
Index: g26/drivers/rtc/rtc-v3020.c
===================================================================
--- g26.orig/drivers/rtc/rtc-v3020.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-v3020.c	2006-09-28 11:00:08.000000000 -0700
@@ -149,7 +149,7 @@ static int v3020_set_time(struct device 
 	return 0;
 }
 
-static struct rtc_class_ops v3020_rtc_ops = {
+static const struct rtc_class_ops v3020_rtc_ops = {
 	.read_time	= v3020_read_time,
 	.set_time	= v3020_set_time,
 };
Index: g26/drivers/rtc/rtc-ds1742.c
===================================================================
--- g26.orig/drivers/rtc/rtc-ds1742.c	2006-09-27 16:06:11.000000000 -0700
+++ g26/drivers/rtc/rtc-ds1742.c	2006-09-28 11:00:08.000000000 -0700
@@ -116,7 +116,7 @@ static int ds1742_rtc_read_time(struct d
 	return 0;
 }
 
-static struct rtc_class_ops ds1742_rtc_ops = {
+static const struct rtc_class_ops ds1742_rtc_ops = {
 	.read_time	= ds1742_rtc_read_time,
 	.set_time	= ds1742_rtc_set_time,
 };
