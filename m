Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbUBCQ0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUBCQ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:26:23 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49583
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266033AbUBCQZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:25:17 -0500
Date: Tue, 3 Feb 2004 17:25:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040203162515.GY26076@dualathlon.random>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040201012803.GN26076@dualathlon.random> <401F251C.2090300@redhat.com> <20040203085224.GA15738@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203085224.GA15738@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 08:52:24AM +0000, Jamie Lokier wrote:
> Ulrich Drepper wrote:
> > You got to be kidding.  Some object fixed in the address space which can
> > perform system calls.  Nothing is more welcome to somebody trying to
> > exploit some bugs.
> 
> Two approaches to randomising the vdso address:
> 
>   1. Selecting a random address at boot time.  All tasks have the same
>      vdso for that run of the kernel.  Advantages: no MSR write at
>      each context switch; could patch libsyscall.so at boot time with
>      address if we were fanatical about optimisation (i.e. other
>      libcs, not Glibc :)  Disadvantages: the attacker may eventually
>      learn the address.
> 
>   2. Select a random address for every new task.  Advantages: harder
>      to guess from studying a machine for a long time.  Disadvantages:
>      slower context switches; the gain from randomising each task is
>      nothing if all the tasks are very long lived anyway.

could you please explain what's the point of this randomising thing what
this attacker is trying to do?

nothing can be randomized, as far as the vsyscall can be executed it
means its address in the address space is known and not random. If the
address is random you can't execute it. The whole vsyscall space is
readonly, the attacker can do nothing on it, no way to touch it with
put_user either.

on x86-64 whatever is executable is readable too (readable non
executable is possible but that's another issue)

whatever the API you'll always be able to find the vsyscall address or
it means you can't execute it in the first place.

so in short, either we have vsyscalls non-randomized, or we don't have
them at all, period.

especially having a fixed address per-kernel makes no sense at all since
it's trivial to find out by all other tasks anyways.

the current API was presented around two years ago at UKUUG, and it was
developed in the open in the x86-64 mailing list (archives should be
online), so if there's really a fundamental problem it would been much
better if you would send your complains to those lists at that time,
instead of coming out of the blue years later when the code runs in
production just fine for years (and it's in glibc for a long time too I
think).

Still I'm struggling to understand what's your point about
randomization, your request makes no sense at all to me and I cannot
imagine any remote security issue related to the current API of the
vsyscalls, furthmore I cannot remotely imagine any difference in terms
of security by using a vsyscall table, the only difference to the end
user would be that its userspace would be running slower, while right
now it's running as fast as the hardware can.

I would appreciate a more detailed explanation rather than "address must
randomized and the api must be changed".
