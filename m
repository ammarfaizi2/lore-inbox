Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbRALTFc>; Fri, 12 Jan 2001 14:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131879AbRALTFW>; Fri, 12 Jan 2001 14:05:22 -0500
Received: from colorfullife.com ([216.156.138.34]:38661 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130599AbRALTFN>;
	Fri, 12 Jan 2001 14:05:13 -0500
Message-ID: <3A5F5538.57F3FDC5@colorfullife.com>
Date: Fri, 12 Jan 2001 20:04:24 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: dwmw2@infradead.org, linux-kernel@vger.kernel.org, mingo@elte.hu,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware 
 related?
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com> <20010112183314.A24174@unternet.org> <3A5F4428.F3249D2@colorfullife.com> <20010112192500.A25057@unternet.org>
Content-Type: multipart/mixed;
 boundary="------------5DF33A7351A06D1D177B8D30"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5DF33A7351A06D1D177B8D30
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus wrote:
> Does this seem to happen mainly with drivers that use "disable_irq()" 
> and "enable_irq()"? I know the ne drivers do (through the 8390 module), 
> and some others do too (3c59x). 

I removed the disable_irq lines from 8390.c, and that fixed the problem:
no hang within 2 minutes - the test is still running.

Frank, could you double check it?

--
	Manfred
--------------5DF33A7351A06D1D177B8D30
Content-Type: text/plain; charset=us-ascii;
 name="patch-frank"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-frank"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 0
//  EXTRAVERSION =
--- 2.4/drivers/net/8390.c	Thu Jan  4 22:00:55 2001
+++ build-2.4/drivers/net/8390.c	Fri Jan 12 19:53:47 2001
@@ -242,15 +242,15 @@
 
 	/* Ugly but a reset can be slow, yet must be protected */
 		
-	disable_irq_nosync(dev->irq);
-	spin_lock(&ei_local->page_lock);
+/*	disable_irq_nosync(dev->irq);*/
+	spin_lock_irqsave(&ei_local->page_lock, flags);
 		
 	/* Try to restart the card.  Perhaps the user has fixed something. */
 	ei_reset_8390(dev);
 	NS8390_init(dev, 1);
 		
-	spin_unlock(&ei_local->page_lock);
-	enable_irq(dev->irq);
+	spin_unlock_irqrestore(&ei_local->page_lock, flags);
+/*	enable_irq(dev->irq); */
 	netif_wake_queue(dev);
 }
     
@@ -285,9 +285,9 @@
 	 *	Slow phase with lock held.
 	 */
 	 
-	disable_irq_nosync(dev->irq);
+/*	disable_irq_nosync(dev->irq);*/
 	
-	spin_lock(&ei_local->page_lock);
+	spin_lock_irqsave(&ei_local->page_lock, flags);
 	
 	ei_local->irqlock = 1;
 
@@ -327,8 +327,8 @@
 		ei_local->irqlock = 0;
 		netif_stop_queue(dev);
 		outb_p(ENISR_ALL, e8390_base + EN0_IMR);
-		spin_unlock(&ei_local->page_lock);
-		enable_irq(dev->irq);
+		spin_unlock_irqrestore(&ei_local->page_lock, flags);
+/*		enable_irq(dev->irq);*/
 		ei_local->stat.tx_errors++;
 		return 1;
 	}
@@ -383,8 +383,8 @@
 	ei_local->irqlock = 0;
 	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 	
-	spin_unlock(&ei_local->page_lock);
-	enable_irq(dev->irq);
+	spin_unlock_irqrestore(&ei_local->page_lock, flags);
+/*	enable_irq(dev->irq); */
 
 	dev_kfree_skb (skb);
 	ei_local->stat.tx_bytes += send_length;

--------------5DF33A7351A06D1D177B8D30--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
