Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVLPMA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVLPMA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVLPMA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:00:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52195 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932208AbVLPMAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:00:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <43A08D50.30707@yahoo.com.au> 
References: <43A08D50.30707@yahoo.com.au>  <439FFF63.6020105@yahoo.com.au> <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> <15157.1134560767@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 16 Dec 2005 12:00:38 +0000
Message-ID: <12832.1134734438@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> I was under the impression that with cmpxchg, you don't need the mutex lock.
> If you do then sure, cmpxchg doesn't buy you anything (even if the arch does
> natively support it).

Consider the slow path...

Imagine the mutex has three states: 0 (unset), 1 (held), 3 (contention).

	MUTEX	PROCESS A	PROCESS B	PROCESS C
	======	==============	==============	==============
	1,B,-
	1,B,-	-->mutex_lock()
	1,B,-	cmpxchg(0,1) [failed]
	1,B,-	-->__mutex_lock()
	1,B,-			-->mutex_unlock()
	1,B,-			cmpxchg(1,0) [success]
	0,-,-			<--mutex_unlock()
	0,-,-	spin_lock
	0,-,A	cmpxchg(0,1) [success]
	1,A,A	spin_unlock
	1,A,-	<--__mutex_lock()
	1,A,-	<--mutex_lock()

Or:

	MUTEX	PROCESS A	PROCESS B	PROCESS C
	======	==============	==============	==============	
	1,B,-
	1,B,-	-->mutex_lock()
	1,B,-	cmpxchg(0,1) [failed]
	1,B,-	-->__mutex_lock()
	1,B,-	spin_lock
	1,B,A	cmpxchg(0,1) [failed]
	1,B,A			-->mutex_unlock()
	1,B,A			cmpxchg(1,0) [success]
	0,-,A			<--mutex_unlock()
	0,-,A	cmpxchg(1,3) [failed]
	0,-,A	cmpxchg(0,1) [success]
	1,A,A	spin_unlock
	1,A,-	<--__mutex_lock()
	1,A,-	<--mutex_lock()

Or:

	MUTEX	PROCESS A	PROCESS B	PROCESS C
	======	==============	==============	==============
	1,B,-
	1,B,-	-->mutex_lock()
	1,B,-	cmpxchg(0,1) [failed]
	1,B,-	-->__mutex_lock()
	1,B,-	spin_lock
	1,B,A	cmpxchg(0,1) [failed]
	1,B,A			-->mutex_unlock()
	1,B,A			cmpxchg(1,0) [success]
	0,-,A			<--mutex_unlock()
	0,-,A	cmpxchg(1,3) [failed]
	0,-,A					-->mutex_lock()
	0,-,A					cmpxchg(0,1) [success]
	1,C,A					<--mutex_lock()
	1,C,A	cmpxchg(0,1) [failed]
	1,C,A	cmpxchg(1,3) [success]
	3,A,A	spin_unlock
	3,A,-	<--__mutex_lock()
	3,A,-	<--mutex_lock()

See how many cmpxchgs you may end up doing? Now imagine that cmpxchg() is
implemented as:

	spin_lock_irqsave(&common_lock[N], flags);
	actual = *state;
	if (actual == old)
		*state = new;
	spin_unlock_irqrestore(&common_lock[N], flags);

Now my point about using LL/SC is that:

	1,C,A	cmpxchg(0,1) [failed]
	1,C,A	cmpxchg(1,3) [success]
	3,C,A	...

Can be turned into:

	1,C,A	x = LL()
	1,C,A	x |= 2;
	1,C,A	SC(3) [success]
	3,C,A	...

On x86 you could use:

	1,C,A	LOCK OR (2)
	3,C,A	...

instead.

Now, contention isn't very likely, so using CMPXCHG _may_ be good enough _if_
you have it. But if you have to emulate it by using spinlocks, you're far
better off just wrapping the entire thing in spinlocks and not pretending use
atomic ops to access the counter; unless, of course, you have somthing that
can do a 1-bit XCHG or better...

	MUTEX	PROCESS A	PROCESS B	PROCESS C
	======	==============	==============	==============
	0,-,-			-->mutex_lock()
	0,-,-			xchg(1) == 0
	1,B,-			<--mutex_lock()
	1,B,-
	1,B,-	-->mutex_lock()
	1,B,-	xchg(1) == 1
	1,B,-	-->__mutex_lock()
	1,B,-			-->mutex_unlock()
	1,B,B			spin_lock
	1,B,B			set(0)
	0,-,B			spin_unlock
	0,-,-			<--mutex_unlock()
	0,-,-	spin_lock
	0,-,A	xchg(1) == 0
	1,A,A	spin_unlock
	1,A,-	<--__mutex_lock()
	1,A,-	<--mutex_lock()

mutex_unlock() should get the spinlock here before modifying the count,
because if there's anything on the queue, it should wake up the first waiter
rather than clearing the count.

David
