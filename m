Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279860AbRKFSCq>; Tue, 6 Nov 2001 13:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279884AbRKFSCf>; Tue, 6 Nov 2001 13:02:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33803 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279860AbRKFSC0>; Tue, 6 Nov 2001 13:02:26 -0500
Date: Tue, 6 Nov 2001 09:59:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161AIX-0001BL-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111060949370.2194-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Nov 2001, Alan Cox wrote:
>
> > Especially on x86 chips.
>
> Well so far I've found one laptop that eats %cr2 on APM calls, and we have
> some mystery cases.

Well, APM is going away, and it should be easy enough to work around it
(and I don't _think_ you can reasonably do the same in ACPI or SMM: SMM
will save the whole CPU state and has to do that anyway, and ACPI doesn't
actually get to touch things like %cr2).

So I'd be more nervous about future CPU's just not having the register
writable (or having only parts of it, or..)

> Peter's suggestion of using %fs or %gs looks more
> promising at the moment

The problem with using a segment register is that then you have to
save/restore it over system calls - pretty much whether the call needs it
or not. Ie you can pretty much _guarantee_ that any system call will be
slowed down by something on the order of 10-15 cycles (on a good day, some
CPU's are slower at it). Same goes for task switch etc.

Which is why I'd much rather just color using the high bits of %esp, and
spend a few more cycles inside "get_current()". I can guarantee you that
it won't slow down paths that don't even need current at all (unlike the
segment register approach), and even the paths that _do_ need current will
only be ~5 cycles slower (plus possible the cache miss of doing the
function call, but the call-site itself will actually be slightly smaller
than the current in-lined 32-bit immediate and "andl").

Using high bits of %esp has zero impact on task-switch, and makes
"get_current" interrupt safe (ie switching tasks is totally atomic, as
it's the one single "movl ..,%esp" instruction that does the real switch
as far as the kernel is concerned).

It does require using an order-2 allocation, which the current VM will
allow anyway, but which is obviously nastier than an order-1.

		Linus

