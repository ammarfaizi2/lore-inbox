Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbVLWOFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbVLWOFp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 09:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVLWOFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 09:05:45 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:30676 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030527AbVLWOFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 09:05:44 -0500
Date: Fri, 23 Dec 2005 17:06:19 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
Subject: [PATCH] SPI: turn transfers from arrays to linked lists
Message-Id: <20051223170619.55ef439d.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch inlined is changing the SPI core and its users to have transfers in the SPI message structure as linked list not as an array, for the reasons discussed recently in this list.
We decided to post is as a single patch, it's not that big to split it :)

Vitaly

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
Signed-off-by: Dmitry Pervushin <dpervushin@gmail.com>

 drivers/input/touchscreen/ads7846.c |   12 ++++++++----
 drivers/mtd/devices/m25p80.c        |   15 +++++++--------
 drivers/mtd/devices/mtd_dataflash.c |   27 +++++++++++++--------------
 drivers/spi/spi.c                   |    6 +++---
 drivers/spi/spi_bitbang.c           |   13 ++++---------
 include/linux/spi/spi.h             |   27 ++++++++++++++++-----------
 6 files changed, 51 insertions(+), 49 deletions(-)

diff -uNr --exclude='patches*' --exclude=.pc linux-2.6.orig/drivers/input/touchscreen/ads7846.c linux-2.6/drivers/input/touchscreen/ads7846.c
--- linux-2.6.orig/drivers/input/touchscreen/ads7846.c	2005-12-23 13:46:16.000000000 +0300
+++ linux-2.6/drivers/input/touchscreen/ads7846.c	2005-12-23 13:34:01.000000000 +0300
@@ -155,10 +155,13 @@
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
@@ -192,8 +195,8 @@
 	/* group all the transfers together, so we can't interfere with
 	 * reading touchscreen state; disable penirq while sampling
 	 */
-	req->msg.transfers = req->xfer;
-	req->msg.n_transfer = 6;
+	for (i = 0; i < 6; i++)
+		list_add_tail(&req->xfer[i].link, &req->msg.transfers);
 
 	disable_irq(spi->irq);
 	status = spi_sync(spi, &req->msg);
@@ -398,6 +401,7 @@
 	struct ads7846			*ts;
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_transfer		*x;
+	int				i;
 
 	if (!spi->irq) {
 		dev_dbg(&spi->dev, "no IRQ?\n");
@@ -500,8 +504,8 @@
 
 	CS_CHANGE(x[-1]);
 
-	ts->msg.transfers = ts->xfer;
-	ts->msg.n_transfer = x - ts->xfer;
+	for (i = 0; i < x - ts->xfer; i++)
+		list_add_tail(&ts->xfer[i].link, &ts->msg.transfers);
 	ts->msg.complete = ads7846_rx;
 	ts->msg.context = ts;
 
diff -uNr --exclude='patches*' --exclude=.pc linux-2.6.orig/drivers/mtd/devices/m25p80.c linux-2.6/drivers/mtd/devices/m25p80.c
--- linux-2.6.orig/drivers/mtd/devices/m25p80.c	2005-12-23 13:46:16.000000000 +0300
+++ linux-2.6/drivers/mtd/devices/m25p80.c	2005-12-23 15:38:19.000000000 +0300
@@ -231,7 +231,7 @@
 {
 	struct m25p *flash = mtd_to_m25p(mtd);
 	struct spi_transfer t[2];
-	struct spi_message m;
+	DECLARE_SPI_MESSAGE(m);
 
 	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %z\n", spi->dev.bus_id,
 			__FUNCTION__, "from", (u32) from, len);
@@ -268,12 +268,11 @@
 
 	t[0].tx_buf = flash->command;
 	t[0].len = sizeof(flash->command);
+	list_add_tail(&t[0].link, &m.transfers);
 
 	t[1].rx_buf = buf;
 	t[1].len = len;
-
-	m.transfers = t;
-	m.n_transfer = 2;
+	list_add_tail(&t[1].link, &m.transfers);
 
 	spi_sync(flash->spi, &m);
 
@@ -295,7 +294,7 @@
 	struct m25p *flash = mtd_to_m25p(mtd);
 	u32 page_offset, page_size;
 	struct spi_transfer t[2];
-	struct spi_message m;
+	DECLARE_SPI_MESSAGE(m);
 
 	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %z\n", spi->dev.bus_id,
 			__FUNCTION__, "to", (u32) to, len);
@@ -326,12 +325,12 @@
 	flash->command[2] = to >> 8;
 	flash->command[3] = to;
 
+	list_add_tail(&t[0].link, &m.transfers);
+	list_add_tail(&t[1].link, &m.transfers);
+
 	t[0].tx_buf = flash->command;
 	t[0].len = sizeof(flash->command);
 
-	m.transfers = t;
-	m.n_transfer = 2;
-
 	/* what page do we start with? */
 	page_offset = to % FLASH_PAGESIZE;
 
