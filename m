Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269819AbUJSXHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269819AbUJSXHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269613AbUJSXG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:06:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:63113 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270081AbUJSWqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:23 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225736981@kroah.com>
Date: Tue, 19 Oct 2004 15:42:17 -0700
Message-Id: <10982257371929@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.38, 2004/10/06 13:01:41-07:00, johnrose@austin.ibm.com

[PATCH] PCI Hotplug: RPA dynamic addition/removal of PCI Host Bridges

The following patch implements the RPA PCI Hotplug and DLPAR driver changes for
the dynamic addition/removal of PCI Host bridges (PHBs).  These operations are
initiated in the same way as existing slot DLPAR operations, which is by
writing the firmware (drc) name of the PHB to:
/sys/bus/pci/slots/control/[add,remove]_slot

The "kernel" entry points for these operations are:
pcibios_remove_root_bus()
	ppc64-specific, submitted to ppc64 list on 8/19, not yet accepted
	http://ozlabs.org/ppc64-patches/patch.pl?id=241
init_phb_dynamic()
	ppc64-specific, submitted to ppc64 list on 9/16, not yet accepted
	http://ozlabs.org/ppc64-patches/patch.pl?id=292
pci_remove_bus()
	generic, submitted and accepted by Greg
	http://www.uwsg.iu.edu/hypermail/linux/kernel/0408.3/0595.html

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpadlpar_core.c |  162 ++++++++++++++++++++++++++++++------
 drivers/pci/hotplug/rpaphp.h        |    3 
 drivers/pci/hotplug/rpaphp_core.c   |  139 ++++++++++++++++++------------
 drivers/pci/hotplug/rpaphp_pci.c    |   25 +++--
 drivers/pci/hotplug/rpaphp_vio.c    |    4 
 5 files changed, 239 insertions(+), 94 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
--- a/drivers/pci/hotplug/rpadlpar_core.c	2004-10-19 15:24:16 -07:00
+++ b/drivers/pci/hotplug/rpadlpar_core.c	2004-10-19 15:24:16 -07:00
@@ -25,6 +25,10 @@
 
 static DECLARE_MUTEX(rpadlpar_sem);
 
+#define NODE_TYPE_VIO  1
+#define NODE_TYPE_SLOT 2
+#define NODE_TYPE_PHB  3
+
 static struct device_node *find_php_slot_vio_node(char *drc_name)
 {
 	struct device_node *child;
@@ -44,21 +48,50 @@
 	return NULL;
 }
 
-static struct device_node *find_php_slot_pci_node(char *drc_name)
+/* Find dlpar-capable pci node that contains the specified name and type */
+static struct device_node *find_php_slot_pci_node(char *drc_name,
+						  char *drc_type)
 {
 	struct device_node *np = NULL;
 	char *name;
+	char *type;
+	int rc;
 
-	while ((np = of_find_node_by_type(np, "pci")))
-		if (is_hotplug_capable(np)) {
-			name = rpaphp_get_drc_name(np);
-			if (name && (!strcmp(drc_name, name)))
+	while ((np = of_find_node_by_type(np, "pci"))) {
+		rc = rpaphp_get_drc_props(np, NULL, &name, &type, NULL);
+		if (rc == 0)
+			if (!strcmp(drc_name, name) && !strcmp(drc_type, type))
 				break;
-		}
+	}
 
 	return np;
 }
 
+static struct device_node *find_newly_added_node(char *drc_name, int *node_type)
+{
+	struct device_node *dn;
+
+	dn = find_php_slot_pci_node(drc_name, "SLOT");
+	if (dn) {
+		*node_type = NODE_TYPE_SLOT;
+		return dn;
+	}
+
+	dn = find_php_slot_pci_node(drc_name, "PHB");
+	if (dn) {
+		*node_type = NODE_TYPE_PHB;
+		return dn;
+	}
+
+	dn = find_php_slot_vio_node(drc_name);
+	if (dn) {
+		*node_type = NODE_TYPE_VIO;
+		return dn;
+	}
+
+	return NULL;
+}
+
 static struct slot *find_slot(char *drc_name)
 {
 	struct list_head *tmp, *n;
@@ -205,6 +238,71 @@
 	return 0;
 }
 
