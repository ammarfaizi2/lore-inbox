Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266150AbRGLQDy>; Thu, 12 Jul 2001 12:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266151AbRGLQDp>; Thu, 12 Jul 2001 12:03:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39265 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266150AbRGLQD2>; Thu, 12 Jul 2001 12:03:28 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave J Woolley <david.woolley@bts.co.uk>, <andrew.grover@intel.com>,
        <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        <acpi@phobos.fachschaften.tu-muenchen.de>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Jul 2001 09:57:43 -0600
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com>
Message-ID: <m1zoaa6sy0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Wed, 4 Jul 2001, Alan Cox wrote:

> We migth want to just make initrd a built-in thing in the kernel,
> something that you simply cannot avoid. A lot of these things (ie dhcp for
> NFS root etc) are right now done in kernel space, simply because we don't
> want to depend on initrd, and people want to use old loaders.

That and the linux tools for making small binaries are relatively
immature.

> I don't like the current initrd very much myself, I have to admit. I'm not
> going to accept a "you have to have a ramdisk" approach - I think the
> ramdisks are really broken.
> 
> But I've seen a "populate ramfs from a tar-file built into 'bzImage'"
> patch somewhere, and that would be a whole lot more palatable to me.

To some extent I'd prefer to build the tar-file into vmlinux as that
makes it a multi architecture solution.  I don't like the fact that
rdev only works on x86.
 
> If anybody were to send me a patch that just unconditionally does this, I
> would probably not be adverse to putting it into 2.5.x. We have all the
> infrastructure to make all this a lot cleaner than it used to be (ie the
> "pivot_root()" stuff etc means that we can _truly_ do things from user
> mode, with no magic kernel flags).
>
> But if we do this, then we should _truly_ get rid of all the root device
> etc setup crap (and the "search for init" etc stuff - it _is_ going to be
> there, and THAT process is the one that should then search for the real
> init once it has booted).

A list of issues I can see with doing this right now.

- umounting the initial fs after you have called pivot_root is
  tricky, can we run a program from an internal mount only?
  (We can remove all of the files on the initial fs with rm -rf /
   assuming we are running on ramfs)

- The version of ``preinit'' cannot use glibc, there is too much
  bloat.  uclibc is o.k. but a little immature.  We can probably use
  the infrastructure we have in linux/unistd.h for doing system calls
  from the kernel to remove any dependieces on other packages.  But
  using kernel headers from user space has been outlawed... 

- In the case of console=tty0 console=ttyS0 /dev/console does not
  output to the same locations as printk.

- We must be architecture netural.  Do this only for x86 is
  unacceptable.

- The _init stuff that allows us to throw code after device
  initialization would need to be disabled to some extent because it
  would now depends on code in user space.

> That, together with reasonable interfaces to let ACPI set irq data for the
> kernel etc, might make moving ACPI back into user space possible in
> _practice_ and not just in theory.

Irq tables.  A corrected system memory map.  Builtin ISA devices.
Long term we need is an interface to feed a pre intialized 
``struct device'' (the renamed struct pci_device) tree into the kernel.

Eric
