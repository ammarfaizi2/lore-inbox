Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSCOXyT>; Fri, 15 Mar 2002 18:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291460AbSCOXyK>; Fri, 15 Mar 2002 18:54:10 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:41951 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291340AbSCOXx6>; Fri, 15 Mar 2002 18:53:58 -0500
Date: Fri, 15 Mar 2002 15:50:41 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.18 scheduler bugs
Message-ID: <20020315155041.C1559@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0203152156270.23324-100000@elte.hu> <200203152214.WAA27958@rudolph.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203152214.WAA27958@rudolph.ccur.com>; from jak@rudolph.ccur.com on Fri, Mar 15, 2002 at 05:14:20PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe: from your original mail,

On Fri, Mar 15, 2002 at 03:54:39PM -0500, Joe Korty wrote:
>
> - reschedule_idle() - smp_send_reschedule when setting idle's need_resched
>
>     Idle tasks nowdays don't spin waiting for need->resched to change,
>     they sleep on a halt insn instead.  Therefore any setting of
>     need->resched on an idle task running on a remote CPU should be
>     accompanied by a cross-processor interrupt.
>
> diff -Nur linux-2.4.18-base/kernel/sched.c linux/kernel/sched.c
> --- linux-2.4.18-base/kernel/sched.c  Fri Dec 21 12:42:04 2001
> +++ linux/kernel/sched.c      Fri Mar 15 14:57:21 2002
> @@ -225,16 +225,9 @@
>       if (can_schedule(p, best_cpu)) {
>               tsk = idle_task(best_cpu);
>               if (cpu_curr(best_cpu) == tsk) {
> -                     int need_resched;
>  send_now_idle:
> -                     /*
> -                      * If need_resched == -1 then we can skip sending
> -                      * the IPI altogether, tsk->need_resched is
> -                      * actively watched by the idle thread.
> -                      */
> -                     need_resched = tsk->need_resched;
>                       tsk->need_resched = 1;
> -                     if ((best_cpu != this_cpu) && !need_resched)
> +                     if (best_cpu != this_cpu)
>                               smp_send_reschedule(best_cpu);
>                       return;
>               }

Note that the original code always did send an IPI when setting
need_resched.  It only skipped the IPI if need_resched was already
set.  I may be wrong, but I always considered the check for
need_resched already being set to be an optimization.  In other
words, if need_resched was already set then you know an IPI was
previously sent but schedule has not yet run on that CPU.

For your patch to make any difference, there would need to be code
that frequently set need_resched and did not send an IPI to the
target CPU.  I don't think there is any code that does this (except
code that sets need_resched while in interrupt context which is
handled by other means).

I would agree that the comment in the above code is out of date
and misleading.

-- 
Mike
