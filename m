Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261902AbRE2Acy>; Mon, 28 May 2001 20:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261903AbRE2Aco>; Mon, 28 May 2001 20:32:44 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:6662 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261902AbRE2Aca>;
	Mon, 28 May 2001 20:32:30 -0400
Date: Tue, 29 May 2001 02:32:23 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Kurt Roeckx <Q@ping.be>
Cc: Russell King <rmk@arm.linux.org.uk>, Vadim Lebedev <vlebedev@aplio.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel
Message-ID: <20010529023222.C6061@pcep-jamie.cern.ch>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> <20010529001256.F9203@flint.arm.linux.org.uk> <20010529013030.A3381@ping.be> <20010529014635.A3499@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010529014635.A3499@ping.be>; from Q@ping.be on Tue, May 29, 2001 at 01:46:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Roeckx wrote:
> You should never "return" from userspace to kernelspace.  The
> only way to go from user space to kernel space should be by using
> a system call.

That does actually happen on x86.  The kernel puts a small code fragment
called the "trampoline" on the user mode stack, which is run when the
signal handler returns if it does a normal return.

The trampoline does the system call "sigreturn", and in there the kernel
restores the state of the user mode stack, before returning to user space.

It is possible to avoid the sigreturn system call by setting the
sa_restorer field, and I don't know why Glibc 2.2 doesn't do this.

By the way, the context stored on the stack is entirely a user space
context, however it does include some information from the kernel that
may be useful to user space, such as a page fault address.

If the user space signal handler mucks with the context on its stack,
all that happens is that "sigreturn" will end up restoring a different
user space context and continuing execution with that.  If you set
context.eip to the address of the kernel's panic() function, than the
user space program will simply crash with a SIGSEGV immediately after
"sigreturn" returns to user space.

Mucking with the context in a signal handler is even useful occasionally.

enjoy,
-- Jamie
