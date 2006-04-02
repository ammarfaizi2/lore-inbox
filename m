Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWDBVIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWDBVIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWDBVH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 17:07:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:40427 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932413AbWDBVH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 17:07:59 -0400
Date: Sun, 2 Apr 2006 16:06:35 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: david-b@pacbell.net
cc: linux-kernel@vger.kernel.org, <spi-devel-general@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] spi: Renamed bitbang_transfer_setup to spi_bitbang_setup_transfer
 and export it 
Message-ID: <Pine.LNX.4.44.0604021605560.9478-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed bitbang_transfer_setup to follow convention of other exported symbols
from spi-bitbang.  Exported spi_bitbang_setup_transfer to allow users of
spi-bitbang to use the function in their own setup_transfer.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit bc33ba02f8414e91a3b2afa877be2c54d6fce564
tree 392781b8d6d0c2d89d9bebf0504074f8078cf6d8
parent 81256e14f3fcfdc988041edf177727dcc880bb19
author Kumar Gala <galak@kernel.crashing.org> Sun, 02 Apr 2006 16:06:04 -0500
committer Kumar Gala <galak@kernel.crashing.org> Sun, 02 Apr 2006 16:06:04 -0500

 drivers/spi/spi_bitbang.c       |   10 ++++++----
 include/linux/spi/spi_bitbang.h |    2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

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
@@ -57,6 +57,8 @@ struct spi_bitbang {
 extern int spi_bitbang_setup(struct spi_device *spi);
 extern void spi_bitbang_cleanup(const struct spi_device *spi);
 extern int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m);
+extern int spi_bitbang_setup_transfer(struct spi_device *spi,
+				      struct spi_transfer *t);
 
 /* start or stop queue processing */
 extern int spi_bitbang_start(struct spi_bitbang *spi);

