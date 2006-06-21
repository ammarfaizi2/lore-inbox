Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWFUObm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWFUObm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWFUObE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:31:04 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751591AbWFUO0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:04 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 09/21] [MMC] Fix sdhci PIO routines
Date: Wed, 21 Jun 2006 16:26:05 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142604.8857.5949.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sdhci controllers operate with blocks, not bytes. The PIO routines must
therefore make sure that the minimum unit transfered is a complete block.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |  158 ++++++++++++++++++++++++++++++++-------------------
 drivers/mmc/sdhci.h |    6 +-
 2 files changed, 101 insertions(+), 63 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index b7a9ac2..eb6aee4 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -8,12 +8,6 @@
  * published by the Free Software Foundation.
  */
 
- /*
-  * Note that PIO transfer is rather crappy atm. The buffer full/empty
-  * interrupts aren't reliable so we currently transfer the entire buffer
-  * directly. Patches to solve the problem are welcome.
-  */
-
 #include <linux/delay.h>
 #include <linux/highmem.h>
 #include <linux/pci.h>
@@ -128,7 +122,7 @@ static void sdhci_init(struct sdhci_host
 		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
 		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
 		SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT |
-		SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL |
+		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL |
 		SDHCI_INT_DMA_END | SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE;
 
 	writel(intmask, host->ioaddr + SDHCI_INT_ENABLE);
@@ -189,79 +183,96 @@ static inline int sdhci_next_sg(struct s
 	return host->num_sg;
 }
 
-static void sdhci_transfer_pio(struct sdhci_host *host)
+static void sdhci_read_block_pio(struct sdhci_host *host)
 {
+	int blksize, chunk_remain;
+	u32 data;
 	char *buffer;
-	u32 mask;
-	int bytes, size;
-	unsigned long max_jiffies;
+	int size;
 
-	BUG_ON(!host->data);
+	DBG("PIO reading\n");
 
-	if (host->num_sg == 0)
-		return;
-
-	bytes = 0;
-	if (host->data->flags & MMC_DATA_READ)
-		mask = SDHCI_DATA_AVAILABLE;
-	else
-		mask = SDHCI_SPACE_AVAILABLE;
+	blksize = 1 << host->data->blksz_bits;
+	chunk_remain = 0;
+	data = 0;
 
 	buffer = sdhci_kmap_sg(host) + host->offset;
 
-	/* Transfer shouldn't take more than 5 s */
-	max_jiffies = jiffies + HZ * 5;
+	while (blksize) {
+		if (chunk_remain == 0) {
+			data = readl(host->ioaddr + SDHCI_BUFFER);
+			chunk_remain = min(blksize, 4);
+		}
 
-	while (host->size > 0) {
-		if (time_after(jiffies, max_jiffies)) {
-			printk(KERN_ERR "%s: PIO transfer stalled. "
-				"Please report this to "
-				BUGMAIL ".\n", mmc_hostname(host->mmc));
-			sdhci_dumpregs(host);
+		size = min(host->size, host->remain);
+		size = min(size, chunk_remain);
 
-			sdhci_kunmap_sg(host);
+		chunk_remain -= size;
+		blksize -= size;
+		host->offset += size;
+		host->remain -= size;
+		host->size -= size;
+		while (size) {
+			*buffer = data & 0xFF;
+			buffer++;
+			data >>= 8;
+			size--;
+		}
 
-			host->data->error = MMC_ERR_FAILED;
-			sdhci_finish_data(host);
-			return;
+		if (host->remain == 0) {
+			sdhci_kunmap_sg(host);
+			if (sdhci_next_sg(host) == 0) {
+				BUG_ON(blksize != 0);
+				return;
+			}
+			buffer = sdhci_kmap_sg(host);
 		}
+	}
 
-		if (!(readl(host->ioaddr + SDHCI_PRESENT_STATE) & mask))
-			continue;
+	sdhci_kunmap_sg(host);
+}
 
-		size = min(host->size, host->remain);
+static void sdhci_write_block_pio(struct sdhci_host *host)
+{
+	int blksize, chunk_remain;
+	u32 data;
+	char *buffer;
+	int bytes, size;
 
-		if (size >= 4) {
-			if (host->data->flags & MMC_DATA_READ)
-				*(u32*)buffer = readl(host->ioaddr + SDHCI_BUFFER);
-			else
-				writel(*(u32*)buffer, host->ioaddr + SDHCI_BUFFER);
-			size = 4;
-		} else if (size >= 2) {
-			if (host->data->flags & MMC_DATA_READ)
-				*(u16*)buffer = readw(host->ioaddr + SDHCI_BUFFER);
-			else
-				writew(*(u16*)buffer, host->ioaddr + SDHCI_BUFFER);
-			size = 2;
-		} else {
-			if (host->data->flags & MMC_DATA_READ)
-				*(u8*)buffer = readb(host->ioaddr + SDHCI_BUFFER);
-			else
-				writeb(*(u8*)buffer, host->ioaddr + SDHCI_BUFFER);
-			size = 1;
-		}
+	DBG("PIO writing\n");
+
+	blksize = 1 << host->data->blksz_bits;
+	chunk_remain = 4;
+	data = 0;
+
+	bytes = 0;
+	buffer = sdhci_kmap_sg(host) + host->offset;
+
+	while (blksize) {
+		size = min(host->size, host->remain);
+		size = min(size, chunk_remain);
 
-		buffer += size;
+		chunk_remain -= size;
+		blksize -= size;
 		host->offset += size;
 		host->remain -= size;
-
-		bytes += size;
 		host->size -= size;
+		while (size) {
+			data >>= 8;
+			data |= (u32)*buffer << 24;
+			buffer++;
+			size--;
+		}
+
+		if (chunk_remain == 0) {
+			writel(data, host->ioaddr + SDHCI_BUFFER);
+			chunk_remain = min(blksize, 4);
+		}
 
 		if (host->remain == 0) {
 			sdhci_kunmap_sg(host);
 			if (sdhci_next_sg(host) == 0) {
-				DBG("PIO transfer: %d bytes\n", bytes);
+				BUG_ON(blksize != 0);
 				return;
 			}
 			buffer = sdhci_kmap_sg(host);
@@ -269,8 +280,35 @@ static void sdhci_transfer_pio(struct sd
 	}
 
 	sdhci_kunmap_sg(host);
+}
+
+static void sdhci_transfer_pio(struct sdhci_host *host)
+{
+	u32 mask;
+
+	BUG_ON(!host->data);
+
+	if (host->size == 0)
+		return;
+
+	if (host->data->flags & MMC_DATA_READ)
+		mask = SDHCI_DATA_AVAILABLE;
+	else
+		mask = SDHCI_SPACE_AVAILABLE;
+
+	while (readl(host->ioaddr + SDHCI_PRESENT_STATE) & mask) {
+		if (host->data->flags & MMC_DATA_READ)
+			sdhci_read_block_pio(host);
+		else
+			sdhci_write_block_pio(host);
+
+		if (host->size == 0)
+			break;
+
+		BUG_ON(host->num_sg == 0);
+	}
 
-	DBG("PIO transfer: %d bytes\n", bytes);
+	DBG("PIO transfer complete.\n");
 }
 
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
@@ -863,7 +901,7 @@ static void sdhci_data_irq(struct sdhci_
 	if (host->data->error != MMC_ERR_NONE)
 		sdhci_finish_data(host);
 	else {
-		if (intmask & (SDHCI_INT_BUF_FULL | SDHCI_INT_BUF_EMPTY))
+		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
 			sdhci_transfer_pio(host);
 
 		if (intmask & SDHCI_INT_DATA_END)
diff --git a/drivers/mmc/sdhci.h b/drivers/mmc/sdhci.h
index a8f4521..f8df28f 100644
--- a/drivers/mmc/sdhci.h
+++ b/drivers/mmc/sdhci.h
@@ -95,8 +95,8 @@ #define SDHCI_SIGNAL_ENABLE	0x38
 #define  SDHCI_INT_RESPONSE	0x00000001
 #define  SDHCI_INT_DATA_END	0x00000002
 #define  SDHCI_INT_DMA_END	0x00000008
-#define  SDHCI_INT_BUF_EMPTY	0x00000010
-#define  SDHCI_INT_BUF_FULL	0x00000020
+#define  SDHCI_INT_SPACE_AVAIL	0x00000010
+#define  SDHCI_INT_DATA_AVAIL	0x00000020
 #define  SDHCI_INT_CARD_INSERT	0x00000040
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
@@ -116,7 +116,7 @@ #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
 #define  SDHCI_INT_CMD_MASK	(SDHCI_INT_RESPONSE | SDHCI_INT_TIMEOUT | \
 		SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX)
 #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
-		SDHCI_INT_BUF_EMPTY | SDHCI_INT_BUF_FULL | \
+		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
 		SDHCI_INT_DATA_END_BIT)
 

