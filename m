Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSKVSDz>; Fri, 22 Nov 2002 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSKVSDz>; Fri, 22 Nov 2002 13:03:55 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:36012 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265135AbSKVSDw>; Fri, 22 Nov 2002 13:03:52 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 22 Nov 2002 10:10:49 -0800
Message-Id: <200211221810.KAA17210@adam.yggdrasil.com>
To: zippel@linux-m68k.org
Subject: Re: [RFC] module fs or how to not break everything at once
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2002, Roman Zippel wrote:
>On Thu, 21 Nov 2002, Adam J. Richter wrote:

>> 	Can you tell me what problem in the existing userland module
>> code (i.e., before 2.5.48) modulefs solves?  Does it actually make
>> the kernel smaller?  Can you give me an example?

>Previous insmod knows too much about kernel internals, it has to fill in 
>kernel structures, which makes changing this structure a real pain. Part 
>of the relocation work can be moved to kbuild, what makes insmod simpler 
>and gives us better control over the module layout.

	I meant "what real advantage does a _filesystem_ interface
give you?"

>See the mini module loader I posted last week.

	Thanks for the pointer.  Looking at your mini-loader, it seems
to me that you could eliminate your modules.lds script if you would
split module-init.c into module-init.c and module-finish.c, which would
simplify the ability to link multiple modules together or have
a module with multiple module_init() functions if we used the
definition of module_init() that is used for kernel objects (more
on this below).

>> 	1. Please take Petr's advice and just make module removal
>> occur when you rmdir the directory.  [...]

>Synchronizing multiple insmod is needed in user space anyway, this doesn't 
>make the kernel side more complex.

	Then a module_init function that may cause another module to
be loaded can deadlock.  I'll have to think about whether that is
a problem.

	I still don't see how having an "almost unloaded" state
visible to user space has any benefit, but I suppose its an irrelevant
question until you show benefits of having a filesystem model.


>> 	2. I would really like insmod to be able to flock modules (or
>> do something similar).  This would increment the reference count on a
>> module until insmod would exit (or would do an execve, I suppose).
>> This would eliminate a race when insmod is loading a module that
>> references symbols in other modules.  I don't think flock is actually
>> propagated down the vfs layer, so perhaps some other primitive could be
>> used.  Perhaps just holding open an open file descriptor on each of
>> the modules in question would be a better interface.

>I don't know what you're trying to do here, but it sounds like you're 
>mixing user space and kernel space problems here.

	If you cannot do complete serialization of rmmod and insmod
because it really does cause a deadlock, then the problem occurs when
a module that insmod depends on gets unloaded after insmod has checked
for the module and read its symbols but before insmod has loaded the
new module.

	If it is OK to serialize all rmmod and insmod calls, then you
already have an implicit method for preventing modules that insmod
depends from being unloaded while insmod is running.

	By the way, if you do serialize all rmmod and insmod calls,
you still have the question of how to convey dependency information to
the kernel if you do not want the loader to know about kernel data
formats like struct module and struct module_ref.  Conceivably you
could represent these dependencies by doing something like "ln
/proc/modfs/libmodule/control /proc/modfs/mymodule/deps/libmodule".
So, it may be possible to have a scheme where you do not need complete
serialization of depmod and insmod, although I don't know if that will
prove to be important.


>> 	3. It's not a modulefs thing, but you might want to consider
>> moving all symbol management to user space [...]

>This is planned, symbols are only needed by kksymoops, otherwise they 
>don't have to be kept in memory all the time.

Great.

>>         4. Regarding what I said about leaving symbol tracking to
>> user space, I'd like to add a note about reliability.  It is not
>> necessary for rmmod to reliably remove symbols from these tables.
>> insmod can check for symbols that map to places that are no longer
>> allocated to modules and remove stale symbols before attempting to
>> load a new module.

>That's a mostly user space problem and I'd rather do this right, why 
>should I keep invalid symbols?

	My point was just about being resiliant against, say, someone
