Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRALL4J>; Fri, 12 Jan 2001 06:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRALLz7>; Fri, 12 Jan 2001 06:55:59 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:47121 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129383AbRALLzt>;
	Fri, 12 Jan 2001 06:55:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        List Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Fri, 12 Jan 2001 10:27:34 -0000."
             <Pine.LNX.4.30.0101121005140.19393-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jan 2001 22:55:41 +1100
Message-ID: <31327.979300541@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001 10:27:34 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>On Fri, 12 Jan 2001, Keith Owens wrote:
>> A typical graph would have scsi disk depends on scsi host adaptor group
>> which depends on pci.
>
>No. sd will happily take over any existing devices when as and when they
>arrive. It doesn't have to be loaded last. Likewise, in theory at least,
>host adaptor drivers using the new PCI driver code would respond correctly
>to the PCI code being initialised (and calling their ->probe routine)
>later, although that doesn't happen now.

You just proved my point.  It is extremely difficult to deduce the
required initialisation order by reading an undocumented Makefile where
the init order is implemented as a side effect of selection order.  The
existing method implies link order when none is required.

>> Most of the objects have fairly simple execution dependencies, e.g.
>> all file systems depend on core fs code having already executed.
>
>Er... Why? They call register_filesystem() which uses a lock which is
>staticly initialised. Don't order stuff for the sake of it. If there are
>filesystems which _do_ require the VFS to be initialised first, those
>filesystems can be marked as such. I'm not aware of any.

I was using scsi and fs as examples, no need to pick holes in the
examples.  But ...

  fs/buffer.c:module_init(bdflush_init)
  fs/pipe.c:module_init(init_pipe_fs)
  fs/fcntl.c:module_init(fasync_init)
  fs/locks.c:module_init(filelock_init)
  fs/dnotify.c:module_init(dnotify_init)

I'm no filesystem expert but it appears that some of those core
initialisation routines must be executed before most filesystems can
start.  In particular, filelock_init() must be executed before any
filesystem that supports locks is initialised.

>All I want is a way to staticly add entries to the
>inter_module_xxx tables at compile time, because I _have_ done the
>analysis, and I'm saying that's when they should be made available.

Firstly inter_module_xxx is only used by that very small subset of code
where there are no constraints on whether the caller and callee can be
in kernel, in modules or a mixture _and_ some of the objects are
optional.  It is a special case because most code handles this problem
through CONFIG options.  If X needs (Y, Z) and X is built into the
kernel then (Y, Z) must also be built into the kernel.  If Y or Z are
optional then control the calls to those functions with CONFIG options.
Almost all of the kernel handles it properly though CONFIG, so
inter_module_xxx is already a process to handle a few special cases.

Secondly you want static inter_module_xxx tables for a small subset of
these special cases, where the source has no other initialisation code.
This is piling special cases on special cases.  Adding static
inter_module_xxx tables requires

* changes to linux/modules.h to define the new table format and
* changes to vmlinux.lds for _every_ architecture to bring all the
  static tables together in vmlinux and
* new initialisation code in module.c to read and load all the static
  tables at boot time and
* extra code in modutils to find any static tables in modules and
* an extension to struct modules to let modutils pass information about
  the static tables to the kernel and
* the kernel code will only work with an upgraded modutils.

That is a lot of work for a very few special cases.  OTOH, you could
just swap the order of 3 lines in drivers/mtd/Makefile.  Guess which
alternative I am going for?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
