Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUCSXf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUCSXf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:35:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:34767 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263147AbUCSXcY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:32:24 -0500
Subject: Re: [PATCH] PCI and PCI Hotplug fixes for 2.6.5-rc1
In-Reply-To: <1079739131226@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 19 Mar 2004 15:32:11 -0800
Message-Id: <1079739131618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.97.3, 2004/03/10 14:23:19-08:00, lxiep@ltcfwd.linux.ibm.com

[PATCH] PCI Hotplug: rpaphp/rpadlpar latest (support for vio and multifunction devices )


 drivers/pci/hotplug/Makefile        |    4 
 drivers/pci/hotplug/rpadlpar_core.c |  186 +++++--
 drivers/pci/hotplug/rpaphp.h        |   90 ++-
 drivers/pci/hotplug/rpaphp_core.c   |  853 ++++++++----------------------------
 drivers/pci/hotplug/rpaphp_pci.c    |  357 ++++++++++++++-
 drivers/pci/hotplug/rpaphp_slot.c   |  188 +++++++
 drivers/pci/hotplug/rpaphp_vio.c    |  121 +++++
 7 files changed, 1038 insertions(+), 761 deletions(-)


diff -Nru a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
--- a/drivers/pci/hotplug/Makefile	Fri Mar 19 15:21:26 2004
+++ b/drivers/pci/hotplug/Makefile	Fri Mar 19 15:21:26 2004
@@ -40,7 +40,9 @@
 				acpiphp_res.o
 
 rpaphp-objs		:=	rpaphp_core.o	\
-				rpaphp_pci.o	
+				rpaphp_pci.o	\
+				rpaphp_slot.o	\
+				rpaphp_vio.o
 
 rpadlpar_io-objs	:=	rpadlpar_core.o \
 				rpadlpar_sysfs.o
diff -Nru a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
--- a/drivers/pci/hotplug/rpadlpar_core.c	Fri Mar 19 15:21:26 2004
+++ b/drivers/pci/hotplug/rpadlpar_core.c	Fri Mar 19 15:21:26 2004
@@ -43,7 +43,28 @@
 	return ptr;
 }
 
-static struct device_node *find_php_slot_node(char *drc_name)
+static struct device_node *find_php_slot_vio_node(char *drc_name)
+{
+	struct device_node *child;
+	struct device_node *parent = of_find_node_by_name(NULL, "vdevice");
+
+	if (!parent)
+		return NULL;
+
+	for (child = of_get_next_child(parent, NULL);	
+	     child; child = of_get_next_child(parent, child)) {
+	
+		char *loc_code;
+	
+		loc_code = get_property(child, "ibm,loc-code", NULL);
+		if (loc_code && !strcmp(loc_code, drc_name))
+			return child;
+	}
+
+	return NULL;
+}
+
+static struct device_node *find_php_slot_pci_node(char *drc_name)
 {
 	struct device_node *np = NULL;
 	char *name;
@@ -72,7 +93,7 @@
 static struct slot *find_slot(char *drc_name)
 {
 	struct hotplug_slot *php_slot = find_php_slot(drc_name);
-	
+
 	if (!php_slot)
 		return NULL;
 
@@ -127,14 +148,14 @@
 	rpadlpar_claim_one_bus(bridge_dev->bus);
 
 	if (hose->last_busno < child->number)
-	    	hose->last_busno = child->number;
+		hose->last_busno = child->number;
 
 	dn->bussubno = child->number;
 
 	/* ioremap() for child bus */
 	if (remap_bus_range(child)) {
 		printk(KERN_ERR "%s: could not ioremap() child bus\n",
-				__FUNCTION__);
+			__FUNCTION__);
 		return 1;
 	}
 
@@ -162,9 +183,9 @@
 		return NULL;
 	}
 
-	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)  {
+	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
 		printk(KERN_ERR "%s: unexpected header type %d\n",
-				__FUNCTION__, dev->hdr_type);
+			__FUNCTION__, dev->hdr_type);
 		return NULL;
 	}
 
@@ -180,7 +201,7 @@
 
 	if (!bridge_dev) {
 		printk(KERN_ERR "%s: unexpected null device\n",
-				__FUNCTION__);
+			__FUNCTION__);
 		return 1;
 	}
 
@@ -188,11 +209,25 @@
 
 	if (unmap_bus_range(secondary_bus)) {
 		printk(KERN_ERR "%s: failed to unmap bus range\n",
-				__FUNCTION__);
+			__FUNCTION__);
 		return 1;
 	}
 
 	pci_remove_bus_device(bridge_dev);
+	return 0;
+}
+
+static inline int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
+{
+	struct pci_dev *dev;
+
+	/* Add pci bus */
+	dev = dlpar_pci_add_bus(dn);
+	if (!dev) {
+		printk(KERN_ERR "%s: unable to add bus %s\n", __FUNCTION__,
+			drc_name);
+		return -EIO;
+	}
 
 	return 0;
 }
@@ -212,37 +247,33 @@
  */
 int dlpar_add_slot(char *drc_name)
 {
-	struct device_node *dn = find_php_slot_node(drc_name);
-	struct pci_dev *dev;
+	struct device_node *dn;
 	int rc = 0;
 
 	if (down_interruptible(&rpadlpar_sem))
 		return -ERESTARTSYS;
 
-	if (!dn) {
-		rc = -ENODEV;
-		goto exit;
-	}
-
 	/* Check for existing hotplug slot */
 	if (find_slot(drc_name)) {
 		rc = -EINVAL;
 		goto exit;
 	}
 
-	/* Add pci bus */
-	dev = dlpar_pci_add_bus(dn);
-	if (!dev) {
-		printk(KERN_ERR "%s: unable to add bus %s\n", __FUNCTION__,
-				drc_name);
-		rc = -EIO;
-		goto exit;
+	dn = find_php_slot_vio_node(drc_name);
+	if (!dn) {
+		dn = find_php_slot_pci_node(drc_name);
+		if (dn)
+			rc = dlpar_add_pci_slot(drc_name, dn);
+		else {
+			rc = -ENODEV;
+			goto exit;
+		}
 	}
 
-	/* Add hotplug slot for new bus */
-	if (rpaphp_add_slot(drc_name)) {
+	/* Add hotplug slot for new VIOA or PCI */
+	if (!rc && rpaphp_add_slot(dn)) {
 		printk(KERN_ERR "%s: unable to add hotplug slot %s\n",
-				__FUNCTION__, drc_name);
+			__FUNCTION__, drc_name);
 		rc = -EIO;
 	}
 exit:
@@ -251,60 +282,107 @@
 }
 
 /**
- * dlpar_remove_slot - DLPAR remove an I/O Slot
+ * dlpar_remove_vio_slot - DLPAR remove a virtual I/O Slot
  * @drc_name: drc-name of newly added slot
  *
  * Remove the kernel and hotplug representations
  * of an I/O Slot.
  * Return Codes:
  * 0			Success
+ * -EIO			Internal  Error
+ */
+int dlpar_remove_vio_slot(struct slot *slot, char *drc_name)
+{
+	/* Remove hotplug slot */
+
+	if (rpaphp_remove_slot(slot)) {
+		printk(KERN_ERR "%s: unable to remove hotplug slot %s\n",
+			__FUNCTION__, drc_name);
+		return -EIO;
+	}
+	return 0;
+}
+
+/**
+ * dlpar_remove_slot - DLPAR remove a PCI I/O Slot
+ * @drc_name: drc-name of newly added slot
+ *
+ * Remove the kernel and hotplug representations
+ * of a PCI I/O Slot.
+ * Return Codes:
+ * 0			Success
  * -ENODEV		Not a valid drc_name
- * -EINVAL		Slot already removed
- * -ERESTARTSYS		Signalled before obtaining lock
  * -EIO			Internal PCI Error
  */
-int dlpar_remove_slot(char *drc_name)
+int dlpar_remove_pci_slot(struct slot *slot, char *drc_name)
 {
-	struct device_node *dn = find_php_slot_node(drc_name);
-	struct slot *slot;
+	struct device_node *dn = find_php_slot_pci_node(drc_name);
 	struct pci_dev *bridge_dev;
-	int rc = 0;
-
-	if (down_interruptible(&rpadlpar_sem))
-		return -ERESTARTSYS;
 
-	if (!dn) {
-		rc = -ENODEV;
-		goto exit;
-	}
-
-	slot = find_slot(drc_name);
-	if (!slot) {
-		rc = -EINVAL;
-		goto exit;
-	}
+	if (!dn)
+		return -ENODEV;
 
 	bridge_dev = slot->bridge;
 	if (!bridge_dev) {
 		printk(KERN_ERR "%s: unexpected null bridge device\n",
-				__FUNCTION__);
-		rc = -EIO;
-		goto exit;
+			__FUNCTION__);
+		return -EIO;
 	}
 
 	/* Remove hotplug slot */
 	if (rpaphp_remove_slot(slot)) {
 		printk(KERN_ERR "%s: unable to remove hotplug slot %s\n",
-				__FUNCTION__, drc_name);
-		rc = -EIO;
-		goto exit;
+			__FUNCTION__, drc_name);
+		return -EIO;
 	}
 
 	/* Remove pci bus */
 	if (dlpar_pci_remove_bus(bridge_dev)) {
 		printk(KERN_ERR "%s: unable to remove pci bus %s\n",
-				__FUNCTION__, drc_name);
-		rc = -EIO;
+			__FUNCTION__, drc_name);
+		return -EIO;
+	}
+	return 0;
+}
+
+/**
+ * dlpar_remove_slot - DLPAR remove an I/O Slot
+ * @drc_name: drc-name of newly added slot
+ *
+ * Remove the kernel and hotplug representations
+ * of an I/O Slot.
+ * Return Codes:
+ * 0			Success
+ * -ENODEV		Not a valid drc_name
+ * -EINVAL		Slot already removed
+ * -ERESTARTSYS		Signalled before obtaining lock
+ * -EIO			Internal Error
+ */
+int dlpar_remove_slot(char *drc_name)
+{
+	struct slot *slot;
+	int rc = 0;
+
+	if (down_interruptible(&rpadlpar_sem))
+		return -ERESTARTSYS;
+	
+	slot = find_slot(drc_name);
+	if (!slot) {
+		rc = -EINVAL;
+		goto exit;
+	}
+	
+	switch (slot->dev_type) {
+		case PCI_DEV:
+			rc = dlpar_remove_pci_slot(slot, drc_name);
+			break;
+
+		case VIO_DEV:
+			rc = dlpar_remove_vio_slot(slot, drc_name);
+			break;
+
+		default:
+			rc = -EIO;
 	}
 exit:
 	up(&rpadlpar_sem);
@@ -324,7 +402,7 @@
 
 	if (!is_dlpar_capable()) {
 		printk(KERN_WARNING "%s: partition not DLPAR capable\n",
-				__FUNCTION__);
+			__FUNCTION__);
 		return -EPERM;
 	}
 
diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	Fri Mar 19 15:21:26 2004
+++ b/drivers/pci/hotplug/rpaphp.h	Fri Mar 19 15:21:26 2004
@@ -26,6 +26,8 @@
 
 #ifndef _PPC64PHP_H
 #define _PPC64PHP_H
+
+#include <linux/pci.h>
 #include "pci_hotplug.h"
 
 #define DR_INDICATOR 9002
@@ -34,24 +36,22 @@
 #define POWER_ON	100
 #define POWER_OFF	0
 
-#define LED_OFF		0 
-#define LED_ON		1	/* continuous on */ 
+#define LED_OFF		0
+#define LED_ON		1	/* continuous on */
 #define LED_ID		2	/* slow blinking */
 #define LED_ACTION	3	/* fast blinking */
 
-#define SLOT_NAME_SIZE 12
-
 /* Error status from rtas_get-sensor */
-#define NEED_POWER    -9000     /* slot must be power up and unisolated to get state */
-#define PWR_ONLY      -9001     /* slot must be powerd up to get state, leave isolated */
-#define ERR_SENSE_USE -9002     /* No DR operation will succeed, slot is unusable  */
+#define NEED_POWER    -9000	/* slot must be power up and unisolated to get state */
+#define PWR_ONLY      -9001	/* slot must be powerd up to get state, leave isolated */
+#define ERR_SENSE_USE -9002	/* No DR operation will succeed, slot is unusable  */
 
 /* Sensor values from rtas_get-sensor */
-#define EMPTY	0       /* No card in slot */
-#define PRESENT	1       /* Card in slot */
+#define EMPTY           0	/* No card in slot */
+#define PRESENT         1	/* Card in slot */
 
 #define MY_NAME "rpaphp"
-
+extern int debug;
 #define dbg(format, arg...)					\
 	do {							\
 		if (debug)					\
@@ -64,6 +64,10 @@
 
 #define SLOT_MAGIC	0x67267322
 
+/* slot types */
+#define VIO_DEV	1
+#define PCI_DEV	2
+
 /* slot states */
 
 #define	NOT_VALID	3
@@ -75,27 +79,55 @@
  * struct slot - slot information for each *physical* slot
  */
 struct slot {
-	u32	magic;
-	int     state;
-	u32     index;
-	u32     type;
-	u32     power_domain;
-	char    *name;
-	struct	device_node *dn;/* slot's device_node in OFDT		*/
-				/* dn has phb info			*/
-	struct	pci_dev	*bridge;/* slot's pci_dev in pci_devices	*/
-
-	struct	pci_dev	*dev;	/* pci_dev of device in this slot 	*/
-				/* it will be used for unconfig		*/ 
-				/* NULL if slot is empty		*/
-
-	struct  hotplug_slot    *hotplug_slot;
-	struct list_head	rpaphp_slot_list;
+	u32 magic;
+	int state;
+	u32 index;
+	u32 type;
+	u32 power_domain;
+	char *name;
+	struct device_node *dn;	/* slot's device_node in OFDT */
+	/* dn has phb info */
+	struct pci_dev *bridge;	/* slot's pci_dev in pci_devices */
+	union {
+		struct pci_dev *pci_dev;	/* pci_dev of device in this slot */
+		/* it will be used for unconfig */
+		/* NULL if slot is empty */
+		struct vio_dev *vio_dev;	/* vio_dev of the device in this slot */
+	} dev;
+	u8 dev_type;		/* VIO or PCI */
+	struct hotplug_slot *hotplug_slot;
+	struct list_head rpaphp_slot_list;
 };
 
+extern struct hotplug_slot_ops rpaphp_hotplug_slot_ops;
+extern struct list_head rpaphp_slot_head;
+extern int num_slots;
+
+/* function prototypes */
+
+/* rpaphp_pci.c */
 extern struct pci_dev *rpaphp_find_pci_dev(struct device_node *dn);
-extern int rpaphp_add_slot(char *slot_name);
-extern int rpaphp_remove_slot(struct slot *slot);
 extern int rpaphp_claim_resource(struct pci_dev *dev, int resource);
+extern int rpaphp_enable_pci_slot(struct slot *slot);
+extern int register_pci_slot(struct slot *slot);
+extern int rpaphp_unconfig_pci_adapter(struct slot *slot);
+extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
+
+/* rpaphp_core.c */
+extern int rpaphp_add_slot(struct device_node *dn);
+extern int rpaphp_remove_slot(struct slot *slot);
 
-#endif /* _PPC64PHP_H */
+/* rpaphp_vio.c */
+extern int rpaphp_get_vio_adapter_status(struct slot *slot, int is_init, u8 * value);
+extern int rpaphp_unconfig_vio_adapter(struct slot *slot);
+extern int register_vio_slot(struct device_node *dn);
+extern int rpaphp_enable_vio_slot(struct slot *slot);
+
+/* rpaphp_slot.c */
+extern void dealloc_slot_struct(struct slot *slot);
+extern struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name, int power_domain);
+extern int register_slot(struct slot *slot);
+extern int rpaphp_get_power_status(struct slot *slot, u8 * value);
+extern int rpaphp_set_attention_status(struct slot *slot, u8 status);
+	
+#endif				/* _PPC64PHP_H */
diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	Fri Mar 19 15:21:26 2004
+++ b/drivers/pci/hotplug/rpaphp_core.c	Fri Mar 19 15:21:26 2004
@@ -33,16 +33,15 @@
 #include <linux/init.h>
 #include <asm/rtas.h>		/* rtas_call */
 #include <asm/pci-bridge.h>	/* for pci_controller */
-#include "../pci.h"		/* for pci_add_new_bus*/
-				/* and pci_do_scan_bus*/
+#include "../pci.h"		/* for pci_add_new_bus */
+				/* and pci_do_scan_bus */
 #include "rpaphp.h"
 #include "pci_hotplug.h"
 
-
-static int debug;
+int debug;
 static struct semaphore rpaphp_sem;
-static LIST_HEAD (rpaphp_slot_head);
-static int num_slots;
+LIST_HEAD(rpaphp_slot_head);
+int num_slots;
 
 #define DRIVER_VERSION	"0.1"
 #define DRIVER_AUTHOR	"Linda Xie <lxie@us.ibm.com>"
@@ -59,109 +58,35 @@
 static int enable_slot(struct hotplug_slot *slot);
 static int disable_slot(struct hotplug_slot *slot);
 static int set_attention_status(struct hotplug_slot *slot, u8 value);
-static int get_power_status(struct hotplug_slot *slot, u8 *value);
-static int get_attention_status(struct hotplug_slot *slot, u8 *value);
-static int get_adapter_status(struct hotplug_slot *slot, u8 *value);
+static int get_power_status(struct hotplug_slot *slot, u8 * value);
+static int get_attention_status(struct hotplug_slot *slot, u8 * value);
+static int get_adapter_status(struct hotplug_slot *slot, u8 * value);
 static int get_max_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
 static int get_cur_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
 
