Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbRG2N5I>; Sun, 29 Jul 2001 09:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267996AbRG2N46>; Sun, 29 Jul 2001 09:56:58 -0400
Received: from Odin.AC.HMC.Edu ([134.173.32.75]:19380 "EHLO odin.ac.hmc.edu")
	by vger.kernel.org with ESMTP id <S267532AbRG2N4r>;
	Sun, 29 Jul 2001 09:56:47 -0400
Date: Sun, 29 Jul 2001 06:56:54 -0700 (PDT)
From: Nate Eldredge <neldredge@hmc.edu>
To: linux-kernel@vger.kernel.org
Subject: International crypto patches and new kernels
Message-ID: <Pine.LNX.4.21.0107290655030.19655-100000@odin.ac.hmc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The International crypto patches do not appear to work with the latest
kernels.

The latest patch I can find is one against 2.4.5-ac11, at
http://www.bzimage.org/kernel-patches/v2.4/alan/v2.4.5/patch-2.4.5-ac11-crypto.bz2
.  This works when applied to 2.4.5-ac11.  However, I tried applying
it to 2.4.6-ac5.  It applies all right (a couple of offset hunks, and
the diffs of debian control files obviously fail, because the files
aren't there on my system).  But when I boot it and attempt to use
loopback encryption, the mount fails with -EINVAL and the kernel emits
the following messages.

attempt to access beyond end of device
07:02: rw=0, want=10241, limit=10240
EXT2-fs: unable to read group descriptors

Further attempts to fsck the device results in:

e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
fsck.ext2: Attempt to read block from filesystem resulted in short read
while trying to open /dev/loop2
Could this be a zero-length partition?

If I losetup -d the device and losetup it again, fsck succeeds, but
mounting still fails.

Here's what I'm doing to make it fail.

CIPHER=aes
KEYSIZE=256
LOOPDEV=/dev/loop2
FILE=/spare/encrypted-image
SIZE=10240 # kbytes
PASSWORD=12345
MOUNTPOINT=/mnt/scratch
FS=ext2
TESTFILE=$MOUNTPOINT/testfile
TESTSTRING="This is a test."

dd if=/dev/zero of=$FILE bs=1k count=$SIZE
echo $PASSWORD |losetup -e $CIPHER -k $KEYSIZE -p 0 $LOOPDEV $FILE
mkfs.$FS $LOOPDEV			# works
fsck.$FS -f $LOOPDEV			# passes
mount -t $FS $LOOPDEV $MOUNTPOINT	# fails as above
echo $TESTSTRING > $TESTFILE		# obviously fails
umount $MOUNTPOINT			# the same
fsck.$FS -f $LOOPDEV			# fails as above
losetup -d $LOOPDEV
echo $PASSWORD |losetup -e $CIPHER -k $KEYSIZE -p 0 $LOOPDEV $FILE
fsck.$FS -f $LOOPDEV			# passes
mount -t $FS $LOOPDEV $MOUNTPOINT	# still fails


I have also tried with FS=minix, CIPHER=twofish, and KEYSIZE=128, and
I've tried putting FILE on ext2 and reiserfs partitions.  None of them
helps.

I think I have gotten the initial mount to succeed in previous tests,
but I can't reproduce it now.  In any case, further attempts to mount
fail.

The same patch applied to 2.4.7-ac2 fails similarly.

-- 

Nate Eldredge
neldredge@hmc.edu

