Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbVAYWOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbVAYWOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVAYWKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:10:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48863 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262218AbVAYWJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:09:12 -0500
Date: Tue, 25 Jan 2005 14:09:05 -0800
Message-Id: <200501252209.j0PM95MX000477@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Alexander Nyberg <alexn@dsv.su.se>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PANIC in check_process_timers() running 2.6.11-rc2-mm1
In-Reply-To: Alexander Nyberg's message of  Tuesday, 25 January 2005 18:06:42 +0100 <1106672802.705.37.camel@boxen>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for tracking that down.  It was intended that such things would not
be possible because getting into that code in the first place should be
ruled out while exiting.  That removes the requirement for any special case
check in the common path.  But, it was done too late since it hadn't
occurred to me that ->live going zero itself created a problem.

Please try this patch instead of the one you posted.  This patch goes on
top of all the patches I posted, and so should apply to -mm1 fine.  But
because the context nearby changes a lot in the various patches, this one
won't apply after just the cputimers patch without the succeeding three.

Andrew, if you prefer, I can send a replacement for the cputimers patch
that includes this fix, and replacements for the three later patches that
will apply after that one.  If you use this patch, make sure it goes after
the three later patches (itimers and sigxcpu).


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -753,14 +753,6 @@ static void exit_notify(struct task_stru
 		state = EXIT_DEAD;
 	tsk->exit_state = state;
 
-	/*
-	 * Clear these here so that update_process_times() won't try to deliver
-	 * itimer, profile or rlimit signals to this task while it is in late exit.
-	 */
- 	tsk->it_virt_expires = cputime_zero;
- 	tsk->it_prof_expires = cputime_zero;
-	tsk->it_sched_expires = 0;
-
 	write_unlock_irq(&tasklist_lock);
 
 	list_for_each_safe(_p, _n, &ptrace_dead) {
@@ -801,6 +793,14 @@ fastcall NORET_TYPE void do_exit(long co
 
 	tsk->flags |= PF_EXITING;
 
+	/*
+	 * Make sure we don't try to process any timer firings
+	 * while we are already exiting.
+	 */
+ 	tsk->it_virt_expires = cputime_zero;
+ 	tsk->it_prof_expires = cputime_zero;
+	tsk->it_sched_expires = 0;
+
 	if (unlikely(in_atomic()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
 				current->comm, current->pid,
