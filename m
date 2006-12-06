Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937560AbWLFTl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937560AbWLFTl4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937561AbWLFTl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:41:56 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:43634 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937435AbWLFTly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:41:54 -0500
Date: Wed, 6 Dec 2006 12:41:53 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206194153.GZ3013@parisc-linux.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206192647.GW3013@parisc-linux.org> <Pine.LNX.4.64.0612061130030.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061130030.3542@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 11:34:52AM -0800, Linus Torvalds wrote:
> On Wed, 6 Dec 2006, Matthew Wilcox wrote:
> > Given parisc's paucity of atomic operations (load-and-zero-32bit and
> > load-and-zero-64bit), cmpxchg() is impossible to implement safely.
> > There has to be something we can hook to exclude another processor
> > modifying the variable.  I'm OK with using atomic_cmpxchg(); we have
> > atomic_set locked against it.
> 
> How do you to the atomic bitops?

The same way we do atomic_t.

What I hadn't realised (because I hadn't read dhowell's implementation
... because it hasn't shown up on git2.kernel.org yet) is that he
doesn't actually *use* this unlocked-assignment that would cause the
problem.  He uses bitops which use the same locks.

> Also, I don't see quite why you think "cmpxchg()" and "atomic_cmpxchg()" 
> would be different. ANY cmpxchg() needs to be atomic - if it's not, 
> there's no point to the operation at all, since you'd just write it as
> 
> 	if (*p == x)
> 		*p = y;
> 
> instead, and not use cmpxchg(). 

The difference is that we can (and do) acquire a lock for atomic_set.
We can't acquire one for X = 6.

>  - on SMP, use a spinlock (with interrupts disabled), and share that 
>    spinlock with all the other atomic ops (bitops at a minimum - the 
>    "atomic_t" operations have traditionally been in another "locking 
>    space" because of sparc32 historic braindamage, but I'd suggest 
>    sharing the same spinlock between them all).

Yep, we agree.

> And yeah, it sucks. You _can_ (if you really want to) make the spinlock be 
> hashed based on the address of the atomic data structure. That at least 
> allows you to do _multiple_ spinlocks, but let's face it, your real 
> problem is _likely_ going to be cacheline bouncing, not contention, and 
> then using a hashed lock won't be likely to buy you all that much.

We do hash based on the address -- and we try to arrange things such
that different spinlocks are acquired for different cachelines.  I don't
know if anyone's benchmarked it recently to see how well it performs.
It's a bit of a waltzing bear [1] at times ;-)

[1] The wonder is not how well it waltzes, but that it waltzes at all
