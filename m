Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWCCLmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWCCLmf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 06:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWCCLmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 06:42:35 -0500
Received: from mx1.suse.de ([195.135.220.2]:53165 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751254AbWCCLmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 06:42:35 -0500
Date: Fri, 3 Mar 2006 12:42:31 +0100
From: Jan Blunck <jblunck@suse.de>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olh@suse.de>, Kirill Korotaev <dev@openvz.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060303114230.GL31712@hasse.suse.de>
References: <17414.38749.886125.282255@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17414.38749.886125.282255@cse.unsw.edu.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, Neil Brown wrote:

>  The core problem is that:
>    prune_one_dentry can hold a reference to a dentry without any
>      lock being held, and without any other reference to the
>      filesystem (if it is being called from shrink_dcache_memory).
>      It holds this reference while calling iput on an inode.  This can
>      take an arbitrarily long time to complete, especially if NFS
>      needs to wait for some RPCs to complete or timeout.
> 
>    shrink_dcache_parent skips over dentries which have a reference,
>      such as the one held by prune_one_dentry.
> 
>    Thus umount can find that an inode is still in use (by it's dentry
>    which was skipped) and will complain.  Worse, when the nfs request
>    on some inode finally completes, it might find the superblock
>    doesn't exist any more and... oops.
> 
>   My proposed solution to the problem is never to expose the reference
>   held by prune_one_dentry.  i.e. keep the spin_lock held.

This morning I wondered, why I was using a list to drop the dentry's inodes
after the dput() has visited all parents.

It is not enough to fix prune_one_dentry() to hold the lock until the parent
is dereferenced since prune_one_dentry() calls __dput_locked(). And in
__dput_locked() we have the same problem again:

from __dput_locked():

                list_del(&dentry->d_u.d_child);
                dentry_stat.nr_dentry--;        /* For d_free, below */
                /*drops the locks, at that point nobody can reach this dentry*/
->              dentry_iput(dentry);
                parent = dentry->d_parent;
                d_free(dentry);
                if (dentry == parent)
                        return;
                dentry = parent;
+
+               if (atomic_read(&dentry->d_count) == 1)
+                       might_sleep();
+               if (!atomic_dec_and_lock(&dentry->d_count, &dcache_lock))
+                       return;
+
+               spin_lock(&dentry->d_lock);
                goto repeat;
        }
  }

Between -> and the atomic_dec_and_lock() the reference count on the parent is
wrong and no lock is held. I fixed that by using d_lru to keep track of all
dentry's which inodes still have to be dereferenced. This should happen after
all parents have been dereferenced.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
