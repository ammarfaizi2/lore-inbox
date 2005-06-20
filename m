Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVFUBLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVFUBLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 21:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVFUAhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:37:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:46308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261703AbVFTW7z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:55 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] sysfs: (rest) if show/store is missing return -EIO
In-Reply-To: <11193083611124@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:21 -0700
Message-Id: <11193083612284@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs: (rest) if show/store is missing return -EIO

sysfs: fix the rest of the kernel so if an attribute doesn't
       implement show or store method read/write will return
       -EIO instead of 0 or -EINVAL or -EPERM.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 70f2817a43c89b784dc2ec3d06ba5bf3064f8235
tree 210bbd16599d4e402051e4ec30c82e70b8b427ef
parent 6c1852a08e444a2e66367352a99c0e93c8bf3e97
author Dmitry Torokhov <dtor_core@ameritech.net> Fri, 29 Apr 2005 01:27:34 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:03 -0700

 drivers/acpi/scan.c             |    4 ++--
 drivers/cpufreq/cpufreq.c       |    4 ++--
 drivers/firmware/edd.c          |    2 +-
 drivers/firmware/efivars.c      |    4 ++--
 drivers/infiniband/core/sysfs.c |    2 +-
 kernel/params.c                 |    4 ++--
 security/seclvl.c               |    4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
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
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
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
diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -115,7 +115,7 @@ edd_attr_show(struct kobject * kobj, str
 {
 	struct edd_device *dev = to_edd_device(kobj);
 	struct edd_attribute *edd_attr = to_edd_attr(attr);
-	ssize_t ret = 0;
+	ssize_t ret = -EIO;
 
 	if (edd_attr->show)
 		ret = edd_attr->show(dev, buf);
diff --git a/drivers/firmware/efivars.c b/drivers/firmware/efivars.c
--- a/drivers/firmware/efivars.c
+++ b/drivers/firmware/efivars.c
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
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -71,7 +71,7 @@ static ssize_t port_attr_show(struct kob
 	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
 
 	if (!port_attr->show)
-		return 0;
+		return -EIO;
 
 	return port_attr->show(p, port_attr, buf);
 }
diff --git a/kernel/params.c b/kernel/params.c
--- a/kernel/params.c
+++ b/kernel/params.c
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
diff --git a/security/seclvl.c b/security/seclvl.c
--- a/security/seclvl.c
+++ b/security/seclvl.c
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

