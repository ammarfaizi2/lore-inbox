Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSGJW2v>; Wed, 10 Jul 2002 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGJW2u>; Wed, 10 Jul 2002 18:28:50 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:21518 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S317329AbSGJW2t>;
	Wed, 10 Jul 2002 18:28:49 -0400
Message-ID: <3D2CB668.8CC739B6@tv-sign.ru>
Date: Thu, 11 Jul 2002 02:34:16 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mingo@elte.hu
Subject: Re: [patch] sched-2.5.24-D3, batch/idle priority scheduling, SCHED_BATCH
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> > > > And users of __KERNEL_SYSCALLS__ and kernel_thread() should not
> > > > have policy == SCHED_BATCH.
> >
> > well, there's one security consequence here - module loading
> > (request_module()), which spawns a kernel thread must not run as
> > SCHED_BATCH. I think the right solution for that path is to set the
> > policy to SCHED_OTHER upon entry, and restore it to the previous one
> > afterwards - this way the helper thread has SCHED_OTHER priority.
>
> i've solved this problem by making kernel_thread() spawned threads drop
> back to SCHED_NORMAL:

Note that request_module() also does waitpid(). So it's better to change
policy upon entry, as You suggested.

> I believe this is the secure way of doing it - independently of
> SCHED_BATCH - a RT task should not spawn a RT kernel thread 'unwillingly'.

Yes, but this semantic change should be ported to all archs
independently of
low level microoptimizations, for consistency. Rename all definitions to
arch_kernel_thread() ?

Btw, how about this tiny bit of cleanup:

asmlinkage void schedule_userspace(void)
{
    /*
     * Only handle batch tasks that are runnable.
     */
    if (current->policy == SCHED_BATCH &&
        current->state == TASK_RUNNING) {
        runqueue_t *rq = this_rq_lock();
        deactivate_batch_task(current, rq);

        // we can keep irqs disabled:
        spin_unlock(&rq->lock);
    }

    schedule();
}

Oleg.
