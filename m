Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266145AbUF2XvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbUF2XvX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUF2XvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:51:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:4095 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266145AbUF2Xu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:50:56 -0400
Subject: [PATCH] [1/2] acpiphp extension for 2.6.7
From: Vernon Mauery <vernux@us.ibm.com>
To: Greg KH <gregkh@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Pat Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Jess Botts <botts@us.ibm.com>,
       pcihpd-discuss@lists.sourceforge.net
In-Reply-To: <20040624214555.GA1800@us.ibm.com>
References: <1087934028.2068.57.camel@bluerat>
	 <20040624214555.GA1800@us.ibm.com>
Content-Type: text/plain
Message-Id: <1088553047.25961.65.camel@bluerat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 16:50:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01 - acpiphp-attention.patch

        This patch adds the ability to register callback functions with
        the acpiphp core to set and get the current attention LED
        status.  The reason this is needed is because there is not set
        ACPI standard for how this is done so each hardware platform may
        implement it differently.  To keep hardware specific code out of
        acpiphp, we allow other modules to register their code with it.


 acpiphp.h      |   22 ++++++++++++
 acpiphp_core.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++----------
 acpiphp_glue.c |   14 -------
 3 files changed, 106 insertions(+), 30 deletions(-)


Signed-off-by: Vernon Mauery <vernux@us.ibm.com>


=====================================================================


diff -ruN -X dontdiff linux-2.6.7.orig/drivers/pci/hotplug/acpiphp.h linux-2.6.7-apci/drivers/pci/hotplug/acpiphp.h
--- linux-2.6.7.orig/drivers/pci/hotplug/acpiphp.h	2004-06-15 22:20:26.000000000 -0700
+++ linux-2.6.7-apci/drivers/pci/hotplug/acpiphp.h	2004-06-22 11:49:38.000000000 -0700
@@ -172,6 +172,22 @@
 };
 
 
+/**
+ * struct acpiphp_attention_info - device specific attention registration
+ *
+ * ACPI has no generic method of setting/getting attention status
+ * this allows for device specific driver registration
+ */
+typedef int (*acpiphp_set_attn_callback)(struct hotplug_slot *slot, u8 status);
+typedef int (*acpiphp_get_attn_callback)(struct hotplug_slot *slot, u8 *status);
+struct acpiphp_attention_info
+{
+	acpiphp_set_attn_callback set_attn;
+	acpiphp_get_attn_callback get_attn;
+	struct module *owner;
+};
+
+
 /* PCI bus bridge HID */
 #define ACPI_PCI_HOST_HID		"PNP0A03"
 
@@ -212,6 +228,12 @@
 
 /* function prototypes */
 
+/* acpiphp_core.c */
+extern int acpiphp_register_attention_info(
+		struct acpiphp_attention_info*info);
+extern int acpiphp_unregister_attention_info(
+		struct acpiphp_attention_info *info);
+
 /* acpiphp_glue.c */
 extern int acpiphp_glue_init (void);
 extern void acpiphp_glue_exit (void);
diff -ruN -X dontdiff linux-2.6.7.orig/drivers/pci/hotplug/acpiphp_core.c linux-2.6.7-apci/drivers/pci/hotplug/acpiphp_core.c
--- linux-2.6.7.orig/drivers/pci/hotplug/acpiphp_core.c	2004-06-15 22:19:37.000000000 -0700
+++ linux-2.6.7-apci/drivers/pci/hotplug/acpiphp_core.c	2004-06-29 11:12:41.754945480 -0700
@@ -51,6 +51,7 @@
 
 /* local variables */
 static int num_slots;
+static struct acpiphp_attention_info *attention_info = NULL;
 
 #define DRIVER_VERSION	"0.4"
 #define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>"
@@ -62,10 +63,15 @@
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 module_param(debug, bool, 644);
 
+/* export the attention callback registration methods */
+EXPORT_SYMBOL_GPL(acpiphp_register_attention_info);
+EXPORT_SYMBOL_GPL(acpiphp_unregister_attention_info);
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
+    * acpiphp_register_attention_info - set attention LED callback
+    *
+    * this is used to register a hardware specific acpi driver
+    * that manipulates the attention LED.  All the fields in
+    * info must be set.
+    *
+    */
+int acpiphp_register_attention_info(struct acpiphp_attention_info *info)
+{
+	int retval = -1;
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
+ * acpiphp_unregister_attention_info - unset attention LED callback
+ *
+ * this is used to un-register a hardware specific acpi driver
+ * that manipulates the attention LED.  The pointer to the 
+ * info struct must be the same as the one used to set it.
+ *
+ */
+int acpiphp_unregister_attention_info(struct acpiphp_attention_info *info)
+{
+	int retval = -1;
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
@@ -120,29 +169,24 @@
 /**
  * set_attention_status - set attention LED
  *
- * TBD:
  * ACPI doesn't have known method to manipulate
- * attention status LED.
+ * attention status LED, so we use a callback that
+ * was registered with us.  This allows hardware specific
+ * ACPI implementations to blink the light for us.
  *
  */
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 {
+	int retval = -1;
+
 	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
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
+	if (attention_info && attention_info->set_attn &&
+			try_module_get(attention_info->owner)) {
+		retval = attention_info->set_attn(hotplug_slot, status);
+		module_put(attention_info->owner);
 	}
-
-	return 0;
+	return retval;
 }
 
 /**
@@ -166,6 +210,30 @@
 }
 
 /**
+ * get_attention_status - get attention LED status
+ *
+ * ACPI doesn't have known method to determine the state
+ * of the attention status LED, so we use a callback that
+ * was registered with us.  This allows hardware specific
+ * ACPI implementations to determine its state
+ *
+ */
+static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 *value)
+{
+	int retval = -1;
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	if (attention_info && attention_info->get_attn &&
+			try_module_get(attention_info->owner)) {
+		retval = attention_info->get_attn(hotplug_slot, value);
+		module_put(attention_info->owner);
+	}
+	return retval;
+}
+
+
+/**
  * get_latch_status - get latch status of a slot
  * @hotplug_slot: slot to get status
  * @value: pointer to store status
@@ -307,7 +375,7 @@
 
 		slot->acpi_slot = get_slot_from_id(i);
 		slot->hotplug_slot->info->power_status = acpiphp_get_power_status(slot->acpi_slot);
-		slot->hotplug_slot->info->attention_status = acpiphp_get_attention_status(slot->acpi_slot);
+		slot->hotplug_slot->info->attention_status = 0;
 		slot->hotplug_slot->info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
 		slot->hotplug_slot->info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
 		slot->hotplug_slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
diff -ruN -X dontdiff linux-2.6.7.orig/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.7-apci/drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6.7.orig/drivers/pci/hotplug/acpiphp_glue.c	2004-06-15 22:19:10.000000000 -0700
+++ linux-2.6.7-apci/drivers/pci/hotplug/acpiphp_glue.c	2004-06-22 11:49:38.000000000 -0700
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



