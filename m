Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268749AbUIBR4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268749AbUIBR4y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268277AbUIBR4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:56:21 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:61352 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S268030AbUIBRwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:52:39 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ACPI-based i8042 keyboard/aux controller enumeration
Date: Thu, 2 Sep 2004 11:52:27 -0600
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz,
       Alessandro Rubini <rubini@ipvvis.unipv.it>,
       Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021152.27472.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is based on 2.6.9-rc1-mm2, i.e., it applies after bk-acpi.patch,
bk-input.patch, and fix-smm-failures-on-e750x-systems.patch from -mm2.



Add ACPI-based i8042 keyboard and aux controller enumeration.

This can be disabled with "i8042.no_acpi=1".  If you need to disable
it, please let me know so I can fix it.

The main reason we need this is because i8042_check_aux() does a
request_irq(12) before it knows whether the AUX controller is even
present.  Some boards with a keyboard controller but no AUX controller
reuse IRQ 12 for PCI interrupts.  And apparently the BIOS on some of
those boards leaves IRQ 12 programmed as edge-triggered, active high,
even though the PCI interrupt is level-triggered, active low.  So if
i8042 comes along and requests IRQ 12 before the PCI driver enables
the device and programs the IOAPIC correctly, i8042 gets an endless
stream of interrupts.

This patch avoids that situation by only poking at ports that ACPI
tells us about.  If ACPI doesn't tell us about an AUX controller,
we don't touch IRQ 12.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -ur 2.6.9-rc1-mm2-kbd1/Documentation/kernel-parameters.txt 2.6.9-rc1-mm2-kbd2/Documentation/kernel-parameters.txt
--- 2.6.9-rc1-mm2-kbd1/Documentation/kernel-parameters.txt	2004-09-02 09:49:05.000000000 -0600
+++ 2.6.9-rc1-mm2-kbd2/Documentation/kernel-parameters.txt	2004-09-02 10:11:29.000000000 -0600
@@ -469,6 +469,7 @@
 			     controller
 	i8042.reset	[HW] Reset the controller during init and cleanup
 	i8042.unlock	[HW] Unlock (ignore) the keylock
+	i8042.no_acpi=1	[HW] Don't use ACPI to discover KBD/AUX ports
 
 	i810=		[HW,DRM]
 
diff -u -ur 2.6.9-rc1-mm2-kbd1/drivers/input/serio/i8042.c 2.6.9-rc1-mm2-kbd2/drivers/input/serio/i8042.c
--- 2.6.9-rc1-mm2-kbd1/drivers/input/serio/i8042.c	2004-09-02 09:49:50.000000000 -0600
+++ 2.6.9-rc1-mm2-kbd2/drivers/input/serio/i8042.c	2004-09-02 10:32:28.000000000 -0600
@@ -24,6 +24,15 @@
 #include <linux/pci.h>
 #include <linux/err.h>
 
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
+
+static int no_acpi;
+module_param(no_acpi, uint, 0);
+MODULE_PARM_DESC(no_acpi, "Disable ACPI keyboard/aux controller detection");
+#endif
+
 #include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
@@ -1068,6 +1077,142 @@
 	return serio;
 }
 
