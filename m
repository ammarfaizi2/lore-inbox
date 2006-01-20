Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWATTFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWATTFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWATTFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:26576 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751161AbWATTE7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:04:59 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: shuffle error checking to better location.
In-Reply-To: <11377838804050@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:40 -0800
Message-Id: <11377838802978@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: shuffle error checking to better location.

Error checking is scattered through various layers of the dlpar code,
leading to a somewhat opaque code structure. This patch consolidates
error checking in one routine, simplifying the code a tad. There's
also some whitespace cleanup here too.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2f8d04252f3ae653d142229c2f28ff88afb46ed8
tree da6abf3cc396887e3ccd3f13d2c938388ff66e52
parent 3138b8204e439aaa9ee4a6693ed1305ac36e356e
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:35:23 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:36 -0800

 drivers/pci/hotplug/rpadlpar_core.c |   44 ++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index d3aa9df..3eefe2c 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -103,13 +103,13 @@ static struct slot *find_slot(struct dev
 	struct list_head *tmp, *n;
 	struct slot *slot;
 
-        list_for_each_safe(tmp, n, &rpaphp_slot_head) {
-                slot = list_entry(tmp, struct slot, rpaphp_slot_list);
-                if (slot->dn == dn)
-                        return slot;
-        }
+	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
+		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
+		if (slot->dn == dn)
+			return slot;
+	}
 
-        return NULL;
+	return NULL;
 }
 
 static struct pci_dev *dlpar_find_new_dev(struct pci_bus *parent,
@@ -126,9 +126,9 @@ static struct pci_dev *dlpar_find_new_de
 	return NULL;
 }
 
-static struct pci_dev *dlpar_pci_add_bus(struct device_node *dn)
+static void dlpar_pci_add_bus(struct device_node *dn)
 {
-	struct pci_dn *pdn = dn->data;
+	struct pci_dn *pdn = PCI_DN(dn);
 	struct pci_controller *phb = pdn->phb;
 	struct pci_dev *dev = NULL;
 
@@ -139,7 +139,7 @@ static struct pci_dev *dlpar_pci_add_bus
 	if (!dev) {
 		printk(KERN_ERR "%s: failed to create pci dev for %s\n",
 				__FUNCTION__, dn->full_name);
-		return NULL;
+		return;
 	}
 
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
@@ -156,35 +156,35 @@ static struct pci_dev *dlpar_pci_add_bus
 
 	/* Add new devices to global lists.  Register in proc, sysfs. */
 	pci_bus_add_devices(phb->bus);
-
-	/* Confirm new bridge dev was created */
-	dev = dlpar_find_new_dev(phb->bus, dn);
-	if (dev) {
-		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
-			printk(KERN_ERR "%s: unexpected header type %d\n",
-				__FUNCTION__, dev->hdr_type);
-			return NULL;
-		}
-	}
-
-	return dev;
 }
 
 static int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
 {
 	struct pci_dev *dev;
+	struct pci_controller *phb;
 
 	if (pcibios_find_pci_bus(dn))
 		return -EINVAL;
 
 	/* Add pci bus */
-	dev = dlpar_pci_add_bus(dn);
+	dlpar_pci_add_bus(dn);
+
+	/* Confirm new bridge dev was created */
+	phb = PCI_DN(dn)->phb;
+	dev = dlpar_find_new_dev(phb->bus, dn);
+
 	if (!dev) {
 		printk(KERN_ERR "%s: unable to add bus %s\n", __FUNCTION__,
 			drc_name);
 		return -EIO;
 	}
 
+	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
+		printk(KERN_ERR "%s: unexpected header type %d, unable to add bus %s\n",
+			__FUNCTION__, dev->hdr_type, drc_name);
+		return -EIO;
+	}
+
 	/* Add hotplug slot */
 	if (rpaphp_add_slot(dn)) {
 		printk(KERN_ERR "%s: unable to add hotplug slot %s\n",

