Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265104AbUFWAUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265104AbUFWAUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 20:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUFWAUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 20:20:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35499 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265104AbUFWAUC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 20:20:02 -0400
Date: Wed, 23 Jun 2004 01:20:01 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Paul Jackson <pj@sgi.com>
Cc: viro@www.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/9) symlink patchkit (against -bk current)
Message-ID: <20040623002001.GC12308@parcelfarce.linux.theplanet.co.uk>
References: <E1Bcqs8-0003xN-Ee@www.linux.org.uk> <20040622155523.7754c2b5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622155523.7754c2b5.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 03:55:23PM -0700, Paul Jackson wrote:
> Al (or other),
> 
> Was there anything that described what these 9 patches are doing,
> overall?  They look intriguing, but I'm too lazy to read all the code
> in order to get the gist of them.  The per-patch comments at the top
> mention something of a "new scheme", but don't, that I noticed, explain
> what that means.  Perhaps something on lkml I missed ...?

My apologies (there was chunk #0 in the set, but I've fscked the
script up - `seq 9` instead of `seq 0 9`).  See below:

----------------------------------------------------------------------------

	Here's a patchkit that seriously reduces the stack footprint
of symlink resolution _and_ cleans the things up ->readlink()/->follow_link()
implementations.

How it works:
 	* ->follow_link() still does what it used to do - replaces
vfsmount/dentry in the nameidata it got from caller.  However, it
can also leave a pathname to be resolved by caller.
 	* we add an array of char * into nameidata; we always work
with nd->saved_names[nd->depth].  nd_set_link() sets it, nd_get_link()
returns it.
 	* callers of ->follow_link() (all two of them) check if
->follow_link() had left us something to do.  If it had (return
value was zero and nd_get_link() is non-NULL), they do __vfs_follow_link()
on that name.  Then they call a new method (->put_link()) that frees
whatever has to be freed, etc.

Note that absolute majority of symlinks have "resolve a pathname" as
part of their ->follow_link(); they can do something else and some
don't do that at all, but having that pathname resolution is very,
very common.
 
With that change we allow them to shift pathname resolution part
to caller.  They don't have to - it's perfectly OK to do all work
in ->follow_link().  However, leaving the pathname resolution to
caller will
	a) exclude foo_follow_link() stack frame from the picture
	b) kill 2 stack frames - all callers are in fs/namei.c
and they can use inlined variant of vfs_follow_link().

That reduction of stack use is enough to push the limit on nested
symlinks from 5 to 8 (actually, even beyond that, but since 8 is
common for other Unices it will do fine).
 
For those who have "pure" ->follow_link() (i.e. "find a string that would
be symlink contents and say nd_set_link(nd, string)") we also get a common
helper implementing ->readlink() - it just calls ->follow_link() on a
dummy nameidata, calls vfs_readlink() on result of nd_get_link() and
does ->put_link().   Using (or not using) it is up to filesystem; it's
a helper that can be used as a ->readlink() for many filesystems, not
a reimplementation of sys_readlink().  However, that's _MANY_ filesystems -
practically all of them.
 
Note that we don't put any crap like "if this is a normal symlink,
do this; otherwise call ->follow_link() and let it do its magic"
into callers - all symlinks are handled the same way.  Which was
the main problem with getlink proposal back then.  In a sense, the
situation is inverse - instead of implementing ->follow_link() via
new method very similar to ->readlink() we provide a helper that
can be used as ->readlink() _if_ ->follow_link() satisfies some
(very common) conditions.  If we need something trickier than
done by that helper - very well, fs should simply use whatever
code is suitable for it (presumably what it had always used as
->readlink()).

Change is backwards compatible - any filesystem that doesn't care to change
works as it always did.  We won't get any stack footprint reduction on the
symlinks from that fs, obviously, but that's exactly what we had until now.
When all filesystems switch to that scheme, we can safely raise the limit
on nested symlinks.  If some site knows that all filesystems they are using
are already there, they can obviously raise the limit for themselves not
waiting for the rest of the world...

Contents of patchkit (part that had been in -mm, that is):
        SL0: infrastructure - helpers allowing ->follow_link() to leave
a pathname to be traversed by caller + corresponding code in callers.

        SL1: ext2 conversion (helper functions for that one will be actually
used a lot by other filesystems, so to fs/namei.c they go)

        SL2: trivial cases - ones where we have no need to clean up after
pathname traversal (link body embedded into inode, etc.).  Plugged leak in
devfs_follow_link(), while we are at it.

        SL3: cases that can simply reuse ext2 helpers (page_follow_link_light()
and page_put_link()).

        SL4: smbfs - switched from on-stack allocation of buffer for link
body (!) to __getname()/putname(); switched to new scheme.

        SL5: xfs switched to new scheme; leaks plugged.

        SL6: shm switched (it almost belongs to SL3, but it does some extra
stuff after the link traversal).

        SL7: befs switched; leaks plugged.

        SL8: ditto for jffs2.