+#ifdef CONFIG_ACPI
+static int acpi_kbd_registered;
+static int acpi_aux_registered;
+
+struct i8042_resources {
+	unsigned int port1;
+	unsigned int port2;
+	unsigned int irq;
+};
+
+static acpi_status acpi_i8042_resource(struct acpi_resource *res, void *data)
+{
+	struct i8042_resources *i8042 = data;
+	struct acpi_resource_io *io;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_ext_irq *ext_irq;
+
+	if (res->id == ACPI_RSTYPE_IO) {
+		io = &res->data.io;
+		if (io->range_length) {
+			if (!i8042->port1)
+				i8042->port1 = io->min_base_address;
+			else
+				i8042->port2 = io->min_base_address;
+		}
+	} else if (res->id == ACPI_RSTYPE_IRQ) {
+		irq = &res->data.irq;
+		if (irq->number_of_interrupts > 0)
+			i8042->irq = acpi_register_gsi(irq->interrupts[0],
+				irq->edge_level, irq->active_high_low);
+	} else if (res->id == ACPI_RSTYPE_EXT_IRQ) {
+		ext_irq = &res->data.extended_irq;
+		if (ext_irq->number_of_interrupts > 0)
+			i8042->irq = acpi_register_gsi(ext_irq->interrupts[0],
+				ext_irq->edge_level, ext_irq->active_high_low);
+	}
+	return AE_OK;
+}
+
+static int acpi_i8042_kbd_add(struct acpi_device *device)
+{
+	struct i8042_resources i8042;
+	acpi_status status;
+
+	memset(&i8042, 0, sizeof(i8042));
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+		acpi_i8042_resource, &i8042);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	printk("i8042: ACPI %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
+		acpi_device_name(device), acpi_device_bid(device),
+		i8042.port1, i8042.port2, i8042.irq);
+
+	i8042_data_reg = i8042.port1;
+	i8042_command_reg = i8042.port2;
+	i8042_status_reg = i8042.port2;
+	i8042_kbd_values.irq = i8042.irq;
+
+	return 0;
+}
+
+static int acpi_i8042_aux_add(struct acpi_device *device)
+{
+	struct i8042_resources i8042;
+	acpi_status status;
+
+	memset(&i8042, 0, sizeof(i8042));
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+		acpi_i8042_resource, &i8042);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	printk("i8042: ACPI %s [%s] at irq %d\n",
+		acpi_device_name(device), acpi_device_bid(device), i8042.irq);
+
+	i8042_aux_values.irq = i8042.irq;
+
+	return 0;
+}
+
+static struct acpi_driver acpi_i8042_kbd_driver = {
+	.name		= "i8042",
+	.ids		= "PNP0303",
+	.ops		= {
+		.add		= acpi_i8042_kbd_add,
+	},
+};
+
+static struct acpi_driver acpi_i8042_aux_driver = {
+	.name		= "i8042",
+	.ids		= "PNP0F13",
+	.ops		= {
+		.add		= acpi_i8042_aux_add,
+	},
+};
+
+static int acpi_i8042_init(void)
+{
+	int err;
+
+	if (no_acpi) {
+		printk("i8042: ACPI detection disabled\n");
+		return -ENODEV;
+	}
+
+	err = acpi_bus_register_driver(&acpi_i8042_kbd_driver);
+	if (err >= 0)
+		acpi_kbd_registered = 1;
+	if (err == 0)
+		return 0;
+
+	err = acpi_bus_register_driver(&acpi_i8042_aux_driver);
+	if (err >= 0)
+		acpi_aux_registered = 1;
+	if (err == 0)
+		i8042_noaux = 1;
+	return 1;
+}
+
+static void acpi_i8042_exit(void)
+{
+	if (acpi_kbd_registered) {
+		acpi_bus_unregister_driver(&acpi_i8042_kbd_driver);
+		acpi_kbd_registered = 0;
+	}
+	if (acpi_aux_registered) {
+		acpi_bus_unregister_driver(&acpi_i8042_aux_driver);
+		acpi_aux_registered = 0;
+	}
+}
+#else
+static inline int  acpi_i8042_init(void) { return -ENODEV; }
+static inline void acpi_i8042_exit(void) { }
+#endif
+
 int __init i8042_init(void)
 {
 	int i;
@@ -1084,6 +1229,9 @@
 	i8042_aux_values.irq = I8042_AUX_IRQ;
 	i8042_kbd_values.irq = I8042_KBD_IRQ;
 
+	if (acpi_i8042_init() == 0)
+		return -ENODEV;
+
 	if (i8042_controller_init())
 		return -ENODEV;
 
@@ -1147,6 +1295,8 @@
 
 	del_timer_sync(&i8042_timer);
 
+	acpi_i8042_exit();
+
 	platform_device_unregister(i8042_platform_device);
 	driver_unregister(&i8042_driver);
 
