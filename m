Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbVLDA2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVLDA2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVLDA2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:28:13 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:4701 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932182AbVLDA2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:28:09 -0500
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-rc3-mm1 1/4] add spi_driver to SPI framework
Date: Sat, 3 Dec 2005 16:23:21 -0800
User-Agent: KMail/1.7.1
Cc: Mark Underwood <basicmark@yahoo.com>,
       Stephen Street <stephen@streetfiresound.com>,
       Vitaly Wool <vwool@ru.mvista.com>
MIME-Version: 1.0
Message-Id: <200512031623.21229.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5bjkDL7WIDmFpPi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_5bjkDL7WIDmFpPi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There seems to be agreement that we should have a "struct spi_driver",
so here's a patch which switches over to that, and updates the docs
accordingly.  It also adds a few other changes, few of which would be
detectable to drivers.

- Dave


--Boundary-00=_5bjkDL7WIDmFpPi
Content-Type: text/x-diff;
  charset="us-ascii";
  name="spi-refresh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spi-refresh.patch"

This is a refresh of the "Simple SPI Framework" found in 2.6.15-rc3-mm1
which makes the following changes:

  * There's now a "struct spi_driver".  This increase the footprint
    of the core a bit, since it now includes code to do what the driver
    core was previously handling directly.  Documentation and comments
    were updated to match.

  * spi_alloc_master() now does class_device_initialize(), so it can
    at least be refcounted before spi_register_master().  To match,
    spi_register_master() switched over to class_device_add().

  * States explicitly that after transfer errors, spi_devices will be
    deselected.  We want fault recovery procedures to work the same
    for all controller drivers.

  * Minor tweaks:  controller_data no longer points to readonly data;
    prevent some potential cast-from-null bugs with container_of calls;
    clarifies some existing kerneldoc, 

And a few small cleanups.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: mm-tmp/include/linux/spi/spi.h
===================================================================
--- mm-tmp.orig/include/linux/spi/spi.h	2005-12-03 14:12:03.000000000 -0800
+++ mm-tmp/include/linux/spi/spi.h	2005-12-03 14:22:55.000000000 -0800
@@ -20,13 +20,8 @@
 #define __LINUX_SPI_H
 
 /*
- * INTERFACES between SPI master drivers and infrastructure
+ * INTERFACES between SPI master-side drivers and SPI infrastructure.
  * (There's no SPI slave support for Linux yet...)
- *
- * A "struct device_driver" for an spi_device uses "spi_bus_type" and
- * needs no special API wrappers (much like platform_bus).  These drivers
- * are bound to devices based on their names (much like platform_bus),
- * and are available in dev->driver.
  */
 extern struct bus_type spi_bus_type;
 
@@ -46,8 +41,8 @@ extern struct bus_type spi_bus_type;
  * @irq: Negative, or the number passed to request_irq() to receive
  * 	interrupts from this device.
  * @controller_state: Controller's runtime state
- * @controller_data: Static board-specific definitions for controller, such
- * 	as FIFO initialization parameters; from board_info.controller_data
+ * @controller_data: Board-specific definitions for controller, such as
+ * 	FIFO initialization parameters; from board_info.controller_data
  *
  * An spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -63,31 +58,32 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			mode;
-#define	SPI_CPHA	0x01		/* clock phase */
-#define	SPI_CPOL	0x02		/* clock polarity */
+#define	SPI_CPHA	0x01			/* clock phase */
+#define	SPI_CPOL	0x02			/* clock polarity */
 #define	SPI_MODE_0	(0|0)
-#define	SPI_MODE_1	(0|SPI_CPHA)
+#define	SPI_MODE_1	(0|SPI_CPHA)		/* (original MicroWire) */
 #define	SPI_MODE_2	(SPI_CPOL|0)
 #define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
-#define	SPI_CS_HIGH	0x04		/* chipselect active high? */
+#define	SPI_CS_HIGH	0x04			/* chipselect active high? */
 	u8			bits_per_word;
 	int			irq;
 	void			*controller_state;
-	const void		*controller_data;
+	void			*controller_data;
 	const char		*modalias;
 
 	// likely need more hooks for more protocol options affecting how
