Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269395AbRHaU4o>; Fri, 31 Aug 2001 16:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269390AbRHaU4f>; Fri, 31 Aug 2001 16:56:35 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60331 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269356AbRHaU4Q>;
	Fri, 31 Aug 2001 16:56:16 -0400
Date: Fri, 31 Aug 2001 16:56:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [RFD] readonly/read-write semantics
In-Reply-To: <Pine.LNX.4.31.0108311620540.3977-100000@sisley.ri.silicomp.fr>
Message-ID: <Pine.GSO.4.21.0108311558430.15931-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Folks, stuff below is, IMNSHO, worth a discussion.  Please, give it
a thought.  Short summary: we need well-defined semantics for
read-only/read-write. Currently we don't have any.

On Fri, 31 Aug 2001, Jean-Marc Saffroy wrote:

(first the trivial part)

> Hello,
> 
> 
> In 2.4.9, I have encountered a strange condition while playing with file
> structs chained on a superblock list (sb->s_files) : some of them can have
> a NULL f_dentry pointer. The only case I found which can cause this is
> when fput is called and f_count drops to zero. Is that the only case ?

Yes, it is, and yes, it's legitimate - code that scans that list should
(and in-tree one does) deal with such case.
 
> While exploring the corresponding code for an explanation, I found what
> looks like a possible race condition : do_remount_sb calls
> fs_may_remount_ro, and only then uses lock_super to do the actual remount.
> 
> Isn't it possible for a program to open a file for writing just after
> fs_may_remount_ro ? The whole thing seems to be protected by the BKL and
> mount_sem, but I guess it won't stop an open.

... and here comes the serious stuff.

mount_sem, BKL and lock_super() have nothing to checks done in the open().

fs_may_remount_ro() is, indeed, racy and had been since very long.
However, the main problem is not in opening something after the
check - the check itself is not exact enough.

Think what happens if the object we hold for writing doesn't currently
have struct file.  At all.  E.g. it is a directory in the middle of
subdirectory creation.

Or, for that matter, combine that with "what happens if we do ...
after we've done the checks" - e.g. consider mkdir() called after
the check.  Or unlink() on opened file driving ->i_nlink to 0.

What we need is a "I want rw access to fs"/"I give up rw access"/"make
it ro" set of primitives.  Unfortunately, it's even more compilcated -
e.g. fs may stomp its foot and set MS_RDONLY in ->s_flags (e.g. upon
finding an error if it has such policy).  That DOESN'T look for files
opened for write (reasonable) and DOESN'T revoke write access to them.

So you end up with fs that is claimed to be r/o, but people still have
files opened for write.

We need clear semantics for readonly/read-write state of filesystems.
Until then all we have is "well, if you go single-user before remount
or otherwise prevent users from access to mountpoit - you should be OK".

Which, BTW, is not _too_ unreasonable, since otherwise you are gambling
on the fact that users won't make the sucker busy in the wrong moment.
More clean solution would be "revoke everyone's write access and remount
r/o", but that will take quite an effort.  Which might be worth doing.

Again, the main issue here is what do we want, not how to implement it.
Flame away.

