Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUA3BtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUA3Bf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:35:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:9692 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266510AbUA3BcD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:03 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <10754263091239@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:49 -0800
Message-Id: <10754263091836@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1517, 2004/01/29 15:34:56-08:00, t-kochi@bq.jp.nec.com

[PATCH] PCI Hotplug: add address file and fix acpiphp bugs

This is the pending patch that adds 'address' file to show
PCI-address and a few other minor fixes.
As 2.6.0 is out, I'm resending the patch.
Would you mind taking this?

> > > Thanks.  I had a little time to try your patch today.  Sorry
> > > to report that it isn't working for me.
> > >
> > > I first powered off (successfully the 1st time) a populated slot
> > > and removed and reinserted the card into the same slot.  The slot
> > > powered back up but I was then unable to power it off.  I believe
> > > the following instruction that still exists in power_off_slot()
> > > may be preventing the slot from being powered off more than once.
> > >     func->flags &= (~FUNC_EXISTS);
> > >
> > > I then tried to insert an adapter in an un-populated slot.  For
> > > some reason (which I don't understand yet) there was an enabling
> > > error which I believe caused enable_device() to exit via a path
> > > that bypassed the instruction that sets the FUNC_EXISTS flag.
> > > I was then unable to power off the slot which I believe was due
> > > to the FUNC_EXISTS flag not being set.
> > >
> > > I didn't have time to definitely confirmed the above theories.
> > > I'll take a closer look at this tomorrow unless you are able
> > > to diagnose using my vague clues :)
> >
> > It turns out that both of the above mentioned problems happened
> > because the call to acpiphp_configure_slot() from enable_device()
> > failed after inserting the card.  When this happens enable_device()
> > exits without setting the FUNC_EXISTS flag for any of the slot
> > functions.  Subsequent attempts to power off the same slot fail
> > when power_off_slot() is unable to locate a function with both
> > FUNC_HAS_EJ0 and FUNC_EXISTS flags set.
> >
> > The patch works okay when using a card that allows
> > acpiphp_configure_slot() to succeed but I believe it should
> > be improved to allow the slot to be powered off following
> > device enablement errors.
>
> Thanks for testing and comments.
> I really appreciate it.
>
> This problem turned out to be somewhat fragile state
> transition:
>
> a lifecycle of a slot is (if there's no error)
>
>   function             state
> ----------------------------------------------------
> 0                      nothing
> 1  power_on_slot()  -> SLOT_POWERDON
> 2  enable_device()  -> SLOT_POWEREDON + SLOT_ENABLED
> 3  disable_device() -> SLOT_POWEREDON
> 4  power_off_slot() -> nothing
>
> but if any error occur during enable_device(), slot will remain
> SLOT_POWERDON, but some functions on the card may not have
> FUNC_EXISTS flags, which will eventually prevents powering
> off in power_off_slot(), state transition from 1 to 4 directly.
> I.e, the FUNC_EXISTS flag introduced more states to
> complicate things.
>
> The FUNC_EXISTS flag was introduced after some discussion
> between me and Irene Zubarev, but it has no more meaning
> than that the function has corresponding 'pci_dev' structure.
> So I eliminated the usage of FUNC_EXISTS and the result is
> the patches attached to this mail (for both 2.4 and 2.6.
> I think Greg already applied the 2.4 'cleanup' patch to his tree,
> but it's not in Marcelo's release so I'm re-attaching to
> this mail for anyone interested in this topic.  It's identical
> to the one I posted earlier).
> These patches don't include Gary's patch in his post last week,
> so please apply separately.
>
> Please note that current acpiphp driver cannot handle a
> PCI card that has a PCI-to-PCI bridge on it (support
> for such cards is incomplete).  But if it's treated as
> an error, it should be recoverable anyway.


 drivers/pci/hotplug/acpiphp.h          |    5 +--
 drivers/pci/hotplug/acpiphp_core.c     |   30 +++++++++++++++++++++--
 drivers/pci/hotplug/acpiphp_glue.c     |   32 +++++++++++++++++--------
 drivers/pci/hotplug/acpiphp_pci.c      |    6 ++--
 drivers/pci/hotplug/acpiphp_res.c      |    3 --
 drivers/pci/hotplug/pci_hotplug.h      |    6 ++++
 drivers/pci/hotplug/pci_hotplug_core.c |   42 +++++++++++++++++++++++++++++++++
 7 files changed, 103 insertions(+), 21 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
--- a/drivers/pci/hotplug/acpiphp.h	Thu Jan 29 17:24:14 2004
+++ b/drivers/pci/hotplug/acpiphp.h	Thu Jan 29 17:24:14 2004
@@ -201,7 +201,7 @@
 
 #define SLOT_POWEREDON		(0x00000001)
 #define SLOT_ENABLED		(0x00000002)
-#define SLOT_MULTIFUNCTION	(x000000004)
+#define SLOT_MULTIFUNCTION	(0x00000004)
 
 /* function flags */
 
@@ -212,8 +212,6 @@
 #define FUNC_HAS_PS2		(0x00000040)
 #define FUNC_HAS_PS3		(0x00000080)
 
-#define FUNC_EXISTS		(0x10000000) /* to make sure we call _EJ0 only for existing funcs */
-
 /* function prototypes */
 
 /* acpiphp_glue.c */
@@ -231,6 +229,7 @@
 extern u8 acpiphp_get_attention_status (struct acpiphp_slot *slot);
 extern u8 acpiphp_get_latch_status (struct acpiphp_slot *slot);
 extern u8 acpiphp_get_adapter_status (struct acpiphp_slot *slot);
+extern u32 acpiphp_get_address (struct acpiphp_slot *slot);
 
 /* acpiphp_pci.c */
 extern struct pci_dev *acpiphp_allocate_pcidev (struct pci_bus *pbus, int dev, int fn);
diff -Nru a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
--- a/drivers/pci/hotplug/acpiphp_core.c	Thu Jan 29 17:24:14 2004
+++ b/drivers/pci/hotplug/acpiphp_core.c	Thu Jan 29 17:24:14 2004
@@ -30,14 +30,14 @@
  *
  */
 
-#include <linux/config.h>
-#include <linux/kernel.h>
+#include <linux/init.h>
 #include <linux/module.h>
+
+#include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-#include <linux/init.h>
 #include "pci_hotplug.h"
 #include "acpiphp.h"
 
@@ -71,6 +71,7 @@
 static int hardware_test	(struct hotplug_slot *slot, u32 value);
 static int get_power_status	(struct hotplug_slot *slot, u8 *value);
 static int get_attention_status	(struct hotplug_slot *slot, u8 *value);
+static int get_address		(struct hotplug_slot *slot, u32 *value);
 static int get_latch_status	(struct hotplug_slot *slot, u8 *value);
 static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
 static int get_max_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
@@ -86,6 +87,7 @@
 	.get_attention_status	= get_attention_status,
 	.get_latch_status	= get_latch_status,
 	.get_adapter_status	= get_adapter_status,
+	.get_address		= get_address,
 	.get_max_bus_speed	= get_max_bus_speed,
 	.get_cur_bus_speed	= get_cur_bus_speed,
 };
