Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbTCZTar>; Wed, 26 Mar 2003 14:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261987AbTCZTaq>; Wed, 26 Mar 2003 14:30:46 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:23943 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261978AbTCZTaB>;
	Wed, 26 Mar 2003 14:30:01 -0500
Message-ID: <3E82024A.4000809@portrix.net>
Date: Wed, 26 Mar 2003 20:40:58 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: azarah@gentoo.org
CC: Greg KH <greg@kroah.com>, KML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>, sensors@stimpy.netroedge.com
Subject: Re: w83781d i2c driver updated for 2.5.66 (without sysfs support)
References: <1048582394.4774.7.camel@workshop.saharact.lan>	 <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
In-Reply-To: <1048705473.7569.10.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> 
> I did look at the changes needed for sysfs, but this beast have
> about 6 ctl_tables, and is hairy in general.  I am not sure what
> is the best way to do it for the different chips, so here is what
> I have until I or somebody else can do the sysfs stuff.
> 
I've just done this with the via686a driver. Saves about 100 lines of code.

Comments?

Jan

--- c/drivers/i2c/chips/via686a.c	2003-03-26 10:35:04.000000000 +0100
+++ b/drivers/i2c/chips/via686a.c	2003-03-26 19:57:19.000000000 +0100
@@ -394,25 +394,185 @@
  			  unsigned short flags, int kind);
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

