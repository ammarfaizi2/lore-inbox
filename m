Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUDFOxe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbUDFOxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:53:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5032 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263851AbUDFOx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:53:27 -0400
Date: Tue, 6 Apr 2004 20:23:48 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: rusty@au1.ibm.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040406145348.GA8516@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <20040406072543.GA21626@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406072543.GA21626@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:25:43AM +0200, Ingo Molnar wrote:
> the question is, how much actual latency does the current 'freeze
> everything' solution cause?   We should prefer simplicity and debuggability 
> over cleverness of implementation - it's not like we'll have hotplug systems 
> on everyone's desk in the next year or so.
> 
> also, even assuming a hotplug CPU system, CPU replacement events are not
> that common, so the performance of the CPU-down op should not be a big
> issue. The function depends on the # of tasks only linearly, and we have
> tons of other code that is linear on the # of tasks - in fact we just
> finished removing all the quadratic functions.

Ingo,
	I obtained some latency measurements of migrate_all_tasks() on 
a 4-way 1.2 GHz Power4 PPC64 (p630) box. They are as below:

Number of Tasks		Cycles (get_cycles) spent in migrate_all_tasks (ms)
===========================================================================

     10536 			803244 (5.3 ms)
     30072  			2587940 (17 ms)


	Extending this to 100000 tasks makes the stoppage time to be for
8 million cycles (~50 ms).

	My main concern of stopping the machine for so much time
was not performance, rather the effect it may have on functioning of the 
system.  The fact that we freeze the machine for (possibly) tons of 
cycles doing nothing but migration made me uncomfortable.  _and_ the fact that 
it can very well be avoided :)

Can we rule out any side effects because of this stoppage? Watchdog timers, 
cluster heartbeats, jiffies, ..?  Not sure ..

It just felt much more "safe" and efficient to delegate migration to more 
safer time in CPU_DEAD notification, when rest of the machine is running.
Plus this avoids the cpu_is_offline check in the more hotter path 
(load_balance/try_to_wake_up)!!


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
