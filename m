Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWGaVuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWGaVuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbWGaVuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:50:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44755 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030480AbWGaVuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:50:21 -0400
Message-ID: <44CE7B0E.30805@sgi.com>
Date: Mon, 31 Jul 2006 14:50:06 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
References: <44CE57EF.2090409@sgi.com> <44CE66C3.7020804@watson.ibm.com>
In-Reply-To: <44CE66C3.7020804@watson.ibm.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
> 
>>This patch adds a few basic accounting fields to the taskstat
>>struct and a bacct_add_tsk() routine to fill the data on
>>exit.
>>
>>
>>Signed-off-by: Jay Lan <jlan@sgi.com>
>>
>>
>>------------------------------------------------------------------------
>>
>>Index: linux/include/linux/taskstats.h
>>===================================================================
>>--- linux.orig/include/linux/taskstats.h	2006-07-31 11:38:54.132326042 -0700
>>+++ linux/include/linux/taskstats.h	2006-07-31 11:42:10.634609610 -0700
>>@@ -2,6 +2,7 @@
>>  *
>>  * Copyright (C) Shailabh Nagar, IBM Corp. 2006
>>  *           (C) Balbir Singh,   IBM Corp. 2006
>>+ *           (C) Jay Lan,        SGI, 2006
>>  *
>>  * This program is free software; you can redistribute it and/or modify it
>>  * under the terms of version 2.1 of the GNU Lesser General Public License
>>@@ -29,13 +30,18 @@
>>  *	c) add new fields after version comment; maintain 64-bit alignment
>>  */
>> 
>>-#define TASKSTATS_VERSION	1
>>+#define TASKSTATS_VERSION	2
>>+#define TASK_COMM_LEN		16
>> 
>> struct taskstats {
>> 
>> 	/* Version 1 */
>> 	__u16	version;
>>-	__u16	padding[3];	/* Userspace should not interpret the padding
>>+	__u8	ac_flag;	/* Record flags */
>>+	__u8	ac_nice;	/* task_nice */
>>+	__u8	ac_sched;	/* Scheduling discipline */
>>+	__u8	ac_pad;
> 
> 
> [Minor comment] The choice of fields to fill the padding is visually separate
> from the delay accounting fields which follow. Can a single field of the same
> length, say ac_uid, be put here instead ?

You are right. I will replace those __u8 fields with the exitcode.

> 
> 
> Also, is the ac_ prefix needed for the common fields like comm, uid, gid, pid
> that are pretty much coming straight out of task_struct ?

And the GNU accounting use the ac_ prefix as well...
I lean to keep ac_ prefix so that people can link those fields to those
in the task_struct. However, i am fine with either way. Let's see if
there is other opinions on the prefix.

> 
> 
>>+	__u16	padding;	/* Userspace should not interpret the padding
> 
> 
> Combine the padding's ?
> 
> 
>> 				 * field which can be replaced by useful
>> 				 * fields if struct taskstats is extended.
>> 				 */
>>@@ -88,6 +94,19 @@ struct taskstats {
>> 	__u64	cpu_run_virtual_total;
>> 	/* Delay accounting fields end */
>> 	/* version 1 ends here */
>>+
>>+	/* Basic Accounting Fields start */
>>+	char	ac_comm[TASK_COMM_LEN];	/* Command name */
>>+	__u32	ac_exitcode;		/* Exit status */
>>+	__u32	ac_uid;			/* User ID */
>>+	__u32	ac_gid;			/* Group ID */
>>+	__u32	ac_pid;			/* Process ID */
>>+	__u32	ac_ppid;		/* Parent process ID */
>>+	__u32	ac_btime;		/* Begin time [sec sinec 1970] */
> 
> 
> s/sinec/since

Good eyes! :)


> 
> 
>>+	__u64	ac_etime;		/* Elapsed time [usec] */
>>+	__u64	ac_utime;		/* User CPU time [usec] */
>>+	__u64	ac_stime;		/* SYstem CPU time [usec] */
>>+	/* Basic Accounting Fields end */
>> };
>> 
>> 
>>Index: linux/kernel/taskstats.c
>>===================================================================
>>--- linux.orig/kernel/taskstats.c	2006-07-31 11:38:54.160326367 -0700
>>+++ linux/kernel/taskstats.c	2006-07-31 11:44:54.952523699 -0700
>>@@ -3,6 +3,7 @@
>>  *
>>  * Copyright (C) Shailabh Nagar, IBM Corp. 2006
>>  *           (C) Balbir Singh,   IBM Corp. 2006
>>+ *           (C) Jay Lan,        SGI, 2006
>>  *
>>  * This program is free software; you can redistribute it and/or modify
>>  * it under the terms of the GNU General Public License as published by
>>@@ -18,6 +19,7 @@
>> 
>> #include <linux/kernel.h>
>> #include <linux/taskstats_kern.h>
>>+#include <linux/acct.h>
>> #include <linux/delayacct.h>
>> #include <linux/cpumask.h>
>> #include <linux/percpu.h>
>>@@ -172,6 +174,53 @@ static void send_cpu_listeners(struct sk
>> 	up_write(&listeners->sem);
>> }
>> 
>>+
>>+#define USEC_PER_TICK	(USEC_PER_SEC/HZ)
>>+/*
>>+ * fill in basic accounting fields
>>+ */
>>+static void bacct_add_tsk(struct taskstats *stats, struct task_struct *tsk)
>>+{
>>+	u64	run_time;
>>+	struct timespec uptime;
>>+
>>+	/* calculate run_time in nsec */
>>+	do_posix_clock_monotonic_gettime(&uptime);
> 
> 
> 
>>+	run_time = (u64)uptime.tv_sec*NSEC_PER_SEC + uptime.tv_nsec;
>>+	run_time -= (u64)current->group_leader->start_time.tv_sec * NSEC_PER_SEC
>>+			+ current->group_leader->start_time.tv_nsec;
>>+	do_div(run_time, NSEC_PER_USEC);	/* rebase run_time to usec */
>>+	stats->ac_etime = run_time;
>>+	do_div(run_time, USEC_PER_SEC);		/* rebase run_time to sec */
>>+	stats->ac_btime = xtime.tv_sec - run_time;
> 
> 
> Above chunk can be written more succintly using the new timespec_sub
> function added.
> 
> ts = timespec_sub(&current->group_leader->start_time, &uptime);

It should be
   ts = timespec_sub(&uptime, &current->group_leader->start_time);

> stats->ac_etime = timespec_to_ns(&ts);

No, ac_etime is in microseconds, not nanoseconds.

> stats->ac_btime = xtime.tv_sec - ts.tv_sec;

This is correct.

> 
> Also, if there's any chance of run_time going negative due to overflow, that
> needs to be handled in both original and succinct code (in latter you can
> check for ts->tv_sec being negative).

The type of timespec->tv_sec is of type 'int'. It will takes 68 years
for an int to wrap wround. Most kernel code are not ready to deal with
it yet.

> 
> 
>>+	if (thread_group_leader(tsk)) {
>>+		stats->ac_exitcode = tsk->exit_code;
>>+		if (tsk->flags & PF_FORKNOEXEC)
>>+			stats->ac_flag |= AFORK;
>>+	}
>>+	if (tsk->flags & PF_SUPERPRIV)
>>+		stats->ac_flag |= ASU;
>>+	if (tsk->flags & PF_DUMPCORE)
>>+		stats->ac_flag |= ACORE;
>>+	if (tsk->flags & PF_SIGNALED)
>>+		stats->ac_flag |= AXSIG;
>>+	stats->ac_nice	= task_nice(tsk);
>>+	stats->ac_sched	= tsk->policy;
>>+	stats->ac_uid	= tsk->uid;
>>+	stats->ac_gid	= tsk->gid;
>>+	stats->ac_pid	= tsk->pid;
>>+	stats->ac_ppid	= (tsk->parent) ? tsk->parent->pid : 0;
>>+	stats->ac_utime	= tsk->utime * USEC_PER_TICK;
>>+	stats->ac_stime	= tsk->stime * USEC_PER_TICK;
>>+	/* Each process gets a minimum of a half tick cpu time */
>>+	if ((stats->ac_utime == 0) && (stats->ac_stime == 0)) {
>>+		stats->ac_stime = USEC_PER_TICK/2;
>>+	}
>>+
>>+	strncpy(stats->ac_comm, tsk->comm, sizeof(stats->ac_comm));
>>+}
>>+
>>+
>> static int fill_pid(pid_t pid, struct task_struct *pidtsk,
>> 		struct taskstats *stats)
>> {
>>@@ -200,6 +249,9 @@ static int fill_pid(pid_t pid, struct ta
>> 	delayacct_add_tsk(stats, tsk);
>> 	stats->version = TASKSTATS_VERSION;
>> 
>>+	/* fill in basic acct fields */
>>+	bacct_add_tsk(stats, tsk);
>>+
> 
> 
> Should be added before stats->version is filled since that is
> a generic field, not delay accounting specific.

Will do. Thanks!


Regards,
  - jay

> 
> 
>> 	/* Define err: label here if needed */
>> 	put_task_struct(tsk);
>> 	return rc;
>>
> 
> 

