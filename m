Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUD2MnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUD2MnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbUD2MnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:43:21 -0400
Received: from mail9.messagelabs.com ([194.205.110.133]:37813 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S264358AbUD2Ml2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:41:28 -0400
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-20.tower-9.messagelabs.com!1083242477!7979053
X-StarScan-Version: 5.2.10; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: [PATCH] 2.6 I2C epson 8564 RTC chip
From: Ian Campbell <icampbell@arcom.com>
To: stefan.eletzhofer@eletztrick.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <20040429120250.GD10867@gonzo.local>
References: <20040429120250.GD10867@gonzo.local>
Content-Type: multipart/mixed; boundary="=-gbmu9BDEwruUKIrkvCjn"
Organization: Arcom Control Systems
Message-Id: <1083242482.26762.30.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 13:41:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gbmu9BDEwruUKIrkvCjn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Stefan,

> This driver only does the low-level I2C stuff, the rtc misc device
> driver is a separate driver module which I will send a patch for soon.

I have a patch (attached, it could do with cleaning up) for the Dallas
DS1307 I2C RTC which I ported from the 2.4 rmk patch, originally written
by Intrinsyc. Currently it includes both the I2C and the RTC bits in the
same driver.

Do you think it is realistic/possible to have the same generic RTC
driver speak to multiple I2C devices, from what I can see in your driver
the two chips seem pretty similar and the differences could probably be
abstracted away. Perhaps that is your intention from the start?

I guess I will wait until you post the RTC misc driver and try and make
the DS1307 one work with that before I submit it.

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
--=-gbmu9BDEwruUKIrkvCjn
Content-Disposition: attachment; filename=ds1307
Content-Type: text/x-patch; name=ds1307; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Index: linux-2.6-bkpxa/drivers/i2c/chips/Kconfig
===================================================================
--- linux-2.6-bkpxa.orig/drivers/i2c/chips/Kconfig	2004-04-26 11:00:40.000000000 +0100
+++ linux-2.6-bkpxa/drivers/i2c/chips/Kconfig	2004-04-26 11:03:03.000000000 +0100
@@ -230,4 +230,8 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called pcf8591.
 
+config DS1307
+	tristate "Dallas Semiconductor DS1307 Real-Time Clock"
+	depends on I2C
+
 endmenu
Index: linux-2.6-bkpxa/drivers/i2c/chips/Makefile
===================================================================
--- linux-2.6-bkpxa.orig/drivers/i2c/chips/Makefile	2004-04-26 11:00:40.000000000 +0100
+++ linux-2.6-bkpxa/drivers/i2c/chips/Makefile	2004-04-26 11:03:03.000000000 +0100
@@ -24,6 +24,8 @@
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 
+obj-$(CONFIG_DS1307)	 	+= ds1307.o
+
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
Index: linux-2.6-bkpxa/drivers/i2c/chips/ds1307.c
===================================================================
--- linux-2.6-bkpxa.orig/drivers/i2c/chips/ds1307.c	2004-04-26 09:37:12.000000000 +0100
+++ linux-2.6-bkpxa/drivers/i2c/chips/ds1307.c	2004-04-26 13:27:11.000000000 +0100
@@ -0,0 +1,602 @@
+/*
+ * ds1307.c
+ *
+ * Device driver for Dallas Semiconductor's Real Time Controller DS1307.
+ *
+ * Copyright (C) 2002 Intrinsyc Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+
+#include <linux/kernel.h>
+#include <linux/poll.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/rtc.h>
+#include <linux/string.h>
+#include <linux/miscdevice.h>
+#include <linux/proc_fs.h>
+
+#include "ds1307.h"
+
+#if DEBUG
+static unsigned int rtc_debug = DEBUG;
+#else
+#define rtc_debug 0	/* gcc will remove all the debug code for us */
+#endif
+
+struct ds1307_data {
+	struct semaphore lock;
+	unsigned char control;
+};
+
+/* --- /dev/rtc interface --- */
+
+static struct i2c_client *rtc_client = NULL;
+
+static int ds1307_rtc_ioctl( struct inode *, struct file *, unsigned int, unsigned long);
+static int ds1307_rtc_open(struct inode *inode, struct file *file);
+static int ds1307_rtc_release(struct inode *inode, struct file *file);
+
+static struct file_operations rtc_fops = {
+	owner:		THIS_MODULE,
+	ioctl:		ds1307_rtc_ioctl,
+	open:		ds1307_rtc_open,
+	release:	ds1307_rtc_release,
+};
+
+static struct miscdevice ds1307_rtc_miscdev = {
+	RTC_MINOR,
+	"rtc",
+	&rtc_fops
+};
+
+
+static char *
+ds1307_mon2str( unsigned int mon)
+{
+	char *mon2str[12] = {
+	  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
+	  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
+	};
+	if( mon > 11) return "error";
+	else return mon2str[ mon];
+}
+
+static int
+ds1307_readram( char *buf, int len)
+{
+	struct i2c_client *client = rtc_client;
+	struct ds1307_data *data = i2c_get_clientdata(client);
+
+        unsigned long   flags;
+        unsigned char ad[1] = { 0 };
+        int ret;
+        struct i2c_msg msgs[2] = {
+                { client->addr, 0,        1, ad  },
+                { client->addr, I2C_M_RD, len, buf } };
+ 
+        spin_lock_irqsave(data->lock, flags);
+        ret = i2c_transfer(client->adapter, msgs, 2);
+        spin_unlock_irqrestore(data->lock,flags);
+ 
+        return ret;
+}
+
+static void
+ds1307_convert_to_time( struct rtc_time *dt, char *buf)
+{
+	dt->tm_sec = BCD_TO_BIN(buf[0]);
+	dt->tm_min = BCD_TO_BIN(buf[1]);
+
+	if ( TWELVE_HOUR_MODE(buf[2]) )
+	{
+		dt->tm_hour = HOURS_12(buf[2]);
+		if (HOURS_AP(buf[2])) /* PM */
+		{
+			dt->tm_hour += 12;
+		}
+	}
+	else /* 24-hour-mode */
+	{
+		dt->tm_hour = HOURS_24(buf[2]);
+	}
+
+	dt->tm_mday = BCD_TO_BIN(buf[4]);
+	/* dt->tm_mon is zero-based */
+	dt->tm_mon = BCD_TO_BIN(buf[5]) - 1;
+	/* year is 1900 + dt->tm_year */
+	dt->tm_year = BCD_TO_BIN(buf[6]) + 100;
+
+	if( rtc_debug > 2)
+	{
+		printk("ds1307_get_datetime: year = %d\n", dt->tm_year);
+		printk("ds1307_get_datetime: mon  = %d\n", dt->tm_mon);
+		printk("ds1307_get_datetime: mday = %d\n", dt->tm_mday);
+		printk("ds1307_get_datetime: hour = %d\n", dt->tm_hour);
+		printk("ds1307_get_datetime: min  = %d\n", dt->tm_min);
+		printk("ds1307_get_datetime: sec  = %d\n", dt->tm_sec);
+	}
+}
+
+static int ds1307_rtc_proc_output( char *buf)
+{
+#define CHECK(ctrl,bit) ((ctrl & bit) ? "yes" : "no")
+	unsigned char ram[DS1307_RAM_SIZE];
+	int ret;
+
+	char *p = buf;
+
+	ret = ds1307_readram( ram, DS1307_RAM_SIZE);
+	if( ret > 0)
+	{
+		int i;
+		struct rtc_time dt;
+		char text[9];
+
+		p += sprintf(p, "DS1307 (64x8 Serial Real Time Clock)\n");
+
+		ds1307_convert_to_time( &dt, ram);
+		p += sprintf(p, "Date/Time           : %02d-%s-%04d %02d:%02d:%02d\n",
+			dt.tm_mday, ds1307_mon2str(dt.tm_mon), dt.tm_year + 1900,
+			dt.tm_hour, dt.tm_min, dt.tm_sec);
+
+		p += sprintf(p, "Clock halted        : %s\n", CHECK(ram[0],0x80));
+		p += sprintf(p, "24h mode            : %s\n", CHECK(ram[2],0x40));
+		p += sprintf(p, "Square wave enabled : %s\n", CHECK(ram[7],0x10));
+		p += sprintf(p, "Freq                : ");
+
+		switch( ram[7] & 0x03)
+		{
+			case RATE_1HZ:
+				p += sprintf(p, "1Hz\n");
+				break;
+			case RATE_4096HZ:
+				p += sprintf(p, "4.096kHz\n");
+				break;
+			case RATE_8192HZ:
+				p += sprintf(p, "8.192kHz\n");
+				break;
+			case RATE_32768HZ:
+			default:
+				p += sprintf(p, "32.768kHz\n");
+				break;
+
+		}
+
+		p += sprintf(p, "RAM dump:\n");
+		text[8]='\0';
+		for( i=0; i<DS1307_RAM_SIZE; i++)
+		{
+			p += sprintf(p, "%02X ", ram[i]);
+
+			if( (ram[i] < 32) || (ram[i]>126)) ram[i]='.';
+			text[i%8] = ram[i];
+			if( (i%8) == 7) p += sprintf(p, "%s\n",text);
+		}
+		p += sprintf(p, "\n");
+	}
+	else
+	{
+		p += sprintf(p, "Failed to read RTC memory!\n");
+	}
+
+	return	p - buf;
+}
+
+static int ds1307_rtc_read_proc(char *page, char **start, off_t off,
+		int count, int *eof, void *data)
+{
+	int len = ds1307_rtc_proc_output (page);
+	if (len <= off+count) *eof = 1;
+	*start = page + off;
+	len -= off;
+	if (len>count) len = count;
+	if (len<0) len = 0;
+	return len;
+}
+
+/* --- I2C interface --- */
+// The DS1307 can only ever be present at address 0x68
+static unsigned short normal_i2c[]      = { 0x68, I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };
+
+I2C_CLIENT_INSMOD;
+
+static int ds1307_attach_adapter(struct i2c_adapter *adapter);
+static int ds1307_detect(struct i2c_adapter *adapter, int address, int kind);
+static void ds1307_init_client(struct i2c_client *client);
+static int ds1307_detach_client(struct i2c_client *client);
+static int ds1307_command(struct i2c_client *client, unsigned int cmd, void *arg);
+static void ds1307_enable_clock(struct i2c_client *client, int enable);
+
+struct i2c_driver ds1307_driver = {
+	.name           = "ds1307",
+	.id		= I2C_DRIVERID_DS1307,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= ds1307_attach_adapter,
+	.detach_client	= ds1307_detach_client,
+	.command        = ds1307_command
+};
+
+static int ds1307_id = 0;
+
+static void ds1307_init_client(struct i2c_client *client)
+{
+	struct ds1307_data *data = i2c_get_clientdata(client);
+	data->control = i2c_smbus_read_byte_data(client, 0x07);
+	ds1307_enable_clock(client, 1);
+}
+
+static int ds1307_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, ds1307_detect);
+}
+
+/* The `kind' parameter contains 0 if this call is due to a `force'
+   parameter, and -1 otherwise */
+static int
+ds1307_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct ds1307_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter,I2C_FUNC_SMBUS_WORD_DATA |
+				             I2C_FUNC_SMBUS_WRITE_BYTE))
+		goto exit;
+
+	if ( kind < 0 ) { 
+		if ( address != 0x68 ) /* DS1307 is always at address 0x68 */
+			goto exit;
+	}
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure. */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct ds1307_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(new_client, 0, sizeof(struct i2c_client) +
+	       sizeof(struct ds1307_data));
+	data = (struct ds1307_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &ds1307_driver;
+	new_client->flags = 0;
+	
+	/* Could do any remaing detection here -- if kind < 0 */
+
+	/* Fill in remaining client fields and put it into the global list */
+	strlcpy(new_client->name, "ds1307", I2C_NAME_SIZE);
+
+	new_client->id = ds1307_id++;
+	init_MUTEX(&data->lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the DS1307 chip */
+	ds1307_init_client(new_client);
+
+	rtc_client = new_client;
+
+	return 0;
+
+      exit_free:
+	kfree(new_client);
+      exit:
+	return err;
+}
+
+static int ds1307_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	ds1307_enable_clock(client, 0);
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+		        "ds1307.o: Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+	return 0;
+}
+
+static __init int ds1307_init(void)
+{
+	int retval;
+
+	retval = i2c_add_driver(&ds1307_driver);
+	if (retval==0)
+	{
+		misc_register (&ds1307_rtc_miscdev);
+		create_proc_read_entry (PROC_DS1307_NAME, 0, 0, ds1307_rtc_read_proc, NULL);
+		printk(KERN_INFO "ds1307.o: RTC driver successfully loaded.\n");
+	}
+	return retval;
+}
+
+static __exit void ds1307_exit(void)
+{
+	remove_proc_entry (PROC_DS1307_NAME, NULL);
+	misc_deregister(&ds1307_rtc_miscdev);
+	i2c_del_driver(&ds1307_driver);
+}
+
+module_init(ds1307_init);
+module_exit(ds1307_exit);
+
+MODULE_AUTHOR ("Intrinsyc Software Inc.");
+MODULE_LICENSE("GPL");
+
+/* --- CUTOFF --- */
+
+static void ds1307_enable_clock(struct i2c_client *client, int enable)
+{
+	unsigned char ctrl_info;
+
+	if( enable)
+		ctrl_info = SQW_ENABLE | RATE_32768HZ;
+	else
+		ctrl_info = SQW_DISABLE;
+
+	ds1307_command(client, DS1307_SETCTRL, &ctrl_info);
+
+	/* read addr 0 (Clock-Halt bit and second counter) */
+	u32 reg = i2c_smbus_read_byte_data(client, 0x0);
+	if (enable)
+		reg &= ~CLOCK_HALT; /* clear Clock-Halt bit */
+	else
+		reg |= CLOCK_HALT; /* set Clock-Halt bit */
+	i2c_smbus_write_byte_data(client, 0, reg);
+}
+
+static int
+ds1307_get_datetime(struct i2c_client *client, struct rtc_time *dt)
+{
+        unsigned char buf[7], addr[1] = { 0 };
+        struct i2c_msg msgs[2] = {
+                { client->addr, 0,        1, addr },
+                { client->addr, I2C_M_RD, 7, buf  }
+        };
+        int ret = -EIO;
+ 
+        memset(buf, 0, sizeof(buf));
+ 
+        ret = i2c_transfer(client->adapter, msgs, 2);
+ 
+        if (ret == 2) {
+                ds1307_convert_to_time( dt, buf);
+                ret = 0;
+        }
+        else
+                printk("ds1307_get_datetime(), i2c_transfer() returned %d\n",ret);
+ 
+        return ret;
+}
+
+static int
+ds1307_set_datetime(struct i2c_client *client, struct rtc_time *dt, int datetoo)
+{
+        unsigned char buf[8];
+        int ret, len = 4;
+ 
+        if( rtc_debug > 2)
+        {
+                printk("ds1307_set_datetime: tm_year = %d\n", dt->tm_year);
+                printk("ds1307_set_datetime: tm_mon  = %d\n", dt->tm_mon);
+                printk("ds1307_set_datetime: tm_mday = %d\n", dt->tm_mday);
+                printk("ds1307_set_datetime: tm_hour = %d\n", dt->tm_hour);
+                printk("ds1307_set_datetime: tm_min  = %d\n", dt->tm_min);
+                printk("ds1307_set_datetime: tm_sec  = %d\n", dt->tm_sec);
+        }
+ 
+        buf[0] = 0;     /* register address on DS1307 */
+        buf[1] = (BIN_TO_BCD(dt->tm_sec));
+        buf[2] = (BIN_TO_BCD(dt->tm_min));
+        buf[3] = (BIN_TO_BCD(dt->tm_hour));
+
+        if (datetoo) {
+                len = 8;
+                /* we skip buf[4] as we don't use day-of-week. */
+                buf[5] = (BIN_TO_BCD(dt->tm_mday));
+                buf[6] = (BIN_TO_BCD(dt->tm_mon + 1));
+                /* The year only ranges from 0-99, we are being passed an offset from 1900,
+                 * and the chip calulates leap years based on 2000, thus we adjust by 100.
+                 */
+                buf[7] = (BIN_TO_BCD(dt->tm_year - 100));
+        }
+        ret = i2c_master_send(client, (char *)buf, len);
+        if (ret == len)
+                ret = 0;
+        else
+                printk("ds1307_set_datetime(), i2c_master_send() returned %d\n",ret);
+
+        return ret;
+}
+
+static int
+ds1307_get_ctrl(struct i2c_client *client, unsigned char *ctrl)
+{
+	struct ds1307_data *data = i2c_get_clientdata(client);
+	*ctrl = data->control;
+	return 0;
+}
+
+static int
+ds1307_set_ctrl(struct i2c_client *client, unsigned char *cinfo)
+{
+	struct ds1307_data *data = i2c_get_clientdata(client);
+	data->control = *cinfo;
+	return i2c_smbus_write_byte_data(client, 0x07, data->control);
+}
+
+static int
+ds1307_read_mem(struct i2c_client *client, struct rtc_mem *mem)
+{
+	unsigned char addr[1];
+	struct i2c_msg msgs[2] = {
+		{ client->addr, 0,	  1, addr },
+		{ client->addr, I2C_M_RD, mem->nr, mem->data }
+	};
+
+	if ( (mem->loc < DS1307_RAM_ADDR_START) ||
+	     ((mem->loc + mem->nr -1) > DS1307_RAM_ADDR_END) )
+		return -EINVAL;
+
+	addr[0] = mem->loc;
+
+	return i2c_transfer(client->adapter, msgs, 2) == 2 ? 0 : -EIO;
+}
+
+static int
+ds1307_write_mem(struct i2c_client *client, struct rtc_mem *mem)
+{
+	unsigned char addr[1];
+	struct i2c_msg msgs[2] = {
+		{ client->addr, 0, 1, addr },
+		{ client->addr, 0, mem->nr, mem->data }
+	};
+
+	if ( (mem->loc < DS1307_RAM_ADDR_START) ||
+	     ((mem->loc + mem->nr -1) > DS1307_RAM_ADDR_END) )
+		return -EINVAL;
+
+	addr[0] = mem->loc;
+
+	return i2c_transfer(client->adapter, msgs, 2) == 2 ? 0 : -EIO;
+}
+
+static int
+ds1307_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case DS1307_GETDATETIME:
+		return ds1307_get_datetime(client, arg);
+
+	case DS1307_SETTIME:
+		return ds1307_set_datetime(client, arg, 0);
+
+	case DS1307_SETDATETIME:
+		return ds1307_set_datetime(client, arg, 1);
+
+	case DS1307_GETCTRL:
+		return ds1307_get_ctrl(client, arg);
+
+	case DS1307_SETCTRL:
+		return ds1307_set_ctrl(client, arg);
+
+	case DS1307_MEM_READ:
+		return ds1307_read_mem(client, arg);
+
+	case DS1307_MEM_WRITE:
+		return ds1307_write_mem(client, arg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+ds1307_rtc_open(struct inode *inode, struct file *file)
+{
+	struct i2c_client *client = rtc_client;
+	struct ds1307_data *data;
+
+	if ( client == NULL )
+		return -ENODEV;
+
+	data = i2c_get_clientdata(client);
+
+	if ( data == NULL ) 
+		return -ENODEV;
+
+	/* re-read ctrl register to ensure there really is a device
+	 * there. if we have a situation where the device is present
+	 * but incorrectly connected (or just faulty) then we may seem
+	 * to be reading/writing OK but really we are getting junk --
+	 * so lets test that the CTRL register is really what we think
+	 * it is. If it isn't then it is likely that we don't have a
+	 * valid device attached */
+	u32 reg = i2c_smbus_read_byte_data(client, 0x07);
+
+	if ( reg == -1 ) {
+		printk (KERN_DEBUG "ds1307_rtc_open: could not verify ctrl - read returned %d.\n", reg);
+		return -ENODEV;
+	} else if ( (reg&~0x20) != (data->control&~0x20) ) { /* 0x20 is OSF bit, ignore it */
+		printk(KERN_DEBUG "ds1307_rtc_open: failed to verify ctrl register. "
+		       "got 0x%02x wanted 0x%02x\n",
+		       reg, data->control);
+		return -ENODEV; 
+	}
+	return 0;
+}
+
+static int
+ds1307_rtc_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int
+ds1307_rtc_ioctl( struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	struct i2c_client *client = rtc_client;
+	struct ds1307_data *data = i2c_get_clientdata(client);
+
+	struct rtc_time wtime;
+
+	switch (cmd) {
+		default:
+		case RTC_UIE_ON:
+		case RTC_UIE_OFF:
+		case RTC_PIE_ON:
+		case RTC_PIE_OFF:
+		case RTC_AIE_ON:
+		case RTC_AIE_OFF:
+		case RTC_ALM_SET:
+		case RTC_ALM_READ:
+		case RTC_IRQP_READ:
+		case RTC_IRQP_SET:
+		case RTC_EPOCH_READ:
+		case RTC_EPOCH_SET:
+		case RTC_WKALM_SET:
+		case RTC_WKALM_RD:
+			return -EINVAL;
+
+		case RTC_RD_TIME:
+			down(&data->lock);
+			ds1307_command(client, DS1307_GETDATETIME, &wtime);
+			up(&data->lock);
+			if( copy_to_user((void *)arg, &wtime, sizeof (struct rtc_time)))
+				return -EFAULT;
+			return 0;
+
+		case RTC_SET_TIME:
+			if (!capable(CAP_SYS_TIME))
+				return -EACCES;
+			if (copy_from_user(&wtime, (struct rtc_time *)arg, sizeof(struct rtc_time)) )
+				return -EFAULT;
+	
+			down(&data->lock);
+			ds1307_command(client, DS1307_SETDATETIME, &wtime);
+			up(&data->lock);
+			return 0;
+	}
+}
Index: linux-2.6-bkpxa/drivers/i2c/chips/ds1307.h
===================================================================
--- linux-2.6-bkpxa.orig/drivers/i2c/chips/ds1307.h	2004-04-26 09:37:12.000000000 +0100
+++ linux-2.6-bkpxa/drivers/i2c/chips/ds1307.h	2004-04-26 11:03:03.000000000 +0100
@@ -0,0 +1,52 @@
+/*
+ * ds1307.h
+ *
+ * Copyright (C) 2002 Intrinsyc Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef DS1307_H
+#define DS1307_H
+
+#define DS1307_RAM_ADDR_START	0x08
+#define DS1307_RAM_ADDR_END	0x3F
+#define DS1307_RAM_SIZE 0x40
+
+#define PROC_DS1307_NAME	"driver/ds1307"
+
+struct rtc_mem {
+	unsigned int	loc;
+	unsigned int	nr;
+	unsigned char	*data;
+};
+
+#define DS1307_GETDATETIME	0
+#define DS1307_SETTIME		1
+#define DS1307_SETDATETIME	2
+#define DS1307_GETCTRL		3
+#define DS1307_SETCTRL		4
+#define DS1307_MEM_READ		5
+#define DS1307_MEM_WRITE	6
+
+#define SQW_ENABLE	0x10	/* Square Wave Enable */
+#define SQW_DISABLE	0x00	/* Square Wave disable */
+
+#define RATE_32768HZ	0x03	/* Rate Select 32.768KHz */
+#define RATE_8192HZ	0x02	/* Rate Select 8.192KHz */
+#define RATE_4096HZ	0x01	/* Rate Select 4.096KHz */
+#define RATE_1HZ	0x00	/* Rate Select 1Hz */
+
+#define CLOCK_HALT	0x80	/* Clock Halt */
+
+#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
+#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
+
+#define TWELVE_HOUR_MODE(n)	(((n)>>6)&1)
+#define HOURS_AP(n)		(((n)>>5)&1)
+#define HOURS_12(n)		BCD_TO_BIN((n)&0x1F)
+#define HOURS_24(n)		BCD_TO_BIN((n)&0x3F)
+
+#endif

--=-gbmu9BDEwruUKIrkvCjn--

