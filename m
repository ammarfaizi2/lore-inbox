Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268213AbTCFSrP>; Thu, 6 Mar 2003 13:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268239AbTCFSrP>; Thu, 6 Mar 2003 13:47:15 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:19682
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S268213AbTCFSrI>; Thu, 6 Mar 2003 13:47:08 -0500
Message-ID: <3E679A55.4030701@redhat.com>
Date: Thu, 06 Mar 2003 10:58:29 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com> <20030306010517.GB17865@wotan.suse.de> <3E66CB1A.6020107@redhat.com> <20030306102720.GA23747@wotan.suse.de>
In-Reply-To: <20030306102720.GA23747@wotan.suse.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:

> We're using %fs enabled glibc (currently with arch_prctl, but I would
> like to change that because it's slow) 

It's already part of the documented ABI.  Yes, if right now somebody
said r11 or whatever is declared the thread register, we could change
it.  But give it a few more weeks and it'll probably be impossible.


> It's hardcoding the magic fs register in the kernel for once.

The kernel just corresponds to what userland expects.  It's the same for
otherarchitectures where clone() loads the appropriate register.


> Now with it getting reloaded it would make sense to set it in the GDT
> too if possible, I agree. I'll implement that.

I'm not sure what your plans wrt to set_thread_area in 64-bit mode are
but I would strongly suggest to remove it completely.


> It will also transparent speed up the glibcs already using arch_prctl.
> I like that.

Yes.


> I can do a similar thing in clone. It unfortuately also hardcodes fs there,
> but I guess that ugly hack will be needed to get the broken NPTL design for this
> to work.

You don't understand threads.  There is nothing broken or NPTL-specific
about the design.  Every thread creation mechanism must be signal save.
 LinuxThreads's is not, which is a bit less of a problem since the
signal handling is broken, too, and signals are unlikely to arrive at
the new thread. Nevertheless, there are certainly spurious crashes which
are hard to reproduce and explain which can be attributed to this problem.

With fixed signal handling the newly created thread needs to have a
valid and correct thread register from the first instruction on and this
can only be implemented in the kernel.  Again, the other archs implement
similar dependencies.  ia-64 loads the tp register with the given value.
 The kernel doesn't live in a vacuum so this kind of dependency is OK.


> You just have to guarantee from user space that you don't do nasty
> things with the selector.

Sure.  Write this in the ABI docs.  Or leave the whole segment register
handling undefined so that nobody gets the idea it's useful to use.


>>- - automatically load the %fs or %gs register with the correct value
>>  before returning from prctl().  This introduces no binary
>>  incompatibilities and it's really the expected behavior.
> 
> 
> It's already done (set to zero) to not confuse the lazy switch logic.

Switching to zero is only correct when using the MSR.  I'm talking about
the case when the value is used as the base address of a segment.  In
that case %fs has to be loaded with the value corresponding to the
apppropriate GDT index.  The loading can happen in the kernel (or when
returning from it) or left to the user.  I think the former is better
since it corresponds more cleanly to what happens if the MSR is used.
If you don't want it return the GDT index and the user code will have to
issue the mov instruction if the return index is != 0 (indicating the
MSR is used).


> 2.5.64 currently doesn't boot (known issue); 2.5.63 works however.
> I'll look into the .64 problems later today and put a fix onto the
> usual place when done (ftp://ftp.x86-64.org/pub/linux/v2.5/) 

Thanks, looking forward to that.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Z5pV2ijCOnn/RHQRAsmhAJ9A9JXlw6YJ/5RAG+Y5NF708UChVwCgv7Cc
1JoFN0hrXYjZ7eynW3Nyj8I=
=+qtg
-----END PGP SIGNATURE-----

