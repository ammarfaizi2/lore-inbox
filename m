Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTIWADY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263068AbTIWABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:01:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:29857 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262817AbTIVXba convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:30 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734271040@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734262308@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.22, 2003/09/22 14:09:17-07:00, greg@kroah.com

[PATCH] I2C: move i2c-velleman driver to drivers/i2c/busses


 drivers/i2c/i2c-velleman.c        |  161 --------------------------------------
 drivers/i2c/Kconfig               |   10 --
 drivers/i2c/Makefile              |    1 
 drivers/i2c/busses/Kconfig        |   10 ++
 drivers/i2c/busses/Makefile       |    1 
 drivers/i2c/busses/i2c-velleman.c |  160 +++++++++++++++++++++++++++++++++++++
 6 files changed, 171 insertions(+), 172 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:12:26 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:12:26 2003
@@ -48,16 +48,6 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-bit.
 
-config I2C_VELLEMAN
-	tristate "Velleman K9000 adapter"
-	depends on I2C_ALGOBIT && ISA
-	help
-	  This supports the Velleman K9000 parallel-port I2C adapter.  Say Y
-	  if you own such an adapter.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-velleman.
-
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
 	depends on SCx200 && I2C_ALGOBIT
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Sep 22 16:12:26 2003
+++ b/drivers/i2c/Makefile	Mon Sep 22 16:12:26 2003
@@ -5,7 +5,6 @@
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
-obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:26 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:26 2003
@@ -203,6 +203,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-sis96x.
 
+config I2C_VELLEMAN
+	tristate "Velleman K9000 adapter"
+	depends on I2C_ALGOBIT && ISA
+	help
+	  This supports the Velleman K9000 parallel-port I2C adapter.  Say Y
+	  if you own such an adapter.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-velleman.
+
 config I2C_VIA
 	tristate "VIA 82C58B"
 	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:26 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:26 2003
@@ -19,6 +19,7 @@
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
 obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
+obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
 obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-velleman.c	Mon Sep 22 16:12:26 2003
