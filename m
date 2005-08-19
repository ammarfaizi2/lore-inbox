Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVHSWrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVHSWrW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 18:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVHSWrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 18:47:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58099 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932319AbVHSWrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 18:47:21 -0400
Date: Fri, 19 Aug 2005 15:47:58 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt6
Message-ID: <20050819224758.GJ1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1124215631.5764.43.camel@localhost.localdomain> <1124218245.5764.52.camel@localhost.localdomain> <1124252419.5764.83.camel@localhost.localdomain> <1124257580.5764.105.camel@localhost.localdomain> <20050817064750.GA8395@elte.hu> <1124287505.5764.141.camel@localhost.localdomain> <1124288677.5764.154.camel@localhost.localdomain> <1124295214.5764.163.camel@localhost.localdomain> <20050817162324.GA24495@elte.hu> <1124486548.18408.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124486548.18408.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 05:22:28PM -0400, Steven Rostedt wrote:
> On Wed, 2005-08-17 at 18:23 +0200, Ingo Molnar wrote:
> 
> > 
> > > And it goes on and on. This happens everytime. Without netconsole, I
> > > only get the nonzero lock count error. Also, one of my lockups on SMP
> > > had to do with the kernel_thread_helper:
> > > 
> > > Using IPI Shortcut mode
> > > khelper/794[CPU#0]: BUG in set_new_owner at kernel/rt.c:916
> 
> This was with netconsole and showed up after a bunch of other bugs. So
> this is a side effect of what happened earlier.
> > 
> > this is a 'must not happen'. Somehow lock->held list got non-empty.  
> > Maybe some use-after-free thing? Havent seen it myself.
> 
> I started debugging netconsole with the RT patch and found this
> happening.  After seeing what's wrong, I looked at the latest git
> branch, and it seems to already have a similar solution that I was going
> to make. Here's a description of what's wrong.
> 
> In net/core/dev.c the following code is in net_rx_action:
> 
> 		netpoll_poll_lock(dev);
> 
> 		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
> 			netpoll_poll_unlock(dev);
> 			raw_local_irq_disable();
> 			list_del(&dev->poll_list);
> 			list_add_tail(&dev->poll_list, &queue->poll_list);
> 			if (dev->quota < 0)
> 				dev->quota += dev->weight;
> 			else
> 				dev->quota = dev->weight;
> 		} else {
> 			netpoll_poll_unlock(dev);
> 
> The netpoll_poll_lock and netpoll_poll_unlock look like this (in current RT):
> 
> static inline netpoll_poll_lock(struct net_device *dev)
> {
> 	if (dev->npinfo) {
> 		spin_lock(&dev->npinfo->poll_lock);
> 		dev->npinfo->poll_owner = smp_processor_id();
> 	}
> }
> 
> static inline void netpoll_poll_unlock(struct net_device *dev)
> {
> 	if (dev->npinfo) {
> 		dev->npinfo->poll_owner = -1;
> 		spin_unlock(&dev->npinfo->poll_lock);
> 	}
> }
> 
> 
> The problem here is that between netpoll_poll_lock and
> netpoll_poll_unlock the dev->npinfo gets assigned. So we unlock the
> dev->npinfo->poll_lock without ever locking it.
> 
> Here's the port from the latest git to solve this. I've CCed the netdev,
> since I'm not sure I got all the places for rcu_lock for the netpoll. At
> least to solve this problem.  I did boot up the kernel and this patch
> did fix my bugs that I was getting using netconsole. (I have one more
> patch to send to fix the illegal API messages).
> 
> -- Steve
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 
> Index: linux_realtime_ernie/include/linux/netpoll.h
> ===================================================================
> --- linux_realtime_ernie/include/linux/netpoll.h	(revision 296)
> +++ linux_realtime_ernie/include/linux/netpoll.h	(working copy)
> @@ -60,25 +60,31 @@
>  	return ret;
>  }

Good catch -- but a few changes needed to be perfectly safe:

	static inline void *netpoll_poll_lock(struct net_device *dev)
	{

		struct netpoll_info *npi;

		rcu_read_lock();
		npi = rcu_dereference(dev)->npinfo;
		if (have) {
			spin_lock(&npi->poll_lock);
			npi->poll_owner = smp_processor_id();
			return npi;
		}
		return NULL;
	}

The earlier version could get in trouble if dev->npinfo was set
to NULL while this was executing.

