Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVCPVto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVCPVto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVCPVtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:49:02 -0500
Received: from www.tuxrocks.com ([64.62.190.123]:26628 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S262822AbVCPVi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:38:58 -0500
Message-ID: <4238A76A.3040408@tuxrocks.com>
Date: Wed, 16 Mar 2005 14:38:50 -0700
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Sorenson <frank@tuxrocks.com>
CC: Dmitry Torokhov <dtor_core@ameritech.net>,
       LKML <linux-kernel@vger.kernel.org>, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 0/5] I8K driver facelift
References: <200502240110.16521.dtor_core@ameritech.net> <4233B65A.4030302@tuxrocks.com>
In-Reply-To: <4233B65A.4030302@tuxrocks.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I replaced the sysfs_ops with ops of my own, and now all the show
and store functions also accept the name of the attribute as a parameter.
This lets the functions know what attribute is being accessed, and allows
us to create attributes that share show and store functions, so things
don't need to be defined at compile time (I feel slightly evil!).

This patch puts the correct number of temp sensors and fans into sysfs,
and only exposes power_status if enabled by the power_status module
parameter.

This patch applies on top of Dmitry Torokov's patches.  Comments welcome!

Thanks,
Frank

Signed-off-by: Frank Sorenson <frank@tuxrocks.com>

--- 2.6.11-a/drivers/char/i8k.c	2005-03-12 18:47:55.000000000 -0700
+++ 2.6.11-b/drivers/char/i8k.c	2005-03-16 14:23:40.000000000 -0700
@@ -23,12 +23,14 @@
 #include <linux/seq_file.h>
 #include <linux/dmi.h>
 #include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
 #include <linux/i8k.h>
 
-#define I8K_VERSION		"1.14 21/02/2005"
+#define I8K_VERSION		"2005-03-16"
 
 #define I8K_SMM_FN_STATUS	0x0025
 #define I8K_SMM_POWER_STATUS	0x0069
@@ -36,7 +38,8 @@
 #define I8K_SMM_GET_FAN		0x00a3
 #define I8K_SMM_GET_SPEED	0x02a3
 #define I8K_SMM_GET_TEMP	0x10a3
-#define I8K_SMM_GET_DELL_SIG	0xffa3
+#define I8K_SMM_GET_DELL_SIG1	0xfea3
+#define I8K_SMM_GET_DELL_SIG2	0xffa3
 #define I8K_SMM_BIOS_VERSION	0x00a6
 
 #define I8K_FAN_MULT		30
@@ -54,7 +57,12 @@
 
 #define I8K_TEMPERATURE_BUG	1
 
+#define to_dev(d) container_of(d, struct device, kobj)
+#define to_dev_attr(_attr) container_of(_attr,struct device_attribute,attr)
+
 static char bios_version[4];
+static int num_temps = 0;
+static int num_fans = 0;
 
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
 MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
@@ -80,6 +88,8 @@
 static int i8k_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long);
 
+static struct kobj_type *backup_ktype;
+
 static struct file_operations i8k_fops = {
 	.open		= i8k_open_fs,
 	.read		= seq_read,
@@ -94,7 +104,7 @@
 };
 
 static struct platform_device *i8k_device;
