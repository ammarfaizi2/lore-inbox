Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131258AbRAUOnc>; Sun, 21 Jan 2001 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135361AbRAUOnY>; Sun, 21 Jan 2001 09:43:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:34565 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131258AbRAUOnK>;
	Sun, 21 Jan 2001 09:43:10 -0500
Message-ID: <3A6AF575.D593AEBC@mandrakesoft.com>
Date: Sun, 21 Jan 2001 09:43:01 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Manfred <manfred@colorfullife.com>, mulder.abg@sni.de,
        linux-kernel@vger.kernel.org, Donald Becker <becker@scyld.com>
Subject: [PATCH] Re: Q: natsemi.c spinlocks
In-Reply-To: <3A44E4D0.E8F177B9@colorfullife.com> <3A45493C.3C75EC1A@uow.edu.au>
Content-Type: multipart/mixed;
 boundary="------------91CDC4A2EAEE4189524D6057"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------91CDC4A2EAEE4189524D6057
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> 
> Manfred wrote:
> >
> > Hi Jeff, Tjeerd,
> >
> > I spotted the spin_lock in natsemi.c, and I think it's bogus.
> >
> > The "simultaneous interrupt entry" is a bug in some 2.0 and 2.1 kernel
> > (even Alan didn't remember it exactly when I asked him), thus a sane
> > driver can assume that an interrupt handler is never reentered.
> >
> > Donald often uses dev->interrupt to hide other races, but I don't see
> > anything in this driver (tx_timeout and netdev_timer are both trivial)
> 
> Hi, Manfed.
> 
> I think you're right.  2.4's interrupt handling prevents
> simultaneous entry of the same ISR.
> 
> However, natsemi.c's spinlock needs to be retained, and
> extended into start_tx(), because this driver has
> a race which has cropped up in a few others:
> 
> Current code:
> 
> start_tx()
> {
>         ...
>         if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
>         /* WINDOW HERE */
>                 np->tx_full = 1;
>                 netif_stop_queue(dev);
>         }
>         ...
> }
> 
> If the ring is currently full and an interrupt comes in
> at the indicated window and reaps ALL the packets in the
> ring, the driver ends up in state `tx_full = 1' and tramsmit
> disabled, but with no outstanding transmit interrupts.
> 
> It's screwed.  You need another interrupt so tx_full
> can be cleared and the queue can be restarted, but you can't
> *get* another interrupt because there are no Tx packets outstanding.
> 
> It's very unlikely to happen with this particular driver
> because it's also polling the transmit queue within
> receive interrupts.  Receiving a packet will clear
> the condition.
> 
> If you were madly hosing out UDP packets and receiving nothing
> then this could occur.  It was certainly triggerable in 3c59x.c,
> which doesn't test the Tx queue state in Rx interrupts.
> 
> I currently have natsemi.c lying in pieces on my garage floor,
> so I'll put this locking in if it's OK with everyone?

(entire message quoted, as it was from 12/23/2000)

Attached is a patch against 2.4.1-pre9, which includes the changes I
would prefer.  Comments?

The Tx locking is a bit conservative -- I think Donald suggested it
could be removed completely -- but I would prefer to have something I am
100% certain will work, and then test the driver without locking under
stress conditions to make sure no race or other bug exists.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------91CDC4A2EAEE4189524D6057
Content-Type: text/plain; charset=us-ascii;
 name="natsemi-2.4.1.9.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="natsemi-2.4.1.9.patch"

Index: linux_2_4/drivers/net/natsemi.c
diff -u linux_2_4/drivers/net/natsemi.c:1.1.1.6 linux_2_4/drivers/net/natsemi.c:1.1.1.6.24.1
--- linux_2_4/drivers/net/natsemi.c:1.1.1.6	Mon Dec 11 19:23:42 2000
+++ linux_2_4/drivers/net/natsemi.c	Sun Jan 21 06:39:02 2001
@@ -26,6 +26,11 @@
 		- Bug fixes and better intr performance (Tjeerd)
 	Version 1.0.2:
 		- Now reads correct MAC address from eeprom
+	Version 1.0.3:
+		- Eliminate redundant priv->tx_full flag
+		- Call netif_start_queue from dev->tx_timeout
+		- wmb() in start_tx() to flush data
+		- Update Tx locking
 
 */
 
@@ -35,7 +40,7 @@
 static const char version2[] =
 "  http://www.scyld.com/network/natsemi.html\n";
 static const char version3[] =
-"  (unofficial 2.4.x kernel port, version 1.0.2, October 6, 2000 Jeff Garzik, Tjeerd Mulder)\n";
+"  (unofficial 2.4.x kernel port, version 1.0.3, January 21, 2001 Jeff Garzik, Tjeerd Mulder)\n";
 /* Updated to recommendations in pci-skeleton v2.03. */
 
 /* Automatically extracted configuration info:
@@ -187,13 +192,14 @@
 
 The send packet thread has partial control over the Tx ring and 'dev->tbusy'
 flag.  It sets the tbusy flag whenever it's queuing a Tx packet. If the next
-queue slot is empty, it clears the tbusy flag when finished otherwise it sets
-the 'lp->tx_full' flag.
+queue slot is empty, it clears the tbusy flag when finished.  Under 2.4, the
+"tbusy flag" is now controlled by netif_{start,stop,wake}_queue() and tested
+by netif_queue_stopped().
 
 The interrupt handler has exclusive control over the Rx ring and records stats
 from the Tx ring.  After reaping the stats, it marks the Tx queue entry as
-empty by incrementing the dirty_tx mark. Iff the 'lp->tx_full' flag is set, it
-clears both the tx_full and tbusy flags.
+empty by incrementing the dirty_tx mark. Iff Tx queueing is stopped and Tx
+entries were reaped, the Tx queue is started and scheduled.
 
 IV. Notes
 
@@ -319,7 +325,6 @@
 	unsigned int cur_rx, dirty_rx;		/* Producer/consumer ring indices */
 	unsigned int cur_tx, dirty_tx;
 	unsigned int rx_buf_sz;				/* Based on MTU+slack. */
-	unsigned int tx_full:1;				/* The Tx queue is full. */
 	/* These values are keep track of the transceiver/media in use. */
 	unsigned int full_duplex:1;			/* Full-duplex operation requested. */
 	unsigned int duplex_lock:1;
@@ -697,7 +702,7 @@
 
 	dev->trans_start = jiffies;
 	np->stats.tx_errors++;
-	return;
+	netif_start_queue(dev);
 }
 
 
@@ -707,7 +712,6 @@
 	struct netdev_private *np = (struct netdev_private *)dev->priv;
 	int i;
 
-	np->tx_full = 0;
 	np->cur_rx = np->cur_tx = 0;
 	np->dirty_rx = np->dirty_tx = 0;
 
@@ -763,11 +767,13 @@
 	np->cur_tx++;
 
 	/* StrongARM: Explicitly cache flush np->tx_ring and skb->data,skb->len. */
+	wmb();
 
-	if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1) {
-		np->tx_full = 1;
+	spin_lock_irq(&np->lock);
+	if (np->cur_tx - np->dirty_tx >= TX_QUEUE_LEN - 1)
 		netif_stop_queue(dev);
-	}
+	spin_unlock_irq(&np->lock);
+
 	/* Wake the potentially-idle transmit channel. */
 	writel(TxOn, dev->base_addr + ChipCmd);
 
@@ -798,9 +804,7 @@
 #endif
 
 	ioaddr = dev->base_addr;
-	np = (struct netdev_private *)dev->priv;
-
-	spin_lock(&np->lock);
+	np = dev->priv;
 
 	do {
 		u32 intr_status = readl(ioaddr + IntrStatus);
@@ -818,6 +822,8 @@
 		if (intr_status & (IntrRxDone | IntrRxErr | IntrRxIdle | IntrRxOverrun))
 			netdev_rx(dev);
 
+		spin_lock(&np->lock);
+
 		for (; np->cur_tx - np->dirty_tx > 0; np->dirty_tx++) {
 			int entry = np->dirty_tx % TX_RING_SIZE;
 			if (np->tx_ring[entry].cmd_status & cpu_to_le32(DescOwn))
@@ -839,13 +845,14 @@
 			dev_kfree_skb_irq(np->tx_skbuff[entry]);
 			np->tx_skbuff[entry] = 0;
 		}
-		if (np->tx_full
+		if (netif_queue_stopped(dev)
 			&& np->cur_tx - np->dirty_tx < TX_QUEUE_LEN - 4) {
 			/* The ring is no longer full, wake queue. */
-			np->tx_full = 0;
 			netif_wake_queue(dev);
 		}
 
+		spin_unlock(&np->lock);
+
 		/* Abnormal error summary/uncommon events handlers. */
 		if (intr_status & IntrAbnormalSummary)
 			netdev_error(dev, intr_status);
@@ -873,8 +880,6 @@
 		}
 	}
 #endif
-
-	spin_unlock(&np->lock);
 }
 
 /* This routine is logically part of the interrupt handler, but separated

--------------91CDC4A2EAEE4189524D6057--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
