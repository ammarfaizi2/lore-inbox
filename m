Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVDXWUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVDXWUa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 18:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVDXWUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 18:20:30 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:17893 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262460AbVDXWUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 18:20:10 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050424213822.GB9304@mail.shareable.org>
References: <E1DPnOn-0000T0-00@localhost>
	 <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost>
	 <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
	 <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114381206.4480.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 24 Apr 2005 15:20:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-24 at 14:38, Jamie Lokier wrote:
> Al Viro wrote:
> > > > I believe the point is:
> > > > 
> > > >    1. Person is logged from client Y to server X, and mounts something on
> > > >       $HOME/mnt/private (that's on X).
> > > > 
> > > >    2. On client Y, person does "scp X:mnt/private/secrets.txt ."
> > > >       and wants it to work.
> > > > 
> > > > The second operation is a separate login to the first.
> > > 
> > > Solution?
> > 
> > ... is the same as for the same question with "set of mounts" replaced
> > with "environment variables".
> 
> Not quite.
> 
> After changing environment variables in .profile, you can copy them to
> other shells using ". ~/.profile".
> 
> There is no analogous mechanism to copy namespaces.
> 
> I agree with you that Miklos' patch is not the right way to do it.
> 
> Much better is the proposal to make namespaces first-class objects,
> that can be switched to.  Then users can choose to have themselves a
> namespace containing their private mounts, if they want it, with
> login/libpam or even a program run from .profile switching into it.
> 
> While users can be allowed to create their own namespaces which affect
> the path traversal of their _own_ directories, it's important that the
> existence of such namespaces cannot affect path traversal of other
> directories such as /etc, or /autofs/whatever - and that creation of
> namespaces by a user cannot prevent the unmounting of a non-user
> filesystem either.
> 
> The way to do that is shared subtrees, or something along those lines.

Right. Adding to it. To begin with the system namespace has all its
entire tree shared. So when a new namespace is cloned, the new namespace
can see any new mount/unmount/binds done in the system namespace as
well. (System namespace is the first initial namespace created by
default).

Any private mounts done by the user in his private-namespace 
will first make that part of the tree private first and then will
continue with the mount. Otherwise the private mount will end up showing
in the system namespace(since it is shared).

RP
> 
> Here is one possible implementation:
> 
> As far as I can tell, namespaces are equivalent to predicates attached
> to every mount - the predicate being "this mount intercepts path
> traversal at this point if current namespace == X".
> 
> It makes sense, when users can create namespaces for themselves, that
> the predicate be changed to "this mount valid if [list of current
> namespace and all parent namespaces] contains X".  Parent namespace
> means the namespace from which a CLONE_NS namespace inherits.
> 
> Then it would be safe (i.e. secure) to allow ordinary users to use
> CLONE_NS for the purpose of establishing private namespace(s), within
> which they can mount things on directories they own.  But those users
> would continue to see mounts & unmounts done by the system in other
> directories such as /mnt and /autofs.  Effectively this confines the
> new namespace to only affecting directories owned by the user.
> 
> That would work properly with suid programs, properly with autofs and
> also manual system-wide administration, and it is general enough that
> it doesn't force any particular policy.  Also, it would be usable for
> partial sharing of resources in virtual server and chroot scenarios.
> What's not to like? :)


> 
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

