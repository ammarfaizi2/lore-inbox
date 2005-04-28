Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVD1Frp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVD1Frp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVD1Fqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:46:52 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:64165 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262139AbVD1Fos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:44:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 3/5] sysfs: (driver/pci) if show/store is missing return -ENOSYS
Date: Thu, 28 Apr 2005 00:42:19 -0500
User-Agent: KMail/1.8
Cc: Greg KH <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>
References: <200504280030.10214.dtor_core@ameritech.net>
In-Reply-To: <200504280030.10214.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504280042.20120.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs: fix drivers/pci so if an attribute does not implement
       show or store method read/write will return -ENOSYS
       instead of 0.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 hotplug/pci_hotplug_core.c |    4 ++--
 hotplug/rpadlpar_sysfs.c   |    2 +-
 pci-driver.c               |   26 ++++++++++++++------------
 3 files changed, 17 insertions(+), 15 deletions(-)

Index: dtor/drivers/pci/hotplug/rpadlpar_sysfs.c
===================================================================
--- dtor.orig/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ dtor/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -48,7 +48,7 @@ dlpar_attr_store(struct kobject * kobj, 
 	struct dlpar_io_attr *dlpar_attr = container_of(attr,
 						struct dlpar_io_attr, attr);
 	return dlpar_attr->store ?
-		dlpar_attr->store(dlpar_attr, buf, nbytes) : 0;
+		dlpar_attr->store(dlpar_attr, buf, nbytes) : -ENOSYS;
 }
 
 static struct sysfs_ops dlpar_attr_sysfs_ops = {
Index: dtor/drivers/pci/pci-driver.c
===================================================================
--- dtor.orig/drivers/pci/pci-driver.c
+++ dtor/drivers/pci/pci-driver.c
@@ -327,13 +327,14 @@ pci_driver_attr_show(struct kobject * ko
 {
 	struct device_driver *driver = kobj_to_pci_driver(kobj);
 	struct driver_attribute *dattr = attr_to_driver_attribute(attr);
-	ssize_t ret = 0;
+	ssize_t ret;
 
-	if (get_driver(driver)) {
-		if (dattr->show)
-			ret = dattr->show(driver, buf);
-		put_driver(driver);
-	}
+	if (!get_driver(driver))
+		return -ENODEV;
+
+	ret = dattr->show ? dattr->show(driver, buf) : -ENOSYS;
+
+	put_driver(driver);
 	return ret;
 }
 
@@ -343,13 +344,14 @@ pci_driver_attr_store(struct kobject * k
 {
 	struct device_driver *driver = kobj_to_pci_driver(kobj);
 	struct driver_attribute *dattr = attr_to_driver_attribute(attr);
-	ssize_t ret = 0;
+	ssize_t ret;
 
-	if (get_driver(driver)) {
-		if (dattr->store)
-			ret = dattr->store(driver, buf, count);
-		put_driver(driver);
-	}
+	if (!get_driver(driver))
+		return -ENODEV;
+
+	ret = dattr->store ? dattr->store(driver, buf, count) : -ENOSYS;
+
+	put_driver(driver);
 	return ret;
 }
 
Index: dtor/drivers/pci/hotplug/pci_hotplug_core.c
===================================================================
--- dtor.orig/drivers/pci/hotplug/pci_hotplug_core.c
+++ dtor/drivers/pci/hotplug/pci_hotplug_core.c
@@ -73,7 +73,7 @@ static ssize_t hotplug_slot_attr_show(st
 {
 	struct hotplug_slot *slot = to_hotplug_slot(kobj);
 	struct hotplug_slot_attribute *attribute = to_hotplug_attr(attr);
-	return attribute->show ? attribute->show(slot, buf) : 0;
+	return attribute->show ? attribute->show(slot, buf) : -ENOSYS;
 }
 
 static ssize_t hotplug_slot_attr_store(struct kobject *kobj,
@@ -81,7 +81,7 @@ static ssize_t hotplug_slot_attr_store(s
 {
 	struct hotplug_slot *slot = to_hotplug_slot(kobj);
 	struct hotplug_slot_attribute *attribute = to_hotplug_attr(attr);
-	return attribute->store ? attribute->store(slot, buf, len) : 0;
+	return attribute->store ? attribute->store(slot, buf, len) : -ENOSYS;
 }
 
 static struct sysfs_ops hotplug_slot_sysfs_ops = {
