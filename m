Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSKVUV0>; Fri, 22 Nov 2002 15:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSKVUV0>; Fri, 22 Nov 2002 15:21:26 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:26893 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262452AbSKVUVY>; Fri, 22 Nov 2002 15:21:24 -0500
Date: Fri, 22 Nov 2002 21:28:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, <vandrove@vc.cvut.cz>
Subject: Re: [RFC] module fs or how to not break everything at once
In-Reply-To: <200211221810.KAA17210@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0211222013110.2113-100000@serv>
References: <200211221810.KAA17210@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 22 Nov 2002, Adam J. Richter wrote:

> 	I meant "what real advantage does a _filesystem_ interface
> give you?"

- more flexibility, you get a lot for free from libfs.c and other parts of 
the kernel. Check how small the modfs example is, much more isn't needed.
- no extra syscalls needed, which might have to be emulated by 64bit 
system. Module objects are normal files, why waste a syscall if you can 
just write() them to the kernel?

> 	Thanks for the pointer.  Looking at your mini-loader, it seems
> to me that you could eliminate your modules.lds script if you would
> split module-init.c into module-init.c and module-finish.c, which would
> simplify the ability to link multiple modules together or have
> a module with multiple module_init() functions if we used the
> definition of module_init() that is used for kernel objects (more
> on this below).

The linker script will not go away, it makes the loader a _lot_ easier and 
I want to keep it this way. Multiple module_init() calls won't happen, 
don't even try it.

> >Synchronizing multiple insmod is needed in user space anyway, this doesn't 
> >make the kernel side more complex.
> 
> 	Then a module_init function that may cause another module to
> be loaded can deadlock.  I'll have to think about whether that is
> a problem.

The user space locking should of course be a bit more intelligent than one 
big lock.

> 	By the way, if you do serialize all rmmod and insmod calls,
> you still have the question of how to convey dependency information to
> the kernel if you do not want the loader to know about kernel data
> formats like struct module and struct module_ref.  Conceivably you
> could represent these dependencies by doing something like "ln
> /proc/modfs/libmodule/control /proc/modfs/mymodule/deps/libmodule".
> So, it may be possible to have a scheme where you do not need complete
> serialization of depmod and insmod, although I don't know if that will
> prove to be important.

The kernel doesn't need the dependency information, they can stay as well 
in user space. The checks currently done don't have to be done in the 
kernel.

> >That's a mostly user space problem and I'd rather do this right, why 
> >should I keep invalid symbols?
> 
> 	My point was just about being resiliant against, say, someone
> accidentally hitting a control-C or a kill signal during one of these
> programs, such as during an aborted shutdown.  However, now that you
> mention it, it would be useful for developers to have an rmmod option
> to retain symbols for debugging a bad memory reference that happens
> after a module has been unloaded.

I want to keep the kernel implementation simple, this would only bloat it.
Cleaning up after a signal shouldn't bother the kernel (at least as far 
as modfs is concerned).

> 	Even if you don't want to support circular dependencies
> (loading multiple .o's together) or multiple module_{init,exit}
> functions, having insmod load separate modules for the init and
> non-init parts will shrink the kernel code.  It would be nice
> for insmod to be able to do ELF section manipulations like this
> also to implement things like having .exit{,func} sections
> that insmod could drop if it were given a flag to load the
> module "permanently."

The point of the linker script is to avoid that the loader has to play 
around with the sections. If you want to get rid of init data, put it at 
the end and truncate() it when you're done. This is trivial to do with a 
module fs.

> >Reference loops are never a good idea,
> 
> 	An advantage of allowing circular loops is that everything
> would be modularized or nearly modularized with only a few changes.
> For example, I want to modularize CONFIG_NET (not just CONFIG_INET).
> However, there is a circular reference:

You're trying to move your problems to someone else - very bad idea.
If you can't get modules references right, you have very likely more 
problems like module initialization races. Link everything together and 
make the initialization explicit and don't rely on that the linker/loader 
gets it magically right.

bye, Roman

