Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSDEBzj>; Thu, 4 Apr 2002 20:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310979AbSDEBza>; Thu, 4 Apr 2002 20:55:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:40175 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S310953AbSDEBzT>;
	Thu, 4 Apr 2002 20:55:19 -0500
Message-ID: <3CAD0311.CFCCCDB@mvista.com>
Date: Thu, 04 Apr 2002 17:51:13 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        george@mvista.com, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] preemptive kernel behavior change: don't be rude
In-Reply-To: <Pine.LNX.4.33.0204041554350.26177-100000@penguin.transmeta.com> <1017965029.23629.685.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Thu, 2002-04-04 at 18:55, Linus Torvalds wrote:
> > Fair enough. Send me a patch to look at.
> 
> Linus et all,
> 
> Here we go:
> 
> - do not manually set task->state
> - instead, in preempt_schedule, set a flag in preempt_count that
>   denotes that this task is entering schedule off a kernel preemption.
> - use this flag in schedule to jump to pick_next_task
> - in preempt_schedule, upon return from schedule, unset the flag
> - have entry.S just call preempt_schedule and not duplicate this work,
>   as Linus suggested.  I agree.  Note this makes debugging easier as
>   we keep a single point of entry for kernel preemptions.
> 
> The result: we can safely preempt non-TASK_RUNNING tasks.  If one is
> preempted, we can safely survive schedule because we won't handle the
> special casing of non-TASK_RUNNING at the top of schedule.  Thus other
> tasks can run as desired and our non-TASK_RUNNING task will eventually
> be rescheduled, in its original state, and complete happily.
> 
> This is the behavior we have in the 2.4 patches and 2.5 until
> ~2.5.6-pre.  This works.  It requires no other changes elsewhere (it
> actually removes some special-casing Ingo did in the signal code).
> 
> This patch works in theory and compiles, but received minimal testing.
> 
>         Robert Love
> 
> diff -urN linux-2.5.8-pre1/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
> --- linux-2.5.8-pre1/arch/i386/kernel/entry.S   Wed Apr  3 20:57:24 2002
> +++ linux/arch/i386/kernel/entry.S      Thu Apr  4 18:32:03 2002
> @@ -240,9 +240,7 @@
>         jnz restore_all
>         incl TI_PRE_COUNT(%ebx)
>         sti
> -       movl TI_TASK(%ebx), %ecx                # ti->task
> -       movl $0,(%ecx)                  # current->state = TASK_RUNNING
> -       call SYMBOL_NAME(schedule)
> +       call SYMBOL_NAME(preempt_schedule)
>         jmp ret_from_intr
>  #endif
> 
> diff -urN linux-2.5.8-pre1/arch/i386/kernel/ptrace.c linux/arch/i386/kernel/ptrace.c
> --- linux-2.5.8-pre1/arch/i386/kernel/ptrace.c  Wed Apr  3 20:57:24 2002
> +++ linux/arch/i386/kernel/ptrace.c     Thu Apr  4 18:31:17 2002
> @@ -455,11 +455,9 @@
>            between a syscall stop and SIGTRAP delivery */
>         current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
>                                         ? 0x80 : 0);
> -       preempt_disable();
>         current->state = TASK_STOPPED;
>         notify_parent(current, SIGCHLD);
>         schedule();
> -       preempt_enable();
>         /*
>          * this isn't the same as continuing with a signal, but it will do
>          * for normal use.  strace only continues with a signal if the
> diff -urN linux-2.5.8-pre1/arch/i386/kernel/signal.c linux/arch/i386/kernel/signal.c
> --- linux-2.5.8-pre1/arch/i386/kernel/signal.c  Wed Apr  3 20:57:24 2002
> +++ linux/arch/i386/kernel/signal.c     Thu Apr  4 18:31:00 2002
> @@ -610,11 +610,9 @@
>                 if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
>                         /* Let the debugger run.  */
>                         current->exit_code = signr;
> -                       preempt_disable();
>                         current->state = TASK_STOPPED;
>                         notify_parent(current, SIGCHLD);
>                         schedule();
> -                       preempt_enable();
> 
>                         /* We're back.  Did the debugger cancel the sig?  */
>                         if (!(signr = current->exit_code))
> @@ -669,14 +667,12 @@
> 
>                         case SIGSTOP: {
>                                 struct signal_struct *sig;
> +                               current->state = TASK_STOPPED;
>                                 current->exit_code = signr;
>                                 sig = current->parent->sig;
> -                               preempt_disable();
> -                               current->state = TASK_STOPPED;
>                                 if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
>                                         notify_parent(current, SIGCHLD);
>                                 schedule();
> -                               preempt_enable();
>                                 continue;
>                         }
> 
> diff -urN linux-2.5.8-pre1/include/linux/sched.h linux/include/linux/sched.h
> --- linux-2.5.8-pre1/include/linux/sched.h      Wed Apr  3 20:57:27 2002
> +++ linux/include/linux/sched.h Thu Apr  4 18:29:53 2002
> @@ -91,6 +91,7 @@
>  #define TASK_UNINTERRUPTIBLE   2
>  #define TASK_ZOMBIE            4
>  #define TASK_STOPPED           8
> +#define PREEMPT_ACTIVE         0x4000000
> 
>  #define __set_task_state(tsk, state_value)             \
>         do { (tsk)->state = (state_value); } while (0)
> diff -urN linux-2.5.8-pre1/kernel/sched.c linux/kernel/sched.c
> --- linux-2.5.8-pre1/kernel/sched.c     Wed Apr  3 20:57:37 2002
> +++ linux/kernel/sched.c        Thu Apr  4 18:29:24 2002
> @@ -764,6 +764,13 @@
>         prev->sleep_timestamp = jiffies;
>         spin_lock_irq(&rq->lock);
> 
> +       /*
> +        * if entering from preempt_schedule, off a kernel preemption,
> +        * go straight to picking the next task.
> +        */
> +       if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
> +               goto pick_next_task;
> +
>         switch (prev->state) {
>         case TASK_INTERRUPTIBLE:
>                 if (unlikely(signal_pending(prev))) {
> @@ -775,7 +782,7 @@
>         case TASK_RUNNING:
>                 ;
>         }
> -#if CONFIG_SMP
> +#if CONFIG_SMP || CONFIG_PREEMPT
>  pick_next_task:
>  #endif
>         if (unlikely(!rq->nr_running)) {
> @@ -843,8 +850,11 @@
>  {
>         if (unlikely(preempt_get_count()))
>                 return;

This line implies that entry.S calls with preempt count of 0.  It use to
call with 1 or was that WAY back there?  

If this is the way it is and it works, then the += and -= below can be
changed to = and the second reference to PREEMPT_ACTIVE becomes 0.

I think I would rather have entry.S set preempt_count to PREEMPT_ACTIVE
with the interrupt system off, turn it on, make the call directly to
schedule(), and then set to zero on return.  I really am concerned with
taking an interrupt during the call, i.e. between the interrupt on and
the store below.  This can lead to stack overflow rather easily.

> -       current->state = TASK_RUNNING;
> +
> +       current_thread_info()->preempt_count += PREEMPT_ACTIVE;
>         schedule();
> +       current_thread_info()->preempt_count -= PREEMPT_ACTIVE;
> +       barrier();
>  }
>  #endif /* CONFIG_PREEMPT */
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