+/* following are the sysfs callback functions */
+static ssize_t show_in(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+
+	return sprintf(buf,"%ld %ld %ld\n",
+		IN_FROM_REG(data->in_min[nr], nr),
+		IN_FROM_REG(data->in_max[nr], nr),
+		IN_FROM_REG(data->in[nr], nr) );
+}
+
+static ssize_t store_in(struct device *dev, const char *buf, size_t 
count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int in_min, in_max, ret;
+	ret = sscanf(buf, "%d %d", &in_min, &in_max);
+	if (ret == -1) return -EINVAL;
+	if (ret >= 1) {
+		data->in_min[nr] = IN_TO_REG(in_min, nr);
+		via686a_write_value(client, VIA686A_REG_IN_MIN(nr), data->in_min[nr]);
+	}
+	if (ret >= 2) {
+		data->in_max[nr] = IN_TO_REG(in_max, nr);
+		via686a_write_value(client, VIA686A_REG_IN_MAX(nr), data->in_max[nr]);
+	}
+	return count;
+}
+
+#define show_in_offset(offset)				\
+static ssize_t						\
+show_in_##offset (struct device *dev, char *buf)	\
+{							\
+	return show_in(dev, buf, 0x##offset);		\
+}							\
+static ssize_t store_in_##offset (struct device *dev, const char *buf, 
size_t count) \
+{								\
+	return store_in(dev, buf, count, 0x##offset);		\
+}								\
+static DEVICE_ATTR(in##offset, S_IRUGO| S_IWUSR, show_in_##offset, 
store_in_##offset)
+
+show_in_offset(0);
+show_in_offset(1);
+show_in_offset(2);
+show_in_offset(3);
+show_in_offset(4);
+
+static ssize_t show_temp(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+
+	return sprintf(buf,"%ld %ld %ld\n",
+		TEMP_FROM_REG(data->temp_over[nr]),
+		TEMP_FROM_REG(data->temp_hyst[nr]),
+		TEMP_FROM_REG10(data->temp[nr]) );
+}
+static ssize_t store_temp(struct device *dev, const char *buf, size_t 
count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int temp_over, temp_hyst, ret;
+	printk(buf);
+	ret = sscanf(buf, "%d %d", &temp_over, &temp_hyst);
+	if (ret == -1) return -EINVAL;
+	if (ret >= 1) {
+		data->temp_over[nr] = TEMP_TO_REG(temp_over);
+		via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr + 1), 
data->temp_over[nr]);
+	}
+	if (ret >= 2) {
+		data->temp_hyst[nr] = TEMP_TO_REG(temp_hyst);
+		via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr + 1), 
data->temp_hyst[nr]);
+	}
+	return count;
+}
+#define show_temp_offset(offset)			\
+static ssize_t						\
+show_temp_##offset (struct device *dev, char *buf)	\
+{							\
+	return show_temp(dev, buf, 0x##offset);		\
+}							\
+static ssize_t store_temp_##offset (struct device *dev, const char 
*buf, size_t count) \
+{								\
+	return store_temp(dev, buf, count, 0x##offset);		\
+}								\
+static DEVICE_ATTR(temp##offset, S_IRUGO | S_IWUSR, show_temp_##offset, 
store_temp_##offset)
+
+show_temp_offset(0);
+show_temp_offset(1);
+show_temp_offset(2);
+
+static ssize_t show_fan(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+
+	return sprintf(buf,"%d %d\n",
+		FAN_FROM_REG(data->fan_min[nr - 1], DIV_FROM_REG(data->fan_div[nr - 1])),
+		FAN_FROM_REG(data->fan[nr - 1], DIV_FROM_REG(data->fan_div[nr - 1])) );
+}
+static ssize_t store_fan(struct device *dev, const char *buf, size_t 
count, int nr) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int fan_min, ret;
+	ret = sscanf(buf, "%d", &fan_min);
+	if (ret == -1) return -EINVAL;
+	if (ret >= 1) {
+		data->fan_min[nr] = FAN_TO_REG(fan_min, DIV_FROM_REG(data->fan_div[nr]));
+		via686a_write_value(client, VIA686A_REG_FAN_MIN(nr+1), 
data->fan_min[nr]);
+	}
+	return count;
+}
+#define show_fan_offset(offset)				\
+static ssize_t						\
+show_fan_##offset (struct device *dev, char *buf)	\
+{							\
+	return show_fan(dev, buf, 0x##offset);		\
+}							\
+static ssize_t store_fan_##offset (struct device *dev, const char *buf, 
size_t count) \
+{								\
+	return store_fan(dev, buf, count, 0x##offset);		\
+}								\
+static DEVICE_ATTR(fan##offset, S_IRUGO | S_IWUSR, show_fan_##offset, 
store_fan_##offset)
+
+show_fan_offset(1);
+show_fan_offset(2);
+
+static ssize_t show_alarm(struct device *dev, char *buf) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+
+	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+}
+static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
+
+static ssize_t show_fan_div(struct device *dev, char *buf) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	via686a_update_client(client);
+
+	return sprintf(buf,"%d %d\n",
+		DIV_FROM_REG(data->fan_div[0]),
+		DIV_FROM_REG(data->fan_div[1]) );
+}
+static ssize_t store_fan_div(struct device *dev, const char *buf, 
size_t count) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct via686a_data *data = i2c_get_clientdata(client);
+	int fan_div[2], ret, old;

-static void via686a_in(struct i2c_client *client, int operation,
-		       int ctl_name, int *nrels_mag, long *results);
-static void via686a_fan(struct i2c_client *client, int operation,
-			int ctl_name, int *nrels_mag, long *results);
-static void via686a_temp(struct i2c_client *client, int operation,
-			 int ctl_name, int *nrels_mag, long *results);
-static void via686a_alarms(struct i2c_client *client, int operation,
-			   int ctl_name, int *nrels_mag, long *results);
-static void via686a_fan_div(struct i2c_client *client, int operation,
-			    int ctl_name, int *nrels_mag, long *results);
+	ret = sscanf(buf, "%d %d", &fan_div[0], &fan_div[1]);
+	if (ret == -1) return -EINVAL;
+	old = via686a_read_value(client, VIA686A_REG_FANDIV);
+	if (ret >= 2) {
+		data->fan_min[1] = DIV_TO_REG(fan_div[1]);
+		old = (old & 0x3f) | (data->fan_div[1] << 6);
+	}
+	if (ret >= 1) {
+		data->fan_min[0] = DIV_TO_REG(fan_div[0]);
+		old = (old & 0xcf) | (data->fan_div[0] << 4);
+		via686a_write_value(client, VIA686A_REG_FANDIV, old);
+	}
+	return count;
+}
+static DEVICE_ATTR(fan_div, S_IRUGO | S_IWUSR, show_fan_div, 
store_fan_div);

