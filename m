Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVA0XAC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVA0XAC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVA0XAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:00:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42528
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261269AbVA0W6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:58:52 -0500
Date: Thu, 27 Jan 2005 23:58:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mauriciolin@gmail.com, tglx@linutronix.de, marcelo.tosatti@cyclades.com,
       edjard@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Message-ID: <20050127225854.GZ8518@opteron.random>
References: <3f250c71050121132713a145e3@mail.gmail.com> <3f250c7105012113455e986ca8@mail.gmail.com> <20050122033219.GG11112@dualathlon.random> <3f250c7105012513136ae2587e@mail.gmail.com> <1106689179.4538.22.camel@tglx.tec.linutronix.de> <3f250c71050125161175234ef9@mail.gmail.com> <20050126004901.GD7587@dualathlon.random> <3f250c7105012710541d3e7ad1@mail.gmail.com> <20050127221129.GX8518@opteron.random> <20050127142943.3fea07df.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127142943.3fea07df.akpm@osdl.org>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 02:29:43PM -0800, Andrew Morton wrote:
> I've already queued a patch for this:
> 
> --- 25/mm/oom_kill.c~mm-fix-several-oom-killer-bugs-fix	Thu Jan 27 13:56:58 2005
> +++ 25-akpm/mm/oom_kill.c	Thu Jan 27 13:57:19 2005
> @@ -198,12 +198,7 @@ static void __oom_kill_task(task_t *p)
>  	p->time_slice = HZ;
>  	p->memdie = 1;
>  
> -	/* This process has hardware access, be more careful. */
> -	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
> -		force_sig(SIGTERM, p);
> -	} else {
> -		force_sig(SIGKILL, p);
> -	}
> +	force_sig(SIGKILL, p);
>  }
>  
>  static struct mm_struct *oom_kill_task(task_t *p)

Thanks.

> However.  This means that we'll now kill off tasks which had hardware
> access.  What are the implications of this?

The implication of the above is basically that the X server won't be
able to restore the text mode, but that avoids the deadlock ;).

And they had not necessairly hardware access. They "might" have hardware
access. Note that an app may have hardware access even if it has no
rawio capabilities. One can run iopl and then change uid just fine. So
the above check is quite weak since it leaves the kernel susceptible to
bugs and memleaks in any app started by root. Kernel shouldn't trust
root apps, all apps are buggy, root apps too (I even once fixed a signal
race in /sbin/init that showed up with the schedule child first sched
optimization ;).

iopl and ioperm are the only two things we care about.  We can a
synchronous reliable eflags/ioperm value only from the "regs" in the
task context. Problem is that since we can pick a task to kill that
isn't necessairly the current task, we should start to approximate, and
assume the process is sleeping. The regs must be saved during
reschedule, so it should cache the old contents. So perhaps we can get a
pratically reliable eflags dump from the tss_struct. But this will not
be common code and it'll require a specialized arch API. Like
has_hw_access(). Only then we can make a stronger assumption and be
truly careful about sending SIGKILL.

The right way to do this is probably to wait a few seconds before
sending the sigkill. I'm not currently sure if it worth adding the
has_hw_access(). But certainly I would prefer to do nothing special with
only the sys_rawio capability. I thought I could wait the other patches
to be merged to avoid confusion before making more changes (since it'd
be a pretty self contained feature), but I can do that now if you
prefer.