+static int dlpar_remove_root_bus(struct pci_controller *phb)
+{
+	struct pci_bus *phb_bus;
+	int rc;
+
+	phb_bus = phb->bus;
+	if (!(list_empty(&phb_bus->children) &&
+	      list_empty(&phb_bus->devices))) {
+		return -EBUSY;
+	}
+
+	rc = pcibios_remove_root_bus(phb);
+	if (rc)
+		return -EIO;
+
+	device_unregister(phb_bus->bridge);
+	pci_remove_bus(phb_bus);
+
+	return 0;
+}
+
+static int dlpar_remove_phb(struct slot *slot)
+{
+	struct pci_controller *phb;
+	struct device_node *dn;
+	int rc = 0;
+
+	dn = slot->dn;
+	if (!dn) {
+		printk(KERN_ERR "%s: unexpected NULL slot device node\n",
+				__FUNCTION__);
+		return -EIO;
+	}
+
+	phb = dn->phb;
+	if (!phb) {
+		printk(KERN_ERR "%s: unexpected NULL phb pointer\n",
+				__FUNCTION__);
+		return -EIO;
+	}
+
+	if (rpaphp_remove_slot(slot)) {
+		printk(KERN_ERR "%s: unable to remove hotplug slot %s\n",
+			__FUNCTION__, slot->location);
+		return -EIO;
+	}
+
+	rc = dlpar_remove_root_bus(phb);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int dlpar_add_phb(struct device_node *dn)
+{
+	struct pci_controller *phb;
+
+	phb = init_phb_dynamic(dn);
+	if (!phb)
+		return 1;
+
+	return 0;
+}
+
 /**
  * dlpar_add_slot - DLPAR add an I/O Slot
  * @drc_name: drc-name of newly added slot
@@ -220,7 +318,8 @@
  */
 int dlpar_add_slot(char *drc_name)
 {
-	struct device_node *dn;
+	struct device_node *dn = NULL;
+	int node_type;
 	int rc = 0;
 
 	if (down_interruptible(&rpadlpar_sem))
@@ -232,18 +331,27 @@
 		goto exit;
 	}
 
-	dn = find_php_slot_vio_node(drc_name);
+	dn = find_newly_added_node(drc_name, &node_type);
 	if (!dn) {
-		dn = find_php_slot_pci_node(drc_name);
-		if (dn)
+		rc = -ENODEV;
+		goto exit;
+	}
+
+	switch (node_type) {
+		case NODE_TYPE_VIO:
+			/* Just add hotplug slot */
+			break;
+		case NODE_TYPE_SLOT:
 			rc = dlpar_add_pci_slot(drc_name, dn);
-		else {
-			rc = -ENODEV;
-			goto exit;
-		}
+			break;
+		case NODE_TYPE_PHB:
+			rc = dlpar_add_phb(dn);
+			break;
+		default:
+			printk("%s: unexpected node type\n", __FUNCTION__);
+			return -EIO;
 	}
 
-	/* Add hotplug slot for new VIOA or PCI */
 	if (!rc && rpaphp_add_slot(dn)) {
 		printk(KERN_ERR "%s: unable to add hotplug slot %s\n",
 			__FUNCTION__, drc_name);
@@ -337,7 +445,8 @@
 		return -ERESTARTSYS;
 
 	if (!find_php_slot_vio_node(drc_name) &&
-	    !find_php_slot_pci_node(drc_name)) {
+	    !find_php_slot_pci_node(drc_name, "SLOT") &&
+	    !find_php_slot_pci_node(drc_name, "PHB")) {
 		rc = -ENODEV;
 		goto exit;
 	}
@@ -348,17 +457,18 @@
 		goto exit;
 	}
 	
-	switch (slot->dev_type) {
-		case PCI_DEV:
-			rc = dlpar_remove_pci_slot(slot, drc_name);
-			break;
-
-		case VIO_DEV:
-			rc = dlpar_remove_vio_slot(slot, drc_name);
-			break;
+	if (slot->type == PHB) {
+		rc = dlpar_remove_phb(slot);
+	} else {
+		switch (slot->dev_type) {
+			case PCI_DEV:
+				rc = dlpar_remove_pci_slot(slot, drc_name);
+				break;
 
-		default:
-			rc = -EIO;
+			case VIO_DEV:
+				rc = dlpar_remove_vio_slot(slot, drc_name);
+				break;
+		}
 	}
 exit:
 	up(&rpadlpar_sem);
diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	2004-10-19 15:24:16 -07:00
+++ b/drivers/pci/hotplug/rpaphp.h	2004-10-19 15:24:16 -07:00
@@ -130,7 +130,8 @@
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
 extern int rpaphp_remove_slot(struct slot *slot);
-extern char *rpaphp_get_drc_name(struct device_node *dn);
+extern int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
+		char **drc_name, char **drc_type, int *drc_power_domain);
 
 /* rpaphp_vio.c */
 extern int rpaphp_get_vio_adapter_status(struct slot *slot, int is_init, u8 * value);
diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	2004-10-19 15:24:16 -07:00
+++ b/drivers/pci/hotplug/rpaphp_core.c	2004-10-19 15:24:16 -07:00
@@ -63,7 +63,6 @@
 static int get_attention_status(struct hotplug_slot *slot, u8 * value);
 static int get_adapter_status(struct hotplug_slot *slot, u8 * value);
 static int get_max_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
-static int rpaphp_disable_slot(struct pci_dev *dev);
 
 struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
 	.owner = THIS_MODULE,
@@ -212,32 +211,91 @@
 	return deregister_slot(slot);
 }
 
