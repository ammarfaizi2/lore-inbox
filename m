Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266503AbUA3FKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266470AbUA3FKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:10:34 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:37586
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S266503AbUA3FKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:10:20 -0500
Message-ID: <4019E713.1010107@redhat.com>
Date: Thu, 29 Jan 2004 21:09:39 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com> <20040129191500.GA1027@mail.shareable.org> <4019A5D2.7040307@redhat.com> <20040130041708.GA2816@mail.shareable.org>
In-Reply-To: <20040130041708.GA2816@mail.shareable.org>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jamie Lokier wrote:

> Because I am sure you don't agree :) this is how to implement it:

You are right, nothing like this is in the least acceptable.  Text
relocations are completely off-limits.  Depending on prelinking being
available is not acceptable.

Your entire scheme is based on this and therefore not worth the bits
used to store it.  Your understanding of how and where syscalls are made
and how ELF works is flawed.  There is no "group the syscalls nicely
together", they are all over the place, inlined in many places.  There
is no concept of weak aliases in dynamic linking.  Finding all the
"aliases" requires lookups by name for now more than 200 syscall names
and growing.  Prelinking can help if it is wanted, but if the vDSO
address is changed or randomized (this is crucial I'd say) or the vDSO
is not setup up for a process, the full price has to be paid.  With
every kernel change the whole prelinking has to be redone.  We kept the
dependencies with the vDSO minimal exactly because it is not a normal DSO.


This proposed method is many times more expensive for all processes
which do not call the same syscalls many many times over.  Every single
name lookup costs dearly, the larger the application the more expensive.
 The startup times will probably increase ten-fold or moreif prelinking
isn't available or disabled because one or more of the linked in objects
changed.  You cannot say that it's OK the system becomes unusable if
prelinking isn't used.  There are always programs which are not
prelinked because they cannot be prelinked, they are newly
installed/updated, or because prelinking isn't done at all to increase
security.  No method must perform measurably worse than normal,
non-prelinked code does now.


And I am not in the least convinced that this one direct jump from a
tainted page is faster then the indirect jump from read-only memory.
You increase the memory usage of the system.  You'd need a couple of
additional pages in each process' glibc which are not shared.


If gettimeofday() is the only optimized syscall, just add a simple

  cmp $__NR_gettimeofday, %eax
  je  __vsyscall_gettimeofday

to the __kernel_vsyscall code.  With correct static branch prediction
you'll not be able to measure the effect.  The correct way is IMO to
completely hide the optimizations since otherwise the increased
dependencies between kernel and libc only create more friction and cost
and loss of speed.


- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAGecT2ijCOnn/RHQRAkBwAJ9f4gKLdVeUpA4kbfxwb1Y4oiJmdQCghg7e
JK8NvNy1GyEJXtE5pGJB1IU=
=D0yc
-----END PGP SIGNATURE-----
