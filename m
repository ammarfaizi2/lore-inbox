Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbTIWAET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTIWADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:03:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:31905 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262878AbTIVXbc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:32 -0400
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <10642734243430@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734242947@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:24 -0700
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.17, 2003/09/22 13:20:35-07:00, greg@kroah.com

[PATCH] I2C: move the i2c-philips-par driver to drivers/i2c/busses


 drivers/i2c/i2c-philips-par.c        |  256 -----------------------------------
 drivers/i2c/Kconfig                  |   10 -
 drivers/i2c/Makefile                 |    1 
 drivers/i2c/busses/Kconfig           |    9 +
 drivers/i2c/busses/Makefile          |    1 
 drivers/i2c/busses/i2c-philips-par.c |  256 +++++++++++++++++++++++++++++++++++
 6 files changed, 266 insertions(+), 267 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:13:17 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:13:17 2003
@@ -48,16 +48,6 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-bit.
 
-config I2C_PHILIPSPAR
-	tristate "Philips style parallel port adapter"
-	depends on I2C_ALGOBIT && PARPORT
-	---help---
-	  This supports parallel-port I2C adapters made by Philips.  Say Y if
-	  you own such an adapter.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-philips-par.
-
 config I2C_ELV
 	tristate "ELV adapter"
 	depends on I2C_ALGOBIT && ISA
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Sep 22 16:13:17 2003
+++ b/drivers/i2c/Makefile	Mon Sep 22 16:13:17 2003
@@ -5,7 +5,6 @@
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
-obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
 obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:13:17 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:13:17 2003
@@ -97,6 +97,15 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-nforce2.
 
+config I2C_PHILIPSPAR
+	tristate "Philips style parallel port adapter"
+	depends on I2C_ALGOBIT && PARPORT
+	help
+	  This supports parallel-port I2C adapters made by Philips.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-philips-par.
+
 config I2C_PIIX4
 	tristate "Intel PIIX4"
 	depends on I2C && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:13:17 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:13:17 2003
