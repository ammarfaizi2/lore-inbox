Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284916AbRLRUQN>; Tue, 18 Dec 2001 15:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284928AbRLRUQD>; Tue, 18 Dec 2001 15:16:03 -0500
Received: from mail.myrio.com ([63.109.146.2]:14580 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S284916AbRLRUPt>;
	Tue, 18 Dec 2001 15:15:49 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB09@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'andersen@codepoet.org'" <andersen@codepoet.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "'viro@math.psu.edu'" <viro@math.psu.edu>
Subject: RE: ramdisk corruption problems - was: RE: pivot_root and initrd 
	kern el panic woes
Date: Tue, 18 Dec 2001 12:14:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More information!  And a workaround!

I conjecture that the ramdisk driver (post 2.4.9) only grabs
VM pages properly if it is accessed directly, as a dd to 
/dev/ram0 does.  I further conjecture that accessing the 
ramdisk through a mounted filesystem does not grab pages 
properly.

The reason I believe this is that removing the call to 
"freeramdisk" from my original script avoids corruption.  

Another way to avoid ramdisk corruption is to 
"dd if=/dev/zero of=/dev/ram0 bs=1k count=4000" 
immediately after the call to freeramdisk.

If my conjecture is right, then the corruption is caused 
because mke2fs on a "freed" /dev/ram0 doesn't touch every 
block of the fs, leaving "holes" where pages are not properly 
grabbed from the VM. The resulting filesystem appears to work, 
but dd'ing from /dev/ram0 gets a broken filesystem image.

Note that "freeramdisk /dev/ram0" is pretty much just:
#define FLKFLSBUF  _IO(0x12,97) /* flush buffer cache */
f = open("/dev/ram0", O_RDWR);
ioctl(f, BLKFLSBUF);

To experiment for yourself, stick the following script in
a subdirectory which also contains a "testdir" directory
with about 3 MB of data.

- - - - - - - -
#!/bin/bash

# to tickle the bug, do the freeramdisk but not the
# dd from /dev/zero to /dev/ram0.  

freeramdisk /dev/ram0
#dd if=/dev/zero of=/dev/ram0 bs=1k count=4000

mke2fs -m0 /dev/ram0 4000
mount -t ext2 /dev/ram0 /mnt/ramdisk
rm -rf /mnt/ramdisk/*

cp -a ./testdir /mnt/ramdisk
umount /dev/ram0

dd if=/dev/ram0 of=ram0.img bs=1k count=4000
dd if=ram0.img of=/dev/ram0 bs=1k count=4000

mount -t ext2 /dev/ram0 /mnt/ramdisk
diff -q -r ./testdir /mnt/ramdisk/testdir

# If diff reports mismatches, you saw the bug.

umount /dev/ram0
- - - - - - - -

If the gods of the VM and VFS don't bother to look at 
it, I might take a peek at the relevant kernel code myself.  
Might take two months of study before I know enough though.

Torrey

