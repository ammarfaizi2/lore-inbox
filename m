Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWEPVlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWEPVlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWEPVlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:41:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:35246 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932174AbWEPVkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:40:46 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Imre Deak <imre.deak@nokia.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 01/10] SPI: per-transfer overrides for wordsize and clocking
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 16 May 2006 14:38:29 -0700
Message-Id: <1147815518285-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.2
In-Reply-To: <20060516213716.GA7972@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Imre Deak <imre.deak@nokia.com>

Some protocols (like one for some bitmap displays) require different clock
speed or word size settings for each transfer in an SPI message. This adds
those parameters to struct spi_transfer.  They are to be used when they are
nonzero; otherwise the defaults from spi_device are to be used.

The patch also adds a setup_transfer callback to spi_bitbang, uses it for
messages that use those overrides, and implements it so that the pure
bitbanging code can help resolve any questions about how it should work.

Signed-off-by: Imre Deak <imre.deak@nokia.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/spi/spi_bitbang.c       |   77 ++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h         |    8 ++++
 include/linux/spi/spi_bitbang.h |    6 +++
 3 files changed, 77 insertions(+), 14 deletions(-)

4cff33f94fefcce1b3c01a9d1da6bb85fe3cbdfa
diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index f037e55..0525c99 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -138,6 +138,43 @@ static unsigned bitbang_txrx_32(
 	return t->len - count;
 }
 
