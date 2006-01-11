Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWAKRpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWAKRpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWAKRpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:45:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:39587 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932375AbWAKRpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:45:11 -0500
Message-ID: <43C5440F.2060503@austin.ibm.com>
Date: Wed, 11 Jan 2006 11:44:47 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Olof Johansson <olof@lixom.net>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PowerPC fastpaths for mutex subsystem
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net> <43BFFF1D.7030007@austin.ibm.com> <20060108094839.GA16887@elte.hu> <43C435B9.5080409@austin.ibm.com> <20060110230917.GA25285@elte.hu>
In-Reply-To: <20060110230917.GA25285@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ok. I'll really need to look at "vmstat" output from these. We could 
> easily make the mutex slowpath behave like ppc64 semaphores, via the 
> attached (untested) patch, but i really think it's the wrong thing to 
> do, because it overloads the system with runnable tasks in an 
> essentially unlimited fashion [== overscheduling] - they'll all contend 
> for the same single mutex.
> 
> in synthetic workloads on idle systems it such overscheduling can help, 
> because the 'luck factor' of the 'thundering herd' of tasks can generate 
> a higher total throughput - at the expense of system efficiency. At 8 
> CPUs i already measured a net performance loss at 3 tasks! So i think 
> the current 'at most 2 tasks runnable' approach of mutexes is the right 
> one on a broad range of hardware.
> 
> still, i'll try a different patch tomorrow, to keep the number of 'in 
> flight' tasks within a certain limit (say at 2) - i suspect that would 
> close the performance gap too, on this test.

The fundamental problem is that there is a relatively major latency to wake 
somebody up, and for them to actually run so they can acquire a lock.  In an 
ideal world there would always be a single waiter running trying to acquire the 
lock at the moment it was unlocked and not running until then.

There are better solutions than just madly throwing more waiters in flight on an 
unlock.  Here's three possibilities off the top of my head:

1) It is possible to have a hybrid lock that spins a single waiting thread and 
sleeps waiters 2..n, so there is always a waiter running trying to acquire the 
lock.  It solves the latency problem if the lock is held a length of time at 
least as long as it takes to wake up the next waiter.  But the spinning waiter 
burns some cpu to buy the decreased latency.

2) You could also do the classic spin for awhile and then sleep method.  This 
essentially turns low latency locks into spinlocks but still sleeps locks which 
are held longer and/or are much more contested.

3) There is the option to look at cpu idleness of the current cpu and spin or 
sleep based on that.

4) Accept that we have a cpu efficient high latency lock and use it appropriately.

I'm not saying any of these 4 is what we should do.  I'm just trying to say 
there are options out there that don't involve thundering hurds and luck to 
address the problem.
