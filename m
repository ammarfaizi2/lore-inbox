Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317559AbSFIFvE>; Sun, 9 Jun 2002 01:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317565AbSFIFvD>; Sun, 9 Jun 2002 01:51:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35575 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317559AbSFIFvD>;
	Sun, 9 Jun 2002 01:51:03 -0400
Message-ID: <3D02EC24.FC3D5AC0@mvista.com>
Date: Sat, 08 Jun 2002 22:48:20 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] missing GET_CPU_IDX in i386 entry.S
In-Reply-To: <3D0223AD.4030208@quark.didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> resume_kernel uses CPU_IDX but never uses GET_CPU_IDX to get the index.
>   This is an issue when smp and preemption are both enabled.  I also
> removed the unused GET_CURRENT_CPU_IDX.

Gosh, your right.  How did you find this?

I think the better solution, however, is to remove the whole
test.  Since the preempt counter gets bumped on each
interrupt and every local_bh_disable, this code should NEVER
find either of the two counters other than zero (since we
already know preemt count is zero).

Good work.

-g
> 
> --
>                                 Brian Gerst
> 
>   ------------------------------------------------------------
> diff -urN linux-bk/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
> --- linux-bk/arch/i386/kernel/entry.S   Wed May 29 15:06:00 2002
> +++ linux/arch/i386/kernel/entry.S      Sat Jun  8 10:44:44 2002
> @@ -83,13 +83,9 @@
>  #define GET_CPU_IDX \
>                 movl TI_CPU(%ebx), %eax;  \
>                 shll $irq_array_shift, %eax
> -#define GET_CURRENT_CPU_IDX \
> -               GET_THREAD_INFO(%ebx); \
> -               GET_CPU_IDX
>  #define CPU_IDX (,%eax)
>  #else
>  #define GET_CPU_IDX
> -#define GET_CURRENT_CPU_IDX GET_THREAD_INFO(%ebx)
>  #define CPU_IDX
>  #endif
> 
> @@ -236,6 +232,7 @@
>         movl TI_FLAGS(%ebx), %ecx
>         testb $_TIF_NEED_RESCHED, %cl
>         jz restore_all
> +       GET_CPU_IDX
>         movl irq_stat+local_bh_count CPU_IDX, %ecx
>         addl irq_stat+local_irq_count CPU_IDX, %ecx
>         jnz restore_all

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
