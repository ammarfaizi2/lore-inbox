Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265774AbUFXWPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265774AbUFXWPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUFXWPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:15:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:42166 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265774AbUFXVrg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:36 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <1088113567782@kroah.com>
Date: Thu, 24 Jun 2004 14:46:07 -0700
Message-Id: <1088113567381@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.103.4, 2004/06/11 17:15:38-07:00, lxiep@us.ibm.com

[PATCH] PCI Hotplug: rpaphp.patch -- multi-function devices not handled correctly

I made changes to rpaphp code, so it can handle multi-fuction
devices correctly. The problem is that the pci_dev field of slot struct
can only record one pci_dev of  the devices of a multi-fuction card.  I
changed pci_dev (a single pci_dev type pointer) to pci_funcs( a list of
pci_dev type pointers). I  rewrote some of the config/unconfig code to
support  the slot struct change.

Along with above changes,  I added LDRSLOT(logical I/O slot) support.
We need LDRSLOT support for DLPAR I/O.  A card in a LDRSLOT can't be
physically removed, but can be logically removed  from one partiton and
reassinged to another partition.

I also merged rpaphp changes from ames tree.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpadlpar_core.c |   28 ---
 drivers/pci/hotplug/rpaphp.h        |   28 ++-
 drivers/pci/hotplug/rpaphp_core.c   |  199 +++++++++++++++------
 drivers/pci/hotplug/rpaphp_pci.c    |  328 +++++++++++++++++++++++++-----------
 drivers/pci/hotplug/rpaphp_slot.c   |  136 ++++++++++++--
 drivers/pci/hotplug/rpaphp_vio.c    |    6 
 6 files changed, 508 insertions(+), 217 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
--- a/drivers/pci/hotplug/rpadlpar_core.c	2004-06-24 13:51:19 -07:00
+++ b/drivers/pci/hotplug/rpadlpar_core.c	2004-06-24 13:51:19 -07:00
@@ -24,25 +24,6 @@
 
 static DECLARE_MUTEX(rpadlpar_sem);
 
-static inline int is_hotplug_capable(struct device_node *dn)
-{
-	unsigned char *ptr = get_property(dn, "ibm,fw-pci-hot-plug-ctrl", NULL);
-
-	return (int) (ptr != NULL);
-}
-
-static char *get_node_drc_name(struct device_node *dn)
-{
-	char *ptr = NULL;
-	int *drc_names;
-
-	drc_names = (int *) get_property(dn, "ibm,drc-names", NULL);
-	if (drc_names)
-		ptr = (char *) &drc_names[1];
-
-	return ptr;
-}
-
 static struct device_node *find_php_slot_vio_node(char *drc_name)
 {
 	struct device_node *child;
@@ -53,9 +34,9 @@
 		return NULL;
 
 	for (child = of_get_next_child(parent, NULL);
-	     child; child = of_get_next_child(parent, child)) {
+		child; child = of_get_next_child(parent, child)) {
 		loc_code = get_property(child, "ibm,loc-code", NULL);
-		if (loc_code && !strcmp(loc_code, drc_name))
+		if (loc_code && !strncmp(loc_code, drc_name, strlen(drc_name)))
 			return child;
 	}
 
@@ -69,7 +50,7 @@
 
 	while ((np = of_find_node_by_type(np, "pci")))
 		if (is_hotplug_capable(np)) {
-			name = get_node_drc_name(np);
+			name = rpaphp_get_drc_name(np);
 			if (name && (!strcmp(drc_name, name)))
 				break;
 		}
@@ -324,6 +305,7 @@
 	}
 
 	/* Remove pci bus */
+
 	if (dlpar_pci_remove_bus(bridge_dev)) {
 		printk(KERN_ERR "%s: unable to remove pci bus %s\n",
 			__FUNCTION__, drc_name);
@@ -364,7 +346,7 @@
 		rc = -EINVAL;
 		goto exit;
 	}
-
+	
 	switch (slot->dev_type) {
 		case PCI_DEV:
 			rc = dlpar_remove_pci_slot(slot, drc_name);
diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	2004-06-24 13:51:19 -07:00
+++ b/drivers/pci/hotplug/rpaphp.h	2004-06-24 13:51:19 -07:00
@@ -30,6 +30,9 @@
 #include <linux/pci.h>
 #include "pci_hotplug.h"
 
+#define	HOTPLUG	1
+#define	EMBEDDED 0
+
 #define DR_INDICATOR 9002
 #define DR_ENTITY_SENSE 9003
 
@@ -73,6 +76,11 @@
 #define	CONFIGURED	1
 #define	EMPTY		0
 
+struct rpaphp_pci_func {
+	struct pci_dev *pci_dev;
+	struct list_head sibling;
+};
+
 /*
  * struct slot - slot information for each *physical* slot
  */
@@ -83,14 +91,13 @@
 	u32 power_domain;
 	char *name;
 	char *location;
+	u8 removable;
 	struct device_node *dn;	/* slot's device_node in OFDT */
-	/* dn has phb info */
+				/* dn has phb info */
 	struct pci_dev *bridge;	/* slot's pci_dev in pci_devices */
 	union {
-		struct pci_dev *pci_dev;	/* pci_dev of device in this slot */
-		/* it will be used for unconfig */
-		/* NULL if slot is empty */
-		struct vio_dev *vio_dev;	/* vio_dev of the device in this slot */
+		struct list_head pci_funcs; /* pci_devs in PCI slot */ 
+		struct vio_dev *vio_dev; /* vio_dev in VIO slot */
 	} dev;
 	u8 dev_type;		/* VIO or PCI */
 	struct hotplug_slot *hotplug_slot;
@@ -101,6 +108,13 @@
 extern struct list_head rpaphp_slot_head;
 extern int num_slots;
 
+static inline int is_hotplug_capable(struct device_node *dn)
+{
+	unsigned char *ptr = get_property(dn, "ibm,fw-pci-hot-plug-ctrl", NULL);
+
+	return (int) (ptr != NULL);
+}
+
 /* function prototypes */
 
 /* rpaphp_pci.c */
@@ -110,10 +124,12 @@
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_unconfig_pci_adapter(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
+extern struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev);
 
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
 extern int rpaphp_remove_slot(struct slot *slot);
+extern char *rpaphp_get_drc_name(struct device_node *dn);
 
 /* rpaphp_vio.c */
 extern int rpaphp_get_vio_adapter_status(struct slot *slot, int is_init, u8 * value);
@@ -125,8 +141,8 @@
 extern void dealloc_slot_struct(struct slot *slot);
 extern struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name, int power_domain);
 extern int register_slot(struct slot *slot);