-static int get_dn_properties(struct device_node *dn, int **indexes, int **names, 
-	int **types, int **power_domains)
+static int get_children_props(struct device_node *dn, int **drc_indexes,
+		int **drc_names, int **drc_types, int **drc_power_domains)
 {
-	*indexes = (int *) get_property(dn, "ibm,drc-indexes", NULL);
+	int *indexes, *names;
+	int *types, *domains;
 
-	/* &names[1] contains NULL terminated slot names */
-	*names = (int *) get_property(dn, "ibm,drc-names", NULL);
+	indexes = (int *) get_property(dn, "ibm,drc-indexes", NULL);
+	names = (int *) get_property(dn, "ibm,drc-names", NULL);
+	types = (int *) get_property(dn, "ibm,drc-types", NULL);
+	domains = (int *) get_property(dn, "ibm,drc-power-domains", NULL);
+
+	if (!indexes || !names || !types || !domains) {
+		/* Slot does not have dynamically-removable children */
+		return 1;
+	}
+	if (drc_indexes)
+		*drc_indexes = indexes;
+	if (drc_names)
+		/* &drc_names[1] contains NULL terminated slot names */
+		*drc_names = names;
+	if (drc_types)
+		/* &drc_types[1] contains NULL terminated slot types */
+		*drc_types = types;
+	if (drc_power_domains)
+		*drc_power_domains = domains;
 
-	/* &types[1] contains NULL terminated slot types */
-	*types = (int *) get_property(dn, "ibm,drc-types", NULL);
-
-	/* power_domains[1...n] are the slot power domains */
-	*power_domains = (int *) get_property(dn, "ibm,drc-power-domains", NULL);
-	
-	if (*indexes && *names && *types && *power_domains) 
-		return (1);
-	
-	return (0);
+	return 0;
+}
+
+/* To get the DRC props describing the current node, first obtain it's
+ * my-drc-index property.  Next obtain the DRC list from it's parent.  Use
+ * the my-drc-index for correlation, and obtain the requested properties.
+ */
+int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
+		char **drc_name, char **drc_type, int *drc_power_domain)
+{
+	int *indexes, *names;
+	int *types, *domains;
+	unsigned int *my_index;
+	char *name_tmp, *type_tmp;
+	int i, rc;
+
+	my_index = (int *) get_property(dn, "ibm,my-drc-index", NULL);
+	if (!my_index) {
+		/* Node isn't DLPAR/hotplug capable */
+		return 1;
+	}
+
+	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
+	if (rc) {
+		return 1;
+	}
+
+	name_tmp = (char *) &names[1];
+	type_tmp = (char *) &types[1];
+
+	/* Iterate through parent properties, looking for my-drc-index */
+	for (i = 0; i < indexes[0]; i++) {
+		if ((unsigned int) indexes[i + 1] == *my_index) {
+			if (drc_name)
+                		*drc_name = name_tmp;
+			if (drc_type)
+				*drc_type = type_tmp;
+			if (drc_index)
+				*drc_index = *my_index;
+			if (drc_power_domain)
+				*drc_power_domain = domains[i+1];
+			return 0;
+		}
+		name_tmp += (strlen(name_tmp) + 1);
+		type_tmp += (strlen(type_tmp) + 1);
+	}
+
+	return 1;
 }
 
 static int is_php_dn(struct device_node *dn, int **indexes, int **names, int **types,
 	  int **power_domains)
 {
+	int rc;
+
 	if (!is_hotplug_capable(dn))
 		return (0);
-	if (!get_dn_properties(dn, indexes, names, types, power_domains))
+	rc = get_children_props(dn, indexes, names, types, power_domains);
+	if (rc)
 		return (0);
 	return (1);
 }
