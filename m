Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSKVXRO>; Fri, 22 Nov 2002 18:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSKVXRO>; Fri, 22 Nov 2002 18:17:14 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:14344 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265414AbSKVXRM>; Fri, 22 Nov 2002 18:17:12 -0500
Date: Sat, 23 Nov 2002 00:24:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, <vandrove@vc.cvut.cz>
Subject: Re: [RFC] module fs or how to not break everything at once
In-Reply-To: <200211222211.OAA17427@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0211222328140.2109-100000@serv>
References: <200211222211.OAA17427@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 22 Nov 2002, Adam J. Richter wrote:

> >The linker script will not go away, it makes the loader a _lot_ easier and 
> >I want to keep it this way. Multiple module_init() calls won't happen, 
> >don't even try it.
> 
> 	How does one script and one .o make the loader "a _lot_ easier"
> than with two .o's?

Check the previous discussions about kloader support for other archs, e.g. 
some have special requirements for section ordering, all this work is 
already done by the linker, why should I duplicate this in the loader?

> >The user space locking should of course be a bit more intelligent than one 
> >big lock.
> 
> 	You would have provided more details you had thought this
> through.  Maybe you never need to do anything from a module_init
> function that loads another module, but, if you do, then there may
> not be an answer in the form of a user space locking policy, and it
> may necessitate moving many elements back into the kernel,

I'm planning to do this with a per module locking, for every module in the 
kernel there is a file with symbol/dependency/... information on which you 
can easily use flock.

> >I want to keep the kernel implementation simple, this would only bloat it.
> >Cleaning up after a signal shouldn't bother the kernel (at least as far 
> >as modfs is concerned).
> 
> 	User level programs cannot catch SIGKILL.  I was not talking about
> adding anything to the kernel.

Why would you kill insmod with SIGKILL? If you do this you likely have to 
cleanup manually anyway (what modfs might actually make possible).

> 	If insmod knows what size to truncate the module to, then it
> has at least a little code dealing with certain sections.  Theoretically,
> it should also determine that the extable contains no pointers into .init
> (although in practice I believe that that is always true right now).

You're trying here to assign tasks to insmod it shouldn't know about. The 
more insmod knows about the module layout the harder is it to change it 
from the kernel side and the more you loose flexibilty.
All this can be easily done by the kernel.

> 	Small modules can potentially be allocated with kmalloc rather
> than vmalloc for better memory efficiency and, I believe, so that they
> can live in the kernel's 4MB huge page on architectures that support
> it, eliminating their TLB utilization.  If you allocate the init and
> non-init modules separately, the non-init module will more often be
> small enough to be allocated this way (also true of the init module, but
> we probably don't care much about that).
> 
> 	In addition to missing opportunities to use kmalloc,
> implementing a truncation to a non-zero size in your modfs requires
> additional code, including a vmalloc_shrink (I think Keith Owens
> posted one).  I was not aware that you even were going to provide
> files for writing the module's contents.  That seems unnecessary.
> Even if you don't want a system call interface for copying the
> module's contents in, why can't insmod just lseek and write /dev/kmem?

Why should all these internals be exposed to insmod? Why isn't a simple 
'map this file into the kernel' interface not enough? Every change in this 
area requires changes to insmod, now add all backward compability code and 
soon you get the current insmod monster.

> >You're trying to move your problems to someone else - very bad idea.
> >If you can't get modules references right, you have very likely more 
> >problems like module initialization races. Link everything together and 
> >make the initialization explicit and don't rely on that the linker/loader 
> >gets it magically right.
> 
> 	First of all, you can have circular references and still have
> only one module_init function.  That is in fact that case with the
> CONFIG_NET=m example that I described and you deleted from your
> response--not very persuasive.
> 
> 	Secondly, you have not shown that these really are necessarily
> always problems with cicular dependencies.  They are, after all, used
> in the built-in kernel objects.

Why do you want to move this problem to the module tools? As I said make 
this dependency explicit (either by resolving them or explicit 
initialization) and be done with it.
You cannot easily compare it boot initialization, e.g. net/core uses 
subsys_initcall, so it's initialized earlier. The network was never 
written as module and you are trying the easy way out by pushing the 
complexity to someone else. Nobody else needs this feature and there are 
alternative ways, so I fail to see why everyone should pay for this.

bye, Roman

