Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTAEXiD>; Sun, 5 Jan 2003 18:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbTAEXiD>; Sun, 5 Jan 2003 18:38:03 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:13478 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265446AbTAEXiC>; Sun, 5 Jan 2003 18:38:02 -0500
Date: Mon, 6 Jan 2003 00:46:17 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, davem@redhat.com, andrew.morton@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
Message-ID: <20030105234617.GA4714@averell>
References: <m3k7hjq5ag.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0301051040020.11848-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301051040020.11848-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 07:51:44PM +0100, Linus Torvalds wrote:
> 
> On 5 Jan 2003, Andi Kleen wrote:
> > 
> > Regarding the EFLAGS handling: why can't you just do 
> > a pushfl in the vsyscall page before pushing the 6th arg on the stack
> > and a popfl afterwards. 
> 
> I did that originally, but timings from Jamie convinced me that it's 
> actually a quite noticeable overhead for the system call path.
> 
> You should realize that the 5-9% slowdown in schedule (which I don't like)  
> comes with a 360% speedup on a P4 in simple system call handling (which I
> _do_ like). My P4 does a system call in 428 cycles as opposed to 1568
> cycles according to my benchmarks.

According to my benchmarks the slowdown on context switch is a lot 
more than 5-9% on P4:

Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw

with wrmsr Linux 2.5.54 2.410 3.5600 6.0300 3.9900   34.8 8.59000    43.7
no wrmsr   Linux 2.5.54 1.270 2.3300 4.7700 2.5100   29.5 4.16000    39.2

That looks more like between 10%-51%

[Note I don't trust the numbers completely, the slowdown looks a bit too
extreme especially for the 16p case. But it is clear that it is a lot
slower]

I haven't benchmarked pushfl/popfl, but I cannot imagine it being that 
slow to offset that. I agree that syscalls are a slightly hotter path than the
context switch, but hurting one for the other that much looks a bit
misbalanced.


> 
> And part of the reason for the huge speedup is that the vsyscall/sysenter
> path is actually pretty much the fastest possible. Yes, it would have been

I can think of some things to speed it up more. e.g. replace all the
push / pop in SAVE/RESTORE_ALL with sub $frame,%esp ; movl %reg,offset(%esp) 
and movl offset(%esp),%reg ; addl $frame,%esp. This way the CPU has 
no dependencies between all the load/store options unlike push/pop.

(that is what all the code optimization guides recommend and gcc / icc
do too for saving/restoring of lots of registers) 

Perhaps that would offset a pushfl / popfl in kernel mode, may be worth 
a try.

-Andi


P.S.: For me it is actually good if the i386 context switch is slow.
On x86-64 I have some ugly wrmsrs in the context switch for the 
64bit segment base rewriting too and slowing down i386 like this will
make the 64bit kernel look better compared to 32bit ;););)

