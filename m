Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135777AbRDTBfv>; Thu, 19 Apr 2001 21:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135776AbRDTBfl>; Thu, 19 Apr 2001 21:35:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61830 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135775AbRDTBf0>;
	Thu, 19 Apr 2001 21:35:26 -0400
Date: Thu, 19 Apr 2001 21:35:02 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ulrich Drepper <drepper@cygnus.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <m34rvkzewj.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.GSO.4.21.0104192044300.19860-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Apr 2001, Ulrich Drepper wrote:

> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > I'm not interested in re-creating the idiocies of Sys IPC.
> 
> I'm not talking about sysv semaphores (couldn't care less).  And you
> haven't read any of the mails with examples I sent.
> 
> If the new interface can be useful for anything it must allow to
> implement process-shared POSIX mutexes.

Pardon me the bluntness, but... Why?
	* on _any_ UNIX we can implement semaphore (object that has Dijkstra's
P and V operations, whatever) shared by processes that have access to pipe.
In a portable way. That's the part of pipe semantics that had been there
since way before v6. Pre-sysv, pre-POSIX, etc. When named pipes appeared
the same semantics had been carried to them. Agreed so far?
	* if we have shared memory _and_ some implementation of semaphores
we can (on architectures that allow atomic_dec() and atomic_inc()) produce
semaphores that work via memory access in uncontended case and use slow
semaphores to handle contention side of the business. Nothing UNIX-specific
here.
	* such objects _are_ useful. They are reasonably portable and
if they fit the task at hand and are cheaper than POSIX mutexes - that's
all rationale one could need for using them.

Sure, the variant I've posted was intra-process only, simply because it
uses normal pipes. Implementation with named pipes is also trivial -
when you map the shared area, allocate private one of the corresponding
size and keep descriptors there. End of story.

AFAICS mechanism is portable enough (and even on the architectures that
do not allow atomic userland operations we can survive - just fall back
to "slow" ones via read()/write() on pipes).  And excuse me, but when
one writes an application code the question is not "how to make it use
POSIX semaphores", it's "how to get the serialization I need in a
portable way".

