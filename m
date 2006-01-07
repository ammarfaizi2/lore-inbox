Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbWAGD0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbWAGD0P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWAGD0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:26:15 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:40879 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030329AbWAGD0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:26:12 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] SPI: turn transfers from arrays to linked lists
Date: Tue, 3 Jan 2006 20:14:07 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
References: <20051223170619.55ef439d.vwool@ru.mvista.com>
In-Reply-To: <20051223170619.55ef439d.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601032014.07649.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'll be passing this version along with future versions;
appropriate for merging into -mm I think.  This does change
how ever driver hooks things up, but those changes should be
easy to get right.

- Dave



This makes the SPI core and its users access transfers in the SPI message
structure as linked list not as an array, as discussed on LKML.

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
Signed-off-by: Dmitry Pervushin <dpervushin@gmail.com>


Minor updates including doc, bugfixes to the list code, and adding
spi_message_add_tail().  Plus, initialize things _before_ grabbing the
locks in some cases (in case it grows more expensive).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 Documentation/spi/spi-summary       |   13 +++++
 drivers/input/touchscreen/ads7846.c |   12 +++--
 drivers/mtd/devices/m25p80.c        |   50 ++++++++++----------
 drivers/mtd/devices/mtd_dataflash.c |   28 +++++++----
 drivers/spi/spi.c                   |   18 ++++---
 drivers/spi/spi_bitbang.c           |   65 ++++++++++++++++-----------
 include/linux/spi/spi.h             |   86 +++++++++++++++++++++++++-----------
 7 files changed, 175 insertions(+), 97 deletions(-)


