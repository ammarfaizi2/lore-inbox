Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbRAPTdQ>; Tue, 16 Jan 2001 14:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbRAPTdH>; Tue, 16 Jan 2001 14:33:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35152 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132422AbRAPTdE>; Tue, 16 Jan 2001 14:33:04 -0500
Date: Tue, 16 Jan 2001 20:33:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: tytso@valinux.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, aviro@redhat.com
Subject: Re: Locking problem in 2.2.18/19-pre7? (fs/inode.c and fs/dcache.c)
Message-ID: <20010116203334.C19265@athlon.random>
In-Reply-To: <E14IbPR-0007Ye-00@beefcake.hdqt.valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14IbPR-0007Ye-00@beefcake.hdqt.valinux.com>; from tytso@valinux.com on Tue, Jan 16, 2001 at 11:04:45AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 11:04:45AM -0800, Theodore Y. Ts'o wrote:
> 
> HJ Lu recently pointed me at a potential locking problem
> try_to_free_inodes(), and when I started proding at it, I found what
> appears to be another set of SMP locking issues in the dcache code.
> (But if that were the case, why aren't we seeing huge numbers of
> complaints?  So I'm wondering if I'm missing something.)

Because the code is correct ;). It is infact a fix and it took some time to fix
such bug in mid 2.2.x.

> 
> Anyway, the first problem which HJ pointed out is in
> try_to_free_inodes() which attempts to implement a mutual exclusion with
> respect to itself as follows....
> 
> 	if (block)
> 	{
> 		struct wait_queue __wait;
> 
> 		__wait.task = current;
> 		add_wait_queue(&wait_inode_freeing, &__wait);
> 		for (;;)
> 		{
> 			/* NOTE: we rely only on the inode_lock to be sure
> 			   to not miss the unblock event */
> 			current->state = TASK_UNINTERRUPTIBLE;
> 			spin_unlock(&inode_lock);
			^^^^^^^^^^^^^^^^^^^^^^^^
> 			schedule();
> 			spin_lock(&inode_lock);
			^^^^^^^^^^^^^^^^^^^^^^^^
> 			if (!block)
> 				break;
> 		}
> 		remove_wait_queue(&wait_inode_freeing, &__wait);
> 		current->state = TASK_RUNNING;
> 	}
> 	block = 1;
> 
> Of course, this is utterly unsafe on an SMP machines, since access to
> the "block" variable isn't protected at all.  So the first question is

Wrong, it's obviously protected by the inode_lock. And even if it wasn't
protected by the inode_lock in 2.2.x inode.c and dcache.c runs globally
serialized by the BKL (but it is obviously protected regardless of the BKL).

> why did whoever implemented this do it in this horribly complicated way
> above, instead of something simple, say like this:
> 
> 	static struct semaphore block = MUTEX;
> 	if (down_trylock(&block)) {
> 		spin_unlock(&inode_lock);
> 		down(&block);
> 		spin_lock(&inode_lock);
> 	}

The above is overkill (there's no need to use further atomic API, when we can
rely on the inode_lock for the locking. It's overcomplex and slower.

> (with the appropriate unlocking code at the end of the function).
> 
> 
> Next question.... why was this there in the first place?  After all,

To fix the "inode-max limit reached" faliures that you could reproduce on
earlier 2.2.x. (the freed inodes was re-used before the task that freed them
had a chance to allocate them for itself)

> most of the time try_to_free_inodes() is called with the inode_lock
> spinlock held, which would act as a automatic mutual exclusion anyway.

> The only time this doesn't happen is when we call prune_dcache(), where
> inode_lock is temporarily dropped.

Wrong:

		spin_unlock(&inode_lock);
		prune_dcache(0, goal);
		spin_lock(&inode_lock);
		sync_all_inodes();
		__free_inodes(&throw_away);

the above code obviously drops the spinlock for doing things like flushing the
dirty inodes to the buffer cache that can block in balance_dirty() etc...
(and that's the real problem because it sleeps so also the BKL gets released
while prune_dcache in practice could not race because of the BKL)

> So I took a look at prune_dcache(), and discovered that (a) it's called
> from multiple places, and (b) it and shrink_dcache_sb() both iterate over
> dentry_unused and among other things, tried to free dcache structures
> without any kind of locking to prevent two kernel threads to
> from mucking with the contents of dentry_unused at the same time, and
> possibly having prune_one_dentry() being called by two processes on the
> same dentry structure.  This should almost certainly cause problems.

we're running under the BKL all over the place in 2.2.x so they can't race.

> So the following patch I think is definitely necessary, assuming that

The patch is definitely not necessary.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
