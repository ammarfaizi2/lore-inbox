Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270051AbUJSXBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270051AbUJSXBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269963AbUJSW5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:57:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:1930 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270082AbUJSWqZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:25 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257354198@kroah.com>
Date: Tue, 19 Oct 2004 15:42:15 -0700
Message-Id: <10982257353682@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.28, 2004/10/06 12:38:06-07:00, johnrose@austin.ibm.com

[PATCH] PCI Hotplug: add host bridges to RPA hotplug subsystem

The following patch implements the registration of PCI Host Bridges as hotplug
slots.  Only host bridges that are dynamically removable will be registered.
The hotplug slots directory goes from looking like this:

# ls /sys/bus/pci/slots
.             0000:00:02.2  0001:00:02.4  0002:00:02.2  30000000
..            0000:00:02.4  0001:00:02.6  0002:00:02.4  control
0000:00:02.0  0001:00:02.2  0002:00:02.0  0002:00:02.6

to this:

# ls /sys/bus/pci/slots
.             0000:00:02.0  0001:00:00.0  0001:00:02.6  0002:00:02.2  30000000
..            0000:00:02.2  0001:00:02.2  0002:00:00.0  0002:00:02.4  control
0000:00:00.0  0000:00:02.4  0001:00:02.4  0002:00:02.0  0002:00:02.6

This work is precursory to the DLPAR module changes that implement
addition/removal of these bridges.  Please apply if there are no objections.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpaphp.h      |    1 
 drivers/pci/hotplug/rpaphp_core.c |   20 ++++++++-----
 drivers/pci/hotplug/rpaphp_pci.c  |   55 +++++++++++++++++++++++++++++++-------
 drivers/pci/hotplug/rpaphp_slot.c |   11 +++----
 4 files changed, 65 insertions(+), 22 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	2004-10-19 15:25:14 -07:00
+++ b/drivers/pci/hotplug/rpaphp.h	2004-10-19 15:25:14 -07:00
@@ -30,6 +30,7 @@
 #include <linux/pci.h>
 #include "pci_hotplug.h"
 
+#define	PHB     2
 #define	HOTPLUG	1
 #define	EMBEDDED 0
 
diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	2004-10-19 15:25:14 -07:00
+++ b/drivers/pci/hotplug/rpaphp_core.c	2004-10-19 15:25:14 -07:00
@@ -245,9 +245,6 @@
 static int is_dr_dn(struct device_node *dn, int **indexes, int **names, int **types,
 	  int **power_domains, int **my_drc_index)
 {
-	if (!is_hotplug_capable(dn))
-		return (0);
-
 	*my_drc_index = (int *) get_property(dn, "ibm,my-drc-index", NULL);
 	if(!*my_drc_index) 		
 		return (0);
@@ -293,6 +290,12 @@
 	return ptr;
 }
 
