Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSIZXdm>; Thu, 26 Sep 2002 19:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSIZXdm>; Thu, 26 Sep 2002 19:33:42 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:20231 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261572AbSIZXdl>; Thu, 26 Sep 2002 19:33:41 -0400
Date: Fri, 27 Sep 2002 01:38:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020926015900.5FD0C2C058@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209261845420.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Rusty Russell wrote:

Hmm, no comments about the proposed module layout? I suppose you believe
me now, that a small and simple userspace insmod is possible. :)

> > A possible solution would be to do something what I'm planning to do for
> > kernel conf - export it as library, then external tools can link the
> > module linker in dynamically.
>
> That makes sense for kernel conf, but less sense to try to find the
> library matching the kernel that you're running on now.  We have
> enough trouble finding the right modules 8) So you need a mechanism to
> check that this is the right library for the kernel.

You need to check that the module matches the kernel as well, so same
problem and possibly the same solution as well.

> If you load an initial ramdisk, which loads modules, then you need to
> leave the initial ramdisk loaded so you can load more modules later
> (for the symbols).  Of if you assume the modules inside the initrd are
> the same as the ones a later insmod sees, all you need is "what
> symbols are loaded where?".
>
> So:
>    o A interface to list of what modules are loaded and where.
>    o An interface to allocate some space in the kernel.
>    o An interface to put something into that space and call a given
>      function.

Transfering data from the initramdisk to the final root shouldn't really
be a problem. Other tools might need that too.

> Now, you still have the "insmod gets killed" problem, so you really
> want to have your "allocate" interface detect this.  Easy: hand out a
> file descriptor, so the module code gets called back when its closed,
> and frees the memory.

That's a userspace problem that is also solvable in userspace. A module
which is only allocated can also be removed like a normal module.
A better module interface to the kernel is desirable, but not a really
urgent yet.

> Each interface requires two pieces of code, one inside the kernel, and
> one in userspace.  In this case, the creation of the interface is not
> for compatibility reasons (in fact, it's such a problem that you need
> matching code versions on both sides!), but just to try to keep some
> code outside the kernel.

What is new about this? Module loading is hardly the only kernel interface
which requires matching user space tools. Do you plan to change the module
interface every other release?

> > Doing the linking in userspace would allow us
> > to remove all symbol information from the kernel (and only keep them for
> > debugging, e.g. kksymoops), even module dependency tracking could be done
> > completely from userspace. Module related information could be reduced to
> > an absolute minimum, so that a nonmodular kernel had no advantage to a
> > modular kernel anymore.
>
> It'll *always* be slightly smaller and slightly faster, unless you
> don't optimize the CONFIG_MODULES=n case.

The speed difference can be fixed for most modules and the additional
memory overhead could be almost negligible.
Actually we do too little in the nonmodule case, for example if a module
fails the kernel will happily initialize any module which depends on it.

> We're still talking about cutting a few hundred lines of code, and
> tens of K, from the kernel in return for increasing complexity.

I rather keep the complexity in userspace than forcing it into the kernel,
where here the complexity is not bad and gives us much more flexibility.
I'm not completely opposed to a kernel, but completely disabling the user
space loader is IMO not acceptable (at least not until the new loader went
through one stable release).

bye, Roman

