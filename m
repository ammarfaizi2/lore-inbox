Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSGCMZU>; Wed, 3 Jul 2002 08:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSGCMZT>; Wed, 3 Jul 2002 08:25:19 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33811 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316953AbSGCMZQ>;
	Wed, 3 Jul 2002 08:25:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-reply-to: Your message of "Wed, 03 Jul 2002 00:31:35 MST."
             <200207030731.AAA03720@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jul 2002 22:27:33 +1000
Message-ID: <5813.1025699253@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002 00:31:35 -0700, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>On Wed, 03 Jul 2002 15:01:53 +1000, Keith Owens <kaos@ocs.com.au> wrote:
>>Agreed, so let's look at some real figures.  The tar ball below contains
>
>>  A patch against kernel 2.5.24 to use init sections for module code
>>  and data.
>
>>  A patch against modutils 2.4.16 to disable error checks.  We are not
>>  loading the modules, just getting data about their size.
>
>>  A Perl script to read the output from the patched insmod and work out
>>  what would be saved by discarding init sections.
>
>>  Two reports from running the script against 2.5.24 with everything
>>  that will build as a module.  One report is from discarding both code
>>  and data.init, the other report is discarding just data.init.
>
>	Cool.  Out of curiosity, is there some reason you need a
>patched version of modutils for extracting this information, rather
>than reading the output of "objdump --section-headers"?

It was easier and more accurate to patch insmod to ignore errors than
to replicate all of insmod's processing in another program.  Especially
when insmod adds data to the module as it is loaded, that data does not
appear in objdump -h.

>>The total saving over all 2.5.24 modules is 4% of the total module
>>sizes, rounded to page boundaries.
>
>      As individual space optimizations go, 4% is respectable,
>especially for something that has no cost

It is not at no cost.  Getting 4% requires arch dependent code to
handle all the tables that are affected by partial text removal.  I can
get 2% for nothing by discarding data.init.  Discarding text.init is a
lot harder.

>>I don't see that the complexity required to adjust the arch dependent
>>tables is worth the small saving.
>
>	I don't follow you.  Right now, I don't think one would have
>to write any new kernel code to load init sections and the non-init
>sections as two separate kernel modules, but perhaps I'm probably
>missing something.

The problem is the partial removal of code when there are tables that
point to _all_ the code.  Partial code removal requires a lot of work
to adjust every table that refers to code and correct them.  To make it
worse, the tables are arch specific.  Most architectures have
__ex_table, with different formats for each arch.  Some have unwind
data, always arch dependent format.  MIPS has dbe.

Data is not referenced by any of these tables so a partial discard of
data is easy, no side effects to worry about.

BTW, this problem exists for removal of __init code from the kernel as
well.  The only reason it does not bite us for kernel __init is that
the freed area is not reused for executable code, it is used for
kmalloc so there is no ambiguity caused by the dangling table data.
With modules there is a distinct risk that the freed code area would be
reused for another module.

>>I looked at that several years ago and discarded the idea.  There may
>>be references from the init code/data to the main code/data. Those
>>references cannot be resolved until the second module has known
>>addresses, which requires insmod to keep track of two modules at once
>>before either can be loaded.
>
>	I do not understand how this is problem.  As far as I know,
>there is nothing preventing one from doing two create_module calls
>followed by two init_module calls, so there should be no problem
>allocating the kernel modules.  The init module would be loaded first,
>and would not run any initiailzation routine.  So, both modules would
>be in kernel memory before any code was run.

It makes insmod much more complicated, it has to load two modules in
parallel with unresolved references in both directions.  I have seen
modules with init code that refers to data and rodata (init -> main)
and modules with references from rodata to init (main -> init).

>	As I understand it, __ex_table is just for copy_{to,from}_uesr,
>which would almost never be done from init sections

__ex_table is used for any code that requires recovery.  Mainly
copy..user but not exclusively.

>The core kernel already deals with the same issue.

It does not.  There is no code to adjust any tables after discarding
kernel __init sections.  We rely on the fact that the discarded kernel
area is not reused for executable text.

