Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbTAFBau>; Sun, 5 Jan 2003 20:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbTAFBau>; Sun, 5 Jan 2003 20:30:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26897 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265628AbTAFBat>; Sun, 5 Jan 2003 20:30:49 -0500
Date: Sun, 5 Jan 2003 17:33:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: "David S. Miller" <davem@redhat.com>, <andrew.morton@digeo.com>,
       <linux-kernel@vger.kernel.org>, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
In-Reply-To: <20030105234617.GA4714@averell>
Message-ID: <Pine.LNX.4.44.0301051720420.13313-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Jan 2003, Andi Kleen wrote:
> 
> Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
>                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
> 
> with wrmsr Linux 2.5.54 2.410 3.5600 6.0300 3.9900   34.8 8.59000    43.7
> no wrmsr   Linux 2.5.54 1.270 2.3300 4.7700 2.5100   29.5 4.16000    39.2
> 
> That looks more like between 10%-51%

The lmbench numbers for context switch overhead vary _way_ too much to say
anything at all based on two runs. By all logic the worst-affected case 
should be the 2p/0K case, since the overhead of the wrmsr should be 100% 
constant.

The numbers by Mikael seem to say that the MSR writes are 800 cycles each 
(!) on a P4, so avoiding the CS write would make the overhead about half 
of what it is now (at the cost of making it conditional).

800 cycles in the context switch path is still nasty, I agree. 

> I haven't benchmarked pushfl/popfl, but I cannot imagine it being that 
> slow to offset that. I agree that syscalls are a slightly hotter path than the
> context switch, but hurting one for the other that much looks a bit
> misbalanced.

Note that pushf/popf is a totally different thing, and has nothing to do 
witht he MSR save. 

For pushf/popf, the tradeoff is very clear: you have to either do the 
pushf/popf in the system call path, or you have to do it in the context 
switch path. They are equally expensive in both, but we do a hell of a lot 
more system calls, so it's _obviously_ better to do the pushf/popf in the 
context switch.

The WRMSR thing is much less obvious. Unlike the pushf/popf, the code 
isn't the same, you have two different cases:

 (a) single static wrmsr / CPU

	Change ESP at system call entry and extra jump to common code

 (b) wrmsr each context switch

	System call entry is free.

The thing that makes me like (b) _despite_ the slowdown of context
switching is that the esp reload it made a difference of tens of cycles in
my testing of system calls (which is surprising, I admit - it might be
more than the esp reload, it might be some interaction with jumps right
after a switch to CPL0 causing badness for the pipeline).

Also, (b) allows us to simplify the TF handling (which is _not_ the eflags
issue: the eflags issue is about IOPL) and means that there are no issues
with NMI's and fake temporary stacks.
   
> I can think of some things to speed it up more. e.g. replace all the
> push / pop in SAVE/RESTORE_ALL with sub $frame,%esp ; movl %reg,offset(%esp) 
> and movl offset(%esp),%reg ; addl $frame,%esp. This way the CPU has 
> no dependencies between all the load/store options unlike push/pop.

Last I remember, that only made a difference on Athlons, and Intel CPU's 
have special-case logic for pushes/pops where they follow the value of the 
stack pointer down the chain and break the dependencies (this may also be 
why reloading %esp caused such a problem for the pipeline - if I remember 
correctly the ESP-following can only handle simple add/sub chains).

> (that is what all the code optimization guides recommend and gcc / icc
> do too for saving/restoring of lots of registers) 

It causes bigger code, which is why I don't particularly like it. 
Benchmarks might be interesting.

			Linus




