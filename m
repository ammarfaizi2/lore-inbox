Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVBXGXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVBXGXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVBXGWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:22:39 -0500
Received: from smtp819.mail.sc5.yahoo.com ([66.163.170.5]:59310 "HELO
	smtp819.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261849AbVBXGOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:14:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] I8K - convert to platform device (sysfs)
Date: Thu, 24 Feb 2005 01:14:44 -0500
User-Agent: KMail/1.7.2
Cc: Massimo Dal Zotto <dz@debian.org>
References: <200502240110.16521.dtor_core@ameritech.net> <200502240112.56523.dtor_core@ameritech.net> <200502240114.04067.dtor_core@ameritech.net>
In-Reply-To: <200502240114.04067.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502240114.44662.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 i8k.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 117 insertions(+)

Index: dtor/drivers/char/i8k.c
===================================================================
--- dtor.orig/drivers/char/i8k.c
+++ dtor/drivers/char/i8k.c
@@ -22,6 +22,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/dmi.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -87,6 +88,13 @@ static struct file_operations i8k_fops =
 	.ioctl		= i8k_ioctl,
 };
 
+static struct device_driver i8k_driver = {
+	.name		= "i8k",
+	.bus		= &platform_bus_type,
+};
+
+static struct platform_device *i8k_device;
+ 
 struct smm_regs {
 	unsigned int eax;
 	unsigned int ebx __attribute__ ((packed));
@@ -406,6 +414,89 @@ static int i8k_open_fs(struct inode *ino
 	return single_open(file, i8k_proc_show, NULL);
 }
 
+static ssize_t i8k_sysfs_cpu_temp_show(struct device *dev, char *buf)
+{
+	int temp = i8k_get_cpu_temp();
+
+	return temp < 0 ? -EIO : sprintf(buf, "%d\n", temp);
+}
+
+static ssize_t i8k_sysfs_fan1_show(struct device *dev, char *buf)
+{
+	int status = i8k_get_fan_status(0);
+	return status < 0 ? -EIO : sprintf(buf, "%d\n", status);
+}
+
+static ssize_t i8k_sysfs_fan1_set(struct device *dev, const char *buf, size_t count)
+{
+	unsigned long state;
+	char *rest;
+
+	if (restricted && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	state = simple_strtoul(buf, &rest, 10);
+	if (*rest || state > I8K_FAN_MAX)
+		return -EINVAL;
+
+	if (i8k_set_fan(0, state) < 0)
+		return -EIO;
+
+	return count;
+}
+
+static ssize_t i8k_sysfs_fan2_show(struct device *dev, char *buf)
+{
+	int status = i8k_get_fan_status(1);
+	return status < 0 ? -EIO : sprintf(buf, "%d\n", status);
+}
+
+static ssize_t i8k_sysfs_fan2_set(struct device *dev, const char *buf, size_t count)
+{
+	unsigned long state;
+	char *rest;
+
+	if (restricted && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	state = simple_strtoul(buf, &rest, 10);
+	if (*rest || state > I8K_FAN_MAX)
+		return -EINVAL;
+
+	if (i8k_set_fan(1, state) < 0)
+		return -EIO;
+
+	return count;
+}
+
+static ssize_t i8k_sysfs_fan1_speed_show(struct device *dev, char *buf)
+{
+	int speed = i8k_get_fan_speed(0);
+	return speed < 0 ? -EIO : sprintf(buf, "%d\n", speed);
+}
+
+static ssize_t i8k_sysfs_fan2_speed_show(struct device *dev, char *buf)
+{
+	int speed = i8k_get_fan_speed(1);
+	return speed < 0 ? -EIO : sprintf(buf, "%d\n", speed);
+}
+
+static ssize_t i8k_sysfs_power_status_show(struct device *dev, char *buf)
+{
+	int status = power_status ? i8k_get_power_status() : -1;
+	return status < 0 ? -EIO : sprintf(buf, "%d\n", status);
+}
+
+static struct device_attribute i8k_device_attrs[] = {
+	__ATTR(cpu_temp, 0444, i8k_sysfs_cpu_temp_show, NULL),
+	__ATTR(fan1_state, 0644, i8k_sysfs_fan1_show, i8k_sysfs_fan1_set),
+	__ATTR(fan2_state, 0644, i8k_sysfs_fan2_show, i8k_sysfs_fan2_set),
+	__ATTR(fan1_speed, 0444, i8k_sysfs_fan1_speed_show, NULL),
+	__ATTR(fan2_speed, 0444, i8k_sysfs_fan2_speed_show, NULL),
+	__ATTR(power_status, 0444, i8k_sysfs_power_status_show, NULL),
+	__ATTR_NULL
+};
+
 static struct dmi_system_id __initdata i8k_dmi_table[] = {
 	{
 		.ident = "Dell Inspiron",
@@ -490,6 +581,7 @@ static int __init i8k_probe(void)
 static int __init i8k_init(void)
 {
 	struct proc_dir_entry *proc_i8k;
+	int err, i;
 
 	/* Are we running on an supported laptop? */
 	if (i8k_probe())
@@ -503,15 +595,40 @@ static int __init i8k_init(void)
 	proc_i8k->proc_fops = &i8k_fops;
 	proc_i8k->owner = THIS_MODULE;
 
+	err = driver_register(&i8k_driver);
+	if (err)
+		goto fail1;
+
+	i8k_device = platform_device_register_simple("i8k", -1, NULL, 0);
+	if (IS_ERR(i8k_device)) {
+		err = PTR_ERR(i8k_device);
+		goto fail2;
+	}
+
+	for (i = 0; attr_name(i8k_device_attrs[i]); i++) {
+		err = device_create_file(&i8k_device->dev, &i8k_device_attrs[i]);
+		if (err)
+			goto fail3;
+	}
+
 	printk(KERN_INFO
 	       "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
 	       I8K_VERSION);
 
 	return 0;
+
+fail3:	while (--i >= 0)
+		device_remove_file(&i8k_device->dev, &i8k_device_attrs[i]);
+	platform_device_unregister(i8k_device);
+fail2:	driver_unregister(&i8k_driver);
+fail1:	remove_proc_entry("i8k", NULL);
+	return err;
 }
 
 static void __exit i8k_exit(void)
 {
+	platform_device_unregister(i8k_device);
+	driver_unregister(&i8k_driver);
 	remove_proc_entry("i8k", NULL);
 }
 