@@ -317,6 +319,28 @@
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	*value = acpiphp_get_adapter_status(slot->acpi_slot);
+
+	return retval;
+}
+
+
+/**
+ * get_address - get pci address of a slot
+ * @hotplug_slot: slot to get status
+ * @busdev: pointer to struct pci_busdev (seg, bus, dev)
+ *
+ */
+static int get_address (struct hotplug_slot *hotplug_slot, u32 *value)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+	int retval = 0;
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_address(slot->acpi_slot);
 
 	return retval;
 }
diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Thu Jan 29 17:24:14 2004
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Thu Jan 29 17:24:14 2004
@@ -26,12 +26,12 @@
  *
  */
 
-#include <linux/config.h>
-#include <linux/kernel.h>
+#include <linux/init.h>
 #include <linux/module.h>
+
+#include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/smp_lock.h>
-#include <linux/init.h>
 #include <asm/semaphore.h>
 
 #include "../pci.h"
@@ -686,7 +686,7 @@
 	struct list_head *l;
 	int retval = 0;
 
-	/* is this already enabled? */
+	/* if already enabled, just skip */
 	if (slot->flags & SLOT_POWEREDON)
 		goto err_exit;
 
@@ -724,14 +724,14 @@
 
 	int retval = 0;
 
-	/* is this already enabled? */
+	/* if already disabled, just skip */
 	if ((slot->flags & SLOT_POWEREDON) == 0)
 		goto err_exit;
 
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
-		if (func->flags & (FUNC_HAS_PS3 | FUNC_EXISTS)) {
+		if (func->pci_dev && (func->flags & FUNC_HAS_PS3)) {
 			status = acpi_evaluate_object(func->handle, "_PS3", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
 				warn("%s: _PS3 failed\n", __FUNCTION__);
@@ -745,7 +745,7 @@
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		/* We don't want to call _EJ0 on non-existing functions. */
-		if (func->flags & (FUNC_HAS_EJ0 | FUNC_EXISTS)) {
+		if (func->pci_dev && (func->flags & FUNC_HAS_EJ0)) {
 			/* _EJ0 method take one argument */
 			arg_list.count = 1;
 			arg_list.pointer = &arg;
@@ -758,7 +758,6 @@
 				retval = -1;
 				goto err_exit;
 			}
-			func->flags &= (~FUNC_EXISTS);
 		}
 	}
 
@@ -838,8 +837,6 @@
 		retval = acpiphp_configure_function(func);
 		if (retval)
 			goto err_exit;
-
-		func->flags |= FUNC_EXISTS;
 	}
 
 	slot->flags |= SLOT_ENABLED;
@@ -1348,4 +1345,19 @@
 	sta = get_slot_status(slot);
 
 	return (sta == 0) ? 0 : 1;
+}
+
+
+/*
+ * pci address (seg/bus/dev)
+ */
+u32 acpiphp_get_address (struct acpiphp_slot *slot)
+{
+	u32 address;
+
+	address = ((slot->bridge->seg) << 16) |
+		  ((slot->bridge->bus) << 8) |
+		  slot->device;
+
+	return address;
 }
