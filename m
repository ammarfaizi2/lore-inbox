Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUBDCkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 21:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUBDCkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 21:40:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50564
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266247AbUBDCko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 21:40:44 -0500
Date: Wed, 4 Feb 2004 03:40:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, johnstul@us.ibm.com,
       drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040204024042.GE26076@dualathlon.random>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com.suse.lists.linux.kernel> <401894DA.7000609@redhat.com.suse.lists.linux.kernel> <20040201012803.GN26076@dualathlon.random.suse.lists.linux.kernel> <401F251C.2090300@redhat.com.suse.lists.linux.kernel> <20040203085224.GA15738@mail.shareable.org.suse.lists.linux.kernel> <20040203162515.GY26076@dualathlon.random.suse.lists.linux.kernel> <20040203173716.GC17895@mail.shareable.org.suse.lists.linux.kernel> <20040203181001.GA26076@dualathlon.random.suse.lists.linux.kernel> <20040203182310.GA18326@mail.shareable.org.suse.lists.linux.kernel> <p73znbzlgu3.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73znbzlgu3.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 03:27:16AM +0100, Andi Kleen wrote:
> Jamie Lokier <jamie@shareable.org> writes:
> 
> > Andrea Arcangeli wrote:
> > > vsyscalls will never execute anything like execve. They can at most
> > > modify userspace memory a fixed address, so if the userspace isn't
> > > fixed, then nothing can be done with a vsyscall.
> > 
> > Are we talking about the same x86_64?
> > 
> > I see this in arch/x86_64/vsyscall.S:
> > 
> > __kernel_vsyscall:
> > .LSTART_vsyscall:
> > 	push	%ebp
> > .Lpush_ebp:
> > 	movl	%ecx, %ebp
> > 	syscall
> > 
> > Is that page not mapped into userspace?
> 
> It is. It is needed for the vsyscall fallback for UML (UML cannot
> support fixed address vsyscalls) and when we have to disable user
> space vgettimeofday for other reasons (e.g. to use alternative time
> sources that cannot be mapped to user space or doing time workarounds
> that require real locks)

the fallback in gettimeofday which may be needed in some system would
require a syscall instruction at fixed address too indeed (however in
most systems that is not necessary so the uml fallback seems to be the
one inserting the syscall instruction in common hardware).

> But any security advantages of not having it are at best illusionary.
> If you don't believe me just grep any random executable for 
> 0xf 0x05 (= syscall) or 0xcd 0x80 (= int $0x80). Even if it wasn't 
> in the vsyscall page you just have to find these two bytes somewhere
> (doesn't have to be an own instruction, they occur commonly as part
> of other instructions or data) and jump to them. Executables are
> at fixed addresses.

agreed.

And if they really want to relocate the vsyscall page, it's possible to
implement with a new syscall without having to slowdown or change the
API. We simply need to change the pte during context switch, but it will
force some invlpg at every context switch. I agree it doesn't worth as
far as the executable is the same on all systems.
