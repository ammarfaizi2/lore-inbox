Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUBCSKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 13:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266118AbUBCSKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 13:10:16 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14783
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266114AbUBCSKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 13:10:04 -0500
Date: Tue, 3 Feb 2004 19:10:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040203181001.GA26076@dualathlon.random>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040201012803.GN26076@dualathlon.random> <401F251C.2090300@redhat.com> <20040203085224.GA15738@mail.shareable.org> <20040203162515.GY26076@dualathlon.random> <20040203173716.GC17895@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203173716.GC17895@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 05:37:16PM +0000, Jamie Lokier wrote:
> Andrea Arcangeli wrote:
> > could you please explain what's the point of this randomising thing what
> > this attacker is trying to do?
> 
> Most buffer overflow attacks work by overwriting the return address of
> a function to make it jump to a known fixed address.
> 
> The simplest form of that is where the stack is at a known address, so
> the attack overwrites a return address to jump to the stack, to
> instructions which are directly controlled by the attacker (part of
> the same buffer overflow).
> 
> When the stack is not executable or randomised, more complex attacks
> are used that take advantage of code sequences in the library or
> executable itself.
> 
> To counter that, if everything executable is mapped at a random
> address, there is no fixed address that can be jumped to for this kind
> of attack.  More complex attacks which trick code into behaving
> wrongly are required.

so you're talking about using vgettimeofday to exploit an insecure
explitable buggy application.

so you mean, people could jump to the vsyscall address, this is true. so
what, they will execute gettimeofday, then what? how bad is to execute
vgettimeofday? when vgettimeofday returns it will pop the next address
on the stack and then what? if you can change the stack with the
parameter of vgettimeofday then you know the stack address too.

I don't see any decrease of security in allowing an attacker to execute
vgettimeofday.

vsyscalls will never execute anything like execve. They can at most
modify userspace memory a fixed address, so if the userspace isn't
fixed, then nothing can be done with a vsyscall.

Please elaborate how can you use vsyscalls to write an exploit for a
buggy application. I don't see it.

> I presume you mean Ulrich's request?  I couldn't care less :)

yes ;)

> Also you'll notice that randomised executables & libraries is a
> relatively new feature, nobody was doing it 2 years ago.

with vsyscalls as worse you can modify memory at a fixed address passed
as parameter, so as far as the interesting userspace  parts are
randomized (i.e. system()) there's no way to exploit anything jumping in
a vsyscall.

> > and I cannot imagine any remote security issue related to the
> > current API of the vsyscalls,
> 
> Simple: Attack finds buffer overflow, uses it to overwrite a
> function's return address to make the CPU jump to the vsyscall code.
> There's a good change the function will have popped some registers
> before returning, to values also set by the overflow.  If that
> function isn't quite convenient enough, the overflow could overwrite
> the parent function's registers and return address instead.
> 
> By making the CPU jump to the vsyscall code and with some register
> values settable, the attack can perform a syscall.  This is the remote

how can the attacker perform a syscall? at worst it can do a
gettimeofday syscall anyways which is equivalent to the vgettimeofday.

> security issue: it allows a buffer overflow to escalate easily to
> making a syscall.

so what, how can a gettimeofday syscall can ever help the attacker?

we're talking about x86-64, only purerly readonly syscalls are exported
as vsyscalls, we're not using vsyscalls to run random syscalls, never.

> All systems with non-randomised libc address have this problem at the
> moment, i.e. virtually all systems.  There's just a few that have been
> hardened with the randomised executable and library stuff, and Ulrich
> would like that to be complete, which means the vsyscall page as well.

relocating the vsyscall page is doable anyways, this is not the problem
and it doesn't require any change of API, it doesn't impact the current
API at all.

You simply want a syscall that can relocate the vsyscall page in a
random place of the unused kernel address space. This is perfectly
doable. But it slowsdown the kernel if it has to be per-process as it
will require a tlb flush for every mm switch. So I'd rather do it only
if you can demonstrate that vgettimeofday vtime can ever help an
attacker and I don't see it, allowing an attacker to execute one
specific system
call is not bad, allowing an attacker to execute _any_ system call is
bad instead.

> > furthmore I cannot remotely imagine any difference in terms
> > of security by using a vsyscall table, the only difference to the end
> > user would be that its userspace would be running slower, while right
> > now it's running as fast as the hardware can.
> 
> The vsyscall table discussion has nothing to do with security.

agreed.

> If there's something I missed feel free to ask.

I don't see how can you exploit an application by allowing the attacker
to run vgettimeofday or even gettimeofday if the rest of the userspace
is randomized as claimed. Sure you can try to modify a fixed address,
that you could not reach, this is a slight decrease in security ifff the
userspace is not randomized (as otherwise claimed), but no way to run a
execve or similar bad thing. And the syscall table wouldn't change
anything. you're simply asking for a syscall for relocation of the
vsyscall page, this is similar to what uml needs for revirtaulization
too, and it can be implemented, and it has nothing to do with the actual
API (that would be an extension to the API) or the lack of syscall table
that would only slowdown the userspace.
