Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272315AbTHDXon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 19:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272312AbTHDXon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 19:44:43 -0400
Received: from zork.zork.net ([64.81.246.102]:43219 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S272316AbTHDXoF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 19:44:05 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Christoph Hellwig <hch@infradead.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: RO --bind mount implementation ...
References: <20030804221615.GA18521@www.13thfloor.at>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>, Christoph
 Hellwig <hch@infradead.org>, Alexander Viro
 <viro@parcelfarce.linux.theplanet.co.uk>
Date: Tue, 05 Aug 2003 00:43:53 +0100
In-Reply-To: <20030804221615.GA18521@www.13thfloor.at> (Herbert
 =?iso-8859-1?q?P=F6tzl's?= message of "Tue, 5 Aug 2003 00:16:15 +0200")
Message-ID: <6u1xw1dm4m.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Pötzl <herbert@13thfloor.at> writes:

> A few days ago, I asked on lkml if mount options like RO would be
> useful for --bind mounts, and Christoph was so nice to refer me to a
> 'n step' plan posted by Al 'a while ago', which I could not find 8-)
> ...

-------------------- Start of forwarded message --------------------
Date:	Thu, 29 May 2003 09:21:27 +0100
From:	viro@parcelfarce.linux.theplanet.co.uk
To:	Shaya Potter <spotter@cs.columbia.edu>
Cc:	linux-fsdevel@vger.kernel.org
Subject: [long] per-mountpoint readonly
Message-ID: <20030529082127.GL14138@parcelfarce.linux.theplanet.co.uk>

On Thu, May 29, 2003 at 12:20:23AM -0400, Shaya Potter wrote:
> On Wed, 2003-05-28 at 20:55, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> > So give it a _REAL_ namespace.  And bind /dev/null over /bin/sh in it.
> > And revoke the capability to call mount(2) and umount(2).  End of story.
> 
> The issue w/ the fs namespaces the kernel supports (at least AFAI
> understand them) is that you can't change the underlying permission
> model.
> 
> so for example, an "apache namespace" you might want it to only have
> read only access to everything besides a few files in /var/log.  Can one
> do that w/ namespaces?


Now, _that_ would be a good thing to implement.  To do it the right way
we need to make readonly status per-mountpoint.  Note that we already have
that for e.g. nosuid and friends.  If we get that done for readonly
you can
	* in your namespace remount everything readonly
	* mount --recbind /var/log /var/log
	  mount -o remount,rw /var/log
and enjoy.

The first question is obviously "could it be done at all?"

Situation with IS_RDONLY() is interesting.  First of all, there are
uses of that beast in ->permission() instances.  We definitely can
(and should) take them upstream.  No matter how hard somebody might
wish to allow write access to e.g. regular file, if fs is readonly,
it's readonly.  Period.  No ACLs can override it.

IOW, that check (IS_RDONLY and (regular|directory|symlink) ==> EROFS)
should be moved into fs/namei.c::permission().  Ditto for checks in
xattr methods - they also go upstream.

ioctls (ext2, ext3, reiserfs) have struct file * and thus are not
a problem.

fs/open.c callers also have struct file * or struct nameidata.  Not a
problem.

fat_truncate() - actually, both checks there are bogus; callers do
check for that stuff.  Should be removed.

ncpfs uses should be replaced with update_atime() (and that will be
a huge can of worms).  We have struct file * in them, anyway.

ntfs uses.  These are actually about the state of filesystem itself -
they attempt to fill the missing permission bits.

arch/sparc64/solaris/fs.c: there we have vfsmount.

fs/namei.c::may_open().  After we make sure that permission() _always_
honors IS_RDONLY() (i.e. move the checks into beginning of the thing),
that particular check is not needed anymore.

vfs_permission() - check moves to permission().  NB: we need to verify
that it's only called by permission() and instances of ->permission().

nfsd_permission() - there we have the export, ergo the vfsmount.

presto_settime() - the check is bogus, we only call it from ->create(),
->unlink(), etc. and the upper layer logics takes care of these checks.

presto_do_setattr() - fsck knows, ask Peter.  I suspect that callers
should do the check, if they are not doing it already.

ext3_change_inode_journal_flag() - called only from ioctl.


And that leaves us with two big ones.  Namely, permission() and update_atime().
The above will take quite a few accurate steps, but it's doable and would
make sense regardless of the following.  And yes, there's a lot of work on
accurate verification of correctness that I'd skipped - it has to be done
and there might be nasty surprises.  However, assuming that it's done,
we are at the interesting point.

The thing is, we have no hope in hell to propagate vfsmount into all calls
of permission().  _HOWEVER_, we might not need to do that.  Note that part
potentially interested in vfsmount is very small and specific.  Again,
we are talking about
	want write and is readonly and (file or directory or symlink).
Right now it needs only inode, but we want to make "is readonly" a function
of vfsmount.  Let's start with taking that check out of permission() and
into its callers.

	Note that callers in floppy_open() (the worst from the "where do
we get vfsmount/dentry" POV) do not give a damn - there the check is
always false, since we are talking about block device.  So they are
not a problem.

	Places where we got the inode from struct file * or struct nameidata
are also not a problem - there we have everything we might possibly ask for.
That kills a lot of permission() instances.

	We also do not care for cases when we don't ask for write access
(obviously - there the check can be dropped).

	Call in nfsd_permission() is not a problem, for the same reasons
as with explicit IS_RDONLY() there.  We have export, ergo we have a vfsmount.

	Call in presto_permission() is an utter bullshit - it's a hack of
rather bad taste and should have been replaced with call of vfs_permission()
(I mean, just look at it - Peter, please, LART whoever had done that).

	Checks that come out of calls in ext2 and ext3 xattr stuff can be
dropped - after the changes above we would have them already done in callers.

	Now we are down to 8 functions
may_create(), may_delete(), vfs_rename_dir()
their intermezzo copies
hpfs_unlink() and update_atime().

Let's take a look at update_atime().  We want to propagate struct vfsmount
and struct dentry into that guy.  It's worth the effort for a lot of reasons,
not the least of them being that we will get per-mountpoint noatime and
nodiratime out that - immediately.

All callers that have inode obtained by struct file * are trivial.  We have
what we need there.  Now, a large group actually comes from the same kind
of place - it's ->readdir() in the majority of filesystems.  We might be
better off just taking that to caller of ->readdir() - provided that NFS
folks are OK with that (nfs does _not_ update atime on client after
readdir()).  In any case, we have struct file * there anyway.

nfsd_readlink() doesn't have struct file *, but it has export.  Same as above.

sys_readlink() has nameidata.

open_namei() and do_follow_link() have pointers to relevant vfsmount (should
be done accurately - it's easy to get confused there).

autofs4 use - AFAICS there we want atime updated unconditionally, so calling
update_atime() (update atime after checking noatime/nodiratime/readonly flags)
is wrong.

That's it with update_atime() and by that time we get visible result - ability
to turn noatime and nodiratime on and off on a subtree basis.

Now, what's left is hpfs_unlink(), may_create()/may_delete()/vfs_rename_dir()
and intermezzo analogs of these 3.  Let's see.

Check in hpfs_unlink() can be dropped.  It should call permission(), all
right, but check for filesystem being writable for us is already done, so
we can skip it.

Situation with may_create()/may_delete() is more interesting.  They are
called from vfs_{create,link,unlink,....} and there we do not have a
vfsmount.  Let's start with taking the check ("fs is writable for us")
from may_...() into these functions.  They are _always_ done on a single
fs, so even if we get several checks, they'll combine nicely.  Moreover,
in all cases except vfs_rename() that check can be done as the very first
operation - if it fails we shoudl return -EROFS and do nothing.

vfs_rename() is almost OK - there we have a POSIX-mandated idiocy:
        if (old_dentry->d_inode == new_dentry->d_inode)
                return 0;
in the very beginning.  The check can go immediately after that, but
we can't move it in the very beginning.  IOW, there is a case when
rename() on a read-only filesystem is required to succeed - when
source and target are links to the same inode.  In that case POSIX
requires to return 0 and do nothing.

Check that had migrated into vfs_rename_dir() can be dropped - we
do the same check in its caller earlier (it's called from vfs_rename()).
BTW, why the fsck vfs_rename_dir() is not static?  We don't use it
anywhere else in the tree and it's not exported, so...

Now, we are left with that merry bunch - vfs_<operation>.  Let's take
the POSIX idiocy to the callers of vfs_rename() and let's move the
check for fs being writable to us into callers of all these guys.

_NOW_ we are done.  Indeed, there are two groups of callers (syscalls
and nfsd) and both know what we are dealing with.  The former have
vfsmount, the latter have export.

Note that passing vfsmount into vfs_...() would be a Wrong Thing(tm) -
they are deliberately fs-local.  I.e. they don't care where (and if)
fs is mounted - they operate below the mount tree level.

Intermezzo analogs are analogous ;-)  We can deal with them in the
same manner.

OK, so far we have shown that per-mountpoint ro/noatime/nodiratime are
doable.  However, the solution as described above is *NOT* going to
be accepted - it sprinkles a lot of crap all over the tree for no
visible reason.  Let's take a look at the resulting picture and see
how it can be cleaned up.

What had actually changed?  We used to have checks for "fs is writable"
on a fairly low level.  The end result has their analogs on earlier
stages - at the point where we have decided that operation will happen
on *this* part of mount tree.

That has an obvious functionality problem - what happens if we decide that
fs is writable and remount it read-only between the check and actual work?
*However*, this is not a new issue.  Current code has exact same problem.
We need to deal with it anyway.

Basically, what's wrong with both current and modified trees is that
we ask "can I write to that sucker now?" and consider the positive
answer as go-ahead.

Theoretically, it could even work - if remount would block until the
transient operation is done or say just say "busy" in all cases when
something is going on.  We even do some checks of that sort.  However,
they deal only with long-term stuff - files being opened for write or
unlinked files kept alive by being open.  Transient stuff is ignored,
so we can very well get fs remounted r/o right after e.g. mkdir()
does all checks and decides to go ahead.

How to fix that?  Well, the obvious way would be to bracket transient
stuff with WILL WRITE/WONT WRITE.  With filesystem being able to say
DO WRITE/DONT WRITE, obviously ;-)

But look, we have already done half of that - we have the opening
brackets.  And that's exactly what our shifted checks are - we are
asking for write access to filesystem, we call a function that assumes
such access and once it returns we are done with the thing.  IOW,
adding the closing brackets is easy now.

And that's what we were missing in the above.  Now we can get sane
semantics for all that stuff.  Why would filesystem be read-only
or read-write?  Well,
	(1) it can be read-only because it refuses to be read-write, period.
E.g. no matter what you do, filesystem on a CD will *not* be writable.  Ever.
Ditto for remote filesystem that is not exported read-write.  Ditto for a
filesystem that doesn't know how to be writable.
	(2) it can be read-only because nobody asked it to be read-write.
	(3) it can be read-only because sysadmin *told* it to stop being
writable.

What happens to these cases if we want per-mountpoint writability?
	(1) doesn't change at all
	(2) becomes "none of the instances are asked to be writable"
	(3) becomes independent from (2)
IOW, we need to distinguish between "make that instance read-only, stop
allowing writes to come via it" and "make fs readonly if it's not busy
writing stuff; do _not_ consider lusers wanting it to be writable an
obstacle, they are welcome to go forth and procreate".

And with that distinction we get a very nice semantics, indeed.  Namely,
	* vfsmounts have a "Don't write through me" flag.
	* superblock has a counter for transient write accesses (->s_writes).
	* superblock has a "Sod off, I'm readonly" flag (->s_baldrick).
Requesting a write access checks both flags and bumps ->s_writes.
Saying that write is over decrements ->s_writes.
Requesting a global readonly remount does current checks (for non-transient
writes), checks ->s_writes and if it's 0 - sets ->s_baldrick and initiates
syncing.
Asking to remount read-write asks filesystem if it would agree to reset
aforementioned flag and resets the vfsmount flag if fs does agree.

That's it.  Now, we might actually go further and try to eliminate the
current mess in check for non-transient write access.  It's not even
that hard - there are only two kinds of non-transients.
	1) file can be opened for write.  We have asked for write access
in may_open(); so let's not relinquish it until the final fput().
	2) file can be unlinked but kept open.  Let the filesystem bump
