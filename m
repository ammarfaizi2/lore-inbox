Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSJRLIl>; Fri, 18 Oct 2002 07:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265068AbSJRLIl>; Fri, 18 Oct 2002 07:08:41 -0400
Received: from [195.223.140.120] ([195.223.140.120]:14924 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265066AbSJRLIj>; Fri, 18 Oct 2002 07:08:39 -0400
Date: Fri, 18 Oct 2002 13:14:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
Message-ID: <20021018111442.GH16501@dualathlon.random>
References: <1034915132.1681.144.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034915132.1681.144.camel@cog>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Oct 17, 2002 at 09:25:31PM -0700, john stultz wrote:
> Linus, Andrea, all,
> 
> 	This is a port of Andrea's x86-64 vsyscall(userspace) gettimeofday to
> i386. Its fairly untested, but it works here! I'm sure it probably has a
> few bugs, but since a number of folks are wanting this, I figured I'd go
> ahead and post and just take the abuse. 
> 
> I realize that this is probably in the "too late" category, but please
> give any feedback you can and I'll try my best to get this ready to go
> before sunday night. 

the main reason it wasn't backported to i386 is that if glibc start
using the vgettimeofday instead of sys_gettimeofday, you won't be able
to downgrade kernel anymore to say 2.4 (oh yeah, I would then backport
it to my tree or Marcelo could apply the patches too to 2.4 but then 2.2
would be left uncovered, new glibc would segfault on the old kernels).
Probably the only way to avoid breaking backwards compatibility is that
glibc will check the uname at the first invocation and then it will
store the information in a global variable in the library. So then for
every second invocation it will be only an overhead of a branch. But it
would be a slowdown for this sequence
fork()exec()gettimeofday()exit()fork()exec()gettimeofday()exit()...

Secondly if we take this long term 32bit route we should first fix the
x86 ABI for the calling conventions too at the very least internally to
the kernel (that would even be completely backwards compatibile but much
more than fixing them for kernel it would be very important to fix them
in userspace). Fixing the ABI should give you much more performance than
vsyscalls (depends on the workload of course but vsyscalls optimizes
only some crtitical program like databases, the other would optimize
them all and its global effect could be even more visible for databases
too, we don't know). You know the registers %eax %ecx and %edx are
clobbered by the callee but they're not used for passing the first three
parameter to functions.  That's a bug in the calling conventions of x86,
I've no idea how such bug could ever see the light of the day, maybe
they expected a push + pop to ram to run faster than a single mov, I
can't know, but it definitely needs fixing. Such things as well will be
automatically fixed migrating to a 64bit kernel and userspace.  This is
why I didn't attempt to drop FASTCALL and to compile the x86 with
mregparm=3 like I didn't backport the vsyscalls to 32bit.

However this is just a reminder message, I mainly wanted to point out
why I didn't spent time in this effort myself, if Linus is excited to
include vsyscalls on 32bit too that's fine with me, it would be a
definitive improvement at least for the non asymmetric multithreading
nor NUMA cases where the TSC loses synchronization (unless something
mmapped like cyclone or HPET is available of course). So it's up to you ;).

Andrea
