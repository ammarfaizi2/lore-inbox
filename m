Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbVKHBcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVKHBcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVKHBcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:32:42 -0500
Received: from [210.76.114.22] ([210.76.114.22]:50869 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S965088AbVKHBcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:32:41 -0500
Message-ID: <4370006E.1050806@ccoss.com.cn>
Date: Tue, 08 Nov 2005 09:33:34 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Fawad Lateef <fawadlateef@gmail.com>, rml@novell.com
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [question] I doublt on timer interrput.
References: <436EEEA4.1020703@ccoss.com.cn> <1e62d1370511070353o1d1d4931ncf0ff8a5f5658069@mail.gmail.com>
In-Reply-To: <1e62d1370511070353o1d1d4931ncf0ff8a5f5658069@mail.gmail.com>
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fawad Lateef Wrote:

>On 11/7/05, liyu <liyu@ccoss.com.cn> wrote:
>  
>
>>    I have one question about timer interrupt (i386 architecture).
>>
>>    As we known, the timer emit HZ times interrputs per second,
>>and in i386. The interrupt handler will call scheduler_tick()
>>each time (on i386 at least, both enable or disable APIC).
>>
>>    On my Celeron machine(IOW, only one CPU, not SMP/SMT), I defined
>>a global int variable 'tick_count' in kernel/sched.c, and add one line
>>of code like follow in scheduler_tick():
>>
>>    ++tick_count;
>>
>>    but I found it is not same with content of the /proc/interrupts,
>>and the differennt between them is not little.
>>
>>    I can not understand why that is.
>>
>>    Any useful idea.
>>
>>
>>    
>>
>
>What I found in the kernel code is that scheduler_tick is called from
>two locations in the kernel (2.6.14-mm1) code (i386).
>
>1) from kernel/timer.c in update_process_times which is called from
>arch/i386/kernel/apic.c and its calling depends on the CONFIG_SMP
>defined or not (see
>http://sosdg.org/~coywolf/lxr/source/arch/i386/kernel/apic.c#L1160)
>and as you don't have CONFIG_SMP enabled so its won't be called from
>here.
>
>2) from sched_fork function in kernel/sched.c
>(http://sosdg.org/~coywolf/lxr/source/kernel/sched.c#L1414) and I
>think its called when newly forked process setup is going to be
>performed, and I think as from here scheduler_tick is called in your
>case, so you are getting different value for your variable tick_count
>
>scheduler_tick might be called from somewhere else which I am missing
>so please CMIIW !
>
>--
>Fawad Lateef
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Please see this URL:

http://lxr.linux.no/source/include/asm-i386/mach-default/do_timer.h#L20

static inline void do_timer_interrupt_hook(struct pt_regs *regs)
{
        do_timer(regs);
#ifndef CONFIG_SMP
        update_process_times(user_mode(regs));
#endif
/*
 * In the SMP case we use the local APIC timer interrupt to do the
 * profiling, except when we simulate SMP mode on a uniprocessor
 * system, in that case we have to call the local interrupt handler.
 */
#ifndef CONFIG_X86_LOCAL_APIC
        profile_tick(CPU_PROFILING, regs);
#else
        if (!using_apic_timer)
                smp_local_timer_interrupt(regs);
#endif
}


That is the code in 2.6.12, but 2.6.13.3 also same with it at least.
So we call scheduler_tick() HZ times per second, both enable
SMP or disable it.

Nod, I agree with your words, the scheduler_tick() do not same with
timer interrupt handler on call times. but I guess it should be more
than jiffies, beacause of other functions also can call it (for example,
as Lateef said, sched_fork().)

I think that

scheduler_tick() might be called from somewhere

is not exact.

We may note, it do not be EXPORT_SYMBOL_*()ed , so it only can be called 
from kernel core,
not kernel modules. Such a few places we can find it use LXR or grep.

I use setup one sysctl integer variable to watch the value of 'count_tick',
Do this way have any problem? I found some value skips, but I think it is
normal case.


However, I will make a experiemnt that write one hook like do_timer(), 
as Love said

PS: if our scheduler_tick() is not called every timer interrput, the 
compute of task timeslice
also is not exact ?!

Thanks a lot.


-liyu

