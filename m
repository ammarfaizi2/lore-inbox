Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156023AbPKXD12>; Tue, 23 Nov 1999 22:27:28 -0500
Received: by vger.rutgers.edu id <S155958AbPKXDV4>; Tue, 23 Nov 1999 22:21:56 -0500
Received: from [202.96.135.132] ([202.96.135.132]:44694 "EHLO mail.huawei.com.cn") by vger.rutgers.edu with ESMTP id <S155964AbPKXDPS>; Tue, 23 Nov 1999 22:15:18 -0500
Date: Mon, 1 Nov 1999 02:15:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: hechengdong <dony.he@huawei.com.cn>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: structure dentry help...
In-Reply-To: <381D3575.D3DA089A@huawei.com.cn>
Message-ID: <Pine.GSO.4.10.9911010154030.18168-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Mon, 1 Nov 1999, hechengdong wrote:

> Hi,
> 
>     Now I am learning linux kernel sources. Can anyone point out to me
> the detailed information about _DENTRY_ structure? I can not guess
> what's the actual meaning of its member, such as d_parent,d_mounts,
> d_covers etc.

It's slightly messy, but the current layout looks so:
	d_parent: points to the parent node in the tree.
	d_subdirs: anchor of the cyclic list that goes through all
children
	d_children: that's where the aforementioned list sits (i.e we
have  parent's d_subdirs <-> 1st child's d_children <-> 2nd child's
d_children <-> ... <-> parent's d_subdirs).

	d_mounts: who overlaps it (root of the tree mounted atop of our
dentry) _or_ dentry itself if it's not a mountpoint; in other words it's a
step upwards.
	d_covers: opposite.

	d_inode: inode corresponding to dentry. May be NULL (for negative
dentries).
	d_alias: cyclic list of dentries that have the same d_inode. It's
anchored in the d_inode->i_dentry. This looks like d_parent/d_children/d_subdirs
structure. Warning: it's badly abused in several filesystems and it is
going to change. d_inode will stay as it is, but you will be safer if
you'll stay out of the d_alias (and i_dentry in struct inode).

	d_hash: hash chains. Anchored in hash table.

	d_count: reference counter. Number of pointers to dentry. Pointers
from cyclic lists do not count.

	d_name: name of dentry.

	d_op: methods.

	The rest: bloody mess.

Notice that:
	a) we can't handle more than one dentry for a directory. VFS does
not allow that, partially due to the d_alias abuse in NFS and friends.
	b) _all_ work with dcache still requires big lock. Again, fixing
that will require cleanup of d_alias/i_dentry mess.
	c) we have only two states for dentry - hashed and unhashed.
Life would be much easier if we had finer separation (e.g. special case
for dentry in process of lookup()). To be changed.
	d) all locking is done on inode level. It makes race prevention
much harder.
	e) cached_lookup() acts funny if we find a directory dentry _and_
attempt to revalidate it gives negative. Compare with the case of
non-directory. Handling of invalidation is tied with the d_alias/i_dentry
problem - same offenders hold the thing. It will take a large and nasty
rewrite.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
