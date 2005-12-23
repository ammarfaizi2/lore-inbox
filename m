Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbVLWAS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVLWAS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVLWASz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:18:55 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:29869 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751222AbVLWASv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:18:51 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.14-rc6-git 1/6] SPI core
Date: Thu, 22 Dec 2005 15:37:32 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net
References: <200511102355.11505.david-b@pacbell.net> 
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9izqDku7O08uaeG"
Message-Id: <200512221537.33071.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_9izqDku7O08uaeG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's the current core.  I expect this will change to (a) let most of it
be linked as a module, not just statically; (b) let spi_transfers group
into a spi_message by using a list_head.  Only the second of those should
be driver-visible.

- Dave


--Boundary-00=_9izqDku7O08uaeG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="spi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spi.patch"

This is the core of a small SPI framework, implementing the model of a
queue of messages which complete asynchronously (with thin synchronous
wrappers on top).

  - It's about 2KB of ".text" (ARM).  If there's got to be a mid-layer
    for something so simple, that's the right size budget.  :)

  - The guts use board-specific SPI device tables to build the driver
    model tree.  (Hardware probing is rarely an option.)

  - This version of Kconfig includes no drivers, but there are several
    controller and protocol drivers added separately.

  - No userspace API.  There are several implementations to compare.
    Implement them like any other driver, and bind them with sysfs.

