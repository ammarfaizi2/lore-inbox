Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264517AbVBENus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264517AbVBENus (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 08:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbVBENur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 08:50:47 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:23474 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S273613AbVBENsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 08:48:39 -0500
Message-ID: <4204CEB5.7000609@free.fr>
Date: Sat, 05 Feb 2005 14:48:37 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] PNP support for i8042 driver
References: <41960AE9.8090409@free.fr> <20041117100745.GA1387@ucw.cz> <4203B2D9.7080904@free.fr> <20050204182816.GA3573@ucw.cz>
In-Reply-To: <20050204182816.GA3573@ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------020502030602060608050408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020502030602060608050408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Vojtech Pavlik wrote:
> On Fri, Feb 04, 2005 at 06:37:29PM +0100, matthieu castet wrote:
> 
>>Hi,
>>
>>Vojtech Pavlik wrote:
>>
>>>On Sat, Nov 13, 2004 at 02:23:53PM +0100, matthieu castet wrote:
>>>
>>>
>>>>Hi,
>>>>this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
>>>>is try before the pnp driver so if you don't disable ACPI or apply 
>>>>others pnpacpi patches, it won't change anything.
>>>>
>>>>Please review it and apply if possible
>>>
>>>
>>>Ok, my thoughts on this:
>>>
>>>	It's OK to keep the device allocated to this driver via the PnP
>>>       subsystem, and not bother with releasing the code via
>>>	__initcall.
>>>
>>>	I agree that if there is a way to enumerate the device, (like
>>>	PnP, ACPI or OpenFirmware), we should use that instead of
>>>	probing and using a platform device for the controller.
>>>
>>>	I think that we should drop the ACPI support from i8042, in
>>>	favor of pnpacpi, because PnP is more generic and if the
>>>	keyboard device was listed in PnPBIOS instead of ACPI, it'll
>>>	still work.
>>>
>>
>>Any news about this ?
> 
>  
> Sort of fell off my radar, can you resend?
> 
attached 2 versions : the one that kill acpi detection and the one with
acpi but a complex init.


Matthieu

PS : I resend it, because, it seem it have failed for Vojtech Pavlik.

--------------020502030602060608050408
Content-Type: text/x-patch;
 name="i8042_pnp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8042_pnp.patch"

Index: drivers/input/serio/i8042-x86ia64io.h
===================================================================
RCS file: /home/mat/dev/linux-cvs-rep/linux-cvs/drivers/input/serio/i8042-x86ia64io.h,v
retrieving revision 1.2
diff -u -u -r1.2 i8042-x86ia64io.h
--- drivers/input/serio/i8042-x86ia64io.h	4 Jan 2005 08:06:19 -0000	1.2
+++ drivers/input/serio/i8042-x86ia64io.h	4 Feb 2005 22:37:12 -0000
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
 
Index: drivers/input/serio/i8042.c
===================================================================
RCS file: /home/mat/dev/linux-cvs-rep/linux-cvs/drivers/input/serio/i8042.c,v
retrieving revision 1.45
diff -u -u -r1.45 i8042.c
--- drivers/input/serio/i8042.c	3 Feb 2005 00:21:36 -0000	1.45
+++ drivers/input/serio/i8042.c	4 Feb 2005 22:37:12 -0000
@@ -54,10 +54,10 @@
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


--------------020502030602060608050408
Content-Type: text/x-patch;
 name="i8042_pnp_acpi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8042_pnp_acpi.patch"

Index: drivers/input/serio/i8042-x86ia64io.h
===================================================================
RCS file: /home/mat/dev/linux-cvs-rep/linux-cvs/drivers/input/serio/i8042-x86ia64io.h,v
retrieving revision 1.2
diff -u -u -r1.2 i8042-x86ia64io.h
--- drivers/input/serio/i8042-x86ia64io.h	4 Jan 2005 08:06:19 -0000	1.2
+++ drivers/input/serio/i8042-x86ia64io.h	4 Feb 2005 22:50:02 -0000
@@ -88,6 +88,116 @@
 };
 #endif
 
