Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751718AbWFWQDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWFWQDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751719AbWFWQDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:03:46 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:62608 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751702AbWFWQDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:03:45 -0400
Message-ID: <449C10E7.8010606@drzeus.cx>
Date: Fri, 23 Jun 2006 18:03:51 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hera.drzeus.cx-31661-1151078624-0001-2"
To: rmk+lkml@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/21] [MMC] Avoid sdhci DMA boundaries
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx> <20060621142608.8857.96591.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142608.8857.96591.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-31661-1151078624-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

New version to fix conflicts by recent merge.


--=_hera.drzeus.cx-31661-1151078624-0001-2
Content-Type: text/x-patch; name="sdhci-dma-bounds.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sdhci-dma-bounds.patch"

[MMC] Avoid sdhci DMA boundaries

The sdhci controllers will issue an interrupt when a configurable number of
bytes have been transfered using DMA. The purpose is to handle multiple,
scattered memory pages.

Unfortunately, it requires that all transfers are completely aligned to
memory pages, which we cannot guarantee. So we just disable the function.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |   13 +++++++++----
 drivers/mmc/sdhci.h |    1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 2636cf5..f8c02ee 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -326,6 +326,9 @@ static void sdhci_prepare_data(struct sd
 	DBG("tsac %d ms nsac %d clk\n",
 		data->timeout_ns / 1000000, data->timeout_clks);
 
+	/* Sanity checks */
+	BUG_ON((1 << data->blksz_bits) * data->blocks > 524288);
+
 	/* timeout in us */
 	target_timeout = data->timeout_ns / 1000 +
 		data->timeout_clks / host->clock;
@@ -375,7 +378,9 @@ static void sdhci_prepare_data(struct sd
 		host->remain = host->cur_sg->length;
 	}
 
-	writew(data->blksz, host->ioaddr + SDHCI_BLOCK_SIZE);
+	/* We do not handle DMA boundaries, so set it to max (512 KiB) */
+	writew(SDHCI_MAKE_BLKSZ(7, data->blksz),
+		host->ioaddr + SDHCI_BLOCK_SIZE);
 	writew(data->blocks, host->ioaddr + SDHCI_BLOCK_COUNT);
 }
 
@@ -1188,10 +1193,10 @@ static int __devinit sdhci_probe_slot(st
 	mmc->max_phys_segs = 16;
 
 	/*
-	 * Maximum number of sectors in one transfer. Limited by sector
-	 * count register.
+	 * Maximum number of sectors in one transfer. Limited by DMA boundary
+	 * size (512KiB), which means (512 KiB/512=) 1024 entries.
 	 */
-	mmc->max_sectors = 0x3FFF;
+	mmc->max_sectors = 1024;
 
 	/*
 	 * Maximum segment size. Could be one segment with the maximum number
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index f8df28f..8ed2a89 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -23,6 +23,7 @@ #define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x
 #define SDHCI_DMA_ADDRESS	0x00
 
 #define SDHCI_BLOCK_SIZE	0x04
+#define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
 
 #define SDHCI_BLOCK_COUNT	0x06
 

--=_hera.drzeus.cx-31661-1151078624-0001-2--
