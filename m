Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbUKDMXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbUKDMXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUKDMWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:22:18 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:61909 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262192AbUKDMPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:15:17 -0500
Message-ID: <418A1D51.4010504@free.fr>
Date: Thu, 04 Nov 2004 13:15:13 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mailinglisten@hentges.net
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
Content-Type: multipart/mixed;
 boundary="------------090900020807050304060100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090900020807050304060100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 > Hello Len,
 >
 > Am Dienstag, den 02.11.2004, 01:46 -0500 schrieb Len Brown:
 >
 > [...]
 >
 > > With the unmodified -mm2 tree, please build with CONFIG_PNPACPI=n
 > > and give that a go.
 >
 > Setting CONFIG_PNPACPI=n ( which can be found in drivers/pnp btw, for
 > all those reading this thread ) indeed fixes the problem.
 >
 > As does applying your remove_driver.patch ( with CONFIG_PNPACPI=y) from
 > the other other thread.
 >
 > Both work-arounds  also fix the asus_acpi kernel module which either
 > wouldn't load at all (no such device) or would load but do nothing
 > (empty /p/a/asus).
 >
 > HTH

Could you try these 2 patchs with CONFIG_PNPACPI=y ?

Thanks

Matthieu

--------------090900020807050304060100
Content-Type: text/x-patch;
 name="pnpacpi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpacpi.patch"

--- linux-2.6.9/drivers/pnp/pnpacpi/core.c.old	2004-11-04 11:56:25.000000000 +0100
+++ linux-2.6.9/drivers/pnp/pnpacpi/core.c	2004-11-04 12:13:46.000000000 +0100
@@ -239,7 +239,11 @@
 static int acpi_pnp_match(struct acpi_device *device,
 	struct acpi_driver	*driver)
 {
-	return (!ispnpidacpi(acpi_device_hid(device)) ||
+	acpi_handle temp = NULL;
+	acpi_status status;
+	/* don't lock non standard pnp device */
+	status = acpi_get_handle(device->handle, "_CRS", &temp);
+	return (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
 		is_exclusive_device(device));
 }
 

--------------090900020807050304060100
Content-Type: text/x-patch;
 name="i8042_pnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8042_pnp.patch"

--- linux-2.6.9/drivers/input/serio/i8042.c.old	2004-11-04 10:28:58.000000000 +0100
+++ linux-2.6.9/drivers/input/serio/i8042.c	2004-11-04 10:28:58.000000000 +0100
@@ -55,10 +55,10 @@
 module_param_named(noloop, i8042_noloop, bool, 0);
 MODULE_PARM_DESC(dumbkbd, "Disable the AUX Loopback command while probing for the AUX port");
 
-#ifdef CONFIG_ACPI
-static int i8042_noacpi;
-module_param_named(noacpi, i8042_noacpi, bool, 0);
-MODULE_PARM_DESC(noacpi, "Do not use ACPI to detect controller settings");
+#ifdef CONFIG_PNP
+static int i8042_nopnp;
+module_param_named(nopnp, i8042_nopnp, bool, 0);
+MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
 #endif
 
 #define DEBUG
--- linux-2.6.9/drivers/input/serio/i8042-x86ia64io.h.old	2004-11-04 10:29:11.000000000 +0100
+++ linux-2.6.9/drivers/input/serio/i8042-x86ia64io.h	2004-11-04 13:09:21.000000000 +0100
@@ -88,183 +88,113 @@
 };
 #endif
 
-#ifdef CONFIG_ACPI
-#include <linux/acpi.h>
-#include <acpi/acpi_bus.h>
-
-struct i8042_acpi_resources {
-	unsigned int port1;
-	unsigned int port2;
-	unsigned int irq;
-};
+#ifdef CONFIG_PNP
+#include <linux/pnp.h>
 
-static int i8042_acpi_kbd_registered;
-static int i8042_acpi_aux_registered;
+static int i8042_pnp_kbd_registered;
+static int i8042_pnp_aux_registered;
 
