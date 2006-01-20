Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWATTNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWATTNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWATTN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:13:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:33232 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751172AbWATTFC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:02 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: cleanup: add prefix
In-Reply-To: <1137783879143@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:39 -0800
Message-Id: <1137783879512@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: cleanup: add prefix

Minor cleanup. Add the prefix rpaphp_* to several generic-sounding routines.
Remove rpaphp_remove_slot(), which is a one-liner.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 170aa7441c7f262b09b85ab21948bd95f3d80887
tree a66122a1f1da2f7dfb940eddc6815aea42029e2a
parent 259d8eac4d548e0e0fdbe25227e2ead29e73feb9
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:31:01 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:35 -0800

 drivers/pci/hotplug/rpadlpar_core.c |    4 ++--
 drivers/pci/hotplug/rpaphp.h        |    6 +++---
 drivers/pci/hotplug/rpaphp_core.c   |   14 +++++---------
 drivers/pci/hotplug/rpaphp_pci.c    |    4 ++--
 drivers/pci/hotplug/rpaphp_slot.c   |   16 ++++++++--------
 5 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 15e853e..d3aa9df 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -227,7 +227,7 @@ static int dlpar_remove_phb(char *drc_na
 	slot = find_slot(dn);
 	if (slot) {
 		/* Remove hotplug slot */
-		if (rpaphp_remove_slot(slot)) {
+		if (rpaphp_deregister_slot(slot)) {
 			printk(KERN_ERR
 				"%s: unable to remove hotplug slot %s\n",
 				__FUNCTION__, drc_name);
@@ -373,7 +373,7 @@ int dlpar_remove_pci_slot(char *drc_name
 	slot = find_slot(dn);
 	if (slot) {
 		/* Remove hotplug slot */
-		if (rpaphp_remove_slot(slot)) {
+		if (rpaphp_deregister_slot(slot)) {
 			printk(KERN_ERR
 				"%s: unable to remove hotplug slot %s\n",
 				__FUNCTION__, drc_name);
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 095c9aa..310b618 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -89,7 +89,7 @@ extern int num_slots;
 
 /* rpaphp_pci.c */
 extern int rpaphp_enable_pci_slot(struct slot *slot);
-extern int register_pci_slot(struct slot *slot);
+extern int rpaphp_register_pci_slot(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
 extern int rpaphp_get_sensor_state(struct slot *slot, int *state);
 
@@ -102,8 +102,8 @@ extern int rpaphp_get_drc_props(struct d
 /* rpaphp_slot.c */
 extern void dealloc_slot_struct(struct slot *slot);
 extern struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name, int power_domain);
-extern int register_slot(struct slot *slot);
-extern int deregister_slot(struct slot *slot);
+extern int rpaphp_register_slot(struct slot *slot);
+extern int rpaphp_deregister_slot(struct slot *slot);
 extern int rpaphp_get_power_status(struct slot *slot, u8 * value);
 extern int rpaphp_set_attention_status(struct slot *slot, u8 status);
 	
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 341fdd5..c0e521c 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -196,11 +196,6 @@ static int get_max_bus_speed(struct hotp
 	return 0;
 }
 
-int rpaphp_remove_slot(struct slot *slot)
-{
-	return deregister_slot(slot);
-}
-
 static int get_children_props(struct device_node *dn, int **drc_indexes,
 		int **drc_names, int **drc_types, int **drc_power_domains)
 {
@@ -307,13 +302,15 @@ static int is_php_dn(struct device_node 
 	return 0;
 }
 
-/****************************************************************
+/**
+ * rpaphp_add_slot -- add hotplug or dlpar slot
+ *
  *	rpaphp not only registers PCI hotplug slots(HOTPLUG), 
  *	but also logical DR slots(EMBEDDED).
  *	HOTPLUG slot: An adapter can be physically added/removed. 
  *	EMBEDDED slot: An adapter can be logically removed/added
  *		  from/to a partition with the slot.
- ***************************************************************/
+ */
 int rpaphp_add_slot(struct device_node *dn)
 {
 	struct slot *slot;
@@ -344,7 +341,7 @@ int rpaphp_add_slot(struct device_node *
 			dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
 					indexes[i + 1], name, type);
 
-			retval = register_pci_slot(slot);
+			retval = rpaphp_register_pci_slot(slot);
 		}
 	}
 exit:
@@ -462,6 +459,5 @@ module_init(rpaphp_init);
 module_exit(rpaphp_exit);
 
 EXPORT_SYMBOL_GPL(rpaphp_add_slot);
-EXPORT_SYMBOL_GPL(rpaphp_remove_slot);
 EXPORT_SYMBOL_GPL(rpaphp_slot_head);
 EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index d1297d0..6f6cbed 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -199,7 +199,7 @@ exit_rc:
 	return -EINVAL;
 }
 
-int register_pci_slot(struct slot *slot)
+int rpaphp_register_pci_slot(struct slot *slot)
 {
 	int rc = -EINVAL;
 
@@ -207,7 +207,7 @@ int register_pci_slot(struct slot *slot)
 		goto exit_rc;
 	if (setup_pci_slot(slot))
 		goto exit_rc;
-	rc = register_slot(slot);
+	rc = rpaphp_register_slot(slot);
 exit_rc:
 	return rc;
 }
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index daa89ae..04cc1e7 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -35,16 +35,16 @@
 
 static ssize_t location_read_file (struct hotplug_slot *php_slot, char *buf)
 {
-        char *value;
-        int retval = -ENOENT;
+	char *value;
+	int retval = -ENOENT;
 	struct slot *slot = (struct slot *)php_slot->private;
 
 	if (!slot)
 		return retval;
 
-        value = slot->location;
-        retval = sprintf (buf, "%s\n", value);
-        return retval;
+	value = slot->location;
+	retval = sprintf (buf, "%s\n", value);
+	return retval;
 }
 
 static struct hotplug_slot_attribute hotplug_slot_attr_location = {
@@ -137,7 +137,7 @@ static int is_registered(struct slot *sl
 	return 0;
 }
 
-int deregister_slot(struct slot *slot)
+int rpaphp_deregister_slot(struct slot *slot)
 {
 	int retval = 0;
 	struct hotplug_slot *php_slot = slot->hotplug_slot;
@@ -160,7 +160,7 @@ int deregister_slot(struct slot *slot)
 	return retval;
 }
 
-int register_slot(struct slot *slot)
+int rpaphp_register_slot(struct slot *slot)
 {
 	int retval;
 
@@ -169,7 +169,7 @@ int register_slot(struct slot *slot)
 		slot->power_domain, slot->type);
 	/* should not try to register the same slot twice */
 	if (is_registered(slot)) { /* should't be here */
-		err("register_slot: slot[%s] is already registered\n", slot->name);
+		err("rpaphp_register_slot: slot[%s] is already registered\n", slot->name);
 		rpaphp_release_slot(slot->hotplug_slot);
 		return -EAGAIN;
 	}	