@@ -10,6 +10,7 @@
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
+obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
diff -Nru a/drivers/i2c/busses/i2c-philips-par.c b/drivers/i2c/busses/i2c-philips-par.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-philips-par.c	Mon Sep 22 16:13:17 2003
@@ -0,0 +1,256 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-philips-par.c i2c-hw access for philips style parallel port adapters  */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 1995-2000 Simon G. Vogl
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
+/* $Id: i2c-philips-par.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/stddef.h>
+#include <linux/parport.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+static int type;
+
+struct i2c_par
+{
+	struct pardevice *pdev;
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data bit_lp_data;
+	struct i2c_par *next;
+};
+
+static struct i2c_par *adapter_list;
+
+
+/* ----- global defines -----------------------------------------------	*/
+#define DEB(x)		/* should be reasonable open, close &c. 	*/
+#define DEB2(x) 	/* low level debugging - very slow 		*/
+#define DEBE(x)	x	/* error messages 				*/
+
+/* ----- printer port defines ------------------------------------------*/
+					/* Pin Port  Inverted	name	*/
+#define I2C_ON		0x20		/* 12 status N	paper		*/
+					/* ... only for phil. not used  */
+#define I2C_SDA		0x80		/*  9 data   N	data7		*/
+#define I2C_SCL		0x08		/* 17 ctrl   N	dsel		*/
+
+#define I2C_SDAIN	0x80		/* 11 stat   Y	busy		*/
+#define I2C_SCLIN	0x08		/* 15 stat   Y	enable		*/
+
+#define I2C_DMASK	0x7f
+#define I2C_CMASK	0xf7
+
+/* ----- local functions ----------------------------------------------	*/
+
+static void bit_lp_setscl(void *data, int state)
+{
+	/*be cautious about state of the control register - 
+		touch only the one bit needed*/
+	if (state) {
+		parport_write_control((struct parport *) data,
+		      parport_read_control((struct parport *) data)|I2C_SCL);
+	} else {
+		parport_write_control((struct parport *) data,
+		      parport_read_control((struct parport *) data)&I2C_CMASK);
+	}
+}
+
+static void bit_lp_setsda(void *data, int state)
+{
+	if (state) {
+		parport_write_data((struct parport *) data, I2C_DMASK);
+	} else {
+		parport_write_data((struct parport *) data, I2C_SDA);
+	}
+}
+
+static int bit_lp_getscl(void *data)
+{
+	return parport_read_status((struct parport *) data) & I2C_SCLIN;
+}
+
+static int bit_lp_getsda(void *data)
+{
+	return parport_read_status((struct parport *) data) & I2C_SDAIN;
+}
+
+static void bit_lp_setscl2(void *data, int state)
+{
+	if (state) {
+		parport_write_data((struct parport *) data,
+		      parport_read_data((struct parport *) data)|0x1);
+	} else {
+		parport_write_data((struct parport *) data,
+		      parport_read_data((struct parport *) data)&0xfe);
+	}
+}
+
+static void bit_lp_setsda2(void *data, int state)
+{
+	if (state) {
+		parport_write_data((struct parport *) data,
+		      parport_read_data((struct parport *) data)|0x2);
+	} else {
+		parport_write_data((struct parport *) data,
+		      parport_read_data((struct parport *) data)&0xfd);
+	}
+}
+
+static int bit_lp_getsda2(void *data)
+{
+	return (parport_read_status((struct parport *) data) & 
+			             PARPORT_STATUS_BUSY) ? 0 : 1;
+}
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+ 
+static struct i2c_algo_bit_data bit_lp_data = {
+	.setsda		= bit_lp_setsda,
+	.setscl		= bit_lp_setscl,
+	.getsda		= bit_lp_getsda,
+	.getscl		= bit_lp_getscl,
+	.udelay		= 80,
+	.mdelay		= 80,
+	.timeout	= HZ
+}; 
+
+static struct i2c_algo_bit_data bit_lp_data2 = {
+	.setsda		= bit_lp_setsda2,
+	.setscl		= bit_lp_setscl2,
+	.getsda		= bit_lp_getsda2,
+	.udelay		= 80,
+	.mdelay		= 80,
+	.timeout	= HZ
+}; 
+
+static struct i2c_adapter bit_lp_ops = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_HW_B_LP,
+	.name		= "Philips Parallel port adapter",
+};
+
+static void i2c_parport_attach (struct parport *port)
+{
+	struct i2c_par *adapter = kmalloc(sizeof(struct i2c_par),
+					  GFP_KERNEL);
+	if (!adapter) {
+		printk(KERN_ERR "i2c-philips-par: Unable to malloc.\n");
+		return;
+	}
+
+	printk(KERN_DEBUG "i2c-philips-par.o: attaching to %s\n", port->name);
+
+	adapter->pdev = parport_register_device(port, "i2c-philips-par",
+						NULL, NULL, NULL, 
+						PARPORT_FLAG_EXCL,
+						NULL);
+	if (!adapter->pdev) {
+		printk(KERN_ERR "i2c-philips-par: Unable to register with parport.\n");
+		kfree(adapter);
+		return;
+	}
+
+	adapter->adapter = bit_lp_ops;
+	adapter->adapter.algo_data = &adapter->bit_lp_data;
+	adapter->bit_lp_data = type ? bit_lp_data2 : bit_lp_data;
+	adapter->bit_lp_data.data = port;
+
+	if (parport_claim_or_block(adapter->pdev) < 0 ) {
+		printk(KERN_ERR "i2c-philips-par: Could not claim parallel port.\n");
+		kfree(adapter);
+		return;
+	}
+	/* reset hardware to sane state */
+	bit_lp_setsda(port, 1);
+	bit_lp_setscl(port, 1);
+	parport_release(adapter->pdev);
+
+	if (i2c_bit_add_bus(&adapter->adapter) < 0)
+	{
+		printk(KERN_ERR "i2c-philips-par: Unable to register with I2C.\n");
+		parport_unregister_device(adapter->pdev);
+		kfree(adapter);
+		return;		/* No good */
+	}
+
+	adapter->next = adapter_list;
+	adapter_list = adapter;
+}
+
+static void i2c_parport_detach (struct parport *port)
+{
+	struct i2c_par *adapter, *prev = NULL;
+
+	for (adapter = adapter_list; adapter; adapter = adapter->next)
+	{
+		if (adapter->pdev->port == port)
+		{
+			parport_unregister_device(adapter->pdev);
+			i2c_bit_del_bus(&adapter->adapter);
+			if (prev)
+				prev->next = adapter->next;
+			else
+				adapter_list = adapter->next;
+			kfree(adapter);
+			return;
+		}
+		prev = adapter;
+	}
+}
+
+
+static struct parport_driver i2c_driver = {
+	"i2c-philips-par",
+	i2c_parport_attach,
+	i2c_parport_detach,
+	NULL
+};
+
+int __init i2c_bitlp_init(void)
+{
+	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+
+	parport_register_driver(&i2c_driver);
+	
+	return 0;
+}
+
+void __exit i2c_bitlp_exit(void)
+{
+	parport_unregister_driver(&i2c_driver);
+}
+
+MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for Philips parallel port adapter");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(type, "i");
+
+module_init(i2c_bitlp_init);
+module_exit(i2c_bitlp_exit);
diff -Nru a/drivers/i2c/i2c-philips-par.c b/drivers/i2c/i2c-philips-par.c
--- a/drivers/i2c/i2c-philips-par.c	Mon Sep 22 16:13:17 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,256 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-philips-par.c i2c-hw access for philips style parallel port adapters  */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 1995-2000 Simon G. Vogl
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
-/* $Id: i2c-philips-par.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
-
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/stddef.h>
-#include <linux/parport.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-
-static int type;
-
-struct i2c_par
-{
-	struct pardevice *pdev;
-	struct i2c_adapter adapter;
-	struct i2c_algo_bit_data bit_lp_data;
-	struct i2c_par *next;
-};
-
-static struct i2c_par *adapter_list;
-
-
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)		/* should be reasonable open, close &c. 	*/
-#define DEB2(x) 	/* low level debugging - very slow 		*/
-#define DEBE(x)	x	/* error messages 				*/
-
-/* ----- printer port defines ------------------------------------------*/
-					/* Pin Port  Inverted	name	*/
-#define I2C_ON		0x20		/* 12 status N	paper		*/
-					/* ... only for phil. not used  */
-#define I2C_SDA		0x80		/*  9 data   N	data7		*/
-#define I2C_SCL		0x08		/* 17 ctrl   N	dsel		*/
-
-#define I2C_SDAIN	0x80		/* 11 stat   Y	busy		*/
-#define I2C_SCLIN	0x08		/* 15 stat   Y	enable		*/
-
-#define I2C_DMASK	0x7f
-#define I2C_CMASK	0xf7
-
-/* ----- local functions ----------------------------------------------	*/
-
-static void bit_lp_setscl(void *data, int state)
-{
-	/*be cautious about state of the control register - 
-		touch only the one bit needed*/
-	if (state) {
-		parport_write_control((struct parport *) data,
-		      parport_read_control((struct parport *) data)|I2C_SCL);
-	} else {
-		parport_write_control((struct parport *) data,
-		      parport_read_control((struct parport *) data)&I2C_CMASK);
-	}
-}
-
-static void bit_lp_setsda(void *data, int state)
-{
-	if (state) {
-		parport_write_data((struct parport *) data, I2C_DMASK);
-	} else {
-		parport_write_data((struct parport *) data, I2C_SDA);
-	}
-}
-
-static int bit_lp_getscl(void *data)
-{
-	return parport_read_status((struct parport *) data) & I2C_SCLIN;
-}
-
-static int bit_lp_getsda(void *data)
-{
-	return parport_read_status((struct parport *) data) & I2C_SDAIN;
-}
-
-static void bit_lp_setscl2(void *data, int state)
-{
-	if (state) {
-		parport_write_data((struct parport *) data,
-		      parport_read_data((struct parport *) data)|0x1);
-	} else {
-		parport_write_data((struct parport *) data,
-		      parport_read_data((struct parport *) data)&0xfe);
-	}
-}
-
-static void bit_lp_setsda2(void *data, int state)
-{
-	if (state) {
-		parport_write_data((struct parport *) data,
-		      parport_read_data((struct parport *) data)|0x2);
-	} else {
-		parport_write_data((struct parport *) data,
-		      parport_read_data((struct parport *) data)&0xfd);
-	}
-}
-
-static int bit_lp_getsda2(void *data)
-{
-	return (parport_read_status((struct parport *) data) & 
-			             PARPORT_STATUS_BUSY) ? 0 : 1;
-}
-
-/* ------------------------------------------------------------------------
- * Encapsulate the above functions in the correct operations structure.
- * This is only done when more than one hardware adapter is supported.
- */
- 
-static struct i2c_algo_bit_data bit_lp_data = {
-	.setsda		= bit_lp_setsda,
-	.setscl		= bit_lp_setscl,
-	.getsda		= bit_lp_getsda,
-	.getscl		= bit_lp_getscl,
-	.udelay		= 80,
-	.mdelay		= 80,
-	.timeout	= HZ
-}; 
-
-static struct i2c_algo_bit_data bit_lp_data2 = {
-	.setsda		= bit_lp_setsda2,
-	.setscl		= bit_lp_setscl2,
-	.getsda		= bit_lp_getsda2,
-	.udelay		= 80,
-	.mdelay		= 80,
-	.timeout	= HZ
-}; 
-
-static struct i2c_adapter bit_lp_ops = {
-	.owner		= THIS_MODULE,
-	.id		= I2C_HW_B_LP,
-	.name		= "Philips Parallel port adapter",
-};
-
-static void i2c_parport_attach (struct parport *port)
-{
-	struct i2c_par *adapter = kmalloc(sizeof(struct i2c_par),
-					  GFP_KERNEL);
-	if (!adapter) {
-		printk(KERN_ERR "i2c-philips-par: Unable to malloc.\n");
-		return;
-	}
-
-	printk(KERN_DEBUG "i2c-philips-par.o: attaching to %s\n", port->name);
-
-	adapter->pdev = parport_register_device(port, "i2c-philips-par",
-						NULL, NULL, NULL, 
-						PARPORT_FLAG_EXCL,
-						NULL);
-	if (!adapter->pdev) {
-		printk(KERN_ERR "i2c-philips-par: Unable to register with parport.\n");
-		kfree(adapter);
-		return;
-	}
-
-	adapter->adapter = bit_lp_ops;
-	adapter->adapter.algo_data = &adapter->bit_lp_data;
-	adapter->bit_lp_data = type ? bit_lp_data2 : bit_lp_data;
-	adapter->bit_lp_data.data = port;
-
-	if (parport_claim_or_block(adapter->pdev) < 0 ) {
-		printk(KERN_ERR "i2c-philips-par: Could not claim parallel port.\n");
-		kfree(adapter);
-		return;
-	}
-	/* reset hardware to sane state */
-	bit_lp_setsda(port, 1);
-	bit_lp_setscl(port, 1);
-	parport_release(adapter->pdev);
-
-	if (i2c_bit_add_bus(&adapter->adapter) < 0)
-	{
-		printk(KERN_ERR "i2c-philips-par: Unable to register with I2C.\n");
-		parport_unregister_device(adapter->pdev);
-		kfree(adapter);
-		return;		/* No good */
-	}
-
-	adapter->next = adapter_list;
-	adapter_list = adapter;
-}
-
-static void i2c_parport_detach (struct parport *port)
-{
-	struct i2c_par *adapter, *prev = NULL;
-
-	for (adapter = adapter_list; adapter; adapter = adapter->next)
-	{
-		if (adapter->pdev->port == port)
-		{
-			parport_unregister_device(adapter->pdev);
-			i2c_bit_del_bus(&adapter->adapter);
-			if (prev)
-				prev->next = adapter->next;
-			else
-				adapter_list = adapter->next;
-			kfree(adapter);
-			return;
-		}
-		prev = adapter;
-	}
-}
-
-
-static struct parport_driver i2c_driver = {
-	"i2c-philips-par",
-	i2c_parport_attach,
-	i2c_parport_detach,
-	NULL
-};
-
-int __init i2c_bitlp_init(void)
-{
-	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
-
-	parport_register_driver(&i2c_driver);
-	
-	return 0;
-}
-
-void __exit i2c_bitlp_exit(void)
-{
-	parport_unregister_driver(&i2c_driver);
-}
-
-MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
-MODULE_DESCRIPTION("I2C-Bus adapter routines for Philips parallel port adapter");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(type, "i");
-
-module_init(i2c_bitlp_init);
-module_exit(i2c_bitlp_exit);

