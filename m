Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTIVXkE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTIVXii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:38:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:3745 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262436AbTIVXah convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:37 -0400
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <10642734262038@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734251033@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:26 -0700
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.19, 2003/09/22 13:36:52-07:00, greg@kroah.com

[PATCH] I2C: move i2c-elv.c driver to drivers/i2c/busses


 drivers/i2c/i2c-elv.c        |  176 -------------------------------------------
 drivers/i2c/Kconfig          |   10 --
 drivers/i2c/Makefile         |    1 
 drivers/i2c/busses/Kconfig   |   10 ++
 drivers/i2c/busses/Makefile  |    1 
 drivers/i2c/busses/i2c-elv.c |  176 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 187 insertions(+), 187 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:12:56 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:12:56 2003
@@ -48,16 +48,6 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-bit.
 
-config I2C_ELV
-	tristate "ELV adapter"
-	depends on I2C_ALGOBIT && ISA
-	help
-	  This supports parallel-port I2C adapters called ELV.  Say Y if you
-	  own such an adapter.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-elv.
-
 config I2C_VELLEMAN
 	tristate "Velleman K9000 adapter"
 	depends on I2C_ALGOBIT && ISA
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Sep 22 16:12:56 2003
+++ b/drivers/i2c/Makefile	Mon Sep 22 16:12:56 2003
@@ -5,7 +5,6 @@
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
-obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:56 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:56 2003
@@ -46,6 +46,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd8111.
 
+config I2C_ELV
+	tristate "ELV adapter"
+	depends on I2C_ALGOBIT && ISA
+	help
+	  This supports parallel-port I2C adapters called ELV.  Say Y if you
+	  own such an adapter.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-elv.
+
 config I2C_I801
 	tristate "Intel 801"
 	depends on I2C && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:56 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:56 2003
@@ -6,6 +6,7 @@
 obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
+obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
diff -Nru a/drivers/i2c/busses/i2c-elv.c b/drivers/i2c/busses/i2c-elv.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-elv.c	Mon Sep 22 16:12:56 2003
@@ -0,0 +1,176 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-elv.c i2c-hw access for philips style parallel port adapters	     */
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
+/* $Id: i2c-elv.c,v 1.27 2003/01/21 08:08:16 kmalkki Exp $ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <asm/io.h>
+
+#define DEFAULT_BASE 0x378
+static int base=0;
+static unsigned char PortData = 0;
+
+/* ----- global defines -----------------------------------------------	*/
+#define DEB(x)		/* should be reasonable open, close &c. 	*/
+#define DEB2(x) 	/* low level debugging - very slow 		*/
+#define DEBE(x)	x	/* error messages 				*/
+#define DEBINIT(x) x	/* detection status messages			*/
+
+/* --- Convenience defines for the parallel port:			*/
+#define BASE	(unsigned int)(data)
+#define DATA	BASE			/* Centronics data port		*/
+#define STAT	(BASE+1)		/* Centronics status port	*/
+#define CTRL	(BASE+2)		/* Centronics control port	*/
+
+
+/* ----- local functions ----------------------------------------------	*/
+
+
+static void bit_elv_setscl(void *data, int state)
+{
+	if (state) {
+		PortData &= 0xfe;
+	} else {
+		PortData |=1;
+	}
+	outb(PortData, DATA);
+}
+
+static void bit_elv_setsda(void *data, int state)
+{
+	if (state) {
+		PortData &=0xfd;
+	} else {
+		PortData |=2;
+	}
+	outb(PortData, DATA);
+} 
+
+static int bit_elv_getscl(void *data)
+{
+	return ( 0 == ( (inb_p(STAT)) & 0x08 ) );
+}
+
+static int bit_elv_getsda(void *data)
+{
+	return ( 0 == ( (inb_p(STAT)) & 0x40 ) );
+}
+
+static int bit_elv_init(void)
+{
+	if (!request_region(base, (base == 0x3bc) ? 3 : 8,
+				"i2c (ELV adapter)"))
+		return -ENODEV;
+
+	if (inb(base+1) & 0x80) {	/* BUSY should be high	*/
+		DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Busy was low.\n"));
+		goto fail;
+	} 
+
+	outb(0x0c,base+2);	/* SLCT auf low		*/
+	udelay(400);
+	if (!(inb(base+1) && 0x10)) {
+		outb(0x04,base+2);
+		DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Select was high.\n"));
+		goto fail;
+	}
+
+	PortData = 0;
+	bit_elv_setsda((void*)base,1);
+	bit_elv_setscl((void*)base,1);
+	return 0;
+
+fail:
+	release_region(base , (base == 0x3bc) ? 3 : 8);
+	return -ENODEV;
+}
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+static struct i2c_algo_bit_data bit_elv_data = {
+	.setsda		= bit_elv_setsda,
+	.setscl		= bit_elv_setscl,
+	.getsda		= bit_elv_getsda,
+	.getscl		= bit_elv_getscl,
+	.udelay		= 80,
+	.mdelay		= 80,
+	.timeout	= HZ
+};
+
+static struct i2c_adapter bit_elv_ops = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_HW_B_ELV,
+	.algo_data	= &bit_elv_data,
+	.name		= "ELV Parallel port adaptor",
+};
+
+static int __init i2c_bitelv_init(void)
+{
+	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	if (base==0) {
+		/* probe some values */
+		base=DEFAULT_BASE;
+		bit_elv_data.data=(void*)DEFAULT_BASE;
+		if (bit_elv_init()==0) {
+			if(i2c_bit_add_bus(&bit_elv_ops) < 0)
+				return -ENODEV;
+		} else {
+			return -ENODEV;
+		}
+	} else {
+		i2c_set_adapdata(&bit_elv_ops, (void *)base);
+		if (bit_elv_init()==0) {
+			if(i2c_bit_add_bus(&bit_elv_ops) < 0)
+				return -ENODEV;
+		} else {
+			return -ENODEV;
+		}
+	}
+	printk(KERN_DEBUG "i2c-elv.o: found device at %#x.\n",base);
+	return 0;
+}
+
+static void __exit i2c_bitelv_exit(void)
+{
+	i2c_bit_del_bus(&bit_elv_ops);
+	release_region(base , (base == 0x3bc) ? 3 : 8);
+}
+
+MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(base, "i");
+
+module_init(i2c_bitelv_init);
+module_exit(i2c_bitelv_exit);
diff -Nru a/drivers/i2c/i2c-elv.c b/drivers/i2c/i2c-elv.c
--- a/drivers/i2c/i2c-elv.c	Mon Sep 22 16:12:56 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,176 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-elv.c i2c-hw access for philips style parallel port adapters	     */
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
-/* $Id: i2c-elv.c,v 1.27 2003/01/21 08:08:16 kmalkki Exp $ */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/errno.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-#include <asm/io.h>
-
-#define DEFAULT_BASE 0x378
-static int base=0;
-static unsigned char PortData = 0;
-
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)		/* should be reasonable open, close &c. 	*/
-#define DEB2(x) 	/* low level debugging - very slow 		*/
-#define DEBE(x)	x	/* error messages 				*/
-#define DEBINIT(x) x	/* detection status messages			*/
-
-/* --- Convenience defines for the parallel port:			*/
-#define BASE	(unsigned int)(data)
-#define DATA	BASE			/* Centronics data port		*/
-#define STAT	(BASE+1)		/* Centronics status port	*/
-#define CTRL	(BASE+2)		/* Centronics control port	*/
-
-
-/* ----- local functions ----------------------------------------------	*/
-
-
-static void bit_elv_setscl(void *data, int state)
-{
-	if (state) {
-		PortData &= 0xfe;
-	} else {
-		PortData |=1;
-	}
-	outb(PortData, DATA);
-}
-
-static void bit_elv_setsda(void *data, int state)
-{
-	if (state) {
-		PortData &=0xfd;
-	} else {
-		PortData |=2;
-	}
-	outb(PortData, DATA);
-} 
-
-static int bit_elv_getscl(void *data)
-{
-	return ( 0 == ( (inb_p(STAT)) & 0x08 ) );
-}
-
-static int bit_elv_getsda(void *data)
-{
-	return ( 0 == ( (inb_p(STAT)) & 0x40 ) );
-}
-
-static int bit_elv_init(void)
-{
-	if (!request_region(base, (base == 0x3bc) ? 3 : 8,
-				"i2c (ELV adapter)"))
-		return -ENODEV;
-
-	if (inb(base+1) & 0x80) {	/* BUSY should be high	*/
-		DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Busy was low.\n"));
-		goto fail;
-	} 
-
-	outb(0x0c,base+2);	/* SLCT auf low		*/
-	udelay(400);
-	if (!(inb(base+1) && 0x10)) {
-		outb(0x04,base+2);
-		DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Select was high.\n"));
-		goto fail;
-	}
-
-	PortData = 0;
-	bit_elv_setsda((void*)base,1);
-	bit_elv_setscl((void*)base,1);
-	return 0;
-
-fail:
-	release_region(base , (base == 0x3bc) ? 3 : 8);
-	return -ENODEV;
-}
-
-/* ------------------------------------------------------------------------
- * Encapsulate the above functions in the correct operations structure.
- * This is only done when more than one hardware adapter is supported.
- */
-static struct i2c_algo_bit_data bit_elv_data = {
-	.setsda		= bit_elv_setsda,
-	.setscl		= bit_elv_setscl,
-	.getsda		= bit_elv_getsda,
-	.getscl		= bit_elv_getscl,
-	.udelay		= 80,
-	.mdelay		= 80,
-	.timeout	= HZ
-};
-
-static struct i2c_adapter bit_elv_ops = {
-	.owner		= THIS_MODULE,
-	.id		= I2C_HW_B_ELV,
-	.algo_data	= &bit_elv_data,
-	.name		= "ELV Parallel port adaptor",
-};
-
-static int __init i2c_bitelv_init(void)
-{
-	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
-	if (base==0) {
-		/* probe some values */
-		base=DEFAULT_BASE;
-		bit_elv_data.data=(void*)DEFAULT_BASE;
-		if (bit_elv_init()==0) {
-			if(i2c_bit_add_bus(&bit_elv_ops) < 0)
-				return -ENODEV;
-		} else {
-			return -ENODEV;
-		}
-	} else {
-		i2c_set_adapdata(&bit_elv_ops, (void *)base);
-		if (bit_elv_init()==0) {
-			if(i2c_bit_add_bus(&bit_elv_ops) < 0)
-				return -ENODEV;
-		} else {
-			return -ENODEV;
-		}
-	}
-	printk(KERN_DEBUG "i2c-elv.o: found device at %#x.\n",base);
-	return 0;
-}
-
-static void __exit i2c_bitelv_exit(void)
-{
-	i2c_bit_del_bus(&bit_elv_ops);
-	release_region(base , (base == 0x3bc) ? 3 : 8);
-}
-
-MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
-MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(base, "i");
-
-module_init(i2c_bitelv_init);
-module_exit(i2c_bitelv_exit);

