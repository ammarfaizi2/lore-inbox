Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbUA1KzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 05:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265906AbUA1KzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 05:55:21 -0500
Received: from c215027.adsl.hansenet.de ([213.39.215.27]:50056 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S265904AbUA1KzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 05:55:03 -0500
Message-ID: <401794F4.80701@portrix.net>
Date: Wed, 28 Jan 2004 11:54:44 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 on raid5 failure
References: <400A5FAA.5030504@portrix.net> <20040118180232.GD1748@srv-lnx2600.matchmail.com> <20040119153005.GA9261@thunk.org> <4010D9C1.50508@portrix.net> <20040127190813.GC22933@thunk.org>
In-Reply-To: <20040127190813.GC22933@thunk.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9CE19E66DCA280A594718B74"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CE19E66DCA280A594718B74
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Theodore Ts'o wrote:
> On Fri, Jan 23, 2004 at 09:22:25AM +0100, Jan Dittmer wrote:
> 
>>Okay, I fscked all filesystems in single user mode, thereby fscked up my 
>>root filesystem, though I didn't even check it - so I restored it from 
>>backup (grub wouldn't even load anymore).
> 
> 
> What messages were printed by e2fsck while it was running --- and was
> all of the filesystems unmounted, excepted for the root filesystem,
> which should have been mounted read-only?
> 
Yep it was all unmounted. But I don't have a transcript of this session. 
I was directly logged in, sorry.

> 
>>After 2 days in my freshly setup debian (2.6.1-bk6), same error. But 
>>this time at least I know it's because I tried to delete those files in 
>>the lost+found directory...
> 
> 
> How did you come to that conclusion?

sfhq:/mnt/data/1/lost+found# ls -l
total 76
d-wSr-----    2 1212680233 136929556    49152 Jun  7  2008 #16370
-rwx-wx---    1 1628702729 135220664    45056 May  4  1974 #16380
sfhq:/mnt/data/1/lost+found# rm *
rm: cannot remove `#16370': Operation not permitted
rm: cannot remove `#16380': Operation not permitted
sfhq:/mnt/data/1/lost+found# rm *
rm: cannot remove `#16370': Operation not permitted
rm: cannot remove `#16380': Operation not permitted
sfhq:/mnt/data/1/lost+found# rm *
rm: cannot remove `#16370': Operation not permitted
rm: cannot remove `#16380': Operation not permitted
sfhq:/mnt/data/1/lost+found# dmesg
EXT3-fs error (device dm-2): ext3_readdir: directory #16370 contains a 
hole at offset 8192
Aborting journal on device dm-2.
EXT3-fs error (device dm-2): ext3_readdir: directory #16370 contains a 
hole at offset 24576
ext3_abort called.
EXT3-fs abort (device dm-2): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only

This is with 2.6.1-bk6 and no concurrent access. With 2.4.25-pre7-pac1 
this does not happen.
So I rechecked the filesystem (with 2.4), hoping it won't get corrupted 
  and I would be able to delete the files, but:

sfhq:~# fsck /dev/myraid/lvol1
fsck 1.35-WIP (07-Dec-2003)
e2fsck 1.35-WIP (07-Dec-2003)
/dev/myraid/lvol1 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Directory inode 16370 has an unallocated block #2.  Allocate<y>? yes

Directory inode 16370 has an unallocated block #6.  Allocate<y>? yes

Pass 3: Checking directory connectivity
Pass 3A: Optimizing directories
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/myraid/lvol1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/myraid/lvol1: 2341/45514752 files (24.0% non-contiguous), 
82194611/91002880 blocks

still no luck with undeleting these files

sfhq:/mnt/data/1/lost+found# rm -rf *
rm: cannot remove directory `#16370': Operation not permitted
rm: cannot remove `#16380': Operation not permitted

sfhq:/mnt/data# dumpe2fs /dev/myraid/lvol1
dumpe2fs 1.35-WIP (07-Dec-2003)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          ba3f83cd-04c8-4c4d-82f7-990077aabb73
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal dir_index needs_recovery sparse_super
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              45514752
Block count:              91002880
Reserved block count:     3640115
Free blocks:              8808269
Free inodes:              45512411
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16384
Inode blocks per group:   512
Filesystem created:       Thu Jul  3 13:57:02 2003
Last mount time:          Wed Jan 28 11:48:13 2004
Last write time:          Wed Jan 28 11:48:13 2004
Mount count:              2
Maximum mount count:      23
Last checked:             Wed Jan 28 11:47:06 2004
Check interval:           15552000 (6 months)
Next check after:         Mon Jul 26 12:47:06 2004
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal inode:            8
Default directory hash:   tea
Directory Hash Seed:      a7fd0c53-efe9-4316-9fa6-e3206623f4fe
Journal backup:           inode blocks

Do you need the complete output? Btw. I have the same error on another 
partition (also on raid5, dm).

Thanks,

Jan


--------------enig9CE19E66DCA280A594718B74
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAF5T0LqMJRclVKIYRAlJaAJ4v1yJ0mgo3jlnc5Ep9o0vLmMsdHgCgh05S
JwB/xaeJyCitxNDNfJm7h6o=
=6t+v
-----END PGP SIGNATURE-----

--------------enig9CE19E66DCA280A594718B74--
