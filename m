Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266335AbSKUDyF>; Wed, 20 Nov 2002 22:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbSKUDyF>; Wed, 20 Nov 2002 22:54:05 -0500
Received: from 216-99-218-29.dsl.aracnet.com ([216.99.218.29]:17799 "EHLO
	dexter.groveronline.com") by vger.kernel.org with ESMTP
	id <S266335AbSKUDyB>; Wed, 20 Nov 2002 22:54:01 -0500
Date: Wed, 20 Nov 2002 20:00:13 -0800 (PST)
From: Andy Grover <agrover@groveronline.com>
To: stelian.pop@fr.alcove.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow others to use ACPI EC interface
Message-ID: <Pine.LNX.4.44.0211201949450.23016-100000@dexter.groveronline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stelian,

Do you have a system that works with ACPI?

This patch against 2.5.latest adds externally callable ec_read and
ec_write functions to the ACPI EC driver. Calling these should allow the
sonypi driver to avoid EC contention when ACPI is present.

Unfortunately I don't think sonypi will be able to remove its own EC read 
and write functions, for the non-ACPI case.

Comments?

Thanks -- Regards -- Andy


===== drivers/acpi/acpi_ksyms.c 1.18 vs edited =====
--- 1.18/drivers/acpi/acpi_ksyms.c	Tue Oct 22 16:14:07 2002
+++ edited/drivers/acpi/acpi_ksyms.c	Wed Nov 20 19:39:04 2002
@@ -24,6 +24,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/acpi.h>
 #include "include/acpi.h"
 #include "acpi_bus.h"
 
@@ -141,3 +142,11 @@
 extern int acpi_pci_irq_lookup (int segment, int bus, int device, int pin);
 EXPORT_SYMBOL(acpi_pci_irq_lookup);
 #endif /*CONFIG_ACPI_PCI */
+
+#ifdef CONFIG_ACPI_EC
+/* ACPI EC driver (ec.c) */
+
+EXPORT_SYMBOL(ec_read);
+EXPORT_SYMBOL(ec_write);
+#endif
+
===== drivers/acpi/ec.c 1.15 vs edited =====
--- 1.15/drivers/acpi/ec.c	Mon Nov 11 16:56:45 2002
+++ edited/drivers/acpi/ec.c	Wed Nov 20 19:41:46 2002
@@ -92,6 +92,9 @@
 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
 static struct acpi_ec	*ec_ecdt;
 
+/* External interfaces use first EC only, so remember */
+static struct acpi_device *first_ec;
+
 /* --------------------------------------------------------------------------
                              Transaction Management
    -------------------------------------------------------------------------- */
@@ -236,6 +239,47 @@
 	return_VALUE(result);
 }
 
