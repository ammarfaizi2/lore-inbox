Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266247AbUGATzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUGATzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266253AbUGATzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:55:15 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:29548 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266247AbUGATy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:54:57 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linuxppc64-dev@lists.linuxppc.org
Subject: PPC64: vio_find_node removal?
Date: Thu, 1 Jul 2004 14:54:53 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011454.55440.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kset_find_obj that is now only used by vio_find_name/vio_find_node needs to
take kobject reference otherwise use of this function is generally unsafe.

I was looking at vio_find_name users and it is only used in rpaphp hotplug
driver. When creating a hotplug slot the function first tries to find already
existing vio node and if unsuccessfull tries to create a new one. The only
time when vio node would already exist if previous call to register_vio_slot
failed (the function does not do cleanup of created vio device node and it's
the only place where vio devices are created). So it seems to me that if
register_vio_slot would do proper cleanup we can get rid of vio_find_name/
vio_find_node. 

Please CC me as I am not subscribed to ppc64 list.

-- 
Dmitry

===== arch/ppc64/kernel/vio.c 1.26 vs edited =====
--- 1.26/arch/ppc64/kernel/vio.c	2004-06-29 09:44:46 -05:00
+++ edited/arch/ppc64/kernel/vio.c	2004-07-01 14:38:22 -05:00
@@ -32,8 +32,6 @@
 
 #define DBGENTER() pr_debug("%s entered\n", __FUNCTION__)
 
-extern struct subsystem devices_subsys; /* needed for vio_find_name() */
-
 static const struct vio_device_id *vio_match_device(
 		const struct vio_device_id *, const struct vio_dev *);
 
@@ -458,42 +456,6 @@
 	return get_property(vdev->dev.platform_data, (char*)which, length);
 }
 EXPORT_SYMBOL(vio_get_attribute);
-
-/* vio_find_name() - internal because only vio.c knows how we formatted the
- * kobject name
- * XXX once vio_bus_type.devices is actually used as a kset in
- * drivers/base/bus.c, this function should be removed in favor of
- * "device_find(kobj_name, &vio_bus_type)"
- */
-static struct vio_dev *vio_find_name(const char *kobj_name)
-{
-	struct kobject *found;
-
-	found = kset_find_obj(&devices_subsys.kset, kobj_name);
-	if (!found)
-		return NULL;
-
-	return to_vio_dev(container_of(found, struct device, kobj));
-}
-
-/**
- * vio_find_node - find an already-registered vio_dev
- * @vnode: device_node of the virtual device we're looking for
- */
-struct vio_dev *vio_find_node(struct device_node *vnode)
-{
-	uint32_t *unit_address;
-	char kobj_name[BUS_ID_SIZE];
-
-	/* construct the kobject name from the device node */
-	unit_address = (uint32_t *)get_property(vnode, "reg", NULL);
-	if (!unit_address)
-		return NULL;
-	snprintf(kobj_name, BUS_ID_SIZE, "%x", *unit_address);
-
-	return vio_find_name(kobj_name);
-}
-EXPORT_SYMBOL(vio_find_node);
 
 /**
  * vio_build_iommu_table: - gets the dma information from OF and builds the TCE tree.
===== drivers/pci/hotplug/rpaphp_vio.c 1.4 vs edited =====
--- 1.4/drivers/pci/hotplug/rpaphp_vio.c	2004-06-29 09:44:45 -05:00
+++ edited/drivers/pci/hotplug/rpaphp_vio.c	2004-07-01 14:37:11 -05:00
@@ -85,9 +85,7 @@
 		goto exit_rc;
 	}
 	slot->dev_type = VIO_DEV;
-	slot->dev.vio_dev = vio_find_node(dn);
-	if (!slot->dev.vio_dev)
-		slot->dev.vio_dev = vio_register_device_node(dn);
+	slot->dev.vio_dev = vio_register_device_node(dn);
 	if (slot->dev.vio_dev)
 		slot->state = CONFIGURED;
 	else
@@ -99,8 +97,11 @@
 		__FUNCTION__, slot->name, slot->dev.vio_dev); 
 	rc = register_slot(slot);
 exit_rc:
-	if (rc && slot)
+	if (rc && slot) {
+		if (slot->dev.vio_dev)
+			vio_unregister_device(slot->dev.vio_dev);
 		dealloc_slot_struct(slot);
+	}
 	return (rc);
 }
 
===== include/asm-ppc64/vio.h 1.11 vs edited =====
--- 1.11/include/asm-ppc64/vio.h	2004-06-29 09:44:45 -05:00
+++ edited/include/asm-ppc64/vio.h	2004-07-01 14:39:10 -05:00
@@ -50,7 +50,6 @@
 		struct device_node *node_vdev);
 #endif
 void __devinit vio_unregister_device(struct vio_dev *dev);
-struct vio_dev *vio_find_node(struct device_node *vnode);
 
 const void * vio_get_attribute(struct vio_dev *vdev, void* which, int* length);
 int vio_get_irq(struct vio_dev *dev);
