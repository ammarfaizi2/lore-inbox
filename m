Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289234AbSANNkV>; Mon, 14 Jan 2002 08:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289236AbSANNkL>; Mon, 14 Jan 2002 08:40:11 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:13575 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289234AbSANNkA>; Mon, 14 Jan 2002 08:40:00 -0500
Date: Mon, 14 Jan 2002 14:39:45 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <yodaiken@fsmlabs.com>, Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16Q6D2-0001aZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201141330350.29208-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Jan 2002, Alan Cox wrote:

> You seem to be missing the fact that latency guarantees only work if you
> can make progress. If a low priority process is pre-empted owning a
> resource (quite likely) then you won't get your good latency. To
> handle those cases you get into priority boosting, and all sorts of lock
> complexity - so that the task that owns the resource temporarily can borrow
> your priority in order that you can make progress at your needed speed.
> That gets horrendously complex, and you get huge chains of priority
> dependancies including hardware level ones.

Any ll approach so far only addresses a single type of latency - the time
from waking up an important process until it really gets the cpu. What is
not handled by any patch are i/o latencies, that means the average time to
get access to a specific resource. (To be exact breaking up locks modifies
of course i/o latencies, but that's more a side effect.)
I/O latencies are only relevant for this discussion insofar, as to verify
they are not overly harmed by improving scheduling latencies. Preempting
does not modify the behaviour of the scheduler, all it does is to increase
the scheduling frequency. This means it can happen that a low priority
task locks a resource for a longer time, because it's interrupted by
another task. Nethertheless the current scheduler guarantees every process
gets its share of the cpu time(*), so the low priority task will continue
and release the resource within a guaranteed amount of time.
So the worst behaviour I see is that on a loaded system, a low priority
task can hold up another task, if that task should be our interactive
task, the interactivity is of course gone. But this problem is not really
new, as we have no guarantees regarding i/o latencies. So everyone using
any patch should be aware of that it's not a magical tool and for getting
better scheduling latencies, one has to trade something else, but so far
I haven't seen any evidence that it makes something else much worse.

(*) This of course assumes accurate cpu time accounting, but I mentioned
this problem before. On the other hand it's also fixable, the tickless
patch looks most interesting in this regard.

bye, Roman

