Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWBWLlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWBWLlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWBWLlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:41:11 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:62925
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750997AbWBWLlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:41:10 -0500
Message-Id: <43FDADA0.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 23 Feb 2006 12:42:08 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 double fault enhancements
References: <200602221159.08969.jbeulich@novell.com> <20060222143212.0eea2ab0.akpm@osdl.org>
In-Reply-To: <20060222143212.0eea2ab0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andrew Morton <akpm@osdl.org> 22.02.06 23:32:12 >>>
>Jan Beulich <jbeulich@novell.com> wrote:
>>
>> Make the double fault handler use CPU-specific stacks. Add some
>> abstraction to simplify future change of other exception handlers to go
>> through task gates. Change the pointer validity checks in the double
>> fault handler to account for the fact that both GDT and TSS aren't in
>> static kernel space anymore. Add a new notification of the event
>> through the die notifier chain, also providing some environmental
>> adjustments so that various infrastructural things work independent of
>> the fact that the fault and the callbacks are running on other then the
>> normal kernel stack.
>
>Why?

In addition to what Andi said, the infrastructural changes are so that you can do
more than just printk()ing information, namely enter a debugger. Even for printk()
I doubt someone has verified and can guarantee for the future that the possible
code paths never use any of the things that make assumptions about the current
stack (specifically, uses of thread_info).

>> +# ifdef CONFIG_SMP
>
>Please don't bother with the space after the #.  Yes, it's for nesting
>level, but if someone later comes along and sticks more ifdefs around this
>code, they won't go through and add the extra spaces anyway.

Will change that.

>Such problems can be avoided by not adding the ifdefs at all..

Here, the code could probably be enabled always, but I dislike having dead code like
this needlessly compiled.

>> +#ifdef N_EXCEPTION_TSS
>
>Can't we use CONFIG_DOUBLEFAULT throughout?  It's very much clearer.

We could, when not considering broader use. I specifically introduced N_EXCEPTION_TSS
so that it wouldn't be as hard as it currently is to have other exceptions got through task
gates (nlkd's fault/trap/abort infrastructure does, for example).

>> +struct tss_struct exception_tss[NR_CPUS][N_EXCEPTION_TSS] __cacheline_aligned = {
>> +	[0 ... NR_CPUS-1] = {
>> +		[0 ... N_EXCEPTION_TSS-1] = {
>> +			.cs       = __KERNEL_CS,
>> +			.ss       = __KERNEL_DS,
>> +			.ss0      = __KERNEL_DS,
>> +			.__cr3    = __pa(swapper_pg_dir),
>> +			.io_bitmap_base = INVALID_IO_BITMAP_OFFSET,
>> +			.ds       = __USER_DS,
>> +			.es       = __USER_DS,
>> +			.eflags	  = X86_EFLAGS_SF | 0x2, /* 0x2 bit is always set */
>> +		},
>> +		[DOUBLEFAULT_TSS].eip = (unsigned long)doublefault_fn
>> +	}
>> +};
>> +#endif
>
>How much more RAM does this patch consume?

8k TSS plus 4k stack per CPU compared to a single global TSS plus 1k stack in current code. One could argue that the
I/O bitmap isn't really needed here, but mis-using it as stack wouldn't work well (because of the thread_info
restrictions the TSS would then need to be allocated so that the I/O bitmap gets page aligned), nor can it be easily
left off (struct tss_struct unfortunately includes this non-architectural part).

>> +#define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
>
>"EXCEPTION_STACK_SIZE", please.

Fine with me; just followed the x86-64 naming.

Jan
