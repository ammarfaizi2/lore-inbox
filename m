Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTA1V1K>; Tue, 28 Jan 2003 16:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbTA1V1K>; Tue, 28 Jan 2003 16:27:10 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:15330 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261330AbTA1V1J>;
	Tue, 28 Jan 2003 16:27:09 -0500
Date: Tue, 28 Jan 2003 21:36:21 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030128213621.GA29036@bjl1.asuk.net>
References: <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.33L2.0301281139570.30636-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301281139570.30636-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Wed, 22 Jan 2003, Jamie Lokier wrote:
> 
> | ps.  sys_* system-call functions should never return "int".  They
> | should always return "long" or a pointer - even if the user-space
> | equivalent returns "int".  Take a look at sys_open() for an example.
> | Technical requirement of the system call return path on 64-bit targets.
> 
> Is this a blanket truism?  For all architectures?

I believe so, for all architecture-independent syscall functions.
(And architecture-dependent on those that need it -- see end of this
message).

Linus mentioned it in passing in the recent x86 vsyscall threads.  I
have never seen it mentioned before.  I always assumed that returned
longs were due to sloppy programming :)

If you look at the syscall return paths on the 64-bit architectures,
some of them always check the 64-bit return value register to see if
it is negative.  If so, they set an error flag, which is what
userspace uses to decide whether to return -1, rather than checking if
the return value is >= -4096 (or >= -125, architecture implementations vary).

This convoluted ABI allows those architectures to return full 64-bit
values as legitimate values, which is needed for... ptrace(), only on
those architecture of course.

The question is therefore are "int" values returned from C functions
sign-extended to 64 bits?  I don't know, maybe it varies between
architectures -- for all I know it happens to work on all the
supported 64-bit architectures -- but I believe this is the reason why
"long" (or equivalent, e.g. "ssize_t") and pointer types are
_supposed_ to be the only permitted return types from syscall
functions.

> Should current (older/all) syscalls be modified, or should only new ones
> (like epoll) be corrected?

All of them.

Here's a partial list of functions which return int from 2.5.49, based
on parsing Alpha, ARM, CRIS, IA64 and x86_64 trees:

	sys_set_tid_address
	sys_futex
	sys_sched_setaffinity
	sys_sched_getaffinity
	sys_remap_file_pages
	sys_epoll_create
	sys_epoll_ctl
	sys_epoll_wait
	sys_lookup_dcookie
	sys_pause

As far as I can guess from reading the GCC sources, 32-bit return
values aren't sign extended on x86_64 and IA64, but they are on all
the other Linux-supported 64-bit architectures (I could be mistaken
about this).  Of x86_64 and IA64, only the IA64 syscall return path
tests if the return value register is negative.

Which suggests that all the architectures are fine with all these
"int" returns, except IA64.

Curiously, IA64's own sys_perfmonctl() returns int.

-- Jamie
