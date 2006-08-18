Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWHREZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWHREZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 00:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWHREZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 00:25:08 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:64505 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964791AbWHREZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 00:25:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TUyRwy8Ar8whtTtyuDDEwLiifXqpOELlVpkEBcfAgGQEackaw3UDRRNZgC5Sv4M/XLCfiFMBXez+0l88tqcrVPqRC0zxrYV7IS04oncLpUlYFJh+WWCds0OSSYvEjcvAZ2+DDIdrUfUUMeGYi0OoIEnWfJ5T27ua7EXclb917m4=
Message-ID: <44E54137.8030805@gmail.com>
Date: Thu, 17 Aug 2006 22:25:27 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC-patch - make sysfs_create_group skip members with attr.mode
 == 0
References: <44E4F2B1.30408@gmail.com> <20060818014922.GA2622@martell.zuzino.mipt.ru>
In-Reply-To: <20060818014922.GA2622@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Thu, Aug 17, 2006 at 04:50:25PM -0600, Jim Cromie wrote:
>   
>> Currently, code in hwmon/*.c uses sysfs_create_group less than it could.
>>     
>
> Please, provide sample patch which will use this feature. And I personally
> don't understand the reasoning: can i2c code use sysfs_create_group()
> with elements of struct attribute_group::attrs array ifdeffed?
>
>   
>> A contributing reason is that many individual attr-files are created
>> conditionally,
>> depending upon both underlying hardware, driver configuration, etc.
>>     
>
>   
>> --- try1/fs/sysfs/group.c	2006-06-17 19:49:35.000000000 -0600
>> +++ try2/fs/sysfs/group.c	2006-08-17 10:06:26.000000000 -0600
>> @@ -32,7 +33,8 @@ static int create_files(struct dentry *
>> 	int error = 0;
>>
>> 	for (attr = grp->attrs; *attr && !error; attr++) {
>> -		error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
>> +		if ((*attr)->mode)
>> +			error = sysfs_add_file(dir, *attr, SYSFS_KOBJ_ATTR);
>> 	}
>>     
>
>
>   
Hi Alexy,

Heres my motivation for the above patch, in 2 parts.

hwmon/pc87360 supports 5 kinds of sensors -
voltages, temps, thermistors, fans, pwm-fan-controllers.
Formerly, all attr-files were created by individual calls
to device_create_file().

patch 1 declares 4 separate groups (fans & pwm are together),
and creates the attr-files by calling sysfs_create_group()
for each.  

This patch doesnt require the proposed patch, but sets it up..



diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc4-mm1-sk/drivers/hwmon/pc87360.c sys-grp/drivers/hwmon/pc87360.c
--- ../linux-2.6.18-rc4-mm1-sk/drivers/hwmon/pc87360.c	2006-08-14 21:19:24.000000000 -0600
+++ sys-grp/drivers/hwmon/pc87360.c	2006-08-15 22:46:16.000000000 -0600
@@ -327,6 +327,12 @@ static struct sensor_device_attribute fa
 	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min, set_fan_min, 2),
 };
 
+#define FAN_UNIT_ATTRS(X)	\
+	&fan_input[X].dev_attr.attr,	\
+	&fan_status[X].dev_attr.attr,	\
+	&fan_div[X].dev_attr.attr,	\
+	&fan_min[X].dev_attr.attr
+
 static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -359,6 +365,19 @@ static struct sensor_device_attribute pw
 	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2),
 };
 
+static struct attribute * pc8736x_fan_attr_array[] = {
+	FAN_UNIT_ATTRS(0),
+	FAN_UNIT_ATTRS(1),
+	FAN_UNIT_ATTRS(2),
+	&pwm[0].dev_attr.attr,
+	&pwm[1].dev_attr.attr,
+	&pwm[2].dev_attr.attr,
+	NULL
+};
+static const struct attribute_group pc8736x_fan_group = {
+	.attrs = pc8736x_fan_attr_array,
+};
+
 static ssize_t show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -471,6 +490,61 @@ static struct sensor_device_attribute in
 	SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
 };
 
+#define VIN_UNIT_ATTRS(X) \
+	&in_input[X].dev_attr.attr,	\
+	&in_status[X].dev_attr.attr,	\
+	&in_min[X].dev_attr.attr,	\
+	&in_max[X].dev_attr.attr
+
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
+}
+static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->vrm);
+}
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pc87360_data *data = i2c_get_clientdata(client);
+	data->vrm = simple_strtoul(buf, NULL, 10);
+	return count;
+}
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+
+static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct pc87360_data *data = pc87360_update_device(dev);
+	return sprintf(buf, "%u\n", data->in_alarms);
+}
+static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
+
+static struct attribute *pc8736x_vin_attr_array[] = {
+	VIN_UNIT_ATTRS(0),
+	VIN_UNIT_ATTRS(1),
+	VIN_UNIT_ATTRS(2),
+	VIN_UNIT_ATTRS(3),
+	VIN_UNIT_ATTRS(4),
+	VIN_UNIT_ATTRS(5),
+	VIN_UNIT_ATTRS(6),
+	VIN_UNIT_ATTRS(7),
+	VIN_UNIT_ATTRS(8),
+	VIN_UNIT_ATTRS(9),
+	VIN_UNIT_ATTRS(10),
+	&dev_attr_cpu0_vid.attr,
+	&dev_attr_vrm.attr,
+	&dev_attr_alarms_in.attr,
+	NULL
+};
+static const struct attribute_group pc8736x_vin_group = {
+	.attrs = pc8736x_vin_attr_array,
+};
+
 static ssize_t show_therm_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -589,33 +663,22 @@ static struct sensor_device_attribute th
 		    show_therm_crit, set_therm_crit, 2+11),
 };
 
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
-}
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
-
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->vrm);
-}
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pc87360_data *data = i2c_get_clientdata(client);
-	data->vrm = simple_strtoul(buf, NULL, 10);
-	return count;
-}
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-
-static ssize_t show_in_alarms(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct pc87360_data *data = pc87360_update_device(dev);
-	return sprintf(buf, "%u\n", data->in_alarms);
-}
-static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
+#define THERM_UNIT_ATTRS(X) \
+	&therm_input[X].dev_attr.attr,	\
+	&therm_status[X].dev_attr.attr,	\
+	&therm_min[X].dev_attr.attr,	\
+	&therm_max[X].dev_attr.attr,	\
+	&therm_crit[X].dev_attr.attr
+
+static struct attribute * pc8736x_therm_attr_array[] = {
+	THERM_UNIT_ATTRS(0),
+	THERM_UNIT_ATTRS(1),
+	THERM_UNIT_ATTRS(2),
+	NULL
+};
+static const struct attribute_group pc8736x_therm_group = {
+	.attrs = pc8736x_therm_attr_array,
+};
 
 static ssize_t show_temp_input(struct device *dev, struct device_attribute *devattr, char *buf)
 {
@@ -735,6 +798,25 @@ static ssize_t show_temp_alarms(struct d
 }
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
 
+#define TEMP_UNIT_ATTRS(X) \
+	&temp_input[X].dev_attr.attr,	\
+	&temp_status[X].dev_attr.attr,	\
+	&temp_min[X].dev_attr.attr,	\
+	&temp_max[X].dev_attr.attr,	\
+	&temp_crit[X].dev_attr.attr
+
+static struct attribute * pc8736x_temp_attr_array[] = {
+	TEMP_UNIT_ATTRS(0),
+	TEMP_UNIT_ATTRS(1),
+	TEMP_UNIT_ATTRS(2),
+	/* include the few miscellaneous atts here */
+	&dev_attr_alarms_temp.attr,
+	NULL
+};
+static const struct attribute_group pc8736x_temp_group = {
+	.attrs = pc8736x_temp_attr_array,
+};
+
 /*
  * Device detection, registration and update
  */
