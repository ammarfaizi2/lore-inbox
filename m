Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263378AbVCJXQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbVCJXQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbVCJXPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:15:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:33498 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263383AbVCJXKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:22 -0500
Date: Thu, 10 Mar 2005 15:09:30 -0800
From: Greg KH <greg@kroah.com>
To: shemminger@osdl.org, romieu@fr.zoreil.com, netdev@oss.sgi.com,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [09/11] r8169: receive descriptor length fix
Message-ID: <20050310230930.GJ22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------


The status and received packets indication in the Rx descriptor ring
are not correctly reset when a descriptor is recycled.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -puN drivers/net/r8169.c~r8169-490 drivers/net/r8169.c
--- a/drivers/net/r8169.c~r8169-490	2005-03-08 00:01:26.000000000 +0100
+++ b/drivers/net/r8169.c		2005-03-09 00:38:34.235464833 +0100
@@ -1683,16 +1683,19 @@ static void rtl8169_free_rx_skb(struct r
 	rtl8169_make_unusable_by_asic(desc);
 }
 
-static inline void rtl8169_return_to_asic(struct RxDesc *desc, int rx_buf_sz)
+static inline void rtl8169_mark_to_asic(struct RxDesc *desc, u32 rx_buf_sz)
 {
-	desc->opts1 |= cpu_to_le32(DescOwn + rx_buf_sz);
+	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
+
+	desc->opts1 = cpu_to_le32(DescOwn | eor | rx_buf_sz);
 }
 
-static inline void rtl8169_give_to_asic(struct RxDesc *desc, dma_addr_t mapping,
-					int rx_buf_sz)
+static inline void rtl8169_map_to_asic(struct RxDesc *desc, dma_addr_t mapping,
+				       u32 rx_buf_sz)
 {
 	desc->addr = cpu_to_le64(mapping);
-	desc->opts1 |= cpu_to_le32(DescOwn + rx_buf_sz);
+	wmb();
+	rtl8169_mark_to_asic(desc, rx_buf_sz);
 }
 
 static int rtl8169_alloc_rx_skb(struct pci_dev *pdev, struct sk_buff **sk_buff,
@@ -1712,7 +1715,7 @@ static int rtl8169_alloc_rx_skb(struct p
 	mapping = pci_map_single(pdev, skb->tail, rx_buf_sz,
 				 PCI_DMA_FROMDEVICE);
 
-	rtl8169_give_to_asic(desc, mapping, rx_buf_sz);
+	rtl8169_map_to_asic(desc, mapping, rx_buf_sz);
 
 out:
 	return ret;
@@ -2150,7 +2153,7 @@ static inline int rtl8169_try_rx_copy(st
 			skb_reserve(skb, NET_IP_ALIGN);
 			eth_copy_and_sum(skb, sk_buff[0]->tail, pkt_size, 0);
 			*sk_buff = skb;
-			rtl8169_return_to_asic(desc, rx_buf_sz);
+			rtl8169_mark_to_asic(desc, rx_buf_sz);
 			ret = 0;
 		}
 	}

_

-- 
Ueimor

