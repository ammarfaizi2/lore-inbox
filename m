Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSGCH3U>; Wed, 3 Jul 2002 03:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSGCH3T>; Wed, 3 Jul 2002 03:29:19 -0400
Received: from h-64-105-34-244.SNVACAID.covad.net ([64.105.34.244]:30172 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316961AbSGCH3P>; Wed, 3 Jul 2002 03:29:15 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 3 Jul 2002 00:31:35 -0700
Message-Id: <200207030731.AAA03720@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: Rusty's module talk at the Kernel Summit
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jul 2002 15:01:53 +1000, Keith Owens <kaos@ocs.com.au> wrote:
>On Mon, 1 Jul 2002  9:12:56 -0700, 
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>
>>	As an extereme illustration, imagine a module with 4095 bytes
>>of non-init data and 2 bytes of init data.  With the .init section loaded,
>>the module will occupy two pages.  Freeing the .init section will free
>>an entire page, making 4096 bytes available to the system, even though
>>only two bytes were in the .init section.

>Agreed, so let's look at some real figures.  The tar ball below contains

>  A patch against kernel 2.5.24 to use init sections for module code
>  and data.

>  A patch against modutils 2.4.16 to disable error checks.  We are not
>  loading the modules, just getting data about their size.

>  A Perl script to read the output from the patched insmod and work out
>  what would be saved by discarding init sections.

>  Two reports from running the script against 2.5.24 with everything
>  that will build as a module.  One report is from discarding both code
>  and data.init, the other report is discarding just data.init.


	Cool.  Out of curiosity, is there some reason you need a
patched version of modutils for extracting this information, rather
than reading the output of "objdump --section-headers"?


[...]
>The total saving over all 2.5.24 modules is 4% of the total module
>sizes, rounded to page boundaries.

      As individual space optimizations go, 4% is respectable,
especially for something that has no cost, helps detect bugs and
simplifies the kernel.  It is hard to think of many potential
other space improvements that would as effective, especially as
function of implementation effort.  In comparison, my vmlinux is
5% init sections.  So, if init sections are worth it for the
core kernel, they should be worth it for modules.

>Most of that saving comes from a few modules.

	This makes me wonder if __init procedures are not being
aggressively identified.  I wonder if people would use __init a little
more if they knew they would get the benefit of it in the module case.
Perhaps someday someone will write a tool to identify procedures that
are only called from init sections.


>There is a lot of arch dependent work required to adjust the in-module
>tables to correctly record which code has been discarded.  If the
>tables are not adjusted then we run the risk of applying unwind or
>exception recovery to the wrong areas.

>I don't see that the complexity required to adjust the arch dependent
>tables is worth the small saving.

	I don't follow you.  Right now, I don't think one would have
to write any new kernel code to load init sections and the non-init
sections as two separate kernel modules, but perhaps I'm probably
missing something.

[..]

>>       It would also be possible to achieve space savings for modules
>>with non-init text+data+bss sizes smaller than a page by allocating
>>their space with kmalloc(...,__GFP_HIGHMEM) instead of vmalloc.

>That requires kfree() but kfree does not unmap the area.  Any buggy
>code that accesses the module after rmmod (which is the main problem
>with module unload) will not be detected.  vfree unmaps the entire
>module on removal.  An oops to detect buggy code is better that a
>silent data corruption.

	I do not believe that there is any guarantee that a subsequent
vmalloc() will not remap the same virtual addresses, and I do not believe
that there is any guarantee that a kfree'd area will remain mapped.  So,
in both cases, there are no guarantees.

	Kernel modules have been a way of life for me for years, and I
don't think I've ever caught a kernel bug by the mechanism that you
describe.  However, I see no harm in having a debugging option that
always vmalloc'ed kernel modules.  This faciilty could be entirely
configuarable from user level by having insmod allocate a module of
*exactly* one page for modules that were less than a page (since you
would only want to kmalloc modules that were *less* than one page).


>>       Here is what I have in mind.  I believe that removal of .init
>>sections could be implemented entirely in user land (aside from
>>removing the include/inux/init.h code that disables init sections for
>>modules).  Insmod would allocate two kernel modules, one for the init
>>sections and the other for the regular sections.  Insmod would resolve
>>references between the two sections.  The temporary module for the
>>init sections would be loaded first, with no initialization routine.
>>The module with the real data would be loaded second, and would run
>>the initialization routine (even if the initialization routine were in
>>the temporary init module).  When the initialization routine
>>completed, regardless of sucess or failure, the temporary init module
>>would be unloaded.

>I looked at that several years ago and discarded the idea.  There may
>be references from the init code/data to the main code/data. Those
>references cannot be resolved until the second module has known
>addresses, which requires insmod to keep track of two modules at once
>before either can be loaded.

	I do not understand how this is problem.  As far as I know,
there is nothing preventing one from doing two create_module calls
followed by two init_module calls, so there should be no problem
allocating the kernel modules.  The init module would be loaded first,
and would not run any initiailzation routine.  So, both modules would
be in kernel memory before any code was run.

>It also requires insmod to split the tables that refer to the init
>code.  For example, insmod would have to separate __ex_table and
>.modinfo data according to which sub-module each entry referred to.

	As I understand it, __ex_table is just for copy_{to,from}_uesr,
which would almost never be done from init sections, so it can go
in the non-init section.  The core kernel already deals with the same
issue.

	The .modinfo section is not something that would be loaded
into kernel memory.  The MODLE_PARM entries may refer to locations
in either kernel module, but I don't see how that is a problem.


>All things considered, loading as two modules is too much modutils work
>and maintenance for too little gain.

	Obviously it's not for me to tell you to write software for
me.  I just hope you'll accept a good patch if someone develops one.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

