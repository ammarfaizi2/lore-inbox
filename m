Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVLVPEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVLVPEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVLVPEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:04:15 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:41645 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750936AbVLVPEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:04:14 -0500
Date: Thu, 22 Dec 2005 18:04:49 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: david-b@pacbell.net
Cc: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
Subject: [PATCH 2.6-git] SPI: add set_clock() to bitbang
Message-Id: <20051222180449.4335a8e6.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

inlined is the small patch that adds set_clock function to the spi_bitbang structure.
Currently SPI bus clock can be configured either in chipselect() (which is _wrong_) or in txrx_buf (also doesn't encourage me much). Making it a separate function adds readability for the code.
Also, it seems to be redundant to set clock on each transfer, so it's proposed to do per-message clock setting. If SPI bus clock setting involves some PLL reconfiguration it's definitely gonna save some time.

Vitaly

Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

 drivers/spi/spi_bitbang.c       |    3 +++
 include/linux/spi/spi_bitbang.h |    1 +
 2 files changed, 4 insertions(+)

Index: linux-2.6.orig/drivers/spi/spi_bitbang.c
===================================================================
--- linux-2.6.orig.orig/drivers/spi/spi_bitbang.c
+++ linux-2.6.orig/drivers/spi/spi_bitbang.c
@@ -263,6 +263,9 @@ nsecs = 100;
 		chipselect = 0;
 		status = 0;
 
+		if (bitbang->set_clock)
+			bitbang->set_clock(spi);
+
 		for (;;t++) {
 			if (bitbang->shutdown) {
 				status = -ESHUTDOWN;
Index: linux-2.6.orig/include/linux/spi/spi_bitbang.h
===================================================================
--- linux-2.6.orig.orig/include/linux/spi/spi_bitbang.h
+++ linux-2.6.orig/include/linux/spi/spi_bitbang.h
@@ -31,6 +31,7 @@ struct spi_bitbang {
 	struct spi_master	*master;
 
 	void	(*chipselect)(struct spi_device *spi, int is_on);
+	void	(*set_clock)(struct spi_device *spi);
 
 	int	(*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
 	u32	(*txrx_word[4])(struct spi_device *spi,
