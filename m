Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVKHCxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVKHCxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbVKHCxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:53:35 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:35747 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965036AbVKHCxf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:53:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QJHrRgWAq+jlXyLDlFOSK3dWoHPmQ08svdcKAYypxRqMukN/2HSVtqOp3CYt4WHXCV0BHMesA8mP6JC7be0EqDFrzfoUBKrqT99nMNH3RrtDDjkgZofvtf3XGybNES3GCIG9Juf94a5FPVlW+lwQliXU8OK+whq2WRlSmrpT9Ug=
Message-ID: <1e62d1370511071853o5d65f0dcm7548b7563615ed35@mail.gmail.com>
Date: Tue, 8 Nov 2005 07:53:34 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: liyu <liyu@ccoss.com.cn>
Subject: Re: [question] I doublt on timer interrput.
Cc: rml@novell.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4370006E.1050806@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436EEEA4.1020703@ccoss.com.cn>
	 <1e62d1370511070353o1d1d4931ncf0ff8a5f5658069@mail.gmail.com>
	 <4370006E.1050806@ccoss.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/05, liyu <liyu@ccoss.com.cn> wrote:
> Fawad Lateef Wrote:
>
> >
> >What I found in the kernel code is that scheduler_tick is called from
> >two locations in the kernel (2.6.14-mm1) code (i386).
> >
> >1) from kernel/timer.c in update_process_times which is called from
> >arch/i386/kernel/apic.c and its calling depends on the CONFIG_SMP
> >defined or not (see
> >http://sosdg.org/~coywolf/lxr/source/arch/i386/kernel/apic.c#L1160)
> >and as you don't have CONFIG_SMP enabled so its won't be called from
> >here.
> >
> >2) from sched_fork function in kernel/sched.c
> >(http://sosdg.org/~coywolf/lxr/source/kernel/sched.c#L1414) and I
> >think its called when newly forked process setup is going to be
> >performed, and I think as from here scheduler_tick is called in your
> >case, so you are getting different value for your variable tick_count
> >
> >scheduler_tick might be called from somewhere else which I am missing
> >so please CMIIW !
> >
> Please see this URL:
>
> http://lxr.linux.no/source/include/asm-i386/mach-default/do_timer.h#L20
>
> static inline void do_timer_interrupt_hook(struct pt_regs *regs)
> {
>         do_timer(regs);
> #ifndef CONFIG_SMP
>         update_process_times(user_mode(regs));
> #endif
> /*
>  * In the SMP case we use the local APIC timer interrupt to do the
>  * profiling, except when we simulate SMP mode on a uniprocessor
>  * system, in that case we have to call the local interrupt handler.
>  */
> #ifndef CONFIG_X86_LOCAL_APIC
>         profile_tick(CPU_PROFILING, regs);
> #else
>         if (!using_apic_timer)
>                 smp_local_timer_interrupt(regs);
> #endif
> }
>
>
> That is the code in 2.6.12, but 2.6.13.3 also same with it at least.
> So we call scheduler_tick() HZ times per second, both enable
> SMP or disable it.
>

Yes, this is the thing which I missed


> Nod, I agree with your words, the scheduler_tick() do not same with
> timer interrupt handler on call times. but I guess it should be more
> than jiffies, beacause of other functions also can call it (for example,
> as Lateef said, sched_fork().)
>
> I think that
>
> scheduler_tick() might be called from somewhere
>
> is not exact.
>
> We may note, it do not be EXPORT_SYMBOL_*()ed , so it only can be called
> from kernel core,
> not kernel modules. Such a few places we can find it use LXR or grep.
>

By saying __might_be_called_from_somewhere__ I meant that I am missing
some-other place __with-in_the_kernel_code__ from where it is called,
which you pointed to me (about do_timer.h)   :)

> I use setup one sysctl integer variable to watch the value of 'count_tick',
> Do this way have any problem? I found some value skips, but I think it is
> normal case.
>

If you are declaring count_tick as a global variable (without static)
in sched.c then you can just use it in your test module by specifying
extern for your variable

>
> However, I will make a experiemnt that write one hook like do_timer(),
> as Love said
>
> PS: if our scheduler_tick() is not called every timer interrput, the
> compute of task timeslice
> also is not exact ?!
>

Yes, I am now sure that it will be called for every timer interrupt ! :)

Thanks,

--
Fawad Lateef
