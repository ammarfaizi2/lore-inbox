Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbUKMNbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbUKMNbS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 08:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262748AbUKMNaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 08:30:10 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:54967 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262735AbUKMNXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 08:23:54 -0500
Message-ID: <41960AE9.8090409@free.fr>
Date: Sat, 13 Nov 2004 14:23:53 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Adam Belay <ambx1@neo.rr.com>, bjorn.helgaas@hp.com, vojtech@suse.cz
Subject: [PATCH] PNP support for i8042 driver
Content-Type: multipart/mixed;
 boundary="------------000602030904060300070109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000602030904060300070109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
is try before the pnp driver so if you don't disable ACPI or apply 
others pnpacpi patches, it won't change anything.

Please review it and apply if possible

thanks,

Matthieu CASTET

Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>

--------------000602030904060300070109
Content-Type: text/x-patch;
 name="i8042_pnp_acpi2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i8042_pnp_acpi2.patch"

--- linux-2.6.9/drivers/input/serio/i8042.c.old	2004-11-12 23:00:09.000000000 +0100
+++ linux-2.6.9/drivers/input/serio/i8042.c	2004-11-12 23:00:39.000000000 +0100
@@ -61,6 +61,12 @@
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
--- linux-2.6.9/drivers/input/serio/i8042-x86ia64io.h.old	2004-11-12 23:00:02.000000000 +0100
+++ linux-2.6.9/drivers/input/serio/i8042-x86ia64io.h	2004-11-13 12:42:09.000000000 +0100
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
@@ -286,10 +396,17 @@
 	i8042_aux_irq = I8042_MAP_IRQ(12);
 
 #ifdef CONFIG_ACPI
-	if (i8042_acpi_init() < 0)
+	if (i8042_acpi_init() < 0) /*ACPI don't detecte Kdb*/
+#endif
+#ifdef CONFIG_PNP
+		if (i8042_pnp_init())
+			return -1;
+#else
+#ifdef CONFIG_ACPI
 		return -1;
 #endif
-
+#endif
+	
 #if defined(__ia64__)
         i8042_reset = 1;
 #endif
@@ -304,6 +421,9 @@
 
 static inline void i8042_platform_exit(void)
 {
+#ifdef CONFIG_PNP
+	i8042_pnp_exit();
+#endif
 }
 
 #endif /* _I8042_X86IA64IO_H */

--------------000602030904060300070109--
