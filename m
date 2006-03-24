Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422835AbWCXKKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbWCXKKO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 05:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWCXKKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 05:10:13 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9095 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1422832AbWCXKJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 05:09:59 -0500
Date: Fri, 24 Mar 2006 13:09:34 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Yi Yang <yang.y.yi@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
Message-ID: <20060324100934.GA21697@2ka.mipt.ru>
References: <44216612.3060406@gmail.com> <1143099809.29668.89.camel@stark> <442349A3.9060907@gmail.com> <1143185750.29668.224.camel@stark> <20060324081149.GC5426@2ka.mipt.ru> <1143193337.29668.241.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143193337.29668.241.camel@stark>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Mar 2006 13:09:35 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 01:42:17AM -0800, Matt Helsley (matthltc@us.ibm.com) wrote:
> On Fri, 2006-03-24 at 11:11 +0300, Evgeniy Polyakov wrote:
> > On Thu, Mar 23, 2006 at 11:35:50PM -0800, Matt Helsley (matthltc@us.ibm.com) wrote:
> > > I would argue preemption should be disabled around the if-block at the
> > > very least. Suppose your rate limit is 10k calls/sec and you have 4
> > > procs. Each proc has a sequence of three instructions:
> > > 
> > > load fsevent_sum into register rx (rx <= 1000)
> > > rx++ (rx <= 1001)
> > > store contents of register rx in fsevent_sum (fsevent_sum <= 1001)
> > > 
> > > 
> > > Now consider the following sequence of steps:
> > > 
> > > load fsevent_sum into rx (rx <= 1000)
> > > <preempted>
> > > <3 other processors each manage to increment the sum by 3333 bringing us
> > > to 9999>
> > > <resumed>
> > > rx++ (rx <= 1001)
> > > store contents of rx in fsevent_sum (fsevent_sum <= 1001)
> > > 
> > > So every processor now thinks it won't exceed the rate limit by
> > > generating more events when in fact we've just exceeded the limit. So,
> > > unless my example is flawed, I think you need to disable preemption
> > > here.
> > 
> > Doesn't it just exceed the limit by one event per cpu?
> 
> The example exceeds it by one at the time of the final store. Thanks to
> the fact that the value is then 1001 it may shortly be exceeded by much
> more than 1.

+
+       if (jiffies - last <= fsevent_ratelimit) {
+               if (fsevent_sum > fsevent_burst_limit)
+                       return -2;
+               fsevent_sum++;

Only process (and not process' syscall) can preempt us here, 
so fsevent_sum can only exceed fsevent_burst_limit by one per process
(process can not preempt itself, so when it has finished syscall which
ends up in event generation, fsevent_sum will be increased).

+       } else {
+               last = jiffies;
+               fsevent_sum = 0;
+       }

Actually, since jiffies and atomic operations are already used, I do not
think addition of new atomic_inc_return or something similar will 
even somehow change the picture.


> Cheers,
> 	-Matt Helsley

-- 
	Evgeniy Polyakov