--- g26.orig/include/linux/spi/spi.h	2006-01-03 19:06:19.000000000 -0800
+++ g26/include/linux/spi/spi.h	2006-01-03 19:44:15.000000000 -0800
@@ -263,15 +263,16 @@ extern struct spi_master *spi_busnum_to_
 
 /**
  * struct spi_transfer - a read/write buffer pair
- * @tx_buf: data to be written (dma-safe address), or NULL
- * @rx_buf: data to be read (dma-safe address), or NULL
- * @tx_dma: DMA address of buffer, if spi_message.is_dma_mapped
- * @rx_dma: DMA address of buffer, if spi_message.is_dma_mapped
+ * @tx_buf: data to be written (dma-safe memory), or NULL
+ * @rx_buf: data to be read (dma-safe memory), or NULL
+ * @tx_dma: DMA address of tx_buf, if spi_message.is_dma_mapped
+ * @rx_dma: DMA address of rx_buf, if spi_message.is_dma_mapped
  * @len: size of rx and tx buffers (in bytes)
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
  * 	(optionally) changing the chipselect status, then starting
  * 	the next transfer or completing this spi_message.
+ * @transfer_list: transfers are sequenced through spi_message.transfers
  *
  * SPI transfers always write the same number of bytes as they read.
  * Protocol drivers should always provide rx_buf and/or tx_buf.
@@ -279,11 +280,16 @@ extern struct spi_master *spi_busnum_to_
  * the data being transferred; that may reduce overhead, when the
  * underlying driver uses dma.
  *
- * All SPI transfers start with the relevant chipselect active.  Drivers
- * can change behavior of the chipselect after the transfer finishes
- * (including any mandatory delay).  The normal behavior is to leave it
- * selected, except for the last transfer in a message.  Setting cs_change
- * allows two additional behavior options:
+ * If the transmit buffer is null, undefined data will be shifted out
+ * while filling rx_buf.  If the receive buffer is null, the data
+ * shifted in will be discarded.  Only "len" bytes shift out (or in).
+ * It's an error to try to shift out a partial word.  (For example, by
+ * shifting out three bytes with word size of sixteen or twenty bits;
+ * the former uses two bytes per word, the latter uses four bytes.)
+ *
+ * All SPI transfers start with the relevant chipselect active.  Normally
+ * it stays selected until after the last transfer in a message.  Drivers
+ * can affect the chipselect signal using cs_change:
  *
  * (i) If the transfer isn't the last one in the message, this flag is
  * used to make the chipselect briefly go inactive in the middle of the
@@ -299,7 +305,8 @@ extern struct spi_master *spi_busnum_to_
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
  * Zero-initialize every field you don't set up explicitly, to
- * insulate against future API updates.
+ * insulate against future API updates.  After you submit a message
+ * and its transfers, ignore them until its completion callback.
  */
 struct spi_transfer {
 	/* it's ok if tx_buf == rx_buf (right?)
@@ -316,12 +323,13 @@ struct spi_transfer {
 
 	unsigned	cs_change:1;
 	u16		delay_usecs;
+
+	struct list_head transfer_list;
 };
 
 /**
  * struct spi_message - one multi-segment SPI transaction
- * @transfers: the segements of the transaction
- * @n_transfer: how many segments
+ * @transfers: list of transfer segments in this transaction
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
  *	addresses for each transfer buffer
@@ -333,14 +341,22 @@ struct spi_transfer {
  * @queue: for use by whichever driver currently owns the message
  * @state: for use by whichever driver currently owns the message
  *
+ * An spi_message is used to execute an atomic sequence of data transfers,
+ * each represented by a struct spi_transfer.  The sequence is "atomic"
+ * in the sense that no other spi_message may use that SPI bus until that
+ * sequence completes.  On some systems, many such sequences can execute as
+ * as single programmed DMA transfer.  On all systems, these messages are
+ * queued, and might complete after transactions to other devices.  Messages
+ * sent to a given spi_device are alway executed in FIFO order.
+ *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
  * Zero-initialize every field you don't set up explicitly, to
- * insulate against future API updates.
+ * insulate against future API updates.  After you submit a message
+ * and its transfers, ignore them until its completion callback.
  */
 struct spi_message {
-	struct spi_transfer	*transfers;
-	unsigned		n_transfer;
+	struct list_head 	transfers;
 
 	struct spi_device	*spi;
 
@@ -371,6 +387,24 @@ struct spi_message {
 	void			*state;
 };
 
+static inline void spi_message_init(struct spi_message *m)
+{
+	memset(m, 0, sizeof *m);
+	INIT_LIST_HEAD(&m->transfers);
+}
+
+static inline void
+spi_message_add_tail(struct spi_transfer *t, struct spi_message *m)
+{
+	list_add_tail(&t->transfer_list, &m->transfers);
+}
+
+static inline void
+spi_transfer_del(struct spi_transfer *t)
+{
+	list_del(&t->transfer_list);
+}
+
 /* It's fine to embed message and transaction structures in other data
  * structures so long as you don't free them while they're in use.
  */
@@ -383,8 +417,12 @@ static inline struct spi_message *spi_me
 			+ ntrans * sizeof(struct spi_transfer),
 			flags);
 	if (m) {
-		m->transfers = (void *)(m + 1);
-		m->n_transfer = ntrans;
+		int i;
+		struct spi_transfer *t = (struct spi_transfer *)(m + 1);
+
+		INIT_LIST_HEAD(&m->transfers);
+		for (i = 0; i < ntrans; i++, t++)
+			spi_message_add_tail(t, m);
 	}
 	return m;
 }
