Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267333AbUHTQA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267333AbUHTQA7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUHTQA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:00:58 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:14411 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S267333AbUHTQA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:00:56 -0400
Date: Fri, 20 Aug 2004 08:57:17 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
Message-ID: <20040820155717.GF1243@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408191724.04422.jbarnes@engr.sgi.com> <20040819233837.GA2723@us.ibm.com> <200408192016.10064.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408192016.10064.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 08:16:10PM -0400, Jesse Barnes wrote:
> On Thursday, August 19, 2004 7:38 pm, Paul E. McKenney wrote:
> > > 41.4% 58.6%    0%  rcu_state
> > > 61.3% 38.7%    0%    __rcu_process_callbacks+0x260
> > > 41.4% 58.6%    0%    rcu_check_quiescent_state+0xf0
> > >
> > > So it looks like the dcache lock is the biggest problem on this system
> > > with this load.  And although the rcu stuff has improved tremendously for
> > > this system, it's still highly contended.
> >
> > Was this run using all of Manfred's RCU patches?  If not, it would be
> > interesting to see what you get with full RCU_HUGE patchset.
> 
> So that stuff isn't in 2.6.8.1-mm1?  What I tested was pretty close to a stock 
> version of that tree.  Where can I grab a version of that patchset that 
> applies to a recent kernel?

If I am not too confused, you need #4 and #5 out of Manfred's set of
five RCU_HUGE patchset.  They are at:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=108546358123902&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=108546384711797&w=2

A little work will be required to get them to apply.  For example, in
the first patch, instead of:

	spin_lock(&rcu_state.mutex);

one would say:

	spin_lock(&rsp->lock);

due to the addition of the _bh() primitives.  The "rcu_ctrlblk."
and "rcu_state." have been replaced by pointers in order to handle
multiple different types of grace periods:

o	Traditional grace periods based on context switch, executing
	in user mode, or running the idle loop.

o	New-age low-latency grace periods based on running with
	interrupts enabled.

							Thanx, Paul
