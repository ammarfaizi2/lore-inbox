Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUF1RCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUF1RCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 13:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUF1RCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 13:02:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24257 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265094AbUF1RAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 13:00:36 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16608.20014.220537.339589@segfault.boston.redhat.com>
Date: Mon, 28 Jun 2004 12:58:22 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
In-Reply-To: <20040628151954.GH25826@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com>
	<20040425191543.GV28459@waste.org>
	<16527.42815.447695.474344@segfault.boston.redhat.com>
	<20040428140353.GC28459@waste.org>
	<16527.47765.286783.249944@segfault.boston.redhat.com>
	<20040428142753.GE28459@waste.org>
	<16527.63123.869014.733258@segfault.boston.redhat.com>
	<16604.18881.850162.785970@segfault.boston.redhat.com>
	<20040625232711.GE25826@waste.org>
	<16608.12233.39964.940020@segfault.boston.redhat.com>
	<20040628151954.GH25826@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

mpm> On Mon, Jun 28, 2004 at 10:48:41AM -0400, Jeff Moyer wrote:
>> ==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall
>> <mpm@selenic.com> adds:
>> 
>> [snip]
>> 
mpm> Huh. I'm not sure if that covers everything.
>>
mpm> We want to:
>>
mpm> a) push stuff through netpoll_rx() iff rx is enabled b) drop packets
mpm> when netpoll_rx() says to c) drop packets when we're trapped for
mpm> debugging/netdump d) drop packets when we manually call dev->poll e)
mpm> keep as little overhead as possible
>>
mpm> The above breaks (a) when we're not trapped (consider breaking in with
mpm> debugger) and (b) in any case.
>>
mpm> My current thought is we want to get this down to a single test in the
mpm> fastpath by replacing netpoll_rx in skb->dev with a flag that is equal
mpm> to netpoll_trapped() | dev->netpoll_rx, which we manipulate when call
dev-> poll within netpoll.
>>
mpm> How's that sound?
>> That sounds fine.  So, in the netif_receive_skb function, we'd now have
>> something like:
>> 
>> if (skb->dev->netpoll_rx && netpoll_rx(skb)) { kfree_skb(skb); return
>> NET_RX_DROP; }
>> 
>> I removed the test for skb->dev->poll, since this is the NAPI code path,
>> I think it should always be present, right?

mpm> No, I think we get to this on the non-NAPI route as well. The ->poll
mpm> check keeps us from filtering twice.

I'll have to take your word for it on this one, as I can't find a way into
this code for the non-napi case.  Would anyone care to give an
authoritative answer on this?

>> And then at the top of the netpoll_rx routine:
>> 
>> if (!(skb->dev->netpoll_rx & NETPOLL_RX_ENABLED)) goto out;

mpm> Let's explicitly return 1.

Ahh, yes, that makes things much more clear.
 
>> The routine, as before, returns the value of trapped.  And now,
>> netpoll_poll would do this:
>> 
>> if(np->dev->poll && test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
np-> dev->netpoll_rx |= NETPOLL_RX_TRAPPED;
>> if (trapped)
np-> dev->poll(np->dev, &budget);
>> else { trapped = 1;
np-> dev->poll(np->dev, &budget);
>> trapped = 0; }
np-> dev->netpoll_rx &= ~NETPOLL_RX_TRAPPED;
>> }
>> 
>> Is this more in line with what you had in mind?

mpm> Yes. Let's make that NETPOLL_RX_DROP to disambiguate the
mpm> trapped/dropped-for-polling. And we can do a simple
mpm> increment/decrement on trapped itself - but do we still need it here
mpm> now that we've shorted out the NAPI path with RX_DROP?

Right.  The code becomes much cleaner with this change (we don't need to
increment/decrement trapped).

mpm> There might be some new atomicity or memory barrier issues here, be
mpm> mindful.

I'll think about this some more.

>> One thing I would consider changing, here, is having netpoll_set_trap
>> take a struct netpoll argument. That way, we could have netpoll_set_trap
>> manipulate the NETPOLL_RX_TRAPPED bit. This would make the trap specific
>> to each interface, but I think that may be desirable.

mpm> It doesn't really make sense for trapped to be non-global - it means
mpm> the machine is in polling-only mode, eg debugger or the like. It's
mpm> rather misusing it to kill the NAPI receive side for netpoll_poll.

Fair enough.  Attached is a patch with these changes.  I've removed
CONFIG_NETPOLL_RX as it no longer seems useful.  Let me know what you
think.

One other thing we might consider is adding a call to touch_nmi_watchdog()
to zap_completion_queue.

Thanks!

Jeff

--- linux-2.6.7/arch/sparc64/defconfig.orig	2004-06-28 12:37:24.000000000 -0400
+++ linux-2.6.7/arch/sparc64/defconfig	2004-06-28 12:37:27.000000000 -0400
@@ -705,7 +705,6 @@
 #
 CONFIG_NET_PKTGEN=m
 CONFIG_NETPOLL=y
-# CONFIG_NETPOLL_RX is not set
 # CONFIG_NETPOLL_TRAP is not set
 CONFIG_NET_POLL_CONTROLLER=y
 CONFIG_HAMRADIO=y
--- linux-2.6.7/arch/ia64/configs/sn2_defconfig.orig	2004-06-28 12:37:50.000000000 -0400
+++ linux-2.6.7/arch/ia64/configs/sn2_defconfig	2004-06-28 12:37:53.000000000 -0400
@@ -636,7 +636,6 @@
 #
 # CONFIG_BT is not set
 CONFIG_NETPOLL=y
-# CONFIG_NETPOLL_RX is not set
 # CONFIG_NETPOLL_TRAP is not set
 CONFIG_NET_POLL_CONTROLLER=y
 
