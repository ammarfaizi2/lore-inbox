Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWATTKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWATTKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWATTJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:09:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:39888 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932074AbWATTFJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:09 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: de-convolute rpaphp_unconfig_pci_adap
In-Reply-To: <11377838804160@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:40 -0800
Message-Id: <11377838804050@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: de-convolute rpaphp_unconfig_pci_adap

Remove general baroqueness.  The function rpaphp_unconfig_pci_adapter()
is really just three lines of code, once all the dbg printks are removed.
And its called in only one place. So replace the call by the thre lines.
Also, provide proper semaphore locking in the affected function
disable_slot()

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6ed2ae1c1dcf0f55af12a172914b770d75d22509
tree a95f09f9c6deed21e74880ae8c831f03e64b6b12
parent 5091bcbccd26ae37caea6330a1f267427422f18f
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:26:27 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:35 -0800

 drivers/pci/hotplug/rpadlpar_core.c |    6 +++++-
 drivers/pci/hotplug/rpaphp.h        |    2 --
 drivers/pci/hotplug/rpaphp_core.c   |   32 ++++++++++++++++++--------------
 drivers/pci/hotplug/rpaphp_pci.c    |   12 ------------
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 6c14810..15e853e 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -380,7 +380,11 @@ int dlpar_remove_pci_slot(char *drc_name
 			return -EIO;
 		}
 	} else {
-		rpaphp_unconfig_pci_adapter(bus);
+		struct pci_dev *dev, *tmp;
+		list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
+			eeh_remove_bus_device(dev);
+			pci_remove_bus_device(dev);
+		}
 	}
 
 	if (unmap_bus_range(bus)) {
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 89d705c..6e4f93b 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -92,8 +92,6 @@ extern int rpaphp_enable_pci_slot(struct
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
 
-extern int rpaphp_unconfig_pci_adapter(struct pci_bus *bus);
-
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
 extern int rpaphp_remove_slot(struct slot *slot);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index cf075c3..acf1764 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -412,27 +412,31 @@ exit:
 	return retval;
 }
 
-static int disable_slot(struct hotplug_slot *hotplug_slot)
+static int __disable_slot(struct slot *slot)
 {
-	int retval = -EINVAL;
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	struct pci_dev *dev, *tmp;
 
-	dbg("%s - Entry: slot[%s]\n", __FUNCTION__, slot->name);
+	if (slot->state == NOT_CONFIGURED)
+		return -EINVAL;
 
-	if (slot->state == NOT_CONFIGURED) {
-		dbg("%s: %s is already disabled\n", __FUNCTION__, slot->name);
-		goto exit;
+	list_for_each_entry_safe(dev, tmp, &slot->bus->devices, bus_list) {
+		eeh_remove_bus_device(dev);
+		pci_remove_bus_device(dev);
 	}
 
-	dbg("DISABLING SLOT %s\n", slot->name);
+	slot->state = NOT_CONFIGURED;
+	return 0;
+}
+
+static int disable_slot(struct hotplug_slot *hotplug_slot)
+{
+	struct slot *slot = (struct slot *)hotplug_slot->private;
+	int retval;
+
 	down(&rpaphp_sem);
-	retval = rpaphp_unconfig_pci_adapter(slot->bus);
+	retval = __disable_slot (slot);
 	up(&rpaphp_sem);
-	slot->state = NOT_CONFIGURED;
-	info("%s: devices in slot[%s] unconfigured.\n", __FUNCTION__,
-	     slot->name);
-exit:
-	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
+
 	return retval;
 }
 
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index 1f5e73b..ce7ebec 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -116,18 +116,6 @@ static void print_slot_pci_funcs(struct 
 	return;
 }
 
-int rpaphp_unconfig_pci_adapter(struct pci_bus *bus)
-{
-	struct pci_dev *dev, *tmp;
-
-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
-		eeh_remove_bus_device(dev);
-		pci_remove_bus_device(dev);
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(rpaphp_unconfig_pci_adapter);
-
 static int setup_pci_hotplug_slot_info(struct slot *slot)
 {
 	struct hotplug_slot_info *hotplug_slot_info = slot->hotplug_slot->info;

