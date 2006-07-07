Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWGGJjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWGGJjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWGGJjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:39:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932091AbWGGJjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:39:01 -0400
Date: Fri, 7 Jul 2006 02:38:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: pauldrynoff@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.17-mm6: strange kobject message
Message-Id: <20060707023824.ded18f30.akpm@osdl.org>
In-Reply-To: <1152264552.3111.35.camel@laptopd505.fenrus.org>
References: <20060707125942.fe3d467b.pauldrynoff@gmail.com>
	<20060707022420.6f58b58c.akpm@osdl.org>
	<1152264552.3111.35.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jul 2006 11:29:12 +0200
Arjan van de Ven <arjan@infradead.org> wrote:

> On Fri, 2006-07-07 at 02:24 -0700, Andrew Morton wrote:
> 
> > hm. 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/broken-out/lockdep-annotate-8390c-disable_irq.patch
> > didn't work.
> 
> -mm6 only had part 1; you also have part 2 now which should fix this one

OK, here it is:

From: Arjan van de Ven <arjan@linux.intel.com>

The ne2000 drivers use disable_irq as a poor mans locking construct; make
sure lockdep knows about these.

NOTE NOTE: the ne2000 driver calls these *from interrupt context*.  That's
a new situation that needs to be analyzed for correctness still; it feels
really wrong to me (but then again so does disable_irq() tricks in general)

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/8390.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/net/8390.c~lockdep-annotate-8390c-disable_irq-2 drivers/net/8390.c
--- a/drivers/net/8390.c~lockdep-annotate-8390c-disable_irq-2
+++ a/drivers/net/8390.c
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
 
_