@@ -0,0 +1,160 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-velleman.c i2c-hw access for Velleman K9000 adapters		     */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 1995-96, 2000 Simon G. Vogl
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
+/* $Id: i2c-velleman.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <asm/io.h>
+
+/* ----- global defines -----------------------------------------------	*/
+#define DEB(x)		/* should be reasonable open, close &c. 	*/
+#define DEB2(x) 	/* low level debugging - very slow 		*/
+#define DEBE(x)	x	/* error messages 				*/
+
+					/* Pin Port  Inverted	name	*/
+#define I2C_SDA		0x02		/*  ctrl bit 1 	(inv)	*/
+#define I2C_SCL		0x08		/*  ctrl bit 3 	(inv)	*/
+
+#define I2C_SDAIN	0x10		/* stat bit 4		*/
+#define I2C_SCLIN	0x08		/* ctrl bit 3 (inv)(reads own output)*/
+
+#define I2C_DMASK	0xfd
+#define I2C_CMASK	0xf7
+
+
+/* --- Convenience defines for the parallel port:			*/
+#define BASE	(unsigned int)(data)
+#define DATA	BASE			/* Centronics data port		*/
+#define STAT	(BASE+1)		/* Centronics status port	*/
+#define CTRL	(BASE+2)		/* Centronics control port	*/
+
+#define DEFAULT_BASE 0x378
+static int base=0;
+
+/* ----- local functions --------------------------------------------------- */
+
+static void bit_velle_setscl(void *data, int state)
+{
+	if (state) {
+		outb(inb(CTRL) & I2C_CMASK,   CTRL);
+	} else {
+		outb(inb(CTRL) | I2C_SCL, CTRL);
+	}
+	
+}
+
+static void bit_velle_setsda(void *data, int state)
+{
+	if (state) {
+		outb(inb(CTRL) & I2C_DMASK , CTRL);
+	} else {
+		outb(inb(CTRL) | I2C_SDA, CTRL);
+	}
+	
+} 
+
+static int bit_velle_getscl(void *data)
+{
+	return ( 0 == ( (inb(CTRL)) & I2C_SCLIN ) );
+}
+
+static int bit_velle_getsda(void *data)
+{
+	return ( 0 != ( (inb(STAT)) & I2C_SDAIN ) );
+}
+
+static int bit_velle_init(void)
+{
+	if (!request_region(base, (base == 0x3bc) ? 3 : 8, 
+			"i2c (Vellemann adapter)"))
+		return -ENODEV;
+
+	bit_velle_setsda((void*)base,1);
+	bit_velle_setscl((void*)base,1);
+	return 0;
+}
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+
+static struct i2c_algo_bit_data bit_velle_data = {
+	.setsda		= bit_velle_setsda,
+	.setscl		= bit_velle_setscl,
+	.getsda		= bit_velle_getsda,
+	.getscl		= bit_velle_getscl,
+	.udelay		= 10,
+	.mdelay		= 10,
+	.timeout	= HZ
+};
+
+static struct i2c_adapter bit_velle_ops = {
+	.owner		= THIS_MODULE,
+	.algo_data	= &bit_velle_data,
+	.name		= "Velleman K8000",
+};
+
+static int __init i2c_bitvelle_init(void)
+{
+	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	if (base==0) {
+		/* probe some values */
+		base=DEFAULT_BASE;
+		bit_velle_data.data=(void*)DEFAULT_BASE;
+		if (bit_velle_init()==0) {
+			if(i2c_bit_add_bus(&bit_velle_ops) < 0)
+				return -ENODEV;
+		} else {
+			return -ENODEV;
+		}
+	} else {
+		bit_velle_data.data=(void*)base;
+		if (bit_velle_init()==0) {
+			if(i2c_bit_add_bus(&bit_velle_ops) < 0)
+				return -ENODEV;
+		} else {
+			return -ENODEV;
+		}
+	}
+	printk(KERN_DEBUG "i2c-velleman.o: found device at %#x.\n",base);
+	return 0;
+}
+
+static void __exit i2c_bitvelle_exit(void)
+{	
+	i2c_bit_del_bus(&bit_velle_ops);
+	release_region(base, (base == 0x3bc) ? 3 : 8);
+}
+
+MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
+MODULE_DESCRIPTION("I2C-Bus adapter routines for Velleman K8000 adapter");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(base, "i");
+
+module_init(i2c_bitvelle_init);
+module_exit(i2c_bitvelle_exit);
diff -Nru a/drivers/i2c/i2c-velleman.c b/drivers/i2c/i2c-velleman.c
--- a/drivers/i2c/i2c-velleman.c	Mon Sep 22 16:12:26 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,161 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-velleman.c i2c-hw access for Velleman K9000 adapters		     */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 1995-96, 2000 Simon G. Vogl
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
-/* $Id: i2c-velleman.c,v 1.29 2003/01/21 08:08:16 kmalkki Exp $ */
-
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-#include <asm/io.h>
-
-/* ----- global defines -----------------------------------------------	*/
-#define DEB(x)		/* should be reasonable open, close &c. 	*/
-#define DEB2(x) 	/* low level debugging - very slow 		*/
-#define DEBE(x)	x	/* error messages 				*/
-
-					/* Pin Port  Inverted	name	*/
-#define I2C_SDA		0x02		/*  ctrl bit 1 	(inv)	*/
-#define I2C_SCL		0x08		/*  ctrl bit 3 	(inv)	*/
-
-#define I2C_SDAIN	0x10		/* stat bit 4		*/
-#define I2C_SCLIN	0x08		/* ctrl bit 3 (inv)(reads own output)*/
-
-#define I2C_DMASK	0xfd
-#define I2C_CMASK	0xf7
-
-
-/* --- Convenience defines for the parallel port:			*/
-#define BASE	(unsigned int)(data)
-#define DATA	BASE			/* Centronics data port		*/
-#define STAT	(BASE+1)		/* Centronics status port	*/
-#define CTRL	(BASE+2)		/* Centronics control port	*/
-
-#define DEFAULT_BASE 0x378
-static int base=0;
-
-/* ----- local functions --------------------------------------------------- */
-
-static void bit_velle_setscl(void *data, int state)
-{
-	if (state) {
-		outb(inb(CTRL) & I2C_CMASK,   CTRL);
-	} else {
-		outb(inb(CTRL) | I2C_SCL, CTRL);
-	}
-	
-}
-
-static void bit_velle_setsda(void *data, int state)
-{
-	if (state) {
-		outb(inb(CTRL) & I2C_DMASK , CTRL);
-	} else {
-		outb(inb(CTRL) | I2C_SDA, CTRL);
-	}
-	
-} 
-
-static int bit_velle_getscl(void *data)
-{
-	return ( 0 == ( (inb(CTRL)) & I2C_SCLIN ) );
-}
-
-static int bit_velle_getsda(void *data)
-{
-	return ( 0 != ( (inb(STAT)) & I2C_SDAIN ) );
-}
-
-static int bit_velle_init(void)
-{
-	if (!request_region(base, (base == 0x3bc) ? 3 : 8, 
-			"i2c (Vellemann adapter)"))
-		return -ENODEV;
-
-	bit_velle_setsda((void*)base,1);
-	bit_velle_setscl((void*)base,1);
-	return 0;
-}
-
-/* ------------------------------------------------------------------------
- * Encapsulate the above functions in the correct operations structure.
- * This is only done when more than one hardware adapter is supported.
- */
-
-static struct i2c_algo_bit_data bit_velle_data = {
-	.setsda		= bit_velle_setsda,
-	.setscl		= bit_velle_setscl,
-	.getsda		= bit_velle_getsda,
-	.getscl		= bit_velle_getscl,
-	.udelay		= 10,
-	.mdelay		= 10,
-	.timeout	= HZ
-};
-
-static struct i2c_adapter bit_velle_ops = {
-	.owner		= THIS_MODULE,
-	.id		= I2C_HW_B_VELLE,
-	.algo_data	= &bit_velle_data,
-	.name		= "Velleman K8000",
-};
-
-static int __init i2c_bitvelle_init(void)
-{
-	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
-	if (base==0) {
-		/* probe some values */
-		base=DEFAULT_BASE;
-		bit_velle_data.data=(void*)DEFAULT_BASE;
-		if (bit_velle_init()==0) {
-			if(i2c_bit_add_bus(&bit_velle_ops) < 0)
-				return -ENODEV;
-		} else {
-			return -ENODEV;
-		}
-	} else {
-		bit_velle_data.data=(void*)base;
-		if (bit_velle_init()==0) {
-			if(i2c_bit_add_bus(&bit_velle_ops) < 0)
-				return -ENODEV;
-		} else {
-			return -ENODEV;
-		}
-	}
-	printk(KERN_DEBUG "i2c-velleman.o: found device at %#x.\n",base);
-	return 0;
-}
-
-static void __exit i2c_bitvelle_exit(void)
-{	
-	i2c_bit_del_bus(&bit_velle_ops);
-	release_region(base, (base == 0x3bc) ? 3 : 8);
-}
-
-MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
-MODULE_DESCRIPTION("I2C-Bus adapter routines for Velleman K8000 adapter");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(base, "i");
-
-module_init(i2c_bitvelle_init);
-module_exit(i2c_bitvelle_exit);

