Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280807AbRKLOd7>; Mon, 12 Nov 2001 09:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280804AbRKLOdu>; Mon, 12 Nov 2001 09:33:50 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:24580 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S280807AbRKLOdg>;
	Mon, 12 Nov 2001 09:33:36 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andrea Arcangeli <andrea@suse.de>
Date: Mon, 12 Nov 2001 15:33:03 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] fix loop with disabled tasklets
CC: mathijs@knoware.nl, jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kuznet@ms2.inr.ac.ru,
        Thorsten Kukuk <kukuk@suse.de>
X-mailer: Pegasus Mail v3.40
Message-ID: <8F913E94424@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Nov 01 at 15:20, Andrea Arcangeli wrote:

Hi Andrea,
  does it compile? It looks to me like that you are using ret_from_fork,
ret_from_smp and ret_from_smpfork interchangably in the patch. You renamed
ret_from_smpfork to ret_from_fork, changed extern ret_from_smpfork
to ret_from_smp, and you still call ret_from_smpfork ;-)

  Or do I miss something?
                                                Thanks,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

> --- 2.4.15pre2aa1/arch/sparc/kernel/entry.S.~1~ Sat Feb 10 02:34:05 2001
> +++ 2.4.15pre2aa1/arch/sparc/kernel/entry.S Mon Nov 12 15:17:32 2001
> @@ -1466,8 +1466,7 @@
>     b   C_LABEL(ret_sys_call)
>      ld [%sp + REGWIN_SZ + PT_I0], %o0
>  
> -#ifdef CONFIG_SMP
> -   .globl  C_LABEL(ret_from_smpfork)
> +   .globl  C_LABEL(ret_from_fork)
>  C_LABEL(ret_from_smpfork):
>     wr  %l0, PSR_ET, %psr
>     WRITE_PAUSE
> @@ -1475,7 +1474,6 @@
>      mov    %g3, %o0
>     b   C_LABEL(ret_sys_call)
>      ld [%sp + REGWIN_SZ + PT_I0], %o0
> -#endif
>  
>     /* Linux native and SunOS system calls enter here... */
>     .align  4
> --- 2.4.15pre2aa1/arch/sparc/kernel/process.c.~1~   Thu Oct 11 10:41:52 2001
> +++ 2.4.15pre2aa1/arch/sparc/kernel/process.c   Mon Nov 12 15:18:21 2001
> @@ -455,11 +455,7 @@
>   *       allocate the task_struct and kernel stack in
>   *       do_fork().
>   */
> -#ifdef CONFIG_SMP
> -extern void ret_from_smpfork(void);
> -#else
> -extern void ret_from_syscall(void);
> -#endif
> +extern void ret_from_smp(void);
>  
>  int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
>         unsigned long unused,
> @@ -493,13 +489,8 @@
>     copy_regwin(new_stack, (((struct reg_window *) regs) - 1));
>  
>     p->thread.ksp = (unsigned long) new_stack;
> -#ifdef CONFIG_SMP
>     p->thread.kpc = (((unsigned long) ret_from_smpfork) - 0x8);
>     p->thread.kpsr = current->thread.fork_kpsr | PSR_PIL;
> -#else
> -   p->thread.kpc = (((unsigned long) ret_from_syscall) - 0x8);
> -   p->thread.kpsr = current->thread.fork_kpsr;
> -#endif
>     p->thread.kwim = current->thread.fork_kwim;
>  
>     /* This is used for sun4c only */
