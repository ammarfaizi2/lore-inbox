Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWJWSUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWJWSUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWJWSUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:20:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33704 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964915AbWJWSUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:20:41 -0400
Subject: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org, olpc-dev@laptop.org
Cc: davidz@redhat.com, greg@kroah.com, mjg59@srcf.ucam.org,
       len.brown@intel.com, sfr@canb.auug.org.au, benh@kernel.crashing.org
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Oct 2006 19:20:33 +0100
Message-Id: <1161627633.19446.387.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At git://git.infradead.org/battery-2.6.git there is an initial
implementation of a battery class, along with a driver which makes use
of it. The patch is below, and also viewable at 
http://git.infradead.org/?p=battery-2.6.git;a=commitdiff;h=master;hp=linus

I don't like the sysfs interaction much -- is it really necessary for me
to provide a separate function for each attribute, rather than a single
function which handles them all and is given the individual attribute as
an argument? That seems strange and bloated.

I'm half tempted to ditch the sysfs attributes and just use a single
seq_file, in fact.

The idea is that all batteries should be presented to userspace through
this class instead of through the existing mess of PMU/APM/ACPI and even
APM _emulation_.

I think I probably want to make AC power a separate 'device' too, rather
than an attribute of any given battery. And when there are multiple
power supplies, there should be multiple such devices. So maybe it
should be a 'power supply' class, not a battery class at all?

Comments? 


commit 42fe507a262b2a2879ca62740c5312778ae78627
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Mon Oct 23 18:14:54 2006 +0100

    [BATTERY] Add support for OLPC battery
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>

commit 6cbec3b84e3ce737b4217788841ea10a28a5e340
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Mon Oct 23 18:14:14 2006 +0100

    [BATTERY] Add initial implementation of battery class
    
    I really don't like the sysfs interaction, and I don't much like the
    internal interaction with the battery drivers either. In fact, there
    isn't much I _do_ like, but it's good enough as a straw man.
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- drivers/Makefile~	2006-10-19 19:51:32.000000000 +0100
+++ drivers/Makefile	2006-10-23 15:27:47.000000000 +0100
@@ -30,6 +30,7 @@ obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ mfd/ net/ media/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
+obj-$(CONFIG_BATTERY_CLASS)	+= battery/
 obj-$(CONFIG_PPC_PMAC)		+= macintosh/
 obj-$(CONFIG_XEN)		+= xen/
 obj-$(CONFIG_IDE)		+= ide/
--- drivers/Kconfig~	2006-09-20 04:42:06.000000000 +0100
+++ drivers/Kconfig	2006-10-23 15:27:42.000000000 +0100
@@ -28,6 +28,8 @@ source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
 
+source "drivers/battery/Kconfig"
+
 source "drivers/macintosh/Kconfig"
 
 source "drivers/net/Kconfig"