- 
+
 struct smm_regs {
 	unsigned int eax;
 	unsigned int ebx __attribute__ ((packed));
@@ -156,7 +166,7 @@
 {
 	struct smm_regs regs = { .eax = I8K_SMM_BIOS_VERSION, };
 
-	return i8k_smm(&regs) < 0 ? : regs.eax;
+	return i8k_smm(&regs) ? : regs.eax;
 }
 
 /*
@@ -201,10 +211,10 @@
  */
 static int i8k_get_fan_status(int fan)
 {
-	struct smm_regs regs = { .eax = I8K_SMM_GET_FAN, };
+	struct smm_regs regs = { .eax = I8K_SMM_GET_FAN, .ebx = (fan & 0xff)};
 
 	regs.ebx = fan & 0xff;
-	return i8k_smm(&regs) < 0 ? : regs.eax & 0xff;
+	return i8k_smm(&regs) ? : regs.eax & 0xff;
 }
 
 /*
@@ -215,7 +225,7 @@
 	struct smm_regs regs = { .eax = I8K_SMM_GET_SPEED, };
 
 	regs.ebx = fan & 0xff;
-	return i8k_smm(&regs) < 0 ? : (regs.eax & 0xffff) * I8K_FAN_MULT;
+	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * I8K_FAN_MULT;
 }
 
 /*
@@ -228,15 +238,15 @@
 	speed = (speed < 0) ? 0 : ((speed > I8K_FAN_MAX) ? I8K_FAN_MAX : speed);
 	regs.ebx = (fan & 0xff) | (speed << 8);
 
-	return i8k_smm(&regs) < 0 ? : i8k_get_fan_status(fan);
+	return i8k_smm(&regs) ? : i8k_get_fan_status(fan);
 }
 
 /*
  * Read the cpu temperature.
  */
-static int i8k_get_cpu_temp(void)
+static int i8k_get_temp(int sensor)
 {
-	struct smm_regs regs = { .eax = I8K_SMM_GET_TEMP, };
+	struct smm_regs regs = { .eax = I8K_SMM_GET_TEMP, .ebx = sensor };
 	int rc;
 	int temp;
 
@@ -268,9 +278,14 @@
 	return temp;
 }
 
-static int i8k_get_dell_signature(void)
+static int i8k_get_cpu_temp(void)
 {
-	struct smm_regs regs = { .eax = I8K_SMM_GET_DELL_SIG, };
+	return i8k_get_temp(0);
+}
+
+static int i8k_get_dell_sig_aux(int fn)
+{
+	struct smm_regs regs = { .eax = fn, };
 	int rc;
 
 	if ((rc = i8k_smm(&regs)) < 0)
@@ -279,6 +294,17 @@
 	return regs.eax == 1145651527 && regs.edx == 1145392204 ? 0 : -1;
 }
 
+static int i8k_get_dell_signature(void)
+{
+	int rc;
+
+	if (((rc=i8k_get_dell_sig_aux(I8K_SMM_GET_DELL_SIG1)) < 0) &&
+	    ((rc=i8k_get_dell_sig_aux(I8K_SMM_GET_DELL_SIG2)) < 0)) {
+		return rc;
+	}
+	return 0;
+}
+
 static int i8k_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
 		     unsigned long arg)
 {
@@ -414,87 +440,112 @@
 	return single_open(file, i8k_proc_show, NULL);
 }
 
-static ssize_t i8k_sysfs_cpu_temp_show(struct device *dev, char *buf)
+static ssize_t i8k_sysfs_cpu_temp_show(struct device *dev, char *buf,
+				       const char *name)
 {
 	int temp = i8k_get_cpu_temp();
 
 	return temp < 0 ? -EIO : sprintf(buf, "%d\n", temp);
 }
 