-static struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
-	.owner			= THIS_MODULE,
-	.enable_slot		= enable_slot,
-	.disable_slot		= disable_slot,
-	.set_attention_status	= set_attention_status,
-	.get_power_status	= get_power_status,
-	.get_attention_status	= get_attention_status,
-	.get_adapter_status	= get_adapter_status,
-	.get_max_bus_speed	= get_max_bus_speed,
-	.get_cur_bus_speed	= get_cur_bus_speed,
+struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
+	.owner = THIS_MODULE,
+	.enable_slot = enable_slot,
+	.disable_slot = disable_slot,
+	.set_attention_status = set_attention_status,
+	.get_power_status = get_power_status,
+	.get_attention_status = get_attention_status,
+	.get_adapter_status = get_adapter_status,
+	.get_max_bus_speed = get_max_bus_speed,
+	.get_cur_bus_speed = get_cur_bus_speed,
 };
 
-static int rpaphp_get_sensor_state(int index, int *state)
-{
-	int rc;
-
-	rc = rtas_get_sensor(DR_ENTITY_SENSE, index, state);
-
-	if (rc) {
-		if (rc ==  NEED_POWER || rc == PWR_ONLY) {
-			dbg("%s: slot must be power up to get sensor-state\n",
-				__FUNCTION__);
-		} else if (rc == ERR_SENSE_USE)
-			info("%s: slot is unusable\n", __FUNCTION__);
-		   else err("%s failed to get sensor state\n", __FUNCTION__);
-	}
-	return rc;
-}
-
-static struct pci_dev *rpaphp_find_bridge_pdev(struct slot *slot)
-{
-	return rpaphp_find_pci_dev(slot->dn);
-}
-
-static struct pci_dev *rpaphp_find_adapter_pdev(struct slot *slot)
-{
-	return rpaphp_find_pci_dev(slot->dn->child);
-}
-
-/* Inline functions to check the sanity of a pointer that is passed to us */
-static inline int slot_paranoia_check(struct slot *slot, const char *function)
+static inline struct slot *get_slot (struct hotplug_slot *hotplug_slot, const char *function)
 {
-	if (!slot) {
-		dbg("%s - slot == NULL\n", function);
-		return -1;
-	}
-
-	if (!slot->hotplug_slot) {
-		dbg("%s - slot->hotplug_slot == NULL!\n", function);
-		return -1;
-	}
-	return 0;
-}
-
-static inline struct slot *get_slot(struct hotplug_slot *hotplug_slot, const char *function)
-{
-	struct slot *slot;
-
 	if (!hotplug_slot) {
 		dbg("%s - hotplug_slot == NULL\n", function);
 		return NULL;
 	}
-
-	slot = (struct slot *)hotplug_slot->private;
-	if (slot_paranoia_check(slot, function))
-		return NULL;
-	return slot;
-}
-
-static inline int rpaphp_set_attention_status(struct slot *slot, u8 status)
-{
-	int	rc;
-
-	/* status: LED_OFF or LED_ON */
-	rc = rtas_set_indicator(DR_INDICATOR, slot->index, status);
-	if (rc)
-		err("slot(%s) set attention-status(%d) failed! rc=0x%x\n",
-			slot->name, status, rc);
-	
-	return rc;
-}
-
-static int rpaphp_get_power_status(struct slot *slot, u8 *value)
-{
-	int	rc;
-
-	rc = rtas_get_power_level(slot->power_domain, (int *)value);
-	if (rc)
-		err("failed to get power-level for slot(%s), rc=0x%x\n",
-			slot->name, rc);
-
-	return rc;
+	return (struct slot *)hotplug_slot->private;
 }
 
 static int rpaphp_get_attention_status(struct slot *slot)
 {
-
 	return slot->hotplug_slot->info->attention_status;
 }
 
@@ -172,7 +97,7 @@
  * echo 2 > attention -- set LED ID(identify, light is blinking)
  *
  */
-static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 value)
+static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 {
 	int retval = 0;
 	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
@@ -182,25 +107,21 @@
 
 	down(&rpaphp_sem);
 	switch (value) {
-		case 0:
-			retval = rpaphp_set_attention_status(slot, LED_OFF);
-			hotplug_slot->info->attention_status = 0;
-			break;
-
-		case 1:
-		default:
-			retval = rpaphp_set_attention_status(slot, LED_ON);
-			hotplug_slot->info->attention_status = 1;
-			break;
-
-		case 2:
-			retval = rpaphp_set_attention_status(slot, LED_ID);
-			hotplug_slot->info->attention_status = 2;
-			break;
-
+	case 0:
+		retval = rpaphp_set_attention_status(slot, LED_OFF);
+		hotplug_slot->info->attention_status = 0;
+		break;
+	case 1:
+	default:
+		retval = rpaphp_set_attention_status(slot, LED_ON);
+		hotplug_slot->info->attention_status = 1;
+		break;
+	case 2:
+		retval = rpaphp_set_attention_status(slot, LED_ID);
+		hotplug_slot->info->attention_status = 2;
+		break;
 	}
 	up(&rpaphp_sem);
-	
 	return retval;
 }
 
@@ -211,7 +132,7 @@
  *
  *
  */
-static int get_power_status (struct hotplug_slot *hotplug_slot, u8 *value)
+static int get_power_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
 	int retval;
 	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
@@ -222,7 +143,6 @@
 	down(&rpaphp_sem);
 	retval = rpaphp_get_power_status(slot, value);
 	up(&rpaphp_sem);
-
 	return retval;
 }
 
@@ -231,7 +151,7 @@
  *
  *
  */
-static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 *value)
+static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
 	int retval = 0;
 	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
@@ -239,81 +159,36 @@
 	if (slot == NULL)
 		return -ENODEV;
 
-
 	down(&rpaphp_sem);
 	*value = rpaphp_get_attention_status(slot);
 	up(&rpaphp_sem);
-
 	return retval;
 }
 
-/*
- * get_adapter_status - get  the status of a slot
- *
- * 0-- slot is empty
- * 1-- adapter is configured
- * 2-- adapter is not configured
- * 3-- not valid
- */
-static int rpaphp_get_adapter_status(struct slot *slot, int is_init, u8 *value)
-{
-	int	state, rc;
-
-	*value 		  = NOT_VALID;
-
-	rc = rpaphp_get_sensor_state(slot->index, &state);
-
-	if (rc)
-		return rc;
-
-	if (state == PRESENT) {
-		dbg("slot is occupied\n");
-
-		if (!is_init) /* at run-time slot->state can be changed by */
-			  /* config/unconfig adapter	 		   */
-			*value = slot->state;
-		else {
-		if (!slot->dn->child)
-			dbg("%s: %s is not valid OFDT node\n",
-				__FUNCTION__, slot->dn->full_name);
-		else
-			if (rpaphp_find_pci_dev(slot->dn->child))
-				*value = CONFIGURED;
-			else {
-				dbg("%s: can't find pdev of adapter in slot[%s]\n",
-					__FUNCTION__, slot->name);
-				*value = NOT_CONFIGURED;
-				}
-		}
-	} else
-		if (state == EMPTY) {
-		dbg("slot is empty\n");
-			*value = state;
-		}
-	
-	return 0;
-}
-
-static int get_adapter_status (struct hotplug_slot *hotplug_slot, u8 *value)
+static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
 	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
 
 	if (slot == NULL)
 		return -ENODEV;
-
 	down(&rpaphp_sem);
-
 	/*  have to go through this */
-	retval = rpaphp_get_adapter_status(slot, 0, value);
-
+	switch (slot->dev_type) {
+	case PCI_DEV:
+		retval = rpaphp_get_pci_adapter_status(slot, 0, value);
+		break;
+	case VIO_DEV:
+		retval = rpaphp_get_vio_adapter_status(slot, 0, value);
+		break;
+	default:
+		retval = -EINVAL;
+	}
 	up(&rpaphp_sem);
-
 	return retval;
 }
 
-
-static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+static int get_max_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
 	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 
@@ -321,46 +196,42 @@
 		return -ENODEV;
 
 	down(&rpaphp_sem);
-
 	switch (slot->type) {
-		case 1:
-		case 2:
-		case 3:
-		case 4:
-		case 5:
-		case 6:
-			*value = PCI_SPEED_33MHz;	/* speed for case 1-6 */
-			break;
-		case 7:
-		case 8:
-			*value = PCI_SPEED_66MHz;
-			break;
-		case 11:
-		case 14:
-			*value = PCI_SPEED_66MHz_PCIX;
-			break;
-		case 12:
-		case 15:
-			*value = PCI_SPEED_100MHz_PCIX;
-			break;
-		case 13:
-		case 16:
-			*value = PCI_SPEED_133MHz_PCIX;
-			break;
-		default:
-			*value = PCI_SPEED_UNKNOWN;
-			break;
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+	case 5:
+	case 6:
+		*value = PCI_SPEED_33MHz;	/* speed for case 1-6 */
+		break;
+	case 7:
+	case 8:
+		*value = PCI_SPEED_66MHz;
+		break;
+	case 11:
+	case 14:
+		*value = PCI_SPEED_66MHz_PCIX;
+		break;
+	case 12:
+	case 15:
+		*value = PCI_SPEED_100MHz_PCIX;
+		break;
+	case 13:
+	case 16:
+		*value = PCI_SPEED_133MHz_PCIX;
+		break;
+	default:
+		*value = PCI_SPEED_UNKNOWN;
+		break;
 
 	}
