Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267386AbRGLATd>; Wed, 11 Jul 2001 20:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267381AbRGLATY>; Wed, 11 Jul 2001 20:19:24 -0400
Received: from kullstam.ne.mediaone.net ([66.30.138.48]:1664 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S267383AbRGLATM>; Wed, 11 Jul 2001 20:19:12 -0400
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7p6 hang
In-Reply-To: <200107110849.f6B8nlm00414@df1tlpc.local.here>
	<shslmlv62us.fsf@charged.uio.no> <3B4C56F1.3085D698@uow.edu.au>
	<15180.24844.687421.239488@charged.uio.no>
	<20010711175809.F3496@athlon.random>
Organization: none
Date: 11 Jul 2001 20:17:48 -0400
In-Reply-To: <20010711175809.F3496@athlon.random>
Message-ID: <m24rsj57bn.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

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

thank you.

this patch fixes things for me too.

i was freezing at boot, right after the kernel prints the line
Initializing RT netlink.
with both 2.4.7-pre5 and 2.4.7-pre6.

after applying this to 2.4.7-pre6, things are working fine (afaict
after just a few minutes...).

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