@@ -402,6 +440,8 @@ static inline void spi_message_free(stru
  * device doesn't work with the mode 0 default.  They may likewise need
  * to update clock rates or word sizes from initial values.  This function
  * changes those settings, and must be called from a context that can sleep.
+ * The changes take effect the next time the device is selected and data
+ * is transferred to or from it.
  */
 static inline int
 spi_setup(struct spi_device *spi)
@@ -468,14 +508,12 @@ spi_write(struct spi_device *spi, const 
 {
 	struct spi_transfer	t = {
 			.tx_buf		= buf,
-			.rx_buf		= NULL,
 			.len		= len,
-			.cs_change	= 0,
 		};
 	struct spi_message	m;
 
-	m.transfers	= &t;
-	m.n_transfer	= 1;
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
 	return spi_sync(spi, &m);
 }
 
@@ -492,15 +530,13 @@ static inline int
 spi_read(struct spi_device *spi, u8 *buf, size_t len)
 {
 	struct spi_transfer	t = {
-			.tx_buf		= NULL,
 			.rx_buf		= buf,
 			.len		= len,
-			.cs_change	= 0,
 		};
 	struct spi_message	m;
 
-	m.transfers	= &t;
-	m.n_transfer	= 1;
+	spi_message_init(&m);
+	spi_message_add_tail(&t, &m);
 	return spi_sync(spi, &m);
 }
 
--- g26.orig/drivers/spi/spi.c	2006-01-03 19:06:19.000000000 -0800
+++ g26/drivers/spi/spi.c	2006-01-03 19:55:35.000000000 -0800
@@ -557,6 +557,17 @@ int spi_write_then_read(struct spi_devic
 	if ((n_tx + n_rx) > SPI_BUFSIZ)
 		return -EINVAL;
 
+	spi_message_init(&message);
+	memset(x, 0, sizeof x);
+	if (n_tx) {
+		x[0].len = n_tx;
+		spi_message_add_tail(&x[0], &message);
+	}
+	if (n_rx) {
+		x[1].len = n_rx;
+		spi_message_add_tail(&x[1], &message);
+	}
+
 	/* ... unless someone else is using the pre-allocated buffer */
 	if (down_trylock(&lock)) {
 		local_buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
@@ -565,18 +576,11 @@ int spi_write_then_read(struct spi_devic
 	} else
 		local_buf = buf;
 
-	memset(x, 0, sizeof x);
-
 	memcpy(local_buf, txbuf, n_tx);
 	x[0].tx_buf = local_buf;
-	x[0].len = n_tx;
-
 	x[1].rx_buf = local_buf + n_tx;
-	x[1].len = n_rx;
 
 	/* do the i/o */
-	message.transfers = x;
-	message.n_transfer = ARRAY_SIZE(x);
 	status = spi_sync(spi, &message);
 	if (status == 0) {
 		memcpy(rxbuf, x[1].rx_buf, n_rx);
--- g26.orig/drivers/input/touchscreen/ads7846.c	2006-01-03 19:06:19.000000000 -0800
+++ g26/drivers/input/touchscreen/ads7846.c	2006-01-03 19:11:20.000000000 -0800
@@ -155,10 +155,13 @@ static int ads7846_read12_ser(struct dev
 	struct ser_req		*req = kzalloc(sizeof *req, SLAB_KERNEL);
 	int			status;
 	int			sample;
+	int 			i;
 
 	if (!req)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&req->msg.transfers);
+
 	/* activate reference, so it has time to settle; */
 	req->xfer[0].tx_buf = &ref_on;
 	req->xfer[0].len = 1;
@@ -192,8 +195,8 @@ static int ads7846_read12_ser(struct dev
 	/* group all the transfers together, so we can't interfere with
 	 * reading touchscreen state; disable penirq while sampling
 	 */
-	req->msg.transfers = req->xfer;
-	req->msg.n_transfer = 6;
+	for (i = 0; i < 6; i++)
+		spi_message_add_tail(&req->xfer[i], &req->msg);
 
 	disable_irq(spi->irq);
 	status = spi_sync(spi, &req->msg);
@@ -398,6 +401,7 @@ static int __devinit ads7846_probe(struc
 	struct ads7846			*ts;
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_transfer		*x;
+	int				i;
 
 	if (!spi->irq) {
 		dev_dbg(&spi->dev, "no IRQ?\n");
@@ -500,8 +504,8 @@ static int __devinit ads7846_probe(struc
 
 	CS_CHANGE(x[-1]);
 
-	ts->msg.transfers = ts->xfer;
-	ts->msg.n_transfer = x - ts->xfer;
+	for (i = 0; i < x - ts->xfer; i++)
+		spi_message_add_tail(&ts->xfer[i], &ts->msg);
 	ts->msg.complete = ads7846_rx;
 	ts->msg.context = ts;
 
--- g26.orig/drivers/mtd/devices/m25p80.c	2006-01-03 19:06:19.000000000 -0800
+++ g26/drivers/mtd/devices/m25p80.c	2006-01-03 19:43:09.000000000 -0800
@@ -243,6 +243,21 @@ static int m25p80_read(struct mtd_info *
 	if (from + len > flash->mtd.size)
 		return -EINVAL;
 
+	spi_message_init(&m);
+	memset(t, 0, (sizeof t));
+
+	t[0].tx_buf = flash->command;
+	t[0].len = sizeof(flash->command);
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].rx_buf = buf;
+	t[1].len = len;
+	spi_message_add_tail(&t[1], &m);
+
+	/* Byte count starts at zero. */
+	if (retlen)
+		*retlen = 0;
+
 	down(&flash->lock);
 
 	/* Wait till previous write/erase is done. */
@@ -252,8 +267,6 @@ static int m25p80_read(struct mtd_info *
 		return 1;
 	}
 
-	memset(t, 0, (sizeof t));
-
 	/* NOTE:  OPCODE_FAST_READ (if available) is faster... */
 
 	/* Set up the write data buffer. */
@@ -262,19 +275,6 @@ static int m25p80_read(struct mtd_info *
 	flash->command[2] = from >> 8;
 	flash->command[3] = from;
 
-	/* Byte count starts at zero. */
-	if (retlen)
-		*retlen = 0;
-
-	t[0].tx_buf = flash->command;
-	t[0].len = sizeof(flash->command);
-
-	t[1].rx_buf = buf;
-	t[1].len = len;
-
-	m.transfers = t;
-	m.n_transfer = 2;
-
 	spi_sync(flash->spi, &m);
 
 	*retlen = m.actual_length - sizeof(flash->command);
@@ -310,6 +310,16 @@ static int m25p80_write(struct mtd_info 
 	if (to + len > flash->mtd.size)
 		return -EINVAL;
 
+	spi_message_init(&m);
+	memset(t, 0, (sizeof t));
+
+	t[0].tx_buf = flash->command;
+	t[0].len = sizeof(flash->command);
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].tx_buf = buf;
+	spi_message_add_tail(&t[1], &m);
+
   	down(&flash->lock);
 
 	/* Wait until finished previous write command. */
@@ -318,26 +328,17 @@ static int m25p80_write(struct mtd_info 
 
 	write_enable(flash);
 
-	memset(t, 0, (sizeof t));
-
 	/* Set up the opcode in the write buffer. */
 	flash->command[0] = OPCODE_PP;
 	flash->command[1] = to >> 16;
 	flash->command[2] = to >> 8;
 	flash->command[3] = to;
 
-	t[0].tx_buf = flash->command;
-	t[0].len = sizeof(flash->command);
-
-	m.transfers = t;
-	m.n_transfer = 2;
-
 	/* what page do we start with? */
 	page_offset = to % FLASH_PAGESIZE;
 
 	/* do all the bytes fit onto one page? */
 	if (page_offset + len <= FLASH_PAGESIZE) {
-		t[1].tx_buf = buf;
 		t[1].len = len;
 
 		spi_sync(flash->spi, &m);
@@ -349,7 +350,6 @@ static int m25p80_write(struct mtd_info 
 		/* the size of data remaining on the first page */
 		page_size = FLASH_PAGESIZE - page_offset;
 
-		t[1].tx_buf = buf;
 		t[1].len = page_size;
 		spi_sync(flash->spi, &m);
 
--- g26.orig/drivers/mtd/devices/mtd_dataflash.c	2006-01-03 19:06:19.000000000 -0800
+++ g26/drivers/mtd/devices/mtd_dataflash.c	2006-01-03 19:23:13.000000000 -0800
@@ -147,7 +147,7 @@ static int dataflash_erase(struct mtd_in
 {
 	struct dataflash	*priv = (struct dataflash *)mtd->priv;
 	struct spi_device	*spi = priv->spi;
-	struct spi_transfer	x[1] = { { .tx_dma = 0, }, };
+	struct spi_transfer	x = { .tx_dma = 0, };
 	struct spi_message	msg;
 	unsigned		blocksize = priv->page_size << 3;
 	u8			*command;
@@ -162,10 +162,11 @@ static int dataflash_erase(struct mtd_in
 			|| (instr->addr % priv->page_size) != 0)
 		return -EINVAL;
 
-	x[0].tx_buf = command = priv->command;
-	x[0].len = 4;
-	msg.transfers = x;
-	msg.n_transfer = 1;
+	spi_message_init(&msg);
+
+	x.tx_buf = command = priv->command;
+	x.len = 4;
+	spi_message_add_tail(&x, &msg);
 
 	down(&priv->lock);
 	while (instr->len > 0) {
@@ -256,12 +257,15 @@ static int dataflash_read(struct mtd_inf
 	DEBUG(MTD_DEBUG_LEVEL3, "READ: (%x) %x %x %x\n",
 		command[0], command[1], command[2], command[3]);
 
+	spi_message_init(&msg);
+
 	x[0].tx_buf = command;
 	x[0].len = 8;
+	spi_message_add_tail(&x[0], &msg);
+
 	x[1].rx_buf = buf;
 	x[1].len = len;
-	msg.transfers = x;
-	msg.n_transfer = 2;
+	spi_message_add_tail(&x[1], &msg);
 
 	down(&priv->lock);
 
@@ -320,9 +324,11 @@ static int dataflash_write(struct mtd_in
 	if ((to + len) > mtd->size)
 		return -EINVAL;
 
+	spi_message_init(&msg);
+
 	x[0].tx_buf = command = priv->command;
 	x[0].len = 4;
-	msg.transfers = x;
+	spi_message_add_tail(&x[0], &msg);
 
 	pageaddr = ((unsigned)to / priv->page_size);
 	offset = ((unsigned)to % priv->page_size);
@@ -364,7 +370,6 @@ static int dataflash_write(struct mtd_in
 			DEBUG(MTD_DEBUG_LEVEL3, "TRANSFER: (%x) %x %x %x\n",
 				command[0], command[1], command[2], command[3]);
 
-			msg.n_transfer = 1;
 			status = spi_sync(spi, &msg);
 			if (status < 0)
 				DEBUG(MTD_DEBUG_LEVEL1, "%s: xfer %u -> %d \n",
@@ -385,14 +390,16 @@ static int dataflash_write(struct mtd_in
 
 		x[1].tx_buf = writebuf;
 		x[1].len = writelen;
-		msg.n_transfer = 2;
+		spi_message_add_tail(x + 1, &msg);
 		status = spi_sync(spi, &msg);
+		spi_transfer_del(x + 1);
 		if (status < 0)
 			DEBUG(MTD_DEBUG_LEVEL1, "%s: pgm %u/%u -> %d \n",
 				spi->dev.bus_id, addr, writelen, status);
 
 		(void) dataflash_waitready(priv->spi);
 
+
 #ifdef	CONFIG_DATAFLASH_WRITE_VERIFY
 
 		/* (3) Compare to Buffer1 */
@@ -405,7 +412,6 @@ static int dataflash_write(struct mtd_in
 		DEBUG(MTD_DEBUG_LEVEL3, "COMPARE: (%x) %x %x %x\n",
 			command[0], command[1], command[2], command[3]);
 
-		msg.n_transfer = 1;
 		status = spi_sync(spi, &msg);
 		if (status < 0)
 			DEBUG(MTD_DEBUG_LEVEL1, "%s: compare %u -> %d \n",
--- g26.orig/drivers/spi/spi_bitbang.c	2006-01-03 19:06:19.000000000 -0800
+++ g26/drivers/spi/spi_bitbang.c	2006-01-03 19:44:50.000000000 -0800
@@ -242,9 +242,9 @@ static void bitbang_work(void *_bitbang)
 		struct spi_message	*m;
 		struct spi_device	*spi;
 		unsigned		nsecs;
-		struct spi_transfer	*t;
+		struct spi_transfer	*t = NULL;
 		unsigned		tmp;
-		unsigned		chipselect;
+		unsigned		cs_change;
 		int			status;
 
 		m = container_of(bitbang->queue.next, struct spi_message,
@@ -259,30 +259,44 @@ static void bitbang_work(void *_bitbang)
 		nsecs = 100;
 
 		spi = m->spi;
-		t = m->transfers;
 		tmp = 0;
-		chipselect = 0;
+		cs_change = 1;
 		status = 0;
 
-		for (;;t++) {
+		list_for_each_entry (t, &m->transfers, transfer_list) {
 			if (bitbang->shutdown) {
 				status = -ESHUTDOWN;
 				break;
 			}
 
-			/* set up default clock polarity, and activate chip */
-			if (!chipselect) {
+			/* set up default clock polarity, and activate chip;
+			 * this implicitly updates clock and spi modes as
+			 * previously recorded for this device via setup().
+			 * (and also deselects any other chip that might be
+			 * selected ...)
+			 */
+			if (cs_change) {
 				bitbang->chipselect(spi, BITBANG_CS_ACTIVE);
 				ndelay(nsecs);
 			}
+			cs_change = t->cs_change;
 			if (!t->tx_buf && !t->rx_buf && t->len) {
 				status = -EINVAL;
 				break;
 			}
 
-			/* transfer data */
-			if (t->len)
+			/* transfer data.  the lower level code handles any
+			 * new dma mappings it needs. our caller always gave
+			 * us dma-safe buffers.
+			 */
+			if (t->len) {
+				/* REVISIT dma API still needs a designated
+				 * DMA_ADDR_INVALID; ~0 might be better.
+				 */
+				if (!m->is_dma_mapped)
+					t->rx_dma = t->tx_dma = 0;
 				status = bitbang->txrx_bufs(spi, t);
+			}
 			if (status != t->len) {
 				if (status > 0)
 					status = -EMSGSIZE;
@@ -295,30 +309,31 @@ static void bitbang_work(void *_bitbang)
 			if (t->delay_usecs)
 				udelay(t->delay_usecs);
 
-			tmp++;
-			if (tmp >= m->n_transfer)
-				break;
-
-			chipselect = !t->cs_change;
-			if (chipselect)
+			if (!cs_change)
 				continue;
+			if (t->transfer_list.next == &m->transfers)
+				break;
 
+			/* sometimes a short mid-message deselect of the chip
+			 * may be needed to terminate a mode or command
+			 */
+			ndelay(nsecs);
 			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
-
-			msleep(1);
+			ndelay(nsecs);
 		}
 
-		tmp = m->n_transfer - 1;
-		tmp = m->transfers[tmp].cs_change;
-
 		m->status = status;
 		m->complete(m->context);
 
-		ndelay(2 * nsecs);
-		bitbang->chipselect(spi, (status == 0 && tmp)
-				? BITBANG_CS_ACTIVE
-				: BITBANG_CS_INACTIVE);
-		ndelay(nsecs);
+		/* normally deactivate chipselect ... unless no error and
+		 * cs_change has hinted that the next message will probably
+		 * be for this chip too.
+		 */
+		if (!(status == 0 && cs_change)) {
+			ndelay(nsecs);
+			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
+			ndelay(nsecs);
+		}
 
 		spin_lock_irqsave(&bitbang->lock, flags);
 	}
--- g26.orig/Documentation/spi/spi-summary	2006-01-03 19:06:19.000000000 -0800
+++ g26/Documentation/spi/spi-summary	2006-01-03 19:06:19.000000000 -0800
@@ -114,6 +114,9 @@ shows up in sysfs in several locations:
    /sys/devices/.../CTLR/spiB.C ... spi_device for on bus "B",
 	chipselect C, accessed through CTLR.
 
+   /sys/devices/.../CTLR/spiB.C/modalias ... identifies the driver
+	that should be used with this device (for hotplug/coldplug)
+
    /sys/bus/spi/devices/spiB.C ... symlink to the physical
    	spiB-C device
 
@@ -246,6 +249,12 @@ driver is registered:
 
 Like with other static board-specific setup, you won't unregister those.
 
+The widely used "card" style computers bundle memory, cpu, and little else
+onto a card that's maybe just thirty square centimeters.  On such systems,
+your arch/.../mach-.../board-*.c file would primarily provide information
+about the devices on the mainboard into which such a card is plugged.  That
+certainly includes SPI devices hooked up through the card connectors!
+
 
 NON-STATIC CONFIGURATIONS
 
@@ -257,6 +266,10 @@ up the spi bus master, and will likely n
 board info based on the board that was hotplugged.  Of course, you'd later
 call at least spi_unregister_device() when that board is removed.
 
+When Linux includes support for MMC/SD/SDIO/DataFlash cards through SPI, those
+configurations will also be dynamic.  Fortunately, those devices all support
+basic device identification probes, so that support should hotplug normally.
+
 
 How do I write an "SPI Protocol Driver"?
 ----------------------------------------
