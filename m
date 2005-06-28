Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVF1F6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVF1F6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVF1Fpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:45:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:12524 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261631AbVF1Fdf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:35 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi hotplug: decouple slot power state changes from physical hotplug
In-Reply-To: <11199367743535@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:54 -0700
Message-Id: <1119936774423@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi hotplug: decouple slot power state changes from physical hotplug

Current acpiphp code does not distinguish between the physical presence and
power state of a device/slot.  That is, if a device has to be disabled, it
also tries to physically ejects the device.  This patch decouples power state
from physical presence.  You can now echo to the corresponding sysfs power
control file to repeatedly enable and disable a device without having to
physically re-insert it.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8d50e332c8bd4f4e8cc76e8ed7326aa6f18182aa
tree dd9caa96f0b5d5bff3d4fccc4be410c4ecad03aa
parent 8e7561cfbdf00fb1cee694cef0e825d0548aedbc
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:57 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:43 -0700

 drivers/pci/hotplug/acpiphp_glue.c |   69 ++++++++++++++++++++----------------
 1 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -592,8 +592,6 @@ static int power_off_slot(struct acpiphp
 	acpi_status status;
 	struct acpiphp_func *func;
 	struct list_head *l;
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
 
 	int retval = 0;
 
@@ -615,27 +613,6 @@ static int power_off_slot(struct acpiphp
 		}
 	}
 
-	list_for_each (l, &slot->funcs) {
-		func = list_entry(l, struct acpiphp_func, sibling);
-
-		/* We don't want to call _EJ0 on non-existing functions. */
-		if (func->flags & FUNC_HAS_EJ0) {
-			/* _EJ0 method take one argument */
-			arg_list.count = 1;
-			arg_list.pointer = &arg;
-			arg.type = ACPI_TYPE_INTEGER;
-			arg.integer.value = 1;
-
-			status = acpi_evaluate_object(func->handle, "_EJ0", &arg_list, NULL);
-			if (ACPI_FAILURE(status)) {
-				warn("%s: _EJ0 failed\n", __FUNCTION__);
-				retval = -1;
-				goto err_exit;
-			} else
-				break;
-		}
-	}
-
 	/* TBD: evaluate _STA to check if the slot is disabled */
 
 	slot->flags &= (~SLOT_POWEREDON);
@@ -782,6 +759,39 @@ static unsigned int get_slot_status(stru
 }
 
 /**
+ * acpiphp_eject_slot - physically eject the slot
+ */
+static int acpiphp_eject_slot(struct acpiphp_slot *slot)
+{
+	acpi_status status;
+	struct acpiphp_func *func;
+	struct list_head *l;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+
+	list_for_each (l, &slot->funcs) {
+		func = list_entry(l, struct acpiphp_func, sibling);
+
+		/* We don't want to call _EJ0 on non-existing functions. */
+		if ((func->flags & FUNC_HAS_EJ0)) {
+			/* _EJ0 method take one argument */
+			arg_list.count = 1;
+			arg_list.pointer = &arg;
+			arg.type = ACPI_TYPE_INTEGER;
+			arg.integer.value = 1;
+
+			status = acpi_evaluate_object(func->handle, "_EJ0", &arg_list, NULL);
+			if (ACPI_FAILURE(status)) {
+				warn("%s: _EJ0 failed\n", __FUNCTION__);
+				return -1;
+			} else
+				break;
+		}
+	}
+	return 0;
+}
+
+/**
  * acpiphp_check_bridge - re-enumerate devices
  *
  * Iterate over all slots under this bridge and make sure that if a
@@ -804,6 +814,8 @@ static int acpiphp_check_bridge(struct a
 			if (retval) {
 				err("Error occurred in disabling\n");
 				goto err_exit;
+			} else {
+				acpiphp_eject_slot(slot);
 			}
 			disabled++;
 		} else {
@@ -1041,7 +1053,6 @@ static void handle_hotplug_event_bridge(
 	}
 }
 
-
 /**
  * handle_hotplug_event_func - handle ACPI event on functions (i.e. slots)
  *
@@ -1084,7 +1095,8 @@ static void handle_hotplug_event_func(ac
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
 		dbg("%s: Device eject notify on %s\n", __FUNCTION__, objname);
-		acpiphp_disable_slot(func->slot);
+		if (!(acpiphp_disable_slot(func->slot)))
+			acpiphp_eject_slot(func->slot);
 		break;
 
 	default:
@@ -1268,7 +1280,6 @@ int acpiphp_enable_slot(struct acpiphp_s
 	return retval;
 }
 
-
 /**
  * acpiphp_disable_slot - power off slot
  */
@@ -1300,11 +1311,7 @@ int acpiphp_disable_slot(struct acpiphp_
  */
 u8 acpiphp_get_power_status(struct acpiphp_slot *slot)
 {
-	unsigned int sta;
-
-	sta = get_slot_status(slot);
-
-	return (sta & ACPI_STA_ENABLED) ? 1 : 0;
+	return (slot->flags & SLOT_POWEREDON);
 }
 
 

