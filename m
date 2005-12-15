Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVLOTJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVLOTJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 14:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVLOTJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 14:09:39 -0500
Received: from science.horizon.com ([192.35.100.1]:23368 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750937AbVLOTJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 14:09:38 -0500
Date: 15 Dec 2005 14:09:37 -0500
Message-ID: <20051215190937.5869.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, torvalds@osdl.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And I can't understand how somebody has the balls to even say that a 
> semaphore isn't a mutex. That's like saying that an object of type "long" 
> isn't an integer, because only "int" objects are integers. That's just 
> INSANE.

I didn't say it isn't a mutex, I said it isn't a GOOD one!

The fundamental reason is that a semaphore doesn't have an owner, and
a mutex does.  And you can do a lot when you know who owns the lock.

>> People are indeed unhappy with the naming, and whether patching 95%
>> of the callers of up() and down() is a good idea is a valid and active
>> subject of debate.  (For an out-of-tree -rt patch, is was certaintly
>> an extremely practical solution.)

> In other words, you are
>  (a) totally making up the claim that people are really unhappy

Huh?  I thought *you* were violently unhappy with the idea of naming
mutex acquire and release down() and up(), and your e-mail is an example
of this unhapiness.

Am I making it up that you are unhappy with usurping the down() and up()
names for mutex use?  If this is you being happy, I'd hate to see
unhappy.

> So tell me, what do you think about your own arguments in that light?

I think they're still completely valid.  Nothing you've said even seems
to address the points I've raised.

>> But regardless of the eventual naming convention, mutexes are a good idea.
>> A mutex is *safer* than a counting semaphore.  That's the main benefit.
>> Indeed, unless there's a performance advantage to a counting semaphore,
>> you should use a mutex!

> Hey, feel free to introduce a mutex, but DAMMIT, just call it that, 
> instead of switching people over. 

As I said, as long as the -rt patch was not in the main tree, taking
advantage of the fact that 95% of the down() and up() callers just want
a mutex was a sensible implementation tradeoff.  For merging it into the
tree, it's ugly, and people don't like that.  The -rt folks have gotten
used to their naming perversions and so don't feel as much repugnance.

> And even then, it should damn well also:
>  - really _be_ faster. On platforms that matter. 
>  - have enough real other advantages that it's worth introducing another 
>    abstraction, and more conceptual complexity. At least the RT patches 
>    had a reason for them.

Agreed.  A mutex that's slower than a counting semaphore needs to be
dragged out behind the wodshed and strangled.  If you can't do
any better, it can just *be* a counting semaphore.

> And besides, all your "safer" arguments are pretty damn pointless in the 
> face of the fact that we have basically had zero bugs with the semaphores. 
> This is not where the bugs happen. Yeah, yeah, double releases can happen, 
> but it sure as hell isn't on my radar of things I remember people doing.

There haven't been problems with the semaphore *implementation*, but
people screw up and deadlock themselves often enough.  I sure remember
double-acquire lockups.  Forgive me if I don't grep the archives, but
I remember people showing code paths that led to them.

Admittedly, lock *ordering* problems are the most common deadlock
situtation but hey, guess what!  Priority inheritance code can be
extended to notice that, too.  (There's a performance hit, so it'd
be a debug option.)

But all of this requires that a lock have an identifiable owner, which
is something hat a mutex has and a semaphore fundamentally doesn't.

> So when you say "This isn't about speed, this is about bug-free code", 
> you're just making that up.
>
> It's doubly silly when your "safer" 
> implementation uses totally illogical names. THAT is what creates bugs.

If you want to argue about names, go discuss gay marriage.

I don't care what it's *called*.  I care that we have stronger
conditions that we can test for correctness.

> So go away.
> 
> Come back if you have pondered, and accepted reality, and perhaps have an 
> acceptable patch that introduces a separate data structure. 

Ha!  I still say you're wrong, and I'm not going to fold over an obvious
technical point just because of flaming.

Are we having some communication problems?  I find it hard to believe
that you're actually this *stupid*, but we might not be talking about
the same thing.

I took your posting to say that

a) Using the names "struct semaphore", "up()" and "down()" for a mutex
   is monumentally brain-dead.  I'm not arguing, although I understand
   the pragmatic reasons for the original abuse of notation.

b) There is no need for a mutex implementation, because a semaphore can
   do anything that a mutex can.  Here, I absolutely disagree.  There
   are things you can do with a mutex that you CANNOT do with a
   general semaphore, because a mutex has stronger invariants.

   A counting semaphore can do MOST of what a mutex does, and is
   demonstrably close enough for a lot of uses.

> And no, we're not switching users over whole-sale.  First you introduce the 
> new concept.  Only THEN can you can switch over INDIVIDUAL LOCKS with 
> reasons for why it's worth it.

Given that 95% of callers are using it as mutex, you're making this 20
times more work than necessary.  Convert 'em all and change the 5%
that need the counting back.

> And hell yes, performance does matter.

I'm not arguing, but this seems to be at odds with your earlier statement:
>>> Dammit, unless the pure mutex has a _huge_ performance advantage on major 
>>> architectures, we're not changing it.

There is obviously no reason to accept a performance *decrease*, but
any potential performance *increase* is unimportant and incidental.

Which is exactly what I said:
>> Indeed, unless there's a performance advantage to a counting semaphore,
>> you should use a mutex!
