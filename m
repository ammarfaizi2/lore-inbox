Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbTAESt0>; Sun, 5 Jan 2003 13:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTAESt0>; Sun, 5 Jan 2003 13:49:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3596 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264975AbTAEStO>; Sun, 5 Jan 2003 13:49:14 -0500
Date: Sun, 5 Jan 2003 10:51:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: davem@redhat.com, <andrew.morton@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
In-Reply-To: <m3k7hjq5ag.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0301051040020.11848-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Jan 2003, Andi Kleen wrote:
> 
> Regarding the EFLAGS handling: why can't you just do 
> a pushfl in the vsyscall page before pushing the 6th arg on the stack
> and a popfl afterwards. 

I did that originally, but timings from Jamie convinced me that it's 
actually a quite noticeable overhead for the system call path.

You should realize that the 5-9% slowdown in schedule (which I don't like)  
comes with a 360% speedup on a P4 in simple system call handling (which I
_do_ like). My P4 does a system call in 428 cycles as opposed to 1568
cycles according to my benchmarks.

And part of the reason for the huge speedup is that the vsyscall/sysenter
path is actually pretty much the fastest possible. Yes, it would have been
faster just from using sysenter/sysexit, but not by 360%. The other
speedups come from not reloading segment registers multiple times
(noticeable on a PIII, not a P4) and from avoiding things liek the flags
pushing.

NOTE! We could trivially speed up the task switching by making 
"load_esp0()" a bit smarter. Right now it actually re-writes _both_ 
SYSENTER_CS and SYSENTER_ESP on a taskswitch, and that's because a process 
that was in vm86 mode will have cleared SYSENTER_CS (so that sysenter will 
cause a GP fault inside vm86 mode).

Now, that SYSENTER_CS thing is very rare indeed, and by keeping track of 
what the previous value was (ie just caching the SYSENTER_CS value in the 
thread_struct), we could get rid of it with a conditional jump instead. 
Want to try it?

> This would also eliminate the random IOPL problem Luca noticed.

Nope, it wouldn't. A "popfl" in user mode does nothing for iopl. You have 
to have the popfl in kernel mode.

			Linus

