Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbUCPANF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbUCPAKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:10:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:15279 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262892AbUCPACM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:12 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913953926@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:35 -0800
Message-Id: <10793913954036@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1646, 2004/03/15 14:13:28-08:00, greg@kroah.com

[PATCH] I2C: delete the i2c-elv.c driver as it is obsoleted by the i2c-parport.c driver.


 drivers/i2c/busses/i2c-elv.c |  168 -------------------------------------------
 drivers/i2c/busses/Kconfig   |   11 --
 drivers/i2c/busses/Makefile  |    1 
 3 files changed, 180 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Mar 15 14:33:49 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Mar 15 14:33:49 2004
@@ -58,17 +58,6 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-elektor.
 
-config I2C_ELV
-	tristate "ELV adapter"
-	depends on I2C
-	select I2C_ALGOBIT
-	help
-	  This supports parallel-port I2C adapters called ELV.  Say Y if you
-	  own such an adapter.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-elv.
-
 config I2C_HYDRA
 	tristate "CHRP Apple Hydra Mac I/O I2C interface"
 	depends on I2C && PCI && PPC_CHRP && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Mar 15 14:33:49 2004
+++ b/drivers/i2c/busses/Makefile	Mon Mar 15 14:33:49 2004
@@ -7,7 +7,6 @@
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
-obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
diff -Nru a/drivers/i2c/busses/i2c-elv.c b/drivers/i2c/busses/i2c-elv.c
--- a/drivers/i2c/busses/i2c-elv.c	Mon Mar 15 14:33:49 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,168 +0,0 @@
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
-#include <linux/config.h>
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
-static long base=0;
-static unsigned char port_data = 0;
-
-/* --- Convenience defines for the parallel port:			*/
-#define BASE	(unsigned long)(data)
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
-		port_data &= 0xfe;
-	} else {
-		port_data |=1;
-	}
-	outb(port_data, DATA);
-}
-
-static void bit_elv_setsda(void *data, int state)
-{
-	if (state) {
-		port_data &=0xfd;
-	} else {
-		port_data |=2;
-	}
-	outb(port_data, DATA);
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
-		pr_debug("i2c-elv: Busy was low.\n");
-		goto fail;
-	} 
-
-	outb(0x0c,base+2);	/* SLCT auf low		*/
-	udelay(400);
-	if (!(inb(base+1) && 0x10)) {
-		outb(0x04,base+2);
-		pr_debug("i2c-elv: Select was high.\n");
-		goto fail;
-	}
-
-	port_data = 0;
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
-	.algo_data	= &bit_elv_data,
-	.name		= "ELV Parallel port adaptor",
-};
-
-static int __init i2c_bitelv_init(void)
-{
-	printk(KERN_INFO "i2c ELV parallel port adapter driver\n");
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
-	pr_debug("i2c-elv: found device at %#lx.\n",base);
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

