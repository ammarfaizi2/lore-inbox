Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbRGLJpS>; Thu, 12 Jul 2001 05:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267460AbRGLJpI>; Thu, 12 Jul 2001 05:45:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:40516 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267458AbRGLJo7>; Thu, 12 Jul 2001 05:44:59 -0400
Date: Thu, 12 Jul 2001 11:45:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: lvm-devel@sistina.com, Andi Kleen <ak@suse.de>
Cc: Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010712114512.J779@athlon.random>
In-Reply-To: <3B4C8263.6000407@switchmanagement.com> <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com> <20010712043046.R3496@athlon.random> <20010712112613.A14134@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010712112613.A14134@gruyere.muc.suse.de>; from ak@suse.de on Thu, Jul 12, 2001 at 11:26:13AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 11:26:13AM +0200, Andi Kleen wrote:
> On Thu, Jul 12, 2001 at 04:30:46AM +0200, Andrea Arcangeli wrote:
> > I will soon somehow make those changes in the lvm (based on beta7) in my
> > tree and it will be interesting to see if this will make a difference. I
> > will also have a look to see if I can improve a little more the lvm_map
> > but other than those non rw semaphores there should be not a significant
					 ^ both
> > overhead to remove in the lvm fast path.
> 
> Even if you fix the snapshot_sem you still have the down on the _pe_lock 
> in lvm_map. The part covered by the PE lock is only a few tenths of cycles
> shorter than the part covered by the snapshot semaphore; so it is unlikely
> that you see much difference unless you change both to rwsems.

See the above 's', plural, in case it was not obious I meant "all the
semaphores in the fast path", not just one, of course doing just one
would been nearly useless.

Both semaphore_S_ are just converted to rwsem in 2.4.7pre6aa1 so the
fast path *cannot* block any longer in my current tree.

> Wouldn't a single semaphore be enough BTW to cover both? 

Actually the _pe_lock is global and it's hold for a short time so it
can make some sense. And if you look closely you'll see that _pe_lock
should _definitely_ be a rw_spinlock not a rw_semaphore. I didn't
changed that though just to keep the patch smaller and to avoid changing
the semantics of the lock, the only thing that matters for us is to
never block and to have a fast read fast path which is provided just
fine by the rwsem (i'll left the s/sem/spinlock/ to the CVS).

Andrea
