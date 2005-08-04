Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVHDOiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVHDOiw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVHDOgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:36:05 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:65425 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261738AbVHDOd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:33:59 -0400
Date: Thu, 4 Aug 2005 07:33:39 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] push rounding up of relative request to schedule_timeout()
Message-ID: <20050804143339.GE4520@us.ibm.com>
References: <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com> <Pine.LNX.4.61.0508041123220.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508041123220.3728@scrub.home>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.2005 [11:38:33 +0200], Roman Zippel wrote:
> Hi,
> 
> Andrew, please drop this patch. 
> Nish, please stop fucking around with kernel APIs.

The comment for schedule_timeout() claims:

 * Make the current task sleep until @timeout jiffies have
 * elapsed.

Currently, it does not do so. I was simply trying to make the function
do what it claims it does.

> On Wed, 3 Aug 2005, Nishanth Aravamudan wrote:
> 
> > > The "jiffies_to_msecs(msecs_to_jiffies(timeout_msecs) + 1)" case (when the 
> > > process is immediately woken up again) makes the caller suspectible to 
> > > timeout manipulations and requires constant reauditing, that no caller 
> > > gets it wrong, so it's better to avoid this error source completely.
> 
> Nish, did you read this? Is my English this bad?

Your English is fine. My point was that the +1 issues (potential
infinite timeouts) are a problem with *jiffies* not milliseconds. And
thus need to be pushed down to the jiffies layer. I think my explanation
was pretty clear.

> 
> > --- 2.6.13-rc5/kernel/timer.c	2005-08-01 12:31:53.000000000 -0700
> > +++ 2.6.13-rc5-dev/kernel/timer.c	2005-08-03 17:30:10.000000000 -0700
> > @@ -1134,7 +1134,7 @@ fastcall signed long __sched schedule_ti
> >  		}
> >  	}
> >  
> > -	expire = timeout + jiffies;
> > +	expire = timeout + jiffies + 1;
> >  
> >  	init_timer(&timer);
> >  	timer.expires = expire;
> 
> And a little later it does:
> 
> 	timeout = expire - jiffies;
> 
> which means callers can get back a larger timeout.

Hrm, maybe I will need to cache the parameter. But the only way you
would get a return value greater than requested is if schedule() returns
before the next jiffy? Which I guess could happen if a wait-queue event
or signal (if the task is set as such) occurs before the next interrupt
*and* there are no other threads running, I believe, as
process_timeout() -> try_to_wake_up() only puts the task back on the run
queue; I don't think it actually preempts the currently running task,
does it?  Just an FYI, though, that is a problem in the current code, in
the sense that we will pass back the exact same value again Let me take
a look, maybe we need to do some -1 later (or just cache the request, as
I mentioned).  Thanks for pointing this out.

> Nish, did you check and fix _all_ users? I can easily find a number of 
> users which immediately use the return value as next timeout.

I haven't fixed all users yet. I plan on trying to do that today. Would
those callers that do immediately use the return value as the next
timeout fall under the functions that should be using
time_after()/time_before()?

> There are _a_lot_ of schedule_timeout(1) for small busy loops, these are 
> asking for "please schedule until next tick". Did you check that these are 
> still ok?

According to the comment for schedule_timeout(), that is not true. They
are asking to sleep for *1* ticks, no the *next* tick. If the assumption
in the code is the latter, they have been calling this function
inappropriately for a while. They probably should be requesting
schedule_timeout(0), i.e. no sleep at all (but we still will add a timer
internally and it won't expire until the next interrupt occurs).

> schedule_timeout() is arguably a broken API, but can we please _first_ 
> come up with a plan to fix this, before we break even more?

It *is* broken, and my patch *does* fix it. I'm not suggesting it go to
Linus today, but it's ok in Andrew's tree, especially if I'm able to get
the depending patches sent out soon.

I am pretty sure there is no way to fix the problems of adding 1 without
an inter-tick position. The +1 is the closest thing we have to a
"ceiling" function with jiffies.

Thanks,
Nish
