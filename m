Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUKNGsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUKNGsd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 01:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUKNGsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 01:48:33 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:7779 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261252AbUKNGsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 01:48:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP support for i8042 driver
Date: Sun, 14 Nov 2004 01:48:00 -0500
User-Agent: KMail/1.6.2
Cc: matthieu castet <castet.matthieu@free.fr>, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, vojtech@suse.cz
References: <41960AE9.8090409@free.fr>
In-Reply-To: <41960AE9.8090409@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411140148.02811.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 November 2004 08:23 am, matthieu castet wrote:
> Hi,
> this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
> is try before the pnp driver so if you don't disable ACPI or apply 
> others pnpacpi patches, it won't change anything.
> 
> Please review it and apply if possible
> 
> thanks,
> 
> Matthieu CASTET
> 
> Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>
> 

Hi,

Do we really need to keep those drivers loaded - i8042 will not
be hotplugged and ports are reserved anyway. We are only interested
in presence of the keyboard and mouse ports. Can we unregister
the drivers (both ACPI and PNP) right after registering and mark
all that stuff as __init/__initdata as in the patch below?
I also adjusted init logic so ACPI/PNP can be enabled/disabled
independently of each other.

-- 
Dmitry

===== drivers/input/serio/i8042.c 1.72 vs edited =====
--- 1.72/drivers/input/serio/i8042.c	2004-11-12 00:25:04 -05:00
+++ edited/drivers/input/serio/i8042.c	2004-11-13 21:43:54 -05:00
@@ -65,6 +65,12 @@ module_param_named(noacpi, i8042_noacpi,
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
===== drivers/input/serio/i8042-x86ia64io.h 1.2 vs edited =====
--- 1.2/drivers/input/serio/i8042-x86ia64io.h	2004-10-19 05:58:22 -05:00
+++ edited/drivers/input/serio/i8042-x86ia64io.h	2004-11-13 23:44:32 -05:00
@@ -88,6 +88,103 @@ static struct dmi_system_id __initdata i
 };
 #endif
 
