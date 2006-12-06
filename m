Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937517AbWLFTft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937517AbWLFTft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937503AbWLFTfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:35:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60865 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937339AbWLFTfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:35:47 -0500
Date: Wed, 6 Dec 2006 11:34:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
cc: Christoph Lameter <clameter@sgi.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206192647.GW3013@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0612061130030.3542@woody.osdl.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206192647.GW3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Matthew Wilcox wrote:
> 
> Given parisc's paucity of atomic operations (load-and-zero-32bit and
> load-and-zero-64bit), cmpxchg() is impossible to implement safely.
> There has to be something we can hook to exclude another processor
> modifying the variable.  I'm OK with using atomic_cmpxchg(); we have
> atomic_set locked against it.

How do you to the atomic bitops?

Also, I don't see quite why you think "cmpxchg()" and "atomic_cmpxchg()" 
would be different. ANY cmpxchg() needs to be atomic - if it's not, 
there's no point to the operation at all, since you'd just write it as

	if (*p == x)
		*p = y;

instead, and not use cmpxchg(). 

So yes, architectures without native support (where "native" includes 
load-locked + store-conditional) always need to

 - on UP, just disable interrupts
 - on SMP, use a spinlock (with interrupts disabled), and share that 
   spinlock with all the other atomic ops (bitops at a minimum - the 
   "atomic_t" operations have traditionally been in another "locking 
   space" because of sparc32 historic braindamage, but I'd suggest 
   sharing the same spinlock between them all).

And yeah, it sucks. You _can_ (if you really want to) make the spinlock be 
hashed based on the address of the atomic data structure. That at least 
allows you to do _multiple_ spinlocks, but let's face it, your real 
problem is _likely_ going to be cacheline bouncing, not contention, and 
then using a hashed lock won't be likely to buy you all that much.

		Linus
