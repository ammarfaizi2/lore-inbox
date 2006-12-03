Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760091AbWLCUsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760091AbWLCUsF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 15:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760089AbWLCUsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 15:48:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:26502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757961AbWLCUsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 15:48:01 -0500
Date: Sun, 3 Dec 2006 12:47:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: wcheng@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
Message-Id: <20061203124752.15e35357.akpm@osdl.org>
In-Reply-To: <45730E36.10309@redhat.com>
References: <4564C28B.30604@redhat.com>
	<20061122153603.33c2c24d.akpm@osdl.org>
	<456B7A5A.1070202@redhat.com>
	<20061127165239.9616cbc9.akpm@osdl.org>
	<456CACF3.7030200@redhat.com>
	<20061128162144.8051998a.akpm@osdl.org>
	<456D2259.1050306@redhat.com>
	<456F014C.5040200@redhat.com>
	<20061201132329.4050d6cd.akpm@osdl.org>
	<45730E36.10309@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Dec 2006 12:49:42 -0500
Wendy Cheng <wcheng@redhat.com> wrote:

> Andrew Morton wrote:
> 
> >On Thu, 30 Nov 2006 11:05:32 -0500
> >Wendy Cheng <wcheng@redhat.com> wrote:
> >
> >  
> >
> >>
> >>The idea is, instead of unconditionally dropping every buffer associated 
> >>with the particular mount point (that defeats the purpose of page 
> >>caching), base kernel exports the "drop_pagecache_sb()" call that allows 
> >>page cache to be trimmed. More importantly, it is changed to offer the 
> >>choice of not randomly purging any buffer but the ones that seem to be 
> >>unused (i_state is NULL and i_count is zero). This will encourage 
> >>filesystem(s) to pro actively response to vm memory shortage if they 
> >>choose so.
> >>    
> >>
> >
> >argh.
> >  
> >
> I read this as "It is ok to give system admin(s) commands (that this 
> "drop_pagecache_sb() call" is all about) to drop page cache. It is, 
> however, not ok to give filesystem developer(s) this very same function 
> to trim their own page cache if the filesystems choose to do so" ?

If you're referring to /proc/sys/vm/drop_pagecache then no, that isn't for
administrators - it's a convenience thing for developers, to get repeatable
benchmarks.  Attempts to make it a per-numa-node control for admin purposes have
been rejected.

> >In Linux a filesystem is a dumb layer which sits between the VFS and the
> >I/O layer and provides dumb services such as reading/writing inodes,
> >reading/writing directory entries, mapping pagecache offsets to disk
> >blocks, etc.  (This model is to varying degrees incorrect for every
> >post-ext2 filesystem, but that's the way it is).
> >  
> >
> Linux kernel, particularly the VFS layer, is starting to show signs of 
> inadequacy as the software components built upon it keep growing. I have 
> doubts that it can keep up and handle this complexity with a development 
> policy like you just described (filesystem is a dumb layer ?). Aren't 
> these DIO_xxx_LOCKING flags inside __blockdev_direct_IO() a perfect 
> example why trying to do too many things inside vfs layer for so many 
> filesystems is a bad idea ?

That's not a very well-chosen example, but yes, the old ext2-based model has
needed to be extended as new filesystems come along.

> By the way, since we're on this subject, 
> could we discuss a little bit about vfs rename call (or I can start 
> another new discussion thread) ?
> 
> Note that linux do_rename() starts with the usual lookup logic, followed 
> by "lock_rename", then a final round of dentry lookup, and finally comes 
> to filesystem's i_op->rename call. Since lock_rename() only calls for 
> vfs layer locks that are local to this particular machine, for a cluster 
> filesystem, there exists a huge window between the final lookup and 
> filesystem's i_op->rename calls such that the file could get deleted 
> from another node before fs can do anything about it. Is it possible 
> that we could get a new function pointer (lock_rename) in 
> inode_operations structure so a cluster filesystem can do proper locking ?

That would need a new thread, and probably (at least pseudo-) code, and
cc's to the appropriate maintainers (although that part of the kernel isn't
really maintained any more - it has fallen into the patch-and-run model).

> >>From our end (cluster locks are expensive - that's why we cache them), 
> >>one of our kernel daemons will invoke this newly exported call based on 
> >>a set of pre-defined tunables. It is then followed by a lock reclaim 
> >>logic to trim the locks by checking the page cache associated with the 
> >>inode (that this cluster lock is created for). If nothing is attached to 
> >>the inode (based on i_mapping->nrpages count), we know it is a good 
> >>candidate for trimming and will subsequently drop this lock (instead of 
> >>waiting until the end of vfs inode life cycle).
> >>    
> >>
> >
> >Again, I don't understand why you're tying the lifetime of these locks to
> >the VFS inode reclaim mechanisms.  Seems odd.
> >  
> >
> Cluster locks are expensive because:
> 
> 1. Every node in the cluster has to agree about it upon granting the 
> request (communication overhead).
> 2. It involves disk flushing if bouncing between nodes. Say one node 
> requests a read lock after another node's write... before the read lock 
> can be granted, the write node needs to flush the data to the disk (disk 
> io overhead).
> 
> For optimization purpose, we want to refrain the disk flush after writes 
> and hope (and encourage) the next person who requests the lock to be on 
> the very same node (to take the advantage of OS write-back logic). 
> That's why the locks are cached on the very same node. It will not get 
> removed unless necessary.
> What would be better to build the lock caching on top of the existing 
> inode cache logic - since these are the objects that the cluster locks 
> are created for in the first place.

hmm, I suppose that makes sense.

Are there dentries associated with these locks?

> >If you want to put an upper bound on the number of in-core locks, why not
> >string them on a list and throw away the old ones when the upper bound is
> >reached?
> >  
> >
> Don't take me wrong. DLM *has* a tunable to set the max lock counts. We 
> do drop the locks but to drop the right locks, we need a little bit help 
> from VFS layer. Latency requirement is difficult to manage.
> 
> >Did you look at improving that lock-lookup algorithm, btw?  Core kernel has
> >no problem maintaining millions of cached VFS objects - is there any reason
> >why your lock lookup cannot be similarly efficient?
> >  
> >
> Don't be so confident. I did see some complaints from ext3 based mail 
> servers in the past - when the storage size was large enough, people had 
> to explicitly umount the filesystem from time to time to rescue their 
> performance. I don't recall the details at this moment though.

People have had plenty of problems with oversized inode-caches in the past,
but I think they were due to memory consumption, not to lookup inefficiency.

My question _still_ remains unanswered.  Third time: is is possible to
speed up this lock-lookup code?

Perhaps others can take a look at it - where is it?