+#ifdef CONFIG_PNP
+#include <linux/pnp.h>
+
+static int __init i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
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
+static int __init i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
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
+static struct pnp_device_id __initdata pnp_kbd_devids[] = {
+	{ .id = "PNP0303", .driver_data = 0 },
+	{ .id = "PNP030b", .driver_data = 0 },
+	{ .id = "", },
+};
+
+static struct pnp_driver __initdata i8042_pnp_kbd_driver = {
+	.name           = "i8042 kbd",
+	.id_table       = pnp_kbd_devids,
+	.probe          = i8042_pnp_kbd_probe,
+};
+
+static struct pnp_device_id __initdata pnp_aux_devids[] = {
+	{ .id = "PNP0f13", .driver_data = 0 },
+	{ .id = "SYN0801", .driver_data = 0 },
+	{ .id = "", },
+};
+
+static struct pnp_driver __initdata i8042_pnp_aux_driver = {
+	.name           = "i8042 aux",
+	.id_table       = pnp_aux_devids,
+	.probe          = i8042_pnp_aux_probe,
+};
+
+static int __init i8042_pnp_init(void)
+{
+	int result;
+
+	result = pnp_register_driver(&i8042_pnp_kbd_driver);
+	if (result < 0)
+		return result;
+	/*
+	 * Unregister the driver right away as we need it only to
+	 * make sure that the keyboard port is present. We do not
+	 * expect i8042 to be hotplugged nor some other device
+	 * claiming its resources.
+	 */
+	pnp_unregister_driver(&i8042_pnp_kbd_driver);
+
+	if (result == 0)
+		return -ENODEV;
+
+	result = pnp_register_driver(&i8042_pnp_aux_driver);
+	if (result >= 0)
+		pnp_unregister_driver(&i8042_pnp_aux_driver);
+
+	if (result <= 0)
+		i8042_noaux = 1;
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
@@ -98,10 +195,7 @@ struct i8042_acpi_resources {
 	unsigned int irq;
 };
 
-static int i8042_acpi_kbd_registered;
-static int i8042_acpi_aux_registered;
-
-static acpi_status i8042_acpi_parse_resource(struct acpi_resource *res, void *data)
+static acpi_status __init i8042_acpi_parse_resource(struct acpi_resource *res, void *data)
 {
 	struct i8042_acpi_resources *i8042_res = data;
 	struct acpi_resource_io *io;
@@ -151,7 +245,7 @@ static acpi_status i8042_acpi_parse_reso
 	return AE_OK;
 }
 
-static int i8042_acpi_kbd_add(struct acpi_device *device)
+static int __init i8042_acpi_kbd_add(struct acpi_device *device)
 {
 	struct i8042_acpi_resources kbd_res;
 	acpi_status status;
@@ -189,7 +283,7 @@ static int i8042_acpi_kbd_add(struct acp
 	return 0;
 }
 
-static int i8042_acpi_aux_add(struct acpi_device *device)
+static int __init i8042_acpi_aux_add(struct acpi_device *device)
 {
 	struct i8042_acpi_resources aux_res;
 	acpi_status status;
@@ -214,7 +308,7 @@ static int i8042_acpi_aux_add(struct acp
 	return 0;
 }
 
-static struct acpi_driver i8042_acpi_kbd_driver = {
+static struct acpi_driver __initdata i8042_acpi_kbd_driver = {
 	.name		= "i8042",
 	.ids		= "PNP0303,PNP030B",
 	.ops		= {
@@ -222,7 +316,7 @@ static struct acpi_driver i8042_acpi_kbd
 	},
 };
 
-static struct acpi_driver i8042_acpi_aux_driver = {
+static struct acpi_driver __initdata i8042_acpi_aux_driver = {
 	.name		= "i8042",
 	.ids		= "PNP0F13,SYN0801",
 	.ops		= {
@@ -230,7 +324,7 @@ static struct acpi_driver i8042_acpi_aux
 	},
 };
 
-static int i8042_acpi_init(void)
+static int __init i8042_acpi_init(void)
 {
 	int result;
 
@@ -243,33 +337,25 @@ static int i8042_acpi_init(void)
 	if (result < 0)
 		return result;
 
-	if (result == 0) {
-		acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
+	acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
+
+	if (result == 0)
 		return -ENODEV;
-	}
-	i8042_acpi_kbd_registered = 1;
 
 	result = acpi_bus_register_driver(&i8042_acpi_aux_driver);
 	if (result >= 0)
-		i8042_acpi_aux_registered = 1;
-	if (result == 0)
+		acpi_bus_unregister_driver(&i8042_acpi_aux_driver);
+
+	if (result <= 0)
 		i8042_noaux = 1;
 
 	return 0;
 }
-
-static void i8042_acpi_exit(void)
-{
-	if (i8042_acpi_kbd_registered)
-		acpi_bus_unregister_driver(&i8042_acpi_kbd_driver);
-
-	if (i8042_acpi_aux_registered)
-		acpi_bus_unregister_driver(&i8042_acpi_aux_driver);
-}
 #endif
 
-static inline int i8042_platform_init(void)
+static int __init i8042_platform_init(void)
 {
+	int probe_failed = 0;
 /*
  * On ix86 platforms touching the i8042 data register region can do really
  * bad things. Because of this the region is always reserved on ix86 boxes.
@@ -278,14 +364,6 @@ static inline int i8042_platform_init(vo
  *		return -1;
  */
 
-	i8042_kbd_irq = I8042_MAP_IRQ(1);
-	i8042_aux_irq = I8042_MAP_IRQ(12);
-
-#ifdef CONFIG_ACPI
-	if (i8042_acpi_init())
-		return -1;
-#endif
-
 #if defined(__ia64__)
         i8042_reset = 1;
 #endif
@@ -295,14 +373,31 @@ static inline int i8042_platform_init(vo
 		i8042_noloop = 1;
 #endif
 
-	return 0;
+	i8042_kbd_irq = I8042_MAP_IRQ(1);
+	i8042_aux_irq = I8042_MAP_IRQ(12);
+
+#ifdef CONFIG_ACPI
+	if (acpi_disabled || i8042_noacpi)
+		printk("i8042: ACPI detection disabled\n");
+	else if (i8042_acpi_init() < 0)
+		probe_failed = 1;
+	else
+		return 0;
+#endif
+#ifdef CONFIG_PNP
+	if (i8042_nopnp)
+		printk("i8042: PNP detection disabled\n");
+	else if (i8042_pnp_init() < 0)
+		probe_failed = 1;
+	else
+		return 0;
+#endif
+
+	return probe_failed ? -1 : 0;
 }
 
 static inline void i8042_platform_exit(void)
 {
-#ifdef CONFIG_ACPI
-	i8042_acpi_exit();
-#endif
 }
 
 #endif /* _I8042_X86IA64IO_H */
