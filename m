Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVEYRGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVEYRGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVEYRFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:05:53 -0400
Received: from c71.sam-solutions.net ([217.21.35.67]:29343 "EHLO
	c71.sam-solutions.net") by vger.kernel.org with ESMTP
	id S261472AbVEYREc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:04:32 -0400
To: linux-kernel@vger.kernel.org
Subject: rs5c372 driver patch
From: p.mironchik@sam-solutions.net (Pavel S. Mironchik)
Organization: SaM-Solutions Ltd.
Date: Wed, 25 May 2005 21:04:22 +0400
Message-ID: <m364x7i6eh.fsf@pc376.sam-solutions.net>
X-Mailer: Gnus v5.10.6/XEmacs 21.4 - "Jumbo Shrimp"
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-OriginalArrivalTime: 25 May 2005 17:04:23.0239 (UTC) FILETIME=[CC907D70:01C5614B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,
If some one need this...
www.lannerinc.com and someone else 
are producing NAS with rs5c372 RTC.
It is impossible run normal linux hw without rtc :)
I ll be glad for any responce....
-- 
Best regards,
Pavel S. Mironchik


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=rs5c372.patch
Content-Description: patch

--- lanner-2.6.10/drivers/char/Kconfig.orig	2005-05-25 19:38:00 +0400
+++ lanner-2.6.10/drivers/char/Kconfig	2005-05-25 19:38:56 +0400
@@ -809,6 +809,10 @@
 	tristate "ST M41ST85W Real Time Clock (Intel IOP Platform)"
 	depends on ARCH_IQ31244 && I2C
 
+config RS5C372_RTC
+	tristate "RS5C372 Real Time Clock"
+	depends on I2C
+
 config PIC16F8X_PIC
 	tristate "Microchip PIC16F8X PIC Controller support (Intel IOP Platform)"
 	depends on ARCH_EP80219 && I2C
--- lanner-2.6.10/drivers/char/Makefile.orig	2005-05-25 19:36:44 +0400
+++ lanner-2.6.10/drivers/char/Makefile	2005-05-25 19:37:11 +0400
@@ -66,6 +66,7 @@
 obj-$(CONFIG_DS1302) += ds1302.o
 obj-$(CONFIG_S3C2410_RTC) += s3c2410-rtc.o
 obj-$(CONFIG_M41ST85W_RTC) += m41st85w.o
+obj-$(CONFIG_RS5C372_RTC) += rs5c372.o
 obj-$(CONFIG_PIC16F8X_PIC) += pic16f8x.o
 ifeq ($(CONFIG_GENERIC_NVRAM),y)
   obj-$(CONFIG_NVRAM) += generic_nvram.o
--- /dev/null	2005-05-25 17:30:46 +0400
+++ lanner-2.6.10/drivers/char/rs5c372.c	2005-05-25 20:02:10 +0400
@@ -0,0 +1,491 @@
+/*
+ * rs5c372.c
+ *
+ * Device driver for Real Time Controller's rs5c372 chips
+ *
+ * Copyright (C) 2005 Pavel Mironchik pmironchik@optifacio.net
+ *	
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This driver is adapted from the m41st85w driver
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
+#include <linux/time.h>
+
+
+//define DEBUG 0
+
+#define PROC_RS5C372_NAME	"driver/rs5c372_reset"
+#define RS5C372_I2C_SLAVE_ADDR  0x32
+#define RS5C372_RAM_ADDR_START	0x00
+#define RS5C372_RAM_ADDR_END	0x0F
+#define RS5C372_RAM_SIZE 	0x10
+#define I2C_DRIVERID_RS5C372    0xF6
+
+#define RS5C372_GETDATETIME	0
+#define RS5C372_SETTIME		1
+#define RS5C372_SETDATETIME	2
+
+#define RTC_SECONDS	0
+#define RTC_MINUTES	1
+#define RTC_HOURS	2
+#define RTC_WEEKDAYS	3
+#define RTC_DAYS	4
+#define RTC_MONTHS	5
+#define RTC_YEARS	6
+#define RTC_TIMETRIMM	7
+
+// ALARM A registers
+#define RTC_AM		8
+#define RTC_AH		9
+#define RTC_AW		10
+
+// ALARM B registers
+#define RTC_BM		11
+#define RTC_BH		12
+#define RTC_BW		13
+
+// Control registers
+#define RTC_CR1		14
+#define RTC_CR2		15
+
+#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
+#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
+#define HOURS_24(n)		BCD_TO_BIN((n)&0x3F)
+
+static unsigned short slave_address = RS5C372_I2C_SLAVE_ADDR;
+
+struct i2c_driver rs5c372_driver;
+struct i2c_client *rs5c372_i2c_client = NULL;
+extern int (*set_rtc) (void);
+
+static unsigned short ignore[]	= 	{ I2C_CLIENT_END };
+static unsigned short normal_addr[] =	{ RS5C372_I2C_SLAVE_ADDR, I2C_CLIENT_END };
+
+static struct i2c_client_address_data addr_data = {
+      normal_i2c:normal_addr,
+      normal_i2c_range:ignore,
+      probe:ignore,
+      probe_range:ignore,
+      ignore:ignore,
+      ignore_range:ignore,
+      force:ignore,
+};
+
+static int rs5c372_rtc_ioctl(struct inode *, struct file *, unsigned int,
+			      unsigned long);
+static int rs5c372_rtc_open(struct inode *inode, struct file *file);
+static int rs5c372_rtc_release(struct inode *inode, struct file *file);
+static int rs5c372_k_set_rtc_time(void);
+
+static struct file_operations rtc_fops = {
+      owner:THIS_MODULE,
+      ioctl:rs5c372_rtc_ioctl,
+      open:rs5c372_rtc_open,
+      release:rs5c372_rtc_release,
+};
+
+
+static struct miscdevice rs5c372_rtc_miscdev = {
+	RTC_MINOR,
+	"rtc",
+	&rtc_fops
+};
+
+static int rs5c372_probe(struct i2c_adapter *adap);
+static int rs5c372_detach(struct i2c_client *client);
+static int rs5c372_command(struct i2c_client *client, unsigned int cmd,
+			    void *arg);
+struct i2c_driver rs5c372_driver = {
+      name:"rs5c372",
+      id:I2C_DRIVERID_RS5C372,
+      flags:I2C_DF_NOTIFY,
+      attach_adapter:rs5c372_probe,
+      detach_client:rs5c372_detach,
+      command:rs5c372_command
+};
+
+extern int (*set_rtc) (void);
+
+static spinlock_t rs5c372_rtc_lock = SPIN_LOCK_UNLOCKED;
+
+static int rs5c372_read(char *buf, int len)
+{
+	unsigned long flags;
+	struct i2c_msg msgs[1] = {
+		{rs5c372_i2c_client->addr, I2C_M_RD, len, buf}
+	};
+	int ret;
+
+	spin_lock_irqsave(&rs5c372_rtc_lock, flags);
+	ret = i2c_transfer(rs5c372_i2c_client->adapter, msgs, 1);
+	spin_unlock_irqrestore(&rs5c372_rtc_lock, flags);
+	return ret;
+}
+
+static int rs5c372_write(char *buf, int len)
+{
+	// warning refer of the format of the first byte
+	// in rs5c372a-e datasheet
+	
+	unsigned long flags;
+	struct i2c_msg msgs[1] = {
+		{rs5c372_i2c_client->addr, 0, len, buf}
+	};
+	int ret;
+
+	spin_lock_irqsave(&rs5c372_rtc_lock, flags);
+	ret = i2c_transfer(rs5c372_i2c_client->adapter, msgs, 1);
+	spin_unlock_irqrestore(&rs5c372_rtc_lock, flags);
+	return ret;
+}
+
+static void rs5c372_setdefaults(char *buf)
+{
+	buf[0]=0x00;
+	buf[4]=0x01;
+	buf[5]=0x01;
+	buf[6]=0x01;
+	buf[7]=0x01;
+	
+	buf[0xF]=0x00;
+	buf[0x10]= 0x20; // 24 hour format ADJ=0
+}
+
+static void rs5c372_dump(void)
+{
+	unsigned char buf[RS5C372_RAM_SIZE+1];
+	int ret;
+	struct i2c_msg msgs[] = {
+		{rs5c372_i2c_client->addr, 1,RS5C372_RAM_SIZE+1, buf}
+	};
+
+	buf[0]=0x00;
+	ret = i2c_transfer(rs5c372_i2c_client->adapter, msgs, 1);
+	if (ret > 0) {
+		int i;
+		for(i=0;i<2*RS5C372_RAM_SIZE;i++){
+			printk("%02X ", buf[i]);
+		}
+		printk("RS5C372 RTclock\n");
+		printk("Seconds: %d ",BCD_TO_BIN(buf[1]));
+		printk("Minutes: %d ",BCD_TO_BIN(buf[2]));
+		printk("Hours: %d ",BCD_TO_BIN(buf[3]& 0x1F));
+		printk("Weekdays: %d ",BCD_TO_BIN(buf[4]));
+		printk("Days: %d ",BCD_TO_BIN(buf[5]));
+		printk("Months: %d ",BCD_TO_BIN(buf[6]));
+		printk("Years: %d\n",BCD_TO_BIN(buf[7]));
+	} 
+}
+
+static int rs5c372_attach(struct i2c_adapter *adap, int addr, int kind)
+{
+	int ret = 0;
+	struct i2c_client *c;
+	struct rtc_time rtctm;
+	
+	if (!(c = kmalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		return -ENOMEM;
+	}
+
+	memset(c, 0, sizeof(struct i2c_client));
+	strncpy(c->name, "rs5c372", I2C_NAME_SIZE);
+	
+	c->id		= rs5c372_driver.id;
+	c->flags	= I2C_CLIENT_ALLOW_USE | I2C_DF_NOTIFY;
+	c->addr		= addr;
+	c->adapter	= adap;
+	c->driver	= &rs5c372_driver;
+	
+	ret = i2c_attach_client(c);
+	rs5c372_i2c_client = c;
+	rs5c372_command(rs5c372_i2c_client, RS5C372_GETDATETIME,
+		(void *)&rtctm);
+
+	xtime.tv_nsec = 0;
+	xtime.tv_sec = mktime(1900 + rtctm.tm_year, rtctm.tm_mon + 1,
+		rtctm.tm_mday, rtctm.tm_hour, rtctm.tm_min, rtctm.tm_sec);
+
+	/* Fix for Uptime */
+        wall_to_monotonic.tv_sec = -xtime.tv_sec;
+        wall_to_monotonic.tv_nsec = -xtime.tv_nsec;
+                
+	set_rtc = rs5c372_k_set_rtc_time;
+	
+	if (ret < 0) {
+		printk(KERN_ERR "rs5c372: Attach was not ok!\n");
+		kfree(c);
+	}
+	return ret;
+}
+
+static int rs5c372_probe(struct i2c_adapter *adap)
+{
+	return i2c_probe(adap, &addr_data, rs5c372_attach);
+}
+
+static int rs5c372_detach(struct i2c_client *client)
+{
+	if (client) {
+		i2c_detach_client(client);
+		kfree(client);
+		client = rs5c372_i2c_client = NULL;
+	}
+	return 0;
+}
+
+
+static void rs5c372_convert_to_time(struct rtc_time *dt, char *buf)
+{
+	dt->tm_sec = BCD_TO_BIN(buf[1] & 0x7f);
+	dt->tm_min = BCD_TO_BIN(buf[2] & 0x7f);
+
+	/* 24 hour mode only */
+	dt->tm_hour = HOURS_24(buf[3]);
+
+	dt->tm_wday = BCD_TO_BIN(buf[4] & 0x07);
+	dt->tm_mday = BCD_TO_BIN(buf[5] & 0x3f);
+	
+	/* dt->tm_mon is zero-based */
+	dt->tm_mon = BCD_TO_BIN(buf[6] & 0x1f) - 1;
+	/* year is 1900 + dt->tm_year */
+	dt->tm_year = BCD_TO_BIN(buf[7])+100;
+	
+#ifdef DEBUG
+	printk("rs5c372_get_datetime: year = %d\n", dt->tm_year);
+	printk("rs5c372_get_datetime: mon  = %d\n", dt->tm_mon);
+	printk("rs5c372_get_datetime: mday = %d\n", dt->tm_mday);
+	printk("rs5c372_get_datetime: hour = %d\n", dt->tm_hour);
+	printk("rs5c372_get_datetime: min  = %d\n", dt->tm_min);
+	printk("rs5c372_get_datetime: sec  = %d\n", dt->tm_sec);
+#endif	
+}
+
+static int rs5c372_get_datetime(struct i2c_client *client, struct rtc_time *dt)
+{
+	unsigned char buf[RS5C372_RAM_SIZE+1];
+	int ret = -EIO;
+
+	ret = rs5c372_read(buf,RS5C372_RAM_SIZE+1);
+	if (ret >= 0) {
+		rs5c372_convert_to_time(dt, buf);
+		ret = 0;
+	} else
+		printk("rs5c372_get_datetime(), i2c_transfer() returned %d\n",
+		       ret);
+	return ret;
+}
+
+
+static int rs5c372_set_datetime(struct i2c_client *client, struct rtc_time *dt,int datetoo)
+{
+	unsigned char buf[RS5C372_RAM_SIZE+1];
+	int ret, len = 4;
+	
+#ifdef DEBUG	
+	printk("rs5c372_set_datetime: tm_year = %d\n", dt->tm_year);
+	printk("rs5c372_set_datetime: tm_mon  = %d\n", dt->tm_mon);
+	printk("rs5c372_set_datetime: tm_mday = %d\n", dt->tm_mday);
+	printk("rs5c372_set_datetime: tm_hour = %d\n", dt->tm_hour);
+	printk("rs5c372_set_datetime: tm_min  = %d\n", dt->tm_min);
+	printk("rs5c372_set_datetime: tm_sec  = %d\n", dt->tm_sec);
+#endif		
+
+	buf[0] = 0;
+	buf[1] = (BIN_TO_BCD(dt->tm_sec));
+	buf[2] = (BIN_TO_BCD(dt->tm_min));
+	buf[3] = (BIN_TO_BCD(dt->tm_hour));
+
+	if (datetoo) {
+		len = 8;
+		buf[4] = (BIN_TO_BCD(dt->tm_wday));
+		buf[5] = (BIN_TO_BCD(dt->tm_mday));
+		buf[6] = (BIN_TO_BCD(dt->tm_mon + 1)); 
+		buf[7] = (BIN_TO_BCD(dt->tm_year - 100));
+	}
+
+	ret = rs5c372_write(buf,len);	
+	if (ret >= 0)
+		ret = 0;
+	else
+		printk
+		    ("rs5c372_set_datetime(), i2c_master_send() returned %d\n",
+		     ret);
+	return ret;
+}
+
+static int rs5c372_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case RS5C372_GETDATETIME:
+		return rs5c372_get_datetime(client, arg);
+	case RS5C372_SETTIME:
+		return rs5c372_set_datetime(client, arg, 0);
+	case RS5C372_SETDATETIME:
+		return rs5c372_set_datetime(client, arg, 1);
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int rs5c372_rtc_open(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+
+static int rs5c372_rtc_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+static int rs5c372_rtc_ioctl(struct inode *inode, struct file *file,
+		   unsigned int cmd, unsigned long arg)
+{
+	unsigned long flags;
+	struct rtc_time wtime;
+	int status = 0;
+
+	switch (cmd) {
+	default:
+	case RTC_UIE_ON:
+	case RTC_UIE_OFF:
+	case RTC_PIE_ON:
+	case RTC_PIE_OFF:
+	case RTC_AIE_ON:
+	case RTC_AIE_OFF:
+	case RTC_ALM_SET:
+	case RTC_ALM_READ:
+	case RTC_IRQP_READ:
+	case RTC_IRQP_SET:
+	case RTC_EPOCH_SET:
+	case RTC_WKALM_SET:
+	case RTC_WKALM_RD:
+		status = -EINVAL;
+		break;
+	case RTC_EPOCH_READ:
+		return put_user(1970, (unsigned long *)arg);
+	case RTC_RD_TIME:
+		spin_lock_irqsave(&rs5c372_rtc_lock, flags);
+		rs5c372_command(rs5c372_i2c_client, RS5C372_GETDATETIME,
+				 &wtime);
+		spin_unlock_irqrestore(&rs5c372_rtc_lock, flags);
+		if (copy_to_user((void *)arg, &wtime, sizeof(struct rtc_time)))
+			status = -EFAULT;
+		break;
+
+	case RTC_SET_TIME:
+		if (!capable(CAP_SYS_TIME)) {
+			status = -EACCES;
+			break;
+		}
+
+		if (copy_from_user
+		    (&wtime, (struct rtc_time *)arg, sizeof(struct rtc_time))) {
+			status = -EFAULT;
+			break;
+		}
+
+		spin_lock_irqsave(&rs5c372_rtc_lock, flags);
+		rs5c372_command(rs5c372_i2c_client, RS5C372_SETDATETIME,
+				 &wtime);
+		spin_unlock_irqrestore(&rs5c372_rtc_lock, flags);
+		break;
+	}
+
+	return status;
+}
+
+static int rs5c372_k_set_rtc_time(void)
+{
+	struct rtc_time new_rtctm, old_rtctm;
+	unsigned long nowtime = xtime.tv_sec;
+
+	if (rs5c372_command
+	    (rs5c372_i2c_client, RS5C372_GETDATETIME, &old_rtctm))
+		return 0;
+
+	new_rtctm.tm_sec = nowtime % 60;
+	nowtime /= 60;
+	new_rtctm.tm_min = nowtime % 60;
+	nowtime /= 60;
+	new_rtctm.tm_hour = nowtime % 24;
+
+	if ((old_rtctm.tm_hour == 23 && old_rtctm.tm_min == 59) ||
+	    (new_rtctm.tm_hour == 23 && new_rtctm.tm_min == 59))
+		return 1;
+
+	return rs5c372_command(rs5c372_i2c_client, RS5C372_SETTIME,
+				&new_rtctm);
+}
+
+
+static int rs5c372_rtc_write_proc(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	// Perfoming reset to defaults
+	int len = 0;
+	unsigned char buf[RS5C372_RAM_SIZE+1];
+	memset(buf,0,RS5C372_RAM_SIZE+1);
+	rs5c372_setdefaults(buf);
+	rs5c372_write(buf,RS5C372_RAM_SIZE+1);
+	rs5c372_dump();
+	return len;
+}
+
+
+static __init int rs5c372_init(void)
+{
+	int retval = 0;
+	struct proc_dir_entry *res=NULL;
+	
+
+	normal_addr[0] = slave_address;
+	retval = i2c_add_driver(&rs5c372_driver);
+	if (retval == 0) {
+		res=create_proc_entry(PROC_RS5C372_NAME, 0, 0);
+		if (res) {
+			res->write_proc=rs5c372_rtc_write_proc;
+			res->data=NULL;
+		}
+		misc_register(&rs5c372_rtc_miscdev);
+		printk("I2C: rs5c372 RTC driver successfully loaded\n");
+//		rs5c372_dump();
+	}
+
+	return retval;
+}
+
+static __exit void rs5c372_exit(void)
+{
+	remove_proc_entry(PROC_RS5C372_NAME, NULL);
+	misc_deregister(&rs5c372_rtc_miscdev);
+	i2c_del_driver(&rs5c372_driver);
+
+}
+
+module_init(rs5c372_init);
+module_exit(rs5c372_exit);
+
+
+MODULE_PARM(slave_address, "i");
+MODULE_PARM_DESC(slave_address, "I2C slave address for RS5C372 RTC.");
+
+MODULE_AUTHOR("Pavel Mironchik pmironchik@optifacio.net");
+MODULE_LICENSE("GPL");

--=-=-=--

