Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRDOGh3>; Sun, 15 Apr 2001 02:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132581AbRDOGhT>; Sun, 15 Apr 2001 02:37:19 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:50959 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132580AbRDOGhJ>; Sun, 15 Apr 2001 02:37:09 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Can't free the ramdisk (initrd, pivot_root)
Date: 14 Apr 2001 23:36:59 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9bbfib$qu4$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friends,

I am trying the following setup, and it works beautifully, *except*
that I don't seem to be able to free the ramdisk memory at the end.
This is using the 2.4.3 stock kernel:

I load an initrd in "non-initrd" mode:

label single
        kernel vmlinuz
        append initrd=initrd.gz root=/dev/ram0 init=/linuxrc single

The initrd sets up a ramfs which is intended to become the root
filesystem, and then calls pivot_root:

[....]
umount /proc

# At this point, all that is mounted is /ram and /ram/usr

# Switch roots and run init
cd /ram
pivot_root /ram /ram/initrd
exec /sbin/init "$@"


(And yes, the /ram/initrd mount point directory does exist.)

This successfully runs init, and I can umount /initrd in the new
setup, but I cannot then destroy the ramdisk contents by calling
ioctl([/dev/ram0], BLKFLSBUF, 0) -- it always returns EBUSY.  What is
holding this ramdisk busy, especially since I could successfully
umount the filesystem?  Seems like a bug to me.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
