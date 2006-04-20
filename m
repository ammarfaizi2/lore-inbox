Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWDTXLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWDTXLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWDTXLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:11:19 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:7794 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750861AbWDTXLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:11:19 -0400
Message-ID: <44481514.4020507@bigpond.net.au>
Date: Fri, 21 Apr 2006 09:11:16 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, akpm@osdl.org
CC: Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smpnice: don't consider sched groups which are lightly
 loaded for balancing
References: <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060419182444.A5081@unix-os.sc.intel.com> <444719F8.2050602@bigpond.net.au> <20060420095408.A10267@unix-os.sc.intel.com>
In-Reply-To: <20060420095408.A10267@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 20 Apr 2006 23:11:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> updated patch appended. thanks.
> 
> --
> with smpnice, sched groups with highest priority tasks can mask the
> imbalance between the other sched groups with in the same domain.
> This patch fixes some of the listed down scenarios by not considering
> the sched groups which are lightly loaded.
> 
> a) on a simple 4-way MP system, if we have one high priority and 4 normal
> priority tasks, with smpnice we would like to see the high priority task
> scheduled on one cpu, two other cpus getting one normal task each and the
> fourth cpu getting the remaining two normal tasks. but with current smpnice
> extra normal priority task keeps jumping from one cpu to another cpu having
> the normal priority task.  This is because of the busiest_has_loaded_cpus,
> nr_loaded_cpus logic.. We are not including the cpu with high priority
> task in max_load calculations but including that in total and avg_load
> calcuations.. leading to max_load < avg_load and load balance between
> cpus running normal priority tasks(2 Vs 1) will always show imbalanace
> as one normal priority and the extra normal priority task will keep moving
> from one cpu to another cpu having normal priority task..
> 
> b) 4-way system with HT (8 logical processors). Package-P0 T0 has a highest
> priority task, T1 is idle. Package-P1 Both T0 and T1 have 1 normal priority
> task each..  P2 and P3 are idle.  With this patch, one of the normal priority
> tasks on P1 will be moved to P2 or P3..
> 
> c) With the current weighted smp nice calculations, it doesn't always make
> sense to look at the highest weighted runqueue in the busy group..
> Consider a load balance scenario on a DP with HT system, with Package-0
> containing one high priority and one low priority, Package-1 containing
> one low priority(with other thread being idle)..  Package-1 thinks that it
> need to take the low priority thread from Package-0. And find_busiest_queue()
> returns the cpu thread with highest priority task.. And ultimately(with help
> of active load balance) we move high priority task to Package-1. And same
> continues with Package-0 now, moving high priority task from package-1 to
> package-0..  Even without the presence of active load balance, load balance
> will fail to balance the above scenario..  Fix find_busiest_queue to use
> "imbalance" when it is lightly loaded.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

Acked-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