+extern int deregister_slot(struct slot *slot);
 extern int rpaphp_get_power_status(struct slot *slot, u8 * value);
 extern int rpaphp_set_attention_status(struct slot *slot, u8 status);
-extern void rpaphp_sysfs_remove_attr_location(struct hotplug_slot *slot);
 	
 #endif				/* _PPC64PHP_H */
diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	2004-06-24 13:51:19 -07:00
+++ b/drivers/pci/hotplug/rpaphp_core.c	2004-06-24 13:51:19 -07:00
@@ -54,6 +54,8 @@
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
+void eeh_register_disable_func(int (*)(struct pci_dev *));
+
 module_param(debug, bool, 0644);
 
 static int enable_slot(struct hotplug_slot *slot);
@@ -63,6 +65,7 @@
 static int get_attention_status(struct hotplug_slot *slot, u8 * value);
 static int get_adapter_status(struct hotplug_slot *slot, u8 * value);
 static int get_max_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
+static int rpaphp_disable_slot(struct pci_dev *dev);
 
 struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
 	.owner = THIS_MODULE,
@@ -89,7 +92,7 @@
  */
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 {
-	int retval;
+	int retval = 0;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 
 	down(&rpaphp_sem);
@@ -208,47 +211,53 @@
 
 int rpaphp_remove_slot(struct slot *slot)
 {
-	int retval = 0;
-	struct hotplug_slot *php_slot = slot->hotplug_slot;
-
-	list_del(&slot->rpaphp_slot_list);
-	
-	/* remove "php_location" file */
-	rpaphp_sysfs_remove_attr_location(php_slot);
-
-	retval = pci_hp_deregister(php_slot);
-	if (retval)
-		err("Problem unregistering a slot %s\n", slot->name);
-
-	num_slots--;
-
-	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
-	return retval;
+	return deregister_slot(slot);
 }
 
-static int is_php_dn(struct device_node *dn, int **indexes, int **names, int **types,
-	  int **power_domains)
+static int get_dn_properties(struct device_node *dn, int **indexes, int **names, 
+	int **types, int **power_domains)
 {
 	*indexes = (int *) get_property(dn, "ibm,drc-indexes", NULL);
-	if (!*indexes)
-		return 0;
+
 	/* &names[1] contains NULL terminated slot names */
 	*names = (int *) get_property(dn, "ibm,drc-names", NULL);
-	if (!*names)
-		return 0;
+
 	/* &types[1] contains NULL terminated slot types */
 	*types = (int *) get_property(dn, "ibm,drc-types", NULL);
-	if (!*types)
-		return 0;
+
 	/* power_domains[1...n] are the slot power domains */
-	*power_domains = (int *) get_property(dn,
-					      "ibm,drc-power-domains", NULL);
-	if (!*power_domains)
-		return 0;
-	if (strcmp(dn->name, "pci") == 0 &&
-			!get_property(dn, "ibm,fw-pci-hot-plug-ctrl", NULL))
-		return 0;
-	return 1;
+	*power_domains = (int *) get_property(dn, "ibm,drc-power-domains", NULL);
+	
+	if (*indexes && *names && *types && *power_domains) 
+		return (1);
+	
+	return (0);
+}
+
+static int is_php_dn(struct device_node *dn, int **indexes, int **names, int **types,
+	  int **power_domains)
+{
+	if (!is_hotplug_capable(dn))
+		return (0);
+	if (!get_dn_properties(dn, indexes, names, types, power_domains))
+		return (0);
+	return (1);
+}
+
+static int is_dr_dn(struct device_node *dn, int **indexes, int **names, int **types,
+	  int **power_domains, int **my_drc_index)
+{
+	if (!is_hotplug_capable(dn))
+		return (0);
+
+	*my_drc_index = (int *) get_property(dn, "ibm,my-drc-index", NULL);
+	if(!*my_drc_index) 		
+		return (0);
+
+	if (!dn->parent)
+		return (0);
+
+	return get_dn_properties(dn->parent, indexes, names, types, power_domains);
 }
 
 static inline int is_vdevice_root(struct device_node *dn)
@@ -256,15 +265,48 @@
 	return !strcmp(dn->name, "vdevice");
 }
 
