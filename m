Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWGEJkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWGEJkM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWGEJkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:40:11 -0400
Received: from oker.escape.de ([194.120.234.254]:15849 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id S964825AbWGEJkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:40:10 -0400
To: linux-kernel@vger.kernel.org
CC: "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: Q: locking mechanisms
References: <m2odw9g937.fsf@janus.isnogud.escape.de>
	<1151746571.25491.850.camel@localhost.localdomain>
	<m2mzbpcyrh.fsf@janus.isnogud.escape.de>
	<20060705061126.GA20483@us.ibm.com>
From: Urs Thuermann <urs@isnogud.escape.de>
Date: 05 Jul 2006 11:35:52 +0200
In-Reply-To: <20060705061126.GA20483@us.ibm.com>; from "Paul E. McKenney" on Tue, 4 Jul 2006 23:11:26 -0700
Message-ID: <m2y7v8gzrb.fsf@janus.isnogud.escape.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@us.ibm.com> writes:

> > I have code that receives network packets by registering with
> > dev_add_pack().  Each packet received is then delivered to a list
> > of receivers, where this list can contain quite a lot of items:
> > 
> > 	receive_function(struct sk_buff *skb, struct net_device *dev,
> > 			struct packet_type *pt, struct net_device *orig_dev)
> > 	{
> > 		...
> > 		rcu_read_lock();
> >             head = find_list(dev);
> > 		hlist_for_each_entry_rcu(p, n, head, list) {
> > 			deliver_packet_to_receiver(skb, p);
> > 		}
> > 		rcu_read_unlock();
> > 	}
> > 
> > The deliver_packet_to_receiver() function finally ends up in a call to
> > sock_queue_rcv_skb().

> "Holding" rcu_read_lock() for long time periods is much less of a
> concern than holding other types of synchronization mechanisms.

Why is that?  I thought, if I hold a spinlock (or rw_lock in my case)
I only block other threads that try to get that same lock.  With
rcu_read_lock() I disable preemption which I thought affects more
(all) other parts of the kernel.

> But I have to ask: roughly how long is "quite long"?

Depends on how many and what types of sockets are opened and which
packets they want to receive.  The code is part of a new protocol
family implementation for CAN (controller area network), which you can
see at belios.de, project name socket-can.  It implements several
types of PF_CAN sockets, which register for packets of certain CAN
IDs, which are then lightly processed (filtered) and eventually
delivered into a queue using sock_queue_rcv_skb().  Usually, the list
has one receiver per open PF_CAN sockets.  Typical usage here has
shown list lengths of 30-100 entries, i.e. 30-100 packets delivered
with sock_queue_rcv_skb().  But it all depends on what the user space
does, how many PF_CAN sockets are opened by all processes.

Is that value of "quite long" also "too long" for doing an
rcu_read_lock()?


urs


BTW, while implementing PF_CAN and reading kernel code and
documentation I often run into questions on details like this which
I'd like answered to get a better understanding of kernel internals,
sometimes not directly related to some concrete implementation
problem.  Is LKML the right place for these questions?