-static int via686a_id = 0;

  /* The driver. I choose to use type i2c_driver, as at is identical to both
     smbus_driver and isa_driver, and clients could be of either kind */
@@ -426,95 +586,18 @@
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
-/* These files are created for each detected VIA686A. This is just a 
template;
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

-int via686a_detect(struct i2c_adapter *adapter, int address,
+static int via686a_detect(struct i2c_adapter *adapter, int address,
  		   unsigned short flags, int kind)
  {
-	int i;
  	struct i2c_client *new_client;
  	struct via686a_data *data;
  	int err = 0;
-	const char *type_name = "via686a";
  	const char client_name[] = "via686a chip";
  	u16 val;

@@ -573,28 +656,31 @@
  	/* Fill in the remaining client fields and put into the global list */
  	snprintf(new_client->dev.name, DEVICE_NAME_SIZE, client_name);

-	new_client->id = via686a_id++;
  	data->valid = 0;
  	init_MUTEX(&data->update_lock);
  	/* Tell the I2C layer a new client has arrived */
  	if ((err = i2c_attach_client(new_client)))
  		goto ERROR3;
-
-	/* Register a new directory entry with module sensors */
-	if ((i = i2c_register_entry((struct i2c_client *) new_client,
-					type_name,
-					via686a_dir_table_template)) < 0) {
-		err = i;
-		goto ERROR4;
-	}
-	data->sysctl_id = i;
+	
+	device_create_file(&new_client->dev, &dev_attr_in0);
+	device_create_file(&new_client->dev, &dev_attr_in1);
+	device_create_file(&new_client->dev, &dev_attr_in2);
+	device_create_file(&new_client->dev, &dev_attr_in3);
+	device_create_file(&new_client->dev, &dev_attr_in4);
+	device_create_file(&new_client->dev, &dev_attr_temp0);
+	device_create_file(&new_client->dev, &dev_attr_temp1);
+	device_create_file(&new_client->dev, &dev_attr_temp2);
+	device_create_file(&new_client->dev, &dev_attr_fan1);
+	device_create_file(&new_client->dev, &dev_attr_fan2);
+	device_create_file(&new_client->dev, &dev_attr_alarm);
+	device_create_file(&new_client->dev, &dev_attr_fan_div);

  	/* Initialize the VIA686A chip */
  	via686a_init_client(new_client);
  	return 0;

-      ERROR4:
-	i2c_detach_client(new_client);
+//      ERROR4:
+//	i2c_detach_client(new_client);
        ERROR3:
  	release_region(address, VIA686A_EXTENT);
  	kfree(new_client);
@@ -605,8 +691,8 @@
  static int via686a_detach_client(struct i2c_client *client)
  {
  	int err;
-	struct via686a_data *data = i2c_get_clientdata(client);
-	i2c_deregister_entry(data->sysctl_id);
+//	struct via686a_data *data = i2c_get_clientdata(client);
+//	i2c_deregister_entry(data->sysctl_id);

  	if ((err = i2c_detach_client(client))) {
  		dev_err(&client->dev,
@@ -739,157 +825,12 @@
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
-   results and write them to the chip, if 
operations==SENSORS_PROC_REAL_WRITE.
-   Note that on SENSORS_PROC_REAL_READ, I do not check whether results is
-   large enough (by checking the incoming value of *nrels). This is not 
very
-   good practice, but as long as you put less than about 5 values in 
results,
-   you can assume it is large enough. */
-static void via686a_in(struct i2c_client *client, int operation, int 
ctl_name,
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
-void via686a_fan(struct i2c_client *client, int operation, int ctl_name,
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
-void via686a_temp(struct i2c_client *client, int operation, int ctl_name,
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
-void via686a_alarms(struct i2c_client *client, int operation, int ctl_name,
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
-void via686a_fan_div(struct i2c_client *client, int operation,
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

