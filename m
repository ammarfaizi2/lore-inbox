Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTAPUn1>; Thu, 16 Jan 2003 15:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTAPUnQ>; Thu, 16 Jan 2003 15:43:16 -0500
Received: from gjs.xs4all.nl ([80.126.25.16]:52163 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S267268AbTAPUnI>;
	Thu, 16 Jan 2003 15:43:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: GertJan Spoelman <kl@gjs.cc>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] (1/3) i2c-isa, via686a and w8378x series sensors support for 2.5.58
Date: Thu, 16 Jan 2003 21:52:01 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301162152.01788.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

These 3 patches provide support for the Pseudo ISA adapter (i2c-isa),
the VIA 686A Integrated Hardware Monitor (via686a) and Winbond W8378x series
(w83781d) sensors.
Both sensors depend on i2c-isa.
The added files are modified versions of the ones found in the lm_sensors-2.7.0
package and were ported by me with help from Christoph Hellwig to the new driver model.

This patch (1/3) adds /drivers/i2c/busses/i2c-isa.c and adds it to Kconfig and Makefile
in the same dir.
Please apply.

Thanks,

	GertJan

diff -Nru linux-2.5.58/drivers/i2c/busses/Kconfig linux-2.5.58-edited/drivers/i2c/busses/Kconfig
--- linux-2.5.58/drivers/i2c/busses/Kconfig	2003-01-15 20:43:35.000000000 +0100
+++ linux-2.5.58-edited/drivers/i2c/busses/Kconfig	2003-01-12 12:32:03.000000000 +0100
@@ -39,5 +39,19 @@
 	  in the lm_sensors package, which you can download at 
 	  http://www.lm-sensors.nu
 
+config I2C_ISA
+	tristate "  Pseudo ISA adapter (for some hardware sensors)"
+	depends on I2C && ISA
+	help
+	  This provide support for accessing some hardware sensors chips over
+	  the ISA bus rather than the I2C or SMBus. If you want to do this,
+	  say yes here.
+
+	  This can also be built as a module which can be inserted and removed
+	  while the kernel is running.  If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  The module will be called i2c-isa.ko.
+
 endmenu
 
diff -Nru linux-2.5.58/drivers/i2c/busses/Makefile linux-2.5.58-edited/drivers/i2c/busses/Makefile
--- linux-2.5.58/drivers/i2c/busses/Makefile	2003-01-15 20:43:48.000000000 +0100
+++ linux-2.5.58-edited/drivers/i2c/busses/Makefile	2003-01-12 12:32:03.000000000 +0100
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
+obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
diff -Nru linux-2.5.58/drivers/i2c/busses/i2c-isa.c linux-2.5.58-edited/drivers/i2c/busses/i2c-isa.c
--- linux-2.5.58/drivers/i2c/busses/i2c-isa.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.58-edited/drivers/i2c/busses/i2c-isa.c	2003-01-12 12:32:03.000000000 +0100
@@ -0,0 +1,61 @@
+/*
+    i2c-isa.c - Part of lm_sensors, Linux kernel modules for hardware
+            monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
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
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/* This implements an i2c algorithm/adapter for ISA bus. Not that this is
+   on first sight very useful; almost no functionality is preserved.
+   Except that it makes writing drivers for chips which can be on both
+   the SMBus and the ISA bus very much easier. See lm78.c for an example
+   of this. */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+
+/* This is the actual algorithm we define */
+static struct i2c_algorithm isa_algorithm = {
+	.name		= "ISA bus algorithm",
+	.id		= I2C_ALGO_ISA,
+};
+
+/* There can only be one... */
+static struct i2c_adapter isa_adapter = {
+	.owner		= THIS_MODULE,
+	.name		= "ISA main adapter",
+	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
+	.algo		= &isa_algorithm,
+};
+
+static int __init isa_init(void)
+{
+	return i2c_add_adapter(&isa_adapter);
+}
+
+static void __exit isa_exit(void)
+{
+	i2c_del_adapter(&isa_adapter);
+}
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("ISA bus access through i2c");
+MODULE_LICENSE("GPL");
+
+module_init(isa_init)
+module_exit(isa_exit)

