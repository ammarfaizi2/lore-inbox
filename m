Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUHWUGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUHWUGo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHWUEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:04:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:39875 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266509AbUHWSgI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:08 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860901833@kroah.com>
Date: Mon, 23 Aug 2004 11:34:50 -0700
Message-Id: <10932860903581@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.59.8, 2004/08/05 16:39:27-07:00, R.Marek@sh.cvut.cz

[PATCH] I2C: automatic VRM detection part2

This is second part, which just adds the functionality to existing code
base, also including support of vid inputs for it8712 chip.

This patch was also briefly reviewed by Jean Delvare.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/adm1025.c  |    2 -
 drivers/i2c/chips/asb100.c   |    5 ---
 drivers/i2c/chips/it87.c     |   56 +++++++++++++++++++++++++++++++++++++++----
 drivers/i2c/chips/lm85.c     |    5 ---
 drivers/i2c/chips/w83627hf.c |    2 -
 drivers/i2c/chips/w83781d.c  |    2 -
 6 files changed, 57 insertions(+), 15 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1025.c b/drivers/i2c/chips/adm1025.c
--- a/drivers/i2c/chips/adm1025.c	2004-08-23 11:04:53 -07:00
+++ b/drivers/i2c/chips/adm1025.c	2004-08-23 11:04:53 -07:00
@@ -455,7 +455,7 @@
 	struct adm1025_data *data = i2c_get_clientdata(client);
 	int i;
 
-	data->vrm = 82;
+	data->vrm = i2c_which_vrm();
 
 	/*
 	 * Set high limits
diff -Nru a/drivers/i2c/chips/asb100.c b/drivers/i2c/chips/asb100.c
--- a/drivers/i2c/chips/asb100.c	2004-08-23 11:04:53 -07:00
+++ b/drivers/i2c/chips/asb100.c	2004-08-23 11:04:53 -07:00
@@ -63,9 +63,6 @@
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
-/* default VRM to 9.0 instead of 8.2 */
-#define ASB100_DEFAULT_VRM 90
-
 /* Insmod parameters */
 SENSORS_INSMOD_1(asb100);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
@@ -959,7 +956,7 @@
 
 	vid = asb100_read_value(client, ASB100_REG_VID_FANDIV) & 0x0f;
 	vid |= (asb100_read_value(client, ASB100_REG_CHIPID) & 0x01) << 4;
-	data->vrm = ASB100_DEFAULT_VRM;
+	data->vrm = i2c_which_vrm();
 	vid = vid_from_reg(vid, data->vrm);
 
 	/* Start monitoring */
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-08-23 11:04:53 -07:00
+++ b/drivers/i2c/chips/it87.c	2004-08-23 11:04:53 -07:00
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
+#include <linux/i2c-vid.h>
 #include <asm/io.h>
 
 
@@ -47,7 +48,7 @@
 static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
-SENSORS_INSMOD_1(it87);
+SENSORS_INSMOD_2(it87, it8712);
 
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
@@ -163,8 +164,6 @@
 					((val)+500)/1000),-128,127))
 #define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*1000)
 
-#define VID_FROM_REG(val) ((val)==0x1f?0:(val)>=0x10?510-(val)*10:\
-				205-(val)*5)
 #define ALARMS_FROM_REG(val) (val)
 
 static int DIV_TO_REG(int val)
@@ -201,6 +200,7 @@
 	u8 sensor;		/* Register value */
 	u8 fan_div[3];		/* Register encoding, shifted right */
 	u8 vid;			/* Register encoding, combined */
+	int vrm;
 	u32 alarms;		/* Register encoding, combined */
 };
 
@@ -543,6 +543,38 @@
 }
 static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);
 
+static ssize_t
+show_vrm_reg(struct device *dev, char *buf)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%ld\n", (long) data->vrm);
+}
+static ssize_t
+store_vrm_reg(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct it87_data *data = i2c_get_clientdata(client);
+	u32 val;
+
+	val = simple_strtoul(buf, NULL, 10);
+	data->vrm = val;
+
+	return count;
+}
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
+#define device_create_file_vrm(client) \
+device_create_file(&client->dev, &dev_attr_vrm)
+
+static ssize_t
+show_vid_reg(struct device *dev, char *buf)
+{
+	struct it87_data *data = it87_update_device(dev);
+	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
+}
+static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid_reg, NULL);
+#define device_create_file_vid(client) \
+device_create_file(&client->dev, &dev_attr_in0_ref)
+
 /* This function is called when:
      * it87_driver is inserted (when this module is loaded), for each
        available adapter
@@ -659,7 +691,11 @@
 	if (kind <= 0) {
 		i = it87_read_value(new_client, IT87_REG_CHIPID);
 		if (i == 0x90) {
+			u16 val;
 			kind = it87;
+			val = (superio_inb(DEVID) << 8) |
+			superio_inb(DEVID + 1);
+			if (val == IT8712F_DEVID) kind = it8712;
 		}
 		else {
 			if (kind == 0)
@@ -674,6 +710,8 @@
 
 	if (kind == it87) {
 		name = "it87";
+	} else if (kind == it8712) {
+		name = "it8712";
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
@@ -741,6 +779,12 @@
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
+	if (data->type == it8712) {
+		device_create_file_vrm(new_client);
+		device_create_file_vid(new_client);
+		data->vrm = i2c_which_vrm();
+	}
+
 	return 0;
 
 ERROR2:
@@ -910,7 +954,11 @@
 			(it87_read_value(client, IT87_REG_ALARM3) << 16);
 
 		data->sensor = it87_read_value(client, IT87_REG_TEMP_ENABLE);
-
+		/* The 8705 does not have VID capability */
+		if (data->type == it8712) {
+			data->vid = it87_read_value(client, IT87_REG_VID);
+			data->vid &= 0x1f;
+		}
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-08-23 11:04:53 -07:00
+++ b/drivers/i2c/chips/lm85.c	2004-08-23 11:04:53 -07:00
@@ -308,9 +308,6 @@
  * version of the driver.
  */
 
-/* Typically used with Pentium 4 systems v9.1 VRM spec */
-#define LM85_INIT_VRM  91
-
 /* Chip sampling rates
  *
  * Some sensors are not updated more frequently than once per second
@@ -832,7 +829,7 @@
 		goto ERROR1;
 
 	/* Set the VRM version */
-	data->vrm = LM85_INIT_VRM ;
+	data->vrm = i2c_which_vrm();
 
 	/* Initialize the LM85 chip */
 	lm85_init_client(new_client);
diff -Nru a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c	2004-08-23 11:04:53 -07:00
+++ b/drivers/i2c/chips/w83627hf.c	2004-08-23 11:04:53 -07:00
@@ -1281,7 +1281,7 @@
 		data->vrm = (data->vrm_ovt & 0x01) ? 90 : 82;
 	} else {
 		/* Convert VID to voltage based on default VRM */
-		data->vrm = DEFAULT_VRM;
+		data->vrm = i2c_which_vrm();
 	}
 
 	tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	2004-08-23 11:04:53 -07:00
+++ b/drivers/i2c/chips/w83781d.c	2004-08-23 11:04:53 -07:00
@@ -1512,7 +1512,7 @@
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);
 	}
 
-	data->vrm = 82;
+	data->vrm = i2c_which_vrm();
 
 	if ((type != w83781d) && (type != as99127f)) {
 		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);

