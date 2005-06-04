Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVFDIjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVFDIjg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 04:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFDIjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 04:39:35 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54721 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261304AbVFDIid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 04:38:33 -0400
Message-ID: <42A16880.4030802@pobox.com>
Date: Sat, 04 Jun 2005 04:38:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x net driver fixes
Content-Type: multipart/mixed;
 boundary="------------050200070305000207090100"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050200070305000207090100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Please pull from the 'misc-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain r8169 and 3c574_cs fixes.  diffstat/shortlog/patch attached.

	Jeff




--------------050200070305000207090100
Content-Type: text/plain;
 name="netdev-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="netdev-2.6.txt"



 drivers/net/pcmcia/3c574_cs.c |    3 +++
 drivers/net/r8169.c           |   31 +++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)



<jgarzik@pretzel.yyz.us>:
  Automatic merge of /spare/repo/netdev-2.6 branch r8169-fix
  Automatic merge of rsync://rsync.kernel.org/.../torvalds/linux-2.6.git branch HEAD

Daniel Ritz <daniel.ritz@gmx.ch>:
  3c574_cs: disable interrupts in el3_close

Francois Romieu <romieu@fr.zoreil.com>:
  [PATCH] r8169: incoming frame length check



diff --git a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
--- a/drivers/net/pcmcia/3c574_cs.c
+++ b/drivers/net/pcmcia/3c574_cs.c
@@ -1274,6 +1274,9 @@ static int el3_close(struct net_device *
 		spin_lock_irqsave(&lp->window_lock, flags);
 		update_stats(dev);
 		spin_unlock_irqrestore(&lp->window_lock, flags);
+
+		/* force interrupts off */
+		outw(SetIntrEnb | 0x0000, ioaddr + EL3_CMD);
 	}
 
 	link->open--;
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -1585,8 +1585,8 @@ rtl8169_hw_start(struct net_device *dev)
 	RTL_W8(ChipCmd, CmdTxEnb | CmdRxEnb);
 	RTL_W8(EarlyTxThres, EarlyTxThld);
 
-	/* For gigabit rtl8169, MTU + header + CRC + VLAN */
-	RTL_W16(RxMaxSize, tp->rx_buf_sz);
+	/* Low hurts. Let's disable the filtering. */
+	RTL_W16(RxMaxSize, 16383);
 
 	/* Set Rx Config register */
 	i = rtl8169_rx_config |
@@ -2127,6 +2127,11 @@ rtl8169_tx_interrupt(struct net_device *
 	}
 }
 
+static inline int rtl8169_fragmented_frame(u32 status)
+{
+	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
+}
+
 static inline void rtl8169_rx_csum(struct sk_buff *skb, struct RxDesc *desc)
 {
 	u32 opts1 = le32_to_cpu(desc->opts1);
@@ -2177,27 +2182,41 @@ rtl8169_rx_interrupt(struct net_device *
 
 	while (rx_left > 0) {
 		unsigned int entry = cur_rx % NUM_RX_DESC;
+		struct RxDesc *desc = tp->RxDescArray + entry;
 		u32 status;
 
 		rmb();
-		status = le32_to_cpu(tp->RxDescArray[entry].opts1);
+		status = le32_to_cpu(desc->opts1);
 
 		if (status & DescOwn)
 			break;
 		if (status & RxRES) {
-			printk(KERN_INFO "%s: Rx ERROR!!!\n", dev->name);
+			printk(KERN_INFO "%s: Rx ERROR. status = %08x\n",
+			       dev->name, status);
 			tp->stats.rx_errors++;
 			if (status & (RxRWT | RxRUNT))
 				tp->stats.rx_length_errors++;
 			if (status & RxCRC)
 				tp->stats.rx_crc_errors++;
+			rtl8169_mark_to_asic(desc, tp->rx_buf_sz);
 		} else {
-			struct RxDesc *desc = tp->RxDescArray + entry;
 			struct sk_buff *skb = tp->Rx_skbuff[entry];
 			int pkt_size = (status & 0x00001FFF) - 4;
 			void (*pci_action)(struct pci_dev *, dma_addr_t,
 				size_t, int) = pci_dma_sync_single_for_device;
 
+			/*
+			 * The driver does not support incoming fragmented
+			 * frames. They are seen as a symptom of over-mtu
+			 * sized frames.
+			 */
+			if (unlikely(rtl8169_fragmented_frame(status))) {
+				tp->stats.rx_dropped++;
+				tp->stats.rx_length_errors++;
+				rtl8169_mark_to_asic(desc, tp->rx_buf_sz);
+				goto move_on;
+			}
+
 			rtl8169_rx_csum(skb, desc);
 			
 			pci_dma_sync_single_for_cpu(tp->pci_dev,
@@ -2224,7 +2243,7 @@ rtl8169_rx_interrupt(struct net_device *
 			tp->stats.rx_bytes += pkt_size;
 			tp->stats.rx_packets++;
 		}
-		
+move_on:		
 		cur_rx++; 
 		rx_left--;
 	}

--------------050200070305000207090100--
