Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWATTFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWATTFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWATTFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:28112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751163AbWATTE7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:04:59 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: remove rpaphp_find_bus()
In-Reply-To: <1137783879871@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:39 -0800
Message-Id: <11377838793011@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: remove rpaphp_find_bus()

The function rpaphp_find_pci_bus() has been migrated to
pcibios_find_pci_bus() in arch/powerpc/platforms/pseries/pci_dlpar.c
This patch removes the old version.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 42ce64544f4cfbafcf8a0fbe779414d2bf81e607
tree 9863ef9598e83536182d6b509f7a5f2708bcb57c
parent 74fe8a7679336ce8229401b13f7af364694818b1
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:18:26 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:35 -0800

 drivers/pci/hotplug/rpadlpar_core.c |    6 +++---
 drivers/pci/hotplug/rpaphp.h        |    3 ---
 drivers/pci/hotplug/rpaphp_pci.c    |   34 ++--------------------------------
 3 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 7f504b3..bc17a13 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -174,7 +174,7 @@ static int dlpar_add_pci_slot(char *drc_
 {
 	struct pci_dev *dev;
 
-	if (rpaphp_find_pci_bus(dn))
+	if (pcibios_find_pci_bus(dn))
 		return -EINVAL;
 
 	/* Add pci bus */
@@ -221,7 +221,7 @@ static int dlpar_remove_phb(char *drc_na
 	struct pci_dn *pdn;
 	int rc = 0;
 
-	if (!rpaphp_find_pci_bus(dn))
+	if (!pcibios_find_pci_bus(dn))
 		return -EINVAL;
 
 	slot = find_slot(dn);
@@ -366,7 +366,7 @@ int dlpar_remove_pci_slot(char *drc_name
 	struct pci_bus *bus;
 	struct slot *slot;
 
-	bus = rpaphp_find_pci_bus(dn);
+	bus = pcibios_find_pci_bus(dn);
 	if (!bus)
 		return -EINVAL;
 
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 57ea71a..b333a35 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -88,13 +88,10 @@ extern int num_slots;
 /* function prototypes */
 
 /* rpaphp_pci.c */
-extern struct pci_bus *rpaphp_find_pci_bus(struct device_node *dn);
-extern int rpaphp_claim_resource(struct pci_dev *dev, int resource);
 extern int rpaphp_enable_pci_slot(struct slot *slot);
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
 extern void rpaphp_init_new_devs(struct pci_bus *bus);
-extern void rpaphp_eeh_init_nodes(struct device_node *dn);
 
 extern int rpaphp_config_pci_adapter(struct pci_bus *bus);
 extern int rpaphp_unconfig_pci_adapter(struct pci_bus *bus);
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index 396b54b..f16d0f9 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -32,36 +32,6 @@
 #include "../pci.h"		/* for pci_add_new_bus */
 #include "rpaphp.h"
 
-static struct pci_bus *find_bus_among_children(struct pci_bus *bus,
-					struct device_node *dn)
-{
-	struct pci_bus *child = NULL;
-	struct list_head *tmp;
-	struct device_node *busdn;
-
-	busdn = pci_bus_to_OF_node(bus);
-	if (busdn == dn)
-		return bus;
-
-	list_for_each(tmp, &bus->children) {
-		child = find_bus_among_children(pci_bus_b(tmp), dn);
-		if (child)
-			break;
-	}
-	return child;
-}
-
-struct pci_bus *rpaphp_find_pci_bus(struct device_node *dn)
-{
-	struct pci_dn *pdn = dn->data;
-
-	if (!pdn  || !pdn->phb || !pdn->phb->bus)
-		return NULL;
-
-	return find_bus_among_children(pdn->phb->bus, dn);
-}
-EXPORT_SYMBOL_GPL(rpaphp_find_pci_bus);
-
 static int rpaphp_get_sensor_state(struct slot *slot, int *state)
 {
 	int rc;
@@ -120,7 +90,7 @@ int rpaphp_get_pci_adapter_status(struct
 			/* config/unconfig adapter */
 			*value = slot->state;
 		} else {
-			bus = rpaphp_find_pci_bus(slot->dn);
+			bus = pcibios_find_pci_bus(slot->dn);
 			if (bus && !list_empty(&bus->devices))
 				*value = CONFIGURED;
 			else
@@ -370,7 +340,7 @@ static int setup_pci_slot(struct slot *s
 	struct pci_bus *bus;
 
 	BUG_ON(!dn);
-	bus = rpaphp_find_pci_bus(dn);
+	bus = pcibios_find_pci_bus(dn);
 	if (!bus) {
 		err("%s: no pci_bus for dn %s\n", __FUNCTION__, dn->full_name);
 		goto exit_rc;

