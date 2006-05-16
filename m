Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWEPVlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWEPVlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWEPVkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:40:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:29870 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932179AbWEPVkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:40:41 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/10] SPI: devices can require LSB-first encodings
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 16 May 2006 14:38:35 -0700
Message-Id: <11478155182487-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.2
In-Reply-To: <11478155182854-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

Add spi_device hook for LSB-first word encoding, and update all the
(in-tree) controller drivers to reject such devices.  Eventually,
some controller drivers will be updated to support lsb-first encodings
on the wire; no current drivers need this.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/spi/spi_bitbang.c |   11 ++++++++++-
 include/linux/spi/spi.h   |    7 +++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

ccf77cc4af5b048e20cfd9327fcc286cb69c34cc
diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 6c3da64..0f7f5c6 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -187,13 +187,22 @@ int spi_bitbang_setup(struct spi_device 
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
+	bitbang = spi_master_get_devdata(spi->master);
+
+	/* REVISIT: some systems will want to support devices using lsb-first
+	 * bit encodings on the wire.  In pure software that would be trivial,
+	 * just bitbang_txrx_le_cphaX() routines shifting the other way, and
+	 * some hardware controllers also have this support.
+	 */
+	if ((spi->mode & SPI_LSB_FIRST) != 0)
+		return -EINVAL;
+
 	if (!cs) {
 		cs = kzalloc(sizeof *cs, SLAB_KERNEL);
 		if (!cs)
 			return -ENOMEM;
 		spi->controller_state = cs;
 	}
-	bitbang = spi_master_get_devdata(spi->master);
 
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0820067..77add90 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -35,10 +35,13 @@ extern struct bus_type spi_bus_type;
  * @chip-select: Chipselect, distinguishing chips handled by "master".
  * @mode: The spi mode defines how data is clocked out and in.
  *	This may be changed by the device's driver.
+ *	The "active low" default for chipselect mode can be overridden,
+ *	as can the "MSB first" default for each word in a transfer.
  * @bits_per_word: Data transfers involve one or more words; word sizes
  *	like eight or 12 bits are common.  In-memory wordsizes are
  *	powers of two bytes (e.g. 20 bit samples use 32 bits).
- *	This may be changed by the device's driver.
+ *	This may be changed by the device's driver, or left at the
+ *	default (0) indicating protocol words are eight bit bytes.
  *	The spi_transfer.bits_per_word can override this for each transfer.
  * @irq: Negative, or the number passed to request_irq() to receive
  *	interrupts from this device.
@@ -67,6 +70,7 @@ #define	SPI_MODE_1	(0|SPI_CPHA)
 #define	SPI_MODE_2	(SPI_CPOL|0)
 #define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
 #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
+#define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
 	u8			bits_per_word;
 	int			irq;
 	void			*controller_state;
@@ -75,7 +79,6 @@ #define	SPI_CS_HIGH	0x04			/* chipselect
 
 	// likely need more hooks for more protocol options affecting how
 	// the controller talks to each chip, like:
-	//  - bit order (default is wordwise msb-first)
 	//  - memory packing (12 bit samples into low bits, others zeroed)
 	//  - priority
 	//  - drop chipselect after each word
-- 
1.3.2

