Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbTCZV5I>; Wed, 26 Mar 2003 16:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262559AbTCZV5I>; Wed, 26 Mar 2003 16:57:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19974 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262558AbTCZV5D>;
	Wed, 26 Mar 2003 16:57:03 -0500
Date: Wed, 26 Mar 2003 14:07:22 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [RFC] lm75.c converted to sysfs
Message-ID: <20030326220722.GD26886@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Ok, I cleaned up my last patch for lm75.c a bit more (this is a i2c
sensors driver), and got rid of the fake floating point stuff.  This is
against a clean 2.5.66 tree, and removes all of the /proc and sysctl
stuff from this driver, it only uses sysfs.

This makes the driver smaller, and allows it to be unloaded safely (I
don't think the sysctl i2c code ever handled removals of drivers quite
properly...)

Comments?

Oh, and yes, this breaks the userspace tools.  I'll be working on
converting the libsensors code to handle sysfs, but first I had to get a
driver to work with sysfs :)

thanks,

greg k-h


diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Wed Mar 26 14:05:04 2003
+++ b/drivers/i2c/chips/lm75.c	Wed Mar 26 14:05:04 2003
@@ -18,6 +18,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -39,26 +41,24 @@
 /* Many LM75 constants specified below */
 
 /* The LM75 registers */
-#define LM75_REG_TEMP 0x00
-#define LM75_REG_CONF 0x01
-#define LM75_REG_TEMP_HYST 0x02
-#define LM75_REG_TEMP_OS 0x03
+#define LM75_REG_TEMP		0x00
+#define LM75_REG_CONF		0x01
+#define LM75_REG_TEMP_HYST	0x02
+#define LM75_REG_TEMP_OS	0x03
 
 /* Conversions. Rounding and limit checking is only done on the TO_REG
    variants. Note that you should be a bit careful with which arguments
    these macros are called: arguments may be evaluated more than once.
    Fixing this is just not worth it. */
-#define TEMP_FROM_REG(val) ((((val & 0x7fff) >> 7) * 5) | ((val & 0x8000)?-256:0))
-#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val<0?(0x200+((val)/5))<<7:(((val) + 2) / 5) << 7),0,0xffff))
+#define TEMP_FROM_REG(val)	((((val & 0x7fff) >> 7) * 5) | ((val & 0x8000)?-256:0))
+#define TEMP_TO_REG(val)	(SENSORS_LIMIT((val<0?(0x200+((val)/5))<<7:(((val) + 2) / 5) << 7),0,0xffff))
 
 /* Initial values */
-#define LM75_INIT_TEMP_OS 600
-#define LM75_INIT_TEMP_HYST 500
+#define LM75_INIT_TEMP_OS	600
+#define LM75_INIT_TEMP_HYST	500
 
 /* Each client has this additional data */
 struct lm75_data {
-	int sysctl_id;
-
 	struct semaphore update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -74,34 +74,54 @@
 static u16 swap_bytes(u16 val);
 static int lm75_read_value(struct i2c_client *client, u8 reg);
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
-static void lm75_temp(struct i2c_client *client, int operation,
-		      int ctl_name, int *nrels_mag, long *results);
 static void lm75_update_client(struct i2c_client *client);
 
 
 /* This is the driver that will be inserted */
 static struct i2c_driver lm75_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "LM75 sensor chip driver",
+	.name		= "lm75",
 	.id		= I2C_DRIVERID_LM75,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
 };
 
-/* These files are created for each detected LM75. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized
-   when a new copy is allocated. */
-static ctl_table lm75_dir_table_template[] = {
-	{LM75_SYSCTL_TEMP, "temp", NULL, 0, 0644, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &lm75_temp},
-	{0}
-};
-
 static int lm75_id = 0;
 
