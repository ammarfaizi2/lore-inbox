Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUCaUr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUCaUr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:47:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:34290 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262448AbUCaUrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:47:55 -0500
Date: Thu, 1 Apr 2004 02:16:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert.Olsson@data.slu.se, paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040331204611.GC4543@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040329222926.GF3808@dualathlon.random> <200403302005.AAA00466@yakov.inr.ac.ru> <20040330211450.GI3808@dualathlon.random> <20040330133000.098761e2.davem@redhat.com> <20040330213742.GL3808@dualathlon.random> <20040330142210.080dbe38.davem@redhat.com> <20040330224902.GM3808@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330224902.GM3808@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 12:49:02AM +0200, Andrea Arcangeli wrote:
> On Tue, Mar 30, 2004 at 02:22:10PM -0800, David S. Miller wrote:
> > Otherwise, keep in mind what I said, and also as Robert mentioned every
> > single local_bh_enable() is going to call do_softirq() if the count falls
> > to zero.
> 
> I was less concerned about the do_sofitrq in local_bh_enable, since that
> runs in a scheduler-aware context, so at least the timeslice is
> definitely accounted for and it'll schedule at some point (unlike with
> an hardirq flood). Actually the length of the default timeslice matters
> too here, lowering the max timeslice to 10msec would certainly reduce
> the effect.

That is there in my list of things to test.

> call_rcu_bh will fix the local_bh_enable too. The only problem with
> call_rcu_bh is how to queue the tasklets in every cpu (an IPI sounds
> overkill at high frequency, because effectively here we're running the rcu
> callbacks in a potential fast path).  OTOH if we've to add a spinlock to
> queue the tasklet, then we might as well take a spinlock in the routing
> cache in the first place (at least for this workload).

I don't do any of this. I just have a separate quiescent state counter
for softirq RCU. It is incremented for regular quiescent points
like cswitch, userland, idle loop as well as at the completion
of each softirq handler. call_rcu_bh() uses its own queues.
Everything else works like call_rcu().

Thanks
Dipankar
