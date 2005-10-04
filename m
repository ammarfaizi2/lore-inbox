Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVJDSCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVJDSCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVJDSCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:02:48 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:58831 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S964890AbVJDSCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:02:46 -0400
X-ORBL: [69.107.75.50]
Date: Tue, 04 Oct 2005 11:02:40 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC 1/2] simple SPI framework
Cc: spi-devel-general@lists.sourceforge.net, basicmark@yahoo.com,
       stephen@streetfiresound.com, dpervushin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the core of a small SPI framework, implementing the model of a
queue of messages which complete asynchronously (with thin synchronous
wrappers on top for apps which want them).

  - It's still less than 2KB of ".text" (ARM).  If there's got to be a
    mid-layer for something so simple, that's the right size budget.  :)

  - The guts use board-specific SPI device tables to build the driver
    model tree.  (Hardware probing is rarely an option.)

  - This version of Kconfig includes no drivers.  At this writing there
    are two known master controller drivers (PXA/SSP, OMAP MicroWire)
    and protocol drivers (CS8415a, ADS7846).

  - No userspace API.  There are several implementations to compare.
    Implement them like any other driver, and bind them with sysfs.

This is enough to write (or adapt) real drivers.

---
Hmm, this should probably use <include/linux/spi/spi.h> instead.

 arch/arm/Kconfig     |    2 
 drivers/Kconfig      |    2 
 drivers/Makefile     |    1 
 drivers/spi/Kconfig  |  122 ++++++++++++
 drivers/spi/Makefile |   23 ++
 drivers/spi/spi.c    |  514 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi.h  |  507 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1171 insertions(+)


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/include/linux/spi.h	2005-10-04 08:00:51.000000000 -0700
@@ -0,0 +1,507 @@
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
+ * INTERFACES between SPI master drivers and infrastructure
+ * (There's no SPI slave support for Linux yet...)
+ *
+ * A "struct device_driver" for an spi_device uses "spi_bus_type" and
+ * needs no special API wrappers (much like platform_bus).  These drivers
+ * are bound to devices based on their names (much like platform_bus),
+ * and are available in dev->driver.
+ */
+extern struct bus_type spi_bus_type;
+
+/**
+ * struct spi_device - master side proxy for an SPI slave device
+ * @dev: driver model representation of the device.
+ * @master: SPI controller used with the device.
+ * @max_speed_hz: clock rate to be used on this board.
+ * @chip-select: chipselect, distinguishing chips handled by "master".
+ * @mode: the spi mode defines how data is clocked out and in.
+ * @bits_per_word: data transfers involve one or more words; word sizes
+ * 	like eight or 12 bits are common.
+ * @irq: negative, or the number passed to request_irq() to receive
+ * 	interrupts from this device.
+ * @platform_data: static board-specific definitions for controller,
+ * 	such as FIFO initialization parameters.
+ * @controller_data: for spi controller driver's runtime state.
+ *
+ * An spi_device is used to interchange data between an SPI slave
+ * (usually a discrete chip) and CPU memory.
+ *
+ * In "dev", the platform_data is used to hold information about this
+ * device that's meaningful to the device's protocol driver, but not
+ * to its controller.  One example might be an identifier for a chip
+ * variant with slightly different functionality.
+ */
+struct spi_device {
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
+#define	SPI_CS_HIGH	0x04		/* chipselect active high? */
+	u8			bits_per_word;
+	int			irq;
+	const void		*platform_data;
+	void			*controller_data;
+
+	// likely need more hooks for more protocol options affecting how
+	// the controller talks to its chips, like:
+	//  - bit order (default is wordwise msb-first)
+	//  - memory packing (12 bit samples into low bits, others zeroed)
+	//  - priority
+	//  - chipselect delays
+	//  - ...
+};
+
+static inline struct spi_device *to_spi_device(struct device *dev)
+{
+	return container_of(dev, struct spi_device, dev);
+}
+
+/* most drivers won't need to care about device refcounting */
+static inline struct spi_device *spi_dev_get(struct spi_device *spi)
+{
+	return (spi && get_device(&spi->dev)) ? spi : NULL;
+}
+
+static inline void spi_dev_put(struct spi_device *spi)
+{
+	if (spi)
+		put_device(&spi->dev);
+}
+
+/* ctldata is for the bus_master driver's runtime state */
+static inline void *spi_get_ctldata(struct spi_device *spi)
+{
+	return spi->controller_data;
+}
+
+static inline void spi_set_ctldata(struct spi_device *spi, void *data)
+{
+	spi->controller_data = data;
+}
+
+
+struct spi_message;
+
+
+/**
+ * struct spi_master - interface to SPI master controller
+ * @cdev: class interface to this driver
+ * @bus_num: board-specific (and often SOC-specific) identifier for a
+ * 	given SPI controller.
+ * @num_chipselects: chipselects are used to distinguish individual
+ * 	SPI slaves, and are numbered from zero to num_chipselects.
+ * 	each slave has a chipselect signal, but it's common that not
+ * 	every chipselect is connected to a slave.
+ * @setup: updates the device mode, wordsize, and clocking records used
+ * 	by a device's SPI controller; protocol code may call this.
+ * @transfer: adds a message to the controller's transfer queue.
+ * @cleanup: frees controller-specific state
+ *
+ * Each SPI master controller can communicate with one or more spi_device
+ * children.  These make a small bus, sharing MOSI, MISO and SCK signals
+ * but not chip select signals.  Each device may be configured to use a
+ * different clock rate, since those shared signals are ignored unless
+ * the chip is selected.
+ *
+ * The driver for an SPI controller manages access to those devices through
+ * a queue of spi_message transactions, copyin data between CPU memory and
+ * an SPI slave device).  For each such message it queues, it calls the
+ * message's completion function when the transaction completes.
+ */
+struct spi_master {
+	struct class_device	cdev;
+
+	/* other than zero (== assign one dynamically), bus_num is fully
+	 * board-specific.  usually that simplifies to being SOC-specific.
+	 * example:  one SOC has three SPI controllers, numbered 1..3,
+	 * and one board's schematics might show it using SPI-2.  software
+	 * would normally use bus_num=2 for that controller.
+	 */
+	u16			bus_num;
+
+	/* chipselects will be integral to many controllers; some others
+	 * might use board-specific GPIOs.
+	 */
+	u16			num_chipselect;
+
+	/* setup mode and clock, etc (spi driver may call many times) */
+	int			(*setup)(struct spi_device *spi);
+
+	/* bidirectional bulk transfers
+	 *
+	 * + The transfer() method may not sleep; its main role is
+	 *   just to add the message to the queue.
+	 * + For now there's no remove-from-queue operation, or
+	 *   any other request management
+	 * + To a given spi_device, message queueing is pure fifo
+	 *
+	 * + The master's main job is to process its message queue,
+	 *   selecting a chip then transferring data
+	 * + If there are multiple spi_device children, the i/o queue
+	 *   arbitration algorithm is unspecified (round robin, fifo,
+	 *   priority, reservations, preemption, etc)
+	 *
+	 * + Chipselect stays active during the entire message
+	 *   (unless modified by spi_transfer.cs_change != 0).
+	 * + The message transfers use clock and SPI mode parameters
+	 *   previously established by setup() for this device
+	 */
+	int			(*transfer)(struct spi_device *spi,
+						struct spi_message *mesg);
+
+	/* called on release() to free memory provided by spi_master */
+	void			(*cleanup)(const struct spi_device *spi);
+};
+
+/* the spi driver core manages memory for the spi_master classdev */
+extern struct spi_master *
+spi_alloc_master(struct device *host, unsigned size);
+
+extern int spi_register_master(struct spi_master *master);
+extern void spi_unregister_master(struct spi_master *master);
+
+
+/*---------------------------------------------------------------------------*/
+
+/*
+ * I/O INTERFACE between SPI controller and protocol drivers
+ *
+ * Protocol drivers use a queue of spi_messages, each transferring data
+ * between the controller and memory buffers.
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
+/**
+ * struct spi_transfer - a read/write buffer pair
+ * @tx_buf: data to be written, or NULL
+ * @rx_buf: data to be read, or NULL
+ * @len: size of rx and tx buffers
+ * @cs_change: affects chipselect after this transfer completes
+ * @delay_usecs: microseconds to delay after this transfer, before
+ * 	starting the next transfer or completing this spi_message. 
+ *
+ * SPI transfers always write the same number of bytes as they read.
+ *
+ * All SPI transfers start with the relevant chipselect active.  Drivers
+ * can change behavior of the chipselect after the transfer finishes
+ * (including any mandatory delay).  The normal behavior is to leave it
+ * selected, except for the last transfer in a message.  Setting cs_change
+ * thus allows either of two things:
+ *
+ * (i) If the transfer isn't the last one in the message, chipselect
+ * may briefly go inactive in the middle of the message.  Toggling
+ * chipselect in this way may be needed to let a single spi_message
+ * perform all of group of chip transactions together.
+ *
+ * (ii) When the transfer is the last one in the message, the chip will
+ * stay selected until the next transfer in the queue is started.  If that
+ * next transfer uses the same chipselect, this removes some overhead.
+ */
+struct spi_transfer {
+	/* it's ok if tx_buf == rx_buf (right?)
+	 * for MicroWire, one buffer must be null
+	 * buffers must work with dma_*map_single() calls
+	 */
+	const void	*tx_buf;
+	void		*rx_buf;
+	unsigned	len;
+
+	/* REVISIT for now, these are only for the controller driver's
+	 * use, for recording dma mappings
+	 */
+	dma_addr_t	tx_dma;
+	dma_addr_t	rx_dma;
+
+	unsigned	cs_change:1;
+	u16		delay_usecs;
+};
+
+/**
+ * struct spi_message - one multi-segment SPI transaction
+ * @transfers: the segements of the transaction
+ * @n_transfer: how many segments
+ * @dev: the device to which the transaction is queued
+ * @complete: called to report transaction completions
+ * @context: the argument to complete() when it's called
+ * @actual_length: how many bytes were transferd
+ * @status: zero for success, else negative errno
+ * @queue: for use by whichever driver currently owns the message
+ * @state: for use by whichever driver currently owns the message
+ */
+struct spi_message {
+	struct spi_transfer	*transfers;
+	unsigned		n_transfer;
+
+	struct spi_device	*dev;
+
+	/* completion is reported through a callback */
+	void 			FASTCALL((*complete)(void *context));
+	void			*context;
+	unsigned		actual_length;
+	int			status;
+
+	/* for optional use by whatever driver currently owns the
+	 * spi_message ...  between calls to spi_async and then later
+	 * complete(), that's the spi_master controller driver.
+	 */
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
+/**
+ * spi_async -- asynchronous SPI transfer
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers, including completion callback
+ *
+ * This call may be used in_irq and other contexts which can't sleep,
+ * as well as from task contexts which can sleep.
+ *
+ * The completion callback is invoked in a context which can't sleep.
+ * Before that invocation, the value of message->status is undefined.
+ * When the callback is issued, message->status holds either zero (to
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
+/* All these synchronous SPI transfer routines are utilities layered
+ * over the core async transfer primitive.  Here, "synchronous" means
+ * they will sleep uninterruptibly until the async transfer completes.
+ */
+
+extern int spi_sync(struct spi_device *spi, struct spi_message *message);
+
+/**
+ * spi_write - SPI synchronous write
+ * @spi: device to which data will be written
+ * @buf: data buffer
+ * @len: data buffer size
+ *
+ * This writes the buffer and returns zero or a negative error code.
+ * Callable only from contexts that can sleep.
+ */
+static inline int
+spi_write(struct spi_device *spi, const u8 *buf, size_t len)
+{
+	struct spi_transfer	t = {
+			.tx_buf		= buf,
+			.rx_buf		= NULL,
+			.len		= len,
+			.cs_change	= 0,
+		};
+	struct spi_message	m = {
+			.transfers	= &t,
+			.n_transfer	= 1,
+		};
+
+	return spi_sync(spi, &m);
+}
+
+/**
+ * spi_read - SPI synchronous read
+ * @spi: device from which data will be read
+ * @buf: data buffer
+ * @len: data buffer size
+ *
+ * This writes the buffer and returns zero or a negative error code.
+ * Callable only from contexts that can sleep.
+ */
+static inline int
+spi_read(struct spi_device *spi, u8 *buf, size_t len)
+{
+	struct spi_transfer	t = {
+			.tx_buf		= NULL,
+			.rx_buf		= buf,
+			.len		= len,
+			.cs_change	= 0,
+		};
+	struct spi_message	m = {
+			.transfers	= &t,
+			.n_transfer	= 1,
+		};
+
+	return spi_sync(spi, &m);
+}
+
+extern int spi_write_then_read(struct spi_device *spi,
+		const u8 *txbuf, unsigned n_tx,
+		u8 *rxbuf, unsigned n_rx);
+
+/**
+ * spi_w8r8 - SPI synchronous 8 bit write followed by 8 bit read
+ * @spi: device with which data will be exchanged
+ * @cmd: command to be written before data is read back
+ *
+ * This returns the (unsigned) eight bit number returned by the
+ * device, or else a negative error code.  Callable only from
+ * contexts that can sleep.
+ */
+static inline int spi_w8r8(struct spi_device *spi, u8 cmd)
+{
+	int			status;
+	u8			result;
+
+	status = spi_write_then_read(spi, &cmd, 1, &result, 1);
+
+	/* return negative errno or unsigned value */
+	return (status < 0) ? status : result;
+}
+
+/**
+ * spi_w8r16 - SPI synchronous 8 bit write followed by 16 bit read
+ * @spi: device with which data will be exchanged
+ * @cmd: command to be written before data is read back
+ *
+ * This returns the (unsigned) sixteen bit number returned by the
+ * device, or else a negative error code.  Callable only from
+ * contexts that can sleep.
+ */
+static inline int spi_w8r16(struct spi_device *spi, u8 cmd)
+{
+	int			status;
+	u16			result;
+
+	status = spi_write_then_read(spi, &cmd, 1, (u8 *) &result, 2);
+
+	/* return negative errno or unsigned value */
+	return (status < 0) ? status : result;
+}
+
+/*---------------------------------------------------------------------------*/
+
+/*
+ * INTERFACE between board init code and SPI infrastructure.
+ *
+ * No SPI driver ever sees these SPI device table segments, but
+ * it's how the SPI core (or adapters that get hotplugged) grows
+ * the driver model tree.
+ *
+ * As a rule, SPI devices can't be probed.  Instead, board init code
+ * provides a table listing the devices which are present, with enough
+ * information to bind and set up the device's driver.  There's basic
+ * support for nonstatic configurations too; enough to handle adding
+ * parport adapters, or microcontrollers acting as USB-to-SPI bridges.
+ */
+
+/* board-specific information about each SPI device */
+struct spi_board_info {
+	/* the device name and module name are coupled, like platform_bus;
+	 * "modalias" is normally the driver name.
+	 *
+	 * platform_data goes to spi_device.dev.platform_data,
+	 * controller_data goes to spi_device.platform_data,
+	 * irq is copied too
+	 */
+	char		modalias[KOBJ_NAME_LEN];
+	const void	*platform_data;
+	const void	*controller_data;
+	int		irq;
+
+	/* slower signaling on noisy or low voltage boards */
+	u32		max_speed_hz;
+
+
+	/* bus_num is board specific and matches the bus_num of some
+	 * spi_master that will probably be registered later.
+	 *
+	 * chip_select reflects how this chip is wired to that master;
+	 * it's less than num_chipselect.
+	 */
+	u16		bus_num;
+	u16		chip_select;
+
+	/* ... may need additional spi_device chip config data here.
+	 * avoid stuff protocol drivers can set; but include stuff
+	 * needed to behave without being bound to a driver:
+	 *  - chipselect polarity
+	 *  - quirks like clock rate mattering when not selected
+	 */
+};
+
+#ifdef	CONFIG_SPI
+extern int
+spi_register_board_info(struct spi_board_info const *info, unsigned n);
+#else
+/* board init code may ignore whether SPI is configured or not */
+static inline int
+spi_register_board_info(struct spi_board_info const *info, unsigned n)
+	{ return 0; }
+#endif
+
+
+/* If you're hotplugging an adapter with devices (parport, usb, etc)
+ * use spi_new_device() to describe each device.  You can also call
+ * spi_unregister_device() to get start making that device vanish,
+ * but normally that would be handled by spi_unregister_master().
+ */
+extern struct spi_device *
+spi_new_device(struct spi_master *, struct spi_board_info *);
+
+static inline void
+spi_unregister_device(struct spi_device *spi)
+{
+	if (spi)
+		device_unregister(&spi->dev);
+}
+
+#endif /* __LINUX_SPI_H */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/spi/spi.c	2005-10-04 08:00:51.000000000 -0700
@@ -0,0 +1,514 @@
+/*
+ * spi.c - SPI init/core code
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
+ * usually before board init code provides the SPI device tables, and
+ * are available later when driver init code needs them.
+ *
+ * Drivers for SPI devices are like those for platform bus devices:
+ *  (a) few bus-specific API wrappers (== needless bloat here)
+ *  (b) matched to devices using device names
+ *  (c) should support "native" suspend and resume methods
+ */
+static void spidev_release(struct device *dev)
+{
+	const struct spi_device	*spi = to_spi_device(dev);
+
+	/* spi masters may cleanup for released devices */
+	if (spi->master->cleanup)
+		spi->master->cleanup(spi);
+
+	class_device_put(&spi->master->cdev);
+	kfree(dev);
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
+static struct device_attribute spi_dev_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
+/* modalias support makes "modprobe $MODALIAS" new-style hotplug work,
+ * and the sysfs version makes coldplug work too.
+ */
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
+#ifdef	CONFIG_PM
+
+/* Suspend/resume in "struct device_driver" don't really need that
+ * strange third parameter, so we just make it a constant and expect
+ * SPI drivers to ignore it just like most platform drivers do.
+ *
+ * NOTE:  the suspend() method for an spi_master controller driver
+ * should verify that all its child devices are marked as suspended;
+ * suspend requests delivered through sysfs power/state files don't
+ * enforce such constraints.
+ */
+static int spi_suspend(struct device *dev, pm_message_t message)
+{
+	int	value;
+
+	if (!dev->driver || !dev->driver->suspend)
+		return 0;
+
+	/* suspend will stop irqs and dma; no more i/o */
+	value = dev->driver->suspend(dev, message, SUSPEND_POWER_DOWN);
+	if (value == 0)
+		dev->power.power_state = message;
+	return value;
+}
+
+static int spi_resume(struct device *dev)
+{
+	int	value;
+
+	if (!dev->driver || !dev->driver->resume)
+		return 0;
+
+	/* resume may restart the i/o queue */
+	value = dev->driver->resume(dev, RESUME_POWER_ON);
+	if (value == 0)
+		dev->power.power_state = PMSG_ON;
+	return value;
+}
+
+#else
+#define spi_suspend	NULL
+#define spi_resume	NULL
+#endif
+
+struct bus_type spi_bus_type = {
+	.name		= "spi",
+	.dev_attrs	= spi_dev_attrs,
+	.match		= spi_match_device,
+	.hotplug	= spi_hotplug,
+	.suspend	= spi_suspend,
+	.resume		= spi_resume,
+};
+EXPORT_SYMBOL_GPL(spi_bus_type);
+
+/*-------------------------------------------------------------------------*/
+
+/* SPI devices should normally not be created by SPI device drivers; that
+ * would make them board-specific.  Similarly with SPI master drivers.
+ * Device registration normally goes into like arch/.../mach.../board-YYY.c
+ * with other information about mainboard devices.
+ */
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
+#define	kzalloc(n, flags)	kcalloc(1,(n),(flags))
+
+static int __init_or_module
+check_child(struct device *dev, void *data)
+{
+	const struct spi_device		*spi = to_spi_device(dev);
+	const struct spi_board_info	*chip = data;
+
+	return (spi->chip_select == chip->chip_select);
+}
+
+
+/* On typical mainboards, this is purely internal; and it's not needed
+ * after board init creates the hard-wired devices.  Some development
+ * platforms may not be able to use spi_register_board_info though, and
+ * this is exported so that for example a USB or parport based adapter
+ * driver could add devices.
+ */
+struct spi_device *__init_or_module
+spi_new_device(struct spi_master *master, struct spi_board_info *chip)
+{
+	struct spi_device	*proxy;
+	struct device		*dev = master->cdev.dev;
+	int			status;
+
+	/* NOTE:  caller did any chip->bus_num checks necessary */
+
+	/* only one child per chipselect, ever */
+	if (device_for_each_child(dev, chip, check_child))
+		return NULL;
+
+	if (!class_device_get(&master->cdev))
+		return NULL;
+
+	proxy = kzalloc(sizeof *proxy, GFP_KERNEL);
+	if (!proxy) {
+		dev_err(dev, "can't alloc dev for cs%d\n",
+			chip->chip_select);
+		goto fail;
+	}
+	proxy->master = master;
+	proxy->chip_select = chip->chip_select;
+	proxy->max_speed_hz = chip->max_speed_hz;
+	proxy->irq = chip->irq;
+
+	snprintf(proxy->dev.bus_id, sizeof proxy->dev.bus_id,
+			"%s.%u-%s", master->cdev.class_id,
+			chip->chip_select, chip->modalias);
+	proxy->dev.parent = dev;
+	proxy->dev.bus = &spi_bus_type;
+	proxy->dev.platform_data = (void *) chip->platform_data;
+	proxy->platform_data = chip->controller_data;
+	proxy->controller_data = NULL;
+	proxy->dev.release = spidev_release;
+
+	/* drivers may modify this default i/o setup */
+	status = master->setup(proxy);
+	if (status < 0) {
+		dev_dbg(dev, "can't %s %s, status %d\n",
+				"setup", proxy->dev.bus_id, status);
+		goto fail;
+	}
+
+	/* FIXME Paranoia argues that we be able to detect callers
+	 * that misbehaved by defining a second device with the
+	 * same bus and chipselect numbers, and fail cleanly.
+	 * Here's the point we'd want to catch that.
+	 */
+
+	status = device_register(&proxy->dev);
+	if (status < 0) {
+		dev_dbg(dev, "can't %s %s, status %d\n",
+				"add", proxy->dev.bus_id, status);
+fail:
+		class_device_put(&master->cdev);
+		kfree(proxy);
+		return NULL;
+	}
+	dev_dbg(dev, "registered child %s\n", proxy->dev.bus_id);
+	return proxy;
+}
+EXPORT_SYMBOL_GPL(spi_new_device);
+
+/*
+ * Board-specific early init code calls this (probably during arch_initcall)
+ * with segments of the SPI device table.  Any device nodes are created later,
+ * after the relevant parent SPI controller (bus_num) is defined.  We keep
+ * this table of devices forever, so that reloading a controller driver will
+ * not make Linux forget about these hard-wired devices.
+ *
+ * Other code can also call this, e.g. a particular add-on board might provide
+ * SPI devices through its expansion connector, so code initializing that board
+ * would naturally declare its SPI devices.
+ *
+ * The board info passed can safely be __initdata ... but be careful of
+ * any embedded pointers (platform_data, etc), they're copied as-is.
+ */
+int __init
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
+/* FIXME someone should add support for a __setup("spi", ...) that
+ * creates board info from kernel command lines
+ */
+
+static void __init_or_module
+scan_boardinfo(struct spi_master *master)
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
+			if (chip->bus_num != master->bus_num)
+				continue;
+			if (chip->chip_select >= master->num_chipselect) {
+				dev_dbg(dev, "cs%d > max %d\n",
+					chip->chip_select,
+					master->num_chipselect);
+				continue;
+			}
+			(void) spi_new_device(master, chip);
+		}
+	}
+	up(&board_lock);
+}
+
+/*-------------------------------------------------------------------------*/
+
+static void spi_master_release(struct class_device *cdev)
+{
+	struct spi_master *master;
+
+	master = container_of(cdev, struct spi_master, cdev);
+	put_device(master->cdev.dev);
+	master->cdev.dev = NULL;
+	kfree(master);
+}
+
+static struct class spi_master_class = {
+	.name		= "spi_master",
+	.owner		= THIS_MODULE,
+	.release	= spi_master_release,
+};
+
+
+/**
+ * spi_alloc_master - allocate SPI master controller
+ * @dev: the controller, possibly using the platform_bus
+ * @size: how much driver-private data to preallocate; a pointer to this
+ * 	memory in the class_data field of the returned class_device
+ *
+ * This call is used only by SPI master controller drivers, which are the
+ * only ones directly touching chip registers.  It's how they allocate
+ * an spi_master structure, prior to calling spi_add_master().
+ *
+ * This must be called from context that can sleep.  It returns the SPI
+ * master structure on success, else NULL.
+ *
+ * The caller is responsible for assigning the bus number and initializing
+ * the master's methods before calling spi_add_master(), or else (on error)
+ * calling class_device_put() to prevent a memory leak.
+ */
+struct spi_master * __init_or_module
+spi_alloc_master(struct device *dev, unsigned size)
+{
+	struct spi_master	*master;
+
+	master = kzalloc(size + sizeof *master, SLAB_KERNEL);
+	if (!master)
+		return NULL;
+
+	master->cdev.class = &spi_master_class;
+	master->cdev.dev = get_device(dev);
+	class_set_devdata(&master->cdev, &master[1]);
+
+	return master;
+}
+EXPORT_SYMBOL_GPL(spi_alloc_master);
+
+/**
+ * spi_register_master - register SPI master controller
+ * @master: initialized master, originally from spi_alloc_master()
+ *
+ * SPI master controllers connect to their drivers using some non-SPI bus,
+ * such as the platform bus.  The final stage of probe() in that code
+ * includes calling spi_register_master() to hook up to this SPI bus glue.
+ *
+ * SPI controllers use board specific (often SOC specific) bus numbers,
+ * and board-specific addressing for SPI devices combines those numbers
+ * with chip select numbers.  Since SPI does not directly support dynamic
+ * device identification, boards need configuration tables telling which
+ * chip is at which address.
+ *
+ * This must be called from context that can sleep.  It returns zero on
+ * success, else a negative error code (dropping the master's refcount).
+ */
+int __init_or_module
+spi_register_master(struct spi_master *master)
+{
+	static atomic_t		dyn_bus_id = ATOMIC_INIT(0);
+	struct device		*dev = master->cdev.dev;
+	int			status = -ENODEV;
+
+	/* convention:  dynamically assigned bus IDs count down from the max */
+	if (master->bus_num == 0) {
+		master->bus_num = atomic_dec_return(&dyn_bus_id);
+		dev_dbg(dev, "spi%d, dynamic bus number\n", master->bus_num);
+	}
+
+	/* FIXME ELSE:  verify that bus_num isn't in use already */
+
+	/* register the device, then userspace will see it */
+	snprintf(master->cdev.class_id, sizeof master->cdev.class_id,
+		"spi%u", master->bus_num);
+	status = class_device_register(&master->cdev);
+	if (status < 0) {
+		class_device_put(&master->cdev);
+		goto done;
+	}
+	dev_dbg(dev, "registered master %s\n", master->cdev.class_id);
+
+	/* populate children from any spi device tables */
+	scan_boardinfo(master);
+	status = 0;
+done:
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_register_master);
+
+
+static int __unregister(struct device *dev, void *unused)
+{
+	device_unregister(dev);
+	return 0;
+}
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
+	class_device_unregister(&master->cdev);
+	(void) device_for_each_child(master->cdev.dev, NULL, __unregister);
+}
+EXPORT_SYMBOL_GPL(spi_unregister_master);
+
+
+/*-------------------------------------------------------------------------*/
+
+/**
+ * spi_sync - blocking/synchronous SPI data transfers
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers
+ *
+ * This call may only be used from a context that may sleep.
+ * The sleep is non-interruptible, and has no timeout.
+ *
+ * Note that the SPI device's chip select is active during the message,
+ * and then is normally disabled between messages.  Drivers for some
+ * frequently-used devices may want to minimize costs of selecting a chip,
+ * by leaving it selected in anticipation that the next message will go
+ * to the same chip.  (That may increase power usage.)
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
+	message->complete = (void (*)(void *)) complete;
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
+ * spi_write_then_read - SPI synchronous write followed by read
+ * @spi: device with which data will be exchanged
+ * @txbuf: data to be written (need not be dma-safe)
+ * @n_tx: size of txbuf, in bytes
+ * @rxbuf: buffer into which data will be read
+ * @n_rx: size of rxbuf, in bytes (need not be dma-safe)
+ *
+ * This performs a half duplex MicroWire style transaction with the
+ * device, sending txbuf and then reading rxbuf.  The return value
+ * is zero for success, else a negative errno status code.
+ */
+int spi_write_then_read(struct spi_device *spi,
+		const u8 *txbuf, unsigned n_tx,
+		u8 *rxbuf, unsigned n_rx)
+{
+	int			status;
+	struct spi_message	message;
+	struct spi_transfer	x[2];
+
+	/* FIXME when we support dma, this should use kmalloc for i/o
+	 * buffers, paying attention to cacheline level dma coherency.
+	 * for PIO this isn't an issue.
+	 */
+	memset(x, 0, sizeof x);
+
+	x[0].tx_buf = (u8 *) txbuf;
+	x[0].len = n_tx;
+
+	x[1].rx_buf = rxbuf;
+	x[1].len = n_rx;
+
+	/* do the i/o */
+	message.transfers = x;
+	message.n_transfer = ARRAY_SIZE(x);
+	status = spi_sync(spi, &message);
+	if (status == 0)
+		status = message.status;
+	return status;
+}
+EXPORT_SYMBOL(spi_write_then_read);
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
+++ g26/drivers/spi/Kconfig	2005-10-04 08:00:51.000000000 -0700
@@ -0,0 +1,122 @@
+#
+# SPI driver configuration
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
+	boolean "Debug support for SPI drivers"
+	depends on SPI && DEBUG_KERNEL
+	help
+	  Say "yes" to enable debug messaging (like dev_dbg and pr_debug),
+	  sysfs, and debugfs support in SPI controller and protocol drivers.
+
+# someday this stuff should be set using arch/CPU/PLATFORM/Kconfig
+config SPI_ARCH_HAS_MASTER
+	boolean
+	default y if ARCH_OMAP
+	default y if ARCH_PXA
+	default y if ARCH_AT91
+
+config SPI_ARCH_HAS_SLAVE
+	boolean
+	default y if ARCH_OMAP
+	default y if ARCH_PXA
+	default y if ARCH_AT91
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
+
+#
+# Add new SPI slave controllers in alphabetical order above this line
+#
+
+
+comment "SPI Protocol Slaves"
+
+#
+# Add new SPI protocol slaves in alphabetical order above this line
+#
+
+endif # "SPI Slave Implementations"
+
+endmenu # "SPI support"
+
--- g26.orig/arch/arm/Kconfig	2005-10-04 07:56:52.000000000 -0700
+++ g26/arch/arm/Kconfig	2005-10-04 08:00:51.000000000 -0700
@@ -713,6 +713,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/hwmon/Kconfig"
 
 #source "drivers/l3/Kconfig"
