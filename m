Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWAVGno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWAVGno (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 01:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWAVGno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 01:43:44 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:20460 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750831AbWAVGno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 01:43:44 -0500
Message-ID: <43D3295E.8040702@comcast.net>
Date: Sun, 22 Jan 2006 01:42:38 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: soft update vs journaling?
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

So I've been researching, because I thought this "Soft Update" thing
that BSD uses was some weird freak-ass way to totally corrupt a file
system if the power drops.  Seems I was wrong; it's actually just the
opposite, an alternate solution to journaling.  So let's compare notes.

I'm not quite clear on what the benefits versus costs of Soft Update
versus Journaling are, so I'll run down what I got, and anyone who wants
to give input can run down on what they got, and we can compare.  Maybe
someone will write a Soft Update system into Linux one day, far, far
into the future; but I doubt it.  It might, however, be interesting to
compare ext2 + SU to ext3; and giving the chance to solve problems such
as delayed delete (i.e. file system fills up while soft update has not
yet executed a delete; try reacting by looking for a delete to suddenly
actually execute) might also be cool.


Soft Update appears to buffer and order meta-data writes in a dependency
scheme that makes certain that inconsistencies can't happen.  Apparently
this means writing up directory entries before inodes, or something to
that effect.  I can't see how this would help in the middle of a buffer
flush (half a dentry written?  Partially deleted inode?  Inode "deleted"
but not freed from disk?), so maybe someone can fill me in.

Journaling apparently means writing out meta-data to a log before
transferring it to the file system.  No matter what happens, a proper
journal (for fun I've designed a transaction log format for low level
filesystems; it's entirely possible to have interrupt at any bit
recoverable) can always be checked over and either rolled back or rolled
forward.  This is easy to design.

Soft Update appears to have the advantage of not needing multiple
writes.  There's no need for journal flushing and then disk flushing;
you just flush the meta-data.  Also, soft update systems mount
instantly, because there's no journal to play back, and the file system
is always consistent.  It may be technically feasible to impliment soft
update on any old file system; I'm unclear as to how exactly to make any
soft-update work, so I can't say if this is absolutely possible (think
for vfat, consistent at all times and still Win32 compatible; great for
flash drives).

Unfortunately, soft update can leave retarded situations where areas of
disk are allocated still after a system failure during an inode delete.
 This won't cause inconsistencies in the on-disk structure, however; you
can freely use the disk without causing even more damage.  The system
just has to sanity check stuff while running and clean up such damage as
it sees it.

Journaling appears to have the advantage that the data gets to disk
faster.  It also seems easier a concept to grasp (i.e. I understand it
fully).  It's old, tried, trusted, and durable.  You also don't have to
worry about having odd meta-data writes that leave deleted files around
in certain circumstances, eating up space.

Unfortunately, journaling uses a chunk of space.  Imagine a journal on a
USB flash stick of 128M; a typical ReiserFS journal is 32 megabytes!
Sure it could be done in 8 or 4 or so; or (in one of my file system
designs) a static 16KiB block could reference dynamicly allocated
journal space, allowing the system to sacrifice performance and shrink
the journal when more space is needed.  Either way, slow media like
floppies will suffer, HARD; and flash devices will see a lot of
write/erase all over the journal area, causing wear on that spot.

So, that's my understanding.  Any comments?  Enlighten me.
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD0yldhDd4aOud5P8RAhzBAJwOvWpAYb+m3Zg8ugnvuY10K74jZgCeL69s
y0172JATNX+q8jzrYGAJ/xc=
=7Dcn
-----END PGP SIGNATURE-----
