Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbUCPBeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263390AbUCPBcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:32:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:45743 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262927AbUCPADD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:03:03 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913954036@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:35 -0800
Message-Id: <1079391395680@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1647, 2004/03/15 14:14:17-08:00, greg@kroah.com

[PATCH] I2C: delete the i2c_philips-par.c and i2c-veleman.c drivers

They are obsolted by the i2c-parport.c driver.


 drivers/i2c/busses/i2c-philips-par.c |  242 -----------------------------------
 drivers/i2c/busses/i2c-velleman.c    |  154 ----------------------
 drivers/i2c/busses/Kconfig           |   21 ---
 drivers/i2c/busses/Makefile          |    2 
 4 files changed, 419 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Mar 15 14:33:42 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Mar 15 14:33:42 2004
@@ -164,16 +164,6 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-nforce2.
 
-config I2C_PHILIPSPAR
-	tristate "Philips style parallel port adapter"
-	depends on I2C && PARPORT
-	select I2C_ALGOBIT
-	help
-	  This supports parallel-port I2C adapters made by Philips.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-philips-par.
-
 config I2C_PARPORT
 	tristate "Parallel port adapter"
 	depends on I2C && PARPORT
@@ -342,17 +332,6 @@
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-sis96x.
-
-config I2C_VELLEMAN
-	tristate "Velleman K8000 adapter"
-	depends on I2C
-	select I2C_ALGOBIT
-	help
-	  This supports the Velleman K8000 parallel-port I2C adapter.  Say Y
-	  if you own such an adapter.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-velleman.
 
 config I2C_VIA
 	tristate "VIA 82C586B"
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Mar 15 14:33:42 2004
+++ b/drivers/i2c/busses/Makefile	Mon Mar 15 14:33:42 2004
@@ -17,7 +17,6 @@
 obj-$(CONFIG_I2C_IXP42X)	+= i2c-ixp42x.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
-obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
@@ -27,7 +26,6 @@
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
 obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
-obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
 obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
diff -Nru a/drivers/i2c/busses/i2c-philips-par.c b/drivers/i2c/busses/i2c-philips-par.c
--- a/drivers/i2c/busses/i2c-philips-par.c	Mon Mar 15 14:33:42 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,242 +0,0 @@
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
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
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
-	memset (adapter, 0x00, sizeof(struct i2c_par));
-
-	/* pr_debug("i2c-philips-par: attaching to %s\n", port->name); */
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
-	adapter->bit_lp_data.setsda(port, 1);
-	adapter->bit_lp_data.setscl(port, 1);
-	parport_release(adapter->pdev);
-
-	if (i2c_bit_add_bus(&adapter->adapter) < 0) {
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
-	for (adapter = adapter_list; adapter; adapter = adapter->next) {
-		if (adapter->pdev->port == port) {
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
-static struct parport_driver i2c_driver = {
-	.name =		"i2c-philips-par",
-	.attach =	i2c_parport_attach,
-	.detach =	i2c_parport_detach,
-};
-
-int __init i2c_bitlp_init(void)
-{
-	printk(KERN_INFO "i2c Philips parallel port adapter driver\n");
-
-	return parport_register_driver(&i2c_driver);
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
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- a/drivers/i2c/busses/i2c-velleman.c	Mon Mar 15 14:33:42 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,154 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-velleman.c i2c-hw access for Velleman K8000 adapters		     */
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
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/ioport.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-#include <asm/io.h>
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
-#define BASE	(unsigned long)(data)
-#define DATA	BASE			/* Centronics data port		*/
-#define STAT	(BASE+1)		/* Centronics status port	*/
-#define CTRL	(BASE+2)		/* Centronics control port	*/
-
-#define DEFAULT_BASE 0x378
-static long base=0;
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
-	.algo_data	= &bit_velle_data,
-	.name		= "Velleman K8000",
-};
-
-static int __init i2c_bitvelle_init(void)
-{
-	printk(KERN_INFO "i2c-velleman: i2c Velleman K8000 driver\n");
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
-	pr_debug("i2c-velleman: found device at %#lx.\n",base);
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