-/**
- * rpaphp_add_slot: Add  Hot Plug slot(s) to sysfs
- *
- */
+char *rpaphp_get_drc_name(struct device_node *dn)
+{
+	char *name, *ptr = NULL;
+	int *drc_names, *drc_indexes, i;
+	struct device_node *parent = dn->parent;	
+	u32 *my_drc_index;
+
+	if (!parent)
+		return NULL;
+
+	my_drc_index = (u32 *) get_property(dn, "ibm,my-drc-index", NULL);
+	if (!my_drc_index)
+		return NULL;	
+
+	drc_names = (int *) get_property(parent, "ibm,drc-names", NULL);
+	drc_indexes = (int *) get_property(parent, "ibm,drc-indexes", NULL);
+	if (!drc_names || !drc_indexes)
+		return NULL;
+
+	name = (char *) &drc_names[1];
+	for (i = 0; i < drc_indexes[0]; i++, name += (strlen(name) + 1)) {
+		if (drc_indexes[i + 1] == *my_drc_index) {
+			ptr = (char *) name;
+			break;
+		}
+	}
+
+	return ptr;
+}
+
+/****************************************************************
+ *	rpaphp not only registers PCI hotplug slots(HOTPLUG), 
+ *	but also logical DR slots(EMBEDDED).
+ *	HOTPLUG slot: An adapter can be physically added/removed. 
+ *	EMBEDDED slot: An adapter can be logically removed/added
+ *		  from/to a partition with the slot.
+ ***************************************************************/
 int rpaphp_add_slot(struct device_node *dn)
 {
 	struct slot *slot;
 	int retval = 0;
-	int i;
+	int i, *my_drc_index, slot_type;
 	int *indexes, *names, *types, *power_domains;
 	char *name, *type;
 
@@ -277,42 +319,65 @@
 	}
 
 	/* register PCI devices */
-	if (dn->name != 0 && strcmp(dn->name, "pci") == 0 &&
-	    is_php_dn(dn, &indexes, &names, &types, &power_domains)) {
+	if (dn->name != 0 && strcmp(dn->name, "pci") == 0) {
+		if (is_php_dn(dn, &indexes, &names, &types, &power_domains))  
+			slot_type = HOTPLUG;
+		else if (is_dr_dn(dn, &indexes, &names, &types, &power_domains, &my_drc_index)) 
+			slot_type = EMBEDDED;
+		else goto exit;
 
 		name = (char *) &names[1];
 		type = (char *) &types[1];
-		for (i = 0; i < indexes[0];
-					i++,
-					name += (strlen(name) + 1),
-					type += (strlen(type) + 1)) {
-			if (!(slot = alloc_slot_struct(dn, indexes[i + 1], name,
-						       power_domains[i + 1]))) {
-				retval = -ENOMEM;
-				goto exit;
-			}
-			slot->type = simple_strtoul(type, NULL, 10);
-			if (slot->type < 1 || slot->type > 16)
-				slot->type = 0;
-			retval = register_pci_slot(slot);
+		for (i = 0; i < indexes[0]; i++,
+	     		name += (strlen(name) + 1), type += (strlen(type) + 1)) {
 
-		}		/* for indexes */
-	}			/* end of PCI device_node */
+			if ( slot_type == HOTPLUG || 
+				(slot_type == EMBEDDED && indexes[i + 1] == my_drc_index[0])) {
+				
+				if (!(slot = alloc_slot_struct(dn, indexes[i + 1], name,
+					       power_domains[i + 1]))) {
+					retval = -ENOMEM;
+					goto exit;
+				}
+				if (slot_type == EMBEDDED)
+					slot->type = EMBEDDED;
+				else
+					slot->type = simple_strtoul(type, NULL, 10);
+				
+				dbg("    Found drc-index:0x%x drc-name:%s drc-type:%s\n",
+					indexes[i + 1], name, type);
+
+				retval = register_pci_slot(slot);
+				if (slot_type == EMBEDDED)
+					goto exit;
+			}
+		}
+	}
 exit:
 	dbg("%s - Exit: num_slots=%d rc[%d]\n",
 	    __FUNCTION__, num_slots, retval);
 	return retval;
 }
 
-static int __init init_rpa(void)
+/*
+ * init_slots - initialize 'struct slot' structures for each slot
+ *
+ */
+static void init_slots(void)
 {
 	struct device_node *dn;
 
+	for (dn = find_all_nodes(); dn; dn = dn->next)
+		rpaphp_add_slot(dn);
+}
+
+static int __init init_rpa(void)
+{
+
 	init_MUTEX(&rpaphp_sem);
 
 	/* initialize internal data structure etc. */
-	for (dn = find_all_nodes(); dn; dn = dn->next)
-		rpaphp_add_slot(dn);
+	init_slots();
 	if (!num_slots)
 		return -ENODEV;
 
@@ -342,12 +407,18 @@
 {
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
+	/* let EEH know they can use hotplug */
+	eeh_register_disable_func(&rpaphp_disable_slot);
+
 	/* read all the PRA info from the system */
 	return init_rpa();
 }
 
 static void __exit rpaphp_exit(void)
 {
+	/* let EEH know we are going away */
+	eeh_register_disable_func(NULL);
+
 	cleanup_slots();
 }
 
@@ -374,11 +445,16 @@
 		retval = -EINVAL;
 	}
 	up(&rpaphp_sem);
-      exit:
+exit:
 	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
 }
 
+static int rpaphp_disable_slot(struct pci_dev *dev)
+{
+	return disable_slot(rpaphp_find_hotplug_slot(dev));
+}
+
 static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
 	int retval;
@@ -395,9 +471,7 @@
 	down(&rpaphp_sem);
 	switch (slot->dev_type) {
 	case PCI_DEV:
-		rpaphp_set_attention_status(slot, LED_ID);
 		retval = rpaphp_unconfig_pci_adapter(slot);
-		rpaphp_set_attention_status(slot, LED_OFF);
 		break;
 	case VIO_DEV:
 		retval = rpaphp_unconfig_vio_adapter(slot);
@@ -406,7 +480,7 @@
 		retval = -ENODEV;
 	}
 	up(&rpaphp_sem);
