Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWHAOng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWHAOng (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWHAOn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:43:27 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:31407 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161009AbWHAOnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:43:00 -0400
Message-ID: <44CF6433.50108@in.ibm.com>
Date: Tue, 01 Aug 2006 19:54:51 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
References: <44CE57EF.2090409@sgi.com>
In-Reply-To: <44CE57EF.2090409@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
>  
> -#define TASKSTATS_VERSION	1
> +#define TASKSTATS_VERSION	2
> +#define TASK_COMM_LEN		16
>  

We should find a way to keep this in sync with with the definition
in linux/sched.h (won't we a warning if both this header and
linux/sched.h are included together?)



> + * fill in basic accounting fields
> + */
> +static void bacct_add_tsk(struct taskstats *stats, struct task_struct *tsk)
> +{
> +	u64	run_time;
> +	struct timespec uptime;
> +
> +	/* calculate run_time in nsec */
> +	do_posix_clock_monotonic_gettime(&uptime);
> +	run_time = (u64)uptime.tv_sec*NSEC_PER_SEC + uptime.tv_nsec;
> +	run_time -= (u64)current->group_leader->start_time.tv_sec * NSEC_PER_SEC
> +			+ current->group_leader->start_time.tv_nsec;
> +	do_div(run_time, NSEC_PER_USEC);	/* rebase run_time to usec */
> +	stats->ac_etime = run_time;
> +	do_div(run_time, USEC_PER_SEC);		/* rebase run_time to sec */
> +	stats->ac_btime = xtime.tv_sec - run_time;
> +	if (thread_group_leader(tsk)) {
> +		stats->ac_exitcode = tsk->exit_code;
> +		if (tsk->flags & PF_FORKNOEXEC)
> +			stats->ac_flag |= AFORK;
> +	}
> +	if (tsk->flags & PF_SUPERPRIV)
> +		stats->ac_flag |= ASU;
> +	if (tsk->flags & PF_DUMPCORE)
> +		stats->ac_flag |= ACORE;
> +	if (tsk->flags & PF_SIGNALED)
> +		stats->ac_flag |= AXSIG;
> +	stats->ac_nice	= task_nice(tsk);
> +	stats->ac_sched	= tsk->policy;
> +	stats->ac_uid	= tsk->uid;
> +	stats->ac_gid	= tsk->gid;
> +	stats->ac_pid	= tsk->pid;
> +	stats->ac_ppid	= (tsk->parent) ? tsk->parent->pid : 0;
> +	stats->ac_utime	= tsk->utime * USEC_PER_TICK;
> +	stats->ac_stime	= tsk->stime * USEC_PER_TICK;

I think you should use the portable cputime_xxxx() API since
tsk->utime and tsk->stime are of type cputime_t


> +	/* Each process gets a minimum of a half tick cpu time */
> +	if ((stats->ac_utime == 0) && (stats->ac_stime == 0)) {
> +		stats->ac_stime = USEC_PER_TICK/2;
> +	}
> +

This is confusing. Half tick does not make any sense from the
scheduler view point (or am I missing something?), so why
return half a tick to the user.


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