NOTE:  The version now in the "mm" tree had to change the "hotplug" callback
so it's named "uevent"; driver model changes.  Of course, for hotplugging to
work, your /sbin/hotplug should "modprobe $MODALIAS".

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tmp/include/linux/spi/spi.h	2005-12-22 14:53:42.000000000 -0800
@@ -0,0 +1,632 @@
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
+ * INTERFACES between SPI master-side drivers and SPI infrastructure.
+ * (There's no SPI slave support for Linux yet...)
+ */
+extern struct bus_type spi_bus_type;
+
+/**
+ * struct spi_device - Master side proxy for an SPI slave device
+ * @dev: Driver model representation of the device.
+ * @master: SPI controller used with the device.
+ * @max_speed_hz: Maximum clock rate to be used with this chip
+ *	(on this board); may be changed by the device's driver.
+ * @chip-select: Chipselect, distinguishing chips handled by "master".
+ * @mode: The spi mode defines how data is clocked out and in.
+ *	This may be changed by the device's driver.
+ * @bits_per_word: Data transfers involve one or more words; word sizes
+ * 	like eight or 12 bits are common.  In-memory wordsizes are
+ *	powers of two bytes (e.g. 20 bit samples use 32 bits).
+ *	This may be changed by the device's driver.
+ * @irq: Negative, or the number passed to request_irq() to receive
+ * 	interrupts from this device.
+ * @controller_state: Controller's runtime state
+ * @controller_data: Board-specific definitions for controller, such as
+ * 	FIFO initialization parameters; from board_info.controller_data
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
+#define	SPI_CPHA	0x01			/* clock phase */
+#define	SPI_CPOL	0x02			/* clock polarity */
+#define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
+#define	SPI_MODE_1	(0|SPI_CPHA)
+#define	SPI_MODE_2	(SPI_CPOL|0)
+#define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
+#define	SPI_CS_HIGH	0x04			/* chipselect active high? */
+	u8			bits_per_word;
+	int			irq;
+	void			*controller_state;
+	void			*controller_data;
+	const char		*modalias;
+
+	// likely need more hooks for more protocol options affecting how
+	// the controller talks to each chip, like:
+	//  - bit order (default is wordwise msb-first)
+	//  - memory packing (12 bit samples into low bits, others zeroed)
+	//  - priority
+	//  - drop chipselect after each word
+	//  - chipselect delays
+	//  - ...
+};
+
+static inline struct spi_device *to_spi_device(struct device *dev)
+{
+	return dev ? container_of(dev, struct spi_device, dev) : NULL;
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
+	return spi->controller_state;
+}
+
+static inline void spi_set_ctldata(struct spi_device *spi, void *state)
+{
+	spi->controller_state = state;
+}
+
+
+struct spi_message;
+
+
+
+struct spi_driver {
+	int			(*probe)(struct spi_device *spi);
+	int			(*remove)(struct spi_device *spi);
+	void			(*shutdown)(struct spi_device *spi);
+	int			(*suspend)(struct spi_device *spi, pm_message_t mesg);
+	int			(*resume)(struct spi_device *spi);
+	struct device_driver	driver;
+};
+
+static inline struct spi_driver *to_spi_driver(struct device_driver *drv)
+{
+	return drv ? container_of(drv, struct spi_driver, driver) : NULL;
+}
+
+extern int spi_register_driver(struct spi_driver *sdrv);
+
+static inline void spi_unregister_driver(struct spi_driver *sdrv)
+{
+	if (!sdrv)
+		return;
+	driver_unregister(&sdrv->driver);
+}
+
+
+
+/**
+ * struct spi_master - interface to SPI master controller
+ * @cdev: class interface to this driver
+ * @bus_num: board-specific (and often SOC-specific) identifier for a
+ * 	given SPI controller.
+ * @num_chipselect: chipselects are used to distinguish individual
+ * 	SPI slaves, and are numbered from zero to num_chipselects.
+ * 	each slave has a chipselect signal, but it's common that not
+ * 	every chipselect is connected to a slave.
+ * @setup: updates the device mode and clocking records used by a
+ * 	device's SPI controller; protocol code may call this.
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
+static inline void *spi_master_get_devdata(struct spi_master *master)
+{
+	return class_get_devdata(&master->cdev);
+}
+
+static inline void spi_master_set_devdata(struct spi_master *master, void *data)
+{
+	class_set_devdata(&master->cdev, data);
+}
+
+static inline struct spi_master *spi_master_get(struct spi_master *master)
+{
+	if (!master || !class_device_get(&master->cdev))
+		return NULL;
+	return master;
+}
+
+static inline void spi_master_put(struct spi_master *master)
+{
+	if (master)
+		class_device_put(&master->cdev);
+}
+
+
+/* the spi driver core manages memory for the spi_master classdev */
+extern struct spi_master *
+spi_alloc_master(struct device *host, unsigned size);
+
+extern int spi_register_master(struct spi_master *master);
+extern void spi_unregister_master(struct spi_master *master);
+
+extern struct spi_master *spi_busnum_to_master(u16 busnum);
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
+ * @tx_buf: data to be written (dma-safe address), or NULL
+ * @rx_buf: data to be read (dma-safe address), or NULL
+ * @tx_dma: DMA address of buffer, if spi_message.is_dma_mapped
+ * @rx_dma: DMA address of buffer, if spi_message.is_dma_mapped
+ * @len: size of rx and tx buffers (in bytes)
+ * @cs_change: affects chipselect after this transfer completes
+ * @delay_usecs: microseconds to delay after this transfer before
+ * 	(optionally) changing the chipselect status, then starting
+ * 	the next transfer or completing this spi_message.
+ *
+ * SPI transfers always write the same number of bytes as they read.
+ * Protocol drivers should always provide rx_buf and/or tx_buf.
+ * In some cases, they may also want to provide DMA addresses for
+ * the data being transferred; that may reduce overhead, when the
+ * underlying driver uses dma.
+ *
+ * All SPI transfers start with the relevant chipselect active.  Drivers
+ * can change behavior of the chipselect after the transfer finishes
+ * (including any mandatory delay).  The normal behavior is to leave it
+ * selected, except for the last transfer in a message.  Setting cs_change
+ * allows two additional behavior options:
+ *
+ * (i) If the transfer isn't the last one in the message, this flag is
+ * used to make the chipselect briefly go inactive in the middle of the
+ * message.  Toggling chipselect in this way may be needed to terminate
+ * a chip command, letting a single spi_message perform all of group of
+ * chip transactions together.
+ *
+ * (ii) When the transfer is the last one in the message, the chip may
+ * stay selected until the next transfer.  This is purely a performance
+ * hint; the controller driver may need to select a different device
+ * for the next message.
+ *
+ * The code that submits an spi_message (and its spi_transfers)
+ * to the lower layers is responsible for managing its memory.
+ * Zero-initialize every field you don't set up explicitly, to
+ * insulate against future API updates.
+ */
+struct spi_transfer {
+	/* it's ok if tx_buf == rx_buf (right?)
+	 * for MicroWire, one buffer must be null
+	 * buffers must work with dma_*map_single() calls, unless
+	 *   spi_message.is_dma_mapped reports a pre-existing mapping
+	 */
+	const void	*tx_buf;
+	void		*rx_buf;
+	unsigned	len;
+
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
+ * @spi: SPI device to which the transaction is queued
+ * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
+ *	addresses for each transfer buffer
+ * @complete: called to report transaction completions
+ * @context: the argument to complete() when it's called
+ * @actual_length: the total number of bytes that were transferred in all
+ *	successful segments
+ * @status: zero for success, else negative errno
+ * @queue: for use by whichever driver currently owns the message
+ * @state: for use by whichever driver currently owns the message
+ *
+ * The code that submits an spi_message (and its spi_transfers)
+ * to the lower layers is responsible for managing its memory.
+ * Zero-initialize every field you don't set up explicitly, to
+ * insulate against future API updates.
+ */
+struct spi_message {
+	struct spi_transfer	*transfers;
+	unsigned		n_transfer;
+
+	struct spi_device	*spi;
+
+	unsigned		is_dma_mapped:1;
+
+	/* REVISIT:  we might want a flag affecting the behavior of the
+	 * last transfer ... allowing things like "read 16 bit length L"
+	 * immediately followed by "read L bytes".  Basically imposing
+	 * a specific message scheduling algorithm.
+	 *
+	 * Some controller drivers (message-at-a-time queue processing)
+	 * could provide that as their default scheduling algorithm.  But
+	 * others (with multi-message pipelines) could need a flag to
+	 * tell them about such special cases.
+	 */
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
+/* It's fine to embed message and transaction structures in other data
+ * structures so long as you don't free them while they're in use.
+ */
+
+static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags)
+{
+	struct spi_message *m;
+
+	m = kzalloc(sizeof(struct spi_message)
+			+ ntrans * sizeof(struct spi_transfer),
+			flags);
+	if (m) {
+		m->transfers = (void *)(m + 1);
+		m->n_transfer = ntrans;
+	}
+	return m;
+}
+
+static inline void spi_message_free(struct spi_message *m)
+{
+	kfree(m);
+}
+
+/**
+ * spi_setup -- setup SPI mode and clock rate
+ * @spi: the device whose settings are being modified
+ *
+ * SPI protocol drivers may need to update the transfer mode if the
+ * device doesn't work with the mode 0 default.  They may likewise need
+ * to update clock rates or word sizes from initial values.  This function
+ * changes those settings, and must be called from a context that can sleep.
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
+ * indicate complete success) or a negative error code.  After that
+ * callback returns, the driver which issued the transfer request may
+ * deallocate the associated memory; it's no longer in use by any SPI
+ * core or controller driver code.
+ *
+ * Note that although all messages to a spi_device are handled in
+ * FIFO order, messages may go to different devices in other orders.
+ * Some device might be higher priority, or have various "hard" access
+ * time requirements, for example.
+ *
+ * On detection of any fault during the transfer, processing of
+ * the entire message is aborted, and the device is deselected.
+ * Until returning from the associated message completion callback,
+ * no other spi_message queued to that device will be processed.
+ * (This rule applies equally to all the synchronous transfer calls,
+ * which are wrappers around this core asynchronous primitive.)
+ */
+static inline int
+spi_async(struct spi_device *spi, struct spi_message *message)
+{
+	message->spi = spi;
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
+	struct spi_message	m;
+
+	m.transfers	= &t;
+	m.n_transfer	= 1;
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
+	struct spi_message	m;
+
+	m.transfers	= &t;
+	m.n_transfer	= 1;
+	return spi_sync(spi, &m);
+}
+
+/* this copies txbuf and rxbuf data; for small transfers only! */
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
+static inline ssize_t spi_w8r8(struct spi_device *spi, u8 cmd)
+{
+	ssize_t			status;
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
+ *
+ * The number is returned in wire-order, which is at least sometimes
+ * big-endian.
+ */
+static inline ssize_t spi_w8r16(struct spi_device *spi, u8 cmd)
+{
+	ssize_t			status;
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
+	 * controller_data goes to spi_device.controller_data,
+	 * irq is copied too
+	 */
+	char		modalias[KOBJ_NAME_LEN];
+	const void	*platform_data;
+	void		*controller_data;
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
+ * spi_unregister_device() to start making that device vanish, but
+ * normally that would be handled by spi_unregister_master().
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
+++ tmp/drivers/spi/spi.c	2005-12-22 14:53:42.000000000 -0800
@@ -0,0 +1,633 @@
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
+#include <linux/cache.h>
+#include <linux/spi/spi.h>
+
+
+/* SPI bustype and spi_master class are registered after board init code
+ * provides the SPI device tables, ensuring that both are present by the
+ * time controller driver registration causes spi_devices to "enumerate".
+ */
+static void spidev_release(struct device *dev)
+{
+	const struct spi_device	*spi = to_spi_device(dev);
+
+	/* spi masters may cleanup for released devices */
+	if (spi->master->cleanup)
+		spi->master->cleanup(spi);
+
+	spi_master_put(spi->master);
+	kfree(dev);
+}
+
+static ssize_t
+modalias_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	const struct spi_device	*spi = to_spi_device(dev);
+
+	return snprintf(buf, BUS_ID_SIZE + 1, "%s\n", spi->modalias);
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
+	const struct spi_device	*spi = to_spi_device(dev);
+
+	return strncmp(spi->modalias, drv->name, BUS_ID_SIZE) == 0;
+}
+
+static int spi_hotplug(struct device *dev, char **envp, int num_envp,
+		char *buffer, int buffer_size)
+{
+	const struct spi_device		*spi = to_spi_device(dev);
+
+	envp[0] = buffer;
+	snprintf(buffer, buffer_size, "MODALIAS=%s", spi->modalias);
+	envp[1] = NULL;
+	return 0;
+}
+
+#ifdef	CONFIG_PM
+
+/*
+ * NOTE:  the suspend() method for an spi_master controller driver
+ * should verify that all its child devices are marked as suspended;
+ * suspend requests delivered through sysfs power/state files don't
+ * enforce such constraints.
+ */
+static int spi_suspend(struct device *dev, pm_message_t message)
+{
+	int			value;
+	struct spi_driver	*drv = to_spi_driver(dev->driver);
+
+	if (!drv->suspend)
+		return 0;
+
+	/* suspend will stop irqs and dma; no more i/o */
+	value = drv->suspend(to_spi_device(dev), message);
+	if (value == 0)
+		dev->power.power_state = message;
+	return value;
+}
+
+static int spi_resume(struct device *dev)
+{
+	int			value;
+	struct spi_driver	*drv = to_spi_driver(dev->driver);
+
+	if (!drv->resume)
+		return 0;
+
+	/* resume may restart the i/o queue */
+	value = drv->resume(to_spi_device(dev));
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
+
+static int spi_drv_probe(struct device *dev)
+{
+	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+
+	return sdrv->probe(to_spi_device(dev));
+}
+
+static int spi_drv_remove(struct device *dev)
+{
+	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+
+	return sdrv->remove(to_spi_device(dev));
+}
+
+static void spi_drv_shutdown(struct device *dev)
+{
+	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+
+	sdrv->shutdown(to_spi_device(dev));
+}
+
+int spi_register_driver(struct spi_driver *sdrv)
+{
+	sdrv->driver.bus = &spi_bus_type;
+	if (sdrv->probe)
+		sdrv->driver.probe = spi_drv_probe;
+	if (sdrv->remove)
+		sdrv->driver.remove = spi_drv_remove;
+	if (sdrv->shutdown)
+		sdrv->driver.shutdown = spi_drv_shutdown;
+	return driver_register(&sdrv->driver);
+}
+EXPORT_SYMBOL_GPL(spi_register_driver);
+
+/*-------------------------------------------------------------------------*/
+
+/* SPI devices should normally not be created by SPI device drivers; that
+ * would make them board-specific.  Similarly with SPI master drivers.
+ * Device registration normally goes into like arch/.../mach.../board-YYY.c
+ * with other readonly (flashable) information about mainboard devices.
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
+
+/* On typical mainboards, this is purely internal; and it's not needed
+ * after board init creates the hard-wired devices.  Some development
+ * platforms may not be able to use spi_register_board_info though, and
+ * this is exported so that for example a USB or parport based adapter
+ * driver could add devices (which it would learn about out-of-band).
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
+	if (!spi_master_get(master))
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
+	proxy->modalias = chip->modalias;
+
+	snprintf(proxy->dev.bus_id, sizeof proxy->dev.bus_id,
+			"%s.%u", master->cdev.class_id,
+			chip->chip_select);
+	proxy->dev.parent = dev;
+	proxy->dev.bus = &spi_bus_type;
+	proxy->dev.platform_data = (void *) chip->platform_data;
+	proxy->controller_data = chip->controller_data;
+	proxy->controller_state = NULL;
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
+	/* driver core catches callers that misbehave by defining
+	 * devices that already exist.
+	 */
+	status = device_register(&proxy->dev);
+	if (status < 0) {
+		dev_dbg(dev, "can't %s %s, status %d\n",
+				"add", proxy->dev.bus_id, status);
+		goto fail;
+	}
+	dev_dbg(dev, "registered child %s\n", proxy->dev.bus_id);
+	return proxy;
+
+fail:
+	spi_master_put(master);
+	kfree(proxy);
+	return NULL;
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
+	bi = kmalloc(sizeof(*bi) + n * sizeof *info, GFP_KERNEL);
+	if (!bi)
+		return -ENOMEM;
+	bi->n_board_info = n;
+	memcpy(bi->board_info, info, n * sizeof *info);
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
+			/* some controllers only have one chip, so they
+			 * might not use chipselects.  otherwise, the
+			 * chipselects are numbered 0..max.
+			 */
+			if (chip->chip_select >= master->num_chipselect
+					&& master->num_chipselect) {
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
+ * @size: how much driver-private data to preallocate; the pointer to this
+ * 	memory is in the class_data field of the returned class_device,
+ *	accessible with spi_master_get_devdata().
+ *
+ * This call is used only by SPI master controller drivers, which are the
+ * only ones directly touching chip registers.  It's how they allocate
+ * an spi_master structure, prior to calling spi_add_master().
+ *
+ * This must be called from context that can sleep.  It returns the SPI
+ * master structure on success, else NULL.
+ *
+ * The caller is responsible for assigning the bus number and initializing
+ * the master's methods before calling spi_add_master(); and (after errors
+ * adding the device) calling spi_master_put() to prevent a memory leak.
+ */
+struct spi_master * __init_or_module
+spi_alloc_master(struct device *dev, unsigned size)
+{
+	struct spi_master	*master;
+
+	if (!dev)
+		return NULL;
+
+	master = kzalloc(size + sizeof *master, SLAB_KERNEL);
+	if (!master)
+		return NULL;
+
+	class_device_initialize(&master->cdev);
+	master->cdev.class = &spi_master_class;
+	master->cdev.dev = get_device(dev);
+	spi_master_set_devdata(master, &master[1]);
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
+ * After a successful return, the caller is responsible for calling
+ * spi_unregister_master().
+ */
+int __init_or_module
+spi_register_master(struct spi_master *master)
+{
+	static atomic_t		dyn_bus_id = ATOMIC_INIT(0);
+	struct device		*dev = master->cdev.dev;
+	int			status = -ENODEV;
+	int			dynamic = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	/* convention:  dynamically assigned bus IDs count down from the max */
+	if (master->bus_num == 0) {
+		master->bus_num = atomic_dec_return(&dyn_bus_id);
+		dynamic = 1;
+	}
+
+	/* register the device, then userspace will see it.
+	 * registration fails if the bus ID is in use.
+	 */
+	snprintf(master->cdev.class_id, sizeof master->cdev.class_id,
+		"spi%u", master->bus_num);
+	status = class_device_add(&master->cdev);
+	if (status < 0)
+		goto done;
+	dev_dbg(dev, "registered master %s%s\n", master->cdev.class_id,
+			dynamic ? " (dynamic)" : "");
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
+	/* note: before about 2.6.14-rc1 this would corrupt memory: */
+	spi_unregister_device(to_spi_device(dev));
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
+	(void) device_for_each_child(master->cdev.dev, NULL, __unregister);
+	class_device_unregister(&master->cdev);
+	master->cdev.dev = NULL;
+}
+EXPORT_SYMBOL_GPL(spi_unregister_master);
+
+/**
+ * spi_busnum_to_master - look up master associated with bus_num
+ * @bus_num: the master's bus number
+ *
+ * This call may be used with devices that are registered after
+ * arch init time.  It returns a refcounted pointer to the relevant
+ * spi_master (which the caller must release), or NULL if there is
+ * no such master registered.
+ */
+struct spi_master *spi_busnum_to_master(u16 bus_num)
+{
+	if (bus_num) {
+		char			name[8];
+		struct kobject		*bus;
+
+		snprintf(name, sizeof name, "spi%u", bus_num);
+		bus = kset_find_obj(&spi_master_class.subsys.kset, name);
+		if (bus)
+			return container_of(bus, struct spi_master, cdev.kobj);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(spi_busnum_to_master);
+
+
+/*-------------------------------------------------------------------------*/
+
+/**
+ * spi_sync - blocking/synchronous SPI data transfers
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers
+ *
+ * This call may only be used from a context that may sleep.  The sleep
+ * is non-interruptible, and has no timeout.  Low-overhead controller
+ * drivers may DMA directly into and out of the message buffers.
+ *
+ * Note that the SPI device's chip select is active during the message,
+ * and then is normally disabled between messages.  Drivers for some
+ * frequently-used devices may want to minimize costs of selecting a chip,
+ * by leaving it selected in anticipation that the next message will go
+ * to the same chip.  (That may increase power usage.)
+ *
+ * Also, the caller is guaranteeing that the memory associated with the
+ * message will not be freed before this call returns.
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
+EXPORT_SYMBOL_GPL(spi_sync);
+
+#define	SPI_BUFSIZ	(SMP_CACHE_BYTES)
+
+static u8	*buf;
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
+ * This call may only be used from a context that may sleep.
+ *
+ * Parameters to this routine are always copied using a small buffer;
+ * performance-sensitive or bulk transfer code should instead use
+ * spi_{async,sync}() calls with dma-safe buffers.
+ */
+int spi_write_then_read(struct spi_device *spi,
+		const u8 *txbuf, unsigned n_tx,
+		u8 *rxbuf, unsigned n_rx)
+{
+	static DECLARE_MUTEX(lock);
+
+	int			status;
+	struct spi_message	message;
+	struct spi_transfer	x[2];
+	u8			*local_buf;
+
+	/* Use preallocated DMA-safe buffer.  We can't avoid copying here,
+	 * (as a pure convenience thing), but we can keep heap costs
+	 * out of the hot path ...
+	 */
+	if ((n_tx + n_rx) > SPI_BUFSIZ)
+		return -EINVAL;
+
+	/* ... unless someone else is using the pre-allocated buffer */
+	if (down_trylock(&lock)) {
+		local_buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
+		if (!local_buf)
+			return -ENOMEM;
+	} else
+		local_buf = buf;
+
+	memset(x, 0, sizeof x);
+
+	memcpy(local_buf, txbuf, n_tx);
+	x[0].tx_buf = local_buf;
+	x[0].len = n_tx;
+
+	x[1].rx_buf = local_buf + n_tx;
+	x[1].len = n_rx;
+
+	/* do the i/o */
+	message.transfers = x;
+	message.n_transfer = ARRAY_SIZE(x);
+	status = spi_sync(spi, &message);
+	if (status == 0) {
+		memcpy(rxbuf, x[1].rx_buf, n_rx);
+		status = message.status;
+	}
+
+	if (x[0].tx_buf == buf)
+		up(&lock);
+	else
+		kfree(local_buf);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_write_then_read);
+
+/*-------------------------------------------------------------------------*/
+
+static int __init spi_init(void)
+{
+	int	status;
+
+	buf = kmalloc(SPI_BUFSIZ, SLAB_KERNEL);
+	if (!buf) {
+		status = -ENOMEM;
+		goto err0;
+	}
+
+	status = bus_register(&spi_bus_type);
+	if (status < 0)
+		goto err1;
+
+	status = class_register(&spi_master_class);
+	if (status < 0)
+		goto err2;
+	return 0;
+
+err2:
+	bus_unregister(&spi_bus_type);
+err1:
+	kfree(buf);
+	buf = NULL;
+err0:
+	return status;
+}
+
+/* board_info is normally registered in arch_initcall(),
+ * but even essential drivers wait till later
+ *
+ * REVISIT only boardinfo really needs static linking. the rest (device and
+ * driver registration) _could_ be dynamically linked (modular) ... costs
+ * include needing to have boardinfo data structures be much more public.
+ */
+subsys_initcall(spi_init);
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tmp/drivers/spi/Kconfig	2005-12-22 14:53:42.000000000 -0800
@@ -0,0 +1,91 @@
+#
+# SPI driver configuration
+#
+# NOTE:  the reason this doesn't show SPI slave support is mostly that
+# nobody's needed a slave side API yet.  The master-role API is not
+# fully appropriate there, so it'd need some thought to do well.
+#
+menu "SPI support"
+
+# someday this stuff should be set using arch/CPU/PLATFORM/Kconfig
+config SPI_ARCH_HAS_MASTER
+	boolean
+	default y if ARCH_AT91
+	default y if ARCH_OMAP
+	default y if ARCH_PXA
+	default y if X86	# devel hack only!!  (ICH7 can...)
+
+config SPI_ARCH_HAS_SLAVE
+	boolean
+	default y if ARCH_AT91
+	default y if ARCH_OMAP
+	default y if ARCH_PXA
+
+config SPI
+	bool "SPI support"
+	depends on SPI_ARCH_HAS_MASTER || SPI_ARCH_HAS_SLAVE
+	help
+	  The "Serial Peripheral Interface" is a low level synchronous
+	  protocol.  Chips that support SPI can have data transfer rates
+	  up to several tens of Mbit/sec.  Chips are addressed with a
+	  controller and a chipselect.  Most SPI slaves don't support
+	  dynamic device discovery; some are even write-only or read-only.
+	  
+	  SPI is widely used by microcontollers to talk with sensors,
+	  eeprom and flash memory, codecs and various other controller
+	  chips, analog to digital (and d-to-a) converters, and more.
+	  MMC and SD cards can be accessed using SPI protocol; and for
+	  DataFlash cards used in MMC sockets, SPI must always be used.
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
+#
+# MASTER side ... talking to discrete SPI slave chips including microcontrollers
+#
+
+config SPI_MASTER
+#	boolean "SPI Master Support"
+	boolean
+	default SPI && SPI_ARCH_HAS_MASTER
+	help
+	  If your system has an master-capable SPI controller (which
+	  provides the clock and chipselect), you can enable that
+	  controller and the protocol drivers for the SPI slave chips
+	  that are connected.
+
+comment "SPI Master Controller Drivers"
+	depends on SPI_MASTER
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
+	depends on SPI_MASTER
+
+
+#
+# Add new SPI protocol masters in alphabetical order above this line
+#
+
+
+# (slave support would go here)
+
+endmenu # "SPI support"
+
--- tmp.orig/arch/arm/Kconfig	2005-12-22 14:53:26.000000000 -0800
+++ tmp/arch/arm/Kconfig	2005-12-22 14:53:42.000000000 -0800
@@ -730,6 +730,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/hwmon/Kconfig"
 
 #source "drivers/l3/Kconfig"
--- tmp.orig/drivers/Kconfig	2005-12-22 14:53:26.000000000 -0800
+++ tmp/drivers/Kconfig	2005-12-22 14:53:42.000000000 -0800
@@ -44,6 +44,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/spi/Kconfig"
+
 source "drivers/w1/Kconfig"
 
 source "drivers/hwmon/Kconfig"
--- tmp.orig/drivers/Makefile	2005-12-22 14:53:26.000000000 -0800
+++ tmp/drivers/Makefile	2005-12-22 14:53:42.000000000 -0800
@@ -40,6 +40,7 @@ obj-$(CONFIG_FUSION)		+= message/
 obj-$(CONFIG_IEEE1394)		+= ieee1394/
 obj-y				+= cdrom/
 obj-$(CONFIG_MTD)		+= mtd/
+obj-$(CONFIG_SPI)		+= spi/
 obj-$(CONFIG_PCCARD)		+= pcmcia/
 obj-$(CONFIG_DIO)		+= dio/
 obj-$(CONFIG_SBUS)		+= sbus/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tmp/drivers/spi/Makefile	2005-12-22 14:53:42.000000000 -0800
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
+# SPI slave drivers (protocol for that link)
+# 	... add above this line ...
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tmp/Documentation/spi/spi-summary	2005-12-22 14:53:42.000000000 -0800
@@ -0,0 +1,443 @@
+Overview of Linux kernel SPI support
+====================================
+
+02-Dec-2005
+
+What is SPI?
+------------
+The "Serial Peripheral Interface" (SPI) is a synchronous four wire serial
+link used to connect microcontrollers to sensors, memory, and peripherals.
+
+The three signal wires hold a clock (SCLK, often on the order of 10 MHz),
+and parallel data lines with "Master Out, Slave In" (MOSI) or "Master In,
+Slave Out" (MISO) signals.  (Other names are also used.)  There are four
+clocking modes through which data is exchanged; mode-0 and mode-3 are most
+commonly used.  Each clock cycle shifts data out and data in; the clock
+doesn't cycle except when there is data to shift.
+
+SPI masters may use a "chip select" line to activate a given SPI slave
+device, so those three signal wires may be connected to several chips
+in parallel.  All SPI slaves support chipselects.  Some devices have
+other signals, often including an interrupt to the master.
+
+Unlike serial busses like USB or SMBUS, even low level protocols for
+SPI slave functions are usually not interoperable between vendors
+(except for cases like SPI memory chips).
+
+  - SPI may be used for request/response style device protocols, as with
+    touchscreen sensors and memory chips.
+
+  - It may also be used to stream data in either direction (half duplex),
+    or both of them at the same time (full duplex).
+
+  - Some devices may use eight bit words.  Others may different word
+    lengths, such as streams of 12-bit or 20-bit digital samples.
+
+In the same way, SPI slaves will only rarely support any kind of automatic
+discovery/enumeration protocol.  The tree of slave devices accessible from
+a given SPI master will normally be set up manually, with configuration
+tables.
+
+SPI is only one of the names used by such four-wire protocols, and
+most controllers have no problem handling "MicroWire" (think of it as
+half-duplex SPI, for request/response protocols), SSP, SSI, PSP, and
+other related protocols.
+
+Microcontrollers often support both master and slave sides of the SPI
+protocol.  This document (and Linux) currently only supports the master
+side of SPI interactions.
+
+
+Who uses it?  On what kinds of systems?
+---------------------------------------
+Linux developers using SPI are probably writing device drivers for embedded
+systems boards.  SPI is used to control external chips, and it is also a
+protocol supported by every MMC or SD memory card.  (The older "DataFlash"
+cards, predating MMC cards but using the same connectors and card shape,
+support only SPI.)  Some PC hardware uses SPI flash for BIOS code.
+
+SPI slave chips range from digital/analog converters used for analog
+sensors and codecs, to memory, to peripherals like USB controllers
+or Ethernet adapters; and more.
+
+Most systems using SPI will integrate a few devices on a mainboard.
+Some provide SPI links on expansion connectors; in cases where no
+dedicated SPI controller exists, GPIO pins can be used to create a
+low speed "bitbanging" adapter.  Very few systems will "hotplug" an SPI
+controller; the reasons to use SPI focus on low cost and simple operation,
+and if dynamic reconfiguration is important, USB will often be a more
+appropriate low-pincount peripheral bus.
+
+Many microcontrollers that can run Linux integrate one or more I/O
+interfaces with SPI modes.  Given SPI support, they could use MMC or SD
+cards without needing a special purpose MMC/SD/SDIO controller.
+
+
+How do these driver programming interfaces work?
+------------------------------------------------
+The <linux/spi/spi.h> header file includes kerneldoc, as does the
+main source code, and you should certainly read that.  This is just
+an overview, so you get the big picture before the details.
+
+SPI requests always go into I/O queues.  Requests for a given SPI device
+are always executed in FIFO order, and complete asynchronously through
+completion callbacks.  There are also some simple synchronous wrappers
+for those calls, including ones for common transaction types like writing
+a command and then reading its response.
+
+There are two types of SPI driver, here called:
+
+  Controller drivers ... these are often built in to System-On-Chip
+	processors, and often support both Master and Slave roles.
+	These drivers touch hardware registers and may use DMA.
+	Or they can be PIO bitbangers, needing just GPIO pins.
+
+  Protocol drivers ... these pass messages through the controller
+	driver to communicate with a Slave or Master device on the
+	other side of an SPI link.
+
+So for example one protocol driver might talk to the MTD layer to export
+data to filesystems stored on SPI flash like DataFlash; and others might
+control audio interfaces, present touchscreen sensors as input interfaces,
+or monitor temperature and voltage levels during industrial processing.
+And those might all be sharing the same controller driver.
+
+A "struct spi_device" encapsulates the master-side interface between
+those two types of driver.  At this writing, Linux has no slave side
+programming interface.
+
+There is a minimal core of SPI programming interfaces, focussing on
+using driver model to connect controller and protocol drivers using
+device tables provided by board specific initialization code.  SPI
+shows up in sysfs in several locations:
+
+   /sys/devices/.../CTLR/spiB.C ... spi_device for on bus "B",
+	chipselect C, accessed through CTLR.
+
+   /sys/bus/spi/devices/spiB.C ... symlink to the physical
+   	spiB-C device
+
+   /sys/bus/spi/drivers/D ... driver for one or more spi*.* devices
+
+   /sys/class/spi_master/spiB ... class device for the controller
+	managing bus "B".  All the spiB.* devices share the same
+	physical SPI bus segment, with SCLK, MOSI, and MISO.
+
+
+How does board-specific init code declare SPI devices?
+------------------------------------------------------
+Linux needs several kinds of information to properly configure SPI devices.
+That information is normally provided by board-specific code, even for
+chips that do support some of automated discovery/enumeration.
+
+DECLARE CONTROLLERS
+
+The first kind of information is a list of what SPI controllers exist.
+For System-on-Chip (SOC) based boards, these will usually be platform
+devices, and the controller may need some platform_data in order to
+operate properly.  The "struct platform_device" will include resources
+like the physical address of the controller's first register and its IRQ.
+
+Platforms will often abstract the "register SPI controller" operation,
+maybe coupling it with code to initialize pin configurations, so that
+the arch/.../mach-*/board-*.c files for several boards can all share the
+same basic controller setup code.  This is because most SOCs have several
+SPI-capable controllers, and only the ones actually usable on a given
+board should normally be set up and registered.
+
+So for example arch/.../mach-*/board-*.c files might have code like:
+
+	#include <asm/arch/spi.h>	/* for mysoc_spi_data */
+
+	/* if your mach-* infrastructure doesn't support kernels that can
+	 * run on multiple boards, pdata wouldn't benefit from "__init".
+	 */
+	static struct mysoc_spi_data __init pdata = { ... };
+
+	static __init board_init(void)
+	{
+		...
+		/* this board only uses SPI controller #2 */
+		mysoc_register_spi(2, &pdata);
+		...
+	}
+
+And SOC-specific utility code might look something like:
+
+	#include <asm/arch/spi.h>
+
+	static struct platform_device spi2 = { ... };
+
+	void mysoc_register_spi(unsigned n, struct mysoc_spi_data *pdata)
+	{
+		struct mysoc_spi_data *pdata2;
+
+		pdata2 = kmalloc(sizeof *pdata2, GFP_KERNEL);
+		*pdata2 = pdata;
+		...
+		if (n == 2) {
+			spi2->dev.platform_data = pdata2;
+			register_platform_device(&spi2);
+
+			/* also: set up pin modes so the spi2 signals are
+			 * visible on the relevant pins ... bootloaders on
+			 * production boards may already have done this, but
+			 * developer boards will often need Linux to do it.
+			 */
+		}
+		...
+	}
+
+Notice how the platform_data for boards may be different, even if the
+same SOC controller is used.  For example, on one board SPI might use
+an external clock, where another derives the SPI clock from current
+settings of some master clock.
+
+
+DECLARE SLAVE DEVICES
+
+The second kind of information is a list of what SPI slave devices exist
+on the target board, often with some board-specific data needed for the
+driver to work correctly.
+
+Normally your arch/.../mach-*/board-*.c files would provide a small table
+listing the SPI devices on each board.  (This would typically be only a
+small handful.)  That might look like:
+
+	static struct ads7846_platform_data ads_info = {
+		.vref_delay_usecs	= 100,
+		.x_plate_ohms		= 580,
+		.y_plate_ohms		= 410,
+	};
+
+	static struct spi_board_info spi_board_info[] __initdata = {
+	{
+		.modalias	= "ads7846",
+		.platform_data	= &ads_info,
+		.mode		= SPI_MODE_0,
+		.irq		= GPIO_IRQ(31),
+		.max_speed_hz	= 120000 /* max sample rate at 3V */ * 16,
+		.bus_num	= 1,
+		.chip_select	= 0,
+	},
+	};
+
+Again, notice how board-specific information is provided; each chip may need
+several types.  This example shows generic constraints like the fastest SPI
+clock to allow (a function of board voltage in this case) or how an IRQ pin
+is wired, plus chip-specific constraints like an important delay that's
+changed by the capacitance at one pin.
+
+(There's also "controller_data", information that may be useful to the
+controller driver.  An example would be peripheral-specific DMA tuning
+data or chipselect callbacks.  This is stored in spi_device later.)
+
+The board_info should provide enough information to let the system work
+without the chip's driver being loaded.  The most troublesome aspect of
+that is likely the SPI_CS_HIGH bit in the spi_device.mode field, since
+sharing a bus with a device that interprets chipselect "backwards" is
+not possible.
+
+Then your board initialization code would register that table with the SPI
+infrastructure, so that it's available later when the SPI master controller
+driver is registered:
+
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
+Like with other static board-specific setup, you won't unregister those.
+
+
+NON-STATIC CONFIGURATIONS
+
+Developer boards often play by different rules than product boards, and one
+example is the potential need to hotplug SPI devices and/or controllers.
+
+For those cases you might need to use use spi_busnum_to_master() to look
+up the spi bus master, and will likely need spi_new_device() to provide the
+board info based on the board that was hotplugged.  Of course, you'd later
+call at least spi_unregister_device() when that board is removed.
+
+
+How do I write an "SPI Protocol Driver"?
+----------------------------------------
+All SPI drivers are currently kernel drivers.  A userspace driver API
+would just be another kernel driver, probably offering some lowlevel
+access through aio_read(), aio_write(), and ioctl() calls and using the
+standard userspace sysfs mechanisms to bind to a given SPI device.
+
+SPI protocol drivers somewhat resemble platform device drivers:
+
+	static struct spi_driver CHIP_driver = {
+		.driver = {
+			.name		= "CHIP",
+			.bus		= &spi_bus_type,
+			.owner		= THIS_MODULE,
+		},
+
+		.probe		= CHIP_probe,
+		.remove		= __devexit_p(CHIP_remove),
+		.suspend	= CHIP_suspend,
+		.resume		= CHIP_resume,
+	};
+
+The driver core will autmatically attempt to bind this driver to any SPI
+device whose board_info gave a modalias of "CHIP".  Your probe() code
+might look like this unless you're creating a class_device:
+
+	static int __devinit CHIP_probe(struct spi_device *spi)
+	{
+		struct CHIP			*chip;
+		struct CHIP_platform_data	*pdata;
+
+		/* assuming the driver requires board-specific data: */
+		pdata = &spi->dev.platform_data;
+		if (!pdata)
+			return -ENODEV;
+
+		/* get memory for driver's per-chip state */
+		chip = kzalloc(sizeof *chip, GFP_KERNEL);
+		if (!chip)
+			return -ENOMEM;
+		dev_set_drvdata(&spi->dev, chip);
+
+		... etc
+		return 0;
+	}
+
+As soon as it enters probe(), the driver may issue I/O requests to
+the SPI device using "struct spi_message".  When remove() returns,
+the driver guarantees that it won't submit any more such messages.
+
+  - An spi_message is a sequence of of protocol operations, executed
+    as one atomic sequence.  SPI driver controls include:
+
+      + when bidirectional reads and writes start ... by how its
+        sequence of spi_transfer requests is arranged;
+
+      + optionally defining short delays after transfers ... using
+        the spi_transfer.delay_usecs setting;
+
+      + whether the chipselect becomes inactive after a transfer and
+        any delay ... by using the spi_transfer.cs_change flag;
+
+      + hinting whether the next message is likely to go to this same
+        device ... using the spi_transfer.cs_change flag on the last
+	transfer in that atomic group, and potentially saving costs
+	for chip deselect and select operations.
+
+  - Follow standard kernel rules, and provide DMA-safe buffers in
+    your messages.  That way controller drivers using DMA aren't forced
+    to make extra copies unless the hardware requires it (e.g. working
+    around hardware errata that force the use of bounce buffering).
+
+    If standard dma_map_single() handling of these buffers is inappropriate,
+    you can use spi_message.is_dma_mapped to tell the controller driver
+    that you've already provided the relevant DMA addresses.
+
+  - The basic I/O primitive is spi_async().  Async requests may be
+    issued in any context (irq handler, task, etc) and completion
+    is reported using a callback provided with the message.
+    After any detected error, the chip is deselected and processing
+    of that spi_message is aborted.
+
+  - There are also synchronous wrappers like spi_sync(), and wrappers
+    like spi_read(), spi_write(), and spi_write_then_read().  These
+    may be issued only in contexts that may sleep, and they're all
+    clean (and small, and "optional") layers over spi_async().
+
+  - The spi_write_then_read() call, and convenience wrappers around
+    it, should only be used with small amounts of data where the
+    cost of an extra copy may be ignored.  It's designed to support
+    common RPC-style requests, such as writing an eight bit command
+    and reading a sixteen bit response -- spi_w8r16() being one its
+    wrappers, doing exactly that.
+
+Some drivers may need to modify spi_device characteristics like the
+transfer mode, wordsize, or clock rate.  This is done with spi_setup(),
+which would normally be called from probe() before the first I/O is
+done to the device.
+
+While "spi_device" would be the bottom boundary of the driver, the
+upper boundaries might include sysfs (especially for sensor readings),
+the input layer, ALSA, networking, MTD, the character device framework,
+or other Linux subsystems.
+
+Note that there are two types of memory your driver must manage as part
+of interacting with SPI devices.
+
+  - I/O buffers use the usual Linux rules, and must be DMA-safe.
+    You'd normally allocate them from the heap or free page pool.
+    Don't use the stack, or anything that's declared "static".
+    
+  - The spi_message and spi_transfer metadata used to glue those
+    I/O buffers into a group of protocol transactions.  These can
+    be allocated anywhere it's convenient, including as part of
+    other allocate-once driver data structures.  Zero-init these.
+
+If you like, spi_message_alloc() and spi_message_free() convenience
+routines are available to allocate and zero-initialize an spi_message
+with several transfers.
+
+
+How do I write an "SPI Master Controller Driver"?
+-------------------------------------------------
+An SPI controller will probably be registered on the platform_bus; write
+a driver to bind to the device, whichever bus is involved.
+
+The main task of this type of driver is to provide an "spi_master".
+Use spi_alloc_master() to allocate the master, and class_get_devdata()
+to get the driver-private data allocated for that device.
+
+	struct spi_master	*master;
+	struct CONTROLLER	*c;
+
+	master = spi_alloc_master(dev, sizeof *c);
+	if (!master)
+		return -ENODEV;
+
+	c = class_get_devdata(&master->cdev);
+
+The driver will initialize the fields of that spi_master, including the
+bus number (maybe the same as the platform device ID) and three methods
+used to interact with the SPI core and SPI protocol drivers.  It will
+also initialize its own internal state.
+
+    master->setup(struct spi_device *spi)
+	This sets up the device clock rate, SPI mode, and word sizes.
+	Drivers may change the defaults provided by board_info, and then
+	call spi_setup(spi) to invoke this routine.  It may sleep.
+
+    master->transfer(struct spi_device *spi, struct spi_message *message)
+    	This must not sleep.  Its responsibility is arrange that the
+	transfer happens and its complete() callback is issued; the two
+	will normally happen later, after other transfers complete.
+
+    master->cleanup(struct spi_device *spi)
+	Your controller driver may use spi_device.controller_state to hold
+	state it dynamically associates with that device.  If you do that,
+	be sure to provide the cleanup() method to free that state.
+
+The bulk of the driver will be managing the I/O queue fed by transfer().
+
+That queue could be purely conceptual.  For example, a driver used only
+for low-frequency sensor acess might be fine using synchronous PIO.
+
+But the queue will probably be very real, using message->queue, PIO,
+often DMA (especially if the root filesystem is in SPI flash), and
+execution contexts like IRQ handlers, tasklets, or workqueues (such
+as keventd).  Your driver can be as fancy, or as simple, as you need.
+
+
+THANKS TO
+---------
+Contributors to Linux-SPI discussions include (in alphabetical order,
+by last name):
+
+David Brownell
+Russell King
+Dmitry Pervushin
+Stephen Street
+Mark Underwood
+Andrew Victor
+Vitaly Wool
+

--Boundary-00=_9izqDku7O08uaeG--
