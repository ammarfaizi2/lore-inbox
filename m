Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSBUIF1>; Thu, 21 Feb 2002 03:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287769AbSBUIFK>; Thu, 21 Feb 2002 03:05:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:26869 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S286179AbSBUIFB>; Thu, 21 Feb 2002 03:05:01 -0500
Message-ID: <3C74AA0C.A627B561@mvista.com>
Date: Thu, 21 Feb 2002 00:04:28 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: bruce.holzrichter@monster.com, ultralinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.5 on Sparc, Ughh...
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101F6B@nocmail.ma.tmpw.net> <20020220.083904.74754277.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
>    Date: Wed, 20 Feb 2002 11:12:31 -0500
> 
>    Ok.  For the adventurous types, you'll at the very least need to apply the
>    below included patches to get Sparc64 to begin the compilation process at
>    all.   Here is some details:
> 
> You can start out with the below to fix things correctly.  The only
> unhandled thing is the pte_offset stuff and I'll work on that some time
> later today.

Uh, Dave, could you expound a bit on why you need a preemption lock
around the notify parent/ schedule code?  We have not found this to be
needed on other archs, but maybe we missed something.

George
> 
> diff -u --recursive --new-file --exclude=BitKeeper --exclude=ChangeSet --exclude=SCCS linux-2.5/arch/sparc64/kernel/process.c build/arch/sparc64/kernel/process.c
> --- linux-2.5/arch/sparc64/kernel/process.c     Thu Feb 14 13:49:29 2002
> +++ build/arch/sparc64/kernel/process.c Thu Feb 14 10:05:56 2002
> @@ -106,9 +106,11 @@
>         int cpu = smp_processor_id();
> 
>         if (local_irq_count(cpu) == 0 &&
> -           local_bh_count(cpu) == 0)
> -               preempt_schedule();
> -       current_thread_info()->preempt_count--;
> +           local_bh_count(cpu) == 0 &&
> +           test_thread_flag(TIF_NEED_RESCHED)) {
> +               current->state = TASK_RUNNING;
> +               schedule();
> +       }
>  }
>  #endif
> 
> diff -u --recursive --new-file --exclude=BitKeeper --exclude=ChangeSet --exclude=SCCS linux-2.5/arch/sparc64/kernel/ptrace.c build/arch/sparc64/kernel/ptrace.c
> --- linux-2.5/arch/sparc64/kernel/ptrace.c      Thu Feb 14 13:49:29 2002
> +++ build/arch/sparc64/kernel/ptrace.c  Thu Feb 14 10:05:56 2002
> @@ -627,9 +627,11 @@
>         if (!(current->ptrace & PT_PTRACED))
>                 return;
>         current->exit_code = SIGTRAP;
> +       preempt_disable();
>         current->state = TASK_STOPPED;
>         notify_parent(current, SIGCHLD);
>         schedule();
> +       preempt_enable();
>         /*
>          * this isn't the same as continuing with a signal, but it will do
>          * for normal use.  strace only continues with a signal if the
> diff -u --recursive --new-file --exclude=BitKeeper --exclude=ChangeSet --exclude=SCCS linux-2.5/arch/sparc64/kernel/rtrap.S build/arch/sparc64/kernel/rtrap.S
> --- linux-2.5/arch/sparc64/kernel/rtrap.S       Thu Feb 14 13:49:29 2002
> +++ build/arch/sparc64/kernel/rtrap.S   Thu Feb 14 10:05:56 2002
> @@ -276,9 +276,9 @@
>                  add                    %l5, 1, %l6
>                 stw                     %l6, [%g6 + TI_PRE_COUNT]
>                 call                    kpreempt_maybe
> -                wrpr                   %g0, RTRAP_PSTATE, %pstate
> -               wrpr                    %g0, RTRAP_PSTATE_IRQOFF, %pstate
> -               stw                     %l5, [%g6 + TI_PRE_COUNT]
> +                nop
> +               ba,pt                   %xcc, rtrap
> +                stw                    %l5, [%g6 + TI_PRE_COUNT]
>  #endif
>  kern_fpucheck: ldub                    [%g6 + TI_FPDEPTH], %l5
>                 brz,pt                  %l5, rt_continue
> diff -u --recursive --new-file --exclude=BitKeeper --exclude=ChangeSet --exclude=SCCS linux-2.5/arch/sparc64/kernel/signal.c build/arch/sparc64/kernel/signal.c
> --- linux-2.5/arch/sparc64/kernel/signal.c      Thu Feb 14 13:49:29 2002
> +++ build/arch/sparc64/kernel/signal.c  Thu Feb 14 10:05:56 2002
> @@ -713,9 +713,11 @@
> 
>                 if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
>                         current->exit_code = signr;
> +                       preempt_disable();
>                         current->state = TASK_STOPPED;
>                         notify_parent(current, SIGCHLD);
>                         schedule();
> +                       preempt_enable();
>                         if (!(signr = current->exit_code))
>                                 continue;
>                         current->exit_code = 0;
> @@ -766,16 +768,20 @@
>                                 if (is_orphaned_pgrp(current->pgrp))
>                                         continue;
> 
> -                       case SIGSTOP:
> -                               if (current->ptrace & PT_PTRACED)
> -                                       continue;
> -                               current->state = TASK_STOPPED;
> +                       case SIGSTOP: {
> +                               struct signal_struct *sig;
> +
>                                 current->exit_code = signr;
> -                               if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags &
> +                               sig = current->p_pptr->sig;
> +                               preempt_disable();
> +                               current->state = TASK_STOPPED;
> +                               if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags &
>                                       SA_NOCLDSTOP))
>                                         notify_parent(current, SIGCHLD);
>                                 schedule();
> +                               preempt_enable();
>                                 continue;
> +                       }
> 
>                         case SIGQUIT: case SIGILL: case SIGTRAP:
>                         case SIGABRT: case SIGFPE: case SIGSEGV:
> diff -u --recursive --new-file --exclude=BitKeeper --exclude=ChangeSet --exclude=SCCS linux-2.5/arch/sparc64/kernel/signal32.c build/arch/sparc64/kernel/signal32.c
> --- linux-2.5/arch/sparc64/kernel/signal32.c    Thu Feb 14 13:49:29 2002
> +++ build/arch/sparc64/kernel/signal32.c        Thu Feb 14 10:05:56 2002
> @@ -1379,9 +1379,11 @@
> 
>                 if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
>                         current->exit_code = signr;
> +                       preempt_disable();
>                         current->state = TASK_STOPPED;
>                         notify_parent(current, SIGCHLD);
>                         schedule();
> +                       preempt_enable();
>                         if (!(signr = current->exit_code))
>                                 continue;
>                         current->exit_code = 0;
> @@ -1432,17 +1434,20 @@
>                                 if (is_orphaned_pgrp(current->pgrp))
>                                         continue;
> 
> -                       case SIGSTOP:
> -                               if (current->ptrace & PT_PTRACED)
> -                                       continue;
> -                               current->state = TASK_STOPPED;
> +                       case SIGSTOP: {
> +                               struct signal_struct *sig;
> +
>                                 current->exit_code = signr;
> -                               if (!(current->p_pptr->sig->action[SIGCHLD-1].sa.sa_flags &
> +                               sig = current->p_pptr->sig;
> +                               preempt_disable();
> +                               current->state = TASK_STOPPED;
> +                               if (sig && !(sig->action[SIGCHLD-1].sa.sa_flags &
>                                       SA_NOCLDSTOP))
>                                         notify_parent(current, SIGCHLD);
>                                 schedule();
> +                               preempt_enable();
>                                 continue;
> -
> +                       }
>                         case SIGQUIT: case SIGILL: case SIGTRAP:
>                         case SIGABRT: case SIGFPE: case SIGSEGV:
>                         case SIGBUS: case SIGSYS: case SIGXCPU: case SIGXFSZ:
> diff -u --recursive --new-file --exclude=BitKeeper --exclude=ChangeSet --exclude=SCCS linux-2.5/include/asm-sparc64/bitops.h build/include/asm-sparc64/bitops.h
> --- linux-2.5/include/asm-sparc64/bitops.h      Thu Feb 14 13:50:37 2002
> +++ build/include/asm-sparc64/bitops.h  Thu Feb 14 10:40:13 2002
> @@ -7,6 +7,7 @@
>  #ifndef _SPARC64_BITOPS_H
>  #define _SPARC64_BITOPS_H
> 
> +#include <linux/compiler.h>
>  #include <asm/byteorder.h>
> 
>  extern long ___test_and_set_bit(unsigned long nr, volatile void *addr);
> @@ -100,6 +101,23 @@
>  }
> 
>  #ifdef __KERNEL__
> +
> +/*
> + * Every architecture must define this function. It's the fastest
> + * way of searching a 140-bit bitmap where the first 100 bits are
> + * unlikely to be set. It's guaranteed that at least one of the 140
> + * bits is cleared.
> + */
> +static inline int sched_find_first_bit(unsigned long *b)
> +{
> +       if (unlikely(b[0]))
> +               return __ffs(b[0]);
> +       if (unlikely(((unsigned int)b[1])))
> +               return __ffs(b[1]);
> +       if (b[1] >> 32)
> +               return __ffs(b[1] >> 32) + 96;
> +       return __ffs(b[2]) + 128;
> +}
> 
>  /*
>   * ffs: find first bit set. This is defined the same way as
> diff -u --recursive --new-file --exclude=BitKeeper --exclude=ChangeSet --exclude=SCCS linux-2.5/include/asm-sparc64/mmu_context.h build/include/asm-sparc64/mmu_context.h
> --- linux-2.5/include/asm-sparc64/mmu_context.h Thu Feb 14 13:50:37 2002
> +++ build/include/asm-sparc64/mmu_context.h     Thu Feb 14 10:55:16 2002
> @@ -27,25 +27,6 @@
>  #include <asm/system.h>
>  #include <asm/spitfire.h>
> 
> -/*
> - * Every architecture must define this function. It's the fastest
> - * way of searching a 168-bit bitmap where the first 128 bits are
> - * unlikely to be set. It's guaranteed that at least one of the 168
> - * bits is cleared.
> - */
> -#if MAX_RT_PRIO != 128 || MAX_PRIO != 168
> -# error update this function.
> -#endif
> -
> -static inline int sched_find_first_bit(unsigned long *b)
> -{
> -       if (unlikely(b[0]))
> -               return __ffs(b[0]);
> -       if (unlikely(b[1]))
> -               return __ffs(b[1]) + 64;
> -       return __ffs(b[2]) + 128;
> -}
> -
>  static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk, unsigned cpu)
>  {
>  }
> diff -u --recursive --new-file --exclude=BitKeeper --exclude=ChangeSet --exclude=SCCS linux-2.5/include/asm-sparc64/system.h build/include/asm-sparc64/system.h
> --- linux-2.5/include/asm-sparc64/system.h      Thu Feb 14 13:50:37 2002
> +++ build/include/asm-sparc64/system.h  Thu Feb 14 10:55:03 2002
> @@ -172,7 +172,7 @@
>          * not preserve it's value.  Hairy, but it lets us remove 2 loads
>          * and 2 stores in this critical code path.  -DaveM
>          */
> -#define switch_to(prev, next, last)                                            \
> +#define switch_to(prev, next)                                                  \
>  do {   CHECK_LOCKS(prev);                                                      \
>         if (test_thread_flag(TIF_PERFCTR)) {                                    \
>                 unsigned long __tmp;                                            \
> @@ -193,16 +193,16 @@
>         "stx    %%i6, [%%sp + 2047 + 0x70]\n\t"                                 \
>         "stx    %%i7, [%%sp + 2047 + 0x78]\n\t"                                 \
>         "rdpr   %%wstate, %%o5\n\t"                                             \
> -       "stx    %%o6, [%%g6 + %3]\n\t"                                          \
> -       "stb    %%o5, [%%g6 + %2]\n\t"                                          \
> +       "stx    %%o6, [%%g6 + %2]\n\t"                                          \
> +       "stb    %%o5, [%%g6 + %1]\n\t"                                          \
>         "rdpr   %%cwp, %%o5\n\t"                                                \
> -       "stb    %%o5, [%%g6 + %5]\n\t"                                          \
> -       "mov    %1, %%g6\n\t"                                                   \
> -       "ldub   [%1 + %5], %%g1\n\t"                                            \
> +       "stb    %%o5, [%%g6 + %4]\n\t"                                          \
> +       "mov    %0, %%g6\n\t"                                                   \
> +       "ldub   [%0 + %4], %%g1\n\t"                                            \
>         "wrpr   %%g1, %%cwp\n\t"                                                \
> -       "ldx    [%%g6 + %3], %%o6\n\t"                                          \
> -       "ldub   [%%g6 + %2], %%o5\n\t"                                          \
> -       "ldx    [%%g6 + %4], %%o7\n\t"                                          \
> +       "ldx    [%%g6 + %2], %%o6\n\t"                                          \
> +       "ldub   [%%g6 + %1], %%o5\n\t"                                          \
> +       "ldx    [%%g6 + %3], %%o7\n\t"                                          \
>         "mov    %%g6, %%l2\n\t"                                                 \
>         "wrpr   %%o5, 0x0, %%wstate\n\t"                                        \
>         "ldx    [%%sp + 2047 + 0x70], %%i6\n\t"                                 \
> @@ -210,13 +210,13 @@
>         "wrpr   %%g0, 0x94, %%pstate\n\t"                                       \
>         "mov    %%l2, %%g6\n\t"                                                 \
>         "wrpr   %%g0, 0x96, %%pstate\n\t"                                       \
> -       "andcc  %%o7, %6, %%g0\n\t"                                             \
> +       "andcc  %%o7, %5, %%g0\n\t"                                             \
>         "bne,pn %%icc, ret_from_syscall\n\t"                                    \
> -       " ldx   [%%g5 + %7], %0\n\t"                                            \
> -       : "=&r" (last)                                                          \
> +       " nop\n\t"                                                              \
> +       : /* no outputs */                                                      \
>         : "r" (next->thread_info),                                              \
>           "i" (TI_WSTATE), "i" (TI_KSP), "i" (TI_FLAGS), "i" (TI_CWP),          \
> -         "i" (_TIF_NEWCHILD), "i" (TI_TASK)                                    \
> +         "i" (_TIF_NEWCHILD)                                                   \
>         : "cc", "g1", "g2", "g3", "g5", "g7",                                   \
>           "l2", "l3", "l4", "l5", "l6", "l7",                                   \
>           "i0", "i1", "i2", "i3", "i4", "i5",                                   \
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
