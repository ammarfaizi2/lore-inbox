Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWHaW5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWHaW5v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 18:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWHaW5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 18:57:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:54985 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964805AbWHaW5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 18:57:49 -0400
Date: Thu, 31 Aug 2006 15:58:28 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Alexey Dobriyan <adobriyan@mail.ru>,
       Matt Helsley <matthltc@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH 1/7] introduce atomic_dec_and_lock_irqsave()
Message-ID: <20060831225828.GB4927@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <44F45045.70402@sw.ru> <44F4540C.8050205@sw.ru> <Pine.LNX.4.64.0608301156010.6762@scrub.home> <20060830145759.GA163@oleg> <Pine.LNX.4.64.0608301248420.6761@scrub.home> <20060830165851.GA8481@in.ibm.com> <Pine.LNX.4.64.0608301918260.6761@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608301918260.6761@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 07:25:07PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 30 Aug 2006, Dipankar Sarma wrote:
> 
> > > > uidhash_lock can be taken from irq context. For example, delayed_put_task_struct()
> > > > does __put_task_struct()->free_uid().
> > > 
> > > AFAICT it's called via rcu, does that mean anything released via rcu has 
> > > to be protected against interrupts?
> > 
> > No. You need protection only if you have are using some 
> > data that can also be used by the RCU callback. For example,
> > if your RCU callback just calls kfree(), you don't have to 
> > do a spin_lock_bh().
> 
> In this case kfree() does its own interrupt synchronization. I didn't 
> realize before that rcu had this (IMO serious) limitation. I think there 
> should be two call_rcu() variants, one that queues the callback in a soft 
> irq and a second which queues it in a thread context.

How about just using synchronize_rcu() in the second situation?
This primitive blocks until the grace period completes, allowing you to
do the remaining processing in thread context.  As a bonus, RCU code
that uses synchronize_rcu() is usually quite a bit simpler than code
using call_rcu().

Using synchronize_rcu():

	list_del_rcu(p);
	synchronize_rcu();
	kfree(p);

Using call_rcu():

	static void rcu_callback_func(struct rcu_head *rcu)
	{
		struct foo *p = container_of(rcu, struct foo, rcu);

		kfree(p);
	}

	list_del_rcu(p);
	call_rcu(&p->rcu, rcu_callback_func);

Furthermore, the call_rcu() approach requires a struct rcu_head somewhere
in the data structure, so use of synchronize_rcu() saves a bit of memory,
as well.

But if you have a situation where neither synchronize_srcu() nor
call_rcu() is working out for you, let's hear it!

						Thanx, Paul
