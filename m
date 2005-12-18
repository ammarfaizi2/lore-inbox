Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVLRTQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVLRTQh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbVLRTQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:16:37 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:19278 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932484AbVLRTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:16:36 -0500
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-rc5-mm3 1/3] SPI core tweaks, bugfix
Date: Sun, 18 Dec 2005 10:37:39 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zxapD+N1H27KSXe"
Message-Id: <200512181037.39154.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_zxapD+N1H27KSXe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The bugfix was on the spi_unregister_master() path, various folk have
reported problems and I suspect this will resolve them.

The API tweaks are some inlined wrappers and doc updates, plus small
error checks.

--Boundary-00=_zxapD+N1H27KSXe
Content-Type: text/x-diff;
  charset="us-ascii";
  name="spi-core-updates.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spi-core-updates.patch"

This includes various updates to the SPI core:

  - Fixes a driver model refcount bug in spi_unregister_master() paths.

  - The spi_master structures now have wrappers which help keep drivers
    from needing class-level get/put for device data or for refcounts.

  - Check for a few setup errors that would cause oopsing later.

  - Docs say more about memory management.  Highlights the use of DMA-safe
    i/o buffers, and zero-initializing spi_message and such metadata.

  - Provide a simple alloc/free for spi_message and its spi_transfer;
    this is only one of the possible memory management policies.

