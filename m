Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUGJHJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUGJHJo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 03:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUGJHJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 03:09:44 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:35594 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266175AbUGJHJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 03:09:40 -0400
Date: Sat, 10 Jul 2004 14:57:46 +0800 (WST)
From: raven@themaw.net
To: Thomas Moestl <moestl@ibr.cs.tu-bs.de>
cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: umount() and NFS races in 2.4.26
In-Reply-To: <20040708180709.GA7704@timesink.dyndns.org>
Message-ID: <Pine.LNX.4.58.0407101419210.1378@donald.themaw.net>
References: <20040708180709.GA7704@timesink.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	RCVD_IN_ORBS, REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2004, Thomas Moestl wrote:

> Hi,
> 
> after deploying an SMP machine at work, we started to experience Oopses
> in file-system related code relatively frequently. Investigation
> revealed that they were caused by references using junk pointers from
> freed super blocks via dangling inodes from unmounted file systems;
> Oopses would always be preceded by the warning
>   VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
> on an unmount (unmount activity is high on this machine due to heavy use
> of the automounter). The predecessor to this machine, a UP system with
> otherwise almost identical configuration, did never encounter such
> problems, so I went looking for possible SMP races.

This has been reported many times by users of autofs, especially people 
with a ot of mount/umount activity.

As James pointed out my latest autofs4 patch resolved the issue for him.
However, on the NFS list Greg Banks pointed out that this may be hiding a
problem that exists in NFS. So it would be good if the NFS folk could 
investigate this further.

Never the less I'm sure there is a race in waitq.c of autofs4 in 
2.4 that seems to cause this problem. This is one of the things 
addressed by my patch.

The autofs4 stuff can be found at 
http://www.kernel.org/pub/linux/daemons/autofs/v4

Note that the patch for the kernel module will not apply cleanly to 
2.4.27-rc3 as Marcello has applied 2 hunks from that patch. Similarly if 
you chose to use the kernel module build kit the mandatory and optional 
kernel patches refered to in it have already been applied to 2.4.27-rc3.

Additionally, I recomend using the latest autofs, currently 4.1.3, as well 
as the 4.1.3 patches found with the tarball at the location above.

> 
> I believe that I have found two problems:
> 
> - The NFS async unlink code (fs/nfs/unlink.c) does keep a dentry for
>   later asynchronous processing, but the mount point is unbusied via
>   path_release() once sys_unlink() returns (fs/namei.c). While it
>   does a dget() on the dentry, this is insufficient to prevent an
>   umount(); when one would happen in the right time window, it seems
>   that it would initially get past the busy check:
> 	if (atomic_read(&mnt->mnt_count) == 2 || flags & MNT_DETACH) {
>   (fs/namespace.c, do_umount()), but invalidate_inodes() in kill_super()
>   (fs/super.c) would then fail because of the inode referenced from
>   the dentry needed for the async unlink (which cannot be removed
>   by shrink_dcache_parent() because the NFS code did dget() it).
> 
>   Please note that this problem is only conjectured, as it turned out
>   to not be our culprit. It looks not completely trivial to fix to me,
>   I believe it might require some changes that would affect other FS
>   implementations. It is not a true SMP race, if it exists it would
>   affect UP systems as well.
> 
> - There is a SMP race between the shrink_dcache_parent() (fs/dcache.c)
>   called from kill_super() and prune_dache() called via
>   shrink_dache_memory() (called by kswapd), as follows:
>   shrink_dache_parent() calls select_parent() to both prepare the LRU
>   list for purge_cache() and return the number of unused dcache
>   entries that can likely be removed in the next prune_dache() run.
>   If select_parent() returns 0, shrink_dcache_parent() assumes that
>   its work is done and returns. Now, assume for simplicity that there
>   are only two remaining dcache entries: one for "foo/bar" and for
>   the directory "foo/", which is referenced by the "foo/bar" entry.
>   Furthermore, prune_dcache() is currently running, called from kswapd,
>   and has decided to remove the "foo/bar" entry. To that end, it
>   calls prune_one_dentry(), which dentry_iput()s then "foo/bar" dentry.
>   This causes the dache_lock() to be dropped. Just now select_parent()
>   comes along, and can obtain the dcache_lock(). It now looks for unused
>   dentries; but there is only the "foo/" one left, which has a non-zero
>   d_count because "foo/bar" referenced it as parent, and
>   prune_one_dentry() did not yet have a chance to dput() it because it
>   has to wait for the dcache_lock(). Thus, select_parent() finds no
>   unused dentries, assumes that all is fine and does not purge any
>   more; the "foo/" entry can remain in the cache for much longer
>   because it may have DCACHE_REFERENCED set, so that the kswapd
>   purge_dcache() will leave it alone. The inode corresponding to the
>   dangling dcache entry will still be referenced, and end up dangling,
>   too. kill_super() will print the warning mentioned above.
>   When dentry or inode are touched again later (for example in another
>   purge_dcache() later on) we can end up accessing the super block
>   freed during the unmount, leading to an Oops.
>   This was partially verified by inspecting the dcache state via
>   /dev/kmem after the busy inodes warning had occured (the directory
>   dentry was not busy any more, but still remained in the unused list).
> 
>   In the attached patch, I have used a semaphore to serialize purging
>   accesses to the dentry_unused list. With a kernel so patched, the
>   problem seems to have disappeared. The patch is just a quick hack,
>   the semantics of the semaphore is not really well-defined; but maybe
>   it can serve as a starting point.
>   
> I have not checked whether any of these issues pertain to the 2.6 series
> as well.
> 
> 	- Thomas
> 
> P.S: please CC me in replies, as I am not subscribed to this list.
> 
> 

