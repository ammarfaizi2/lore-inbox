Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbTADFzx>; Sat, 4 Jan 2003 00:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbTADFzw>; Sat, 4 Jan 2003 00:55:52 -0500
Received: from dp.samba.org ([66.70.73.150]:49107 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263491AbTADFzv>;
	Sat, 4 Jan 2003 00:55:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] extable cleanup 
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, rth@twiddle.net,
       rmk@arm.linux.org.uk, bjornw@axis.com, davidm@hpl.hp.com,
       geert@linux-m68k.org, ralf@gnu.org, paulus@samba.org, anton@samba.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, gniibe@m17n.org,
       kkojima@rr.iij4u.or.jp, "David S. Miller" <davem@redhat.com>,
       ak@suse.de
In-reply-to: Your message of "Fri, 03 Jan 2003 10:41:41 -0800."
             <Pine.LNX.4.44.0301031036560.2750-100000@home.transmeta.com> 
Date: Sat, 04 Jan 2003 16:33:57 +1100
Message-Id: <20030104060424.6E8CC2C37B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301031036560.2750-100000@home.transmeta.com> you wri
te:
> 
> On Fri, 3 Jan 2003, Rusty Russell wrote:
> >
> > Fairly straightforward consolidation of extable handling.  Sparc64 is
> > trickiest, with its extable range stuff (ideally, the ranges would be
> > in a separate __extable_range section, then the extable walking code
> > could be made common, too).
> > 
> > Only tested on x86: ppc and sparc64 written untested, others broken.
> 
> Did you test on a true i386, which needs exception handling very early on 
> to handle the test for broken WP? In other words, are all the exception 
> table data structures properly initialized?

That's not a problem: the exception table search code looks like:

/* Given an address, look for it in the exception tables. */
const struct exception_table_entry *search_exception_tables(unsigned long addr)
{
	const struct exception_table_entry *e;

	e = search_extable(__start___ex_table, __stop___ex_table-1, addr);
	if (!e)
		e = search_module_extables(addr);
	return e;
}

search_extable is arch specific, and requires no setup on any arch.
The list containing the modules is initialized using the LIST_HEAD, so
is empty, so search_module_extables is a noop.

> And did you check that an oops in the init handling works correctly before
> the kallsyms table has been initialized? That "initcall(symbol_init)"  
> makes me suspect it won't..

Once again, no initialization required.  "symbol_init" initializes the
EXPORT'ed symbol tables for module loading: kallsyms doesn't need
initialization.

> There was a reason why "extable_init()" was in init/main.c, and was done 
> _early_.

Yes, because archs iterated through the extable list to find even core
kernel exception tables.  The patch changes that: the lookup for core
kernel is done first, then the module code looks through a linked
list, meaning you don't need an extable list for !CONFIG_MODULES, etc.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
