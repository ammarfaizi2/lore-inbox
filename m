Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVLWAUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVLWAUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVLWATH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:19:07 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:34477 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751230AbVLWASy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:18:54 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.14-rc6-git 5/6] SPI bitbang utilities
Date: Thu, 22 Dec 2005 15:39:43 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net
References: <200511102355.11505.david-b@pacbell.net> 
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/kzqDi7HOGCtSqL"
Message-Id: <200512221539.43487.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/kzqDi7HOGCtSqL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This code supports a range of implementations for SPI controllers,
from pure GPIO bitbanging up to drivers using non-queued DMA.  The
price includes a task context and various other restrictions that
higher performance drivers may need to avoid.


--Boundary-00=_/kzqDi7HOGCtSqL
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bitbang_spi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bitbang_spi.patch"

This adds a bitbanging spi master, hooking up to board/adapter-specific glue
code which knows how to set and read the signals (gpios etc).

That glue code gets hooked up using platform_data which includes I/O loops.
Those loops could be optimized down to a few instructions accessing GPIO
registers, in some common cases.

This understands all the currently defined protocol tweaking options, and
could eventually serve as as reference implementation for them.

  - different word sizes
  - differing clock rates
  - SPI modes differing only by CPOL ... chip setup, I/O loops
  - SPI modes with I/O loops differing by CPHA
  - delays (usecs) after transfers
  - dropping chipselect mid-transfer

Not all those combinations have been tested yet; notably, not CPHA=1.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- tmp.orig/drivers/spi/Kconfig	2005-12-22 14:53:42.000000000 -0800
+++ tmp/drivers/spi/Kconfig	2005-12-22 14:54:03.000000000 -0800
@@ -30,7 +30,7 @@ config SPI
 	  up to several tens of Mbit/sec.  Chips are addressed with a
 	  controller and a chipselect.  Most SPI slaves don't support
 	  dynamic device discovery; some are even write-only or read-only.
-	  
+
 	  SPI is widely used by microcontollers to talk with sensors,
 	  eeprom and flash memory, codecs and various other controller
 	  chips, analog to digital (and d-to-a) converters, and more.
@@ -66,6 +66,19 @@ config SPI_MASTER
 comment "SPI Master Controller Drivers"
 	depends on SPI_MASTER
 
