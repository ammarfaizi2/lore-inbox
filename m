Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTIVXw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbTIVXvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:51:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:15265 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262792AbTIVXbE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:04 -0400
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <10642734262308@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734262057@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:26 -0700
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.21, 2003/09/22 13:57:44-07:00, greg@kroah.com

I2C: move i2c-elektor.c driver to drivers/i2c/busses/


 drivers/i2c/i2c-elektor.c        |  286 ---------------------------------------
 drivers/i2c/Kconfig              |   10 -
 drivers/i2c/Makefile             |    1 
 drivers/i2c/busses/Kconfig       |   10 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-elektor.c |  286 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 297 insertions(+), 297 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:12:35 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:12:35 2003
@@ -107,16 +107,6 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-pcf.
 
-config I2C_ELEKTOR
-	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF && BROKEN_ON_SMP
-	help
-	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
-	  such an adapter.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-elektor.
-
 config I2C_KEYWEST
 	tristate "Powermac Keywest I2C interface"
 	depends on I2C && PPC_PMAC
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Sep 22 16:12:35 2003
+++ b/drivers/i2c/Makefile	Mon Sep 22 16:12:35 2003
@@ -7,7 +7,6 @@
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
 obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
-obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:35 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:35 2003
@@ -46,6 +46,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd8111.
 
+config I2C_ELEKTOR
+	tristate "Elektor ISA card"
+	depends on I2C_ALGOPCF && BROKEN_ON_SMP
+	help
+	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
+	  such an adapter.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-elektor.
+
 config I2C_ELV
 	tristate "ELV adapter"
 	depends on I2C_ALGOBIT && ISA
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:35 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:35 2003
@@ -6,6 +6,7 @@
 obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
+obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-elektor.c	Mon Sep 22 16:12:35 2003
@@ -0,0 +1,286 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-elektor.c i2c-hw access for PCF8584 style isa bus adaptes             */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 1995-97 Simon G. Vogl
+                   1998-99 Hans Berglund
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+/* ------------------------------------------------------------------------- */
+
+/* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
+   Frodo Looijaard <frodol@dds.nl> */
+
+/* Partialy rewriten by Oleg I. Vdovikin for mmapped support of 
+   for Alpha Processor Inc. UP-2000(+) boards */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/wait.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-pcf.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include "../i2c-pcf8584.h"
+
+#define DEFAULT_BASE 0x330
+
+static int base;
+static int irq;
+static int clock  = 0x1c;
+static int own    = 0x55;
+static int mmapped;
+static int i2c_debug;
+
+/* vdovikin: removed static struct i2c_pcf_isa gpi; code - 
+  this module in real supports only one device, due to missing arguments
+  in some functions, called from the algo-pcf module. Sometimes it's
+  need to be rewriten - but for now just remove this for simpler reading */
+
+static wait_queue_head_t pcf_wait;
+static int pcf_pending;
+
+/* ----- global defines -----------------------------------------------	*/
+#define DEB(x)	if (i2c_debug>=1) x
+#define DEB2(x) if (i2c_debug>=2) x
+#define DEB3(x) if (i2c_debug>=3) x
+#define DEBE(x)	x	/* error messages 				*/
+
+/* ----- local functions ----------------------------------------------	*/
+
+static void pcf_isa_setbyte(void *data, int ctl, int val)
+{
+	int address = ctl ? (base + 1) : base;
+
+	/* enable irq if any specified for serial operation */
+	if (ctl && irq && (val & I2C_PCF_ESO)) {
+		val |= I2C_PCF_ENI;
+	}
+
+	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
+
+	switch (mmapped) {
+	case 0: /* regular I/O */
+		outb(val, address);
+		break;
+	case 2: /* double mapped I/O needed for UP2000 board,
+                   I don't know why this... */
+		writeb(val, address);
+		/* fall */
+	case 1: /* memory mapped I/O */
+		writeb(val, address);
+		break;
+	}
+}
+
+static int pcf_isa_getbyte(void *data, int ctl)
+{
+	int address = ctl ? (base + 1) : base;
+	int val = mmapped ? readb(address) : inb(address);
+
+	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
+
+	return (val);
+}
+
+static int pcf_isa_getown(void *data)
+{
+	return (own);
+}
+
+
+static int pcf_isa_getclock(void *data)
+{
+	return (clock);
+}
+
+static void pcf_isa_waitforpin(void) {
+
+	int timeout = 2;
+
+	if (irq > 0) {
+		cli();
+		if (pcf_pending == 0) {
+			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
+		} else
+			pcf_pending = 0;
+		sti();
+	} else {
+		udelay(100);
+	}
+}
+
+
+static irqreturn_t pcf_isa_handler(int this_irq, void *dev_id, struct pt_regs *regs) {
+	pcf_pending = 1;
+	wake_up_interruptible(&pcf_wait);
+	return IRQ_HANDLED;
+}
+
+
+static int pcf_isa_init(void)
+{
+	if (!mmapped) {
+		if (!request_region(base, 2, "i2c (isa bus adapter)")) {
+			printk(KERN_ERR
+			       "i2c-elektor.o: requested I/O region (0x%X:2) "
+			       "is in use.\n", base);
+			return -ENODEV;
+		}
+	}
+	if (irq > 0) {
+		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", 0) < 0) {
+			printk(KERN_ERR "i2c-elektor.o: Request irq%d failed\n", irq);
+			irq = 0;
+		} else
+			enable_irq(irq);
+	}
+	return 0;
+}
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+static struct i2c_algo_pcf_data pcf_isa_data = {
+	.setpcf	    = pcf_isa_setbyte,
+	.getpcf	    = pcf_isa_getbyte,
+	.getown	    = pcf_isa_getown,
+	.getclock   = pcf_isa_getclock,
+	.waitforpin = pcf_isa_waitforpin,
+	.udelay	    = 10,
+	.mdelay	    = 10,
+	.timeout    = 100,
+};
+
+static struct i2c_adapter pcf_isa_ops = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_HW_P_ELEK,
+	.algo_data	= &pcf_isa_data,
+	.name		= "PCF8584 ISA adapter",
+};
+
+static int __init i2c_pcfisa_init(void) 
+{
+#ifdef __alpha__
+	/* check to see we have memory mapped PCF8584 connected to the 
+	Cypress cy82c693 PCI-ISA bridge as on UP2000 board */
+	if (base == 0) {
+		
+		struct pci_dev *cy693_dev =
+                    pci_find_device(PCI_VENDOR_ID_CONTAQ, 
+		                    PCI_DEVICE_ID_CONTAQ_82C693, NULL);
+
+		if (cy693_dev) {
+			char config;
+			/* yeap, we've found cypress, let's check config */
+			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
+				
+				DEB3(printk(KERN_DEBUG "i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
+
+				/* UP2000 board has this register set to 0xe1,
+                                   but the most significant bit as seems can be 
+				   reset during the proper initialisation
+                                   sequence if guys from API decides to do that
+                                   (so, we can even enable Tsunami Pchip
+                                   window for the upper 1 Gb) */
+
+				/* so just check for ROMCS at 0xe0000,
+                                   ROMCS enabled for writes
+				   and external XD Bus buffer in use. */
+				if ((config & 0x7f) == 0x61) {
+					/* seems to be UP2000 like board */
+					base = 0xe0000;
+                                        /* I don't know why we need to
+                                           write twice */
+					mmapped = 2;
+                                        /* UP2000 drives ISA with
+					   8.25 MHz (PCI/4) clock
+					   (this can be read from cypress) */
+					clock = I2C_PCF_CLK | I2C_PCF_TRNS90;
+					printk(KERN_INFO "i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
+				}
+			}
+		}
+	}
+#endif
+
+	/* sanity checks for mmapped I/O */
+	if (mmapped && base < 0xc8000) {
+		printk(KERN_ERR "i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "i2c-elektor.o: i2c pcf8584-isa adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+
+	if (base == 0) {
+		base = DEFAULT_BASE;
+	}
+
+	init_waitqueue_head(&pcf_wait);
+	if (pcf_isa_init())
+		return -ENODEV;
+	if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
+		goto fail;
+	
+	printk(KERN_ERR "i2c-elektor.o: found device at %#x.\n", base);
+
+	return 0;
+
+ fail:
+	if (irq > 0) {
+		disable_irq(irq);
+		free_irq(irq, 0);
+	}
+
+	if (!mmapped)
+		release_region(base , 2);
+	return -ENODEV;
+}
+
+static void i2c_pcfisa_exit(void)
+{
+	i2c_pcf_del_bus(&pcf_isa_ops);
+
+	if (irq > 0) {
+		disable_irq(irq);
+		free_irq(irq, 0);
+	}
+
+	if (!mmapped)
+		release_region(base , 2);
+}
+
+MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(base, "i");
+MODULE_PARM(irq, "i");
+MODULE_PARM(clock, "i");
+MODULE_PARM(own, "i");
+MODULE_PARM(mmapped, "i");
+MODULE_PARM(i2c_debug, "i");
+
+module_init(i2c_pcfisa_init);
+module_exit(i2c_pcfisa_exit);
diff -Nru a/drivers/i2c/i2c-elektor.c b/drivers/i2c/i2c-elektor.c
--- a/drivers/i2c/i2c-elektor.c	Mon Sep 22 16:12:35 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,286 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-elektor.c i2c-hw access for PCF8584 style isa bus adaptes             */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 1995-97 Simon G. Vogl
-                   1998-99 Hans Berglund
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
-/* ------------------------------------------------------------------------- */
-
-/* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
-   Frodo Looijaard <frodol@dds.nl> */
-
-/* Partialy rewriten by Oleg I. Vdovikin for mmapped support of 
-   for Alpha Processor Inc. UP-2000(+) boards */
-
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/pci.h>
-#include <linux/wait.h>
-
-#include <linux/i2c.h>
-#include <linux/i2c-algo-pcf.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-
-#include "i2c-pcf8584.h"
-
-#define DEFAULT_BASE 0x330
-
-static int base;
-static int irq;
-static int clock  = 0x1c;
-static int own    = 0x55;
-static int mmapped;
-static int i2c_debug;
-
-/* vdovikin: removed static struct i2c_pcf_isa gpi; code - 
-  this module in real supports only one device, due to missing arguments
-  in some functions, called from the algo-pcf module. Sometimes it's
-  need to be rewriten - but for now just remove this for simpler reading */
-
-static wait_queue_head_t pcf_wait;
-static int pcf_pending;
-
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)	if (i2c_debug>=1) x
-#define DEB2(x) if (i2c_debug>=2) x
-#define DEB3(x) if (i2c_debug>=3) x
-#define DEBE(x)	x	/* error messages 				*/
-
-/* ----- local functions ----------------------------------------------	*/
-
-static void pcf_isa_setbyte(void *data, int ctl, int val)
-{
-	int address = ctl ? (base + 1) : base;
-
-	/* enable irq if any specified for serial operation */
-	if (ctl && irq && (val & I2C_PCF_ESO)) {
-		val |= I2C_PCF_ENI;
-	}
-
-	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
-
-	switch (mmapped) {
-	case 0: /* regular I/O */
-		outb(val, address);
-		break;
-	case 2: /* double mapped I/O needed for UP2000 board,
-                   I don't know why this... */
-		writeb(val, address);
-		/* fall */
-	case 1: /* memory mapped I/O */
-		writeb(val, address);
-		break;
-	}
-}
-
-static int pcf_isa_getbyte(void *data, int ctl)
-{
-	int address = ctl ? (base + 1) : base;
-	int val = mmapped ? readb(address) : inb(address);
-
-	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
-
-	return (val);
-}
-
-static int pcf_isa_getown(void *data)
-{
-	return (own);
-}
-
-
-static int pcf_isa_getclock(void *data)
-{
-	return (clock);
-}
-
-static void pcf_isa_waitforpin(void) {
-
-	int timeout = 2;
-
-	if (irq > 0) {
-		cli();
-		if (pcf_pending == 0) {
-			interruptible_sleep_on_timeout(&pcf_wait, timeout*HZ );
-		} else
-			pcf_pending = 0;
-		sti();
-	} else {
-		udelay(100);
-	}
-}
-
-
-static irqreturn_t pcf_isa_handler(int this_irq, void *dev_id, struct pt_regs *regs) {
-	pcf_pending = 1;
-	wake_up_interruptible(&pcf_wait);
-	return IRQ_HANDLED;
-}
-
-
-static int pcf_isa_init(void)
-{
-	if (!mmapped) {
-		if (!request_region(base, 2, "i2c (isa bus adapter)")) {
-			printk(KERN_ERR
-			       "i2c-elektor.o: requested I/O region (0x%X:2) "
-			       "is in use.\n", base);
-			return -ENODEV;
-		}
-	}
-	if (irq > 0) {
-		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", 0) < 0) {
-			printk(KERN_ERR "i2c-elektor.o: Request irq%d failed\n", irq);
-			irq = 0;
-		} else
-			enable_irq(irq);
-	}
-	return 0;
-}
-
-/* ------------------------------------------------------------------------
- * Encapsulate the above functions in the correct operations structure.
- * This is only done when more than one hardware adapter is supported.
- */
-static struct i2c_algo_pcf_data pcf_isa_data = {
-	.setpcf	    = pcf_isa_setbyte,
-	.getpcf	    = pcf_isa_getbyte,
-	.getown	    = pcf_isa_getown,
-	.getclock   = pcf_isa_getclock,
-	.waitforpin = pcf_isa_waitforpin,
-	.udelay	    = 10,
-	.mdelay	    = 10,
-	.timeout    = 100,
-};
-
-static struct i2c_adapter pcf_isa_ops = {
-	.owner		= THIS_MODULE,
-	.id		= I2C_HW_P_ELEK,
-	.algo_data	= &pcf_isa_data,
-	.name		= "PCF8584 ISA adapter",
-};
-
-static int __init i2c_pcfisa_init(void) 
-{
-#ifdef __alpha__
-	/* check to see we have memory mapped PCF8584 connected to the 
-	Cypress cy82c693 PCI-ISA bridge as on UP2000 board */
-	if (base == 0) {
-		
-		struct pci_dev *cy693_dev =
-                    pci_find_device(PCI_VENDOR_ID_CONTAQ, 
-		                    PCI_DEVICE_ID_CONTAQ_82C693, NULL);
-
-		if (cy693_dev) {
-			char config;
-			/* yeap, we've found cypress, let's check config */
-			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
-				
-				DEB3(printk(KERN_DEBUG "i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
-
-				/* UP2000 board has this register set to 0xe1,
-                                   but the most significant bit as seems can be 
-				   reset during the proper initialisation
-                                   sequence if guys from API decides to do that
-                                   (so, we can even enable Tsunami Pchip
-                                   window for the upper 1 Gb) */
-
-				/* so just check for ROMCS at 0xe0000,
-                                   ROMCS enabled for writes
-				   and external XD Bus buffer in use. */
-				if ((config & 0x7f) == 0x61) {
-					/* seems to be UP2000 like board */
-					base = 0xe0000;
-                                        /* I don't know why we need to
-                                           write twice */
-					mmapped = 2;
-                                        /* UP2000 drives ISA with
-					   8.25 MHz (PCI/4) clock
-					   (this can be read from cypress) */
-					clock = I2C_PCF_CLK | I2C_PCF_TRNS90;
-					printk(KERN_INFO "i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
-				}
-			}
-		}
-	}
-#endif
-
-	/* sanity checks for mmapped I/O */
-	if (mmapped && base < 0xc8000) {
-		printk(KERN_ERR "i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
-		return -ENODEV;
-	}
-
-	printk(KERN_INFO "i2c-elektor.o: i2c pcf8584-isa adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
-
-	if (base == 0) {
-		base = DEFAULT_BASE;
-	}
-
-	init_waitqueue_head(&pcf_wait);
-	if (pcf_isa_init())
-		return -ENODEV;
-	if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
-		goto fail;
-	
-	printk(KERN_ERR "i2c-elektor.o: found device at %#x.\n", base);
-
-	return 0;
-
- fail:
-	if (irq > 0) {
-		disable_irq(irq);
-		free_irq(irq, 0);
-	}
-
-	if (!mmapped)
-		release_region(base , 2);
-	return -ENODEV;
-}
-
-static void i2c_pcfisa_exit(void)
-{
-	i2c_pcf_del_bus(&pcf_isa_ops);
-
-	if (irq > 0) {
-		disable_irq(irq);
-		free_irq(irq, 0);
-	}
-
-	if (!mmapped)
-		release_region(base , 2);
-}
-
-MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
-MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(base, "i");
-MODULE_PARM(irq, "i");
-MODULE_PARM(clock, "i");
-MODULE_PARM(own, "i");
-MODULE_PARM(mmapped, "i");
-MODULE_PARM(i2c_debug, "i");
-
-module_init(i2c_pcfisa_init);
-module_exit(i2c_pcfisa_exit);

