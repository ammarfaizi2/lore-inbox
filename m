Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWDPNkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWDPNkl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 09:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWDPNkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 09:40:41 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:15522 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750747AbWDPNkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 09:40:40 -0400
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>, Martin Mares <mj@atrey.karlin.mff.cuni.cz>,
       bjornw@axis.com, schwidefsky@de.ibm.com, benedict.gaster@superh.com,
       lethal@linux-sh.org, Chris Zankel <chris@zankel.net>,
       Marc Gauthier <marc@tensilica.com>, Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, davem@davemloft.net, rusty@rustcorp.com.au
In-Reply-To: <17473.60411.690686.714791@cargo.ozlabs.ibm.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <4440855A.7040203@yahoo.com.au>
	 <Pine.LNX.4.58.0604151609340.11302@gandalf.stny.rr.com>
	 <4441B02D.4000405@yahoo.com.au>
	 <Pine.LNX.4.58.0604152323560.16853@gandalf.stny.rr.com>
	 <17473.60411.690686.714791@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sun, 16 Apr 2006 09:40:04 -0400
Message-Id: <1145194804.27407.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-16 at 17:02 +1000, Paul Mackerras wrote:
> Steven Rostedt writes:
> 
> > So now I'm asking for advice on some ideas that can be a work around to
> > keep the robustness and speed.
> 
> Ideally, what I'd like to do on powerpc is to dedicate one register to
> storing a per-cpu base address or offset, and be able to resolve the
> offset at link time, so that per-cpu variable accesses just become a
> register + offset memory access.  (For modules, "link time" would be
> module load time.)

That was my original goal too, but the per_cpu and modules has problems
to solve this.

> 
> We *might* be able to use some of the infrastructure that was put into
> gcc and binutils to support TLS (thread local storage) to achieve
> this.  (See http://people.redhat.com/drepper/tls.pdf for some of the
> details of that.)

Thanks for the pointer I'll give it a read (but on Monday).

