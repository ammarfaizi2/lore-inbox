Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbWF2RAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbWF2RAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWF2RAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:00:53 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:29483 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750985AbWF2RAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:00:51 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: i386 IPI handlers running with hardirq_count == 0 
In-reply-to: Your message of "29 Jun 2006 13:25:38 +0200."
             <p73wtb0w6dp.fsf@verdi.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Jun 2006 03:00:42 +1000
Message-ID: <9914.1151600442@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (on 29 Jun 2006 13:25:38 +0200) wrote:
>Andrew Morton <akpm@osdl.org> writes:
>
>> On Thu, 29 Jun 2006 19:01:17 +1000
>> Keith Owens <kaos@ocs.com.au> wrote:
>> 
>> > Macro arch/i386/kernel/entry.S::BUILD_INTERRUPT generates the code to
>> > handle an IPI and call the corresponding smp_<name> C code.
>> > BUILD_INTERRUPT does not update the hardirq_count for the interrupted
>> > task, that is left to the C code.  Some of the C IPI handlers do not
>> > call irq_enter(), so they are running in IRQ context but the
>> > hardirq_count field does not reflect this.  For example,
>> > smp_invalidate_interrupt does not set the hardirq count.
>> > 
>> > What is the best fix, change BUILD_INTERRUPT to adjust the hardirq
>> > count or audit all the C handlers to ensure that they call irq_enter()?
>> > 
>> 
>> The IPI handlers run with IRQs disabled.  Do we need a fix?
>
>They have to because if there was another interrupt it would execute
>IRET and then clear the NMI flag in the hardware and allow nested NMIs 
>which would cause all sorts of problems.
>
>The only reason to change it would be complex callbacks in the
>current handlers using notifier chains. Maybe if they're that complex they 
>should become simpler? 

My question has nothing to do with NMI.  I am querying inconsistent
behaviour amongst normal IPIs, this list :-

i386 function                   irq_enter?
smp_apic_timer_interrupt           yes
smp_call_function_interrupt        yes
smp_error_interrupt                yes
smp_invalidate_interrupt           no - why
smp_reschedule_interrupt           no (does not need it)
smp_spurious_interrupt             yes
smp_thermal_interrupt              yes

x86_64 function                 irq_enter?
mce_threshold_interrupt            yes
smp_apic_timer_interrupt           yes
smp_call_function_interrupt        yes
smp_error_interrupt                yes
smp_invalidate_interrupt           no - why
smp_reschedule_interrupt           no (does not need it)
smp_spurious_interrupt             yes
smp_thermal_interrupt              yes

That is just the mach-default list, I have not checked the platforms
like voyager.

