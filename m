Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945989AbWJZXVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbWJZXVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945984AbWJZXVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:21:18 -0400
Received: from host-233-54.several.ru ([213.234.233.54]:62853 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1945989AbWJZXVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:21:16 -0400
Date: Fri, 27 Oct 2006 03:21:06 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] bacct_add_tsk: fix unsafe and wrong parent/group_leader dereference
Message-ID: <20061026232106.GA523@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. ts = timespec_sub(uptime, current->group_leader->start_time);

   It is possible that current != tsk. Probably it was supposed
   to be 'tsk->group_leader->start_time. But why we are reading
   group_leader's start_time ? This accounting is per thread,
   not per procees, I changed this to 'tsk->start_time.
   Please corect me.

2. stats->ac_ppid = (tsk->parent) ? tsk->parent->pid : 0;

   tsk->parent never == NULL, and it is unsafe to dereference it.
   Both the task and it's parent may exit after the caller unlocks
   tasklist_lock, the memory could be unmapped (DEBUG_SLAB).
   (And we should use ->real_parent->tgid in fact).

Q: I don't understand the 'if (thread_group_leader(tsk))' check.
Why it is needed ?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/tsacct.c~2_par_fix	2006-10-22 18:24:03.000000000 +0400
+++ STATS/kernel/tsacct.c	2006-10-27 01:03:26.000000000 +0400
@@ -36,7 +36,7 @@ void bacct_add_tsk(struct taskstats *sta
 
 	/* calculate task elapsed time in timespec */
 	do_posix_clock_monotonic_gettime(&uptime);
-	ts = timespec_sub(uptime, current->group_leader->start_time);
+	ts = timespec_sub(uptime, tsk->start_time);
 	/* rebase elapsed time to usec */
 	ac_etime = timespec_to_ns(&ts);
 	do_div(ac_etime, NSEC_PER_USEC);
@@ -58,7 +58,10 @@ void bacct_add_tsk(struct taskstats *sta
 	stats->ac_uid	 = tsk->uid;
 	stats->ac_gid	 = tsk->gid;
 	stats->ac_pid	 = tsk->pid;
-	stats->ac_ppid	 = (tsk->parent) ? tsk->parent->pid : 0;
+	rcu_read_lock();
+	stats->ac_ppid	 = pid_alive(tsk) ?
+				rcu_dereference(tsk->real_parent)->tgid : 0;
+	rcu_read_unlock();
 	stats->ac_utime	 = cputime_to_msecs(tsk->utime) * USEC_PER_MSEC;
 	stats->ac_stime	 = cputime_to_msecs(tsk->stime) * USEC_PER_MSEC;
 	stats->ac_minflt = tsk->min_flt;

