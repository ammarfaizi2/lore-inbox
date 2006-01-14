Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWANV1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWANV1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWANV1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:27:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:5780 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751309AbWANV1D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:27:03 -0500
Cc: david-b@pacbell.net
Subject: [PATCH] spi: add spi_bitbang driver
In-Reply-To: <1137199592102@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 16:46:33 -0800
Message-Id: <1137199593773@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] spi: add spi_bitbang driver

This adds a bitbanging spi master, hooking up to board/adapter-specific glue
code which knows how to set and read the signals (gpios etc).

This code kicks in after the glue code creates a platform_device with the
right platform_data.  That data includes I/O loops, which will usually
come from expanding an inline function (provided in the header).  One goal
is that the I/O loops should be easily optimized down to a few GPIO register
accesses, in common cases, for speed and minimized overhead.

This understands all the currently defined protocol tweaking options in the
SPI framework, and might eventually serve as as reference implementation.

  - different word sizes (1..32 bits)
  - differing clock rates
  - SPI modes differing by CPOL (affecting chip select and I/O loops)
  - SPI modes differing by CPHA (affecting I/O loops)
  - delays (usecs) after transfers
  - temporarily deselecting chips in mid-transfer

A lot of hardware could work with this framework, though common types of
controller can't reach peak performance without switching to a driver
structure that supports pipelining of transfers (e.g.  DMA queues) and maybe
controllers (e.g.  IRQ driven).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9904f22a7202c6b54e96b0cc9870817013c350a1
tree 02d526b1bf54b1c64e58a9f903269f9cdc6ec83c
parent 2e5a7bd978bf4118a0c8edf2e6ff81d0a72fee47
author David Brownell <david-b@pacbell.net> Sun, 08 Jan 2006 13:34:26 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 16:29:55 -0800

 drivers/spi/Kconfig             |   13 +
 drivers/spi/Makefile            |    1 
 drivers/spi/spi_bitbang.c       |  460 +++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi_bitbang.h |  128 +++++++++++
 4 files changed, 602 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d310510..9b21c5d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -51,6 +51,19 @@ config SPI_MASTER
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
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index afd2321..5da6a4d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -11,6 +11,7 @@ endif
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
new file mode 100644
index 0000000..44aff19
--- /dev/null
+++ b/drivers/spi/spi_bitbang.c
@@ -0,0 +1,460 @@
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
+// FIXME this is made-up
+nsecs = 100;
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
+				bitbang->chipselect(spi, 1);
+				ndelay(nsecs);
+			}
+			if (!t->tx_buf && !t->rx_buf && t->len) {
+				status = -EINVAL;
+				break;
+			}
+
+			/* transfer data */
+			if (t->len) {
+				/* FIXME if bitbang->use_dma, dma_map_single()
+				 * before the transfer, and dma_unmap_single()
+				 * afterwards, for either or both buffers...
+				 */
+				status = bitbang->txrx_bufs(spi, t);
+			}
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
+			if (chipselect);
+				continue;
+
+			bitbang->chipselect(spi, 0);
+
+			/* REVISIT do we want the udelay here instead? */
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
+		bitbang->chipselect(spi, status == 0 && tmp);
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
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
new file mode 100644
index 0000000..8dfe61a
--- /dev/null
+++ b/include/linux/spi/spi_bitbang.h
@@ -0,0 +1,128 @@
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
+
+	int	(*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
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

