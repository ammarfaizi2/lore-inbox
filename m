Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266855AbUHWTsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUHWTsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUHWTrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:47:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:51395 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266855AbUHWSgY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:24 -0400
X-Fake: the user-agent is fake
Subject: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <20040823183323.GA1236@kroah.com>
Date: Mon, 23 Aug 2004 11:34:40 -0700
Message-Id: <10932860802825@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.41.1, 2004/07/14 13:29:31-07:00, vernux@us.ibm.com

[PATCH] PCI Hotplug: acpiphp extension for 2.6.7, part 1

This patch adds the ability to register callback functions with
the acpiphp core to set and get the current attention LED
status.  The reason this is needed is because there is not set
ACPI standard for how this is done so each hardware platform may
implement it differently.  To keep hardware specific code out of
acpiphp, we allow other modules to register their code with it.



Signed-off-by: Vernon Mauery <vernux@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/acpiphp.h      |   16 ++++
 drivers/pci/hotplug/acpiphp_core.c |  127 ++++++++++++++++++++++++++++---------
 drivers/pci/hotplug/acpiphp_glue.c |   14 ----
 3 files changed, 115 insertions(+), 42 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
--- a/drivers/pci/hotplug/acpiphp.h	2004-08-23 11:09:13 -07:00
+++ b/drivers/pci/hotplug/acpiphp.h	2004-08-23 11:09:13 -07:00
@@ -171,6 +171,18 @@
 	struct pci_resource *bus_head;
 };
 
+/**
+ * struct acpiphp_attention_info - device specific attention registration
+ *
+ * ACPI has no generic method of setting/getting attention status
+ * this allows for device specific driver registration
+ */
+struct acpiphp_attention_info
+{
+	int (*set_attn)(struct hotplug_slot *slot, u8 status);
+	int (*get_attn)(struct hotplug_slot *slot, u8 *status);
+	struct module *owner;
+};
 
 /* PCI bus bridge HID */
 #define ACPI_PCI_HOST_HID		"PNP0A03"
@@ -211,6 +223,10 @@
 #define FUNC_HAS_PS3		(0x00000080)
 
 /* function prototypes */
+
+/* acpiphp_core.c */
+extern int acpiphp_register_attention(struct acpiphp_attention_info*info);
+extern int acpiphp_unregister_attention(struct acpiphp_attention_info *info);
 
 /* acpiphp_glue.c */
 extern int acpiphp_glue_init (void);
diff -Nru a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
--- a/drivers/pci/hotplug/acpiphp_core.c	2004-08-23 11:09:13 -07:00
+++ b/drivers/pci/hotplug/acpiphp_core.c	2004-08-23 11:09:13 -07:00
@@ -51,6 +51,7 @@
 
 /* local variables */
 static int num_slots;
+static struct acpiphp_attention_info *attention_info;
 
 #define DRIVER_VERSION	"0.4"
 #define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>"
@@ -62,10 +63,15 @@
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 module_param(debug, bool, 644);
 
+/* export the attention callback registration methods */
+EXPORT_SYMBOL_GPL(acpiphp_register_attention);
+EXPORT_SYMBOL_GPL(acpiphp_unregister_attention);
+
 static int enable_slot		(struct hotplug_slot *slot);
 static int disable_slot		(struct hotplug_slot *slot);
 static int set_attention_status (struct hotplug_slot *slot, u8 value);
 static int get_power_status	(struct hotplug_slot *slot, u8 *value);
+static int get_attention_status (struct hotplug_slot *slot, u8 *value);
 static int get_address		(struct hotplug_slot *slot, u32 *value);
 static int get_latch_status	(struct hotplug_slot *slot, u8 *value);
 static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
@@ -76,11 +82,54 @@
 	.disable_slot		= disable_slot,
 	.set_attention_status	= set_attention_status,
 	.get_power_status	= get_power_status,
+	.get_attention_status	= get_attention_status,
 	.get_latch_status	= get_latch_status,
 	.get_adapter_status	= get_adapter_status,
 	.get_address		= get_address,
 };
 
