Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUK3EcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUK3EcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbUK3EcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:32:14 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:22407 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261976AbUK3EcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:32:03 -0500
Message-ID: <41ABF7C5.5070609@comcast.net>
Date: Mon, 29 Nov 2004 23:32:05 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Designing Another File System
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greetings.

I've been interested in file system design for a while, and I think I
may be able to design one.  Being poor, I would like to patent/sell it
when done; however, whatever the result, I'd assuredly give a free
license to implement the resulting file system in GPL2 licensed code (if
you're not making money off it, I'm not making money off it).  This is
similar in principle to how Hans Reiser sells his file system I think.

I've examined briefly the overall concepts which go into several file
systems and pooled them together to create my basic requirements.  In
these include things such as:


- - a new journaling method that scales up and down to high loads and
small devices

- - localization of Inodes and related meta-data to prevent disk thrashing

- - a scheme which allows Inodes to be dynamically allocated and
deallocated out of order

- - 64 bit indices indicating the exact physical location on disk of
Inodes, giving a O(1) seek to the Inode itself

- - A design based around preventing information leaking by guaranteed
secure erasure of data (insofar that the journal even will finish wiping
out data when replaying a transaction)


I have 6 basic questions.


1)  Can Unix utilities in general deal with 64 bit Inodes?  (Most
programs I assume won't care; ls -i and df -i might have trouble)

2)  Are there any other security concerns aside from information leaking
(deleted data being left over on disk, which may pop up in incompletely
written files)?

3)  What basic information do I absolutely *need* in my super block?

4)  What basic information do I absolutely *need* in my Inodes? (I'm
thinking {type,atime,dtime,ctime,mtime,posix_dac,meta_data_offset,size,\
links}

5)  What basic information do I absolutely *need* in my directory
entries? (I'm thinking {name,inode})

6)  How do I lay out a time field for atime/dtime/ctime/mtime?


A few more specifics, as Block size grows, the file system does not lose
efficiency.  Fragment Blocks should skillfully subdivide huge Blocks
with a third level index, increasing seek time O(+1) for the information
stored in the Fragment Block:


- -Inode
|-Meta-data
||-Data Block
|||-Data (2 seeks)
||-Fragment Block
|||-Fragment
||||-Data (3 seeks)


Fragment Blocks can store anything but Inodes, so it would be advisable
to avoid huge Blocks; if a Block is 25% of the disk, for example, one
Block must be dedicated to serving up Inode information.  Also, with
64KiB blocks, a 256TiB file system can be created.  Larger Blocks will
allow larger file systems; a larger file system will predictably house
more files (unless it houses one gargantuan relational data base-- the
only plausible situation where my design would require more, smaller
blocks to be more efficient).

Directories will have to be some sort of on disk BsomethingTree. . . B*,
B+, something.  I have no idea how to implement this :D  I'll assume I
treat the directory data as a logically contiguous file (yes I'm gonna
store directory data just like file data).  I could use a string hash of
the Directory Entry name with disambiguation at the end, except my
options here seem limited:


- - Use a 32 bit string hash, 4 levels, 8 bits per level.  256 entries of
32 bit {offset} for the next level per level, 1024B per level on unique
paths.  Worst case 1 path per file, 65536 files in the worst case
measure 1 root (1KiB) + 256 L2 (256KiB) + 65536 L3 (64M) + 65536 L4
(64M), total 128MiB, collision rate is probably low.  Ouch.

- - Use a 16 bit string hash, 2 levels, 8 bits per level.  256 entries of
32 bit {offset) for the next level per level, 1024B per level on unique
path.  Worst case 1 path per file, 65536 files in the worst case measure
1 root (1KiB) + 256 L2 (256KiB), no disambiguation, though collision
rate is probably higher than that.  Beyond 65536 creates collisions.
Hitting a disambiguation situation is going to be fairly common.


I guess the second would be better?  I can't locate any directories on
my drive with >2000 entries *shrug*.  The end key is just the entry
{name,inode} pair.

Any ideas?

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBq/fEhDd4aOud5P8RAofxAJ4hBzZfFiLAyU413zNj2jVqlLzXWACfcaqd
4iwnewSp2xKrO94F9TF6dSY=
=ZKm6
-----END PGP SIGNATURE-----
