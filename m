Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265371AbUFBGui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265371AbUFBGui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 02:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUFBGug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 02:50:36 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:29056 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265371AbUFBGue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 02:50:34 -0400
Subject: Re: [PATCH] Fix signal race during process exit
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Kerr <jeremy@redfishsoftware.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040601225703.6c697bed.akpm@osdl.org>
References: <200406021213.58305.jeremy@redfishsoftware.com.au>
	 <20040601225703.6c697bed.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086158988.29381.277.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Jun 2004 16:49:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 15:57, Andrew Morton wrote:
> void update_process_times(int user_tick)
> {
> 	struct task_struct *p = current;
> 	int cpu = smp_processor_id(), system = user_tick ^ 1;
> versus:
> 
> void __exit_sighand(struct task_struct *tsk)
> {
> 	struct sighand_struct * sighand = tsk->sighand;

No.  tsk == current for __exit_sighand.  You know, getting current is SO
expensive, and so we should PASS IT to functions explicitly!

One of my pet gripes: this code is badly obfuscated by this.  Is it just
me?

> And there's a little window at the end of exit_notify() where the exitting
> task (which is still "current" on its CPU) can take a timer interrupt while
> in a state TASK_ZOMBIE.  The CPU which is running wait4() will run
> release_task() for the exitting task and the above race can occur.

Hmm, while we're at it, the task seems to release itself while running
here: exit_notify() -> release_task() -> put_task_struct() ->
__put_task_struct() -> BOOM?

Surely not, what am I missing?

> Right now, I see no alternative to adding locking which pins task->sighand
> while the timer handler is running.  Taking tasklist_lock on each timer
> tick will hurt - maybe a new per-process lock is needed?

Hmm, a per-cpu cache of exited tasks: one task for each CPU.  We hold a
reference to the task struct until the next exit on the same CPU
happens?  We could also reuse that cache for fork()...

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

