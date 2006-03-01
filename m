Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWCAWmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWCAWmd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWCAWmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:42:33 -0500
Received: from havoc.gtf.org ([69.61.125.42]:51892 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750759AbWCAWmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:42:32 -0500
Date: Wed, 1 Mar 2006 17:42:29 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] e1000 fix
Message-ID: <20060301224229.GA12689@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/e1000/e1000.h      |    3 -
 drivers/net/e1000/e1000_main.c |  117 +++++++++++++++--------------------------
 2 files changed, 45 insertions(+), 75 deletions(-)

Jeff Kirsher:
      e1000: revert to single descriptor for legacy receive path

diff --git a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
index 27c7730..99baf0e 100644
--- a/drivers/net/e1000/e1000.h
+++ b/drivers/net/e1000/e1000.h
@@ -225,9 +225,6 @@ struct e1000_rx_ring {
 	struct e1000_ps_page *ps_page;
 	struct e1000_ps_page_dma *ps_page_dma;
 
-	struct sk_buff *rx_skb_top;
-	struct sk_buff *rx_skb_prev;
-
 	/* cpu for rx queue */
 	int cpu;
 
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 31e3329..5b7d0f4 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -103,7 +103,7 @@ static char e1000_driver_string[] = "Int
 #else
 #define DRIVERNAPI "-NAPI"
 #endif
-#define DRV_VERSION "6.3.9-k2"DRIVERNAPI
+#define DRV_VERSION "6.3.9-k4"DRIVERNAPI
 char e1000_driver_version[] = DRV_VERSION;
 static char e1000_copyright[] = "Copyright (c) 1999-2005 Intel Corporation.";
 
@@ -1635,8 +1635,6 @@ setup_rx_desc_die:
 
 	rxdr->next_to_clean = 0;
 	rxdr->next_to_use = 0;
-	rxdr->rx_skb_top = NULL;
-	rxdr->rx_skb_prev = NULL;
 
 	return 0;
 }
@@ -1713,8 +1711,23 @@ e1000_setup_rctl(struct e1000_adapter *a
 		rctl |= adapter->rx_buffer_len << 0x11;
 	} else {
 		rctl &= ~E1000_RCTL_SZ_4096;
-		rctl &= ~E1000_RCTL_BSEX;
-		rctl |= E1000_RCTL_SZ_2048;
+		rctl |= E1000_RCTL_BSEX; 
+		switch (adapter->rx_buffer_len) {
+		case E1000_RXBUFFER_2048:
+		default:
+			rctl |= E1000_RCTL_SZ_2048;
+			rctl &= ~E1000_RCTL_BSEX;
+			break;
+		case E1000_RXBUFFER_4096:
+			rctl |= E1000_RCTL_SZ_4096;
+			break;
+		case E1000_RXBUFFER_8192:
+			rctl |= E1000_RCTL_SZ_8192;
+			break;
+		case E1000_RXBUFFER_16384:
+			rctl |= E1000_RCTL_SZ_16384;
+			break;
+		}
 	}
 
 #ifndef CONFIG_E1000_DISABLE_PACKET_SPLIT
@@ -2107,16 +2120,6 @@ e1000_clean_rx_ring(struct e1000_adapter
 		}
 	}
 
-	/* there also may be some cached data in our adapter */
-	if (rx_ring->rx_skb_top) {
-		dev_kfree_skb(rx_ring->rx_skb_top);
-
-		/* rx_skb_prev will be wiped out by rx_skb_top */
-		rx_ring->rx_skb_top = NULL;
-		rx_ring->rx_skb_prev = NULL;
-	}
-
-
 	size = sizeof(struct e1000_buffer) * rx_ring->count;
 	memset(rx_ring->buffer_info, 0, size);
 	size = sizeof(struct e1000_ps_page) * rx_ring->count;
@@ -3106,24 +3109,27 @@ e1000_change_mtu(struct net_device *netd
 		break;
 	}
 
-	/* since the driver code now supports splitting a packet across
-	 * multiple descriptors, most of the fifo related limitations on
-	 * jumbo frame traffic have gone away.
-	 * simply use 2k descriptors for everything.
-	 *
-	 * NOTE: dev_alloc_skb reserves 16 bytes, and typically NET_IP_ALIGN
-	 * means we reserve 2 more, this pushes us to allocate from the next
-	 * larger slab size
-	 * i.e. RXBUFFER_2048 --> size-4096 slab */
 
