Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbUATAOz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUATAOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:14:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:23980 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265140AbUATAAH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:00:07 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
In-Reply-To: <10745567611379@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 15:59:21 -0800
Message-Id: <10745567611005@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.98.9, 2004/01/14 11:23:34-08:00, khali@linux-fr.org

[PATCH] I2C: New parport bus drivers

These are replacements for the i2c-philips-par, i2c-elv and i2c-velleman
drivers, as well as for the i2c-old i2c-parport driver as found under
drivers/media/video in linux 2.4. My reason for writing them, as already
discussed on the sensors and linux-kernel mailing-lists, is that all
these drivers basically do the same thing, so I thought it would be
easier to maintain a single driver instead of four. As Simon Vogl
pointed out that using a direct I/O access (as done in i2c-elv and
i2c-velleman) could be prefered over clean parport access (as done in
i2c-philips-par) on embedded devices, I finally wrote two drivers
instead of one. But both drivers support all devices, it's just a matter
of how they are accessed (and wether the driver depends on the parport
driver).

I made it so that the definition of the adapters (i.e. how to set and
get SDA and SCL, basically) is completely separated from the code
itself. Thus, adding support for a new adapter is simply adding a new
set of data to the definition table, describing how the adapter works,
in a single file.

This means that all simple parallel port adapters are virtually
supported. The i2c-pport driver we have in i2c CVS isn't supported yet
because it works a bit differently, but I believe that extending the
current driver(s) to support it should be possible (although it can be
discussed wether it's worth it).

You'll have to pass the type parameter that is correct for your board:
 0 = Philips
 2 = Velleman
 3 = ELV
 4 = ADM evaluation board

I could only test with my ADM eval board, and it worked OK with
both drivers. If they are confirmed to work, we could get rid of all
other parallel port i2c drivers in 2.6.
***

I think we should mark the i2c-philips-par, i2c-elv and i2c-velleman drivers as "deprecated" in i2c/busses/Kconfig. Is there a standard way to do so (like there is "&& EXPERIMENTAL" for new drivers)?

Thanks.


 drivers/i2c/busses/Kconfig             |   43 +++++
 drivers/i2c/busses/Makefile            |    2 
 drivers/i2c/busses/i2c-parport-light.c |  174 +++++++++++++++++++++
 drivers/i2c/busses/i2c-parport.c       |  266 +++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-parport.h       |   87 ++++++++++
 5 files changed, 572 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:31:46 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:31:46 2004
@@ -155,6 +155,49 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-philips-par.
 
+config I2C_PARPORT
+	tristate "Parallel port adapter"
+	depends on I2C_ALGOBIT && PARPORT
+	help
+	  This supports parallel port I2C adapters such as the ones made by
+	  Philips or Velleman, Analog Devices evaluation boards, and more.
+	  Basically any adapter using the parallel port as an I2C bus with
+	  no extra chipset is supported by this driver, or could be.
+
+	  This driver is a replacement for (and was inspired by) an older
+	  driver named i2c-philips-par.  The new driver supports more devices,
+	  and makes it easier to add support for new devices.
+	  
+	  Another driver exists, named i2c-parport-light, which doesn't depend
+	  on the parport driver.  This is meant for embedded systems. Don't say
+	  Y here if you intend to say Y or M there.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-parport.
+
+config I2C_PARPORT_LIGHT
+	tristate "Parallel port adapter (light)"
+	depends on I2C_ALGOBIT 
+	help
+	  This supports parallel port I2C adapters such as the ones made by
+	  Philips or Velleman, Analog Devices evaluation boards, and more.
+	  Basically any adapter using the parallel port as an I2C bus with
+	  no extra chipset is supported by this driver, or could be.
+
+	  This driver is a light version of i2c-parport.  It doesn't depend
+	  on the parport driver, and uses direct I/O access instead.  This
+	  might be prefered on embedded systems where wasting memory for
+	  the clean but heavy parport handling is not an option.  The
+	  drawback is a reduced portability and the impossibility to
+	  dasiy-chain other parallel port devices.
+	  
+	  Don't say Y here if you said Y or M to i2c-parport.  Saying M to
+	  both is possible but both modules should not be loaded at the same
+	  time.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-parport-light.
+
 config I2C_PIIX4
 	tristate "Intel PIIX4"
 	depends on I2C && PCI && EXPERIMENTAL && !64BIT
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Jan 19 15:31:46 2004
+++ b/drivers/i2c/busses/Makefile	Mon Jan 19 15:31:46 2004
@@ -17,6 +17,8 @@
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
+obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
+obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
diff -Nru a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-parport-light.c	Mon Jan 19 15:31:46 2004
@@ -0,0 +1,174 @@
+/* ------------------------------------------------------------------------ *
+ * i2c-parport.c I2C bus over parallel port                                 *
+ * ------------------------------------------------------------------------ *
+   Copyright (C) 2003-2004 Jean Delvare <khali@linux-fr.org>
+   
+   Based on older i2c-velleman.c driver
+   Copyright (C) 1995-2000 Simon G. Vogl
+   With some changes from:
+   Frodo Looijaard <frodol@dds.nl>
+   Kyösti Mälkki <kmalkki@cc.hut.fi>
+   
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * ------------------------------------------------------------------------ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <asm/io.h>
+#include "i2c-parport.h"
+
+#define DEFAULT_BASE 0x378
+
+static int base;
+MODULE_PARM(base, "i");
+MODULE_PARM_DESC(base, "Base I/O address");
+
+/* ----- Low-level parallel port access ----------------------------------- */
+
+static inline void port_write(unsigned char p, unsigned char d)
+{
+	outb(d, base+p);
+}
+
+static inline unsigned char port_read(unsigned char p)
+{
+	return inb(base+p);
+}
+
+/* ----- Unified line operation functions --------------------------------- */
+
+static inline void line_set(int state, const struct lineop *op)
+{
+	u8 oldval = port_read(op->port);
+
+	/* Touch only the bit(s) needed */
+	if ((op->inverted && !state) || (!op->inverted && state))
+		port_write(op->port, oldval | op->val);
+	else
+		port_write(op->port, oldval & ~op->val);
+}
+
+static inline int line_get(const struct lineop *op)
+{
+	u8 oldval = port_read(op->port);
+
+	return ((op->inverted && (oldval & op->val) != op->val)
+	    || (!op->inverted && (oldval & op->val) == op->val));
+}
+
+/* ----- I2C algorithm call-back functions and structures ----------------- */
+
+static void parport_setscl(void *data, int state)
+{
+	line_set(state, &adapter_parm[type].setscl);
+}
+
+static void parport_setsda(void *data, int state)
+{
+	line_set(state, &adapter_parm[type].setsda);
+}
+
+static int parport_getscl(void *data)
+{
+	return line_get(&adapter_parm[type].getscl);
+}
+
+static int parport_getsda(void *data)
+{
+	return line_get(&adapter_parm[type].getsda);
+}
+
+/* Encapsulate the functions above in the correct structure
+   Note that getscl will be set to NULL by the attaching code for adapters
+   that cannot read SCL back */
+static struct i2c_algo_bit_data parport_algo_data = {
+	.setsda		= parport_setsda,
+	.setscl		= parport_setscl,
+	.getsda		= parport_getsda,
+	.getscl		= parport_getscl,
+	.udelay		= 50,
+	.mdelay		= 50,
+	.timeout	= HZ,
+}; 
+
+/* ----- I2c structure ---------------------------------------------------- */
+
+static struct i2c_adapter parport_adapter = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_ADAP_CLASS_SMBUS,
+	.id		= I2C_HW_B_LP,
+	.algo_data	= &parport_algo_data,
+	.name		= "Parallel port adapter (light)",
+};
+
+/* ----- Module loading, unloading and information ------------------------ */
+
+static int __init i2c_parport_init(void)
+{
+	int type_count;
+
+	type_count = sizeof(adapter_parm)/sizeof(struct adapter_parm);
+	if (type < 0 || type >= type_count) {
+		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
+		type = 0;
+	}
+	
+	if (base == 0) {
+		printk(KERN_INFO "i2c-parport: using default base 0x%x\n", DEFAULT_BASE);
+		base = DEFAULT_BASE;
+	}
+
+	if (!request_region(base, 3, "i2c-parport"))
+		return -ENODEV;
+
+        if (!adapter_parm[type].getscl.val)
+		parport_algo_data.getscl = NULL;
+
+	/* Reset hardware to a sane state (SCL and SDA high) */
+	parport_setsda(NULL, 1);
+	parport_setscl(NULL, 1);
+	/* Other init if needed (power on...) */
+	if (adapter_parm[type].init.val)
+		line_set(1, &adapter_parm[type].init);
+
+	if (i2c_bit_add_bus(&parport_adapter) < 0) {
+		printk(KERN_ERR "i2c-parport: Unable to register with I2C\n");
+		release_region(base, 3);
+		return -ENODEV;
+	}
+	
+	return 0;
+}
+
+static void __exit i2c_parport_exit(void)
+{
+	/* Un-init if needed (power off...) */
+	if (adapter_parm[type].init.val)
+		line_set(0, &adapter_parm[type].init);
+
+	i2c_bit_del_bus(&parport_adapter);
+	release_region(base, 3);
+}
+
+MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
+MODULE_DESCRIPTION("I2C bus over parallel port (light)");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_parport_init);
+module_exit(i2c_parport_exit);
diff -Nru a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-parport.c	Mon Jan 19 15:31:46 2004
@@ -0,0 +1,266 @@
+/* ------------------------------------------------------------------------ *
+ * i2c-parport.c I2C bus over parallel port                                 *
+ * ------------------------------------------------------------------------ *
+   Copyright (C) 2003-2004 Jean Delvare <khali@linux-fr.org>
+   
+   Based on older i2c-philips-par.c driver
+   Copyright (C) 1995-2000 Simon G. Vogl
+   With some changes from:
+   Frodo Looijaard <frodol@dds.nl>
+   Kyösti Mälkki <kmalkki@cc.hut.fi>
+   
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * ------------------------------------------------------------------------ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/parport.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include "i2c-parport.h"
+
+/* ----- Device list ------------------------------------------------------ */
+
+struct i2c_par {
+	struct pardevice *pdev;
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data algo_data;
+	struct i2c_par *next;
+};
+
+static struct i2c_par *adapter_list;
+
+/* ----- Low-level parallel port access ----------------------------------- */
+
+static void port_write_data(struct parport *p, unsigned char d)
+{
+	parport_write_data(p, d);
+}
+
+static void port_write_control(struct parport *p, unsigned char d)
+{
+	parport_write_control(p, d);
+}
+
+static unsigned char port_read_data(struct parport *p)
+{
+	return parport_read_data(p);
+}
+
+static unsigned char port_read_status(struct parport *p)
+{
+	return parport_read_status(p);
+}
+
+static unsigned char port_read_control(struct parport *p)
+{
+	return parport_read_control(p);
+}
+
+static void (*port_write[])(struct parport *, unsigned char) = {
+	port_write_data,
+	NULL,
+	port_write_control,
+};
+
+static unsigned char (*port_read[])(struct parport *) = {
+	port_read_data,
+	port_read_status,
+	port_read_control,
+};
+
+/* ----- Unified line operation functions --------------------------------- */
+
+static inline void line_set(struct parport *data, int state,
+	const struct lineop *op)
+{
+	u8 oldval = port_read[op->port](data);
+
+	/* Touch only the bit(s) needed */
+	if ((op->inverted && !state) || (!op->inverted && state))
+		port_write[op->port](data, oldval | op->val);
+	else
+		port_write[op->port](data, oldval & ~op->val);
+}
+
+static inline int line_get(struct parport *data,
+	const struct lineop *op)
+{
+	u8 oldval = port_read[op->port](data);
+
+	return ((op->inverted && (oldval & op->val) != op->val)
+	    || (!op->inverted && (oldval & op->val) == op->val));
+}
+
+/* ----- I2C algorithm call-back functions and structures ----------------- */
+
+static void parport_setscl(void *data, int state)
+{
+	line_set((struct parport *) data, state, &adapter_parm[type].setscl);
+}
+
+static void parport_setsda(void *data, int state)
+{
+	line_set((struct parport *) data, state, &adapter_parm[type].setsda);
+}
+
+static int parport_getscl(void *data)
+{
+	return line_get((struct parport *) data, &adapter_parm[type].getscl);
+}
+
+static int parport_getsda(void *data)
+{
+	return line_get((struct parport *) data, &adapter_parm[type].getsda);
+}
+
+/* Encapsulate the functions above in the correct structure.
+   Note that this is only a template, from which the real structures are
+   copied. The attaching code will set getscl to NULL for adapters that
+   cannot read SCL back, and will also make the the data field point to
+   the parallel port structure. */
+static struct i2c_algo_bit_data parport_algo_data = {
+	.setsda		= parport_setsda,
+	.setscl		= parport_setscl,
+	.getsda		= parport_getsda,
+	.getscl		= parport_getscl,
+	.udelay		= 60,
+	.mdelay		= 60,
+	.timeout	= HZ,
+}; 
+
+/* ----- I2c and parallel port call-back functions and structures --------- */
+
+static struct i2c_adapter parport_adapter = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_ADAP_CLASS_SMBUS,
+	.id		= I2C_HW_B_LP,
+	.name		= "Parallel port adapter",
+};
+
+static void i2c_parport_attach (struct parport *port)
+{
+	struct i2c_par *adapter;
+	
+	adapter = kmalloc(sizeof(struct i2c_par), GFP_KERNEL);
+	if (adapter == NULL) {
+		printk(KERN_ERR "i2c-parport: Failed to kmalloc\n");
+		return;
+	}
+	memset(adapter, 0x00, sizeof(struct i2c_par));
+
+	printk(KERN_DEBUG "i2c-parport: attaching to %s\n", port->name);
+	adapter->pdev = parport_register_device(port, "i2c-parport",
+		NULL, NULL, NULL, PARPORT_FLAG_EXCL, NULL);
+	if (!adapter->pdev) {
+		printk(KERN_ERR "i2c-parport: Unable to register with parport\n");
+		goto ERROR0;
+	}
+
+	/* Fill the rest of the structure */
+	adapter->adapter = parport_adapter;
+	adapter->algo_data = parport_algo_data;
+	if (!adapter_parm[type].getscl.val)
+		adapter->algo_data.getscl = NULL;
+	adapter->algo_data.data = port;
+	adapter->adapter.algo_data = &adapter->algo_data;
+
+	if (parport_claim_or_block(adapter->pdev) < 0) {
+		printk(KERN_ERR "i2c-parport: Could not claim parallel port\n");
+		goto ERROR1;
+	}
+
+	/* Reset hardware to a sane state (SCL and SDA high) */
+	parport_setsda(port, 1);
+	parport_setscl(port, 1);
+	/* Other init if needed (power on...) */
+	if (adapter_parm[type].init.val)
+		line_set(port, 1, &adapter_parm[type].init);
+
+	parport_release(adapter->pdev);
+
+	if (i2c_bit_add_bus(&adapter->adapter) < 0) {
+		printk(KERN_ERR "i2c-parport: Unable to register with I2C\n");
+		goto ERROR1;
+	}
+
+	/* Add the new adapter to the list */
+	adapter->next = adapter_list;
+	adapter_list = adapter;
+        return;
+
+ERROR1:
+	parport_unregister_device(adapter->pdev);
+ERROR0:
+	kfree(adapter);
+}
+
+static void i2c_parport_detach (struct parport *port)
+{
+	struct i2c_par *adapter, *prev;
+
+	/* Walk the list */
+	for (prev = NULL, adapter = adapter_list; adapter;
+	     prev = adapter, adapter = adapter->next) {
+		if (adapter->pdev->port == port) {
+			/* Un-init if needed (power off...) */
+			if (adapter_parm[type].init.val)
+				line_set(port, 0, &adapter_parm[type].init);
+				
+			i2c_bit_del_bus(&adapter->adapter);
+			parport_unregister_device(adapter->pdev);
+			if (prev)
+				prev->next = adapter->next;
+			else
+				adapter_list = adapter->next;
+			kfree(adapter);
+			return;
+		}
+	}
+}
+
+static struct parport_driver i2c_driver = {
+	.name	= "i2c-parport",
+	.attach	= i2c_parport_attach,
+	.detach	= i2c_parport_detach,
+};
+
+/* ----- Module loading, unloading and information ------------------------ */
+
+static int __init i2c_parport_init(void)
+{
+	int type_count;
+
+	type_count = sizeof(adapter_parm)/sizeof(struct adapter_parm);
+	if (type < 0 || type >= type_count) {
+		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
+		type = 0;
+	}
+	
+	return parport_register_driver(&i2c_driver);
+}
+
+static void __exit i2c_parport_exit(void)
+{
+	parport_unregister_driver(&i2c_driver);
+}
+
+MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
+MODULE_DESCRIPTION("I2C bus over parallel port");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_parport_init);
+module_exit(i2c_parport_exit);
diff -Nru a/drivers/i2c/busses/i2c-parport.h b/drivers/i2c/busses/i2c-parport.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-parport.h	Mon Jan 19 15:31:46 2004
@@ -0,0 +1,87 @@
+/* ------------------------------------------------------------------------ *
+ * i2c-parport.h I2C bus over parallel port                                 *
+ * ------------------------------------------------------------------------ *
+   Copyright (C) 2003-2004 Jean Delvare <khali@linux-fr.org>
+   
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * ------------------------------------------------------------------------ */
+
+#ifdef DATA
+#undef DATA
+#endif
+
+#define DATA	0
+#define STAT	1
+#define CTRL	2
+
+struct lineop {
+	u8 val;
+	u8 port;
+	u8 inverted;
+};
+
+struct adapter_parm {
+	struct lineop setsda;
+	struct lineop setscl;
+	struct lineop getsda;
+	struct lineop getscl;
+	struct lineop init;
+};
+
+static struct adapter_parm adapter_parm[] = {
+	/* type 0: Philips adapter */
+	{
+		.setsda	= { 0x80, DATA, 1 },
+		.setscl	= { 0x08, CTRL, 0 },
+		.getsda	= { 0x80, STAT, 0 },
+		.getscl	= { 0x08, STAT, 0 },
+	},
+	/* type 1: home brew teletext adapter */
+	{
+		.setsda	= { 0x02, DATA, 0 },
+		.setscl	= { 0x01, DATA, 0 },
+		.getsda	= { 0x80, STAT, 1 },
+	},
+	/* type 2: Velleman K8000 adapter */
+	{
+		.setsda	= { 0x02, CTRL, 1 },
+		.setscl	= { 0x08, CTRL, 1 },
+		.getsda	= { 0x10, STAT, 0 },
+	},
+	/* type 3: ELV adapter */
+	{
+		.setsda	= { 0x02, DATA, 1 },
+		.setscl	= { 0x01, DATA, 1 },
+		.getsda	= { 0x40, STAT, 1 },
+		.getscl	= { 0x08, STAT, 1 },
+	},
+	/* type 4: ADM 1032 evaluation board */
+	{
+		.setsda	= { 0x02, DATA, 1 },
+		.setscl	= { 0x01, DATA, 1 },
+		.getsda	= { 0x10, STAT, 1 },
+		.init	= { 0xf0, DATA, 0 },
+	},
+};
+
+static int type;
+MODULE_PARM(type, "i");
+MODULE_PARM_DESC(type,
+	"Type of adapter:\n"
+	" 0 = Philips adapter\n"
+	" 1 = home brew teletext adapter\n"
+	" 2 = Velleman K8000 adapter\n"
+	" 3 = ELV adapter\n"
+	" 4 = ADM 1032 evalulation board\n");

