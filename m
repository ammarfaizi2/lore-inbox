Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWCaKH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWCaKH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCaKFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:05:17 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:14125 "EHLO
	linux") by vger.kernel.org with ESMTP id S932080AbWCaKEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:48 -0500
Message-Id: <20060331100423.320464000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:24 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 01/10] RTC subsystem, DS1672 oscillator handling
Content-Disposition: inline; filename=rtc-subsys-ds1672-fix-osc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kumar Gala <galak@kernel.crashing.org>

* Always enable the oscillator when we set the time
* If the oscillator is disable when we probe the RTC report back a warning
  to the user
* Added sysfs attribute to represent the state of the oscillator

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
commit 3acc1a4629e70bce7493b5463f3c785379ae8b6b
tree 34463406603ac788697d8d228a2caf2c0ea40b3a
parent 329b10bb0feacb7fb9a41389313ff0a51ae56f2a
author Kumar Gala <galak@kernel.crashing.org> Tue, 28 Mar 2006 16:53:43 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 28 Mar 2006 16:53:43 -0600

 drivers/rtc/rtc-ds1672.c |   61 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 3 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-ds1672.c	2006-03-29 02:14:50.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-ds1672.c	2006-03-29 02:16:01.000000000 +0200
@@ -23,6 +23,7 @@ I2C_CLIENT_INSMOD;
 
 #define DS1672_REG_CNT_BASE	0
 #define DS1672_REG_CONTROL	4
+#define DS1672_REG_CONTROL_EOSC	0x80
 #define DS1672_REG_TRICKLE	5
 
 
@@ -72,16 +73,17 @@ static int ds1672_get_datetime(struct i2
 static int ds1672_set_mmss(struct i2c_client *client, unsigned long secs)
 {
 	int xfer;
-	unsigned char buf[5];
+	unsigned char buf[6];
 
 	buf[0] = DS1672_REG_CNT_BASE;
 	buf[1] = secs & 0x000000FF;
 	buf[2] = (secs & 0x0000FF00) >> 8;
 	buf[3] = (secs & 0x00FF0000) >> 16;
 	buf[4] = (secs & 0xFF000000) >> 24;
+	buf[5] = 0;	/* set control reg to enable counting */
 
-	xfer = i2c_master_send(client, buf, 5);
-	if (xfer != 5) {
+	xfer = i2c_master_send(client, buf, 6);
+	if (xfer != 6) {
 		dev_err(&client->dev, "%s: send: %d\n", __FUNCTION__, xfer);
 		return -EIO;
 	}
@@ -120,6 +122,44 @@ static int ds1672_rtc_set_mmss(struct de
 	return ds1672_set_mmss(to_i2c_client(dev), secs);
 }
 
+static int ds1672_get_control(struct i2c_client *client, u8 *status)
+{
+	unsigned char addr = DS1672_REG_CONTROL;
+
+	struct i2c_msg msgs[] = {
+		{ client->addr, 0, 1, &addr },		/* setup read ptr */
+		{ client->addr, I2C_M_RD, 1, status },	/* read control */
+	};
+
+	/* read control register */
+	if ((i2c_transfer(client->adapter, &msgs[0], 2)) != 2) {
+		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* following are the sysfs callback functions */
+static ssize_t show_control(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	char *state = "enabled";
+	u8 control;
+	int err;
+
+	err = ds1672_get_control(client, &control);
+	if (err)
+		return err;
+
+	if (control & DS1672_REG_CONTROL_EOSC)
+		state = "disabled";
+
+	return sprintf(buf, "%s\n", state);
+}
+
+static DEVICE_ATTR(control, S_IRUGO, show_control, NULL);
+
 static struct rtc_class_ops ds1672_rtc_ops = {
 	.read_time	= ds1672_rtc_read_time,
 	.set_time	= ds1672_rtc_set_time,
@@ -162,6 +202,7 @@ static struct i2c_driver ds1672_driver =
 static int ds1672_probe(struct i2c_adapter *adapter, int address, int kind)
 {
 	int err = 0;
+	u8 control;
 	struct i2c_client *client;
 	struct rtc_device *rtc;
 
@@ -202,6 +243,20 @@ static int ds1672_probe(struct i2c_adapt
 
 	i2c_set_clientdata(client, rtc);
 
+	/* read control register */
+	err = ds1672_get_control(client, &control);
+	if (err) {
+		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
+		goto exit_detach;
+	}
+
+	if (control & DS1672_REG_CONTROL_EOSC)
+		dev_warn(&client->dev, "Oscillator not enabled. "
+					"Set time to enable.\n");
+
+	/* Register sysfs hooks */
+	device_create_file(&client->dev, &dev_attr_control);
+
 	return 0;
 
 exit_detach:

--
