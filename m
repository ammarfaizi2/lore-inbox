Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265356AbUFBF5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUFBF5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 01:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUFBF5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 01:57:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:46217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265359AbUFBF5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 01:57:43 -0400
Date: Tue, 1 Jun 2004 22:57:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Kerr <jeremy@redfishsoftware.com.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix signal race during process exit
Message-Id: <20040601225703.6c697bed.akpm@osdl.org>
In-Reply-To: <200406021213.58305.jeremy@redfishsoftware.com.au>
References: <200406021213.58305.jeremy@redfishsoftware.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Kerr <jeremy@redfishsoftware.com.au> wrote:
>
> This patch fixes a race where timer-generated signals are delivered to an 
>  exiting process, after task->sighand is cleared.

Nasty.  I'm surprised that we haven't hit this more frequently.  I guess
timer-generated signals aren't very common.


However I'm not sure that your fix is complete:

void update_process_times(int user_tick)
{
	struct task_struct *p = current;
	int cpu = smp_processor_id(), system = user_tick ^ 1;

	/* Don't send signals to current after release_task() */
	if (likely(p->sighand))
		update_one_process(p, user_tick, system, cpu);

versus:

void __exit_sighand(struct task_struct *tsk)
{
	struct sighand_struct * sighand = tsk->sighand;

	/* Ok, we're done with the signal handlers.
	 * Set sighand to NULL to tell kernel/timer.c not
	 * to deliver further signals to this task
	 */
	tsk->sighand = NULL;
	if (atomic_dec_and_test(&sighand->count))
		kmem_cache_free(sighand_cachep, sighand);

If these two functions are running on different CPUs then the race is still
there - exit_sighand() can call update_process_times() while __exit_sighand
is throwing away p->sighand.

Question is, can these functions run on separate CPUs?  Certainly a
different CPU can run release_task(), via wait4().

And there's a little window at the end of exit_notify() where the exitting
task (which is still "current" on its CPU) can take a timer interrupt while
in a state TASK_ZOMBIE.  The CPU which is running wait4() will run
release_task() for the exitting task and the above race can occur.

(And if the exitting task is being ptraced things get more complex..)

Did I miss something?

It seems silly to be trying to deliver timer signals to processes which are
so late in exit and we could perhaps set ->it_prof_value and
->it_virt_value to zero earlier in exit.  That's sane, but doesn't fix the
race.

Right now, I see no alternative to adding locking which pins task->sighand
while the timer handler is running.  Taking tasklist_lock on each timer
tick will hurt - maybe a new per-process lock is needed?
