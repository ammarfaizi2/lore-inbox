Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262138AbSIZBxo>; Wed, 25 Sep 2002 21:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262140AbSIZBxo>; Wed, 25 Sep 2002 21:53:44 -0400
Received: from dp.samba.org ([66.70.73.150]:49558 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262138AbSIZBxn>;
	Wed, 25 Sep 2002 21:53:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Wed, 25 Sep 2002 23:28:36 +0200."
             <Pine.LNX.4.44.0209252003370.338-100000@serv> 
Date: Thu, 26 Sep 2002 11:49:38 +1000
Message-Id: <20020926015900.5FD0C2C058@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209252003370.338-100000@serv> you write:
> A possible solution would be to do something what I'm planning to do for
> kernel conf - export it as library, then external tools can link the
> module linker in dynamically.

That makes sense for kernel conf, but less sense to try to find the
library matching the kernel that you're running on now.  We have
enough trouble finding the right modules 8) So you need a mechanism to
check that this is the right library for the kernel.

> > It it *now* clear why I'm not interested in saving a few hundred lines
> > of kernel code, even if the communication overhead didn't eat them up
> > again?
> 
> It's not only this. A kernel linker would force us to keep all symbol
> information in kernel space.

No, just the exported symbols (about 40k on my kernel).  We do
currently keep them uncompressed, which could be fixed (and kind of
shows how few people care about kernel bloat 8( )

If you load an initial ramdisk, which loads modules, then you need to
leave the initial ramdisk loaded so you can load more modules later
(for the symbols).  Of if you assume the modules inside the initrd are
the same as the ones a later insmod sees, all you need is "what
symbols are loaded where?".

So:
   o A interface to list of what modules are loaded and where.
   o An interface to allocate some space in the kernel.
   o An interface to put something into that space and call a given
     function.

Now, you still have the "insmod gets killed" problem, so you really
want to have your "allocate" interface detect this.  Easy: hand out a
file descriptor, so the module code gets called back when its closed,
and frees the memory.

Each interface requires two pieces of code, one inside the kernel, and
one in userspace.  In this case, the creation of the interface is not
for compatibility reasons (in fact, it's such a problem that you need
matching code versions on both sides!), but just to try to keep some
code outside the kernel.

> Doing the linking in userspace would allow us
> to remove all symbol information from the kernel (and only keep them for
> debugging, e.g. kksymoops), even module dependency tracking could be done
> completely from userspace. Module related information could be reduced to
> an absolute minimum, so that a nonmodular kernel had no advantage to a
> modular kernel anymore.

It'll *always* be slightly smaller and slightly faster, unless you
don't optimize the CONFIG_MODULES=n case.

We're still talking about cutting a few hundred lines of code, and
tens of K, from the kernel in return for increasing complexity.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
