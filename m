Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSLFRtM>; Fri, 6 Dec 2002 12:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSLFRtM>; Fri, 6 Dec 2002 12:49:12 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:16403 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264936AbSLFRsU>;
	Fri, 6 Dec 2002 12:48:20 -0500
Date: Fri, 6 Dec 2002 09:55:29 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI Hotplug changes for 2.4.20
Message-ID: <20021206175528.GJ10444@kroah.com>
References: <20021206175439.GI10444@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206175439.GI10444@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.828, 2002/12/06 09:31:02-08:00, t-kouchi@mvf.biglobe.ne.jp

[PATCH] ACPI PCI hotplug updates

These are updates of the acpiphp driver for 2.4
This is mainly for backporting of bugfixes in 2.5 to 2.4.
Please apply.
  - backport of 2.5 changes & bugfixes
  - whitespace cleanup
  - message cleanup


diff -Nru a/drivers/hotplug/Makefile b/drivers/hotplug/Makefile
--- a/drivers/hotplug/Makefile	Fri Dec  6 09:51:04 2002
+++ b/drivers/hotplug/Makefile	Fri Dec  6 09:51:04 2002
@@ -29,9 +29,6 @@
 
 ifdef CONFIG_HOTPLUG_PCI_ACPI
   EXTRA_CFLAGS	+= -D_LINUX -I$(CURDIR)/../acpi
-  ifdef CONFIG_ACPI_DEBUG
-    EXTRA_CFLAGS += -DACPI_DEBUG -Wno-unused
-  endif
 endif
 
 acpiphp_objs		:=	acpiphp_core.o	\
