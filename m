Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVFUW6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVFUW6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVFUW5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:57:00 -0400
Received: from waste.org ([216.27.176.166]:9892 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262439AbVFUWxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:53:10 -0400
Date: Tue, 21 Jun 2005 15:52:52 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: netdev@oss.sgi.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch,rfc] allow registration of multiple netpolls per interface
Message-ID: <20050621225252.GY27572@waste.org>
References: <17080.35214.507402.998984@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17080.35214.507402.998984@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 05:41:34PM -0400, Jeff Moyer wrote:
> Hi,
> 
> This patch restores functionality that was removed when the recursive
> ->poll bug was fixed.  Namely, it allows multiple netpoll clients to
> register against the same network interface.

Thanks. I've been neglecting this for a bit while I've been busy with
other things.
 
> In order to put things into perspective, I'm going to provide some
> background information.  So, here is how things used to work:
> 
> Multiple users of the netpoll interface could register themselves to send
> packets over the same interface.  Any number of these netpoll clients could
> register an rx_hook, as well.  However, only the very first in the list
> (hence the last one that registered), that matched the incoming interface,
> would be called when a packet arrived.  The reason for this was not design,
> it was an oversight in the implementation.  In practice, however, no one
> ever stumbled over this.  (There are more subtleties when dealing with
> multiple rx_hooks registered to the same interface, but we'll ignore these,
> since no one ever ran into such problems.)

Hmm. It's conceivable we'll want netdump and kgdb on the same
interface so we'll have to address this eventually..

> Note that each netpoll client that registered an rx_hook was put on a
> netpoll_rx_list.  This list was protected by a spinlock, and so operations
> which touched the rx routines would incur a locking penalty and a list
> traversal.  I am mentioning this because the list and associated lock were
> removed when the code was refactored, and the patches I propose will
> reintroduce the lock, but not the list.

..so we'll probably want the list back in some form. Sigh.

> Moving to what we have today:
> 
> Multiple netpoll clients can register to send packets over the same
> interface.  That's right, you can actually do this.  However, there are
> ugly side effects.  Because we now have a pointer from the net_device to a
> struct netpoll, the last netpoll client to register will be pointed to by
> the net_device->np.  What this means is that if you had two clients, the
> first registers an rx_hook and the second does not, then the netpoll code
> will not know that any device has actually registered an rx_hook (since the
> np pointer in the struct net_device is overwritten)!  As a result, no
> incoming packets will be delivered to the registered rx routine.  This is
> clearly undesirable behaviour.
> 
> So what does the patch do?
> 
> I created a new structure:
> 
> struct netpoll_info {
> 	spinlock_t poll_lock;
> 	int poll_owner;
> 	int rx_flags;
> 	spinlock_t rx_lock;
> 	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
> };
> 
> This is the structure which gets pointed to by the net_device.  All of the
> flags and locks which are specific to the INTERFACE go here.  Any variables
> which must be kept per struct netpoll were left in the struct netpoll.  So
> now, we have a cleaner separation of data and its scope.
> 
> Since we never really supported having more than one struct netpoll
> register an rx_hook, I got rid of the rx_list.  This is replaced by a
> single pointer in the netpoll_info structure (np_rx).  We still need to
> protect addition or removal of the rx_np pointer, and so keep the lock
> (rx_lock).  There is one lock per struct net_device, and I am certain that
> it will be 0 contention, as rx_np will only be changed during an insmod or
> rmmod.  If people think this would be a good rcu candidate, let me know and
> I'll change it to use that locking scheme.

It might be simpler to have a single lock here..?

> In the process of making these changes, I've fixed a couple other minor
> bugs [1].  These fixes are included in this patch, but I will break them
> out if people agree with this approach.
> 
> I have tested this by registering multiple netpoll clients, and verifying
> that they both function properly.  I have not yet tried registering an
> rx_hook, but I believe the code should be sufficient to handle that case.
> 
> And so, here is the full patch.  I'd appreciate comments.  Once we've
> reached consensus, I will resubmit as a patch series.

I think the general idea is sound. So let's take a look at the patch itself.

> Oh, and I've cc'd both netdev@oss.sgi.com and @vger.kernel.org.  Is it safe
> to just use the vger list?

Yes.

> [1] netpoll_poll_unlock unlocked and then set the poll_owner.  I've
>     reversed the order of those operations.  The netpoll_cleanup code could
>     dereference a null pointer, that was fixed by virtue of being very
>     different in the new case.

Ok, let's fix the lock ordering bit first.