+static int
+bitbang_transfer_setup(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct spi_bitbang_cs	*cs = spi->controller_state;
+	u8			bits_per_word;
+	u32			hz;
+
+	if (t) {
+		bits_per_word = t->bits_per_word;
+		hz = t->speed_hz;
+	} else {
+		bits_per_word = 0;
+		hz = 0;
+	}
+
+	/* spi_transfer level calls that work per-word */
+	if (!bits_per_word)
+		bits_per_word = spi->bits_per_word;
+	if (bits_per_word <= 8)
+		cs->txrx_bufs = bitbang_txrx_8;
+	else if (bits_per_word <= 16)
+		cs->txrx_bufs = bitbang_txrx_16;
+	else if (bits_per_word <= 32)
+		cs->txrx_bufs = bitbang_txrx_32;
+	else
+		return -EINVAL;
+
+	/* nsecs = (clock period)/2 */
+	if (!hz)
+		hz = spi->max_speed_hz;
+	cs->nsecs = (1000000000/2) / hz;
+	if (cs->nsecs > MAX_UDELAY_MS * 1000)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * spi_bitbang_setup - default setup for per-word I/O loops
  */
@@ -145,6 +182,7 @@ int spi_bitbang_setup(struct spi_device 
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
 	struct spi_bitbang	*bitbang;
+	int			retval;
 
 	if (!spi->max_speed_hz)
 		return -EINVAL;
@@ -160,25 +198,14 @@ int spi_bitbang_setup(struct spi_device 
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
-	/* spi_transfer level calls that work per-word */
-	if (spi->bits_per_word <= 8)
-		cs->txrx_bufs = bitbang_txrx_8;
-	else if (spi->bits_per_word <= 16)
-		cs->txrx_bufs = bitbang_txrx_16;
-	else if (spi->bits_per_word <= 32)
-		cs->txrx_bufs = bitbang_txrx_32;
-	else
-		return -EINVAL;
-
 	/* per-word shift register access, in hardware or bitbanging */
 	cs->txrx_word = bitbang->txrx_word[spi->mode & (SPI_CPOL|SPI_CPHA)];
 	if (!cs->txrx_word)
 		return -EINVAL;
 
-	/* nsecs = (clock period)/2 */
-	cs->nsecs = (1000000000/2) / (spi->max_speed_hz);
-	if (cs->nsecs > MAX_UDELAY_MS * 1000)
-		return -EINVAL;
+	retval = bitbang_transfer_setup(spi, NULL);
+	if (retval < 0)
+		return retval;
 
 	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec\n",
 			__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
@@ -246,6 +273,8 @@ static void bitbang_work(void *_bitbang)
 		unsigned		tmp;
 		unsigned		cs_change;
 		int			status;
+		int			(*setup_transfer)(struct spi_device *,
+						struct spi_transfer *);
 
 		m = container_of(bitbang->queue.next, struct spi_message,
 				queue);
@@ -262,6 +291,7 @@ static void bitbang_work(void *_bitbang)
 		tmp = 0;
 		cs_change = 1;
 		status = 0;
+		setup_transfer = NULL;
 
 		list_for_each_entry (t, &m->transfers, transfer_list) {
 			if (bitbang->shutdown) {
@@ -269,6 +299,20 @@ static void bitbang_work(void *_bitbang)
 				break;
 			}
 
+			/* override or restore speed and wordsize */
+			if (t->speed_hz || t->bits_per_word) {
+				setup_transfer = bitbang->setup_transfer;
+				if (!setup_transfer) {
+					status = -ENOPROTOOPT;
+					break;
+				}
+			}
+			if (setup_transfer) {
+				status = setup_transfer(spi, t);
+				if (status < 0)
+					break;
+			}
+
 			/* set up default clock polarity, and activate chip;
 			 * this implicitly updates clock and spi modes as
 			 * previously recorded for this device via setup().
@@ -325,6 +369,10 @@ static void bitbang_work(void *_bitbang)
 		m->status = status;
 		m->complete(m->context);
 
+		/* restore speed and wordsize */
+		if (setup_transfer)
+			setup_transfer(spi, NULL);
+
 		/* normally deactivate chipselect ... unless no error and
 		 * cs_change has hinted that the next message will probably
 		 * be for this chip too.
@@ -406,6 +454,7 @@ int spi_bitbang_start(struct spi_bitbang
 		bitbang->use_dma = 0;
 		bitbang->txrx_bufs = spi_bitbang_bufs;
 		if (!bitbang->master->setup) {
+			bitbang->setup_transfer = bitbang_transfer_setup;
 			bitbang->master->setup = spi_bitbang_setup;
 			bitbang->master->cleanup = spi_bitbang_cleanup;
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index b05f146..caa4665 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -31,6 +31,7 @@ extern struct bus_type spi_bus_type;
  * @master: SPI controller used with the device.
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
+ *	The spi_transfer.speed_hz can override this for each transfer.
  * @chip-select: Chipselect, distinguishing chips handled by "master".
  * @mode: The spi mode defines how data is clocked out and in.
  *	This may be changed by the device's driver.
@@ -38,6 +39,7 @@ extern struct bus_type spi_bus_type;
  * 	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
  *	This may be changed by the device's driver.
+ *	The spi_transfer.bits_per_word can override this for each transfer.
  * @irq: Negative, or the number passed to request_irq() to receive
  * 	interrupts from this device.
  * @controller_state: Controller's runtime state
@@ -268,6 +270,10 @@ extern struct spi_master *spi_busnum_to_
  * @tx_dma: DMA address of tx_buf, if spi_message.is_dma_mapped
  * @rx_dma: DMA address of rx_buf, if spi_message.is_dma_mapped
  * @len: size of rx and tx buffers (in bytes)
+ * @speed_hz: Select a speed other then the device default for this
+ *      transfer. If 0 the default (from spi_device) is used.
+ * @bits_per_word: select a bits_per_word other then the device default
+ *      for this transfer. If 0 the default (from spi_device) is used.
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
  * 	(optionally) changing the chipselect status, then starting
@@ -322,7 +328,9 @@ struct spi_transfer {
 	dma_addr_t	rx_dma;
 
 	unsigned	cs_change:1;
+	u8		bits_per_word;
 	u16		delay_usecs;
+	u32		speed_hz;
 
 	struct list_head transfer_list;
 };
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index c961fe9..c954557 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -30,6 +30,12 @@ struct spi_bitbang {
 
 	struct spi_master	*master;
 
+	/* setup_transfer() changes clock and/or wordsize to match settings
+	 * for this transfer; zeroes restore defaults from spi_device.
+	 */
+	int	(*setup_transfer)(struct spi_device *spi,
+			struct spi_transfer *t);
+
 	void	(*chipselect)(struct spi_device *spi, int is_on);
 #define	BITBANG_CS_ACTIVE	1	/* normally nCS, active low */
 #define	BITBANG_CS_INACTIVE	0
-- 
1.3.2

