Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268333AbUH2V3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268333AbUH2V3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268327AbUH2V3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:29:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57060 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268326AbUH2V1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:27:05 -0400
Date: Sun, 29 Aug 2004 22:27:00 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hans Reiser <reiser@namesys.com>
Cc: flx@msu.ru, Paul Jackson <pj@sgi.com>, riel@redhat.com, ninja@slaphack.com,
       torvalds@osdl.org, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com> <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41323751.5000607@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 01:06:41PM -0700, Hans Reiser wrote:

> How about if you educate me on the problems you see for a bit before I 
> respond? I think it might help us move into a constructive discussion.

A slew of cache coherency issues (and memory consumption on top of that).
Rigth now we have a signle dentry tree for all fs instances, no matter
how many times it and its subtrees are visible in the tree.  Which,
obviously, avoids all that crap.  As soon as we start trying to have
multiple trees over the same fs, we are in for a *lot* of fun.

The basic question is how do you propagate the changes from one tree
to another and what do you do when change to "invisible" entry happens
via a tree where it is visible.  Unfortunately, all obvious solutions
either hit the pathname resolution and hit it *hard* (both in scalability
and in price of uncontended case) or create a mess for stuff like
NFS silly-rename semantics, VFAT aliases, etc.

Saying that some unspecified data structures might work doesn't help.
obviously - any variant will have tradeoffs of its own and has to be
discussed individually.  fsdevel is there for exactly that sort of
stuff, so if you have any specific proposals you want to discuss, you
are more than welcome.

Again, right now all cache coherency issues are sidestepped by having a single
instance of dentry tree per superblock.  Each mount/binding is represented by
vfsmount and _refers_ to a (sub)tree of dentry tree of that fs - dentries
and inodes are the same (ditto for private data structures owned by filesystem,
obviously).

So we have a forest of dentry trees (one per filesystem) and forest of
vfsmount trees (one tree per namespace).  Each vfsmount corresponds to
a chunk of namespace - think of the full user-visible tree cut into
pieces by mountpoints.  For every piece we know
	a) what fs it's from (->mnt_sb)
	b) what subtree of that fs it corresponds (->mnt_root)
	c) what piece it's attached to (->mnt_parent)
	d) where in that piece it's attached (->mnt_mountpoint)
	e) where to find its siblings and children
	f) which namespace (== tree in vfsmount forest) it's from

Point in a namespace is determined by pair (vfsmount, dentry) - which
piece we are looking at and where in that piece we are.  Pathname lookups
operate on such pairs - as long as we do not cross into another piece
we just step from dentry to dentry, when we cross mountpoint towards root,
we flip to (mnt_parent, mnt_mountpoint) first, when we cross mountpoint
into mounted filesystem, we do hash lookup (lookup_mnt()) by our pair,
find vfsmount with such mnt_parent and mnt_mountpoint and step into
(vfsmount, vfsmount->mnt_root).

Lifetime of vfsmounts is controlled by a simple refcount.  Having vfsmount
attached to tree contributes +1, so does having it pinned down by lookup/
chdir/chroot/opened file.  When the last vfsmount goes away, filesystem is
shut down (basically, that's what happens on umount).  Binding simply creates
a vfsmount pointing to target and attaches it at source.

Cloning a namespace copies the vfsmount tree of parent process' namespace
and flips vfsmounts of our root and cwd into the corresponding nodes in that
copy.  Normally, fork()/clone() just increments namespace refcount instead
of cloning it, so all children share namespace with parent.

When all processes in a namespace are gone its refcount goes to zero.  At
that point we dissolve all attachments in its vfsmount tree (which drops
a reference to each vfsmount and can in turn lead to fs shutdowns).

Lazy umount does similar operation with specified subtree - it detaches
all pieces mounted anywhere in that subtree and drops reference to each.
Ones that are not busy will be shut down immediately, ones that are will
go away as soon as they stop being busy.

vfsmounts can have flags of their own - one of the pending projects is to
allow individual vfsmounts to be read-only.  Noexec, nosuid and nodev are
already per-mountpoint.

Tree of vfsmounts is protected by
	a) vfsmount spinlock (protects hash lookups, mostly)
	b) per-namespace semaphore (that one is obviously blocking)
	c) in cases when we can go from 0 to 1 vfsmounts with given dentry
as a mountpoint, we also hold ->d_inode->i_sem on the mountpoint-to-be
(that closes races between rmdir/mount, rename/mount, etc.)

Dentry tree is messier - these days we have dcache_lock and RCU stuff.
If you can help getting the documentation out of these guys, you've got
a *lot* of thanks from a lot of people.  As it is, it's RTFS country.
I can answer specific questions there, but I won't even try to produce
readable manual covering the entire thing.

Directory operations have exclusion based on ->i_sem - see
Documentation/filesystems/directory-locking for description and proof
of correctness.

For operations that can destroy an object (unlink/rmdir/overwriting rename)
we try to unhash the victim dentry first, so the filesystems that can't
handle unlinked-but-busy stuff can detect such attempt by seeing the
victim still hashed _and_ can be sure that if it's not hashed, nobody will
come and see it (lookup would have to go to filesystem code, since we
have the sucker unhashed and we have exclusion there).  If operation is
unsuccessful, we rehash the victim.

Files involved:
	fs/dcache.c
	fs/super.c
	fs/inode.c
	fs/namespace.c
	include/linux/dcache.h
	include/linux/fs.h
	include/linux/mount.h

If you need more details on any specific area (or gaps in the above) - just
ask.
