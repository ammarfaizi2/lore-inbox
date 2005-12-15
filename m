Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVLOTwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVLOTwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVLOTwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:52:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750996AbVLOTwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:52:11 -0500
Date: Thu, 15 Dec 2005 11:52:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux@horizon.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <20051215190937.5869.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0512151141480.3292@g5.osdl.org>
References: <20051215190937.5869.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Dec 2005, linux@horizon.com wrote:
> 
> Huh?  I thought *you* were violently unhappy with the idea of naming
> mutex acquire and release down() and up(), and your e-mail is an example
> of this unhapiness.

Ahh, I thought you were considering naming unhappiness to be a reason
_for_ the mutex change.

down() and up() aren't the traditional names for the operations, P()/V()
are, and I thought you were arguing that some people might dislike the
_current_ naming.

> There haven't been problems with the semaphore *implementation*, but
> people screw up and deadlock themselves often enough.  I sure remember
> double-acquire lockups.  Forgive me if I don't grep the archives, but
> I remember people showing code paths that led to them.

Double aquires certainly occasionally happen, but they are (assuming it's 
a real double aquire, and not a race due to lock ordering) easy to see, 
since it just hangs the process and you get a traceback and find it.

But mutexes don't help either. A mutex will hang exactly the same way, 
with exactly the same behaviour, and aren't any easier to debug (as 
mentioned, a hung semaphore isn't exactly hard to debug).

Or maybe you're talking about a _recursive_ mutex, which is something that 
actually has totally different semantics. We've discussed adding them, but 
pretty much every time it was the result of some really really bad locking 
design, so at least so far we've instead decided to bite the bullet and 
fix the locking.

So yes, recursive mutexes can be easier to use, but they really do allow 
(and thus indirectly encourage) bad locking. So I'm not convinced we want 
one.

> But all of this requires that a lock have an identifiable owner, which
> is something hat a mutex has and a semaphore fundamentally doesn't.

Actually, we've certainly had semaphore debugging patches which consider 
the last person who successfully got a semaphore to be the "owner".

Sure, it's not well-defined for the generic semaphore case, but so what? 
In the generic case, you can't use mutexes anyway. For _debugging_ 
ownership as in "who got this lock last" is still useful. I know I've 
cooked up trivial patches to do that when I was trying to figure out a 
lock ordering bug.

Google is your friend. Just try "semaphore owner debug", and the #2 hit is 
a patch that does exactly that for Linux.

> I don't care what it's *called*.  I care that we have stronger
> conditions that we can test for correctness.

Hey, if so, please don't encourage the current patch. 

We can certainly add a new lockign mechanism, I'm just not at all 
convinced that it's warranted. I certainly disagree with you that using 
semaphores would somehow be less easy to test for correctness.

		Linus
