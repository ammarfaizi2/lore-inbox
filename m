Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVCHJwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVCHJwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVCHJwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:52:15 -0500
Received: from ozlabs.org ([203.10.76.45]:31189 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261942AbVCHJt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:49:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16941.30016.630217.310616@cargo.ozlabs.ibm.com>
Date: Tue, 8 Mar 2005 20:49:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: johnrose@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 error code cleanups rpa[php,dlpar]
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from John Rose <johnrose@austin.ibm.com>

This patch changes the RPA PCI Hotplug and DLPAR modules to use more
conventional error values for return codes.  The goal is to make failure
conditions obvious in the wrapper functions and in the caller code.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN drivers/pci/hotplug/rpaphp.h~02_rpaphp_rcs drivers/pci/hotplug/rpaphp.h
--- 2_6_linus_3/drivers/pci/hotplug/rpaphp.h~02_rpaphp_rcs	2005-03-07 17:52:20.000000000 -0600
+++ 2_6_linus_3-johnrose/drivers/pci/hotplug/rpaphp.h	2005-03-07 17:52:20.000000000 -0600
@@ -45,11 +45,6 @@
 #define LED_ID		2	/* slow blinking */
 #define LED_ACTION	3	/* fast blinking */
 
-/* Error status from rtas_get-sensor */
-#define NEED_POWER    -9000	/* slot must be power up and unisolated to get state */
-#define PWR_ONLY      -9001	/* slot must be powerd up to get state, leave isolated */
-#define ERR_SENSE_USE -9002	/* No DR operation will succeed, slot is unusable  */
-
 /* Sensor values from rtas_get-sensor */
 #define EMPTY           0	/* No card in slot */
 #define PRESENT         1	/* Card in slot */
diff -puN drivers/pci/hotplug/rpaphp_core.c~02_rpaphp_rcs drivers/pci/hotplug/rpaphp_core.c
--- 2_6_linus_3/drivers/pci/hotplug/rpaphp_core.c~02_rpaphp_rcs	2005-03-07 17:52:20.000000000 -0600
+++ 2_6_linus_3-johnrose/drivers/pci/hotplug/rpaphp_core.c	2005-03-07 17:52:20.000000000 -0600
@@ -256,12 +256,12 @@ int rpaphp_get_drc_props(struct device_n
 	my_index = (int *) get_property(dn, "ibm,my-drc-index", NULL);
 	if (!my_index) {
 		/* Node isn't DLPAR/hotplug capable */
-		return 1;
+		return -EINVAL;
 	}
 
 	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
 	if (rc < 0) {
-		return 1;
+		return -EINVAL;
 	}
 
 	name_tmp = (char *) &names[1];
@@ -284,7 +284,7 @@ int rpaphp_get_drc_props(struct device_n
 		type_tmp += (strlen(type_tmp) + 1);
 	}
 
-	return 1;
+	return -EINVAL;
 }
 
 static int is_php_type(char *drc_type)
diff -puN drivers/pci/hotplug/rpaphp_pci.c~02_rpaphp_rcs drivers/pci/hotplug/rpaphp_pci.c
--- 2_6_linus_3/drivers/pci/hotplug/rpaphp_pci.c~02_rpaphp_rcs	2005-03-07 17:52:20.000000000 -0600
+++ 2_6_linus_3-johnrose/drivers/pci/hotplug/rpaphp_pci.c	2005-03-07 17:52:20.000000000 -0600
@@ -81,8 +81,8 @@ static int rpaphp_get_sensor_state(struc
 
 	rc = rtas_get_sensor(DR_ENTITY_SENSE, slot->index, state);
 
-	if (rc) {
-		if (rc == NEED_POWER || rc == PWR_ONLY) {
+	if (rc < 0) {
+		if (rc == -EFAULT || rc == -EEXIST) {
 			dbg("%s: slot must be power up to get sensor-state\n",
 			    __FUNCTION__);
 
@@ -91,14 +91,14 @@ static int rpaphp_get_sensor_state(struc
 			 */
 			rc = rtas_set_power_level(slot->power_domain, POWER_ON,
 						  &setlevel);
-			if (rc) {
+			if (rc < 0) {
 				dbg("%s: power on slot[%s] failed rc=%d.\n",
 				    __FUNCTION__, slot->name, rc);
 			} else {
 				rc = rtas_get_sensor(DR_ENTITY_SENSE,
 						     slot->index, state);
 			}
-		} else if (rc == ERR_SENSE_USE)
+		} else if (rc == -ENODEV)
 			info("%s: slot is unusable\n", __FUNCTION__);
 		else
 			err("%s failed to get sensor state\n", __FUNCTION__);
@@ -413,7 +413,7 @@ static int setup_pci_hotplug_slot_info(s
 	if (slot->hotplug_slot->info->adapter_status == NOT_VALID) {
 		err("%s: NOT_VALID: skip dn->full_name=%s\n",
 		    __FUNCTION__, slot->dn->full_name);
-		return -1;
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -426,15 +426,15 @@ static int set_phb_slot_name(struct slot
 
 	dn = slot->dn;
 	if (!dn) {
-		return 1;
+		return -EINVAL;
 	}
 	phb = dn->phb;
 	if (!phb) {
-		return 1;
+		return -EINVAL;
 	}
 	bus = phb->bus;
 	if (!bus) {
-		return 1;
+		return -EINVAL;
 	}
 
 	sprintf(slot->name, "%04x:%02x:%02x.%x", pci_domain_nr(bus),
@@ -448,7 +448,7 @@ static int setup_pci_slot(struct slot *s
 
 	if (slot->type == PHB) {
 		rc = set_phb_slot_name(slot);
-		if (rc) {
+		if (rc < 0) {
 			err("%s: failed to set phb slot name\n", __FUNCTION__);
 			goto exit_rc;
 		}
@@ -509,12 +509,12 @@ static int setup_pci_slot(struct slot *s
 	return 0;
 exit_rc:
 	dealloc_slot_struct(slot);
-	return 1;
+	return -EINVAL;
 }
 
 int register_pci_slot(struct slot *slot)
 {
-	int rc = 1;
+	int rc = -EINVAL;
 
 	slot->dev_type = PCI_DEV;
 	if ((slot->type == EMBEDDED) || (slot->type == PHB))
diff -puN drivers/pci/hotplug/rpaphp_slot.c~02_rpaphp_rcs drivers/pci/hotplug/rpaphp_slot.c
--- 2_6_linus_3/drivers/pci/hotplug/rpaphp_slot.c~02_rpaphp_rcs	2005-03-07 17:52:20.000000000 -0600
+++ 2_6_linus_3-johnrose/drivers/pci/hotplug/rpaphp_slot.c	2005-03-07 17:52:20.000000000 -0600
@@ -211,7 +211,7 @@ int register_slot(struct slot *slot)
 	if (is_registered(slot)) { /* should't be here */
 		err("register_slot: slot[%s] is already registered\n", slot->name);
 		rpaphp_release_slot(slot->hotplug_slot);
-		return 1;
+		return -EAGAIN;
 	}	
 	retval = pci_hp_register(slot->hotplug_slot);
 	if (retval) {
@@ -270,7 +270,7 @@ int rpaphp_set_attention_status(struct s
 
 	/* status: LED_OFF or LED_ON */
 	rc = rtas_set_indicator(DR_INDICATOR, slot->index, status);
-	if (rc)
+	if (rc < 0)
 		err("slot(name=%s location=%s index=0x%x) set attention-status(%d) failed! rc=0x%x\n",
 		    slot->name, slot->location, slot->index, status, rc);
 
diff -puN drivers/pci/hotplug/rpaphp_vio.c~02_rpaphp_rcs drivers/pci/hotplug/rpaphp_vio.c
--- 2_6_linus_3/drivers/pci/hotplug/rpaphp_vio.c~02_rpaphp_rcs	2005-03-07 17:52:20.000000000 -0600
+++ 2_6_linus_3-johnrose/drivers/pci/hotplug/rpaphp_vio.c	2005-03-07 17:52:20.000000000 -0600
@@ -71,11 +71,11 @@ int register_vio_slot(struct device_node
 {
 	u32 *index;
 	char *name;
-	int rc = 1;
+	int rc = -EINVAL;
 	struct slot *slot = NULL;
 	
 	rc = rpaphp_get_drc_props(dn, NULL, &name, NULL, NULL);
-	if (rc)
+	if (rc < 0)
 		goto exit_rc;
 	index = (u32 *) get_property(dn, "ibm,my-drc-index", NULL);
 	if (!index)
diff -puN drivers/pci/hotplug/rpadlpar_core.c~02_rpaphp_rcs drivers/pci/hotplug/rpadlpar_core.c
--- 2_6_linus_3/drivers/pci/hotplug/rpadlpar_core.c~02_rpaphp_rcs	2005-03-07 17:52:51.000000000 -0600
+++ 2_6_linus_3-johnrose/drivers/pci/hotplug/rpadlpar_core.c	2005-03-07 17:53:02.000000000 -0600
@@ -142,7 +142,7 @@ static int pci_add_secondary_bus(struct 
 	child = pci_add_new_bus(bridge_dev->bus, bridge_dev, sec_busno);
 	if (!child) {
 		printk(KERN_ERR "%s: could not add secondary bus\n", __FUNCTION__);
-		return 1;
+		return -ENOMEM;
 	}
 
 	sprintf(child->name, "PCI Bus #%02x", child->number);
@@ -204,7 +204,7 @@ static int dlpar_pci_remove_bus(struct p
 	if (!bridge_dev) {
 		printk(KERN_ERR "%s: unexpected null device\n",
 			__FUNCTION__);
-		return 1;
+		return -EINVAL;
 	}
 
 	secondary_bus = bridge_dev->subordinate;
@@ -212,7 +212,7 @@ static int dlpar_pci_remove_bus(struct p
 	if (unmap_bus_range(secondary_bus)) {
 		printk(KERN_ERR "%s: failed to unmap bus range\n",
 			__FUNCTION__);
-		return 1;
+		return -ERANGE;
 	}
 
 	pci_remove_bus_device(bridge_dev);
@@ -282,7 +282,7 @@ static int dlpar_remove_phb(struct slot 
 	}
 
 	rc = dlpar_remove_root_bus(phb);
-	if (rc)
+	if (rc < 0)
 		return rc;
 
 	return 0;
@@ -294,7 +294,7 @@ static int dlpar_add_phb(struct device_n
 
 	phb = init_phb_dynamic(dn);
 	if (!phb)
-		return 1;
+		return -EINVAL;
 
 	return 0;
 }
