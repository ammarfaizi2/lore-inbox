Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbTCZJbQ>; Wed, 26 Mar 2003 04:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbTCZJbQ>; Wed, 26 Mar 2003 04:31:16 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:55424 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S261525AbTCZJbO>;
	Wed, 26 Mar 2003 04:31:14 -0500
Message-ID: <3E8175FF.7060705@portrix.net>
Date: Wed, 26 Mar 2003 10:42:23 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: add eeprom i2c driver
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com>
In-Reply-To: <20030325172024.GC15823@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
  As an example of the changes necessary, here's a patch against the i2c
> cvs version of the eeprom.c driver that converts it over to use sysfs,
> instead of the /proc and sysctl interface.  It's still a bit rough, but
> you should get the idea of where I'm wanting to go with this.  As you
> can see, it takes about 100 lines of code off of this driver, which is
> nice.
> 
I thought about doing something like this for adding sysfs support.
Should the voltages and other data appear as integer or as floats in 
sysfs tree? (ie. 1.20V or 120cV)
And what should be written back? I think the /proc interface expects 
floats...

Jan

just an part of the patch to get the idea:

--- c/drivers/i2c/chips/via686a.c	2003-03-26 10:35:04.000000000 +0100
+++ b/drivers/i2c/chips/via686a.c	2003-03-26 10:33:13.000000000 +0100
@@ -401,6 +401,7 @@
  static void via686a_init_client(struct i2c_client *client);


+
  static void via686a_in(struct i2c_client *client, int operation,
  		       int ctl_name, int *nrels_mag, long *results);
  static void via686a_fan(struct i2c_client *client, int operation,
@@ -412,8 +413,103 @@
  static void via686a_fan_div(struct i2c_client *client, int operation,
  			    int ctl_name, int *nrels_mag, long *results);

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
+	int a,b,ret;
+	printk(buf);
+	ret = sscanf(buf, "%d %d", &a, &b);
+	if (ret==-1) return -EINVAL;
+	printk("%d %d", a, b);
+	if (ret >= 1) {
+		data->in_min[nr] = IN_TO_REG(a, nr);
+		via686a_write_value(client, VIA686A_REG_IN_MIN(nr), data->in_min[nr]);
+	}
+	if (ret >= 2) {
+		data->in_max[nr] = IN_TO_REG(b, nr);
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
+-int via686a_detect(struct i2c_adapter *adapter, int address,
+static int via686a_detect(struct i2c_adapter *adapter, int address,
  		   unsigned short flags, int kind)
  {
  	int i;
@@ -579,7 +666,17 @@
  	/* Tell the I2C layer a new client has arrived */
  	if ((err = i2c_attach_client(new_client)))
  		goto ERROR3;
-
+
+	device_create_file(&new_client->dev, &dev_attr_in0);
+	device_create_file(&new_client->dev, &dev_attr_in1);
+	device_create_file(&new_client->dev, &dev_attr_in2);
+	device_create_file(&new_client->dev, &dev_attr_in3);
+	device_create_file(&new_client->dev, &dev_attr_in4);
+	device_create_file(&new_client->dev, &dev_attr_temp0);
+	device_create_file(&new_client->dev, &dev_attr_temp1);
+	device_create_file(&new_client->dev, &dev_attr_temp2);
+	device_create_file(&new_client->dev, &dev_attr_fan0);
+	device_create_file(&new_client->dev, &dev_attr_fan1);
  	/* Register a new directory entry with module sensors */
  	if ((i = i2c_register_entry((struct i2c_client *) new_client,
  					type_name,


