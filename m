Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbVLEU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbVLEU0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbVLEU0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:26:07 -0500
Received: from web36912.mail.mud.yahoo.com ([209.191.85.80]:18328 "HELO
	web36912.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751443AbVLEU0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:26:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=cLbPf1kIH34zwhsKj4h8tCC0ST0NMVY73X5+cPMlkOP038n4QAE8FF2jqJmmvBv7z6K2FW02sKrPaUR4lqQ5JqqOauN9id8NOy1KZWolHD1iuoXSFHYJ5mT+GnXtTDQWDgZ8uODPn5xmwOcJOTO647s1WcFjar++L2ABSRt6cWQ=  ;
Message-ID: <20051205202605.92440.qmail@web36912.mail.mud.yahoo.com>
Date: Mon, 5 Dec 2005 20:26:05 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: [PATCH] [SPI] build as module and fix priority inversion problem
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       David Brownell <david-b@pacbell.net>
Cc: Vitaly Wool <vwool@ru.mvista.com>, stephen@streetfiresound.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2012831116-1133814365=:91877"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-2012831116-1133814365=:91877
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Sorry, made a bit of a mess with the last e-mail :(. Trying again :) 
 
This patch fix's the possible priority inversion that vitaly pointed out and allows the driver to
be built as a module. 
 
David, please can you test this patch. Can you also submit a patch which adds the module author,
description and license please, thanks. Kconfig |    2 +-

 spi.c   |   23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)


	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
--0-2012831116-1133814365=:91877
Content-Type: text/x-patch; name="spi-dir.patch"
Content-Description: 1747405766-spi-dir.patch
Content-Disposition: inline; filename="spi-dir.patch"

diff -uprN spi-org/Kconfig spi/Kconfig
--- spi-org/Kconfig	2005-12-05 19:49:52.000000000 +0000
+++ spi/Kconfig	2005-12-05 18:38:06.000000000 +0000
@@ -22,7 +22,7 @@ config SPI_ARCH_HAS_SLAVE
 	default y if ARCH_PXA
 
 config SPI
-	bool "SPI support"
+	tristate "SPI support"
 	depends on SPI_ARCH_HAS_MASTER || SPI_ARCH_HAS_SLAVE
 	help
 	  The "Serial Peripheral Interface" is a low level synchronous
diff -uprN spi-org/spi.c spi/spi.c
--- spi-org/spi.c	2005-12-05 19:49:52.000000000 +0000
+++ spi/spi.c	2005-12-05 19:06:05.000000000 +0000
@@ -232,6 +232,8 @@ EXPORT_SYMBOL_GPL(spi_new_device);
  * The board info passed can safely be __initdata ... but be careful of
  * any embedded pointers (platform_data, etc), they're copied as-is.
  */
+
+#ifdef CONFIG_SPI
 int __init
 spi_register_board_info(struct spi_board_info const *info, unsigned n)
 {
@@ -249,6 +251,7 @@ spi_register_board_info(struct spi_board
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_register_board_info);
+#endif
 
 /* FIXME someone should add support for a __setup("spi", ...) that
  * creates board info from kernel command lines
@@ -505,6 +508,7 @@ int spi_write_then_read(struct spi_devic
 	int			status;
 	struct spi_message	message;
 	struct spi_transfer	x[2];
+	u8			*local_buf;
 
 	/* Use preallocated DMA-safe buffer.  We can't avoid copying here,
 	 * (as a pure convenience thing), but we can keep heap costs
@@ -513,14 +517,19 @@ int spi_write_then_read(struct spi_devic
 	if ((n_tx + n_rx) > SPI_BUFSIZ)
 		return -EINVAL;
 
-	down(&lock);
+	if (down_trylock(&lock))
+		/* Someone else is using the main buffer, kalloc a new one */
+		local_buf = kmalloc(SPI_BUFSIZ, GFP_ATOMIC);
+	else
+		local_buf = buf;
+
 	memset(x, 0, sizeof x);
 
-	memcpy(buf, txbuf, n_tx);
-	x[0].tx_buf = buf;
+	memcpy(local_buf, txbuf, n_tx);
+	x[0].tx_buf = local_buf;
 	x[0].len = n_tx;
 
-	x[1].rx_buf = buf + n_tx;
+	x[1].rx_buf = local_buf + n_tx;
 	x[1].len = n_rx;
 
 	/* do the i/o */
@@ -532,7 +541,11 @@ int spi_write_then_read(struct spi_devic
 		status = message.status;
 	}
 
-	up(&lock);
+	if (x[0].tx_buf == buf)
+		up(&lock);
+	else
+		kfree(local_buf);
+
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_write_then_read);

--0-2012831116-1133814365=:91877--