+config SPI_BITBANG
+	tristate "Bitbanging SPI master"
+	depends on SPI_MASTER && EXPERIMENTAL
+	help
+	  With a few GPIO pins, your system can bitbang the SPI protocol.
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
--- tmp.orig/drivers/spi/Makefile	2005-12-22 14:53:42.000000000 -0800
+++ tmp/drivers/spi/Makefile	2005-12-22 14:54:03.000000000 -0800
@@ -11,6 +11,7 @@ endif
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tmp/include/linux/spi/spi_bitbang.h	2005-12-22 14:54:03.000000000 -0800
@@ -0,0 +1,135 @@
+#ifndef	__SPI_BITBANG_H
+#define	__SPI_BITBANG_H
+
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
+ */
+struct spi_bitbang {
+	struct workqueue_struct	*workqueue;
+	struct work_struct	work;
+
+	spinlock_t		lock;
+	struct list_head	queue;
+	u8			busy;
+	u8			shutdown;
+	u8			use_dma;
+
+	struct spi_master	*master;
+
+	void	(*chipselect)(struct spi_device *spi, int is_on);
+#define	BITBANG_CS_ACTIVE	1	/* normally nCS, active low */
+#define	BITBANG_CS_INACTIVE	0
+
+	/* txrx_bufs() may handle dma mapping for transfers that don't
+	 * already have one (transfer.{tx,rx}_dma is zero), or use PIO
+	 */
+	int	(*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
+
+	/* txrx_word[SPI_MODE_*]() just looks like a shift register */
+	u32	(*txrx_word[4])(struct spi_device *spi,
+			unsigned nsecs,
+			u32 word, u8 bits);
+};
+
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
+
+#endif	/* __SPI_BITBANG_H */
+
+/*-------------------------------------------------------------------------*/
+
+#ifdef	EXPAND_BITBANG_TXRX
+
+/*
+ * The code that knows what GPIO pins do what should have declared four
+ * functions, ideally as inlines, before #defining EXPAND_BITBANG_TXRX
+ * and including this header:
+ *
+ *  void setsck(struct spi_device *, int is_on);
+ *  void setmosi(struct spi_device *, int is_on);
+ *  int getmiso(struct spi_device *);
+ *  void spidelay(unsigned);
+ *
+ * A non-inlined routine would call bitbang_txrx_*() routines.  The
+ * main loop could easily compile down to a handful of instructions,
+ * especially if the delay is a NOP (to run at peak speed).
+ *
+ * Since this is software, the timings may not be exactly what your board's
+ * chips need ... there may be several reasons you'd need to tweak timings
+ * in these routines, not just make to make it faster or slower to match a
+ * particular CPU clock rate.
+ */
+
+static inline u32
+bitbang_txrx_be_cpha0(struct spi_device *spi,
+		unsigned nsecs, unsigned cpol,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
+
+	/* clock starts at inactive polarity */
+	for (word <<= (32 - bits); likely(bits); bits--) {
+
+		/* setup MSB (to slave) on trailing edge */
+		setmosi(spi, word & (1 << 31));
+		spidelay(nsecs);	/* T(setup) */
+
+		setsck(spi, !cpol);
+		spidelay(nsecs);
+
+		/* sample MSB (from slave) on leading edge */
+		word <<= 1;
+		word |= getmiso(spi);
+		setsck(spi, cpol);
+	}
+	return word;
+}
+
+static inline u32
+bitbang_txrx_be_cpha1(struct spi_device *spi,
+		unsigned nsecs, unsigned cpol,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
+
+	/* clock starts at inactive polarity */
+	for (word <<= (32 - bits); likely(bits); bits--) {
+
+		/* setup MSB (to slave) on leading edge */
+		setsck(spi, !cpol);
+		setmosi(spi, word & (1 << 31));
+		spidelay(nsecs); /* T(setup) */
+
+		setsck(spi, cpol);
+		spidelay(nsecs);
+
+		/* sample MSB (from slave) on trailing edge */
+		word <<= 1;
+		word |= getmiso(spi);
+	}
+	return word;
+}
+
+#endif	/* EXPAND_BITBANG_TXRX */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tmp/drivers/spi/spi_bitbang.c	2005-12-22 14:54:03.000000000 -0800
@@ -0,0 +1,457 @@
+/*
+ * spi_bitbang.c - polling/bitbanging SPI master controller driver utilities
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+
+/*----------------------------------------------------------------------*/
+
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
+ *
+ *
+ * NOTE:  SPI controller pins can often be used as GPIO pins instead,
+ * which means you could use a bitbang driver either to get hardware
+ * working quickly, or testing for differences that aren't speed related.
+ */
+
+struct spi_bitbang_cs {
+	unsigned	nsecs;	/* (clock cycle time)/2 */
+	u32		(*txrx_word)(struct spi_device *spi, unsigned nsecs,
+					u32 word, u8 bits);
+	unsigned	(*txrx_bufs)(struct spi_device *,
+					u32 (*txrx_word)(
+						struct spi_device *spi,
+						unsigned nsecs,
+						u32 word, u8 bits),
+					unsigned, struct spi_transfer *);
+};
+
+static unsigned bitbang_txrx_8(
+	struct spi_device	*spi,
+	u32			(*txrx_word)(struct spi_device *spi,
+					unsigned nsecs,
+					u32 word, u8 bits),
+	unsigned		ns,
+	struct spi_transfer	*t
+) {
+	unsigned		bits = spi->bits_per_word;
+	unsigned		count = t->len;
+	const u8		*tx = t->tx_buf;
+	u8			*rx = t->rx_buf;
+
+	while (likely(count > 0)) {
+		u8		word = 0;
+
+		if (tx)
+			word = *tx++;
+		word = txrx_word(spi, ns, word, bits);
+		if (rx)
+			*rx++ = word;
+		count -= 1;
+	}
+	return t->len - count;
+}
+
+static unsigned bitbang_txrx_16(
+	struct spi_device	*spi,
+	u32			(*txrx_word)(struct spi_device *spi,
+					unsigned nsecs,
+					u32 word, u8 bits),
+	unsigned		ns,
+	struct spi_transfer	*t
+) {
+	unsigned		bits = spi->bits_per_word;
+	unsigned		count = t->len;
+	const u16		*tx = t->tx_buf;
+	u16			*rx = t->rx_buf;
+
+	while (likely(count > 1)) {
+		u16		word = 0;
+
+		if (tx)
+			word = *tx++;
+		word = txrx_word(spi, ns, word, bits);
+		if (rx)
+			*rx++ = word;
+		count -= 2;
+	}
+	return t->len - count;
+}
+
+static unsigned bitbang_txrx_32(
+	struct spi_device	*spi,
+	u32			(*txrx_word)(struct spi_device *spi,
+					unsigned nsecs,
+					u32 word, u8 bits),
+	unsigned		ns,
+	struct spi_transfer	*t
+) {
+	unsigned		bits = spi->bits_per_word;
+	unsigned		count = t->len;
+	const u32		*tx = t->tx_buf;
+	u32			*rx = t->rx_buf;
+
+	while (likely(count > 3)) {
+		u32		word = 0;
+
+		if (tx)
+			word = *tx++;
+		word = txrx_word(spi, ns, word, bits);
+		if (rx)
+			*rx++ = word;
+		count -= 4;
+	}
+	return t->len - count;
+}
+
+/**
+ * spi_bitbang_setup - default setup for per-word I/O loops
+ */
+int spi_bitbang_setup(struct spi_device *spi)
+{
+	struct spi_bitbang_cs	*cs = spi->controller_state;
+	struct spi_bitbang	*bitbang;
+
+	if (!spi->max_speed_hz)
+		return -EINVAL;
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
+	/* nsecs = (clock period)/2 */
+	cs->nsecs = (1000000000/2) / (spi->max_speed_hz);
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
+		bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
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
+static void bitbang_work(void *_bitbang)
+{
+	struct spi_bitbang	*bitbang = _bitbang;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&bitbang->lock, flags);
+	bitbang->busy = 1;
+	while (!list_empty(&bitbang->queue)) {
+		struct spi_message	*m;
+		struct spi_device	*spi;
+		unsigned		nsecs;
+		struct spi_transfer	*t;
+		unsigned		tmp;
+		unsigned		chipselect;
+		int			status;
+
+		m = container_of(bitbang->queue.next, struct spi_message,
+				queue);
+		list_del_init(&m->queue);
+		spin_unlock_irqrestore(&bitbang->lock, flags);
+
+		/* FIXME this is made-up ... the correct value is known to
+		 * word-at-a-time bitbang code, and presumably chipselect()
+		 * should enforce these requirements too?
+		 */
+		nsecs = 100;
+
+		spi = m->spi;
+		t = m->transfers;
+		tmp = 0;
+		chipselect = 0;
+		status = 0;
+
+		for (;;t++) {
+			if (bitbang->shutdown) {
+				status = -ESHUTDOWN;
+				break;
+			}
+
+			/* set up default clock polarity, and activate chip */
+			if (!chipselect) {
+				bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
+				ndelay(nsecs);
+			}
+			if (!t->tx_buf && !t->rx_buf && t->len) {
+				status = -EINVAL;
+				break;
+			}
+
+			/* transfer data */
+			if (t->len)
+				status = bitbang->txrx_bufs(spi, t);
+			if (status != t->len) {
+				if (status > 0)
+					status = -EMSGSIZE;
+				break;
+			}
+			m->actual_length += status;
+			status = 0;
+
+			/* protocol tweaks before next transfer */
+			if (t->delay_usecs)
+				udelay(t->delay_usecs);
+
+			tmp++;
+			if (tmp >= m->n_transfer)
+				break;
+
+			chipselect = !t->cs_change;
+			if (chipselect)
+				continue;
+
+			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
+
+			msleep(1);
+		}
+
+		tmp = m->n_transfer - 1;
+		tmp = m->transfers[tmp].cs_change;
+
+		m->status = status;
+		m->complete(m->context);
+
+		ndelay(2 * nsecs);
+		bitbang->chipselect(spi, (status == 0 && tmp)
+				? BITBANG_CS_ACTIVE
+				: BITBANG_CS_INACTIVE);
+		ndelay(nsecs);
+
+		spin_lock_irqsave(&bitbang->lock, flags);
+	}
+	bitbang->busy = 0;
+	spin_unlock_irqrestore(&bitbang->lock, flags);
+}
+
+/**
+ * spi_bitbang_transfer - default submit to transfer queue
+ */
+int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct spi_bitbang	*bitbang;
+	unsigned long		flags;
+
+	m->actual_length = 0;
+	m->status = -EINPROGRESS;
+
+	bitbang = spi_master_get_devdata(spi->master);
+	if (bitbang->shutdown)
+		return -ESHUTDOWN;
+
+	spin_lock_irqsave(&bitbang->lock, flags);
+	list_add_tail(&m->queue, &bitbang->queue);
+	queue_work(bitbang->workqueue, &bitbang->work);
+	spin_unlock_irqrestore(&bitbang->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_bitbang_transfer);
+
+/*----------------------------------------------------------------------*/
+
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
+{
+	int	status;
+
+	if (!bitbang->master || !bitbang->chipselect)
+		return -EINVAL;
+
+	INIT_WORK(&bitbang->work, bitbang_work, bitbang);
+	spin_lock_init(&bitbang->lock);
+	INIT_LIST_HEAD(&bitbang->queue);
+
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
+
+	/* this task is the only thing to touch the SPI bits */
+	bitbang->busy = 0;
+	bitbang->workqueue = create_singlethread_workqueue(
+			bitbang->master->cdev.dev->bus_id);
+	if (bitbang->workqueue == NULL) {
+		status = -EBUSY;
+		goto err1;
+	}
+
+	/* driver may get busy before register() returns, especially
+	 * if someone registered boardinfo for devices
+	 */
+	status = spi_register_master(bitbang->master);
+	if (status < 0)
+		goto err2;
+
+	return status;
+
+err2:
+	destroy_workqueue(bitbang->workqueue);
+err1:
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_bitbang_start);
+
+/**
+ * spi_bitbang_stop - stops the task providing spi communication
+ */
+int spi_bitbang_stop(struct spi_bitbang *bitbang)
+{
+	unsigned	limit = 500;
+
+	spin_lock_irq(&bitbang->lock);
+	bitbang->shutdown = 0;
+	while (!list_empty(&bitbang->queue) && limit--) {
+		spin_unlock_irq(&bitbang->lock);
+
+		dev_dbg(bitbang->master->cdev.dev, "wait for queue\n");
+		msleep(10);
+
+		spin_lock_irq(&bitbang->lock);
+	}
+	spin_unlock_irq(&bitbang->lock);
+	if (!list_empty(&bitbang->queue)) {
+		dev_err(bitbang->master->cdev.dev, "queue didn't empty\n");
+		return -EBUSY;
+	}
+
+	destroy_workqueue(bitbang->workqueue);
+
+	spi_unregister_master(bitbang->master);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_bitbang_stop);
+
+MODULE_LICENSE("GPL");
+

--Boundary-00=_/kzqDi7HOGCtSqL--
