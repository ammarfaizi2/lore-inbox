Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUJBHvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUJBHvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 03:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUJBHvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 03:51:36 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:60526 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S267341AbUJBHvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 03:51:32 -0400
Message-ID: <415E5EE6.3010800@novell.com>
Date: Sat, 02 Oct 2004 03:55:18 -0400
From: Jeff Mahoney <jeffm@novell.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] Race with iput and umount
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070108090809070503050105"
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070108090809070503050105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hey all -

There is currently no method in the superblock shutdown path to
determine if all inodes associated with the superblock are completely
quiesced. invalidate_inodes() will attempt to flush out inodes still
hanging around, but if inodes are in the iput() path, it's possible for
them to be removed from the inode list and in the ->delete_inode fs
method, which isn't protected by inode_lock any longer.
generic_shutdown_super() will happily call the ->put_super fs method,
destroying data structures still in use by the iput (->delete_inode) in
progress.  That's where Oopsen come into play.

The unlink path will call the ->unlink fs method, release the path (thus
dropping the reference to the vfsmount, and then call iput. Since the
vfsmount reference is dropped back to 1, a umount will succeed, causing
the superblock to be cleaned up.

This doesn't trigger during read/write or if pwd is inside the
filesystem, since open files and working directories also cause an
incremented vfsmount->mnt_count.

I've triggered Oopsen on 2.6.5, 2.6.8, 2.6.9-rc2, and 2.6.9-rc3 using
reiserfs, ext2, and ext3. Presumably, most (all?) 2.6 should be susceptible.

Attached is a script I've used to reliably trigger this bug. I'll
continue to track this down, but figured I'd post a heads up so more
eyes would see it.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBXl7mLPWxlyuTD7IRAu3VAJ4r/sFAX6dOr6WMpLh6YykmhBxo7gCgoluP
dpoTUfCqGZIVWeFJ1rc8yOI=
=lj86
-----END PGP SIGNATURE-----

--------------070108090809070503050105
Content-Type: application/x-sh;
 name="45004.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="45004.sh"

#!/bin/sh

#in MB
SIZE=5000

DEV=/dev/hda8
MP=/media/testdev

mount $DEV $MP

echo "Creating file.. "
dd if=/dev/zero of=$MP/file bs=1M count=$SIZE

echo "Starting to remove file (background)"
rm $MP/file &

echo "Trying to umount (background)"
( while ! umount $MP; do sleep 1; done) &
wait

--------------070108090809070503050105--