-      exit:
+exit:
 	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
 }
@@ -417,3 +491,4 @@
 EXPORT_SYMBOL_GPL(rpaphp_add_slot);
 EXPORT_SYMBOL_GPL(rpaphp_remove_slot);
 EXPORT_SYMBOL_GPL(rpaphp_slot_head);
+EXPORT_SYMBOL_GPL(rpaphp_get_drc_name);
diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	2004-06-24 13:51:19 -07:00
+++ b/drivers/pci/hotplug/rpaphp_pci.c	2004-06-24 13:51:19 -07:00
@@ -30,24 +30,18 @@
 
 struct pci_dev *rpaphp_find_pci_dev(struct device_node *dn)
 {
-	struct pci_dev *retval_dev = NULL, *dev;
+	struct pci_dev *retval_dev = NULL, *dev = NULL;
 	char bus_id[BUS_ID_SIZE];
 
 	sprintf(bus_id, "%04x:%02x:%02x.%d",dn->phb->global_number,
 		dn->busno, PCI_SLOT(dn->devfn), PCI_FUNC(dn->devfn));
-
-	dbg("Enter rpaphp_find_pci_dev() full_name=%s bus_id=%s\n", 
-		dn->full_name, bus_id);
-	
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-               if (!strcmp(pci_name(dev), bus_id)) {
+		if (!strcmp(pci_name(dev), bus_id)) {
 			retval_dev = dev;
-			dbg("rpaphp_find_pci_dev(): found dev=%p\n\n", dev);
 			break;
 		}
 	}
 	return retval_dev;
-
 }
 
 EXPORT_SYMBOL_GPL(rpaphp_find_pci_dev);
@@ -79,11 +73,6 @@
 	return rpaphp_find_pci_dev(slot->dn);
 }
 
-static struct pci_dev *rpaphp_find_adapter_pdev(struct slot *slot)
-{
-	return rpaphp_find_pci_dev(slot->dn->child);
-}
-
 static int rpaphp_get_sensor_state(struct slot *slot, int *state)
 {
 	int rc;
@@ -144,7 +133,8 @@
 			else if (rpaphp_find_pci_dev(slot->dn->child))
 				*value = CONFIGURED;
 			else {
-				dbg("%s: can't find pdev of adapter in slot[%s]\n", __FUNCTION__, slot->name);
+				err("%s: can't find pdev of adapter in slot[%s]\n", 
+					__FUNCTION__, slot->dn->full_name);
 				*value = NOT_CONFIGURED;
 			}
 		}
@@ -158,7 +148,8 @@
 }
 
 /* Must be called before pci_bus_add_devices */
-static void rpaphp_fixup_new_pci_devices(struct pci_bus *bus)
+static void 
+rpaphp_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus)
 {
 	struct pci_dev *dev;
 
@@ -169,8 +160,9 @@
 		 */
 		if (list_empty(&dev->global_list)) {
 			int i;
-
-			pcibios_fixup_device_resources(dev, bus);
+			
+			if(fix_bus)
+				pcibios_fixup_device_resources(dev, bus);
 			pci_read_irq_line(dev);
 			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 				struct resource *r = &dev->resource[i];
@@ -183,69 +175,139 @@
 	}
 }
 
-static void
-rpaphp_pci_config_device(struct pci_bus *pci_bus, struct device_node *dn)
-{
-	int num;
-
-	num = pci_scan_slot(pci_bus, PCI_DEVFN(PCI_SLOT(dn->devfn), 0));
-	if (num) {
-		rpaphp_fixup_new_pci_devices(pci_bus);
-		pci_bus_add_devices(pci_bus);
-	}
-}
-
-static int rpaphp_pci_config_bridge(struct pci_dev *dev, struct device_node *dn);
+static int rpaphp_pci_config_bridge(struct pci_dev *dev);
 
 /*****************************************************************************
- rpaphp_pci_config_dn() will recursively configure all devices under the 
- given slot->dn and return the dn's pci_dev.
+ rpaphp_pci_config_slot() will  configure all devices under the 
+ given slot->dn and return the the first pci_dev.
  *****************************************************************************/
 static struct pci_dev *
-rpaphp_pci_config_dn(struct device_node *dn, struct pci_bus *bus)
+rpaphp_pci_config_slot(struct device_node *dn, struct pci_bus *bus)
 {
-	struct device_node *local;
+	struct device_node *eads_first_child = dn->child;
 	struct pci_dev *dev;
+	int num;
+	
+	dbg("Enter %s: dn=%s bus=%s\n", __FUNCTION__, dn->full_name, bus->name);
 
-	for (local = dn->child; local; local = local->sibling) {
-		rpaphp_pci_config_device(bus, local);
-		dev = rpaphp_find_pci_dev(local);
-		if (!rpaphp_pci_config_bridge(dev, local))
+	if (eads_first_child) {
+		/* pci_scan_slot should find all children of EADs */
+		num = pci_scan_slot(bus, PCI_DEVFN(PCI_SLOT(eads_first_child->devfn), 0));
+		if (num) {
+			rpaphp_fixup_new_pci_devices(bus, 1); 
+			pci_bus_add_devices(bus);
+		}
+		dev = rpaphp_find_pci_dev(eads_first_child);
+		if (!dev) {
+			err("No new device found\n");
 			return NULL;
+		}
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) 
+			rpaphp_pci_config_bridge(dev);
 	}
-
 	return dev;
 }
 
