Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUBCRha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 12:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBCRh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 12:37:29 -0500
Received: from mail.shareable.org ([81.29.64.88]:25294 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263609AbUBCRhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 12:37:23 -0500
Date: Tue, 3 Feb 2004 17:37:16 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040203173716.GC17895@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040201012803.GN26076@dualathlon.random> <401F251C.2090300@redhat.com> <20040203085224.GA15738@mail.shareable.org> <20040203162515.GY26076@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203162515.GY26076@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> could you please explain what's the point of this randomising thing what
> this attacker is trying to do?

Most buffer overflow attacks work by overwriting the return address of
a function to make it jump to a known fixed address.

The simplest form of that is where the stack is at a known address, so
the attack overwrites a return address to jump to the stack, to
instructions which are directly controlled by the attacker (part of
the same buffer overflow).

When the stack is not executable or randomised, more complex attacks
are used that take advantage of code sequences in the library or
executable itself.

To counter that, if everything executable is mapped at a random
address, there is no fixed address that can be jumped to for this kind
of attack.  More complex attacks which trick code into behaving
wrongly are required.

> nothing can be randomized, as far as the vsyscall can be executed it
> means its address in the address space is known and not random. If the
> address is random you can't execute it. The whole vsyscall space is
> readonly, the attacker can do nothing on it, no way to touch it with
> put_user either.

In this context, random means that the process knows the address and
the (remote) attacker does not.

> especially having a fixed address per-kernel makes no sense at all since
> it's trivial to find out by all other tasks anyways.

To put it another way, that protects against some kinds of remote
attack but it doesn't protect at all against local ones.

> the current API was presented around two years ago at UKUUG, and it was
> developed in the open in the x86-64 mailing list (archives should be
> online), so if there's really a fundamental problem it would been much
> better if you would send your complains to those lists at that time,
> instead of coming out of the blue years later when the code runs in
> production just fine for years (and it's in glibc for a long time too I
> think).

> Still I'm struggling to understand what's your point about
> randomization, your request makes no sense at all to me

I presume you mean Ulrich's request?  I couldn't care less :)

Also you'll notice that randomised executables & libraries is a
relatively new feature, nobody was doing it 2 years ago.

> and I cannot imagine any remote security issue related to the
> current API of the vsyscalls,

Simple: Attack finds buffer overflow, uses it to overwrite a
function's return address to make the CPU jump to the vsyscall code.
There's a good change the function will have popped some registers
before returning, to values also set by the overflow.  If that
function isn't quite convenient enough, the overflow could overwrite
the parent function's registers and return address instead.

By making the CPU jump to the vsyscall code and with some register
values settable, the attack can perform a syscall.  This is the remote
security issue: it allows a buffer overflow to escalate easily to
making a syscall.

All systems with non-randomised libc address have this problem at the
moment, i.e. virtually all systems.  There's just a few that have been
hardened with the randomised executable and library stuff, and Ulrich
would like that to be complete, which means the vsyscall page as well.

> furthmore I cannot remotely imagine any difference in terms
> of security by using a vsyscall table, the only difference to the end
> user would be that its userspace would be running slower, while right
> now it's running as fast as the hardware can.

The vsyscall table discussion has nothing to do with security.

At the moment, Glibc is not running as far as the hardware can on
i386, but the cost of making it do so which includes some program
startup time and memory cost is considered not worth the minor speed change.

> I would appreciate a more detailed explanation rather than "address must
> randomized and the api must be changed".

If there's something I missed feel free to ask.

-- Jamie
