Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVLJPYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVLJPYV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 10:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVLJPYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 10:24:21 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:64932 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932410AbVLJPYU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 10:24:20 -0500
Date: Sat, 10 Dec 2005 20:49:51 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix RCU race in access of nohz_cpu_mask
Message-ID: <20051210151951.GA2798@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <439889FA.BB08E5E1@tv-sign.ru> <20051209024623.GA14844@in.ibm.com> <4399D852.47E0BB4E@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4399D852.47E0BB4E@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 10:17:38PM +0300, Oleg Nesterov wrote:
> Srivatsa Vaddagiri wrote:
> > 
> > On Thu, Dec 08, 2005 at 10:31:06PM +0300, Oleg Nesterov wrote:
> > > I can't see how this change can prevent idle cpus to be included in
> > > ->cpumask, cpu can add itself to nohz_cpu_mask right after some other
> > > cpu started new grace period.
> > 
> > Yes that can happen, but if they check for rcu_pending right after that
> > it will prevent them from going tickless atleast (which will prevent grace
> > periods from being unnecessarily extended). Something like below:
> > 
> >         CPU0                                    CPU1
> > 
> >         rcp->cur++;     /* New GP */
> > 
> >         smp_mb();
> 
> I think I need some education on memory barriers.
> 
> Does this mb() garantees that the new value of ->cur will be visible
> on other cpus immediately after smp_mb() (so that rcu_pending() will
> notice it) ?

AFAIK the new value of ->cur should be visible to other CPUs when smp_mb() 
returns. Here's a definition of smp_mb() from Paul's article:

smp_mb(): "memory barrier" that orders both loads and stores. This means loads 
and stores preceding the memory barrier are committed to memory before any 
loads and stores following the memory barrier.

[ http://www.linuxjournal.com/article/8211 ]

> My understanding is that it only garantees that all stores before it
> must be visible before any store after mb. (yes, mb implies rmb, but
> I think it does not matter if CPU1 adds itself to nonhz mask after
> CPU0 reads nohz_cpu_mask). This means that CPU1 can read the stale
> value of ->cur. I guess I am wrong, but I can't prove it to myself.
> 
> Could you please clarify this?
> 
> Even simpler question:
> 
> CPU0
> 	var = 1;
> 	wmb();
> 
> after that CPU1 does rmb().
> 
> Does it garantees that CPU1 will see the new value of var?

Again, going by the above article, I would expect CPU1 to see the new value of 
var.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