-
 	up(&rpaphp_sem);
-
 	return 0;
 }
 
-
 /* return dummy value because not sure if PRA provides any method... */
-static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+static int get_cur_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
 {
 	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 
@@ -368,416 +239,106 @@
 		return -ENODEV;
 
 	*value = PCI_SPEED_UNKNOWN;
-
 	return 0;
 }
 
-/*
- * rpaphp_validate_slot - make sure the name of the slot matches
- * 				the location code , if the slots is not
- *				empty.
- */
-static int rpaphp_validate_slot(const char *slot_name, const int slot_index)
-{
-	struct device_node	*dn;
-
-	for(dn = find_all_nodes(); dn; dn = dn->next) {
-
-		int 		*index;
-		unsigned char	*loc_code;
-
-		index  = (int *)get_property(dn, "ibm,my-drc-index", NULL);
-
-		if (index && *index == slot_index) {
-			char *slash, *tmp_str;
-
-			loc_code = get_property(dn, "ibm,loc-code", NULL);
-			if (!loc_code) { 
-				return -1;
-			}
-
-			tmp_str = kmalloc(MAX_LOC_CODE, GFP_KERNEL); 
-			if (!tmp_str) {
-				err("%s: out of memory\n", __FUNCTION__);
-				return -1;
-			}
-				
-			strcpy(tmp_str, loc_code);
-			slash = strrchr(tmp_str, '/');
-			if (slash) 
-				*slash = '\0';
-			
-			if (strcmp(slot_name, tmp_str)) {
-				kfree(tmp_str);
-				return -1;
-			}
-
-			kfree(tmp_str);
-			break;
-		}
-	}
-	
-	return 0;
-}
-
-/* Must be called before pci_bus_add_devices */
-static void rpaphp_fixup_new_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-	/*
-	 * Skip already-present devices (which are on the
-	 * global device list.)
-	 */
-		if (list_empty(&dev->global_list)) {
-			int i;
-			pcibios_fixup_device_resources(dev, bus);
-			pci_read_irq_line(dev);
-			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-				struct resource *r = &dev->resource[i];
-				if (r->parent || !r->start || !r->flags)
-					continue;
-				rpaphp_claim_resource(dev, i);
-			}
-		}
-	}
-}
-
-static struct pci_dev *rpaphp_config_adapter(struct slot *slot)
-{
-	struct pci_bus 		*pci_bus;
-	struct device_node	*dn;
-	int 			num;
-	struct pci_dev		*dev = NULL;
-
-	if (slot->bridge) {
-
-		pci_bus = slot->bridge->subordinate;
-
-		if (!pci_bus) {
-			err("%s: can't find bus structure\n", __FUNCTION__);
-			goto exit;
-		}
-
-		for (dn = slot->dn->child; dn; dn = dn->sibling) {
-			dbg("child dn's devfn=[%x]\n", dn->devfn);
-				num = pci_scan_slot(pci_bus,
-				PCI_DEVFN(PCI_SLOT(dn->devfn),  0));
-
-				dbg("pci_scan_slot return num=%d\n", num);
-
-			if (num) {
-				rpaphp_fixup_new_devices(pci_bus);
-				pci_bus_add_devices(pci_bus);
-			}
-		}
-
-		dev = rpaphp_find_pci_dev(slot->dn->child);
-	} else {
-		/* slot is not enabled */
-		err("slot doesn't have pci_dev structure\n");
-		dev = NULL;
-		goto exit;
-	}
-
-exit:
-	dbg("Exit %s: pci_dev %s\n", __FUNCTION__, dev? "found":"not found");
-
-	return dev;
-}
-
-static int rpaphp_unconfig_adapter(struct slot *slot)
-{
-	if (!slot->dev) {
-		info("%s: no card in slot[%s]\n",
-			__FUNCTION__, slot->name);
-
-		return -EINVAL;
-	}
-
-	/* remove the device from the pci core */
-	pci_remove_bus_device(slot->dev);
-
-	pci_dev_put(slot->dev);
-	slot->state = NOT_CONFIGURED;
-
-	dbg("%s: adapter in slot[%s] unconfigured.\n", __FUNCTION__, slot->name);
-
-	return 0;
-}
-
-/* free up the memory user be a slot */
-
-static void rpaphp_release_slot(struct hotplug_slot *hotplug_slot)
-{
-	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
-
-	if (slot == NULL)
-		return;
-
-	kfree(slot->hotplug_slot->info);
-	kfree(slot->hotplug_slot->name);
-	kfree(slot->hotplug_slot);
-	pci_dev_put(slot->bridge);
-	pci_dev_put(slot->dev);
-	kfree(slot);
-}
-
 int rpaphp_remove_slot(struct slot *slot)
 {
 	int retval = 0;
+	char *rm_link;
 
-  	sysfs_remove_link(slot->hotplug_slot->kobj.parent,
-			slot->bridge->slot_name);
+	dbg("%s - Entry: slot[%s]\n", __FUNCTION__, slot->name);
+	if (slot->dev_type == PCI_DEV)
+		rm_link = pci_name(slot->bridge);
+	else
+		rm_link = strstr(slot->dn->full_name, "@");
 
+	sysfs_remove_link(slot->hotplug_slot->kobj.parent, rm_link);
 	list_del(&slot->rpaphp_slot_list);
 	retval = pci_hp_deregister(slot->hotplug_slot);
 	if (retval)
 		err("Problem unregistering a slot %s\n", slot->name);
+
 	num_slots--;
 
+	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
 }
 
-static int is_php_dn(struct device_node *dn, int **indexes,  int **names, int **types, int **power_domains)
+static int is_php_dn(struct device_node *dn, int **indexes, int **names, int **types,
+	  int **power_domains)
 {
-	*indexes = (int *)get_property(dn, "ibm,drc-indexes", NULL);
+	*indexes = (int *) get_property(dn, "ibm,drc-indexes", NULL);
 	if (!*indexes)
-		return(0);
-
+		return (0);
 	/* &names[1] contains NULL terminated slot names */
-	*names = (int *)get_property(dn, "ibm,drc-names", NULL);
+	*names = (int *) get_property(dn, "ibm,drc-names", NULL);
 	if (!*names)
-		return(0);
-
+		return (0);
 	/* &types[1] contains NULL terminated slot types */
-	*types = (int *)get_property(dn, "ibm,drc-types", NULL);
+	*types = (int *) get_property(dn, "ibm,drc-types", NULL);
 	if (!*types)
-		return(0);
-
+		return (0);
 	/* power_domains[1...n] are the slot power domains */
-	*power_domains = (int *)get_property(dn,
-		"ibm,drc-power-domains", NULL);
+	*power_domains = (int *) get_property(dn,
+					      "ibm,drc-power-domains", NULL);
 	if (!*power_domains)
-		return(0);
-
-	if (!get_property(dn, "ibm,fw-pci-hot-plug-ctrl", NULL))
-		return(0);
-
-	return(1);
-}
-
-static struct slot *alloc_slot_struct(void)
-{
-	struct slot *slot;
-
-	slot = kmalloc(sizeof(struct slot), GFP_KERNEL);
-	if (!slot)
-		return (NULL);
-	memset(slot, 0, sizeof(struct slot));
-	slot->hotplug_slot = kmalloc(sizeof(struct hotplug_slot),
-		GFP_KERNEL);
-	if (!slot->hotplug_slot) {
-		kfree(slot);
-		return (NULL);
-	}
-	memset(slot->hotplug_slot, 0, sizeof(struct hotplug_slot));
-	slot->hotplug_slot->info = kmalloc(sizeof(struct hotplug_slot_info),
-		GFP_KERNEL);
-	if (!slot->hotplug_slot->info) {
-		kfree(slot->hotplug_slot);
-		kfree(slot);
-		return (NULL);
-	}
-	memset(slot->hotplug_slot->info, 0, sizeof(struct hotplug_slot_info));
-	slot->hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
-	if (!slot->hotplug_slot->name) {
-		kfree(slot->hotplug_slot->info);
-		kfree(slot->hotplug_slot);
-		kfree(slot);
-		return (NULL);
-	}
-	return (slot);
+		return (0);
+	if (strcmp(dn->name, "pci") == 0 &&
+	    !get_property(dn, "ibm,fw-pci-hot-plug-ctrl", NULL))
+		return (0);
+	return (1);
 }
 
