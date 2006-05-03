Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWECT1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWECT1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 15:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWECT1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 15:27:30 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:29963 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750748AbWECT13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 15:27:29 -0400
Message-ID: <445903DD.6090408@shadowen.org>
Date: Wed, 03 May 2006 20:26:21 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jan Beulich <jbeulich@novell.com>, Martin Bligh <mbligh@google.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com> <200605022209.37205.ak@suse.de> <44586E0E.76E4.0078.0@novell.com> <200605030849.44893.ak@suse.de>
In-Reply-To: <200605030849.44893.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 03 May 2006 08:47, Jan Beulich wrote:
> 
>>>>>Andi Kleen <ak@suse.de> 02.05.06 22:09 >>>
>>>
>>>On Tuesday 02 May 2006 22:00, Martin Bligh wrote:
>>>
>>>
>>>>>Index: linux/arch/x86_64/kernel/traps.c
>>>>>===================================================================
>>>>>--- linux.orig/arch/x86_64/kernel/traps.c
>>>>>+++ linux/arch/x86_64/kernel/traps.c
>>>>>@@ -238,6 +238,7 @@ void show_trace(unsigned long *stack)
>>>>> 			HANDLE_STACK (stack < estack_end);
>>>>> 			i += printk(" <EOE>");
>>>>> 			stack = (unsigned long *) estack_end[-2];
>>>>>+			printk("new stack %lx (%lx %lx %lx %lx %lx)\n", stack, estack_end[0], estack_end[-1],
>>
>>estack_end[-2], estack_end[-3], estack_end[-4]);
>>
>>>>> 			continue;
>>>>> 		}
>>>>> 		if (irqstack_end) {
>>>>
>>>>Thanks for running this Andy:
>>>>
>>>>http://test.kernel.org/abat/30183/debug/console.log 
>>>
>>>
>>><EOE>new stack 0 (0 0 0 10082 10)
>>
>>Looks like <rubbish> <SS> <RSP> <RFLAGS> <CS> to me, ...
> 
> 
> Hmm, right.
>  
> 
>>>Hmm weird. There isn't anything resembling an exception frame at the top of the
>>>stack.  No idea how this could happen.
>>
>>... which is a valid frame where the stack pointer was corrupted before the exception occurred. One more printed item
>>(or rather, starting items at estack_end[-1]) would allow at least seeing what RIP this came from.
> 
> 
> Any can you add that please and check? 

Ok.  Just got some results (in full at the end of the message).  Seems
that this is indeed a stack frame:

	new stack 0 (0 0 10046 10 ffffffff8047c8e8)

And if my reading of the System.map is right, this is _just_ in schedule.

ffffffff8047c17e T sha_init
ffffffff8047c1a8 T __sched_text_start
ffffffff8047c1a8 T schedule
ffffffff8047c8ed T thread_return
ffffffff8047c9be T wait_for_completion
ffffffff8047caa8 T wait_for_completion_timeout

By the looks of it that would make it here, at the call __switch_to?
Which of course makes loads of sense _if_ the loaded stack pointer was
crap say 0.

#define switch_to(prev,next,last) \
        asm volatile(SAVE_CONTEXT     \
                     "movq %%rsp,%P[threadrsp](%[prev])\n\t" /* save RSP
*/   \
                     "movq %P[threadrsp](%[next]),%%rsp\n\t" /* restore
RSP */   \
                     "call __switch_to\n\t"   \
                     ".globl thread_return\n" \
                     "thread_return:\n\t"

I'll go shove some debug in there and see what pops out.
-apw

double fault: 0000 [1] SMP
last sysfs file: /devices/pci0000:00/0000:00:06.0/resource
CPU 0
Modules linked in:
Pid: 228, comm: kswapd0 Tainted: G   M  2.6.17-rc3-mm1-autokern1 #1
RIP: 0010:[<ffffffff8047c8e8>] <ffffffff8047c8e8>{__sched_text_start+1856}
RSP: 0000:0000000000000000  EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff805d9438
RDX: ffff8100e3d4a090 RSI: ffffffff805d9438 RDI: ffff8100e3d4a090
RBP: ffffffff805d9438 R08: 0000000000000001 R09: ffff8101001c9da8
R10: 0000000000000002 R11: 000000000000004d R12: ffffffff805013c0
R13: ffff8100013dc8c0 R14: ffff810008003620 R15: 000002a75ef255cc
FS:  0000000000000000(0000) GS:ffffffff805fa000(0000) knlGS:00000000f7e0b460
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: fffffffffffffff8 CR3: 000000006b004000 CR4: 00000000000006e0
Process kswapd0 (pid: 228, threadinfo ffff8101001c8000, task
ffff8100e3d4a090)
Stack: ffffffff80579e20 ffff8100e3d4a090 0000000000000001 ffffffff80579f58
       0000000000000000 ffffffff80579e78 ffffffff8020b0e3 ffffffff80579f58
       0000000000000000 ffffffff80485520
Call Trace: <#DF> <ffffffff8020b0e3>{show_registers+140}
       <ffffffff8020b388>{__die+159} <ffffffff8020b3fd>{die+50}
       <ffffffff8020bbd9>{do_double_fault+115}
<ffffffff8020aa91>{double_fault+125}
       <ffffffff8047c8e8>{__sched_text_start+1856} <EOE>new stack 0 (0 0
10046 10 ffffffff8047c8e8)


Code: e8 1c ba d8 ff 65 48 8b 34 25 00 00 00 00 4c 8b 46 08 f0 41
RIP <ffffffff8047c8e8>{__sched_text_start+1856} RSP <0000000000000000>