-static int rpaphp_pci_config_bridge(struct pci_dev *dev, struct device_node *dn)
+static int rpaphp_pci_config_bridge(struct pci_dev *dev)
 {
-	if (dev && dn->child) {	/* dn is a PCI bridge node */
-		struct pci_bus *child;
-		u8 sec_busno;
-
-		/* get busno of downstream bus */
-		pci_read_config_byte(dev, PCI_SECONDARY_BUS, &sec_busno);
-
-		/* add to children of PCI bridge dev->bus */
-		child = pci_add_new_bus(dev->bus, dev, sec_busno);
-		if (!child) {
-			err("%s: could not add second bus\n", __FUNCTION__);
-			return 0;
-		}
-		sprintf(child->name, "PCI Bus #%02x", child->number);
-		/* Fixup subordinate bridge bases and resureces */
-		pcibios_fixup_bus(child);
+	u8 sec_busno;
+	struct pci_bus *child_bus;
+	struct pci_dev *child_dev;
+
+	dbg("Enter %s:  BRIDGE dev=%s\n", __FUNCTION__, pci_name(dev));
 
-		/* may need do more stuff here */
-		rpaphp_pci_config_dn(dn, dev->subordinate);
+	/* get busno of downstream bus */
+	pci_read_config_byte(dev, PCI_SECONDARY_BUS, &sec_busno);
+		
+	/* add to children of PCI bridge dev->bus */
+	child_bus = pci_add_new_bus(dev->bus, dev, sec_busno);
+	if (!child_bus) {
+		err("%s: could not add second bus\n", __FUNCTION__);
+		return -EIO;
 	}
-	return 1;
+	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
+	/* do pci_scan_child_bus */
+	pci_scan_child_bus(child_bus);
+
+	list_for_each_entry(child_dev, &child_bus->devices, bus_list) {
+		eeh_add_device_late(child_dev);
+	}
+
+	 /* fixup new pci devices without touching bus struct */
+	rpaphp_fixup_new_pci_devices(child_bus, 0);
+
+	/* Make the discovered devices available */
+	pci_bus_add_devices(child_bus);
+	return 0;
+}
+
+static void enable_eeh(struct device_node *dn)
+{
+	struct device_node *sib;
+
+	for (sib = dn->child; sib; sib = sib->sibling) 
+		enable_eeh(sib);
+	eeh_add_device_early(dn);
+	return;
+	
+}
+
+#ifdef DEBUG
+static void print_slot_pci_funcs(struct slot *slot)
+{
+	struct list_head *l;
+
+	if (slot->dev_type == PCI_DEV) {
+		printk("pci_funcs of slot[%s]\n", slot->name);
+		if (list_empty(&slot->dev.pci_funcs))
+			printk("	pci_funcs is EMPTY\n");
+
+		list_for_each (l, &slot->dev.pci_funcs) {
+			struct rpaphp_pci_func *func =
+				list_entry(l, struct rpaphp_pci_func, sibling);
+			printk("	FOUND dev=%s\n", pci_name(func->pci_dev));
+		}
+	}
+	return;
+}
+#else
+static void print_slot_pci_funcs(struct slot *slot)
+{
+	return;
+}
+#endif
+
+static int init_slot_pci_funcs(struct slot *slot)
+{
+	struct device_node *child;
+
+	for (child = slot->dn->child; child != NULL; child = child->sibling) {
+		struct pci_dev *pdev = rpaphp_find_pci_dev(child);
+
+		if (pdev) {
+			struct rpaphp_pci_func *func;
+			func = kmalloc(sizeof(struct rpaphp_pci_func), GFP_KERNEL);
+			if (!func) 
+				return -ENOMEM;
+			memset(func, 0, sizeof(struct rpaphp_pci_func));
+			INIT_LIST_HEAD(&func->sibling);
+			func->pci_dev = pdev;
+			list_add_tail(&func->sibling, &slot->dev.pci_funcs);
+			print_slot_pci_funcs(slot);
+		} else {
+			err("%s: dn=%s has no pci_dev\n", 
+				__FUNCTION__, child->full_name);
+			return -EIO;
+		}
+	}
+	return 0;
 }
 
-static struct pci_dev *rpaphp_config_pci_adapter(struct slot *slot)
+static int rpaphp_config_pci_adapter(struct slot *slot)
 {
 	struct pci_bus *pci_bus;
-	struct pci_dev *dev = NULL;
+	struct pci_dev *dev;
+	int rc = -ENODEV;
 
 	dbg("Entry %s: slot[%s]\n", __FUNCTION__, slot->name);
 
@@ -256,38 +318,74 @@
 			err("%s: can't find bus structure\n", __FUNCTION__);
 			goto exit;
 		}
-
-		eeh_add_device_early(slot->dn->child);
-		dev = rpaphp_pci_config_dn(slot->dn, pci_bus);
-		eeh_add_device_late(dev);
+		enable_eeh(slot->dn);
+		dev = rpaphp_pci_config_slot(slot->dn, pci_bus);
+		if (!dev) {
+			err("%s: can't find any devices.\n", __FUNCTION__);
+			goto exit;
+		}
+		/* associate corresponding pci_dev */	
+		rc = init_slot_pci_funcs(slot);
+		if (rc)
+			goto exit;
+		print_slot_pci_funcs(slot);
+		if (!list_empty(&slot->dev.pci_funcs)) 
+			rc = 0;
 	} else {
 		/* slot is not enabled */
 		err("slot doesn't have pci_dev structure\n");
-		dev = NULL;
 	}
