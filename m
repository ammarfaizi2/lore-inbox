Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265082AbUFVSBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbUFVSBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUFVSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:00:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:48821 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265082AbUFVRnf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:35 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261112687@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:51 -0700
Message-Id: <10879261113701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.102.3, 2004/06/08 14:31:15-07:00, mhoffman@lightlink.com

[PATCH] I2C: add alternate VCORE calculations for w83627thf and w83637hf

This patch adds support for the alternate in0/VCORE calculation which is
available for 2 of 4 chips this driver supports.  It also fixes a minor
bug in the standard voltage input calculation.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/w83627hf.c |   94 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 91 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:47:55 2004
+++ b/drivers/i2c/chips/w83627hf.c	Tue Jun 22 09:47:55 2004
@@ -199,7 +199,7 @@
 #define W83627THF_REG_PWM2		0x03	/* 697HF and 637HF too */
 #define W83627THF_REG_PWM3		0x11	/* 637HF too */
 
-#define W83627THF_REG_VRM_OVT_CFG 	0x18	/* 637HF too, unused yet */
+#define W83627THF_REG_VRM_OVT_CFG 	0x18	/* 637HF too */
 
 static const u8 regpwm_627hf[] = { W83627HF_REG_PWM1, W83627HF_REG_PWM2 };
 static const u8 regpwm[] = { W83627THF_REG_PWM1, W83627THF_REG_PWM2,
@@ -222,7 +222,7 @@
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
 #define IN_TO_REG(val)  (SENSORS_LIMIT((((val) + 8)/16),0,255))
-#define IN_FROM_REG(val) ((val) * 16 + 5)
+#define IN_FROM_REG(val) ((val) * 16)
 
 static inline u8 FAN_TO_REG(long rpm, int div)
 {
@@ -312,6 +312,7 @@
 				   Default = 3435.
 				   Other Betas unimplemented */
 	u8 vrm;
+	u8 vrm_ovt;		/* Register value, 627thf & 637hf only */
 };
 
 
@@ -391,7 +392,6 @@
 sysfs_in_reg_offset(min, offset) \
 sysfs_in_reg_offset(max, offset)
 
-sysfs_in_offsets(0)
 sysfs_in_offsets(1)
 sysfs_in_offsets(2)
 sysfs_in_offsets(3)
@@ -401,6 +401,89 @@
 sysfs_in_offsets(7)
 sysfs_in_offsets(8)
 
+/* use a different set of functions for in0 */
+static ssize_t show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
+{
+	long in0;
+
+	if ((data->vrm_ovt & 0x01) &&
+		(w83627thf == data->type || w83637hf == data->type))
+
+		/* use VRM9 calculation */
+		in0 = (long)((reg * 488 + 70000 + 50) / 100);
+	else
+		/* use VRM8 (standard) calculation */
+		in0 = (long)IN_FROM_REG(reg);
+
+	return sprintf(buf,"%ld\n", in0);
+}
+
+static ssize_t show_regs_in_0(struct device *dev, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return show_in_0(data, buf, data->in[0]);
+}
+
+static ssize_t show_regs_in_min0(struct device *dev, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return show_in_0(data, buf, data->in_min[0]);
+}
+
+static ssize_t show_regs_in_max0(struct device *dev, char *buf)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+	return show_in_0(data, buf, data->in_max[0]);
+}
+
+static ssize_t store_regs_in_min0(struct device *dev,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627hf_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+	if ((data->vrm_ovt & 0x01) &&
+		(w83627thf == data->type || w83637hf == data->type))
+
+		/* use VRM9 calculation */
+		data->in_min[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+	else
+		/* use VRM8 (standard) calculation */
+		data->in_min[0] = IN_TO_REG(val);
+
+	w83627hf_write_value(client, W83781D_REG_IN_MIN(0), data->in_min[0]);
+	return count;
+}
+
+static ssize_t store_regs_in_max0(struct device *dev,
+	const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627hf_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+	if ((data->vrm_ovt & 0x01) &&
+		(w83627thf == data->type || w83637hf == data->type))
+		
+		/* use VRM9 calculation */
+		data->in_max[0] = (u8)(((val * 100) - 70000 + 244) / 488);
+	else
+		/* use VRM8 (standard) calculation */
+		data->in_max[0] = IN_TO_REG(val);
+
+	w83627hf_write_value(client, W83781D_REG_IN_MAX(0), data->in_max[0]);
+	return count;
+}
+
+static DEVICE_ATTR(in0_input, S_IRUGO, show_regs_in_0, NULL)
+static DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
+	show_regs_in_min0, store_regs_in_min0)
+static DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
+	show_regs_in_max0, store_regs_in_max0)
+
 #define device_create_file_in(client, offset) \
 do { \
 device_create_file(&client->dev, &dev_attr_in##offset##_input); \
@@ -1190,6 +1273,11 @@
 	} else if (w83627thf == data->type) {
 		data->vid = w83627thf_read_gpio5(client) & 0x1f;
 	}
+
+	/* Read VRM & OVT Config only once */
+	if (w83627thf == data->type || w83637hf == data->type)
+		data->vrm_ovt = 
+			w83627hf_read_value(client, W83627THF_REG_VRM_OVT_CFG);
 
 	/* Convert VID to voltage based on default VRM */
 	data->vrm = DEFAULT_VRM;

