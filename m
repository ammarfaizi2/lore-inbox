Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbSJIRfu>; Wed, 9 Oct 2002 13:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261943AbSJIRfu>; Wed, 9 Oct 2002 13:35:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47867 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261875AbSJIRfq>;
	Wed, 9 Oct 2002 13:35:46 -0400
Message-ID: <3DA46A17.447B2C59@mvista.com>
Date: Wed, 09 Oct 2002 10:40:39 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       Jeff Dike <jdike@karaya.com>
Subject: Re: [PATCH] make do_signal static on i386
References: <20021009181003.022da660.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will cause problems for nano_sleep and
clock_nanosleep.  These system calls need to call
do_signal() in order to meet the POSIX standard which states
that they are interrupted only by signals that are delivered
to user code.  Other signals are not to interrupt the
sleep.  This is why do_signal() returns this information to
the caller.

I suppose one could argue that such functions should be in
signal.c, but save for this signal issue the code is
common.  Seems a waste to support the same code in N
platforms.

-g

Stephen Rothwell wrote:
> 
> Hi Linus,
> 
> This patch makes do_signal static in arch/i386/kernel/signal.c which
> means its declaration can be removed from asm-i386/signal.h which may
> help Jeff out with UML.
> 
> I am not sure whether we need the FASTCALL() or whether the change
> in the comment in asm-um/signal.h makes sense.  (Does UML work on
> x86_64, yet?)
> 
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> 
> diff -ruN 2.5.41-1.715/arch/i386/kernel/signal.c 2.5.41-1.715-si.1/arch/i386/kernel/signal.c
> --- 2.5.41-1.715/arch/i386/kernel/signal.c      2002-10-02 11:23:54.000000000 +1000
> +++ 2.5.41-1.715-si.1/arch/i386/kernel/signal.c 2002-10-09 17:52:15.000000000 +1000
> @@ -27,6 +27,8 @@
> 
>  #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
> 
> +static int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
> +
>  /*
>   * Atomically swap in the new signal mask, and wait for a signal.
>   */
> @@ -545,7 +547,7 @@
>   * want to handle. Thus you cannot kill init even with a SIGKILL even by
>   * mistake.
>   */
> -int do_signal(struct pt_regs *regs, sigset_t *oldset)
> +static int do_signal(struct pt_regs *regs, sigset_t *oldset)
>  {
>         siginfo_t info;
>         int signr;
> diff -ruN 2.5.41-1.715/include/asm-i386/signal.h 2.5.41-1.715-si.1/include/asm-i386/signal.h
> --- 2.5.41-1.715/include/asm-i386/signal.h      2002-01-31 07:12:46.000000000 +1100
> +++ 2.5.41-1.715-si.1/include/asm-i386/signal.h 2002-10-09 17:54:28.000000000 +1000
> @@ -2,7 +2,6 @@
>  #define _ASMi386_SIGNAL_H
> 
>  #include <linux/types.h>
> -#include <linux/linkage.h>
> 
>  /* Avoid too many header ordering problems.  */
>  struct siginfo;
> @@ -217,9 +216,6 @@
>         return word;
>  }
> 
> -struct pt_regs;
> -extern int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
> -
>  #endif /* __KERNEL__ */
> 
>  #endif
> diff -ruN 2.5.41-1.715/include/asm-um/signal.h 2.5.41-1.715-si.1/include/asm-um/signal.h
> --- 2.5.41-1.715/include/asm-um/signal.h        2002-09-16 13:40:57.000000000 +1000
> +++ 2.5.41-1.715-si.1/include/asm-um/signal.h   2002-10-09 17:56:20.000000000 +1000
> @@ -6,7 +6,7 @@
>  #ifndef __UM_SIGNAL_H
>  #define __UM_SIGNAL_H
> 
> -/* Need to kill the do_signal() declaration in the i386 signal.h */
> +/* Need to kill the do_signal() declaration in the x86_64 signal.h */
> 
>  #define do_signal do_signal_renamed
>  #include "asm/arch/signal.h"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