--- linux-2.6.7/arch/ppc64/configs/pSeries_defconfig.orig	2004-06-28 12:39:00.000000000 -0400
+++ linux-2.6.7/arch/ppc64/configs/pSeries_defconfig	2004-06-28 12:39:03.000000000 -0400
@@ -544,7 +544,6 @@
 #
 # CONFIG_BT is not set
 CONFIG_NETPOLL=y
-CONFIG_NETPOLL_RX=y
 CONFIG_NETPOLL_TRAP=y
 CONFIG_NET_POLL_CONTROLLER=y
 
--- linux-2.6.7/arch/ppc64/configs/iSeries_defconfig.orig	2004-06-28 12:39:19.000000000 -0400
+++ linux-2.6.7/arch/ppc64/configs/iSeries_defconfig	2004-06-28 12:39:23.000000000 -0400
@@ -358,7 +358,6 @@
 #
 # CONFIG_NET_PKTGEN is not set
 CONFIG_NETPOLL=y
-CONFIG_NETPOLL_RX=y
 CONFIG_NETPOLL_TRAP=y
 CONFIG_NET_POLL_CONTROLLER=y
 # CONFIG_HAMRADIO is not set
--- linux-2.6.7/arch/ppc64/defconfig.orig	2004-06-28 12:40:06.000000000 -0400
+++ linux-2.6.7/arch/ppc64/defconfig	2004-06-28 12:40:08.000000000 -0400
@@ -544,8 +544,7 @@
 #
 # CONFIG_BT is not set
 CONFIG_NETPOLL=y
-CONFIG_NETPOLL_RX=y
 CONFIG_NETPOLL_TRAP=y
 CONFIG_NET_POLL_CONTROLLER=y
 
--- linux-2.6.7/arch/x86_64/defconfig.orig	2004-06-28 12:40:21.000000000 -0400
+++ linux-2.6.7/arch/x86_64/defconfig	2004-06-28 12:40:24.000000000 -0400
@@ -399,7 +399,6 @@
 #
 # CONFIG_NET_PKTGEN is not set
 CONFIG_NETPOLL=y
-# CONFIG_NETPOLL_RX is not set
 # CONFIG_NETPOLL_TRAP is not set
 CONFIG_NET_POLL_CONTROLLER=y
 # CONFIG_HAMRADIO is not set
--- linux-2.6.7/include/linux/netdevice.h.orig	2004-06-28 12:05:36.000000000 -0400
+++ linux-2.6.7/include/linux/netdevice.h	2004-06-28 12:13:36.000000000 -0400
@@ -459,7 +459,7 @@
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	int			netpoll_rx;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
--- linux-2.6.7/net/core/dev.c.orig	2004-06-28 12:05:22.000000000 -0400
+++ linux-2.6.7/net/core/dev.c	2004-06-28 12:40:52.000000000 -0400
@@ -1575,7 +1575,7 @@
 	struct softnet_data *queue;
 	unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
@@ -1737,7 +1737,7 @@
 	int ret = NET_RX_DROP;
 	unsigned short type;
 
-#ifdef CONFIG_NETPOLL_RX
+#ifdef CONFIG_NETPOLL
 	if (skb->dev->netpoll_rx && skb->dev->poll && netpoll_rx(skb)) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
--- linux-2.6.7/net/core/netpoll.c.orig	2004-06-28 12:05:28.000000000 -0400
+++ linux-2.6.7/net/core/netpoll.c	2004-06-28 12:11:45.000000000 -0400
@@ -29,6 +29,9 @@
 #define MAX_SKBS 32
 #define MAX_UDP_CHUNK 1460
 
+#define NETPOLL_RX_ENABLED  1
+#define NETPOLL_RX_DROP     2
+
 static spinlock_t skb_list_lock = SPIN_LOCK_UNLOCKED;
 static int nr_skbs;
 static struct sk_buff *skbs;
@@ -70,9 +73,12 @@
 	np->dev->poll_controller(np->dev);
 
 	/* If scheduling is stopped, tickle NAPI bits */
-	if(trapped && np->dev->poll &&
-	   test_bit(__LINK_STATE_RX_SCHED, &np->dev->state))
+	if (np->dev->poll && 
+	    test_bit(__LINK_STATE_RX_SCHED, &np->dev->state)) {
+		np->dev->netpoll_rx |= NETPOLL_RX_DROP;
 		np->dev->poll(np->dev, &budget);
+		np->dev->netpoll_rx &= ~NETPOLL_RX_DROP;
+	}
 	zap_completion_queue();
 }
 
@@ -333,6 +339,9 @@
 	struct list_head *p;
 	unsigned long flags;
 
+	if (!(skb->dev->netpoll_rx & NETPOLL_RX_ENABLED))
+		return 1;
+
 	if (skb->dev->type != ARPHRD_ETHER)
 		goto out;
 
@@ -591,10 +600,7 @@
 	if(np->rx_hook) {
 		unsigned long flags;
 
-#ifdef CONFIG_NETPOLL_RX
-		np->dev->netpoll_rx = 1;
-#endif
-
+		np->dev->netpoll_rx = NETPOLL_RX_ENABLED;
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_add(&np->rx_list, &rx_list);
 		spin_unlock_irqrestore(&rx_list_lock, flags);
@@ -613,9 +619,7 @@
 
 		spin_lock_irqsave(&rx_list_lock, flags);
 		list_del(&np->rx_list);
-#ifdef CONFIG_NETPOLL_RX
-		np->dev->netpoll_rx = 0;
-#endif
+		np->dev->netpoll_rx &= ~NETPOLL_RX_ENABLED;
 		spin_unlock_irqrestore(&rx_list_lock, flags);
 	}
 
