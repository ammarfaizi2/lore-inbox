Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422679AbWHUQqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422679AbWHUQqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 12:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422697AbWHUQqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 12:46:39 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30147 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422679AbWHUQqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 12:46:38 -0400
Date: Mon, 21 Aug 2006 22:15:53 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 0/7] CPU controller - V1
Message-ID: <20060821164553.GA21130@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <1156156960.7772.38.camel@Homer.simpson.net> <20060821124830.GB14291@in.ibm.com> <1156180241.6582.69.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156180241.6582.69.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 05:10:41PM +0000, Mike Galbraith wrote:
> I must be missing something.  If current and awakening tasks have
> separate runqueues, task_rq(awakening)->curr != current.  We won't look
> at current->prio, so won't resched(current).

Ok ..we have two types of runqueues here:

1. struct task_grp_rq
	per-task-group-per-cpu runqueue, which holds ready-to-run tasks 
	belonging to the group in active and expired arrays.

2. struct rq
	per-cpu runqueue, which holds ready-to-run task-groups in active and 
	expired arrays. This structure also holds some members like
	curr, nr_running etc which more or less have the same significance as 
	the current runqueue members.

task_rq(tsk) still extracts "struct rq", while
task_grp(tsk)->rq[task_cpu(tsk)] extracts "struct task_grp_rq".

Hence task_rq(awakening)->curr == current, which should be sufficient to 
resched(current), although I think there is a bug in current code 
(irrespective of these patches):

try_to_wake_up() :
	
	...

        if (!sync || cpu != this_cpu) {
                if (TASK_PREEMPTS_CURR(p, rq))
                        resched_task(rq->curr);
        }
        success = 1;

	...

TASK_PREEMPTS_CURR() is examined and resched_task() is called only if 
(cpu != this_cpu). What about the case (cpu == this_cpu) - who will
call resched_task() on current? I had expected the back-end of interrupt
handling to do that, but didnt find any code to do so.

-- 
Regards,
vatsa
