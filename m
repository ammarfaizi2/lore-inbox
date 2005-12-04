Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVLDA2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVLDA2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVLDA2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:28:15 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:8285 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932185AbVLDA2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:28:10 -0500
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-rc3-mm1 3/4] add spi_bitbang driver
Date: Sat, 3 Dec 2005 16:26:13 -0800
User-Agent: KMail/1.7.1
Cc: linuxMark Underwood <basicmark@yahoo.com>,
       Stephen Street <stephen@streetfiresound.com>,
       Vitaly Wool <vwool@ru.mvista.com>
References: <200512031556.32214.david-b@pacbell.net>
In-Reply-To: <200512031556.32214.david-b@pacbell.net>
MIME-Version: 1.0
Message-Id: <200512031626.14078.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mejkD9zGMVEOESv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_mejkD9zGMVEOESv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a mostly-working bitbang driver for SPI.  It seems to
handle SPI mode 0 just fine; I've done a bunch of flash updates
through a parport wrapper, and no bits were damaged.

Eventually I hope this will serve as a reference implementation,
showing how the various API operations map to bits on the wire.
(Contrast it to the I2C bitbangers, also.  Simpler...)

Likewise, folk looking at getting more standard SPI support on
their hardware could start with this.  It's reasonably common
for the pins used for SPI controllers to be accessible as GPIOs,
so this bitbanger might be used until a real hardware driver was
debugged and tuned.  (That's assuming there _is_ a dedicated
SPI controller to use!)

Comments appreciated.  Also testing with other SPI modes,
and potentially code tweaks to make the banging go faster.

- Dave

 

--Boundary-00=_mejkD9zGMVEOESv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bitbang_spi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bitbang_spi.patch"

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

This version is circulating mostly as an RFC.  SPI Mode 0 works talking
to a Flash chip, but I'm still chasing down some bugs that show up after
I rmmod the parport adapter.



--- mm-tmp.orig/drivers/spi/Kconfig	2005-12-03 14:23:27.000000000 -0800
+++ mm-tmp/drivers/spi/Kconfig	2005-12-03 15:45:32.000000000 -0800
@@ -66,6 +66,19 @@ config SPI_MASTER
 comment "SPI Master Controller Drivers"
 	depends on SPI_MASTER
 
+config SPI_BITBANG
+	tristate "Bitbanging SPI master"
+	depends on SPI_MASTER && EXPERIMENTAL
+	help
+	  With a few GPIO pins, your system can bitbang the SPI protocol.
+	  Choose this if you need SPI support through I/O pins (GPIO,
+	  parallel port, etc).
+	  
+	  Make sure you initialize one platform device object for each SPI
+	  master device on your system, using "spi_bitbang" as the device
+	  name with platform_data saying how to use which pins.  That will
+	  often be done using static board-specific tables in board-specific
+	  (or adapter-specific) setup code.
 
 #
 # Add new SPI master controllers in alphabetical order above this line
