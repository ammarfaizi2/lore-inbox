Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbVEGNXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbVEGNXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVEGNXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:23:46 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:58387 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263109AbVEGNVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:21:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=i9RupXkS82zOMpK5IzmY9S5s6X8jfJ6/sMNSMHfCwA4UJuNArpsim67/JVAYHVQf3t1YLAKvZbBJb1EmFjKnQqA1kkBYmbQhkOP3wXynQnS+8/3HcncFraKLyd2kEewPbJtL3Ab+4N7T7DZd7KvhaPrGySsSmdtkHMNgUAtWkaw=
Message-ID: <253818670505070621784dbd63@mail.gmail.com>
Date: Sat, 7 May 2005 09:21:34 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6.12-rc4 1/3] dynamic sysfs callbacks
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Jean Delvare <khali@linux-fr.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_415_17942695.1115472094280"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_415_17942695.1115472094280
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This patch against 2.6.12-rc4 adds a void * field to the base sysfs
attribute, and updates all the derived attributes (device_attribute,
etc) to pass the void * to their sysfs callbacks. This facilitates a
number of things:

- reduce the size of much of the sysfs attribute code significantly by
allowing the replacement of the large number of macro generated
virtually identical sysfs callbacks with a single sysfs callback that
uses the void * parameter to decide what to do. For example, adapting
adm1026 to take advantage of this patch:

-------------------2.6.11.7--------------------
Module                  Size  Used by
adm1026                44692  0
--------2.6.12-rc3-devdyncallback-----
Module                  Size  Used by
adm1026                33172  0

