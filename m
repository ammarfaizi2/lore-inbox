Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWATTL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWATTL5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWATTLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:11:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:37840 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932068AbWATTFH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:07 -0500
Cc: linas@austin.ibm.com
Subject: [PATCH] powerpc/PCI hotplug: merge rpaphp_enable_pci_slot()
In-Reply-To: <1137783879865@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:39 -0800
Message-Id: <11377838792136@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] powerpc/PCI hotplug: merge rpaphp_enable_pci_slot()

Remove general baroqueness.  The function rpaphp_enable_pci_slot()
has a fairly simple logic structure, once all of the debug printk's
are removed. Its called from only one place, and that place also
has a very simple structure once he printk's are removed.  Merge
the two together.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Acked-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 259d8eac4d548e0e0fdbe25227e2ead29e73feb9
tree 93956dbd55f6b9fb8fff48ce36f069bd9c192e92
parent 6ed2ae1c1dcf0f55af12a172914b770d75d22509
author linas@austin.ibm.com <linas@austin.ibm.com> Thu, 12 Jan 2006 18:28:22 -0600
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:35 -0800

 drivers/pci/hotplug/rpaphp.h      |    1 +
 drivers/pci/hotplug/rpaphp_core.c |   38 +++++++++++++++++++++++++++----------
 drivers/pci/hotplug/rpaphp_pci.c  |   30 +----------------------------
 3 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 6e4f93b..095c9aa 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -91,6 +91,7 @@ extern int num_slots;
 extern int rpaphp_enable_pci_slot(struct slot *slot);
 extern int register_pci_slot(struct slot *slot);
 extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
+extern int rpaphp_get_sensor_state(struct slot *slot, int *state);
 
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index acf1764..341fdd5 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -393,22 +393,40 @@ static void __exit rpaphp_exit(void)
 	cleanup_slots();
 }
 
-static int enable_slot(struct hotplug_slot *hotplug_slot)
+static int __enable_slot(struct slot *slot)
 {
-	int retval = 0;
-	struct slot *slot = (struct slot *)hotplug_slot->private;
+	int state;
+	int retval;
+
+	if (slot->state == CONFIGURED)
+		return 0;
 
-	if (slot->state == CONFIGURED) {
-		dbg("%s: %s is already enabled\n", __FUNCTION__, slot->name);
-		goto exit;
+	retval = rpaphp_get_sensor_state(slot, &state);
+	if (retval)
+		return retval;
+
+	if (state == PRESENT) {
+		pcibios_add_pci_devices(slot->bus);
+		slot->state = CONFIGURED;
+	} else if (state == EMPTY) {
+		slot->state = EMPTY;
+	} else {
+		err("%s: slot[%s] is in invalid state\n", __FUNCTION__, slot->name);
+		slot->state = NOT_VALID;
+		return -EINVAL;
 	}
+	return 0;
+}
+
+static int enable_slot(struct hotplug_slot *hotplug_slot)
+{
+	int retval;
+	struct slot *slot = (struct slot *)hotplug_slot->private;
 
-	dbg("ENABLING SLOT %s\n", slot->name);
 	down(&rpaphp_sem);
-	retval = rpaphp_enable_pci_slot(slot);
+	retval = __enable_slot(slot);
 	up(&rpaphp_sem);
-exit:
-	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
+
 	return retval;
 }
 
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index ce7ebec..d1297d0 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -32,7 +32,7 @@
 #include "../pci.h"		/* for pci_add_new_bus */
 #include "rpaphp.h"
 
-static int rpaphp_get_sensor_state(struct slot *slot, int *state)
+int rpaphp_get_sensor_state(struct slot *slot, int *state)
 {
 	int rc;
 	int setlevel;
@@ -212,31 +212,3 @@ exit_rc:
 	return rc;
 }
 
-int rpaphp_enable_pci_slot(struct slot *slot)
-{
-	int retval = 0, state;
-
-	retval = rpaphp_get_sensor_state(slot, &state);
-	if (retval)
-		goto exit;
-	dbg("%s: sensor state[%d]\n", __FUNCTION__, state);
-	/* if slot is not empty, enable the adapter */
-	if (state == PRESENT) {
-		dbg("%s : slot[%s] is occupied.\n", __FUNCTION__, slot->name);
-		pcibios_add_pci_devices(slot->bus);
-		slot->state = CONFIGURED;
-		info("%s: devices in slot[%s] configured\n",
-					__FUNCTION__, slot->name);
-	} else if (state == EMPTY) {
-		dbg("%s : slot[%s] is empty\n", __FUNCTION__, slot->name);
-		slot->state = EMPTY;
-	} else {
-		err("%s: slot[%s] is in invalid state\n", __FUNCTION__,
-		    slot->name);
-		slot->state = NOT_VALID;
-		retval = -EINVAL;
-	}
-exit:
-	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
-	return retval;
-}

