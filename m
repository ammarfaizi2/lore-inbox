Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316462AbSEUAbq>; Mon, 20 May 2002 20:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316463AbSEUAbp>; Mon, 20 May 2002 20:31:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27143 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316462AbSEUAbo>;
	Mon, 20 May 2002 20:31:44 -0400
Date: Tue, 21 May 2002 01:31:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c rewrite for better locking
Message-ID: <20020521013143.G20755@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <3CE01FC9.5000107@us.ibm.com> <20020513213638.F10287@parcelfarce.linux.theplanet.co.uk> <3CE9369D.50802@us.ibm.com> <20020520200807.A20755@parcelfarce.linux.theplanet.co.uk> <3CE967A6.9050107@us.ibm.com> <20020520223750.D20755@parcelfarce.linux.theplanet.co.uk> <3CE97C0D.7010500@us.ibm.com> <20020521000540.F20755@parcelfarce.linux.theplanet.co.uk> <3CE98A04.5040107@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 04:43:00PM -0700, Dave Hansen wrote:
> With the current layout of data structures, finely grained locking 
> will be a pain.  There will continue to be a need for these locks:
> 1. 1 for each of the 2 global lists
> 2. a lock for each inode's lock list
> 3. a lock (or refcount) for every single lock, because it could be 
> referenced from either the inode's list OR the global lists.

I don't believe #3 is necessary.  At any given point in a lock's
existence, it's:

(a) blocking on an active lock (attached to its blocking lock through
    fl_block, attached to the list of blocked locks through fl_link,
    and pointing at its blocking lock with fl_next)
(b) an active lock (attached to any locks blocking on it through
    fl_block, attached to the list of global locks through fl_link and
    pointing at the next active lock with fl_next).

So I can't see the need for a reference count.  We always know where
it's referenced from and what its lifecycle is.  I'm not surprised
you're confused though -- locks.c is still a mess.  I think I've got
some improvements, but I'm waiting for OSDL to give me access to a quad
CPU machine to test on.

> OR, a single global lock for everything (which I don't like)

I prefer a single global lock.  Yes, it will be held for longer than
necessary if you had a per-inode lock, but it doesn't bloat struct inode
any more than it currently is.  Also, there's never a lock inversion
issue, which I believe the algorithm you describe below has.

Insert lock is grab inode-file-lock for write, grab global-file-lock for write,
insert lock, release both.
Display locks is grab global-file-lock for read, grab inode-file-lock for
read, display information, release both.

so insert grabs inode lock, display grabs global lock, insert spins
waiting for exclusive access, display spins waiting for the exclusive
access to be released.  Boom.

>    That's why I want to change the global lock list storage to use the 
> already existing per-inode lists.  I want a file_lock_list to be a 
> list of inodes that have locks outstanding on them.  This global list 
> of inodes will need race protection as will the per-inode flock list. 
>   The print_lock_info thing (whatever it's called) will look something 
> like this:
> 
> read_lock( global_flock_list )
> for each inode with locks {
> 	read_lock( inode->flock_list_lock )
> 	for each flock on inode {
> 		print stuff for this lock
> 	}
> 	read_unlock( inode->flock_list_lock )
> }
> read_unlock( global_flock_list )
> 
> 
> >>inode_list fl_inode_list* head;
> >>Is the use of blocked_list just an optimization?  Could 
> >>posix_locks_deadlock theoretically go through all of the locks (from 
> >>the global list) and ignore the ones that aren't posix and aren't 
> >>blocking?
> > 
> > Theoretically, yes, because that's what the code used to do ;-)
> > That was really ugly code, though.  Not to mention that it's an O(n^2)
> > algorithm, which you really don't want to do while holding a global lock.
> > It's still O(n^2), but at least I reduced the size of N to the number
> > of tasks currently waiting for a lock.  (Actually, it used to be O(n^3)
> > because it was written badly.  But we'll skip over that.)
> 
> Since this will only require a read lock, it should be significantly 
> less costly than when the BKL was held.  Also, we're dealing with 
> quite small numbers here, or we wouldn't be using linked lists.  If 
> optimization is needed, perhaps the global-inodes-with-locks-on-them 
> list can be supplemented with a 
> global-inodes-with-locks-blocking-on-them list too.  However, I don't 
> like the looks of it and I think that to do it cleanly, it will be 
> necessary to add _another_ per-inode list for the blocked locks.  This 
> approach is starting to sound way too complex.

The cost will still be high.  The N in the approach you want to take
is roughly the number of locks existing in the system (each lock has
to be checked to see whether any lock is currently blocking on it).
The N in the current approach is the number of locks which are currently
blocking in the system.  Since a task can only be blocking on one lock,
this is the number of tasks in the system currently blocking on a lock.
I think you underestimate how big a difference this really is.

Typically, there are maybe 8 processes blocked on locks (those apache
children using it as a mutex ;-).  O(N^2) for this case is O(64).
If we're talking about a system which is big enough that this kind of
lock scalability makes a difference, there must be thousands of locks
being taken and released every second.  O(N^2) would be O(1000000),
with a global lock held -- 15000 times longer!

-- 
Revolutions do not require corporate support.
