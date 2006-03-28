Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWC1VIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWC1VIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWC1VIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:08:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:33193 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932211AbWC1VIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:08:45 -0500
Date: Tue, 28 Mar 2006 15:07:33 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: a.zummo@towertech.it
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: Added support for ds1672 control
Message-ID: <Pine.LNX.4.44.0603281507050.20373-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Always enable the oscillator when we set the time
* If the oscillator is disable when we probe the RTC report back a warning
  to the user
* Added sysfs attribute to represent the state of the oscillator

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit fde7a0afd6f8dca9b498aea689de3ca409c16732
tree c390aefedb2073d8a107ec70efe551993e51c943
parent 329b10bb0feacb7fb9a41389313ff0a51ae56f2a
author Kumar Gala <galak@kernel.crashing.org> Tue, 28 Mar 2006 15:07:03 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 28 Mar 2006 15:07:03 -0600

 drivers/rtc/rtc-ds1672.c |   51 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1672.c b/drivers/rtc/rtc-ds1672.c
index 358695a..283d19f 100644
--- a/drivers/rtc/rtc-ds1672.c
+++ b/drivers/rtc/rtc-ds1672.c
@@ -72,16 +72,17 @@ static int ds1672_get_datetime(struct i2
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
+	buf[5] = 0;
 
-	xfer = i2c_master_send(client, buf, 5);
-	if (xfer != 5) {
+	xfer = i2c_master_send(client, buf, 6);
+	if (xfer != 6) {
 		dev_err(&client->dev, "%s: send: %d\n", __FUNCTION__, xfer);
 		return -EIO;
 	}
@@ -120,6 +121,37 @@ static int ds1672_rtc_set_mmss(struct de
 	return ds1672_set_mmss(to_i2c_client(dev), secs);
 }
 
+static int ds1672_get_control(struct i2c_client *client)
+{
+	unsigned char addr = DS1672_REG_CONTROL;
+	unsigned char val = 0;
+
+	struct i2c_msg msgs[] = {
+		{ client->addr, 0, 1, &addr },		/* setup read ptr */
+		{ client->addr, I2C_M_RD, 1, &val },	/* read control */
+	};
+
+	/* read control register */
+	if ((i2c_transfer(client->adapter, &msgs[0], 2)) != 2) {
+		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
+		return -EIO;
+	} else
+		return val;
+}
+
+/* following are the sysfs callback functions */
+static ssize_t show_control(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	char *state = "enabled";
+
+	if (ds1672_get_control(client))
+		state = "disabled";
+	return sprintf(buf, "%s\n", state);
+}
+
+static DEVICE_ATTR(control, S_IRUGO, show_control, NULL);
+
 static struct rtc_class_ops ds1672_rtc_ops = {
 	.read_time	= ds1672_rtc_read_time,
 	.set_time	= ds1672_rtc_set_time,
@@ -202,6 +234,19 @@ static int ds1672_probe(struct i2c_adapt
 
 	i2c_set_clientdata(client, rtc);
 
+	/* read control register */
+	err = ds1672_get_control(client);
+	if (err < 0) {
+		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
+		goto exit_detach;
+	}
+	if (err > 0)
+		dev_warn(&client->dev, "Oscillator not enabled. "
+					"Set time to enable\n");
+
+	/* Register sysfs hooks */
+	device_create_file(&client->dev, &dev_attr_control);
+
 	return 0;
 
 exit_detach:

