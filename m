Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135452AbRAMBMG>; Fri, 12 Jan 2001 20:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135712AbRAMBL5>; Fri, 12 Jan 2001 20:11:57 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:6150 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S135452AbRAMBLj>;
	Fri, 12 Jan 2001 20:11:39 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Christian Zander <phoenix@minion.de>
cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Fri, 12 Jan 2001 20:11:30 BST."
             <20010112201130.A710@chronos> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Jan 2001 12:11:31 +1100
Message-ID: <3654.979348291@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001 20:11:30 +0100, 
Christian Zander <phoenix@minion.de> wrote:
>Saying that I should have made use of this mechanism for the specific
>code in the Nvidia driver that we are talking about clearly shows that
>you didn't look at it. The module used get_module_symbol to search its
>own symbol table for parameters that may have been passed to it at load
>time.

My apologies.  I read the patch, not the full source code and the patch
does not have enough programming context to show that the driver is
only searching its own symbol space.  In my own defense, the references
to spinlock_t unload_lock and MOD_CAN_QUERY(mp) in the patch are highly
misleading, those statements only make sense when you are looking at a
symbol table for another module.  When searching your own symbol table
the current module must be live with a non-zero use count, not being
unloaded and it can always be queried.

>Contrary to what you're saying, the patch does not just inline the old
>get_module_symbol algorithm nor does it access any of module.c's internal
>data.

unload_lock and MOD_CAN_QUERY were copied verbatim from the old
get_module_symbol, even though they are completely unnecessary.  That
looks like inlining the old algorithm to me.

struct module_symbol, mp->nsyms and mp->syms are module.c internal
data.  If it is ever necessary to change those structures, nothing
outside module.c, the 32/64 handlers for module system calls and
modutils should be affected.  Now if I change module_symbol, other bits
of the kernel will unexpectedly break, this is not good.

>> Whoever coded that patch should be taken out and shot, hung, drawn and
>> quartered then forced to write COBOL for the rest of their natural
>> life.
>
>Excellent comment - it is just as appropriate as it is helpful.

Over emphasis for humorous effect.  Must remember to add smiley.


What this patch and David Woodhouse's comments show is that I need to
look at a generic and safe mechanism for kernel/module symbol lookup.
The existing static mechanism works for fixed symbol names but does not
work for symbol names that are generated at run time nor for symbols
that may or may not be present.

get_module_symbol() "worked" but was horribly unsafe.  It broke with
module versions, it did zero type checking which left the code open to
version skew and it assumed that all addresses are equivalent to an
unsigned long.

That last point is especially important for IA64 where function
pointers do not reference the function directly, instead they point to
a function descriptor with two fields, one of which is the function
address.  Casting the unsigned long address of a function into a
function pointer fails miserably on IA64, and gcc does not even give
any warnings.  foo = (int (*)(int))get_module_symbol(NULL, "funcname")
is architecture dependent.

Using EXPORT_SYMBOL_NOVERS() to "fix" the modversions problem for
get_module_symbol() removes all inter module checks on the relevant
symbols.  Not just for the caller of get_module_symbol for all modules
that access those symbols.  This leaves too much code open to version
skew and is not acceptable.

inter_module_xxx is modversions safe.  It still does no type checking
because it uses void * for the data structure, but the exporter and
user have to declare their common data area which reduces the chance of
version skew.  I am still not happy about this possibility of skew but
anything is better than no checks at all.  Passing a data structure
which contains real declarations for function pointers instead of
assuming you can cast a number to a function pointer makes
inter_module_xxx architecture independent.


I will look at a general kernel and module symbol lookup routine that
does the job properly.  The hard part is making sure that the provider
and consumer have exactly the same types for a symbol.  Both
get_module_symbol and inter_module_xxx completely bypass the
modversions checks and are wide open to undetectable version skew,
although inter_module_xxx is a little bit safer.  Any replacement for
these functions must be able to do type checking at run time, which
probably means it is 2.5 code.  And yes, David, it should be able to
handle static data.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
