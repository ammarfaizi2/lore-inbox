Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSHOK2K>; Thu, 15 Aug 2002 06:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316677AbSHOK2K>; Thu, 15 Aug 2002 06:28:10 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:13278 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316675AbSHOK2J>; Thu, 15 Aug 2002 06:28:09 -0400
Date: Thu, 15 Aug 2002 11:31:48 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
Message-ID: <20020815113148.A28398@kushida.apsleyroad.org>
References: <20020815050343.A27963@kushida.apsleyroad.org> <Pine.LNX.4.44.0208150837510.2197-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208150837510.2197-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Aug 15, 2002 at 08:45:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > I wonder if it makes more sense for the release word to be a futex --
> > then various ways of actually waiting for the stack are available.
> 
> the window for locking is really small (and will always be small), so it's
> cheaper for the fastpath to implement this as a spinlock, with the
> stack-user being the lock holder.

I'm thinking that any _clean_ threading library (pthreads or not)
should do these two things:

   - intercept all the system calls that might call mmput(); that is,
     exit() and execve()), just so it can move the thread-specific data
     (including the stack) onto the "potentially free list".

   - free the stack memory as soon as possible after a thread has died,
     _without_ depending on garbage collection.  What if all the other
     threads are compute-bound?  There's a lump of unnecessary stack
     taking up memory for an indefinite time.

It seems that you're using a futex anyway -- so why not eliminate that
pesky system call _and_ make sure pthread_join() work if some library
you're linked to exits without calling pthread_exit()..

-- Jamie
