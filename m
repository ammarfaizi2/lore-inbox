Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTDDHpq (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 02:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTDDHpp (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 02:45:45 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:10173 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S263461AbTDDHnw (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 02:43:52 -0500
Message-ID: <3E8D3A59.8010401@portrix.net>
Date: Fri, 04 Apr 2003 09:55:05 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] convert via686a i2c driver to sysfs
Content-Type: multipart/mixed;
 boundary="------------060805050604020704030700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060805050604020704030700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

I thought I posted this yesterday but cannot find it on the list. So 
here it goes again. Tested w/ Via KT133A board and using centiVolt and 
deziDegrees. Still waiting for a final decision. My vote goes to 
milliVolt and milliDegree.

Thanks,

Jan

ps: Yes, I don't have fans connected, and my cpu is running a bit hot ;-)

jdittmer@ds666:/mnt/data0/tmp/p$ grep -H . 
/sys/devices/legacy/i2c-0/0-6000/*
/sys/devices/legacy/i2c-0/0-6000/alarm:1555
/sys/devices/legacy/i2c-0/0-6000/fan_div1:2
/sys/devices/legacy/i2c-0/0-6000/fan_div2:2
/sys/devices/legacy/i2c-0/0-6000/fan_input1:0
/sys/devices/legacy/i2c-0/0-6000/fan_input2:0
/sys/devices/legacy/i2c-0/0-6000/fan_min1:3000
/sys/devices/legacy/i2c-0/0-6000/fan_min2:3000
/sys/devices/legacy/i2c-0/0-6000/in_input0:168
/sys/devices/legacy/i2c-0/0-6000/in_input1:30
/sys/devices/legacy/i2c-0/0-6000/in_input2:335
/sys/devices/legacy/i2c-0/0-6000/in_input3:467
/sys/devices/legacy/i2c-0/0-6000/in_input4:1198
/sys/devices/legacy/i2c-0/0-6000/in_max0:218
/sys/devices/legacy/i2c-0/0-6000/in_max1:274
/sys/devices/legacy/i2c-0/0-6000/in_max2:362
/sys/devices/legacy/i2c-0/0-6000/in_max3:549
/sys/devices/legacy/i2c-0/0-6000/in_max4:1318
/sys/devices/legacy/i2c-0/0-6000/in_min0:179
/sys/devices/legacy/i2c-0/0-6000/in_min1:224
/sys/devices/legacy/i2c-0/0-6000/in_min2:295
/sys/devices/legacy/i2c-0/0-6000/in_min3:447
/sys/devices/legacy/i2c-0/0-6000/in_min4:1079
/sys/devices/legacy/i2c-0/0-6000/name:via686a chip
/sys/devices/legacy/i2c-0/0-6000/power:0
/sys/devices/legacy/i2c-0/0-6000/temp_input1:650
/sys/devices/legacy/i2c-0/0-6000/temp_input2:292
/sys/devices/legacy/i2c-0/0-6000/temp_input3:266
/sys/devices/legacy/i2c-0/0-6000/temp_max1:599
/sys/devices/legacy/i2c-0/0-6000/temp_max2:599
/sys/devices/legacy/i2c-0/0-6000/temp_max3:599
/sys/devices/legacy/i2c-0/0-6000/temp_min1:497
/sys/devices/legacy/i2c-0/0-6000/temp_min2:497
/sys/devices/legacy/i2c-0/0-6000/temp_min3:497

--------------060805050604020704030700
Content-Type: text/plain;
 name="sysfsvia"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysfsvia"

===== via686a.c 1.3 vs edited =====
--- 1.3/drivers/i2c/chips/via686a.c	Wed Apr  2 22:01:10 2003
+++ edited/via686a.c	Fri Apr  4 09:51:30 2003
@@ -87,9 +87,9 @@
 static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e };
 
 /* temps numbered 1-3 */
-#define VIA686A_REG_TEMP(nr)		(regtemp[(nr) - 1])
-#define VIA686A_REG_TEMP_OVER(nr)	(regover[(nr) - 1])
-#define VIA686A_REG_TEMP_HYST(nr)	(reghyst[(nr) - 1])
+#define VIA686A_REG_TEMP(nr)		(regtemp[nr])
+#define VIA686A_REG_TEMP_OVER(nr)	(regover[nr])
+#define VIA686A_REG_TEMP_HYST(nr)	(reghyst[nr])
 #define VIA686A_REG_TEMP_LOW1	0x4b	// bits 7-6
 #define VIA686A_REG_TEMP_LOW23	0x49	// 2 = bits 5-4, 3 = bits 7-6
 
@@ -369,6 +369,8 @@
    dynamically allocated, at the same time when a new via686a client is
    allocated. */
 struct via686a_data {
+	int sysctl_id;
+
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -388,16 +390,262 @@
 static struct pci_dev *s_bridge;	/* pointer to the (only) via686a */
 
 static int via686a_attach_adapter(struct i2c_adapter *adapter);
-static int via686a_detect(struct i2c_adapter *adapter, int address, int kind);
+static int via686a_detect(struct i2c_adapter *adapter, int address,
+			  unsigned short flags, int kind);
 static int via686a_detach_client(struct i2c_client *client);
 
-static int via686a_read_value(struct i2c_client *client, u8 register);
-static void via686a_write_value(struct i2c_client *client, u8 register,
-				u8 value);
+static inline int via686a_read_value(struct i2c_client *client, u8 reg)
+{
+	return (inb_p(client->addr + reg));
+}
+
+static inline void via686a_write_value(struct i2c_client *client, u8 reg,
+				       u8 value)
+{
+	outb_p(value, client->addr + reg);
+}
+
 static void via686a_update_client(struct i2c_client *client);
 static void via686a_init_client(struct i2c_client *client);
 
-static int via686a_id = 0;
+/* following are the sysfs callback functions */
+
+/* 7 voltage sensors */
+static ssize_t show_in(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr) );
+}
+
+static ssize_t show_in_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr) );
+}
+
+static ssize_t show_in_max(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr) );
+}
+
+static ssize_t set_in_min(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	data->in_min[nr] = IN_TO_REG(val,nr);
+	via686a_write_value(client, VIA686A_REG_IN_MIN(nr), 
+			data->in_min[nr]);
+	return count;
+}
+static ssize_t set_in_max(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	data->in_max[nr] = IN_TO_REG(val,nr);
+	via686a_write_value(client, VIA686A_REG_IN_MAX(nr), 
+			data->in_max[nr]);
+	return count;
+}
+#define show_in_offset(offset)					\
+static ssize_t 							\
+	show_in##offset (struct device *dev, char *buf)		\
+{								\
+	return show_in(dev, buf, 0x##offset);			\
+}								\
+static ssize_t 							\
+	show_in##offset##_min (struct device *dev, char *buf)	\
+{								\
+	return show_in_min(dev, buf, 0x##offset);		\
+}								\
+static ssize_t 							\
+	show_in##offset##_max (struct device *dev, char *buf)	\
+{								\
+	return show_in_max(dev, buf, 0x##offset);		\
+}								\
+static ssize_t set_in##offset##_min (struct device *dev, 	\
+		const char *buf, size_t count) 			\
+{								\
+	return set_in_min(dev, buf, count, 0x##offset);		\
+}								\
+static ssize_t set_in##offset##_max (struct device *dev,	\
+			const char *buf, size_t count)		\
+{								\
+	return set_in_max(dev, buf, count, 0x##offset);		\
+}								\
+static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL) 	\
+static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 		\
+		show_in##offset##_min, set_in##offset##_min)	\
+static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 		\
+		show_in##offset##_max, set_in##offset##_max)
+
+show_in_offset(0);
+show_in_offset(1);
+show_in_offset(2);
+show_in_offset(3);
+show_in_offset(4);
+
+/* 3 temperatures */
+static ssize_t show_temp(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG10(data->temp[nr]) );
+}
+/* more like overshoot temperature */
+static ssize_t show_temp_max(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_over[nr]));
+}
+/* more like hysteresis temperature */
+static ssize_t show_temp_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf, "%ld\n", TEMP_FROM_REG(data->temp_hyst[nr]));
+}
+static ssize_t set_temp_max(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	data->temp_over[nr] = TEMP_TO_REG(val);
+	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
+	return count;
+}
+static ssize_t set_temp_min(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	data->temp_hyst[nr] = TEMP_TO_REG(val);
+	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
+	return count;
+}
+#define show_temp_offset(offset)					\
+static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_temp(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t								\
+show_temp_##offset##_max (struct device *dev, char *buf)		\
+{									\
+	return show_temp_max(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t								\
+show_temp_##offset##_min (struct device *dev, char *buf)		\
+{									\
+	return show_temp_min(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_temp_##offset##_max (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_temp_##offset##_min (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_max, set_temp_##offset##_max) 	\
+static DEVICE_ATTR(temp_min##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_min, set_temp_##offset##_min)	
+
+show_temp_offset(1);
+show_temp_offset(2);
+show_temp_offset(3);
+
+/* 2 Fans */
+static ssize_t show_fan(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr], 
+				DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf,"%d\n",
+		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_div(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+}
+static ssize_t set_fan_min(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	return count;
+}
+static ssize_t set_fan_div(struct device *dev, const char *buf, 
+		size_t count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	int old = via686a_read_value(client, VIA686A_REG_FANDIV);
+	data->fan_div[nr] = DIV_TO_REG(val);
+	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
+	via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	return count;
+}
+
+#define show_fan_offset(offset)						\
+static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_fan(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+{									\
+	return show_fan_min(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+{									\
+	return show_fan_div(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_fan_##offset##_min (struct device *dev, 		\
+	const char *buf, size_t count) 					\
+{									\
+	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_fan_##offset##_div (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_min, set_fan_##offset##_min) 	\
+static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_div, set_fan_##offset##_div)
+
+show_fan_offset(1);
+show_fan_offset(2);
+
+/* Alarm */
+static ssize_t show_alarm(struct device *dev, char *buf) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+}
+static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
 
 /* The driver. I choose to use type i2c_driver, as at is identical to both
    smbus_driver and isa_driver, and clients could be of either kind */
@@ -411,95 +659,19 @@
 };
 
 
-
-/* The /proc/sys entries */
-
-/* -- SENSORS SYSCTL START -- */
-#define VIA686A_SYSCTL_IN0 1000
-#define VIA686A_SYSCTL_IN1 1001
-#define VIA686A_SYSCTL_IN2 1002
-#define VIA686A_SYSCTL_IN3 1003
-#define VIA686A_SYSCTL_IN4 1004
-#define VIA686A_SYSCTL_FAN1 1101
-#define VIA686A_SYSCTL_FAN2 1102
-#define VIA686A_SYSCTL_TEMP 1200
-#define VIA686A_SYSCTL_TEMP2 1201
-#define VIA686A_SYSCTL_TEMP3 1202
-#define VIA686A_SYSCTL_FAN_DIV 2000
-#define VIA686A_SYSCTL_ALARMS 2001
-
-#define VIA686A_ALARM_IN0 0x01
-#define VIA686A_ALARM_IN1 0x02
-#define VIA686A_ALARM_IN2 0x04
-#define VIA686A_ALARM_IN3 0x08
-#define VIA686A_ALARM_TEMP 0x10
-#define VIA686A_ALARM_FAN1 0x40
-#define VIA686A_ALARM_FAN2 0x80
-#define VIA686A_ALARM_IN4 0x100
-#define VIA686A_ALARM_TEMP2 0x800
-#define VIA686A_ALARM_CHAS 0x1000
-#define VIA686A_ALARM_TEMP3 0x8000
-
-/* -- SENSORS SYSCTL END -- */
-
-#if 0
-/* These files are created for each detected VIA686A. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized 
-   when a new copy is allocated. */
-static ctl_table via686a_dir_table_template[] = {
-	{VIA686A_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_in},
-	{VIA686A_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_fan},
-	{VIA686A_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_fan},
-	{VIA686A_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &via686a_temp},
-	{VIA686A_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL,
-	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_temp},
-	{VIA686A_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL,
-	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_temp},
-	{VIA686A_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL,
-	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_fan_div},
-	{VIA686A_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL,
-	 &i2c_proc_real, &i2c_sysctl_real, NULL, &via686a_alarms},
-	{0}
-};
-#endif
-
-static inline int via686a_read_value(struct i2c_client *client, u8 reg)
-{
-	return (inb_p(client->addr + reg));
-}
-
-static inline void via686a_write_value(struct i2c_client *client, u8 reg,
-				       u8 value)
-{
-	outb_p(value, client->addr + reg);
-}
-
 /* This is called when the module is loaded */
 static int via686a_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, via686a_detect);
 }
 
-static int via686a_detect(struct i2c_adapter *adapter, int address, int kind)
+static int via686a_detect(struct i2c_adapter *adapter, int address,
+		   unsigned short flags, int kind)
 {
 	struct i2c_client *new_client;
 	struct via686a_data *data;
 	int err = 0;
-	const char *name = "via686a";
+	const char client_name[] = "via686a chip";
 	u16 val;
 
 	/* Make sure we are probing the ISA bus!!  */
@@ -552,16 +724,49 @@
 	new_client->adapter = adapter;
 	new_client->driver = &via686a_driver;
 	new_client->flags = 0;
+	new_client->dev.parent = &adapter->dev;
 
 	/* Fill in the remaining client fields and put into the global list */
-	snprintf(new_client->dev.name, DEVICE_NAME_SIZE, name);
+	snprintf(new_client->dev.name, DEVICE_NAME_SIZE, client_name);
 
-	new_client->id = via686a_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
+	
+	/* register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_in_input0);
+	device_create_file(&new_client->dev, &dev_attr_in_input1);
+	device_create_file(&new_client->dev, &dev_attr_in_input2);
+	device_create_file(&new_client->dev, &dev_attr_in_input3);
+	device_create_file(&new_client->dev, &dev_attr_in_input4);
+	device_create_file(&new_client->dev, &dev_attr_in_min0);
+	device_create_file(&new_client->dev, &dev_attr_in_min1);
+	device_create_file(&new_client->dev, &dev_attr_in_min2);
+	device_create_file(&new_client->dev, &dev_attr_in_min3);
+	device_create_file(&new_client->dev, &dev_attr_in_min4);
+	device_create_file(&new_client->dev, &dev_attr_in_max0);
+	device_create_file(&new_client->dev, &dev_attr_in_max1);
+	device_create_file(&new_client->dev, &dev_attr_in_max2);
+	device_create_file(&new_client->dev, &dev_attr_in_max3);
+	device_create_file(&new_client->dev, &dev_attr_in_max4);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input2);
+	device_create_file(&new_client->dev, &dev_attr_temp_input3);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max2);
+	device_create_file(&new_client->dev, &dev_attr_temp_max3);
+	device_create_file(&new_client->dev, &dev_attr_temp_min1);
+	device_create_file(&new_client->dev, &dev_attr_temp_min2);
+	device_create_file(&new_client->dev, &dev_attr_temp_min3);
+	device_create_file(&new_client->dev, &dev_attr_fan_input1);
+	device_create_file(&new_client->dev, &dev_attr_fan_input2);
+	device_create_file(&new_client->dev, &dev_attr_fan_min1);
+	device_create_file(&new_client->dev, &dev_attr_fan_min2);
+	device_create_file(&new_client->dev, &dev_attr_fan_div1);
+	device_create_file(&new_client->dev, &dev_attr_fan_div2);
+	device_create_file(&new_client->dev, &dev_attr_alarm);
 
 	/* Initialize the VIA686A chip */
 	via686a_init_client(new_client);
@@ -629,7 +834,7 @@
 			    FAN_TO_REG(VIA686A_INIT_FAN_MIN, 2));
 	via686a_write_value(client, VIA686A_REG_FAN_MIN(2),
 			    FAN_TO_REG(VIA686A_INIT_FAN_MIN, 2));
-	for (i = 1; i <= 3; i++) {
+	for (i = 0; i <= 2; i++) {
 		via686a_write_value(client, VIA686A_REG_TEMP_OVER(i),
 				    TEMP_TO_REG(VIA686A_INIT_TEMP_OVER));
 		via686a_write_value(client, VIA686A_REG_TEMP_HYST(i),
@@ -670,13 +875,13 @@
 			data->fan_min[i - 1] = via686a_read_value(client,
 						     VIA686A_REG_FAN_MIN(i));
 		}
-		for (i = 1; i <= 3; i++) {
-			data->temp[i - 1] = via686a_read_value(client,
+		for (i = 0; i <= 2; i++) {
+			data->temp[i] = via686a_read_value(client,
 						 VIA686A_REG_TEMP(i)) << 2;
-			data->temp_over[i - 1] =
+			data->temp_over[i] =
 			    via686a_read_value(client,
 					       VIA686A_REG_TEMP_OVER(i));
-			data->temp_hyst[i - 1] =
+			data->temp_hyst[i] =
 			    via686a_read_value(client,
 					       VIA686A_REG_TEMP_HYST(i));
 		}
@@ -709,164 +914,12 @@
 	up(&data->update_lock);
 }
 
-
-/* The next few functions are the call-back functions of the /proc/sys and
-   sysctl files. Which function is used is defined in the ctl_table in
-   the extra1 field.
-   Each function must return the magnitude (power of 10 to divide the date
-   with) if it is called with operation==SENSORS_PROC_REAL_INFO. It must
-   put a maximum of *nrels elements in results reflecting the data of this
-   file, and set *nrels to the number it actually put in it, if operation==
-   SENSORS_PROC_REAL_READ. Finally, it must get upto *nrels elements from
-   results and write them to the chip, if operations==SENSORS_PROC_REAL_WRITE.
-   Note that on SENSORS_PROC_REAL_READ, I do not check whether results is
-   large enough (by checking the incoming value of *nrels). This is not very
-   good practice, but as long as you put less than about 5 values in results,
-   you can assume it is large enough. */
-/* FIXME, remove these functions, they are here to verify the sysfs conversion
- * is correct, or not */
-__attribute__((unused))
-static void via686a_in(struct i2c_client *client, int operation, int ctl_name,
-               int *nrels_mag, long *results)
-{
-	struct via686a_data *data = i2c_get_clientdata(client);
-	int nr = ctl_name - VIA686A_SYSCTL_IN0;
-
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 2;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = IN_FROM_REG(data->in_min[nr], nr);
-		results[1] = IN_FROM_REG(data->in_max[nr], nr);
-		results[2] = IN_FROM_REG(data->in[nr], nr);
-		*nrels_mag = 3;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->in_min[nr] = IN_TO_REG(results[0], nr);
-			via686a_write_value(client, VIA686A_REG_IN_MIN(nr),
-					    data->in_min[nr]);
-		}
-		if (*nrels_mag >= 2) {
-			data->in_max[nr] = IN_TO_REG(results[1], nr);
-			via686a_write_value(client, VIA686A_REG_IN_MAX(nr),
-					    data->in_max[nr]);
-		}
-	}
-}
-
-__attribute__((unused))
-static void via686a_fan(struct i2c_client *client, int operation, int ctl_name,
-		 int *nrels_mag, long *results)
-{
-	struct via686a_data *data = i2c_get_clientdata(client);
-	int nr = ctl_name - VIA686A_SYSCTL_FAN1 + 1;
-
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = FAN_FROM_REG(data->fan_min[nr - 1],
-					  DIV_FROM_REG(data->fan_div
-						       [nr - 1]));
-		results[1] = FAN_FROM_REG(data->fan[nr - 1],
-				 DIV_FROM_REG(data->fan_div[nr - 1]));
-		*nrels_mag = 2;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->fan_min[nr - 1] = FAN_TO_REG(results[0], 
-							   DIV_FROM_REG(data->
-							      fan_div[nr -1]));
-			via686a_write_value(client,
-					    VIA686A_REG_FAN_MIN(nr),
-					    data->fan_min[nr - 1]);
-		}
-	}
-}
-
-__attribute__((unused))
-static void via686a_temp(struct i2c_client *client, int operation, int ctl_name,
-		  int *nrels_mag, long *results)
-{
-	struct via686a_data *data = i2c_get_clientdata(client);
-	int nr = ctl_name - VIA686A_SYSCTL_TEMP;
-
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_over[nr]);
-		results[1] = TEMP_FROM_REG(data->temp_hyst[nr]);
-		results[2] = TEMP_FROM_REG10(data->temp[nr]);
-		*nrels_mag = 3;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->temp_over[nr] = TEMP_TO_REG(results[0]);
-			via686a_write_value(client,
-					    VIA686A_REG_TEMP_OVER(nr + 1),
-					    data->temp_over[nr]);
-		}
-		if (*nrels_mag >= 2) {
-			data->temp_hyst[nr] = TEMP_TO_REG(results[1]);
-			via686a_write_value(client,
-					    VIA686A_REG_TEMP_HYST(nr + 1),
-					    data->temp_hyst[nr]);
-		}
-	}
-}
-
-__attribute__((unused))
-static void via686a_alarms(struct i2c_client *client, int operation, int ctl_name,
-		    int *nrels_mag, long *results)
-{
-	struct via686a_data *data = i2c_get_clientdata(client);
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = ALARMS_FROM_REG(data->alarms);
-		*nrels_mag = 1;
-	}
-}
-
-__attribute__((unused))
-static void via686a_fan_div(struct i2c_client *client, int operation,
-		     int ctl_name, int *nrels_mag, long *results)
-{
-	struct via686a_data *data = i2c_get_clientdata(client);
-	int old;
-
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		via686a_update_client(client);
-		results[0] = DIV_FROM_REG(data->fan_div[0]);
-		results[1] = DIV_FROM_REG(data->fan_div[1]);
-		*nrels_mag = 2;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		old = via686a_read_value(client, VIA686A_REG_FANDIV);
-		if (*nrels_mag >= 2) {
-			data->fan_div[1] = DIV_TO_REG(results[1]);
-			old = (old & 0x3f) | (data->fan_div[1] << 6);
-		}
-		if (*nrels_mag >= 1) {
-			data->fan_div[0] = DIV_TO_REG(results[0]);
-			old = (old & 0xcf) | (data->fan_div[0] << 4);
-			via686a_write_value(client, VIA686A_REG_FANDIV,
-					    old);
-		}
-	}
-}
-
-
 static struct pci_device_id via686a_pci_ids[] __devinitdata = {
        {
 	       .vendor 		= PCI_VENDOR_ID_VIA, 
 	       .device 		= PCI_DEVICE_ID_VIA_82C686_4, 
 	       .subvendor	= PCI_ANY_ID, 
 	       .subdevice	= PCI_ANY_ID, 
-	       .class		= 0, 
-	       .class_mask	= 0, 
-	       .driver_data	= 0, 
        },
        { 0, }
 };

--------------060805050604020704030700--

