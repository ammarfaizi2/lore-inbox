Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267673AbSLTAvo>; Thu, 19 Dec 2002 19:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbSLTAvn>; Thu, 19 Dec 2002 19:51:43 -0500
Received: from mailproxy1.netcologne.de ([194.8.194.222]:15754 "EHLO
	mailproxy1.netcologne.de") by vger.kernel.org with ESMTP
	id <S267673AbSLTAve>; Thu, 19 Dec 2002 19:51:34 -0500
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@netcologne.de>
Reply-To: joergprante@netcologne.de
To: marcelo@conectiva.com.br
Subject: [PATCH] [2.4.21-pre2] scx200 build fix
Date: Fri, 20 Dec 2002 01:58:24 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_C18EDJ7KMF7TVYWEJEIS"
Message-Id: <200212200158.24528.joergprante@netcologne.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C18EDJ7KMF7TVYWEJEIS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

this patch solves the problem reported by Eyal Lebedinsky.
It moves scx200.c from arch/i386/kernel to drivers/char directory and adj=
usts=20
the Makefile accordingly. Marcelo, can you please apply?

Best regards,=20

J=F6rg


--------------Boundary-00=_C18EDJ7KMF7TVYWEJEIS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="001_scx200-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="001_scx200-fix"

--- linux/drivers/char/Makefile	2002-12-10 20:22:56.000000000 +0000
+++ linux/drivers/char/Makefile	2002-12-10 20:22:01.000000000 +0000
@@ -254,7 +254,7 @@
 obj-$(CONFIG_DZ) += dz.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
-obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o
+obj-$(CONFIG_SCx200_GPIO) += scx200_gpio.o scx200.o
 
 # Only one watchdog can succeed. We probe the hardware watchdog
 # drivers first, then the softdog driver.  This means if your hardware
--- linux/drivers/char/scx200.c	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/char/scx200.c	2002-12-10 20:22:10.000000000 +0000
@@ -0,0 +1,128 @@
+/* linux/drivers/char/scx200.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 support. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <linux/scx200.h>
+#include <linux/scx200.h>
+
+#define NAME "scx200"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 Driver");
+MODULE_LICENSE("GPL");
+
+unsigned scx200_gpio_base = 0;
+long scx200_gpio_shadow[2];
+
+spinlock_t scx200_gpio_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t scx200_gpio_config_lock = SPIN_LOCK_UNLOCKED;
+
+u32 scx200_gpio_configure(int index, u32 mask, u32 bits)
+{
+	u32 config, new_config;
+	unsigned long flags;
+
+	spin_lock_irqsave(&scx200_gpio_config_lock, flags);
+
+	outl(index, scx200_gpio_base + 0x20);
+	config = inl(scx200_gpio_base + 0x24);
+
+	new_config = (config & mask) | bits;
+	outl(new_config, scx200_gpio_base + 0x24);
+
+	spin_unlock_irqrestore(&scx200_gpio_config_lock, flags);
+
+	return config;
+}
+
+void scx200_gpio_dump(unsigned index)
+{
+	u32 config = scx200_gpio_configure(index, ~0, 0);
+	printk(KERN_DEBUG "GPIO%02u: 0x%08lx", index, (unsigned long)config);
+	
+	if (config & 1) 
+		printk(" OE"); /* output enabled */
+	else
+		printk(" TS"); /* tristate */
+	if (config & 2) 
+		printk(" PP"); /* push pull */
+	else
+		printk(" OD"); /* open drain */
+	if (config & 4) 
+		printk(" PUE"); /* pull up enabled */
+	else
+		printk(" PUD"); /* pull up disabled */
+	if (config & 8) 
+		printk(" LOCKED"); /* locked */
+	if (config & 16) 
+		printk(" LEVEL"); /* level input */
+	else
+		printk(" EDGE"); /* edge input */
+	if (config & 32) 
+		printk(" HI"); /* trigger on rising edge */
+	else
+		printk(" LO"); /* trigger on falling edge */
+	if (config & 64) 
+		printk(" DEBOUNCE"); /* debounce */
+	printk("\n");
+}
+
+int __init scx200_init(void)
+{
+	struct pci_dev *bridge;
+	int bank;
+	unsigned base;
+
+	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
+
+	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS, 
+				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+				      NULL)) == NULL)
+		return -ENODEV;
+
+	base = pci_resource_start(bridge, 0);
+	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
+
+	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == 0) {
+		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
+		return -EBUSY;
+	}
+
+	scx200_gpio_base = base;
+
+	/* read the current values driven on the GPIO signals */
+	for (bank = 0; bank < 2; ++bank)
+		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
+
+	return 0;
+}
+
+void __exit scx200_cleanup(void)
+{
+	release_region(scx200_gpio_base, SCx200_GPIO_SIZE);
+}
+
+module_init(scx200_init);
+module_exit(scx200_cleanup);
+
+EXPORT_SYMBOL(scx200_gpio_base);
+EXPORT_SYMBOL(scx200_gpio_shadow);
+EXPORT_SYMBOL(scx200_gpio_lock);
+EXPORT_SYMBOL(scx200_gpio_configure);
+EXPORT_SYMBOL(scx200_gpio_dump);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel modules"
+        c-basic-offset: 8
+    End:
+*/
--- linux/arch/i386/kernel/scx200.c	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/i386/kernel/scx200.c	2002-12-10 20:22:10.000000000 +0000
@@ -1,128 +0,0 @@
-/* linux/arch/i386/kernel/scx200.c 
-
-   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
-
-   National Semiconductor SCx200 support. */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-
-#include <linux/scx200.h>
-#include <linux/scx200.h>
-
-#define NAME "scx200"
-
-MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
-MODULE_DESCRIPTION("NatSemi SCx200 Driver");
-MODULE_LICENSE("GPL");
-
-unsigned scx200_gpio_base = 0;
-long scx200_gpio_shadow[2];
-
-spinlock_t scx200_gpio_lock = SPIN_LOCK_UNLOCKED;
-static spinlock_t scx200_gpio_config_lock = SPIN_LOCK_UNLOCKED;
-
-u32 scx200_gpio_configure(int index, u32 mask, u32 bits)
-{
-	u32 config, new_config;
-	unsigned long flags;
-
-	spin_lock_irqsave(&scx200_gpio_config_lock, flags);
-
-	outl(index, scx200_gpio_base + 0x20);
-	config = inl(scx200_gpio_base + 0x24);
-
-	new_config = (config & mask) | bits;
-	outl(new_config, scx200_gpio_base + 0x24);
-
-	spin_unlock_irqrestore(&scx200_gpio_config_lock, flags);
-
-	return config;
-}
-
-void scx200_gpio_dump(unsigned index)
-{
-	u32 config = scx200_gpio_configure(index, ~0, 0);
-	printk(KERN_DEBUG "GPIO%02u: 0x%08lx", index, (unsigned long)config);
-	
-	if (config & 1) 
-		printk(" OE"); /* output enabled */
-	else
-		printk(" TS"); /* tristate */
-	if (config & 2) 
-		printk(" PP"); /* push pull */
-	else
-		printk(" OD"); /* open drain */
-	if (config & 4) 
-		printk(" PUE"); /* pull up enabled */
-	else
-		printk(" PUD"); /* pull up disabled */
-	if (config & 8) 
-		printk(" LOCKED"); /* locked */
-	if (config & 16) 
-		printk(" LEVEL"); /* level input */
-	else
-		printk(" EDGE"); /* edge input */
-	if (config & 32) 
-		printk(" HI"); /* trigger on rising edge */
-	else
-		printk(" LO"); /* trigger on falling edge */
-	if (config & 64) 
-		printk(" DEBOUNCE"); /* debounce */
-	printk("\n");
-}
-
-int __init scx200_init(void)
-{
-	struct pci_dev *bridge;
-	int bank;
-	unsigned base;
-
-	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
-
-	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS, 
-				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
-				      NULL)) == NULL)
-		return -ENODEV;
-
-	base = pci_resource_start(bridge, 0);
-	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
-
-	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == 0) {
-		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
-		return -EBUSY;
-	}
-
-	scx200_gpio_base = base;
-
-	/* read the current values driven on the GPIO signals */
-	for (bank = 0; bank < 2; ++bank)
-		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
-
-	return 0;
-}
-
-void __exit scx200_cleanup(void)
-{
-	release_region(scx200_gpio_base, SCx200_GPIO_SIZE);
-}
-
-module_init(scx200_init);
-module_exit(scx200_cleanup);
-
-EXPORT_SYMBOL(scx200_gpio_base);
-EXPORT_SYMBOL(scx200_gpio_shadow);
-EXPORT_SYMBOL(scx200_gpio_lock);
-EXPORT_SYMBOL(scx200_gpio_configure);
-EXPORT_SYMBOL(scx200_gpio_dump);
-
-/*
-    Local variables:
-        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel modules"
-        c-basic-offset: 8
-    End:
-*/

--------------Boundary-00=_C18EDJ7KMF7TVYWEJEIS--

