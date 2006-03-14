Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWCNI0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWCNI0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWCNI0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:26:07 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:45584 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750778AbWCNI0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:26:06 -0500
Message-ID: <44167E03.3060807@vmware.com>
Date: Tue, 14 Mar 2006 00:25:39 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VMI Interface Proposal Documentation for I386, Part 5
References: <4415CE76.9030006@vmware.com> <Pine.LNX.4.64.0603132328270.11606@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0603132328270.11606@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Mon, 13 Mar 2006, Zachary Amsden wrote:
>
>   
>>   PROCESSOR STATE CALLS
>>
>>    This set of calls controls the online status of the processor.  It
>>    include interrupt control, reboot, halt, and shutdown functionality.
>>    Future expansions may include deep sleep and hotplug CPU capabilities.
>>
>>    VMI_DisableInterrupts
>>
>>       VMICALL void VMI_DisableInterrupts(void);
>>
>>       Disable maskable interrupts on the processor.
>>
>>       Inputs:      None
>>       Outputs:     None
>>       Clobbers:    Flags only
>>       Segments:    As this is both performance critical and likely to
>>          be called from low level interrupt code, this call does not
>>          require flat DS/ES segments, but uses the stack segment for
>>          data access.  Therefore only CS/SS must be well defined.
>>
>>    VMI_EnableInterrupts
>>
>>       VMICALL void VMI_EnableInterrupts(void);
>>
>>       Enable maskable interrupts on the processor.  Note that the
>>       current implementation always will deliver any pending interrupts
>>       on a call which enables interrupts, for compatibility with kernel
>>       code which expects this behavior.  Whether this should be required
>>       is open for debate.
>>     
>
> Mind if i push this debate slightly forward? If we were to move the 
> dispatch of pending interrupts elsewhere, where would that be? In 
> particular, for a device which won't issue any more interrupts until it's 
> previous interrupt is serviced. Perhaps injection at arbitrary points 
> during runtime when interrupts are enabled?
>   

Thanks for the response.

This is exactly what I was hoping for - discussion.  Think about this 
from the hypervisor perspective - if the guest enables interrupts, and 
you have something pending to deliver, for correctness, you have to 
deliver it, right now.  But does the kernel truly require that interrupt 
deliver immediately - in most cases, no.  In particular, on the fast 
path for system calls, one of the first instructions executed is "STI."  
Do you really want to take interrupts there?  No, but you have to let 
them come in.  So you work around that fact by allowing them, even if it 
inconveniences you.  In some cases, you have not yet set up even proper 
kernel segments to access data.

It could be possible to change the semantics of the interrupt masking 
interface in Linux, such that enable_interrupts() did just that - but 
did not yet deliver pending IRQs.  As did restore_interrupt_mask().  
This would require inspection of many drivers to ensure that they don't 
rely on those actions causing immediate interrupt delivery.  And if they 
did, they would require a call, say, deliver_pending_irqs() to 
accomplish that.

Is this a nice interface for Linux?  Probably not.  In fact, requiring 
source inspection of all drivers just for this would be a gargantuan 
task, as well as being difficult to maintain.  Perhaps, it may have some 
benefit - one ideology is that drivers should not in general require the 
ability to enable and receive interrupts immediately.  Otherwise, they 
are dependent on hardware responses to continue operation, which means 
they are probably not fault tolerant / recoverable.  But many drivers 
have been written this way.

The motivation here is entirely selfish.  Emulating the CPU by 
unquestioning delivery of interrupts is a fine course of action - but it 
does impose a slight overhead.  You first have to determine if there are 
any interrupts / callbacks / upcalls to be serviced.  This is not 
something you can do in one instruction, and moreover, you may have to 
deal with race conditions in determining whether or not any actions are 
pending.  So there is a measurable benefit, when running in a virtual 
machine, to separate the required delivery or interrupts with the 
enabling of them.

That is why I think it warrants discussion on the principles, although I 
am not sure that it is practical.

Zach