-	/* recent hardware supports 1KB granularity */
 	if (adapter->hw.mac_type > e1000_82547_rev_2) {
-		adapter->rx_buffer_len =
-		    ((max_frame < E1000_RXBUFFER_2048) ?
-		        max_frame : E1000_RXBUFFER_2048);
+		adapter->rx_buffer_len = max_frame;
 		E1000_ROUNDUP(adapter->rx_buffer_len, 1024);
-	} else
-		adapter->rx_buffer_len = E1000_RXBUFFER_2048;
+	} else {
+		if(unlikely((adapter->hw.mac_type < e1000_82543) &&
+		   (max_frame > MAXIMUM_ETHERNET_FRAME_SIZE))) {
+			DPRINTK(PROBE, ERR, "Jumbo Frames not supported "
+					    "on 82542\n");
+			return -EINVAL;
+		} else {
+			if(max_frame <= E1000_RXBUFFER_2048)
+				adapter->rx_buffer_len = E1000_RXBUFFER_2048;
+			else if(max_frame <= E1000_RXBUFFER_4096)
+				adapter->rx_buffer_len = E1000_RXBUFFER_4096;
+			else if(max_frame <= E1000_RXBUFFER_8192)
+				adapter->rx_buffer_len = E1000_RXBUFFER_8192;
+			else if(max_frame <= E1000_RXBUFFER_16384)
+				adapter->rx_buffer_len = E1000_RXBUFFER_16384;
+		}
+	}
 
 	netdev->mtu = new_mtu;
 
@@ -3620,7 +3626,7 @@ e1000_clean_rx_irq(struct e1000_adapter 
 	uint8_t last_byte;
 	unsigned int i;
 	int cleaned_count = 0;
-	boolean_t cleaned = FALSE, multi_descriptor = FALSE;
+	boolean_t cleaned = FALSE;
 
 	i = rx_ring->next_to_clean;
 	rx_desc = E1000_RX_DESC(*rx_ring, i);
@@ -3652,43 +3658,12 @@ e1000_clean_rx_irq(struct e1000_adapter 
 
 		length = le16_to_cpu(rx_desc->length);
 
-		skb_put(skb, length);
-
-		if (!(status & E1000_RXD_STAT_EOP)) {
-			if (!rx_ring->rx_skb_top) {
-				rx_ring->rx_skb_top = skb;
-				rx_ring->rx_skb_top->len = length;
-				rx_ring->rx_skb_prev = skb;
-			} else {
-				if (skb_shinfo(rx_ring->rx_skb_top)->frag_list) {
-					rx_ring->rx_skb_prev->next = skb;
-					skb->prev = rx_ring->rx_skb_prev;
-				} else {
-					skb_shinfo(rx_ring->rx_skb_top)->frag_list = skb;
-				}
-				rx_ring->rx_skb_prev = skb;
-				rx_ring->rx_skb_top->data_len += length;
-			}
+		if (unlikely(!(status & E1000_RXD_STAT_EOP))) {
+			/* All receives must fit into a single buffer */
+			E1000_DBG("%s: Receive packet consumed multiple"
+				  " buffers\n", netdev->name);
+			dev_kfree_skb_irq(skb);
 			goto next_desc;
-		} else {
-			if (rx_ring->rx_skb_top) {
-				if (skb_shinfo(rx_ring->rx_skb_top)
-							->frag_list) {
-					rx_ring->rx_skb_prev->next = skb;
-					skb->prev = rx_ring->rx_skb_prev;
-				} else
-					skb_shinfo(rx_ring->rx_skb_top)
-							->frag_list = skb;
-
-				rx_ring->rx_skb_top->data_len += length;
-				rx_ring->rx_skb_top->len +=
-					rx_ring->rx_skb_top->data_len;
-
-				skb = rx_ring->rx_skb_top;
-				multi_descriptor = TRUE;
-				rx_ring->rx_skb_top = NULL;
-				rx_ring->rx_skb_prev = NULL;
-			}
 		}
 
 		if (unlikely(rx_desc->errors & E1000_RXD_ERR_FRAME_ERR_MASK)) {
@@ -3712,10 +3687,7 @@ e1000_clean_rx_irq(struct e1000_adapter 
 		 * performance for small packets with large amounts
 		 * of reassembly being done in the stack */
 #define E1000_CB_LENGTH 256
-		if ((length < E1000_CB_LENGTH) &&
-		   !rx_ring->rx_skb_top &&
-		   /* or maybe (status & E1000_RXD_STAT_EOP) && */
-		   !multi_descriptor) {
+		if (length < E1000_CB_LENGTH) {
 			struct sk_buff *new_skb =
 			    dev_alloc_skb(length + NET_IP_ALIGN);
 			if (new_skb) {
@@ -3729,7 +3701,8 @@ e1000_clean_rx_irq(struct e1000_adapter 
 				skb = new_skb;
 				skb_put(skb, length);
 			}
-		}
+		} else
+			skb_put(skb, length);
 
 		/* end copybreak code */
 
