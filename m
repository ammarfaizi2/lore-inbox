Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132204AbRALTGw>; Fri, 12 Jan 2001 14:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132152AbRALTGd>; Fri, 12 Jan 2001 14:06:33 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:18951 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S131879AbRALTGV>;
	Fri, 12 Jan 2001 14:06:21 -0500
Date: Fri, 12 Jan 2001 20:05:41 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Message-ID: <20010112200541.A25675@unternet.org>
In-Reply-To: <E14H8Ks-0004hA-00@the-village.bc.nu> <3A5F4827.2E443786@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F4827.2E443786@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 12, 2001 at 07:08:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per Linus' suggestion, I removed the disable_irq/enable_irq statements from
the 8390 core driver, and replace the spinlocks with irq-safe versions. This
seems to solve the network hangs, as I am currently running a heavy network
load (which would have killed a non-patched driver within seconds). Network
latency seems a bit higher, and there are some hiccups in the streaming audio
(part of the network load, easy indicator of performance...), but no hangs.
Here's the patch:

--- linux/drivers/net/8390.c.org	Fri Jan 12 19:52:38 2001
+++ linux/drivers/net/8390.c	Fri Jan 12 19:54:50 2001
@@ -242,15 +242,15 @@
 
 	/* Ugly but a reset can be slow, yet must be protected */
 		
-	disable_irq_nosync(dev->irq);
-	spin_lock(&ei_local->page_lock);
+	/* disable_irq_nosync(dev->irq); */
+	spin_lock_irq(&ei_local->page_lock);
 		
 	/* Try to restart the card.  Perhaps the user has fixed something. */
 	ei_reset_8390(dev);
 	NS8390_init(dev, 1);
 		
-	spin_unlock(&ei_local->page_lock);
-	enable_irq(dev->irq);
+	spin_unlock_irq(&ei_local->page_lock);
+	/* enable_irq(dev->irq); */
 	netif_wake_queue(dev);
 }
     
@@ -285,9 +285,9 @@
 	 *	Slow phase with lock held.
 	 */
 	 
-	disable_irq_nosync(dev->irq);
+	/* disable_irq_nosync(dev->irq); */
 	
-	spin_lock(&ei_local->page_lock);
+	spin_lock_irq(&ei_local->page_lock);
 	
 	ei_local->irqlock = 1;
 
@@ -383,8 +383,8 @@
 	ei_local->irqlock = 0;
 	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 	
-	spin_unlock(&ei_local->page_lock);
-	enable_irq(dev->irq);
+	spin_unlock_irq(&ei_local->page_lock);
+	/* enable_irq(dev->irq); */
 
 	dev_kfree_skb (skb);
 	ei_local->stat.tx_bytes += send_length;

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
