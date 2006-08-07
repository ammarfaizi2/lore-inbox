Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWHGXGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWHGXGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHGXGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:06:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17938 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751120AbWHGXGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:06:25 -0400
Date: Tue, 8 Aug 2006 01:06:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Message-ID: <20060807230622.GP3691@stusta.de>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com> <20060807085924.72f832af.rdunlap@xenotime.net> <m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com> <20060807105537.08557636.rdunlap@xenotime.net> <m1psfcbcnk.fsf@ebiederm.dsl.xmission.com> <20060807194047.GM3691@stusta.de> <m1mzag9o8w.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mzag9o8w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 04:26:07PM -0600, Eric W. Biederman wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > On Mon, Aug 07, 2006 at 12:53:35PM -0600, Eric W. Biederman wrote:
> >>...
> >> --- a/arch/x86_64/Kconfig
> >> +++ b/arch/x86_64/Kconfig
> >> @@ -384,6 +384,20 @@ config NR_CPUS
> >>  	  This is purely to save memory - each supported CPU requires
> >>  	  memory in the static kernel configuration.
> >>  
> >> +config NR_IRQS
> >> +	int "Maximum number of IRQs (224-57344)"
> >
> > 	int "Maximum number of IRQs (224-57344)" depends on SMP
> >
> > This way, people with SMP=n will not see this question.
> 
> I doubt it will be interesting but it might be, it is certainly
> well defined what happens when you have more irqs that a cpu
> has irq destinations.

The only effect of the user visibility of this option with SMP=n is that 
the user might choose a higher value resulting in wasted space.

We do already have a big amount of options, there's no reason for 
showing more than required.

> >> +	range 224 57344
> >> +	default "4096" if SMP
> >> +	default "224" if !SMP
> >
> > Why not always
> >          default "224"
> > ?
> 
> A couple of reasons.
> - Things still need shaking out at the > 256 irq level and since
>   this is going into -mm it is reasonable to have a large default.

For -mm, it might make even more sense defaulting to 57344 for getting a 
better testing coverage.

This would give a good feedback of both space usage problems and the 
timing behavior of all the
    for (i = 0; i < NR_IRQS; i++)
loops in the kernel.

> - It is silly to have a default that won't work on some hardware,
>   that we can support without unreasonable overhead.

So let's default NR_CPUS to 255 and NR_IRQS to 57344?

It's also silly if the defaults waste space (and time) for the majority 
of users.

> - There are major simplicity gains to be had from a slight sparse
>   irq space.
> 
> - I haven't a clue what the irq numbers look like in the real world
>   that we should be supporting since there was code in x86_64 and
>   i386 to hack them up terribly.  All I have a clue about are
>   the really big machines.  So I wouldn't be surprised if there
>   were some small but I/O heavy machines that found 224 too limiting.
>   I know of at least one uniprocessor machine that would have used
>   almost all 224 irqs.
> 
> - I want people to realize that we can easily have more than 256 irqs.
>   With pure software interrupt sources and networking drivers allocating
>   one irq per cpu the chances of us using our maximum allotment of irqs
>   is much more likely in the next couple of years.

The common x86_64 SMP machine for sale today is a dual core desktop.

More than 224 IRQs are an exceptional case, and we can expect people 
building such systems to know what they are doing.

> - 4096 is the number I expect distribution vendors will ship.  Why set
>   a different default than what you expect most people will use?

Defaults are not for distributions.

Distribution maintainers are expected to set such options not depending 
on the defaults but depending on the needs of their users.

Depending on whether the distribution targets only desktop users, or 
whether the primary target are big servers, 4096 might be wrong in any 
direction.

> Eric

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

