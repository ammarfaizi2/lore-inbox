Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284887AbRLFAPs>; Wed, 5 Dec 2001 19:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284886AbRLFAP2>; Wed, 5 Dec 2001 19:15:28 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:526 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284879AbRLFAPV>; Wed, 5 Dec 2001 19:15:21 -0500
Date: Wed, 5 Dec 2001 16:26:21 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler Cleanup
In-Reply-To: <20011205154618.B24407@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.40.0112051619480.1644-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Mike Kravetz wrote:

> On Wed, Dec 05, 2001 at 03:44:42PM -0800, Davide Libenzi wrote:
> > Anyway me too have verified an increased latency with sched_yield() test
> > and next days I'm going to try the real one with the cycle counter
> > sampler.
> > I've a suspect, but i've to see the disassembly of schedule() before
> > talking :)
>
> One thing to note is that possible acquisition of the runqueue
> lock was reintroduced in sys_sched_yield().  From looking at
> the code, it seems the purpose was to ?add fairness? in the case
> of multiple yielders.  Is that correct Ingo?

Yep, suppose you've three running tasks A, B and C ( in that order ) and
suppose A and B are yield()ing.
You get:

A B A B A B A B A B A ...

until the priority of A or B drops, then C has a chance to execute.
Since with the new counter decay code priority remains up until a sudden
drop, why don't we decrease counter by K ( 1? ) for each sched_yield() call ?
In this way we can easily avoid the above pattern in case of multiple
yield()ers.



PS: sched_yield() code is very important because it is used inside the
pthread spinlock() wait path for a bunch of times before falling into
usleep().



- Davide



