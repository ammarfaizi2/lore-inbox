Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVLMTFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVLMTFg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbVLMTFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:05:36 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:14214 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030207AbVLMTFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:05:35 -0500
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-rc5-mm2] SPI, priority inversion tweak
Date: Tue, 13 Dec 2005 10:28:49 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hLxnDRKDtbLq5vn"
Message-Id: <200512131028.49291.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_hLxnDRKDtbLq5vn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is an updated version of the patch from Mark Underwood, handling
the no-memory case better and using SLAB_KERNEL not SLAB_ATOMIC.

Please apply it on top of the current SPI code in the MM tree.

- Dave

--Boundary-00=_hLxnDRKDtbLq5vn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="spi-kmalloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spi-kmalloc.patch"

Update the SPI framework to remove a potential priority inversion case by
reverting to kmalloc if the pre-allocated DMA-safe buffer isn't available.

From: Mark Underwood <basicmark@yahoo.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/spi/spi.c	2005-12-11 11:06:38.000000000 -0800
+++ g26/drivers/spi/spi.c	2005-12-13 09:56:22.000000000 -0800
@@ -541,22 +541,30 @@ int spi_write_then_read(struct spi_devic
 	int			status;
 	struct spi_message	message;
 	struct spi_transfer	x[2];
+	u8			*local_buf;
 
 	/* Use preallocated DMA-safe buffer.  We can't avoid copying here,
 	 * (as a pure convenience thing), but we can keep heap costs
-	 * out of the hot path.
+	 * out of the hot path ...
 	 */
 	if ((n_tx + n_rx) > SPI_BUFSIZ)
 		return -EINVAL;
 
-	down(&lock);
+	/* ... unless someone else is using the pre-allocated buffer */
+	if (down_trylock(&lock)) {
+		local_buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
+		if (!local_buf)
+			return -ENOMEM;
+	} else
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
@@ -568,7 +576,11 @@ int spi_write_then_read(struct spi_devic
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

--Boundary-00=_hLxnDRKDtbLq5vn--
