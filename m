Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVCaWDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVCaWDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVCaWDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:03:46 -0500
Received: from fmr23.intel.com ([143.183.121.15]:44730 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261811AbVCaWDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:03:35 -0500
Date: Thu, 31 Mar 2005 14:03:04 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Tom Duffy <tduffy@sun.com>
Cc: Dely Sy <dlsy@snoqualmie.dp.intel.com>, gregkh@suse.de,
       rajesh.shah@intel.com, akpm@osdl.org, dely.l.sy@intel.com,
       len.brown@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, tony.luck@intel.com,
       Prasad Singamsetty <Prasad.Singamsetty@sun.com>
Subject: Re: [Pcihpd-discuss] RE: [RFC/Patch 0/12] ACPI based root bridge hot-add
Message-ID: <20050331140304.C21596@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <200503230313.j2N3DYpE010786@snoqualmie.dp.intel.com> <1111618996.12700.44.camel@duffman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1111618996.12700.44.camel@duffman>; from tduffy@sun.com on Wed, Mar 23, 2005 at 03:03:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 03:03:16PM -0800, Tom Duffy wrote:
> 
> I have updated to Wilcox's rewrite, Rajesh's stuff, and Dely's latest
> patch.  Still seeing these:
> 
> [root@intlhotp-1 ~]# modprobe acpiphp
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> acpiphp: Slot [4] registered
> acpiphp: Slot [3] registered
> 
> [root@intlhotp-1 ~]# cd /sys/bus/pci/slots/4
> 
> [root@intlhotp-1 4]# echo 0 > power
> 
> This *does* take this slot off line.  Before, I see in lscpi

Note that the current code also attempts to physically eject the
card when you power it off like this. 

> After, these are gone.
> 
> [root@intlhotp-1 4]# cat power
> 1
> 
> Hrm, this should be 0.
> 
The code invokes an ACPI _STAtus method to report the power state.
It can get confused if that reports that the device is still
present. The code does keep internal info about the power state
of each slot, but it doesn't use it to report power state.

> [root@intlhotp-1 4]# echo 1 > power
> acpiphp_glue: No new device found
> 
If the firmware had a working _EJ0 method for this slot, the
card has been physically ejected.

Does this patch help? It decouples power changes from physical
ejection. With this, you can use the sysfs power control file
to repeatedly power a device on and off. You have to use an
acpi button press to actually physically eject it. Patch 
applies on 2.6.12-rc1-mm4 on top of the acpiphp re-write
plus all the other new patches.

-----------

Current acpiphp code does not distinguish between the physical
presence and power state of a device/slot. That is, if a device
has to be disabled, it also tries to physically ejects the device.
This patch decouples power state from physical presence. You can
now echo to the corresponding sysfs power control file to 
repeatedly enable and disable a device without having to
physically re-insert it. 

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

---

 linux-2.6.12-rc1-mm4-rshah1/drivers/pci/hotplug/acpiphp_glue.c |   69 +++++-----
 1 files changed, 38 insertions(+), 31 deletions(-)

diff -puN drivers/pci/hotplug/acpiphp_glue.c~acpiphp-decouple-power-eject drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6.12-rc1-mm4/drivers/pci/hotplug/acpiphp_glue.c~acpiphp-decouple-power-eject	2005-03-31 13:10:24.846754032 -0800
+++ linux-2.6.12-rc1-mm4-rshah1/drivers/pci/hotplug/acpiphp_glue.c	2005-03-31 13:12:20.483471366 -0800
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
 
 
_