> 
> Also, I've added Rusty Russell to the cc list, since he designed the
> per-cpu variable stuff in the first place, and would be able to
> explain the trade-offs that led to the PERCPU_ENOUGH_ROOM thing.  (I
> think you're discovering them as you go, though. :)

Thanks for adding Rusty, I thought I did, but looking back to my
original posts, I must have missed him.

Since Rusty's on the list now, here's the issues I have already found
that caused the use of PERCPU_ENOUGH_ROOM.  I'll try to explain them the
best I can such that others also understand the issues at hand, and
Rusty can jump in and tell us where I missed.

I've explained some of this in my first email, but I'll repeat it again
here. I'll first explain things how they are done generic and then what
I understand the x86_64 does (I believe ppc is similar).

The per_cpu variables are defined with the macro 
    DEFINE_PER_CPU(type, var)

This macro just places the variable into the section .data.percpu and
prepends the prefix "per_cpu__" to the variable.

To use this variable in another .c file the declaration is used by the
macro
    DECLARE_PER_CPU(type, var)

This macro is simply the extern declaration of the variable with the
prefix added.

If this variable is to be used outside the kernel, or in the case it was
declared in a module and needs to be used in other modules, it is
exported with the macro
   EXPORT_PER_CPU_SYMBOL(var)  or EXPORT_PER_CPU_SYMBOL_GPL(var)

This macro is the same as their EXPORT_SYMBOL equivalents except that it
adds the per_cpu__ prefix.


>From the above, it can be seen that on boot up the per_cpu variables are
really just allocate once in their own section .data.percpu.  So the
kernel now figures out the size of this section cache aligns it and then
allocates (ALIGN(size,SMP_CACHE_BYTES) * NR_CPUS).

It then copies the contents of the .data.percpu section into this newly
allocated area NR_CPUS times.  The offset for each allocation is stored
in the __per_cpu_offset[] array.  This offset is the difference from the
start of each allocated per_cpu area to the start of the .data.percpu
section.

Now that the section has been copied for every CPU into it's own area,
the original .data.percpu section can be discarded and freed for use
elsewhere.


To access the per_cpu variables the macro per_cpu(var, cpu) is used.
This macro is where the magic happens.  The macro adds the prefix
"per_cpu__" to the var and then takes its address and adds the offset of
__per_cpu_offset[cpu] to it to resolve the actual location that the
variable is at.

This macro is also done such that it can be used as a normal variable.
For example:

   DEFINE_PER_CPU(int, myint);

   int t = per_cpu(myint, cpu);
   per_cpu(myint, cpu) = t;
   int *y = &per_cpu(myint, cpu);

And it handles arrays as well.

   DEFINE_PER_CPU(int, myintarr[10]);

   per_cpu(myintarray[3], cpu) = 2;

and so on.

This is all fine until we add loadable module support that also uses
their own per_cpu variables, and it makes it even worst that the modules
too can export these variables to be used in other modules.

To handle this, Rusty added a reserved area in the per_cpu allocation of
PERCPU_ENOUGH_ROOM.  This size is meant to hold both the kernel per_cpu
variables as well as the module ones.  So if CONFIG_MODULES is defined
and PERCPU_ENOUGH_ROOM is greater than the size of the .data.percpu
section, then the PERCPU_ENOUGH_ROOM is used in the allocation of the
per_cpu area. The allocation size is PERCPU_ENOUGH_ROOM * NR_CPUS, and
the offsets of each cpu area is separated by PERCPU_ENOUGH_ROOM bytes.

When a module is loaded, a slightly complex algorithm is used to find
and keep track of what reserved area is available, and which is not.

When a module is using per_cpu data, it finds memory in this reserve and
then its .data.percpu section is copied into this reserve NR_CPUS times
(this isn't quite accurate, since the macro for_each_possible_cpu is
used here).

The reason that this is done, is that the per_cpu macro cant know
whether or not the per_cpu variable was declared in a kernel or in a
module.  So the __pre_cpu_offset[] array offset can't be used if the
module allocation is in its own separate area. Remember that this offset
array stores the difference from where the variable originally was and
where it is now for each cpu.

You might think you could just allocate the space for this in a module
since we have control of the linker to place the section anywhere we
want, and then play with the difference such that the __per_cpu_offset
would find the new location, but this can only work for cpu[0].
Remember that this offset array is spaced by the size of .data.percpu,
so how can you guarantee to allocate the space for CPU 1 for a module
that would then be offset to the location by __per_cpu_offse[1]?  So the
module solution cant be solved this way.


My solution, was to change this by creating a new section
called .data.percpu_offset.  This section would hold a pointer to the
__per_cpu_offset (for kernel or module) for every per_cpu variable
defined.  This is done by making DEFINE_PER_CPU(var,cpu) not only define
the pre_cpu__##var but also a per_cpu_offset__##var.  This way the
per_cpu macro can use the name to find the area that the variable
resides.  And so modules can now allocate their own space.



Now a quick description of what x86_64 does.  Instead of allocating one
big chunk for the per_cpu area that contains the variables for all the
CPUs, it allocates one chunk per cpu in the cpu node area.  So that the
memory for a per_cpu of a given CPU is in an area that can be quickly
received by that CPU nicely in a NUMA fashion.  This is because instead
of using the __pre_cpu_offset array, it uses a PDA descriptor that is
used to store data for each CPU.


Now my solution is still in its infancy, and can still be optimized.
Ideally, we want this to be as fast as the current solution, or at least
not any noticeable difference.  my current solution doesn't do this, but
before we strike it down, is there ways to change that and make it do
so.

The added space in the .data.percpu_offset is much smaller then the
extra space in PERCPU_ENOUGH_ROOM, so if I need to duplicate
the .data.percpu_offset, then we still save space and keep it robust
where we wont need to ever worry about adjusting PERCPU_ENOUGH_ROOM.

But then again, if I where to duplicate this section, then I would have
the same problem finding this section as I do with finding the
per_cpu__##var! :(

I'll think more about this, but maybe someone else has some crazy ideas
that can find a solution to this that is both fast and robust.

Some ideas come in looking at gcc builtin macros and linker magic. One
thing we can tell is the address of these variables, and maybe that can
be used in the per_cpu macro to determine where to find the variables.

Some people may think I'm stubborn in wanting to fix this, but I still
think that, although it's fast, the current solution is somewhat a hack.
And I still believe we can clean it up without hurting performance.

Thanks for the time in reading all of this.

-- Steve

