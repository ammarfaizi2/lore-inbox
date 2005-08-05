Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbVHENtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbVHENtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbVHENtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:49:20 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:38327 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S263021AbVHENtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:49:18 -0400
Subject: Re: lockups with netconsole on e1000 on media insertion
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       John =?ISO-8859-1?Q?B=E4ckstrand?= <sandos@home.se>
In-Reply-To: <p73ek987gjw.fsf@bragg.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
	 <p73ek987gjw.fsf@bragg.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 09:49:03 -0400
Message-Id: <1123249743.18332.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 13:45 +0200, Andi Kleen wrote:
> John Bäckstrand <sandos@home.se> writes:
> 
> > I've been trying to hunt down a hard lockup issue with some hardware
> > of mine, but I've possibly hit a kernel bug instead. When using
> > netconsole on my e1000, if I unplug the cable and then re-plug it, the
> > machine locks up hard. It manages to print the "link up" message on
> > the screen, but nothing after that. Now, I wonder if this is supposed
> > to be so? I tried this on 4 different configurations, 2.6.13-rc5 and
> > 2.6.12 with and without "noapic acpi=off", same result on all of
> > them. I've tried with 1 and 3 other NICs in the machine at the same
> > time.
> 
> I ran into the same problem some time ago on e1000. The problem was
> that if the link doesn't come up netconsole ends up waiting forever
> for it.
> 
> The patch was for 2.6.12, did a quick untested port to 2.6.13rc5.
> 
> -Andi
> 
> Only try a limited number to send packets in netpoll
> 
> Avoids hangs on e1000 when link is not up.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/net/core/netpoll.c
> ===================================================================
> --- linux.orig/net/core/netpoll.c
> +++ linux/net/core/netpoll.c
> @@ -247,9 +247,11 @@ static void netpoll_send_skb(struct netp
>  {
>  	int status;
>  	struct netpoll_info *npinfo;
> +	/* Only try 5 times in case the link is down etc. */
> +	int try = 5;
>  
>  repeat:
> -	if(!np || !np->dev || !netif_running(np->dev)) {
> +	if(try-- == 0 || !np || !np->dev || !netif_running(np->dev)) {
>  		__kfree_skb(skb);
>  		return;
>  	}
> @@ -286,6 +288,9 @@ repeat:
>  
>  	/* transmit busy */
>  	if(status) {
> +		/* Don't count spinlock as try */
> +		if (status == NETDEV_TX_LOCKED)
> +			try++; 
>  		netpoll_poll(np);
>  		goto repeat;
>  	}
> -

This is fixing the symptom and is not the cure.  Unfortunately I don't
have a e1000 card so I can't try a fix. But I did have a e100 card that
would lock up the same way.  The problem was that netpoll_poll calls the
cards netpoll routine (in e1000_main.c e1000_netpoll).  In the e100
case, when the transmit buffer would fill up, the queue would go down.
But the netpoll routine in the e100 code never put it back up after it
was all transfered. So this would lock up the kernel when that happened.

I believe that the e1000 is suffering the same problem, but I can't fix
it since I don't have an e1000 to test, but what probably needs to be
done is to check to see if the transmit buffer can be cleaned and the
queue go back up.

e1000_netpoll calls e1000_intr which looks like this:

static irqreturn_t
e1000_intr(int irq, void *data, struct pt_regs *regs)
{
	struct net_device *netdev = data;
	struct e1000_adapter *adapter = netdev_priv(netdev);
	struct e1000_hw *hw = &adapter->hw;
	uint32_t icr = E1000_READ_REG(hw, ICR);
#ifndef CONFIG_E1000_NAPI
	unsigned int i;
#endif

	if(unlikely(!icr))
		return IRQ_NONE;  /* Not our interrupt */

^^^^^^^^
---- Here I'm wondering if the netpoll case this is returned?


	if(unlikely(icr & (E1000_ICR_RXSEQ | E1000_ICR_LSC))) {
		hw->get_link_status = 1;
		mod_timer(&adapter->watchdog_timer, jiffies);
	}

#ifdef CONFIG_E1000_NAPI
	if(likely(netif_rx_schedule_prep(netdev))) {

		/* Disable interrupts and register for poll. The flush 
		  of the posted write is intentionally left out.
		*/

		atomic_inc(&adapter->irq_sem);
		E1000_WRITE_REG(hw, IMC, ~0);
		__netif_rx_schedule(netdev);
	}
#else
	/* Writing IMC and IMS is needed for 82547.
	   Due to Hub Link bus being occupied, an interrupt
	   de-assertion message is not able to be sent.
	   When an interrupt assertion message is generated later,
	   two messages are re-ordered and sent out.
	   That causes APIC to think 82547 is in de-assertion
	   state, while 82547 is in assertion state, resulting
	   in dead lock. Writing IMC forces 82547 into
	   de-assertion state.
	*/
	if(hw->mac_type == e1000_82547 || hw->mac_type == e1000_82547_rev_2){
		atomic_inc(&adapter->irq_sem);
		E1000_WRITE_REG(hw, IMC, ~0);
	}

	for(i = 0; i < E1000_MAX_INTR; i++)
		if(unlikely(!adapter->clean_rx(adapter) &
		   !e1000_clean_tx_irq(adapter)))
^^^^^
----  This should clean the transmit buffer, but it may not get here.

			break;

	if(hw->mac_type == e1000_82547 || hw->mac_type == e1000_82547_rev_2)
		e1000_irq_enable(adapter);
#endif

	return IRQ_HANDLED;
}



So maybe the patch should be something like:

--- linux-2.6.13-rc3/drivers/net/e1000/e1000_main.c.orig	2005-08-05 09:32:01.000000000 -0400
+++ linux-2.6.13-rc3/drivers/net/e1000/e1000_main.c	2005-08-05 09:33:56.000000000 -0400
@@ -3816,6 +3816,7 @@ e1000_netpoll(struct net_device *netdev)
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	disable_irq(adapter->pdev->irq);
 	e1000_intr(adapter->pdev->irq, netdev, NULL);
+	e1000_clean_tx_irq(adapter);
 	enable_irq(adapter->pdev->irq);
 }
 #endif


I don't have the card, so I can't test it. But if this works (after
removing the previous patch) then this is the better solution.  If this
does work, then we should probably add the timeout in netpoll with a
warning that the netpoll of the driver is broken:

Here's a modified version of the other patch: So we know where the
problem is.

#### John, Delete this part if you apply the above. ####

--- linux-2.6.13-rc3/net/core/netpoll.c.orig	2005-08-05 09:37:00.000000000 -0400
+++ linux-2.6.13-rc3/net/core/netpoll.c	2005-08-05 09:44:19.000000000 -0400
@@ -247,9 +247,14 @@ static void netpoll_send_skb(struct netp
 {
 	int status;
 	struct netpoll_info *npinfo;
+	/* only try five times incase link is down */
+	int try=5;
 
 repeat:
-	if(!np || !np->dev || !netif_running(np->dev)) {
+	if(try-- == 0 || !np || !np->dev || !netif_running(np->dev)) {
+		if (!try)
+			printk(KERN_WARNING "net driver is stuck down, maybe a"
+					" problem with the driver's netpoll\n");
 		__kfree_skb(skb);
 		return;
 	}
@@ -286,6 +291,9 @@ repeat:
 
 	/* transmit busy */
 	if(status) {
+		/* Don't count spinlock as try */
+		if (status == NETDEV_TX_LOCKED)
+			try++;
 		netpoll_poll(np);
 		goto repeat;
 	}


-- Steve