diff -Nru a/drivers/hotplug/acpiphp.h b/drivers/hotplug/acpiphp.h
--- a/drivers/hotplug/acpiphp.h	Fri Dec  6 09:51:04 2002
+++ b/drivers/hotplug/acpiphp.h	Fri Dec  6 09:51:04 2002
@@ -97,17 +97,17 @@
 
 #define dbg(format, arg...)					\
 	do {							\
-		if (debug)					\
-			printk (KERN_DEBUG "%s: " format "\n",	\
+		if (acpiphp_debug)				\
+			printk(KERN_DEBUG "%s: " format,	\
 				MY_NAME , ## arg); 		\
 	} while (0)
-#define err(format, arg...) printk (KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
-#define info(format, arg...) printk (KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
-#define warn(format, arg...) printk (KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME , ## arg)
 
 #define SLOT_MAGIC	0x67267322
 /* name size which is used for entries in pcihpfs */
-#define SLOT_NAME_SIZE	16		/* ACPIxxxx */
+#define SLOT_NAME_SIZE	32		/* ACPI{_SUN}-{BUS}:{DEV} */
 
 struct acpiphp_bridge;
 struct acpiphp_slot;
@@ -122,8 +122,6 @@
 	struct hotplug_slot	*hotplug_slot;
 	struct list_head	slot_list;
 
-	/* if there are multiple corresponding ACPI slot objects,
-	   this points to one of them */
 	struct acpiphp_slot	*acpi_slot;
 };
 
@@ -200,7 +198,6 @@
 	struct acpiphp_bridge *bridge;	/* parent */
 	struct list_head funcs;		/* one slot may have different
 					   objects (i.e. for each function) */
-	struct acpiphp_func *func;	/* functions */
 	struct semaphore crit_sect;
 
 	u32		id;		/* slot id (serial #) for hotplug core */
@@ -213,7 +210,7 @@
 
 
 /**
- * struct acpiphp_func - PCI slot information
+ * struct acpiphp_func - PCI function information
  *
  * PCI function information for each object in ACPI namespace
  * typically 8 objects per slot (i.e. for each PCI function)
@@ -318,5 +315,8 @@
 extern void acpiphp_free_resource (struct pci_resource **res);
 extern void acpiphp_dump_resource (struct acpiphp_bridge *bridge); /* debug */
 extern void acpiphp_dump_func_resource (struct acpiphp_func *func); /* debug */
+
+/* variables */
+extern int acpiphp_debug;
 
 #endif /* _ACPIPHP_H */
diff -Nru a/drivers/hotplug/acpiphp_core.c b/drivers/hotplug/acpiphp_core.c
--- a/drivers/hotplug/acpiphp_core.c	Fri Dec  6 09:51:04 2002
+++ b/drivers/hotplug/acpiphp_core.c	Fri Dec  6 09:51:04 2002
@@ -50,12 +50,14 @@
 	#define MY_NAME	THIS_MODULE->name
 #endif
 
+static int debug;
+int acpiphp_debug;
+
 /* local variables */
-static int debug = 1;			/* XXX set to 0 after debug */
 static int num_slots;
 
-#define DRIVER_VERSION	"0.3"
-#define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>"
+#define DRIVER_VERSION	"0.4"
+#define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kouchi@cq.jp.nec.com>"
 #define DRIVER_DESC	"ACPI Hot Plug PCI Controller Driver"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
@@ -72,17 +74,21 @@
 static int get_attention_status	(struct hotplug_slot *slot, u8 *value);
 static int get_latch_status	(struct hotplug_slot *slot, u8 *value);
 static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
+static int get_max_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
+static int get_cur_bus_speed	(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value);
 
 static struct hotplug_slot_ops acpi_hotplug_slot_ops = {
-	owner:			THIS_MODULE,
-	enable_slot:		enable_slot,
-	disable_slot:		disable_slot,
-	set_attention_status:	set_attention_status,
-	hardware_test:		hardware_test,
-	get_power_status:	get_power_status,
-	get_attention_status:	get_attention_status,
-	get_latch_status:	get_latch_status,
-	get_adapter_status:	get_adapter_status,
+	.owner			= THIS_MODULE,
+	.enable_slot		= enable_slot,
+	.disable_slot		= disable_slot,
+	.set_attention_status	= set_attention_status,
+	.hardware_test		= hardware_test,
+	.get_power_status	= get_power_status,
+	.get_attention_status	= get_attention_status,
+	.get_latch_status	= get_latch_status,
+	.get_adapter_status	= get_adapter_status,
+	.get_max_bus_speed	= get_max_bus_speed,
+	.get_cur_bus_speed	= get_cur_bus_speed,
 };
 
 
@@ -90,15 +96,15 @@
 static inline int slot_paranoia_check (struct slot *slot, const char *function)
 {
 	if (!slot) {
-		dbg("%s - slot == NULL", function);
+		dbg("%s - slot == NULL\n", function);
 		return -1;
 	}
 	if (slot->magic != SLOT_MAGIC) {
-		dbg("%s - bad magic number for slot", function);
+		dbg("%s - bad magic number for slot\n", function);
 		return -1;
 	}
 	if (!slot->hotplug_slot) {
-		dbg("%s - slot->hotplug_slot == NULL!", function);
+		dbg("%s - slot->hotplug_slot == NULL!\n", function);
 		return -1;
 	}
 	return 0;
@@ -106,16 +112,16 @@
 
 
 static inline struct slot *get_slot (struct hotplug_slot *hotplug_slot, const char *function)
-{ 
+{
 	struct slot *slot;
 
 	if (!hotplug_slot) {
-		dbg("%s - hotplug_slot == NULL", function);
+		dbg("%s - hotplug_slot == NULL\n", function);
 		return NULL;
 	}
 
 	slot = (struct slot *)hotplug_slot->private;
-	if (slot_paranoia_check (slot, function))
+	if (slot_paranoia_check(slot, function))
                 return NULL;
 	return slot;
 }
@@ -130,16 +136,16 @@
  */
 static int enable_slot (struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
 
-	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	/* enable the specified slot */
-	retval = acpiphp_enable_slot (slot->acpi_slot);
+	retval = acpiphp_enable_slot(slot->acpi_slot);
 
 	return retval;
 }
@@ -154,16 +160,16 @@
  */
 static int disable_slot (struct hotplug_slot *hotplug_slot)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
 
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	/* disable the specified slot */
-	retval = acpiphp_disable_slot (slot->acpi_slot);
+	retval = acpiphp_disable_slot(slot->acpi_slot);
 
 	return retval;
 }
@@ -180,8 +186,8 @@
 static int set_attention_status (struct hotplug_slot *hotplug_slot, u8 status)
 {
 	int retval = 0;
-	
-	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	switch (status) {
 		case 0:
@@ -208,15 +214,15 @@
  */
 static int hardware_test (struct hotplug_slot *hotplug_slot, u32 value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg ("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	err ("No hardware tests are defined for this driver");
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	err("No hardware tests are defined for this driver\n");
 	retval = -ENODEV;
 
 	return retval;
@@ -234,15 +240,15 @@
  */
 static int get_power_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	*value = acpiphp_get_power_status (slot->acpi_slot);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_power_status(slot->acpi_slot);
 
 	return retval;
 }
@@ -258,8 +264,8 @@
 static int get_attention_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	int retval = 0;
-	
-	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
+
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
 
 	*value = hotplug_slot->info->attention_status;
 
@@ -278,15 +284,15 @@
  */
 static int get_latch_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	*value = acpiphp_get_latch_status (slot->acpi_slot);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_latch_status(slot->acpi_slot);
 
 	return retval;
 }
@@ -303,20 +309,48 @@
  */
 static int get_adapter_status (struct hotplug_slot *hotplug_slot, u8 *value)
 {
-	struct slot *slot = get_slot (hotplug_slot, __FUNCTION__);
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
 	int retval = 0;
-	
+
 	if (slot == NULL)
 		return -ENODEV;
-	
-	dbg("%s - physical_slot = %s", __FUNCTION__, hotplug_slot->name);
 
-	*value = acpiphp_get_adapter_status (slot->acpi_slot);
+	dbg("%s - physical_slot = %s\n", __FUNCTION__, hotplug_slot->name);
+
+	*value = acpiphp_get_adapter_status(slot->acpi_slot);
 
 	return retval;
 }
 
 
+/* return dummy value because ACPI doesn't provide any method... */
+static int get_max_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	*value = PCI_SPEED_UNKNOWN;
+
+	return 0;
+}
+
+
+/* return dummy value because ACPI doesn't provide any method... */
+static int get_cur_bus_speed (struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
+{
+	struct slot *slot = get_slot(hotplug_slot, __FUNCTION__);
+
+	if (slot == NULL)
+		return -ENODEV;
+
+	*value = PCI_SPEED_UNKNOWN;
+
+	return 0;
+}
+
+
 static int init_acpi (void)
 {
 	int retval;
@@ -335,13 +369,6 @@
 }
 
 
-static void exit_acpi (void)
-{
-	/* deallocate internal data structures etc. */
-	acpiphp_glue_exit();
-}
-
-
 /**
  * make_slot_name - make a slot name that appears in pcihpfs
  * @slot: slot to name
@@ -349,7 +376,10 @@
  */
 static void make_slot_name (struct slot *slot)
 {
-	snprintf (slot->hotplug_slot->name, SLOT_NAME_SIZE, "ACPI%x", slot->acpi_slot->sun);
+	snprintf(slot->hotplug_slot->name, SLOT_NAME_SIZE, "ACPI%d-%02x:%02x",
+		 slot->acpi_slot->sun,
+		 slot->acpi_slot->bridge->bus,
+		 slot->acpi_slot->device);
 }
 
 /**
@@ -363,31 +393,31 @@
 	int i;
 
 	for (i = 0; i < num_slots; ++i) {
-		slot = kmalloc (sizeof (struct slot), GFP_KERNEL);
+		slot = kmalloc(sizeof(struct slot), GFP_KERNEL);
 		if (!slot)
 			return -ENOMEM;
 		memset(slot, 0, sizeof(struct slot));
 
-		slot->hotplug_slot = kmalloc (sizeof (struct hotplug_slot), GFP_KERNEL);
+		slot->hotplug_slot = kmalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
 		if (!slot->hotplug_slot) {
-			kfree (slot);
+			kfree(slot);
 			return -ENOMEM;
 		}
-		memset(slot->hotplug_slot, 0, sizeof (struct hotplug_slot));
+		memset(slot->hotplug_slot, 0, sizeof(struct hotplug_slot));
 
-		slot->hotplug_slot->info = kmalloc (sizeof (struct hotplug_slot_info), GFP_KERNEL);
+		slot->hotplug_slot->info = kmalloc(sizeof(struct hotplug_slot_info), GFP_KERNEL);
 		if (!slot->hotplug_slot->info) {
-			kfree (slot->hotplug_slot);
-			kfree (slot);
+			kfree(slot->hotplug_slot);
+			kfree(slot);
 			return -ENOMEM;
 		}
-		memset(slot->hotplug_slot->info, 0, sizeof (struct hotplug_slot_info));
+		memset(slot->hotplug_slot->info, 0, sizeof(struct hotplug_slot_info));
 
-		slot->hotplug_slot->name = kmalloc (SLOT_NAME_SIZE, GFP_KERNEL);
+		slot->hotplug_slot->name = kmalloc(SLOT_NAME_SIZE, GFP_KERNEL);
 		if (!slot->hotplug_slot->name) {
-			kfree (slot->hotplug_slot->info);
-			kfree (slot->hotplug_slot);
-			kfree (slot);
+			kfree(slot->hotplug_slot->info);
+			kfree(slot->hotplug_slot);
+			kfree(slot);
 			return -ENOMEM;
 		}
 
@@ -397,26 +427,27 @@
 		slot->hotplug_slot->private = slot;
 		slot->hotplug_slot->ops = &acpi_hotplug_slot_ops;
 
-		slot->acpi_slot = get_slot_from_id (i);
+		slot->acpi_slot = get_slot_from_id(i);
 		slot->hotplug_slot->info->power_status = acpiphp_get_power_status(slot->acpi_slot);
 		slot->hotplug_slot->info->attention_status = acpiphp_get_attention_status(slot->acpi_slot);
 		slot->hotplug_slot->info->latch_status = acpiphp_get_latch_status(slot->acpi_slot);
 		slot->hotplug_slot->info->adapter_status = acpiphp_get_adapter_status(slot->acpi_slot);
 
-		make_slot_name (slot);
+		make_slot_name(slot);
 
-		retval = pci_hp_register (slot->hotplug_slot);
+		retval = pci_hp_register(slot->hotplug_slot);
 		if (retval) {
-			err ("pci_hp_register failed with error %d", retval);
-			kfree (slot->hotplug_slot->info);
-			kfree (slot->hotplug_slot->name);
-			kfree (slot->hotplug_slot);
-			kfree (slot);
+			err("pci_hp_register failed with error %d\n", retval);
+			kfree(slot->hotplug_slot->info);
+			kfree(slot->hotplug_slot->name);
+			kfree(slot->hotplug_slot);
+			kfree(slot);
 			return retval;
 		}
 
 		/* add slot to our internal list */
-		list_add (&slot->slot_list, &slot_list);
+		list_add(&slot->slot_list, &slot_list);
+		info("Slot [%s] registered\n", slot->hotplug_slot->name);
 	}
 
 	return retval;
@@ -425,17 +456,17 @@
 
 static void cleanup_slots (void)
 {
-	struct list_head *tmp;
+	struct list_head *tmp, *n;
 	struct slot *slot;
 
-	list_for_each (tmp, &slot_list) {
-		slot = list_entry (tmp, struct slot, slot_list);
-		list_del (&slot->slot_list);
-		pci_hp_deregister (slot->hotplug_slot);
-		kfree (slot->hotplug_slot->info);
-		kfree (slot->hotplug_slot->name);
-		kfree (slot->hotplug_slot);
-		kfree (slot);
+	list_for_each_safe (tmp, n, &slot_list) {
+		slot = list_entry(tmp, struct slot, slot_list);
+		list_del(&slot->slot_list);
+		pci_hp_deregister(slot->hotplug_slot);
+		kfree(slot->hotplug_slot->info);
+		kfree(slot->hotplug_slot->name);
+		kfree(slot->hotplug_slot);
+		kfree(slot);
 	}
 
 	return;
@@ -446,6 +477,10 @@
 {
 	int retval;
 
+	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+
+	acpiphp_debug = debug;
+
 	/* read all the ACPI info from the system */
 	retval = init_acpi();
 	if (retval)
@@ -455,7 +490,6 @@
 	if (retval)
 		return retval;
 
-	info (DRIVER_DESC " version: " DRIVER_VERSION);
 	return 0;
 }
 
@@ -463,7 +497,8 @@
 static void __exit acpiphp_exit(void)
 {
 	cleanup_slots();
-	exit_acpi();
+	/* deallocate internal data structures etc. */
+	acpiphp_glue_exit();
 }
 
 module_init(acpiphp_init);
diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- a/drivers/hotplug/acpiphp_glue.c	Fri Dec  6 09:51:04 2002
+++ b/drivers/hotplug/acpiphp_glue.c	Fri Dec  6 09:51:04 2002
@@ -39,7 +39,6 @@
 
 static LIST_HEAD(bridge_list);
 
-static int debug = 1;			/* XXX set 0 after debug */
 #define MY_NAME "acpiphp_glue"
 
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
@@ -90,8 +89,6 @@
 static acpi_status
 is_ejectable_slot (acpi_handle handle, u32 lvl,	void *context, void **rv)
 {
-	acpi_status status;
-	acpi_handle tmp;
 	int *count = (int *)context;
 
 	if (is_ejectable(handle)) {
@@ -157,7 +154,7 @@
 	for (slot = bridge->slots; slot; slot = slot->next)
 		if (slot->device == device) {
 			if (slot->sun != sun)
-				warn("sibling found, but _SUN doesn't match!");
+				warn("sibling found, but _SUN doesn't match!\n");
 			break;
 		}
 
@@ -181,7 +178,7 @@
 
 		bridge->nr_slots++;
 
-		dbg("found ACPI PCI Hotplug slot at PCI %02x:%02x Slot:%d",
+		dbg("found ACPI PCI Hotplug slot at PCI %02x:%02x Slot:%d\n",
 		    slot->bridge->bus, slot->device, slot->sun);
 	}
 
@@ -206,7 +203,7 @@
 					     newfunc);
 
 	if (ACPI_FAILURE(status)) {
-		err("failed to register interrupt notify handler");
+		err("failed to register interrupt notify handler\n");
 		return status;
 	}
 
@@ -306,21 +303,21 @@
 			switch (resource_type) {
 			case ACPI_MEMORY_RANGE:
 				if (cache_attribute == ACPI_PREFETCHABLE_MEMORY) {
-					dbg("resource type: prefetchable memory 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+					dbg("resource type: prefetchable memory 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
 					res = acpiphp_make_resource(min_address_range,
 							    address_length);
 					if (!res) {
-						err("out of memory");
+						err("out of memory\n");
 						return;
 					}
 					res->next = bridge->p_mem_head;
 					bridge->p_mem_head = res;
 				} else {
-					dbg("resource type: memory 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+					dbg("resource type: memory 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
 					res = acpiphp_make_resource(min_address_range,
 							    address_length);
 					if (!res) {
-						err("out of memory");
+						err("out of memory\n");
 						return;
 					}
 					res->next = bridge->mem_head;
@@ -328,22 +325,22 @@
 				}
 				break;
 			case ACPI_IO_RANGE:
-				dbg("resource type: io 0x%x - 0x%x", (u32)min_address_range, (u32)max_address_range);
+				dbg("resource type: io 0x%x - 0x%x\n", (u32)min_address_range, (u32)max_address_range);
 				res = acpiphp_make_resource(min_address_range,
 						    address_length);
 				if (!res) {
-					err("out of memory");
+					err("out of memory\n");
 					return;
 				}
 				res->next = bridge->io_head;
 				bridge->io_head = res;
 				break;
 			case ACPI_BUS_NUMBER_RANGE:
-				dbg("resource type: bus number %d - %d", (u32)min_address_range, (u32)max_address_range);
+				dbg("resource type: bus number %d - %d\n", (u32)min_address_range, (u32)max_address_range);
 				res = acpiphp_make_resource(min_address_range,
 						    address_length);
 				if (!res) {
-					err("out of memory");
+					err("out of memory\n");
 					return;
 				}
 				res->next = bridge->bus_head;
@@ -360,10 +357,9 @@
 	acpiphp_resource_sort_and_combine(&bridge->mem_head);
 	acpiphp_resource_sort_and_combine(&bridge->p_mem_head);
 	acpiphp_resource_sort_and_combine(&bridge->bus_head);
-#if 1
-	info("ACPI _CRS resource:");
+
+	dbg("ACPI _CRS resource:\n");
 	acpiphp_dump_resource(bridge);
-#endif
 }
 
 
@@ -372,7 +368,7 @@
 {
 	const struct list_head *l;
 
-	list_for_each(l, list) {
+	list_for_each (l, list) {
 		struct pci_bus *b = pci_bus_b(l);
 		if (b->number == bus)
 			return b;
@@ -386,7 +382,7 @@
 		}
 	}
 
-	return 0;
+	return NULL;
 }
 
 
@@ -397,7 +393,8 @@
 #if ACPI_CA_VERSION < 0x20020201
 	acpi_buffer buffer;
 #else
-	acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
+			       .pointer = NULL};
 #endif
 	acpi_object *package;
 	int i;
@@ -425,7 +422,7 @@
 #endif
 
 	if (ACPI_FAILURE(status)) {
-		dbg("_HPP evaluation failed");
+		dbg("_HPP evaluation failed\n");
 		return;
 	}
 
@@ -433,13 +430,13 @@
 
 	if (!package || package->type != ACPI_TYPE_PACKAGE ||
 	    package->package.count != 4 || !package->package.elements) {
-		err("invalid _HPP object; ignoring");
+		err("invalid _HPP object; ignoring\n");
 		goto err_exit;
 	}
 
 	for (i = 0; i < 4; i++) {
 		if (package->package.elements[i].type != ACPI_TYPE_INTEGER) {
-			err("invalid _HPP parameter type; ignoring");
+			err("invalid _HPP parameter type; ignoring\n");
 			goto err_exit;
 		}
 	}
@@ -449,7 +446,7 @@
 	bridge->hpp.enable_SERR = package->package.elements[2].integer.value;
 	bridge->hpp.enable_PERR = package->package.elements[3].integer.value;
 
-	dbg("_HPP parameter = (%02x, %02x, %02x, %02x)",
+	dbg("_HPP parameter = (%02x, %02x, %02x, %02x)\n",
 	    bridge->hpp.cache_line_size,
 	    bridge->hpp.latency_timer,
 	    bridge->hpp.enable_SERR,
@@ -484,15 +481,13 @@
 					     bridge);
 
 	if (ACPI_FAILURE(status)) {
-		err("failed to register interrupt notify handler");
+		err("failed to register interrupt notify handler\n");
 	}
 
 	list_add(&bridge->list, &bridge_list);
 
-#if 1
-	dbg("Bridge resource:");
+	dbg("Bridge resource:\n");
 	acpiphp_dump_resource(bridge);
-#endif
 }
 
 
@@ -503,7 +498,8 @@
 #if ACPI_CA_VERSION < 0x20020201
 	acpi_buffer buffer;
 #else
-	acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	acpi_buffer buffer = { .length = ACPI_ALLOCATE_BUFFER,
+			       .pointer = NULL};
 #endif
 	struct acpiphp_bridge *bridge;
 
@@ -545,7 +541,7 @@
 #endif
 
 	if (ACPI_FAILURE(status)) {
-		err("failed to decode bridge resources");
+		err("failed to decode bridge resources\n");
 		kfree(bridge);
 		return;
 	}
@@ -565,17 +561,15 @@
 /* allocate and initialize PCI-to-PCI bridge data structure */
 static void add_p2p_bridge (acpi_handle *handle, int seg, int bus, int dev, int fn)
 {
-	acpi_status status;
 	struct acpiphp_bridge *bridge;
 	u8 tmp8;
 	u16 tmp16;
-	u32 tmp;
 	u64 base64, limit64;
 	u32 base, limit, base32u, limit32u;
 
 	bridge = kmalloc(sizeof(struct acpiphp_bridge), GFP_KERNEL);
 	if (bridge == NULL) {
-		err("out of memory");
+		err("out of memory\n");
 		return;
 	}
 
@@ -587,14 +581,14 @@
 
 	bridge->pci_dev = pci_find_slot(bus, PCI_DEVFN(dev, fn));
 	if (!bridge->pci_dev) {
-		err("Can't get pci_dev");
+		err("Can't get pci_dev\n");
 		kfree(bridge);
 		return;
 	}
 
 	bridge->pci_bus = bridge->pci_dev->subordinate;
 	if (!bridge->pci_bus) {
-		err("This is not a PCI-to-PCI bridge!");
+		err("This is not a PCI-to-PCI bridge!\n");
 		kfree(bridge);
 		return;
 	}
@@ -621,10 +615,10 @@
 		limit = ((limit << 8) & 0xf000) + 0xfff;
 		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->io_head) {
-			err("out of memory");
+			err("out of memory\n");
 			return;
 		}
-		dbg("16bit I/O range: %04x-%04x",
+		dbg("16bit I/O range: %04x-%04x\n",
 		    (u32)bridge->io_head->base,
 		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
 		break;
@@ -635,18 +629,18 @@
 		limit = (((u32)tmp16 << 16) | ((limit << 8) & 0xf000)) + 0xfff;
 		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->io_head) {
-			err("out of memory");
+			err("out of memory\n");
 			return;
 		}
-		dbg("32bit I/O range: %08x-%08x",
+		dbg("32bit I/O range: %08x-%08x\n",
 		    (u32)bridge->io_head->base,
 		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
 		break;
 	case 0x0f:
-		dbg("I/O space unsupported");
+		dbg("I/O space unsupported\n");
 		break;
 	default:
-		warn("Unknown I/O range type");
+		warn("Unknown I/O range type\n");
 	}
 
 	/* Memory resources (mandatory for P2P bridge) */
@@ -656,10 +650,10 @@
 	limit = ((tmp16 & 0xfff0) << 16) | 0xfffff;
 	bridge->mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
 	if (!bridge->mem_head) {
-		err("out of memory");
+		err("out of memory\n");
 		return;
 	}
-	dbg("32bit Memory range: %08x-%08x",
+	dbg("32bit Memory range: %08x-%08x\n",
 	    (u32)bridge->mem_head->base,
 	    (u32)(bridge->mem_head->base + bridge->mem_head->length-1));
 
@@ -675,10 +669,10 @@
 		limit = ((limit & 0xfff0) << 16) | 0xfffff;
 		bridge->p_mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
 		if (!bridge->p_mem_head) {
-			err("out of memory");
+			err("out of memory\n");
 			return;
 		}
-		dbg("32bit Prefetchable memory range: %08x-%08x",
+		dbg("32bit Prefetchable memory range: %08x-%08x\n",
 		    (u32)bridge->p_mem_head->base,
 		    (u32)(bridge->p_mem_head->base + bridge->p_mem_head->length - 1));
 		break;
@@ -690,10 +684,10 @@
 
 		bridge->p_mem_head = acpiphp_make_resource(base64, limit64 - base64 + 1);
 		if (!bridge->p_mem_head) {
-			err("out of memory");
+			err("out of memory\n");
 			return;
 		}
-		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x",
+		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x\n",
 		    (u32)(bridge->p_mem_head->base >> 32),
 		    (u32)(bridge->p_mem_head->base & 0xffffffff),
 		    (u32)((bridge->p_mem_head->base + bridge->p_mem_head->length - 1) >> 32),
@@ -702,7 +696,7 @@
 	case 0x0f:
 		break;
 	default:
-		warn("Unknown prefetchale memory type");
+		warn("Unknown prefetchale memory type\n");
 	}
 
 	init_bridge_misc(bridge);
@@ -719,7 +713,6 @@
 	unsigned long tmp;
 	int seg, bus, device, function;
 	struct pci_dev *dev;
-	u32 val;
 
 	/* get PCI address */
 	seg = (*segbus >> 8) & 0xff;
@@ -731,7 +724,7 @@
 
 	status = acpi_evaluate_integer(handle, "_ADR", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
-		dbg("%s: _ADR evaluation failure", __FUNCTION__);
+		dbg("%s: _ADR evaluation failure\n", __FUNCTION__);
 		return AE_OK;
 	}
 
@@ -748,7 +741,7 @@
 
 	/* check if this bridge has ejectable slots */
 	if (detect_ejectable_slots(handle) > 0) {
-		dbg("found PCI-to-PCI bridge at PCI %02x:%02x.%d", bus, device, function);
+		dbg("found PCI-to-PCI bridge at PCI %s\n", dev->slot_name);
 		add_p2p_bridge(handle, seg, bus, device, function);
 	}
 
@@ -763,14 +756,13 @@
 	unsigned long tmp;
 	int seg, bus;
 	acpi_handle dummy_handle;
-	int sta = -1;
 
 	/* if the bridge doesn't have _STA, we assume it is always there */
 	status = acpi_get_handle(handle, "_STA", &dummy_handle);
 	if (ACPI_SUCCESS(status)) {
 		status = acpi_evaluate_integer(handle, "_STA", NULL, &tmp);
 		if (ACPI_FAILURE(status)) {
-			dbg("%s: _STA evaluation failure", __FUNCTION__);
+			dbg("%s: _STA evaluation failure\n", __FUNCTION__);
 			return 0;
 		}
 		if ((tmp & ACPI_STA_FUNCTIONING) == 0)
@@ -789,13 +781,13 @@
 	if (ACPI_SUCCESS(status)) {
 		bus = tmp;
 	} else {
-		warn("can't get bus number, assuming 0");
+		warn("can't get bus number, assuming 0\n");
 		bus = 0;
 	}
 
 	/* check if this bridge has ejectable slots */
 	if (detect_ejectable_slots(handle) > 0) {
-		dbg("found PCI host-bus bridge with hot-pluggable slots");
+		dbg("found PCI host-bus bridge with hot-pluggable slots\n");
 		add_host_bridge(handle, seg, bus);
 		return 0;
 	}
@@ -807,7 +799,7 @@
 				     find_p2p_bridge, &tmp, NULL);
 
 	if (ACPI_FAILURE(status))
-		warn("find_p2p_bridge faied (error code = 0x%x)",status);
+		warn("find_p2p_bridge faied (error code = 0x%x)\n",status);
 
 	return 0;
 }
@@ -820,21 +812,23 @@
 	acpi_status status;
 	acpi_device_info info;
 	char objname[5];
-	acpi_buffer buffer = { sizeof(objname), objname };
+	acpi_buffer buffer = { .length = sizeof(objname),
+			       .pointer = objname };
 
 	status = acpi_get_object_info(handle, &info);
 	if (ACPI_FAILURE(status)) {
-		dbg("%s: failed to get bridge information", __FUNCTION__);
+		dbg("%s: failed to get bridge information\n", __FUNCTION__);
 		return AE_OK;		/* continue */
 	}
 
 	info.hardware_id[sizeof(info.hardware_id)-1] = '\0';
 
-	/* TBD check _CID also */
-	if (strcmp(info.hardware_id, ACPI_PCI_HOST_HID) == 0) {
-
+	/* TBD use acpi_get_devices() API */
+	if (info.current_status &&
+	    (info.valid & ACPI_VALID_HID) &&
+	    strcmp(info.hardware_id, ACPI_PCI_HOST_HID) == 0) {
 		acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
-		dbg("checking PCI-hotplug capable bridges under [%s]", objname);
+		dbg("checking PCI-hotplug capable bridges under [%s]\n", objname);
 		add_bridges(handle);
 	}
 	return AE_OK;
@@ -852,15 +846,15 @@
 	if (slot->flags & SLOT_POWEREDON)
 		goto err_exit;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_PS0) {
-			dbg("%s: executing _PS0 on %02x:%02x.%d", __FUNCTION__,
-			    slot->bridge->bus, slot->device, func->function);
+			dbg("%s: executing _PS0 on %s\n", __FUNCTION__,
+			    func->pci_dev->slot_name);
 			status = acpi_evaluate_object(func->handle, "_PS0", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
-				warn("%s: _PS0 failed", __FUNCTION__);
+				warn("%s: _PS0 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
 			}
@@ -890,27 +884,27 @@
 	if ((slot->flags & SLOT_POWEREDON) == 0)
 		goto err_exit;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_PS3) {
-			dbg("%s: executing _PS3 on %02x:%02x.%d", __FUNCTION__,
-			    slot->bridge->bus, slot->device, func->function);
+			dbg("%s: executing _PS3 on %s\n", __FUNCTION__,
+			    func->pci_dev->slot_name);
 			status = acpi_evaluate_object(func->handle, "_PS3", NULL, NULL);
 			if (ACPI_FAILURE(status)) {
-				warn("%s: _PS3 failed", __FUNCTION__);
+				warn("%s: _PS3 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
 			}
 		}
 	}
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_EJ0) {
-			dbg("%s: executing _EJ0 on %02x:%02x.%d", __FUNCTION__,
-			    slot->bridge->bus, slot->device, func->function);
+			dbg("%s: executing _EJ0 on %s\n", __FUNCTION__,
+			    func->pci_dev->slot_name);
 
 			/* _EJ0 method take one argument */
 			arg_list.count = 1;
@@ -920,7 +914,7 @@
 
 			status = acpi_evaluate_object(func->handle, "_EJ0", &arg_list, NULL);
 			if (ACPI_FAILURE(status)) {
-				warn("%s: _EJ0 failed", __FUNCTION__);
+				warn("%s: _EJ0 failed\n", __FUNCTION__);
 				retval = -1;
 				goto err_exit;
 			}
@@ -946,7 +940,6 @@
  */
 static int enable_device (struct acpiphp_slot *slot)
 {
-	acpi_status status;
 	u8 bus;
 	struct pci_dev dev0, *dev;
 	struct pci_bus *child;
@@ -961,7 +954,7 @@
 	dev = pci_find_slot(slot->bridge->bus, PCI_DEVFN(slot->device, 0));
 	if (dev) {
 		/* This case shouldn't happen */
-		err("pci_dev structure already exists.");
+		err("pci_dev structure already exists.\n");
 		retval = -1;
 		goto err_exit;
 	}
@@ -981,7 +974,7 @@
 	dev = pci_scan_slot (&dev0);
 
 	if (!dev) {
-		err("No new device found");
+		err("No new device found\n");
 		retval = -1;
 		goto err_exit;
 	}
@@ -993,7 +986,7 @@
 	}
 
 	/* associate pci_dev to our representation */
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		func->pci_dev = pci_find_slot(slot->bridge->bus,
@@ -1010,10 +1003,8 @@
 
 	slot->flags |= SLOT_ENABLED;
 
-#if 1
-	dbg("Available resources:");
+	dbg("Available resources:\n");
 	acpiphp_dump_resource(slot->bridge);
-#endif
 
  err_exit:
 	return retval;
@@ -1028,20 +1019,19 @@
 	int retval = 0;
 	struct acpiphp_func *func;
 	struct list_head *l;
-	acpi_status status;
 
 	/* is this slot already disabled? */
 	if (!(slot->flags & SLOT_ENABLED))
 		goto err_exit;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->pci_dev) {
 			if (acpiphp_unconfigure_function(func) == 0) {
 				func->pci_dev = NULL;
 			} else {
-				err("failed to unconfigure device");
+				err("failed to unconfigure device\n");
 				retval = -1;
 				goto err_exit;
 			}
@@ -1070,12 +1060,11 @@
 {
 	acpi_status status;
 	unsigned long sta = 0;
-	int fn;
 	u32 dvid;
 	struct list_head *l;
 	struct acpiphp_func *func;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
 		if (func->flags & FUNC_HAS_STA) {
@@ -1106,7 +1095,7 @@
 /**
  * handle_hotplug_event_bridge - handle ACPI event on bridges
  *
- * @handle: Notify()'ed acpi_handle 
+ * @handle: Notify()'ed acpi_handle
  * @type: Notify code
  * @context: pointer to acpiphp_bridge structure
  *
@@ -1117,7 +1106,8 @@
 {
 	struct acpiphp_bridge *bridge;
 	char objname[64];
-	acpi_buffer buffer = { sizeof(objname), objname };
+	acpi_buffer buffer = { .length = sizeof(objname),
+			       .pointer = objname };
 
 	bridge = (struct acpiphp_bridge *)context;
 
@@ -1126,28 +1116,28 @@
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
-		dbg("%s: Bus check notify on %s", __FUNCTION__, objname);
+		dbg("%s: Bus check notify on %s\n", __FUNCTION__, objname);
 		acpiphp_check_bridge(bridge);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		/* device check */
-		dbg("%s: Device check notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device check notify on %s\n", __FUNCTION__, objname);
 		acpiphp_check_bridge(bridge);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_WAKE:
 		/* wake event */
-		dbg("%s: Device wake notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device wake notify on %s\n", __FUNCTION__, objname);
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
-		dbg("%s: Device eject notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device eject notify on %s\n", __FUNCTION__, objname);
 		break;
 
 	default:
-		warn("notify_handler: unknown event type 0x%x for %s", type, objname);
+		warn("notify_handler: unknown event type 0x%x for %s\n", type, objname);
 		break;
 	}
 }
@@ -1156,7 +1146,7 @@
 /**
  * handle_hotplug_event_func - handle ACPI event on functions (i.e. slots)
  *
- * @handle: Notify()'ed acpi_handle 
+ * @handle: Notify()'ed acpi_handle
  * @type: Notify code
  * @context: pointer to acpiphp_func structure
  *
@@ -1167,7 +1157,8 @@
 {
 	struct acpiphp_func *func;
 	char objname[64];
-	acpi_buffer buffer = { sizeof(objname), objname };
+	acpi_buffer buffer = { .length = sizeof(objname),
+			       .pointer = objname };
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -1176,29 +1167,29 @@
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
-		dbg("%s: Bus check notify on %s", __FUNCTION__, objname);
+		dbg("%s: Bus check notify on %s\n", __FUNCTION__, objname);
 		acpiphp_enable_slot(func->slot);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		/* device check : re-enumerate from parent bus */
-		dbg("%s: Device check notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device check notify on %s\n", __FUNCTION__, objname);
 		acpiphp_check_bridge(func->slot->bridge);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_WAKE:
 		/* wake event */
-		dbg("%s: Device wake notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device wake notify on %s\n", __FUNCTION__, objname);
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
-		dbg("%s: Device eject notify on %s", __FUNCTION__, objname);
+		dbg("%s: Device eject notify on %s\n", __FUNCTION__, objname);
 		acpiphp_disable_slot(func->slot);
 		break;
 
 	default:
-		warn("notify_handler: unknown event type 0x%x for %s", type, objname);
+		warn("notify_handler: unknown event type 0x%x for %s\n", type, objname);
 		break;
 	}
 }
@@ -1225,7 +1216,7 @@
 				     NULL, NULL);
 
 	if (ACPI_FAILURE(status)) {
-		err("%s: acpi_walk_namespace() failed", __FUNCTION__);
+		err("%s: acpi_walk_namespace() failed\n", __FUNCTION__);
 		return -1;
 	}
 
@@ -1240,19 +1231,19 @@
  */
 void acpiphp_glue_exit (void)
 {
-	struct list_head *node, *shead, *l, *n;
+	struct list_head *l1, *l2, *n1, *n2;
 	struct acpiphp_bridge *bridge;
 	struct acpiphp_slot *slot, *next;
 	struct acpiphp_func *func;
 	acpi_status status;
 
-	list_for_each(node, &bridge_list) {
-		bridge = (struct acpiphp_bridge *)node;
+	list_for_each_safe (l1, n1, &bridge_list) {
+		bridge = (struct acpiphp_bridge *)l1;
 		slot = bridge->slots;
 		while (slot) {
 			next = slot->next;
-			list_for_each_safe(l, n, &slot->funcs) {
-				func = list_entry(l, struct acpiphp_func, sibling);
+			list_for_each_safe (l2, n2, &slot->funcs) {
+				func = list_entry(l2, struct acpiphp_func, sibling);
 				acpiphp_free_resource(&func->io_head);
 				acpiphp_free_resource(&func->mem_head);
 				acpiphp_free_resource(&func->p_mem_head);
@@ -1261,7 +1252,7 @@
 								    ACPI_SYSTEM_NOTIFY,
 								    handle_hotplug_event_func);
 				if (ACPI_FAILURE(status))
-					err("failed to remove notify handler");
+					err("failed to remove notify handler\n");
 				kfree(func);
 			}
 			kfree(slot);
@@ -1270,7 +1261,7 @@
 		status = acpi_remove_notify_handler(bridge->handle, ACPI_SYSTEM_NOTIFY,
 						    handle_hotplug_event_bridge);
 		if (ACPI_FAILURE(status))
-			err("failed to remove notify handler");
+			err("failed to remove notify handler\n");
 
 		acpiphp_free_resource(&bridge->io_head);
 		acpiphp_free_resource(&bridge->mem_head);
@@ -1293,13 +1284,13 @@
 
 	num_slots = 0;
 
-	list_for_each(node, &bridge_list) {
+	list_for_each (node, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)node;
-		dbg("Bus%d %dslot(s)", bridge->bus, bridge->nr_slots);
+		dbg("Bus%d %dslot(s)\n", bridge->bus, bridge->nr_slots);
 		num_slots += bridge->nr_slots;
 	}
 
-	dbg("Total %dslots", num_slots);
+	dbg("Total %dslots\n", num_slots);
 	return num_slots;
 }
 
@@ -1317,7 +1308,7 @@
 	struct acpiphp_slot *slot;
 	int retval = 0;
 
-	list_for_each(node, &bridge_list) {
+	list_for_each (node, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)node;
 		for (slot = bridge->slots; slot; slot = slot->next) {
 			retval = fn(slot, data);
@@ -1338,7 +1329,7 @@
 	struct acpiphp_bridge *bridge;
 	struct acpiphp_slot *slot;
 
-	list_for_each(node, &bridge_list) {
+	list_for_each (node, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)node;
 		for (slot = bridge->slots; slot; slot = slot->next)
 			if (slot->id == id)
@@ -1346,7 +1337,7 @@
 	}
 
 	/* should never happen! */
-	err("%s: no object for id %d",__FUNCTION__, id);
+	err("%s: no object for id %d\n",__FUNCTION__, id);
 	return 0;
 }
 
@@ -1357,7 +1348,6 @@
 int acpiphp_enable_slot (struct acpiphp_slot *slot)
 {
 	int retval;
-	int online = 0;
 
 	down(&slot->crit_sect);
 
@@ -1381,8 +1371,6 @@
  */
 int acpiphp_disable_slot (struct acpiphp_slot *slot)
 {
-	struct list_head *l;
-	struct acpiphp_func *func;
 	int retval = 0;
 
 	down(&slot->crit_sect);
@@ -1397,14 +1385,12 @@
 	if (retval)
 		goto err_exit;
 
-#if 1
 	acpiphp_resource_sort_and_combine(&slot->bridge->io_head);
 	acpiphp_resource_sort_and_combine(&slot->bridge->mem_head);
 	acpiphp_resource_sort_and_combine(&slot->bridge->p_mem_head);
 	acpiphp_resource_sort_and_combine(&slot->bridge->bus_head);
-	dbg("Available resources:");
+	dbg("Available resources:\n");
 	acpiphp_dump_resource(slot->bridge);
-#endif
 
  err_exit:
 	up(&slot->crit_sect);
@@ -1431,7 +1417,7 @@
 			if (sta != ACPI_STA_ALL) {
 				retval = acpiphp_disable_slot(slot);
 				if (retval) {
-					err("Error occured in enabling");
+					err("Error occured in enabling\n");
 					up(&slot->crit_sect);
 					goto err_exit;
 				}
@@ -1442,7 +1428,7 @@
 			if (sta == ACPI_STA_ALL) {
 				retval = acpiphp_enable_slot(slot);
 				if (retval) {
-					err("Error occured in enabling");
+					err("Error occured in enabling\n");
 					up(&slot->crit_sect);
 					goto err_exit;
 				}
@@ -1451,7 +1437,7 @@
 		}
 	}
 
-	dbg("%s: %d enabled, %d disabled", __FUNCTION__, enabled, disabled);
+	dbg("%s: %d enabled, %d disabled\n", __FUNCTION__, enabled, disabled);
 
  err_exit:
 	return retval;
diff -Nru a/drivers/hotplug/acpiphp_pci.c b/drivers/hotplug/acpiphp_pci.c
--- a/drivers/hotplug/acpiphp_pci.c	Fri Dec  6 09:51:04 2002
+++ b/drivers/hotplug/acpiphp_pci.c	Fri Dec  6 09:51:04 2002
@@ -37,16 +37,14 @@
 #include "pci_hotplug.h"
 #include "acpiphp.h"
 
-static int debug = 1;			/* XXX set 0 after debug */
 #define MY_NAME "acpiphp_pci"
 
 static void acpiphp_configure_irq (struct pci_dev *dev);
 
 
 /* allocate mem/pmem/io resource to a new function */
-static int alloc_resource (struct acpiphp_func *func)
+static int init_config_space (struct acpiphp_func *func)
 {
-	u64 base;
 	u32 bar, len;
 	u32 address[] = {
 		PCI_BASE_ADDRESS_0,
@@ -70,13 +68,13 @@
 	ops = bridge->pci_ops;
 
 	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_write_config_dword_nodev (ops, bus, device, function, address[count], 0xFFFFFFFF);
+		pci_write_config_dword_nodev(ops, bus, device, function, address[count], 0xFFFFFFFF);
 		pci_read_config_dword_nodev(ops, bus, device, function, address[count], &bar);
 
 		if (!bar)	/* This BAR is not implemented */
 			continue;
 
-		dbg("Device %02x.%02x BAR %d wants %x", device, function, count, bar);
+		dbg("Device %02x.%02x BAR %d wants %x\n", device, function, count, bar);
 
 		if (bar & PCI_BASE_ADDRESS_SPACE_IO) {
 			/* This is IO */
@@ -84,7 +82,7 @@
 			len = bar & 0xFFFFFFFC;
 			len = ~len + 1;
 
-			dbg ("len in IO %x, BAR %d", len, count);
+			dbg("len in IO %x, BAR %d\n", len, count);
 
 			spin_lock(&bridge->res_lock);
 			res = acpiphp_get_io_resource(&bridge->io_head, len);
@@ -107,7 +105,7 @@
 				len = bar & 0xFFFFFFF0;
 				len = ~len + 1;
 
-				dbg("len in PFMEM %x, BAR %d", len, count);
+				dbg("len in PFMEM %x, BAR %d\n", len, count);
 
 				spin_lock(&bridge->res_lock);
 				res = acpiphp_get_resource(&bridge->p_mem_head, len);
@@ -122,7 +120,7 @@
 				pci_write_config_dword_nodev(ops, bus, device, function, address[count], (u32)res->base);
 
 				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg ("inside the pfmem 64 case, count %d", count);
+					dbg("inside the pfmem 64 case, count %d\n", count);
 					count += 1;
 					pci_write_config_dword_nodev(ops, bus, device, function, address[count], (u32)(res->base >> 32));
 				}
@@ -136,7 +134,7 @@
 				len = bar & 0xFFFFFFF0;
 				len = ~len + 1;
 
-				dbg("len in MEM %x, BAR %d", len, count);
+				dbg("len in MEM %x, BAR %d\n", len, count);
 
 				spin_lock(&bridge->res_lock);
 				res = acpiphp_get_resource(&bridge->mem_head, len);
@@ -152,7 +150,7 @@
 
 				if (bar & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
-					dbg ("inside mem 64 case, reg. mem, count %d", count);
+					dbg("inside mem 64 case, reg. mem, count %d\n", count);
 					count += 1;
 					pci_write_config_dword_nodev(ops, bus, device, function, address[count], (u32)(res->base >> 32));
 				}
@@ -203,15 +201,16 @@
 	pci_proc_attach_device(dev);
 #endif
 	pci_announce_device_to_drivers(dev);
+	info("Device %s configured\n", dev->slot_name);
 
 	return 0;
 }
 
 
-static int is_pci_dev_in_use (struct pci_dev* dev) 
+static int is_pci_dev_in_use (struct pci_dev* dev)
 {
-	/* 
-	 * dev->driver will be set if the device is in use by a new-style 
+	/*
+	 * dev->driver will be set if the device is in use by a new-style
 	 * driver -- otherwise, check the device's regions to see if any
 	 * driver has claimed them
 	 */
@@ -253,13 +252,13 @@
 {
 	struct pci_dev *dev = wrapped_dev->dev;
 
-	dbg("attempting removal of driver for device %s", dev->slot_name);
+	dbg("attempting removal of driver for device %s\n", dev->slot_name);
 
 	/* Now, remove the Linux Driver Representation */
 	if (dev->driver) {
 		if (dev->driver->remove) {
 			dev->driver->remove(dev);
-			dbg("driver was properly removed");
+			dbg("driver was properly removed\n");
 		}
 		dev->driver = NULL;
 	}
@@ -276,6 +275,7 @@
 	/* Now, remove the Linux Representation */
 	if (dev) {
 		if (pci_hp_remove_device(dev) == 0) {
+			info("Device %s removed\n", dev->slot_name);
 			kfree(dev); /* Now, remove */
 		} else {
 			return -1; /* problems while freeing, abort visitation */
@@ -313,7 +313,7 @@
 /* detect_used_resource - subtract resource under dev from bridge */
 static int detect_used_resource (struct acpiphp_bridge *bridge, struct pci_dev *dev)
 {
-	u32 bar, len, pin;
+	u32 bar, len;
 	u64 base;
 	u32 address[] = {
 		PCI_BASE_ADDRESS_0,
@@ -327,7 +327,7 @@
 	int count;
 	struct pci_resource *res;
 
-	dbg("Device %s", dev->slot_name);
+	dbg("Device %s\n", dev->slot_name);
 
 	for (count = 0; address[count]; count++) {	/* for 6 BARs */
 		pci_read_config_dword(dev, address[count], &bar);
@@ -344,7 +344,7 @@
 			len &= 0xFFFFFFFC;
 			len = ~len + 1;
 
-			dbg("BAR[%d] %08x - %08x (IO)", count, (u32)base, (u32)base + len - 1);
+			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
 
 			spin_lock(&bridge->res_lock);
 			res = acpiphp_get_resource_with_base(&bridge->io_head, base, len);
@@ -361,10 +361,10 @@
 				len = ~len + 1;
 
 				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg ("prefetch mem 64");
+					dbg("prefetch mem 64\n");
 					count += 1;
 				}
-				dbg("BAR[%d] %08x - %08x (PMEM)", count, (u32)base, (u32)base + len - 1);
+				dbg("BAR[%d] %08x - %08x (PMEM)\n", count, (u32)base, (u32)base + len - 1);
 				spin_lock(&bridge->res_lock);
 				res = acpiphp_get_resource_with_base(&bridge->p_mem_head, base, len);
 				spin_unlock(&bridge->res_lock);
@@ -378,10 +378,10 @@
 
 				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
-					dbg ("mem 64");
+					dbg("mem 64\n");
 					count += 1;
 				}
-				dbg("BAR[%d] %08x - %08x (MEM)", count, (u32)base, (u32)base + len - 1);
+				dbg("BAR[%d] %08x - %08x (MEM)\n", count, (u32)base, (u32)base + len - 1);
 				spin_lock(&bridge->res_lock);
 				res = acpiphp_get_resource_with_base(&bridge->mem_head, base, len);
 				spin_unlock(&bridge->res_lock);
@@ -403,7 +403,7 @@
 	struct list_head *l;
 	struct pci_dev *dev;
 
-	list_for_each(l, &bus->devices) {
+	list_for_each (l, &bus->devices) {
 		dev = pci_dev_b(l);
 		detect_used_resource(bridge, dev);
 		/* XXX recursive call */
@@ -421,9 +421,6 @@
  */
 int acpiphp_detect_pci_resource (struct acpiphp_bridge *bridge)
 {
-	struct list_head *l;
-	struct pci_dev *dev;
-
 	detect_used_resource_bus(bridge, bridge->pci_bus);
 
 	return 0;
@@ -452,20 +449,19 @@
 	};
 	int count;
 	struct pci_resource *res;
-	struct pci_ops *ops;
 	struct pci_dev *dev;
 
 	dev = func->pci_dev;
-	dbg("Hot-pluggable device %s", dev->slot_name);
+	dbg("Hot-pluggable device %s\n", dev->slot_name);
 
 	for (count = 0; address[count]; count++) {	/* for 6 BARs */
-		pci_read_config_dword (dev, address[count], &bar);
+		pci_read_config_dword(dev, address[count], &bar);
 
 		if (!bar)	/* This BAR is not implemented */
 			continue;
 
-		pci_write_config_dword (dev, address[count], 0xFFFFFFFF);
-		pci_read_config_dword (dev, address[count], &len);
+		pci_write_config_dword(dev, address[count], 0xFFFFFFFF);
+		pci_read_config_dword(dev, address[count], &len);
 
 		if (len & PCI_BASE_ADDRESS_SPACE_IO) {
 			/* This is IO */
@@ -473,7 +469,7 @@
 			len &= 0xFFFFFFFC;
 			len = ~len + 1;
 
-			dbg("BAR[%d] %08x - %08x (IO)", count, (u32)base, (u32)base + len - 1);
+			dbg("BAR[%d] %08x - %08x (IO)\n", count, (u32)base, (u32)base + len - 1);
 
 			res = acpiphp_make_resource(base, len);
 			if (!res)
@@ -492,10 +488,10 @@
 				len = ~len + 1;
 
 				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {	/* takes up another dword */
-					dbg ("prefetch mem 64");
+					dbg("prefetch mem 64\n");
 					count += 1;
 				}
-				dbg("BAR[%d] %08x - %08x (PMEM)", count, (u32)base, (u32)base + len - 1);
+				dbg("BAR[%d] %08x - %08x (PMEM)\n", count, (u32)base, (u32)base + len - 1);
 				res = acpiphp_make_resource(base, len);
 				if (!res)
 					goto no_memory;
@@ -511,10 +507,10 @@
 
 				if (len & PCI_BASE_ADDRESS_MEM_TYPE_64) {
 					/* takes up another dword */
-					dbg ("mem 64");
+					dbg("mem 64\n");
 					count += 1;
 				}
-				dbg("BAR[%d] %08x - %08x (MEM)", count, (u32)base, (u32)base + len - 1);
+				dbg("BAR[%d] %08x - %08x (MEM)\n", count, (u32)base, (u32)base + len - 1);
 				res = acpiphp_make_resource(base, len);
 				if (!res)
 					goto no_memory;
@@ -525,7 +521,7 @@
 			}
 		}
 
-		pci_write_config_dword (dev, address[count], bar);
+		pci_write_config_dword(dev, address[count], bar);
 	}
 #if 1
 	acpiphp_dump_func_resource(func);
@@ -534,7 +530,7 @@
 	return 0;
 
  no_memory:
-	err("out of memory");
+	err("out of memory\n");
 	acpiphp_free_resource(&func->io_head);
 	acpiphp_free_resource(&func->mem_head);
 	acpiphp_free_resource(&func->p_mem_head);
@@ -567,7 +563,7 @@
 	if (hdr & 0x80)
 		is_multi = 1;
 
-	list_for_each(l, &slot->funcs) {
+	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 		if (is_multi || func->function == 0) {
 			pci_read_config_dword_nodev(slot->bridge->pci_ops,
@@ -576,7 +572,7 @@
 						    func->function,
 						    PCI_VENDOR_ID, &dvid);
 			if (dvid != 0xffffffff) {
-				retval = alloc_resource(func);
+				retval = init_config_space(func);
 				if (retval)
 					break;
 			}
@@ -589,16 +585,16 @@
 
 /* for pci_visit_dev() */
 static struct pci_visit configure_functions = {
-	post_visit_pci_dev:	configure_pci_dev
+	.post_visit_pci_dev =	configure_pci_dev
 };
 
 static struct pci_visit unconfigure_functions_phase1 = {
-	post_visit_pci_dev:	unconfigure_pci_dev_driver
+	.post_visit_pci_dev =	unconfigure_pci_dev_driver
 };
 
 static struct pci_visit unconfigure_functions_phase2 = {
-	post_visit_pci_bus:	unconfigure_pci_bus,
-	post_visit_pci_dev:	unconfigure_pci_dev
+	.post_visit_pci_bus =	unconfigure_pci_bus,
+	.post_visit_pci_dev =	unconfigure_pci_dev
 };
 
 
@@ -647,7 +643,6 @@
 int acpiphp_unconfigure_function (struct acpiphp_func *func)
 {
 	struct acpiphp_bridge *bridge;
-	struct pci_resource *tmp;
 	struct pci_dev_wrapped wrapped_dev;
 	struct pci_bus_wrapped wrapped_bus;
 	int retval = 0;
@@ -686,45 +681,6 @@
 }
 
 
-/* XXX IA64 specific */
-#ifdef CONFIG_IA64
-static int ia64_get_irq(struct pci_dev *dev, int pin)
-{
-	extern int pci_pin_to_vector(int bus, int slot, int pci_pin);
-	int irq;
-
-	irq = pci_pin_to_vector(dev->bus->number, PCI_SLOT(dev->devfn), pin);
-
-	if (irq < 0 && dev->bus->parent) {
-		/* go back to the bridge */
-		struct pci_dev *bridge = dev->bus->self;
-
-		if (bridge) {
-			/* allow for multiple bridges on an adapter */
-			do {
-				/* do the bridge swizzle... */
-				pin = (pin + PCI_SLOT(dev->devfn)) % 4;
-				irq = pci_pin_to_vector(bridge->bus->number,
-							PCI_SLOT(bridge->devfn),
-							   pin);
-			} while (irq < 0 && (bridge = bridge->bus->self));
-		}
-		if (irq >= 0)
-			printk(KERN_WARNING
-			       "PCI: using PPB(B%d,I%d,P%d) to get vector %02x\n",
-			       dev->bus->number, PCI_SLOT(dev->devfn),
-			       pin, irq);
-		else
-			printk(KERN_WARNING
-			       "PCI: Couldn't map irq for (B%d,I%d,P%d)\n",
-			       dev->bus->number, PCI_SLOT(dev->devfn), pin);
-	}
-
-	return irq;
-}
-#endif
-
-
 /*
  * acpiphp_configure_irq - configure PCI_INTERRUPT_PIN
  *
@@ -740,24 +696,10 @@
  */
 static void acpiphp_configure_irq (struct pci_dev *dev)
 {
-#if CONFIG_IA64		    /* XXX IA64 specific, need i386 version */
-	int bus, device, function, irq;
-	u8 tmp;
-
-	bus = dev->bus->number;
-	device = PCI_SLOT(dev->devfn);
-	function = PCI_FUNC(dev->devfn);
-
-	pci_read_config_byte (dev, PCI_INTERRUPT_PIN, &tmp);
-
-	if ((tmp > 0x00) && (tmp < 0x05)) {
-		irq = ia64_get_irq(dev, tmp - 1);
-		if (irq > 0) {
-			dev->irq = irq;
-			pci_write_config_byte (dev, PCI_INTERRUPT_LINE, irq);
-		} else {
-			err("Couldn't get IRQ for INT%c", 'A' + tmp - 1);
-		}
-	}
+#if CONFIG_IA64		    /* XXX IA64 specific */
+	extern void iosapic_fixup_pci_interrupt (struct pci_dev *dev);
+
+	iosapic_fixup_pci_interrupt(dev);
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
 #endif
 }
diff -Nru a/drivers/hotplug/acpiphp_res.c b/drivers/hotplug/acpiphp_res.c
--- a/drivers/hotplug/acpiphp_res.c	Fri Dec  6 09:51:04 2002
+++ b/drivers/hotplug/acpiphp_res.c	Fri Dec  6 09:51:04 2002
@@ -59,8 +59,6 @@
 
 #define MY_NAME "acpiphp_res"
 
-/* local variables */
-static int debug = 0;
 
 /*
  * sort_by_size - sort nodes by their length, smallest first
@@ -275,7 +273,7 @@
 
 	for (max = *head;max; max = max->next) {
 
-		/* If not big enough we could probably just bail, 
+		/* If not big enough we could probably just bail,
 		   instead we'll continue to the next. */
 		if (max->length < size)
 			continue;
@@ -372,13 +370,13 @@
 		return NULL;
 
 	for (node = *head; node; node = node->next) {
-		dbg("%s: req_size =%x node=%p, base=%x, length=%x",
+		dbg("%s: req_size =%x node=%p, base=%x, length=%x\n",
 		    __FUNCTION__, size, node, (u32)node->base, node->length);
 		if (node->length < size)
 			continue;
 
 		if (node->base & (size - 1)) {
-			dbg("%s: not aligned", __FUNCTION__);
+			dbg("%s: not aligned\n", __FUNCTION__);
 			/* this one isn't base aligned properly
 			   so we'll make a new entry and split it up */
 			temp_qword = (node->base | (size-1)) + 1;
@@ -402,7 +400,7 @@
 
 		/* Don't need to check if too small since we already did */
 		if (node->length > size) {
-			dbg("%s: too big", __FUNCTION__);
+			dbg("%s: too big\n", __FUNCTION__);
 			/* this one is longer than we need
 			   so we'll make a new entry and split it up */
 			split_node = acpiphp_make_resource(node->base + size, node->length - size);
@@ -417,7 +415,7 @@
 			node->next = split_node;
 		}  /* End of too big on top end */
 
-		dbg("%s: got one!!!", __FUNCTION__);
+		dbg("%s: got one!!!\n", __FUNCTION__);
 		/* If we got here, then it is the right size
 		   Now take it out of the list */
 		if (*head == node) {
@@ -439,7 +437,7 @@
 /**
  * get_resource_with_base - get resource with specific base address
  *
- * this function 
+ * this function
  * returns the first node of "size" length located at specified base address.
  * If it finds a node larger than "size" it will split it up.
  *
@@ -460,7 +458,7 @@
 		return NULL;
 
 	for (node = *head; node; node = node->next) {
-		dbg(": 1st req_base=%x req_size =%x node=%p, base=%x, length=%x",
+		dbg(": 1st req_base=%x req_size =%x node=%p, base=%x, length=%x\n",
 		    (u32)base, size, node, (u32)node->base, node->length);
 		if (node->base > base)
 			continue;
@@ -469,7 +467,7 @@
 			continue;
 
 		if (node->base < base) {
-			dbg(": split 1");
+			dbg(": split 1\n");
 			/* this one isn't base aligned properly
 			   so we'll make a new entry and split it up */
 			temp_qword = base;
@@ -491,12 +489,12 @@
 			node->next = split_node;
 		}
 
-		dbg(": 2nd req_base=%x req_size =%x node=%p, base=%x, length=%x",
+		dbg(": 2nd req_base=%x req_size =%x node=%p, base=%x, length=%x\n",
 		    (u32)base, size, node, (u32)node->base, node->length);
 
 		/* Don't need to check if too small since we already did */
 		if (node->length > size) {
-			dbg(": split 2");
+			dbg(": split 2\n");
 			/* this one is longer than we need
 			   so we'll make a new entry and split it up */
 			split_node = acpiphp_make_resource(node->base + size, node->length - size);
@@ -511,7 +509,7 @@
 			node->next = split_node;
 		}  /* End of too big on top end */
 
-		dbg(": got one!!!");
+		dbg(": got one!!!\n");
 		/* If we got here, then it is the right size
 		   Now take it out of the list */
 		if (*head == node) {
@@ -549,13 +547,13 @@
 	if (!(*head))
 		return 1;
 
-	dbg("*head->next = %p",(*head)->next);
+	dbg("*head->next = %p\n",(*head)->next);
 
 	if (!(*head)->next)
 		return 0;	/* only one item on the list, already sorted! */
 
-	dbg("*head->base = 0x%x",(u32)(*head)->base);
-	dbg("*head->next->base = 0x%x", (u32)(*head)->next->base);
+	dbg("*head->base = 0x%x\n",(u32)(*head)->base);
+	dbg("*head->next->base = 0x%x\n", (u32)(*head)->next->base);
 	while (out_of_order) {
 		out_of_order = 0;
 
@@ -589,7 +587,7 @@
 	while (node1 && node1->next) {
 		if ((node1->base + node1->length) == node1->next->base) {
 			/* Combine */
-			dbg("8..");
+			dbg("8..\n");
 			node1->length += node1->next->length;
 			node2 = node1->next;
 			node1->next = node1->next->next;
@@ -670,39 +668,32 @@
 	cnt = 0;
 
 	while (p) {
-		info("[%02d] %08x - %08x",
-		     cnt++, (u32)p->base, (u32)p->base + p->length - 1);
+		dbg("[%02d] %08x - %08x\n",
+		    cnt++, (u32)p->base, (u32)p->base + p->length - 1);
 		p = p->next;
 	}
 }
 
 void acpiphp_dump_resource(struct acpiphp_bridge *bridge)
 {
-	info("I/O resource:");
+	dbg("I/O resource:\n");
 	dump_resource(bridge->io_head);
-	info("MEM resource:");
+	dbg("MEM resource:\n");
 	dump_resource(bridge->mem_head);
-	info("PMEM resource:");
+	dbg("PMEM resource:\n");
 	dump_resource(bridge->p_mem_head);
-	info("BUS resource:");
+	dbg("BUS resource:\n");
 	dump_resource(bridge->bus_head);
 }
 
 void acpiphp_dump_func_resource(struct acpiphp_func *func)
 {
-	info("I/O resource:");
+	dbg("I/O resource:\n");
 	dump_resource(func->io_head);
-	info("MEM resource:");
+	dbg("MEM resource:\n");
 	dump_resource(func->mem_head);
-	info("PMEM resource:");
+	dbg("PMEM resource:\n");
 	dump_resource(func->p_mem_head);
-	info("BUS resource:");
+	dbg("BUS resource:\n");
 	dump_resource(func->bus_head);
 }
-
-/*
-EXPORT_SYMBOL(acpiphp_get_io_resource);
-EXPORT_SYMBOL(acpiphp_get_max_resource);
-EXPORT_SYMBOL(acpiphp_get_resource);
-EXPORT_SYMBOL(acpiphp_resource_sort_and_combine);
-*/
