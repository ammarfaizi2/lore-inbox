Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWDNVTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWDNVTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWDNVTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:19:12 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:1708 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965168AbWDNVTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:19:11 -0400
Subject: [PATCH 00/05] robust per_cpu allocation for modules
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux390@de.ibm.com, lethal@linux-sh.org,
       davem@davemloft.net, chris@zankel.net
Content-Type: text/plain
Date: Fri, 14 Apr 2006 17:18:55 -0400
Message-Id: <1145049535.1336.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current method of allocating space for per_cpu variables in modules
is not robust and consumes quite a bit of space.

per_cpu variables:

The per_cpu variables are declared by code that needs to have variables
spaced out by cache lines on SMP machines, such that, writing to any of
these variables on one CPU wont be in danger of writing into a cache
line of a global variable shared by other CPUs.  If this were to happen,
the performance would go down by having the CPUs unnecessarily needing
to update cache lines across CPUs for even read only global variables.

To solve this, a developer needs only to declare a per_cpu variable
using the DECLARE_PER_CPU(type, var) macro.  This would then place the
variable into the .data.percpu section.  On boot up, an area is
allocated by the size of this section + PERCPU_ENOUGH_ROOM (mentioned
later) times NR_CPUS.  Then the .data.percpu section is copied into this
area once for NR_CPUS.  The .data.percpu section is later discarded (the
variables now exist in the allocated area).

The __per_cpu_offset[] array holds the difference between
the .data.percpu section and the location where the data is actually
stored. __per_cpu_offset[0] holds the difference for the variables
assigned to cpu 0, __per_cpu_offset[1] holds the difference for the
variables to cpu 1, and so on.

To access a per_cpu variable, the per_cpu(var, cpu) macro is used.  This
macro returns the address of the variable (still pointing to the
discarded .data.percpu section) plus the __per_cpu_offset[cpu]. So the
result is the location to the actual variable for the specified CPU
located in the allocated area.

Modules:

Since there is no way to know from per_cpu if the variable was part of a
module, or part of the kernel, the variables for the module need to be
located in the same allocated area as the per_cpu variables created in
the kernel.

Why is that?

The per_cpu variables are used in the kernel basically like normal
variables.  For example:

with:
  DEFINE_PER_CPU(int, myint);

we can do the following:
  per_cpu(myint, cpu) = 4;
  int i = per_cpu(myint, cpu);
  int *i = &per_cpu(myint, cpu);

Not to mention that we can export these variables as well so that a
module can be using a per_cpu variable from the kernel, or even declared
in another module and exported (the net code does this).

Now remember, the variables are still located in the discarded sections,
but their content is in allocated space offset per cpu.  We have a
single array storing these offsets (__per_cpu_offset).  So this makes it
very difficult to define special DEFINE/DECLARE_PER_CPU macros and use
the CONFIG_MODULE to play magic in figuring things out.  Mainly because
we have one per_cpu macro that can be used in a module referencing
per_cpu variables declared in the kernel, declared in the given module,
or even declared in another module.

PERCPU_ENOUGH_ROOM:

When you configure an SMP kernel with loadable modules, the kernel needs
to take an aggressive stance and preallocate enough room to hold the
per_cpu variables in all the modules that could be loaded.  To make
matters worst, this space is allocated per cpu!  So if you have a 64
processor machine with loadable modules, you are allocating extra space
for each of the 64 CPUs even if you never load a module that has a
per_cpu variable in it!

Currently PERCPU_ENOUGH_ROOM is defined as 32768 (32K).  On my 2x intel
SMP machine, with my normal configuration, using 2.6.17-rc1, the size
of .data.percpu is 17892 (17K).  So the extra space for the modules is
32768 - 17892 = 14876 (14K).  Now this is needed for every CPU so I am
actually using 
14876 * 2 = 29752 (or 29K).

Now looking at the modules that I have loaded, none of them had
a .data.percpu section defined, so that 29K was a complete waste!


So the current solution has two flaws:
1. not robust. If we someday add more modules that together take up
   more than 14K, we need to manually update the PERCPU_ENOUGH_ROOM.
2. waste of memory.  We have 14K of memory wasted per CPU. Remember
   a 64 processor machine would be wasting 896K of memory!


A solution:

I spent some time trying to come up with a solution to all this.
Something that wouldn't be too intrusive to the way things already work.
I received nice input from Andi Kleen and Thomas Gleixner.  I first
tried to use the __builtin_choose_expr and __builtin_types_compatible_p
to determine if a variable is from the kernel or modules at compile
time. But unfortunately, I've been told that makes things too complex,
but even worst it had "show stopping" flaws.

Ideally this could be resolved at link time of the module, but that too
would require looking into the relocation tables which are different for
every architecture.  This would be too intrusive, and prone to bugs.

So I went for a much simpler solution.  This solution is not optimal in
saving space, but it does much better than what is currently
implemented, and is still easy to understand and manage, which alone may
outweigh an optimal space solution.

First off, if CONFIG_SMP or CONFIG_MODULES is not set, the solution is
the same as it currently is.  So my solution only affects the kernel if
both CONFIG_SMP and CONFIG_MODULES are set (this is the same
configuration that wastes the memory in the current implementation).

I created a new section called, .data.percpu_offset.  This section will
hold a pointer for every variable that is declared as per_cpu with
DEFINE_PER_CPU.  Although this wastes space too, the amount of space
needed for my setup (the same configuration that wastes 14K per cpu) is
4368 (4K).  Since this section is not copied for every CPU, this saves
us 10K for the first cpu (14 - 4) and 14K for every CPU after that! So
this saves on my setup 24K. (Note: I noticed that I used the default
NR_CPUS which is 8, so this really saved me 108K).

The data in .data.percpu_offset holds is referenced by the per_cpu
variable name which points to the __per_cpu_offset array.  For modules,
it will point to the per_cpu_offset array of the module.

Example:

 DEFINE_PER_CPU(int, myint);

 would now create a variable called per_cpu_offset__myint in
the .data.percpu_offset section.  This variable will point to the (if
defined in the kernel) __per_cpu_offset[] array.  If this was a module
variable, it would point to the module per_cpu_offset[] array which is
created when the modules is loaded.

So now I get rid of the PERCPU_ENOUGH_ROOM constant and some of the
complexity in kernel/module.c that shares code with the kernel, and each
module has it's own allocation of per_cpu data. And this means the
per_cpu data is more robust (can handle future changes in the modules)
and saves up space.


Draw backs:

The one draw back I have on this, is because the DECLARE_PER_CPU macro
declares two variables now, you can't declare a "static DEFINE_PER_CPU".
So instead I created a DEFINE_STATIC_PER_CPU macro to handle this case.

The following patch set is against 2.6.17-rc1, but this patch set is
currently only for i386.  I have a x86_64 that I can work on to port,
but I will need the help of others to port to some other archs, mostly
the other 64 bit archs.  I tried to CC the maintainers of the other
archs (those listed in the vmlinux.lds, include/asm-<arch>/percpu.h
files and the MAINTAINER file).

I'm not going to spam the CC list (nor Andrew) with the rest of the
patches (only 5).  Please see LKML for the rest.

-- Steve