@@ -935,67 +1017,46 @@ static int pc87360_detect(struct i2c_ada
 		pc87360_init_client(client, use_thermistors);
 	}
 
-	/* Register sysfs hooks */
-	data->class_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->class_dev)) {
-		err = PTR_ERR(data->class_dev);
+	/* Register sysfs groups */
+
+	if (data->innr && 
+	    sysfs_create_group(&client->dev.kobj,
+			       &pc8736x_vin_group))
 		goto ERROR3;
-	}
 
-	if (data->innr) {
-		for (i = 0; i < 11; i++) {
-			device_create_file(dev, &in_input[i].dev_attr);
-			device_create_file(dev, &in_min[i].dev_attr);
-			device_create_file(dev, &in_max[i].dev_attr);
-			device_create_file(dev, &in_status[i].dev_attr);
-		}
-		device_create_file(dev, &dev_attr_cpu0_vid);
-		device_create_file(dev, &dev_attr_vrm);
-		device_create_file(dev, &dev_attr_alarms_in);
-	}
+	if (data->tempnr &&
+	    sysfs_create_group(&client->dev.kobj, 
+			       &pc8736x_temp_group))
+		goto ERROR3;
 
-	if (data->tempnr) {
-		for (i = 0; i < data->tempnr; i++) {
-			device_create_file(dev, &temp_input[i].dev_attr);
-			device_create_file(dev, &temp_min[i].dev_attr);
-			device_create_file(dev, &temp_max[i].dev_attr);
-			device_create_file(dev, &temp_crit[i].dev_attr);
-			device_create_file(dev, &temp_status[i].dev_attr);
-		}
-		device_create_file(dev, &dev_attr_alarms_temp);
-	}
+	if (data->innr == 14 &&
+	    sysfs_create_group(&client->dev.kobj, 
+			       &pc8736x_therm_group))
+		goto ERROR3;
 
