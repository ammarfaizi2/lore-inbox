Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWEDQ30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWEDQ30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWEDQ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:29:26 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:25869 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1030195AbWEDQ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:29:26 -0400
Message-ID: <445A2BA1.6020900@shadowen.org>
Date: Thu, 04 May 2006 17:28:17 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>,
       Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com> <200605022209.37205.ak@suse.de> <44586E0E.76E4.0078.0@novell.com> <200605030849.44893.ak@suse.de> <445903DD.6090408@shadowen.org>
In-Reply-To: <445903DD.6090408@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Andi Kleen wrote:
> 
>>On Wednesday 03 May 2006 08:47, Jan Beulich wrote:
>>
>>
>>>>>>Andi Kleen <ak@suse.de> 02.05.06 22:09 >>>
>>>>
>>>>On Tuesday 02 May 2006 22:00, Martin Bligh wrote:
>>>>
>>>>
>>>>
>>>>>>Index: linux/arch/x86_64/kernel/traps.c
>>>>>>===================================================================
>>>>>>--- linux.orig/arch/x86_64/kernel/traps.c
>>>>>>+++ linux/arch/x86_64/kernel/traps.c
>>>>>>@@ -238,6 +238,7 @@ void show_trace(unsigned long *stack)
>>>>>>			HANDLE_STACK (stack < estack_end);
>>>>>>			i += printk(" <EOE>");
>>>>>>			stack = (unsigned long *) estack_end[-2];
>>>>>>+			printk("new stack %lx (%lx %lx %lx %lx %lx)\n", stack, estack_end[0], estack_end[-1],
>>>
>>>estack_end[-2], estack_end[-3], estack_end[-4]);
>>>
>>>
>>>>>>			continue;
>>>>>>		}
>>>>>>		if (irqstack_end) {
>>>>>
>>>>>Thanks for running this Andy:
>>>>>
>>>>>http://test.kernel.org/abat/30183/debug/console.log 
>>>>
>>>>
>>>><EOE>new stack 0 (0 0 0 10082 10)
>>>
>>>Looks like <rubbish> <SS> <RSP> <RFLAGS> <CS> to me, ...
>>
>>
>>Hmm, right.
>> 
>>
>>
>>>>Hmm weird. There isn't anything resembling an exception frame at the top of the
>>>>stack.  No idea how this could happen.
>>>
>>>... which is a valid frame where the stack pointer was corrupted before the exception occurred. One more printed item
>>>(or rather, starting items at estack_end[-1]) would allow at least seeing what RIP this came from.
>>
>>
>>Any can you add that please and check? 
> 
> 
> Ok.  Just got some results (in full at the end of the message).  Seems
> that this is indeed a stack frame:
> 
> 	new stack 0 (0 0 10046 10 ffffffff8047c8e8)
> 
> And if my reading of the System.map is right, this is _just_ in schedule.
> 
> ffffffff8047c17e T sha_init
> ffffffff8047c1a8 T __sched_text_start
> ffffffff8047c1a8 T schedule
> ffffffff8047c8ed T thread_return
> ffffffff8047c9be T wait_for_completion
> ffffffff8047caa8 T wait_for_completion_timeout
> 
> By the looks of it that would make it here, at the call __switch_to?
> Which of course makes loads of sense _if_ the loaded stack pointer was
> crap say 0.
> 
> #define switch_to(prev,next,last) \
>         asm volatile(SAVE_CONTEXT     \
>                      "movq %%rsp,%P[threadrsp](%[prev])\n\t" /* save RSP
> */   \
>                      "movq %P[threadrsp](%[next]),%%rsp\n\t" /* restore
> RSP */   \
>                      "call __switch_to\n\t"   \
>                      ".globl thread_return\n" \
>                      "thread_return:\n\t"
> 
> I'll go shove some debug in there and see what pops out.


Ok.  I've been playing with this some.  Basically when we pick up the
new process to schedule it has a 0 rsp.  Dumping out the comm and flags
both reveal 0's throughout.  I tried another run poisoning the flags
field when freeing a task but the flags remain 0.

Anyone got any good ideas for patches to blame?

-apw