-static ssize_t i8k_sysfs_fan1_show(struct device *dev, char *buf)
+static ssize_t i8k_sysfs_temp_show(struct device *dev, char *buf,
+				   const char *name)
 {
-	int status = i8k_get_fan_status(0);
-	return status < 0 ? -EIO : sprintf(buf, "%d\n", status);
-}
-
-static ssize_t i8k_sysfs_fan1_set(struct device *dev, const char *buf, size_t count)
-{
-	unsigned long state;
+	unsigned long temp_num;
+	int temp;
 	char *rest;
 
-	if (restricted && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	state = simple_strtoul(buf, &rest, 10);
-	if (*rest || state > I8K_FAN_MAX)
-		return -EINVAL;
+	temp_num = simple_strtoul(name + 4, &rest, 10);
+	temp = i8k_get_temp(temp_num - 1);
 
-	if (i8k_set_fan(0, state) < 0)
-		return -EIO;
-
-	return count;
+	return temp < 0 ? -EIO : sprintf(buf, "%d\n", temp);
 }
 
-static ssize_t i8k_sysfs_fan2_show(struct device *dev, char *buf)
+static ssize_t i8k_sysfs_fan_show(struct device *dev, char *buf,
+				  const char *name)
 {
-	int status = i8k_get_fan_status(1);
+	unsigned long fan_num;
+	int status;
+	char *rest;
+
+	fan_num = simple_strtoul(name + 3, &rest, 10);
+	status = i8k_get_fan_status(fan_num - 1);
 	return status < 0 ? -EIO : sprintf(buf, "%d\n", status);
 }
 
-static ssize_t i8k_sysfs_fan2_set(struct device *dev, const char *buf, size_t count)
+static ssize_t i8k_sysfs_fan_set(struct device *dev, const char *buf,
+				 size_t count, const char *name)
 {
+	unsigned long fan_num;
 	unsigned long state;
 	char *rest;
 
 	if (restricted && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	fan_num = simple_strtoul(name + 3, &rest, 10);
+
 	state = simple_strtoul(buf, &rest, 10);
 	if (*rest || state > I8K_FAN_MAX)
 		return -EINVAL;
 
-	if (i8k_set_fan(1, state) < 0)
+	if (i8k_set_fan(fan_num - 1, state) < 0)
 		return -EIO;
 
 	return count;
 }
 
-static ssize_t i8k_sysfs_fan1_speed_show(struct device *dev, char *buf)
+static ssize_t i8k_sysfs_fan_speed_show(struct device *dev, char *buf,
+					const char *name)
 {
-	int speed = i8k_get_fan_speed(0);
-	return speed < 0 ? -EIO : sprintf(buf, "%d\n", speed);
-}
+	unsigned long fan_num;
+	char *rest;
+	int speed;
 
-static ssize_t i8k_sysfs_fan2_speed_show(struct device *dev, char *buf)
-{
-	int speed = i8k_get_fan_speed(1);
+	fan_num = simple_strtoul(name + 3, &rest, 10);
+	speed = i8k_get_fan_speed(fan_num - 1);
 	return speed < 0 ? -EIO : sprintf(buf, "%d\n", speed);
 }
 
-static ssize_t i8k_sysfs_power_status_show(struct device *dev, char *buf)
+static ssize_t i8k_sysfs_power_status_show(struct device *dev, char *buf,
+					   char *name)
 {
 	int status = power_status ? i8k_get_power_status() : -1;
 	return status < 0 ? -EIO : sprintf(buf, "%d\n", status);
 }
 
-static struct device_attribute i8k_device_attrs[] = {
-	__ATTR(cpu_temp, 0444, i8k_sysfs_cpu_temp_show, NULL),
-	__ATTR(fan1_state, 0644, i8k_sysfs_fan1_show, i8k_sysfs_fan1_set),
-	__ATTR(fan2_state, 0644, i8k_sysfs_fan2_show, i8k_sysfs_fan2_set),
-	__ATTR(fan1_speed, 0444, i8k_sysfs_fan1_speed_show, NULL),
-	__ATTR(fan2_speed, 0444, i8k_sysfs_fan2_speed_show, NULL),
-	__ATTR(power_status, 0444, i8k_sysfs_power_status_show, NULL),
-	__ATTR_NULL
+static ssize_t i8k_sysfs_show(struct kobject *kobj, struct attribute *attr,
+			      char * buf)
+{
+	struct device_attribute * dev_attr = to_dev_attr(attr);
+	struct device * dev = to_dev(kobj);
+	int (*func3)(struct device *, char *, char *);
+
+	if (dev_attr->show) {
+		func3 = dev_attr->show;
+		return (*func3)(dev, buf, dev_attr->attr.name);
+	}
+	return -EINVAL;
+}
+
+static ssize_t i8k_sysfs_store(struct kobject *kobj, struct attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct device_attribute * dev_attr = to_dev_attr(attr);
+	struct device * dev = to_dev(kobj);
+	int (*func4)(struct device *, const char *, size_t, char *);
+
+	if (dev_attr->store)
+	{
+		func4 = dev_attr->store;
+		return (*func4)(dev, buf, count, dev_attr->attr.name);
+	}
+	return -EINVAL;
+}
+
+static struct sysfs_ops i8k_sysfs_ops = {
+	.show		= i8k_sysfs_show,
+	.store		= i8k_sysfs_store,
 };
 
 static struct dmi_system_id __initdata i8k_dmi_table[] = {
@@ -506,6 +557,13 @@
 		},
 	},
 	{
+		.ident = "Dell Inspiron",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+		},
+	},
+	{
 		.ident = "Dell Latitude",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer"),
@@ -578,6 +636,105 @@
 	return 0;
 }
 
+static int sysfs_add_generic(char *dev_name, int mode, void *show, void *store)
+{
+	char *name;
+	struct device_attribute *attr;
+	int err;
+
+	name = kmalloc(strlen(dev_name) + 1, GFP_KERNEL);
+	if (name == NULL)
+		return -ENOMEM;
+	strncpy(name, dev_name, strlen(dev_name));
+	name[strlen(dev_name)] = '\0';
+	attr = kmalloc(sizeof *attr, GFP_KERNEL);
+	if (attr == NULL)
+		return -ENOMEM;
+	*attr =  ((struct device_attribute) {
+		.attr = {
+			.name = name,
+			.mode = mode,
+		},
+		.show = show,
+		.store = store,
+	});
+	err = device_create_file(&i8k_device->dev, attr);
+	if (err)
+	{
+		device_remove_file(&i8k_device->dev, attr);
+		kfree(attr);
+		kfree(name);
+		return -1;
+	}
+	return 0;
+}
+
+static int sysfs_add_temp(int temp_num)
+{
+	char temp_name[30];
+
+	sprintf(temp_name, "temp%d", temp_num + 1);
+	return sysfs_add_generic(temp_name, 0444, i8k_sysfs_temp_show, NULL);
+}
+
+static int sysfs_add_fan(int fan_num)
+{
+	char fan_state_name[30];
+	char fan_speed_name[30];
+
+	sprintf(fan_state_name, "fan%d_state", fan_num + 1);
+	sprintf(fan_speed_name, "fan%d_speed", fan_num + 1);
+
+	sysfs_add_generic(fan_state_name, 0644,
+			  i8k_sysfs_fan_show, i8k_sysfs_fan_set);
+	sysfs_add_generic(fan_speed_name, 0444,
+			  i8k_sysfs_fan_speed_show, NULL);
+	return 0;
+}
+
+static int i8k_redirect_sysfs_ops(void)
+{
+	struct device *dev;
+	struct kobject *kobj;
+	struct kobj_type *ktype;
+	struct kobj_type *temp_ktype;
+	struct kset *kset;
+
+	dev = &i8k_device->dev;
+	kobj = &dev->kobj;
+	kset = kobj->kset;
+	ktype = kset->ktype;
+
+	temp_ktype = kmalloc(sizeof *temp_ktype, GFP_KERNEL);
+
+	temp_ktype->release = ktype->release;
+	temp_ktype->sysfs_ops = &i8k_sysfs_ops;
+	temp_ktype->default_attrs = ktype->default_attrs;
+
+	backup_ktype = ktype;
+	kset->ktype = temp_ktype;
+
+	return 0;
+}
+
+static int i8k_restore_sysfs_ops(void)
+{
+	struct device *dev;
+	struct kobject *kobj;
+	struct kset *kset;
+	struct kobj_type *temp_ktype;
+
+	dev = &i8k_device->dev;
+	kobj = &dev->kobj;
+	kset = kobj->kset;
+	temp_ktype = kset->ktype;
+
+	kset->ktype = backup_ktype;
+	kfree(temp_ktype);
+
+	return 0;
+}
+
 static int __init i8k_init(void)
 {
 	struct proc_dir_entry *proc_i8k;
@@ -587,6 +744,11 @@
 	if (i8k_probe())
 		return -ENODEV;
 
+	while (i8k_get_temp(num_temps) >= 0) num_temps ++;
+	printk(KERN_INFO "i8k: found %d temperature sensors\n", num_temps);
+	while (i8k_get_fan_status(num_fans) >= 0) num_fans ++;
+	printk(KERN_INFO "i8k: found %d fans\n", num_fans);
+
 	/* Register the proc entry */
 	proc_i8k = create_proc_entry("i8k", 0, NULL);
 	if (!proc_i8k)
@@ -605,21 +767,31 @@
 		goto fail2;
 	}
 
-	for (i = 0; attr_name(i8k_device_attrs[i]); i++) {
-		err = device_create_file(&i8k_device->dev, &i8k_device_attrs[i]);
+	i8k_redirect_sysfs_ops();
+
+	/* register the temp sensors */
+	for (i = 0; i < num_temps; i++) {
+		err = sysfs_add_temp(i);
+		if (err)
+			goto fail2;
+	}
+
+	/* register the fans */
+	for (i = 0; i < num_fans; i++) {
+		err = sysfs_add_fan(i);
 		if (err)
-			goto fail3;
+			goto fail2;
 	}
+	sysfs_add_generic("cpu_temp", 0444, i8k_sysfs_cpu_temp_show, NULL);
+	if (power_status)
+		sysfs_add_generic("power_status", 0444,
+				  i8k_sysfs_power_status_show, NULL);
 
 	printk(KERN_INFO
 	       "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
 	       I8K_VERSION);
 
 	return 0;
-
-fail3:	while (--i >= 0)
-		device_remove_file(&i8k_device->dev, &i8k_device_attrs[i]);
-	platform_device_unregister(i8k_device);
 fail2:	driver_unregister(&i8k_driver);
 fail1:	remove_proc_entry("i8k", NULL);
 	return err;
@@ -627,6 +799,7 @@
 
 static void __exit i8k_exit(void)
 {
+	i8k_restore_sysfs_ops();
 	platform_device_unregister(i8k_device);
 	driver_unregister(&i8k_driver);
 	remove_proc_entry("i8k", NULL);
