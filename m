Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWGEOM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWGEOM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWGEOM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:12:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:36274 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964878AbWGEOM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:12:58 -0400
Date: Wed, 5 Jul 2006 07:13:16 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Urs Thuermann <urs@isnogud.escape.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: locking mechanisms
Message-ID: <20060705141316.GA21837@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <m2odw9g937.fsf@janus.isnogud.escape.de> <1151746571.25491.850.camel@localhost.localdomain> <m2mzbpcyrh.fsf@janus.isnogud.escape.de> <20060705061126.GA20483@us.ibm.com> <m2y7v8gzrb.fsf@janus.isnogud.escape.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2y7v8gzrb.fsf@janus.isnogud.escape.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 11:35:52AM +0200, Urs Thuermann wrote:
> "Paul E. McKenney" <paulmck@us.ibm.com> writes:
> 
> > > I have code that receives network packets by registering with
> > > dev_add_pack().  Each packet received is then delivered to a list
> > > of receivers, where this list can contain quite a lot of items:
> > > 
> > > 	receive_function(struct sk_buff *skb, struct net_device *dev,
> > > 			struct packet_type *pt, struct net_device *orig_dev)
> > > 	{
> > > 		...
> > > 		rcu_read_lock();
> > >             head = find_list(dev);
> > > 		hlist_for_each_entry_rcu(p, n, head, list) {
> > > 			deliver_packet_to_receiver(skb, p);
> > > 		}
> > > 		rcu_read_unlock();
> > > 	}
> > > 
> > > The deliver_packet_to_receiver() function finally ends up in a call to
> > > sock_queue_rcv_skb().
> 
> > "Holding" rcu_read_lock() for long time periods is much less of a
> > concern than holding other types of synchronization mechanisms.
> 
> Why is that?  I thought, if I hold a spinlock (or rw_lock in my case)
> I only block other threads that try to get that same lock.  With
> rcu_read_lock() I disable preemption which I thought affects more
> (all) other parts of the kernel.

In any kernel in which rcu_read_lock() disables preemption, both
spin_lock() and read_lock() (and friends) also disables preemption.
In addition, as you pointed out above, spin_lock(), read_lock(), and
friends are also blocking any other task that is trying to acquire
the lock in a conflicting manner to task(s) already holding it.

For reference, the kernels handle preemption as follows:

o	non-CONFIG_PREEMPT:  preemption is already disabled anyway,
	so any time anywhere in the kernel counts against realtime
	latency.

o	CONFIG_PREEMPT: all spinlock acquisitions, as well as rcu_read_lock(),
	disable preemption.

o	CONFIG_PREEMPT_RT (in Ingo Molnar's -rt patchset): neither "normal"
	spinlock acquisitions nor rcu_read_lock() disable preemption.

> > But I have to ask: roughly how long is "quite long"?
> 
> Depends on how many and what types of sockets are opened and which
> packets they want to receive.  The code is part of a new protocol
> family implementation for CAN (controller area network), which you can
> see at belios.de, project name socket-can.  It implements several
> types of PF_CAN sockets, which register for packets of certain CAN
> IDs, which are then lightly processed (filtered) and eventually
> delivered into a queue using sock_queue_rcv_skb().  Usually, the list
> has one receiver per open PF_CAN sockets.  Typical usage here has
> shown list lengths of 30-100 entries, i.e. 30-100 packets delivered
> with sock_queue_rcv_skb().  But it all depends on what the user space
> does, how many PF_CAN sockets are opened by all processes.
> 
> Is that value of "quite long" also "too long" for doing an
> rcu_read_lock()?

Seems like 30-100 entries would be OK in many cases -- but is it possible
to use a hash table, a tree, or some such if problems arise?

> urs
> 
> BTW, while implementing PF_CAN and reading kernel code and
> documentation I often run into questions on details like this which
> I'd like answered to get a better understanding of kernel internals,
> sometimes not directly related to some concrete implementation
> problem.  Is LKML the right place for these questions?

Yes, though it is almost always worthwhile to google "xxx site:lwn.net"
or "xxx site:lkml.org" for topic "xxx".  And the contents of the
Documentation directory, as well -- sometimes a little grepping in
that directory can be quite helpful.  In addition, there are a number
of books on Linux kernel internals.

						Thanx, Paul
