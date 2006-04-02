Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWDBEsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWDBEsf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 23:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWDBEsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 23:48:35 -0500
Received: from mga05.intel.com ([192.55.52.89]:64815 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750725AbWDBEse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 23:48:34 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,154,1141632000"; 
   d="scan'208"; a="18714901:sNHT16748837"
Date: Sat, 1 Apr 2006 20:48:24 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: smpnice loadbalancing with high priority tasks
Message-ID: <20060401204824.A8662@unix-os.sc.intel.com>
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <442B3111.5030808@bigpond.net.au>; from pwil3058@bigpond.net.au on Thu, Mar 30, 2006 at 12:14:57PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

There are still issues which we need to address.. These are surfacing
as we are patching issue by issue(instead of addressing the root issue, which
is: presence of high priority tasks messes up load balancing of normal
priority tasks..)

for example

a) on a simple 4-way MP system, if we have one high priority and 4 normal
priority tasks, with smpnice we would like to see the high priority task
scheduled on one cpu, two other cpus getting one normal task each and the
fourth cpu getting the remaining two normal tasks. but with smpnice that 
extra normal priority task keeps jumping from one cpu to another cpu having
the normal priority task.

This is because of the busiest_has_loaded_cpus, nr_loaded_cpus logic.. We
are not including the cpu with high priority task in max_load calculations
but including that in total and avg_load calcuations.. leading to max_load <
avg_load and load balance between cpus running normal priority tasks(2 Vs 1)
will always show imbalanace as one normal priority and the extra normal
priority task will keep moving from one cpu to another cpu having
normal priority task..

b) on a simple DP system, if we have two high priority and two normal priority
tasks, ideally we should schedule one high and one normal priority task on 
each cpu.. current code doesn't find an imbalance if both the normal priority
tasks gets scheduled on the same cpu(running one high priority task)

there may not be benchmarks which expose these conditions.. but I think
we haven't addressed the corner case conditions well enough..

thanks,
suresh