+/*
+ * Externally callable EC access functions. For now, assume 1 EC only
+ */
+int
+ec_read(u8 addr, u8 *val)
+{
+	struct acpi_ec *ec;
+	int err;
+	u32 temp_data;
+
+	if (!first_ec)
+		return -ENODEV;
+
+	ec = acpi_driver_data(first_ec);
+
+	err = acpi_ec_read(ec, addr, &temp_data);
+
+	if (!err) {
+		*val = temp_data;
+		return 0;
+	}
+	else
+		return err;
+}
+
+int
+ec_write(u8 addr, u8 val)
+{
+	struct acpi_ec *ec;
+	int err;
+
+	if (!first_ec)
+		return -ENODEV;
+
+	ec = acpi_driver_data(first_ec);
+
+	err = acpi_ec_write(ec, addr, val);
+
+	return err;
+}
+
 
 static int
 acpi_ec_query (
@@ -540,11 +584,15 @@
 	acpi_evaluate_integer(ec->handle, "_GLK", NULL, &ec->global_lock);
 
 	/* If our UID matches the UID for the ECDT-enumerated EC,
-	   we already found this EC, so abort. */
+	   we now have the *real* EC info, so kill the makeshift one.*/
 	acpi_evaluate_integer(ec->handle, "_UID", NULL, &uid);
 	if (ec_ecdt && ec_ecdt->uid == uid) {
-		result = -ENODEV;
-		goto end;
+		acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
+			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
+	
+		acpi_remove_gpe_handler(ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
+
+		kfree(ec_ecdt);
 	}
 
 	/* Get GPE bit assignment (EC events). */
@@ -564,6 +612,9 @@
 		acpi_device_name(device), acpi_device_bid(device),
 		(u32) ec->gpe_bit);
 
+	if (!first_ec)
+		first_ec = device;
+
 end:
 	if (result)
 		kfree(ec);
@@ -584,7 +635,7 @@
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	ec = (struct acpi_ec *) acpi_driver_data(device);
+	ec = acpi_driver_data(device);
 
 	acpi_ec_remove_fs(device);
 
@@ -609,7 +660,7 @@
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	ec = (struct acpi_ec *) acpi_driver_data(device);
+	ec = acpi_driver_data(device);
 
 	if (!ec)
 		return_VALUE(-EINVAL);
@@ -688,7 +739,7 @@
 	if (!device)
 		return_VALUE(-EINVAL);
 
-	ec = (struct acpi_ec *) acpi_driver_data(device);
+	ec = acpi_driver_data(device);
 
 	status = acpi_remove_address_space_handler(ec->handle,
 		ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
@@ -711,50 +762,50 @@
 
 	status = acpi_get_firmware_table("ECDT", 1, ACPI_LOGICAL_ADDRESSING, 
 		(acpi_table_header **) &ecdt_ptr);
-	if (ACPI_SUCCESS(status)) {
-		printk(KERN_INFO PREFIX "Found ECDT\n");
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	printk(KERN_INFO PREFIX "Found ECDT\n");
+
+	 /*
+	 * Generate a temporary ec context to use until the namespace is scanned
+	 */
+	ec_ecdt = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
+	if (!ec_ecdt)
+		return -ENOMEM;
+	memset(ec_ecdt, 0, sizeof(struct acpi_ec));
+
+	ec_ecdt->command_addr = ecdt_ptr->ec_control;
+	ec_ecdt->status_addr = ecdt_ptr->ec_control;
+	ec_ecdt->data_addr = ecdt_ptr->ec_data;
+	ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
+	ec_ecdt->lock = SPIN_LOCK_UNLOCKED;
+	/* use the GL just to be safe */
+	ec_ecdt->global_lock = TRUE;
+	ec_ecdt->uid = ecdt_ptr->uid;
 
-		/*
-		 * TODO: When the new driver model allows it, simply tell the
-		 * EC driver it has a new device via that, instead if this.
-		 */
-		ec_ecdt = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
-		if (!ec_ecdt)
-			return -ENOMEM;
-		memset(ec_ecdt, 0, sizeof(struct acpi_ec));
-		
-		ec_ecdt->command_addr = ecdt_ptr->ec_control;
-		ec_ecdt->status_addr = ecdt_ptr->ec_control;
-		ec_ecdt->data_addr = ecdt_ptr->ec_data;
-		ec_ecdt->gpe_bit = ecdt_ptr->gpe_bit;
-		ec_ecdt->lock = SPIN_LOCK_UNLOCKED;
-		/* use the GL just to be safe */
-		ec_ecdt->global_lock = TRUE;
-		ec_ecdt->uid = ecdt_ptr->uid;
-
-		status = acpi_get_handle(NULL, ecdt_ptr->ec_id, &ec_ecdt->handle);
-		if (ACPI_FAILURE(status)) {
-			goto error;
-		}
-
-		/*
-		 * Install GPE handler
-		 */
-		status = acpi_install_gpe_handler(ec_ecdt->gpe_bit,
-			ACPI_EVENT_EDGE_TRIGGERED, &acpi_ec_gpe_handler,
-			ec_ecdt);
-		if (ACPI_FAILURE(status)) {
-			goto error;
-		}
-
-		status = acpi_install_address_space_handler (ACPI_ROOT_OBJECT,
-				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler,
-				&acpi_ec_space_setup, ec_ecdt);
-		if (ACPI_FAILURE(status)) {
-			acpi_remove_gpe_handler(ec_ecdt->gpe_bit,
-				&acpi_ec_gpe_handler);
-			goto error;
-		}
+	status = acpi_get_handle(NULL, ecdt_ptr->ec_id, &ec_ecdt->handle);
+	if (ACPI_FAILURE(status)) {
+		goto error;
+	}
+
+	/*
+	 * Install GPE handler
+	 */
+	status = acpi_install_gpe_handler(ec_ecdt->gpe_bit,
+		ACPI_EVENT_EDGE_TRIGGERED, &acpi_ec_gpe_handler,
+		ec_ecdt);
+	if (ACPI_FAILURE(status)) {
+		goto error;
+	}
+
+	status = acpi_install_address_space_handler (ACPI_ROOT_OBJECT,
+			ACPI_ADR_SPACE_EC, &acpi_ec_space_handler,
+			&acpi_ec_space_setup, ec_ecdt);
+	if (ACPI_FAILURE(status)) {
+		acpi_remove_gpe_handler(ec_ecdt->gpe_bit,
+			&acpi_ec_gpe_handler);
+		goto error;
 	}
 
 	return 0;
@@ -796,20 +847,6 @@
 /* EC driver currently not unloadable */
 #if 0
 static void __exit
-acpi_ec_ecdt_exit (void)
-{
-	if (!ec_ecdt)
-		return;
-
-	acpi_remove_address_space_handler(ACPI_ROOT_OBJECT,
-		ACPI_ADR_SPACE_EC, &acpi_ec_space_handler);
-	
-	acpi_remove_gpe_handler(ec_ecdt->gpe_bit, &acpi_ec_gpe_handler);
-
-	kfree(ec_ecdt);
-}
-
-static void __exit
 acpi_ec_exit (void)
 {
 	ACPI_FUNCTION_TRACE("acpi_ec_exit");
@@ -817,8 +854,6 @@
 	acpi_bus_unregister_driver(&acpi_ec_driver);
 
 	remove_proc_entry(ACPI_EC_CLASS, acpi_root_dir);
-
-	acpi_ec_ecdt_exit();
 
 	return_VOID;
 }
===== include/linux/acpi.h 1.17 vs edited =====
--- 1.17/include/linux/acpi.h	Tue Oct 22 15:58:43 2002
+++ edited/include/linux/acpi.h	Wed Nov 20 19:38:22 2002
@@ -419,6 +419,12 @@
 
 #endif /*CONFIG_ACPI_PCI*/
 
+#ifdef CONFIG_ACPI_EC
+
+int ec_read(u8 addr, u8 *val);
+int ec_write(u8 addr, u8 val);
+
+#endif /*CONFIG_ACPI_EC*/
 
 #ifdef CONFIG_ACPI
 

