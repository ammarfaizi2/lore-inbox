Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTFZAfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTFZAfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:35:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:17815 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265227AbTFZAfB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10565884952122@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.73
In-Reply-To: <1056588494675@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Jun 2003 17:48:15 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1429.2.6, 2003/06/25 17:13:44-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix core problem with kobject lifespans.

Added needed release function, now all pci hotplug drivers need to implement
it...


 drivers/pci/hotplug/pci_hotplug.h      |    4 ++++
 drivers/pci/hotplug/pci_hotplug_core.c |   22 +++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/hotplug/pci_hotplug.h b/drivers/pci/hotplug/pci_hotplug.h
--- a/drivers/pci/hotplug/pci_hotplug.h	Wed Jun 25 17:37:57 2003
+++ b/drivers/pci/hotplug/pci_hotplug.h	Wed Jun 25 17:37:57 2003
@@ -51,6 +51,8 @@
 	ssize_t (*show)(struct hotplug_slot *, char *);
 	ssize_t (*store)(struct hotplug_slot *, const char *, size_t);
 };
+#define to_hotplug_attr(n) container_of(n, struct hotplug_slot_attribute, attr);
+
 /**
  * struct hotplug_slot_ops -the callbacks that the hotplug pci core can use
  * @owner: The module owner of this structure
@@ -130,12 +132,14 @@
 	char				*name;
 	struct hotplug_slot_ops		*ops;
 	struct hotplug_slot_info	*info;
+	void (*release) (struct hotplug_slot *slot);
 	void				*private;
 
 	/* Variables below this are for use only by the hotplug pci core. */
 	struct list_head		slot_list;
 	struct kobject			kobj;
 };
+#define to_hotplug_slot(n) container_of(n, struct hotplug_slot, kobj)
 
 extern int pci_hp_register		(struct hotplug_slot *slot);
 extern int pci_hp_deregister		(struct hotplug_slot *slot);
diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	Wed Jun 25 17:37:57 2003
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	Wed Jun 25 17:37:57 2003
@@ -74,20 +74,16 @@
 static ssize_t hotplug_slot_attr_show(struct kobject *kobj,
 		struct attribute *attr, char *buf)
 {
-	struct hotplug_slot *slot=container_of(kobj,
-			struct hotplug_slot,kobj);
-	struct hotplug_slot_attribute *attribute =
-		container_of(attr, struct hotplug_slot_attribute, attr);
+	struct hotplug_slot *slot = to_hotplug_slot(kobj);
+	struct hotplug_slot_attribute *attribute = to_hotplug_attr(attr);
 	return attribute->show ? attribute->show(slot, buf) : 0;
 }
 
 static ssize_t hotplug_slot_attr_store(struct kobject *kobj,
 		struct attribute *attr, const char *buf, size_t len)
 {
-	struct hotplug_slot *slot=container_of(kobj,
-			struct hotplug_slot,kobj);
-	struct hotplug_slot_attribute *attribute =
-		container_of(attr, struct hotplug_slot_attribute, attr);
+	struct hotplug_slot *slot = to_hotplug_slot(kobj);
+	struct hotplug_slot_attribute *attribute = to_hotplug_attr(attr);
 	return attribute->store ? attribute->store(slot, buf, len) : 0;
 }
 
@@ -96,8 +92,16 @@
 	.store = hotplug_slot_attr_store,
 };
 
+static void hotplug_slot_release(struct kobject *kobj)
+{
+	struct hotplug_slot *slot = to_hotplug_slot(kobj);
+	if (slot->release)
+		slot->release(slot);
+}
+
 static struct kobj_type hotplug_slot_ktype = {
-	.sysfs_ops = &hotplug_slot_sysfs_ops
+	.sysfs_ops = &hotplug_slot_sysfs_ops,
+	.release = &hotplug_slot_release,
 };
 
 static decl_subsys(hotplug_slots, &hotplug_slot_ktype, NULL);

