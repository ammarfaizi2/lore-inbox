Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263195AbTDCAD7>; Wed, 2 Apr 2003 19:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263191AbTDCAC4>; Wed, 2 Apr 2003 19:02:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:50876 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263205AbTDCACL> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:11 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289582463@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289583383@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:58 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.5, 2003/04/02 11:29:55-08:00, greg@kroah.com

i2c: convert lm75 chip driver to use sysfs files.


 drivers/i2c/chips/lm75.c |  185 +++++++++++++++++++----------------------------
 1 files changed, 77 insertions(+), 108 deletions(-)


diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Wed Apr  2 16:01:36 2003
+++ b/drivers/i2c/chips/lm75.c	Wed Apr  2 16:01:36 2003
@@ -18,6 +18,8 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -25,8 +27,6 @@
 #include <linux/i2c-proc.h>
 
 
-#define LM75_SYSCTL_TEMP 1200	/* Degrees Celsius * 10 */
-
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { SENSORS_I2C_END };
 static unsigned short normal_i2c_range[] = { 0x48, 0x4f, SENSORS_I2C_END };
@@ -39,97 +39,113 @@
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
-	struct semaphore update_lock;
-	char valid;		/* !=0 if following fields are valid */
-	unsigned long last_updated;	/* In jiffies */
-
-	u16 temp, temp_os, temp_hyst;	/* Register values */
+	struct semaphore	update_lock;
+	char			valid;		/* !=0 if following fields are valid */
+	unsigned long		last_updated;	/* In jiffies */
+	u16			temp_input;	/* Register values */
+	u16			temp_max;
+	u16			temp_hyst;
 };
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter);
-static int lm75_detect(struct i2c_adapter *adapter, int address,
-		       unsigned short flags, int kind);
+static int lm75_detect(struct i2c_adapter *adapter, int address, int kind);
 static void lm75_init_client(struct i2c_client *client);
 static int lm75_detach_client(struct i2c_client *client);
-static u16 swap_bytes(u16 val);
 static int lm75_read_value(struct i2c_client *client, u8 reg);
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
-static void lm75_temp(struct i2c_client *client, int operation,
-		      int ctl_name, int *nrels_mag, long *results);
 static void lm75_update_client(struct i2c_client *client);
 
 
 /* This is the driver that will be inserted */
 static struct i2c_driver lm75_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "LM75 sensor",
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
+	return sprintf(buf, "%d\n", temp * 100);		\
+}
+show(temp_max);
+show(temp_hyst);
+show(temp_input);
+
+#define set(value, reg)	\
+static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
+{								\
+	struct i2c_client *client = to_i2c_client(dev);		\
+	struct lm75_data *data = i2c_get_clientdata(client);	\
+	int temp = simple_strtoul(buf, NULL, 10) / 100;		\
+								\
+	data->value = TEMP_TO_REG(temp);			\
+	lm75_write_value(client, reg, data->value);		\
+	return count;						\
+}
+set(temp_max, LM75_REG_TEMP_OS);
+set(temp_hyst, LM75_REG_TEMP_HYST);
+
+static DEVICE_ATTR(temp_max, S_IWUSR | S_IRUGO, show_temp_max, set_temp_max);
+static DEVICE_ATTR(temp_min, S_IWUSR | S_IRUGO, show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR(temp_input, S_IRUGO, show_temp_input, NULL);
+
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
 
 /* This function is called by i2c_detect */
-static int lm75_detect(struct i2c_adapter *adapter, int address,
-		       unsigned short flags, int kind)
+static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i, cur, conf, hyst, os;
 	struct i2c_client *new_client;
 	struct lm75_data *data;
 	int err = 0;
-	const char *type_name, *client_name;
+	const char *name;
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
 #ifdef DEBUG
 	if (i2c_is_isa_adapter(adapter)) {
-		printk
-		    ("lm75.o: lm75_detect called for an ISA bus adapter?!?\n");
-		return 0;
+		dev_dbg(&adapter->dev,
+			"lm75_detect called for an ISA bus adapter?!?\n");
+		goto exit;
 	}
 #endif
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
-		    goto error0;
+		goto exit;
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
@@ -138,7 +154,7 @@
 				   sizeof(struct lm75_data),
 				   GFP_KERNEL))) {
 		err = -ENOMEM;
-		goto error0;
+		goto exit;
 	}
 	memset(new_client, 0x00, sizeof(struct i2c_client) +
 				 sizeof(struct lm75_data));
@@ -157,16 +173,10 @@
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
-				goto error1;
+			if ((i2c_smbus_read_byte_data(new_client, i * 8 + 1) != conf) ||
+			    (i2c_smbus_read_word_data(new_client, i * 8 + 2) != hyst) ||
+			    (i2c_smbus_read_word_data(new_client, i * 8 + 3) != os))
+				goto exit_free;
 	}
 
 	/* Determine the chip type - only one kind supported! */
@@ -174,15 +184,15 @@
 		kind = lm75;
 
 	if (kind == lm75) {
-		type_name = "lm75";
-		client_name = "LM75 chip";
+		name = "lm75";
 	} else {
-		pr_debug("lm75.o: Internal error: unknown kind (%d)?!?", kind);
-		goto error1;
+		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
+			kind);
+		goto exit_free;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
+	strncpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
 
 	new_client->id = lm75_id++;
 	data->valid = 0;
@@ -190,36 +200,23 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto error3;
+		goto exit_free;
 
-	/* Register a new directory entry with module sensors */
-	i = i2c_register_entry(new_client, type_name, lm75_dir_table_template);
-	if (i < 0) {
-		err = i;
-		goto error4;
-	}
-	data->sysctl_id = i;
+	device_create_file(&new_client->dev, &dev_attr_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp_min);
+	device_create_file(&new_client->dev, &dev_attr_temp_input);
 
 	lm75_init_client(new_client);
 	return 0;
 
-/* OK, this is not exactly good programming practice, usually. But it is
-   very code-efficient in this case. */
-
-      error4:
-	i2c_detach_client(new_client);
-      error3:
-      error1:
+exit_free:
 	kfree(new_client);
-      error0:
+exit:
 	return err;
 }
 
 static int lm75_detach_client(struct i2c_client *client)
 {
-	struct lm75_data *data = i2c_get_clientdata(client);
-
-	i2c_deregister_entry(data->sysctl_id);
 	i2c_detach_client(client);
 	kfree(client);
 	return 0;
@@ -271,44 +268,16 @@
 
 	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
 	    (jiffies < data->last_updated) || !data->valid) {
-		pr_debug("Starting lm75 update\n");
+		dev_dbg(&client->dev, "Starting lm75 update\n");
 
-		data->temp = lm75_read_value(client, LM75_REG_TEMP);
-		data->temp_os = lm75_read_value(client, LM75_REG_TEMP_OS);
-		data->temp_hyst =
-		    lm75_read_value(client, LM75_REG_TEMP_HYST);
+		data->temp_input = lm75_read_value(client, LM75_REG_TEMP);
+		data->temp_max = lm75_read_value(client, LM75_REG_TEMP_OS);
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
-	struct lm75_data *data = i2c_get_clientdata(client);
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

