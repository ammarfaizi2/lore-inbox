Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTETOYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 10:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTETOYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 10:24:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1763 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263791AbTETOYG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 10:24:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: userspace irq balancer
Date: Tue, 20 May 2003 09:35:22 -0500
User-Agent: KMail/1.4.3
Cc: "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
       mbligh@aracnet.com, wli@holomorphy.com, arjanv@redhat.com,
       pbadari@us.ibm.com, linux-kernel@vger.kernel.org, gh@us.ibm.com,
       johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
References: <88560000.1053409990@[10.10.2.4]> <200305200907.41443.habanero@us.ibm.com> <20030520142158.GA27982@gtf.org>
In-Reply-To: <20030520142158.GA27982@gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305200935.22545.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 May 2003 09:21, Jeff Garzik wrote:
> On Tue, May 20, 2003 at 09:07:41AM -0500, Andrew Theurer wrote:
> > On Tuesday 20 May 2003 01:40, David S. Miller wrote:
> > >    From: Dave Hansen <haveblue@us.ibm.com>
> > >    Date: 19 May 2003 23:36:23 -0700
> > >
> > >    I don't even think we can do that.  That code was being integrated
> > >    around the same time that our Specweb setup decided to go south on
> > > us and start physically frying itself.
> > >
> > > This gets more amusing by the second.  Let's kill this code
> > > already.  People who like the current algorithms can push
> > > them into the userspace solution.
> >
> > Remember this all started with some idea of "fairness" among cpus and
> > very little to do with performance.   particularly on P4 with HT, where
> > the first logical cpu got all the ints and tasks running on that cpu were
> > slower than other cpus.  This was in most cases the highest performing
> > situation, -but- it was unfair to the tasks running on cpu0.  irq_balance
> > fixed this with a random target cpu that was in theory supposed to not
> > change often enough to preserve cache warmth.  In practice is the target
> > cpus changed too often which thrashed cache and the HW overhead of
> > changing the destination that often was way way to high.
>
> You call that a fix?  ;-)  I call that working around a bug.
>
> If tasks run slower on cpuX than cpuY because of a heavier int load,
> that's the fault of the scheduler not the irqbalancer, be it in-kernel
> or userspace.  If there's a lesser-utilized cpu the task needs to be
> migrated to that cpu from the irq-loaded one, when CPU accounting
> notices the kernel interrupt handling having an impact.

On paper it sounds good but it may be more difficult (and not perfect) in 
practice.  For example, if you have one runnable task per cpu, moving it to 
another cpu would not help.  To preserve fairness, all you could do is swap 
the tasks around, which would thrash the cache pretty well.  Also, the int 
load may be very dynamic, so you need to be really careful and make sure you 
are measuring sustained int load.  

However I do agree, we need something in the scheduler, in particular 
something to modify max_load and load in find_busiest_queue, based on a int 
load average for those cpus.  

-Andrew
