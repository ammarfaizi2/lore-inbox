Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbVLMQww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbVLMQww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030182AbVLMQww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:52:52 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:53194 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030181AbVLMQwv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:52:51 -0500
Date: Tue, 13 Dec 2005 19:53:17 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, dpervushin@gmail.com,
       akpm@osdl.org, greg@kroah.com, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Message-Id: <20051213195317.29cfd34a.vwool@ru.mvista.com>
In-Reply-To: <20051213170629.7240d211.vwool@ru.mvista.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com>
	<20051213170629.7240d211.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

this patch removes nasty buffer allocation in spi core for sync message transfers. (And thus solves the problem of possible priority inversion I've pointed out before).
The write_then_read function sets the flags singalling for buffers not being DMA-safe and it's absolutely up to the controller whatta do with that.
I. e. it will prolly allocate/copy if it performs DMA transfers or just don't do anything special if it's working in PIO. It can even use a single DMA-safe buffer as David's core did (although I wouldn't encourage anyone to do that! :))
This is of coure more flexible and also more optimal as it will *not* require _redundant_ memcpy's and semaphores protection in case of PIO transfers.
Please note that this is a key patch for us in some aspects, although it's rather small! :)

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>
Signed-off-by: Dmitry Pervushin <dpervushin@gmail.com>

 drivers/spi/spi.c       |   35 ++++++-----------------------------
 include/linux/spi/spi.h |    7 +++++++
 2 files changed, 13 insertions(+), 29 deletions(-)

Index: linux-2.6.orig/drivers/spi/spi.c
===================================================================
--- linux-2.6.orig.orig/drivers/spi/spi.c
+++ linux-2.6.orig/drivers/spi/spi.c
@@ -507,10 +507,6 @@ int spi_sync(struct spi_device *spi, str
 }
 EXPORT_SYMBOL_GPL(spi_sync);
 
-#define	SPI_BUFSIZ	(SMP_CACHE_BYTES)
-
-static u8	*buf;
-
 /**
  * spi_write_then_read - SPI synchronous write followed by read
  * @spi: device with which data will be exchanged
@@ -532,39 +528,28 @@ int spi_write_then_read(struct spi_devic
 		const u8 *txbuf, unsigned n_tx,
 		u8 *rxbuf, unsigned n_rx)
 {
-	static DECLARE_MUTEX(lock);
-
 	int			status;
 	struct spi_message	message;
 	struct spi_transfer	x[2];
 
-	/* Use preallocated DMA-safe buffer.  We can't avoid copying here,
-	 * (as a pure convenience thing), but we can keep heap costs
-	 * out of the hot path.
-	 */
-	if ((n_tx + n_rx) > SPI_BUFSIZ)
-		return -EINVAL;
-
-	down(&lock);
 	memset(x, 0, sizeof x);
+	memset(&message, 0, sizeof message);
 
-	memcpy(buf, txbuf, n_tx);
-	x[0].tx_buf = buf;
+	x[0].tx_buf = tx_buf;
 	x[0].len = n_tx;
+	x[0].tx_dma_unsafe = 1;
 
-	x[1].rx_buf = buf + n_tx;
+	x[1].rx_buf = rx_buf;
 	x[1].len = n_rx;
+	x[1].rx_dma_unsafe = 1;
 
 	/* do the i/o */
 	message.transfers = x;
 	message.n_transfer = ARRAY_SIZE(x);
 	status = spi_sync(spi, &message);
-	if (status == 0) {
-		memcpy(rxbuf, x[1].rx_buf, n_rx);
+	if (status == 0)
 		status = message.status;
-	}
 
-	up(&lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_write_then_read);
@@ -575,12 +560,6 @@ static int __init spi_init(void)
 {
 	int	status;
 
-	buf = kmalloc(SPI_BUFSIZ, SLAB_KERNEL);
-	if (!buf) {
-		status = -ENOMEM;
-		goto err0;
-	}
-
 	status = bus_register(&spi_bus_type);
 	if (status < 0)
 		goto err1;
@@ -593,9 +572,7 @@ static int __init spi_init(void)
 err2:
 	bus_unregister(&spi_bus_type);
 err1:
-	kfree(buf);
 	buf = NULL;
-err0:
 	return status;
 }
 
Index: linux-2.6.orig/include/linux/spi/spi.h
===================================================================
--- linux-2.6.orig.orig/include/linux/spi/spi.h
+++ linux-2.6.orig/include/linux/spi/spi.h
@@ -248,6 +248,10 @@ extern struct spi_master *spi_busnum_to_
  * @rx_dma: DMA address of buffer, if spi_message.is_dma_mapped
  * @len: size of rx and tx buffers (in bytes)
  * @cs_change: affects chipselect after this transfer completes
+ * @tx_dma_unsafe: signals to controller driver that the buffer
+ * 	is not DMA-safe
+ * @rx_dma_unsafe: signals to controller driver that the buffer
+ * 	is not DMA-safe
  * @delay_usecs: microseconds to delay after this transfer before
  * 	(optionally) changing the chipselect status, then starting
  * 	the next transfer or completing this spi_message.
@@ -288,6 +292,9 @@ struct spi_transfer {
 	dma_addr_t	rx_dma;
 
 	unsigned	cs_change:1;
+	unsigned	rx_dma_unsafe:1;
+	unsigned	tx_dma_unsafe:1;
+
 	u16		delay_usecs;
 };
 
