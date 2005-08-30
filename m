Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVH3Cm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVH3Cm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 22:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVH3Cm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 22:42:28 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:65497 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932091AbVH3Cm2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 22:42:28 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=Rypm5XlMGnFiI5PuVGya44GiC/0OKixQReWo9jmE7QpYJ2gAZL6pr4BfzAX/xlbaz
	/inAtdORUmuqJjhMPiDig==
Date: Mon, 29 Aug 2005 19:42:16 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: SPI redux ... driver model support
Cc: dpervushin@ru.mvista.com, basicmark@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050830024216.9AFEDC10BE@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last couple times SPI frameworks came up here, some of the feedback
included "make it use the driver model properly; don't be like I2C".

In hopes that it'll be useful, here's a small SPI core with driver model
support driven from board-specific tables listing devices.  I expect the
I/O call(s) could stand to change; but at least this one starts out right,
based on async I/O.  (There's a synchronous call; it's a trivial wrapper.)

 arch/arm/Kconfig       |    2 
 drivers/Kconfig        |    2 
 drivers/Makefile       |    1 
 drivers/spi/Kconfig    |  302 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/Makefile   |   32 ++++
 drivers/spi/spi_init.c |  233 ++++++++++++++++++++++++++++++++++
 include/linux/spi.h    |  179 ++++++++++++++++++++++++++
 7 files changed, 751 insertions(+)

Here's one instance of the sysfs "spi_host" class:

	[root@argon sys]# cd /sys/class
	[root@argon class]# ls
	i2c-adapter/   misc/          pcmcia_socket/ spi_host/      usb_host/
	input/         mtd/           scsi_device/   tty/           vc/
	mem/           net/           scsi_host/     usb/
	[root@argon class]# ls spi_host
	spi2/
	[root@argon class]# ls -l spi_host/spi2
	drwxr-xr-x    2 root     root            0 Aug 29 18:46 ./
	drwxr-xr-x    3 root     root            0 Dec 31  1969 ../
	lrwxrwxrwx    1 root     root            0 Aug 29 18:46 device -> ../../../devices/platform/omap-uwire/
	[root@argon class]#

Here are the real sysfs objects for that host and its single child
(on chipselect 0).  Notice that the device exists, but is waiting for
driver-modelized ads7846 support (touchscreen and other sensors):

	[root@argon class]# cd /sys/devices/platform/omap-uwire
	[root@argon omap-uwire]# ls
	bus@            driver@         power/          spi2.0-ads7846/
	[root@argon omap-uwire]# ls -l spi*
	lrwxrwxrwx    1 root     root            0 Aug 29 18:46 bus -> ../../../../bus/spi/
	-r--r--r--    1 root     root         4096 Aug 29 18:46 modalias
	drwxr-xr-x    2 root     root            0 Aug 29 18:46 power/
	[root@argon omap-uwire]# cat spi*/modalias
	ads7846
	[root@argon omap-uwire]#

For your viewing pleasure, and without the broadast flag that would
prevent further redistribution, a patch is appended.

- Dave


-----------------------------------------	SNIP!!
This is the start of a small SPI framework that started fresh, so it
doesn't continue the "i2c driver model mess".

  - It needs less than 1KB of codespace.  If we're stuck with a mid-layer
    for something so simple, that's the right size budget.  :)

  - The guts use board-specific SPI master configuration tables to build
    the driver model tree.  (Hardware probing is normally NOT an option.)

  - The Kconfig should be informative about the scope and content of SPI.
    Don't take that set of drivers seriously yet though!

  - Building real drivers into this framework likely means updating the
    I/O "async message" model to include protocol tweaking (like I2C), and
    maybe some RPC-ish calls (integer in/out, not bulk data; like SMBus).

  - No userspace API.  There are several implementations to compare.
    Implement them like any driver, then bind that driver to the device.

