Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318542AbSHPQ0c>; Fri, 16 Aug 2002 12:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318546AbSHPQ0c>; Fri, 16 Aug 2002 12:26:32 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:30434 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318542AbSHPQ0a>; Fri, 16 Aug 2002 12:26:30 -0400
Date: Fri, 16 Aug 2002 17:30:13 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
Message-ID: <20020816173013.A858@kushida.apsleyroad.org>
References: <20020816151911.A590@kushida.apsleyroad.org> <Pine.LNX.4.44.0208161639150.29243-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208161639150.29243-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Aug 16, 2002 at 04:48:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> there are some practical problems with making the notification a futex,
> not a simple flag. Eg. futexes right now do not force any lock-counter
> format upon userspace. Futexes can be used as mutexes, conditional
> variables, read-write locks, all of which have different atomic counter
> formats and uses.

Agreed; futexes are lovely because they are so generic.

> By doing the TID-release notification via a futex the actual format of
> the lock is forced, which is a cleanliness problem. Just writing $0 to
> the TID pointer is a robust thing on the other hand.

Quite.  There is no lock; the the futex is used in its purest form, as
a wait queue.

      TID  = thread is alive
      zero = thread is gone

There's no "lock-counter format", because this isn't a lock -- it's a
wakeup.  There no need for atomicity either, because the listener only
reads, it doesn't write.  I'm not sure if a PROT_SEM word is required
for cache coherency, but if it is, your current implementation requires
one too.

Here's a synchronous thread_join-style waiter; it is architecture-neutral:

	while (tid = *tid_address) != 0)
		retval = sys_futex (tid_address, FUTEX_WAIT, tid, 0);

-- Jamie
