Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSLQIs5>; Tue, 17 Dec 2002 03:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLQIs5>; Tue, 17 Dec 2002 03:48:57 -0500
Received: from ns.suse.de ([213.95.15.193]:61190 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261894AbSLQIs4>;
	Tue, 17 Dec 2002 03:48:56 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Intel P6 vs P7 system call performance
References: <20021209193649.GC10316@suse.de.suse.lists.linux.kernel> <Pine.LNX.4.44.0212161639310.1623-100000@penguin.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Dec 2002 09:56:20 +0100
In-Reply-To: Linus Torvalds's message of "17 Dec 2002 01:54:31 +0100"
Message-ID: <p73smwxrpl7.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> 
> That NMI problem is pretty fundamentally unfixable due to the stupid
> sysenter semantics, but we could just make the NMI handlers be real
> careful about it and fix it up if it happens.

You just have to make the NMI a task gate with an own TSS, then the 
microcode will set up an own stack for you.

The only issue afterwards is that "current" does not work, but that
can be worked around by being a bit careful in the handler.
It has to run with interrupts off too to avoid a race with an 
timer interrupt which uses current (or alternatively the timer
interrupt could check for the "in nmi condition" - I don't think
any other interrupts access current except when they crash)

[in theory it would be also possible to align the NMI stacks to
8K and put a "pseudo" task into that stack, but it would look
a bit inelegant for me]

Using a task gate would be a good idea for kernel stack faults and
double faults too, then it would be at least possible to get an oops
for them, not the usual double fault.

[x86-64 does it similarly, except that it uses ISTs instead of task
gates and avoids the current problem by using an explicit base register]

I cannot implement SYSENTER for x86-64/32bit emulation, but I think
I can change the vsyscall code to use SYSCALL, not SYSENTER. The only
issue is that I cannot easily use a fixmap to map into 32bit processes,
because the kernel fixmap are way up into the 48bit address space
and not reachable from compatibility mode.
I suspect a similar trick as with the lazy vmallocs - map it in the
page fault handler on demand will work. I hope there won't be much
more of these special cases though, do_page_fault is getting
awfully complicated.

-Andi

