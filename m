Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbRCFXkj>; Tue, 6 Mar 2001 18:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbRCFXkT>; Tue, 6 Mar 2001 18:40:19 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:25862 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129679AbRCFXkQ>; Tue, 6 Mar 2001 18:40:16 -0500
Date: Tue, 6 Mar 2001 23:39:17 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Jonathan Lahr <lahr@sequent.com>
cc: Anton Blanchard <anton@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kernel lock contention and scalability
In-Reply-To: <20010306144552.G6451@w-lahr.des.sequent.com>
Message-ID: <Pine.LNX.4.10.10103062318190.26554-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Jonathan Lahr wrote:

[ sorry to reply over another reply, but I don't have
  the original of this ]

> > Tridge and I tried out the postgresql benchmark you used here and this
> > contention is due to a bug in postgres. From a quick strace, we found
> > the threads do a load of select(0, NULL, NULL, NULL, {0,0}).

I can shed some light on this (though I'm far from a PG hacker).

Postgres can use either of two locking methods -- SysV semaphores
(which it tries to avoid, asusming that they'll be too heavy) or
userspace spinlocks (via inline assembler on platforms which support
it).

In the slow path of a spinlock_acquire they busy wait for a few
cycles, and then call schedule with a zero timeout assuming that
it'll basically do the same as a sched_yield() but more portably.

Matthew.