diff -Nru a/drivers/pci/hotplug/acpiphp_pci.c b/drivers/pci/hotplug/acpiphp_pci.c
--- a/drivers/pci/hotplug/acpiphp_pci.c	Thu Jan 29 17:24:14 2004
+++ b/drivers/pci/hotplug/acpiphp_pci.c	Thu Jan 29 17:24:14 2004
@@ -29,11 +29,11 @@
  *
  */
 
-#include <linux/config.h>
-#include <linux/kernel.h>
+#include <linux/init.h>
 #include <linux/module.h>
+
+#include <linux/kernel.h>
 #include <linux/pci.h>
-#include <linux/init.h>
 #include <linux/acpi.h>
 #include "../pci.h"
 #include "pci_hotplug.h"
diff -Nru a/drivers/pci/hotplug/acpiphp_res.c b/drivers/pci/hotplug/acpiphp_res.c
--- a/drivers/pci/hotplug/acpiphp_res.c	Thu Jan 29 17:24:14 2004
+++ b/drivers/pci/hotplug/acpiphp_res.c	Thu Jan 29 17:24:14 2004
@@ -29,7 +29,7 @@
  *
  */
 
-#include <linux/config.h>
+#include <linux/init.h>
 #include <linux/module.h>
 
 #include <linux/kernel.h>
@@ -39,7 +39,6 @@
 #include <linux/pci.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
-#include <linux/init.h>
 
 #include <linux/string.h>
 #include <linux/mm.h>
diff -Nru a/drivers/pci/hotplug/pci_hotplug.h b/drivers/pci/hotplug/pci_hotplug.h
--- a/drivers/pci/hotplug/pci_hotplug.h	Thu Jan 29 17:24:14 2004
+++ b/drivers/pci/hotplug/pci_hotplug.h	Thu Jan 29 17:24:14 2004
@@ -74,6 +74,9 @@
  * @get_adapter_status: Called to get see if an adapter is present in the slot or not.
  *	If this field is NULL, the value passed in the struct hotplug_slot_info
  *	will be used when this value is requested by a user.
