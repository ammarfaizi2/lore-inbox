Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbRCVFTa>; Thu, 22 Mar 2001 00:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131829AbRCVFTU>; Thu, 22 Mar 2001 00:19:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3970 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131820AbRCVFTJ>;
	Thu, 22 Mar 2001 00:19:09 -0500
Date: Thu, 22 Mar 2001 00:18:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: lock_kernel() usage and sync_*() functions
In-Reply-To: <99bsbk$a6n$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0103212354420.2632-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Mar 2001, Linus Torvalds wrote:

> In article <Pine.LNX.4.05.10103211901070.705-100000@cosmic.nrg.org>,
> Nigel Gamble  <nigel@nrg.org> wrote:
> >
> >Why is the kernel lock held around sync_supers() and sync_inodes() in
> >sync_old_buffers() and fsync_dev(), but not in sync_dev()?  Is it just
> >to serialize calls to these functions, or is there some other reason?
> 
> A lot of the FS locks need the kernel lock and are not SMP-safe on their
> own.  Look at "lock_super()" for the worst offender (I think most of the
> other ones have been converted to properly lock on SMP).

Fixed in namespaces patch.

> sync_inodes() _shouldn't_ need it. sync_supers() definitely does.

Unfortunately, sync_inodes() involves scanning the list of superblocks.
And that's a source of big PITA.

> The fact that sync_dev() doesn't get the kernel lock looks worrisome. 
> Of course, I don't think much of anything actually _uses_ "sync_dev()"
> anyway (quick grep shows it up in revalidate, which gets the kernel lock
> earlier)

sync_dev() is called only under BKL, AFAICS.
 
> But it might be a good idea to try to (a) remove the bkl from the
> functions, and push it down into sync_supers() that definitely needs it
> now (and remove it when it doesn't any more).

Again, done in namespaces patch (->s_lock is semaphore there).

> The long-term plan (ie 2.5.x) is to basically remove the bkl from all
> the VFS interfaces. For 2.4.x, only the truly performance-critical stuff
> was done (ie mainly name lookup and read/write page).

Ehh... Linus, the main problem is in get_super(). Want a nice race?
sys_ustat() vs. sys_umount(). The former does get_super(), finds
struct super_block and does nothing to guarantee that it will stay.
Then it calls ->statfs(). In the meanwhile, you umount the thing
and do rmmod. Oops..

We need to refcount the struct super_block. I went for the following:
rw-semaphore ->s_umount protects the superblock "contents", ->s_count 
is a refcount.
	get_super() grabs a spinlock, looks through the list of
superblocks and increments s_count before dropping the spinlock.
Then it does down_read() on ->s_umount and checks ->s_root once it
got the semaphore. non-NULL - OK, NULL - repeat the search.
	drop_super() - read_up() and atomic_dec_and_test(), followed
by kfree().
	kill_super() - grab the ->s_umount for write(), remove from
list and set ->s_root to NULL while we are holding the ->s_umount and
only then drop it.
	->s_count gets contributions from each get_super() (temp.
reference) _and_ from having vfsmounts over that superblock. Same
scheme as with mm_struct - it's a number of temp refs + one more if
there are perm. ones.

	It works (I'm running such kernel for more than a month on
my boxen) and I'm going to show this beast in details in San Jose. 
Patch is about 150K unpacked, but most of that stuff is in cleanup
of last stages of boot sequence and general cleanup of fs/super.c,
so we could deal with get_super() races with smaller patch. However,
it requires changes to drivers - get_super() needs to be balanced.
Sorry - no way around tha, AFAICS.

	I started with adding 
void invalidate_dev(kdev_t dev, int sync_flag)
{
        struct super_block *sb = get_super(dev);
        if (sync_flag == 1)
                sync_dev(dev);
        else if (sync_flag == 2)
                fsync_dev(dev);
        if (sb) {
                invalidate_inodes(sb);
                /* drop_super(sb); here */
        }
        invalidate_buffers(dev);
}
in fs/buffer.c and converted drivers to that - all uses of get_super()
are in the kernel proper, so after that it was easier to fix without
excessive pain. We could do the same in the main tree as the first
step of get_super() fixes. Mind if I submit such patch?

						Cheers,
							Al

