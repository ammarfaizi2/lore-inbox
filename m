Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUBBPni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 10:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbUBBPnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 10:43:37 -0500
Received: from mx1.elte.hu ([157.181.1.137]:34490 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265693AbUBBPne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 10:43:34 -0500
Date: Mon, 2 Feb 2004 16:40:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       dipankar@in.ibm.com
Subject: Re: [PATCH 3/4] 2.6.2-rc2-mm2 CPU Hotplug: The Core
Message-ID: <20040202154040.GA5895@elte.hu>
References: <20040202111224.DE5402C26D@lists.samba.org> <Pine.LNX.4.58.0402020741250.16748@devserv.devel.redhat.com> <20040202132230.GA21772@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202132230.GA21772@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> One possibility is the migration request will be in CPU 0's queue and
> not in CPU1's? Hence there won't be anything (in CPU1's migration
> request queue) to process when CPU1 is brought down. However by the
> time migration thread on CPU 0 gets around to processing the request,
> CPU1 is already down and hence the check.

IMO the semantics of this area are not defined clearly enough, hence
these problems. __migrate_task(cpu) is a wrapper around
set_cpus_allowed(). If a CPU goes away atomically then the only source
of some non-online CPU is from user-space or unsafe references of
smp_processor_id() [which are also preempt-unsafe so need to be fixed
anyway]. set_cpus_allowed() deals with invalid masks just fine: it does
nothing and returns an error. The following sequence shouldnt be
possible to trigger if CPU-down is an atomic event:

        /* Affinity changed (again). */
        if (!cpu_isset(dest_cpu, p->cpus_allowed))
                goto out;
        /* CPU went down. */
        if (cpu_is_offline(dest_cpu))
                goto out;

because p->cpus_allowed is fixed up atomically. If this task is in
CPU1's migration queue then the CPU-down mechanism takes care of it. If
this task is in CPU0's migration queue then the task will be migrated
off CPU1 by the CPU-down mechanism and CPU0's migration wont have alot
of work left.

kernel-space threads that rely on running on a specific CPU need the
callback mechanism on CPU-down, so there's no problem with them.

user-space tasks that rely on running on a specific CPU need a callback
too. (probably in the form of a signal, which, if unhandled, terminates
the task.) Eg. if a webserver has a mode to run one thread per CPU, then
the server needs to adapt to the new situation when a CPU goes away. We
cannot just unilaterally migrate a task and violate its affinity.

another thing: if the migrate-irqs op is done atomically too (together
with the migrate-tasks op) then the special-cases in idle_balance() and
rebalance_tick() could go away too.

	Ingo
