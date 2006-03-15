Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWCOW0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWCOW0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWCOW0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:26:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2495
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752119AbWCOW0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:26:31 -0500
Date: Wed, 15 Mar 2006 14:26:28 -0800 (PST)
Message-Id: <20060315.142628.28661597.davem@davemloft.net>
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, jeff@garzik.org, cramerj@intel.com,
       john.ronciak@intel.com
Subject: [PATCH]: e1000 endianness bugs
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	return -E_NO_BIG_ENDIAN_TESTING;

[E1000]: Fix 4 missed endianness conversions on RX descriptor fields.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 5b7d0f4..1d91117 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3710,7 +3710,7 @@ e1000_clean_rx_irq(struct e1000_adapter 
 		e1000_rx_checksum(adapter,
 				  (uint32_t)(status) |
 				  ((uint32_t)(rx_desc->errors) << 24),
-				  rx_desc->csum, skb);
+				  le16_to_cpu(rx_desc->csum), skb);
 
 		skb->protocol = eth_type_trans(skb, netdev);
 #ifdef CONFIG_E1000_NAPI
@@ -3854,11 +3854,11 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 		}
 
 		e1000_rx_checksum(adapter, staterr,
-				  rx_desc->wb.lower.hi_dword.csum_ip.csum, skb);
+				  le16_to_cpu(rx_desc->wb.lower.hi_dword.csum_ip.csum), skb);
 		skb->protocol = eth_type_trans(skb, netdev);
 
 		if (likely(rx_desc->wb.upper.header_status &
-			  E1000_RXDPS_HDRSTAT_HDRSP))
+			   cpu_to_le16(E1000_RXDPS_HDRSTAT_HDRSP)))
 			adapter->rx_hdr_split++;
 #ifdef CONFIG_E1000_NAPI
 		if (unlikely(adapter->vlgrp && (staterr & E1000_RXD_STAT_VP))) {
@@ -3884,7 +3884,7 @@ e1000_clean_rx_irq_ps(struct e1000_adapt
 #endif
 
 next_desc:
-		rx_desc->wb.middle.status_error &= ~0xFF;
+		rx_desc->wb.middle.status_error &= cpu_to_le32(~0xFF);
 		buffer_info->skb = NULL;
 
 		/* return some buffers to hardware, one at a time is too slow */
