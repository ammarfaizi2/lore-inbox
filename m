Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263011AbTCYRKE>; Tue, 25 Mar 2003 12:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263006AbTCYRKE>; Tue, 25 Mar 2003 12:10:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4370 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263056AbTCYRJy>;
	Tue, 25 Mar 2003 12:09:54 -0500
Date: Tue, 25 Mar 2003 09:20:24 -0800
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: add eeprom i2c driver
Message-ID: <20030325172024.GC15823@kroah.com>
References: <3E806AC6.30503@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E806AC6.30503@portrix.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 03:42:14PM +0100, Jan Dittmer wrote:
> This adds support for reading eeproms.
> Tested against latest bk changes with i2c-isa.

I'd like to hold off in submitting the i2c chip drivers just yet, due to
the changes for sysfs that are going to be needed for these drivers.

As an example of the changes necessary, here's a patch against the i2c
cvs version of the eeprom.c driver that converts it over to use sysfs,
instead of the /proc and sysctl interface.  It's still a bit rough, but
you should get the idea of where I'm wanting to go with this.  As you
can see, it takes about 100 lines of code off of this driver, which is
nice.

I'm copying the sensors list too, as they wanted to see how this was
going to be done.

Comments?

thanks,

greg k-h

--- src/lmsensors/lm_sensors2/kernel/chips/eeprom.c	Tue Jan 21 12:01:26 2003
+++ linux/linux-2.5/drivers/i2c/chips/eeprom.c	Tue Mar 25 09:03:21 2003
@@ -24,9 +24,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c-proc.h>
 #include <linux/init.h>
-#include "version.h"
-
-MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { SENSORS_I2C_END };
@@ -39,38 +36,29 @@
 
 static int checksum = 0;
 MODULE_PARM(checksum, "i");
-MODULE_PARM_DESC(checksum,
-		 "Only accept eeproms whose checksum is correct");
-
+MODULE_PARM_DESC(checksum, "Only accept eeproms whose checksum is correct");
 
-/* Many constants specified below */
 
 /* EEPROM registers */
-#define EEPROM_REG_CHECKSUM 0x3f
+#define EEPROM_REG_CHECKSUM	0x3f
 
 /* EEPROM memory types: */
-#define ONE_K		1
-#define TWO_K		2
-#define FOUR_K		3
-#define EIGHT_K		4
-#define SIXTEEN_K	5
+#define ONE_K			1
+#define TWO_K			2
+#define FOUR_K			3
+#define EIGHT_K			4
+#define SIXTEEN_K		5
 
-/* Conversions */
 /* Size of EEPROM in bytes */
-#define EEPROM_SIZE 256
+#define EEPROM_SIZE		256
 
 /* Each client has this additional data */
 struct eeprom_data {
-	int sysctl_id;
-
+//	int sysctl_id;
 	struct semaphore update_lock;
-	char valid;		/* !=0 if following fields are valid */
+	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
-
-	u8 data[EEPROM_SIZE];	/* Register values */
-#if 0
-	int memtype;
-#endif
+	u8 data[EEPROM_SIZE];		/* Register values */
 };
 
 
@@ -79,89 +67,61 @@
 			 unsigned short flags, int kind);
 static int eeprom_detach_client(struct i2c_client *client);
 
-#if 0
-static int eeprom_write_value(struct i2c_client *client, u8 reg,
-			      u8 value);
-#endif
-
-static void eeprom_contents(struct i2c_client *client, int operation,
-			    int ctl_name, int *nrels_mag, long *results);
 static void eeprom_update_client(struct i2c_client *client);
 
 
 /* This is the driver that will be inserted */
 static struct i2c_driver eeprom_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "EEPROM READER",
+	.name		= "eeprom",
 	.id		= I2C_DRIVERID_EEPROM,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= eeprom_attach_adapter,
 	.detach_client	= eeprom_detach_client,
 };
 
