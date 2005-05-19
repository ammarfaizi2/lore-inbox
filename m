Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVESUC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVESUC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVESUC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:02:59 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:6157 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261238AbVESUC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:02:29 -0400
Date: Thu, 19 May 2005 22:02:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: Greg KH <greg@kroah.com>, LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
 drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Message-Id: <20050519220235.3946f880.khali@linux-fr.org>
In-Reply-To: <253818670505172136613abb43@mail.gmail.com>
References: <2538186705051703479bd0c29@mail.gmail.com>
	<e9iUj0EZ.1116327879.1515720.khali@localhost>
	<2538186705051704181a70dbbf@mail.gmail.com>
	<253818670505172136613abb43@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yanu

> > If you could come up with an additional demonstration patch for
> > either the lm90 driver or the it87 driver, I would happily give it
> > a try. The adm1026 has very few users AFAIK so it might not be the
> > best choice to find testers, although I agree that it was a
> > convenient way to demonstrate how drivers could benefit from the
> > proposed change.
> 
> Here is a patch against it87, since it seems to have many more device
> attributes than lm90. The size difference:
> 
> before:
> Module                  Size  Used by
> it87                   28832  0
> after:
> Module                  Size  Used by
> it87                   22432  0
> 
> That isn't bad, but the code cleanup is worth it alone in my opinion.

I finally gave a try to your patches, including the one for it87 which I
used for testing. It all works like a charm, pretty impressive
considering the overall complexity of the change. Congratulations :)

I'd like to add that the technical solution you came up with pleases me
much (which may or may not be relevant).

If we are into code refactoring and driver size shrinking, you may want
to take a look at the following patch, which makes it87 even smaller
(from 18976 bytes down to 16992 bytes on my system) and IMHO more
cleaner. I do voluntarily not sign it, it's not meant for immediate
inclusion, I'd rather see your changes in mainstream before I start
pushing my own ones. It's simply meant as a proof that your proposed big
change doesn't prevent further improvements, which is great :) Basically
the idea is to use arrays for the device sysfs attributes, so that we
then can use a loop to instantiate them instead of having to instantiate
each one individually. The same could be done in many other hardware
monitoring drivers as well, of course (which is why I defined the helper
macros in i2c-sysfs.h).

And once again... great great work Yani :)

Thanks.

 drivers/i2c/chips/it87.c  |  227 ++++++++++++++++++++++------------------------
 include/linux/i2c-sysfs.h |   10 ++
 2 files changed, 119 insertions(+), 118 deletions(-)

Index: linux-2.6.12-rc4/drivers/i2c/chips/it87.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/i2c/chips/it87.c	2005-05-19 19:13:52.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/chips/it87.c	2005-05-19 21:33:49.000000000 +0200
@@ -304,33 +304,40 @@
 	return count;
 }
 
