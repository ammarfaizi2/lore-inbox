Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVHQGfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVHQGfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbVHQGfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:35:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15490 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1750876AbVHQGfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:35:45 -0400
Date: Wed, 17 Aug 2005 08:35:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050817063544.GA6519@elte.hu>
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com> <20050817014857.GA3192@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817014857.GA3192@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> My tests are not finding even glaring races, so time to go and create 
> some torture tests before getting too much more elaborate.  10,000 
> eyes are nice (and Oleg's eyes do seem to be working especially well), 
> but a good software-test sledgehammer has its uses as well.

i've merged this to the -rt tree, and find below a delta patch relative 
to the previous patch.

	Ingo

Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c
+++ linux/kernel/exit.c
@@ -74,7 +74,6 @@ repeat: 
 		__ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
-	__exit_sighand(p);
 	/*
 	 * Note that the fastpath in sys_times depends on __exit_signal having
 	 * updated the counters before a task is removed from the tasklist of
Index: linux/kernel/signal.c
===================================================================
--- linux.orig/kernel/signal.c
+++ linux/kernel/signal.c
@@ -328,17 +328,19 @@ void __exit_sighand(struct task_struct *
 	struct sighand_struct * sighand = tsk->sighand;
 
 	/* Ok, we're done with the signal handlers */
-	spin_lock(&sighand->siglock);
 	tsk->sighand = NULL;
 	if (atomic_dec_and_test(&sighand->count))
 		sighand_free(sighand);
-	spin_unlock(&sighand->siglock);
 }
 
 void exit_sighand(struct task_struct *tsk)
 {
 	write_lock_irq(&tasklist_lock);
-	__exit_sighand(tsk);
+	spin_lock(&tsk->sighand->siglock);
+	if (tsk->sighand != NULL) {
+		__exit_sighand(tsk);
+	}
+	spin_unlock(&tsk->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 }
 
@@ -361,6 +363,7 @@ void __exit_signal(struct task_struct *t
 		if (tsk == sig->curr_target)
 			sig->curr_target = next_thread(tsk);
 		tsk->signal = NULL;
+		__exit_sighand(tsk);
 		spin_unlock(&sighand->siglock);
 		flush_sigqueue(&sig->shared_pending);
 	} else {
@@ -392,6 +395,7 @@ void __exit_signal(struct task_struct *t
 		sig->nvcsw += tsk->nvcsw;
 		sig->nivcsw += tsk->nivcsw;
 		sig->sched_time += tsk->sched_time;
+		__exit_sighand(tsk);
 		spin_unlock(&sighand->siglock);
 		sig = NULL;	/* Marker for below.  */
 	}