+#define show(value)	\
+static ssize_t show_##value(struct device *dev, char *buf)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct lm75_data *data = i2c_get_clientdata(client);	\
+	int temp;						\
+								\
+	lm75_update_client(client);				\
+	temp = TEMP_FROM_REG(data->value);			\
+	return sprintf(buf, "%d\n", temp);			\
+}
+show(temp);
+show(temp_os);
+show(temp_hyst);
+
+#define set(value, reg)	\
+static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct lm75_data *data = i2c_get_clientdata(client);	\
+	int temp = simple_strtoul(buf, NULL, 10);		\
+								\
+	data->value = TEMP_TO_REG(temp);			\
+	lm75_write_value(client, reg, data->value);		\
+	return count;						\
+}
+set(temp_os, LM75_REG_TEMP_OS);
+set(temp_hyst, LM75_REG_TEMP_HYST);
+
+static DEVICE_ATTR(temp, S_IRUGO, show_temp, NULL);
+static DEVICE_ATTR(temp_os, 0644, show_temp_os, set_temp_os);
+static DEVICE_ATTR(temp_hyst, 0644, show_temp_hyst, set_temp_hyst);
+
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, lm75_detect);
@@ -121,15 +141,15 @@
 	   at this moment; i2c_detect really won't call us. */
 #ifdef DEBUG
 	if (i2c_is_isa_adapter(adapter)) {
-		printk
-		    ("lm75.o: lm75_detect called for an ISA bus adapter?!?\n");
+		dev_dbg(&adapter->dev,
+			"lm75_detect called for an ISA bus adapter?!?\n");
 		return 0;
 	}
 #endif
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
-		    goto error0;
+		goto error0;
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
@@ -140,10 +160,12 @@
 		err = -ENOMEM;
 		goto error0;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct lm75_data));
 
 	data = (struct lm75_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &lm75_driver;
 	new_client->flags = 0;
@@ -155,15 +177,9 @@
 		hyst = i2c_smbus_read_word_data(new_client, 2);
 		os = i2c_smbus_read_word_data(new_client, 3);
 		for (i = 0; i <= 0x1f; i++)
-			if (
-			    (i2c_smbus_read_byte_data
-			     (new_client, i * 8 + 1) != conf)
-			    ||
-			    (i2c_smbus_read_word_data
-			     (new_client, i * 8 + 2) != hyst)
-			    ||
-			    (i2c_smbus_read_word_data
-			     (new_client, i * 8 + 3) != os))
+			if ((i2c_smbus_read_byte_data(new_client, i * 8 + 1) != conf) ||
+			    (i2c_smbus_read_word_data(new_client, i * 8 + 2) != hyst) ||
+			    (i2c_smbus_read_word_data(new_client, i * 8 + 3) != os))
 				goto error1;
 	}
 
@@ -175,12 +191,13 @@
 		type_name = "lm75";
 		client_name = "LM75 chip";
 	} else {
-		pr_debug("lm75.o: Internal error: unknown kind (%d)?!?", kind);
+		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
+			kind);
 		goto error1;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strcpy(new_client->name, client_name);
+	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
@@ -190,34 +207,22 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto error3;
 
-	/* Register a new directory entry with module sensors */
-	i = i2c_register_entry(new_client, type_name, lm75_dir_table_template);
-	if (i < 0) {
-		err = i;
-		goto error4;
-	}
-	data->sysctl_id = i;
+	device_create_file(&new_client->dev, &dev_attr_temp);
+	device_create_file(&new_client->dev, &dev_attr_temp_os);
+	device_create_file(&new_client->dev, &dev_attr_temp_hyst);
 
 	lm75_init_client(new_client);
 	return 0;
 
-/* OK, this is not exactly good programming practice, usually. But it is
-   very code-efficient in this case. */
-
-      error4:
-	i2c_detach_client(new_client);
-      error3:
-      error1:
+error3:
+error1:
 	kfree(new_client);
-      error0:
+error0:
 	return err;
 }
 
 static int lm75_detach_client(struct i2c_client *client)
 {
-	struct lm75_data *data = client->data;
-
-	i2c_deregister_entry(data->sysctl_id);
 	i2c_detach_client(client);
 	kfree(client);
 	return 0;
@@ -263,50 +268,22 @@
 
 static void lm75_update_client(struct i2c_client *client)
 {
-	struct lm75_data *data = client->data;
+	struct lm75_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
 
 	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
 	    (jiffies < data->last_updated) || !data->valid) {
-		pr_debug("Starting lm75 update\n");
+		dev_dbg(&client->dev, "Starting lm75 update\n");
 
 		data->temp = lm75_read_value(client, LM75_REG_TEMP);
 		data->temp_os = lm75_read_value(client, LM75_REG_TEMP_OS);
-		data->temp_hyst =
-		    lm75_read_value(client, LM75_REG_TEMP_HYST);
+		data->temp_hyst = lm75_read_value(client, LM75_REG_TEMP_HYST);
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
 
 	up(&data->update_lock);
-}
-
-
-static void lm75_temp(struct i2c_client *client, int operation, int ctl_name,
-		      int *nrels_mag, long *results)
-{
-	struct lm75_data *data = client->data;
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 1;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		lm75_update_client(client);
-		results[0] = TEMP_FROM_REG(data->temp_os);
-		results[1] = TEMP_FROM_REG(data->temp_hyst);
-		results[2] = TEMP_FROM_REG(data->temp);
-		*nrels_mag = 3;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-		if (*nrels_mag >= 1) {
-			data->temp_os = TEMP_TO_REG(results[0]);
-			lm75_write_value(client, LM75_REG_TEMP_OS,
-					 data->temp_os);
-		}
-		if (*nrels_mag >= 2) {
-			data->temp_hyst = TEMP_TO_REG(results[1]);
-			lm75_write_value(client, LM75_REG_TEMP_HYST,
-					 data->temp_hyst);
-		}
-	}
 }
 
 static int __init sensors_lm75_init(void)