--- /dev/null	2006-10-01 17:20:05.827666723 +0100
+++ drivers/battery/Makefile	2006-10-23 16:53:20.000000000 +0100
@@ -0,0 +1,4 @@
+# Battery code
+obj-$(CONFIG_BATTERY_CLASS)		+= battery-class.o
+
+obj-$(CONFIG_OLPC_BATTERY)		+= olpc-battery.o
--- /dev/null	2006-10-01 17:20:05.827666723 +0100
+++ drivers/battery/Kconfig	2006-10-23 16:52:42.000000000 +0100
@@ -0,0 +1,22 @@
+
+menu "Battery support"
+
+config BATTERY_CLASS
+       tristate "Battery support"
+       help
+         Say Y to enable battery class support. This allows a battery
+	 information to be presented in a uniform manner for all types
+	 of batteries.
+
+	 Battery information from APM and ACPI is not yet available by
+	 this method, but should soon be. If you use APM or ACPI, say
+	 'N', although saying 'Y' would be harmless.
+
+config OLPC_BATTERY
+       tristate "One Laptop Per Child battery"
+       depends on BATTERY_CLASS && X86_32
+       help
+         Say Y to enable support for the battery on the $100 laptop.
+
+
+endmenu
--- /dev/null	2006-10-01 17:20:05.827666723 +0100
+++ drivers/battery/battery-class.c	2006-10-23 17:59:04.000000000 +0100
@@ -0,0 +1,286 @@
+/*
+ * Battery class core
+ *
+ *	© 2006 David Woodhouse <dwmw2@infradead.org>
+ *
+ * Based on LED Class support, by John Lenz and Richard Purdie:
+ *
+ *	© 2005 John Lenz <lenz@cs.wisc.edu>
+ *	© 2005-2006 Richard Purdie <rpurdie@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/battery.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+
+static struct class *battery_class;
+
+/* OMFG we can't just have a single 'show' routine which is given the
+   'class_attribute' as an argument -- we have to have 20-odd copies
+   of almost identical routines */
+
+static ssize_t battery_attribute_show_int(struct class_device *dev, char *buf, int attr)
+{
+        struct battery_classdev *battery_cdev = class_get_devdata(dev);
+        ssize_t ret = 0;
+	long value;
+
+	ret =  battery_cdev->query_long(battery_cdev, attr, &value);
+	if (ret)
+		return ret;
+
+	sprintf(buf, "%ld\n", value);
+        ret = strlen(buf) + 1;
+
+        return ret;
+}  
+
+static ssize_t battery_attribute_show_milli(struct class_device *dev, char *buf, int attr)
+{
+        struct battery_classdev *battery_cdev = class_get_devdata(dev);
+        ssize_t ret = 0;
+	long value;
+
+	ret = battery_cdev->query_long(battery_cdev, attr, &value);
+	if (ret)
+		return ret;
+
+	sprintf(buf, "%ld.%03ld\n", value/1000, value % 1000);
+        ret = strlen(buf) + 1;
+        return ret;
+}  
+
+static ssize_t battery_attribute_show_string(struct class_device *dev, char *buf, int attr)
+{
+        struct battery_classdev *battery_cdev = class_get_devdata(dev);
+        ssize_t ret = 0;
+
+	ret = battery_cdev->query_str(battery_cdev, attr, buf, PAGE_SIZE-1);
+	if (ret)
+		return ret;
+
+	strcat(buf, "\n");
+        ret = strlen(buf) + 1;
+        return ret;
+}  
+
+static ssize_t battery_attribute_show_status(struct class_device *dev, char *buf)
+{
+        struct battery_classdev *battery_cdev = class_get_devdata(dev);
+        ssize_t ret = 0;
+	unsigned long status;
+
+	status = battery_cdev->status(battery_cdev, ~BAT_STAT_AC);
+	if (status & BAT_STAT_ERROR)
+		return -EIO;
+
+	if (status & BAT_STAT_PRESENT)
+		sprintf(buf, "present");
+	else
+		sprintf(buf, "absent");
+
+	if (status & BAT_STAT_LOW)
+		strcat(buf, ",low");
+
+	if (status & BAT_STAT_FULL)
+		strcat(buf, ",full");
+
+	if (status & BAT_STAT_CHARGING)
+		strcat(buf, ",charging");
+
+	if (status & BAT_STAT_DISCHARGING)
+		strcat(buf, ",discharging");
+
+	if (status & BAT_STAT_OVERTEMP)
+		strcat(buf, ",overtemp");
+
+	if (status & BAT_STAT_FIRE)
+		strcat(buf, ",on-fire");
+
+	if (status & BAT_STAT_CHARGE_DONE)
+		strcat(buf, ",charge-done");
+
+	strcat(buf, "\n");
+        ret = strlen(buf) + 1;
+        return ret;
+}
+
+static ssize_t battery_attribute_show_ac_status(struct class_device *dev, char *buf)
+{
+        struct battery_classdev *battery_cdev = class_get_devdata(dev);
+        ssize_t ret = 0;
+	unsigned long status;
+
+	status = battery_cdev->status(battery_cdev, BAT_STAT_AC);
+	if (status & BAT_STAT_ERROR)
+		return -EIO;
+
+	if (status & BAT_STAT_AC)
+		sprintf(buf, "on-line");
+	else
+		sprintf(buf, "off-line");
+
+	strcat(buf, "\n");
+        ret = strlen(buf) + 1;
+        return ret;
+}  
+
+/* Ew. We can't even use CLASS_DEVICE_ATTR() if we want one named 'current' */
+#define BATTERY_DEVICE_ATTR(_name, _attr, _type) \
+static ssize_t battery_attr_show_##_attr(struct class_device *dev, char *buf)	\
+{										\
+	return battery_attribute_show_##_type(dev, buf, BAT_INFO_##_attr);	\
+}										\
+static struct class_device_attribute class_device_attr_##_attr  = {		\
+        .attr = { .name = _name, .mode = 0444, .owner = THIS_MODULE },		\
+	.show = battery_attr_show_##_attr };
+
+static CLASS_DEVICE_ATTR(status,0444,battery_attribute_show_status, NULL);
+static CLASS_DEVICE_ATTR(ac,0444,battery_attribute_show_ac_status, NULL);
+BATTERY_DEVICE_ATTR("temp1",TEMP1,milli);
+BATTERY_DEVICE_ATTR("temp1_name",TEMP1_NAME,string);
+BATTERY_DEVICE_ATTR("temp2",TEMP2,milli);
+BATTERY_DEVICE_ATTR("temp2_name",TEMP2_NAME,string);
+BATTERY_DEVICE_ATTR("voltage",VOLTAGE,milli);
+BATTERY_DEVICE_ATTR("voltage_design",VOLTAGE_DESIGN,milli);
+BATTERY_DEVICE_ATTR("current",CURRENT,milli);
+BATTERY_DEVICE_ATTR("charge_rate",CHARGE_RATE,milli);
+BATTERY_DEVICE_ATTR("charge_max",CHARGE_MAX,milli);
+BATTERY_DEVICE_ATTR("charge_last",CHARGE_LAST,milli);
+BATTERY_DEVICE_ATTR("charge_low",CHARGE_LOW,milli);
+BATTERY_DEVICE_ATTR("charge_warn",CHARGE_WARN,milli);
+BATTERY_DEVICE_ATTR("charge_unit",CHARGE_UNITS,string);
+BATTERY_DEVICE_ATTR("charge_percent",CHARGE_PCT,int);
+BATTERY_DEVICE_ATTR("time_remaining",TIME_REMAINING,int);
+BATTERY_DEVICE_ATTR("manufacturer",MANUFACTURER,string);
+BATTERY_DEVICE_ATTR("technology",TECHNOLOGY,string);
+BATTERY_DEVICE_ATTR("model",MODEL,string);
+BATTERY_DEVICE_ATTR("serial",SERIAL,string);
+BATTERY_DEVICE_ATTR("type",TYPE,string);
+BATTERY_DEVICE_ATTR("oem_info",OEM_INFO,string);
+
+#define REGISTER_ATTR(_attr)							\
+	if (battery_cdev->capabilities & (1<<BAT_INFO_##_attr))			\
+		class_device_create_file(battery_cdev->class_dev,		\
+					 &class_device_attr_##_attr);
+#define UNREGISTER_ATTR(_attr)							\
+	if (battery_cdev->capabilities & (1<<BAT_INFO_##_attr))			\
+		class_device_remove_file(battery_cdev->class_dev,		\
+					 &class_device_attr_##_attr);
+/**
+ * battery_classdev_register - register a new object of battery_classdev class.
+ * @dev: The device to register.
+ * @battery_cdev: the battery_classdev structure for this device.
+ */
+int battery_classdev_register(struct device *parent, struct battery_classdev *battery_cdev)
+{
+        battery_cdev->class_dev = class_device_create(battery_class, NULL, 0,
+						      parent, "%s", battery_cdev->name);
+
+        if (unlikely(IS_ERR(battery_cdev->class_dev)))
+                return PTR_ERR(battery_cdev->class_dev);
+
+        class_set_devdata(battery_cdev->class_dev, battery_cdev);
+
+        /* register the attributes */
+        class_device_create_file(battery_cdev->class_dev,
+                                &class_device_attr_status);
+
+        if (battery_cdev->status_cap & (1<<BAT_STAT_AC))
+		class_device_create_file(battery_cdev->class_dev, &class_device_attr_ac);
+
+	REGISTER_ATTR(TEMP1);
+	REGISTER_ATTR(TEMP1_NAME);
+	REGISTER_ATTR(TEMP2);
+	REGISTER_ATTR(TEMP2_NAME);
+	REGISTER_ATTR(VOLTAGE);
+	REGISTER_ATTR(VOLTAGE_DESIGN);
+	REGISTER_ATTR(CHARGE_PCT);
+	REGISTER_ATTR(CURRENT);
+	REGISTER_ATTR(CHARGE_RATE);
+	REGISTER_ATTR(CHARGE_MAX);
+	REGISTER_ATTR(CHARGE_LAST);
+	REGISTER_ATTR(CHARGE_LOW);
+	REGISTER_ATTR(CHARGE_WARN);
+	REGISTER_ATTR(CHARGE_UNITS);
+	REGISTER_ATTR(TIME_REMAINING);
+	REGISTER_ATTR(MANUFACTURER);
+	REGISTER_ATTR(TECHNOLOGY);
+	REGISTER_ATTR(MODEL);
+	REGISTER_ATTR(SERIAL);
+	REGISTER_ATTR(TYPE);
+	REGISTER_ATTR(OEM_INFO);
+
+        printk(KERN_INFO "Registered battery device: %s\n",
+                        battery_cdev->class_dev->class_id);
+
+        return 0;
+}
+EXPORT_SYMBOL_GPL(battery_classdev_register);
+
+/**
+ * battery_classdev_unregister - unregisters a object of battery_properties class.
+ * @battery_cdev: the battery device to unreigister
+ *
+ * Unregisters a previously registered via battery_classdev_register object.
+ */
+void battery_classdev_unregister(struct battery_classdev *battery_cdev)
+{
+        class_device_remove_file(battery_cdev->class_dev,
+				 &class_device_attr_status);
+
+        if (battery_cdev->status_cap & (1<<BAT_STAT_AC))
+		class_device_remove_file(battery_cdev->class_dev, &class_device_attr_ac);
+
+	UNREGISTER_ATTR(TEMP1);
+	UNREGISTER_ATTR(TEMP1_NAME);
+	UNREGISTER_ATTR(TEMP2);
+	UNREGISTER_ATTR(TEMP2_NAME);
+	UNREGISTER_ATTR(VOLTAGE);
+	UNREGISTER_ATTR(VOLTAGE_DESIGN);
+	UNREGISTER_ATTR(CHARGE_PCT);
+	UNREGISTER_ATTR(CURRENT);
+	UNREGISTER_ATTR(CHARGE_RATE);
+	UNREGISTER_ATTR(CHARGE_MAX);
+	UNREGISTER_ATTR(CHARGE_LAST);
+	UNREGISTER_ATTR(CHARGE_LOW);
+	UNREGISTER_ATTR(CHARGE_WARN);
+	UNREGISTER_ATTR(CHARGE_UNITS);
+	UNREGISTER_ATTR(TIME_REMAINING);
+	UNREGISTER_ATTR(MANUFACTURER);
+	UNREGISTER_ATTR(TECHNOLOGY);
+	UNREGISTER_ATTR(MODEL);
+	UNREGISTER_ATTR(SERIAL);
+	UNREGISTER_ATTR(TYPE);
+	UNREGISTER_ATTR(OEM_INFO);
+
+        class_device_unregister(battery_cdev->class_dev);
+}
+EXPORT_SYMBOL_GPL(battery_classdev_unregister);
+
+static int __init battery_init(void)
+{
+        battery_class = class_create(THIS_MODULE, "battery");
+        if (IS_ERR(battery_class))
+                return PTR_ERR(battery_class);
+        return 0;
+}
+
+static void __exit battery_exit(void)
+{
+        class_destroy(battery_class);
+}
+
+subsys_initcall(battery_init);
+module_exit(battery_exit);
+
+MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Battery class interface");
--- /dev/null	2006-10-01 17:20:05.827666723 +0100
+++ drivers/battery/olpc-battery.c	2006-10-23 17:56:38.000000000 +0100
@@ -0,0 +1,198 @@
+/*
+ * Battery driver for One Laptop Per Child ($100 laptop) board.
+ *
+ *	© 2006 David Woodhouse <dwmw2@infradead.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/battery.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <asm/io.h>
+
+#define wBAT_VOLTAGE		0xf900 /* *9.76/32,    mV */
+#define wBAT_CURRENT		0xf902 /* *15.625/120, mA */
+#define wBAT_TEMP		0xf906 /* *256/1000,   °C */
+#define wAMB_TEMP		0xf908 /* *256/1000,   °C */
+#define SOC			0xf910 /*      percentage */
+#define sMBAT_STATUS		0xfaa4
+#define		sBAT_PRESENT		1
+#define		sBAT_FULL		2
+#define		sBAT_DESTROY		4
+#define		sBAT_LOW			32
+#define		sBAT_DISCHG		64
+#define sMCHARGE_STATUS		0xfaa5
+#define		sBAT_CHARGE		1
+#define		sBAT_OVERTEMP		4
+#define		sBAT_NiMH		8
+#define sPOWER_FLAG		0xfa40
+#define		ADAPTER_IN		1
+
+static int lock_ec(void)
+{
+	unsigned long timeo = jiffies + HZ/20;
+
+	while (1) {
+                unsigned char lock = inb(0x6c) & 0x80;
+                if (!lock)
+                        return 0;
+		if (time_after(jiffies, timeo))
+			return 1;
+                yield();
+        }
+}
+
+static void unlock_ec(void)
+{
+        outb(0xff, 0x6c);
+}
+
+unsigned char read_ec_byte(unsigned short adr)
+{
+        outb(adr >> 8, 0x381);
+        outb(adr, 0x382);
+        return inb(0x383);
+}
+
+unsigned short read_ec_word(unsigned short adr)
+{
+        return (read_ec_byte(adr) << 8) | read_ec_byte(adr+1);
+}
+
+unsigned long olpc_bat_status(struct battery_classdev *cdev, unsigned long mask)
+{
+	unsigned long result = 0;
+	unsigned short tmp;
+
+	if (lock_ec()) {
+		printk(KERN_ERR "Failed to lock EC for battery access\n");
+		return BAT_STAT_ERROR;
+	}
+
+	if (mask & BAT_STAT_AC) {
+		if (read_ec_byte(sPOWER_FLAG) & ADAPTER_IN)
+			result |= BAT_STAT_AC;
+	}
+	if (mask & (BAT_STAT_PRESENT|BAT_STAT_FULL|BAT_STAT_FIRE|BAT_STAT_LOW|BAT_STAT_DISCHARGING)) {
+		tmp = read_ec_byte(sMBAT_STATUS);
+		
+		if (tmp & sBAT_PRESENT)
+			result |= BAT_STAT_PRESENT;
+		if (tmp & sBAT_FULL)
+			result |= BAT_STAT_FULL;
+		if (tmp & sBAT_DESTROY)
+			result |= BAT_STAT_FIRE;
+		if (tmp & sBAT_LOW)
+			result |= BAT_STAT_LOW;
+		if (tmp & sBAT_DISCHG)
+			result |= BAT_STAT_DISCHARGING;
+	}
+	if (mask & (BAT_STAT_CHARGING|BAT_STAT_OVERTEMP)) {
+		tmp = read_ec_byte(sMCHARGE_STATUS);
+		if (tmp & sBAT_CHARGE)
+			result |= BAT_STAT_CHARGING;
+		if (tmp & sBAT_OVERTEMP)
+			result |= BAT_STAT_OVERTEMP;
+	}
+	unlock_ec();
+	return result;
+}
+
+int olpc_bat_query_long(struct battery_classdev *dev, int attr, long *result)
+{
+	int ret = 0;
+
+	if (lock_ec())
+		return -EIO;
+
+	if (!(read_ec_byte(sMBAT_STATUS) & sBAT_PRESENT)) {
+		ret = -ENODEV;
+	} else if (attr == BAT_INFO_VOLTAGE) {
+		*result = read_ec_word(wBAT_VOLTAGE) * 9760 / 32000;
+	} else if (attr == BAT_INFO_CURRENT) {
+		*result = read_ec_word(wBAT_CURRENT) * 15625 / 120000;
+	} else if (attr == BAT_INFO_TEMP1) {
+		*result = read_ec_word(wBAT_TEMP) * 1000 / 256;
+	} else if (attr == BAT_INFO_TEMP2) {
+		*result = read_ec_word(wAMB_TEMP) * 1000 / 256;
+	} else if (attr == BAT_INFO_CHARGE_PCT) {
+		*result = read_ec_byte(SOC);
+	} else 
+		ret = -EINVAL;
+
+	unlock_ec();
+	return ret;
+}
+
+int olpc_bat_query_str(struct battery_classdev *dev, int attr, char *str, int len)
+{
+	int ret = 0;
+
+	if (attr == BAT_INFO_TYPE) {
+		snprintf(str, len, "OLPC");
+	} else if (attr == BAT_INFO_TEMP1_NAME) {
+		snprintf(str, len, "battery");
+	} else if (attr == BAT_INFO_TEMP2_NAME) {
+		snprintf(str, len, "ambient");
+	} else if (!(read_ec_byte(sMBAT_STATUS) & sBAT_PRESENT)) {
+		ret = -ENODEV;
+	} else if (attr == BAT_INFO_TECHNOLOGY) {
+		if (lock_ec())
+			ret = -EIO;
+		else {
+			unsigned short tmp = read_ec_byte(sMCHARGE_STATUS);
+			if (tmp & sBAT_NiMH)
+				snprintf(str, len, "NiMH");
+			else
+				snprintf(str, len, "unknown");
+		}
+		unlock_ec();
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static struct battery_classdev olpc_bat = {
+	.name = "OLPC",
+	.capabilities = (1<<BAT_INFO_VOLTAGE) |
+			(1<<BAT_INFO_CURRENT) |
+			(1<<BAT_INFO_TEMP1) |
+			(1<<BAT_INFO_TEMP2) |
+			(1<<BAT_INFO_CHARGE_PCT) |
+			(1<<BAT_INFO_TYPE) |
+			(1<<BAT_INFO_TECHNOLOGY) |
+			(1<<BAT_INFO_TEMP1_NAME) |
+			(1<<BAT_INFO_TEMP2_NAME),
+	.status_cap = BAT_STAT_AC | BAT_STAT_PRESENT | BAT_STAT_LOW | 
+		      BAT_STAT_FULL | BAT_STAT_CHARGING| BAT_STAT_DISCHARGING |
+		      BAT_STAT_OVERTEMP | BAT_STAT_FIRE,
+	.status = olpc_bat_status,
+	.query_long = olpc_bat_query_long,
+	.query_str = olpc_bat_query_str,
+};
+
+void __exit olpc_bat_exit(void)
+{
+	battery_classdev_unregister(&olpc_bat);
+}
+
+int __init olpc_bat_init(void)
+{
+	battery_classdev_register(NULL, &olpc_bat);
+	return 0;
+}
+
+module_init(olpc_bat_init);
+module_exit(olpc_bat_exit);
+
+MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Battery class interface");
--- /dev/null	2006-10-01 17:20:05.827666723 +0100
+++ include/linux/battery.h	2006-10-23 17:11:28.000000000 +0100
@@ -0,0 +1,84 @@
+/*
+ * Driver model for batteries
+ *
+ *	© 2006 David Woodhouse <dwmw2@infradead.org>
+ *
+ * Based on LED Class support, by John Lenz and Richard Purdie:
+ *
+ *	© 2005 John Lenz <lenz@cs.wisc.edu>
+ *	© 2005-2006 Richard Purdie <rpurdie@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __LINUX_BATTERY_H__
+#define __LINUX_BATTERY_H__
+
+struct device;
+struct class_device;
+
+/*
+ * Battery Core
+ */
+#define BAT_STAT_AC		(1<<0)
+#define BAT_STAT_PRESENT	(1<<1)
+#define BAT_STAT_LOW		(1<<2)
+#define BAT_STAT_FULL		(1<<3)
+#define BAT_STAT_CHARGING	(1<<4)
+#define BAT_STAT_DISCHARGING	(1<<5)
+#define BAT_STAT_OVERTEMP	(1<<6)
+#define BAT_STAT_FIRE		(1<<7)
+#define BAT_STAT_CHARGE_DONE	(1<<8)
+
+#define BAT_STAT_ERROR		(1<<31)
+
+#define BAT_INFO_TEMP1		(0) /* °C/1000 */
+#define BAT_INFO_TEMP1_NAME	(1) /* string */
+
+#define BAT_INFO_TEMP2		(2) /* °C/1000 */
+#define BAT_INFO_TEMP2_NAME	(3) /* string */
+
+#define BAT_INFO_VOLTAGE	(4) /* mV */
+#define BAT_INFO_VOLTAGE_DESIGN	(5) /* mV */
+
+#define BAT_INFO_CURRENT	(6) /* mA */
+
+#define BAT_INFO_CHARGE_RATE	(7) /* BAT_INFO_CHARGE_UNITS */
+#define BAT_INFO_CHARGE		(8) /* BAT_INFO_CHARGE_UNITS */
+#define BAT_INFO_CHARGE_MAX	(9) /* BAT_INFO_CHARGE_UNITS  */
+#define BAT_INFO_CHARGE_LAST	(10) /* BAT_INFO_CHARGE_UNITS  */
+#define BAT_INFO_CHARGE_LOW	(11) /* BAT_INFO_CHARGE_UNITS  */
+#define BAT_INFO_CHARGE_WARN	(12) /* BAT_INFO_CHARGE_UNITS  */
+#define BAT_INFO_CHARGE_UNITS	(13) /* string */
+#define BAT_INFO_CHARGE_PCT	(14) /* % */
+
+#define BAT_INFO_TIME_REMAINING	(15) /* seconds */
+
+#define BAT_INFO_MANUFACTURER	(16) /* string */
+#define BAT_INFO_TECHNOLOGY	(17) /* string */
+#define BAT_INFO_MODEL		(18) /* string */
+#define BAT_INFO_SERIAL		(19) /* string */
+#define BAT_INFO_TYPE		(20) /* string */
+#define BAT_INFO_OEM_INFO	(21) /* string */
+
+struct battery_classdev {
+	const char		*name;
+	/* Capabilities of this battery driver */
+	unsigned long		 capabilities, status_cap;
+
+	/* Query functions */
+	unsigned long		(*status)(struct battery_classdev *, unsigned long mask);
+	int			(*query_long)(struct battery_classdev *, int attr, long *result);
+	int			(*query_str)(struct battery_classdev *, int attr, char *str, ssize_t len);
+
+	struct class_device	*class_dev;
+	struct list_head	 node;	/* Battery Device list */
+};
+
+extern int battery_classdev_register(struct device *parent,
+				     struct battery_classdev *battery_cdev);
+extern void battery_classdev_unregister(struct battery_classdev *battery_cdev);
+
+#endif /* __LINUX_BATTERY_H__ */


-- 
dwmw2