+ * @get_address: Called to get pci address of a slot.
+ *	If this field is NULL, the value passed in the struct hotplug_slot_info
+ *	will be used when this value is requested by a user.
  * @get_max_bus_speed: Called to get the max bus speed for a slot.
  *	If this field is NULL, the value passed in the struct hotplug_slot_info
  *	will be used when this value is requested by a user.
@@ -96,6 +99,7 @@
 	int (*get_attention_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
+	int (*get_address)		(struct hotplug_slot *slot, u32 *value);
 	int (*get_max_bus_speed)	(struct hotplug_slot *slot, enum pci_bus_speed *value);
 	int (*get_cur_bus_speed)	(struct hotplug_slot *slot, enum pci_bus_speed *value);
 };
@@ -106,6 +110,7 @@
  * @attention_status: if the attention light is enabled or not (1/0)
  * @latch_status: if the latch (if any) is open or closed (1/0)
  * @adapter_present: if there is a pci board present in the slot or not (1/0)
+ * @address: (domain << 16 | bus << 8 | dev)
  *
  * Used to notify the hotplug pci core of the status of a specific slot.
  */
@@ -114,6 +119,7 @@
 	u8	attention_status;
 	u8	latch_status;
 	u8	adapter_status;
+	u32	address;
 	enum pci_bus_speed	max_bus_speed;
 	enum pci_bus_speed	cur_bus_speed;
 };
diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	Thu Jan 29 17:24:14 2004
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	Thu Jan 29 17:24:14 2004
@@ -159,6 +159,7 @@
 GET_STATUS(attention_status, u8)
 GET_STATUS(latch_status, u8)
 GET_STATUS(adapter_status, u8)
+GET_STATUS(address, u32)
 GET_STATUS(max_bus_speed, enum pci_bus_speed)
 GET_STATUS(cur_bus_speed, enum pci_bus_speed)
 
@@ -302,6 +303,28 @@
 	.show = presence_read_file,
 };
 
+static ssize_t address_read_file (struct hotplug_slot *slot, char *buf)
+{
+	int retval;
+	u32 address;
+
+	retval = get_address (slot, &address);
+	if (retval)
+		goto exit;
+	retval = sprintf (buf, "%04x:%02x:%02x\n",
+			  (address >> 16) & 0xffff,
+			  (address >> 8) & 0xff,
+			  address & 0xff);
+
+exit:
+	return retval;
+}
+
+static struct hotplug_slot_attribute hotplug_slot_attr_address = {
+	.attr = {.name = "address", .mode = S_IFREG | S_IRUGO},
+	.show = address_read_file,
+};
+
 static char *unknown_speed = "Unknown bus speed";
 
 static ssize_t max_bus_speed_read_file (struct hotplug_slot *slot, char *buf)
@@ -425,6 +448,15 @@
 	return -ENOENT;
 }
 
+static int has_address_file (struct hotplug_slot *slot)
+{
+	if ((!slot) || (!slot->ops))
+		return -ENODEV;
+	if (slot->ops->get_address)
+		return 0;
+	return -ENOENT;
+}
+
 static int has_max_bus_speed_file (struct hotplug_slot *slot)
 {
 	if ((!slot) || (!slot->ops))
@@ -466,6 +498,9 @@
 	if (has_adapter_file(slot) == 0)
 		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
 
+	if (has_address_file(slot) == 0)
+		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_address.attr);
+
 	if (has_max_bus_speed_file(slot) == 0)
 		sysfs_create_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
 
@@ -492,6 +527,9 @@
 	if (has_adapter_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
 
+	if (has_address_file(slot) == 0)
+		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_address.attr);
+
 	if (has_max_bus_speed_file(slot) == 0)
 		sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_max_bus_speed.attr);
 
@@ -611,6 +649,10 @@
 	if ((has_adapter_file(slot) == 0) &&
 	    (slot->info->adapter_status != info->adapter_status))
 		sysfs_update_file(&slot->kobj, &hotplug_slot_attr_presence.attr);
+
+	if ((has_address_file(slot) == 0) &&
+	    (slot->info->address != info->address))
+		sysfs_update_file(&slot->kobj, &hotplug_slot_attr_address.attr);
 
 	if ((has_max_bus_speed_file(slot) == 0) &&
 	    (slot->info->max_bus_speed != info->max_bus_speed))

