Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWEPVkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWEPVkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWEPVkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:40:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:29102 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932174AbWEPVkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:40:40 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kumar Gala <galak@kernel.crashing.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/10] SPI: Renamed bitbang_transfer_setup to spi_bitbang_setup_transfer and export it
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 16 May 2006 14:38:34 -0700
Message-Id: <11478155182854-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.2
In-Reply-To: <11478155182390-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kumar Gala <galak@kernel.crashing.org>

Renamed bitbang_transfer_setup to follow convention of other exported symbols
from spi-bitbang.  Exported spi_bitbang_setup_transfer to allow users of
spi-bitbang to use the function in their own setup_transfer.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 drivers/spi/spi_bitbang.c       |   10 ++++++----
 include/linux/spi/spi_bitbang.h |    2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

ff9f4771b5f017ee0f57629488b6cd7a6ef3d19b
diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
index 0525c99..6c3da64 100644
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -138,8 +138,7 @@ static unsigned bitbang_txrx_32(
 	return t->len - count;
 }
 
-static int
-bitbang_transfer_setup(struct spi_device *spi, struct spi_transfer *t)
+int spi_bitbang_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
 	u8			bits_per_word;
@@ -174,6 +173,7 @@ bitbang_transfer_setup(struct spi_device
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(spi_bitbang_setup_transfer);
 
 /**
  * spi_bitbang_setup - default setup for per-word I/O loops
@@ -203,7 +203,7 @@ int spi_bitbang_setup(struct spi_device 
 	if (!cs->txrx_word)
 		return -EINVAL;
 
-	retval = bitbang_transfer_setup(spi, NULL);
+	retval = spi_bitbang_setup_transfer(spi, NULL);
 	if (retval < 0)
 		return retval;
 
@@ -454,7 +454,9 @@ int spi_bitbang_start(struct spi_bitbang
 		bitbang->use_dma = 0;
 		bitbang->txrx_bufs = spi_bitbang_bufs;
 		if (!bitbang->master->setup) {
-			bitbang->setup_transfer = bitbang_transfer_setup;
+			if (!bitbang->setup_transfer)
+				bitbang->setup_transfer =
+					 spi_bitbang_setup_transfer;
 			bitbang->master->setup = spi_bitbang_setup;
 			bitbang->master->cleanup = spi_bitbang_cleanup;
 		}
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index c954557..16ce178 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -57,6 +57,8 @@ #define	BITBANG_CS_INACTIVE	0
 extern int spi_bitbang_setup(struct spi_device *spi);
 extern void spi_bitbang_cleanup(const struct spi_device *spi);
 extern int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m);
+extern int spi_bitbang_setup_transfer(struct spi_device *spi,
+				      struct spi_transfer *t);
 
 /* start or stop queue processing */
 extern int spi_bitbang_start(struct spi_bitbang *spi);
-- 
1.3.2

