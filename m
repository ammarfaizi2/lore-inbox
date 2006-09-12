Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbWILWDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbWILWDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWILWDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:03:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44171 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030348AbWILWDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:03:09 -0400
Date: Tue, 12 Sep 2006 23:55:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] 2.6.18-rc6: hda is allready "IN USE" when booting / pi futex
Message-ID: <20060912215510.GA14878@elte.hu>
References: <20060907133357.GA30888@core> <20060912153932.GA14388@core> <20060912173455.GB6236@elte.hu> <20060912214822.GA20437@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912214822.GA20437@core>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christian Leber <christian@leber.de> wrote:

> > The b29739f902ee76a05493fb7d2303490fc75364f4 patch is quite large, so i 
> > have created a finegrained, functional splitup of it:
> > 
> >   sched-cleanups.patch
> >   sched-add-task-rq-lock-ops.patch
> >   sched-add-rt-mutex-setprio.patch
> >   sched-pi-lock.patch
> >   sched-add-new-macros.patch
> >   sched-add-normal-prio.patch
> >   sched-use-has-rt-policy.patch
> 
> until here everthing seems to be ok (20 boots)
> 
> >   sched-set-user-nice-fix.patch
> 
> here we go, that one triggers the problem

ok, great. Could you try the patch below ontop of 2.6.18-rc6, does it 
'fix' your bootup too?

the original patch (which this patch reverses) is harmless: it changes 
the priority calculation of reniced tasks from:

	p->prio = NICE_TO_PRIO(nice);

to:

	p->prio = effective_prio(p);

which is a correct change, because NICE_TO_PRIO() gives a 'static' value 
that is not modified by interactivity bonuses/penalties, while 
effective_prio() is the kind of prio every task should get. I.e. 
sys_nice(1) used to (incorrectly) discard the interactive bias of a 
task, until the end of the timeslice.

so i'm afraid you managed to trigger a race in the IDE driver that used 
to be dormant until now... To debug such races the best method is to 
create a 'trace' by printk-ing key points of the port/disk detection 
mechanism. [another option would be to use the latency tracer to do a 
_really_ finegrained trace of the incident - assuming that the bug does 
not go away due to tracing overhead.]

	Ingo

--------------->
Subject: [patch] revert set_user_nice() change
From: Ingo Molnar <mingo@elte.hu>

revert an otherwise correct fix.

this disturbs dynamic priorities (of user and kernel threads),
so it could have an impact on timing-sensitive races.

NOT-Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 kernel/sched.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -3864,8 +3864,8 @@ void rt_mutex_setprio(struct task_struct
 
 void set_user_nice(struct task_struct *p, long nice)
 {
+	int old_prio, new_prio, delta;
 	struct prio_array *array;
-	int old_prio, delta;
 	unsigned long flags;
 	struct rq *rq;
 
@@ -3892,11 +3892,12 @@ void set_user_nice(struct task_struct *p
 		dec_raw_weighted_load(rq, p);
 	}
 
+	old_prio = p->prio;
+	new_prio = NICE_TO_PRIO(nice);
+	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
 	set_load_weight(p);
-	old_prio = p->prio;
-	p->prio = effective_prio(p);
-	delta = p->prio - old_prio;
+	p->prio += delta;
 
 	if (array) {
 		enqueue_task(p, array);
