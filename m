Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSKVWE5>; Fri, 22 Nov 2002 17:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbSKVWE4>; Fri, 22 Nov 2002 17:04:56 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:1489 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265306AbSKVWEy>; Fri, 22 Nov 2002 17:04:54 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 22 Nov 2002 14:11:47 -0800
Message-Id: <200211222211.OAA17427@adam.yggdrasil.com>
To: zippel@linux-m68k.org
Subject: Re: [RFC] module fs or how to not break everything at once
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2002, Roman Zippel wrote:
>On Fri, 22 Nov 2002, Adam J. Richter wrote:

>> 	I meant "what real advantage does a _filesystem_ interface
>> give you?"

>- more flexibility, you get a lot for free from libfs.c and other parts of 
>the kernel. Check how small the modfs example is, much more isn't needed.
>- no extra syscalls needed, which might have to be emulated by 64bit 
>system. Module objects are normal files, why waste a syscall if you can 
>just write() them to the kernel?

>> 	Thanks for the pointer.  Looking at your mini-loader, it seems
>> to me that you could eliminate your modules.lds script if you would
>> split module-init.c into module-init.c and module-finish.c, which would
>> simplify the ability to link multiple modules together or have
>> a module with multiple module_init() functions if we used the
>> definition of module_init() that is used for kernel objects (more
>> on this below).

>The linker script will not go away, it makes the loader a _lot_ easier and 
>I want to keep it this way. Multiple module_init() calls won't happen, 
>don't even try it.

	How does one script and one .o make the loader "a _lot_ easier"
than with two .o's?

	You cannot determine technical merit ex cathedra.  Obviously
you can do whatever you want with your own tree, but if you can't
convince someone is basically a proponent of moving as much of the
module support into user level as possible (and a moderate proponent
of filesystem interfaces), then how likely do you think it is that you
will convince others?


>> >Synchronizing multiple insmod is needed in user space anyway, this doesn't 
>> >make the kernel side more complex.
>> 
>> 	Then a module_init function that may cause another module to
>> be loaded can deadlock.  I'll have to think about whether that is
>> a problem.

>The user space locking should of course be a bit more intelligent than one 
>big lock.

	You would have provided more details you had thought this
through.  Maybe you never need to do anything from a module_init
function that loads another module, but, if you do, then there may
not be an answer in the form of a user space locking policy, and it
may necessitate moving many elements back into the kernel, such as
this one:

[...]
>The kernel doesn't need the dependency information, they can stay as well 
>in user space. The checks currently done don't have to be done in the 
>kernel.

	That is intriguing, although it depends on whether on that user
space locking scheme working.


>> >That's a mostly user space problem and I'd rather do this right, why 
>> >should I keep invalid symbols?
>> 
>> 	My point was just about being resiliant against, say, someone
>> accidentally hitting a control-C or a kill signal during one of these
>> programs, such as during an aborted shutdown.  However, now that you
>> mention it, it would be useful for developers to have an rmmod option
>> to retain symbols for debugging a bad memory reference that happens
>> after a module has been unloaded.

>I want to keep the kernel implementation simple, this would only bloat it.
>Cleaning up after a signal shouldn't bother the kernel (at least as far 
>as modfs is concerned).

	User level programs cannot catch SIGKILL.  I was not talking about
adding anything to the kernel.


>> 	Even if you don't want to support circular dependencies
>> (loading multiple .o's together) or multiple module_{init,exit}
>> functions, having insmod load separate modules for the init and
>> non-init parts will shrink the kernel code.  It would be nice
>> for insmod to be able to do ELF section manipulations like this
>> also to implement things like having .exit{,func} sections
>> that insmod could drop if it were given a flag to load the
>> module "permanently."

>The point of the linker script is to avoid that the loader has to play 
>around with the sections. If you want to get rid of init data, put it at 
>the end and truncate() it when you're done. This is trivial to do with a 
>module fs.

	If insmod knows what size to truncate the module to, then it
has at least a little code dealing with certain sections.  Theoretically,
it should also determine that the extable contains no pointers into .init
(although in practice I believe that that is always true right now).

	Small modules can potentially be allocated with kmalloc rather
than vmalloc for better memory efficiency and, I believe, so that they
can live in the kernel's 4MB huge page on architectures that support
it, eliminating their TLB utilization.  If you allocate the init and
non-init modules separately, the non-init module will more often be
small enough to be allocated this way (also true of the init module, but
we probably don't care much about that).

	In addition to missing opportunities to use kmalloc,
implementing a truncation to a non-zero size in your modfs requires
additional code, including a vmalloc_shrink (I think Keith Owens
posted one).  I was not aware that you even were going to provide
files for writing the module's contents.  That seems unnecessary.
Even if you don't want a system call interface for copying the
module's contents in, why can't insmod just lseek and write /dev/kmem?

[...]
>> 	An advantage of allowing circular loops is that everything
>> would be modularized or nearly modularized with only a few changes.
>> For example, I want to modularize CONFIG_NET (not just CONFIG_INET).
>> However, there is a circular reference:

>You're trying to move your problems to someone else - very bad idea.
>If you can't get modules references right, you have very likely more 
>problems like module initialization races. Link everything together and 
>make the initialization explicit and don't rely on that the linker/loader 
>gets it magically right.

	First of all, you can have circular references and still have
only one module_init function.  That is in fact that case with the
CONFIG_NET=m example that I described and you deleted from your
response--not very persuasive.

	Secondly, you have not shown that these really are necessarily
always problems with cicular dependencies.  They are, after all, used
in the built-in kernel objects.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
