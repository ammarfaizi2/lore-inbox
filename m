Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267264AbUHDGFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267264AbUHDGFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUHDGFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:05:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:232 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267264AbUHDGFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:05:49 -0400
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
From: Nathan Lynch <nathanl@austin.ibm.com>
To: dipankar@in.ibm.com
Cc: V Srivatsa <vatsa@in.ibm.com>, Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, zwane@linuxpower.ca
In-Reply-To: <1091478386.29556.36.camel@pants.austin.ibm.com>
References: <20040802094907.GA3945@in.ibm.com>
	 <20040802095741.GA4599@in.ibm.com>
	 <1091475519.29556.4.camel@pants.austin.ibm.com>
	 <1091478386.29556.36.camel@pants.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1091567239.28036.36.camel@biclops.private.network>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 03 Aug 2004 16:07:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-02 at 15:26, Nathan Lynch wrote:
> On Mon, 2004-08-02 at 14:38, Nathan Lynch wrote:
> > Could you try on 2.6.8-rc2-mm2 along with this patch?  Vatsa had a patch
> > go in that should prevent the crash you are seeing -- the patch below is
> > needed to prevent the same crash in the offline case.  This check used
> > to be in load_balance and some other scheduler functions, iirc; does
> > anyone know why they were removed?
> 
> Er, I meant to put the check in rebalance_tick, not load_balance.
> 
> However, after a few minutes with this, I hit the BUG_ON in the CPU_DEAD
> case in migration_call; not sure whether this is a separate issue.

So, with the cpu_is_offline check in rebalance_tick on top of
2.6.8-rc2-mm2, this is the BUG_ON in migration_call I tend to hit while
hotplugging cpus as quickly as possible while running make -j 40:

        case CPU_DEAD:
                migrate_all_tasks(cpu);
                rq = cpu_rq(cpu);
                kthread_stop(rq->migration_thread);
                rq->migration_thread = NULL;
                /* Idle task back to normal (off runqueue, low prio) */
                rq = task_rq_lock(rq->idle, &flags);
                deactivate_task(rq->idle, rq);
                rq->idle->static_prio = MAX_PRIO;
                __setscheduler(rq->idle, SCHED_NORMAL, 0);
                task_rq_unlock(rq, &flags);
                BUG_ON(rq->nr_running != 0);

I can reproduce this on both ppc64 and i386.  Does anyone know why this
is happening?

If I remove the BUG_ON, things seem to go ok, but I doubt that's the
right thing to do.

Nathan


