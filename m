Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUBDCaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 21:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbUBDCaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 21:30:16 -0500
Received: from ns.suse.de ([195.135.220.2]:27874 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266220AbUBDCaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 21:30:11 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: johnstul@us.ibm.com, drepper@redhat.com, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com.suse.lists.linux.kernel>
	<401894DA.7000609@redhat.com.suse.lists.linux.kernel>
	<20040201012803.GN26076@dualathlon.random.suse.lists.linux.kernel>
	<401F251C.2090300@redhat.com.suse.lists.linux.kernel>
	<20040203085224.GA15738@mail.shareable.org.suse.lists.linux.kernel>
	<20040203162515.GY26076@dualathlon.random.suse.lists.linux.kernel>
	<20040203173716.GC17895@mail.shareable.org.suse.lists.linux.kernel>
	<20040203181001.GA26076@dualathlon.random.suse.lists.linux.kernel>
	<20040203182310.GA18326@mail.shareable.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Feb 2004 03:27:16 +0100
In-Reply-To: <20040203182310.GA18326@mail.shareable.org.suse.lists.linux.kernel>
Message-ID: <p73znbzlgu3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Andrea Arcangeli wrote:
> > vsyscalls will never execute anything like execve. They can at most
> > modify userspace memory a fixed address, so if the userspace isn't
> > fixed, then nothing can be done with a vsyscall.
> 
> Are we talking about the same x86_64?
> 
> I see this in arch/x86_64/vsyscall.S:
> 
> __kernel_vsyscall:
> .LSTART_vsyscall:
> 	push	%ebp
> .Lpush_ebp:
> 	movl	%ecx, %ebp
> 	syscall
> 
> Is that page not mapped into userspace?

It is. It is needed for the vsyscall fallback for UML (UML cannot
support fixed address vsyscalls) and when we have to disable user
space vgettimeofday for other reasons (e.g. to use alternative time
sources that cannot be mapped to user space or doing time workarounds
that require real locks)

But any security advantages of not having it are at best illusionary.
If you don't believe me just grep any random executable for 
0xf 0x05 (= syscall) or 0xcd 0x80 (= int $0x80). Even if it wasn't 
in the vsyscall page you just have to find these two bytes somewhere
(doesn't have to be an own instruction, they occur commonly as part
of other instructions or data) and jump to them. Executables are
at fixed addresses.

-Andi
