Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266740AbUHZBCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266740AbUHZBCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 21:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUHZBCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 21:02:36 -0400
Received: from mail.shareable.org ([81.29.64.88]:38853 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266725AbUHZBA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 21:00:59 -0400
Date: Thu, 26 Aug 2004 02:00:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826010049.GA24731@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> > Is this a problem if we treat entering a file-as-directory as crossing
> > a mount point (i.e. like auto-mounting)?
> 
> Yes - mountpoints can't be e.g. unlinked.  Moreover, having directory
> mounted on non-directory is also an interesting situation.

Ok, so can we make it so mountpoints can be unlinked? :)

The mount would continue to exist, but with no name, until its last
user disappears.

> > Simply doing a path walk would lock the file and then cross the mount
> > point to a directory.
> 
> *Ugh*
> 
> What would happen if you open that directory or chdir there?  If it's
> "underlying file stays locked" - we are in even more obvious deadlocks.

I think the underlying file does not stay locked, and once you've
entered it as a directory, it can be unlinked.

If you have the directory open or chdir into it, then it _may_ have
the effect of keeping the file's storage allocated when you unlink it
-- just like when a file is unlinked while opened.  As that is not a
user-visible property, it's a filesystem-specific implementation
detail as to whether it keeps the file's data in existence while the
metadata directories and/or files are open.

> > A way to ensure that preserves the lock order is to require that the
> > metadata is in a different filesystem to its file (i.e. not crossing a
> > bind mount to the same filesystem).
> > 
> > That has the side effect of preventing hard links between metadata
> > files and non-metadata, which in my opinion is fine.
> 
> We don't actually need a different fs - different vfsmount will do just fine.

> > The strict order is ensured by preventing bind mounts which create a
> > path cycle containing a file->metadata edge.  One way to ensure that
> > is to prevent mounts on the metadata filesystems, but the rule doesn't
> > have to be that strict.  This condition only needs to be checked in
> > the mount() syscall.
> 
> You really don't want to lock mountpoint on path lookup, so I don't see
> how that would be relevant - it's a hell to clean up, for one thing
> (I've crossed ten mountpoints on the way, when do I unlock them and
> how do I prevent deadlocks from that?)  Besides, different namespaces
> can have completely different mount trees, so tracking down all that
> stuff would be hell in its own right.

I didn't mean locking a chain of mountpoints, I meant the temporary
state where two dentries and/or inodes are locked, parent and child,
during a path walk.  However I'm not very familiar with that part of
the VFS and I see that the current RCU dcache might not lock that much
during a path walk.

> The main issue I see with all schemes in that direction (and something
> like that could be made workable) is the semantics of unlink() on
> mountpoints.  *Especially* with users being able to see attributes of
> files they do not own (e.g. reiser4 mode/uid/gid stuff).  Ability to
> pin down any damn file on the system and make it impossible to replace
> is not something you want to give to any user.

I agree, users shouldn't be able to pin down a file.

I think unlink() should succeed on a file while something is visiting
inside its metadata directory.

It's a filesystem quality-of-implementation feature whether that
actually releases the file's data.  It's a desirable feature because
one user shouldn't be able to pin another user's quota'd data if they
don't have permission to open the file, but if it's not implemented by
a filesystem then it doesn't break anything fundamental.

It's a semantics question whether unlinking a file makes the metadata
(i.e. "uid", "mode", "content-type" etc.) disappear at the same time,
or if the metadata stays around until the last visitor leaves it.  A
filesystem might be able to keep the metadata in existence even if it
deletes the file's storage on unlink(), but it would be nice for the
VFS to declare which semantic is preferred.

One of the big potential uses for file-as-directory is to go inside
archive files, ELF files, .iso files and so on in a convenient way.
In those cases, if you open one of the virtually generated "archive
content" files, then you might expect the data to continue to exist
after the underlying file is unlinked.  I think that's reasonable:
being inside an archive is very similar to having it open.  There is
no quota pinning problem with this, because "archive content" files
should inherit permission restrictions from the underlying file.  If
you can't read the file, then you can't read it's unpacked contents.

(reiser4 doesn't offer that last feature, but any of the myriad
userspace filesystem hooks could offer it if the VFS has approprate
auto-mounting file-as-directory hooks).

-- Jamie
