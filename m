Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031025AbVIJAKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031025AbVIJAKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 20:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031026AbVIJAKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 20:10:04 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:17073 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1031025AbVIJAKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 20:10:01 -0400
X-ORBL: [69.107.75.50]
Date: Fri, 09 Sep 2005 17:09:52 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: SPI redux ... [refresh 1/2]
Cc: dpervushin@ru.mvista.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050910000952.34036E9DF5@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is what my SPI core tries to do. I would like to
> > make at 'as small as possible and no smaller'
>
> I'll post a refresh of my patch that seems to me to be
> a much better match for those goals.  The refresh includes
> some tweaks based on what you sent, but it's still just
> one KByte of overhead in the target ROM.  :)

OK, here's the first part of the refresh ... updated core code.
You can use it with the patch that'll follow next, holding some
example code.

Unfortunately, adding the attributes and such made the code
take just a bit more ".text" space; it's a couple hundred bytes
over that 1KB line.

- Dave

--------------------------------	SNIP!

This is the start of a small SPI framework that started fresh, so that
doesn't perpetuate the "i2c driver model mess".

  - It needs a bit over 1KB of ".text" (ARM).  If there's got to be a
    mid-layer for something so simple, that's the right size budget.  :)

  - The guts use board-specific SPI device tables to build the driver
    model tree.  (Hardware probing is rarely an option.)

  - The Kconfig should be informative about the scope and content of SPI.

  - Building more drivers into this framework likely means updating the
    I/O "async message" model to include protocol tweaking (like I2C).

  - No userspace API.  There are several implementations to compare.
    Implement them like any other driver; no magic hooks!

Updates since the last version include much cleanup, some internal docs,
sysfs attributes for the device clock rate and SPI transfer mode, and a
new library routine to simplify common "read sensor value" type operations.

