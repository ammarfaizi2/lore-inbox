Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUIWEGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUIWEGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIWEE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:04:58 -0400
Received: from mail.aknet.ru ([217.67.122.194]:50956 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S268249AbUIWD7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:59:16 -0400
Message-ID: <41524C76.3020505@aknet.ru>
Date: Thu, 23 Sep 2004 08:09:26 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz>
In-Reply-To: <20040922200228.GB11017@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Petr Vandrovec wrote:
>> 1. I am not allocating the ring1 stack separately,
>> I am allocating it on a ring0 stack. Much simpler
>> code, although non-reentrant/preempt-unsafe.
> I think that it is problem.  And do not forget that NMI can occur at any
> place, so I'm not quite sure how your code works.
Why it is not preempt-unsafe, I beleive, is because
if it is preempted after modifying GDT, and then
another process will walk that path modifying GDT,
the first process will not return anywhere. But as
for NMI this should not be the case, as it doesn't
seem to call schedule().

> What if exception occurs in CPL1 code?  Processor reloads SS/ESP from
> TSS, pointing at top of CPL0 stack - where it overwrites CPL1 stack -
> - and it pushes on top of CPL0 stack address of CPL1 - and real return
> address for CPL3 was lost :-(  Boom.
But for that I reserve the room on stack, so that
should not hurt.

> You change base address for SS segment - in that case you need per-CPU
> SS segment, it wont' work with global SS segment.
But I beleive it *is* per-CPU, no? I am taking the
TI_cpu value from the thread struct to look up the
proper GDT, should that work? (no SMP-box here to
test)

> Did you tried setting SS/ESP on stack to invalid values, so IRET on CPL1
> triggers fault?  You should be able to do that by modifying SS/ESP from
> signal handler.
Yes, I did that - that seem to work (i.e. no Oops
or something bad).

>> +#define NMI_STACK_RESERVE 0x400
>> +#define MAKE_ESPFIX \
>> +	cli; \
>> +	subl $NMI_STACK_RESERVE, %esp; \
> This is ugly.  What if NMI handler uses more than 1KB?
Adjusting NMI_STACK_RESERVE? I need only a few
bytes of stack to work with, so I can reserve
any amount for NMI. What should it be? 0x400 was
taken "randomly", but really, is it worth allocating
another per-CPU object to only save a few bytes of
the ring-0 stack?

> What about referencing 14+NMI_STACK_RESERVE() ?
Will work either, but for what? Just looks a bit
cleaner to me to do it that way, or am I missing
something?

> And ESP is not
> multiple of 4 here - it may slow down processor a bit.
But I have to store the value of ((ESP & 0xffff) | 4) on
stack, so that's why I do that. How can it be
done in a more effective way? pushl, then movw?

> I think that you should prepare stack by using moves to
> -NMI_STACK_RESERVE-xx(%esp) instead of adjusting stack and using pushes.
I can do that of course, do you think it is faster?

> Or you can (if you want per-thread and not per-CPU stack) prepare CPL1
> stack above CPL0 stack - this way you steal 24 bytes from CPL0 stack,
> but CPL0 can use full 4KB (8KB), without NMI being limited by 1KB.
Ughh, I really need the motivation to fiddle with
the CPL1 stack separately. I don't want to limit the
NMI handler, and 0x400 was just a random value. Maybe
just enlarging it will resolve the problem?

>> +	pushl 20(%esp); \
>> +	andl $~(IF_MASK | TF_MASK | RF_MASK | NT_MASK | AC_MASK), (%esp); \
>> +	orl $IOPL1_MASK, (%esp); \
> Does this work if userspace runs with iopl 3,2 or 1?  Does iret on CPL1
Yes, that should work I think.

> set iopl level properly (i.e. is iopl set if IOPL <= CPL, or only if CPL=0?).
Ring-1 code can't alter the IOPL, but then I set
IOPL3 initially. I just use ring3_IOPL|IOPL1, which
should be able to handle all cases (i.e. I do
"pushl 20(%esp)" exactly only to get the Ring-3 IOPL,
I don't care about the other flags there).

> I'm not sure about lea speed.  And fast path should NOT jump,
> forward jumps are initialy predicted as not taken... Maybe:
No problems.

> And then you can move MAKE_ESPFIX out of macro.
Good idea! :)

> And it seems to me that it adds too many operations to fast path.
Ughh, 8 insns only! Is this really too much? :(

> Maybe you want to introduce some per-thread flag,
I don't know. Probably not. I'll think about that.

> or leave syscall path
> to corrupt ESP (dosemu apps should not call Linux INT syscall, yes?).
Yes. I'll see how that can be done.

>> -	if (regs->xcs & 3)
>> +	if (regs->xcs & 2)
>>  		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
> I think you should leave this as is, regs->xss/regs->esp should be valid
> for CPL1 exceptions.
Very probably, I was not sure about all that
s/3/2/g changes I made. So I'll remove those
you mentioned, thanks. It was just that the
kernel/user code should now be considered by
regs->xcs&2 rather than regs->xcs&3, so I just
replaced it everywhere. I'll have a closer look.

Also I was suggested privately to try doing
everything at Ring-0 after all (unfortunately
the guy have not CCd the message to LKML).
I know that we use Ring-1 so that the NMI
handler to work on the small stack, but the
guy writes:

... but i think linux
already has a task gate for NMI, or if not, it should.

I should have a look also in that direction I think.

