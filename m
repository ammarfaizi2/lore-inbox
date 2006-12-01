Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161824AbWLAVXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161824AbWLAVXj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161807AbWLAVXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:23:39 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161741AbWLAVXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:23:38 -0500
Date: Fri, 1 Dec 2006 13:23:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wendy Cheng <wcheng@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
Message-Id: <20061201132329.4050d6cd.akpm@osdl.org>
In-Reply-To: <456F014C.5040200@redhat.com>
References: <4564C28B.30604@redhat.com>
	<20061122153603.33c2c24d.akpm@osdl.org>
	<456B7A5A.1070202@redhat.com>
	<20061127165239.9616cbc9.akpm@osdl.org>
	<456CACF3.7030200@redhat.com>
	<20061128162144.8051998a.akpm@osdl.org>
	<456D2259.1050306@redhat.com>
	<456F014C.5040200@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 11:05:32 -0500
Wendy Cheng <wcheng@redhat.com> wrote:

> How about a simple and plain change with this uploaded patch ....
> 
> The idea is, instead of unconditionally dropping every buffer associated 
> with the particular mount point (that defeats the purpose of page 
> caching), base kernel exports the "drop_pagecache_sb()" call that allows 
> page cache to be trimmed. More importantly, it is changed to offer the 
> choice of not randomly purging any buffer but the ones that seem to be 
> unused (i_state is NULL and i_count is zero). This will encourage 
> filesystem(s) to pro actively response to vm memory shortage if they 
> choose so.

argh.

In Linux a filesystem is a dumb layer which sits between the VFS and the
I/O layer and provides dumb services such as reading/writing inodes,
reading/writing directory entries, mapping pagecache offsets to disk
blocks, etc.  (This model is to varying degrees incorrect for every
post-ext2 filesystem, but that's the way it is).

We do not want to go "encouraging" filesystems to play games tuning and
trimming VFS caches and things like that.  If a patch doing that were to
turn up it would be heartily shouted at and the originator would be asked
to go off and implement the functionality in core VFS so that a) all
filesystems can immediately utilise it and b) other filesystems aren't
tempted to go off and privately implement something similar.

So please bear this philosophy in mind, and think about this feature from
that perspective.

One approach might be to add a per-superblock upper-bound on the number of
cached dentries and/or inodes.  Typically that would be controlled by a
(re)mount option.  Although we could perhaps discuss a sysfs representation
of this (and, presumably, other mount options).

But I'd expect such a proposal to have a hard time, because we'd need to
know why such a thing is needed: we prefer auto-tuning, and that's what we
have now, so what's gone wrong with it and how can we fix it, rather than
adding a manual override?

>  From our end (cluster locks are expensive - that's why we cache them), 
> one of our kernel daemons will invoke this newly exported call based on 
> a set of pre-defined tunables. It is then followed by a lock reclaim 
> logic to trim the locks by checking the page cache associated with the 
> inode (that this cluster lock is created for). If nothing is attached to 
> the inode (based on i_mapping->nrpages count), we know it is a good 
> candidate for trimming and will subsequently drop this lock (instead of 
> waiting until the end of vfs inode life cycle).

Again, I don't understand why you're tying the lifetime of these locks to
the VFS inode reclaim mechanisms.  Seems odd.

If you want to put an upper bound on the number of in-core locks, why not
string them on a list and throw away the old ones when the upper bound is
reached?

Did you look at improving that lock-lookup algorithm, btw?  Core kernel has
no problem maintaining millions of cached VFS objects - is there any reason
why your lock lookup cannot be similarly efficient?

> Note that I could do invalidate_inode_pages() within our kernel modules 
> to accomplish what drop_pagecache_sb() does (without coming here to bug 
> people) but I don't have access to inode_lock as an external kernel 
> module. So either EXPORT_SYMBOL(inode_lock) or this patch ?
> 
> The end result (of this change) should encourage filesystem to actively 
> avoid depleting too much memory

That is _not_ a filesytem responsibility!  inode cache is owned and
maintained by the VFS.

> and we'll encourage our applications to 
> understand clustering locality issues.

?

> Haven't tested this out though - would appreciate some comments before 
> spending more efforts on this direction.
> 
> -- Wendy
> 
> 
> 
