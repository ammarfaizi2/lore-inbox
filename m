Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbRGKSeI>; Wed, 11 Jul 2001 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264709AbRGKSds>; Wed, 11 Jul 2001 14:33:48 -0400
Received: from sloth.wcug.wwu.edu ([140.160.176.172]:40734 "HELO
	sloth.wcug.wwu.edu") by vger.kernel.org with SMTP
	id <S264797AbRGKSdk>; Wed, 11 Jul 2001 14:33:40 -0400
Date: Wed, 11 Jul 2001 11:33:40 -0700 (PDT)
From: Josh Logan <josh@wcug.wwu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Andrew Morton <andrewm@uow.edu.au>,
        Klaus Dittrich <kladit@t-online.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <20010711175809.F3496@athlon.random>
Message-ID: <Pine.BSO.4.21.0107111129150.26715-100000@sloth.wcug.wwu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having a hang right after the floppy is initialised with pre5 and pre6
(2.4.3 works fine)  I tried this patch, but it did not make any
improvments.  The machine still has SysRq commands available.  Please let
me know what other information you would like to debug this problem.

BTW, I also tried to disable the floppy in the BIOS and got:
...
Floppy OK
task queue still active
<HANG>

							Later, JOSH


On Wed, 11 Jul 2001, Andrea Arcangeli wrote:

> On Wed, Jul 11, 2001 at 04:22:04PM +0200, Trond Myklebust wrote:
> > >>>>> " " == Andrew Morton <andrewm@uow.edu.au> writes:
> > 
> >      > Trond Myklebust wrote:
> >     >>
> >     >> ...  I have the same problem on my setup. To me, it looks like
> >     >> the loop in spawn_ksoftirqd() is suffering from some sort of
> >     >> atomicity problem.
> > 
> >      > Does a `set_current_state(TASK_RUNNING);' in spawn_ksoftirqd()
> >      > fix it?  If so we have a rogue initcall...
> > 
> > Nope. The same thing happens as before.
> > 
> > A couple of debugging statements show that ksoftirqd_CPU0 gets created
> > fine, and that ksoftirqd_task(0) is indeed getting set correctly
> > before we loop in spawn_ksoftirqd().
> > After this the second call to kernel_thread() succeeds, but
> > ksoftirqd() itself never gets called before the hang occurs.
> 
> ksoftirqd is quite scheduler intensive, and while its startup is
> correct (no need of any change there), it tends to trigger scheduler
> bugs (one of those bugs was just fixed in pre5). The reason I never seen
> the deadlock I also fixed this other scheduler bug in my tree:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre5aa1/00_sched-yield-1
> 
> this one I forgot to sumbit but here it is now for easy merging:
> 
> --- 2.4.4aa3/kernel/sched.c.~1~	Sun Apr 29 17:37:05 2001
> +++ 2.4.4aa3/kernel/sched.c	Tue May  1 16:39:42 2001
> @@ -674,8 +674,10 @@
>  #endif
>  	spin_unlock_irq(&runqueue_lock);
>  
> -	if (prev == next)
> +	if (prev == next) {
> +		current->policy &= ~SCHED_YIELD;
>  		goto same_process;
> +	}
>  
>  #ifdef CONFIG_SMP
>   	/*
> 
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