> --- linux-2.6.12-rc6/net/core/netpoll.c.orig	2005-06-20 19:51:56.000000000 -0400
> +++ linux-2.6.12-rc6/net/core/netpoll.c	2005-06-21 16:03:22.409620400 -0400
> @@ -131,18 +131,19 @@ static int checksum_udp(struct sk_buff *
>  static void poll_napi(struct netpoll *np)
>  {
>  	int budget = 16;
> +	struct netpoll_info *npinfo = np->dev->npinfo;

As a minor point of style, I like to put the "get my private info"
lines first.

> @@ -245,6 +246,7 @@ repeat:
>  static void netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
>  {
>  	int status;
> +	struct netpoll_info *npinfo;
>  
>  repeat:
>  	if(!np || !np->dev || !netif_running(np->dev)) {
> @@ -253,7 +255,8 @@ repeat:
>  	}
>  
>  	/* avoid recursion */
> -	if(np->poll_owner == smp_processor_id() ||
> +	npinfo = np->dev->npinfo;

Again, the npinfo assignment ought to happen as soon as possible.

> +	if(npinfo->poll_owner == smp_processor_id() ||
>  	   np->dev->xmit_lock_owner == smp_processor_id()) {
>  		if (np->drop)
>  			np->drop(skb);
> @@ -346,7 +349,15 @@ static void arp_reply(struct sk_buff *sk
>  	int size, type = ARPOP_REPLY, ptype = ETH_P_ARP;
>  	u32 sip, tip;
>  	struct sk_buff *send_skb;
> -	struct netpoll *np = skb->dev->np;
> +	struct netpoll *np;
> +	struct netpoll_info *npinfo = skb->dev->npinfo;
> +
> +	if (!npinfo) return;

We should only be replying to ARPs if we're trapped, right? How do we
get here with npinfo unset?

The return ought to be on a separate line, btw.

> +	spin_lock_irqsave(&npinfo->rx_lock, flags);
> +	if (npinfo->rx_np->dev == skb->dev)
> +		np = npinfo->rx_np;
> +	spin_unlock_irqrestore(&npinfo->rx_lock, flags);

And I think that means we don't need the lock here either.  

>  	if (!np) return;

And the same question and style criticism of my own code.

> @@ -429,9 +440,9 @@ int __netpoll_rx(struct sk_buff *skb)
>  	int proto, len, ulen;
>  	struct iphdr *iph;
>  	struct udphdr *uh;
> -	struct netpoll *np = skb->dev->np;
> +	struct netpoll *np = skb->dev->npinfo->rx_np;
>  
> -	if (!np->rx_hook)
> +	if (!np)
>  		goto out;
>  	if (skb->dev->type != ARPHRD_ETHER)
>  		goto out;
> @@ -611,9 +622,8 @@ int netpoll_setup(struct netpoll *np)
>  {
>  	struct net_device *ndev = NULL;
>  	struct in_device *in_dev;
> -
> -	np->poll_lock = SPIN_LOCK_UNLOCKED;
> -	np->poll_owner = -1;
> +	struct netpoll_info *npinfo;
> +	unsigned long flags;
>  
>  	if (np->dev_name)
>  		ndev = dev_get_by_name(np->dev_name);
> @@ -624,7 +634,17 @@ int netpoll_setup(struct netpoll *np)
>  	}
>  
>  	np->dev = ndev;
> -	ndev->np = np;
> +	if (!ndev->npinfo) {
> +		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
> +		if (!npinfo)
> +			goto release;
> +
> +		npinfo->rx_np = NULL;
> +		npinfo->poll_lock = SPIN_LOCK_UNLOCKED;
> +		npinfo->poll_owner = -1;
> +		npinfo->rx_lock = SPIN_LOCK_UNLOCKED;
> +	} else
> +		npinfo = ndev->npinfo;
>  
>  	if (!ndev->poll_controller) {
>  		printk(KERN_ERR "%s: %s doesn't support polling, aborting.\n",
> @@ -692,13 +712,20 @@ int netpoll_setup(struct netpoll *np)
>  		       np->name, HIPQUAD(np->local_ip));
>  	}
>  
> -	if(np->rx_hook)
> -		np->rx_flags = NETPOLL_RX_ENABLED;
> +	if(np->rx_hook) {
> +		spin_lock_irqsave(&npinfo->rx_lock, flags);
> +		npinfo->rx_flags |= NETPOLL_RX_ENABLED;
> +		npinfo->rx_np = np;
> +		spin_unlock_irqsave(&npinfo->rx_lock, flags);
> +	}
> +	/* last thing to do is link it to the net device structure */
> +	ndev->npinfo = npinfo;
>  
>  	return 0;
>  
>   release:
> -	ndev->np = NULL;
> +	if (!ndev->npinfo)
> +		kfree(npinfo);
>  	np->dev = NULL;
>  	dev_put(ndev);
>  	return -1;
> @@ -706,9 +733,17 @@ int netpoll_setup(struct netpoll *np)
>  
>  void netpoll_cleanup(struct netpoll *np)
>  {
> -	if (np->dev)
> -		np->dev->np = NULL;
> -	dev_put(np->dev);
> +	struct netpoll_info *npinfo;
> +
> +	if (np->dev) {
> +		npinfo = np->dev->npinfo;
> +		if (npinfo && npinfo->rx_np == np) {
> +			npinfo->rx_np = NULL;
> +			npinfo->rx_flags &= ~NETPOLL_RX_ENABLED;
> +		}
> +		dev_put(np->dev);
> +	}
> +
>  	np->dev = NULL;
>  }
>  
> --- linux-2.6.12-rc6/net/core/dev.c.orig	2005-06-20 19:51:59.000000000 -0400
> +++ linux-2.6.12-rc6/net/core/dev.c	2005-06-21 13:53:51.583407710 -0400
> @@ -1656,6 +1656,7 @@ int netif_receive_skb(struct sk_buff *sk
>  	unsigned short type;
>  
>  	/* if we've gotten here through NAPI, check netpoll */
> +	/* how else can we get here?  --phro */

We can get here in the usual route of non-NAPI delivery, IIRC.

>  	if (skb->dev->poll && netpoll_rx(skb))
>  		return NET_RX_DROP;
>  
> --- linux-2.6.12-rc6/include/linux/netpoll.h.orig	2005-06-20 19:51:47.000000000 -0400
> +++ linux-2.6.12-rc6/include/linux/netpoll.h	2005-06-21 15:29:48.994422229 -0400
> @@ -16,14 +16,19 @@ struct netpoll;
>  struct netpoll {
>  	struct net_device *dev;
>  	char dev_name[16], *name;
> -	int rx_flags;
>  	void (*rx_hook)(struct netpoll *, int, char *, int);
>  	void (*drop)(struct sk_buff *skb);
>  	u32 local_ip, remote_ip;
>  	u16 local_port, remote_port;
>  	unsigned char local_mac[6], remote_mac[6];
> +};
> +
> +struct netpoll_info {
>  	spinlock_t poll_lock;
>  	int poll_owner;
> +	int rx_flags;
> +	spinlock_t rx_lock;
> +	struct netpoll *rx_np; /* netpoll that registered an rx_hook */
>  };
>  
>  void netpoll_poll(struct netpoll *np);
> @@ -39,22 +44,35 @@ void netpoll_queue(struct sk_buff *skb);
>  #ifdef CONFIG_NETPOLL
>  static inline int netpoll_rx(struct sk_buff *skb)
>  {
> -	return skb->dev->np && skb->dev->np->rx_flags && __netpoll_rx(skb);
> +	struct netpoll_info *npinfo = skb->dev->npinfo;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	if (!npinfo || (!npinfo->rx_np && !npinfo->rx_flags))
> +		return 0;
> +
> +	spin_lock_irqsave(&npinfo->rx_lock, flags);
> +	/* check rx_flags again with the lock held */
> +	if (npinfo->rx_flags && __netpoll_rx(skb))
> +		ret = 1;
> +	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
> +
> +	return ret;
>  }

This is perhaps a problem due to cache line bouncing. Perhaps we can
use an atomic op and a memory barrier instead?

>  static inline void netpoll_poll_lock(struct net_device *dev)
>  {
> -	if (dev->np) {
> -		spin_lock(&dev->np->poll_lock);
> -		dev->np->poll_owner = smp_processor_id();
> +	if (dev->npinfo) {
> +		spin_lock(&dev->npinfo->poll_lock);
> +		dev->npinfo->poll_owner = smp_processor_id();
>  	}
>  }
>  
>  static inline void netpoll_poll_unlock(struct net_device *dev)
>  {
> -	if (dev->np) {
> -		spin_unlock(&dev->np->poll_lock);
> -		dev->np->poll_owner = -1;
> +	if (dev->npinfo) {
> +		dev->npinfo->poll_owner = -1;
> +		spin_unlock(&dev->npinfo->poll_lock);
>  	}
>  }
>  
> --- linux-2.6.12-rc6/include/linux/netdevice.h.orig	2005-06-20 20:26:21.000000000 -0400
> +++ linux-2.6.12-rc6/include/linux/netdevice.h	2005-06-21 14:46:52.093190854 -0400
> @@ -41,7 +41,7 @@
>  struct divert_blk;
>  struct vlan_group;
>  struct ethtool_ops;
> -struct netpoll;
> +struct netpoll_info;
>  					/* source back-compat hooks */
>  #define SET_ETHTOOL_OPS(netdev,ops) \
>  	( (netdev)->ethtool_ops = (ops) )
> @@ -468,7 +468,7 @@ struct net_device
>  						     unsigned char *haddr);
>  	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
>  #ifdef CONFIG_NETPOLL
> -	struct netpoll		*np;
> +	struct netpoll_info	*npinfo;
>  #endif
>  #ifdef CONFIG_NET_POLL_CONTROLLER
>  	void                    (*poll_controller)(struct net_device *dev);

-- 
Mathematics is the supreme nostalgia of our time.
