Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUKOOOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUKOOOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUKOOOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:14:53 -0500
Received: from mail.shareable.org ([81.29.64.88]:9603 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261607AbUKOONB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:13:01 -0500
Date: Mon, 15 Nov 2004 14:12:47 +0000
From: Jamie Lokier <jamie@shareable.org>
To: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu,
       seto.hidetoshi@jp.fujitsu.com
Subject: Re: Futex queue_me/get_user ordering (was: 2.6.10-rc1-mm5 [u])
Message-ID: <20041115141247.GC25502@mail.shareable.org>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <20041114095051.GA11391@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114095051.GA11391@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Sun, Nov 14, 2004 at 09:23:08AM +0000, Jamie Lokier wrote:
> 
> > So I don't know if NPTL is buggy, but the pseudo-code given in the bug
> > report is (because of unconditional wake++), and so is the failure
> > example (because it doesn't use a mutex).
> 
> Please advise if 'Emergency Services''s update to the manpage is correct
> (two levels up this message thread), if so, I can apply it and forward to
> aeb.

'Emergency Services' was me, if that's what you're asking.  I believe
the updates to be correct and I have studied the futex code quite a
lot.

Two more things for the man page.  You wrote:

     To reiterate, bare futexes are not intended as an easy to use
     abstraction for end-users.  Implementors are expected to be
     assembly literate and to have read the sources of the futex
     userspace library referenced below.

I agree they are not intended as an easy to use abstraction.  However,
users do not have to be assembly literate, in the sense that it is
possible to write code using futex which is architecture-indepedent.

For mutexes, architecture-dependent locked bus cycles are used, but
some code which uses futex is written in C using counters.
pthread_cond_signal/wait which started this thread is an example.  So
I suggest a change to read:

     To reiterate, bare futexes are not intended as an easy to use
     abstraction for end-users.  Implementors are expected to
     understand processor memory ordering, barriers and
     synchronisation, and to have read the sources of the futex
     userspace library referenced below.

Secondly, is it appropriate to add Ulrich Drepper's "Futexes Are
Tricky" paper to SEE ALSO?

     "Futexes Are Tricky", Ulrich Drepper, June 2004,
     http://people.redhat.com/drepper/futex.pdf

It's a very interesting paper, worth reading.  But note that Ulrich's
description of the FUTEX_WAIT operation in that paper is *wrong*:

     This means that the operation to wait on a futex is composed of
     getting the lock for the futex, checking the current value, if
     necessary adding the thread to the wait queue, and releasing the lock.

In fact, waiting does not get the lock for the futex.  It relies on
the ordering of (1) adding to the wait queue, (2) checking the current
value, and (3) removing from the wait queue if the value doesn't
match.  Among other things, this is necessary because checking the
current value cannot be done with a spinlock held.

The effect is very similar, but not exactly the same.

-- Jamie
