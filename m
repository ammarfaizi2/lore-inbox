Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbULABVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbULABVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbULABUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:20:06 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:20645 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261247AbULABR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:17:56 -0500
Message-ID: <41AD1B52.7040008@comcast.net>
Date: Tue, 30 Nov 2004 20:16:02 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Designing Another File System
References: <41ABF7C5.5070609@comcast.net> <41AC7086.1030005@hist.no>
In-Reply-To: <41AC7086.1030005@hist.no>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Helge Hafting wrote:
| John Richard Moser wrote:
|
|> -----BEGIN PGP SIGNED MESSAGE-----
|> Hash: SHA1
|>
|> Greetings.
|>
|> I've been interested in file system design for a while, and I think I
|> may be able to design one.  Being poor, I would like to patent/sell it
|> when done;
|
|
| Well, if you want to make money - you get to do the work.  Including
| the initial research into filesystem design.
|

Eh, you're probably right; but I thought all idealistic open source
advocates considered the fruits of the work to be proper return to the
community >:P

Anyway, I dunno how I'd go about any of that anyway.  The thoughts have
crossed my mind though, as they should yours when you're poor and living
in your parents' house.

I'll definitely code it myself if I decide to sell licenses to use the
code in closed source products; I can't sell other peoples' work, it
doesn't work that way.

|> however, whatever the result, I'd assuredly give a free
|> license to implement the resulting file system in GPL2 licensed code (if
|> you're not making money off it, I'm not making money off it).  This is
|> similar in principle to how Hans Reiser sells his file system I think.
|
|
| GPL means no restrictions, you can't prevent, say, redhat from
| selling distro CDs with your GPL'ed fs.  As for _patenting_ it, well,
| people here generally dislike software patents for good reasons.
| You don't need a patent for this either - a copyright is probably
| what you're after.
|

MySQL, Dan's Guardian.  They cost for business use.

As for "no restrictions," remember that GPL means you can't just
incorporate the code into your closed source product.  A few GPL
projects have been known to sell separate licenses (reiserfs I thought
did this) to allow such an incorporation of their work.  If i.e. Apple
wants *me* to write them a driver for the FS, fine, they can pay me
royaltees too.

|>
|> 2)  Are there any other security concerns aside from information leaking
|> (deleted data being left over on disk, which may pop up in incompletely
|> written files)?
|
|
| Have you considered what kind of data loss you'll get if power fails
| before stuff is written to disk, or while it is being written?  That sort
| of thing is important to users, because it really happens a lot.  Can you
| design so a good fsck for your fs is possible?
|

Data loss can't really be helped.  Either the data makes it to disk or
it doesn't; data goes after allocation, but even a full journal won't
save me data loss.  A rollback journal "might," if the entire change to
the file from fopen() to fclose() is exactly one transaction; else, no.

As for a good fsck, call Sally.  :)

Actually a fsck shouldn't be too hard; inode blocks and fragment blocks
will be self-identifying and indexing, so even if the bitmap is lost,
the whole thing can be rebuilt *if* you know the exact offset of the
data area, the FS version, and the block size.

|> 6)  How do I lay out a time field for atime/dtime/ctime/mtime?
|>
| Any way you like, as long as you actually store the information
| in a retrieveable way.
|

What information is that?

|>
|> A few more specifics, as Block size grows, the file system does not lose
|> efficiency.  Fragment Blocks should skillfully subdivide huge Blocks
|> with a third level index, increasing seek time O(+1) for the information
|> stored in the Fragment Block:
|>
|>
|> - -Inode
|> |-Meta-data
|> ||-Data Block
|> |||-Data (2 seeks)
|> ||-Fragment Block
|> |||-Fragment
|> ||||-Data (3 seeks)
|>
|>
|> Fragment Blocks can store anything but Inodes, so it would be advisable
|> to avoid huge Blocks; if a Block is 25% of the disk, for example, one
|> Block must be dedicated to serving up Inode information.  Also, with
|> 64KiB blocks, a 256TiB file system can be created.  Larger Blocks will
|> allow larger file systems; a larger file system will predictably house
|> more files (unless it houses one gargantuan relational data base-- the
|> only plausible situation where my design would require more, smaller
|> blocks to be more efficient).
|>
|> Directories will have to be some sort of on disk BsomethingTree. . . B*,
|> B+, something.  I have no idea how to implement this :D  I'll assume I
|
|
| Then you have a lot to learn about fs design - before you can
| design anything _sellable_.  Take a look at the details of
| existing linux fs'es - and be happy that you can do that at all because
| they aren't patented or otherwise restricted.

I still think patents are a good thing, if the patent owners have half a
brain.  For example, Judy Arrays ( http://judy.sf.net/ ) are patented by
HP; their design is LGPL though.  "Patented" doesn't equivilate to "Out
of reach" by nature, just by controller.

|
|> treat the directory data as a logically contiguous file (yes I'm gonna
|> store directory data just like file data).  I could use a string hash of
|> the Directory Entry name with disambiguation at the end, except my
|> options here seem limited:
|>
|>
|> - - Use a 32 bit string hash, 4 levels, 8 bits per level.  256 entries of
|> 32 bit {offset} for the next level per level, 1024B per level on unique
|> paths.  Worst case 1 path per file, 65536 files in the worst case
|> measure 1 root (1KiB) + 256 L2 (256KiB) + 65536 L3 (64M) + 65536 L4
|> (64M), total 128MiB, collision rate is probably low.  Ouch.
|>
|> - - Use a 16 bit string hash, 2 levels, 8 bits per level.  256 entries of
|> 32 bit {offset) for the next level per level, 1024B per level on unique
|> path.  Worst case 1 path per file, 65536 files in the worst case measure
|> 1 root (1KiB) + 256 L2 (256KiB), no disambiguation, though collision
|> rate is probably higher than that.  Beyond 65536 creates collisions.
|> Hitting a disambiguation situation is going to be fairly common.
|>
|>
|> I guess the second would be better?  I can't locate any directories on
|> my drive with >2000 entries *shrug*.  The end key is just the entry
|> {name,inode} pair.
|
|
| If you want this fs to be generically used, expect some people to show
| up with millions of files in a directory or tens of millions. They will
| not be amused if the lookup isn't O(1). . .
|
| There are still fs'es around that don't look up names in O(1)
| time, but some O(1) fs'es exist.  So, to _sell_ you need to be among the
| better ones.
|
|> Any ideas?
|>
| Write a serious free fs, and get help here.  Or go commercial - sell
| your fs and pay your developers and helpers.
|

Well, I'm not Hans Reiser, so I guess DARPA isn't going to give me $13M;
selling this thing (even if I can outrank everyone in the world by leaps
and bounds) isn't going to make me instantly rich.  Even if it would,
nobody's gonna help me with it like that; and I don't have the skill to
do this myself.

Ah why not.

| Helge Hafting
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBrRtPhDd4aOud5P8RAkhgAJ95lOJFvG+cHpOrWyDGn1/VZlFhzQCdGP/p
T8b0J6idnUgZY/uS35FVRZc=
=Vr0i
-----END PGP SIGNATURE-----
