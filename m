Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbTBCQvf>; Mon, 3 Feb 2003 11:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbTBCQvf>; Mon, 3 Feb 2003 11:51:35 -0500
Received: from [195.223.140.107] ([195.223.140.107]:30340 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266859AbTBCQvb>;
	Mon, 3 Feb 2003 11:51:31 -0500
Date: Mon, 3 Feb 2003 18:00:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4, 2.5: SMP race: __sync_single_inode vs. __mark_inode_dirty
Message-ID: <20030203170031.GV8395@dualathlon.random>
References: <Pine.LNX.4.44.0302022203560.1545-300000@artax.karlin.mff.cuni.cz> <20030202160656.52349e3a.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202160656.52349e3a.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 04:06:56PM -0800, Andrew Morton wrote:
> Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
> >
> > Hi.
> > 
> > there's a SMP race condition between __sync_single_inode (or __sync_one on
> > 2.4.20) and __mark_inode_dirty. __mark_inode_dirty doesn't take inode
> > spinlock. As we know -- unless you take a spinlock or use barrier,
> > processor can change order of instructions.
> > 
> 
> Looks good to me, although my understanding of these memory ordering issues

the 2.5 patch yes, the 2.4 one not.

> is woeful.
> 
> We do want to avoid taking inode_lock in mark_inode_dirty() - that is called
> very frequently.  I'm rather surprised that inode_lock contention has not
> been a problem thus far.

we can usually optimize away those mark_inode_dirty() calls in the
caller in a smp safe way, by checking if the inode has just the same
atime/mtime that we're going to overwrite (and by skipping the write in
such case obviously).

So I'm not sure if it worth that much to avoid the spinlock, the memory
barriers remains a viable alternative.

However my main concern is that Mikulas's 2.4 patch is buggy, the sync
path he implemented is this:

        inode->i_state &= ~I_DIRTY;
+
+       smp_rmb(); /* mark_inode_dirty doesn't take spinlock, make sure   
+               that inode is not read speculatively by this cpu
+               before &= ~I_DIRTY  -- mikulas */
+
        spin_unlock(&inode_lock);


and this mean the i_state write can be pass the smp_rmb() and in turn
this race could still happen this way:

					spin_lock()
					read inode->i_state into register
					(for the later inode->i_state &= ~I_DIRTY write)
					smp_rmb()

	make changes
	mark_inode_dirty
	smp_mb()

	i_state still dirty so return


					inode->i_state &= ~I_DIRTY;
					spin_unlock

					/* no smp_rmb anymore so it
					 * won't see the other cpu data despite
					 * the other side did smp_mb */

and the race will happen again, just in a different way than the one
described so far. So the patch is a noop.

The patch would been correct if he put the smp_rmb() _after_ the
spin_unlock of the sync path (not before), because that way he would
rely on the inode->i_state &= ~I_DIRTY not passing the smp_rmb() because
of the implicit one-way memory barrier of the spinlock that avoids the
critical section to pass the spin_unlock.

So IMHO this is the correct fix:

	spin_lock
	inode->i_state &= ~I_DIRTY;
	spin_unlock
	smp_rmb

this way if the mark_inode_dirty sees I_DIRTY set after the smp_mb(), it
is guaranteed the sync path will also see the data-updates after
clearing I_DIRTY.

and really I'm unsure if it worth to depend on the implicit one-way
inclusive semantics of spin_unlock (rather than doing a more clear
smp_mb(), it's more a documentation theorical most-finegrined possible
implementation/exercise than anything pratical), but it should be safe,
unless some arch implements very big magics in spinlocks, normally the
magic is to have the barrier to work one-way only and that's fine with
us, all we care about is that the I_DIRTY doesn't get past the
smp_rmb(), we don't care if writes after smp_rmb() are executed before
the 'inode->i_state &= ~I_DIRTY;'. This is why the above is enough.
Certainly it's ok for all the archs I know of (ia64 with its smart
finegrined one-way barriers in the spinlocks included). And if some arch
isn't ok with it we'd like to know early since it could break other
places too.

The 2.5 patch was ok because the write_lock/write_unlock before the spin_unlock are
equivalent to a full smp_mb() (not a smp_rmb!) between inode->i_state &=
~I_DIRTY and spin_unlock, and the smp_mb() after clearing i_state is
more than enough, it doesn't matter if it happens before or after the
spin_unlock. The smp_rmb instead has to go only _after_ spin_unlock so
it needs the other half of wmb semantics provided by the spin_unlock to
be safe.

> Longer-term we should probably turn i_state into a ulong and only run
> atomic bitops against it.

that would be wasteful as far as we take the inode_lock anyways to
list_move. And a fast-path test_bit would require the smb_mb anyways, in
asm it won't be different from the current not-bitops code at all. I
don't see any obvious advantage in practice.

I attached my 2.4 fix that should be correct:

--- 2.4.21pre4aa1/fs/inode.c.~1~	2003-01-31 02:38:47.000000000 +0100
+++ 2.4.21pre4aa1/fs/inode.c	2003-02-03 17:48:25.000000000 +0100
@@ -199,6 +199,9 @@ void __mark_inode_dirty(struct inode *in
 			sb->s_op->dirty_inode(inode);
 	}
 
+	/* make sure that changes are seen by all cpus before we test i_state */
+	smp_mb();
+
 	/* avoid the locking if we can */
 	if ((inode->i_state & flags) == flags)
 		return;
@@ -273,6 +276,23 @@ static inline void __sync_one(struct ino
 	inode->i_state &= ~I_DIRTY;
 	spin_unlock(&inode_lock);
 
+	/*
+	 * mark_inode_dirty() doesn't take spinlock, make sure
+	 * that the data is not read speculatively by this cpu
+	 * before &= ~I_DIRTY is flushed to ram.
+	 *
+	 * We depend on the inode->i_state &= ~I_DIRTY not passing
+	 * the smp_rmb() because of the implicit one-way memory
+	 * barrier of the spinlock that avoids the critical section
+	 * to pass the spin_unlock(). Shall this dependency break
+	 * (i.e. if the spin_unlock goes away), this has to be
+	 * converted to a smp_mb() (note: if I_DIRTY would
+	 * become a bitop, a test_and_set_bit just has to provide
+	 * implicity smp_mb() semantics for the non contention
+	 * branch).
+	 */
+	smp_rmb();
+
 	filemap_fdatasync(inode->i_mapping);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */

Andrea
