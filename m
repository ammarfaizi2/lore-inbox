Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbTGDTYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266134AbTGDTYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:24:18 -0400
Received: from franka.aracnet.com ([216.99.193.44]:1742 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S266126AbTGDTYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:24:16 -0400
Date: Fri, 04 Jul 2003 12:38:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <15480000.1057347497@[10.10.2.4]>
In-Reply-To: <20030704182617.GA955@holomorphy.com>
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no> <20030704093531.GA26348@holomorphy.com> <20030704095004.GB26348@holomorphy.com> <7910000.1057333295@[10.10.2.4]> <20030704182617.GA955@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>>>> Okay, now for the "final solution" wrt. sparse physical APIC ID's
>>>> in addition to what I hope is a fix for your bug. This uses a separate
>>>> bitmap type (of a NR_CPUS -independent width MAX_APICS) for physical
>>>> APIC ID bitmaps.
>>>> \begin{cross-fingers}
> 
> On Fri, Jul 04, 2003 at 08:41:38AM -0700, Martin J. Bligh wrote:
>> Is it really necessary to turn half the apic code upside down in order
>> to fix this? What's the actual bugfix that's buried in this cleanup?
>> Despite the fact you seem to have gone out of your way to make this
>> hard to review, there are a few things I can see that strike me as odd.
>> Not necessarily wrong, but requiring more explanation.
> 
> It's not a cleanup, and it doesn't touch trailing whitespace etc.

Maybe not, but it looks like one. Maybe if you actually explain
what you're trying to fix, and why?

I think this kind of change deserves a better explanation that 
"I'm right" ... that's my main objection.

> On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>>> -			if (i >= 0xf)
>>> +			if (i >= APIC_BROADCAST_ID)
> 
> On Fri, Jul 04, 2003 at 08:41:38AM -0700, Martin J. Bligh wrote:
>> Is that always correct? it's not equivalent.
> 
> It is.

Explain. Not obvious to the casual observer.

> On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>>> diff -prauN mm1-2.5.74-1/include/asm-i386/mach-bigsmp/mach_apic.h physid-2.5.74-1/include/asm-i386/mach-bigsmp/mach_apic.h
>>> --- mm1-2.5.74-1/include/asm-i386/mach-bigsmp/mach_apic.h	2003-07-03 12:23:56.000000000 -0700
>>> +++ physid-2.5.74-1/include/asm-i386/mach-bigsmp/mach_apic.h	2003-07-04 02:47:45.000000000 -0700
>>> @@ -29,15 +29,15 @@ static inline cpumask_t target_cpus(void
>>>  # define INT_DELIVERY_MODE dest_LowestPrio
>>>  # define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
>>> -#define APIC_BROADCAST_ID     (0x0f)
>>> +#define APIC_BROADCAST_ID     (0xff)
> 
> On Fri, Jul 04, 2003 at 08:41:38AM -0700, Martin J. Bligh wrote:
>> So ... you've tested that change on a bigsmp machine, right? 
>> At least, provide some reasoning here. Like this comment further down the
>> patch ...
> 
> APIC_BROADCAST_ID is an upper bound on valid physical APIC ID's as it
> is used in the code. That actually was commented in the patch.

I find it odd that this worked before then. Also seems to be a separate
issue from the rest of the patch. Is quite probably correct, is just
non-obvious in the context of the rest of the patch.

> On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>>> +/*
>>> + * this isn't really broadcast, just a (potentially inaccurate) upper
>>> + * bound for valid physical APIC id's
>>> + */
> 
> On Fri, Jul 04, 2003 at 08:41:38AM -0700, Martin J. Bligh wrote:
>> Which makes the change just look wrong to me. If you're thinking 
>> "physical clustered mode" that terminology just utterly confusing crap, 
>> and the change is wrong, as far as I can see. 
> 
> The change is correct, and I am not thinking of any such thing.
> APIC_BROADCAST_ID's sole usage is for terminating loops over physical
> APIC ID's while setting the physical APIC ID's of IO-APIC's.

Why is Summit 0xF, and bigsmp 0xFF then?

> On Fri, Jul 04, 2003 at 02:35:31AM -0700, William Lee Irwin III wrote:
>>> +++ physid-2.5.74-1/include/asm-i386/mach-numaq/mach_apic.h	
>>> 2003-07-04 02:45:17.000000000 -0700
>>> 
>>> -static inline cpumask_t apicid_to_cpu_present(int logical_apicid)
>>> +static inline physid_mask_t apicid_to_cpu_present(int logical_apicid)
>>>  {
>>>  	int node = apicid_to_node(logical_apicid);
>>>  	int cpu = __ffs(logical_apicid & 0xf);
>>>  
>>> -	return cpumask_of_cpu(cpu + 4*node);
>>> +	return physid_mask_of_physid(cpu + 4*node);
>>>  }
> 
> On Fri, Jul 04, 2003 at 08:41:38AM -0700, Martin J. Bligh wrote:
>> Hmmmm. What are you using physical apicids here for? They seem
>> irrelevant to this function. 
> 
> Look at where it's used.

I did. Still unclear why you think this is correct, or what physical
apicids have to do with a function that maps from apicids to  the
phys_cpu_present_map, which is a compact mapping of logical apicids
for NUMA-Q.

Sorry, but this needs more explanation.

M.
