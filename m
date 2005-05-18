Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVERRfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVERRfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 13:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVERRfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 13:35:11 -0400
Received: from mail.shareable.org ([81.29.64.88]:38872 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262192AbVERRei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 13:34:38 -0400
Date: Wed, 18 May 2005 18:34:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: trond.myklebust@fys.uio.no, dhowells@redhat.com, linuxram@us.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry()
Message-ID: <20050518173419.GB993@mail.shareable.org>
References: <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <1116414429.10773.57.camel@lade.trondhjem.org> <E1DYMn1-0000kp-00@dorka.pomaz.szeredi.hu> <20050518125041.GA29107@mail.shareable.org> <E1DYOTs-0000ub-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DYOTs-0000ub-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> >     - Causes every mount in a mount tree to be detached (independently),
> >       when last task associated with a namespace is destroyed.
> 
> I don't understand.  The tree _has_ to be detached when no task uses
> the namespace.  That is the main purpose of the namespace structure,
> to provide an anchor for the mount tree.

That makes less sense if we allow other tasks to be using a namespace
through a passing a file descriptor, and then the last task which has
current->namespace equal to that namespace exits.  It makes no sense
to me that the mount which is still accessible through the file
descriptor is suddenly detached from it's parent and children mounts.

Why is it not good enough to detach each vfsmnt when the last
reference to each vfsmnt is dropped?  In other words, simply when the
vfsmnt becomes unreachable?

That would detach whole vfsmnt trees when the last reference to the
root of the tree is dropped, rather than when a task exits even though
another tasks has a file descriptor still pointing to the tree.

That would be a change of behaviour, but it seems like quite a
sensible change in behaviour, and would not affect "normal" namespace
users.

There's one other purpose to mnt_namespace:

   - The list in /proc/mounts.

But really it would *improve* security if the list in /proc/mounts was
derived by walking the vfsmnt subtree starting at current->chroot.

> > And this invisible effect:
> > 
> >     - More concurrency than a global mount lock would have.
> 
> This is the key issue I think.  It may even have security implications
> in the future if we want to allow unprivileged mounts : a user could
> DoS the system by just doing lots of mounts umounts in a private
> namespace.

Not an argument.  If that's a problem, they could easily DoS the
system by doing lots of mount/umounts in the initial namespace.

The proper thing to do about concurrency is to make sure the slow
operation (getting the superblock) is done outside any mount
semaphore, and just do the tree traversal/splicing operations inside
it.  The code seems to do that already, so I think a global semaphore
instead of mnt_namespace->sem would make no practical difference.

But if it was a problem, we'd come up with something.  Let's
concentrate on the behaviour we want, rather than a minor detail like
that.

I think the common sense behaviour is to say that vfsmnts remain
mounted as long as they are reachable - from a file descriptor, task's
root, or task's cwd.

-- Jamie
