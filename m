Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUFBHI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUFBHI5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUFBHI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:08:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:56757 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262176AbUFBHIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:08:52 -0400
Date: Wed, 2 Jun 2004 00:08:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: jeremy@redfishsoftware.com.au, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Fix signal race during process exit
Message-Id: <20040602000812.541ee72a.akpm@osdl.org>
In-Reply-To: <1086158988.29381.277.camel@bach>
References: <200406021213.58305.jeremy@redfishsoftware.com.au>
	<20040601225703.6c697bed.akpm@osdl.org>
	<1086158988.29381.277.camel@bach>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> On Wed, 2004-06-02 at 15:57, Andrew Morton wrote:
> > void update_process_times(int user_tick)
> > {
> > 	struct task_struct *p = current;
> > 	int cpu = smp_processor_id(), system = user_tick ^ 1;
> > versus:
> > 
> > void __exit_sighand(struct task_struct *tsk)
> > {
> > 	struct sighand_struct * sighand = tsk->sighand;
> 
> No.  tsk == current for __exit_sighand.

Nope.
	wait4->wait_task_zombie->release_task->__exit_sighand

>  You know, getting current is SO
> expensive, and so we should PASS IT to functions explicitly!
> 
> One of my pet gripes: this code is badly obfuscated by this.  Is it just
> me?

It does make the code a bit hard to follow, but yes, evaluating `current'
takes ~14 bytes of text on x86.  Although I think recent versions of the
compiler are able to cse it.

Still, the right way to do this is to lose all the dopey `p's and `tsk's
and adopt a convention of using `this_task' or some such identifier.

> > And there's a little window at the end of exit_notify() where the exitting
> > task (which is still "current" on its CPU) can take a timer interrupt while
> > in a state TASK_ZOMBIE.  The CPU which is running wait4() will run
> > release_task() for the exitting task and the above race can occur.
> 
> Hmm, while we're at it, the task seems to release itself while running
> here: exit_notify() -> release_task() -> put_task_struct() ->
> __put_task_struct() -> BOOM?
> 
> Surely not, what am I missing?

There's still one put to go - that happens at the end of
finish_task_switch(), via the next-to-run process.

> > Right now, I see no alternative to adding locking which pins task->sighand
> > while the timer handler is running.  Taking tasklist_lock on each timer
> > tick will hurt - maybe a new per-process lock is needed?
> 
> Hmm, a per-cpu cache of exited tasks: one task for each CPU.  We hold a
> reference to the task struct until the next exit on the same CPU
> happens?  We could also reuse that cache for fork()...

The problem is task_struct.sighand, not the task_struct itself.  ->sighand
can be thrown away while update_process_times() is still poking at it.

hmm, maybe it _is_ sufficient to null out current->it_prof_value and
current->it_virt_incr in the do_exit() path.  Because in *this* case we know
that it is always the exitting task which is doing the nulling, so the
timer interrupt cannot run on a different CPU.

--- 25/kernel/exit.c~a	2004-06-02 00:06:33.864102384 -0700
+++ 25-akpm/kernel/exit.c	2004-06-02 00:07:12.050297200 -0700
@@ -749,6 +749,13 @@ static void exit_notify(struct task_stru
 	 * complete, and with interrupts blocked that will never happen.
 	 */
 	_raw_write_unlock(&tasklist_lock);
+
+	/*
+	 * comment goes here
+	 */
+	tsk->it_virt_incr = 0;
+	tsk->it_prof_value = 0;
+
 	local_irq_enable();
 
 	/* If the process is dead, release it - nobody will wait for it */
_


yes?