(see http://archives.andrew.net.au/lm-sensors/msg31310.html)

- allow the creation of a non-predetermined and potentially unlimited
number of sysfs attributes, this is required by bmcsensors - a driver
I am porting from lm_sensors 2.4 to 2.6.

(see http://archives.andrew.net.au/lm-sensors/msg31225.html ,
http://bmcsensors-26.sourceforge.net/)

This first patch changes the core sysfs attribute and derived attributes.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

------=_Part_415_17942695.1115472094280
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc4-sysfsdyncallback-core.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc4-sysfsdyncallback-core.diff"

diff -uprN -X dontdiff linux-2.6.12-rc4/drivers/base/bus.c linux-2.6.12-rc4-sysfsdyncallback-core/drivers/base/bus.c
--- linux-2.6.12-rc4/drivers/base/bus.c	2005-05-07 03:37:15.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/drivers/base/bus.c	2005-05-07 04:31:56.000000000 -0400
@@ -39,7 +39,7 @@ drv_attr_show(struct kobject * kobj, str
 	ssize_t ret = 0;
 
 	if (drv_attr->show)
-		ret = drv_attr->show(drv, buf);
+		ret = drv_attr->show(drv, buf, attr->data);
 	return ret;
 }
 
@@ -52,7 +52,7 @@ drv_attr_store(struct kobject * kobj, st
 	ssize_t ret = 0;
 
 	if (drv_attr->store)
-		ret = drv_attr->store(drv, buf, count);
+		ret = drv_attr->store(drv, buf, count, attr->data);
 	return ret;
 }
 
@@ -87,7 +87,7 @@ bus_attr_show(struct kobject * kobj, str
 	ssize_t ret = 0;
 
 	if (bus_attr->show)
-		ret = bus_attr->show(bus, buf);
+		ret = bus_attr->show(bus, buf, attr->data);
 	return ret;
 }
 
@@ -100,7 +100,7 @@ bus_attr_store(struct kobject * kobj, st
 	ssize_t ret = 0;
 
 	if (bus_attr->store)
-		ret = bus_attr->store(bus, buf, count);
+		ret = bus_attr->store(bus, buf, count, attr->data);
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc4/drivers/base/class.c linux-2.6.12-rc4-sysfsdyncallback-core/drivers/base/class.c
--- linux-2.6.12-rc4/drivers/base/class.c	2005-05-07 03:37:15.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/drivers/base/class.c	2005-05-07 04:31:56.000000000 -0400
@@ -29,7 +29,7 @@ class_attr_show(struct kobject * kobj, s
 	ssize_t ret = 0;
 
 	if (class_attr->show)
-		ret = class_attr->show(dc, buf);
+		ret = class_attr->show(dc, buf, attr->data);
 	return ret;
 }
 
@@ -42,7 +42,7 @@ class_attr_store(struct kobject * kobj, 
 	ssize_t ret = 0;
 
 	if (class_attr->store)
-		ret = class_attr->store(dc, buf, count);
+		ret = class_attr->store(dc, buf, count, attr->data);
 	return ret;
 }
 
@@ -206,7 +206,7 @@ class_device_attr_show(struct kobject * 
 	ssize_t ret = 0;
 
 	if (class_dev_attr->show)
-		ret = class_dev_attr->show(cd, buf);
+		ret = class_dev_attr->show(cd, buf, attr->data);
 	return ret;
 }
 
@@ -219,7 +219,7 @@ class_device_attr_store(struct kobject *
 	ssize_t ret = 0;
 
 	if (class_dev_attr->store)
-		ret = class_dev_attr->store(cd, buf, count);
+		ret = class_dev_attr->store(cd, buf, count, attr->data);
 	return ret;
 }
 
@@ -371,7 +371,7 @@ static void class_device_remove_attrs(st
 	}
 }
 
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
+static ssize_t show_dev(struct class_device *class_dev, char *buf, void *data)
 {
 	return print_dev_t(buf, class_dev->devt);
 }
diff -uprN -X dontdiff linux-2.6.12-rc4/drivers/base/core.c linux-2.6.12-rc4-sysfsdyncallback-core/drivers/base/core.c
--- linux-2.6.12-rc4/drivers/base/core.c	2005-05-07 03:37:15.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/drivers/base/core.c	2005-05-07 04:31:56.000000000 -0400
@@ -41,7 +41,7 @@ dev_attr_show(struct kobject * kobj, str
 	ssize_t ret = 0;
 
 	if (dev_attr->show)
-		ret = dev_attr->show(dev, buf);
+		ret = dev_attr->show(dev, buf, attr->data);
 	return ret;
 }
 
@@ -54,7 +54,7 @@ dev_attr_store(struct kobject * kobj, st
 	ssize_t ret = 0;
 
 	if (dev_attr->store)
-		ret = dev_attr->store(dev, buf, count);
+		ret = dev_attr->store(dev, buf, count, attr->data);
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc4/drivers/base/sys.c linux-2.6.12-rc4-sysfsdyncallback-core/drivers/base/sys.c
--- linux-2.6.12-rc4/drivers/base/sys.c	2005-05-07 03:37:15.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/drivers/base/sys.c	2005-05-07 04:31:56.000000000 -0400
@@ -36,7 +36,7 @@ sysdev_show(struct kobject * kobj, struc
 	struct sysdev_attribute * sysdev_attr = to_sysdev_attr(attr);
 
 	if (sysdev_attr->show)
-		return sysdev_attr->show(sysdev, buffer);
+		return sysdev_attr->show(sysdev, buffer, attr->data);
 	return 0;
 }
 
@@ -49,7 +49,7 @@ sysdev_store(struct kobject * kobj, stru
 	struct sysdev_attribute * sysdev_attr = to_sysdev_attr(attr);
 
 	if (sysdev_attr->store)
-		return sysdev_attr->store(sysdev, buffer, count);
+		return sysdev_attr->store(sysdev, buffer, count, attr->data);
 	return 0;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc4/drivers/block/genhd.c linux-2.6.12-rc4-sysfsdyncallback-core/drivers/block/genhd.c
--- linux-2.6.12-rc4/drivers/block/genhd.c	2005-05-07 03:37:15.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/drivers/block/genhd.c	2005-05-07 04:31:56.000000000 -0400
@@ -325,7 +325,7 @@ static ssize_t disk_attr_show(struct kob
 	ssize_t ret = 0;
 
 	if (disk_attr->show)
-		ret = disk_attr->show(disk,page);
+		ret = disk_attr->show(disk,page,attr->data);
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc4/drivers/cpufreq/cpufreq.c linux-2.6.12-rc4-sysfsdyncallback-core/drivers/cpufreq/cpufreq.c
--- linux-2.6.12-rc4/drivers/cpufreq/cpufreq.c	2005-05-07 03:37:16.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/drivers/cpufreq/cpufreq.c	2005-05-07 04:31:56.000000000 -0400
@@ -521,7 +521,7 @@ static ssize_t show(struct kobject * kob
 	policy = cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
-	ret = fattr->show ? fattr->show(policy,buf) : 0;
+	ret = fattr->show ? fattr->show(policy,buf,attr->data) : 0;
 	cpufreq_cpu_put(policy);
 	return ret;
 }
@@ -535,7 +535,7 @@ static ssize_t store(struct kobject * ko
 	policy = cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
-	ret = fattr->store ? fattr->store(policy,buf,count) : 0;
+	ret = fattr->store ? fattr->store(policy,buf,count,attr->data) : 0;
 	cpufreq_cpu_put(policy);
 	return ret;
 }
diff -uprN -X dontdiff linux-2.6.12-rc4/drivers/pci/pci-driver.c linux-2.6.12-rc4-sysfsdyncallback-core/drivers/pci/pci-driver.c
--- linux-2.6.12-rc4/drivers/pci/pci-driver.c	2005-05-07 03:37:18.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/drivers/pci/pci-driver.c	2005-05-07 04:31:56.000000000 -0400
@@ -56,7 +56,8 @@ pci_device_probe_dynamic(struct pci_driv
  * and causes the driver to probe for all devices again.
  */
 static inline ssize_t
-store_new_id(struct device_driver *driver, const char *buf, size_t count)
+store_new_id(struct device_driver *driver, const char *buf, size_t count, 
+		void *data)
 {
 	struct dynid *dynid;
 	struct bus_type * bus;
@@ -339,7 +340,7 @@ pci_driver_attr_show(struct kobject * ko
 
 	if (get_driver(driver)) {
 		if (dattr->show)
-			ret = dattr->show(driver, buf);
+			ret = dattr->show(driver, buf, attr->data);
 		put_driver(driver);
 	}
 	return ret;
@@ -355,7 +356,7 @@ pci_driver_attr_store(struct kobject * k
 
 	if (get_driver(driver)) {
 		if (dattr->store)
-			ret = dattr->store(driver, buf, count);
+			ret = dattr->store(driver, buf, count, attr->data);
 		put_driver(driver);
 	}
 	return ret;
diff -uprN -X dontdiff linux-2.6.12-rc4/fs/sysfs/file.c linux-2.6.12-rc4-sysfsdyncallback-core/fs/sysfs/file.c
--- linux-2.6.12-rc4/fs/sysfs/file.c	2005-05-07 03:37:22.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/fs/sysfs/file.c	2005-05-07 04:31:56.000000000 -0400
@@ -26,7 +26,7 @@ subsys_attr_show(struct kobject * kobj, 
 	ssize_t ret = 0;
 
 	if (sattr->show)
-		ret = sattr->show(s,page);
+		ret = sattr->show(s,page,attr->data);
 	return ret;
 }
 
@@ -39,7 +39,7 @@ subsys_attr_store(struct kobject * kobj,
 	ssize_t ret = 0;
 
 	if (sattr->store)
-		ret = sattr->store(s,page,count);
+		ret = sattr->store(s,page,count,attr->data);
 	return ret;
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc4/include/linux/cpufreq.h linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/cpufreq.h
--- linux-2.6.12-rc4/include/linux/cpufreq.h	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/cpufreq.h	2005-05-07 04:31:56.000000000 -0400
@@ -240,8 +240,9 @@ static inline void cpufreq_verify_within
 
 struct freq_attr {
 	struct attribute attr;
-	ssize_t (*show)(struct cpufreq_policy *, char *);
-	ssize_t (*store)(struct cpufreq_policy *, const char *, size_t count);
+	ssize_t (*show)(struct cpufreq_policy *, char *, void * data);
+	ssize_t (*store)(struct cpufreq_policy *, const char *, size_t count,
+			void * data);
 };
 
 
diff -uprN -X dontdiff linux-2.6.12-rc4/include/linux/device.h linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/device.h
--- linux-2.6.12-rc4/include/linux/device.h	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/device.h	2005-05-07 04:31:56.000000000 -0400
@@ -87,8 +87,9 @@ int bus_for_each_drv(struct bus_type * b
 
 struct bus_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct bus_type *, char * buf);
-	ssize_t (*store)(struct bus_type *, const char * buf, size_t count);
+	ssize_t (*show)(struct bus_type *, char * buf, void * data);
+	ssize_t (*store)(struct bus_type *, const char * buf, size_t count,
+			void * data);
 };
 
 #define BUS_ATTR(_name,_mode,_show,_store)	\
@@ -127,8 +128,9 @@ extern struct device_driver *driver_find
 
 struct driver_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct device_driver *, char * buf);
-	ssize_t (*store)(struct device_driver *, const char * buf, size_t count);
+	ssize_t (*show)(struct device_driver *, char * buf, void * data);
+	ssize_t (*store)(struct device_driver *, const char * buf, size_t count,
+			void * data);
 };
 
 #define DRIVER_ATTR(_name,_mode,_show,_store)	\
@@ -168,8 +170,9 @@ extern void class_put(struct class *);
 
 struct class_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct class *, char * buf);
-	ssize_t (*store)(struct class *, const char * buf, size_t count);
+	ssize_t (*show)(struct class *, char * buf, void * data);
+	ssize_t (*store)(struct class *, const char * buf, size_t count, 
+			void * data);
 };
 
 #define CLASS_ATTR(_name,_mode,_show,_store)			\
@@ -217,8 +220,8 @@ extern void class_device_put(struct clas
 
 struct class_device_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct class_device *, char * buf);
-	ssize_t (*store)(struct class_device *, const char * buf, size_t count);
+	ssize_t (*show)(struct class_device *, char * buf, void * data);
+	ssize_t (*store)(struct class_device *, const char * buf, size_t count, void * data);
 };
 
 #define CLASS_DEVICE_ATTR(_name,_mode,_show,_store)		\
@@ -335,8 +338,9 @@ extern void driver_attach(struct device_
 
 struct device_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct device * dev, char * buf);
-	ssize_t (*store)(struct device * dev, const char * buf, size_t count);
+	ssize_t (*show)(struct device * dev, char * buf, void * data);
+	ssize_t (*store)(struct device * dev, const char * buf, size_t count,
+			void * data);
 };
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
diff -uprN -X dontdiff linux-2.6.12-rc4/include/linux/genhd.h linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/genhd.h
--- linux-2.6.12-rc4/include/linux/genhd.h	2005-03-02 02:37:49.000000000 -0500
+++ linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/genhd.h	2005-05-07 04:31:56.000000000 -0400
@@ -131,7 +131,7 @@ struct gendisk {
 /* Structure for sysfs attributes on block devices */
 struct disk_attribute {
 	struct attribute attr;
-	ssize_t (*show)(struct gendisk *, char *);
+	ssize_t (*show)(struct gendisk *, char *, void * data);
 };
 
 /* 
diff -uprN -X dontdiff linux-2.6.12-rc4/include/linux/kobject.h linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/kobject.h
--- linux-2.6.12-rc4/include/linux/kobject.h	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/kobject.h	2005-05-07 04:31:56.000000000 -0400
@@ -234,8 +234,9 @@ static inline void subsys_put(struct sub
 
 struct subsys_attribute {
 	struct attribute attr;
-	ssize_t (*show)(struct subsystem *, char *);
-	ssize_t (*store)(struct subsystem *, const char *, size_t); 
+	ssize_t (*show)(struct subsystem *, char *, void * data);
+	ssize_t (*store)(struct subsystem *, const char *, size_t, 
+			void * data); 
 };
 
 extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
diff -uprN -X dontdiff linux-2.6.12-rc4/include/linux/module.h linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/module.h
--- linux-2.6.12-rc4/include/linux/module.h	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/module.h	2005-05-07 04:31:56.000000000 -0400
@@ -48,9 +48,10 @@ struct module;
 
 struct module_attribute {
         struct attribute attr;
-        ssize_t (*show)(struct module_attribute *, struct module *, char *);
+        ssize_t (*show)(struct module_attribute *, struct module *, char *, 
+			void * data);
         ssize_t (*store)(struct module_attribute *, struct module *,
-			 const char *, size_t count);
+			 const char *, size_t count, void * data);
 };
 
 struct module_kobject
diff -uprN -X dontdiff linux-2.6.12-rc4/include/linux/sysdev.h linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/sysdev.h
--- linux-2.6.12-rc4/include/linux/sysdev.h	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/sysdev.h	2005-05-07 04:31:56.000000000 -0400
@@ -77,14 +77,15 @@ extern void sysdev_unregister(struct sys
 
 struct sysdev_attribute { 
 	struct attribute	attr;
-	ssize_t (*show)(struct sys_device *, char *);
-	ssize_t (*store)(struct sys_device *, const char *, size_t);
+	ssize_t (*show)(struct sys_device *, char *, void * data);
+	ssize_t (*store)(struct sys_device *, const char *, size_t, 
+			void * data);
 };
 
 
 #define SYSDEV_ATTR(_name,_mode,_show,_store) 		\
 struct sysdev_attribute attr_##_name = { 			\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .data = NULL },	\
 	.show	= _show,					\
 	.store	= _store,					\
 };
diff -uprN -X dontdiff linux-2.6.12-rc4/include/linux/sysfs.h linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/sysfs.h
--- linux-2.6.12-rc4/include/linux/sysfs.h	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/include/linux/sysfs.h	2005-05-07 04:31:56.000000000 -0400
@@ -19,6 +19,7 @@ struct attribute {
 	char			* name;
 	struct module 		* owner;
 	mode_t			mode;
+	void *                  data;
 };
 
 struct attribute_group {
@@ -34,13 +35,15 @@ struct attribute_group {
  */
 
 #define __ATTR(_name,_mode,_show,_store) { \
-	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, 	\
+		.owner = THIS_MODULE, .data   = NULL, },	\
 	.show	= _show,					\
 	.store	= _store,					\
 }
 
 #define __ATTR_RO(_name) { \
-	.attr	= { .name = __stringify(_name), .mode = 0444, .owner = THIS_MODULE },	\
+	.attr	= { .name = __stringify(_name), .mode = 0444, 	\
+		.owner = THIS_MODULE, .data   = NULL,  },	\
 	.show	= _name##_show,	\
 }
 
diff -uprN -X dontdiff linux-2.6.12-rc4/kernel/module.c linux-2.6.12-rc4-sysfsdyncallback-core/kernel/module.c
--- linux-2.6.12-rc4/kernel/module.c	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/kernel/module.c	2005-05-07 04:31:56.000000000 -0400
@@ -652,7 +652,7 @@ void symbol_put_addr(void *addr)
 EXPORT_SYMBOL_GPL(symbol_put_addr);
 
 static ssize_t show_refcnt(struct module_attribute *mattr,
-			   struct module *mod, char *buffer)
+			   struct module *mod, char *buffer, void *sdata)
 {
 	/* sysfs holds a reference */
 	return sprintf(buffer, "%u\n", module_refcount(mod)-1);
@@ -931,7 +931,7 @@ static unsigned long resolve_symbol(Elf_
  */
 #ifdef CONFIG_KALLSYMS
 static ssize_t module_sect_show(struct module_attribute *mattr,
-				struct module *mod, char *buf)
+				struct module *mod, char *buf, void *sdata)
 {
 	struct module_sect_attr *sattr =
 		container_of(mattr, struct module_sect_attr, mattr);
diff -uprN -X dontdiff linux-2.6.12-rc4/kernel/params.c linux-2.6.12-rc4-sysfsdyncallback-core/kernel/params.c
--- linux-2.6.12-rc4/kernel/params.c	2005-05-07 03:37:24.000000000 -0400
+++ linux-2.6.12-rc4-sysfsdyncallback-core/kernel/params.c	2005-05-07 04:31:56.000000000 -0400
@@ -380,7 +380,7 @@ struct module_param_attrs
 #define to_param_attr(n) container_of(n, struct param_attribute, mattr);
 
 static ssize_t param_attr_show(struct module_attribute *mattr,
-			       struct module *mod, char *buf)
+			       struct module *mod, char *buf, void *data)
 {
 	int count;
 	struct param_attribute *attribute = to_param_attr(mattr);
@@ -399,7 +399,7 @@ static ssize_t param_attr_show(struct mo
 /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
 static ssize_t param_attr_store(struct module_attribute *mattr,
 				struct module *owner,
-				const char *buf, size_t len)
+				const char *buf, size_t len, void *data)
 {
  	int err;
 	struct param_attribute *attribute = to_param_attr(mattr);
@@ -634,7 +634,7 @@ static ssize_t module_attr_show(struct k
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
 
-	ret = attribute->show(attribute, mk->mod, buf);
+	ret = attribute->show(attribute, mk->mod, buf, attr->data);
 
 	module_put(mk->mod);
 
@@ -658,7 +658,7 @@ static ssize_t module_attr_store(struct 
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
 
-	ret = attribute->store(attribute, mk->mod, buf, len);
+	ret = attribute->store(attribute, mk->mod, buf, len, attr->data);
 
 	module_put(mk->mod);
 




















------=_Part_415_17942695.1115472094280--
