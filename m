Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWGKIkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWGKIkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWGKIkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:40:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20670 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750752AbWGKIko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:40:44 -0400
Subject: Re: 2.6.18-rc1-mm1 inconsistent lock state in netpoll_send_skb
From: Arjan van de Ven <arjan@infradead.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <44B2A522.2080703@free.fr>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <44B17735.4060006@free.fr> <1152520823.4874.0.camel@laptopd505.fenrus.org>
	 <44B2A522.2080703@free.fr>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 10:40:38 +0200
Message-Id: <1152607239.3128.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Reversed (or previously applied) patch detected! 
> 
> Wrong patch ? This one won't apply, it seems to be already 
> applied to 2.6.18-rc1-mm1.

ok these patches ought to fix this for real (sorry I don't have this
hardware so I cannot actually do the testing)

I hope you have time to test these..

Greetings,
   Arjan van de Ven

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs

Introduce the disable_irq_nosync_lockdep_irqsave() and enable_irq_lockdep_irqrestore() APIs.
These are needed for NE2000; basically NE2000 calls disable_irq and enable_irq as locking
against the IRQ handler, but both in cases where interrupts are on and off. This means that
lockdep needs to track the old state of the virtual irq flags on disable_irq, and restore these
at enable_irq time.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Index: linux-2.6.18-rc1/include/linux/interrupt.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/interrupt.h
+++ linux-2.6.18-rc1/include/linux/interrupt.h
@@ -123,6 +123,14 @@ static inline void disable_irq_nosync_lo
 #endif
 }
 
+static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
+{
+	disable_irq_nosync(irq);
+#ifdef CONFIG_LOCKDEP
+	local_irq_save(*flags);
+#endif
+}
+
 static inline void disable_irq_lockdep(unsigned int irq)
 {
 	disable_irq(irq);
@@ -139,6 +147,14 @@ static inline void enable_irq_lockdep(un
 	enable_irq(irq);
 }
 
+static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
+{
+#ifdef CONFIG_LOCKDEP
+	local_irq_restore(*flags);
+#endif
+	enable_irq(irq);
+}
+
 /* IRQ wakeup (PM) control: */
 extern int set_irq_wake(unsigned int irq, unsigned int on);
 
From: Arjan van de Ven <arjan@linux.intel.com>
Subject: lockdep: annotate the ne2000 driver with the new disable_irq API addition

The ne2000 driver's xmit function gets called from netpoll with the
_xmit_lock spinlock held as _irqsave. This means the xmit function needs to preserve this
irq-off state throughout to avoid deadlock. It does, but we need to also tell lockdep that
the function indeed does this by using the proper disable_irq annotation.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-2.6.18-rc1/drivers/net/8390.c
===================================================================
--- linux-2.6.18-rc1.orig/drivers/net/8390.c
+++ linux-2.6.18-rc1/drivers/net/8390.c
@@ -299,7 +299,7 @@ static int ei_start_xmit(struct sk_buff 
 	 *	Slow phase with lock held.
 	 */
 	 
-	disable_irq_nosync_lockdep(dev->irq);
+	disable_irq_nosync_lockdep_irqsave(dev->irq, &flags);
 	
 	spin_lock(&ei_local->page_lock);
 	
@@ -338,7 +338,7 @@ static int ei_start_xmit(struct sk_buff 
 		netif_stop_queue(dev);
 		outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 		spin_unlock(&ei_local->page_lock);
-		enable_irq_lockdep(dev->irq);
+		enable_irq_lockdep_irqrestore(dev->irq, &flags);
 		ei_local->stat.tx_errors++;
 		return 1;
 	}
@@ -379,7 +379,7 @@ static int ei_start_xmit(struct sk_buff 
 	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 	
 	spin_unlock(&ei_local->page_lock);
-	enable_irq_lockdep(dev->irq);
+	enable_irq_lockdep_irqrestore(dev->irq, &flags);
 
 	dev_kfree_skb (skb);
 	ei_local->stat.tx_bytes += send_length;


