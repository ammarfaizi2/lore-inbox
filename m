Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVERTwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVERTwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 15:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVERTwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 15:52:42 -0400
Received: from mail.shareable.org ([81.29.64.88]:43224 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262311AbVERTw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 15:52:29 -0400
Date: Wed, 18 May 2005 20:52:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: trond.myklebust@fys.uio.no, dhowells@redhat.com, linuxram@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
Message-ID: <20050518195218.GA3051@mail.shareable.org>
References: <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <1116414429.10773.57.camel@lade.trondhjem.org> <E1DYMn1-0000kp-00@dorka.pomaz.szeredi.hu> <20050518125041.GA29107@mail.shareable.org> <E1DYOTs-0000ub-00@dorka.pomaz.szeredi.hu> <20050518173419.GB993@mail.shareable.org> <E1DYTri-0001SL-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DYTri-0001SL-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> > That makes less sense if we allow other tasks to be using a namespace
> > through a passing a file descriptor, and then the last task which has
> > current->namespace equal to that namespace exits.  It makes no sense
> > to me that the mount which is still accessible through the file
> > descriptor is suddenly detached from it's parent and children mounts.
> 
> I see your point.  I don't yet see a solution.
> 
> Currently detach is an explicit action, not something automatic which
> happens when there are no more references to a vfsmount.

It's implicit, when the last task calls put_namespace:

	void __put_namespace(struct namespace *namespace)
	{
[...]
		umount_tree(namespace->root);
		-> calls detach_mnt for each vfsmnt in namespace.
[...]
	}

> > Why is it not good enough to detach each vfsmnt when the last
> > reference to each vfsmnt is dropped?  In other words, simply when the
> > vfsmnt becomes unreachable?
> 
> Define unreachable.

Unreachable as in no file descriptors (or chroot/cwd) refer to the
vfsmnt, either directly or indirectly through a path traversal.

> Then define a mechanism, by which it can be detected.

There aren't any vfsmnt->vfsmnt cycles...  They're a forest, vfsmnts
don't move from one tree to another (bind mounts don't link them, they
create new vfsmnts), and each tree can be referenced by a file
descriptor at any point on the tree.

It rather hinges on which of these behaviours you prefer:

   1. A file descriptor/chroot/cwd reference to any point in a vfsmnt
      tree means the whole tree is retained.  This means ".." remains
      always accessible: fchdir(fd); open("..") continues to access
      that whole tree as you still have fd.

   2. A file descriptor/chroot/cwd reference to any point in a vfsmnt
      tree means the subtree from that point is retained, and parents
      may disappear if there are no references (not counting ".." as a
      reference).  This behaviour is more sensible for chroots, where
      the parents should be inaccessible anyway.

   3. A mixture, where current->root references only maintain the
      subtree rooted at that point, and other references, if outside
      the current->root subtree, retain the whole tree accessible from
      those references.

The appropriate data structure / algorithm depends on which behaviour
is preferred.  So which is it?  1 Is best done with a mnt_namespace
structure, but references to it counted when vfsmnts are referenced by
file descriptors/root/cwd, _not_ references by tasks (no
current->namespace).  2 is best done by simply reference counting
vfsmnts.

-- Jamie
