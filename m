Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWJIT3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWJIT3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWJIT3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:29:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41919 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964782AbWJIT3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:29:43 -0400
Date: Mon, 9 Oct 2006 20:29:43 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tifm __iomem annotations, NULL noise removal
Message-ID: <20061009192943.GX29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/misc/tifm_7xx1.c |   13 +++++++------
 drivers/misc/tifm_core.c |    2 +-
 drivers/mmc/tifm_sd.c    |   14 +++++++-------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index b174866..1ba8754 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -48,7 +48,7 @@ static void tifm_7xx1_remove_media(void 
 			printk(KERN_INFO DRIVER_NAME
 			       ": demand removing card from socket %d\n", cnt);
 			sock = fm->sockets[cnt];
-			fm->sockets[cnt] = 0;
+			fm->sockets[cnt] = NULL;
 			fm->remove_mask &= ~(1 << cnt);
 
 			writel(0x0e00, sock->addr + SOCK_CONTROL);
@@ -118,7 +118,7 @@ static irqreturn_t tifm_7xx1_isr(int irq
 	return IRQ_HANDLED;
 }
 
-static tifm_media_id tifm_7xx1_toggle_sock_power(char *sock_addr, int is_x2)
+static tifm_media_id tifm_7xx1_toggle_sock_power(char __iomem *sock_addr, int is_x2)
 {
 	unsigned int s_state;
 	int cnt;
@@ -163,7 +163,8 @@ static tifm_media_id tifm_7xx1_toggle_so
 	return (readl(sock_addr + SOCK_PRESENT_STATE) >> 4) & 7;
 }
 
-inline static char *tifm_7xx1_sock_addr(char *base_addr, unsigned int sock_num)
+inline static char __iomem *
+tifm_7xx1_sock_addr(char __iomem *base_addr, unsigned int sock_num)
 {
 	return base_addr + ((sock_num + 1) << 10);
 }
@@ -176,7 +177,7 @@ static void tifm_7xx1_insert_media(void 
 	char *card_name = "xx";
 	int cnt, ok_to_register;
 	unsigned int insert_mask;
-	struct tifm_dev *new_sock = 0;
+	struct tifm_dev *new_sock = NULL;
 
 	if (!class_device_get(&fm->cdev))
 		return;
@@ -230,7 +231,7 @@ static void tifm_7xx1_insert_media(void 
 				if (!ok_to_register ||
 					    device_register(&new_sock->dev)) {
 					spin_lock_irqsave(&fm->lock, flags);
-					fm->sockets[cnt] = 0;
+					fm->sockets[cnt] = NULL;
 					spin_unlock_irqrestore(&fm->lock,
 								flags);
 					tifm_free_device(&new_sock->dev);
@@ -390,7 +391,7 @@ static void tifm_7xx1_remove(struct pci_
 
 	tifm_remove_adapter(fm);
 
-	pci_set_drvdata(dev, 0);
+	pci_set_drvdata(dev, NULL);
 
 	iounmap(fm->addr);
 	pci_intx(dev, 0);
diff --git a/drivers/misc/tifm_core.c b/drivers/misc/tifm_core.c
index cca5f85..ee32613 100644
--- a/drivers/misc/tifm_core.c
+++ b/drivers/misc/tifm_core.c
@@ -157,7 +157,7 @@ struct tifm_dev *tifm_alloc_device(struc
 		dev->wq = create_singlethread_workqueue(dev->wq_name);
 		if (!dev->wq) {
 			kfree(dev);
-			return 0;
+			return NULL;
 		}
 		dev->dev.parent = fm->dev;
 		dev->dev.bus = &tifm_bus_type;
diff --git a/drivers/mmc/tifm_sd.c b/drivers/mmc/tifm_sd.c
index 6d23dc0..2bacff6 100644
--- a/drivers/mmc/tifm_sd.c
+++ b/drivers/mmc/tifm_sd.c
@@ -501,13 +501,13 @@ static void tifm_sd_end_cmd(void *data)
 	struct tifm_dev *sock = host->dev;
 	struct mmc_host *mmc = tifm_get_drvdata(sock);
 	struct mmc_request *mrq;
-	struct mmc_data *r_data = 0;
+	struct mmc_data *r_data = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sock->lock, flags);
 
 	mrq = host->req;
-	host->req = 0;
+	host->req = NULL;
 	host->state = IDLE;
 
 	if (!mrq) {
@@ -546,7 +546,7 @@ static void tifm_sd_request_nodma(struct
 	struct tifm_dev *sock = host->dev;
 	unsigned long flags;
 	struct mmc_data *r_data = mrq->cmd->data;
-	char *t_buffer = 0;
+	char *t_buffer = NULL;
 
 	if (r_data) {
 		t_buffer = kmap(r_data->sg->page);
@@ -613,13 +613,13 @@ static void tifm_sd_end_cmd_nodma(void *
 	struct tifm_dev *sock = host->dev;
 	struct mmc_host *mmc = tifm_get_drvdata(sock);
 	struct mmc_request *mrq;
-	struct mmc_data *r_data = 0;
+	struct mmc_data *r_data = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sock->lock, flags);
 
 	mrq = host->req;
-	host->req = 0;
+	host->req = NULL;
 	host->state = IDLE;
 
 	if (!mrq) {
@@ -644,7 +644,7 @@ static void tifm_sd_end_cmd_nodma(void *
 			r_data->bytes_xfered += r_data->blksz -
 				readl(sock->addr + SOCK_MMCSD_BLOCK_LEN) + 1;
 		}
-		host->buffer = 0;
+		host->buffer = NULL;
 		host->buffer_pos = 0;
 		host->buffer_size = 0;
 	}
@@ -895,7 +895,7 @@ static void tifm_sd_remove(struct tifm_d
 		sock->addr + SOCK_DMA_FIFO_INT_ENABLE_CLEAR);
 	writel(0, sock->addr + SOCK_DMA_FIFO_INT_ENABLE_SET);
 
-	tifm_set_drvdata(sock, 0);
+	tifm_set_drvdata(sock, NULL);
 	mmc_free_host(mmc);
 }
 
-- 
1.4.2.GIT

