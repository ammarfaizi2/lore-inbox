Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276190AbRI1Rdu>; Fri, 28 Sep 2001 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276191AbRI1Rdk>; Fri, 28 Sep 2001 13:33:40 -0400
Received: from chiara.elte.hu ([157.181.150.200]:35599 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276190AbRI1RdY>;
	Fri, 28 Sep 2001 13:33:24 -0400
Date: Fri, 28 Sep 2001 19:31:27 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <kuznet@ms2.inr.ac.ru>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>, <bcrl@redhat.com>, <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <200109281704.VAA04444@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0109281904200.8840-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:

> > have been processed. [the jiffy test is not completely accurate
>
> It is. The break is forced not earlier than after one jiffie, but
> it may loop for up to 2 jiffies.

(you are right. it does jiffies - start_time > 1. good.)

> > there is nothing sacred about the old method of processing NET_RX_SOFTIRQ,
> > then NET_TX_SOFTIRQ, then breaking out of do_softirq() (the mechanizm was
> > a bit more complex than that, but in insignificant ways). It's just as
> > arbitrary as 10 loops - with the difference that 10 loops perform better.
>
> Do not cheat yourself. 10 is more than 1 by order of magnitude.
> I would eat this argument if the limit was 2. :-)

what are you trying to argue, that it's incorrect to re-process softirqs
if they got activated during the previous pass? I told a number of
fundamental reasons why it's a good idea to loop, tell me one not to do
so, on a 'healthy' system.

(Lets assume that a loop of 10 still ensures basic safety in situations
where external load overloads the system. I will tell you that not even a
loop of 1 ensures safety, unless one tweaks the softirq handlers
themselves (netdev_max_backlog) to do less and less work per interrupt.
Is your point to make the softirq loop to be sysctl-tunable? I can sure
show you slow enough systems which can be overloaded via hardirqs alone.)

> Please, explain who exactly obtains an advantage of looping.

I think the technically most reasonable approach is to process softirqs
*as soon as possible*, without context switches, for obvious performance
reasons. They are called 'interrupts' after all. Or do we want to delegate
hardware interrupts to process contexts as well?

interrupts, in most cases, are 'replies to a request'. It's a pair of
code: the first part issues the work, then comes the completion of work.
Processes are usually the entities that 'issue' work, interrupts/softirqs
are the ones that complete it. It's conceptually the right thing to
complete work that was started.

Softirq work is something that has to be executed sooner or later, in a
healthy system. I prefer 'sooner' to 'later'. I prefer delaying current
contexts instead of buffering work - executing current contexts will
likely only increase the amount of work that has to be done in the future.

the only reason why the loop is not endless is reliability: weaker
systems, wich can be overloaded over external interfaces need some
protection against endless softirq loops. I measured 10 to be something
pretty close to a loop of 10000.

i prefer my system to go near its peak performance, and i do not want to
suffer from any 'safety measure' until it's absolutely necessery. and if
it's absolutely necessery i prefer to design the safety measure in a way
to make fast enough systems still go fast. Not the other way around.

please point out flaws in this thinking.

	Ingo

