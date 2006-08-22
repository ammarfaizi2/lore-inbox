Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWHVANP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWHVANP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWHVANP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:13:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:23936 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750832AbWHVANO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:13:14 -0400
Date: Mon, 21 Aug 2006 19:13:11 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens.Osterkamp@de.ibm.com, jklewis@us.ibm.com, arnd@arndb.de
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060822001311.GK5427@austin.ibm.com>
References: <20060818192356.GD26889@austin.ibm.com> <20060818.142513.29571851.davem@davemloft.net> <20060818224618.GN26889@austin.ibm.com> <20060818.155116.112621100.davem@davemloft.net> <20060818232942.GO26889@austin.ibm.com> <20060818234532.GA8644@austin.ibm.com> <1155962022.5803.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155962022.5803.68.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 02:33:42PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-08-18 at 18:45 -0500, Linas Vepstas wrote:
> > On Fri, Aug 18, 2006 at 06:29:42PM -0500, linas wrote:
> > > 
> > > I don't understand what you are saying. If I call the transmit 
> > > queue cleanup code from the poll() routine, nothing hapens, 
> > > because the kernel does not call the poll() routine often 
> > > enough. I've stated this several times.  
> > 
> > OK, Arnd gave me a clue stick. I need to call the (misnamed)
> > netif_rx_schedule() from the tx interrupt in order to get 
> > this to work. That makes sense, and its easy, I'll send the 
> > revised patch.. well, not tonight, but shortly.
> 
> You might not want to call it all the time though... You need some
> interrupt mitigation and thus a timer that calls netif_rx_schedule()
> might be of some use still...

Well, again, the whole point of a low-watermark interrupt is to 
get zero of them when the system is working correctly; they're
self-mitigating by design.

-------------
Anyway, I tried the suggestion, but am getting less-than-ideal
results. 

To recap: my original patch did this:

   spider_interrupt_handler(struct whatever *) {
      ...
      if (tx_interrupt) 
         schedule_work (tx_cleanup_handler)
   }

which David Miller objected to. Once I understood the why 
(sorry for not getting it right away), I then replaced the 
above with the below, which is what I think everyone wanted:


   spider_interrupt_handler(struct whatever *) {
      ...
      if (tx_interrupt) 
         netif_rx_schedule(netdev);
   }

   spidernet_poll(stuct whatever *) {
      tx_cleanup_handler(txring);
      // rx_stuff too ...
   }

I was expecting this to be a no-op from the performance
point of view. Instead, I get a fairly dramatic (11%) slowdown:
the first patch runs in the 785-805 Mbits/sec range, while
the second patch runs in the 705-715 Mbits/sec range. 
I am surprised, ad don't understand why this would be so.

For the record, the alternate patch is below.

----

Index: linux-2.6.18-rc2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/net/spider_net.c	2006-08-21 16:59:33.000000000 -0500
+++ linux-2.6.18-rc2/drivers/net/spider_net.c	2006-08-21 17:15:28.000000000 -0500
@@ -1087,6 +1090,8 @@ spider_net_poll(struct net_device *netde
 	int packets_to_do, packets_done = 0;
 	int no_more_packets = 0;
 
+	spider_net_cleanup_tx_ring(card);
+
 	packets_to_do = min(*budget, netdev->quota);
 
 	while (packets_to_do) {
@@ -1495,16 +1500,16 @@ spider_net_interrupt(int irq, void *ptr,
 	if (!status_reg)
 		return IRQ_NONE;
 
-	if (status_reg & SPIDER_NET_RXINT ) {
+	if (status_reg & SPIDER_NET_RXINT) {
 		spider_net_rx_irq_off(card);
 		netif_rx_schedule(netdev);
 	}
-	if (status_reg & SPIDER_NET_TXINT ) {
-		spider_net_cleanup_tx_ring(card);
-		netif_wake_queue(netdev);
-	}
 
-	if (status_reg & SPIDER_NET_ERRINT )
+	/* Call rx_schedule from the tx interrupt, so that NAPI poll runs. */
+	if (status_reg & SPIDER_NET_TXINT)
+		netif_rx_schedule(netdev);
+
+	if (status_reg & SPIDER_NET_ERRINT)
 		spider_net_handle_error_irq(card, status_reg);
 
 	/* clear interrupt sources */