+
+/**
+ * acpiphp_register_attention - set attention LED callback
+ * @info: must be completely filled with LED callbacks
+ *
+ * Description: this is used to register a hardware specific ACPI
+ * driver that manipulates the attention LED.  All the fields in
+ * info must be set.
+ **/
+int acpiphp_register_attention(struct acpiphp_attention_info *info)
+{
+	int retval = -EINVAL;
+
+	if (info && info->owner && info->set_attn &&
+			info->get_attn && !attention_info) {
+		retval = 0;
+		attention_info = info;
+	}
+	return retval;
+}
+
+
+/**
+ * acpiphp_unregister_attention - unset attention LED callback
+ * @info: must match the pointer used to register
+ *
+ * Description: this is used to un-register a hardware specific acpi
+ * driver that manipulates the attention LED.  The pointer to the 
+ * info struct must be the same as the one used to set it.
+ **/
+int acpiphp_unregister_attention(struct acpiphp_attention_info *info)
+{
+	int retval = -EINVAL;
+
+	if (info && attention_info == info) {
+		attention_info = NULL;
+		retval = 0;
+	}
+	return retval;
+}
+
+
 /**
  * enable_slot - power on and enable a slot
  * @hotplug_slot: slot to enable
@@ -117,33 +166,29 @@
 }
 
 
-/**
- * set_attention_status - set attention LED
- *
- * TBD:
- * ACPI doesn't have known method to manipulate
- * attention status LED.
- *
- */
-static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
-{
-	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
-
-	switch (status) {
-		case 0:
-			/* FIXME turn light off */
-			hotplug_slot->info->attention_status = 0;
-			break;
-
-		case 1:
-		default:
-			/* FIXME turn light on */
-			hotplug_slot->info->attention_status = 1;
-			break;
-	}
-
-	return 0;
-}
+ /**
+  * set_attention_status - set attention LED
+ * @hotplug_slot: slot to set attention LED on
+ * @status: value to set attention LED to (0 or 1)
+ *
+ * attention status LED, so we use a callback that
+ * was registered with us.  This allows hardware specific
+ * ACPI implementations to blink the light for us.
+ **/
+ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
+ {
+	int retval = -ENODEV;
+
+ 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+ 
+	if (attention_info && try_module_get(attention_info->owner)) {
+		retval = attention_info->set_attn(hotplug_slot, status);
+		module_put(attention_info->owner);
+	} else
+		attention_info = NULL;
+	return retval;
+ }
+ 
 
 /**
  * get_power_status - get power status of a slot
@@ -165,6 +210,32 @@
 	return 0;
 }
 
+
+ /**
+ * get_attention_status - get attention LED status
+ * @hotplug_slot: slot to get status from
+ * @value: returns with value of attention LED
+ *
+ * ACPI doesn't have known method to determine the state
+ * of the attention status LED, so we use a callback that
+ * was registered with us.  This allows hardware specific
+ * ACPI implementations to determine its state
+ **/
+static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	int retval = -EINVAL;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	if (attention_info && try_module_get(attention_info->owner)) {
+		retval = attention_info->get_attn(hotplug_slot, value);
+		module_put(attention_info->owner);
+	} else
+		attention_info = NULL;
+	return retval;
+}
+
+
 /**
  * get_latch_status - get latch status of a slot
  * @hotplug_slot: slot to get status
@@ -307,7 +378,7 @@
 
 		slot->acpi_slot = get_slot_from_id(i);
 		slot->hotplug_slot->info->power_status = acpiphp_get_power_status(slot->acpi_slot);
-		slot->hotplug_slot->info->attention_status = acpiphp_get_attention_status(slot->acpi_slot);
+		slot->hotplug_slot->info->attention_status = 0;
 		slot->hotplug_slot->info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
 		slot->hotplug_slot->info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
 		slot->hotplug_slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	2004-08-23 11:09:13 -07:00
+++ b/drivers/pci/hotplug/acpiphp_glue.c	2004-08-23 11:09:13 -07:00
@@ -1302,20 +1302,6 @@
 
 
 /*
- * attention LED ON: 1
- *		OFF: 0
- *
- * TBD
- * no direct attention led status information via ACPI
- *
- */
-u8 acpiphp_get_attention_status(struct acpiphp_slot *slot)
-{
-	return 0;
-}
-
-
-/*
  * latch closed:  1
  * latch   open:  0
  */

