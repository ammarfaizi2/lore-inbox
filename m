Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136280AbRAMKr3>; Sat, 13 Jan 2001 05:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136477AbRAMKrT>; Sat, 13 Jan 2001 05:47:19 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:1796 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S136280AbRAMKrH>; Sat, 13 Jan 2001 05:47:07 -0500
Date: Sat, 13 Jan 2001 10:46:44 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Christian Zander <phoenix@minion.de>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: <3654.979348291@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0101131011020.1540-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001, Keith Owens wrote:

> Over emphasis for humorous effect.  Must remember to add smiley.

Heh. But it does deserve to get into the fortune file.

> What this patch and David Woodhouse's comments show is that I need to
> look at a generic and safe mechanism for kernel/module symbol lookup.
> The existing static mechanism works for fixed symbol names but does not
> work for symbol names that are generated at run time nor for symbols
> that may or may not be present.

Actually, my testing showed that modutils was quite OK with symbols which
may or may not be present. But compiling such code into the kernel, at
least on MIPS and m68k, didn't work.

cat >weaktest.c <<EOF
#include <linux/module.h>

extern char *myfun(void) __attribute__((weak));

int init_module(void)
{
	char *txt= "myfun() not present\n";

	if (myfun)
		txt = myfun();

	printk(txt);
	return 0;
}
EOF
cat > myfun.c <<EOF
#include <linux/module.h>

char *myfun(void)
{
return "Hello World\n";
}
EOF

I doubt this would have implemented weak symbols completely, though.
Fixing up the reference in weaktest.o if myfun.o was loaded later, etc.
And we don't really want to 'fix' that either.

So it'd still have needed request_module(); get_module_symbol() if it
found that myfun wasn't present and it needed it. So it might as well have
used get_module_symbol() from the start instead of the weak declaration.

> get_module_symbol() "worked" but was horribly unsafe.  It broke with
> module versions, it did zero type checking which left the code open to
> version skew and it assumed that all addresses are equivalent to an
> unsigned long.
>
> That last point is especially important for IA64 where function
> pointers do not reference the function directly, instead they point to
> a function descriptor with two fields, one of which is the function
> address.  Casting the unsigned long address of a function into a
> function pointer fails miserably on IA64, and gcc does not even give
> any warnings.  foo = (int (*)(int))get_module_symbol(NULL, "funcname")
> is architecture dependent.

But fixable.

> Using EXPORT_SYMBOL_NOVERS() to "fix" the modversions problem for
> get_module_symbol() removes all inter module checks on the relevant
> symbols.  Not just for the caller of get_module_symbol for all modules
> that access those symbols.  This leaves too much code open to version
> skew and is not acceptable.

I'm not sure there's anything which was expected to be obtained by
get_module_symbol() which was also obtained by normal linking. The nature
of these routines is that they're optional. Usually, the routine would be
optional for all callers or it'd be mandatory for all callers. Rarely a
mixture.

But what about keeping a separate table, with PUBLISH_SYMBOL() or
something slightly more sensibly named? That way, get_published_symbol()
can only get at those symbols which were supposed to be listed, and if
someone really wants EXPORT_SYMBOL() and PUBLISH_SYMBOL() they can do
that.

> > inter_module_xxx is modversions safe.  It still does no type checking
> because it uses void * for the data structure, but the exporter and
> user have to declare their common data area which reduces the chance of
> version skew.

I'm not sure I follow. The exporter and the user have to each declare
their common data area, which means they don't have to declare it
identically, and there's just as much chance of version skew as before,
surely? With get_module_symbol both had to declare it, too.

And 'modversions safe' just means that there's no attempt to mangle the
names so it's identical to the EXPORT_SYMBOL_NOVERS case above?

> I am still not happy about this possibility of skew but
> anything is better than no checks at all.  Passing a data structure
> which contains real declarations for function pointers instead of
> assuming you can cast a number to a function pointer makes
> inter_module_xxx architecture independent.

On the other hand, it's also simple enough to define a macro which does
the arch-dependent equivalent of the 'foo=(fnptr_t)get_module_symbol()'
above, isn't it? But I'm not particularly attached to the method. The
static initialisation is what I miss.

> I will look at a general kernel and module symbol lookup routine that
> does the job properly.

Thanks.

> The hard part is making sure that the provider and consumer have
> exactly the same types for a symbol.

That would be useful, but it's not 100% imperative. Runtime type-checking
is a nice sanity check where it's almost free, as it was in the
modversions case, but I don't want to program in Java.

-- 
dwmw2

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
