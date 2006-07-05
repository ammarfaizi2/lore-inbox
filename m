Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWGEGLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWGEGLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 02:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWGEGLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 02:11:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52707 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932065AbWGEGLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 02:11:05 -0400
Date: Tue, 4 Jul 2006 23:11:26 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Urs Thuermann <urs@isnogud.escape.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: locking mechanisms
Message-ID: <20060705061126.GA20483@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <m2odw9g937.fsf@janus.isnogud.escape.de> <1151746571.25491.850.camel@localhost.localdomain> <m2mzbpcyrh.fsf@janus.isnogud.escape.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2mzbpcyrh.fsf@janus.isnogud.escape.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 02:58:42PM +0200, Urs Thuermann wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > Does Documentation/listRCU.txt answer your questions ?
> 
> It doesn't answer my question.  I have code that receives network
> packets by registering with dev_add_pack().  Each packet received is
> then delivered to a list of receivers, where this list can contain quite
> a lot of items:
> 
> 	receive_function(struct sk_buff *skb, struct net_device *dev,
> 			struct packet_type *pt, struct net_device *orig_dev)
> 	{
> 		...
> 		rcu_read_lock();
>                 head = find_list(dev);
> 		hlist_for_each_entry_rcu(p, n, head, list) {
> 			deliver_packet_to_receiver(skb, p);
> 		}
> 		rcu_read_unlock();
> 	}
> 
> The deliver_packet_to_receiver() function finally ends up in a call to
> sock_queue_rcv_skb().
> 
> My questions was, wether I should worry to "hold" the rcu_read_lock for
> the time of the list traversal since the list can be quite long and
> preemption is disabled between rcu_read_lock() and rcu_read_unlock().

"Holding" rcu_read_lock() for long time periods is much less of a
concern than holding other types of synchronization mechanisms.
The main concern is the effect on realtime latency in CONFIG_PREEMPT
(but -not- CONFIG_PREEMPT_RT) kernels.  This concern is due to the
fact that rcu_read_lock() suppresses preemption in CONFIG_PREEMPT
kernels.

But I have to ask: roughly how long is "quite long"?

							Thanx, Paul
