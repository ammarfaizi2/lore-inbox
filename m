Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267149AbUBSJxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267151AbUBSJxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:53:52 -0500
Received: from dp.samba.org ([66.70.73.150]:46268 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S267149AbUBSJxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:53:47 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: keventd_create_kthread 
In-reply-to: Your message of "Thu, 19 Feb 2004 02:46:08 CDT."
             <Pine.LNX.4.58.0402190205040.16515@devserv.devel.redhat.com> 
Date: Thu, 19 Feb 2004 20:46:58 +1100
Message-Id: <20040219095358.EA9812C301@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0402190205040.16515@devserv.devel.redhat.com> you write:
> The current wait_task_inactive() code seems to be OK on x86.
> Context-switching cannot be preempted. The goal of wait_task_inactive() is
> to wait for the task to unschedule on a CPU. If that's due to preempt then
> it's due to preempt.

No, because it can come back at any time 8(

> that in any modern interface. Why does keventd_create_kthread() need
> wait_task_inactive()?

Um, the code was taken from sched.c to kthread:

2.6.3 migration_thread():
	set_current_state(TASK_UNINTERRUPTIBLE);
	schedule();

2.6.3 migration_call():
		kernel_thread(migration_thread, &startup, CLONE_KERNEL);
		wait_for_completion(&startup.startup_done);
		wait_task_inactive(startup.task);

		startup.task->thread_info->cpu = cpu;
		startup.task->cpus_allowed = cpumask_of_cpu(cpu);


So, if the migration thread has been preempted immediately before
schedule(), wait_task_inactive returns, but it can come back from
preempt while we're messing with startup.task->thread_info->cpu.

Now, the latter part is wrapped in kthread_bind(), which should really
be doing the wait_task_inactive itself (doing it in kthread_create is
overzealous).  But the race is still there.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
