Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWHAVWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWHAVWv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 17:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWHAVWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 17:22:51 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:32260 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751034AbWHAVWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 17:22:50 -0400
Message-ID: <44CFC139.4030801@vmware.com>
Date: Tue, 01 Aug 2006 14:01:45 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
Cc: akpm@osdl.org, 76306.1226@compuserve.com, ak@muc.de, JBeulich@novell.com,
       rohitseth@google.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net> <44CE766D.6000705@vmware.com> <44CF474C.9070800@aknet.ru>
In-Reply-To: <44CF474C.9070800@aknet.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> Hi Zach and thanks for you really great review!
>
> Zachary Amsden wrote:
>> Overall, this looks like a great cleanup.  But I think there are some 
>> details with the patch that need fixing.  It is extremely hard to 
>> follow the entry.S changes based on patches alone - which tree does 
>> this apply cleanly to?
> This should cleanly apply to 2.6.18-rc2-mm1.
>
>> I would like to see the final result in entry.S, there are
> I'll send it to you privately.
>
>> still some details (dealing with eliminating the push/pop of %eax as 
>> a temporary for the segment comparison) which I could not follow 
>> exactly in patch format.
> The reason for removal was that I also removed the xorl %eax,%eax, 
> decl %eax
> stuff from error_code (replaced with $-1, as you've seen), and so 
> preserving
> %eax became unnecessary I think.
>
>>> iret_exc:
>>> -    TRACE_IRQS_ON
>>> -    sti
>>>      pushl $0            # no error code
>>>      pushl $do_iret_error
>>>      jmp error_code
>>>  
>> Why did you remove the sti here?
> Because I simply broke my head over that code. If you say sti should
> stay - I beleive you. But please, explain me how it works, before I
> went crazy! :)

> I read the iret pseudo-code in the Intel manuals carefully. It first
> pops the iret frame into temporaries, then checks the values for
> validity, and then either faults or writes the values to the real
> registers. Now, if we have a bad user's iret frame, the iret will
> pop it, raise an exception and push a kernel's iret frame, while
> the popped user's frame at that point should be completely lost,
> as far as I can understand. Now we go into GPF handler, then to a
> fixup, push $0 as an error code, but what iret frame is above that
> error code? Where does it come from? Doesn't the iret loses the
> user's iret frame completely? Certainly I am missing something obvious
> here, but I just can't follow that magic...
>
>> Did you test this with deliberately faulting IRETs?  I think this is 
>> a bug.
> Yes, I tested that and it works (I have a rather extensive test-suite
> for that problem - faulting iret is always tested). But since I
> don't understand the magic, I can't say why it works.

You need to get a #GP or #NP on the faulting iret.  Several ways to do 
that -

1) Issue int $0x80 from last two bytes of an LDT code segment with 
truncated limit (#GP)
2) Move %ss to LDT, set %esp high.  Issue write LDT system call via int 
$0x80 that truncates the limit below %esp (#GP)
3) Move %cs / %ss to LDT.  Issue write LDT system call and make cs / ss 
segment not present (#NP)

Note that on the path back to the iret, interrupts are disabled.  The 
iret faults, but doesn't pop the user return frame.  The check for the 
fixup section will happen, and fixup_exception will return to the STI 
instruction in the fixup, with the user frame still above on the stack 
(but note the return pops EFLAGS, which disables interrupts as they were 
before for the iret).  The fixup returns, pushes a fake error code onto 
the stack, followed by a push of the exception handle, do_iret_error.  
It then re-enters the common error_code path, with saves registers and 
dispatches to do_iret_error, which follows the notify path, either 
killing the process with a SIGSEGV or delivering a signal.  The whole 
time the user return frame is sitting up there on the stack, so taking 
this exception:

DO_ERROR_INFO(32, SIGSEGV, "iret exception", iret_error, ILL_BADSTK, 0)

makes it appear as if the user instruction to which the kernel was 
trying to return caused a SIGSEGV / ILL_BADSTK.

I think you actually want interrupts enabled in that path, since if you 
look at the #GP handler, it is a trap gate, not an interrupt gate - so 
#GPs from userspace that take a very similar signal notifier path enter 
with interrupts enabled.  I don't think very much would go wrong if 
interrupts were left disabled, but it makes me nervous to change that 
semantic.


>> Bigger problem!  (*!)  It is _unsafe_ to call C-code here.
> Ow, holly shit!!! What a disaster... But you are right. Well,
> this will make my new patch really big...
>
>> You did not introduce this bug, I just spotted it now, and the old 
>> code has the same problem.
> You are wrong here - I introduced that bug as the old code is
> also mine. Linus attributed it to someone else though, probably
> by mistake (or did he just wanted to rescue me from the rant about
> that code? :). But it was mine.

Ah, ok.

>> There are two options I see to fixing this problem.  One is to move 
>> the GDT fixup code into assembler.  The other is to compile the GDT 
>> fixup code in a separate .o file with exactly specified CFLAGS to 
>> make sure -fomit-frame-pointer is not passed to it.
> Well, unsafe is unsafe. If we can't explicitly tell gcc to prefix the
> %ebp accesses with %ds, then I'd better go for an asm version.

Sounds like a plan.

>
>>> -    .quad 0x0000920000000000    /* 0xd0 - ESPFIX 16-bit SS */
>>> +    .quad 0x00cf92000000ffff    /* 0xd0 - ESPFIX SS */
>> Seems a bit dangerous to allow access to full 4GB through this.  Can 
>> you tighten the limit any?  I suppose not, because the high bits in 
>> %esp really could be anything.  But it might be nice to try setting 
>> the limit to regs->esp + THREAD_SIZE.  Of course, this is not 
>> strictly necessary, just an extra paranoid protection mechanism.
> Since, when calculating the base, I do &-THREAD_SIZE, I guess the minimal
> safe limit is regs->esp + THREAD_SIZE*2... Well, may just I not do 
> that please? :)
> For what, btw? There are no such a things for __KERNEL_DS or anything, so
> I just don't see the necessity.

It helps track down any bugs that could leak through otherwise and 
corrupt random memory.
