Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVEBB6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVEBB6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEBB4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:56:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34576 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261651AbVEBBq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:46:56 -0400
Date: Mon, 2 May 2005 03:46:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/block/sx8.c: remove unused code
Message-ID: <20050502014655.GV3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it planned to ever #define IF_64BIT_DMA_IS_POSSIBLE ?

If not, the patch below removes this currently completely unused code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

 drivers/block/sx8.c |   30 ++++++------------------------
 1 files changed, 6 insertions(+), 24 deletions(-)

--- linux-2.6.12-rc2-mm2-full/drivers/block/sx8.c.old	2005-04-09 21:51:31.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/block/sx8.c	2005-04-09 21:52:46.000000000 +0200
@@ -176,7 +176,6 @@ enum {
 	FL_NON_RAID		= FW_VER_NON_RAID,
 	FL_4PORT		= FW_VER_4PORT,
 	FL_FW_VER_MASK		= (FW_VER_NON_RAID | FW_VER_4PORT),
-	FL_DAC			= (1 << 16),
 	FL_DYN_MAJOR		= (1 << 17),
 };
 
@@ -1565,7 +1564,6 @@ static int carm_init_one (struct pci_dev
 {
 	static unsigned int printed_version;
 	struct carm_host *host;
-	unsigned int pci_dac;
 	int rc;
 	request_queue_t *q;
 	unsigned int i;
@@ -1581,28 +1579,12 @@ static int carm_init_one (struct pci_dev
 	if (rc)
 		goto err_out;
 
-#if IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
-	rc = pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
-	if (!rc) {
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
-		if (rc) {
-			printk(KERN_ERR DRV_NAME "(%s): consistent DMA mask failure\n",
-				pci_name(pdev));
-			goto err_out_regions;
-		}
-		pci_dac = 1;
-	} else {
-#endif
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
-		if (rc) {
-			printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
-				pci_name(pdev));
-			goto err_out_regions;
-		}
-		pci_dac = 0;
-#if IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
+	rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+	if (rc) {
+		printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
+			pci_name(pdev));
+		goto err_out_regions;
 	}
-#endif
 
 	host = kmalloc(sizeof(*host), GFP_KERNEL);
 	if (!host) {
@@ -1614,7 +1596,7 @@ static int carm_init_one (struct pci_dev
 
 	memset(host, 0, sizeof(*host));
 	host->pdev = pdev;
-	host->flags = pci_dac ? FL_DAC : 0;
+	host->flags = 0;
 	spin_lock_init(&host->lock);
 	INIT_WORK(&host->fsm_task, carm_fsm_task, host);
 	init_MUTEX_LOCKED(&host->probe_sem);

