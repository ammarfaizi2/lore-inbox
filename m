Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWH0Qg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWH0Qg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWH0Qgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:36:55 -0400
Received: from gw.goop.org ([64.81.55.164]:17334 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932175AbWH0Qgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:36:55 -0400
Message-ID: <44F1CA1E.5010008@goop.org>
Date: Sun, 27 Aug 2006 09:36:46 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel.
References: <20060827084417.918992193@goop.org> <20060827084451.492329798@goop.org> <200608271757.18621.ak@suse.de>
In-Reply-To: <200608271757.18621.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>  
>> -	/* Clear %fs and %gs. */
>> -	asm volatile ("movl %0, %%fs; movl %0, %%gs" : : "r" (0));
>> +	/* Clear %fs. */
>> +	asm volatile ("mov %0, %%fs" : : "r" (0));
>> +
>> +	/* Set %gs for this CPU's PDA */
>> +	asm volatile ("mov %0, %%gs" : : "r" (__KERNEL_PDA));
>>     
>
> I would add memory clobbers here to make sure the dependency on read/write pda
> is right.
>   

Yep.  And the "m" args in the pda asm isn't quite right for rmw PDA ops 
(not that there are any at the moment).

>> +1:	movw GS(%esp), %gs
>>     
>
> movl is recommended in 32bit mode
>   

OK.  I thought the assembler objected to me about it.

>> --- a/arch/i386/kernel/signal.c
>> +++ b/arch/i386/kernel/signal.c
>> @@ -128,7 +128,7 @@ restore_sigcontext(struct pt_regs *regs,
>>  			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
>>  			 X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_CF)
>>  
>> -	GET_SEG(gs);
>> +	COPY_SEG(gs);
>>  	GET_SEG(fs);
>>  	COPY_SEG(es);
>>  	COPY_SEG(ds);
>> @@ -244,9 +244,7 @@ setup_sigcontext(struct sigcontext __use
>>  {
>>  	int tmp, err = 0;
>>  
>> -	tmp = 0;
>> -	savesegment(gs, tmp);
>> -	err |= __put_user(tmp, (unsigned int __user *)&sc->gs);
>> +	err |= __put_user(regs->xgs, (unsigned int __user *)&sc->gs);
>>  	savesegment(fs, tmp);
>>  	err |= __put_user(tmp, (unsigned int __user *)&sc->fs);
>>     
>
> Hmm, changing it for the sc looks a bit bogus. If everything 
> is right nothing should change for user space, but this changes something.
>   

The sigcontext contains the userspace register state at the time of the 
signal.  Since userspace %gs is stored in the on-stack pt_regs, that 
should be where it fetches it from to fill out the sigcontext, rather 
than the kernel's internal value of %gs - in other words, it should be 
the same as ds and es.  Or am I missing something?

>> @@ -306,7 +306,7 @@ static void do_sys_vm86(struct kernel_vm
>>  	tsk->thread.screen_bitmap = info->screen_bitmap;
>>  	if (info->flags & VM86_SCREEN_BITMAP)
>>  		mark_screen_rdonly(tsk->mm);
>> -	__asm__ __volatile__("xorl %eax,%eax; movl %eax,%fs; movl %eax,%gs\n\t");
>> +	__asm__ __volatile__("movl %0,%%fs\n\t" : : "r" (0));
>>     
>
> This is actually a useful bug fix on its own.
>   

Yep.  But there seems to be some other very dubious code in there as 
well (the asm("mov %%eax,%0" : "=r" (eax)) sequence).  I was wondering 
about what it all does...

    J
