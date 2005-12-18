Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965244AbVLRTRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965244AbVLRTRB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbVLRTQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:16:38 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:20302 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932709AbVLRTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:16:36 -0500
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-rc5-mm3 3/3] SPI bitbanging becomes library code
Date: Sun, 18 Dec 2005 10:46:23 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/5apD2WzjKnty4a"
Message-Id: <200512181046.23542.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/5apD2WzjKnty4a
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This updates the SPI bitbanging support so it should be usable for
some common types of SPI hardware.

--Boundary-00=_/5apD2WzjKnty4a
Content-Type: text/x-diff;
  charset="us-ascii";
  name="spi-bitbang-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spi-bitbang-update.patch"

This updates the SPI bitbanging support:

  - It's no longer a standalone driver, but is instead a library of code
    for drivers to call.

  - It should now support three different types of driver, all within
    this task-per-controller implementation model.

	* Pure bitbang.  These can now provide word-at-a-time I/O loops
	  tuned for each SPI mode, possibly using assembly language.

	* Word-at-a-time controllers.  Some controllers essentially let
	  those I/O loops be handled by the hardware, and at common CPU
	  and SPI speeds a polling driver may be quite appropriate.

	* Transfer-at-a-time controllers.  It turns out that it's easy
	  to fit controllers with FIFOs, half-duplex restrictions, and
	  simple DMA support into the same framework.

  - Some cleanups to the code actually banging bits.

That means a lot of hardware could work with this framework, though common
types of controller can't reach peak performance without switching to a
driver structure that supports pipelining of transfers (e.g. DMA queues)
and maybe controllers (e.g. IRQ driven).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- mm3.orig.orig/drivers/spi/Kconfig	2005-12-18 10:18:34.000000000 -0800
+++ mm3.orig/drivers/spi/Kconfig	2005-12-18 10:18:52.000000000 -0800
@@ -71,14 +71,14 @@ config SPI_BITBANG
 	depends on SPI_MASTER && EXPERIMENTAL
 	help
 	  With a few GPIO pins, your system can bitbang the SPI protocol.
-	  Choose this if you need SPI support through I/O pins (GPIO,
-	  parallel port, etc).
-
-	  Make sure you initialize one platform device object for each SPI
-	  master device on your system, using "spi_bitbang" as the device
-	  name with platform_data saying how to use which pins.  That will
-	  often be done using static board-specific tables in board-specific
-	  (or adapter-specific) setup code.
+	  Select this to get SPI support through I/O pins (GPIO, parallel
+	  port, etc).  Or, some systems' SPI master controller drivers use
+	  this code to manage the per-word or per-transfer accesses to the
+	  hardware shift registers.
+
+	  This is library code, and is automatically selected by drivers that
+	  need it.  You only need to select this explicitly to support driver
+	  modules that aren't part of this kernel tree.
 
 #
 # Add new SPI master controllers in alphabetical order above this line
--- mm3.orig.orig/include/linux/spi/spi_bitbang.h	2005-12-18 10:18:34.000000000 -0800
+++ mm3.orig/include/linux/spi/spi_bitbang.h	2005-12-18 10:18:52.000000000 -0800
@@ -1,46 +1,67 @@
 #ifndef	__SPI_BITBANG_H
 #define	__SPI_BITBANG_H
 
-/* delarations for interface between core/algorithm and the part of the
- * driver that actually knows what pins do what
+/*
+ * Mix this utility code with some glue code to get one of several types of
+ * simple SPI master driver.  Two do polled word-at-a-time I/O:
+ *
+ *   -	GPIO/parport bitbangers.  Provide chipselect() and txrx_word[](),
+ *	expanding the per-word routines from the inline templates below.
+ *
+ *   -	Drivers for controllers resembling bare shift registers.  Provide
+ *	chipselect() and txrx_word[](), with custom setup()/cleanup() methods
+ *	that use your controller's clock and chipselect registers.
+ *
+ * Some hardware works well with requests at spi_transfer scope:
+ *
+ *   -	Drivers leveraging smarter hardware, with fifos or DMA; or for half
+ *	duplex (MicroWire) controllers.  Provide chipslect() and txrx_bufs(),
+ *	and custom setup()/cleanup() methods.
  */
