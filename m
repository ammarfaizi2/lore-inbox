Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbSKWGDT>; Sat, 23 Nov 2002 01:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbSKWGDT>; Sat, 23 Nov 2002 01:03:19 -0500
Received: from h-64-105-34-232.SNVACAID.covad.net ([64.105.34.232]:9856 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266968AbSKWGDQ>; Sat, 23 Nov 2002 01:03:16 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 22 Nov 2002 20:58:29 -0800
Message-Id: <200211230458.UAA17701@adam.yggdrasil.com>
To: zippel@linux-m68k.org
Subject: Re: [RFC] module fs or how to not break everything at once
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002 00:24:18 +0100, Roman Zippel wrote:
>On Fri, 22 Nov 2002, Adam J. Richter wrote:

>> >The linker script will not go away, it makes the loader a _lot_ easier and 
>> >I want to keep it this way. Multiple module_init() calls won't happen, 
>> >don't even try it.
>> 
>> 	How does one script and one .o make the loader "a _lot_ easier"
>> than with two .o's?

>Check the previous discussions about kloader support for other archs, e.g. 
>some have special requirements for section ordering, all this work is 
>already done by the linker, why should I duplicate this in the loader?

	I will try to find that discussion.  In the meantime, I'll just
point out that you can still use the linker with two .o files instead
of one .o and an ld script.  At the very least, it you would be
relying on one less GNUism (linker scripts).

>> >The user space locking should of course be a bit more intelligent than one 
>> >big lock.
>> 
>> 	You would have provided more details you had thought this
>> through.  Maybe you never need to do anything from a module_init
>> function that loads another module, but, if you do, then there may
>> not be an answer in the form of a user space locking policy, and it
>> may necessitate moving many elements back into the kernel,

>I'm planning to do this with a per module locking, for every module in the 
>kernel there is a file with symbol/dependency/... information on which you 
>can easily use flock.

	This is pretty close to my original suggestion of "I would
really like insmod to be able to flock modules [...]" except that
you don't need the kernel support to increment the reference
count on the modules because rmmod will also do the same flock.  Come
to think of it, if insmod requests shared locks on the modules that
it wants and rmmod requests exclusive locks, I think that should
completely resolve the problem.


>> >I want to keep the kernel implementation simple, this would only bloat it.
>> >Cleaning up after a signal shouldn't bother the kernel (at least as far 
>> >as modfs is concerned).
>> 
>> 	User level programs cannot catch SIGKILL.  I was not talking about
>> adding anything to the kernel.

>Why would you kill insmod with SIGKILL?

	For example, you might be aborting a shutdown, or you might
have decided to kill all processes on a certain terminal because
you're trying to kill some runaway activity.

>If you do this you likely have to 
>cleanup manually anyway (what modfs might actually make possible).

	The point is that you could reduce or eliminate the "cleanup
manually" work to the point where orindary Linux users could manage
it.


>> 	If insmod knows what size to truncate the module to, then it
>> has at least a little code dealing with certain sections.  Theoretically,
>> it should also determine that the extable contains no pointers into .init
>> (although in practice I believe that that is always true right now).

>You're trying here to assign tasks to insmod it shouldn't know about. The 
>more insmod knows about the module layout the harder is it to change it 
>from the kernel side and the more you loose flexibilty.
>All this can be easily done by the kernel.

	By that logic, we must go with Rusty's kernel module loader,
perhaps with an interface like "int sys_insmod(char **argv)."

	Fortunatly, I don't buy that logic.  I think it greatly
overestimates the cost and degree of modutils compatability issues.
As I see it, we can weight what benefits we hope to get by dividing
the software in certain ways rather than trying to make unsupported
proclamations that something "shouldn't" be a certain way.

	Putting module truncate code in the kernel will add kernel
code for the truncate and for vmalloc_shrink(), and will impede
allocating smaller non-init module sections with kmalloc.  I think
that the compatability issues that we've had with the user level
module utilities have been relatively small and these changes will
make them smaller.  So, I think it will be the better trade-off in
terms of kernel memory consumption vs. insmod code maintenance for
insmod to continue to know about know about the ".init*" section
prefix and the fixup table section name (it does not have to know the
actual fixup data structure format).

	If you're really paranoid about tracking insmod and yet
