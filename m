Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbUBUUXY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 15:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUBUUXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 15:23:24 -0500
Received: from torham.dlitz.net ([24.72.34.179]:16782 "HELO
	bernstein.dlitz.net") by vger.kernel.org with SMTP id S261617AbUBUUXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 15:23:20 -0500
Date: Sat, 21 Feb 2004 14:24:24 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2 ext3 loopback bug with data=journal
Message-ID: <20040221202424.GA25120@rivest.dlitz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Homepage: http://www.dlitz.net/
X-PGP-Public-Key-URL: http://www.dlitz.net/go/gpgkey
X-PGP-ID: 0xE272C3C3
X-PGP-Fingerprint: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux rivest.dlitz.net 2.4.23-1um
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting an error message upon running e2fsck on a freshly-created 
ext3 loopback filesystem:

	Superblock has a bad ext3 journal (inode 8).
	Clear? yes

	*** ext3 journal has been deleted - filesystem is now ext2 only ***

How to reproduce the bug:
	
	# /tmp is on an ext3 filesystem mounted with data=journal
	# Create a 1 GiB (approx) empty file
	# (note that the bug still appears when using a non-sparse file)
	dd if=/dev/zero of=/tmp/dummyfs bs=1k count=1 seek=1M
	# Make the filesystem
	mke2fs -j -F /tmp/dummyfs
	# Check the filesystem.  This will find errors and delete the 
	# journal
	e2fsck -y /tmp/dummyfs

Things that cause the bug to *not* be reproduced:

	- mount /tmp with data=ordered instead of data=journal
	- create a 2GB ext2 loopback filesystem somewhere, and mount it 
	  over /tmp before executing the code above (i.e. put another 
	  filesystem layer in between mke2fs and the buggy ext3 filesystem)

I've included more verbose output below.

Also, I don't read linux-kernel much these days, so please Cc: me if you 
want me to reply.

-- 
Dwayne C. Litzenberger <dlitz@dlitz.net>

---- BEGIN OUTPUT ----
gando:~# dd if=/dev/zero of=/tmp/dummyfs bs=1k count=1 seek=1M
1+0 records in
1+0 records out
1024 bytes transferred in 0.000747 seconds (1370992 bytes/sec)
gando:~# mke2fs -j -F /tmp/dummyfs
mke2fs 1.35-WIP (21-Aug-2003)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
131072 inodes, 262144 blocks
13107 blocks (5.00%) reserved for the super user
First data block=0
8 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376

Writing inode tables: done                            
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 37 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
gando:~# e2fsck -y /tmp/dummyfs
e2fsck 1.35-WIP (21-Aug-2003)
Superblock has a bad ext3 journal (inode 8).
Clear? yes

*** ext3 journal has been deleted - filesystem is now ext2 only ***

Superblock doesn't have has_journal flag, but has ext3 journal inode.
Clear? yes

/tmp/dummyfs was not cleanly unmounted, check forced.
Pass 1: Checking inodes, blocks, and sizes
Journal inode is not in use, but contains data.  Clear? yes

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -(521--8722)
Fix? yes

Free blocks count wrong for group #0 (24045, counted=32247).
Fix? yes

Free blocks count wrong (249815, counted=258017).
Fix? yes


/tmp/dummyfs: ***** FILE SYSTEM WAS MODIFIED *****
/tmp/dummyfs: 11/131072 files (0.0% non-contiguous), 4127/262144 blocks
gando:~# 
---- END OUTPUT ----
