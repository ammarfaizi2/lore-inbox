Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALCbu>; Thu, 11 Jan 2001 21:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130376AbRALCbk>; Thu, 11 Jan 2001 21:31:40 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:30243 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129742AbRALCb2>;
	Thu, 11 Jan 2001 21:31:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        List Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Fri, 12 Jan 2001 03:12:47 BST."
             <20010112031247.E10035@nightmaster.csn.tu-chemnitz.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jan 2001 13:30:56 +1100
Message-ID: <24827.979266656@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001 03:12:47 +0100, 
Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:
>So why don't we use sth. like depmod for these issues and get the
>link order automagically (like we get module load order)?

depmod handles dependencies on symbols.  Module Y needs a symbol from
module X so modprobe must load X before Y.  This is a link/load problem
which depmod handles fairly well.

The initialisation order is a dependency on actions, not on symbols.
Code F cannot start until code E has initialised so execute E before F.
This should have *NOTHING* to do with link order, but it is implemented
as a side effect of link ordering which confuses people.

People need to realise that the problem is initialisation order,
nothing more, nothing less.  You have to determine and document the
startup requirements for your code.  Only you know what the startup
pre-requisites for your code are, there is no way for another program
to determine this from the source.  Document your startup requirements,
implement according to the documentation and your problems go away.

Initialisation order is not the problem, the implementation is the
problem.  The method currently used to control initialisation order
sucks.  It is better than the original method (lots of conditional
calls in main.c) but it still sucks.

* Initialisation order is set by the order of structures in section
  .initcall.init.
* The order of the structures in .initcall.init is set by the order
  that objects are linked into vmlinux.
* The link order for vmlinux is derived from a combination of line
  order within a Makefile plus an overriding directory link order from
  the top level Makefile and parent Makefiles.
* Because order is a side effect of adding a line to a Makefile, the
  order requirements are rarely documented.

It is no wonder that people have problems getting the initialisation
order correct.

I want to completely remove this multi layered method for setting
initialisation order and go back to basics.  I want the programmer to
say "initialise E and F after G, H and I".  The kernel build system
works out the directed graph of initialisation order then controls the
execution of startup code to satisfy this graph.

That still means controlling link order to achieve the required result.
But with my approach the complexity would be handled by kbuild based on
explicit rules which are documented in the local Makefile, instead of
the complexity being handled by programmer via implicit rules scattered
over several layers of Makefiles.

A typical graph would have scsi disk depends on scsi host adaptor group
which depends on pci.  Within the scsi host adaptor group you might
need to initialise one driver before another, so just declare the few
inter-driver dependencies.  kbuild would automatically initialise pci
then the scsi host adaptors (in the correct order) then scsi disk.

Most of the objects have fairly simple execution dependencies, e.g.
all file systems depend on core fs code having already executed.  There
are no dependencies between most file systems so most file systems
could initialise in any order[1] which means they could be linked in
any order within the file system group.

I am ready and willing to code this method, it would make kbuild a lot
easier to code, as well as making future maintainence a lot easier.
Linus refuses to accept this approach.  He insists that kernel coders
explicitly specify the link order for everything, via Makefile
order[2].  As long as Linus insists on kernel coders explicitly
controlling the entire link order, we are stuck with the current
method.  I have tried to change his mind without success.

[1] vfat is one obvious exception, it needs dos first.  Also the first
    few built in file systems must execute in a defined order because
    that in turn controls the probe order for mount.  But this order
    should be explicitly declared, not as a side effect of the line
    order in fs/Makefile.

[2] http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg10520.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
