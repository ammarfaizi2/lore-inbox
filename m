Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbVLWXtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbVLWXtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 18:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbVLWXtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 18:49:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24205 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161139AbVLWXtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 18:49:05 -0500
Date: Fri, 23 Dec 2005 17:48:58 -0600
From: Robin Holt <holt@sgi.com>
To: Olof Johansson <olof@lixom.net>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
Message-ID: <20051223234858.GA31945@lnx-holt.americas.sgi.com>
References: <20051223163816.GA30906@sgi.com> <20051223204822.GC24601@pb15.lixom.net> <20051223213216.GA29541@sgi.com> <20051223215915.GE24601@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223215915.GE24601@pb15.lixom.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 03:59:16PM -0600, Olof Johansson wrote:
> On Fri, Dec 23, 2005 at 03:32:16PM -0600, Jack Steiner wrote:
> 
> > On IA64, the "sync" instructions are actually part of the ld.acq ot st.rel
> > instructions that are used to set/clear spinlocks.
> [...]
> > IA64 implements fencing of ld.acq or st.rel instructions as one-directional
> > barriers.
> 
> So ia64 spin_unlock doesn't do store-store ordering across it. I'm
> surprised this is the first time this causes problems. Other architectures
> seem to order:
> 
> * sparc64 does a membar StoreStore|LoadStore
> * powerpc does lwsync or sync, depending on arch
> * alpha does an mb();
> 
> * x86 is in-order
> 
> So, sounds to me like you need to fix your lock primitives, not add
> barriers to generic code?

I don't think this is a case which is handled by the typical lock
primitives.  Here we essentially have two things being unlocked in
close succession.  The first is the wait queue, the second the futex_q.

There is nothing in the typical unlock path which would require unlocks
to be ordered with respect to each other.  However, in this case, the
futex_q expects to finish processing the wake_up_all before releasing
the lock_ptr.  That is a requirement of wake_futex and not the locking
primitives.  If wake_futex() requires it, then it should be responsible
for enforcing that requirement.

I suppose a step in the right direction would be doing a volatile store
to q->lock_ptr.  I haven't looked, but that should at least prevent the
clearing of lock_ptr until the wait queue is unlocked.

Jack, can you repeat your testing with a cast on the q->lock_ptr line to
a volatile.  After looking at it some more, shouldn't the struct futex_q{}
definition for the spinlock_t *lock_ptr be volatile?


Thanks,
Robin Holt