-static int setup_hotplug_slot_info(struct slot *slot)
+static inline int is_vdevice_root(struct device_node *dn)
 {
-	rpaphp_get_power_status(slot,
-		&slot->hotplug_slot->info->power_status);
-
-	rpaphp_get_adapter_status(slot, 1,
-		&slot->hotplug_slot->info->adapter_status);
-
-	if (slot->hotplug_slot->info->adapter_status == NOT_VALID) {
-		dbg("%s: NOT_VALID: skip dn->full_name=%s\n",
-			__FUNCTION__, slot->dn->full_name);
-		    kfree(slot->hotplug_slot->info);
-		    kfree(slot->hotplug_slot->name);
-		    kfree(slot->hotplug_slot);
-		    kfree(slot);
-		return (-1);
-	}
-	return (0);
-}
-
-static int register_slot(struct slot *slot)
-{
-	int retval;
-
-	retval = pci_hp_register(slot->hotplug_slot);
-	if (retval) {
-		err("pci_hp_register failed with error %d\n", retval);
-		rpaphp_release_slot(slot->hotplug_slot);
-		return (retval);
-	}
-	/* create symlink between slot->name and it's bus_id */
-	dbg("%s: sysfs_create_link: %s --> %s\n", __FUNCTION__,
-		slot->bridge->slot_name, slot->name);
-	retval = sysfs_create_link(slot->hotplug_slot->kobj.parent,
-			&slot->hotplug_slot->kobj,
-			slot->bridge->slot_name);
-	if (retval) {
-		err("sysfs_create_link failed with error %d\n", retval);
-		rpaphp_release_slot(slot->hotplug_slot);
-		return (retval);
-	}
-	/* add slot to our internal list */
-	dbg("%s adding slot[%s] to rpaphp_slot_list\n",
-		__FUNCTION__, slot->name);
-
-	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
-
-	info("Slot [%s] (bus_id=%s) registered\n",
-		slot->name, slot->bridge->slot_name);
-	return (0);
+	return !strcmp(dn->name, "vdevice");
 }
 
 /*************************************
  * Add  Hot Plug slot(s) to sysfs
  *
  ************************************/
-int rpaphp_add_slot(char *slot_name)
+int rpaphp_add_slot(struct device_node *dn)
 {
-	struct slot		*slot;
-	int 			retval = 0;
-	int 			i;
-	struct device_node 	*dn;
-	int 			*indexes, *names, *types, *power_domains;
-	char 			*name, *type;
-
-	for (dn = find_all_nodes(); dn; dn = dn->next) {
-
-		if (dn->name != 0 && strcmp(dn->name, "pci") == 0)	{
-			if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
-				continue;
-
-			dbg("%s : found device_node in OFDT full_name=%s, name=%s\n",
-				__FUNCTION__, dn->full_name, dn->name);
-
-			name = (char *)&names[1];
-			type = (char *)&types[1];
-
-			for (i = 0; i < indexes[0];
-				i++,
-				name += (strlen(name) + 1),
-				type += (strlen(type) + 1)) {
-
-				dbg("%s: name[%s] index[%x]\n",
-					__FUNCTION__, name, indexes[i+1]);
-
-				if (slot_name && strcmp(slot_name, name))
-					continue;
-
-				if (rpaphp_validate_slot(name, indexes[i + 1])) {
-					dbg("%s: slot(%s, 0x%x) is invalid.\n",
-						__FUNCTION__, name, indexes[i+ 1]);
-					continue;
-				}
-
-				slot = alloc_slot_struct();
-				if (!slot) {
-					retval = -ENOMEM;
-					goto exit;
-				}
-
-				slot->name = slot->hotplug_slot->name;
-				slot->index = indexes[i + 1];
-				strcpy(slot->name, name);
-				slot->type = simple_strtoul(type, NULL, 10);
-				if (slot->type < 1  || slot->type > 16)
-					slot->type = 0;
-
-				slot->power_domain = power_domains[i + 1];
-				slot->magic = SLOT_MAGIC;
-				slot->hotplug_slot->private = slot;
-				slot->hotplug_slot->ops = &rpaphp_hotplug_slot_ops;
-				slot->hotplug_slot->release = &rpaphp_release_slot;
-				slot->dn = dn;
-
-				/*
-			 	* Initilize the slot info structure with some known
-			 	* good values.
-			 	*/
-				if (setup_hotplug_slot_info(slot))
-					continue;
-
-				slot->bridge = rpaphp_find_bridge_pdev(slot);
-				if (!slot->bridge && slot_name) { /* slot being added doesn't have pci_dev yet*/
-					dbg("%s: no pci_dev for bridge dn %s\n",
-							__FUNCTION__, slot_name);
-					kfree(slot->hotplug_slot->info);
-					kfree(slot->hotplug_slot->name);
-					kfree(slot->hotplug_slot);
-					kfree(slot);
-					continue;
-				}
-
-				/* find slot's pci_dev if it's not empty*/
-				if (slot->hotplug_slot->info->adapter_status == EMPTY) {
-					slot->state = EMPTY;  /* slot is empty */
-					slot->dev = NULL;
-				} else {  /* slot is occupied */
-					if(!(slot->dn->child)) { /* non-empty slot has to have child */
-						err("%s: slot[%s]'s device_node doesn't have child for adapter\n",
-						__FUNCTION__, slot->name);
-						kfree(slot->hotplug_slot->info);
-						kfree(slot->hotplug_slot->name);
-						kfree(slot->hotplug_slot);
-						kfree(slot);
-						continue;
-
-					}
-
-					slot->dev = rpaphp_find_adapter_pdev(slot);
-					if(slot->dev) {
-						slot->state = CONFIGURED;
-						pci_dev_get(slot->dev);
-					} else {
-						/* DLPAR add as opposed to
-						 * boot time */
-						slot->state = NOT_CONFIGURED;
-						}
-				}
-				dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n",
-					__FUNCTION__, dn->full_name, slot->index, slot->name,
-					slot->power_domain, slot->type);
-
-				retval = register_slot(slot);
-				if (retval)
-					goto exit;
-
-				num_slots++;
-
-				if (slot_name)
-					goto exit;
-
-			}/* for indexes */
-		}/* "pci" */
-	}/* find_all_nodes */
-exit:
+	struct slot *slot;
+	int retval = 0;
+	int i;
+	int *indexes, *names, *types, *power_domains;
+	char *name, *type;
+
+	dbg("Entry %s: dn->full_name=%s\n", __FUNCTION__, dn->full_name);
+
+	if (dn->parent && is_vdevice_root(dn->parent)) {
+		/* register a VIO device */
+		retval = register_vio_slot(dn);
+		goto exit;
+	}
+
+	/* register PCI devices */
+	if (dn->name != 0 && strcmp(dn->name, "pci") == 0 &&
+	    is_php_dn(dn, &indexes, &names, &types, &power_domains)) {
+
+		name = (char *) &names[1];
+		type = (char *) &types[1];
+		for (i = 0; i < indexes[0];
+		     i++,
+		     name += (strlen(name) + 1), type += (strlen(type) + 1)) {
+			if (!(slot = alloc_slot_struct(dn, indexes[i + 1], name,
+						       power_domains[i + 1]))) {
+				retval = -ENOMEM;
+				goto exit;
+			}
+			slot->type = simple_strtoul(type, NULL, 10);
+			if (slot->type < 1 || slot->type > 16)
+				slot->type = 0;
+			retval = register_pci_slot(slot);
+
+		}		/* for indexes */
+	}			/* end of PCI device_node */
+      exit:
 	dbg("%s - Exit: num_slots=%d rc[%d]\n",
-		__FUNCTION__, num_slots, retval);
+	    __FUNCTION__, num_slots, retval);
 	return retval;
 }
 
@@ -785,31 +346,28 @@
  * init_slots - initialize 'struct slot' structures for each slot
  *
  */
-static int init_slots (void)
+static void init_slots(void)
 {
-	int 			retval = 0;
+	struct device_node *dn;
 
-	retval = rpaphp_add_slot(NULL);
-
-	return retval;
+	for (dn = find_all_nodes(); dn; dn = dn->next)
+		rpaphp_add_slot(dn);
 }
 
-
-static int init_rpa (void)
+static int init_rpa(void)
 {
-	int 			retval = 0;
 
 	init_MUTEX(&rpaphp_sem);
 
 	/* initialize internal data structure etc. */
-	retval = init_slots();
+	init_slots();
 	if (!num_slots)
-		retval = -ENODEV;
+		return -ENODEV;
 
-	return retval;
+	return 0;
 }
 
-static void cleanup_slots (void)
+static void cleanup_slots(void)
 {
 	struct list_head *tmp, *n;
 	struct slot *slot;
@@ -817,125 +375,100 @@
 	/*
 	 * Unregister all of our slots with the pci_hotplug subsystem,
 	 * and free up all memory that we had allocated.
-	 * memory will be freed in release_slot callback.
+	 * memory will be freed in release_slot callback. 
 	 */
 
-	list_for_each_safe (tmp, n, &rpaphp_slot_head) {
+	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
+		char *rm_link;
+
 		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
-		sysfs_remove_link(slot->hotplug_slot->kobj.parent,
-			slot->bridge->slot_name);
+		if (slot->dev_type == PCI_DEV)
+			rm_link = pci_name(slot->bridge);
+		else
+			rm_link = strstr(slot->dn->full_name, "@");
+		sysfs_remove_link(slot->hotplug_slot->kobj.parent, rm_link);
 		list_del(&slot->rpaphp_slot_list);
 		pci_hp_deregister(slot->hotplug_slot);
 	}
-
 	return;
 }
 
-
 static int __init rpaphp_init(void)
 {
-	int retval = 0;
-
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 	/* read all the PRA info from the system */
-	retval = init_rpa();
-
-	return retval;
+	return init_rpa();
 }
 