An SPI master controller will declare itself to the SPI framework, which
causes any child devices (from those tables) to be created immediately.
New "modalias" style hotplug is supported, for ultra-slim userspace tools.


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/include/linux/spi.h	2005-08-29 16:00:38.000000000 -0700
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) 2005 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __LINUX_SPI_H
+#define __LINUX_SPI_H
+
+/*
+ * PROTOTYPE ONLY !!!
+ *
+ * The focus is on driver model support ... enough for SPI mastering
+ * board setups to work.  The I/O model still needs attention.
+ */
+
+/*---------------------------------------------------------------------------*/
+
+/*
+ * INTERFACE between board init code and SPI infrastructure.
+ *
+ * No SPI driver ever sees these device tables, but it's what
+ * builds the SPI driver model tree.
+ */
+
+/* board-specific initialization provides a table of SPI devices */
+struct spi_board_info {
+	/* the device name and module name are coupled, like platform_bus.
+	 * platform_data has things like GPIOs and IRQ assignments.
+	 */
+	const char	*modalias;
+	void		*platform_data;
+
+	/* e.g. slower on noisy or low voltage boards */
+	u32		max_speed_hz;
+
+	/* bus numbering is board specific (except zero means no-bus),
+	 * and chip selects reflect how each controller is wired.
+	 */
+	u16		bus_num;
+	u16		chip_select;
+
+	/* ... may need more standard chip config data ... */
+};
+
+extern int
+spi_register_board_info(struct spi_board_info const *info, unsigned n);
+
+
+/*---------------------------------------------------------------------------*/
+
+/*
+ * INTERFACES between SPI master drivers and infrastructure
+ *
+ * There are two types of master (or slave) driver:  "controller" drivers
+ * usually work on platform devices and touch chip registers; "protocol"
+ * drivers work on an SPI device by asking its controller driver to
+ * transfer the relevant data.
+ *
+ * The "struct device_driver" for an SPI device uses "spi_bus_type" and
+ * will be bound to devices based on their names (much like platform_bus).
+ */
+extern struct bus_type spi_bus_type;
+
+struct spi_device {
+	struct device	dev;
+	struct spi_host	*host;
+	u32		max_speed_hz;
+	u16		chip_select;
+	u8		mode;
+/* low two bits == mode 0/3/... */
+#define	SPI_MODE_READ_FALLING_EDGE	0x00
+#define	SPI_MODE_READ_RISING_EDGE	0x01
+#define	SPI_MODE_WRITE_FALLING_EDGE	0x00
+#define	SPI_MODE_WRITE_RISING_EDGE	0x02
+/* (REVISIT:  check all that!!) */
+};
+
+static inline struct spi_device *to_spi_device(struct device *dev)
+{
+	return container_of(dev, struct spi_device, dev);
+}
+
+
+struct spi_message;
+
+struct spi_host {
+	struct class_device	dev;
+	u16			bus_num;
+
+	/* setup mode and clock, etc */
+	int			(*setup)(struct spi_device *dev);
+
+	/* bidirectional bit transfers
+	 * the optional i/o queue arbitrates hardware access when multiple
+	 * protocol drivers and chipselects are concurrently active.
+	 */
+	int			(*transfer)(struct spi_device *dev,
+						struct spi_message *mesg);
+	struct list_head	queue;
+};
+
+extern int spi_register_host(struct device *host, struct spi_host *spi);
+
+
+/*---------------------------------------------------------------------------*/
+
+/*
+ * I/O INTERFACE between SPI controller and device drivers
+ *
+ * Basically think of a queue of spi_messages, each of which will
+ * transfer data in both directions but to different addresses.
+ * SPI protocol drivers just provide spi_messages.
+ */
+
+struct spi_transfer {
+	/* it's ok if tx_buf == rx_buf
+	 * in SPI, number of bits out == number of bits in
+	 * for MicroWire, one buffer must be null
+	 * buffers must work with dma_*map_single() calls
+	 */
+	u8		*tx_buf, *rx_buf;
+	unsigned	len;
+};
+
+struct spi_message {
+	struct spi_transfer	*transfers;
+	unsigned		n_transfer;
+
+	unsigned		flags;
+#define	SPI_XFER_CS_ON		0x0000	/* CS stays on after this */
+#define	SPI_XFER_CS_OFF		0x0001	/* CS turned off after this */
+
+	/* REVISIT:  Devices may be doing things like 12 bit transfers;
+	 * for now, assume those will be left aligned in 16 bit values.
+	 * wordsize may matter here too.
+	 */
+
+	/* completion is reported this way */
+	// REVISIT make this FASTCALL so we can easily
+	// use complete() from <linux/completion.h>
+	void 			(*complete)(void *context);
+	void			*context;
+	int			status;
+
+	/* controller driver state */
+	struct list_head	queue;
+};
+
+/* before passing messages, setup the SPI mode and clock rate */
+static inline int
+spi_setup(struct spi_device *dev)
+{
+	return dev->host->setup(dev);
+}
+
+/* synchronous SPI transfers; this may sleep */
+extern int spi_sync(struct spi_device *dev, struct spi_message *message);
+
+/* async SPI transfer, can be used in_irq */
+static inline int
+spi_async(struct spi_device *dev, struct spi_message *message)
+{
+	return dev->host->transfer(dev, message);
+}
+
+#endif /* __LINUX_SPI_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/spi/spi_init.c	2005-08-29 16:00:38.000000000 -0700
@@ -0,0 +1,233 @@
+/* spi-init.c -- prototype of SPI init/core code
+ *
+ * Copyright (C) 2005 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/autoconf.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/spi.h>
+
+
+static struct spi_board_info const *board_info;
+static unsigned n_board_info;
+
+/*
+ * Board init code calls this -- probably during arch_initcall -- to define
+ * the SPI devices found on this board.  The device nodes are created later,
+ * after the relevant parent SPI controller (bus_num) is defined.  We keep
+ * this table of devices forever, so that reloading a controller driver will
+ * not forget about these devices.
+ *
+ * REVISIT this version just records this data, with no copying ... but it's
+ * common to build systems by stacking boards, with SPI being one of the
+ * interfaces on the connector.  For example, i2c eeproms could identify
+ * each board, letting other code infer what spi devices it adds.  That
+ * means we might need to make this call several times...
+ *
+ * We may also want to add a usermode API for this ... it's probably easier
+ * to handle some of those multi-board situations from there.
+ */
+int __init
+spi_register_board_info(struct spi_board_info const *info, unsigned n)
+{
+	if (board_info)
+		return -EBUSY;
+	board_info = info;
+	n_board_info = n;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_register_board_info);
+
+
+/*-------------------------------------------------------------------------*/
+
+/*
+ * Here's how registering an SPI host goes:
+ *   - SPI bustype and spi_host class are registered early
+ *   - SPI controller and driver probably live on the platform_bus
+ *   - controller driver allocates an spi_host
+ *   - end of controller driver's probe() calls spi_register_host()
+ *	+ creates the class device for that SPI controller
+ *	+ creates any pre-declared devices
+ *   - driver model handles hotplug/modalias and probing, as usual
+ *
+ * That way SPI controller and device drivers can be modules, and all
+ * driver model devices are provided without hardware probing.
+ */
+
+static struct class spi_host_class = {
+	.name	= "spi_host",
+	.owner	= THIS_MODULE,
+};
+
+static void spidev_release(struct device *dev)
+{
+	kfree(container_of(dev, struct spi_device, dev));
+}
+
+int spi_register_host(struct device *host, struct spi_host *spi)
+{
+	int		status, i;
+
+	if (!n_board_info) {
+		dev_dbg(host, "spi board info is missing\n");
+		return -EINVAL;
+	}
+	if (spi->bus_num == 0) {
+		dev_dbg(host, "spi bus number not assigned\n");
+		return -EINVAL;
+	}
+
+	spi->dev.class = &spi_host_class;
+	spi->dev.dev = host;
+	snprintf(spi->dev.class_id, sizeof spi->dev.class_id,
+		"spi%d", spi->bus_num);
+
+	status = class_device_register(&spi->dev);
+	if (status < 0)
+		return status;
+	dev_dbg(host, "master %s\n", spi->dev.class_id);
+
+	for (i = 0; i < n_board_info; i++) {
+		struct spi_board_info const	*chip;
+		struct spi_device		*dev;
+
+		chip = &board_info[i];
+		if (chip->bus_num != spi->bus_num)
+			continue;
+
+		dev = kcalloc(1, sizeof *dev, GFP_KERNEL);
+		if (!dev) {
+			dev_err(host, "can't alloc dev for cs%d\n",
+				chip->chip_select);
+			continue;
+		}
+		dev->host = spi;
+		dev->chip_select = chip->chip_select;
+		dev->max_speed_hz = chip->max_speed_hz;
+
+		snprintf(dev->dev.bus_id, sizeof dev->dev.bus_id,
+				"spi%u.%u-%s",
+				chip->bus_num, chip->chip_select,
+				chip->modalias);
+		dev->dev.parent = host;
+		dev->dev.bus = &spi_bus_type;
+		dev->dev.platform_data = chip->platform_data;
+		dev->dev.release = spidev_release;
+
+		/* drivers may modify this default i/o setup */
+		status = spi->setup(dev);
+		if (status < 0) {
+			dev_err(host, "can't setup %s, status %d\n",
+					dev->dev.bus_id, status);
+			goto trynext;
+		}
+
+		status = device_register(&dev->dev);
+		if (status < 0) {
+			dev_err(host, "can't add %s, status %d\n",
+					dev->dev.bus_id, status);
+trynext:
+			kfree(dev);
+			continue;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_register_host);
+
+
+/* FIXME add spi_unregister_host() */
+
+
+/*-------------------------------------------------------------------------*/
+
+/* NOTE SIMPLIFICATION:  no "cancel message" operation */
+
+static void spi_sync_complete(void *done)
+{
+	complete(done);
+}
+
+int spi_sync(struct spi_device *dev, struct spi_message *message)
+{
+	DECLARE_COMPLETION(done);
+	int status;
+
+	message->complete = spi_sync_complete;
+	message->context = &done;
+	status = spi_async(dev, message);
+	if (status == 0) {
+		wait_for_completion(&done);
+		status = message->status;
+	}
+	message->context = NULL;
+	return status;
+}
+
+/*-------------------------------------------------------------------------*/
+
+static ssize_t
+modalias_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	const char *modalias = strchr(dev->bus_id, '-') + 1;
+	return snprintf(buf, BUS_ID_SIZE + 1, "%s\n", modalias);
+}
+
+static struct device_attribute spi_dev_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
+static int spi_match_device(struct device *dev, struct device_driver *drv)
+{
+	const char *modalias = strchr(dev->bus_id, '-') + 1;
+
+	return strncmp(modalias, drv->name, BUS_ID_SIZE) == 0;
+}
+
+static int spi_hotplug(struct device *dev, char **envp, int num_envp,
+		char *buffer, int buffer_size)
+{
+	const char *modalias = strchr(dev->bus_id, '-') + 1;
+
+	envp[0] = buffer;
+	snprintf(buffer, buffer_size, "MODALIAS=%s", modalias);
+	envp[1] = NULL;
+	return 0;
+}
+
+struct bus_type spi_bus_type = {
+	.name		= "spi",
+	.match		= spi_match_device,
+	.hotplug	= spi_hotplug,
+	.dev_attrs	= spi_dev_attrs,
+};
+EXPORT_SYMBOL_GPL(spi_bus_type);
+
+
+static int __init spi_init(void)
+{
+	bus_register(&spi_bus_type);
+	class_register(&spi_host_class);
+	return 0;
+}
+postcore_initcall(spi_init);
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/spi/Kconfig	2005-08-29 16:02:13.000000000 -0700
@@ -0,0 +1,302 @@
+#
+# This is what Linux SPI might look support after adding drivers for
+# some embedded SPI-capable hardware that's used with Linux.
+#
+# NOTE: over half of the SPI protocol masters mentioned actually exist,
+# and sometimes even on 2.6.  Few of the SPI master controller drivers
+# exist.  None of those drivers use the 2.6 driver model, and they all
+# have different I/O models too.
+#
+
+#
+# SPI device configuration
+#
+menu "Serial Peripheral Interface (SPI)"
+
+config SPI
+	bool "SPI support"
+	depends on SPI_ARCH_HAS_MASTER || SPI_ARCH_HAS_SLAVE
+	help
+	  The "Serial Peripheral Interface" is a low level synchronous
+	  protocol used to talk with sensors, eeprom and flash memory,
+	  codecs and various other controller chips, analog to digital
+	  (and d-to-a) converters, and more.  MMC and SD cards can be
+	  accessed using SPI protocol; and for DataFlash cards used in
+	  MMC sockets, SPI must be used.
+
+	  Chips and controllers that support SPI can have data transfer
+	  rates up to several tens of Mbit/sec, and often support DMA.
+	  Chips are addressed with a controller and (usually) a chipselect.
+	  Most SPI devices don't support dynamic device discovery; some
+	  are even write-only or read-only.
+
+	  SPI is one of a family of similar protocols using a four wire
+	  interface (select, clock, data in, data out) including Microwire
+	  (half duplex), SSP, and PSP.  This driver framework should work
+	  with most of them.
+
+config SPI_DEBUG
+	boolean "Debug messaging for SPI drivers"
+	depends on SPI && DEBUG_KERNEL
+	help
+	  Say "yes" to enable debug messaging (like dev_dbg and pr_debug)
+	  from SPI bus and device drivers.
+
+# someday this stuff should be set using arch/CPU/PLATFORM/Kconfig
+config SPI_ARCH_HAS_MASTER
+	boolean
+	default y if ARCH_OMAP
+	default y if ARCH_PXA
+	default y if ARCH_AT91
+	default y if X86		# DEVEL HACK
+
+config SPI_ARCH_HAS_SLAVE
+	boolean
+	default y if ARCH_OMAP
+	default y if ARCH_PXA
+	default y if ARCH_AT91
+	default y if X86		# DEVEL HACK
+
+#
+# MASTER
+#
+comment "No SPI master hardware is available."
+	depends on SPI && !SPI_ARCH_HAS_MASTER
+
+menuconfig SPI_MASTER
+	boolean "SPI Master support"
+	depends on SPI && SPI_ARCH_HAS_SLAVE
+
+if SPI_MASTER
+
+comment "SPI Master Controller Drivers"
+
+# Atmel AT91rm9200 (and some other AT91 family chips)
+config SPI_AT91
+	tristate "AT91 as SPI master"
+	depends on ARCH_AT91
+	help
+	  This implements SPI master mode using an SPI controller.
+
+# FIXME  bitbangers need arch-specific ways to access the
+# right GPIO pins, probably using platform data and maybe
+# using platform-specific minidrivers.
+config SPI_BITBANG
+	tristate "Bitbanging SPI master"
+	help
+	  You can implement SPI using GPIO pins, as this driver
+	  eventually should do.
+
+# Motorola Coldfire (m68k)
+config SPI_COLDFIRE
+	tristate "Coldfire QSPI as SPI master"
+	depends on COLDFIRE
+	help
+	  This implements SPI master mode using the QSPI controller.
+
+# Motorola MPC (PPC)
+config SPI_MPC
+	tristate "MPC SPI master"
+	depends on PPC && MPC
+	help
+	  This implements SPI master mode using the MPC SPI controller.
+
+# TI OMAP (ARM)
+config SPI_OMAP
+	tristate "OMAP SPI controller as master"
+	depends on ARCH_OMAP
+	help
+	  This implements SPI master mode using the dedicated SPI
+	  controller.
+
+config SPI_OMAP_MCBSP
+	tristate "OMAP MCBSP as SPI master"
+	depends on ARCH_OMAP
+	help
+	  This implements master mode SPI using a McBSP controller.
+
+config SPI_OMAP_UWIRE
+	tristate "OMAP MicroWire as SPI master"
+	depends on ARCH_OMAP
+	select OMAP_UWIRE
+	help
+	  This implements master mode SPI using the MicroWire controller.
+
+config SPI_OMAP_MMC
+	tristate "OMAP MMC as SPI master"
+	depends on ARCH_OMAP
+	help
+	  This implements master mode SPI using an MMC controller.
+
+
+# Intel PXA (ARM)
+config SPI_PXA_SSP
+	tristate "PXA SSP controller as SPI master"
+	depends on ARCH_PXA
+	help
+	  This implements SPI master mode using an SSP controller.
+
+config SPI_PXA_NSSP
+	tristate "PXA NSSP (or ASSP) controller as SPI master"
+	depends on ARCH_PXA
+	help
+	  This implements SPI master mode using the NSSP controller, which
+	  is available with PXA 255 and PXA 26x processors.
+
+config SPI_PXA_MMC
+	tristate "PXA MMC as SPI master"
+	depends on ARCH_PXA
+	help
+	  This implements master mode SPI using an MMC controller.
+
+
+#
+# Add new SPI master controllers in alphabetical order above this line
+#
+
+
+#
+# There are lots of SPI device types, with sensors and memory
+# being probably the most widely used ones.
+#
+comment "SPI Protocol Masters"
+
+config SPI_ADS7864
+	tristate "ADS 7864 touchscreen and sensors"
+	help
+	  This chip has touchscreen, voltage, and temperature sensors.
+	  The driver packages the touchscreen as an input device,
+	  and publishes the sensor values in sysfs.
+
+config SPI_DATAFLASH
+	tristate "DataFlash -- MTD support"
+	depends on MTD
+	help
+	  This driver provides an MTD interface to Atmel's DataFlash.
+	  It probes the device to see what size chip is present.
+	  Some MCUs can boot directly from DataFlash.
+
+config SPI_EEPROM
+	tristate "EEPROM -- sysfs support"
+	depends on SYSFS
+	help
+	  This provides a read/write "eeprom" file in sysfs for the
+	  specified device.  Platform data identifies the EEPROM type.
+
+config SPI_ETHERNET
+	tristate "Ethernet Master"
+	depends on NET
+	help
+	  Uses SPI to exchange Ethernet packets with some SPI
+	  protocol slave.  No Ethernet adapter hardware is used.
+
+config SPI_FLASH
+	tristate "FLASH -- MTD support"
+	depends on MTD
+	help
+	  This provides an MTD interface to SPI flash chips like the
+	  AT25 or M25 series.  Platform data identifies the FLASH type.
+
+config SPI_M41T94
+	tristate "M41T94 RTC/WDT support"
+	help
+	  This supports the ST M41T94 chips, providing the conventional
+	  miscdev files for the real-time clock and watchdog timer.
+
+config SPI_MCP320x
+	tristate "MPC 320x ADC support"
+	help
+	  These are multi-channel 12-bit A/D converters with sample-and-hold.
+
+config SPI_TC77
+	tristate "TC77 temperature sensor"
+	depends on SENSORS
+	help
+	  This is a 12-bit (plus sign) temperature sensor.
+
+config SPI_TSC2101
+	tristate "TSC 2101 touchscreen, sensors, and audio"
+	help
+	  This chip has touchscreen, voltage, and temperature sensors
+	  along with audio i/O for microphone, headphone, and speaker.
+	  The driver packages the touchscreen as an input device,
+	  publishes the sensor values in sysfs, and packages the audio
+	  through the ALSA driver stack.
+
+# USB:  n9604_udc, cy7c67200_hcd, ...
+
+#
+# Add new SPI protocol masters in alphabetical order above this line
+#
+
+endif # "SPI Master Implementations"
+
+
+#
+# SLAVE
+#
+comment "No SPI slave hardware is available."
+	depends on SPI && !SPI_ARCH_HAS_SLAVE
+
+menuconfig SPI_SLAVE
+	boolean "SPI Slave support"
+	depends on SPI && SPI_ARCH_HAS_SLAVE
+
+if SPI_SLAVE
+
+comment "SPI Slave Controller Drivers"
+
+config SPI_AT91_SLAVE
+	tristate "AT91 as SPI slave"
+	depends on ARCH_AT91
+	help
+	  This implements SPI slave mode using an SPI controller.
+
+config SPI_OMAP_SLAVE
+	tristate "OMAP SPI controller as slave"
+	depends on ARCH_OMAP
+	help
+	  This implements SPI slave mode using the dedicated SPI
+	  controller.
+
+config SPI_OMAP_MCBSP_SLAVE
+	tristate "OMAP MCBSP as SPI slave"
+	depends on ARCH_OMAP
+	help
+	  This implements slave mode SPI using a McBSP controller.
+
+config SPI_PXA_SSP_SLAVE
+	tristate "PXA SSP controller as SPI slave"
+	depends on ARCH_PXA
+	help
+	  This implements SPI slave mode using an SSP controller.
+
+config SPI_PXA_NSSP_SLAVE
+	tristate "PXA NSSP (or ASSP) controller as SPI slave"
+	depends on ARCH_PXA
+	help
+	  This implements SPI slave mode using the NSSP controller, which
+	  is available with PXA 255 and PXA 26x processors.
+
+#
+# Add new SPI slave controllers in alphabetical order above this line
+#
+
+
+comment "SPI Protocol Slaves"
+
+config SPI_ETHERNET_SLAVE
+	tristate "Ethernet Slave"
+	depends on NET
+	help
+	  Uses SPI to exchange Ethernet packets with some SPI
+	  protocol master.
+
+#
+# Add new SPI protocol slaves in alphabetical order above this line
+#
+
+endif # "SPI Slave Implementations"
+
+endmenu # "SPI support"
+
--- g26.orig/drivers/Kconfig	2005-08-27 01:55:10.000000000 -0700
+++ g26/drivers/Kconfig	2005-08-29 16:00:38.000000000 -0700
@@ -58,6 +58,8 @@ source "drivers/usb/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/infiniband/Kconfig"
 
 source "drivers/sn/Kconfig"
--- g26.orig/arch/arm/Kconfig	2005-08-23 23:48:00.000000000 -0700
+++ g26/arch/arm/Kconfig	2005-08-29 16:05:50.000000000 -0700
@@ -762,6 +762,8 @@ source "drivers/usb/Kconfig"
 
 source "drivers/mmc/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 endmenu
 
 source "fs/Kconfig"
--- g26.orig/drivers/Makefile	2005-08-29 15:51:01.000000000 -0700
+++ g26/drivers/Makefile	2005-08-29 16:00:38.000000000 -0700
@@ -61,6 +61,7 @@ obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
+obj-$(CONFIG_SPI)		+= spi/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/spi/Makefile	2005-08-29 16:00:38.000000000 -0700
@@ -0,0 +1,32 @@
+#
+# Makefile for kernel SPI drivers.
+#
+
+ifeq ($(CONFIG_SPI_DEBUG),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
+# small core, mostly translating board-specific
+# config declarations into driver model code
+obj-$(CONFIG_SPI_MASTER)		+= spi_init.o
+
+
+# SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
+#obj-$(CONFIG_SPI_OMAP)			+= omap_spi.o
+#obj-$(CONFIG_SPI_OMAP_MMC)		+= omap_spi_mmc.o
+#obj-$(CONFIG_SPI_PXA_SSP)		+= pxa_ssp.o
+#obj-$(CONFIG_SPI_PXA_MMC)		+= pxa_spi_mmc.o
+
+# SPI protocol drivers (device/link on bus)
+# obj-$(CONFIG_SPI_DATAFLASH)		+= dataflash.o
+# obj-$(CONFIG_SPI_EEPROM)		+= at25c.o
+# obj-$(CONFIG_SPI_ETHERNET)		+= spi_ether.o
+
+
+# SPI slave controller drivers (upstream link)
+obj-$(CONFIG_SPI_OMAP_SLAVE)		+= omap_spi_slave.o
+obj-$(CONFIG_SPI_PXA_SSP_SLAVE)		+= pxa_ssp_slave.o
+
+# SPI slave drivers (protocol for that link)
+# obj-$(CONFIG_SPI_ETHERNET_SLAVE)	+= spi_ether_slave.o
