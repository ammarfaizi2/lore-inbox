Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267977AbTCFKQw>; Thu, 6 Mar 2003 05:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267980AbTCFKQw>; Thu, 6 Mar 2003 05:16:52 -0500
Received: from ns.suse.de ([213.95.15.193]:29700 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267977AbTCFKQt>;
	Thu, 6 Mar 2003 05:16:49 -0500
Date: Thu, 6 Mar 2003 11:27:20 +0100
From: Andi Kleen <ak@suse.de>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
Message-ID: <20030306102720.GA23747@wotan.suse.de>
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com> <20030306010517.GB17865@wotan.suse.de> <3E66CB1A.6020107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E66CB1A.6020107@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 08:14:18PM -0800, Ulrich Drepper wrote:
> 
> > It should already work on the current kernel, modulo clone.
> > (but arch_prctl, set_thread_area in 2.5, ldt in 2.4 etc.)
> 
> I cannot confirm this.  I wasted a lot of time on getting it to work.
> Without avail.

We're using %fs enabled glibc (currently with arch_prctl, but I would
like to change that because it's slow) 

> And the problem is?  Nobody must mug around with the segment registers
> without knowing what s/he does.

It's hardcoding the magic fs register in the kernel for once.

> You don't need two interface.  Make prctl() do it automatically.  It has
> all the info it needs.  Forget about the set_thread_area syscall in
> 64-bit mode and simply use one fixed GDT entry in case the address
> passed to pcrtl() is small enough.  Same for clone(): the SETTLS
> parameter shole be a simple address.  Treat it as passed to prctl() and
> use a segment or the MSR.

I had some code like this for some time - not in prctl, but in set_thread_area,
but I removed it because the selector messing looked too ugly.

But that was before prctl reloaded the selector forcefully to zero.
That was later changed to fix another bug.

Now with it getting reloaded it would make sense to set it in the GDT
too if possible, I agree. I'll implement that.

It will also transparent speed up the glibcs already using arch_prctl.
I like that.

I can do a similar thing in clone. It unfortuately also hardcodes fs there,
but I guess that ugly hack will be needed to get the broken NPTL design for this
to work.

You just have to guarantee from user space that you don't do nasty
things with the selector.

> 
> - - have prctl() return the index and expect the user to load it.  This is
>   slightly binary incompatible (existing code depends on no such
>   requirement).  It could be solved by introducing ARCH_SET_FS_AUTO or
>   so;
> 
> - - automatically load the %fs or %gs register with the correct value
>   before returning from prctl().  This introduces no binary
>   incompatibilities and it's really the expected behavior.

It's already done (set to zero) to not confuse the lazy switch logic.

> 
> 
> If you don't want to do the work help me to get 2.5 running on my
> machine and I'll come up with a patch.

2.5.64 currently doesn't boot (known issue); 2.5.63 works however.
I'll look into the .64 problems later today and put a fix onto the
usual place when done (ftp://ftp.x86-64.org/pub/linux/v2.5/) 

-Andi