-
 static void __exit rpaphp_exit(void)
 {
 	cleanup_slots();
 }
 
-
 static int enable_slot(struct hotplug_slot *hotplug_slot)
 {
-	int retval = 0, state;
-
+	int retval = 0;
 	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 
 	if (slot == NULL)
 		return -ENODEV;
 
 	if (slot->state == CONFIGURED) {
-		dbg("%s: %s is already enabled\n",
-			__FUNCTION__, slot->name);
+		dbg("%s: %s is already enabled\n", __FUNCTION__, slot->name);
 		goto exit;
 	}
 
 	dbg("ENABLING SLOT %s\n", slot->name);
-
 	down(&rpaphp_sem);
-
-	retval = rpaphp_get_sensor_state(slot->index, &state);
-
-	if (retval)
-		goto exit;
-
-	dbg("%s: sensor state[%d]\n", __FUNCTION__, state);
-
-	/* if slot is not empty, enable the adapter */
-	if (state == PRESENT) {
-		dbg("%s : slot[%s] is occupid.\n", __FUNCTION__, slot->name);
-
-		
-		slot->dev = rpaphp_config_adapter(slot);
-		if (slot->dev != NULL) {
-			slot->state = CONFIGURED;
-
-			dbg("%s: adapter %s in slot[%s] has been configured\n",
-				__FUNCTION__, slot->dev->slot_name,
-				slot->name);
-		} else {
-			slot->state = NOT_CONFIGURED;
-
-			dbg("%s: no pci_dev struct for adapter in slot[%s]\n",
-				__FUNCTION__, slot->name);
-		}
-
-	} else if (state == EMPTY) {
-		dbg("%s : slot[%s] is empty\n", __FUNCTION__, slot->name);
-		slot->state = EMPTY;
-	} else {
-		err("%s: slot[%s] is in invalid state\n", __FUNCTION__, slot->name);
-		slot->state = NOT_VALID;
+	switch (slot->dev_type) {
+	case PCI_DEV:
+		retval = rpaphp_enable_pci_slot(slot);
+		break;
+	case VIO_DEV:
+		retval = rpaphp_enable_vio_slot(slot);
+		break;
+	default:
 		retval = -EINVAL;
 	}
-
-exit:
-	if (slot->state != NOT_VALID)
-		rpaphp_set_attention_status(slot, LED_ON);
-	else
-		rpaphp_set_attention_status(slot, LED_ID);
-
 	up(&rpaphp_sem);
-
+      exit:
+	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
 }
 
 static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
-	int	retval;
+	int retval;
 	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 
 	if (slot == NULL)
 		return -ENODEV;
 
-	dbg("DISABLING SLOT %s\n", slot->name);
-
-	down(&rpaphp_sem);
-
-	rpaphp_set_attention_status(slot, LED_ID);
+	dbg("%s - Entry: slot[%s]\n", __FUNCTION__, slot->name);
 
-	retval = rpaphp_unconfig_adapter(slot);
-
-	rpaphp_set_attention_status(slot, LED_OFF);
+	if (slot->state == NOT_CONFIGURED) {
+		dbg("%s: %s is already disabled\n", __FUNCTION__, slot->name);
+		goto exit;
+	}
 
+	dbg("DISABLING SLOT %s\n", slot->name);
+	down(&rpaphp_sem);
+	switch (slot->dev_type) {
+	case PCI_DEV:
+		rpaphp_set_attention_status(slot, LED_ID);
+		retval = rpaphp_unconfig_pci_adapter(slot);
+		rpaphp_set_attention_status(slot, LED_OFF);
+		break;
+	case VIO_DEV:
+		retval = rpaphp_unconfig_vio_adapter(slot);
+		break;
+	default:
+		retval = -ENODEV;
+	}
 	up(&rpaphp_sem);
-
+      exit:
+	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
 }
 
diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	Fri Mar 19 15:21:26 2004
+++ b/drivers/pci/hotplug/rpaphp_pci.c	Fri Mar 19 15:21:26 2004
@@ -23,32 +23,35 @@
  *
  */
 #include <linux/pci.h>
-#include <asm/pci-bridge.h>	/* for pci_controller */
-#include "rpaphp.h"
+#include <asm/pci-bridge.h>
+#include "../pci.h"		/* for pci_add_new_bus */
 
+#include "rpaphp.h"
 
 struct pci_dev *rpaphp_find_pci_dev(struct device_node *dn)
 {
-	struct pci_dev		*retval_dev = NULL, *dev = NULL;
-
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		if(!dev->bus)
-			continue;
+	struct pci_dev *retval_dev = NULL, *dev = NULL;
+	char bus_id[BUS_ID_SIZE];
 
-		if (dev->devfn != dn->devfn)
-			continue;
+	sprintf(bus_id, "%04x:%02x:%02x.%d",dn->phb->global_number,
+		dn->busno, PCI_SLOT(dn->devfn), PCI_FUNC(dn->devfn));
 
-		if (dn->phb->global_number == pci_domain_nr(dev->bus) &&
-		    dn->busno == dev->bus->number) {
+	dbg("Enter rpaphp_find_pci_dev() full_name=%s bus_id=%s\n", 
+		dn->full_name, bus_id);
+	
+	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+               if (!strcmp(pci_name(dev), bus_id)) {
 			retval_dev = dev;
+			dbg("rpaphp_find_pci_dev(): found dev=%p\n\n", dev);
 			break;
 		}
 	}
-
 	return retval_dev;
 
 }
 
+EXPORT_SYMBOL_GPL(rpaphp_find_pci_dev);
+
 int rpaphp_claim_resource(struct pci_dev *dev, int resource)
 {
 	struct resource *res = &dev->resource[resource];
@@ -63,13 +66,333 @@
 
 	if (err) {
 		err("PCI: %s region %d of %s %s [%lx:%lx]\n",
-			root ? "Address space collision on" :
-			"No parent found for",
-			resource, dtype, pci_name(dev), res->start, res->end);
+		    root ? "Address space collision on" :
+		    "No parent found for",
+		    resource, dtype, pci_name(dev), res->start, res->end);
 	}
-
 	return err;
 }
 
-EXPORT_SYMBOL_GPL(rpaphp_find_pci_dev);
 EXPORT_SYMBOL_GPL(rpaphp_claim_resource);