-/* -- SENSORS SYSCTL START -- */
+static int eeprom_id = 0;
 
-#define EEPROM_SYSCTL1 1000
-#define EEPROM_SYSCTL2 1001
-#define EEPROM_SYSCTL3 1002
-#define EEPROM_SYSCTL4 1003
-#define EEPROM_SYSCTL5 1004
-#define EEPROM_SYSCTL6 1005
-#define EEPROM_SYSCTL7 1006
-#define EEPROM_SYSCTL8 1007
-#define EEPROM_SYSCTL9 1008
-#define EEPROM_SYSCTL10 1009
-#define EEPROM_SYSCTL11 1010
-#define EEPROM_SYSCTL12 1011
-#define EEPROM_SYSCTL13 1012
-#define EEPROM_SYSCTL14 1013
-#define EEPROM_SYSCTL15 1014
-#define EEPROM_SYSCTL16 1015
-
-/* -- SENSORS SYSCTL END -- */
-
-/* These files are created for each detected EEPROM. This is just a template;
-   though at first sight, you might think we could use a statically
-   allocated list, we need some way to get back to the parent - which
-   is done through one of the 'extra' fields which are initialized
-   when a new copy is allocated. */
-static ctl_table eeprom_dir_table_template[] = {
-	{EEPROM_SYSCTL1, "00", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL2, "10", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL3, "20", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL4, "30", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL5, "40", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL6, "50", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL7, "60", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL8, "70", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL9, "80", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL10, "90", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL11, "a0", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL12, "b0", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL13, "c0", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL14, "d0", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL15, "e0", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{EEPROM_SYSCTL16, "f0", NULL, 0, 0444, NULL, &i2c_proc_real,
-	 &i2c_sysctl_real, NULL, &eeprom_contents},
-	{0}
-};
+static ssize_t show_eeprom(struct device *dev, char *buf, int base)
+{
+	struct i2c_client *client;
+	struct eeprom_data *data;
+	char *buffer;
+	int i;
 
-static int eeprom_id = 0;
+	client = to_i2c_client(dev);
+	data = i2c_get_clientdata(client);
+	buffer = buf;
+
+	eeprom_update_client(client);
+	for (i = 0; i < 15; ++i)
+		buf += sprintf(buf, "%d ", data->data[i + base]);
+	buf += sprintf(buf, "%d\n", data->data[15 + base]);
+	return (buf - buffer);
+}
+#define show_eeprom_offset(offset)			\
+static ssize_t						\
+show_eeprom_##offset (struct device *dev, char *buf)	\
+{							\
+	return show_eeprom(dev, buf, 0x##offset);	\
+}							\
+static DEVICE_ATTR(eeprom_##offset, S_IRUGO, show_eeprom_##offset, NULL)
+show_eeprom_offset(00);
+show_eeprom_offset(10);
+show_eeprom_offset(20);
+show_eeprom_offset(30);
+show_eeprom_offset(40);
+show_eeprom_offset(50);
+show_eeprom_offset(60);
+show_eeprom_offset(70);
+show_eeprom_offset(80);
+show_eeprom_offset(90);
+show_eeprom_offset(a0);
+show_eeprom_offset(b0);
+show_eeprom_offset(c0);
+show_eeprom_offset(d0);
+show_eeprom_offset(e0);
+show_eeprom_offset(f0);
 
 static int eeprom_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -182,14 +142,13 @@
 	   at this moment; i2c_detect really won't call us. */
 #ifdef DEBUG
 	if (i2c_is_isa_adapter(adapter)) {
-		printk
-		    ("eeprom.o: eeprom_detect called for an ISA bus adapter?!?\n");
+		dev_dbg(&adapter->dev, " eeprom_detect called for an ISA bus adapter?!?\n");
 		return 0;
 	}
 #endif
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		    goto ERROR0;
+		goto ERROR0;
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
@@ -200,11 +159,13 @@
 		err = -ENOMEM;
 		goto ERROR0;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct eeprom_data));
 
 	data = (struct eeprom_data *) (new_client + 1);
 	memset(data, 0xff, EEPROM_SIZE);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &eeprom_driver;
 	new_client->flags = 0;
@@ -218,8 +179,7 @@
 		for (i = 0; i <= 0x3e; i++)
 			cs += i2c_smbus_read_byte_data(new_client, i);
 		cs &= 0xff;
-		if (i2c_smbus_read_byte_data
-		    (new_client, EEPROM_REG_CHECKSUM) != cs)
+		if (i2c_smbus_read_byte_data (new_client, EEPROM_REG_CHECKSUM) != cs)
 			goto ERROR1;
 	}
 
