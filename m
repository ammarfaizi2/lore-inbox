Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUA3Acz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 19:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUA3Acz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 19:32:55 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:48592
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266247AbUA3Acv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 19:32:51 -0500
Message-ID: <4019A5D2.7040307@redhat.com>
Date: Thu, 29 Jan 2004 16:31:14 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com> <20040129191500.GA1027@mail.shareable.org>
In-Reply-To: <20040129191500.GA1027@mail.shareable.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:

> As this is x86, can't the syscall routines in Glibc call directly
> without a PLT entry?

No, since this is just an ordinary jump through the PLT.  That the
target DSO is synthesized is irrelevant.  It's ld.so which needs the PIC
setup, not the called DSO.


> With prelinking, because the vdso is always
> located at the same address, there isn't even a dirty page overhead to
> using non-PIC in this case.

But this isn't true.  The address can change.  There are already two
flavors (normal and 4G/4G) and there will probably be more.  Ingo would
have to comment on that.


> If you have to use a PLT entry it is.  If you can do it without a PLT,
> direct jump to the optimised syscall address is fastest.

A direct jump is hardcoding the information which is exactly what should
be avoided.


> Being Glibc, you could always tweak ld.so to only look at the last one
> if this were really a performance issue.  Btw, every syscall used by
> the program requires at least one symbol lookup, usually over the
> whole search path, anyway.

The symbol for the syscall stub in libc is looked up, yes, but nothing
else.  I fail to see the relevence.  You cannot say that since a call
already requires N ns it is OK for it to take 2*N ns.


> I hear what you're saying.  These are the things which bother me:
> 
>    1. There are already three indirect jumps to make a syscall.
>       (PLT to libc function, indirect jump to vsyscall entry, indirect
>       jump inside kernel).  Another is not necessary (in fact two of
>       those aren't necessary either), why add more?

Because they are all at different level and to abstract out different
things.


>    2. Table makes the stub for all syscalls slower.

Not as much as any other acceptable solution.  The vdso code is compiled
for a given address and therefore the memory loads can use absolute
addresses.


> All this is moot, though, because in reality only very few syscalls
> will be optimised, and it doesn't really matter if an older Glibc
> doesn't take advantage of a newer kernel's optimised version.  If
> someone would like the performance, installing an up to date Glibc is
> no big deal.

This is certainly not what many people think.  In general, every
dependency on the runtime for programs to take advantage of new kernel
features is bad and should be avoided.  If I'd write kernel code I'd
want to control the use as much as possible.  And this trivial jump
table can do this very efficiently.


> So pragmatically John's solution, with Glibc looking in the vdso just
> for syscalls it knows have an optimised implementation (i.e. just
> gettimeofday so far), is best IMHO.

Pragmatically?  How about "practically"?  Mind you, for x86 the code
wouldn't be as simple as the vgettimeofday call on x86-64.  For x86-64
all acceptable kernels had the vsyscall and therefore glibc doesn't have
to worry about it not being available.  And there currently in no second
or third location for the vDSO.

For x86 we have to handle in the same binary old kernels and kernels
where the vDSO is at a different address than the stock kernel.  This
means the computation of the address consists of several step.  Get the
vDSO address (passed up in the auxiliary vector), adding the magic
offset, and then jumping.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGaXS2ijCOnn/RHQRAqITAJ98+xMjIQInUqOZjVo52xOM3IFqZwCdHbFJ
O1poE0GkZx/75yGEDuNBz7o=
=GvFA
-----END PGP SIGNATURE-----