diff -uNr --exclude='patches*' --exclude=.pc linux-2.6.orig/drivers/mtd/devices/mtd_dataflash.c linux-2.6/drivers/mtd/devices/mtd_dataflash.c
--- linux-2.6.orig/drivers/mtd/devices/mtd_dataflash.c	2005-12-23 13:46:16.000000000 +0300
+++ linux-2.6/drivers/mtd/devices/mtd_dataflash.c	2005-12-23 15:31:14.000000000 +0300
@@ -147,8 +147,8 @@
 {
 	struct dataflash	*priv = (struct dataflash *)mtd->priv;
 	struct spi_device	*spi = priv->spi;
-	struct spi_transfer	x[1] = { { .tx_dma = 0, }, };
-	struct spi_message	msg;
+	struct spi_transfer	x = { .tx_dma = 0, };
+	DECLARE_SPI_MESSAGE(msg);
 	unsigned		blocksize = priv->page_size << 3;
 	u8			*command;
 
@@ -162,10 +162,9 @@
 			|| (instr->addr % priv->page_size) != 0)
 		return -EINVAL;
 
-	x[0].tx_buf = command = priv->command;
-	x[0].len = 4;
-	msg.transfers = x;
-	msg.n_transfer = 1;
+	x.tx_buf = command = priv->command;
+	x.len = 4;
+	list_add_tail(&x.link, &msg.transfers);
 
 	down(&priv->lock);
 	while (instr->len > 0) {
@@ -231,7 +230,7 @@
 {
 	struct dataflash	*priv = (struct dataflash *)mtd->priv;
 	struct spi_transfer	x[2] = { { .tx_dma = 0, }, };
-	struct spi_message	msg;
+	DECLARE_SPI_MESSAGE(msg);
 	unsigned int		addr;
 	u8			*command;
 	int			status;
@@ -258,10 +257,10 @@
 
 	x[0].tx_buf = command;
 	x[0].len = 8;
+	list_add_tail(&x[0].link, &msg.transfers);
 	x[1].rx_buf = buf;
 	x[1].len = len;
-	msg.transfers = x;
-	msg.n_transfer = 2;
+	list_add_tail(&x[1].link, &msg.transfers);
 
 	down(&priv->lock);
 
@@ -302,7 +301,7 @@
 	struct dataflash	*priv = (struct dataflash *)mtd->priv;
 	struct spi_device	*spi = priv->spi;
 	struct spi_transfer	x[2] = { { .tx_dma = 0, }, };
-	struct spi_message	msg;
+	DECLARE_SPI_MESSAGE(msg);
 	unsigned int		pageaddr, addr, offset, writelen;
 	size_t			remaining = len;
 	u_char			*writebuf = (u_char *) buf;
@@ -320,9 +319,10 @@
 	if ((to + len) > mtd->size)
 		return -EINVAL;
 
+	list_add_tail(&x[0].link, &msg.transfers);
+	
 	x[0].tx_buf = command = priv->command;
 	x[0].len = 4;
-	msg.transfers = x;
 
 	pageaddr = ((unsigned)to / priv->page_size);
 	offset = ((unsigned)to % priv->page_size);
@@ -364,7 +364,6 @@
 			DEBUG(MTD_DEBUG_LEVEL3, "TRANSFER: (%x) %x %x %x\n",
 				command[0], command[1], command[2], command[3]);
 
-			msg.n_transfer = 1;
 			status = spi_sync(spi, &msg);
 			if (status < 0)
 				DEBUG(MTD_DEBUG_LEVEL1, "%s: xfer %u -> %d \n",
@@ -385,8 +384,9 @@
 
 		x[1].tx_buf = writebuf;
 		x[1].len = writelen;
-		msg.n_transfer = 2;
+		list_add_tail(&x[1].link, &msg.transfers);
 		status = spi_sync(spi, &msg);
+		list_del(&x[1].link);
 		if (status < 0)
 			DEBUG(MTD_DEBUG_LEVEL1, "%s: pgm %u/%u -> %d \n",
 				spi->dev.bus_id, addr, writelen, status);
@@ -405,7 +405,6 @@
 		DEBUG(MTD_DEBUG_LEVEL3, "COMPARE: (%x) %x %x %x\n",
 			command[0], command[1], command[2], command[3]);
 
-		msg.n_transfer = 1;
 		status = spi_sync(spi, &msg);
 		if (status < 0)
 			DEBUG(MTD_DEBUG_LEVEL1, "%s: compare %u -> %d \n",
diff -uNr --exclude='patches*' --exclude=.pc linux-2.6.orig/drivers/spi/spi_bitbang.c linux-2.6/drivers/spi/spi_bitbang.c
--- linux-2.6.orig/drivers/spi/spi_bitbang.c	2005-12-23 13:46:16.000000000 +0300
+++ linux-2.6/drivers/spi/spi_bitbang.c	2005-12-23 16:13:35.000000000 +0300
@@ -242,7 +242,7 @@
 		struct spi_message	*m;
 		struct spi_device	*spi;
 		unsigned		nsecs;
-		struct spi_transfer	*t;
+		struct spi_transfer	*t = NULL;
 		unsigned		tmp;
 		unsigned		chipselect;
 		int			status;
@@ -259,12 +259,11 @@
 		nsecs = 100;
 
 		spi = m->spi;
-		t = m->transfers;
 		tmp = 0;
 		chipselect = 0;
 		status = 0;
 
-		for (;;t++) {
+		list_for_each_entry (t, &m->transfers, link) {
 			if (bitbang->shutdown) {
 				status = -ESHUTDOWN;
 				break;
@@ -295,10 +294,6 @@
 			if (t->delay_usecs)
 				udelay(t->delay_usecs);
 
-			tmp++;
-			if (tmp >= m->n_transfer)
-				break;
-
 			chipselect = !t->cs_change;
 			if (chipselect)
 				continue;
@@ -308,8 +303,8 @@
 			msleep(1);
 		}
 
-		tmp = m->n_transfer - 1;
-		tmp = m->transfers[tmp].cs_change;
+		if (t)
+			tmp = t->cs_change;
 
 		m->status = status;
 		m->complete(m->context);
diff -uNr --exclude='patches*' --exclude=.pc linux-2.6.orig/drivers/spi/spi.c linux-2.6/drivers/spi/spi.c
--- linux-2.6.orig/drivers/spi/spi.c	2005-12-23 13:46:16.000000000 +0300
+++ linux-2.6/drivers/spi/spi.c	2005-12-23 15:28:58.000000000 +0300
@@ -546,7 +546,7 @@
 	static DECLARE_MUTEX(lock);
 
 	int			status;
-	struct spi_message	message;
+	DECLARE_SPI_MESSAGE(message);
 	struct spi_transfer	x[2];
 	u8			*local_buf;
 
@@ -570,13 +570,13 @@
 	memcpy(local_buf, txbuf, n_tx);
 	x[0].tx_buf = local_buf;
 	x[0].len = n_tx;
+	list_add_tail(&x[0].link, &message.transfers);
 
 	x[1].rx_buf = local_buf + n_tx;
 	x[1].len = n_rx;
+	list_add_tail(&x[1].link, &message.transfers);
 
 	/* do the i/o */
-	message.transfers = x;
-	message.n_transfer = ARRAY_SIZE(x);
 	status = spi_sync(spi, &message);
 	if (status == 0) {
 		memcpy(rxbuf, x[1].rx_buf, n_rx);
diff -uNr --exclude='patches*' --exclude=.pc linux-2.6.orig/include/linux/spi/spi.h linux-2.6/include/linux/spi/spi.h
--- linux-2.6.orig/include/linux/spi/spi.h	2005-12-23 13:46:16.000000000 +0300
+++ linux-2.6/include/linux/spi/spi.h	2005-12-23 15:34:21.000000000 +0300
@@ -316,12 +316,13 @@
 
 	unsigned	cs_change:1;
 	u16		delay_usecs;
+
+	struct list_head link;
 };
 
 /**
  * struct spi_message - one multi-segment SPI transaction
  * @transfers: the segements of the transaction
- * @n_transfer: how many segments
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
  *	addresses for each transfer buffer
@@ -339,8 +340,7 @@
  * insulate against future API updates.
  */
 struct spi_message {
-	struct spi_transfer	*transfers;
-	unsigned		n_transfer;
+	struct list_head 	transfers;
 
 	struct spi_device	*spi;
 
@@ -371,6 +371,9 @@
 	void			*state;
 };
 
+#define DECLARE_SPI_MESSAGE(mmm)	struct spi_message mmm = \
+		{ .transfers = LIST_HEAD_INIT((mmm).transfers), }
+
 /* It's fine to embed message and transaction structures in other data
  * structures so long as you don't free them while they're in use.
  */
@@ -383,8 +386,12 @@
 			+ ntrans * sizeof(struct spi_transfer),
 			flags);
 	if (m) {
-		m->transfers = (void *)(m + 1);
-		m->n_transfer = ntrans;
+		int i;
+		struct spi_transfer *t = (struct spi_transfer *)(m + 1);
+
+		INIT_LIST_HEAD(&m->transfers);
+		for (i = 0; i < ntrans; i++)
+			list_add_tail(&t[i].link, &m->transfers);
 	}
 	return m;
 }
@@ -472,10 +479,9 @@
 			.len		= len,
 			.cs_change	= 0,
 		};
-	struct spi_message	m;
+	DECLARE_SPI_MESSAGE(m);
 
-	m.transfers	= &t;
-	m.n_transfer	= 1;
+	list_add_tail(&t.link, &m.transfers);
 	return spi_sync(spi, &m);
 }
 
@@ -497,10 +503,9 @@
 			.len		= len,
 			.cs_change	= 0,
 		};
-	struct spi_message	m;
+	DECLARE_SPI_MESSAGE(m);
 
-	m.transfers	= &t;
-	m.n_transfer	= 1;
+	list_add_tail(&t.link, &m.transfers);
 	return spi_sync(spi, &m);
 }
 