+struct spi_bitbang {
+	struct workqueue_struct	*workqueue;
+	struct work_struct	work;
+
+	spinlock_t		lock;
+	struct list_head	queue;
+	u8			busy;
+	u8			shutdown;
+	u8			use_dma;
 
-/**
- * struct spi_bitbang_plat_data - pass hardware-specific knowledge
- */
-struct spi_bitbang_plat_data {
-	unsigned	num_chipselect;
+	struct spi_master	*master;
 
-	/* enable/disable the chip; before enable, sets phase */
 	void	(*chipselect)(struct spi_device *spi, int is_on);
 
-	/* probably these should become  txrx_mode0(), txrx_mode1(),
-	 * and so on, when speed matters.
-	 */
-	u32	(*txrx_word)(struct spi_device *spi,
+	int	(*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
+	u32	(*txrx_word[4])(struct spi_device *spi,
 			unsigned nsecs,
 			u32 word, u8 bits);
 };
 
-extern struct platform_driver spi_bitbang_driver;
-
-
-/* FIXME just name functions after SCK and MOSI */
-enum spi_bitbang_pin {
-	SPI_BITBANG_SCK,
-	SPI_BITBANG_MOSI,
-};
+/* you can call these default bitbang->master methods from your custom
+ * methods, if you like.
+ */
+extern int spi_bitbang_setup(struct spi_device *spi);
+extern void spi_bitbang_cleanup(const struct spi_device *spi);
+extern int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m);
+
+/* start or stop queue processing */
+extern int spi_bitbang_start(struct spi_bitbang *spi);
+extern int spi_bitbang_stop(struct spi_bitbang *spi);
 
 #endif	/* __SPI_BITBANG_H */
 
+/*-------------------------------------------------------------------------*/
+
 #ifdef	EXPAND_BITBANG_TXRX
 
 /*
- * The code that knows what GPIO pins do what should have declared three
+ * The code that knows what GPIO pins do what should have declared four
  * functions, ideally as inlines, before #defining EXPAND_BITBANG_TXRX
  * and including this header:
  *
- *  void setpin(struct spi_device *, enum spi_bitbang_pin, int is_on);
+ *  void setsck(struct spi_device *, int is_on);
+ *  void setmosi(struct spi_device *, int is_on);
  *  int getmiso(struct spi_device *);
  *  void spidelay(unsigned);
  *
@@ -50,33 +71,31 @@ enum spi_bitbang_pin {
  *
  * Since this is software, the timings may not be exactly what your board's
  * chips need ... there may be several reasons you'd need to tweak timings
- * in this routine, not just make to make it faster or slower to match a
+ * in these routines, not just make to make it faster or slower to match a
  * particular CPU clock rate.
  */
 
-// SPI_MODE_0 seems to work fine
-
 static inline u32
 bitbang_txrx_be_cpha0(struct spi_device *spi,
 		unsigned nsecs, unsigned cpol,
 		u32 word, u8 bits)
 {
-	/* if (cpol) this is SPI_MODE_0; else this is SPI_MODE_2 */
+	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
 
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on trailing edge */
-		setpin(spi, SPI_BITBANG_MOSI, word & (1 << 31));
+		setmosi(spi, word & (1 << 31));
 		spidelay(nsecs);	/* T(setup) */
 
-		setpin(spi, SPI_BITBANG_SCK, !cpol);
+		setsck(spi, !cpol);
 		spidelay(nsecs);
 
 		/* sample MSB (from slave) on leading edge */
 		word <<= 1;
 		word |= getmiso(spi);
-		setpin(spi, SPI_BITBANG_SCK, cpol);
+		setsck(spi, cpol);
 	}
 	return word;
 }
@@ -86,18 +105,18 @@ bitbang_txrx_be_cpha1(struct spi_device 
 		unsigned nsecs, unsigned cpol,
 		u32 word, u8 bits)
 {
-	/* if (cpol) this is SPI_MODE_1; else this is SPI_MODE_3 */
+	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
 
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on leading edge */
-		setpin(spi, SPI_BITBANG_SCK, !cpol);
-		setpin(spi, SPI_BITBANG_MOSI, word & (1 << 31));
-		spidelay(nsecs);
+		setsck(spi, !cpol);
+		setmosi(spi, word & (1 << 31));
+		spidelay(nsecs); /* T(setup) */
 
-		setpin(spi, SPI_BITBANG_SCK, cpol);
-		spidelay(nsecs);	/* T(setup) */
+		setsck(spi, cpol);
+		spidelay(nsecs);
 
 		/* sample MSB (from slave) on trailing edge */
 		word <<= 1;
--- mm3.orig.orig/drivers/spi/spi_bitbang.c	2005-12-18 10:18:34.000000000 -0800
+++ mm3.orig/drivers/spi/spi_bitbang.c	2005-12-18 10:18:52.000000000 -0800
@@ -1,5 +1,5 @@
 /*
- * spi_bitbang.c - bitbanging SPI driver
+ * spi_bitbang.c - polling/bitbanging SPI master controller driver utilities
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/platform_device.h>
@@ -28,37 +29,42 @@
 #include <linux/spi/spi_bitbang.h>
 
 
-struct spi_bitbang {
-	struct work_struct	work;
-	struct workqueue_struct	*workqueue;
-
-	spinlock_t		lock;
-	struct list_head	queue;
-
-	struct spi_master	*master;
-
-	void	(*chipselect)(struct spi_device *spi, int is_on);
-	u32	(*txrx_word)(struct spi_device *spi,
-			unsigned nsecs,
-			u32 word, u8 bits);
-};
+/*----------------------------------------------------------------------*/
 
-/* spi_bitbang_cs is in spi_device->controller_state.
+/*
+ * FIRST PART (OPTIONAL):  word-at-a-time spi_transfer support.
+ * Use this for GPIO or shift-register level hardware APIs.
+ *
+ * spi_bitbang_cs is in spi_device->controller_state, which is unavailable
+ * to glue code.  These bitbang setup() and cleanup() routines are always
+ * used, though maybe they're called from controller-aware code.
+ *
+ * chipselect() and friends may use use spi_device->controller_data and
+ * controller registers as appropriate.
  *
- * chipselect() etc probably use use spi_device->controller_data
- * to remember chipselect, clock, and data i/o pins.
+ *
+ * NOTE:  SPI controller pins can often be used as GPIO pins instead,
+ * which means you could use a bitbang driver either to get hardware
+ * working quickly, or testing for differences that aren't speed related.
  */
+
 struct spi_bitbang_cs {
 	unsigned	nsecs;	/* (clock cycle time)/2 */
-	unsigned	(*txrx_buf)(struct spi_bitbang *, struct spi_device *,
+	u32		(*txrx_word)(struct spi_device *spi, unsigned nsecs,
+					u32 word, u8 bits);
+	unsigned	(*txrx_bufs)(struct spi_device *,
+					u32 (*txrx_word)(
+						struct spi_device *spi,
+						unsigned nsecs,
+						u32 word, u8 bits),
 					unsigned, struct spi_transfer *);
 };
 
-/*----------------------------------------------------------------------*/
-
 static unsigned bitbang_txrx_8(
-	struct spi_bitbang	*bitbang,
 	struct spi_device	*spi,
+	u32			(*txrx_word)(struct spi_device *spi,
+					unsigned nsecs,
+					u32 word, u8 bits),
 	unsigned		ns,
 	struct spi_transfer	*t
 ) {
@@ -72,7 +78,7 @@ static unsigned bitbang_txrx_8(
 
 		if (tx)
 			word = *tx++;
-		word = bitbang->txrx_word(spi, ns, word, bits);
+		word = txrx_word(spi, ns, word, bits);
 		if (rx)
 			*rx++ = word;
 		count -= 1;
@@ -81,8 +87,10 @@ static unsigned bitbang_txrx_8(
 }
 
 static unsigned bitbang_txrx_16(
-	struct spi_bitbang	*bitbang,
 	struct spi_device	*spi,
+	u32			(*txrx_word)(struct spi_device *spi,
+					unsigned nsecs,
+					u32 word, u8 bits),
 	unsigned		ns,
 	struct spi_transfer	*t
 ) {
@@ -96,7 +104,7 @@ static unsigned bitbang_txrx_16(
 
 		if (tx)
 			word = *tx++;
-		word = bitbang->txrx_word(spi, ns, word, bits);
+		word = txrx_word(spi, ns, word, bits);
 		if (rx)
 			*rx++ = word;
 		count -= 2;
@@ -105,8 +113,10 @@ static unsigned bitbang_txrx_16(
 }
 
 static unsigned bitbang_txrx_32(
-	struct spi_bitbang	*bitbang,
 	struct spi_device	*spi,
+	u32			(*txrx_word)(struct spi_device *spi,
+					unsigned nsecs,
+					u32 word, u8 bits),
 	unsigned		ns,
 	struct spi_transfer	*t
 ) {
@@ -120,7 +130,7 @@ static unsigned bitbang_txrx_32(
 
 		if (tx)
 			word = *tx++;
-		word = bitbang->txrx_word(spi, ns, word, bits);
+		word = txrx_word(spi, ns, word, bits);
 		if (rx)
 			*rx++ = word;
 		count -= 4;
@@ -128,16 +138,111 @@ static unsigned bitbang_txrx_32(
 	return t->len - count;
 }
 
+/**
+ * spi_bitbang_setup - default setup for per-word I/O loops
+ */
+int spi_bitbang_setup(struct spi_device *spi)
+{
+	struct spi_bitbang_cs	*cs = spi->controller_state;
+	struct spi_bitbang	*bitbang;
+
+	if (!cs) {
+		cs = kzalloc(sizeof *cs, SLAB_KERNEL);
+		if (!cs)
+			return -ENOMEM;
+		spi->controller_state = cs;
+	}
+	bitbang = spi_master_get_devdata(spi->master);
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	/* spi_transfer level calls that work per-word */
+	if (spi->bits_per_word <= 8)
+		cs->txrx_bufs = bitbang_txrx_8;
+	else if (spi->bits_per_word <= 16)
+		cs->txrx_bufs = bitbang_txrx_16;
+	else if (spi->bits_per_word <= 32)
+		cs->txrx_bufs = bitbang_txrx_32;
+	else
+		return -EINVAL;
+
+	/* per-word shift register access, in hardware or bitbanging */
+	cs->txrx_word = bitbang->txrx_word[spi->mode & (SPI_CPOL|SPI_CPHA)];
+	if (!cs->txrx_word)
+		return -EINVAL;
+
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz = 500 * 1000;
+
+	/* nsecs = max(50, (clock period)/2), be optimistic */
+	cs->nsecs = (1000000000/2) / (spi->max_speed_hz);
+	if (cs->nsecs < 50)
+		cs->nsecs = 50;
+	if (cs->nsecs > MAX_UDELAY_MS * 1000)
+		return -EINVAL;
+
+	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec\n",
+			__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
+			spi->bits_per_word, 2 * cs->nsecs);
+
+	/* NOTE we _need_ to call chipselect() early, ideally with adapter
+	 * setup, unless the hardware defaults cooperate to avoid confusion
+	 * between normal (active low) and inverted chipselects.
+	 */
+
+	/* deselect chip (low or high) */
+	spin_lock(&bitbang->lock);
+	if (!bitbang->busy) {
+		bitbang->chipselect(spi, 0);
+		ndelay(cs->nsecs);
+	}
+	spin_unlock(&bitbang->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_bitbang_setup);
+
+/**
+ * spi_bitbang_cleanup - default cleanup for per-word I/O loops
+ */
+void spi_bitbang_cleanup(const struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+EXPORT_SYMBOL_GPL(spi_bitbang_cleanup);
+
+static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct spi_bitbang_cs	*cs = spi->controller_state;
+	unsigned		nsecs = cs->nsecs;
+
+	return cs->txrx_bufs(spi, cs->txrx_word, nsecs, t);
+}
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * SECOND PART ... simple transfer queue runner.
+ *
+ * This costs a task context per controller, running the queue by
+ * performing each transfer in sequence.  Smarter hardware can queue
+ * several DMA transfers at once, and process several controller queues
+ * in parallel; this driver doesn't match such hardware very well.
+ *
+ * Drivers can provide word-at-a-time i/o primitives, or provide
+ * transfer-at-a-time ones to leverage dma or fifo hardware.
+ */
 static void bitbang_work(void *_bitbang)
 {
 	struct spi_bitbang	*bitbang = _bitbang;
 	unsigned long		flags;
 
 	spin_lock_irqsave(&bitbang->lock, flags);
+	bitbang->busy = 1;
 	while (!list_empty(&bitbang->queue)) {
 		struct spi_message	*m;
 		struct spi_device	*spi;
-		struct spi_bitbang_cs	*cs;
 		unsigned		nsecs;
 		struct spi_transfer	*t;
 		unsigned		tmp;
@@ -149,19 +254,22 @@ static void bitbang_work(void *_bitbang)
 		list_del_init(&m->queue);
 		spin_unlock_irqrestore(&bitbang->lock, flags);
 
+// FIXME this is made-up
+nsecs = 100;
+
 		spi = m->spi;
-		cs = spi->controller_state;
-		nsecs = cs->nsecs;
 		t = m->transfers;
 		tmp = 0;
 		chipselect = 0;
 		status = 0;
 
-		ndelay(nsecs);
-
 		for (;;t++) {
+			if (bitbang->shutdown) {
+				status = -ESHUTDOWN;
+				break;
+			}
 
-			/* set up default clock polarity and select */
+			/* set up default clock polarity, and activate chip */
 			if (!chipselect) {
 				bitbang->chipselect(spi, 1);
 				ndelay(nsecs);
@@ -172,7 +280,13 @@ static void bitbang_work(void *_bitbang)
 			}
 
 			/* transfer data */
-			status = cs->txrx_buf(bitbang, spi, nsecs, t);
+			if (t->len) {
+				/* FIXME if bitbang->use_dma, dma_map_single()
+				 * before the transfer, and dma_unmap_single()
+				 * afterwards, for either or both buffers...
+				 */
+				status = bitbang->txrx_bufs(spi, t);
+			}
 			if (status != t->len) {
 				if (status > 0)
 					status = -EMSGSIZE;
@@ -211,70 +325,24 @@ static void bitbang_work(void *_bitbang)
 
 		spin_lock_irqsave(&bitbang->lock, flags);
 	}
+	bitbang->busy = 0;
 	spin_unlock_irqrestore(&bitbang->lock, flags);
-
-}
-
-/*----------------------------------------------------------------------*/
-
-static int bitbang_setup(struct spi_device *spi)
-{
-	struct spi_bitbang_cs	*cs = spi->controller_state;
-	struct spi_bitbang	*bitbang;
-
-	if (!cs) {
-		cs = kzalloc(sizeof *cs, SLAB_KERNEL);
-		if (!cs)
-			return -ENOMEM;
-		spi->controller_state = cs;
-	}
-	bitbang = class_get_devdata(&spi->master->cdev);
-
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-	if (spi->bits_per_word <= 8)
-		cs->txrx_buf = bitbang_txrx_8;
-	else if (spi->bits_per_word <= 16)
-		cs->txrx_buf = bitbang_txrx_16;
-	else if (spi->bits_per_word <= 32)
-		cs->txrx_buf = bitbang_txrx_32;
-	else
-		return -EINVAL;
-
-	if (!spi->max_speed_hz)
-		spi->max_speed_hz = 500 * 1000;
-
-	/* nsecs = max(50, (clock period)/2), be optimistic */
-	cs->nsecs = (1000000000/2) / (spi->max_speed_hz);
-	if (cs->nsecs < 50)
-		cs->nsecs = 50;
-	if (cs->nsecs > MAX_UDELAY_MS * 1000)
-		return -EINVAL;
-
-	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec\n",
-			__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
-			spi->bits_per_word, 2 * cs->nsecs);
-
-	/* deselect chip (low or high) */
-	bitbang->chipselect(spi, 0);
-	ndelay(cs->nsecs);
-	return 0;
 }
 
-static void bitbang_cleanup(const struct spi_device *spi)
-{
-	kfree(spi->controller_state);
-}
-
-static int bitbang_transfer(struct spi_device *spi, struct spi_message *m)
+/**
+ * spi_bitbang_transfer - default submit to transfer queue
+ */
+int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m)
 {
 	struct spi_bitbang	*bitbang;
 	unsigned long		flags;
 
 	m->actual_length = 0;
-	m->status = 0;
+	m->status = -EINPROGRESS;
 
-	bitbang = class_get_devdata(&spi->master->cdev);
+	bitbang = spi_master_get_devdata(spi->master);
+	if (bitbang->shutdown)
+		return -ESHUTDOWN;
 
 	spin_lock_irqsave(&bitbang->lock, flags);
 	list_add_tail(&m->queue, &bitbang->queue);
@@ -283,54 +351,59 @@ static int bitbang_transfer(struct spi_d
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
 
 /*----------------------------------------------------------------------*/
 
-static int __devinit bitbang_probe(struct platform_device *pdev)
+/**
+ * spi_bitbang_start - start up a polled/bitbanging SPI master driver
+ * @bitbang: driver handle
+ *
+ * Caller should have zero-initialized all parts of the structure, and then
+ * provided callbacks for chip selection and I/O loops.  If the master has
+ * a transfer method, its final step should call spi_bitbang_transfer; or,
+ * that's the default if the transfer routine is not initialized.  It should
+ * also set up the bus number and number of chipselects.
+ *
+ * For i/o loops, provide callbacks either per-word (for bitbanging, or for
+ * hardware that basically exposes a shift register) or per-spi_transfer
+ * (which takes better advantage of hardware like fifos or DMA engines).
+ *
+ * Drivers using per-word I/O loops should use (or call) spi_bitbang_setup and
+ * spi_bitbang_cleanup to handle those spi master methods.  Those methods are
+ * the defaults if the bitbang->txrx_bufs routine isn't initialized.
+ *
+ * This routine registers the spi_master, which will process requests in a
+ * dedicated task, keeping IRQs unblocked most of the time.  To stop
+ * processing those requests, call spi_bitbang_stop().
+ */
+int spi_bitbang_start(struct spi_bitbang *bitbang)
 {
-	struct spi_bitbang_plat_data	*pdata = pdev->dev.platform_data;
-	struct spi_master		*master;
-	struct spi_bitbang		*bitbang;
-	int				status;
+	int	status;
 
-	if (!pdata)
+	if (!bitbang->master || !bitbang->chipselect)
 		return -EINVAL;
 
-	master = spi_alloc_master(&pdev->dev, sizeof *bitbang);
-	if (!master)
-		return -ENOMEM;
-
-	if (pdev->id != -1)
-		master->bus_num = pdev->id;
-	master->setup = bitbang_setup;
-	master->transfer = bitbang_transfer;
-	master->cleanup = bitbang_cleanup;
-	master->num_chipselect = pdata->num_chipselect;
-
-	bitbang = class_get_devdata(&master->cdev);
-	bitbang->chipselect = pdata->chipselect;
-	bitbang->txrx_word = pdata->txrx_word;
-
 	INIT_WORK(&bitbang->work, bitbang_work, bitbang);
 	spin_lock_init(&bitbang->lock);
 	INIT_LIST_HEAD(&bitbang->queue);
-	bitbang->master = master;
-
-	if (class_device_get(&master->cdev) == NULL) {
-		status = -ENOMEM;
-		goto err0;
-	}
 
-	/* bridging code is allowed to know that this is where
-	 * the spi_master is stored ... so it can then for example
-	 * use that with spi_new_device().
-	 */
-	dev_set_drvdata(&pdev->dev, master);
+	if (!bitbang->master->transfer)
+		bitbang->master->transfer = spi_bitbang_transfer;
+	if (!bitbang->txrx_bufs) {
+		bitbang->use_dma = 0;
+		bitbang->txrx_bufs = spi_bitbang_bufs;
+		if (!bitbang->master->setup) {
+			bitbang->master->setup = spi_bitbang_setup;
+			bitbang->master->cleanup = spi_bitbang_cleanup;
+		}
+	} else if (!bitbang->master->setup)
+		return -EINVAL;
 
-	/* this task is the only thing to touch the SPI bits.
-	 * it's OK if clock cycles stretch when it gets preempted
-	 */
-	bitbang->workqueue = create_singlethread_workqueue(pdev->dev.bus_id);
+	/* this task is the only thing to touch the SPI bits */
+	bitbang->busy = 0;
+	bitbang->workqueue = create_singlethread_workqueue(
+			bitbang->master->cdev.dev->bus_id);
 	if (bitbang->workqueue == NULL) {
 		status = -EBUSY;
 		goto err1;
@@ -339,7 +412,7 @@ static int __devinit bitbang_probe(struc
 	/* driver may get busy before register() returns, especially
 	 * if someone registered boardinfo for devices
 	 */
-	status = spi_register_master(master);
+	status = spi_register_master(bitbang->master);
 	if (status < 0)
 		goto err2;
 
@@ -348,55 +421,40 @@ static int __devinit bitbang_probe(struc
 err2:
 	destroy_workqueue(bitbang->workqueue);
 err1:
-	class_device_put(&master->cdev);
-err0:
 	return status;
 }
+EXPORT_SYMBOL_GPL(spi_bitbang_start);
 
-static int __devexit bitbang_remove(struct platform_device *pdev)
+/**
+ * spi_bitbang_stop - stops the task providing spi communication
+ */
+int spi_bitbang_stop(struct spi_bitbang *bitbang)
 {
-	struct spi_master		*master;
-	struct spi_bitbang		*bitbang;
+	unsigned	limit = 500;
 
-	master = dev_get_drvdata(&pdev->dev);
-	bitbang = class_get_devdata(&master->cdev);
+	spin_lock_irq(&bitbang->lock);
+	bitbang->shutdown = 0;
+	while (!list_empty(&bitbang->queue) && limit--) {
+		spin_unlock_irq(&bitbang->lock);
 
-	/* NOTE:  assumes that all children were already cleaned up,
-	 * which also means there will be no pending requests...
-	 */
-	WARN_ON(!list_empty(&bitbang->queue));
-	WARN_ON(!list_empty(&pdev->dev.klist_children.k_list));
-
-	destroy_workqueue(bitbang->workqueue);
-	class_device_put(&master->cdev);
-	spi_unregister_master(master);
-
-	return 0;
-}
+		dev_dbg(bitbang->master->cdev.dev, "wait for queue\n");
+		msleep(10);
 
-struct platform_driver spi_bitbang_driver = {
-	.driver = {
-		.name =		"spi_bitbang",
-		.owner =	THIS_MODULE,
-	},
-	.probe =	bitbang_probe,
-	.remove =	__devexit_p(bitbang_remove),
-	// suspend, resume ... stop queue after current message, restart later
-};
-EXPORT_SYMBOL_GPL(spi_bitbang_driver);
+		spin_lock_irq(&bitbang->lock);
+	}
+	spin_unlock_irq(&bitbang->lock);
+	if (!list_empty(&bitbang->queue)) {
+		dev_err(bitbang->master->cdev.dev, "queue didn't empty\n");
+		return -EBUSY;
+	}
 
+	destroy_workqueue(bitbang->workqueue);
 
-static int __init bitbang_init(void)
-{
-	return platform_driver_register(&spi_bitbang_driver);
-}
-device_initcall(bitbang_init);
+	spi_unregister_master(bitbang->master);
 
-static void __exit bitbang_exit(void)
-{
-	platform_driver_unregister(&spi_bitbang_driver);
+	return 0;
 }
-module_exit(bitbang_exit);
+EXPORT_SYMBOL_GPL(spi_bitbang_stop);
 
 MODULE_LICENSE("GPL");
 

--Boundary-00=_/5apD2WzjKnty4a--
