Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbVG3HTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVG3HTF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 03:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVG3HTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 03:19:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:33709 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262991AbVG3HTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 03:19:02 -0400
Date: Sat, 30 Jul 2005 09:19:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       John Hawkes <hawkes@sgi.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [sched, patch] better wake-balancing, #3
Message-ID: <20050730071917.GA31822@elte.hu>
References: <42E98DEA.9090606@yahoo.com.au> <200507290627.j6T6Rrg06842@unix-os.sc.intel.com> <20050729114822.GA25249@elte.hu> <20050729141311.GA4154@elte.hu> <20050729150207.GA6332@elte.hu> <20050729162108.GA10243@elte.hu> <42EAC504.3000300@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EAC504.3000300@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > here's an updated patch. It handles one more detail: on SCHED_SMT we 
> > should check the idleness of siblings too. Benchmark numbers still 
> > look good.
> 
> Maybe. Ken hasn't measured the effect of wake balancing in 2.6.13, 
> which is quite a lot different to that found in 2.6.12.
> 
> I don't really like having a hard cutoff like that -wake balancing can 
> be important for IO workloads, though I haven't measured for a long 
> time. [...]

well, i have measured it, and it was a win for just about everything 
that is not idle, and even for an IPC (SysV semaphores) half-idle 
workload i've measured a 3% gain. No performance loss in tbench either, 
which is clearly the most sensitive to affine/passive balancing. But i'd 
like to see what Ken's (and others') numbers are.

the hard cutoff also has the benefit that it allows us to potentially 
make wakeup migration _more_ agressive in the future. So instead of 
having to think about weakening it due to the tradeoffs present in e.g.  
Ken's workload, we can actually make it stronger.

> [...] In IPC workloads, the cache affinity of local wakeups becomes 
> less apparent when the runqueue gets lots of tasks on it, however 
> benefits of IO affinity will generally remain. Especially on NUMA 
> systems.

especially on NUMA, if the migration-target CPU (this_cpu) is not at 
least partially idle, i'd be quite uneasy to passive balance from 
another node. I suspect this needs numbers from Martin and John?

> fork/clone/exec/etc balancing really doesn't do anything to capture 
> this kind of relationship between tasks and between tasks and IRQ 
> sources. Without wake balancing we basically have a completely random 
> scattering of tasks.

Ken's workload is a heavy IO one with lots of IRQ sources. And precisely 
for such type of workloads usually the best tactic is to leave the task 
alone and queue it wherever it last ran.

whenever there's a strong (and exclusive) relationship between tasks and 
individual interrupt sources, explicit binding to CPUs/groups of CPUs is 
the best method. In any case, more measurements are needed.

	Ingo
