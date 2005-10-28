Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030215AbVJ1QIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030215AbVJ1QIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbVJ1QIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:08:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23315 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030325AbVJ1QIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:08:51 -0400
Date: Fri, 28 Oct 2005 17:08:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <richard@openedhand.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC] The driver model, I2C and gpio provision on Sharp SL-C1000 (Akita)
Message-ID: <20051028160841.GB4464@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <richard@openedhand.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>
References: <1130493129.8414.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130493129.8414.70.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 10:52:09AM +0100, Richard Purdie wrote:
> I2C drivers appear relatively late in the boot procedure and changing
> that isn't practical. I therefore ended up writing akita-ioexp which
> acts as an interface between the rest of the kernel drivers and the
> max7310 i2c driver.

You're not the only one with this problem, and this is one reason I've
never submitted the SA11x0 audio drivers.  The L3 bus subsystem inter-
links on some platforms with the I2C subsystem (it physically shares
the same signals but it isn't I2C compatible as such.)

Hence, in order to lock I2C off the bus, we have to take the same
driver-based locks as I2C.  This can only really happen if I2C is
initialised first.

Below is the complete patch for the L3 support, which includes moving
the I2C initialisation early.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N linus/Documentation/l3/structure linux/Documentation/l3/structure
--- linus/Documentation/l3/structure	Thu Jan  1 01:00:00 1970
+++ linux/Documentation/l3/structure	Sun Aug  5 18:40:00 2001
@@ -0,0 +1,23 @@
+L3 Bus Driver
+-------------
+
+The structure of the L3 subsystem is as follows:
+
+       ^              ^            ^
+       |              |            |
+       |        +-----v----+  +----v-----+
+       |        | device   |  | device   |
+       |        | driver 1 |  | driver 2 |
+  +----v-----+  +-----^----+  +----^-----+
+  |   core   |        |            |
+  | services <--------+------------+
+  +----^-----+
+       |
+   +---v----+   +-----------+
+   |  bus   <---> algorithm |
+   | driver |   |  driver   |
+   +--------+   +-----------+
+
+Applications talk to the core to obtain bus adapters.  Applications talk
+to device drivers to perform actions.  Device drivers in turn talk to the
+core to perform L3 bus transactions via the bus and algorithm drivers.
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/arch/arm/Kconfig linux/./arch/arm/Kconfig
--- orig/arch/arm/Kconfig	Wed Jun 29 15:49:19 2005
+++ linux/arch/arm/Kconfig	Wed Jun 29 16:07:34 2005
@@ -736,7 +736,7 @@ source "drivers/char/Kconfig"
 
 source "drivers/hwmon/Kconfig"
 
-#source "drivers/l3/Kconfig"
+source "drivers/l3/Kconfig"
 
 source "drivers/misc/Kconfig"
 
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/drivers/Makefile linux/./drivers/Makefile
--- orig/drivers/Makefile	Wed Jun 29 15:49:56 2005
+++ linux/drivers/Makefile	Wed Jun 29 15:58:48 2005
@@ -12,6 +12,8 @@ obj-$(CONFIG_ACPI_BOOT)		+= acpi/
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
 obj-$(CONFIG_PNP)		+= pnp/
+obj-$(CONFIG_I2C)		+= i2c/
+obj-$(CONFIG_L3)		+= l3/
 
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
@@ -52,7 +54,6 @@ obj-$(CONFIG_SBUS)		+= sbus/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
-obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_PHONE)		+= telephony/
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git linus/drivers/i2c/busses/Kconfig linux/drivers/i2c/busses/Kconfig
--- linus/drivers/i2c/busses/Kconfig	Wed Jun 22 22:41:27 2005
+++ linux/drivers/i2c/busses/Kconfig	Sun Jul 24 20:32:40 2005
@@ -107,6 +107,17 @@ config I2C_HYDRA
 	  This support is also available as a module.  If so, the module
 	  will be called i2c-hydra.
 
