Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSKVKnU>; Fri, 22 Nov 2002 05:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSKVKnU>; Fri, 22 Nov 2002 05:43:20 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:60679 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263143AbSKVKnS>; Fri, 22 Nov 2002 05:43:18 -0500
Date: Fri, 22 Nov 2002 11:50:23 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: vandrove@vc.cvut.cz, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] module fs or how to not break everything at once
In-Reply-To: <200211212321.PAA16033@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0211221053570.2113-100000@serv>
References: <200211212321.PAA16033@adam.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Nov 2002, Adam J. Richter wrote:

> 	Can you tell me what problem in the existing userland module
> code (i.e., before 2.5.48) modulefs solves?  Does it actually make
> the kernel smaller?  Can you give me an example?

Previous insmod knows too much about kernel internals, it has to fill in 
kernel structures, which makes changing this structure a real pain. Part 
of the relocation work can be moved to kbuild, what makes insmod simpler 
and gives us better control over the module layout. See the mini module 
loader I posted last week.

> 	1. Please take Petr's advice and just make module removal
> occur when you rmdir the directory.  Making the removal happen in
> two stages introduces additioal states that have to be defined, such
> as the state where the "module unmap" command has been received
> but the module's directory has been removed.  What if somebody else
> wants to load the same module again at this time?  Either you will
> get flakiness in facilities that rely on automatic kernel module
> loading or modprobe has to be modified to deal with that
> possibility and perhaps try to do the remove itself.

Synchronizing multiple insmod is needed in user space anyway, this doesn't 
make the kernel side more complex.

> 	2. I would really like insmod to be able to flock modules (or
> do something similar).  This would increment the reference count on a
> module until insmod would exit (or would do an execve, I suppose).
> This would eliminate a race when insmod is loading a module that
> references symbols in other modules.  I don't think flock is actually
> propagated down the vfs layer, so perhaps some other primitive could be
> used.  Perhaps just holding open an open file descriptor on each of
> the modules in question would be a better interface.

I don't know what you're trying to do here, but it sounds like you're 
mixing user space and kernel space problems here.

> 	3. It's not a modulefs thing, but you might want to consider
> moving all symbol management to user space, including that for the
> core kernel symbols.  The symbol tables can be maintained in user
> files by the insmod and rmmod programs, they could even be inferred
> from the module's start address and the module's .o in the file
> system.  If people really want to store this data to be stored in
> kernel memory, they can allocate extra space where the module is
> actually loaded and their favorite symbol table format there.

This is planned, symbols are only needed by kksymoops, otherwise they 
don't have to be kept in memory all the time.

>         4. Regarding what I said about leaving symbol tracking to
> user space, I'd like to add a note about reliability.  It is not
> necessary for rmmod to reliably remove symbols from these tables.
> insmod can check for symbols that map to places that are no longer
> allocated to modules and remove stale symbols before attempting to
> load a new module.

That's a mostly user space problem and I'd rather do this right, why 
should I keep invalid symbols?

>         5. You should not need to do anything special in modfs
> to support init sections.  That can be done by loading two separate
> modules and then removing the one corresponding to an init section.

I doubt that's a good idea, mostly also because of the following point.

>         6. For module_init functions, consider taking a pointer to
> an array of init functions and a count.  That would be compatible
> with the system for built-in kernel object files, so it would
> eliminate a difference in linux/include/init.h.  You could also do
> the same for module_exit functions.  This change would also
> allow linking .o's together more or less arbitrarily into single
> modules, which would allow loading of modules that have reference
> loops among them.

Reference loops are never a good idea, if object files are that closely 
related, create a single module. Multiple init/exit functions are no good 
idea either, in which order should they be executed? If it's really one 
module than also keep it one module.

>         7. Instead of module parameters, consider just supporting
> __setup() declarations used in kernel objects.  These would then
> process a string that you'd pass.  insmod might want to prepend the
> contents of /proc/cmdline to that string so that people could pass
> command lines at the boot prompt even if the driver they wanted to
> talk to were a module.  This change would eliminate another difference
> between module and core kernel objects.  Ultimately, I would like
> eliminate any compilation difference between kernel and module
> objects.  This would allow deferring the decision about what should be
> in modules and what should be in the kernel until link time.  Not only
> would this slightly simplify the build process and modules' source
> code,

Kernel parameter unification might actually be one of the few good parts
from Rusty's loader, but I have to look at, when it's working again.

> but it would also allow binary distributions for a wider
> variety of uses.

What does this mean???

bye, Roman