-
 exit:
-	dbg("Exit %s: pci_dev %s\n", __FUNCTION__, dev ? "found" : "not found");
-	return dev;
+	dbg("Exit %s:  rc=%d\n", __FUNCTION__, rc);
+	return rc;
+}
+
+
+static void rpaphp_eeh_remove_bus_device(struct pci_dev *dev)
+{
+	eeh_remove_device(dev);
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		struct pci_bus *bus = dev->subordinate;
+		struct list_head *ln;
+		if (!bus)
+			return; 
+		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
+			struct pci_dev *pdev = pci_dev_b(ln);
+			if (pdev)
+				rpaphp_eeh_remove_bus_device(pdev);
+		}
+
+	}
+	return;
 }
 
 int rpaphp_unconfig_pci_adapter(struct slot *slot)
 {
 	int retval = 0;
+	struct list_head *ln;
 
 	dbg("Entry %s: slot[%s]\n", __FUNCTION__, slot->name);
-	if (!slot->dev.pci_dev) {
-		info("%s: no card in slot[%s]\n", __FUNCTION__, slot->name);
+	if (list_empty(&slot->dev.pci_funcs)) {
+		err("%s: slot[%s] doesn't have any devices.\n", __FUNCTION__, 
+			slot->name);
 
 		retval = -EINVAL;
 		goto exit;
 	}
-	/* remove the device from the pci core */
-	eeh_remove_device(slot->dev.pci_dev);
-	pci_remove_bus_device(slot->dev.pci_dev);
-
+	/* remove the devices from the pci core */
+	list_for_each (ln, &slot->dev.pci_funcs) {
+		struct rpaphp_pci_func *func;
+	
+		func = list_entry(ln, struct rpaphp_pci_func, sibling);
+		if (func->pci_dev) {
+			rpaphp_eeh_remove_bus_device(func->pci_dev);
+			pci_remove_bus_device(func->pci_dev); 
+		}
+		kfree(func);
+	}
+	INIT_LIST_HEAD(&slot->dev.pci_funcs);
 	slot->state = NOT_CONFIGURED;
-	info("%s: adapter in slot[%s] unconfigured.\n", __FUNCTION__,
+	info("%s: devices in slot[%s] unconfigured.\n", __FUNCTION__,
 	     slot->name);
 exit:
 	dbg("Exit %s, rc=0x%x\n", __FUNCTION__, retval);
@@ -303,7 +401,7 @@
 				      &slot->hotplug_slot->info->
 				      adapter_status);
 	if (slot->hotplug_slot->info->adapter_status == NOT_VALID) {
-		dbg("%s: NOT_VALID: skip dn->full_name=%s\n",
+		err("%s: NOT_VALID: skip dn->full_name=%s\n",
 		    __FUNCTION__, slot->dn->full_name);
 		return -1;
 	}
@@ -314,35 +412,41 @@
 {
 	slot->bridge = rpaphp_find_bridge_pdev(slot);
 	if (!slot->bridge) {	/* slot being added doesn't have pci_dev yet */
-		dbg("%s: no pci_dev for bridge dn %s\n", __FUNCTION__, slot->name);
-		dealloc_slot_struct(slot);
-		return 1;
+		err("%s: no pci_dev for bridge dn %s\n", __FUNCTION__, slot->name);
+		goto exit_rc;
 	}
-	
+	dbg("%s set slot->name to %s\n",  __FUNCTION__, pci_name(slot->bridge));
 	strcpy(slot->name, pci_name(slot->bridge));
+
 	/* find slot's pci_dev if it's not empty */
 	if (slot->hotplug_slot->info->adapter_status == EMPTY) {
 		slot->state = EMPTY;	/* slot is empty */
-		slot->dev.pci_dev = NULL;
 	} else {
 		/* slot is occupied */
 		if (!(slot->dn->child)) {
 			/* non-empty slot has to have child */
-			err("%s: slot[%s]'s device_node doesn't have child for adapter\n", __FUNCTION__, slot->name);
-			dealloc_slot_struct(slot);
-			return 1;
+			err("%s: slot[%s]'s device_node doesn't have child for adapter\n", 
+				__FUNCTION__, slot->name);
+			goto exit_rc;
+		}
+		if (init_slot_pci_funcs(slot)) {
+			err("%s: init_slot_pci_funcs failed\n", __FUNCTION__);
+			goto exit_rc;
 		}
-		slot->dev.pci_dev = rpaphp_find_adapter_pdev(slot);
-		if (slot->dev.pci_dev) {
+		print_slot_pci_funcs(slot);
+		if (!list_empty(&slot->dev.pci_funcs)) {
 			slot->state = CONFIGURED;
-		
+	
 		} else {
 			/* DLPAR add as opposed to 
-			 * boot time */
+		 	 * boot time */
 			slot->state = NOT_CONFIGURED;
 		}
 	}
 	return 0;
+exit_rc:
+	dealloc_slot_struct(slot);
+	return 1;
 }
 
 int register_pci_slot(struct slot *slot)
@@ -350,14 +454,17 @@
 	int rc = 1;
 
 	slot->dev_type = PCI_DEV;
+	if (slot->type == EMBEDDED)
+		slot->removable = EMBEDDED;
+	else
+		slot->removable = HOTPLUG;
+	INIT_LIST_HEAD(&slot->dev.pci_funcs);
 	if (setup_pci_hotplug_slot_info(slot))
 		goto exit_rc;
 	if (setup_pci_slot(slot))
 		goto exit_rc;
 	rc = register_slot(slot);
 exit_rc:
-	if (rc)
-		dealloc_slot_struct(slot);
 	return rc;
 }
 
@@ -371,12 +478,12 @@
 	dbg("%s: sensor state[%d]\n", __FUNCTION__, state);
 	/* if slot is not empty, enable the adapter */
 	if (state == PRESENT) {
-		dbg("%s : slot[%s] is occupid.\n", __FUNCTION__, slot->name);
-		if ((slot->dev.pci_dev =
-		     rpaphp_config_pci_adapter(slot)) != NULL) {
+		dbg("%s : slot[%s] is occupied.\n", __FUNCTION__, slot->name);
+		retval = rpaphp_config_pci_adapter(slot);
+		if (!retval) {
 			slot->state = CONFIGURED;
-			dbg("%s: PCI adapter %s in slot[%s] has been configured\n", 
-				__FUNCTION__, pci_name(slot->dev.pci_dev), slot->name);
+			dbg("%s: PCI devices in slot[%s] has been configured\n", 
+				__FUNCTION__, slot->name);
 		} else {
 			slot->state = NOT_CONFIGURED;
 			dbg("%s: no pci_dev struct for adapter in slot[%s]\n",
@@ -392,10 +499,31 @@
 		retval = -EINVAL;
 	}
 exit:
-	if (slot->state != NOT_VALID)
-		rpaphp_set_attention_status(slot, LED_ON);
-	else
-		rpaphp_set_attention_status(slot, LED_ID);
 	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
 }
+
+struct hotplug_slot *rpaphp_find_hotplug_slot(struct pci_dev *dev)
+{
+	struct list_head	*tmp, *n;
+	struct slot		*slot;
+
+	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
+		struct pci_bus *bus;
+		struct list_head *ln;
+
+		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
+		bus = slot->bridge->subordinate;
+		if (!bus)
+			return NULL; /* shouldn't be here */
+		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
+                                struct pci_dev *pdev = pci_dev_b(ln);
+				if (pdev == dev)
+					return slot->hotplug_slot;
+		}
+	}
+
+	return NULL;
+}
+
+EXPORT_SYMBOL_GPL(rpaphp_find_hotplug_slot);
diff -Nru a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
--- a/drivers/pci/hotplug/rpaphp_slot.c	2004-06-24 13:51:19 -07:00
+++ b/drivers/pci/hotplug/rpaphp_slot.c	2004-06-24 13:51:19 -07:00
@@ -29,6 +29,35 @@
 #include <linux/pci.h>
 #include "rpaphp.h"
 
+static ssize_t removable_read_file (struct hotplug_slot *php_slot, char *buf)
+{
+	u8 value;
+	int retval = -ENOENT;
+	struct slot *slot = (struct slot *)php_slot->private;
+
+	if (!slot)
+		return retval;
+
+	value = slot->removable;
+	retval = sprintf (buf, "%d\n", value);
+	return retval;
+}
+
+static struct hotplug_slot_attribute hotplug_slot_attr_removable = {
+	.attr = {.name = "phy_removable", .mode = S_IFREG | S_IRUGO},
+	.show = removable_read_file,
+};
+
+static void rpaphp_sysfs_add_attr_removable (struct hotplug_slot *slot)
+{
+	sysfs_create_file(&slot->kobj, &hotplug_slot_attr_removable.attr);
+}
+
+static void rpaphp_sysfs_remove_attr_removable (struct hotplug_slot *slot)
+{
+	sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_removable.attr);
+}
+
 static ssize_t location_read_file (struct hotplug_slot *php_slot, char *buf)
 {
         char *value;
@@ -53,7 +82,7 @@
 	sysfs_create_file(&slot->kobj, &hotplug_slot_attr_location.attr);
 }
 
-void rpaphp_sysfs_remove_attr_location (struct hotplug_slot *slot)
+static void rpaphp_sysfs_remove_attr_location (struct hotplug_slot *slot)
 {
 	sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_location.attr);
 }
@@ -68,6 +97,17 @@
 
 void dealloc_slot_struct(struct slot *slot)
 {
+	struct list_head *ln, *n;
+
+	if (slot->dev_type == PCI_DEV) {
+		list_for_each_safe (ln, n, &slot->dev.pci_funcs) {
+			struct rpaphp_pci_func *func;
+
+			func = list_entry(ln, struct rpaphp_pci_func, sibling);
+			kfree(func);
+		}
+	}
+
 	kfree(slot->hotplug_slot->info);
 	kfree(slot->hotplug_slot->name);
 	kfree(slot->hotplug_slot);
@@ -86,7 +126,7 @@
 	memset(slot, 0, sizeof (struct slot));
 	slot->hotplug_slot = kmalloc(sizeof (struct hotplug_slot), GFP_KERNEL);
 	if (!slot->hotplug_slot)
-		goto error_slot;
+		goto error_slot;	
 	memset(slot->hotplug_slot, 0, sizeof (struct hotplug_slot));
 	slot->hotplug_slot->info = kmalloc(sizeof (struct hotplug_slot_info),
 					   GFP_KERNEL);
@@ -95,7 +135,7 @@
 	memset(slot->hotplug_slot->info, 0, sizeof (struct hotplug_slot_info));
 	slot->hotplug_slot->name = kmalloc(BUS_ID_SIZE + 1, GFP_KERNEL);
 	if (!slot->hotplug_slot->name)
-		goto error_info;
+		goto error_info;	
 	slot->location = kmalloc(strlen(drc_name) + 1, GFP_KERNEL);
 	if (!slot->location)
 		goto error_name;
@@ -107,9 +147,8 @@
 	slot->hotplug_slot->private = slot;
 	slot->hotplug_slot->ops = &rpaphp_hotplug_slot_ops;
 	slot->hotplug_slot->release = &rpaphp_release_slot;
-	slot->hotplug_slot->info->cur_bus_speed = PCI_SPEED_UNKNOWN;
-
-	return slot;
+	
+	return (slot);
 
 error_name:
 	kfree(slot->hotplug_slot->name);
@@ -123,15 +162,56 @@
 	return NULL;
 }
 
+static int is_registered(struct slot *slot)
+{
+	struct slot             *tmp_slot;
+
+	list_for_each_entry(tmp_slot, &rpaphp_slot_head, rpaphp_slot_list) {
+		if (!strcmp(tmp_slot->name, slot->name))
+			return 1;
+	}	
+	return 0;
+}
+
+int deregister_slot(struct slot *slot)
+{
+	int retval = 0;
+	struct hotplug_slot *php_slot = slot->hotplug_slot;
+
+	 dbg("%s - Entry: deregistering slot=%s\n",
+		__FUNCTION__, slot->name);
+
+	list_del(&slot->rpaphp_slot_list);
+	
+	/* remove "phy_location" file */
+	rpaphp_sysfs_remove_attr_location(php_slot);
+
+	/* remove "phy_removable" file */
+	rpaphp_sysfs_remove_attr_removable(php_slot);
+
+	retval = pci_hp_deregister(php_slot);
+	if (retval)
+		err("Problem unregistering a slot %s\n", slot->name);
+	else
+		num_slots--;
+
+	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
+	return retval;
+}
+
 int register_slot(struct slot *slot)
 {
 	int retval;
-	char *vio_uni_addr = NULL;
 
-	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n",
-		__FUNCTION__, slot->dn->full_name, slot->index, slot->name,
+	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n", 
+		__FUNCTION__, slot->dn->full_name, slot->index, slot->name, 
 		slot->power_domain, slot->type);
-
+	/* should not try to register the same slot twice */
+	if (is_registered(slot)) { /* should't be here */
+		err("register_slot: slot[%s] is already registered\n", slot->name);
+		rpaphp_release_slot(slot->hotplug_slot);
+		return 1;
+	}	
 	retval = pci_hp_register(slot->hotplug_slot);
 	if (retval) {
 		err("pci_hp_register failed with error %d\n", retval);
@@ -142,30 +222,40 @@
 	/* create "phy_locatoin" file */
 	rpaphp_sysfs_add_attr_location(slot->hotplug_slot);	
 
+	/* create "phy_removable" file */
+	rpaphp_sysfs_add_attr_removable(slot->hotplug_slot);	
+
 	/* add slot to our internal list */
 	dbg("%s adding slot[%s] to rpaphp_slot_list\n",
 	    __FUNCTION__, slot->name);
 
 	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
 
-	if (vio_uni_addr)
-		info("Slot [%s](vio_uni_addr=%s) registered\n",
-		     slot->name, vio_uni_addr);
+	if (slot->dev_type == VIO_DEV)
+		info("Slot [%s](VIO location=%s) registered\n",
+		     slot->name, slot->location);
 	else
-		info("Slot [%s](bus_id=%s) registered\n",
-		     slot->name, pci_name(slot->bridge));
+		info("Slot [%s](PCI location=%s) registered\n",
+		     slot->name, slot->location);
 	num_slots++;
 	return 0;
 }
 
 int rpaphp_get_power_status(struct slot *slot, u8 * value)
 {
-	int rc;
-
-	rc = rtas_get_power_level(slot->power_domain, (int *) value);
-	if (rc)
-		err("failed to get power-level for slot(%s), rc=0x%x\n",
-		    slot->name, rc);
+	int rc = 0;
+	
+	if (slot->type == EMBEDDED) {
+		dbg("%s set to POWER_ON for EMBEDDED slot %s\n",
+			__FUNCTION__, slot->location);
+		*value = POWER_ON;
+	}
+	else {
+		rc = rtas_get_power_level(slot->power_domain, (int *) value);
+		if (rc)
+			err("failed to get power-level for slot(%s), rc=0x%x\n",
+		    		slot->location, rc);
+	}
 
 	return rc;
 }
@@ -177,8 +267,8 @@
 	/* status: LED_OFF or LED_ON */
 	rc = rtas_set_indicator(DR_INDICATOR, slot->index, status);
 	if (rc)
-		err("slot(%s) set attention-status(%d) failed! rc=0x%x\n",
-		    slot->name, status, rc);
+		err("slot(name=%s location=%s index=0x%x) set attention-status(%d) failed! rc=0x%x\n",
+		    slot->name, slot->location, slot->index, status, rc);
 
 	return rc;
 }
diff -Nru a/drivers/pci/hotplug/rpaphp_vio.c b/drivers/pci/hotplug/rpaphp_vio.c
--- a/drivers/pci/hotplug/rpaphp_vio.c	2004-06-24 13:51:19 -07:00
+++ b/drivers/pci/hotplug/rpaphp_vio.c	2004-06-24 13:51:19 -07:00
@@ -74,11 +74,11 @@
 	int rc = 1;
 	struct slot *slot = NULL;
 	
+	name = rpaphp_get_drc_name(dn);
+	if (!name)
+		goto exit_rc;
 	index = (u32 *) get_property(dn, "ibm,my-drc-index", NULL);
 	if (!index)
-		goto exit_rc;
-	name = get_property(dn, "ibm,loc-code", NULL);
-	if (!name)
 		goto exit_rc;
 	if (!(slot = alloc_slot_struct(dn, *index, name, 0))) {
 		rc = -ENOMEM;

