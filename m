Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVFUDW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVFUDW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVFUDTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:19:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:3812 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261643AbVFTW7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:33 -0400
Cc: dtor_core@ameritech.net
Subject: [PATCH] sysfs: (driver/pci) if show/store is missing return -EIO
In-Reply-To: <11193083612648@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:21 -0700
Message-Id: <111930836153@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] sysfs: (driver/pci) if show/store is missing return -EIO

sysfs: fix drivers/pci so if an attribute does not implement
       show or store method read/write will return -EIO
       instead of 0.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit fc7e4828995d8c9e4c9597f8a19179e4ab53f73e
tree 0ca83b71052eb241acc64d0152bff21188944b9c
parent 4a0c20bf8c0fe2116f8fd7d3da6122bf8a01f026
author Dmitry Torokhov <dtor_core@ameritech.net> Fri, 29 Apr 2005 01:26:27 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:02 -0700

 drivers/pci/hotplug/pci_hotplug_core.c |    4 ++--
 drivers/pci/hotplug/rpadlpar_sysfs.c   |    2 +-
 drivers/pci/pci-driver.c               |   26 ++++++++++++++------------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -73,7 +73,7 @@ static ssize_t hotplug_slot_attr_show(st
 {
 	struct hotplug_slot *slot = to_hotplug_slot(kobj);
 	struct hotplug_slot_attribute *attribute = to_hotplug_attr(attr);
-	return attribute->show ? attribute->show(slot, buf) : 0;
+	return attribute->show ? attribute->show(slot, buf) : -EIO;
 }
 
 static ssize_t hotplug_slot_attr_store(struct kobject *kobj,
@@ -81,7 +81,7 @@ static ssize_t hotplug_slot_attr_store(s
 {
 	struct hotplug_slot *slot = to_hotplug_slot(kobj);
 	struct hotplug_slot_attribute *attribute = to_hotplug_attr(attr);
-	return attribute->store ? attribute->store(slot, buf, len) : 0;
+	return attribute->store ? attribute->store(slot, buf, len) : -EIO;
 }
 
 static struct sysfs_ops hotplug_slot_sysfs_ops = {
diff --git a/drivers/pci/hotplug/rpadlpar_sysfs.c b/drivers/pci/hotplug/rpadlpar_sysfs.c
--- a/drivers/pci/hotplug/rpadlpar_sysfs.c
+++ b/drivers/pci/hotplug/rpadlpar_sysfs.c
@@ -48,7 +48,7 @@ dlpar_attr_store(struct kobject * kobj, 
 	struct dlpar_io_attr *dlpar_attr = container_of(attr,
 						struct dlpar_io_attr, attr);
 	return dlpar_attr->store ?
-		dlpar_attr->store(dlpar_attr, buf, nbytes) : 0;
+		dlpar_attr->store(dlpar_attr, buf, nbytes) : -EIO;
 }
 
 static struct sysfs_ops dlpar_attr_sysfs_ops = {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -335,13 +335,14 @@ pci_driver_attr_show(struct kobject * ko
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
+	ret = dattr->show ? dattr->show(driver, buf) : -EIO;
+
+	put_driver(driver);
 	return ret;
 }
 
@@ -351,13 +352,14 @@ pci_driver_attr_store(struct kobject * k
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
+	ret = dattr->store ? dattr->store(driver, buf, count) : -EIO;
+
+	put_driver(driver);
 	return ret;
 }
 

