Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbVESMn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVESMn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVESMn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:43:28 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:20996 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262446AbVESMnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:43:13 -0400
To: jamie@shareable.org
CC: trond.myklebust@fys.uio.no, dhowells@redhat.com, linuxram@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20050518195218.GA3051@mail.shareable.org> (message from Jamie
	Lokier on Wed, 18 May 2005 20:52:18 +0100)
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
References: <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <1116414429.10773.57.camel@lade.trondhjem.org> <E1DYMn1-0000kp-00@dorka.pomaz.szeredi.hu> <20050518125041.GA29107@mail.shareable.org> <E1DYOTs-0000ub-00@dorka.pomaz.szeredi.hu> <20050518173419.GB993@mail.shareable.org> <E1DYTri-0001SL-00@dorka.pomaz.szeredi.hu> <20050518195218.GA3051@mail.shareable.org>
Message-Id: <E1DYkLV-0002Il-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 19 May 2005 14:41:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Define unreachable.
> 
> Unreachable as in no file descriptors (or chroot/cwd) refer to the
> vfsmnt, either directly or indirectly through a path traversal.
> 
> > Then define a mechanism, by which it can be detected.
> 
> There aren't any vfsmnt->vfsmnt cycles...  They're a forest, vfsmnts
> don't move from one tree to another (bind mounts don't link them, they
> create new vfsmnts), and each tree can be referenced by a file
> descriptor at any point on the tree.
> 
> It rather hinges on which of these behaviours you prefer:
> 
>    1. A file descriptor/chroot/cwd reference to any point in a vfsmnt
>       tree means the whole tree is retained.  This means ".." remains
>       always accessible: fchdir(fd); open("..") continues to access
>       that whole tree as you still have fd.
> 
>    2. A file descriptor/chroot/cwd reference to any point in a vfsmnt
>       tree means the subtree from that point is retained, and parents
>       may disappear if there are no references (not counting ".." as a
>       reference).  This behaviour is more sensible for chroots, where
>       the parents should be inaccessible anyway.
> 
>    3. A mixture, where current->root references only maintain the
>       subtree rooted at that point, and other references, if outside
>       the current->root subtree, retain the whole tree accessible from
>       those references.

4. Everything stays the same, except chroot() changes
current->namespace to current->fs->root_mnt->namespace.  This would
address your concern with chroot.

> The appropriate data structure / algorithm depends on which
> behaviour is preferred.  So which is it?

My preference is 1) or 4).

2) and 3) would have some pretty strange properties (in some
situations you can enter a directory, but you cannot get out with 'cd
..' any more)

>  1 Is best done with a mnt_namespace structure, but references to it
> counted when vfsmnts are referenced by file descriptors/root/cwd,
> _not_ references by tasks (no current->namespace).

So you are proposing selective replacement of 

  mntget(mnt);

with

  mntget(mnt);
  get_namespace(mnt->mnt_namespace);

and similar for mntput()?

What do you do on unmount?  If you set mnt->mnt_namespace to NULL,
you'd have to do a put_namespace() for each file descriptor/root/cwd
referencing the mount, but how do you do that?

> 2 is best done by simply reference counting vfsmnts.

It would need quite a revamp of the current reference counting.  If
I'm not mistaken, currently each vfsmount has an initial reference
given to it in alloc_vfsmnt.  And on attach, the parent namespace's
count is also increased, and vice-versa for unmount.

I'm not sure what purpose referencing the parent serves, but it won't
work with 2).  There you'd need referencing the other way round:
parents holding a reference on their children, and have no initial
reference.

With 2) it's also questionable, how you copy the namespace in clone().
Do you just copy the tree under current->fs->root_mnt?  Or do you copy
tree under cwd as well (if it's disjunct from the root tree)?

Miklos
