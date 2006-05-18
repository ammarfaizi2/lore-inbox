Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWERNk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWERNk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 09:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWERNk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 09:40:57 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:12746
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751079AbWERNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 09:40:56 -0400
Message-Id: <446C95CD.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 18 May 2006 15:42:05 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 1/3] reliable stack trace support
References: <4469FC07.76E4.0078.0@novell.com> <200605161704.15028.ak@suse.de>
In-Reply-To: <200605161704.15028.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +#ifdef CONFIG_STACK_UNWIND
>> +#include <asm/unwind.h>
>> +#else
>> +#include <asm-generic/unwind.h>
>> +#endif
>
>Normally the other archs should get stub includes that include asm-generic/unwind.h

This would make them appear kind of supporting unwind, even though they really don't, wouldn't it?

>> +	unwind_init();
>
>Stupid q. but what happens when we get a crash before unwind_init? 
>Is the failure benign?

You'll get old fashioned stack traces, which I consider benign.

>> +#ifdef MODULE_UNWIND_INFO
>> +#include <asm/unwind.h>
>> +#endif
>
>It should be possible to include this without the ifdef, no?

Only if all arch-s get an asm/unwind.h, which I consider ill (see above).

>> +#ifdef MODULE_UNWIND_INFO
>> +	unwind_remove_table(mod->unwind_info, 0);
>> +#endif
>
>Might be better to stub it in the include

It is stubbed, but as above - the include isn't always there.

>> +static const struct {
>> +	unsigned offs:BITS_PER_LONG / 2;
>> +	unsigned width:BITS_PER_LONG / 2;
>> +} reg_info[] = {
>> +	UNW_REGISTER_INFO
>> +};
>> +
>> +#undef PTREGS_INFO
>> +#undef EXTRA_INFO
>
>Where are they actually used?  I can't find UNW_REGISTER_INFO 
>in the patch.

These are defined per architecture.

>In general it looks a bit overcomplicated. Can you just
>use the values directly in the unwinder code?

Which values? The offsets into pt_regs are clearly architecture specific, so I don't think it'd be nice to put them
into generic code.

>> +#ifndef REG_INVALID
>
>Who would set it?

Again, an architecture if the default definition isn't sufficient.

>> +#define DW_CFA_nop                          0x00
>
>I guess it would be useful to have them in some include.
>Maybe linux/dwarf2.h ?

Do you think they might be re-used by anyone else? I generally prefer keeping stuff used only in a single place out of
sight for anyone else.

>In general please replace all uintN_t with uN 

Why that? What are these types for then? After all, they're standard mandated, and one more of my preferences is to use
standard types where-ever possible.

>> +
>> +static struct unwind_table *
>> +find_table(unsigned long pc)
>
>Should be on one line. More further down.

Make the code uglier in my opinion, especially when the parameter declarations are quite long.

>> +				atomic_inc(&table->users);
>> +				break;
>> +			}
>> +		atomic_dec(&lookups);
>> +	} while (atomic_read(&removals) != old_removals);
>
>This looks like a seq lock? Use the real thing? 

The code here should get away without taking *any* locks, otherwise you may end up not seeing any backtrace at all when
the system dies.

>> +	table = kmalloc(sizeof(*table), GFP_USER);
>
>GFP_KERNEL.

Not sure about the significance - I took this from respective ia64 code.

>> +	if (table) {
>> +		while (atomic_read(&table->users) || atomic_read(&lookups))
>> +			msleep(1);
>
>Can't this livelock? 
>
>I suspect it isn't needed anyways because module unload uses stop_machine()
>already and that should be enough to stop the lockups which don't block.

That is what I wasn't sure of - if these functions are indeed meant to be called only from the module loader (which I
think they are), then table_lock isn't needed (serialized by module_mutex).

>> +#ifdef UNW_FP
>
>This should be CONFIG_FRAME_POINTER

No - there are arch-s (ia64, while clearly not going to be getting here, immediately comes to mind) where you cannot
define what register the frame pointer is in. I rather think x86 is special in that you actually can.

> +		unsigned long top, bottom;
> +#endif
> +
> +		drop_table(table);
> +#ifdef UNW_FP
> +		top = STACK_TOP(frame->task);
> +		bottom = STACK_BOTTOM(frame->task);
> +# if FRAME_RETADDR_OFFSET < 0

Nasty ifdefs. Can you perhaps isolate that < 0 case in a separate function. Also
when does it happen anyways? A little bit cleanup here would be good.

>> +EXPORT_SYMBOL_GPL(unwind_init_frame_info);
>
>I would actually use EXPORT_SYMBOL().  Would be unfair to not give an unwinder
>to any modules.

Fine with me - I just followed other people's demands (on other occasions) to only use GPL exports for new symbols.

>>  config UNWIND_INFO
>>  	bool "Compile the kernel with frame unwind information"
>> -	depends on !IA64
>> +	depends on !IA64 && !PARISC
>
>Why PARISC?

Because it, like ia64, has its own unwinding logic.

Jan
