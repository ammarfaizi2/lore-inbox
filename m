Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVEMI1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVEMI1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 04:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVEMI1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 04:27:47 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:25508 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262302AbVEMI1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 04:27:06 -0400
Message-ID: <428464D5.10702@yahoo.com.au>
Date: Fri, 13 May 2005 18:27:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: vatsa@in.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       george@mvista.com, jdike@addtoit.com,
       Jesse Barnes <jesse.barnes@intel.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050512171251.GA21656@in.ibm.com> <OF86BA5D99.FE159896-ONC1256FFF.0062E865-C1256FFF.0063A681@de.ibm.com> <20050513062330.GD23705@in.ibm.com> <42845456.3080908@yahoo.com.au> <20050513080424.GA31206@elte.hu>
In-Reply-To: <20050513080424.GA31206@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> the power equation is really easy: the implicit cost of a deep CPU sleep 
> is say 1-2 msecs. (that's how long it takes to shut the CPU and the bus 
> down, etc.) If we do an exponential backoff we periodically re-wake the 
> CPU fully up again - wasting 1-2msec (or more) more power. With the 
> watchdog solution we have more overhead on the busy CPU but it takes 
> _much_ less power for a truly idle CPU to be turned off. [the true 
> 'effective cost' all depends on the scheduling pattern as well, but the 
> calculation before is still valid.] Whatever the algorithmic overhead of 
> the watchdog code, it's dwarved by the power overhead caused by false 
> idle-wakeups of CPUs under exponential backoff.
> 

Well, it really depends on how it is implemented, and what tradeoffs
you make.

Let's say that you don't start deep sleeping until you've backed off
to 64ms rebalancing. Now the CPU power consumption is reduced to less
than 2% of ideal.

Now we don't have to worry about uniprocessor, and SMP systems that
go *completely* idle can have mechanism to indefinitely deep sleep
all CPUs until there is real work.

What you're left with are SMP systems with *some* activity happening,
and of those, I bet most idle CPUs will have other reasons to be woken
up other than the scheduler tick anyway.

And don't forget that the watchdog approach can just as easily deep
sleep a CPU only to immediately wake it up again if it detects an
imbalance.

So in terms of real, system wide power savings, I'm guessing the
difference would really be immesurable.

And the CPU usage / wakeup cost arguments cut both ways. The busy
CPUs have to do extra work in the watchdog case.

> the watchdog solution - despite being more complex - is also more 
> orthogonal in that it does not change the balancing decisions at all - 
> they just get offloaded to another CPU. The exponential backoff OTOH 
> materially changes how we do SMP balancing - which might or might not 
> matter much, but it will always depend on circumstances. So in the long 
> run the watchdog solution is probably easier to control. (because it's 
> just an algorithm offload, not a material scheduling feature.)
> 

Well so does the watchdog, really. But it's probably not like you have
to *really* tune sleep algorithms _exactly_ right, yeah? So long as you
get within even 5% of total theoretical power saving on SMP systems,
it's likely good enough.

> so unless there are strong implementational arguments against the 
> watchdog solution, i definitely think it's the higher quality solution, 
> both in terms of power savings, and in terms of impact.
> 

I'm think power savings will be unmeasurable between the two approaches,
backoff will be quite a lot less complex, and have less impact on CPUs
that are busy doing real work.

Smells like a bakeoff coming up :)