-#define show_in_offset(offset)					\
-static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, 		\
-		show_in, NULL, offset);
-
-#define limit_in_offset(offset)					\
-static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, 	\
-		show_in_min, set_in_min, offset);		\
-static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, 	\
-		show_in_max, set_in_max, offset);
-
-show_in_offset(0);
-limit_in_offset(0);
-show_in_offset(1);
-limit_in_offset(1);
-show_in_offset(2);
-limit_in_offset(2);
-show_in_offset(3);
-limit_in_offset(3);
-show_in_offset(4);
-limit_in_offset(4);
-show_in_offset(5);
-limit_in_offset(5);
-show_in_offset(6);
-limit_in_offset(6);
-show_in_offset(7);
-limit_in_offset(7);
-show_in_offset(8);
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(in_input, 9)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in0_input, S_IRUGO, show_in, NULL, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in1_input, S_IRUGO, show_in, NULL, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in2_input, S_IRUGO, show_in, NULL, 2)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in3_input, S_IRUGO, show_in, NULL, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in4_input, S_IRUGO, show_in, NULL, 4)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in5_input, S_IRUGO, show_in, NULL, 5)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in6_input, S_IRUGO, show_in, NULL, 6)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in7_input, S_IRUGO, show_in, NULL, 7)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in8_input, S_IRUGO, show_in, NULL, 8)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(in_min, 8)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in0_min, S_IRUGO | S_IWUSR, show_in_min, set_in_min, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in1_min, S_IRUGO | S_IWUSR, show_in_min, set_in_min, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in2_min, S_IRUGO | S_IWUSR, show_in_min, set_in_min, 2)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in3_min, S_IRUGO | S_IWUSR, show_in_min, set_in_min, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in4_min, S_IRUGO | S_IWUSR, show_in_min, set_in_min, 4)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in5_min, S_IRUGO | S_IWUSR, show_in_min, set_in_min, 5)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in6_min, S_IRUGO | S_IWUSR, show_in_min, set_in_min, 6)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in7_min, S_IRUGO | S_IWUSR, show_in_min, set_in_min, 7)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(in_max, 8)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in0_max, S_IRUGO | S_IWUSR, show_in_max, set_in_max, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in1_max, S_IRUGO | S_IWUSR, show_in_max, set_in_max, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in2_max, S_IRUGO | S_IWUSR, show_in_max, set_in_max, 2)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in3_max, S_IRUGO | S_IWUSR, show_in_max, set_in_max, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in4_max, S_IRUGO | S_IWUSR, show_in_max, set_in_max, 4)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in5_max, S_IRUGO | S_IWUSR, show_in_max, set_in_max, 5)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in6_max, S_IRUGO | S_IWUSR, show_in_max, set_in_max, 6)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(in7_max, S_IRUGO | S_IWUSR, show_in_max, set_in_max, 7)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
 
 /* 3 temperatures */
 static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
@@ -392,17 +399,25 @@
 	up(&data->update_lock);
 	return count;
 }
