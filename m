Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310143AbSCFTS4>; Wed, 6 Mar 2002 14:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310142AbSCFTSm>; Wed, 6 Mar 2002 14:18:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31483 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S310139AbSCFTSX>;
	Wed, 6 Mar 2002 14:18:23 -0500
Message-ID: <3C866B56.AE2F63BD@mvista.com>
Date: Wed, 06 Mar 2002 11:17:42 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: preemptive kernel on UP
In-Reply-To: <1015287099.865.3.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> During 2.5.5-pre, an optimization was made that removed schedule_tail
> from UP kernels.  This causes the initial preempt_count of a new task,
> which starts at 1, to never decrement to zero and thus never become
> preemptible.
> 
> Thanks to everyone who pointed out the lousy performance - it took
> awhile to find but it should be fixed now.  Please comment if not.
> 
> Patch is against 2.5.6-pre2 and is critical for all UP+preempt users.

With out a lot of looking, wouldn't it be easier to just change fork?

-g
> 
>         Robert Love
> 
> diff -urN linux-2.5.6-pre2/arch/alpha/kernel/entry.S linux/arch/alpha/kernel/entry.S
> --- linux-2.5.6-pre2/arch/alpha/kernel/entry.S  Fri Mar  1 17:21:14 2002
> +++ linux/arch/alpha/kernel/entry.S     Mon Mar  4 17:49:27 2002
> @@ -495,7 +495,7 @@
>         ret     $31,($26),1
>  .end alpha_switch_to
> 
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_SMP || CONFIG_PREEMPT
>  .globl  ret_from_fork
>  .align 3
>  .ent ret_from_fork
> diff -urN linux-2.5.6-pre2/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
> --- linux-2.5.6-pre2/arch/i386/kernel/entry.S   Tue Feb 19 21:10:58 2002
> +++ linux/arch/i386/kernel/entry.S      Mon Mar  4 17:48:32 2002
> @@ -195,7 +195,7 @@
> 
> 
>  ENTRY(ret_from_fork)
> -#if CONFIG_SMP
> +#if CONFIG_SMP || CONFIG_PREEMPT
>         call SYMBOL_NAME(schedule_tail)
>  #endif
>         GET_THREAD_INFO(%ebx)
> diff -urN linux-2.5.6-pre2/arch/ppc/kernel/entry.S linux/arch/ppc/kernel/entry.S
> --- linux-2.5.6-pre2/arch/ppc/kernel/entry.S    Tue Feb 19 21:10:59 2002
> +++ linux/arch/ppc/kernel/entry.S       Mon Mar  4 17:48:41 2002
> @@ -343,7 +343,7 @@
> 
>         .globl  ret_from_fork
>  ret_from_fork:
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_SMP || CONFIG_PREEMPT
>         bl      schedule_tail
>  #endif
>         rlwinm  r3,r1,0,0,18
> diff -urN linux-2.5.6-pre2/arch/ppc64/kernel/entry.S linux/arch/ppc64/kernel/entry.S
> --- linux-2.5.6-pre2/arch/ppc64/kernel/entry.S  Tue Feb 19 21:10:53 2002
> +++ linux/arch/ppc64/kernel/entry.S     Mon Mar  4 17:52:16 2002
> @@ -311,7 +311,7 @@
>         blr
> 
>  _GLOBAL(ret_from_fork)
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_SMP || CONFIG_PREEMPT
>         bl      .schedule_tail
>  #endif
>         clrrdi  r4,r1,THREAD_SHIFT
> diff -urN linux-2.5.6-pre2/arch/s390/kernel/entry.S linux/arch/s390/kernel/entry.S
> --- linux-2.5.6-pre2/arch/s390/kernel/entry.S   Tue Feb 19 21:10:57 2002
> +++ linux/arch/s390/kernel/entry.S      Mon Mar  4 17:48:12 2002
> @@ -295,7 +295,7 @@
>          stosm   24(%r15),0x03     # reenable interrupts
>          sr      %r0,%r0           # child returns 0
>          st      %r0,SP_R2(%r15)   # store return value (change R2 on stack)
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_SMP || CONFIG_PREEMPT
>          l       %r1,BASED(.Lschedtail)
>         la      %r14,BASED(sysc_return)
>          br      %r1               # call schedule_tail, return to sysc_return
> @@ -896,7 +896,7 @@
>  #error .Ltrace:       .long  syscall_trace
>  .Lvfork:       .long  sys_vfork
> 
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_SMP || CONFIG_PREEMPT
>  .Lschedtail:   .long  schedule_tail
>  #endif
> 
> diff -urN linux-2.5.6-pre2/arch/s390x/kernel/entry.S linux/arch/s390x/kernel/entry.S
> --- linux-2.5.6-pre2/arch/s390x/kernel/entry.S  Tue Feb 19 21:10:58 2002
> +++ linux/arch/s390x/kernel/entry.S     Mon Mar  4 17:53:31 2002
> @@ -280,7 +280,7 @@
>          GET_CURRENT               # load pointer to task_struct to R9
>          stosm   48(%r15),0x03     # reenable interrupts
>         xc      SP_R2(8,%r15),SP_R2(%r15) # child returns 0
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_SMP || CONFIG_PREEMPT
>         larl    %r14,sysc_return
>          jg      schedule_tail     # return to sysc_return
>  #else
> diff -urN linux-2.5.6-pre2/kernel/sched.c linux/kernel/sched.c
> --- linux-2.5.6-pre2/kernel/sched.c     Fri Mar  1 17:21:16 2002
> +++ linux/kernel/sched.c        Mon Mar  4 17:54:00 2002
> @@ -397,7 +397,7 @@
>                         p->sleep_avg) / (EXIT_WEIGHT + 1);
>  }
> 
> -#if CONFIG_SMP
> +#if CONFIG_SMP || CONFIG_PREEMPT
>  asmlinkage void schedule_tail(void)
>  {
>         spin_unlock_irq(&this_rq()->lock);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
