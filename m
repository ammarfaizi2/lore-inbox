Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270050AbRIHQDz>; Sat, 8 Sep 2001 12:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269971AbRIHQDq>; Sat, 8 Sep 2001 12:03:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:56644 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269967AbRIHQD3>; Sat, 8 Sep 2001 12:03:29 -0400
Date: Sat, 8 Sep 2001 18:04:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: Re: expand_stack fix [was Re: 2.4.9aa3]
Message-ID: <20010908180416.Z11329@athlon.random>
In-Reply-To: <20010903172445.N699@athlon.random> <Pine.LNX.4.33.0109071142060.10472-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109071142060.10472-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Sep 07, 2001 at 11:47:09AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2001 at 11:47:09AM -0700, Linus Torvalds wrote:
> 
> On Mon, 3 Sep 2001, Andrea Arcangeli wrote:
> >
> > Linus please include the attached patch to the next kernel, expand_stack
> > is totally broken at the moment, we cannot mess with the mm vma layout
> > if we don't hold the mmap_sem in write mode.
> 
> I disagree with the diagnosis..
> 
> expand_stack() has _never_ messed with the vma layout, and never should.
> As such, from a vma list integrity standpoint it is fine.
> 
> Do we mess with the contents? Yes. But I'd much rather see a much more
> minimal approach to the problem, on the order of:
>  - make sure we only accept GROWSDOWN for anonymous areas (which don't
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    care about the offset)
>  - make the vm_start update atomic (possibly by just getting the pagetable
>    spinlock).

We just take the pagetable spinlock there, the race is all about the
pgoff.

In short you agree that the current locking is broken but you propose to
limit the usability of GROWSDOWN and GROWSUP solely to the anonymous
vmas instead of fixing the pgoff race with proper locking as I did.

My fix for the race doesn't drop the usability of GROWSDOWN that could
otherwise break userspace programs. I guess at least uml uses growsdown
vma file backed. Jeff?

Assuming it's acceptable to break GROWSDOWN on file backed vmas as you
suggested, the new locking rules with your approch would be:

1)	pgoff is garbage as usual for any anon vma so don't even try to
	mess with it in expand_stack
2)	with only the read semaphore acquired the vm_start/vm_end of the
	vmas can expand under us but the vma tree not
3)	with only the read semaphore acquired to get a consistent
	vm_start/vm_end of all vmas in the tree (like we need to in
	expand_stack) also the page_table_lock of the mm must be
	acquired
4)	with the write lock vm_start/vm_end are consistent always as
	well as tree so no change here

> > I considered implementing a read->write semaphore upgrade primitive but
> > it cannot be reliable
> 
> There is no such thing. Never has been. It's a fundamentally impossible
> operation. We may, at some point, decide to have a "read_for_write()" and

Yes, of course with "it cannot be reliable" I meant it cannot work out
always, it would be an optimization for the common case:

	spin_lock(&rwsem->lock)
	if (only one reader)
		gain write privilegies
		err = success
	else
		err = faliure
	spin_unlock(&rwsem->lock)

	return err

it would still require the fail path in case of the faliure (multiple
readers potentially all trying to upgrade the lock) so I ignored the
optimization (expand_stack isn't a very fast path anyways).

> However, having a finer-granularity spinlock _inside_ the semaphore (see
> above suggestion) is a perfectly valid approach.

if you are 100% sure it's acceptable to break the kernel API for the
GROWSDOWN file backed vmas (which I don't think it's the case) I can
switch to your suggested fix (otherwise I prefer to keep upgrading the
semaphore in expand_stack rather to have to spinlocking at every nopage
private/shared page fault).

Andrea
