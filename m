Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266510AbUBRXNg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266997AbUBRXNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:13:36 -0500
Received: from dp.samba.org ([66.70.73.150]:45545 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266510AbUBRXNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:13:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: keventd_create_kthread 
In-reply-to: Your message of "Wed, 18 Feb 2004 00:46:48 -0800."
             <20040218004648.7471bb37.akpm@osdl.org> 
Date: Thu, 19 Feb 2004 10:12:01 +1100
Message-Id: <20040218231322.35EE92C05F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040218004648.7471bb37.akpm@osdl.org> you write:
> wait_task_inactive() will return due to the preemption?
> 
> perhaps wait_task_inactive() should wait until the target task leaves state
> TASK_RUNNING.

That's not enough: it can set that and then get preemted.  It really
want to return when the task is off the runqueue.  The original
wait_task_inactive() does an incredible complicated and AFAICT useless
dance wrt not locking and disabling preempt explicitly.  Ingo, how's
this replacement?  (And who wrote this code?)

/*
 * wait_task_inactive - wait for a thread to unschedule.
 *
 * The caller must ensure that the task *will* unschedule sometime soon,
 * else this function might spin for a *long* time. This function can't
 * be called with interrupts off, or it may introduce deadlock with
 * smp_call_function() if an IPI is sent by the same process we are
 * waiting to become inactive.
 */
void wait_task_inactive(task_t * p)
{
	unsigned long flags;
	runqueue_t *rq;

repeat:
	rq = task_rq_lock(p, &flags);
	/* Must be off runqueue entirely, not preempted. */
	if (unlikely(p->array)) {
		task_rq_unlock(rq, &flags);
		cpu_relax();
		/* If it's preempted: yield.  It could be a while. */
		if (!task_running(p))
			yield();
		goto repeat;
	}
	task_rq_unlock(rq, &flags);
}

Untested BTW.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
