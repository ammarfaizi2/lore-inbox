Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312281AbSCYCu1>; Sun, 24 Mar 2002 21:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSCYCuS>; Sun, 24 Mar 2002 21:50:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:43018 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312278AbSCYCuC>; Sun, 24 Mar 2002 21:50:02 -0500
Message-ID: <3C9E8FFC.6853A65C@zip.com.au>
Date: Sun, 24 Mar 2002 18:48:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Robert Love <rml@tech9.net>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: preempt-related hangs
In-Reply-To: <3C9E8767.4F57CB0A@zip.com.au> <5.1.0.14.2.20020325023128.03e40850@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> At 02:11 25/03/02, Andrew Morton wrote:
> >Andrew Morton wrote:
> > >
> > > ..
> > > Kernel is 2.5.7, dual PIII.  When I enable preempt it
> > > locks during boot.
> >
> >OK, this patch fixed it.  I don't know why.
> 
> Er, because you disable preemption twice and it never gets enabled again? (-:
> 
> You probably meant that to be preemt_enable() at the bottom of the patch...
> That might not solve your problem of course... But with the patch you
> basically have completely disabled preemption, you might as well not
> configure it into the kernel. (-;

Yeah I know. Sheesh.  I don't even have time to test the fix
before you're on my act :)

Fixed-up workaround with a little debug check is below.

I think Robert's right - the problem is more likely to lie
with the migration thread handoff thingy.

--- 2.5.7/kernel/sched.c~preempt-lockup	Sun Mar 24 18:10:49 2002
+++ 2.5.7-akpm/kernel/sched.c	Sun Mar 24 18:25:29 2002
@@ -1561,6 +1561,8 @@ void set_cpus_allowed(task_t *p, unsigne
 	migration_req_t req;
 	runqueue_t *rq;
 
+	preempt_disable();
+
 	new_mask &= cpu_online_map;
 	if (!new_mask)
 		BUG();
@@ -1573,7 +1575,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 */
 	if (new_mask & (1UL << p->thread_info->cpu)) {
 		task_rq_unlock(rq, &flags);
-		return;
+		goto out;
 	}
 
 	init_MUTEX_LOCKED(&req.sem);
@@ -1583,6 +1585,8 @@ void set_cpus_allowed(task_t *p, unsigne
 	wake_up_process(rq->migration_thread);
 
 	down(&req.sem);
+out:
+	preempt_enable();
 }
 
 static volatile unsigned long migration_mask;
--- 2.5.7/kernel/exit.c~preempt-lockup	Sun Mar 24 18:31:39 2002
+++ 2.5.7-akpm/kernel/exit.c	Sun Mar 24 18:37:19 2002
@@ -489,6 +489,14 @@ NORET_TYPE void do_exit(long code)
 		panic("Attempted to kill the idle task!");
 	if (tsk->pid == 1)
 		panic("Attempted to kill init!");
+#ifdef CONFIG_PREEMPT
+	if (preempt_get_count()) {
+		printk(KERN_ERR "task `%s' exits with non-zero "
+				"preempt count: %d\n",
+				current->comm,
+				preempt_get_count());
+	}
+#endif
 	tsk->flags |= PF_EXITING;
 	del_timer_sync(&tsk->real_timer);
 

-