@@ -231,15 +191,12 @@
 		type_name = "eeprom";
 		client_name = "EEPROM chip";
 	} else {
-#ifdef DEBUG
-		printk("eeprom.o: Internal error: unknown kind (%d)?!?",
-		       kind);
-#endif
+		dev_dbg(&adap->dev, "Internal error: unknown kind (%d)?!?", kind);
 		goto ERROR1;
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strcpy(new_client->name, client_name);
+	strncpy(new_client->dev.name, client_name, DEVICE_NAME_SIZE);
 
 	new_client->id = eeprom_id++;
 	data->valid = 0;
@@ -249,25 +206,38 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR3;
 
-	/* Register a new directory entry with module sensors */
-	if ((i = i2c_register_entry(new_client, type_name,
-					eeprom_dir_table_template)) < 0) {
-		err = i;
-		goto ERROR4;
-	}
-	data->sysctl_id = i;
+	device_create_file(&new_client->dev, &dev_attr_eeprom_00);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_10);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_20);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_30);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_40);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_50);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_60);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_70);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_80);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_90);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_a0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_b0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_c0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_d0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_e0);
+	device_create_file(&new_client->dev, &dev_attr_eeprom_f0);
+
+//	/* Register a new directory entry with module sensors */
+//	if ((i = i2c_register_entry(new_client, type_name, eeprom_dir_table_template)) < 0) {
+//		err = i;
+//		goto ERROR4;
+//	}
+//	data->sysctl_id = i;
 
 	return 0;
 
-/* OK, this is not exactly good programming practice, usually. But it is
-   very code-efficient in this case. */
-
-      ERROR4:
-	i2c_detach_client(new_client);
-      ERROR3:
-      ERROR1:
+//ERROR4:
+//	i2c_detach_client(new_client);
+ERROR3:
+ERROR1:
 	kfree(new_client);
-      ERROR0:
+ERROR0:
 	return err;
 }
 