+static int is_dlpar_drc_type(const char *type_str)
+{
+	/* Only register DLPAR-capable nodes of drc-type PHB or SLOT */
+	return (!strcmp(type_str, "PHB") || !strcmp(type_str, "SLOT"));
+}
+
 /****************************************************************
  *	rpaphp not only registers PCI hotplug slots(HOTPLUG), 
  *	but also logical DR slots(EMBEDDED).
@@ -329,15 +332,18 @@
 		for (i = 0; i < indexes[0]; i++,
 	     		name += (strlen(name) + 1), type += (strlen(type) + 1)) {
 
-			if ( slot_type == HOTPLUG || 
-				(slot_type == EMBEDDED && indexes[i + 1] == my_drc_index[0])) {
-				
+			if (slot_type == HOTPLUG ||
+			    (slot_type == EMBEDDED &&
+			     indexes[i + 1] == my_drc_index[0] &&
+			     is_dlpar_drc_type(type))) {
 				if (!(slot = alloc_slot_struct(dn, indexes[i + 1], name,
 					       power_domains[i + 1]))) {
 					retval = -ENOMEM;
 					goto exit;
 				}
-				if (slot_type == EMBEDDED)
+				if (!strcmp(type, "PHB"))
+					slot->type = PHB;
+				else if (slot_type == EMBEDDED)
 					slot->type = EMBEDDED;
 				else
 					slot->type = simple_strtoul(type, NULL, 10);
diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	2004-10-19 15:25:14 -07:00
+++ b/drivers/pci/hotplug/rpaphp_pci.c	2004-10-19 15:25:14 -07:00
@@ -408,15 +408,52 @@
 	return 0;
 }
 
+static int set_phb_slot_name(struct slot *slot)
+{
+	struct device_node *dn;
+	struct pci_controller *phb;
+	struct pci_bus *bus;
+
+	dn = slot->dn;
+	if (!dn) {
+		return 1;
+	}
+	phb = dn->phb;
+	if (!phb) {
+		return 1;
+	}
+	bus = phb->bus;
+	if (!bus) {
+		return 1;
+	}
+
+	sprintf(slot->name, "%04x:%02x:%02x.%x", pci_domain_nr(bus),
+			bus->number, 0, 0);
+	return 0;
+}
+
 static int setup_pci_slot(struct slot *slot)
 {
-	slot->bridge = rpaphp_find_bridge_pdev(slot);
-	if (!slot->bridge) {	/* slot being added doesn't have pci_dev yet */
-		err("%s: no pci_dev for bridge dn %s\n", __FUNCTION__, slot->name);
-		goto exit_rc;
+	int rc;
+
+	if (slot->type == PHB) {
+		rc = set_phb_slot_name(slot);
+		if (rc) {
+			err("%s: failed to set phb slot name\n", __FUNCTION__);
+			goto exit_rc;
+		}
+	} else {
+		slot->bridge = rpaphp_find_bridge_pdev(slot);
+		if (!slot->bridge) {
+			/* slot being added doesn't have pci_dev yet */
+			err("%s: no pci_dev for bridge dn %s\n",
+					__FUNCTION__, slot->name);
+			goto exit_rc;
+		}
+		dbg("%s set slot->name to %s\n",  __FUNCTION__,
+				pci_name(slot->bridge));
+		strcpy(slot->name, pci_name(slot->bridge));
 	}
-	dbg("%s set slot->name to %s\n",  __FUNCTION__, pci_name(slot->bridge));
-	strcpy(slot->name, pci_name(slot->bridge));
 
 	/* find slot's pci_dev if it's not empty */
 	if (slot->hotplug_slot->info->adapter_status == EMPTY) {
@@ -470,10 +507,10 @@
 	int rc = 1;
 
 	slot->dev_type = PCI_DEV;
-	if (slot->type == EMBEDDED)
-		slot->removable = EMBEDDED;
+	if ((slot->type == EMBEDDED) || (slot->type == PHB))
+		slot->removable = 0;
 	else
-		slot->removable = HOTPLUG;
+		slot->removable = 1;
 	INIT_LIST_HEAD(&slot->dev.pci_funcs);
 	if (setup_pci_hotplug_slot_info(slot))
 		goto exit_rc;
diff -Nru a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
--- a/drivers/pci/hotplug/rpaphp_slot.c	2004-10-19 15:25:14 -07:00
+++ b/drivers/pci/hotplug/rpaphp_slot.c	2004-10-19 15:25:14 -07:00
@@ -246,12 +246,7 @@
 {
 	int rc = 0, level;
 	
-	if (slot->type == EMBEDDED) {
-		dbg("%s set to POWER_ON for EMBEDDED slot %s\n",
-			__FUNCTION__, slot->location);
-		*value = POWER_ON;
-	}
-	else {
+	if (slot->type == HOTPLUG) {
 		rc = rtas_get_power_level(slot->power_domain, &level);
 		if (!rc) {
 			dbg("%s the power level of slot %s(pwd-domain:0x%x) is %d\n",
@@ -260,6 +255,10 @@
 		} else
 			err("failed to get power-level for slot(%s), rc=0x%x\n",
 				slot->location, rc);
+	} else {
+		dbg("%s report POWER_ON for EMBEDDED or PHB slot %s\n",
+			__FUNCTION__, slot->location);
+		*value = (u8) POWER_ON;
 	}
 
 	return rc;