+#ifdef CONFIG_PNP
+#include <linux/pnp.h>
+
+static int i8042_pnp_kbd_registered;
+static int i8042_pnp_aux_registered;
+
+
+static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_data_reg = pnp_port_start(dev, 0);
+	else
+		printk(KERN_WARNING "PNP: [%s] has no data port; default is 0x%x\n",
+			pnp_dev_name(dev), i8042_data_reg);
+
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_command_reg = pnp_port_start(dev, 1);
+	else
+		printk(KERN_WARNING "PNP: [%s] has no command port; default is 0x%x\n",
+			pnp_dev_name(dev), i8042_command_reg);
+
+	if (pnp_irq_valid(dev, 0))
+		i8042_kbd_irq = pnp_irq(dev, 0);
+	else
+		printk(KERN_WARNING "PNP: [%s] has no IRQ; default is %d\n",
+			pnp_dev_name(dev), i8042_kbd_irq);
+
+	printk("PNP: %s [%s] at I/O 0x%x, 0x%x, irq %d\n",
+		"PS/2 Keyboard Controller", pnp_dev_name(dev),
+		i8042_data_reg, i8042_command_reg, i8042_kbd_irq);
+
+	return 0;
+}
+
+static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	if (pnp_irq_valid(dev, 0))
+		i8042_aux_irq = pnp_irq(dev, 0);
+	else
+		printk(KERN_WARNING "PNP: [%s] has no IRQ; default is %d\n",
+			pnp_dev_name(dev), i8042_aux_irq);
+
+	printk("PNP: %s [%s] at irq %d\n",
+		"PS/2 Mouse Controller", pnp_dev_name(dev), i8042_aux_irq);
+
+	return 0;
+}
+
+static struct pnp_device_id pnp_kbd_devids[] = {
+	{ .id = "PNP0303", .driver_data = 0 },
+	{ .id = "PNP030b", .driver_data = 0 },
+	{ .id = "", },
+};
+
+static struct pnp_driver i8042_pnp_kbd_driver = {
+	.name           = "i8042 kbd",
+	.id_table       = pnp_kbd_devids,
+	.probe          = i8042_pnp_kbd_probe,
+};
+
+static struct pnp_device_id pnp_aux_devids[] = {
+	{ .id = "PNP0f13", .driver_data = 0 },
+	{ .id = "SYN0801", .driver_data = 0 },
+	{ .id = "", },
+};
+
+static struct pnp_driver i8042_pnp_aux_driver = {
+	.name           = "i8042 aux",
+	.id_table       = pnp_aux_devids,
+	.probe          = i8042_pnp_aux_probe,
+};
+
+static int i8042_pnp_init(void)
+{
+	int result;
+
+	if (i8042_nopnp) {
+		printk("i8042: PNP detection disabled\n");
+		return 0;
+	}
+
+	result = pnp_register_driver(&i8042_pnp_kbd_driver);
+	if (result < 0)
+		return result;
+
+	if (result == 0) {
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
+		return -ENODEV;
+	}
+	i8042_pnp_kbd_registered = 1;
+
+	result = pnp_register_driver(&i8042_pnp_aux_driver);
+	if (result >= 0)
+		i8042_pnp_aux_registered = 1;
+	if (result == 0)
+		i8042_noaux = 1;
+
+	return 0;
+}
+
+static void i8042_pnp_exit(void)
+{
+	if (i8042_pnp_kbd_registered)
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
+
+	if (i8042_pnp_aux_registered)
+		pnp_unregister_driver(&i8042_pnp_aux_driver);
+}
+#endif
+
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
@@ -282,8 +392,13 @@
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
 #ifdef CONFIG_ACPI
-	if (i8042_acpi_init())
-		return -1;
+	if (i8042_acpi_init() < 0) /*ACPI don't detecte Kdb*/
+#endif
+#ifdef CONFIG_PNP
+		if (i8042_pnp_init())
+#endif
+#if defined(CONFIG_ACPI) || defined(CONFIG_PNP)
+			return -1;
 #endif
 
 #if defined(__ia64__)
@@ -303,6 +418,9 @@
 #ifdef CONFIG_ACPI
 	i8042_acpi_exit();
 #endif
+#ifdef CONFIG_PNP
+	i8042_pnp_exit();
+#endif
 }
 
 #endif /* _I8042_X86IA64IO_H */
Index: drivers/input/serio/i8042.c
===================================================================
RCS file: /home/mat/dev/linux-cvs-rep/linux-cvs/drivers/input/serio/i8042.c,v
retrieving revision 1.45
diff -u -u -r1.45 i8042.c
--- drivers/input/serio/i8042.c	3 Feb 2005 00:21:36 -0000	1.45
+++ drivers/input/serio/i8042.c	4 Feb 2005 22:45:07 -0000
@@ -60,6 +60,12 @@
 MODULE_PARM_DESC(noacpi, "Do not use ACPI to detect controller settings");
 #endif
 
+#ifdef CONFIG_PNP
+static int i8042_nopnp;
+module_param_named(nopnp, i8042_nopnp, bool, 0);
+MODULE_PARM_DESC(nopnp, "Do not use PNP to detect controller settings");
+#endif
+
 #define DEBUG
 #ifdef DEBUG
 static int i8042_debug;


--------------020502030602060608050408--
