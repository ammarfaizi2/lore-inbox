Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbUCSOwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUCSOwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:52:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40634 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262236AbUCSOwH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:52:07 -0500
Date: Fri, 19 Mar 2004 14:52:06 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 3/5
Message-ID: <20040319145206.GQ31500@parcelfarce.linux.theplanet.co.uk>
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075814.GE31818@MAIL.13thfloor.at> <20040318122645.GJ31500@parcelfarce.linux.theplanet.co.uk> <20040319025236.GC31040@MAIL.13thfloor.at> <20040319111117.GP31500@parcelfarce.linux.theplanet.co.uk> <20040319134028.GA5297@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040319134028.GA5297@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 02:40:28PM +0100, Herbert Poetzl wrote:
> > FWIW, I would start with
> > 	1) split out simple_permission() - vfs_permission() sans the
> > r/o checks; vfs_permission() would call it and all in-tree calls of
> > vfs_permission() would get expanded.
> 
> 	 -· vfs_permission()
> 	  ¦-· hfs_permission()
> 	  ¦-· hfsplus_permission()
> 	  ¦-· nfs_permission()
> 	  ¦-* permission()
> 	  ¦-· presto_permission()
> 	  '-· proc_permission()
> 
> please elaborate ...

First chunk: replace calls of vfs_permission() with r/o checks +
simple_permission(), _leaving_ vfs_permission() _itself_ _as-is_.
 
> > 	2) prove that all instances of ->permission() honour r/o checks.
> > Fix the broken ones (and yes, we do have them - e.g. hfs_permission()
> > or bogus return values in proc_permission()), after we'd shown that
> > it's safe.  Note that it's not obvious - e.g. anything around ACLs or
> > <barf> XFS ioctls is not just fscking ugly - it's brittle as hell and
> > will require very careful treatment.
> 
> okay, but why not do it in permission(), and make
> the few callers of vfs_permission use that one instead?

Filesystem code might be calling permission(9) and expecting (broken)
behaviour from its own ->permission().  Switch to uniform behaviour
would break such places, forcing us to compensate there.  And analysis
won't be fun.

> except for jfs_permission() and nfsd_permission()
> (which is hell enough) there are no direct calls
> of *_permission() ...

fs code calling permission() is basically equivalent to direct call.

> > 	3) once that is done, put r/o checks into the beginning of
> > permission(9)
> 
> hmm, obviously you didn't read the patch at all, as that 
> is exactly what I did, so please have a look at it ...

Yes, I have read it.  Try to read the reply - what I'm saying is that it
should be a separate chunk in the series _and_ it will need some preparations
before it can go in.

> > 	4) for all instances of ->permission(), move r/o checks in
> > the places that call that instance directly.  Remove them from method
> > itself.
> > 
> > 	And yes, #2 will hurt.  Badly.
> 
> I don't see why, please enlighten me ...

See above.

> > BTW, IS_RDONLY() part of that stuff will really hit the fan when you start
> > touching the FPOS in fs/ext2/xattr.c and around it.  Have fun...
> > 
> > Note that it's not enough to bring relevant vfsmount to every caller of
> > IS_RDONLY() - if we are calling it to make sure that fs is not r/o,
> > we _really_ want to make sure that it doesn't get remounted r/o just as
> > IS_RDONLY() returns.  And yes, there are real bugs in that area.
> 
> hmm, well but how would moving the ro checks around
> or adding them for the vfs mounts influence that?
> 
> I agree that this _is_ an issue but why should this _not_
> happen with mount -o remount,ro /xy ?

Once the checks are moved up, we split them into pairs (want_write_access(),
drop_write_access()) where the former can fail.  Then the second call gets
moved past the call of fs method.  IOW, we go from

	start fs activity
	deep in the bowels of fs code check for r/o and possibly fail
	do the rest

to
	check for r/o and possibly fail
	do fs work

_and_ to

	request write access and possibly fail
	do fs work
	drop write access

Transition between (2) and (3) is simple and relatively easy to verify
_IF_ the checks are lifted up.  And result will give sane protection
for remount - switch to r/o would have to be atomic wrt requesting
write access and would fail if we had writers.

Note that per-mountpoint r/o will take pretty much the same amount of work -
propagating vfsmounts down to the IS_RDONLY checks only to have that reverted
when we lift the checks up would mean doing more or less the same twice.

It can be done and it can be merged gradually in small and simple chunks,
so that they could be (a) well-understood and (b) well-tested.

The way we split the series *does* matter - composition of these patches
will be large and will touch quite a few places (there's extra fun with
delayed writes - e.g. removal of last link in foo_unlink() will mean
extra request for write access, dropped when inode is finally deleted,
possibly hours after unlink(2) had returned).  Doing that in one or even
3-4 patches would be insane even in 2.7; in 2.6 it's so out of question
that it's not even funny.
