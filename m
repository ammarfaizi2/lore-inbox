Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbTAEJ63>; Sun, 5 Jan 2003 04:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTAEJ63>; Sun, 5 Jan 2003 04:58:29 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:55262 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264639AbTAEJ61>; Sun, 5 Jan 2003 04:58:27 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davem@redhat.com, andrew.morton@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
References: <3E17AC67.43923E08@digeo.com>
	<Pine.LNX.4.44.0301041952110.1651-100000@home.transmeta.com>
From: Andi Kleen <ak@muc.de>
Date: 05 Jan 2003 11:06:47 +0100
In-Reply-To: <Pine.LNX.4.44.0301041952110.1651-100000@home.transmeta.com>
Message-ID: <m3k7hjq5ag.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 4 Jan 2003, Andrew Morton wrote:
> > > 
> > > Hmm.. The backup patch doesn't handle single-stepping correctly: the
> > > eflags cleanup singlestep patch later in the sysenter sequence _depends_
> > > on the stack (and thus thread) being right on the very first in-kernel
> > > instruction.
> > 
> > Well that's just a straight `patch -R' of the patch which added the wrmsr's.
> 
> Yes, but the breakage comes laterr when a subsequent patch in the 
> 2.5.53->54 stuff started depending on the stack location being stable even 
> on the first instruction.

Regarding the EFLAGS handling: why can't you just do 
a pushfl in the vsyscall page before pushing the 6th arg on the stack
and a popfl afterwards. 

Then the syscall entry in kernel code could just do

        pushfl $fixed_eflags
        popfl 

The first popl for the 6th arg in the vsyscall page wouldn't be traced 
then, but I doubt that is a problem.

Would add a few cycles to the entry path, but then it is better than
having slow context switch.

This would also eliminate the random IOPL problem Luca noticed.
BTW I think I have the same issue on x86-64 with SYSCALL (random IOPL
in kernel), but so far nothing broke, so it is probably not a big
problem.

> 
> > > It doesn't show up on lmbench (insufficient precision), but your AIM9
> > > numbers are quite interesting. Are they stable?
> > 
> > Seem to be, but more work is needed, including oprofiling.  Andi is doing
> > some P4 testing at present.
> 
> Ok.

Here are the numbers from a Dual 2.4Ghz Xeon. The first is plain 
2.5.54, the second is with the WRMSR-in-switch-to patch backed out.
Also 2.4.18-aa for co

Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw

oenone     Linux 2.5.54 2.410 3.5600 6.0300 3.9900   34.8 8.59000    43.7
oenone     Linux 2.5.54 1.270 2.3300 4.7700 2.5100   29.5 4.16000    39.2


If that is true the slowdown would be nearly 50% for the 2p case.
That looks a bit much, I wonder if lmbench is very accurate here
(do we have some other context switch benchmark to double check?)
but all numbers show a significant slowdown.

-Andi
