Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSGJJaM>; Wed, 10 Jul 2002 05:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317518AbSGJJaL>; Wed, 10 Jul 2002 05:30:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4776 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317517AbSGJJaK>;
	Wed, 10 Jul 2002 05:30:10 -0400
Date: Thu, 11 Jul 2002 11:31:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: O(1) scheduler "complex" macros
In-Reply-To: <200207101105.29317.efocht@ess.nec.de>
Message-ID: <Pine.LNX.4.44.0207111111280.6835-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jul 2002, Erich Focht wrote:

> > the best solution might be to just lock the 'next' task - this needs a new
> > per-task irq-safe spinlock, to avoid deadlocks. This way whenever a task
> > is in the middle of a context-switch it cannot be scheduled on another
> > CPU.
> 
> We tested this and it looked good. But inserting a udelay(100) like:
> 	...
> 	prepare_arch_switch(rq, next);
> 	udelay(100);
> 	prev = context_switch(prev, next);
> 	...
> leads to a crash after 10 minutes. Again this looks like accessing an
> empty page.

there is one more detail - wait_task_inactive() needs to consider the
->switch_lock as well - otherwise exit() might end up freeing the
pagetables earlier than the context-switch has truly finished. The
udelay(100) test should trigger this race.

i've fixed this and uploaded the -A8 patch:

        http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.25-A8

does this fix the ia64 crashes? you need to define an ia64-specific
task_running(rq, p) macro, which should be something like:

 #define task_running(rq, p) \
	((rq)->curr == (p)) && !spin_is_locked(&(p)->switch_lock)

a number of other places needed to be updated to use the task_running()  
macro. For load_balance() and set_cpus_allowed() it's technically not
necessery, but i've added it to make things cleaner and safer for the time
being.

the default locking is still as lightweight as it used to be.

> Does anything speak against such a test? It is there just to show up
> quickly problems which we might normally get only after hours of
> running.

the udelay() test should be fine otherwise. (as long as ia64 udelay doesnt
do anything weird.)

	Ingo

