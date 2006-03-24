Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWCXHrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWCXHrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWCXHrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:47:36 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51107 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751580AbWCXHrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:47:35 -0500
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
In-Reply-To: <442349A3.9060907@gmail.com>
References: <44216612.3060406@gmail.com> <1143099809.29668.89.camel@stark>
	 <442349A3.9060907@gmail.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 23:35:50 -0800
Message-Id: <1143185750.29668.224.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 09:21 +0800, Yi Yang wrote:
> Matt Helsley wrote:
> 
> Thanks for Matt's careful review. I'll follow your advices to modify it 
> and new version will be released soon.
> > On Wed, 2006-03-22 at 22:58 +0800, Yi Yang wrote:
> >   

<snip>

> >> +int __raise_fsevent(const char * oldname, const char * newname, u32 mask)
> >>     
> >
> > The return value of this function does not appear to be used.
> >   
> If some modules want to use it to transfer file system events reliably,  
> the return value will be very valuble,
> because the caller can retry the transfer until it successes.

Fair enough, though I hope you'll return -EFOO rather than -1, -2,...

<snip>

> >> +	int namelen = 0;
> >> +	static unsigned long last = 0;
> >> +	static int fsevent_sum = 0;
> >>     
> >
> > Yuck, static local variables. IMHO these should be globals. It would
> > make the fact they aren't protected from concurrent access more obvious
> > (see below).
> >   
> Yes, they should be global.
> >   
> >> +	if (atomic_read(&cn_fs_event_listeners) < 1)
> >> +		return 0;
> >> +
> >> +	if (jiffies - last <= fsevent_ratelimit) {
> >> +		if (fsevent_sum > fsevent_burst_limit) {
> >> +			return -1;
> >>     
> >
> > OK, so you're rate limiting the events. Shouldn't you still boost the
> > sequence number so that userspace knows some events got dropped? Also
> > perhaps you can find an appropriate error to return instead of -1.
> >   
> Good idea.
> >   
> >> +		}
> >>     
> >
> > remove unecessary braces
> >
> >   
> >> +		fsevent_sum++;
> >>     
> >
> > Looks racy to me -- what's protecting fsevent_sum from access by
> > multiple cpus?
> >   
> This just is used to limit event rate when the user space application 
> leads to an unlimited events loop.
> so it mustn't be precise, I used spinlock originally, but Andrew thinks 
> lock overhead is big, inotify has led to
> some frustrating lock overhead, so I decide to remove it, in fact 
> fsevent_sum just is the number used to limit rate,
>  some race conditions don't effect the rate limit.

OK, I can see why you would want to avoid a spinlock. However spinlocks
are not your only option. For instance you could use the per-cpu idioms
to limit the rate.

I would argue preemption should be disabled around the if-block at the
very least. Suppose your rate limit is 10k calls/sec and you have 4
procs. Each proc has a sequence of three instructions:

load fsevent_sum into register rx (rx <= 1000)
rx++ (rx <= 1001)
store contents of register rx in fsevent_sum (fsevent_sum <= 1001)


Now consider the following sequence of steps:

load fsevent_sum into rx (rx <= 1000)
<preempted>
<3 other processors each manage to increment the sum by 3333 bringing us
to 9999>
<resumed>
rx++ (rx <= 1001)
store contents of rx in fsevent_sum (fsevent_sum <= 1001)

So every processor now thinks it won't exceed the rate limit by
generating more events when in fact we've just exceeded the limit. So,
unless my example is flawed, I think you need to disable preemption
here.

Also, even if you simply disable preemption couldn't this cause the
cache line containing the sum to bounce frequently on large SMP systems?

<snip>

Cheers,
	-Matt Helsley

