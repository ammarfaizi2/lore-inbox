Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131222AbRAMS0V>; Sat, 13 Jan 2001 13:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRAMS0D>; Sat, 13 Jan 2001 13:26:03 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131222AbRAMSZp>;
	Sat, 13 Jan 2001 13:25:45 -0500
Date: Sat, 13 Jan 2001 15:09:40 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Christian Zander <phoenix@minion.de>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: <7650.979387596@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0101131413190.21182-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Keith Owens wrote:

> BTW, modutils cannot automatically fill in upward references when a
> module is loaded.  A reference is a use count, an automatic reference
> would be an automatic use count with no way of removing it.  Code that
> calls upwards to a symbol must perform an overt action to get the
> reference and cope with the case when the symbol is not there.  Think
> of it as a probe, "do I have facility XXX yet?".  It is up to the
> caller to probe as often as required.  Hot plugging for symbols, wheee!

We don't need to overdesign it. get_module_symbol() basically provided
this for us. The only thing really wrong with it was the lack of use
count handling, which I fixed a while ago.

Lack of runtime typechecking isn't a showstopper. Otherwise we'd have
thrown out GCC by now and rewritten the kernel in Modula-3.

That leaves the IA64 problem.

> Fixing this would mean tweaking get_module_symbol() on IA64 to
> recognise that the symbol is a function, build a function descriptor on
> the fly and return the address of the descriptor.  But the information
> about the types of symbols is not available in the kernel nor in
> modules after they are loaded, get_module_symbol() cannot differentiate
> between functions and anything else.  There is also the small matter of
> grubbing around in the arch dependent bit of struct modules to find the
> global pointer for the target function, more complexity.

This is already handled by modutils, presumably. How? By 'grubbing arouund
in the arch dependent bit of struct modules'? There's already a handful of
gp handling surrounded by #ifdef __alpha__ in module.c which doesn't seem
too unreasonable.

The caller knows what it's expecting to find. How about separate
get_module_function() and get_module_data() routines? Which are identical
on most architectures, but on (Alpha and?) IA64 could be defined to return
an appropriate structure.

> get_module_symbol() was usually used with a cast from unsigned long to
> some type that was defined in the calling .c file.  That made the
> caller code responsible for using the correct declaration.  It is
> better to define interfaces as shared data in a shared header.  Not
> perfect, but better.

We could quite happily define the function type in a shared header file,
and coding the original function and the subsequent cast from
get_module_symbol() using that definition.

Conversely, nothing stops you from using only local definitions for
the inter_module_xxx objects, rather than a single shared definition.

Nothing's changed. You just changed the users to use shared definitions
while you converted them to inter_module_xxx. But there's no fundamental
difference in the interface used, in this respect.

> With inter_module_xxx you have no type checking on the registered data.
> But you do not have to use EXPORT_SYMBOL_NOVERS on the shared symbols
> which means that any other users of the symbols will still get type
> checking.  Again, not perfect, but better.

Slightly. But for the cases where inter_module_xxx or get_module_symbol
are used,

	A. AFAIK there are no such 'direct' users who get the
		benefit of the runtime typechecking.

	B. The authors are already having to pay attention to any
		changes in the type of the exported data, rather than
		just pretending that they're writing Java code and
		expecting the runtime system to wipe the dribble
		from their chins.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
