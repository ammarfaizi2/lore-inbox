Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSGIRYu>; Tue, 9 Jul 2002 13:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSGIRYt>; Tue, 9 Jul 2002 13:24:49 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:49566 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S317349AbSGIRYq> convert rfc822-to-8bit; Tue, 9 Jul 2002 13:24:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: O(1) scheduler "complex" macros
Date: Tue, 9 Jul 2002 19:27:14 +0200
X-Mailer: KMail [version 1.4]
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ia64" <linux-ia64@linuxia64.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207091927.14537.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

the patch eliminating the frozen_lock which went into 2.5.22 requires
macros for prepare_arch_schedule(), etc... On IA64 I think that we need
to use the "complex" macros, otherwise there is a potential deadlock.

Unfortunately the "complex" macros seem to have the problem that the "prev"
task can be stolen right before the context switch. In your description to
the patch you wrote:

> architectures that need to unlock the runqueue before doing the switch can
> do the following:
>
>  #define prepare_arch_schedule(prev)             task_lock(prev)
>  #define finish_arch_schedule(prev)              task_unlock(prev)
>  #define prepare_arch_switch(rq)                 spin_unlock(&(rq)->lock)
>  #define finish_arch_switch(rq)                  __sti()
>
> this way the task-lock makes sure that a task is not scheduled on some
> other CPU before the switch-out finishes, but the runqueue lock is
> dropped.

Suppose we have 
  cpu1: idle1
  cpu2: prev2 -> next2  (in the switch)

I don't understand how task_lock(prev2) done on cpu2 can prevent cpu1 to
schedule prev2, which it stole after the RQ#2 lock release. It will just
try to task_lock(idle1), which will be successfull.

The problems I have are with a small and ugly testprogram which generates
128 threads which all just do   system("exit");  Running this program
continuously sooner or later leads to attempts to switch to tasks which
have already exited. Inserting a small udelay after prepare_arch_switch
reveals the problem earlier.

I also tried inserting "while (spin_is_locked(&(next)->alloc_lock));"
but it didn't help.

Any idea how to fix this problem?

Thanks a lot in advance,
best regards,

Erich

PS: Below is the relevant part of schedule():

	prepare_arch_schedule(prev);
...
	if (likely(prev != next)) {
		rq->nr_switches++;
		rq->curr = next;
		prepare_arch_switch(rq);
		//while (spin_is_locked(&(next)->alloc_lock));
		prev = context_switch(prev, next);
		barrier();
		rq = this_rq();
		finish_arch_switch(rq);
	} else
		spin_unlock_irq(&rq->lock);
 	finish_arch_schedule(prev);

PPS: The potential deadlock on IA64 for the "simple" macros comes from
the fact that we sometimes wrap the context counter and need to
read_lock(tasklist_lock). Doing this without releasing the RQ can lead
to a deadlock with sys_wait4, where a write_lock(&tasklist_lock) is
needed, inside of which a __wake_up needs the RQ lock :-(

