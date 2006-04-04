Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWDDAYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWDDAYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWDDAYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:24:34 -0400
Received: from mga05.intel.com ([192.55.52.89]:60176 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S964910AbWDDAYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 20:24:34 -0400
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,160,1141632000"; 
   d="scan'208"; a="19442818:sNHT17585470"
Date: Mon, 3 Apr 2006 17:24:08 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smpnice loadbalancing with high priority tasks
Message-ID: <20060403172408.A31895@unix-os.sc.intel.com>
References: <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <442F7871.4030405@bigpond.net.au>; from pwil3058@bigpond.net.au on Sun, Apr 02, 2006 at 05:08:33PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 05:08:33PM +1000, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > Peter,
> > 
> > There are still issues which we need to address.. These are surfacing
> > as we are patching issue by issue(instead of addressing the root issue, which
> > is: presence of high priority tasks messes up load balancing of normal
> > priority tasks..)
> > 
> > for example
> > 
> > a) on a simple 4-way MP system, if we have one high priority and 4 normal
> > priority tasks, with smpnice we would like to see the high priority task
> > scheduled on one cpu, two other cpus getting one normal task each and the
> > fourth cpu getting the remaining two normal tasks. but with smpnice that 
> > extra normal priority task keeps jumping from one cpu to another cpu having
> > the normal priority task.
> > 
> > This is because of the busiest_has_loaded_cpus, nr_loaded_cpus logic.. We
> > are not including the cpu with high priority task in max_load calculations
> > but including that in total and avg_load calcuations.. leading to max_load <
> > avg_load and load balance between cpus running normal priority tasks(2 Vs 1)
> > will always show imbalanace as one normal priority and the extra normal
> > priority task will keep moving from one cpu to another cpu having
> > normal priority task..
> 
> I can't see anything like this in the code.  

Don't you see a condition where max_load < avg_load(as mentioned in the
above example) and in this case, code ignores avg_load and imbalance
will aways be the extra normal priority task( coming from
"max_load - busiest_load_per_task") and this normal priority task keeps 
hopping from one cpu to another cpu having normal priority task..

> Can you send a patch to fix 
> what you think the problem in the is?

I am looking at ways in fixing all these issues cleanly... I don't have
a clean solution yet...

> 
> The effect you describe can be caused by other tasks running on the 
> system (see below for fuller description).
> 
> > 
> > b) on a simple DP system, if we have two high priority and two normal priority
> > tasks, ideally we should schedule one high and one normal priority task on 
> > each cpu.. current code doesn't find an imbalance if both the normal priority
> > tasks gets scheduled on the same cpu(running one high priority task)

if the system goes into this state(whatever the reason may be...), how can
the current code detect this and resolve this imbalance... (by reviewing the
code, it shows that imbalance in this particular situation can't be detected...)


> This is one of my standard tests and it works for me.  The only time the 

Force your test into the above scenario and see how it behaves... if you
simply start new processes, then exec balance will nicely balance...
things go bad only when we go into the described above state..

I can give numerous other examples which fails

c) DP system: if the cpu-0 has two high priority and cpu-1 has one normal
priority task, how can the current code detect this imbalance..

d) 4-way MP system: if the cpu-0 has two high priority tasks, cpu-1 has
one high priority and four normal priority and cpu-2,3 each has one
high priority task.. how does the current code distribute the normal
priority tasks among cpu-1,2,3... (in this case, max_load will always
point to cpu-0 and will never distribute the noraml priority tasks...)

by giving these examples I am just pointing out various corner conditions..

> This (in my opinion) is what you are seeing.

Simple review of the current code is showing all these problems... when you
start new tasks, all will be well because of fork/exec balance... but
during run time, if the system goes to a particular state, current imbalance
code behaves poorly in the presence of high priority tasks...

thanks,
suresh