--- g26.orig/drivers/Kconfig	2005-10-04 07:56:52.000000000 -0700
+++ g26/drivers/Kconfig	2005-10-04 08:00:51.000000000 -0700
@@ -44,6 +44,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/hwmon/Kconfig"
--- g26.orig/drivers/Makefile	2005-10-04 07:56:52.000000000 -0700
+++ g26/drivers/Makefile	2005-10-04 08:00:51.000000000 -0700
@@ -39,6 +39,7 @@ obj-$(CONFIG_FUSION)		+= message/
 obj-$(CONFIG_IEEE1394)		+= ieee1394/
 obj-y				+= cdrom/
 obj-$(CONFIG_MTD)		+= mtd/
+obj-$(CONFIG_SPI)		+= spi/
 obj-$(CONFIG_PCCARD)		+= pcmcia/
 obj-$(CONFIG_DIO)		+= dio/
 obj-$(CONFIG_SBUS)		+= sbus/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/spi/Makefile	2005-10-04 08:00:51.000000000 -0700
@@ -0,0 +1,23 @@
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
+# SPI master controller drivers (bus)
+# 	... add above this line ...
+
+# SPI protocol drivers (device/link on bus)
+# 	... add above this line ...
+
+# SPI slave controller drivers (upstream link)
+# 	... add above this line ...
+
+# SPI slave drivers (protocol for upstream link)
+# 	... add above this line ...
