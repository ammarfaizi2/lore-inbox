Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283616AbRK3LYG>; Fri, 30 Nov 2001 06:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283619AbRK3LX4>; Fri, 30 Nov 2001 06:23:56 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49918 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S283618AbRK3LXp>; Fri, 30 Nov 2001 06:23:45 -0500
Date: Fri, 30 Nov 2001 20:23:36 +0900
Message-Id: <200111301123.UAA23808@asami.proc.flab.fujitsu.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 8139too.c
Reply-to: kumon@flab.fujitsu.co.jp
From: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 8139too.c, skb is used after it is freed.
Look at the argument of RTL_W32_F() in the following patch.

8 % diff -u -10 8139too.c  /tmp/8139too.c 
--- 8139too.c	Sun Nov 25 10:46:36 2001
+++ /tmp/8139too.c	Fri Nov 30 19:50:48 2001
@@ -1635,40 +1635,40 @@
 {
 	struct rtl8139_private *tp = dev->priv;
 	void *ioaddr = tp->mmio_addr;
 	unsigned int entry;
 
 	/* Calculate the next Tx descriptor entry. */
 	entry = tp->cur_tx % NUM_TX_DESC;
 
 	if (likely(skb->len < TX_BUF_SIZE)) {
 		skb_copy_and_csum_dev(skb, tp->tx_buf[entry]);
-		dev_kfree_skb(skb);
 	} else {
 		dev_kfree_skb(skb);
 		tp->stats.tx_dropped++;
 		return 0;
   	}
 
 	/* Note: the chip doesn't have auto-pad! */
 	spin_lock_irq(&tp->lock);
 	RTL_W32_F (TxStatus0 + (entry * sizeof (u32)),
 		   tp->tx_flag | (skb->len >= ETH_ZLEN ? skb->len : ETH_ZLEN));
 
 	dev->trans_start = jiffies;
 
 	tp->cur_tx++;
 	wmb();
 
 	if ((tp->cur_tx - NUM_TX_DESC) == tp->dirty_tx)
 		netif_stop_queue (dev);
 	spin_unlock_irq(&tp->lock);
+	dev_kfree_skb(skb);
 
 	DPRINTK ("%s: Queued Tx packet at %p size %u to slot %d.\n",
 		 dev->name, skb->data, skb->len, entry);
 
 	return 0;
 }
 
 
 static void rtl8139_tx_interrupt (struct net_device *dev,
 				  struct rtl8139_private *tp,


--
Software Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
