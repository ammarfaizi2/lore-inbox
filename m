Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266603AbRGLVYQ>; Thu, 12 Jul 2001 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRGLVYI>; Thu, 12 Jul 2001 17:24:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62049 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266603AbRGLVXz>; Thu, 12 Jul 2001 17:23:55 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave J Woolley <david.woolley@bts.co.uk>, andrew.grover@intel.com,
        linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com>
	<m1zoaa6sy0.fsf@frodo.biederman.org>
	<3B4DCCF8.16B27789@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Jul 2001 15:18:18 -0600
In-Reply-To: <3B4DCCF8.16B27789@mandrakesoft.com>
Message-ID: <m1r8vl7so5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> "Eric W. Biederman" wrote:
> > That and the linux tools for making small binaries are relatively
> > immature.
> 
> I am rapidly discovering that :(
> 
> I wouldn't mind, for example, having a linker that is smart enough to
> eliminate dead code inside code sections, and can rewrite function
> prologues to more optimized forms once it knows the entire scope of said
> functions.  (ie. an optimizing linker)

I'll worry about the linker when the embedded libc problem is handled.
uClibc is the most mature when I looked several months ago, and unlike dietlibc
it actually tried not to user kernel headers.
 
> > > I don't like the current initrd very much myself, I have to admit. I'm not
> > > going to accept a "you have to have a ramdisk" approach - I think the
> > > ramdisks are really broken.
> > >
> > > But I've seen a "populate ramfs from a tar-file built into 'bzImage'"
> > > patch somewhere, and that would be a whole lot more palatable to me.
> > 
> > To some extent I'd prefer to build the tar-file into vmlinux as that
> > makes it a multi architecture solution.  I don't like the fact that
> > rdev only works on x86.
> 
> IMHO rdev -should- work on other platforms.  There -should- be a way to
> set flags inside an already-built kernel image.  That concept is not
> inherently x86.
> 
> That is why I favor
> 
> 	cat bzImage ramfs.tar.gz > vmlinuz
> 	rdev vmlinuz i-have-a-ramfs
> 
> It's -much- more flexible than actually building the initramfs into the
> kernel.
> 
> Admittedly I'm biased but IMHO the only reason why people want to lose
> flexibility by avoiding this approach is to avoid coming up with an rdev
> concept that works on alpha, sparc, ...  :)

Which is why I mentioned vmlinux.  All platforms build it at some stage.

> > - The version of ``preinit'' cannot use glibc, there is too much
> >   bloat.  uclibc is o.k. but a little immature.  We can probably use
> >   the infrastructure we have in linux/unistd.h for doing system calls
> >   from the kernel to remove any dependieces on other packages.  But
> >   using kernel headers from user space has been outlawed...
> 
> There should be no need to use linux/unistd.h infrastructure.  dietlibc
> is just as small (smaller than uClibc in the cases I've tried), and has
> already done this.  They even have dynamic linking going for x86, arm,
> sparc, and maybe others.  http://www.fefe.de/dietlibc/

I've played with it.  Dietlibc is horrible on alpha.  The basic problem
is dependecies on kernel headers.  uClibc was at least straight forward
to port.  In my backlog of things to do is get the uClibc port to alpha
contributed.

> > - We must be architecture netural.  Do this only for x86 is
> >   unacceptable.
> 
> obviously

I saw plenty of reference to bzImage and vmlinuz, it is only obvious
in hindsight.  

> > - The _init stuff that allows us to throw code after device
> >   initialization would need to be disabled to some extent because it
> >   would now depends on code in user space.
> 
> I don't see this at all, can you elaborate?

Well if you don't know the devices is there, you can't throw away it's
initialization routine.  This problem already exists to some extent with
hot-plug pci devices.  But if you treat the host pci bridge as a hot-plug
pci device, then everything else is as well..

> > Irq tables.  A corrected system memory map.  Builtin ISA devices.
> > Long term we need is an interface to feed a pre intialized
> > ``struct device'' (the renamed struct pci_device) tree into the kernel.
> 
> ie. come up with our own firmware->kernel information passing interface
> :)
> 
> Let's make it better than ACPI this time, shall we?  :)

It's probably the most important thing on my todo list, (with the
exception of convincing AMD it's not a problem to release a few extra
lines of code)...  Though
since it is most grunt work and detail checking I'm not even going to
look at it until I'm back from vacation :)

Eric
