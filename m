Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUHLVHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUHLVHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268798AbUHLVGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:06:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3554 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268799AbUHLVD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:03:27 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16667.55966.317888.504243@segfault.boston.redhat.com>
Date: Thu, 12 Aug 2004 17:01:18 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>,
       jgarzik@pobox.com
Subject: Re: [patch] fix netconsole hang with alt-sysrq-t
In-Reply-To: <20040806202649.GE16310@waste.org>
References: <16659.56343.686372.724218@segfault.boston.redhat.com>
	<20040806195237.GC16310@waste.org>
	<16659.58271.979999.616045@segfault.boston.redhat.com>
	<20040806202649.GE16310@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

mpm> On Fri, Aug 06, 2004 at 04:01:35PM -0400, Jeff Moyer wrote:
>> ==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt
>> Mackall <mpm@selenic.com> adds:
>> 
mpm> On Fri, Aug 06, 2004 at 03:29:27PM -0400, Jeff Moyer wrote:
>> >> Hi, Matt,
>> >> 
>> >> Here's the patch.  Sorry it took me so long, been busy with other
>> work.  >> Two things which need perhaps more thinking, can netpoll_poll
>> be called >> recursively (it didn't look like it to me)
>> 
mpm> It can if the poll function does a printk or the like and wants to
mpm> recurse via netconsole. We could short-circuit that with an in_netpoll
mpm> flag, but let's worry about that separately.

So how do you want to deal with this case?  We could do something like:

	int cpu = smp_processor_id();

	local_irq_save(flags);
	if (!spin_trylock(&netpoll_poll_lock)) {
		/* allow recursive calls on this cpu */
		if (cpu != poll_owner)
			spin_lock(&netpoll_poll_lock);
	}
	poll_owner = cpu;

	...

	poll_owner = -1;
	spin_unlock(&netpoll_poll_lock);
	local_irq_restore(flags);

>> >> and do we care about the racy >> nature of the netpoll_set_trap
>> interface?
>> 
mpm> That should probably become an atomic now.
>> Ouch.  I wanted to avoid that, but if we can't, we can't.  Will
>> netpoll_set_trap then to an atomic_inc or an atomic_add?  I've only seen
>> it called with 1 and 0, is that all that was intended?

mpm> It's a boolean interface. We might switch from set(bool) to
mpm> enable()/disable(). More thought required.
 
>> >> You'll notice that I reverted part of an earlier changeset which
>> caused us >> to call the hard_start_xmit function even if
>> netif_queue_stopped returned >> true.  This is a bug.  I preserved the
>> second part of that patch, which was >> correct.
>> 
mpm> Ok, jgarzik pointed that out to me just a bit ago. I'm not sure if
mpm> we're dealing with the behavior that was intended to address yet
mpm> though. Stelian, can you try giving this a spin?
>> Well, we kept the second part of the patch, which deals with the
>> hard_start_xmit routine returning 1.  That was a valid bug, I believe.

mpm> Probably, but it's hairy enough that I'm not entirely convinced we've
mpm> solved the particular problem.

>> Yah, and I just noticed we don't want the poll_lock to be per struct
>> netpoll.  It should be a static lock in the netpoll.c file.  The problem
>> is that more than one netpoll object can reference the same ethernet
>> device.

mpm> Good catch. My original design stuck pointers to the netpoll objects
mpm> in the net device and then I switched to allowing multiples and didn't
mpm> fix that bit.

Okay, Matt, here is another take which converts trapped to an atomic, and
moves the poll_lock out of the netdevice structure.  I'm keeping the change
to check for netif_queue_stopped as things are not happy without that
patch.  Jeff, would you mind commenting on why that is correct, please?
It's this hunk here:

@@ -168,6 +180,14 @@
 	spin_lock(&np->dev->xmit_lock);
 	np->dev->xmit_lock_owner = smp_processor_id();
 
+	if (netif_queue_stopped(np->dev)) {
+		np->dev->xmit_lock_owner = -1;
+		spin_unlock(&np->dev->xmit_lock);
+
+		netpoll_poll(np);
+		goto repeat;
+	}
+

Without this test, we would go ahead and call hard_start_xmit even though
the queue was stopped.

Thanks!

Jeff

--- linux-2.6.7/include/linux/netdevice.h.orig	2004-08-06 13:01:39.000000000 -0400
+++ linux-2.6.7/include/linux/netdevice.h	2004-08-06 13:01:41.000000000 -0400
@@ -462,7 +462,7 @@
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	int			netpoll_rx;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
--- linux-2.6.7/net/core/netpoll.c.orig	2004-08-06 11:13:45.000000000 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-08-12 16:32:04.151624208 -0400
@@ -36,7 +36,11 @@
 static spinlock_t rx_list_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(rx_list);
 
-static int trapped;
+static atomic_t trapped;
+spinlock_t netpoll_poll_lock = SPIN_LOCK_UNLOCKED;
+
+#define NETPOLL_RX_ENABLED  1
+#define NETPOLL_RX_DROP     2
 
 #define MAX_SKB_SIZE \
 		(MAX_UDP_CHUNK + sizeof(struct udphdr) + \
@@ -61,7 +65,8 @@
 
 void netpoll_poll(struct netpoll *np)
 {
-	int budget = 1;
+	int budget = 16;
+	unsigned long flags;
 
 	if(!np->dev || !netif_running(np->dev) || !np->dev->poll_controller)
 		return;
@@ -70,9 +75,19 @@
 	np->dev->poll_controller(np->dev);
 
 	/* If scheduling is stopped, tickle NAPI bits */
-	if(trapped && np->dev->poll &&
-	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
+	spin_lock_irqsave(&netpoll_poll_lock, flags);
+	if (np->dev->poll &&
+	    test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
+		np->dev->netpoll_rx |= NETPOLL_RX_DROP;
+		atomic_inc(&trapped);
+
 		np->dev->poll(np->dev, &budget);
+
+		atomic_dec(&trapped);
+		np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
+	}
+	spin_unlock_irqrestore(&netpoll_poll_lock, flags);
+
 	zap_completion_queue();
 }
 
@@ -168,6 +183,14 @@
 	spin_lock(&np->dev->xmit_lock);
 	np->dev->xmit_lock_owner = smp_processor_id();
 
+	if (netif_queue_stopped(np->dev)) {
+		np->dev->xmit_lock_owner = -1;
+		spin_unlock(&np->dev->xmit_lock);
+
+		netpoll_poll(np);
+		goto repeat;
+	}
+
 	status = np->dev->hard_start_xmit(skb, np->dev);
 	np->dev->xmit_lock_owner = -1;
 	spin_unlock(&np->dev->xmit_lock);
@@ -337,7 +360,8 @@
 		goto out;
 
 	/* check if netpoll clients need ARP */
-	if (skb->protocol == __constant_htons(ETH_P_ARP) && trapped) {
+	if (skb->protocol == __constant_htons(ETH_P_ARP) && 
+	    atomic_read(&trapped)) {
 		arp_reply(skb);
 		return 1;
 	}
@@ -400,7 +424,7 @@
 	spin_unlock_irqrestore(&rx_list_lock, flags);
 
 out:
-	return trapped;
+	return atomic_read(&trapped);
 }
 
 int netpoll_parse_options(struct netpoll *np, char *opt)
@@ -591,9 +615,7 @@
 	if(np->rx_hook) {
 		unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
-		np->dev->netpoll_rx = 1;
-#endif
+		np->dev->netpoll_rx = NETPOLL_RX_ENABLED;
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_add(&np->rx_list, &rx_list);
@@ -613,24 +635,25 @@
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_del(&np->rx_list);
-#ifdef CONFIG_NETPOLL_RX
-		np->dev->netpoll_rx = 0;
-#endif
 		spin_unlock_irqrestore(&rx_list_lock, flags);
 	}
 
+	np->dev->netpoll_rx = 0;
 	dev_put(np->dev);
 	np->dev = NULL;
 }
 
 int netpoll_trap(void)
 {
-	return trapped;
+	return atomic_read(&trapped);
 }
 
 void netpoll_set_trap(int trap)
 {
-	trapped = trap;
+	if (trap)
+		atomic_inc(&trapped);
+	else
+		atomic_dec(&trapped);
 }
 
 EXPORT_SYMBOL(netpoll_set_trap);
--- linux-2.6.7/net/core/dev.c.orig	2004-08-06 11:13:51.000000000 -0400
+++ linux-2.6.7/net/core/dev.c	2004-08-06 13:26:28.000000000 -0400
@@ -1601,7 +1601,7 @@
 	struct softnet_data *queue;
 	unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
@@ -1805,7 +1805,7 @@
 	int ret = NET_RX_DROP;
 	unsigned short type;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && skb->dev->poll && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
--- linux-2.6.7/net/Kconfig.orig	2004-08-06 13:09:21.000000000 -0400
+++ linux-2.6.7/net/Kconfig	2004-08-06 13:09:24.000000000 -0400
@@ -656,9 +656,6 @@
 config NETPOLL
 	def_bool NETCONSOLE || KGDBOE
 
-config NETPOLL_RX
-	def_bool KGDBOE
-
 config NETPOLL_TRAP
 	def_bool KGDBOE
 
