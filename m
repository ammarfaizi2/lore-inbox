Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWATTLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWATTLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWATTLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:11:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:38864 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932070AbWATTFI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:08 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: merge config_pci_adapter
In-Reply-To: <11377838792136@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:39 -0800
Message-Id: <11377838791361@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: merge config_pci_adapter

Remove general baroqueness.  The function rpaphp_config_pci_adapter()
is really just one line of code, once all the dbg printks are removed.
And its called in only one place. So replace the call by the one line.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2a291fc8e77fad35c129ae5b11bbe13d835c01c1
tree 285acb9205261675f5dde1dbcdcccaab802903e4
parent 22a585a88bd1cdd7d3b757b1b6d57d7ce12b3e08
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:22:07 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:35 -0800

 drivers/pci/hotplug/rpaphp.h     |    1 -
 drivers/pci/hotplug/rpaphp_pci.c |   35 ++++-------------------------------
 2 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 6aa91ef..89d705c 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -92,7 +92,6 @@ extern int rpaphp_enable_pci_slot(struct
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
 
-extern int rpaphp_config_pci_adapter(struct pci_bus *bus);
 extern int rpaphp_unconfig_pci_adapter(struct pci_bus *bus);
 
 /* rpaphp_core.c */
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index 1a12ebd..b93d9c9 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -116,24 +116,6 @@ static void print_slot_pci_funcs(struct 
 	return;
 }
 
-int rpaphp_config_pci_adapter(struct pci_bus *bus)
-{
-	struct device_node *dn = pci_bus_to_OF_node(bus);
-	int rc = -ENODEV;
-
-	dbg("Entry %s: slot[%s]\n", __FUNCTION__, dn->full_name);
-	if (!dn)
-		goto exit;
-
-	pcibios_add_pci_devices(bus);
-	print_slot_pci_funcs(bus);
-	rc = 0;
-exit:
-	dbg("Exit %s:  rc=%d\n", __FUNCTION__, rc);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(rpaphp_config_pci_adapter);
-
 static void rpaphp_eeh_remove_bus_device(struct pci_dev *dev)
 {
 	eeh_remove_device(dev);
@@ -225,10 +207,7 @@ static int setup_pci_slot(struct slot *s
 		if (slot->hotplug_slot->info->adapter_status == NOT_CONFIGURED) {
 			dbg("%s CONFIGURING pci adapter in slot[%s]\n",  
 				__FUNCTION__, slot->name);
-			if (rpaphp_config_pci_adapter(slot->bus)) {
-				err("%s: CONFIG pci adapter failed\n", __FUNCTION__);
-				goto exit_rc;		
-			}
+			pcibios_add_pci_devices(slot->bus);
 
 		} else if (slot->hotplug_slot->info->adapter_status != CONFIGURED) {
 			err("%s: slot[%s]'s adapter_status is NOT_VALID.\n",
@@ -274,16 +253,10 @@ int rpaphp_enable_pci_slot(struct slot *
 	/* if slot is not empty, enable the adapter */
 	if (state == PRESENT) {
 		dbg("%s : slot[%s] is occupied.\n", __FUNCTION__, slot->name);
-		retval = rpaphp_config_pci_adapter(slot->bus);
-		if (!retval) {
-			slot->state = CONFIGURED;
-			info("%s: devices in slot[%s] configured\n",
+		pcibios_add_pci_devices(slot->bus);
+		slot->state = CONFIGURED;
+		info("%s: devices in slot[%s] configured\n",
 					__FUNCTION__, slot->name);
-		} else {
-			slot->state = NOT_CONFIGURED;
-			dbg("%s: no pci_dev struct for adapter in slot[%s]\n",
-			    __FUNCTION__, slot->name);
-		}
 	} else if (state == EMPTY) {
 		dbg("%s : slot[%s] is empty\n", __FUNCTION__, slot->name);
 		slot->state = EMPTY;

