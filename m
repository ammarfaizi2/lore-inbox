Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUHaDZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUHaDZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 23:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUHaDZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 23:25:49 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:62137 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266364AbUHaDZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 23:25:44 -0400
Subject: Re: [RFC&PATCH] Alternative RCU implementation
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jack Steiner <steiner@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       rusty@rustcorp.com.au
In-Reply-To: <20040830185223.GF1243@us.ibm.com>
References: <m3brgwgi30.fsf@new.localdomain>
	 <20040830004322.GA2060@us.ibm.com>
	 <1093886020.984.238.camel@new.localdomain>
	 <20040830185223.GF1243@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093922569.1003.159.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Aug 2004 23:22:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 14:52, Paul E. McKenney wrote: 
> On Mon, Aug 30, 2004 at 01:13:41PM -0400, Jim Houston wrote:
> > I know that I'm questioning one of your design goals for RCU by adding
> > overhead to the read-side.  I have read everything I could find on RCU.
> > My belief is that the cost of the xchg() instruction is small 
> > compared to the cache benifit of freeing memory more quickly.
> > I think it's more interesting to look at the impact of the xchg() at the
> > level of an entire system call.  Adding 30 nanoseconds to a open/close
> > path that tasks 3 microseconds seems reasonable.  It is hard to measure
> > the benefit of reusing the a dcache entry more quickly.
> 
> Hello, Jim,
> 
> The other thing to keep in mind is that reducing the grace-period
> duration increases the per-access overhead, since each grace period
> incurs a cost.  So there is a balance that needs to be struck between
> overflowing memory with a too-long grace period and incurring too
> much overhead with a too-short grace period.
> 
> How does the rest of the kernel work with all interrupts to
> a particular CPU shut off?  For example, how do you timeslice?
> 
> 						Thanx, Paul
> 
> PS.  My concerns with some aspects of your design aside, your
>      getting a significant change to the RCU infrastructure to
>      work reasonably well is quite impressive!

Hi Paul,

I have two module parameters in the patch which can be used to
tune how often grace periods are started.  They can be set at boot
time as follows:

rcupdate.rcu_max_count=#
	The per-cpu count of queued requests at which to
	start a new batch.  Patch defaults to 256.

rcupdate.rcu_max_time=#
	Timeout value in jiffies at which to start a batch. 
	Defaults to HZ/10.

I picked the defaults to start batches with similar frequency to
the existing code.

I tested a dual processor with rcupdate.rcu_max_count=0. This
will start a grace period for every call_rcu(). I ran
my rename test this way and it worked suprisingly well.

I maintain a nxtbatch value which lets me check if the grace period
for the entries in the nxt list has started or perhaps already
completed.  I check this in call_rcu() and avoid mixing batches.
Any requests queued before the batch was started will be completed
at the end of the grace period.  Unless a very small rcu_max_count
value is used, there is likely to be some delay between completing
a grace period and needing to start another.


> How does the rest of the kernel work with all interrupts to
> a particular CPU shut off?  For example, how do you timeslice?

It's a balancing act.  In some cases we just document the
missing functionality.  If the local timer is disabled on a cpu,
all processes are SCHED_FIFO.  In the case of Posix timers, we
move timers to honor the procesor shielding an the process affinity.

Jim Houston


