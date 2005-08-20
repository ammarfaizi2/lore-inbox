Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932759AbVHTSiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759AbVHTSiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 14:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbVHTSiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 14:38:14 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:56845 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932759AbVHTSiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 14:38:14 -0400
Message-ID: <4307788E.1040209@symas.com>
Date: Sat, 20 Aug 2005 11:38:06 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050810 SeaMonkey/1.0a
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() makes OpenLDAP slow
References: <4D8eT-4rg-31@gated-at.bofh.it> <4306A176.3090907@shaw.ca> <4306AF26.3030106@yahoo.com.au>
In-Reply-To: <4306AF26.3030106@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
>  Robert Hancock wrote:
> > I fail to see how sched_yield is going to be very helpful in this
> > situation. Since that call can sleep from a range of time ranging
> > from zero to a long time, it's going to give unpredictable results.

>  Well, not sleep technically, but yield the CPU for some undefined
>  amount of time.

Since the slapd server was not written to run in realtime, nor is it 
commonly run on realtime operating systems, I don't believe predictable 
timing here is a criteria we care about. One could say the same of 
sigsuspend() by the way - it can pause a process for a range of time 
ranging from zero to a long time. Should we tell application writers not 
to use this function either, regardless of whether the developer thinks 
they have a good reason to use it?

> > It seems to me that this sort of thing is why we have POSIX pthread
> > synchronization primitives.. sched_yield is basically there for a
> > process to indicate that "what I'm doing doesn't matter much, let
> > other stuff run". Any other use of it generally constitutes some
> > kind of hack.

In terms of transaction recovery, we do an exponential backoff on the 
retries, because our benchmarks showed that under heavy lock contention, 
immediate retries only made things worse. In fact, having arbitrarily 
long backoff delays here was shown to improve transaction throughput. 
(We use select() with an increasing timeval in combination with the 
yield() call. One way or another we get a longer delay as desired.)

sched_yield is there for a *thread* to indicate "what I'm doing doesn't 
matter much, let other stuff run."

I suppose it may be a hack. But then so is TCP congestion control. In 
both cases, empirical evidence indicates the hack is worthwhile. If you 
haven't done the analysis then you're in no position to deny the value 
of the approach.

>  In SCHED_OTHER mode, you're right, sched_yield is basically
>  meaningless.

>  In a realtime system, there is a very well defined and probably
>  useful behaviour.

>  Eg. If 2 SCHED_FIFO processes are running at the same priority, One
>  can call sched_yield to deterministically give the CPU to the other
>  guy.

Well yes, the point of a realtime system is to provide deterministic 
response times to unpredictable input.

I'll note that we removed a number of the yield calls (that were in 
OpenLDAP 2.2) for the 2.3 release, because I found that they were 
redundant and causing unnecessary delays. My own test system is running 
on a Linux 2.6.12.3 kernel (installed over a SuSE 9.2 x86_64 distro), 
and OpenLDAP 2.3 runs perfectly well here, now that those redundant 
calls have been removed. But I also found that I needed to add a new 
yield(), to work around yet another unexpected issue on this system - we 
have a number of threads waiting on a condition variable, and the thread 
holding the mutex signals the var, unlocks the mutex, and then 
immediately relocks it. The expectation here is that upon unlocking the 
mutex, the calling thread would block while some waiting thread (that 
just got signaled) would get to run. In fact what happened is that the 
calling thread unlocked and relocked the mutex without allowing any of 
the waiting threads to run. In this case the only solution was to insert 
a yield() after the mutex_unlock(). So again, for those of you claiming 
"oh, all you need to do is use a condition variable or any of the other 
POSIX synchronization primitives" - yes, that's a nice theory, but 
reality says otherwise.

To say that sched_yield is basically meaningless is far overstating your 
point.
-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