Nothing to break code that already works.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- mm3.orig.orig/include/linux/spi/spi.h	2005-12-18 08:52:45.000000000 -0800
+++ mm3.orig/include/linux/spi/spi.h	2005-12-18 08:52:49.000000000 -0800
@@ -60,8 +60,8 @@ struct spi_device {
 	u8			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
-#define	SPI_MODE_0	(0|0)
-#define	SPI_MODE_1	(0|SPI_CPHA)		/* (original MicroWire) */
+#define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
+#define	SPI_MODE_1	(0|SPI_CPHA)
 #define	SPI_MODE_2	(SPI_CPOL|0)
 #define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
 #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
@@ -209,6 +209,30 @@ struct spi_master {
 	void			(*cleanup)(const struct spi_device *spi);
 };
 
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
 /* the spi driver core manages memory for the spi_master classdev */
 extern struct spi_master *
 spi_alloc_master(struct device *host, unsigned size);
@@ -271,11 +295,17 @@ extern struct spi_master *spi_busnum_to_
  * stay selected until the next transfer.  This is purely a performance
  * hint; the controller driver may need to select a different device
  * for the next message.
+ *
+ * The code that submits an spi_message (and its spi_transfers)
+ * to the lower layers is responsible for managing its memory.
+ * Zero-initialize every field you don't set up explicitly, to
+ * insulate against future API updates.
  */
 struct spi_transfer {
 	/* it's ok if tx_buf == rx_buf (right?)
 	 * for MicroWire, one buffer must be null
-	 * buffers must work with dma_*map_single() calls
+	 * buffers must work with dma_*map_single() calls, unless
+	 *   spi_message.is_dma_mapped reports a pre-existing mapping
 	 */
 	const void	*tx_buf;
 	void		*rx_buf;
@@ -302,6 +332,11 @@ struct spi_transfer {
  * @status: zero for success, else negative errno
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
+ *
+ * The code that submits an spi_message (and its spi_transfers)
+ * to the lower layers is responsible for managing its memory.
+ * Zero-initialize every field you don't set up explicitly, to
+ * insulate against future API updates.
  */
 struct spi_message {
 	struct spi_transfer	*transfers;
@@ -336,6 +371,29 @@ struct spi_message {
 	void			*state;
 };
 
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
 /**
  * spi_setup -- setup SPI mode and clock rate
  * @spi: the device whose settings are being modified
@@ -363,7 +421,10 @@ spi_setup(struct spi_device *spi)
  * The completion callback is invoked in a context which can't sleep.
  * Before that invocation, the value of message->status is undefined.
  * When the callback is issued, message->status holds either zero (to
- * indicate complete success) or a negative error code.
+ * indicate complete success) or a negative error code.  After that
+ * callback returns, the driver which issued the transfer request may
+ * deallocate the associated memory; it's no longer in use by any SPI
+ * core or controller driver code.
  *
  * Note that although all messages to a spi_device are handled in
  * FIFO order, messages may go to different devices in other orders.
@@ -445,6 +506,7 @@ spi_read(struct spi_device *spi, u8 *buf
 	return spi_sync(spi, &m);
 }
 
+/* this copies txbuf and rxbuf data; for small transfers only! */
 extern int spi_write_then_read(struct spi_device *spi,
 		const u8 *txbuf, unsigned n_tx,
 		u8 *rxbuf, unsigned n_rx);
@@ -555,8 +617,9 @@ spi_register_board_info(struct spi_board
 
 
 /* If you're hotplugging an adapter with devices (parport, usb, etc)
- * use spi_new_device() to describe each device.  You would then call
- * spi_unregister_device() to start making that device vanish.
+ * use spi_new_device() to describe each device.  You can also call
+ * spi_unregister_device() to start making that device vanish, but
+ * normally that would be handled by spi_unregister_master().
  */
 extern struct spi_device *
 spi_new_device(struct spi_master *, struct spi_board_info *);
--- mm3.orig.orig/drivers/spi/spi.c	2005-12-18 08:52:45.000000000 -0800
+++ mm3.orig/drivers/spi/spi.c	2005-12-18 10:18:13.000000000 -0800
@@ -38,7 +38,7 @@ static void spidev_release(struct device
 	if (spi->master->cleanup)
 		spi->master->cleanup(spi);
 
-	class_device_put(&spi->master->cdev);
+	spi_master_put(spi->master);
 	kfree(dev);
 }
 
@@ -90,7 +90,7 @@ static int spi_suspend(struct device *de
 	int			value;
 	struct spi_driver	*drv = to_spi_driver(dev->driver);
 
-	if (!drv || !drv->suspend)
+	if (!drv->suspend)
 		return 0;
 
 	/* suspend will stop irqs and dma; no more i/o */
@@ -105,7 +105,7 @@ static int spi_resume(struct device *dev
 	int			value;
 	struct spi_driver	*drv = to_spi_driver(dev->driver);
 
-	if (!drv || !drv->resume)
+	if (!drv->resume)
 		return 0;
 
 	/* resume may restart the i/o queue */
@@ -198,7 +198,7 @@ spi_new_device(struct spi_master *master
 
 	/* NOTE:  caller did any chip->bus_num checks necessary */
 
-	if (!class_device_get(&master->cdev))
+	if (!spi_master_get(master))
 		return NULL;
 
 	proxy = kzalloc(sizeof *proxy, GFP_KERNEL);
@@ -244,7 +244,7 @@ spi_new_device(struct spi_master *master
 	return proxy;
 
 fail:
-	class_device_put(&master->cdev);
+	spi_master_put(master);
 	kfree(proxy);
 	return NULL;
 }
@@ -324,8 +324,6 @@ static void spi_master_release(struct cl
 	struct spi_master *master;
 
 	master = container_of(cdev, struct spi_master, cdev);
-	put_device(master->cdev.dev);
-	master->cdev.dev = NULL;
 	kfree(master);
 }
 
@@ -339,8 +337,9 @@ static struct class spi_master_class = {
 /**
  * spi_alloc_master - allocate SPI master controller
  * @dev: the controller, possibly using the platform_bus
- * @size: how much driver-private data to preallocate; a pointer to this
- * 	memory in the class_data field of the returned class_device
+ * @size: how much driver-private data to preallocate; the pointer to this
+ * 	memory is in the class_data field of the returned class_device,
+ *	accessible with spi_master_get_devdata().
  *
  * This call is used only by SPI master controller drivers, which are the
  * only ones directly touching chip registers.  It's how they allocate
@@ -350,14 +349,17 @@ static struct class spi_master_class = {
  * master structure on success, else NULL.
  *
  * The caller is responsible for assigning the bus number and initializing
- * the master's methods before calling spi_add_master(), or else (on error)
- * calling class_device_put() to prevent a memory leak.
+ * the master's methods before calling spi_add_master(); and (after errors
+ * adding the device) calling spi_master_put() to prevent a memory leak.
  */
 struct spi_master * __init_or_module
 spi_alloc_master(struct device *dev, unsigned size)
 {
 	struct spi_master	*master;
 
+	if (!dev)
+		return NULL;
+
 	master = kzalloc(size + sizeof *master, SLAB_KERNEL);
 	if (!master)
 		return NULL;
@@ -365,7 +367,7 @@ spi_alloc_master(struct device *dev, uns
 	class_device_initialize(&master->cdev);
 	master->cdev.class = &spi_master_class;
 	master->cdev.dev = get_device(dev);
-	class_set_devdata(&master->cdev, &master[1]);
+	spi_master_set_devdata(master, &master[1]);
 
 	return master;
 }
@@ -387,6 +389,8 @@ EXPORT_SYMBOL_GPL(spi_alloc_master);
  *
  * This must be called from context that can sleep.  It returns zero on
  * success, else a negative error code (dropping the master's refcount).
+ * After a successful return, the caller is responsible for calling
+ * spi_unregister_master().
  */
 int __init_or_module
 spi_register_master(struct spi_master *master)
@@ -396,6 +400,9 @@ spi_register_master(struct spi_master *m
 	int			status = -ENODEV;
 	int			dynamic = 0;
 
+	if (!dev)
+		return -ENODEV;
+
 	/* convention:  dynamically assigned bus IDs count down from the max */
 	if (master->bus_num == 0) {
 		master->bus_num = atomic_dec_return(&dyn_bus_id);
@@ -425,7 +432,7 @@ EXPORT_SYMBOL_GPL(spi_register_master);
 static int __unregister(struct device *dev, void *unused)
 {
 	/* note: before about 2.6.14-rc1 this would corrupt memory: */
-	device_unregister(dev);
+	spi_unregister_device(to_spi_device(dev));
 	return 0;
 }
 
@@ -440,8 +447,9 @@ static int __unregister(struct device *d
  */
 void spi_unregister_master(struct spi_master *master)
 {
-	class_device_unregister(&master->cdev);
 	(void) device_for_each_child(master->cdev.dev, NULL, __unregister);
+	class_device_unregister(&master->cdev);
+	master->cdev.dev = NULL;
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
 
@@ -487,6 +495,9 @@ EXPORT_SYMBOL_GPL(spi_busnum_to_master);
  * by leaving it selected in anticipation that the next message will go
  * to the same chip.  (That may increase power usage.)
  *
+ * Also, the caller is guaranteeing that the memory associated with the
+ * message will not be freed before this call returns.
+ *
  * The return value is a negative error code if the message could not be
  * submitted, else zero.  When the value is zero, then message->status is
  * also defined:  it's the completion code for the transfer, either zero
@@ -524,9 +535,9 @@ static u8	*buf;
  * is zero for success, else a negative errno status code.
  * This call may only be used from a context that may sleep.
  *
- * Parameters to this routine are always copied using a small buffer,
- * large transfers should use use spi_{async,sync}() calls with
- * dma-safe buffers.
+ * Parameters to this routine are always copied using a small buffer;
+ * performance-sensitive or bulk transfer code should instead use
+ * spi_{async,sync}() calls with dma-safe buffers.
  */
 int spi_write_then_read(struct spi_device *spi,
 		const u8 *txbuf, unsigned n_tx,
--- mm3.orig.orig/Documentation/spi/spi-summary	2005-12-18 08:52:45.000000000 -0800
+++ mm3.orig/Documentation/spi/spi-summary	2005-12-18 08:52:49.000000000 -0800
@@ -363,6 +363,22 @@ upper boundaries might include sysfs (es
 the input layer, ALSA, networking, MTD, the character device framework,
 or other Linux subsystems.
 
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
 
 How do I write an "SPI Master Controller Driver"?
 -------------------------------------------------

--Boundary-00=_zxapD+N1H27KSXe--
