Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVD2G3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVD2G3j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 02:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVD2G3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 02:29:14 -0400
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:19039 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262439AbVD2G1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 02:27:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/5 (take 2)] sysfs: (rest) if show/store is missing return -EIO
Date: Fri, 29 Apr 2005 01:27:34 -0500
User-Agent: KMail/1.8
Cc: Robert Love <rml@novell.com>, Greg KH <gregkh@suse.de>,
       Jean Delvare <khali@linux-fr.org>
References: <200504280030.10214.dtor_core@ameritech.net> <1114710135.6682.60.camel@betsy> <200504290122.00679.dtor_core@ameritech.net>
In-Reply-To: <200504290122.00679.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290127.35237.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: fix the rest of the kernel so if an attribute doesn't
       implement show or store method read/write will return
       -EIO instead of 0 or -EINVAL or -EPERM.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/scan.c             |    4 ++--
 drivers/cpufreq/cpufreq.c       |    4 ++--
 drivers/firmware/edd.c          |    2 +-
 drivers/firmware/efivars.c      |    4 ++--
 drivers/infiniband/core/sysfs.c |    2 +-
 kernel/params.c                 |    4 ++--
 security/seclvl.c               |    4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

Index: dtor/drivers/cpufreq/cpufreq.c
===================================================================
--- dtor.orig/drivers/cpufreq/cpufreq.c
+++ dtor/drivers/cpufreq/cpufreq.c
@@ -521,7 +521,7 @@ static ssize_t show(struct kobject * kob
 	policy = cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
-	ret = fattr->show ? fattr->show(policy,buf) : 0;
+	ret = fattr->show ? fattr->show(policy,buf) : -EIO;
 	cpufreq_cpu_put(policy);
 	return ret;
 }
@@ -535,7 +535,7 @@ static ssize_t store(struct kobject * ko
 	policy = cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
-	ret = fattr->store ? fattr->store(policy,buf,count) : 0;
+	ret = fattr->store ? fattr->store(policy,buf,count) : -EIO;
 	cpufreq_cpu_put(policy);
 	return ret;
 }
Index: dtor/drivers/firmware/efivars.c
===================================================================
--- dtor.orig/drivers/firmware/efivars.c
+++ dtor/drivers/firmware/efivars.c
@@ -352,7 +352,7 @@ static ssize_t efivar_attr_show(struct k
 {
 	struct efivar_entry *var = to_efivar_entry(kobj);
 	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -368,7 +368,7 @@ static ssize_t efivar_attr_store(struct 
 {
 	struct efivar_entry *var = to_efivar_entry(kobj);
 	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
Index: dtor/kernel/params.c
===================================================================
--- dtor.orig/kernel/params.c
+++ dtor/kernel/params.c
@@ -629,7 +629,7 @@ static ssize_t module_attr_show(struct k
 	mk = to_module_kobject(kobj);
 
 	if (!attribute->show)
-		return -EPERM;
+		return -EIO;
 
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
@@ -653,7 +653,7 @@ static ssize_t module_attr_store(struct 
 	mk = to_module_kobject(kobj);
 
 	if (!attribute->store)
-		return -EPERM;
+		return -EIO;
 
 	if (!try_module_get(mk->mod))
 		return -ENODEV;
Index: dtor/drivers/infiniband/core/sysfs.c
===================================================================
--- dtor.orig/drivers/infiniband/core/sysfs.c
+++ dtor/drivers/infiniband/core/sysfs.c
@@ -71,7 +71,7 @@ static ssize_t port_attr_show(struct kob
 	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
 
 	if (!port_attr->show)
-		return 0;
+		return -EIO;
 
 	return port_attr->show(p, port_attr, buf);
 }
Index: dtor/security/seclvl.c
===================================================================
--- dtor.orig/security/seclvl.c
+++ dtor/security/seclvl.c
@@ -155,7 +155,7 @@ seclvl_attr_store(struct kobject *kobj,
 	struct seclvl_obj *obj = container_of(kobj, struct seclvl_obj, kobj);
 	struct seclvl_attribute *attribute =
 	    container_of(attr, struct seclvl_attribute, attr);
-	return (attribute->store ? attribute->store(obj, buf, len) : 0);
+	return attribute->store ? attribute->store(obj, buf, len) : -EIO;
 }
 
 static ssize_t
@@ -164,7 +164,7 @@ seclvl_attr_show(struct kobject *kobj, s
 	struct seclvl_obj *obj = container_of(kobj, struct seclvl_obj, kobj);
 	struct seclvl_attribute *attribute =
 	    container_of(attr, struct seclvl_attribute, attr);
-	return (attribute->show ? attribute->show(obj, buf) : 0);
+	return attribute->show ? attribute->show(obj, buf) : -EIO;
 }
 
 /**
Index: dtor/drivers/acpi/scan.c
===================================================================
--- dtor.orig/drivers/acpi/scan.c
+++ dtor/drivers/acpi/scan.c
@@ -65,14 +65,14 @@ static ssize_t acpi_device_attr_show(str
 {
 	struct acpi_device *device = to_acpi_device(kobj);
 	struct acpi_device_attribute *attribute = to_handle_attr(attr);
-	return attribute->show ? attribute->show(device, buf) : 0;
+	return attribute->show ? attribute->show(device, buf) : -EIO;
 }
 static ssize_t acpi_device_attr_store(struct kobject *kobj,
 		struct attribute *attr, const char *buf, size_t len)
 {
 	struct acpi_device *device = to_acpi_device(kobj);
 	struct acpi_device_attribute *attribute = to_handle_attr(attr);
-	return attribute->store ? attribute->store(device, buf, len) : len;
+	return attribute->store ? attribute->store(device, buf, len) : -EIO;
 }
 
 static struct sysfs_ops acpi_device_sysfs_ops = {
Index: dtor/drivers/firmware/edd.c
===================================================================
--- dtor.orig/drivers/firmware/edd.c
+++ dtor/drivers/firmware/edd.c
@@ -115,7 +115,7 @@ edd_attr_show(struct kobject * kobj, str
 {
 	struct edd_device *dev = to_edd_device(kobj);
 	struct edd_attribute *edd_attr = to_edd_attr(attr);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (edd_attr->show)
 		ret = edd_attr->show(dev, buf);