not so paranoid that you want the module loader in kernel, I
suppose we could consider shipping insmod in the kernel tree
and installing it in /lib/modules/<version>/, or doing the same
for a user level dynamic library.



>> 	Small modules can potentially be allocated with kmalloc rather
>> than vmalloc for better memory efficiency and, I believe, so that they
>> can live in the kernel's 4MB huge page on architectures that support
>> it, eliminating their TLB utilization.  If you allocate the init and
>> non-init modules separately, the non-init module will more often be
>> small enough to be allocated this way (also true of the init module, but
>> we probably don't care much about that).
>> 
>> 	In addition to missing opportunities to use kmalloc,
>> implementing a truncation to a non-zero size in your modfs requires
>> additional code, including a vmalloc_shrink (I think Keith Owens
>> posted one).  I was not aware that you even were going to provide
>> files for writing the module's contents.  That seems unnecessary.
>> Even if you don't want a system call interface for copying the
>> module's contents in, why can't insmod just lseek and write /dev/kmem?

>Why should all these internals be exposed to insmod?  Why isn't a simple 
>'map this file into the kernel' interface not enough?

	The above paragraphs explain this: performance, kernel code
size.  There is a benefit to being able to allocate the small non-init
sections of module with kmalloc.

>Every change in this area requires changes to insmod,

	Lots of changes in this area would not require changes to
insmod anymore.  For example, changes to struct module or new fields
in just about any other kernel structure would no longer require changes
to insmod.


>now add all backward compability code and 
>soon you get the current insmod monster.

	2.5.48 has already broken backward compatability.  So that's
not really a requirement at this point.  Detecting older kernels and
execing /sbin/insmod.old in that case seems to have sufficed.

>> >You're trying to move your problems to someone else - very bad idea.
>> >If you can't get modules references right, you have very likely more 
>> >problems like module initialization races. Link everything together and 
>> >make the initialization explicit and don't rely on that the linker/loader 
>> >gets it magically right.
>> 
>> 	First of all, you can have circular references and still have
>> only one module_init function.  That is in fact that case with the
>> CONFIG_NET=m example that I described and you deleted from your
>> response--not very persuasive.
>> 
>> 	Secondly, you have not shown that these really are necessarily
>> always problems with cicular dependencies.  They are, after all, used
>> in the built-in kernel objects.

>Why do you want to move this problem to the module tools?

	"Move this problem" is not how I would describe it.  I want to
eliminate an incompatibility with built-in objects, and that
incompatability was introduced by the module system.

>As I said make 
>this dependency explicit (either by resolving them or explicit 
>initialization) and be done with it.

	I don't know exactly what you mean by this.  For example,
go back to my previous message and explain how to achieve CONFIG_NET=m.

>You cannot easily compare it boot initialization, e.g. net/core uses 
>subsys_initcall, so it's initialized earlier. The network was never 
>written as module

	Almost all modules were originally "never written as a module."

>and you are trying the easy way out by pushing the 
>complexity to someone else.

	I don't know what you mean by "pushing the complexity on
someone else."

>Nobody else needs this feature and there are 
>alternative ways, so I fail to see why everyone should pay for this.

	I don't know what standard you have in mind when you say
"needs."  Nobody "needs" anything in Linux, or computers.  People
survived just fine without them for millenia.

	Many people could benefit from CONFIG_NET=m, because it would
allow for smaller media boot images or ones with more drivers, while
still allowing the network functionality to be loaded later without
the need to reboot to a new kernel.  There are also still people who
use PC's without networking, although not many in the developed world.
It might also be another pebble on the balance scale for gadget
manufacturers that do not have Linux kernel developers but might
consider Linux for some devices that might not due networking (mp3
players, low end PDA's, or, more likely, more specialized products).
Besides, I'm just using CONFIG_NET=m as one example.  It's probably
not the only example of a facility that could be more easily
modularized reference loops among modules were allowed (for example, I
think isa-pnp was recently unmodularized for this reason, although my
recollection could easily be wrong about that).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

