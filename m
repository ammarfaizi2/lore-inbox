Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWGCVoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWGCVoB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWGCVoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:44:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19887 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750852AbWGCVoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:44:00 -0400
Subject: Re: 2.6.17-mm5 + pcmcia/hostap/8139too patches -- inconsistent
	{hardirq-on-W} -> {in-hardirq-W} usage
From: Arjan van de Ven <arjan@infradead.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com>
References: <a44ae5cd0607031431q8dcc698j1c447b1d51c7cc75@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 23:43:54 +0200
Message-Id: <1151963034.3108.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 14:31 -0700, Miles Lane wrote:
> inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
> swapper/0 [HC1[1]:SC1[2]:HE0:SE0] takes:
>  (&ei_local->page_lock){++..}, at: [<f935079f>] ei_interrupt+0x49/0x294 [8390]
> {hardirq-on-W} state was registered at:
>   [<c102d152>] lock_acquire+0x60/0x80
>   [<c1200376>] _spin_lock+0x23/0x32

fun.. you have many strange network cards :-)

ok I'm not quite happy about this one yet, but can you try this patch?


The ne2000 drivers use disable_irq as a poor mans locking construct;
make sure lockdep knows about these.
NOTE NOTE: the ne2000 driver calls these *from interrupt context*.
That's a new situation that needs to be analyzed for correctness still;
it feels really wrong to me (but then again so does disable_irq() tricks
in general)


Andrew: once testing completes and I've looked at it more I'll resend
with a proper description + signed-off line

---
 drivers/net/8390.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.17-mm4/drivers/net/8390.c
===================================================================
--- linux-2.6.17-mm4.orig/drivers/net/8390.c
+++ linux-2.6.17-mm4/drivers/net/8390.c
@@ -299,7 +299,7 @@ static int ei_start_xmit(struct sk_buff 
 	 *	Slow phase with lock held.
 	 */
 	 
-	disable_irq_nosync(dev->irq);
+	disable_irq_nosync_lockdep(dev->irq);
 	
 	spin_lock(&ei_local->page_lock);
 	
@@ -338,7 +338,7 @@ static int ei_start_xmit(struct sk_buff 
 		netif_stop_queue(dev);
 		outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 		spin_unlock(&ei_local->page_lock);
-		enable_irq(dev->irq);
+		enable_irq_lockdep(dev->irq);
 		ei_local->stat.tx_errors++;
 		return 1;
 	}
@@ -379,7 +379,7 @@ static int ei_start_xmit(struct sk_buff 
 	outb_p(ENISR_ALL, e8390_base + EN0_IMR);
 	
 	spin_unlock(&ei_local->page_lock);
-	enable_irq(dev->irq);
+	enable_irq_lockdep(dev->irq);
 
 	dev_kfree_skb (skb);
 	ei_local->stat.tx_bytes += send_length;
@@ -505,9 +505,9 @@ irqreturn_t ei_interrupt(int irq, void *
 #ifdef CONFIG_NET_POLL_CONTROLLER
 void ei_poll(struct net_device *dev)
 {
-	disable_irq(dev->irq);
+	disable_irq_lockdep(dev->irq);
 	ei_interrupt(dev->irq, dev, NULL);
-	enable_irq(dev->irq);
+	enable_irq_lockdep(dev->irq);
 }
 #endif
 