+config I2C_BIT_SA1100_GPIO
+	tristate "SA1100 I2C GPIO adapter"
+	depends on I2C && ARCH_SA1100
+	select BIT_SA1100_GPIO
+	help
+	  This supports I2C on the SA11x0 processor GPIO pins.  This
+	  shares support with the L3 driver.
+
+	  This support is also available as a module.  If so, the module
+	  will be called l3-bit-sa1100.
+
 config I2C_I801
 	tristate "Intel 82801 (ICH)"
 	depends on I2C && PCI
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/l3/Kconfig linux/drivers/l3/Kconfig
--- orig/drivers/l3/Kconfig	Thu Jan  1 01:00:00 1970
+++ linux/drivers/l3/Kconfig	Sat Jul  2 20:12:47 2005
@@ -0,0 +1,23 @@
+#
+# L3 bus configuration
+#
+
+menu "L3 serial bus support"
+
+config L3
+	tristate "L3 support"
+
+config L3_BIT_SA1100_GPIO
+	tristate "SA11x0 L3 GPIO adapter"
+	depends on L3 && ARCH_SA1100
+	select BIT_SA1100_GPIO
+
+config BIT_SA1100_GPIO
+	tristate
+	select L3_ALGOBIT if L3
+	select I2C_ALGOBIT if I2C
+
+config L3_ALGOBIT
+	bool
+
+endmenu
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/l3/Makefile linux/drivers/l3/Makefile
--- orig/drivers/l3/Makefile	Thu Jan  1 01:00:00 1970
+++ linux/drivers/l3/Makefile	Sat Jul  2 20:13:13 2005
@@ -0,0 +1,8 @@
+#
+# Makefile for the L3 bus driver.
+#
+
+obj-$(CONFIG_L3)		+= l3-core.o
+obj-$(CONFIG_L3_ALGOBIT)	+= l3-algo-bit.o
+obj-$(CONFIG_BIT_SA1100_GPIO)	+= l3-bit-sa11x0.o
+
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/l3/l3-algo-bit.c linux/drivers/l3/l3-algo-bit.c
--- orig/drivers/l3/l3-algo-bit.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/l3/l3-algo-bit.c	Sat Jul  2 17:31:58 2005
@@ -0,0 +1,174 @@
+/*
+ * L3 bus algorithm module.
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Note that L3 buses can share the same pins as I2C buses, so we must
+ *  _not_ generate an I2C start condition.  An I2C start condition is
+ *  defined as a high-to-low transition of the data line while the clock
+ *  is high.  Therefore, we must only change the data line while the
+ *  clock is low.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/l3.h>
+
+#include "l3-algo-bit.h"
+
+#define setdat(l3,algo,val)	algo->setdat(l3, val)
+#define setclk(l3,algo,val)	algo->setclk(l3, val)
+#define setmode(l3,algo,val)	algo->setmode(l3, val)
+#define setdatin(l3,algo)	algo->setdir(l3, 1)
+#define setdatout(l3,algo)	algo->setdir(l3, 0)
+#define getdat(l3,algo)		algo->getdat(l3)
+
+/*
+ * Send one byte of data to the chip.  Data is latched into the chip on
+ * the rising edge of the clock.
+ */
+static void sendbyte(struct l3_adapter *l3, struct l3_algo_bit_data *algo,
+		     unsigned int byte)
+{
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		setclk(l3, algo, 0);
+		udelay(algo->data_hold);
+		setdat(l3, algo, byte & 1);
+		udelay(algo->data_setup);
+		setclk(l3, algo, 1);
+		udelay(algo->clock_high);
+		byte >>= 1;
+	}
+}
+
+/*
+ * Send a set of bytes to the chip.  We need to pulse the MODE line
+ * between each byte, but never at the start nor at the end of the
+ * transfer.
+ */
+static void sendbytes(struct l3_adapter *l3, struct l3_algo_bit_data *algo,
+		      const u8 *buf, size_t len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (i) {
+			udelay(algo->mode_hold);
+			setmode(l3, algo, 0);
+			udelay(algo->mode);
+		}
+		setmode(l3, algo, 1);
+		udelay(algo->mode_setup);
+		sendbyte(l3, algo, buf[i]);
+	}
+}
+
+/*
+ * Read one byte of data from the chip.  Data is latched into the chip on
+ * the rising edge of the clock.
+ */
+static unsigned int readbyte(struct l3_adapter *l3,
+			     struct l3_algo_bit_data *algo)
+{
+	unsigned int byte = 0;
+	int i;
+
+	for (i = 0; i < 8; i++) {
+		setclk(l3, algo, 0);
+		udelay(algo->data_hold + algo->data_setup);
+		setclk(l3, algo, 1);
+		if (getdat(l3, algo))
+			byte |= 1 << i;
+		udelay(algo->clock_high);
+	}
+
+	return byte;
+}
+
+/*
+ * Read a set of bytes from the chip.  We need to pulse the MODE line
+ * between each byte, but never at the start nor at the end of the
+ * transfer.
+ */
+static void readbytes(struct l3_adapter *l3, struct l3_algo_bit_data *algo,
+		      u8 *buf, size_t len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (i) {
+			udelay(algo->mode_hold);
+			setmode(l3, algo, 0);
+		}
+		setmode(l3, algo, 1);
+		udelay(algo->mode_setup);
+		buf[i] = readbyte(l3, algo);
+	}
+}
+
+static void start(struct l3_adapter *l3, struct l3_algo_bit_data *algo,
+		  u8 addr)
+{
+	/*
+	 * If we share an I2C bus, ensure that it is in STOP mode
+	 */
+	setclk(l3, algo, 1);
+	setdat(l3, algo, 1);
+	setmode(l3, algo, 1);
+	setdatout(l3, algo);
+	udelay(algo->mode);
+
+	setmode(l3, algo, 0);
+	udelay(algo->mode_setup);
+	sendbyte(l3, algo, addr);
+	udelay(algo->mode_hold);
+}
+
+static void stop(struct l3_adapter *l3, struct l3_algo_bit_data *algo)
+{
+	/*
+	 * Ensure that we leave the bus in I2C stop mode.
+	 */
+	setclk(l3, algo, 1);
+	setdat(l3, algo, 1);
+	setmode(l3, algo, 0);
+	setdatin(l3, algo);
+}
+
+ssize_t l3_algo_bit_read(struct l3_adapter *l3, struct l3_algo_bit_data *algo,
+			 u8 addr, u8 *buf, size_t len)
+{
+	start(l3, algo, addr);
+
+	setdatin(l3, algo);
+	readbytes(l3, algo, buf, len);
+
+	stop(l3, algo);
+
+	return 0;
+}
+EXPORT_SYMBOL(l3_algo_bit_read);
+
+ssize_t l3_algo_bit_write(struct l3_adapter *l3, struct l3_algo_bit_data *algo,
+			  u8 addr, const u8 *buf, size_t len)
+{
+	start(l3, algo, addr);
+
+	setdatout(l3, algo);
+	sendbytes(l3, algo, buf, len);
+
+	stop(l3, algo);
+
+	return 0;
+}
+EXPORT_SYMBOL(l3_algo_bit_write);
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/l3/l3-algo-bit.h linux/drivers/l3/l3-algo-bit.h
--- orig/drivers/l3/l3-algo-bit.h	Thu Jan  1 01:00:00 1970
+++ linux/drivers/l3/l3-algo-bit.h	Sat Jul  2 15:49:41 2005
@@ -0,0 +1,37 @@
+/*
+ *  linux/include/linux/l3/algo-bit.h
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * L3 Bus bit-banging algorithm.  Derived from i2c-algo-bit.h by
+ * Simon G. Vogl.
+ */
+#ifndef L3_ALGO_BIT_H
+#define L3_ALGO_BIT_H 1
+
+#include <linux/l3.h>
+
+struct l3_algo_bit_data {
+	void (*setdat) (struct l3_adapter *, int state);
+	void (*setclk) (struct l3_adapter *, int state);
+	void (*setmode)(struct l3_adapter *, int state);
+	void (*setdir) (struct l3_adapter *, int in);	/* set data direction */
+	int  (*getdat) (struct l3_adapter *);
+
+	/* bus timings (us) */
+	int	data_hold;
+	int	data_setup;
+	int	clock_high;
+	int	mode_hold;
+	int	mode_setup;
+	int	mode;
+};
+
+ssize_t l3_algo_bit_read(struct l3_adapter *, struct l3_algo_bit_data *, u8 addr, u8 *buf, size_t len);
+ssize_t l3_algo_bit_write(struct l3_adapter *, struct l3_algo_bit_data *, u8 addr, const u8 *buf, size_t len);
+
+#endif
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/l3/l3-bit-sa11x0.c linux/drivers/l3/l3-bit-sa11x0.c
--- orig/drivers/l3/l3-bit-sa11x0.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/l3/l3-bit-sa11x0.c	Sat Jul  2 19:38:46 2005
@@ -0,0 +1,296 @@
+/*
+ *  linux/drivers/l3/l3-bit-sa1100.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  This is a combined I2C and L3 bus driver.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/system.h>
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/arch/assabet.h>
+
+#define NAME "l3-bit-sa1100-gpio"
+
+struct bit_data {
+	unsigned int	sda;
+	unsigned int	scl;
+	unsigned int	l3_mode;
+};
+
+static int getsda(void *data)
+{
+	struct bit_data *bits = data;
+
+	return GPLR & bits->sda;
+}
+
+#ifdef CONFIG_I2C_BIT_SA1100_GPIO
+static void i2c_setsda(void *data, int state)
+{
+	struct bit_data *bits = data;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (state)
+		GPDR &= ~bits->sda;
+	else {
+		GPCR = bits->sda;
+		GPDR |= bits->sda;
+	}
+	local_irq_restore(flags);
+}
+
+static void i2c_setscl(void *data, int state)
+{
+	struct bit_data *bits = data;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (state)
+		GPDR &= ~bits->scl;
+	else {
+		GPCR = bits->scl;
+		GPDR |= bits->scl;
+	}
+	local_irq_restore(flags);
+}
+
+static int i2c_getscl(void *data)
+{
+	struct bit_data *bits = data;
+
+	return GPLR & bits->scl;
+}
+
+static struct i2c_algo_bit_data i2c_bit_data = {
+	.setsda		= i2c_setsda,
+	.setscl		= i2c_setscl,
+	.getsda		= getsda,
+	.getscl		= i2c_getscl,
+	.udelay		= 10,
+	.mdelay		= 10,
+	.timeout	= 100,
+};
+
+static struct i2c_adapter i2c_adapter = {
+	.algo_data	= &i2c_bit_data,
+};
+
+#define LOCK	&i2c_adapter.bus_lock
+
+static int __init i2c_init(struct bit_data *bits)
+{
+	i2c_bit_data.data = bits;
+	return i2c_bit_add_bus(&i2c_adapter);
+}
+
+static void i2c_exit(void)
+{
+	i2c_bit_del_bus(&i2c_adapter);
+}
+
+#else
+static DECLARE_MUTEX(l3_lock);
+#define LOCK		&l3_lock
+#define i2c_init(bits)	(0)
+#define i2c_exit()	do { } while (0)
+#endif
+
+#ifdef CONFIG_L3_BIT_SA1100_GPIO
+
+#include "l3-algo-bit.h"
+
+/*
+ * iPAQs need the clock line driven hard high and low.
+ */
+static void l3_setscl(struct l3_adapter *adap, int state)
+{
+	struct bit_data *bits = adap->data;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (state)
+		GPSR = bits->scl;
+	else
+		GPCR = bits->scl;
+	GPDR |= bits->scl;
+	local_irq_restore(flags);
+}
+
+static void l3_setsda(struct l3_adapter *adap, int state)
+{
+	struct bit_data *bits = adap->data;
+
+	if (state)
+		GPSR = bits->sda;
+	else
+		GPCR = bits->sda;
+}
+
+static void l3_setdir(struct l3_adapter *adap, int in)
+{
+	struct bit_data *bits = adap->data;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	if (in)
+		GPDR &= ~bits->sda;
+	else
+		GPDR |= bits->sda;
+	local_irq_restore(flags);
+}
+
+static void l3_setmode(struct l3_adapter *adap, int state)
+{
+	struct bit_data *bits = adap->data;
+
+	if (state)
+		GPSR = bits->l3_mode;
+	else
+		GPCR = bits->l3_mode;
+}
+
+static int l3_getdat(struct l3_adapter *adap)
+{
+	struct bit_data *bits = adap->data;
+
+	return GPLR & bits->scl;
+}
+
+static struct l3_algo_bit_data l3_bit_data = {
+	.setdat		= l3_setsda,
+	.setclk		= l3_setscl,
+	.setmode	= l3_setmode,
+	.setdir		= l3_setdir,
+	.getdat		= l3_getdat,
+	.data_hold	= 1,
+	.data_setup	= 1,
+	.clock_high	= 1,
+	.mode_hold	= 1,
+	.mode_setup	= 1,
+};
+
+static int sa11x0_l3_read(struct l3_adapter *l3_adap, u8 addr, u8 *buf, size_t len)
+{
+	return l3_algo_bit_read(l3_adap, &l3_bit_data, addr, buf, len);
+}
+
+static int sa11x0_l3_write(struct l3_adapter *l3_adap, u8 addr, const u8 *buf, size_t len)
+{
+	return l3_algo_bit_write(l3_adap, &l3_bit_data, addr, buf, len);
+}
+
+static struct l3_adapter l3_adapter = {
+	.owner		= THIS_MODULE,
+	.name		= NAME,
+	.read		= sa11x0_l3_read,
+	.write		= sa11x0_l3_write,
+	.lock		= LOCK,
+};
+
+static int __init l3_init(struct bit_data *bits)
+{
+	l3_adapter.data = bits;
+	return l3_add_adapter(&l3_adapter);
+}
+
+static void __exit l3_exit(void)
+{
+	l3_del_adapter(&l3_adapter);
+}
+#else
+#define l3_init(bits)	(0)
+#define l3_exit()	do { } while (0)
+#endif
+
+static struct bit_data bit_data;
+
+static int __init bus_init(void)
+{
+	struct bit_data *bit = &bit_data;
+	unsigned long flags;
+	int ret;
+
+	if (machine_is_assabet() || machine_is_pangolin()) {
+		bit->sda     = GPIO_GPIO15;
+		bit->scl     = GPIO_GPIO18;
+		bit->l3_mode = GPIO_GPIO17;
+	}
+
+	if (machine_is_cerf()) {
+		bit->sda     = GPIO_GPIO6;
+		bit->scl     = GPIO_GPIO4;
+		bit->l3_mode = GPIO_GPIO5;
+	}
+
+	if (machine_is_h3600() || machine_is_h3100()) {
+		bit->sda     = GPIO_GPIO14;
+		bit->scl     = GPIO_GPIO16;
+		bit->l3_mode = GPIO_GPIO15;
+	}
+
+	if (machine_is_stork()) {
+		bit->sda     = GPIO_GPIO15;
+		bit->scl     = GPIO_GPIO18;
+		bit->l3_mode = GPIO_GPIO17;
+	}
+
+	if (!bit->sda)
+		return -ENODEV;
+
+	/*
+	 * Default level for L3 mode is low.
+	 * We set SCL and SDA high (i2c idle state).
+	 */
+	local_irq_save(flags);
+	GPDR &= ~(bit->scl | bit->sda);
+	GPCR = bit->l3_mode | bit->scl | bit->sda;
+	GPDR |= bit->l3_mode;
+	local_irq_restore(flags);
+
+	if (machine_is_assabet()) {
+		/*
+		 * Release reset on UCB1300, ADI7171 and UDA1341.  We
+		 * need to do this here so that we can communicate on
+		 * the I2C/L3 buses.
+		 */
+		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
+		mdelay(1);
+		ASSABET_BCR_clear(ASSABET_BCR_CODEC_RST);
+		mdelay(1);
+		ASSABET_BCR_set(ASSABET_BCR_CODEC_RST);
+	}
+
+	ret = i2c_init(bit);
+	if (ret == 0 && bit->l3_mode) {
+		ret = l3_init(bit);
+		if (ret)
+			i2c_exit();
+	}
+
+	return ret;
+}
+
+static void __exit bus_exit(void)
+{
+	l3_exit();
+	i2c_exit();
+}
+
+module_init(bus_init);
+module_exit(bus_exit);
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -x .git -N orig/drivers/l3/l3-core.c linux/drivers/l3/l3-core.c
--- orig/drivers/l3/l3-core.c	Thu Jan  1 01:00:00 1970
+++ linux/drivers/l3/l3-core.c	Sat Jul  2 15:49:24 2005
@@ -0,0 +1,170 @@
+/*
+ *  linux/drivers/l3/l3-core.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *
+ *  General structure taken from i2c-core.c by Simon G. Vogl
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ *  See linux/Documentation/l3 for further documentation.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/proc_fs.h>
+#include <linux/kmod.h>
+#include <linux/init.h>
+#include <linux/l3.h>
+
+static DECLARE_MUTEX(adapter_lock);
+static LIST_HEAD(adapter_list);
+
+/**
+ * l3_add_adapter - register a new L3 bus adapter
+ * @adap: l3_adapter structure for the registering adapter
+ *
+ * Make the adapter available for use by clients using name adap->name.
+ * The adap->adapters list is initialised by this function.
+ *
+ * Returns 0;
+ */
+int l3_add_adapter(struct l3_adapter *adap)
+{
+	down(&adapter_lock);
+	list_add(&adap->adapters, &adapter_list);
+	up(&adapter_lock);
+	return 0;	
+}
+
+/**
+ * l3_del_adapter - unregister a L3 bus adapter
+ * @adap: l3_adapter structure to unregister
+ *
+ * Remove an adapter from the list of available L3 Bus adapters.
+ *
+ * Returns 0;
+ */
+int l3_del_adapter(struct l3_adapter *adap)
+{
+	down(&adapter_lock);
+	list_del(&adap->adapters);
+	up(&adapter_lock);
+	return 0;
+}
+
+static struct l3_adapter *__l3_get_adapter(const char *name)
+{
+	struct list_head *l;
+
+	list_for_each(l, &adapter_list) {
+		struct l3_adapter *adap = list_entry(l, struct l3_adapter, adapters);
+
+		if (strcmp(adap->name, name) == 0)
+			return adap;
+	}
+
+	return NULL;
+}
+
+/**
+ * l3_get_adapter - get a reference to an adapter
+ * @name: driver name
+ *
+ * Obtain a l3_adapter structure for the specified adapter.  If the adapter
+ * is not currently load, then load it.  The adapter will be locked in core
+ * until all references are released via l3_put_adapter.
+ */
+struct l3_adapter *l3_get_adapter(const char *name)
+{
+	struct l3_adapter *adap;
+	int try;
+
+	for (try = 0; try < 2; try ++) {
+		down(&adapter_lock);
+		adap = __l3_get_adapter(name);
+		if (adap && !try_module_get(adap->owner))
+			adap = NULL;
+		up(&adapter_lock);
+
+		if (adap)
+			break;
+
+		if (try == 0)
+			request_module(name);
+	}
+
+	return adap;
+}
+
+/**
+ * l3_put_adapter - release a reference to an adapter
+ * @adap: driver to release reference
+ *
+ * Indicate to the L3 core that you no longer require the adapter reference.
+ * The adapter module may be unloaded when there are no references to its
+ * data structure.
+ *
+ * You must not use the reference after calling this function.
+ */
+void l3_put_adapter(struct l3_adapter *adap)
+{
+	if (adap && adap->owner)
+		module_put(adap->owner);
+}
+
+/**
+ * l3_write - send data to a device on an L3 bus
+ * @adap: L3 bus adapter
+ * @addr: L3 bus address
+ * @buf: buffer for bytes to send
+ * @len: number of bytes to send
+ *
+ * Send len bytes pointed to by buf to device address addr on the L3 bus
+ * described by client.
+ *
+ * Returns the number of bytes transferred, or negative error code.
+ */
+ssize_t l3_write(struct l3_adapter *adap, int addr, const u8 *buf, size_t len)
+{
+	ssize_t ret;
+
+	down(adap->lock);
+	ret = adap->write(adap, addr, buf, len);
+	up(adap->lock);
+
+	return ret;
+}
+
+/**
+ * l3_read - receive data from a device on an L3 bus
+ * @adap: L3 bus adapter
+ * @addr: L3 bus address
+ * @buf: buffer for bytes to receive
+ * @len: number of bytes to receive
+ *
+ * Receive len bytes from device address addr on the L3 bus described by
+ * client to a buffer pointed to by buf.
+ *
+ * Returns the number of bytes transferred, or negative error code.
+ */
+ssize_t l3_read(struct l3_adapter *adap, int addr, u8 *buf, size_t len)
+{
+	ssize_t ret;
+
+	down(adap->lock);
+	ret = adap->read(adap, addr, buf, len);
+	up(adap->lock);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(l3_add_adapter);
+EXPORT_SYMBOL(l3_del_adapter);
+EXPORT_SYMBOL(l3_get_adapter);
+EXPORT_SYMBOL(l3_put_adapter);
+EXPORT_SYMBOL(l3_write);
+EXPORT_SYMBOL(l3_read);
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej -x .git -N orig/include/linux/l3.h linux/include/linux/l3.h
--- orig/include/linux/l3.h	Sat Apr 26 08:56:46 1997
+++ linux/include/linux/l3.h	Sat Jul  2 15:46:10 2005
@@ -0,0 +1,73 @@
+/*
+ *  linux/include/linux/l3/l3.h
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * Derived from i2c.h by Simon G. Vogl
+ */
+#ifndef L3_H
+#define L3_H
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/list.h>
+
+struct l3_adapter;
+struct semaphore;
+
+/*
+ * l3_adapter is the structure used to identify a physical L3 bus along
+ * with the access algorithms necessary to access it.
+ */
+struct l3_adapter {
+	/*
+	 * This name is used to uniquely identify the adapter.
+	 * It should be the same as the module name.
+	 */
+	char			name[32];
+
+	/*
+	 * perform bus transactions
+	 */
+	ssize_t			(*read)(struct l3_adapter *, u8 addr, u8 *buf, size_t len);
+	ssize_t			(*write)(struct l3_adapter *, u8 addr, const u8 *buf, size_t len);
+
+	/*
+	 * This may be NULL, or should point to the module struct
+	 */
+	struct module		*owner;
+
+	/*
+	 * private data for the adapter
+	 */
+	void			*data;
+
+	/*
+	 * Our lock.  Unlike the i2c layer, we allow this to be used for
+	 * other stuff, like the i2c layer lock.  Some people implement
+	 * i2c stuff using the same signals as the l3 bus.
+	 */
+	struct semaphore	*lock;
+
+	/*
+	 * List of all adapters.
+	 */
+	struct list_head	adapters;
+};
+
+extern int l3_add_adapter(struct l3_adapter *);
+extern int l3_del_adapter(struct l3_adapter *);
+extern void l3_put_adapter(struct l3_adapter *);
+extern struct l3_adapter *l3_get_adapter(const char *name);
+
+extern ssize_t l3_write(struct l3_adapter *, int, const u8 *, size_t);
+extern ssize_t l3_read(struct l3_adapter *, int, u8 *, size_t);
+
+#endif
+
+#endif /* L3_H */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
