Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVLPBdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVLPBdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVLPBdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:33:35 -0500
Received: from science.horizon.com ([192.35.100.1]:38716 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751202AbVLPBdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:33:35 -0500
Date: 15 Dec 2005 20:33:27 -0500
Message-ID: <20051216013327.18923.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, torvalds@osdl.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512151141480.3292@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahh, I thought you were considering naming unhappiness to be a reason
> _for_ the mutex change.

Good gods, no.  The best mnemonics for P() and V() I've ever seen
were in the Amiga which called them Procure() and Vacate(), but the
names still suck mightily.

> Double aquires certainly occasionally happen, but they are (assuming it's 
> a real double aquire, and not a race due to lock ordering) easy to see, 
> since it just hangs the process and you get a traceback and find it.

Ah, now we get to the valid point.

> But mutexes don't help either. A mutex will hang exactly the same way, 
> with exactly the same behaviour, and aren't any easier to debug (as 
> mentioned, a hung semaphore isn't exactly hard to debug).

Well, a mutex can detect it immediately, rather than via a timeout,
but that's a matter of a few seconds, and the vast majority of the
evidence you want is frozen by the deadlock itself.

> So yes, recursive mutexes can be easier to use, but they really do allow 
> (and thus indirectly encourage) bad locking. So I'm not convinced we want 
> one.

Agreed.  Maybe someone will someday find an application where there's
really no way around it, but avoiding the need is generally better
design.

>> But all of this requires that a lock have an identifiable owner, which
>> is something hat a mutex has and a semaphore fundamentally doesn't.

> Actually, we've certainly had semaphore debugging patches which consider 
> the last person who successfully got a semaphore to be the "owner".
> 
> Sure, it's not well-defined for the generic semaphore case, but so what? 

An excellent point.  As long as it's only used for post-mortem debugging,
and not to verify invariants at run-time, you can keep track of
"who would be the woner if this were a mutex".

>> I don't care what it's *called*.  I care that we have stronger
>> conditions that we can test for correctness.

> Hey, if so, please don't encourage the current patch. 
>
> We can certainly add a new locking mechanism, I'm just not at all 
> convinced that it's warranted. I certainly disagree with you that using 
> semaphores would somehow be less easy to test for correctness.

Let's go through what you lose if you give up a known lock owner and
just use something probabilistic....

Detecting deadlocks - can be done immediately and definitively with
a lock owner, and only via timeouts without.  Still, not a deal-breaker.

Multi-lock deadlocks - same, although the detection code is
more complex so probably shouldn't be enabled all the time.

Double-release: can be instantly detected with a known mutex, but will
produce really odd misbehaviour with a semaphore.  Still, you're quite
right that failing to release on a failure path is by far the more
common bug.

Priority inheritance.  This is the original reason that the -rt patch
implemented mutexes, and requires accurate lock owner information.
Not having it is a show-stopper here.

Source documentation.  This is more a style thing, but I really
like putting as much information into the source as possible.
(If comments worked, we wouldn't need sparse.)  

So the latter two are the only really good reasons.  Still, I think
they're persuasive.

Can anyone think of any other benefits?
