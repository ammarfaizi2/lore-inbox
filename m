Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWEDHkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWEDHkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWEDHke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:40:34 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:26636 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751432AbWEDHke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:40:34 -0400
Message-ID: <4459AFD8.1080408@shadowen.org>
Date: Thu, 04 May 2006 08:40:08 +0100
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

A quick patch to check for a 0 rsp triggers, so will try and find out
what the new process is.

-apw