the ->s_writes when the ->i_nlink reaches 0 and have the ->delete_inode()
decrement it when it's done.
That will make the current mess unnecessary - we can just check ->s_writes
and it will tell us if the thing is busy.

Moreover, with that scheme we could even play with "if hadn't been
asked for write access in a while, tell it to go readonly but to be
ready to become read-write as soon as the next request for write access
will be issued" - the policy would be in userland and kernel-side part
wouldn't be hard.  One such scheme would keep a flag that could be reset
by userland if ->s_writes was currently 0 and set whenever we grant
write access; attempt to reset it when it's already reset would do a
"soft" remount - it would tell the fs driver to do usual steps of r/o
remount, but switch back to r/w when write access is requested again.
Userland process would simply try to reset the flag periodically.

There's a lot of possible variations - basically, with that stuff done
we get remount logics into sane shape and that allows a lot of interesting
things.  *Besides* the immediate results (per-subtree read-only).


So there...  It certainly appears to be doable, it doesn't require too
nasty surgery of in-kernel APIs and it's splittable into reasonably small
steps that make sense on their own.  If somebody would start doing that
they'd have to do (accurately) verification of correctness on each step -
thing that is missing in the above and can require dealing with problems
I'd overlooked.  FWIW, my gut feeling from looking at that stuff is that
there won't be anything too nasty, but that needs to be checked if
somebody will start that work - the stuff above is a quick and dirty
attempt of a roadmap, but there might be pits with something unpleasant.

I would estimate that as 3-4 months' work / 4-6 months on gradual merge
(started in parallel) / several months of playing with the results
after the semantics of remount will be sanitized.  YMMV.
-
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


-------------------- End of forwarded message --------------------
