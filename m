Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262711AbTCTW0C>; Thu, 20 Mar 2003 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262724AbTCTWZ2>; Thu, 20 Mar 2003 17:25:28 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:44037 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262711AbTCTWVl>;
	Thu, 20 Mar 2003 17:21:41 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <1048199574195@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995753053@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.15, 2003/03/20 11:47:43-08:00, greg@kroah.com

i2c: added i2c-isa bus controller driver.

Based on the i2c cvs version of this driver.


 drivers/i2c/busses/Kconfig   |   18 ++++++++++++
 drivers/i2c/busses/Makefile  |    1 
 drivers/i2c/busses/i2c-isa.c |   62 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Thu Mar 20 12:53:05 2003
+++ b/drivers/i2c/busses/Kconfig	Thu Mar 20 12:53:05 2003
@@ -76,6 +76,24 @@
 	  in the lm_sensors package, which you can download at 
 	  http://www.lm-sensors.nu
 
+config I2C_ISA
+	tristate "  ISA Bus support"
+	depends on I2C && I2C_PROC && ISA && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for i2c
+	  interfaces that are on the ISA bus.
+
+	  This can also be built as a module which can be inserted and removed 
+	  while the kernel is running.  If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  The module will be called i2c-isa.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at 
+	  http://www.lm-sensors.nu
+
+
 config I2C_PIIX4
 	tristate "  Intel PIIX4"
 	depends on I2C && I2C_PROC && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Thu Mar 20 12:53:05 2003
+++ b/drivers/i2c/busses/Makefile	Thu Mar 20 12:53:05 2003
@@ -6,4 +6,5 @@
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
+obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-isa.c	Thu Mar 20 12:53:05 2003
@@ -0,0 +1,62 @@
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
+#include <linux/errno.h>
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
+static int __init i2c_isa_init(void)
+{
+	return i2c_add_adapter(&isa_adapter);
+}
+
+static void __exit i2c_isa_exit(void)
+{
+	i2c_del_adapter(&isa_adapter);
+}
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("ISA bus access through i2c");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_isa_init);
+module_exit(i2c_isa_exit);