-static acpi_status i8042_acpi_parse_resource(struct acpi_resource *res, void *data)
-{
-	struct i8042_acpi_resources *i8042_res = data;
-	struct acpi_resource_io *io;
-	struct acpi_resource_fixed_io *fixed_io;
-	struct acpi_resource_irq *irq;
-	struct acpi_resource_ext_irq *ext_irq;
-
-	switch (res->id) {
-		case ACPI_RSTYPE_IO:
-			io = &res->data.io;
-			if (io->range_length) {
-				if (!i8042_res->port1)
-					i8042_res->port1 = io->min_base_address;
-				else
-					i8042_res->port2 = io->min_base_address;
-			}
-			break;
-
-		case ACPI_RSTYPE_FIXED_IO:
-			fixed_io = &res->data.fixed_io;
-			if (fixed_io->range_length) {
-				if (!i8042_res->port1)
-					i8042_res->port1 = fixed_io->base_address;
-				else
-					i8042_res->port2 = fixed_io->base_address;
-			}
-			break;
-
-		case ACPI_RSTYPE_IRQ:
-			irq = &res->data.irq;
-			if (irq->number_of_interrupts > 0)
-				i8042_res->irq =
-					acpi_register_gsi(irq->interrupts[0],
-							  irq->edge_level,
-							  irq->active_high_low);
-			break;
-
-		case ACPI_RSTYPE_EXT_IRQ:
-			ext_irq = &res->data.extended_irq;
-			if (ext_irq->number_of_interrupts > 0)
-				i8042_res->irq =
-					acpi_register_gsi(ext_irq->interrupts[0],
-							  ext_irq->edge_level,
-							  ext_irq->active_high_low);
-			break;
-	}
-	return AE_OK;
-}
 
-static int i8042_acpi_kbd_add(struct acpi_device *device)
+static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
-	struct i8042_acpi_resources kbd_res;
-	acpi_status status;
-
-	memset(&kbd_res, 0, sizeof(kbd_res));
-	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-				     i8042_acpi_parse_resource, &kbd_res);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	if (kbd_res.port1)
-		i8042_data_reg = kbd_res.port1;
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_data_reg = pnp_port_start(dev,0);
 	else
-		printk(KERN_WARNING "ACPI: [%s] has no data port; default is 0x%x\n",
-			acpi_device_bid(device), i8042_data_reg);
+		printk(KERN_WARNING "PNP: [%s] has no data port; default is 0x%x\n",
+			pnp_dev_name(dev), i8042_data_reg);
 
-	if (kbd_res.port2)
-		i8042_command_reg = kbd_res.port2;
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_command_reg = pnp_port_start(dev,1);
 	else
-		printk(KERN_WARNING "ACPI: [%s] has no command port; default is 0x%x\n",
-			acpi_device_bid(device), i8042_command_reg);
+		printk(KERN_WARNING "PNP: [%s] has no command port; default is 0x%x\n",
+			pnp_dev_name(dev), i8042_command_reg);
 
-	if (kbd_res.irq)
-		i8042_kbd_irq = kbd_res.irq;
+	if (pnp_irq_valid(dev,0))
+		i8042_kbd_irq = pnp_irq(dev,0);
 	else
-		printk(KERN_WARNING "ACPI: [%s] has no IRQ; default is %d\n",
-			acpi_device_bid(device), i8042_kbd_irq);
+		printk(KERN_WARNING "PNP: [%s] has no IRQ; default is %d\n",
+			pnp_dev_name(dev), i8042_kbd_irq);
 
-	strncpy(acpi_device_name(device), "PS/2 Keyboard Controller",
-		sizeof(acpi_device_name(device)));
-	printk("ACPI: %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
-		acpi_device_name(device), acpi_device_bid(device),
+	printk("PNP: %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
+		"PS/2 Keyboard Controller", pnp_dev_name(dev),
 		i8042_data_reg, i8042_command_reg, i8042_kbd_irq);
 
 	return 0;
 }
 
-static int i8042_acpi_aux_add(struct acpi_device *device)
+static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
-	struct i8042_acpi_resources aux_res;
-	acpi_status status;
-
-	memset(&aux_res, 0, sizeof(aux_res));
-	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
-				     i8042_acpi_parse_resource, &aux_res);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	if (aux_res.irq)
-		i8042_aux_irq = aux_res.irq;
+	if (pnp_irq_valid(dev,0))
+		i8042_aux_irq = pnp_irq(dev,0);
 	else
