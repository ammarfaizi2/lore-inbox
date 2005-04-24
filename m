Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVDXVio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVDXVio (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVDXVin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:38:43 -0400
Received: from mail.shareable.org ([81.29.64.88]:5800 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262444AbVDXVig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:38:36 -0400
Date: Sun, 24 Apr 2005 22:38:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424213822.GB9304@mail.shareable.org>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> > > I believe the point is:
> > > 
> > >    1. Person is logged from client Y to server X, and mounts something on
> > >       $HOME/mnt/private (that's on X).
> > > 
> > >    2. On client Y, person does "scp X:mnt/private/secrets.txt ."
> > >       and wants it to work.
> > > 
> > > The second operation is a separate login to the first.
> > 
> > Solution?
> 
> ... is the same as for the same question with "set of mounts" replaced
> with "environment variables".

Not quite.

After changing environment variables in .profile, you can copy them to
other shells using ". ~/.profile".

There is no analogous mechanism to copy namespaces.

I agree with you that Miklos' patch is not the right way to do it.

Much better is the proposal to make namespaces first-class objects,
that can be switched to.  Then users can choose to have themselves a
namespace containing their private mounts, if they want it, with
login/libpam or even a program run from .profile switching into it.

While users can be allowed to create their own namespaces which affect
the path traversal of their _own_ directories, it's important that the
existence of such namespaces cannot affect path traversal of other
directories such as /etc, or /autofs/whatever - and that creation of
namespaces by a user cannot prevent the unmounting of a non-user
filesystem either.

The way to do that is shared subtrees, or something along those lines.

Here is one possible implementation:

As far as I can tell, namespaces are equivalent to predicates attached
to every mount - the predicate being "this mount intercepts path
traversal at this point if current namespace == X".

It makes sense, when users can create namespaces for themselves, that
the predicate be changed to "this mount valid if [list of current
namespace and all parent namespaces] contains X".  Parent namespace
means the namespace from which a CLONE_NS namespace inherits.

Then it would be safe (i.e. secure) to allow ordinary users to use
CLONE_NS for the purpose of establishing private namespace(s), within
which they can mount things on directories they own.  But those users
would continue to see mounts & unmounts done by the system in other
directories such as /mnt and /autofs.  Effectively this confines the
new namespace to only affecting directories owned by the user.

That would work properly with suid programs, properly with autofs and
also manual system-wide administration, and it is general enough that
it doesn't force any particular policy.  Also, it would be usable for
partial sharing of resources in virtual server and chroot scenarios.
What's not to like? :)

-- Jamie