+
+static struct pci_dev *rpaphp_find_bridge_pdev(struct slot *slot)
+{
+	return rpaphp_find_pci_dev(slot->dn);
+}
+
+static struct pci_dev *rpaphp_find_adapter_pdev(struct slot *slot)
+{
+	return rpaphp_find_pci_dev(slot->dn->child);
+}
+
+static int rpaphp_get_sensor_state(struct slot *slot, int *state)
+{
+	int rc;
+	int setlevel;
+
+	rc = rtas_get_sensor(DR_ENTITY_SENSE, slot->index, state);
+
+	if (rc) {
+		if (rc == NEED_POWER || rc == PWR_ONLY) {
+			dbg("%s: slot must be power up to get sensor-state\n",
+			    __FUNCTION__);
+
+			/* some slots have to be powered up 
+			 * before get-sensor will succeed.
+			 */
+			rc = rtas_set_power_level(slot->power_domain, POWER_ON,
+						  &setlevel);
+			if (rc) {
+				dbg("%s: power on slot[%s] failed rc=%d.\n",
+				    __FUNCTION__, slot->name, rc);
+			} else {
+				rc = rtas_get_sensor(DR_ENTITY_SENSE,
+						     slot->index, state);
+			}
+		} else if (rc == ERR_SENSE_USE)
+			info("%s: slot is unusable\n", __FUNCTION__);
+		else
+			err("%s failed to get sensor state\n", __FUNCTION__);
+	}
+	return rc;
+}
+
+/*
+ * get_pci_adapter_status - get  the status of a slot
+ * 
+ * 0-- slot is empty
+ * 1-- adapter is configured
+ * 2-- adapter is not configured
+ * 3-- not valid
+ */
+int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value)
+{
+	int state, rc;
+	*value = NOT_VALID;
+
+	rc = rpaphp_get_sensor_state(slot, &state);
+	if (rc)
+		goto exit;
+	if (state == PRESENT) {
+		if (!is_init)
+			/* at run-time slot->state can be changed by */
+			/* config/unconfig adapter                        */
+			*value = slot->state;
+		else {
+			if (!slot->dn->child)
+				dbg("%s: %s is not valid OFDT node\n",
+				    __FUNCTION__, slot->dn->full_name);
+			else if (rpaphp_find_pci_dev(slot->dn->child))
+				*value = CONFIGURED;
+			else {
+				dbg("%s: can't find pdev of adapter in slot[%s]\n", __FUNCTION__, slot->name);
+				*value = NOT_CONFIGURED;
+			}
+		}
+	} else if (state == EMPTY) {
+		dbg("slot is empty\n");
+		*value = state;
+	}
+
+      exit:
+	return rc;
+}
+
+/* Must be called before pci_bus_add_devices */
+static void rpaphp_fixup_new_pci_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		/*
+		 * Skip already-present devices (which are on the
+		 * global device list.)
+		 */
+		if (list_empty(&dev->global_list)) {
+			int i;
+
+			pcibios_fixup_device_resources(dev, bus);
+			pci_read_irq_line(dev);
+			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+				struct resource *r = &dev->resource[i];
+				if (r->parent || !r->start || !r->flags)
+					continue;
+				rpaphp_claim_resource(dev, i);
+			}
+		}
+	}
+}
+
+static void rpaphp_pci_config_device(struct pci_bus *pci_bus, struct device_node *dn)
+{
+	int num;
+
+	num = pci_scan_slot(pci_bus, PCI_DEVFN(PCI_SLOT(dn->devfn), 0));
+	if (num) {
+		rpaphp_fixup_new_pci_devices(pci_bus);
+		pci_bus_add_devices(pci_bus);
+	}
+	return;
+}
+
+static int rpaphp_pci_config_bridge(struct pci_dev *dev, struct device_node *dn);
+
+/*****************************************************************************
+ rpaphp_pci_config_dn() will recursively configure all devices under the 
+ given slot->dn and return the dn's pci_dev.
+ *****************************************************************************/
+static struct pci_dev *rpaphp_pci_config_dn(struct device_node *dn, struct pci_bus *bus)
+{
+	struct device_node *local;
+	struct pci_dev *dev;
+
+	for (local = dn->child; local; local = local->sibling) {
+		rpaphp_pci_config_device(bus, local);
+		dev = rpaphp_find_pci_dev(local);
+		if (!rpaphp_pci_config_bridge(dev, local))
+			return NULL;
+	}
+
+	return dev;
+}
+
+static int rpaphp_pci_config_bridge(struct pci_dev *dev, struct device_node *dn)
+{
+	if (dev && dn->child) {	/* dn is a PCI bridge node */
+		struct pci_bus *child;
+		u8 sec_busno;
+
+		/* get busno of downstream bus */
+		pci_read_config_byte(dev, PCI_SECONDARY_BUS, &sec_busno);
+
+		/* add to children of PCI bridge dev->bus */
+		child = pci_add_new_bus(dev->bus, dev, sec_busno);
+		if (!child) {
+			err("%s: could not add second bus\n", __FUNCTION__);
+			return 0;
+		}
+		sprintf(child->name, "PCI Bus #%02x", child->number);
+		/* Fixup subordinate bridge bases and resureces */
+		pcibios_fixup_bus(child);
+
+		/* may need do more stuff here */
+		rpaphp_pci_config_dn(dn, dev->subordinate);
+	}
+	return 1;
+}
+
+static struct pci_dev *rpaphp_config_pci_adapter(struct slot *slot)
+{
+	struct pci_bus *pci_bus;
+	struct pci_dev *dev = NULL;
+
+	dbg("Entry %s: slot[%s]\n", __FUNCTION__, slot->name);
+
+	if (slot->bridge) {
+
+		pci_bus = slot->bridge->subordinate;
+		if (!pci_bus) {
+			err("%s: can't find bus structure\n", __FUNCTION__);
+			goto exit;
+		}
+
+		dev = rpaphp_pci_config_dn(slot->dn, pci_bus);
+	} else {
+		/* slot is not enabled */
+		err("slot doesn't have pci_dev structure\n");
+		dev = NULL;
+		goto exit;
+	}
+
+      exit:
+	dbg("Exit %s: pci_dev %s\n", __FUNCTION__, dev ? "found" : "not found");
+	return dev;
+}
+
+int rpaphp_unconfig_pci_adapter(struct slot *slot)
+{
+	int retval = 0;
+
+	dbg("Entry %s: slot[%s]\n", __FUNCTION__, slot->name);
+	if (!slot->dev.pci_dev) {
+		info("%s: no card in slot[%s]\n", __FUNCTION__, slot->name);
+
+		retval = -EINVAL;
+		goto exit;
+	}
+	/* remove the device from the pci core */
+	pci_remove_bus_device(slot->dev.pci_dev);
+
+	slot->state = NOT_CONFIGURED;
+	info("%s: adapter in slot[%s] unconfigured.\n", __FUNCTION__,
+	     slot->name);
+exit:
+	dbg("Exit %s, rc=0x%x\n", __FUNCTION__, retval);
+	return retval;
+}
+
+static int setup_pci_hotplug_slot_info(struct slot *slot)
+{
+	dbg("%s Initilize the PCI slot's hotplug->info structure ...\n",
+	    __FUNCTION__);
+	rpaphp_get_power_status(slot, &slot->hotplug_slot->info->power_status);
+	rpaphp_get_pci_adapter_status(slot, 1,
+				      &slot->hotplug_slot->info->
+				      adapter_status);
+	if (slot->hotplug_slot->info->adapter_status == NOT_VALID) {
+		dbg("%s: NOT_VALID: skip dn->full_name=%s\n",
+		    __FUNCTION__, slot->dn->full_name);
+		dealloc_slot_struct(slot);
+		return (-1);
+	}
+	return (0);
+}
+
+static int setup_pci_slot(struct slot *slot)
+{
+	slot->bridge = rpaphp_find_bridge_pdev(slot);
+	if (!slot->bridge) {	/* slot being added doesn't have pci_dev yet */
+		dbg("%s: no pci_dev for bridge dn %s\n", __FUNCTION__, slot->name);
+		dealloc_slot_struct(slot);
+		return 1;
+	}
+
+	/* find slot's pci_dev if it's not empty */
+	if (slot->hotplug_slot->info->adapter_status == EMPTY) {
+		slot->state = EMPTY;	/* slot is empty */
+		slot->dev.pci_dev = NULL;
+	} else {
+		/* slot is occupied */
+		if (!(slot->dn->child)) {
+			/* non-empty slot has to have child */
+			err("%s: slot[%s]'s device_node doesn't have child for adapter\n", __FUNCTION__, slot->name);
+			dealloc_slot_struct(slot);
+			return 1;
+		}
+		slot->dev.pci_dev = rpaphp_find_adapter_pdev(slot);
+		if (slot->dev.pci_dev) {
+			slot->state = CONFIGURED;
+		
+		} else {
+			/* DLPAR add as opposed to 
+			 * boot time */
+			slot->state = NOT_CONFIGURED;
+		}
+	}
+	return 0;
+}
+
+int register_pci_slot(struct slot *slot)
+{
+	int rc = 1;
+
+	slot->dev_type = PCI_DEV;
+	if (setup_pci_hotplug_slot_info(slot))
+		goto exit_rc;
+	if (setup_pci_slot(slot))
+		goto exit_rc;
+	rc = register_slot(slot);
+      exit_rc:
+	if (rc)
+		dealloc_slot_struct(slot);
+	return rc;
+}
+
+int rpaphp_enable_pci_slot(struct slot *slot)
+{
+	int retval = 0, state;
+
+	retval = rpaphp_get_sensor_state(slot, &state);
+	if (retval)
+		goto exit;
+	dbg("%s: sensor state[%d]\n", __FUNCTION__, state);
+	/* if slot is not empty, enable the adapter */
+	if (state == PRESENT) {
+		dbg("%s : slot[%s] is occupid.\n", __FUNCTION__, slot->name);
+		if ((slot->dev.pci_dev =
+		     rpaphp_config_pci_adapter(slot)) != NULL) {
+			slot->state = CONFIGURED;
+			dbg("%s: PCI adapter %s in slot[%s] has been configured\n", 
+				__FUNCTION__, pci_name(slot->dev.pci_dev), slot->name);
+		} else {
+			slot->state = NOT_CONFIGURED;
+			dbg("%s: no pci_dev struct for adapter in slot[%s]\n",
+			    __FUNCTION__, slot->name);
+		}
+	} else if (state == EMPTY) {
+		dbg("%s : slot[%s] is empty\n", __FUNCTION__, slot->name);
+		slot->state = EMPTY;
+	} else {
+		err("%s: slot[%s] is in invalid state\n", __FUNCTION__,
+		    slot->name);
+		slot->state = NOT_VALID;
+		retval = -EINVAL;
+	}
+      exit:
+	if (slot->state != NOT_VALID)
+		rpaphp_set_attention_status(slot, LED_ON);
+	else
+		rpaphp_set_attention_status(slot, LED_ID);
+	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
+	return retval;
+}
diff -Nru a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpaphp_slot.c	Fri Mar 19 15:21:26 2004
@@ -0,0 +1,188 @@
+/*
+ * RPA Virtual I/O device functions 
+ * Copyright (C) 2004 Linda Xie <lxie@us.ibm.com>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <lxie@us.ibm.com>
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/pci.h>
+#include "rpaphp.h"
+
+/* free up the memory user by a slot */
+
+static void rpaphp_release_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = hotplug_slot? (struct slot *) hotplug_slot->private:NULL;
+
+	if (slot == NULL)
+		return;
+
+	dealloc_slot_struct(slot);
+}
+
+void dealloc_slot_struct(struct slot *slot)
+{
+	kfree(slot->hotplug_slot->info);
+	kfree(slot->hotplug_slot->name);
+	kfree(slot->hotplug_slot);
+	kfree(slot);
+	return;
+}
+
+struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name,
+		  int power_domain)
+{
+	struct slot *slot;
+	
+	dbg("Enter alloc_slot_struct(): dn->full_name=%s drc_index=0x%x drc_name=%s\n",
+		dn->full_name, drc_index, drc_name);
+
+	slot = kmalloc(sizeof (struct slot), GFP_KERNEL);
+	if (!slot)
+		return (NULL);
+	memset(slot, 0, sizeof (struct slot));
+	slot->hotplug_slot = kmalloc(sizeof (struct hotplug_slot), GFP_KERNEL);
+	if (!slot->hotplug_slot) {
+		kfree(slot);
+		return (NULL);
+	}
+	memset(slot->hotplug_slot, 0, sizeof (struct hotplug_slot));
+	slot->hotplug_slot->info = kmalloc(sizeof (struct hotplug_slot_info),
+					   GFP_KERNEL);
+	if (!slot->hotplug_slot->info) {
+		kfree(slot->hotplug_slot);
+		kfree(slot);
+		return (NULL);
+	}
+	memset(slot->hotplug_slot->info, 0, sizeof (struct hotplug_slot_info));
+	slot->hotplug_slot->name = kmalloc(strlen(drc_name) + 1, GFP_KERNEL);
+	if (!slot->hotplug_slot->name) {
+		kfree(slot->hotplug_slot->info);
+		kfree(slot->hotplug_slot);
+		kfree(slot);
+		return (NULL);
+	}
+	slot->name = slot->hotplug_slot->name;
+	slot->dn = dn;
+	slot->index = drc_index;
+	strcpy(slot->name, drc_name);
+	slot->power_domain = power_domain;
+	slot->magic = SLOT_MAGIC;
+	slot->hotplug_slot->private = slot;
+	slot->hotplug_slot->ops = &rpaphp_hotplug_slot_ops;
+	slot->hotplug_slot->release = &rpaphp_release_slot;
+	dbg("Exit alloc_slot_struct(): slot->dn->full_name=%s drc_index=0x%x drc_name=%s\n",
+		slot->dn->full_name, slot->index, slot->name);
+	return (slot);
+}
+
+int register_slot(struct slot *slot)
+{
+	int retval;
+	char *vio_uni_addr = NULL;
+
+	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n", __FUNCTION__, slot->dn->full_name, slot->index, slot->name, slot->power_domain, slot->type);
+
+	retval = pci_hp_register(slot->hotplug_slot);
+	if (retval) {
+		err("pci_hp_register failed with error %d\n", retval);
+		rpaphp_release_slot(slot->hotplug_slot);
+		return (retval);
+	}
+	switch (slot->dev_type) {
+	case PCI_DEV:
+		/* create symlink between slot->name and it's bus_id */
+
+		dbg("%s: sysfs_create_link: %s --> %s\n", __FUNCTION__,
+		    pci_name(slot->bridge), slot->name);
+
+		retval = sysfs_create_link(slot->hotplug_slot->kobj.parent,
+					   &slot->hotplug_slot->kobj,
+					   pci_name(slot->bridge));
+		if (retval) {
+			err("sysfs_create_link failed with error %d\n", retval);
+			rpaphp_release_slot(slot->hotplug_slot);
+			return (retval);
+		}
+		break;
+	case VIO_DEV:
+		/* create symlink between slot->name and it's uni-address */
+		vio_uni_addr = strchr(slot->dn->full_name, '@');
+		if (!vio_uni_addr)
+			return (1);
+		dbg("%s: sysfs_create_link: %s --> %s\n", __FUNCTION__,
+		    vio_uni_addr, slot->name);
+		retval = sysfs_create_link(slot->hotplug_slot->kobj.parent,
+					   &slot->hotplug_slot->kobj,
+					   vio_uni_addr);
+		if (retval) {
+			err("sysfs_create_link failed with error %d\n", retval);
+			rpaphp_release_slot(slot->hotplug_slot);
+			return (retval);
+		}
+		break;
+	default:
+		return (1);
+	}
+
+	/* add slot to our internal list */
+	dbg("%s adding slot[%s] to rpaphp_slot_list\n",
+	    __FUNCTION__, slot->name);
+
+	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
+
+	if (vio_uni_addr)
+		info("Slot [%s](vio_uni_addr=%s) registered\n",
+		     slot->name, vio_uni_addr);
+	else
+		info("Slot [%s](bus_id=%s) registered\n",
+		     slot->name, pci_name(slot->bridge));
+	num_slots++;
+	return (0);
+}
+
+int rpaphp_get_power_status(struct slot *slot, u8 * value)
+{
+	int rc;
+
+	rc = rtas_get_power_level(slot->power_domain, (int *) value);
+	if (rc)
+		err("failed to get power-level for slot(%s), rc=0x%x\n",
+		    slot->name, rc);
+
+	return rc;
+}
+
+int rpaphp_set_attention_status(struct slot *slot, u8 status)
+{
+	int rc;
+
+	/* status: LED_OFF or LED_ON */
+	rc = rtas_set_indicator(DR_INDICATOR, slot->index, status);
+	if (rc)
+		err("slot(%s) set attention-status(%d) failed! rc=0x%x\n",
+		    slot->name, status, rc);
+
+	return rc;
+}
diff -Nru a/drivers/pci/hotplug/rpaphp_vio.c b/drivers/pci/hotplug/rpaphp_vio.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/hotplug/rpaphp_vio.c	Fri Mar 19 15:21:26 2004
@@ -0,0 +1,121 @@
+/*
+ * RPA Hot Plug Virtual I/O device functions 
+ * Copyright (C) 2004 Linda Xie <lxie@us.ibm.com>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <lxie@us.ibm.com>
+ *
+ */
+#include <asm/vio.h>
+#include "rpaphp.h"
+
+/*
+ * get_vio_adapter_status - get  the status of a slot
+ * 
+ * status:
+ * 
+ * 1-- adapter is configured
+ * 2-- adapter is not configured
+ * 3-- not valid
+ */
+inline int rpaphp_get_vio_adapter_status(struct slot *slot, int is_init, u8 *value)
+{
+	*value = slot->state;
+	return 0;
+}
+
+int rpaphp_unconfig_vio_adapter(struct slot *slot)
+{
+	int retval = 0;
+
+	dbg("Entry %s: slot[%s]\n", __FUNCTION__, slot->name);
+	if (!slot->dev.vio_dev) {
+		info("%s: no VIOA in slot[%s]\n", __FUNCTION__, slot->name);
+		retval = -EINVAL;
+		goto exit;
+	}
+	/* remove the device from the vio core */
+	vio_unregister_device(slot->dev.vio_dev);
+	slot->state = NOT_CONFIGURED;
+	info("%s: adapter in slot[%s] unconfigured.\n", __FUNCTION__, slot->name);
+exit:
+	dbg("Exit %s, rc=0x%x\n", __FUNCTION__, retval);
+	return retval;
+}
+
+static int setup_vio_hotplug_slot_info(struct slot *slot)
+{
+	slot->hotplug_slot->info->power_status = 1;
+	rpaphp_get_vio_adapter_status(slot, 1,
+		&slot->hotplug_slot->info->adapter_status); 
+	return 0;
+}
+
+int register_vio_slot(struct device_node *dn)
+{
+	u32 *index;
+	char *name;
+	int rc = 1;
+	struct slot *slot = NULL;
+	
+	index = (u32 *) get_property(dn, "ibm,my-drc-index", NULL);
+	if (!index)
+		goto exit_rc;
+	name = get_property(dn, "ibm,loc-code", NULL);
+	if (!name)
+		goto exit_rc;
+	if (!(slot = alloc_slot_struct(dn, *index, name, 0))) {
+		rc = -ENOMEM;
+		goto exit_rc;
+	}
+	slot->dev_type = VIO_DEV;
+	slot->dev.vio_dev = vio_find_node(dn);
+	if (!slot->dev.vio_dev)
+		slot->dev.vio_dev = vio_register_device(dn);
+	if (slot->dev.vio_dev)
+		slot->state = CONFIGURED;
+	else
+		slot->state = NOT_CONFIGURED;
+	if (setup_vio_hotplug_slot_info(slot))
+		goto exit_rc;
+	info("%s: registered VIO device[name=%s vio_dev=%p]\n",
+		__FUNCTION__, slot->name, slot->dev.vio_dev); 
+	rc = register_slot(slot);
+exit_rc:
+	if (rc && slot)
+		dealloc_slot_struct(slot);
+	return (rc);
+}
+
+int rpaphp_enable_vio_slot(struct slot *slot)
+{
+	int retval = 0;
+
+	if ((slot->dev.vio_dev = vio_register_device(slot->dn))) {
+		info("%s: VIO adapter %s in slot[%s] has been configured\n",
+			__FUNCTION__, slot->dn->name, slot->name);
+		slot->state = CONFIGURED;
+	} else {
+		info("%s: no vio_dev struct for adapter in slot[%s]\n",
+			__FUNCTION__, slot->name);
+		slot->state = NOT_CONFIGURED;
+	}
+	
+	return retval;
+}