-		printk(KERN_WARNING "ACPI: [%s] has no IRQ; default is %d\n",
-			acpi_device_bid(device), i8042_aux_irq);
+		printk(KERN_WARNING "PNP: [%s] has no IRQ; default is %d\n",
+			pnp_dev_name(dev), i8042_aux_irq);
 
-	strncpy(acpi_device_name(device), "PS/2 Mouse Controller",
-		sizeof(acpi_device_name(device)));
-	printk("ACPI: %s [%s] at irq %d\n",
-		acpi_device_name(device), acpi_device_bid(device), i8042_aux_irq);
+	printk("PNP: %s [%s] at irq %d\n",
+		"PS/2 Mouse Controller", pnp_dev_name(dev), i8042_aux_irq);
 
 	return 0;
 }
 
-static struct acpi_driver i8042_acpi_kbd_driver = {
-	.name		= "i8042",
-	.ids		= "PNP0303,PNP030B",
-	.ops		= {
-		.add		= i8042_acpi_kbd_add,
-	},
+static struct pnp_device_id pnp_kbd_devids[] = {
+	{ .id = "PNP0303", .driver_data = 0 },
+	{ .id = "PNP030b", .driver_data = 0 },
+	{ .id = "", },
+};
+
+static struct pnp_driver i8042_pnp_kbd_driver = {
+	.name           = "i8042 kdb",
+	.id_table       = pnp_kbd_devids,
+	.probe          = i8042_pnp_kbd_probe,
+};
+
+static struct pnp_device_id pnp_aux_devids[] = {
+	{ .id = "PNP0f13", .driver_data = 0 },
+	{ .id = "SYN0801", .driver_data = 0 },
+	{ .id = "", },
 };
 
-static struct acpi_driver i8042_acpi_aux_driver = {
-	.name		= "i8042",
-	.ids		= "PNP0F13,SYN0801",
-	.ops		= {
-		.add		= i8042_acpi_aux_add,
-	},
+static struct pnp_driver i8042_pnp_aux_driver = {
+	.name           = "i8042 aux",
+	.id_table       = pnp_aux_devids,
+	.probe          = i8042_pnp_aux_probe,
 };
 
-static int i8042_acpi_init(void)
+static int i8042_pnp_init(void)
 {
 	int result;
 
-	if (acpi_disabled || i8042_noacpi) {
-		printk("i8042: ACPI detection disabled\n");
+	if (i8042_nopnp) {
+		printk("i8042: PNP detection disabled\n");
 		return 0;
 	}
 
-	result = acpi_bus_register_driver(&i8042_acpi_kbd_driver);
+	result = pnp_register_driver(&i8042_pnp_kbd_driver);
 	if (result < 0)
 		return result;
 
 	if (result == 0) {
-		acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
 		return -ENODEV;
 	}
-	i8042_acpi_kbd_registered = 1;
+	i8042_pnp_kbd_registered = 1;
 
-	result = acpi_bus_register_driver(&i8042_acpi_aux_driver);
+	result = pnp_register_driver(&i8042_pnp_aux_driver);
 	if (result >= 0)
-		i8042_acpi_aux_registered = 1;
+		i8042_pnp_aux_registered = 1;
 	if (result == 0)
 		i8042_noaux = 1;
 
 	return 0;
 }
 
-static void i8042_acpi_exit(void)
+static void i8042_pnp_exit(void)
 {
-	if (i8042_acpi_kbd_registered)
-		acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
+	if (i8042_pnp_kbd_registered)
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
 
-	if (i8042_acpi_aux_registered)
-		acpi_bus_unregister_driver(&i8042_acpi_aux_driver);
+	if (i8042_pnp_aux_registered)
+		pnp_unregister_driver(&i8042_pnp_aux_driver);
 }
 #endif
 
@@ -281,8 +211,8 @@
 	i8042_kbd_irq = I8042_MAP_IRQ(1);
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
-#ifdef CONFIG_ACPI
-	if (i8042_acpi_init())
+#ifdef CONFIG_PNP
+	if (i8042_pnp_init())
 		return -1;
 #endif
 
@@ -300,8 +230,8 @@
 
 static inline void i8042_platform_exit(void)
 {
-#ifdef CONFIG_ACPI
-	i8042_acpi_exit();
+#ifdef CONFIG_PNP
+	i8042_pnp_exit();
 #endif
 }
 

--------------090900020807050304060100--
