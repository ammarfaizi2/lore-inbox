Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265276AbUFBIS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUFBIS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 04:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265344AbUFBIS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 04:18:29 -0400
Received: from ozlabs.org ([203.10.76.45]:64202 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265276AbUFBIS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 04:18:26 -0400
From: Jeremy Kerr <jeremy@redfishsoftware.com.au>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix signal race during process exit
Date: Wed, 2 Jun 2004 18:13:26 +1000
User-Agent: KMail/1.6.2
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <200406021213.58305.jeremy@redfishsoftware.com.au> <20040602000812.541ee72a.akpm@osdl.org> <20040602001653.738887b2.akpm@osdl.org>
In-Reply-To: <20040602001653.738887b2.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406021813.26216.jeremy@redfishsoftware.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton <akpm@osdl.org> wrote:
> > yes?
>
> no.  It needs tasklist_lock as well, to keep the other CPU (which is doing
> wait4) at bay.

almost:

> +	tsk->it_virt_incr = 0;
> +	tsk->it_prof_value = 0;

If we're using this approach, we also need to deal with the send_sig() calls 
in do_process_times():

	if (psecs / HZ > p->rlim[RLIMIT_CPU].rlim_cur) {
		/* Send SIGXCPU every second.. */
		if (!(psecs % HZ))
			send_sig(SIGXCPU, p, 1);
		/* and SIGKILL when we go over max.. */
		if (psecs / HZ > p->rlim[RLIMIT_CPU].rlim_max)
			send_sig(SIGKILL, p, 1);
	}

by setting rlim_cur to RLIM_INFINITY.



Fix a race identified by Jeremy Kerr <jeremy@redfishsoftware.com.au>: if
update_process_times() decides to deliver a signal due to process timer
expiry, it can race with __exit_sighand()'s freeing of task->sighand.

Fix that by clearing the per-process timer state in exit_notify(), while under
local_irq_disable() and under tasklist_lock.  tasklist_lock provides exclusion
wrt release_task()'s freeing of task->sighand and local_irq_disable() provides
exclusion wrt update_process_times()'s inspection of the per-process timer
state.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>


diff -urN --exclude '.*.sw[op]' linux-2.6.7-rc2-bk2.orig/kernel/exit.c 
linux-2.6.7-rc2-bk2/kernel/exit.c
--- linux-2.6.7-rc2-bk2.orig/kernel/exit.c	2004-06-02 11:29:13.000000000 +1000
+++ linux-2.6.7-rc2-bk2/kernel/exit.c	2004-06-02 18:02:05.000000000 +1000
@@ -736,6 +736,14 @@
 	tsk->state = state;
 	tsk->flags |= PF_DEAD;
 
+	/*
+	 * Clear these here so that update_process_times() won't try to deliver
+	 * itimer, profile or rlimit signals to this task while it is in late exit.
+	 */
+	tsk->it_virt_incr = 0;
+	tsk->it_prof_value = 0;
+	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
+
 	/*
 	 * In the preemption case it must be impossible for the task
 	 * to get runnable again, so use "_raw_" unlock to keep



Jeremy