This should suffice for writing (or adapting) real driver code.


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/include/linux/spi.h	2005-09-09 16:53:47.438773671 -0700
@@ -0,0 +1,245 @@
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
+ * PROTOTYPE !!!
+ *
+ * The focus is on driver model support ... enough for SPI mastering
+ * board setups to work.  The I/O model still needs attention, since
+ * SPI protocols seem to need to tweaking.
+ */
+
+/*---------------------------------------------------------------------------*/
+
+/*
+ * INTERFACES between SPI master drivers and infrastructure
+ *
+ * There are two types of master (or slave) driver:  "controller" drivers
+ * usually work on platform devices and touch chip registers; "protocol"
+ * drivers work on abstract SPI devices by asking a controller driver to
+ * transfer the relevant data, and they shouldn't much care if they use
+ * one controller or another.
+ *
+ * A "struct device_driver" for an SPI device uses "spi_bus_type" and needs
+ * no special API wrappers (much like platform_bus).  These drivers are
+ * bound to devices based on their names (much like platform_bus), and
+ * are available in dev->driver.
+ */
+extern struct bus_type spi_bus_type;
+
+struct spi_device {	/* this proxies the device through a master */
+	struct device		dev;
+	struct spi_master	*master;
+	u32			max_speed_hz;
+	u8			chip_select;
+	u8			mode;
+#define	SPI_CPHA	0x01		/* clock phase */
+#define	SPI_CPOL	0x02		/* clock polarity */
+#define	SPI_MODE_0	(0|0)
+#define	SPI_MODE_1	(0|SPI_CPHA)
+#define	SPI_MODE_2	(SPI_CPOL|0)
+#define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
+
+	// MAYBE ADD:
+	//  - chipselect polarity (default active low)
+	//  - spi wordsize (default 8 bits unsigned)
+	//  - bit order (default is wordwise msb-first)
+	//  - memory packing (default: 12 bit samples into 16 bits, msb)
+	//  - priority
+	//  - delays
+	//  - ...
+
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
+struct spi_master {
+	struct class_device	cdev;
+	u16			bus_num;
+	u16			num_chipselect;
+
+	/* setup mode and clock, etc */
+	int			(*setup)(struct spi_device *spi);
+
+	/* bidirectional bulk transfers
+	 * + transfer() may not sleep
+	 * + to a given spi_device, message queueing is pure fifo
+	 * + if there are multiple spi_device children, the i/o queue
+	 *   arbitration algorithm is unspecified (round robin, fifo,
+	 *   priority, reservations, preemption, etc)
+	 * + the master's main job is to process its message queue,
+	 *   selecting a chip then transferring data
+	 * + for now there's no remove-from-queue operation, or
+	 *   any other request management
+	 */
+	int			(*transfer)(struct spi_device *spi,
+						struct spi_message *mesg);
+
+	// we may want to fastpath common operations, like maybe
+	//	int (*write8_read16)(struct spi_device spi, u8 command);
+	// would give quick synchronous access when the queue is empty.
+};
+
+/* the controller driver manages memory for the spi_master classdev,
+ * normally contained inside its associated private state.
+ */
+extern int spi_register_master(struct device *host, struct spi_master *spi);
+extern void spi_unregister_master(struct spi_master *spi);
+
+
+/*---------------------------------------------------------------------------*/
+
+/*
+ * I/O INTERFACE between SPI controller and protocol drivers
+ *
+ * The interface is a queue of spi_messages, each transferring data
+ * between the controller and memory buffers.  SPI protocol drivers just
+ * provide spi_messages to hardware controller drivers.  SPI controller
+ * drivers process that queue, issuing completion callbacks as appropriate.
+ *
+ * The spi_messages themselves consist of a series of read+write transfer
+ * segments.  Those segments always read the same number of bits as they
+ * write; but one or the other is easily ignored by passing a null buffer
+ * pointer.  (This is unlike most types of I/O API, because SPI hardware
+ * is full duplex.)
+ *
+ * NOTE:  Allocation of spi_transfer and spi_message memory is entirely
+ * up to the protocol driver, which guarantees the integrity of both (as
+ * well as the data buffers) for as long as the message is queued.
+ */
+
+struct spi_transfer {
+	/* it's ok if tx_buf == rx_buf (right?)
+	 * for MicroWire, one buffer must be null
+	 * buffers must work with dma_*map_single() calls
+	 */
+	void		*tx_buf, *rx_buf;
+	unsigned	len;
+};
+
+/* spi messages will often be stack-allocated */
+struct spi_message {
+	struct spi_transfer	*transfers;
+	unsigned		n_transfer;
+
+	struct spi_device	*dev;
+
+	/* Optionally leave this chipselect active afterward */
+	unsigned		csrel_disable:1;
+
+	/* completion is reported this way */
+	void 			(*complete)(void *context);
+	void			*context;
+	unsigned		actual_length;
+	int			status;
+
+	/* for optional controller driver state */
+	struct list_head	queue;
+	void			*state;
+};
+
+/**
+ * spi_setup -- setup SPI mode and clock rate
+ * @spi: the device whose settings are being modified
+ *
+ * SPI protocol drivers may need to update the transfer mode if the
+ * device doesn't work with the mode 0 default.  They may likewise need
+ * to update clock rates.  This function changes those settings,
+ * and must be called from a context that can sleep.
+ */
+static inline int
+spi_setup(struct spi_device *spi)
+{
+	return spi->master->setup(spi);
+}
+
+
+/* synchronous SPI transfers; these may sleep uninterruptibly */
+extern int spi_sync(struct spi_device *spi, struct spi_message *message);
+extern int spi_w8r16(struct spi_device *spi, u8 cmd);
+
+
+/**
+ * spi_async -- asynchronous SPI transfer
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers, including completion callback
+ *
+ * This call may be used in_irq in other contexts which can't sleep,
+ * as well as from task contexts which can sleep.
+ *
+ * The completion callback is invoked in a context which can't sleep.
+ * Before that invocation, the value of message->status is undefined.
+ * When the callback is issue, message->status holds either zero (to
+ * indicate complete success) or a negative error code.
+ */
+static inline int
+spi_async(struct spi_device *spi, struct spi_message *message)
+{
+	message->dev = spi;
+	return spi->master->transfer(spi, message);
+}
+
+/*---------------------------------------------------------------------------*/
+
+/*
+ * INTERFACE between board init code and SPI infrastructure.
+ *
+ * No SPI driver ever sees these SPI device table segments, but
+ * it's how the SPI core builds its part of the driver model tree.
+ */
+
+/* board-specific initialization provides a table of SPI devices */
+struct spi_board_info {
+	/* the device name and module name are coupled, like platform_bus.
+	 * platform_data has things like IRQ assignments (just pass the int
+	 * that goes to request_irq), related GPIOs, and so on.
+	 */
+	char	modalias[KOBJ_NAME_LEN];
+	void	*platform_data;
+
+	/* slower signaling on noisy or low voltage boards */
+	u32		max_speed_hz;
+
+	/* bus numbering is board specific (except zero means no-bus),
+	 * and chip selects reflect how each controller is wired.
+	 */
+	u16	bus_num;
+	u16	chip_select;
+
+	/* ... may need additional spi_device chip config data here.
+	 * avoid stuff protocol drivers can set; but include stuff
+	 * needed to behave without being bound to a driver:
+	 *  - chipselect polarity
+	 *  - quirks like clock rate mattering when not selected
+	 */
+};
+
+extern int
+spi_register_board_info(struct spi_board_info const *info, unsigned n);
+
+
+#endif /* __LINUX_SPI_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/drivers/spi/spi.c	2005-09-09 16:53:47.439773481 -0700
@@ -0,0 +1,403 @@
+/* spi.c -- prototype of SPI init/core code
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
+/* SPI bustype and spi_master class are registered during early boot,
+ * usually after board init code provided the SPI device tables, and
+ * are available when driver init code needs them.
+ *
+ * Drivers for SPI devices are like those for platform bus devices:
+ *  (a)	no bus-specific API wrappers (== needless bloat here)
+ *  (b) matched to devices using device names
+ *  (c) should support "native" suspend and resume methods
+ */
+static void spidev_release(struct device *dev)
+{
+	const struct spi_device	*spi = to_spi_device(dev);
+
+	class_device_put(&spi->master->cdev);
+	kfree(dev);
+}
+
+// no, we probably don't need to list speed and mode in sysfs...
+
+static ssize_t
+maxspeed_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	const struct spi_device	*spi = to_spi_device(dev);
+
+	return sprintf(buf, "%u\n", spi->max_speed_hz);
+}
+
+static ssize_t
+modalias_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	const char *modalias = strchr(dev->bus_id, '-') + 1;
+
+	return snprintf(buf, BUS_ID_SIZE + 1, "%s\n", modalias);
+}
+
+static ssize_t
+mode_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	struct spi_device	*spi = to_spi_device(dev);
+
+	return sprintf(buf, "%u\n", spi->mode);
+}
+
+static struct device_attribute spi_dev_attrs[] = {
+	__ATTR_RO(maxspeed),
+	__ATTR_RO(modalias),
+	__ATTR_RO(mode),
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
+static struct class spi_master_class = {
+	.name	= "spi_master",
+	.owner	= THIS_MODULE,
+};
+
+
+/*-------------------------------------------------------------------------*/
+
+struct boardinfo {
+	struct list_head	list;
+	unsigned		n_board_info;
+	struct spi_board_info	board_info[0];
+};
+
+static LIST_HEAD(board_list);
+static DECLARE_MUTEX(board_lock);
+
+/*
+ * Board-specific early init code calls this (probably during arch_initcall)
+ * with segments of the SPI device table.  Any device nodes are created later,
+ * after the relevant parent SPI controller (bus_num) is defined.  We keep
+ * this table of devices forever, so that reloading a controller driver will
+ * not make Linux forget about these devices.
+ *
+ * Other code can also call this, e.g. a particular add-on board might provide
+ * SPI devices on its expansion connector, so code initializing that board
+ * would naturally declare its SPI devices.
+ *
+ * The board info passed can safely be __initdata ... but be careful of
+ * any embedded pointers (platform_data, etc), they're copied as-is.
+ */
+int
+#if defined(CONFIG_SPI_EXAMPLE_MODULE)
+// HACK -- ONLY FOR DEVELOPMENT!!
+__init_or_module
+#else
+__init
+#endif
+spi_register_board_info(struct spi_board_info const *info, unsigned n)
+{
+	struct boardinfo	*bi;
+
+	bi = kmalloc (sizeof (*bi) + n * sizeof (*info), GFP_KERNEL);
+	if (!bi)
+		return -ENOMEM;
+	bi->n_board_info = n;
+	memcpy(bi->board_info, info, n * sizeof (*info));
+
+	down(&board_lock);
+	list_add_tail(&bi->list, &board_list);
+	up(&board_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_register_board_info);
+
+static int check_child(struct device *dev, void *data)
+{
+	const struct spi_device		*spi = to_spi_device(dev);
+	const struct spi_board_info	*chip = data;
+
+	return (spi->chip_select == chip->chip_select);
+}
+
+#define	kzalloc(n, flags)	kcalloc(1,(n),(flags))
+
+static void scan_boardinfo(struct spi_master *master)
+{
+	struct boardinfo	*bi;
+	struct device		*dev = master->cdev.dev;
+
+	down(&board_lock);
+	list_for_each_entry(bi, &board_list, list) {
+		struct spi_board_info	*chip = bi->board_info;
+		unsigned		n;
+
+		for (n = bi->n_board_info; n > 0; n--, chip++) {
+			struct spi_device		*proxy;
+			int				status;
+
+			if (chip->bus_num != master->bus_num)
+				continue;
+			if (chip->chip_select >= master->num_chipselect) {
+				dev_dbg(dev, "cs%d > max %d\n",
+					chip->chip_select,
+					master->num_chipselect);
+				continue;
+			}
+
+			/* only one child per chipselect, ever */
+			if (device_for_each_child(dev, chip, check_child))
+				continue;
+
+			if (!class_device_get(&master->cdev))
+				continue;
+
+			proxy = kzalloc(sizeof *proxy, GFP_KERNEL);
+			if (!proxy) {
+				dev_err(dev, "can't alloc dev for cs%d\n",
+					chip->chip_select);
+				goto trynext;
+			}
+			proxy->master = master;
+			proxy->chip_select = chip->chip_select;
+			proxy->max_speed_hz = chip->max_speed_hz;
+
+			snprintf(proxy->dev.bus_id, sizeof proxy->dev.bus_id,
+					"%s.%u-%s", master->cdev.class_id,
+					chip->chip_select, chip->modalias);
+			proxy->dev.parent = dev;
+			proxy->dev.bus = &spi_bus_type;
+			proxy->dev.platform_data = chip->platform_data;
+			proxy->dev.release = spidev_release;
+
+			/* drivers may modify this default i/o setup */
+			status = master->setup(proxy);
+			if (status < 0) {
+				dev_dbg(dev, "can't %s %s, status %d\n",
+						"setup",
+						proxy->dev.bus_id, status);
+				goto trynext;
+			}
+
+			status = device_register(&proxy->dev);
+			if (status < 0) {
+				dev_dbg(dev, "can't %s %s, status %d\n",
+						"add",
+						proxy->dev.bus_id, status);
+trynext:
+				class_device_put(&master->cdev);
+				kfree(proxy);
+				continue;
+			}
+			dev_dbg(dev, "registered child %s\n",
+					proxy->dev.bus_id);
+		}
+	}
+	up(&board_lock);
+}
+
+/*-------------------------------------------------------------------------*/
+
+static atomic_t	dyn_bus_id = ATOMIC_INIT(0);
+
+/**
+ * spi_register_master - register SPI master controller
+ * @dev: the controller
+ * @master: the master, with all uninitialized fields zeroed
+ *
+ * This call is used only by SPI master controller drivers, which are the
+ * only ones directly touching chip registers.
+ *
+ * SPI master controllers connect to their drivers using some non-SPI bus,
+ * such as the platform bus.  The final stage of probe() in that code
+ * includes calling spi_register_master(), with memory managed by that
+ * controller, to hook up to this SPI bus glue.
+ *
+ * SPI controllers use board specific (often SOC specific) bus numbers,
+ * and board-specific addressing for SPI devices combines those numbers
+ * with chip select numbers.  Since SPI does not directly support dynamic
+ * device identification, most boards need configuration tables saying
+ * "this chip is at that address".
+ *
+ * This must be called from context that can sleep.  It returns zero
+ * on success, else a negative error code.
+ */
+int spi_register_master(struct device *dev, struct spi_master *master)
+{
+	int			status = -ENODEV;
+
+	if (list_empty(&board_list)) {
+		dev_dbg(dev, "spi board info is missing\n");
+		goto done;
+	}
+
+	/* convention:  dynamically assigned bus IDs count down from the max */
+	if (master->bus_num == 0) {
+		master->bus_num = atomic_dec_return(&dyn_bus_id);
+		dev_dbg(dev, "spi%d, dynamic bus number\n", master->bus_num);
+	}
+
+	master->cdev.class = &spi_master_class;
+	master->cdev.dev = get_device(dev);
+	class_set_devdata(&master->cdev, master);
+	snprintf(master->cdev.class_id, sizeof master->cdev.class_id,
+		"spi%u", master->bus_num);
+
+	/* register the device, then userspace will see it */
+	status = class_device_register(&master->cdev);
+	if (status < 0) {
+		put_device(dev);
+		goto done;
+	}
+	dev_dbg(dev, "registered master %s\n", master->cdev.class_id);
+
+	scan_boardinfo(master);
+	status = 0;
+done:
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_register_master);
+
+
+/**
+ * spi_unregister_master - unregister SPI master controller
+ * @master: the master being unregistered
+ *
+ * This call is used only by SPI master controller drivers, which are the
+ * only ones directly touching chip registers.
+ *
+ * This must be called from context that can sleep.
+ */
+void spi_unregister_master(struct spi_master *master)
+{
+	/* REVISIT when do children get deleted? */
+	class_device_unregister(&master->cdev);
+
+	put_device(master->cdev.dev);
+	master->cdev.dev = NULL;
+
+}
+EXPORT_SYMBOL_GPL(spi_unregister_master);
+
+
+/*-------------------------------------------------------------------------*/
+
+static void spi_sync_complete(void *done)
+{
+	complete(done);
+}
+
+/**
+ * spi_sync - blocking/synchronous SPI data transfers
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers
+ *
+ * This call may only be used from a context that may sleep.
+ * The sleep is non-interruptible, and has no timeout.
+ *
+ * The return value is a negative error code if the message could not be
+ * submitted, else zero.  When the value is zero, then message->status is
+ * also defined:  it's the completion code for the transfer, either zero
+ * or a negative error code from the controller driver.
+ */
+int spi_sync(struct spi_device *spi, struct spi_message *message)
+{
+	DECLARE_COMPLETION(done);
+	int status;
+
+	message->complete = spi_sync_complete;
+	message->context = &done;
+	status = spi_async(spi, message);
+	if (status == 0)
+		wait_for_completion(&done);
+	message->context = NULL;
+	return status;
+}
+EXPORT_SYMBOL(spi_sync);
+
+/**
+ * spi_w8r16 - SPI synchronous 8 bit write followed by 16 bit read
+ * @spi: device with which data will be exchanged
+ * @cmd: command to be written before data is read back
+ *
+ * This returns the (unsigned) sixteen bit number returned by the
+ * device, or else a negative error code.
+ */
+int spi_w8r16(struct spi_device *spi, u8 cmd)
+{
+	int			status;
+	struct spi_message	message;
+	struct spi_transfer	x[2];
+	u16			result;
+
+	x[0].tx_buf = &cmd;
+	x[0].rx_buf = NULL;
+	x[0].len = 1;
+
+	x[1].tx_buf = NULL;
+	x[1].rx_buf = &result;
+	x[1].len = 2;
+
+	/* do the i/o */
+	message.transfers = &x[0];
+	message.n_transfer = ARRAY_SIZE(x);
+	status = spi_sync(spi, &message);
+
+	/* return negative errno or unsigned value */
+	return (status < 0) ? status : result;
+}
+EXPORT_SYMBOL(spi_w8r16);
+
+/*-------------------------------------------------------------------------*/
+
+static int __init spi_init(void)
+{
+	bus_register(&spi_bus_type);
+	class_register(&spi_master_class);
+	return 0;
+}
+postcore_initcall(spi_init);
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/drivers/spi/Kconfig	2005-09-09 16:53:47.440773290 -0700
@@ -0,0 +1,319 @@
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
+menu "SPI support"
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
+	  Chips that support SPI can have data transfer rates up to several
+	  tens of Mbit/sec, and the controllers often support DMA.  Chips
+	  are addressed with a controller and a chipselect.  Most SPI
+	  devices don't support dynamic device discovery; some are even
+	  write-only or read-only.
+
+	  SPI is one of a family of similar protocols using a four wire
+	  interface (select, clock, data in, data out) including Microwire
+	  (half duplex), SSP, SSI, and PSP.  This driver framework should
+	  work with most such devices and controllers.
+
+config SPI_DEBUG
+	boolean "Debug messaging for SPI drivers"
+	depends on SPI && DEBUG_KERNEL
+	help
+	  Say "yes" to enable debug messaging (like dev_dbg and pr_debug)
+	  from SPI controller and protocol drivers.
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
+# MASTER side ... talking to discrete SPI slave chips including microcontrollers
+#
+comment "No SPI master hardware is available."
+	depends on SPI && !SPI_ARCH_HAS_MASTER
+
+menuconfig SPI_MASTER
+	boolean "SPI Master support"
+	depends on SPI && SPI_ARCH_HAS_MASTER
+	help
+	  If your system has an master-capable SPI controller (which
+	  provides the clock and chipselect), you can enable that
+	  controller and the protocol drivers for the SPI slave chips
+	  that are connected.
+
+if SPI_MASTER
+
+comment "SPI Master Controller Drivers"
+
+config SPI_EXAMPLE
+	tristate "SPI Platform Example"
+	help
+	  This just builds some sample code uses the core APIs to build
+	  some SPI devices and plug in dummy controller drivers.
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
+config SPI_ADS7846
+	tristate "ADS 7846 touchscreen and sensors"
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
+# SLAVE side ... widely implemented on microcontrollers,
+# but Linux-capable hardware often supports this too
+#
+comment "No SPI slave hardware is available."
+	depends on SPI && !SPI_ARCH_HAS_SLAVE
+
+menuconfig SPI_SLAVE
+	boolean "SPI Slave support"
+	depends on SPI && SPI_ARCH_HAS_SLAVE
+	help
+	  If your system has a slave-capable SPI controller (driven
+	  by a master when it provides chipselect and clock), you can
+	  enable drivers for that controller and for the SPI protocol
+	  slave functions you're implementing.
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
--- osk.orig/arch/arm/Kconfig	2005-09-09 16:53:17.055568971 -0700
+++ osk/arch/arm/Kconfig	2005-09-09 16:53:47.441773099 -0700
@@ -746,6 +746,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/hwmon/Kconfig"
 
 #source "drivers/l3/Kconfig"
--- osk.orig/drivers/Kconfig	2005-09-09 16:53:17.054569162 -0700
+++ osk/drivers/Kconfig	2005-09-09 16:53:47.442772909 -0700
@@ -42,6 +42,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/hwmon/Kconfig"
--- osk.orig/drivers/Makefile	2005-09-09 16:53:17.054569162 -0700
+++ osk/drivers/Makefile	2005-09-09 16:53:47.442772909 -0700
@@ -29,6 +29,7 @@ obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ net/ 
 obj-$(CONFIG_I2C)               += i2c/
 obj-y				+= media/ ssi/
+obj-$(CONFIG_SPI)		+= spi/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-$(CONFIG_PPC_PMAC)		+= macintosh/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ osk/drivers/spi/Makefile	2005-09-09 16:53:47.443772718 -0700
@@ -0,0 +1,34 @@
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
+obj-$(CONFIG_SPI_MASTER)		+= spi.o
+
+# STUBBED IMPLEMENTATION
+obj-$(CONFIG_SPI_EXAMPLE)		+= spi_plat_example.o
+
+# SPI master controller drivers (bus)
+#obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
+#obj-$(CONFIG_SPI_OMAP)			+= omap_spi.o
+#obj-$(CONFIG_SPI_OMAP_MMC)		+= omap_spi_mmc.o
+#obj-$(CONFIG_SPI_PXA_SSP)		+= pxa_ssp.o
+#obj-$(CONFIG_SPI_PXA_MMC)		+= pxa_spi_mmc.o
+
+# SPI protocol drivers (device/link on bus)
+# obj-$(CONFIG_SPI_DATAFLASH)		+= dataflash.o
+# obj-$(CONFIG_SPI_EEPROM)		+= at25c.o
+# obj-$(CONFIG_SPI_ETHERNET)		+= spi_ether.o
+obj-$(CONFIG_SPI_ADS7846)		+= ads7846.o
+
+# SPI slave controller drivers (upstream link)
+#obj-$(CONFIG_SPI_OMAP_SLAVE)		+= omap_spi_slave.o
+#obj-$(CONFIG_SPI_PXA_SSP_SLAVE)		+= pxa_ssp_slave.o
+
+# SPI slave drivers (protocol for that link)
+# obj-$(CONFIG_SPI_ETHERNET_SLAVE)	+= spi_ether_slave.o
