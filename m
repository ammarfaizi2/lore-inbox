Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287348AbSAZXwl>; Sat, 26 Jan 2002 18:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSAZXw2>; Sat, 26 Jan 2002 18:52:28 -0500
Received: from hera.cwi.nl ([192.16.191.8]:54912 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S287348AbSAZXwP>;
	Sat, 26 Jan 2002 18:52:15 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 26 Jan 2002 23:52:02 GMT
Message-Id: <UTC200201262352.XAA28475.aeb@cwi.nl>
To: jeffm@boxybutgood.com, linux-kernel@vger.kernel.org
Subject: Re: loopback anomaly?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jeff Meininger <jeffm@boxybutgood.com>

    I've found some undesirable behavior when trying to use the loop block
    driver with files with strange byte counts.  The files I'd like to setup
    as loopback devices are on read-only media, and they're all different byte
    counts... not necessarily even an integral multiple of 512.  I can't just
    pad them to work with losetup.

What kernel version?

    If you have a 1048577-byte file (1 byte more than 1M), the loopback device
    skips the last byte, which is what I believe it should do.  BLKGETSIZE
    says 2048.

    If you have a 1048575-byte file (1 byte less than 1M), the loopback device
    reports 2046 for it's BLKGETSIZE.  This sounds correct, since it has to
    use one less 1024-block to get an integral multiple.  However, when you
    examine the contents of the loopback device, you'll find that there are
    only 2040 sectors... there are 3072 more bytes missing than you'd expect.

No doubt what happens is that the underlying filesystem
that contains the file that you do losetup on has a
block size 4096.

You can check by asking
	# blockdev --getbsz /dev/loopN

If the answer is 4096, then you can change it by
	# blockdev --setbsz 512 /dev/loopN

With the wrong block size, you will get an I/O error
reading the end of the loop device. With the right
block size there will not be an I/O error, but of course
still the size is rounded down to a multiple of 1024.

There is a growing need to address Linux' inability to
get at the last sector of devices with an odd number of
sectors, and more generally to get at the end of block devices
with a length that is not a nice multiple of a large power of 2.

Andries
