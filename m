Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265859AbTLIOZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265873AbTLIOXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:23:07 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13781
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265865AbTLIOUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:20:30 -0500
Date: Tue, 9 Dec 2003 15:21:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: linux-kernel@vger.kernel.org,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Subject: Re: oom killer in 2.4.23
Message-ID: <20031209142151.GB12532@dualathlon.random>
References: <Z6Iv-7O2-29@gated-at.bofh.it> <Z8Ag-3BK-3@gated-at.bofh.it> <Zbyn-23P-29@gated-at.bofh.it> <20031205140520.39289a3a.kristian.peters@korseby.net> <20031205195800.GB2121@dualathlon.random> <20031206103143.027ba4ec.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206103143.027ba4ec.kristian.peters@korseby.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 10:31:43AM +0100, Kristian Peters wrote:
> Andrea Arcangeli <andrea@suse.de> schrieb:
> > what you're complaining is the 'selection of the task to be killed'.
> > That's not solvable. the kernel can't read your brain period. Only if
> > the kernel could read the brain of the adminstrator then you would be
> > happy, there is no way the kernel can know which is the task you really
> > want to have killed first.
> 
> I agree. On a server the most likely application to be killed would be the service with the most pages in memory. And those services tend to be the important ones.
> 
> However, for a simple desktop-linux that statistical approach seems to
> be wrong. Your vm has even killed /sbin/getty sometimes, so that I
> can't login via a simple console.

I see this problem, for most desktop users the biggest task plus some
other random bit like the nicelevel and length of runtime etc.. actually
result in a reasonable estimate of the best task to kill.

> Re-enabling the oom-killer gives a good result for me:
> 
> Dec  6 09:46:19 adlib kernel: Out of Memory: Killed process 643 (khexedit).
> Dec  6 09:48:42 adlib kernel: Out of Memory: Killed process 645 (khexedit).
> 
> What I complain is that your vm kills some processes without
> mentioning in the logs. How can I determine what processes the kernel
> has killed ?

no this is is not the case. It is always mentioned in the logs. Grep for
VM and you'll find all of them, no difference from before. I agree it
would be very bad if the admin couldn't know what was killed exactly to
restart everything properly (with the bad app under rlimit the next time ;)

> I hope that fairly simple patch does things right for all people that
> want the old behaviour. It's already a year ago I last hacked on the
> kernel.
> 
> diff -rauN linux-2.4.23/include/linux/sched.h linux-2.4.23-kp1/include/linux/sched.h
> --- linux-2.4.23/include/linux/sched.h  Fri Nov 28 19:26:21 2003
> +++ linux-2.4.23-kp1/include/linux/sched.h      Sat Dec  6 09:57:04 2003
> @@ -429,6 +429,7 @@
>  #define PF_DUMPCORE    0x00000200      /* dumped core */
>  #define PF_SIGNALED    0x00000400      /* killed by a signal */
>  #define PF_MEMALLOC    0x00000800      /* Allocating memory */
> +#define PF_MEMDIE      0x00001000      /* Killed for out-of-memory */
>  #define PF_FREE_PAGES  0x00002000      /* per process page freeing */
>  #define PF_NOIO                0x00004000      /* avoid generating further I/O */
>  
> diff -rauN linux-2.4.23/mm/oom_kill.c linux-2.4.23-kp1/mm/oom_kill.c
> --- linux-2.4.23/mm/oom_kill.c  Fri Nov 28 19:26:21 2003
> +++ linux-2.4.23-kp1/mm/oom_kill.c      Fri Dec  5 20:31:39 2003
> @@ -21,8 +21,6 @@
>  #include <linux/swapctl.h>
>  #include <linux/timex.h>
>  
> -#if 0          /* Nothing in this file is used */
> -
>  /* #define DEBUG */
>  
>  /**
> @@ -257,5 +255,3 @@
>         first = now;
>         count = 0;
>  }
> -
> -#endif /* Unused file */
> diff -rauN linux-2.4.23/mm/vmscan.c linux-2.4.23-kp1/mm/vmscan.c
> --- linux-2.4.23/mm/vmscan.c    Fri Nov 28 19:26:21 2003
> +++ linux-2.4.23-kp1/mm/vmscan.c        Sat Dec  6 10:21:55 2003
> @@ -649,13 +649,7 @@
>                                 failed_swapout = !swap_out(classzone);
>                 } while (--tries);
>  
> -       if (likely(current->pid != 1))
> -               break;
> -       if (!check_classzone_need_balance(classzone))
> -               break;
> -
> -       __set_current_state(TASK_RUNNING);
> -       yield();
> +       out_of_memory();
>         }
>  
>         return 0;

this should go back to the 2.4.22 deadlock prone oom killer yes. you can
also leave the yield() in the main loop (after out_of_memory())
(__set_current_state(TASK_RUNNING) isn't needed these days just yield is
safe enough).
