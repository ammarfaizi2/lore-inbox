Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbULABqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbULABqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbULABoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:44:08 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:38812 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261237AbULABma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:42:30 -0500
Message-ID: <41AD218E.7090305@comcast.net>
Date: Tue, 30 Nov 2004 20:42:38 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phil Lougher <phil.lougher@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Designing Another File System
References: <41ABF7C5.5070609@comcast.net> <cce9e37e041130112243beb62d@mail.gmail.com>
In-Reply-To: <cce9e37e041130112243beb62d@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Phil Lougher wrote:
| On Mon, 29 Nov 2004 23:32:05 -0500, John Richard Moser
| <nigelenki@comcast.net> wrote:
|
|
|>- - localization of Inodes and related meta-data to prevent disk thrashing
|
|
| All filesystems place their filesystem metadata inside the inodes.  If
| you mean file metadata then please be more precise.  This isn't
| terribly new, recent posts have discussed how moving eas/acls inside
| the inode for ext3 has sped up performance.
|

I got the idea from FFS and its derivatives (UFS, UFS2, EXT2).  I don't
want to store xattrs inside inodes though; I want them in the same block
with the inode.  A few mS for the seek, but eh, the data's right there,
not on the other side of the disk.

|
|>- - a scheme which allows Inodes to be dynamically allocated and
|>deallocated out of order
|>
|
|
| Um,  all filesystems do that, I think you're missing words to the
| effect "without any performance loss or block fragmentation" !

All filesystems allow you to create the FS with 1 inode total?


Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/hda1            7823616  272670 7550946    4% /

No, it looks like this one allocates many inodes and uses them as it
goes.  Reiser has 0 inodes . . .

|
|
|>- - 64 bit indices indicating the exact physical location on disk of
|>Inodes, giving a O(1) seek to the Inode itself
|
|
|>1)  Can Unix utilities in general deal with 64 bit Inodes?  (Most
|>programs I assume won't care; ls -i and df -i might have trouble)
|>
|
|
| There seems to be some confusion here.  The filesystem can use 64 bit
| inode numbers internally but hide these 64 bits and instead present
| munged 32 bit numbers to Linux.
|
| The 64 bit resolution is only necessary within the filesystem dentry
| lookup function to go from a directory name entry to the physical
| inode location on disk.  The inode number can then be reduced to 32
| bits for 'presentation' to the VFS.  AFAIK as all file access is
| through the dentry cache this is sufficient.  The only problems are
| that VFS iget() needs to be replaced with a filesystem specific iget.
| A number of filesystems do this.  Squashfs internally uses 37 bit
| inode numbers and presents them as 32 bit inode numbers in this way.
|

Ugly, but ok.  What happens when i actually have >4G inodes though?

|
|>3)  What basic information do I absolutely *need* in my super block?
|>4)  What basic information do I absolutely *need* in my Inodes? (I'm
|>thinking {type,atime,dtime,ctime,mtime,posix_dac,meta_data_offset,size,\
|>links}
|
|
| Very much depends on your filesystem.  Cramfs is a good example of the
| minimum you need to store to satisfy the Linux VFS.  If you don't care
| what they are almost anything can be invented (uid, gid, mode, atime,
| dtime etc) and set to a useful default.  The *absolute* minimum is
| probably type, file/dir size, and file/dir data location on disk.

I meant basic, not for me.  Basic things a real Unix filesystem needs.
What *I* need comes from my head.  :)

|
|
|>I guess the second would be better?  I can't locate any directories on
|>my drive with >2000 entries *shrug*.  The end key is just the entry
|>{name,inode} pair.
|
|
| I've had people trying to store 500,000 + files in a Squashfs
| directory.  Needless to say with the original directory implementation
| this didn't work terribly well...
|

Ouch.  Someone told me the directory had to be O(1) lookup . . . .

| Phillip Lougher
|

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBrSGNhDd4aOud5P8RAlo0AJ4pxB/LMhgTvNW4GdMmaNA2/uM0wACfWR8+
kOxwHU3/mTUUNAAhda2rv+g=
=fsJV
-----END PGP SIGNATURE-----