-	if (data->innr == 14) {
-		for (i = 0; i < 3; i++) {
-			device_create_file(dev, &therm_input[i].dev_attr);
-			device_create_file(dev, &therm_min[i].dev_attr);
-			device_create_file(dev, &therm_max[i].dev_attr);
-			device_create_file(dev, &therm_crit[i].dev_attr);
-			device_create_file(dev, &therm_status[i].dev_attr);
-		}
-	}
+	if (data->fannr &&
+	    sysfs_create_group(&client->dev.kobj,
+			       &pc8736x_fan_group))
+		goto ERROR3;
 
-	for (i = 0; i < data->fannr; i++) {
-		if (FAN_CONFIG_MONITOR(data->fan_conf, i)) {
-			device_create_file(dev, &fan_input[i].dev_attr);
-			device_create_file(dev, &fan_min[i].dev_attr);
-			device_create_file(dev, &fan_div[i].dev_attr);
-			device_create_file(dev, &fan_status[i].dev_attr);
-		}
-		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
-			device_create_file(dev, &pwm[i].dev_attr);
+	data->class_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto ERROR3;
 	}
-
 	return 0;
 
 ERROR3:
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_temp_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_fan_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_therm_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_vin_group);
+
 	i2c_detach_client(client);
 ERROR2:
-	for (i = 0; i < 3; i++) {
-		if (data->address[i]) {
+	for (i = 0; i < 3; i++)
+		if (data->address[i])
 			release_region(data->address[i], PC87360_EXTENT);
-		}
-	}
 ERROR1:
 	kfree(data);
 	return err;
@@ -1008,16 +1069,19 @@ static int pc87360_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_temp_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_fan_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_therm_group);
+	sysfs_remove_group(&client->dev.kobj, &pc8736x_vin_group);
+
 	if ((i = i2c_detach_client(client)))
 		return i;
 
-	for (i = 0; i < 3; i++) {
-		if (data->address[i]) {
+	for (i = 0; i < 3; i++)
+		if (data->address[i])
 			release_region(data->address[i], PC87360_EXTENT);
-		}
-	}
-	kfree(data);
 
+	kfree(data);
 	return 0;
 }
 

So, now we have 4 working groups (with a few problems)

However, the driver supports several different chips,
which have varying numbers of voltage & temp measurement circuits.

Prior to this patch, the way to get 3 sets of voltage-device-attrs
was to call device_create_file for the 1st 3, but not for 4..N.
If you'd declared (at compile time) a group of voltage-attrs, 
the corresponding attr-files would be created en-masse.

With this patch, atts 4..N can be disabled at runtime,
by setting mode = 0.  Afterwards, when sysfs_group_create
is called, it creates attr-files *only* for those whose
mode != 0.  IOW - no attr-files for non-existent hardware.
Normally, mode is set usefully, and attr-files
are created as normal.


IE, like this:


diff -ruNp -X dontdiff -X exclude-diffs sys-grp/drivers/hwmon/pc87360.c grp2/drivers/hwmon/pc87360.c
--- sys-grp/drivers/hwmon/pc87360.c	2006-08-16 07:53:00.000000000 -0600
+++ grp2/drivers/hwmon/pc87360.c	2006-08-17 11:54:59.000000000 -0600
@@ -1020,7 +1020,32 @@ static int pc87360_detect(struct i2c_ada
 		pc87360_init_client(client, use_thermistors);
 	}
 
-	/* Register sysfs groups */
+	/* disable group members which arent supported by the
+	   available hardware.  For efficiency, we handle all-or-none
+	   groups separately below, and more variant groups here
+	 */
+
+#	define disable_attr(X) 	(X).dev_attr.attr.mode = 0
+
+	for (i = 0; i < ARRAY_SIZE(fan_input); i++) {
+		if (!FAN_CONFIG_MONITOR(data->fan_conf, i)) {
+			disable_attr(fan_input[i]);
+			disable_attr(fan_min[i]);
+			disable_attr(fan_div[i]);
+			disable_attr(fan_status[i]);
+		}
+		if (FAN_CONFIG_CONTROL(data->fan_conf, i))
+			disable_attr(pwm[i]);
+	}
+	for (i = data->tempnr; i &&  i < ARRAY_SIZE(temp_input); i++) {
+		disable_attr(temp_input[i]);
+		disable_attr(temp_min[i]);
+		disable_attr(temp_max[i]);
+		disable_attr(temp_crit[i]);
+		disable_attr(temp_status[i]);
+	}
+
+	/* Register sysfs groups for available hardware */
 
 	if (data->innr && 
 	    sysfs_create_group(&client->dev.kobj,



I hope that clarifies (and sufficiently justifies) ..

thanks





