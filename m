Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTKMMNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 07:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbTKMMNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 07:13:24 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27403 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263913AbTKMMNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 07:13:19 -0500
Date: Thu, 13 Nov 2003 07:02:30 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: So, Poll is not scalable... what to do?
In-Reply-To: <3FB2D656.60008@cyberone.com.au>
Message-ID: <Pine.LNX.3.96.1031113065637.23748B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Nick Piggin wrote:

> 
> 
> Davide Libenzi wrote:
> 
> >On 12 Nov 2003, bill davidsen wrote:
> >
> >
> >>In article <20031112053207.GA9634@alpha.home.local>,
> >>Willy Tarreau  <willy@w.ods.org> wrote:
> >>| On Tue, Nov 11, 2003 at 05:52:42PM -0600, kirk bae wrote:
> >>| > If poll is not scalable, which method should I use when writing 
> >>| > multithreaded socket server?
> >>| 
> >>| Honnestly, if you're using threads (I mean lots of threads, such as one
> >>| per connection), I don't think that poll performance will be your worst
> >>| ennemy. The first thing to do is to handle the task switching yourself
> >>| either with a publicly available coroutine library or with one of your own.
> >>
> >>It's not clear that with 2.6 this is necessary or desirable. I'll let
> >>someone who worked on the new thread and/or futex development say more
> >>if they will, but I'm reasonable convinced that in most cases the kernel
> >>will do it better.
> >>
> >
> >Pros & Cons:
> >
> >*) Coroutines cost is basically its stack (8-16Kb). Threads there's a 
> >little bit more under the hood
> >
> >*) No locks at all with coroutines
> >
> >*) Coroutine context switch time was about 20 times faster last time I 
> >tried. I used this:
> >
> 
> According to lmbench, 2.4 does a context switch in 0.67us (on one type
> of uniprocessor cpu - the machines at osdl). 2.6.0-test9 manages 1.17us
> (174% longer). I have some patches that brings this to 0.80us (119%).
> This is with 2 active tasks, so O(1) doesn't get to show its advantage.

It would seem that in the case of many sockets that there is still a need
to determine when to run a coroutine. Using pthreads and NPTL lets the
kernel do that by unblocking the thread, handles SMP cases, etc. And is
source code portable.

On the other hand, I'm sure that with enough effort some solution-specific
code could do better, assuming that there's nothing else in the machine.
And depending on the base hardware and the computation involved, there
could be a big win with SMP of the HT flavor.

I think any problem like this is an "it depends" case, but the assumption
that polling doesn't scale is a good starting point.

> 
> If you remove the realtime priority array (disable RT scheduling support)
> you could probably drop this figure below 2.4's. I should get some numbers
> 
> Perhaps if there is demand I could make RT scheduling a config option in
> my patchset. I think Andrea does something fancy like that. I'll have to
> take a look at his code.
> 
> 
> That said, I'd be inclined to think an application that it context switch
> bound is broken by design. Although maybe there are some special cases.
> 
> 
> 2.4: http://khack.osdl.org/stp/282982/results/summary_report
> 2.6: http://khack.osdl.org/stp/282354/results/summary_report
> np:  http://khack.osdl.org/stp/283054/results/summary_report
> 
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