accidentally hitting a control-C or a kill signal during one of these
programs, such as during an aborted shutdown.  However, now that you
mention it, it would be useful for developers to have an rmmod option
to retain symbols for debugging a bad memory reference that happens
after a module has been unloaded.


>>         5. You should not need to do anything special in modfs
>> to support init sections.  That can be done by loading two separate
>> modules and then removing the one corresponding to an init section.

>I doubt that's a good idea, mostly also because of the following point.

	Even if you don't want to support circular dependencies
(loading multiple .o's together) or multiple module_{init,exit}
functions, having insmod load separate modules for the init and
non-init parts will shrink the kernel code.  It would be nice
for insmod to be able to do ELF section manipulations like this
also to implement things like having .exit{,func} sections
that insmod could drop if it were given a flag to load the
module "permanently."


>>         6. For module_init functions, consider taking a pointer to
>> an array of init functions and a count.  That would be compatible
>> with the system for built-in kernel object files, so it would
>> eliminate a difference in linux/include/init.h.  You could also do
>> the same for module_exit functions.  This change would also
>> allow linking .o's together more or less arbitrarily into single
>> modules, which would allow loading of modules that have reference
>> loops among them.

>Reference loops are never a good idea,

	An advantage of allowing circular loops is that everything
would be modularized or nearly modularized with only a few changes.
For example, I want to modularize CONFIG_NET (not just CONFIG_INET).
However, there is a circular reference:

      net/core ---> drivers/net/loopback.c ----> net/ethernet --> net/core

	I might try to remove the net/core --> drivers/net/loopback.c
dependency to break this loop.  However, there may be some positive
trade-offs made in the networking code about being able to asume that
there is always at least one device present and that the first device
on the list is the loopback device, an assumption mentioned in some
code comments.  If I move drivers/net/loopback.c and net/ethernet,
I'll lose cvs tracking, plus I really think they belong where they are
from a software maintenance standpoint.  Probably I will have to make
a special link rule and litter a bunch of Makefiles and .c files with
ifdefs.  In the meantime CONFIG_NET=y seems to work just fine with
this circular dependency, and there is no reason why execution should
fail if you load the same functionality as a module.

>if object files are that closely 
>related, create a single module. Multiple init/exit functions are no good 
>idea either, in which order should they be executed? If it's really one 
>module than also keep it one module.

	Module_init calls can be used to initialize facilities local
to each file, which allows for fewer global symbols and may simplify
inclusion or exclusion of various facilities just by the CONFIG_xxx
options in the Makefile.  Their order of execution would controlled by
the order in which are linked, just like kernel object files.  I
thought I came across a couple of examples of this, mostly where a
/proc interface for functionality was set up in a separate file,
but I no longer remember where.  Perhaps all of those cases have
now been eliminated.

	The circular dependency and multiple module_init are not as
important to me as just being able to defer the decision about what is
a module and what is compiled-in until link time.


>>         7. Instead of module parameters, consider just supporting
>> __setup() declarations used in kernel objects.  [...]

>Kernel parameter unification might actually be one of the few good parts
>from Rusty's loader, but I have to look at, when it's working again.

	Great.


>> but it would also allow binary distributions for a wider
>> variety of uses.

>What does this mean???

	A vendor could build a kernel with "make allmodconfig", and
then a user could run a script to choose which modules should be
included into the kernel for relatively customized purposes.  The
default configuration might be link in binfmt_elf, rd, romfs to boot
an initial ramdisk, but some customers might want decide they want to
boot directly to their IDE or SCSI disk and link in the modules that
they already use.

	Also, perhaps the initial program of mounting a root file
system and exec'ing /sbin/init could be separated out (with some
rearrangement).  So, it might be easier to build, say, a router kernel
with no built-in filesystems, no PCI support, etc. for less
engineering cost.

	I think there are many companies that want to build gadgets
but are more concerned with time to market and perceived engineering
risk than last 25% of memory footprint, and they go with Windows CE or
NT Embedded in part because they do not want to be running a custom
source build.  I think it would simplify Linux usage if one could
decide what modules to link in without needing to recompile sources.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
