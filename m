Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUFBHRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUFBHRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUFBHRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:17:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:19388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265091AbUFBHRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:17:37 -0400
Date: Wed, 2 Jun 2004 00:16:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: rusty@rustcorp.com.au, jeremy@redfishsoftware.com.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Fix signal race during process exit
Message-Id: <20040602001653.738887b2.akpm@osdl.org>
In-Reply-To: <20040602000812.541ee72a.akpm@osdl.org>
References: <200406021213.58305.jeremy@redfishsoftware.com.au>
	<20040601225703.6c697bed.akpm@osdl.org>
	<1086158988.29381.277.camel@bach>
	<20040602000812.541ee72a.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> yes?

no.  It needs tasklist_lock as well, to keep the other CPU (which is doing
wait4) at bay.




Fix a race identified by Jeremy Kerr <jeremy@redfishsoftware.com.au>: if
update_process_times() decides to deliver a signal due to process timer
expiry, it can race with __exit_sighand()'s freeing of task->sighand.

Fix that by clearing the per-process timer state in exit_notify(), while under
local_irq_disable() and under tasklist_lock.  tasklist_lock provides exclusion
wrt release_task()'s freeing of task->sighand and local_irq_disable() provides
exclusion wrt update_process_times()'s inspection of the per-process timer
state.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/exit.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN kernel/exit.c~really-fix-signal-race-during-process-exit kernel/exit.c
--- 25/kernel/exit.c~really-fix-signal-race-during-process-exit	2004-06-02 00:09:01.491659584 -0700
+++ 25-akpm/kernel/exit.c	2004-06-02 00:15:31.230410288 -0700
@@ -737,6 +737,13 @@ static void exit_notify(struct task_stru
 	tsk->flags |= PF_DEAD;
 
 	/*
+	 * Clear these here so that update_process_times() won't try to deliver
+	 * itimer signals to this task while it is in late exit.
+	 */
+	tsk->it_virt_incr = 0;
+	tsk->it_prof_value = 0;
+
+	/*
 	 * In the preemption case it must be impossible for the task
 	 * to get runnable again, so use "_raw_" unlock to keep
 	 * preempt_count elevated until we schedule().
_