I am assuming that the dev pointer is really what is being RCU-protected,
but this example uses mostly static data structures, so it is hard
for me to tell.  The npinfo pointer is not being RCU protected, as it
appears to never be changed.  The other candidate is the rx_np pointer,
which is set to NULL in netpoll_cleanup.  I suggest a modification
to netpoll_cleanup below that handles both possibilities.  Of course,
I might well be missing something...

> -static inline void netpoll_poll_unlock(struct net_device *dev)
> +static inline void netpoll_poll_unlock(void *have)
>  {
> -	if (dev->npinfo) {
> -		dev->npinfo->poll_owner = -1;
> -		spin_unlock(&dev->npinfo->poll_lock);
> +	struct netpoll_info *npi = have;
> +
> +	if (npi) {
> +		npi->poll_owner = -1;
> +		spin_unlock(&npi->poll_lock);
>  	}
> +	rcu_read_unlock();
>  }
>  
>  #else
>  #define netpoll_rx(a) 0
> -#define netpoll_poll_lock(a)
> +#define netpoll_poll_lock(a) 0
>  #define netpoll_poll_unlock(a)
>  #endif
>  
> Index: linux_realtime_ernie/net/core/netpoll.c
> ===================================================================
> --- linux_realtime_ernie/net/core/netpoll.c	(revision 296)
> +++ linux_realtime_ernie/net/core/netpoll.c	(working copy)

If netpoll_setup() is implicitly tearing down an earlier netpoll_setup(),
then something like Steve's change below might be needed.

> @@ -726,6 +726,9 @@
>  	/* last thing to do is link it to the net device structure */
>  	ndev->npinfo = npinfo;
>  
> +	/* avoid racing with NAPI reading npinfo */
> +	synchronize_rcu();
> +
>  	return 0;
>  
>   release:

Assuming that it is legal to block in netpoll_cleanup(), the following
should work.  The idea is to NULL the dev pointer, wait for all RCU
readers to get done, and only then complete the cleanup.

	void netpoll_cleanup(struct netpoll *np)
	{
		struct netpoll_info *npinfo;
		unsigned long flags;
		struct net_device *dp;

		if (np->dev) {
			dp = np->dev;
			rcu_assign_pointer(np->dev, NULL);
			synchronize_rcu();
			npinfo = dp->npinfo;
			if (npinfo && npinfo->rx_np == np) {
				spin_lock_irqsave(&npinfo->rx_lock, flags);
				npinfo->rx_np = NULL;
				npinfo->rx_flags &= ~NETPOLL_RX_ENABLED;
				spin_unlock_irqrestore(&npinfo->rx_lock, flags);
			}
			dev_put(dp);
		}

	}

Again, I do not fully understand this code, so a grain of salt might
come in handy.  But there definitely need to be some rcu_dereference()
and rcu_assign_pointer() primitives in there somewhere.  ;-)

The following changes look good to me, but, as I said earlier, I do
not claim to fully understand this code.

> Index: linux_realtime_ernie/net/core/dev.c
> ===================================================================
> --- linux_realtime_ernie/net/core/dev.c	(revision 296)
> +++ linux_realtime_ernie/net/core/dev.c	(working copy)
> @@ -1723,6 +1723,7 @@
>  
>  	while (!list_empty(&queue->poll_list)) {
>  		struct net_device *dev;
> +		void *have;
>  
>  		if (budget <= 0 || jiffies - start_time > 1)
>  			goto softnet_break;
> @@ -1735,10 +1736,10 @@
>  
>  		dev = list_entry(queue->poll_list.next,
>  				 struct net_device, poll_list);
> -		netpoll_poll_lock(dev);
> +		have = netpoll_poll_lock(dev);
>  
>  		if (dev->quota <= 0 || dev->poll(dev, &budget)) {
> -			netpoll_poll_unlock(dev);
> +			netpoll_poll_unlock(have);
>  			raw_local_irq_disable();
>  			list_del(&dev->poll_list);
>  			list_add_tail(&dev->poll_list, &queue->poll_list);
> @@ -1747,7 +1748,7 @@
>  			else
>  				dev->quota = dev->weight;
>  		} else {
> -			netpoll_poll_unlock(dev);
> +			netpoll_poll_unlock(have);
>  			dev_put(dev);
>  			raw_local_irq_disable();
>  		}

						Thanx, Paul
