Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271846AbRH0TPq>; Mon, 27 Aug 2001 15:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271848AbRH0TPh>; Mon, 27 Aug 2001 15:15:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49160 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271846AbRH0TPY>; Mon, 27 Aug 2001 15:15:24 -0400
Subject: Re: Is it bad to have lots of sleeping tasks?
To: frankeh@us.ibm.com
Date: Mon, 27 Aug 2001 20:18:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox @vger.kernel.org),
        ddade@digitalstatecraft.com, linux-kernel@vger.kernel.org
In-Reply-To: <3B8A88B0.FDCC5ACE@watson.ibm.com> from "Hubertus Franke" at Aug 27, 2001 01:51:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bRuB-0004Uc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan is right, I would not be too concerned about the recalculate
> loop. There are patches out that would basically eliminate the
> update of all tasks during recalculate, but they come at an additional
> cost during add_from_runqueue and del_from_runqueue. I don't know
> exactly where the break-even point is where either solution is
> worse of better.

The overhead will be pretty close to zero since the update will be for a
task that is in local cache, so its a tiny bit of math from L1 cache with
writes that don't cause stalls.

> We presented this stuff at OLS and since then have improved the
> low running-thread count scenario.

> The MQ is functionally equivalent to the current scheduler

This is one of the things I think we have wrong although I understand
keeping the behaviour was part of the goal of your code. The scheduler
should be cache optimising for cpu soakers at least. That also seems
to simplify the scheduler not make it more complex.

For example we tend to schedule events badly - consider processes A and B
and are CPU suckers and an editor. Each time you hit a key and wake the
editor you tend to flip between running A and B. 

I'd like to see us end up with an O(1) [for hardware ffz at least] scheduler
that did the right things for cache locality. I've got some ideas but I
don't know how to make them work SMP.

> Alan, could you suggest some benchmarks to run for 2-way systems,
> that have low thread counts, are easily reproducable (no big setup and
> large system configuration required) that would help us make the point
> for a larger set of application then we have targetted.

Lmbench can be useful for small scale numbers, although it isnt intended
currently to measure SMP. Perhaps Larry can comment on that.

We certainly both agree the scheduler needs work

Alan