--- mm-tmp.orig/drivers/spi/Makefile	2005-12-03 14:17:41.000000000 -0800
+++ mm-tmp/drivers/spi/Makefile	2005-12-03 15:45:32.000000000 -0800
@@ -11,6 +11,7 @@ endif
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ mm-tmp/include/linux/spi/spi_bitbang.h	2005-12-03 15:45:32.000000000 -0800
@@ -0,0 +1,109 @@
+#ifndef	__SPI_BITBANG_H
+#define	__SPI_BITBANG_H
+
+/* delarations for interface between core/algorithm and the part of the
+ * driver that actually knows what pins do what
+ */
+
+/**
+ * struct spi_bitbang_plat_data - pass hardware-specific knowledge
+ */
+struct spi_bitbang_plat_data {
+	unsigned	num_chipselect;
+
+	/* enable/disable the chip; before enable, sets phase */
+	void	(*chipselect)(struct spi_device *spi, int is_on);
+
+	/* probably these should become  txrx_mode0(), txrx_mode1(),
+	 * and so on, when speed matters.
+	 */
+	u32	(*txrx_word)(struct spi_device *spi,
+			unsigned nsecs,
+			u32 word, u8 bits);
+};
+
+extern struct platform_driver spi_bitbang_driver;
+
+
+/* FIXME just name functions after SCK and MOSI */
+enum spi_bitbang_pin {
+	SPI_BITBANG_SCK,
+	SPI_BITBANG_MOSI,
+};
+
+#endif	/* __SPI_BITBANG_H */
+
+#ifdef	EXPAND_BITBANG_TXRX
+
+/*
+ * The code that knows what GPIO pins do what should have declared three
+ * functions, ideally as inlines, before #defining EXPAND_BITBANG_TXRX
+ * and including this header:
+ *
+ *  void setpin(struct spi_device *, enum spi_bitbang_pin, int is_on);
+ *  int getmiso(struct spi_device *);
+ *  void spidelay(unsigned);
+ *
+ * A non-inlined routine would call bitbang_txrx_*() routines.  The
+ * main loop could easily compile down to a handful of instructions,
+ * especially if the delay is a NOP (to run at peak speed).
+ *
+ * Since this is software, the timings may not be exactly what your board's
+ * chips need ... there may be several reasons you'd need to tweak timings
+ * in this routine, not just make to make it faster or slower to match a
+ * particular CPU clock rate.
+ */
+
+// SPI_MODE_0 seems to work fine
+
+static inline u32
+bitbang_txrx_be_cpha0(struct spi_device *spi,
+		unsigned nsecs, unsigned cpol,
+		u32 word, u8 bits)
+{
+	/* if (cpol) this is SPI_MODE_0; else this is SPI_MODE_2 */
+
+	/* clock starts at inactive polarity */
+	for (word <<= (32 - bits); likely(bits); bits--) {
+
+		/* setup MSB (to slave) on trailing edge */
+		setpin(spi, SPI_BITBANG_MOSI, word & (1 << 31));
+		spidelay(nsecs);	/* T(setup) */
+
+		setpin(spi, SPI_BITBANG_SCK, !cpol);
+		spidelay(nsecs);
+
+		/* sample MSB (from slave) on leading edge */
+		word <<= 1;
+		word |= getmiso(spi);
+		setpin(spi, SPI_BITBANG_SCK, cpol);
+	}
+	return word;
+}
+
+static inline u32
+bitbang_txrx_be_cpha1(struct spi_device *spi,
+		unsigned nsecs, unsigned cpol,
+		u32 word, u8 bits)
+{
+	/* if (cpol) this is SPI_MODE_1; else this is SPI_MODE_3 */
+
+	/* clock starts at inactive polarity */
+	for (word <<= (32 - bits); likely(bits); bits--) {
+
+		/* setup MSB (to slave) on leading edge */
+		setpin(spi, SPI_BITBANG_SCK, !cpol);
+		setpin(spi, SPI_BITBANG_MOSI, word & (1 << 31));
+		spidelay(nsecs);
+
+		setpin(spi, SPI_BITBANG_SCK, cpol);
+		spidelay(nsecs);	/* T(setup) */
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
+++ mm-tmp/drivers/spi/spi_bitbang.c	2005-12-03 15:45:32.000000000 -0800
@@ -0,0 +1,401 @@
+/*
+ * spi_bitbang.c - bitbanging SPI driver
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
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+
+struct spi_bitbang {
+	struct work_struct	work;
+	struct workqueue_struct	*workqueue;
+
+	spinlock_t		lock;
+	struct list_head	queue;
+
+	struct spi_master	*master;
+
+	void	(*chipselect)(struct spi_device *spi, int is_on);
+	u32	(*txrx_word)(struct spi_device *spi,
+			unsigned nsecs,
+			u32 word, u8 bits);
+};
+
+/* spi_bitbang_cs is in spi_device->controller_state.
+ *
+ * chipselect() etc probably use use spi_device->controller_data
+ * to remember chipselect, clock, and data i/o pins.
+ */
+struct spi_bitbang_cs {
+	unsigned	nsecs;	/* (clock cycle time)/2 */
+	unsigned	(*txrx_buf)(struct spi_bitbang *, struct spi_device *,
+					unsigned, struct spi_transfer *);
+};
+
+/*----------------------------------------------------------------------*/
+
+static unsigned bitbang_txrx_8(
+	struct spi_bitbang	*bitbang,
+	struct spi_device	*spi,
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
+		word = bitbang->txrx_word(spi, ns, word, bits);
+		if (rx)
+			*rx++ = word;
+		count -= 1;
+	}
+	return t->len - count;
+}
+
+static unsigned bitbang_txrx_16(
+	struct spi_bitbang	*bitbang,
+	struct spi_device	*spi,
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
+		word = bitbang->txrx_word(spi, ns, word, bits);
+		if (rx)
+			*rx++ = word;
+		count -= 2;
+	}
+	return t->len - count;
+}
+
+static unsigned bitbang_txrx_32(
+	struct spi_bitbang	*bitbang,
+	struct spi_device	*spi,
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
+		word = bitbang->txrx_word(spi, ns, word, bits);
+		if (rx)
+			*rx++ = word;
+		count -= 4;
+	}
+	return t->len - count;
+}
+
+static void bitbang_work(void *_bitbang)
+{
+	struct spi_bitbang	*bitbang = _bitbang;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&bitbang->lock, flags);
+	while (!list_empty(&bitbang->queue)) {
+		struct spi_message	*m;
+		struct spi_device	*spi;
+		struct spi_bitbang_cs	*cs;
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
+		spi = m->spi;
+		cs = spi->controller_state;
+		nsecs = cs->nsecs;
+		t = m->transfers;
+		tmp = 0;
+		chipselect = 0;
+		status = 0;
+
+		ndelay(nsecs);
+
+		for (;;t++) {
+
+			/* set up default clock polarity and select */
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
+			status = cs->txrx_buf(bitbang, spi, nsecs, t);
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
+	spin_unlock_irqrestore(&bitbang->lock, flags);
+	
+}
+
+/*----------------------------------------------------------------------*/
+
+static int bitbang_setup(struct spi_device *spi)
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
+	bitbang = class_get_devdata(&spi->master->cdev);
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+	if (spi->bits_per_word <= 8)
+		cs->txrx_buf = bitbang_txrx_8;
+	else if (spi->bits_per_word <= 16)
+		cs->txrx_buf = bitbang_txrx_16;
+	else if (spi->bits_per_word <= 32)
+		cs->txrx_buf = bitbang_txrx_32;
+	else
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
+	/* deselect chip (low or high) */
+	bitbang->chipselect(spi, 0);
+	ndelay(cs->nsecs);
+	return 0;
+}
+
+static void bitbang_cleanup(const struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
+static int bitbang_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct spi_bitbang	*bitbang;
+	unsigned long		flags;
+
+	m->actual_length = 0;
+	m->status = 0;
+
+	bitbang = class_get_devdata(&spi->master->cdev);
+
+	spin_lock_irqsave(&bitbang->lock, flags);
+	list_add_tail(&m->queue, &bitbang->queue);
+	queue_work(bitbang->workqueue, &bitbang->work);
+	spin_unlock_irqrestore(&bitbang->lock, flags);
+
+	return 0;
+}
+
+/*----------------------------------------------------------------------*/
+
+static int __devinit bitbang_probe(struct platform_device *pdev)
+{
+	struct spi_bitbang_plat_data	*pdata = pdev->dev.platform_data;
+	struct spi_master		*master;
+	struct spi_bitbang		*bitbang;
+	int				status;
+
+	if (!pdata)
+		return -EINVAL;
+
+	master = spi_alloc_master(&pdev->dev, sizeof *bitbang);
+	if (!master)
+		return -ENOMEM;
+
+	if (pdev->id != -1)
+		master->bus_num = pdev->id;
+	master->setup = bitbang_setup;
+	master->transfer = bitbang_transfer;
+	master->cleanup = bitbang_cleanup;
+	master->num_chipselect = pdata->num_chipselect;
+
+	bitbang = class_get_devdata(&master->cdev);
+	bitbang->chipselect = pdata->chipselect;
+	bitbang->txrx_word = pdata->txrx_word;
+
+	INIT_WORK(&bitbang->work, bitbang_work, bitbang);
+	spin_lock_init(&bitbang->lock);
+	INIT_LIST_HEAD(&bitbang->queue);
+	bitbang->master = master;
+
+	if (class_device_get(&master->cdev) == NULL) {
+		status = -ENOMEM;
+		goto err0;
+	}
+
+	/* bridging code is allowed to know that this is where
+	 * the spi_master is stored ... so it can then for example
+	 * use that with spi_new_device().
+	 */
+	dev_set_drvdata(&pdev->dev, master);
+
+	/* this task is the only thing to touch the SPI bits.
+	 * it's OK if clock cycles stretch when it gets preempted
+	 */
+	bitbang->workqueue = create_singlethread_workqueue(pdev->dev.bus_id);
+	if (bitbang->workqueue == NULL) {
+		status = -EBUSY;
+		goto err1;
+	}
+
+	/* driver may get busy before register() returns, especially
+	 * if someone registered boardinfo for devices 
+	 */
+	status = spi_register_master(master);
+	if (status < 0)
+		goto err2;
+
+	return status;
+
+err2:
+	destroy_workqueue(bitbang->workqueue);
+err1:
+	class_device_put(&master->cdev);
+err0:
+	return status;
+}
+
+static int __devexit bitbang_remove(struct platform_device *pdev)
+{
+	struct spi_master		*master;
+	struct spi_bitbang		*bitbang;
+
+	master = dev_get_drvdata(&pdev->dev);
+	bitbang = class_get_devdata(&master->cdev);
+
+	/* NOTE:  assumes that all children were already cleaned up,
+	 * which also means there will be no pending requests...
+	 */
+	WARN_ON(!list_empty(&bitbang->queue));
+	WARN_ON(!list_empty(&pdev->dev.klist_children.k_list));
+
+	destroy_workqueue(bitbang->workqueue);
+	class_device_put(&master->cdev);
+	spi_unregister_master(master);
+
+	return 0;
+}
+
+struct platform_driver spi_bitbang_driver = {
+	.driver = {
+		.name =		"spi_bitbang",
+		.owner =	THIS_MODULE,
+	},
+	.probe =	bitbang_probe,
+	.remove =	__devexit_p(bitbang_remove),
+	// suspend, resume ... stop queue after current message, restart later
+};
+EXPORT_SYMBOL_GPL(spi_bitbang_driver);
+
+
+static int __init bitbang_init(void)
+{
+	return platform_driver_register(&spi_bitbang_driver);
+}
+device_initcall(bitbang_init);
+
+static void __exit bitbang_exit(void)
+{
+	platform_driver_unregister(&spi_bitbang_driver);
+}
+module_exit(bitbang_exit);
+
+MODULE_LICENSE("GPL");
+

--Boundary-00=_mejkD9zGMVEOESv--
