Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSLQQsp>; Tue, 17 Dec 2002 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbSLQQsp>; Tue, 17 Dec 2002 11:48:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29450 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264771AbSLQQsn>; Tue, 17 Dec 2002 11:48:43 -0500
Date: Tue, 17 Dec 2002 08:57:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: mingo@elte.hu, <linux-kernel@vger.kernel.org>, <davej@suse.de>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <p73smwxrpl7.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0212170850250.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 Dec 2002, Andi Kleen wrote:
>
> Linus Torvalds <torvalds@transmeta.com> writes:
> >
> > That NMI problem is pretty fundamentally unfixable due to the stupid
> > sysenter semantics, but we could just make the NMI handlers be real
> > careful about it and fix it up if it happens.
>
> You just have to make the NMI a task gate with an own TSS, then the
> microcode will set up an own stack for you.

Actually, I came up with a much simpler solution (which I didn't yet
implement, but should be just a few lines).

The simpler solution is to just make the temporary ESP stack _look_ like
it's a real process - ie make it 8kB per CPU (instead of the current 4kB)
and put a fake "thread_info" at the bottom of it with the right CPU
number etc. That way if an NMI comes in (in the _extremely_ tiny window),
it will still see a sane picture of the system. It will basically think
that we had a micro-task-switch between two instructions.

It's also entirely possible that the NMI window may not actually even
exist, since I'm not even sure that Intel checks for pending interrupt
before the first instruction of a trap handler.

> Using a task gate would be a good idea for kernel stack faults and
> double faults too, then it would be at least possible to get an oops
> for them, not the usual double fault.

We can't get stack faults without degrading performance horribly (they
require you to set up the stack segment in magic ways that gcc doesn't
even support). For double-faults, yes, but quite frankly, if you ever get
a double fault things are _so_ screwed up that it's not very funny any
more.

> I cannot implement SYSENTER for x86-64/32bit emulation, but I think
> I can change the vsyscall code to use SYSCALL, not SYSENTER.

Right. The point of my patches is that user-level really _cannot_ use
sysenter directly, because the sysenter semantics are just not useful for
user land. So as far as user land is concerned, it really _is_ just a
"call 0xfffff000", and then the kernel can do whatever is appropriate for
that CPU.

		Linus

