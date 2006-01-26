Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWAZX4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWAZX4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWAZX4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:56:43 -0500
Received: from fmr21.intel.com ([143.183.121.13]:52189 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750938AbWAZX4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:56:43 -0500
Date: Thu, 26 Jan 2006 15:56:23 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Con Kolivas <kernel@kolivas.org>, mingo@elte.hu,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: smp 'nice' bias support breaks scheduler behavior
Message-ID: <20060126155623.A19789@unix-os.sc.intel.com>
References: <20060126025220.B8521@unix-os.sc.intel.com> <200601262325.05296.kernel@kolivas.org> <43D95D04.8050802@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43D95D04.8050802@bigpond.net.au>; from pwil3058@bigpond.net.au on Fri, Jan 27, 2006 at 10:36:36AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 10:36:36AM +1100, Peter Williams wrote:
> Con Kolivas wrote:
> > On Thursday 26 January 2006 21:52, Siddha, Suresh B wrote:
> >>>[PATCH] sched: implement nice support across physical cpus on SMP
> >>
> >>I don't see imbalance calculations in find_busiest_group() take
> >>prio_bias into account. This will result in wrong imbalance value and
> >>will cause issues.
> > in 2.6.16-rc1:
> > 
> > find_busiest_group(....
> > 
> > 	load = __target_load(i, load_idx, idle);
> > else
> > 	load = __source_load(i, load_idx, idle);
> > 
> > where __target_load and __source_load is where we take into account prio_bias.

We take that into consideration only while calculating the loads.. But we
don't scale it down while calculating imbalance, resulting in the problem
I mentioned.

> > 
> > I'm not sure which code you're looking at, but Peter Williams is working on 
> > rewriting the smp nice balancing code in -mm at the moment so that is quite 
> > different from current linus tree.
> > 

Peters changes in -mm fix this issue. Will this be pushed to Linus tree
before 2.6.16 comes out?

> 
> Yes, indeed.  And it would be very helpful if people interested in this 
> topic (and that have test suites designed to test whether "niceness" is 
> being well balanced across CPUs) could test it.  This is especially the 
> case for larger systems as I do not have ready access for testing on them.

I don't have any test suites for testing "niceness". But I can def check
more to make sure that it doesn't cause any regression :)

thanks,
suresh

> 
> > 
> > 
> >>For example on a DP system with HT, if there are three runnable processes
> >>(simple infinite loop with same nice value), this patch is resulting in
> >>bouncing of these 3 processes from one processor to another...Lets assume
> >>if the 3 processes are scheduled as 2 in package-0 and 1 in package1..
> >>Now when the busy processor on package-1 does load balance and as
> >>imbalance doesn't take "prio_bias" into account, this will kick active
> >>load balance on package-0.. And this is continuing for ever, resulting
> >>in bouncing from one processor to another.
> >>
> >>Even when the system is completely loaded and if there is an imbalance,
> >>this patch causes wrong imabalance counts and cause unoptimized
> >>movements.
> >>
> >>Do you want to look into this and post a patch for 2.6.16?
