Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVFVVQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVFVVQg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 17:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVFVVNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 17:13:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262310AbVFVVFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:05:20 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.53899.201190.106025@segfault.boston.redhat.com>
Date: Wed, 22 Jun 2005 17:05:15 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: netdev@oss.sgi.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch,rfc] allow registration of multiple netpolls per interface
In-Reply-To: <20050622170128.GV27572@waste.org>
References: <17080.35214.507402.998984@segfault.boston.redhat.com>
	<20050621225252.GY27572@waste.org>
	<17081.20441.714191.528270@segfault.boston.redhat.com>
	<20050622170128.GV27572@waste.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch,rfc] allow registration of multiple netpolls per interface; Matt Mackall <mpm@selenic.com> adds:

mpm> On Wed, Jun 22, 2005 at 07:47:37AM -0400, Jeff Moyer wrote:
mpm> Hmm. It's conceivable we'll want netdump and kgdb on the same
mpm> interface so we'll have to address this eventually..
>> 
>> Well, do you want to address it eventually, or now?  As I said, it's never
>> bitten anyone before.

mpm> Later's fine. I just don't want to design it out by accident again.
 
OK.

>> >> struct netpoll_info {
>> >>         spinlock_t poll_lock;
>> >>         int poll_owner;
>> >>         int rx_flags;
>> >>         spinlock_t rx_lock;
>> >>         struct netpoll *rx_np; /* netpoll that registered an rx_hook */
>> >> };

[snip]

mpm> It might be simpler to have a single lock here..?
>> 
>> Maybe.  You can't really have netpoll code running on multiple cpus at the
>> same time, right?  This is the rx path, remember, so the other cpu should
>> be spinning on the poll_lock.
>> 
>> Keeping separate locks would allow you to unregister a struct netpoll
>> associated with another net device without causing lock contention.  This
>> is a very minor win, obviously.
>> 
>> I still feel like this npinfo struct is the right place for this, though.
>> If you're strongly opposed to that, I'll change it.

mpm> No, certainly having it in npinfo makes sense. I just was wondering if
mpm> we really need two locks in there.

Oh, I misunderstood.  Well, one protects recursing into the driver's poll
routine, the other protects access to the np_rx pointer, which may later
become a list.  I don't think we can lump these two together, do you?

>> >> +	spin_lock_irqsave(&npinfo->rx_lock, flags);
>> >> +	if (npinfo->rx_np->dev == skb->dev)
>> >> +		np = npinfo->rx_np;
>> >> +	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
>> 
mpm> And I think that means we don't need the lock here either.  
>> 
>> Sure we do.  We need to protect against rmmod's.

mpm> How can we have an rmmmod when we're trapped?

Looking over the code, I don't see what would prevent this.  Could you
point me the code which prevents this?

It's a good thing we're discussing it, since I found that I didn't take the
lock in netpoll_cleanup.


Okay, so here's the full patch again, with the changes we've discussed.
I've also included an interdiff.  As you can see, the first version I sent
didn't have some basic compile fixes, sorry about that.  Anyway, I have
booted and tested this version with multiple netpoll clients.

Barring any negative feedback, I'll break this up and send it as a patch
series.

Thanks,

Jeff

(Interdiff first)

