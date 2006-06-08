Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWFHVjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWFHVjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 17:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWFHVjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 17:39:18 -0400
Received: from havoc.gtf.org ([69.61.125.42]:53459 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965026AbWFHVjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 17:39:17 -0400
Date: Thu, 8 Jun 2006 17:39:13 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060608213913.GA29830@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just got back from travelling, and am catching up.  Thanks to Andrew for
working with me via email while I was on the road, he pushed a couple
patches already for me.

Here are the netdev fixes that were in my 'Pending' folder.  I've got a
couple libata fixes to push as well, those may not come until tomorrow.

Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/e1000/e1000_ethtool.c          |    5 +++-
 drivers/net/e1000/e1000_main.c             |    8 +------
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c |   31 ++++++++++++++++++++---------
 3 files changed, 28 insertions(+), 16 deletions(-)

Auke Kok:
      e1000: fix ethtool test irq alloc as "probe"
      e1000: remove risky prefetch on next_skb->data

Michael Buesch:
      bcm43xx: add DMA rx poll workaround to DMA4

diff --git a/drivers/net/e1000/e1000_ethtool.c b/drivers/net/e1000/e1000_ethtool.c
index ecccca3..d1c705b 100644
--- a/drivers/net/e1000/e1000_ethtool.c
+++ b/drivers/net/e1000/e1000_ethtool.c
@@ -870,13 +870,16 @@ e1000_intr_test(struct e1000_adapter *ad
 	*data = 0;
 
 	/* Hook up test interrupt handler just for this test */
- 	if (!request_irq(irq, &e1000_test_intr, 0, netdev->name, netdev)) {
+	if (!request_irq(irq, &e1000_test_intr, SA_PROBEIRQ, netdev->name,
+	                 netdev)) {
  		shared_int = FALSE;
  	} else if (request_irq(irq, &e1000_test_intr, SA_SHIRQ,
 			      netdev->name, netdev)){
 		*data = 1;
 		return -1;
 	}
+	DPRINTK(PROBE,INFO, "testing %s interrupt\n",
+	        (shared_int ? "shared" : "unshared"));
 
 	/* Disable all the interrupts */
 	E1000_WRITE_REG(&adapter->hw, IMC, 0xFFFFFFFF);
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index ed15fca..97e71a4 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3519,7 +3519,7 @@ #endif
 	buffer_info = &rx_ring->buffer_info[i];
 
 	while (rx_desc->status & E1000_RXD_STAT_DD) {
-		struct sk_buff *skb, *next_skb;
+		struct sk_buff *skb;
 		u8 status;
 #ifdef CONFIG_E1000_NAPI
 		if (*work_done >= work_to_do)
@@ -3537,8 +3537,6 @@ #endif
 		prefetch(next_rxd);
 
 		next_buffer = &rx_ring->buffer_info[i];
-		next_skb = next_buffer->skb;
-		prefetch(next_skb->data - NET_IP_ALIGN);
 
 		cleaned = TRUE;
 		cleaned_count++;
@@ -3668,7 +3666,7 @@ #endif
 	struct e1000_buffer *buffer_info, *next_buffer;
 	struct e1000_ps_page *ps_page;
 	struct e1000_ps_page_dma *ps_page_dma;
-	struct sk_buff *skb, *next_skb;
+	struct sk_buff *skb;
 	unsigned int i, j;
 	uint32_t length, staterr;
 	int cleaned_count = 0;
@@ -3697,8 +3695,6 @@ #endif
 		prefetch(next_rxd);
 
 		next_buffer = &rx_ring->buffer_info[i];
-		next_skb = next_buffer->skb;
-		prefetch(next_skb->data - NET_IP_ALIGN);
 
 		cleaned = TRUE;
 		cleaned_count++;
diff --git a/drivers/net/wireless/bcm43xx/bcm43xx_dma.c b/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
index bbecba0..d0318e5 100644
--- a/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
+++ b/drivers/net/wireless/bcm43xx/bcm43xx_dma.c
@@ -624,25 +624,28 @@ err_destroy_tx0:
 static u16 generate_cookie(struct bcm43xx_dmaring *ring,
 			   int slot)
 {
-	u16 cookie = 0x0000;
+	u16 cookie = 0xF000;
 
 	/* Use the upper 4 bits of the cookie as
 	 * DMA controller ID and store the slot number
-	 * in the lower 12 bits
+	 * in the lower 12 bits.
+	 * Note that the cookie must never be 0, as this
+	 * is a special value used in RX path.
 	 */
 	switch (ring->mmio_base) {
 	default:
 		assert(0);
 	case BCM43xx_MMIO_DMA1_BASE:
+		cookie = 0xA000;
 		break;
 	case BCM43xx_MMIO_DMA2_BASE:
-		cookie = 0x1000;
+		cookie = 0xB000;
 		break;
 	case BCM43xx_MMIO_DMA3_BASE:
-		cookie = 0x2000;
+		cookie = 0xC000;
 		break;
 	case BCM43xx_MMIO_DMA4_BASE:
-		cookie = 0x3000;
+		cookie = 0xD000;
 		break;
 	}
 	assert(((u16)slot & 0xF000) == 0x0000);
@@ -660,16 +663,16 @@ struct bcm43xx_dmaring * parse_cookie(st
 	struct bcm43xx_dmaring *ring = NULL;
 
 	switch (cookie & 0xF000) {
-	case 0x0000:
+	case 0xA000:
 		ring = dma->tx_ring0;
 		break;
-	case 0x1000:
+	case 0xB000:
 		ring = dma->tx_ring1;
 		break;
-	case 0x2000:
+	case 0xC000:
 		ring = dma->tx_ring2;
 		break;
-	case 0x3000:
+	case 0xD000:
 		ring = dma->tx_ring3;
 		break;
 	default:
@@ -839,8 +842,18 @@ static void dma_rx(struct bcm43xx_dmarin
 		/* We received an xmit status. */
 		struct bcm43xx_hwxmitstatus *hw = (struct bcm43xx_hwxmitstatus *)skb->data;
 		struct bcm43xx_xmitstatus stat;
+		int i = 0;
 
 		stat.cookie = le16_to_cpu(hw->cookie);
+		while (stat.cookie == 0) {
+			if (unlikely(++i >= 10000)) {
+				assert(0);
+				break;
+			}
+			udelay(2);
+			barrier();
+			stat.cookie = le16_to_cpu(hw->cookie);
+		}
 		stat.flags = hw->flags;
 		stat.cnt1 = hw->cnt1;
 		stat.cnt2 = hw->cnt2;
