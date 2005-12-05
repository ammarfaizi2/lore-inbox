Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVLEUP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVLEUP0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbVLEUP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:15:26 -0500
Received: from web36913.mail.mud.yahoo.com ([209.191.85.81]:37244 "HELO
	web36913.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751412AbVLEUPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:15:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dGZZxgkVNSh633uRRbtZM0zRqAfCDs8DuxoN9wR2LcIVgT/qT586q3h7k4VpRC4AT5TtNCITgN702TczsGYf5mDRb19r5oPkFWsY/AY+4n48EAJi3wEdX2rLmDZLlnFqOPtOAjUjASLMdlDZdWoj+FtRUNddujmTOljQTb9QKSw=  ;
Message-ID: <20051205201522.36583.qmail@web36913.mail.mud.yahoo.com>
Date: Mon, 5 Dec 2005 20:15:22 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: stephen@streetfiresound.com, vwool@ru.mvista.com
To: akpm@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1394837760-1133813722=:31113"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1394837760-1133813722=:31113
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

This patch fix's the possible priority inversion that vitaly pointed out and allows the driver to
be built as a module. 
 
David, please can you test this patch. Can you also submit a patch which adds the module author,
description and license please, thanks.

Mark

 Kconfig |    2 +-
 spi.c   |   23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)


		
___________________________________________________________ 
Yahoo! Exclusive Xmas Game, help Santa with his celebrity party - http://santas-christmas-party.yahoo.net/
--0-1394837760-1133813722=:31113
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

--0-1394837760-1133813722=:31113--