diff -u linux-2.6.12-rc6/net/core/netpoll.c linux-2.6.12-rc6/net/core/netpoll.c
--- linux-2.6.12-rc6/net/core/netpoll.c	2005-06-21 16:03:22.409620400 -0400
+++ linux-2.6.12-rc6/net/core/netpoll.c	2005-06-22 16:51:24.336062231 -0400
@@ -130,8 +130,8 @@
  */
 static void poll_napi(struct netpoll *np)
 {
-	int budget = 16;
 	struct netpoll_info *npinfo = np->dev->npinfo;
+	int budget = 16;
 
 	if (test_bit(__LINK_STATE_RX_SCHED, &np->dev->state) &&
 	    npinfo->poll_owner != smp_processor_id() &&
@@ -344,22 +344,22 @@
 
 static void arp_reply(struct sk_buff *skb)
 {
+	struct netpoll_info *npinfo = skb->dev->npinfo;
 	struct arphdr *arp;
 	unsigned char *arp_ptr;
 	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
 	u32 sip, tip;
+	unsigned long flags;
 	struct sk_buff *send_skb;
-	struct netpoll *np;
-	struct netpoll_info *npinfo = skb->dev->npinfo;
-
-	if (!npinfo) return;
+	struct netpoll *np = NULL;
 
 	spin_lock_irqsave(&npinfo->rx_lock, flags);
-	if (npinfo->rx_np->dev == skb->dev)
+	if (npinfo->rx_np && npinfo->rx_np->dev == skb->dev)
 		np = npinfo->rx_np;
 	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
 
-	if (!np) return;
+	if (!np)
+		return;
 
 	/* No arp on this interface */
 	if (skb->dev->flags & IFF_NOARP)
@@ -716,7 +716,7 @@
 		spin_lock_irqsave(&npinfo->rx_lock, flags);
 		npinfo->rx_flags |= NETPOLL_RX_ENABLED;
 		npinfo->rx_np = np;
-		spin_unlock_irqsave(&npinfo->rx_lock, flags);
+		spin_unlock_irqrestore(&npinfo->rx_lock, flags);
 	}
 	/* last thing to do is link it to the net device structure */
 	ndev->npinfo = npinfo;
@@ -734,12 +734,15 @@
 void netpoll_cleanup(struct netpoll *np)
 {
 	struct netpoll_info *npinfo;
+	unsigned long flags;
 
 	if (np->dev) {
 		npinfo = np->dev->npinfo;
 		if (npinfo && npinfo->rx_np == np) {
+			spin_lock_irqsave(&npinfo->rx_lock, flags);
 			npinfo->rx_np = NULL;
 			npinfo->rx_flags &= ~NETPOLL_RX_ENABLED;
+			spin_unlock_irqrestore(&npinfo->rx_lock, flags);
 		}
 		dev_put(np->dev);
 	}
reverted:
--- linux-2.6.12-rc6/net/core/dev.c	2005-06-21 13:53:51.583407710 -0400
+++ linux-2.6.12-rc6/net/core/dev.c.orig	2005-06-20 19:51:59.000000000 -0400
@@ -1656,7 +1656,6 @@
 	unsigned short type;
 
 	/* if we've gotten here through NAPI, check netpoll */
-	/* how else can we get here?  --phro */
 	if (skb->dev->poll && netpoll_rx(skb))
 		return NET_RX_DROP;
 


And now, the full diff:

--- linux-2.6.12-rc6/net/core/netpoll.c.orig	2005-06-20 19:51:56.000000000 -0400
+++ linux-2.6.12-rc6/net/core/netpoll.c	2005-06-22 16:51:24.336062231 -0400
@@ -130,19 +130,20 @@ static int checksum_udp(struct sk_buff *
  */
 static void poll_napi(struct netpoll *np)
 {
+	struct netpoll_info *npinfo = np->dev->npinfo;
 	int budget = 16;
 
 	if (test_bit(__LINK_STATE_RX_SCHED, &np->dev->state) &&
-	    np->poll_owner != smp_processor_id() &&
-	    spin_trylock(&np->poll_lock)) {
-		np->rx_flags |= NETPOLL_RX_DROP;
+	    npinfo->poll_owner != smp_processor_id() &&
+	    spin_trylock(&npinfo->poll_lock)) {
+		npinfo->rx_flags |= NETPOLL_RX_DROP;
 		atomic_inc(&trapped);
 
 		np->dev->poll(np->dev, &budget);
 
 		atomic_dec(&trapped);
-		np->rx_flags &= ~NETPOLL_RX_DROP;
-		spin_unlock(&np->poll_lock);
+		npinfo->rx_flags &= ~NETPOLL_RX_DROP;
+		spin_unlock(&npinfo->poll_lock);
 	}
 }
 
@@ -245,6 +246,7 @@ repeat:
 static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 {
 	int status;
+	struct netpoll_info *npinfo;
 
 repeat:
 	if(!np || !np->dev || !netif_running(np->dev)) {
@@ -253,7 +255,8 @@ repeat:
 	}
 
 	/* avoid recursion */
-	if(np->poll_owner == smp_processor_id() ||
+	npinfo = np->dev->npinfo;
+	if(npinfo->poll_owner == smp_processor_id() ||
 	   np->dev->xmit_lock_owner == smp_processor_id()) {
 		if (np->drop)
 			np->drop(skb);
@@ -341,14 +344,22 @@ void netpoll_send_udp(struct netpoll *np
 
 static void arp_reply(struct sk_buff *skb)
 {
+	struct netpoll_info *npinfo = skb->dev->npinfo;
 	struct arphdr *arp;
 	unsigned char *arp_ptr;
 	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
 	u32 sip, tip;
+	unsigned long flags;
 	struct sk_buff *send_skb;
-	struct netpoll *np = skb->dev->np;
+	struct netpoll *np = NULL;
+
+	spin_lock_irqsave(&npinfo->rx_lock, flags);
+	if (npinfo->rx_np && npinfo->rx_np->dev == skb->dev)
+		np = npinfo->rx_np;
+	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
 
-	if (!np) return;
+	if (!np)
+		return;
 
 	/* No arp on this interface */
 	if (skb->dev->flags & IFF_NOARP)
@@ -429,9 +440,9 @@ int __netpoll_rx(struct sk_buff *skb)
 	int proto, len, ulen;
 	struct iphdr *iph;
 	struct udphdr *uh;
-	struct netpoll *np = skb->dev->np;
+	struct netpoll *np = skb->dev->npinfo->rx_np;
 
-	if (!np->rx_hook)
+	if (!np)
 		goto out;
 	if (skb->dev->type != ARPHRD_ETHER)
 		goto out;
@@ -611,9 +622,8 @@ int netpoll_setup(struct netpoll *np)
 {
 	struct net_device *ndev = NULL;
 	struct in_device *in_dev;
-
-	np->poll_lock = SPIN_LOCK_UNLOCKED;
-	np->poll_owner = -1;
+	struct netpoll_info *npinfo;
+	unsigned long flags;
 
 	if (np->dev_name)
 		ndev = dev_get_by_name(np->dev_name);
@@ -624,7 +634,17 @@ int netpoll_setup(struct netpoll *np)
 	}
 
 	np->dev = ndev;
-	ndev->np = np;
+	if (!ndev->npinfo) {
+		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
+		if (!npinfo)
+			goto release;
+
+		npinfo->rx_np = NULL;
+		npinfo->poll_lock = SPIN_LOCK_UNLOCKED;
+		npinfo->poll_owner = -1;
+		npinfo->rx_lock = SPIN_LOCK_UNLOCKED;
+	} else
+		npinfo = ndev->npinfo;
 
 	if (!ndev->poll_controller) {
 		printk(KERN_ERR "%s: %s doesn't support polling, aborting.\n",
@@ -692,13 +712,20 @@ int netpoll_setup(struct netpoll *np)
 		       np->name, HIPQUAD(np->local_ip));
 	}
 
-	if(np->rx_hook)
-		np->rx_flags = NETPOLL_RX_ENABLED;
+	if(np->rx_hook) {
+		spin_lock_irqsave(&npinfo->rx_lock, flags);
+		npinfo->rx_flags |= NETPOLL_RX_ENABLED;
+		npinfo->rx_np = np;
+		spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+	}
+	/* last thing to do is link it to the net device structure */
+	ndev->npinfo = npinfo;
 
 	return 0;
 
  release:
-	ndev->np = NULL;
+	if (!ndev->npinfo)
+		kfree(npinfo);
 	np->dev = NULL;
 	dev_put(ndev);
 	return -1;
@@ -706,9 +733,20 @@ int netpoll_setup(struct netpoll *np)
 
 void netpoll_cleanup(struct netpoll *np)
 {
-	if (np->dev)
-		np->dev->np = NULL;
-	dev_put(np->dev);
+	struct netpoll_info *npinfo;
+	unsigned long flags;
+
+	if (np->dev) {
+		npinfo = np->dev->npinfo;
+		if (npinfo && npinfo->rx_np == np) {
+			spin_lock_irqsave(&npinfo->rx_lock, flags);
+			npinfo->rx_np = NULL;
+			npinfo->rx_flags &= ~NETPOLL_RX_ENABLED;
+			spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+		}
+		dev_put(np->dev);
+	}
+
 	np->dev = NULL;
 }
 
--- linux-2.6.12-rc6/include/linux/netpoll.h.orig	2005-06-20 19:51:47.000000000 -0400
+++ linux-2.6.12-rc6/include/linux/netpoll.h	2005-06-21 15:29:48.000000000 -0400
@@ -16,14 +16,19 @@ struct netpoll;
 struct netpoll {
 	struct net_device *dev;
 	char dev_name[16], *name;
-	int rx_flags;
 	void (*rx_hook)(struct netpoll *, int, char *, int);
 	void (*drop)(struct sk_buff *skb);
 	u32 local_ip, remote_ip;
 	u16 local_port, remote_port;
 	unsigned char local_mac[6], remote_mac[6];
+};
+
+struct netpoll_info {
 	spinlock_t poll_lock;
 	int poll_owner;
+	int rx_flags;
+	spinlock_t rx_lock;
+	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
 };
 
 void netpoll_poll(struct netpoll *np);
@@ -39,22 +44,35 @@ void netpoll_queue(struct sk_buff *skb);
 #ifdef CONFIG_NETPOLL
 static inline int netpoll_rx(struct sk_buff *skb)
 {
-	return skb->dev->np && skb->dev->np->rx_flags && __netpoll_rx(skb);
+	struct netpoll_info *npinfo = skb->dev->npinfo;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!npinfo || (!npinfo->rx_np && !npinfo->rx_flags))
+		return 0;
+
+	spin_lock_irqsave(&npinfo->rx_lock, flags);
+	/* check rx_flags again with the lock held */
+	if (npinfo->rx_flags && __netpoll_rx(skb))
+		ret = 1;
+	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
+
+	return ret;
 }
 
 static inline void netpoll_poll_lock(struct net_device *dev)
 {
-	if (dev->np) {
-		spin_lock(&dev->np->poll_lock);
-		dev->np->poll_owner = smp_processor_id();
+	if (dev->npinfo) {
+		spin_lock(&dev->npinfo->poll_lock);
+		dev->npinfo->poll_owner = smp_processor_id();
 	}
 }
 
 static inline void netpoll_poll_unlock(struct net_device *dev)
 {
-	if (dev->np) {
-		spin_unlock(&dev->np->poll_lock);
-		dev->np->poll_owner = -1;
+	if (dev->npinfo) {
+		dev->npinfo->poll_owner = -1;
+		spin_unlock(&dev->npinfo->poll_lock);
 	}
 }
 
--- linux-2.6.12-rc6/include/linux/netdevice.h.orig	2005-06-20 20:26:21.000000000 -0400
+++ linux-2.6.12-rc6/include/linux/netdevice.h	2005-06-21 14:46:52.000000000 -0400
@@ -41,7 +41,7 @@
 struct divert_blk;
 struct vlan_group;
 struct ethtool_ops;
-struct netpoll;
+struct netpoll_info;
 					/* source back-compat hooks */
 #define SET_ETHTOOL_OPS(netdev,ops) \
 	( (netdev)->ethtool_ops = (ops) )
@@ -468,7 +468,7 @@ struct net_device
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 #ifdef CONFIG_NETPOLL
-	struct netpoll		*np;
+	struct netpoll_info	*npinfo;
 #endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	void                    (*poll_controller)(struct net_device *dev);
