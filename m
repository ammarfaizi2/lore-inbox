Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTLPSW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 13:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLPSW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 13:22:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:32168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261967AbTLPSW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 13:22:56 -0500
Date: Tue, 16 Dec 2003 10:22:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Nick Piggin <piggin@cyberone.com.au>, bill davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [CFT][RFC] HT scheduler
In-Reply-To: <20031214043245.GC21241@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0312161007270.1599@home.osdl.org>
References: <20031213022038.300B22C2C1@lists.samba.org> <3FDAB517.4000309@cyberone.com.au>
 <brgeo7$huv$1@gatekeeper.tmr.com> <3FDBC876.3020603@cyberone.com.au>
 <20031214043245.GC21241@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Dec 2003, Jamie Lokier wrote:

> Nick Piggin wrote:
> > >Shared runqueues sound like a simplification to describe execution units
> > >which have shared resourses and null cost of changing units. You can do
> > >that by having a domain which behaved like that, but a shared runqueue
> > >sounds better because it would eliminate the cost of even considering
> > >moving a process from one sibling to another.
> >
> > You are correct, however it would be a miniscule cost advantage,
> > possibly outweighed by the shared lock, and overhead of more
> > changing of CPUs (I'm sure there would be some cost).
>
> Regarding the overhead of the shared runqueue lock:
>
> Is the "lock" prefix actually required for locking between x86
> siblings which share the same L1 cache?

I bet it is. In a big way.

The lock does two independent things:
 - it tells the core that it can't just crack up the load and store.
 - it also tells other memory ops that they can't re-order around it.

Neither of these have anything to do with the L1 cache.

In short, I'd be very very surprised if you didn't need a "lock" prefix
even between hyperthreaded cores. It might be true in some specific
implementation of HT, but quite frankly I'd doubt it, and I'd be willing
to guarantee that Intel would never make that architectural even if it was
true today (ie it would then break on future versions).

It should be easy enough to test in user space.

[ Time passes ]

Done. Check this program out with and without the "lock ;" prefix. With
the "lock" it will run forever on a HT CPU. Without the lock, it will show
errors pretty much immediately when the two threads start accessing "nr"
concurrently.

		Linus

----
#include <pthread.h>
#include <signal.h>
#include <unistd.h>
#include <stdio.h>

unsigned long nr;

#define LOCK "lock ;"

void * check_bit(int bit)
{
	int set, reset;
	do {
		asm(LOCK "btsl %1,%2; sbbl %0,%0": "=r" (set): "r" (bit), "m" (nr):"memory");
		asm(LOCK "btcl %1,%2; sbbl %0,%0": "=r" (reset): "r" (bit), "m" (nr):"memory");
	} while (reset && !set);
	fprintf(stderr, "bit %d: %d %d (%08x)\n", bit, set, reset, nr);
	return NULL;
}

static void * thread1(void* dummy)
{
	return check_bit(0);
}

static void * thread2(void *dummy)
{
	return check_bit(1);
}

int main(int argc, char ** argv)
{
	pthread_t p;

	pthread_create(&p, NULL, thread1, NULL);
	sleep(1);
	thread2(NULL);
	return 1;
}
