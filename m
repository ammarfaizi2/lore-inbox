Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUDFHZd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263659AbUDFHZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:25:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64457 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263653AbUDFHZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:25:25 -0400
Date: Tue, 6 Apr 2004 09:25:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: rusty@au1.ibm.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040406072543.GA21626@elte.hu>
References: <20040405121824.GA8497@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405121824.GA8497@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> Hi Rusty,
> 	migrate_all_tasks is currently run with rest of the machine
> stopped. It iterates thr' the complete task table, turning off cpu
> affinity of any task that it finds affine to the dying cpu. Depending
> on the task table size this can take considerable time. All this time
> machine is stopped, doing nothing.

this is being done to keep things simple and fast - to avoid the
special-cases (hotplug hooks) in various bits of scheduler code.

> The solution that I came up with (which can be shot down if you think
> its not correct/good :-) which meets both the above goals was to have
> idle task put to the _front_ of the dying CPU's runqueue at the
> highest priority possible. This cause idle thread to run _immediately_
> after kstopmachine thread yields. Idle thread notices that its cpu is
> offline and dies quickly. Task migration can then be done at leisure
> in CPU_DEAD notification, when rest of the CPUs are running.

nice. The best thing is that your patch also removes a special-case from
the hot path.

> +/* Add task at the _front_ of it's priority queue - Used by CPU offline code */
> +static inline void __enqueue_task(struct task_struct *p, prio_array_t *array)

btw., there's now an enqueue_task_head() function in the -mm scheduler
[to do cache-cold migration], if you build ontop of -mm you'll have one
less infrastructure bit to worry about.

the question is, how much actual latency does the current 'freeze
everything' solution cause? We should prefer simplicity and
debuggability over cleverness of implementation - it's not like we'll
have hotplug systems on everyone's desk in the next year or so.

also, even assuming a hotplug CPU system, CPU replacement events are not
that common, so the performance of the CPU-down op should not be a big
issue. The function depends on the # of tasks only linearly, and we have
tons of other code that is linear on the # of tasks - in fact we just
finished removing all the quadratic functions.

	Ingo