-	// the controller talks to its chips, like:
+	// the controller talks to each chip, like:
 	//  - bit order (default is wordwise msb-first)
 	//  - memory packing (12 bit samples into low bits, others zeroed)
 	//  - priority
+	//  - drop chipselect after each word
 	//  - chipselect delays
 	//  - ...
 };
 
 static inline struct spi_device *to_spi_device(struct device *dev)
 {
-	return container_of(dev, struct spi_device, dev);
+	return dev ? container_of(dev, struct spi_device, dev) : NULL;
 }
 
 /* most drivers won't need to care about device refcounting */
@@ -117,12 +113,38 @@ static inline void spi_set_ctldata(struc
 struct spi_message;
 
 
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
 /**
  * struct spi_master - interface to SPI master controller
  * @cdev: class interface to this driver
  * @bus_num: board-specific (and often SOC-specific) identifier for a
  * 	given SPI controller.
- * @num_chipselects: chipselects are used to distinguish individual
+ * @num_chipselect: chipselects are used to distinguish individual
  * 	SPI slaves, and are numbered from zero to num_chipselects.
  * 	each slave has a chipselect signal, but it's common that not
  * 	every chipselect is connected to a slave.
@@ -225,7 +247,7 @@ extern struct spi_master *spi_busnum_to_
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
  * 	(optionally) changing the chipselect status, then starting
- * 	the next transfer or completing this spi_message.
+ * 	the next transfer or completing this spi_message. 
  *
  * SPI transfers always write the same number of bytes as they read.
  * Protocol drivers should always provide rx_buf and/or tx_buf.
@@ -275,7 +297,8 @@ struct spi_transfer {
  *	addresses for each transfer buffer
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
- * @actual_length: how many bytes were transferd
+ * @actual_length: the total number of bytes that were transferred in all
+ *	successful segments
  * @status: zero for success, else negative errno
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
@@ -295,9 +318,9 @@ struct spi_message {
 	 *
 	 * Some controller drivers (message-at-a-time queue processing)
 	 * could provide that as their default scheduling algorithm.  But
-	 * others (with multi-message pipelines) would need a flag to
+	 * others (with multi-message pipelines) could need a flag to
 	 * tell them about such special cases.
-	 */
+	 */ 
 
 	/* completion is reported through a callback */
 	void 			FASTCALL((*complete)(void *context));
@@ -346,6 +369,13 @@ spi_setup(struct spi_device *spi)
  * FIFO order, messages may go to different devices in other orders.
  * Some device might be higher priority, or have various "hard" access
  * time requirements, for example.
+ *
+ * On detection of any fault during the transfer, processing of
+ * the entire message is aborted, and the device is deselected.
+ * Until returning from the associated message completion callback,
+ * no other spi_message queued to that device will be processed.
+ * (This rule applies equally to all the synchronous transfer calls,
+ * which are wrappers around this core asynchronous primitive.)
  */
 static inline int
 spi_async(struct spi_device *spi, struct spi_message *message)
@@ -484,12 +514,12 @@ struct spi_board_info {
 	 * "modalias" is normally the driver name.
 	 *
 	 * platform_data goes to spi_device.dev.platform_data,
-	 * controller_data goes to spi_device.platform_data,
+	 * controller_data goes to spi_device.controller_data,
 	 * irq is copied too
 	 */
 	char		modalias[KOBJ_NAME_LEN];
 	const void	*platform_data;
-	const void	*controller_data;
+	void		*controller_data;
 	int		irq;
 
 	/* slower signaling on noisy or low voltage boards */
@@ -525,9 +555,8 @@ spi_register_board_info(struct spi_board
 
 
 /* If you're hotplugging an adapter with devices (parport, usb, etc)
- * use spi_new_device() to describe each device.  You can also call
- * spi_unregister_device() to get start making that device vanish,
- * but normally that would be handled by spi_unregister_master().
+ * use spi_new_device() to describe each device.  You would then call
+ * spi_unregister_device() to start making that device vanish.
  */
 extern struct spi_device *
 spi_new_device(struct spi_master *, struct spi_board_info *);
Index: mm-tmp/drivers/spi/spi.c
===================================================================
--- mm-tmp.orig/drivers/spi/spi.c	2005-12-03 14:12:03.000000000 -0800
+++ mm-tmp/drivers/spi/spi.c	2005-12-03 14:45:04.000000000 -0800
@@ -26,13 +26,9 @@
 #include <linux/spi/spi.h>
 
 
-/* SPI bustype and spi_master class are registered during early boot,
- * usually before board init code provides the SPI device tables, and
- * are available later when driver init code needs them.
- *
- * Drivers for SPI devices started out like those for platform bus
- * devices.  But both have changed in 2.6.15; maybe this should get
- * an "spi_driver" structure at some point (not currently needed)
+/* SPI bustype and spi_master class are registered after board init code
+ * provides the SPI device tables, ensuring that both are present by the
+ * time controller driver registration causes spi_devices to "enumerate".
  */
 static void spidev_release(struct device *dev)
 {
@@ -83,10 +79,7 @@ static int spi_hotplug(struct device *de
 
 #ifdef	CONFIG_PM
 
-/* Suspend/resume in "struct device_driver" don't really need that
- * strange third parameter, so we just make it a constant and expect
- * SPI drivers to ignore it just like most platform drivers do.
- *
+/*
  * NOTE:  the suspend() method for an spi_master controller driver
  * should verify that all its child devices are marked as suspended;
  * suspend requests delivered through sysfs power/state files don't
@@ -94,13 +87,14 @@ static int spi_hotplug(struct device *de
  */
 static int spi_suspend(struct device *dev, pm_message_t message)
 {
-	int	value;
+	int			value;
+	struct spi_driver	*drv = to_spi_driver(dev->driver);
 
-	if (!dev->driver || !dev->driver->suspend)
+	if (!drv || !drv->suspend)
 		return 0;
 
 	/* suspend will stop irqs and dma; no more i/o */
-	value = dev->driver->suspend(dev, message);
+	value = drv->suspend(to_spi_device(dev), message);
 	if (value == 0)
 		dev->power.power_state = message;
 	return value;
@@ -108,13 +102,14 @@ static int spi_suspend(struct device *de
 
 static int spi_resume(struct device *dev)
 {
-	int	value;
+	int			value;
+	struct spi_driver	*drv = to_spi_driver(dev->driver);
 
-	if (!dev->driver || !dev->driver->resume)
+	if (!drv || !drv->resume)
 		return 0;
 
 	/* resume may restart the i/o queue */
-	value = dev->driver->resume(dev);
+	value = drv->resume(to_spi_device(dev));
 	if (value == 0)
 		dev->power.power_state = PMSG_ON;
 	return value;
@@ -135,6 +130,41 @@ struct bus_type spi_bus_type = {
 };
 EXPORT_SYMBOL_GPL(spi_bus_type);
 
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
 /*-------------------------------------------------------------------------*/
 
 /* SPI devices should normally not be created by SPI device drivers; that
@@ -208,13 +238,15 @@ spi_new_device(struct spi_master *master
 	if (status < 0) {
 		dev_dbg(dev, "can't %s %s, status %d\n",
 				"add", proxy->dev.bus_id, status);
-fail:
-		class_device_put(&master->cdev);
-		kfree(proxy);
-		return NULL;
+		goto fail;
 	}
 	dev_dbg(dev, "registered child %s\n", proxy->dev.bus_id);
 	return proxy;
+
+fail:
+	class_device_put(&master->cdev);
+	kfree(proxy);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(spi_new_device);
 
@@ -237,11 +269,11 @@ spi_register_board_info(struct spi_board
 {
 	struct boardinfo	*bi;
 
-	bi = kmalloc (sizeof (*bi) + n * sizeof (*info), GFP_KERNEL);
+	bi = kmalloc(sizeof(*bi) + n * sizeof *info, GFP_KERNEL);
 	if (!bi)
 		return -ENOMEM;
 	bi->n_board_info = n;
-	memcpy(bi->board_info, info, n * sizeof (*info));
+	memcpy(bi->board_info, info, n * sizeof *info);
 
 	down(&board_lock);
 	list_add_tail(&bi->list, &board_list);
@@ -330,6 +362,7 @@ spi_alloc_master(struct device *dev, uns
 	if (!master)
 		return NULL;
 
+	class_device_initialize(&master->cdev);
 	master->cdev.class = &spi_master_class;
 	master->cdev.dev = get_device(dev);
 	class_set_devdata(&master->cdev, &master[1]);
@@ -366,7 +399,7 @@ spi_register_master(struct spi_master *m
 	/* convention:  dynamically assigned bus IDs count down from the max */
 	if (master->bus_num == 0) {
 		master->bus_num = atomic_dec_return(&dyn_bus_id);
-		dynamic = 0;
+		dynamic = 1;
 	}
 
 	/* register the device, then userspace will see it.
@@ -374,11 +407,9 @@ spi_register_master(struct spi_master *m
 	 */
 	snprintf(master->cdev.class_id, sizeof master->cdev.class_id,
 		"spi%u", master->bus_num);
-	status = class_device_register(&master->cdev);
-	if (status < 0) {
-		class_device_put(&master->cdev);
+	status = class_device_add(&master->cdev);
+	if (status < 0)
 		goto done;
-	}
 	dev_dbg(dev, "registered master %s%s\n", master->cdev.class_id,
 			dynamic ? " (dynamic)" : "");
 
@@ -491,6 +522,7 @@ static u8	*buf;
  * This performs a half duplex MicroWire style transaction with the
  * device, sending txbuf and then reading rxbuf.  The return value
  * is zero for success, else a negative errno status code.
+ * This call may only be used from a context that may sleep.
  *
  * Parameters to this routine are always copied using a small buffer,
  * large transfers should use use spi_{async,sync}() calls with
@@ -541,16 +573,38 @@ EXPORT_SYMBOL_GPL(spi_write_then_read);
 
 static int __init spi_init(void)
 {
+	int	status;
+
 	buf = kmalloc(SPI_BUFSIZ, SLAB_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	if (!buf) {
+		status = -ENOMEM;
+		goto err0;
+	}
 
-	bus_register(&spi_bus_type);
-	class_register(&spi_master_class);
+	status = bus_register(&spi_bus_type);
+	if (status < 0)
+		goto err1;
+
+	status = class_register(&spi_master_class);
+	if (status < 0)
+		goto err2;
 	return 0;
+
+err2:
+	bus_unregister(&spi_bus_type);
+err1:
+	kfree(buf);
+	buf = NULL;
+err0:
+	return status;
 }
+
 /* board_info is normally registered in arch_initcall(),
  * but even essential drivers wait till later
+ *
+ * REVISIT only boardinfo really needs static linking. the rest (device and
+ * driver registration) _could_ be dynamically linked (modular) ... costs
+ * include needing to have boardinfo data structures be much more public.
  */
 subsys_initcall(spi_init);
 
Index: mm-tmp/Documentation/spi/spi-summary
===================================================================
--- mm-tmp.orig/Documentation/spi/spi-summary	2005-12-03 14:12:03.000000000 -0800
+++ mm-tmp/Documentation/spi/spi-summary	2005-12-03 14:19:41.000000000 -0800
@@ -1,18 +1,19 @@
 Overview of Linux kernel SPI support
 ====================================
 
-22-Nov-2005
+02-Dec-2005
 
 What is SPI?
 ------------
-The "Serial Peripheral Interface" (SPI) is a four-wire point-to-point
-serial link used to connect microcontrollers to sensors and memory.
+The "Serial Peripheral Interface" (SPI) is a synchronous four wire serial
+link used to connect microcontrollers to sensors, memory, and peripherals.
 
 The three signal wires hold a clock (SCLK, often on the order of 10 MHz),
 and parallel data lines with "Master Out, Slave In" (MOSI) or "Master In,
 Slave Out" (MISO) signals.  (Other names are also used.)  There are four
 clocking modes through which data is exchanged; mode-0 and mode-3 are most
-commonly used.
+commonly used.  Each clock cycle shifts data out and data in; the clock
+doesn't cycle except when there is data to shift.
 
 SPI masters may use a "chip select" line to activate a given SPI slave
 device, so those three signal wires may be connected to several chips
@@ -79,11 +80,18 @@ The <linux/spi/spi.h> header file includ
 main source code, and you should certainly read that.  This is just
 an overview, so you get the big picture before the details.
 
+SPI requests always go into I/O queues.  Requests for a given SPI device
+are always executed in FIFO order, and complete asynchronously through
+completion callbacks.  There are also some simple synchronous wrappers
+for those calls, including ones for common transaction types like writing
+a command and then reading its response.
+
 There are two types of SPI driver, here called:
 
   Controller drivers ... these are often built in to System-On-Chip
 	processors, and often support both Master and Slave roles.
 	These drivers touch hardware registers and may use DMA.
+	Or they can be PIO bitbangers, needing just GPIO pins.
 
   Protocol drivers ... these pass messages through the controller
 	driver to communicate with a Slave or Master device on the
@@ -116,11 +124,6 @@ shows up in sysfs in several locations:
 	managing bus "B".  All the spiB.* devices share the same
 	physical SPI bus segment, with SCLK, MOSI, and MISO.
 
-The basic I/O primitive submits an asynchronous message to an I/O queue
-maintained by the controller driver.  A completion callback is issued
-asynchronously when the data transfer(s) in that message completes.
-There are also some simple synchronous wrappers for those calls.
-
 
 How does board-specific init code declare SPI devices?
 ------------------------------------------------------
@@ -253,7 +256,7 @@ example is the potential need to hotplug
 For those cases you might need to use use spi_busnum_to_master() to look
 up the spi bus master, and will likely need spi_new_device() to provide the
 board info based on the board that was hotplugged.  Of course, you'd later
-call at least spi_unregister_device() when that board is removed.
+call at least spi_unregister_device() when that board is removed. 
 
 
 How do I write an "SPI Protocol Driver"?
@@ -263,33 +266,40 @@ would just be another kernel driver, pro
 access through aio_read(), aio_write(), and ioctl() calls and using the
 standard userspace sysfs mechanisms to bind to a given SPI device.
 
-SPI protocol drivers are normal device drivers, with no more wrapper
-than needed by platform devices:
+SPI protocol drivers somewhat resemble platform device drivers:
+
+	static struct spi_driver CHIP_driver = {
+		.driver = {
+			.name		= "CHIP",
+			.bus		= &spi_bus_type,
+			.owner		= THIS_MODULE,
+		},
 
-	static struct device_driver CHIP_driver = {
-		.name		= "CHIP",
-		.bus		= &spi_bus_type,
 		.probe		= CHIP_probe,
-		.remove		= __exit_p(CHIP_remove),
+		.remove		= __devexit_p(CHIP_remove),
 		.suspend	= CHIP_suspend,
 		.resume		= CHIP_resume,
 	};
 
-The SPI core will autmatically attempt to bind this driver to any SPI
+The driver core will autmatically attempt to bind this driver to any SPI
 device whose board_info gave a modalias of "CHIP".  Your probe() code
 might look like this unless you're creating a class_device:
 
-	static int __init CHIP_probe(struct device *dev)
+	static int __devinit CHIP_probe(struct spi_device *spi)
 	{
-		struct spi_device		*spi = to_spi_device(dev);
 		struct CHIP			*chip;
-		struct CHIP_platform_data	*pdata = dev->platform_data;
+		struct CHIP_platform_data	*pdata;
+
+		/* assuming the driver requires board-specific data: */
+		pdata = &spi->dev.platform_data;
+		if (!pdata)
+			return -ENODEV;
 
 		/* get memory for driver's per-chip state */
 		chip = kzalloc(sizeof *chip, GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
-		dev_set_drvdata(dev, chip);
+		dev_set_drvdata(&spi->dev, chip);
 
 		... etc
 		return 0;
@@ -328,7 +338,9 @@ the driver guarantees that it won't subm
   - The basic I/O primitive is spi_async().  Async requests may be
     issued in any context (irq handler, task, etc) and completion
     is reported using a callback provided with the message.
-
+    After any detected error, the chip is deselected and processing
+    of that spi_message is aborted.
+    
   - There are also synchronous wrappers like spi_sync(), and wrappers
     like spi_read(), spi_write(), and spi_write_then_read().  These
     may be issued only in contexts that may sleep, and they're all

--Boundary-00=_5bjkDL7WIDmFpPi--
