Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268449AbTCFWUY>; Thu, 6 Mar 2003 17:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268452AbTCFWUY>; Thu, 6 Mar 2003 17:20:24 -0500
Received: from [66.78.32.3] ([66.78.32.3]:61606 "EHLO blacksea.bsdns.net")
	by vger.kernel.org with ESMTP id <S268449AbTCFWUV> convert rfc822-to-8bit;
	Thu, 6 Mar 2003 17:20:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Northup <digitale@digitaleric.net>
Reply-To: digitale@digitaleric.net
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Date: Thu, 6 Mar 2003 17:30:39 -0500
User-Agent: KMail/1.4.2
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       <rml@tech9.net>, <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303060931300.7206-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303060931300.7206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303061730.39422.digitale@digitaleric.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - blacksea.bsdns.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - digitaleric.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 March 2003 12:35 pm, Linus Torvalds wrote:
> On 6 Mar 2003, Alan Cox wrote:
> > Not all X servers do that. X is not special in any way. Its just a
> > daemon. It has the same timing properties as many other daemons doing
> > time critical operations for many clients
>
> I really think that this is the most important observation about the
> behaviour. X really isn't doing anything that other deamons don't do. It
> so happens that what X is doing is a lot more complex than most deamons
> do, so it's fairly easy to trigger X into using a fair amount of CPU time,
> but that only makes the breakdown case so much easier to see.
>
> In all honesty, though, it's also obviously the case that the breakdown
> case in the case of X is _really_ visible in a very very concrete way,
> since X is the _only_ thing really "visible" unless you have Direct
> Rendering clients. So even if the problem were to happen with another
> deamon, it probably wouldn't stand out quite as badly. So in that sense X
> ends up having some special characteristics - "visibility".

Yes.  The special thing about X (and XMMS, XINE, et al) is that the 
interactivity heuristic fails in a user-noticeable way.  The heuristic must 
also be guessing incorrectly in other situations, but nobody seems to have 
noticed when it did (or, at least, complained about it).

Another noteworthy attribute of these programs is that they _know_ they will 
be used interactively.  And, if there were a way for them to convey that 
information to the kernel (not by using 'nice'), I bet all of the above 
projects would take advantage of that mechanism.

At first I strongly dissaproved of the kernel's timeslice adjustment by 
interactivity estimation; policy belongs in userland, I thought.  But the 
algorithm is actually quite effective -- a balance between high HZ for 
real-time-ish applications but manages to avoid the cache-thrashing in places 
it would hurt.  This policy works well most of the time, so the kernel 
includes it as a sensible default.  But X demonstrates that sometimes we want 
to set a different policy.  After all, the heuristic will not become perfect, 
and its worst-case behavior is pretty bad.  (If your computers are too fast 
to notice, try turning off cache with /proc/mtrr.  Not be a great idea on an 
important system though...)

The question is: what interface would be used?  A new syscall seems excessive; 
but something in /proc (/proc/xyz/preferred_timeslice ?) is non-optimal, 
because it must not be used in chroot.  I am not qualified to suggest the 
Proper mechanism, but I strongly believe there should be one.

--Eric