@@ -245,6 +303,8 @@
 static int is_dr_dn(struct device_node *dn, int **indexes, int **names, int **types,
 	  int **power_domains, int **my_drc_index)
 {
+	int rc;
+
 	*my_drc_index = (int *) get_property(dn, "ibm,my-drc-index", NULL);
 	if(!*my_drc_index) 		
 		return (0);
@@ -252,7 +312,9 @@
 	if (!dn->parent)
 		return (0);
 
-	return get_dn_properties(dn->parent, indexes, names, types, power_domains);
+	rc = get_children_props(dn->parent, indexes, names, types,
+				power_domains);
+	return (rc == 0);
 }
 
 static inline int is_vdevice_root(struct device_node *dn)
@@ -260,37 +322,7 @@
 	return !strcmp(dn->name, "vdevice");
 }
 
-char *rpaphp_get_drc_name(struct device_node *dn)
-{
-	char *name, *ptr = NULL;
-	int *drc_names, *drc_indexes, i;
-	struct device_node *parent = dn->parent;	
-	u32 *my_drc_index;
-
-	if (!parent)
-		return NULL;
-
-	my_drc_index = (u32 *) get_property(dn, "ibm,my-drc-index", NULL);
-	if (!my_drc_index)
-		return NULL;	
-
-	drc_names = (int *) get_property(parent, "ibm,drc-names", NULL);
-	drc_indexes = (int *) get_property(parent, "ibm,drc-indexes", NULL);
-	if (!drc_names || !drc_indexes)
-		return NULL;
-
-	name = (char *) &drc_names[1];
-	for (i = 0; i < drc_indexes[0]; i++, name += (strlen(name) + 1)) {
-		if (drc_indexes[i + 1] == *my_drc_index) {
-			ptr = (char *) name;
-			break;
-		}
-	}
-
-	return ptr;
-}
-
-static int is_dlpar_drc_type(const char *type_str)
+int is_dlpar_type(const char *type_str)
 {
 	/* Only register DLPAR-capable nodes of drc-type PHB or SLOT */
 	return (!strcmp(type_str, "PHB") || !strcmp(type_str, "SLOT"));
@@ -335,7 +367,7 @@
 			if (slot_type == HOTPLUG ||
 			    (slot_type == EMBEDDED &&
 			     indexes[i + 1] == my_drc_index[0] &&
-			     is_dlpar_drc_type(type))) {
+			     is_dlpar_type(type))) {
 				if (!(slot = alloc_slot_struct(dn, indexes[i + 1], name,
 					       power_domains[i + 1]))) {
 					retval = -ENOMEM;
@@ -448,11 +480,6 @@
 	return retval;
 }
 
-static int rpaphp_disable_slot(struct pci_dev *dev)
-{
-	return disable_slot(rpaphp_find_hotplug_slot(dev));
-}
-
 static int disable_slot(struct hotplug_slot *hotplug_slot)
 {
 	int retval = -EINVAL;
@@ -489,4 +516,4 @@
 EXPORT_SYMBOL_GPL(rpaphp_add_slot);
 EXPORT_SYMBOL_GPL(rpaphp_remove_slot);
 EXPORT_SYMBOL_GPL(rpaphp_slot_head);
-EXPORT_SYMBOL_GPL(rpaphp_get_drc_name);
+EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	2004-10-19 15:24:16 -07:00
+++ b/drivers/pci/hotplug/rpaphp_pci.c	2004-10-19 15:24:16 -07:00
@@ -117,33 +117,40 @@
 int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value)
 {
 	int state, rc;
-	*value = NOT_VALID;
+ 	struct device_node *child_dn;
+ 	struct pci_dev *child_dev;
 
+	*value = NOT_VALID;
 	rc = rpaphp_get_sensor_state(slot, &state);
 	if (rc)
 		goto exit;
-	if (state == PRESENT) {
+
+ 	if ((state == EMPTY) || (slot->type == PHB)) {
+ 		dbg("slot is empty\n");
+ 		*value = EMPTY;
+ 	}
+ 	else if (state == PRESENT) {
 		if (!is_init)
 			/* at run-time slot->state can be changed by */
 			/* config/unconfig adapter */
 			*value = slot->state;
 		else {
-			if (!slot->dn->child)
+ 			child_dn = slot->dn->child;
+ 			if (child_dn)
+ 				child_dev = rpaphp_find_pci_dev(child_dn);
+
+ 			if (child_dev)
+ 				*value = CONFIGURED;
+ 			else if (!child_dn)
 				dbg("%s: %s is not valid OFDT node\n",
 				    __FUNCTION__, slot->dn->full_name);
-			else if (rpaphp_find_pci_dev(slot->dn->child))
-				*value = CONFIGURED;
 			else {
 				err("%s: can't find pdev of adapter in slot[%s]\n", 
 					__FUNCTION__, slot->dn->full_name);
 				*value = NOT_CONFIGURED;
 			}
 		}
-	} else if (state == EMPTY) {
-		dbg("slot is empty\n");
-		*value = state;
 	}
-
 exit:
 	return rc;
 }
diff -Nru a/drivers/pci/hotplug/rpaphp_vio.c b/drivers/pci/hotplug/rpaphp_vio.c
--- a/drivers/pci/hotplug/rpaphp_vio.c	2004-10-19 15:24:16 -07:00
+++ b/drivers/pci/hotplug/rpaphp_vio.c	2004-10-19 15:24:16 -07:00
@@ -74,8 +74,8 @@
 	int rc = 1;
 	struct slot *slot = NULL;
 	
-	name = rpaphp_get_drc_name(dn);
-	if (!name)
+	rc = rpaphp_get_drc_props(dn, NULL, &name, NULL, NULL);
+	if (rc)
 		goto exit_rc;
 	index = (u32 *) get_property(dn, "ibm,my-drc-index", NULL);
 	if (!index)

