Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267765AbTCFEDD>; Wed, 5 Mar 2003 23:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267773AbTCFEDD>; Wed, 5 Mar 2003 23:03:03 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:50909
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267765AbTCFEDB>; Wed, 5 Mar 2003 23:03:01 -0500
Message-ID: <3E66CB1A.6020107@redhat.com>
Date: Wed, 05 Mar 2003 20:14:18 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com> <20030306010517.GB17865@wotan.suse.de>
In-Reply-To: <20030306010517.GB17865@wotan.suse.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[Dammit, send prematurely.  Ignore the first copy.]

Andi Kleen wrote:

> You want the change, not me ;)

But I cannot test it since the kernel doesn't work.


> It should already work on the current kernel, modulo clone.
> (but arch_prctl, set_thread_area in 2.5, ldt in 2.4 etc.)

I cannot confirm this.  I wasted a lot of time on getting it to work.
Without avail.


> It's needed for 32bit emulation at least. The code is 100% shared
> between the emulation and the native 64bit model.

That's irrelevant.  Nobody needs the interface in 64-bit mode if there
is the prctl() code.  Yes, there will be one more if() in copy_thread,
but so what?


> In theory it could be removed from the system call table for 64bit
> but there didn't seem a good reason to do so - after all 64bit programs
> can put their thread local data into the first 4GB and
> fast context switches.

This limits the scalability.  Forever.


> The problem is that the 64bit base has different semantics.
>
> When you use a segment register you have to do:
>
> 	call kernel to set gdt/ldt
> 	movl index,%%fs
>
> But when the kernel did set the 64bit base in the kernel call the
> following movl to the selector would destroy it again

And the problem is?  Nobody must mug around with the segment registers
without knowing what s/he does.

If you want to change the %fs/%gs value temporarily follow this receipe:


  if (%[fg]s index is zero)
    saveidx = 0
    saveaddr = prctl (ARCH_GET_[FG]S)
  else
    saveidx = index of %[fg]s

  [...do your work...]

  if (saveidx == 0)
    prctl(ARCH_SET_[FG]S, saveaddr)
  else
    %[fg]s = saveindex


It's nothing you cannot handle from userspace.


> Loading the index inside the system call would also be problematic:
> First it would be different from what i386 does, causing porting
headaches.

Every program needs porting.  Normal memory allocation isn't guaranteed
to yield addresses < 4GB and therefore the use as a segment base address
fails.  Beside that, any program which modifies segment registers (I
cannot even think of more than two) are special and already have
portability code included if they run on machines != x86.


> Also you could not easily do it from a different thread unlike the
> LDT load.

Who says something about changing the LDT handling?  The set_thread_area
syscall handles the GDT.  And you cannot modify the GDT address
registered with a given index in another thread or process except with
ptrace().  Not even on x86.


> That should already work and it is in fact how I imagined this to be:
>
> do MAP_32BIT - if yes use set_thread_area or an LDT entry;
>
> if not use arch_prctl
>
> The NPTL signal race problem for the clones in case you have a 64bit
> base is a bit ugly though I agree.

You don't need two interface.  Make prctl() do it automatically.  It has
all the info it needs.  Forget about the set_thread_area syscall in
64-bit mode and simply use one fixed GDT entry in case the address
passed to pcrtl() is small enough.  Same for clone(): the SETTLS
parameter shole be a simple address.  Treat it as passed to prctl() and
use a segment or the MSR.

Te only remaining question is who to load the segment register.   There
are two possibilities:

- - have prctl() return the index and expect the user to load it.  This is
  slightly binary incompatible (existing code depends on no such
  requirement).  It could be solved by introducing ARCH_SET_FS_AUTO or
  so;

- - automatically load the %fs or %gs register with the correct value
  before returning from prctl().  This introduces no binary
  incompatibilities and it's really the expected behavior.


If you don't want to do the work help me to get 2.5 running on my
machine and I'll come up with a patch.

- --
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Zssb2ijCOnn/RHQRAubyAJ4lHZHO0ZFgHdWOab1mnezIJ1k/KQCggmOU
WXZQEdvrAZsGhbwNzskoXX4=
=m9SY
-----END PGP SIGNATURE-----

