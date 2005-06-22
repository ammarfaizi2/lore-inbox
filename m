Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVFVRWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVFVRWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVFVROB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:14:01 -0400
Received: from waste.org ([216.27.176.166]:54483 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261749AbVFVRBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:01:46 -0400
Date: Wed, 22 Jun 2005 10:01:28 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: netdev@oss.sgi.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch,rfc] allow registration of multiple netpolls per interface
Message-ID: <20050622170128.GV27572@waste.org>
References: <17080.35214.507402.998984@segfault.boston.redhat.com> <20050621225252.GY27572@waste.org> <17081.20441.714191.528270@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17081.20441.714191.528270@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 07:47:37AM -0400, Jeff Moyer wrote:
> mpm> Hmm. It's conceivable we'll want netdump and kgdb on the same
> mpm> interface so we'll have to address this eventually..
> 
> Well, do you want to address it eventually, or now?  As I said, it's never
> bitten anyone before.

Later's fine. I just don't want to design it out by accident again.
 
> >> struct netpoll_info {
> >> spinlock_t poll_lock;
> >> int poll_owner;
> >> int rx_flags;
> >> spinlock_t rx_lock;
> >> struct netpoll *rx_np; /* netpoll that registered an rx_hook */
> >> };
> >> 
> >> This is the structure which gets pointed to by the net_device.  All of the
> >> flags and locks which are specific to the INTERFACE go here.  Any variables
> >> which must be kept per struct netpoll were left in the struct netpoll.  So
> >> now, we have a cleaner separation of data and its scope.
> >> 
> >> Since we never really supported having more than one struct netpoll
> >> register an rx_hook, I got rid of the rx_list.  This is replaced by a
> >> single pointer in the netpoll_info structure (np_rx).  We still need to
> >> protect addition or removal of the rx_np pointer, and so keep the lock
> >> (rx_lock).  There is one lock per struct net_device, and I am certain that
> >> it will be 0 contention, as rx_np will only be changed during an insmod or
> >> rmmod.  If people think this would be a good rcu candidate, let me know and
> >> I'll change it to use that locking scheme.
> 
> mpm> It might be simpler to have a single lock here..?
> 
> Maybe.  You can't really have netpoll code running on multiple cpus at the
> same time, right?  This is the rx path, remember, so the other cpu should
> be spinning on the poll_lock.
> 
> Keeping separate locks would allow you to unregister a struct netpoll
> associated with another net device without causing lock contention.  This
> is a very minor win, obviously.
> 
> I still feel like this npinfo struct is the right place for this, though.
> If you're strongly opposed to that, I'll change it.

No, certainly having it in npinfo makes sense. I just was wondering if
we really need two locks in there.

> >> +	spin_lock_irqsave(&npinfo->rx_lock, flags);
> >> +	if (npinfo->rx_np->dev == skb->dev)
> >> +		np = npinfo->rx_np;
> >> +	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
> 
> mpm> And I think that means we don't need the lock here either.  
> 
> Sure we do.  We need to protect against rmmod's.

How can we have an rmmmod when we're trapped?

> >> static inline int netpoll_rx(struct sk_buff *skb)
> >> {
> >> -	return skb->dev->np && skb->dev->np->rx_flags && __netpoll_rx(skb);
> >> +	struct netpoll_info *npinfo = skb->dev->npinfo;
> >> +	unsigned long flags;
> >> +	int ret = 0;
> >> +
> >> +	if (!npinfo || (!npinfo->rx_np && !npinfo->rx_flags))
> >> +		return 0;
> >> +
> >> +	spin_lock_irqsave(&npinfo->rx_lock, flags);
> >> +	/* check rx_flags again with the lock held */
> >> +	if (npinfo->rx_flags && __netpoll_rx(skb))
> >> +		ret = 1;
> >> +	spin_unlock_irqrestore(&npinfo->rx_lock, flags);
> >> +
> >> +	return ret;
> >> }
> 
> mpm> This is perhaps a problem due to cache line bouncing. Perhaps we can
> mpm> use an atomic op and a memory barrier instead?
> 
> It really should be a 0 contention lock.  Let's not optimize something that
> doesn't need it.  If we find that it causes problems, I'll be more than
> happy to fix it.

Ok, fair enough.

-- 
Mathematics is the supreme nostalgia of our time.