-#define show_temp_offset(offset)					\
-static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, 		\
-		show_temp, NULL, offset - 1); 				\
-static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 	\
-		show_temp_max, set_temp_max, offset - 1); 		\
-static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR, 	\
-		show_temp_min, set_temp_min, offset - 1);
-
-show_temp_offset(1);
-show_temp_offset(2);
-show_temp_offset(3);
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(temp_input, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp1_input, S_IRUGO, show_temp, NULL, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp2_input, S_IRUGO, show_temp, NULL, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp3_input, S_IRUGO, show_temp, NULL, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(temp_min, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp1_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp2_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp3_min, S_IRUGO | S_IWUSR, show_temp_min, set_temp_min, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(temp_max, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp1_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp2_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp3_max, S_IRUGO | S_IWUSR, show_temp_max, set_temp_max, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
 
 static ssize_t show_sensor(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -451,13 +466,13 @@
 	up(&data->update_lock);
 	return count;
 }
-#define show_sensor_offset(offset)					\
-static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, 	\
-		show_sensor, set_sensor, offset - 1);
-
-show_sensor_offset(1);
-show_sensor_offset(2);
-show_sensor_offset(3);
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(temp_type, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp1_type, S_IRUGO | S_IWUSR, show_sensor, set_sensor, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp2_type, S_IRUGO | S_IWUSR, show_sensor, set_sensor, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(temp3_type, S_IRUGO | S_IWUSR, show_sensor, set_sensor, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
 
 /* 3 Fans */
 static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
@@ -619,27 +634,36 @@
 	return count;
 }
 
-#define show_fan_offset(offset)					\
-static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, 	\
-		show_fan, NULL, offset - 1); 			\
-static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
-		show_fan_min, set_fan_min, offset - 1); 	\
-static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
-		show_fan_div, set_fan_div, offset - 1);
-
-show_fan_offset(1);
-show_fan_offset(2);
-show_fan_offset(3);
-
-#define show_pwm_offset(offset)						\
-static SENSOR_DEVICE_ATTR(pwm##offset##_enable, S_IRUGO | S_IWUSR,	\
-		show_pwm_enable, set_pwm_enable, offset - 1);		\
-static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
-		show_pwm , set_pwm, offset - 1);
-
-show_pwm_offset(1);
-show_pwm_offset(2);
-show_pwm_offset(3);
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(fan_input, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan1_input, S_IRUGO, show_fan, NULL, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan2_input, S_IRUGO, show_fan, NULL, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan3_input, S_IRUGO, show_fan, NULL, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(fan_min, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan1_min, S_IRUGO | S_IWUSR, show_fan_min, set_fan_min, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan2_min, S_IRUGO | S_IWUSR, show_fan_min, set_fan_min, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan3_min, S_IRUGO | S_IWUSR, show_fan_min, set_fan_min, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(fan_div, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan1_div, S_IRUGO | S_IWUSR, show_fan_div, set_fan_div, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan2_div, S_IRUGO | S_IWUSR, show_fan_div, set_fan_div, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(fan3_div, S_IRUGO | S_IWUSR, show_fan_div, set_fan_div, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(pwm, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(pwm2, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(pwm3, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
+static SENSOR_DEVICE_ATTR_ARRAY_HEAD(pwm_enable, 3)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable, set_pwm_enable, 0)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(pwm2_enable, S_IRUGO | S_IWUSR, show_pwm_enable, set_pwm_enable, 1)
+SENSOR_DEVICE_ATTR_ARRAY_ITEM(pwm3_enable, S_IRUGO | S_IWUSR, show_pwm_enable, set_pwm_enable, 2)
+SENSOR_DEVICE_ATTR_ARRAY_TAIL;
+
 
 /* Alarms */
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
@@ -843,60 +867,27 @@
 	it87_init_client(new_client, data);
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in4_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in5_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in6_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in7_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in8_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in0_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in1_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in2_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in3_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in4_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in5_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in6_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in7_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in0_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in1_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in2_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in3_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in4_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in5_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in6_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_in7_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_max.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp1_type.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp2_type.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_temp3_type.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_input.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_min.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
-	device_create_file(&new_client->dev, &sensor_dev_attr_fan3_div.dev_attr);
+	for (i=0; i<8; i++) {
+		device_create_file(&new_client->dev, &sensor_dev_attr_in_input[i].dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in_min[i].dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_in_max[i].dev_attr);
+	}
+	device_create_file(&new_client->dev, &sensor_dev_attr_in_input[8].dev_attr);
+	for (i=0; i<3; i++) {
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp_input[i].dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp_min[i].dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp_max[i].dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_temp_type[i].dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_fan_input[i].dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_fan_min[i].dev_attr);
+		device_create_file(&new_client->dev, &sensor_dev_attr_fan_div[i].dev_attr);
+	}
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 	if (enable_pwm_interface) {
-		device_create_file(&new_client->dev, &sensor_dev_attr_pwm1_enable.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_pwm2_enable.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_pwm3_enable.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_pwm1.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_pwm2.dev_attr);
-		device_create_file(&new_client->dev, &sensor_dev_attr_pwm3.dev_attr);
+		for (i=0; i<3; i++) {
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm_enable[i].dev_attr);
+			device_create_file(&new_client->dev, &sensor_dev_attr_pwm[i].dev_attr);
+		}
 	}
 
 	if (data->type == it8712) {
Index: linux-2.6.12-rc4/include/linux/i2c-sysfs.h
===================================================================
--- linux-2.6.12-rc4.orig/include/linux/i2c-sysfs.h	2005-05-19 19:13:52.000000000 +0200
+++ linux-2.6.12-rc4/include/linux/i2c-sysfs.h	2005-05-19 20:40:21.000000000 +0200
@@ -34,4 +34,14 @@
 	.index=_index,						\
 }
 
+#define SENSOR_DEVICE_ATTR_ARRAY_HEAD(_name,_size)		\
+struct sensor_device_attribute sensor_dev_attr_##_name[_size] = {
+
+#define SENSOR_DEVICE_ATTR_ARRAY_ITEM(_name,_mode,_show,_store,_index)	\
+	{ .dev_attr=__ATTR(_name,_mode,_show,_store),		\
+	  .index=_index, },
+
+#define SENSOR_DEVICE_ATTR_ARRAY_TAIL				\
+}
+
 #endif /* _LINUX_I2C_SYSFS_H */


-- 
Jean Delvare