@@ -275,8 +245,7 @@
 {
 	int err;
 
-	i2c_deregister_entry(((struct eeprom_data *) (client->data))->
-				 sysctl_id);
+//	i2c_deregister_entry(((struct eeprom_data *) (i2c_get_clientdata(client)))->sysctl_id);
 
 	if ((err = i2c_detach_client(client))) {
 		printk
@@ -289,42 +258,24 @@
 	return 0;
 }
 
-
-#if 0
-/* No writes yet (PAE) */
-static int eeprom_write_value(struct i2c_client *client, u8 reg, u8 value)
-{
-	return i2c_smbus_write_byte_data(client, reg, value);
-}
-#endif
-
 static void eeprom_update_client(struct i2c_client *client)
 {
-	struct eeprom_data *data = client->data;
+	struct eeprom_data *data = i2c_get_clientdata(client);
 	int i, j;
 
 	down(&data->update_lock);
 
 	if ((jiffies - data->last_updated > 300 * HZ) |
 	    (jiffies < data->last_updated) || !data->valid) {
+		dev_dbg(&client->dev, "Starting eeprom update\n");
 
-#ifdef DEBUG
-		printk("Starting eeprom update\n");
-#endif
-
-		if (i2c_check_functionality(client->adapter,
-		                            I2C_FUNC_SMBUS_READ_I2C_BLOCK))
-		{
+		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
 			for (i=0; i<EEPROM_SIZE; i+=I2C_SMBUS_I2C_BLOCK_MAX)
-				if (i2c_smbus_read_i2c_block_data(client,
-				                           i, data->data + i)
-				                    != I2C_SMBUS_I2C_BLOCK_MAX)
+				if (i2c_smbus_read_i2c_block_data(client, i, data->data + i) != I2C_SMBUS_I2C_BLOCK_MAX)
 					goto DONE;
 		} else {
 			if (i2c_smbus_write_byte(client, 0)) {
-#ifdef DEBUG
-				printk("eeprom read start has failed!\n");
-#endif
+				dev_dbg(&client->dev, "eeprom read start has failed!\n");
 				goto DONE;
 			}
 			for (i = 0; i < EEPROM_SIZE; i++) {
@@ -341,88 +292,8 @@
 	up(&data->update_lock);
 }
 
-
-void eeprom_contents(struct i2c_client *client, int operation,
-		     int ctl_name, int *nrels_mag, long *results)
-{
-	int i;
-	int base = 0;
-	struct eeprom_data *data = client->data;
-
-	switch (ctl_name) {
-		case EEPROM_SYSCTL2:
-			base = 16;
-			break;
-		case EEPROM_SYSCTL3:
-			base = 32;
-			break;
-		case EEPROM_SYSCTL4:
-			base = 48;
-			break;
-		case EEPROM_SYSCTL5:
-			base = 64;
-			break;
-		case EEPROM_SYSCTL6:
-			base = 80;
-			break;
-		case EEPROM_SYSCTL7:
-			base = 96;
-			break;
-		case EEPROM_SYSCTL8:
-			base = 112;
-			break;
-		case EEPROM_SYSCTL9:
-			base = 128;
-			break;
-		case EEPROM_SYSCTL10:
-			base = 144;
-			break;
-		case EEPROM_SYSCTL11:
-			base = 160;
-			break;
-		case EEPROM_SYSCTL12:
-			base = 176;
-			break;
-		case EEPROM_SYSCTL13:
-			base = 192;
-			break;
-		case EEPROM_SYSCTL14:
-			base = 208;
-			break;
-		case EEPROM_SYSCTL15:
-			base = 224;
-			break;
-		case EEPROM_SYSCTL16:
-			base = 240;
-			break;
-	}
-
-	if (operation == SENSORS_PROC_REAL_INFO)
-		*nrels_mag = 0;
-	else if (operation == SENSORS_PROC_REAL_READ) {
-		eeprom_update_client(client);
-		for (i = 0; i < 16; i++) {
-			results[i] = data->data[i + base];
-		}
-#ifdef DEBUG
-		printk("eeprom.o: 0x%X EEPROM Contents (base %d): ",
-		       client->addr, base);
-		for (i = 0; i < 16; i++) {
-			printk(" 0x%X", data->data[i + base]);
-		}
-		printk(" .\n");
-#endif
-		*nrels_mag = 16;
-	} else if (operation == SENSORS_PROC_REAL_WRITE) {
-
-/* No writes to the EEPROM (yet, anyway) (PAE) */
-		printk("eeprom.o: No writes to EEPROMs supported!\n");
-	}
-}
-
 static int __init sm_eeprom_init(void)
 {
-	printk("eeprom.o version %s (%s)\n", LM_VERSION, LM_DATE);
 	return i2c_add_driver(&eeprom_driver);
 }
 
@@ -432,10 +303,10 @@
 }
 
 
-
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl> and "
+		"Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("EEPROM driver");
+MODULE_LICENSE("GPL");
 
 module_init(sm_eeprom_init);
 module_exit(sm_eeprom_exit);
