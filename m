Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVCVWFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVCVWFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVCVWEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:04:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64012 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262111AbVCVWCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:02:44 -0500
Date: Tue, 22 Mar 2005 23:02:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davem@davemloft.net, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/net/tg3.c: remove dead code
Message-ID: <20050322220243.GQ1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker discovered that i never gets any value different 
from 0 assigned.

I do not claim that this patch is correct, but if it isn't correct the 
bug is that i never gets assigned any value.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/tg3.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

--- linux-2.6.12-rc1-mm1-full/drivers/net/tg3.c.old	2005-03-22 21:34:55.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/net/tg3.c	2005-03-22 22:08:40.000000000 +0100
@@ -2982,7 +2982,6 @@ static int tigon3_4gb_hwbug_workaround(s
 	struct sk_buff *new_skb = skb_copy(skb, GFP_ATOMIC);
 	dma_addr_t new_addr;
 	u32 entry = *start;
-	int i;
 
 	if (!new_skb) {
 		dev_kfree_skb(skb);
@@ -2999,23 +2998,16 @@ static int tigon3_4gb_hwbug_workaround(s
 	*start = NEXT_TX(entry);
 
 	/* Now clean up the sw ring entries. */
-	i = 0;
 	while (entry != last_plus_one) {
-		int len;
+		int len = skb_headlen(skb);
 
-		if (i == 0)
-			len = skb_headlen(skb);
-		else
-			len = skb_shinfo(skb)->frags[i-1].size;
 		pci_unmap_single(tp->pdev,
 				 pci_unmap_addr(&tp->tx_buffers[entry], mapping),
 				 len, PCI_DMA_TODEVICE);
-		if (i == 0) {
-			tp->tx_buffers[entry].skb = new_skb;
-			pci_unmap_addr_set(&tp->tx_buffers[entry], mapping, new_addr);
-		} else {
-			tp->tx_buffers[entry].skb = NULL;
-		}
+
+		tp->tx_buffers[entry].skb = new_skb;
+		pci_unmap_addr_set(&tp->tx_buffers[entry], mapping, new_addr);
+
 		entry = NEXT_TX(entry);
 	}
 

