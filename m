Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWGCImw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWGCImw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWGCImv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:42:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39052 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750802AbWGCImv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:42:51 -0400
Subject: Re: 2.6.17-mm5 -- inconsistent {in-softirq-W} -> {softirq-on-W}
	usage.
From: Arjan van de Ven <arjan@infradead.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, mingo@elte.hu
In-Reply-To: <a44ae5cd0607030125l770086e1wdbbc8e8306ce94ca@mail.gmail.com>
References: <a44ae5cd0607030125l770086e1wdbbc8e8306ce94ca@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 10:42:45 +0200
Message-Id: <1151916166.3108.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> stack backtrace:

>  [<f9099d31>] rtl8139_start_xmit+0xd9/0xff [8139too]
>  [<c11ad5ea>] netpoll_send_skb+0x98/0xea

This seems to be a real deadlock...

So netpoll_send_skb takes the _xmit_lock, which is all nitty gritty
but then rtl8139_start_xmit comes around while that lock is taken, and
does

      spin_unlock_irq(&tp->lock);

which.. enables interrupts and softirqs; this is quite bad because the
xmit lock is taken in softirq context for the watchdog like this:
  [<c1200376>] _spin_lock+0x23/0x32
  [<c11af282>] dev_watchdog+0x14/0xb1
  [<c101dab2>] run_timer_softirq+0xf2/0x14a
  [<c101a691>] __do_softirq+0x55/0xb0
  [<c1004a8d>] do_softirq+0x58/0xbd

Which would deadlock now that the spin_unlock_irq() has enabled
irqs/softirqs while the _xmit_lock is still held.


The patch below turns this into a irqsave/irqrestore pair so that
interrupts don't get enabled unconditionally.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 drivers/net/8139too.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.17-mm4/drivers/net/8139too.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/net/8139too.c
+++ linux-2.6.17-mm4/drivers/net/8139too.c
@@ -1710,6 +1710,7 @@ static int rtl8139_start_xmit (struct sk
 	void __iomem *ioaddr = tp->mmio_addr;
 	unsigned int entry;
 	unsigned int len = skb->len;
+	unsigned long flags;
 
 	/* Calculate the next Tx descriptor entry. */
 	entry = tp->cur_tx % NUM_TX_DESC;
@@ -1726,7 +1727,7 @@ static int rtl8139_start_xmit (struct sk
 		return 0;
 	}
 
-	spin_lock_irq(&tp->lock);
+	spin_lock_irqsave(&tp->lock, flags);
 	RTL_W32_F (TxStatus0 + (entry * sizeof (u32)),
 		   tp->tx_flag | max(len, (unsigned int)ETH_ZLEN));
 
@@ -1737,7 +1738,7 @@ static int rtl8139_start_xmit (struct sk
 
 	if ((tp->cur_tx - NUM_TX_DESC) == tp->dirty_tx)
 		netif_stop_queue (dev);
-	spin_unlock_irq(&tp->lock);
+	spin_unlock_irqrestore(&tp->lock, flags);
 
 	if (netif_msg_tx_queued(tp))
 		printk (KERN_DEBUG "%s: Queued Tx packet size %u to slot %d.\n",


