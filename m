Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUA2TQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUA2TQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:16:15 -0500
Received: from mail.shareable.org ([81.29.64.88]:2176 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S266274AbUA2TQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:16:13 -0500
Date: Thu, 29 Jan 2004 19:15:00 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040129191500.GA1027@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40194B6D.6060906@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> And they require the syscall stubs to suddenly set up the usual PIC
> infrastructure since a jump through the PLT is used.

As this is x86, can't the syscall routines in Glibc call directly
without a PLT entry?  With prelinking, because the vdso is always
located at the same address, there isn't even a dirty page overhead to
using non-PIC in this case.

> This is much slower than the extra indirection the vdso could do.

If you have to use a PLT entry it is.  If you can do it without a PLT,
direct jump to the optimised syscall address is fastest.

> The vdso is just one of the DSOs in the search path and usually the very
> last.  So there would be possible many objects which are looked at
> first, unsuccessfully.

Being Glibc, you could always tweak ld.so to only look at the last one
if this were really a performance issue.  Btw, every syscall used by
the program requires at least one symbol lookup, usually over the
whole search path, anyway.

> And another problem I should have mentioned last night: in statically
> linked applications the vDSO isn't used this way.  Do dynamic linker
> functionality is available.  We find the vDSO through the auxiliary
> vector and use the absolute address, not the symbol table of the vDSO.
> If the syscall entry in the vDSO would do the dispatch automatically,
> statically linked apps would benefit from the optimizations, too.
> Otherwise they are left out.

I hear what you're saying.  These are the things which bother me:

   1. There are already three indirect jumps to make a syscall.
      (PLT to libc function, indirect jump to vsyscall entry, indirect
      jump inside kernel).  Another is not necessary (in fact two of
      those aren't necessary either), why add more?

   2. Table makes the stub for all syscalls slower.

All this is moot, though, because in reality only very few syscalls
will be optimised, and it doesn't really matter if an older Glibc
doesn't take advantage of a newer kernel's optimised version.  If
someone would like the performance, installing an up to date Glibc is
no big deal.

So pragmatically John's solution, with Glibc looking in the vdso just
for syscalls it knows have an optimised implementation (i.e. just
gettimeofday so far), is best IMHO.

-- Jamie
