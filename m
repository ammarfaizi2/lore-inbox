Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSJVUlZ>; Tue, 22 Oct 2002 16:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSJVUlW>; Tue, 22 Oct 2002 16:41:22 -0400
Received: from [202.88.156.6] ([202.88.156.6]:46752 "EHLO
	saraswati.hathway.com") by vger.kernel.org with ESMTP
	id <S264943AbSJVUlT>; Tue, 22 Oct 2002 16:41:19 -0400
Date: Wed, 23 Oct 2002 01:34:38 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release
Message-ID: <20021023013438.E25716@dikhow>
Reply-To: dipankar@gamebox.net
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <1035307430.1008.1476.camel@phantasy> <3DB59431.2090807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB59431.2090807@mvista.com>; from cminyard@mvista.com on Tue, Oct 22, 2002 at 08:30:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 08:30:16PM +0200, Corey Minyard wrote:
> Robert Love wrote:
> >At least on the variant of RCU that is in 2.5, the RCU code does the
> >read side by disabling preemption.  Nothing else.
> >
> In 2.5.44, stock from kernel.org, rcu_process_callbacks() calls 
> local_irq_disable().  Is that just preemption disabling, now?

No, that is to allow queueing of callbacks from irq context - see
call_rcu(). Since the queues are per-CPU, we don't need any spinlock.
rcu_process_callbacks() is always invoked from the RCU per-CPU tasklet,
so preemption doesn't come into picture. But irq disabling is needed
so that it doesn't race with call_rcu().

Only preemption related issue with RCU is that in the reader
side (in your case traversing the nmi handler list for invocation),
there should not be any preemption (not possible anyway in your case).
This is achieved by rcu_read_lock()/rcu_read_unlock() which essentially
disables/enables preemption.

The idea is that if you get preempted while holding reference to
some RCU protected data, it is not safe to invoke the RCU callback.
Once you get preempted, you can run on a different CPU and keeping
track of the preempted tasks become difficult. Besides preempted
tasks with low priority can delay RCU update for long periods.
Hence the disabling of preemption which is not worse than locks.


> >But anyhow, disabling interrupts should not affect NMIs, no?
> >
> You are correct.  disabling preemption or interrupts has no effect on NMIs.

Yes.

Thanks
Dipankar
