Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314129AbSDLRzy>; Fri, 12 Apr 2002 13:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314130AbSDLRzy>; Fri, 12 Apr 2002 13:55:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18586 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314129AbSDLRzw>;
	Fri, 12 Apr 2002 13:55:52 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 12 Apr 2002 17:55:50 GMT
Message-Id: <UTC200204121755.RAA597903.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, mark.post@eds.com
Subject: Re: PROBLEM: kernel mount of initrd fails unless mke2fs uses 1024 byt e blocks
Cc: alan@lxorguk.ukuu.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: "Post, Mark K" <mark.post@eds.com>

    [1.] One line summary of the problem:
        Trying to use an initrd for an installation fails unless the mke2fs
    used a blocksize of 1024 bytes.

    [2.] Full description of the problem/report:
        I'm trying to create a Linux for S/390 version 2.2.20 installation
    kernel/ramdisk set.  When I create the ramdisk, if I issue the mke2fs
    command with -b 2048 or -b 4096, it works fine.  But, I try to boot the
    system, I get an "EXT2-fs: Magic mismatch, very weird !" error when the
    kernel tries to mount the ramdisk as the root file system.  If I let the
    blocksize default, or specify -b 1024, everything works fine.

    The comparison that seems to be failing is at line 500 of
    linux/fs/ext/super.c:
                    if (es->s_magic != le16_to_cpu(EXT2_SUPER_MAGIC)) {
                            printk ("EXT2-fs: Magic mismatch, very weird !\n");
                            goto failed_mount;

Well, we can read the source.
ext2_read_super() starts finding a blocksize:

	blocksize = get_hardblocksize(dev);

and buffer.c:get_hardblocksize() returns hardsect_size[major][minor].
rd.c sets hardsect_size[] to rd_hardsec, and initializes rd_hardsec
to RDBLK_SIZE, which is 512.
OK, so blocksize = 512.

Next,
	if (blocksize < BLOCK_SIZE)
		blocksize = BLOCK_SIZE;

So, now it is 1024.

Then bread (dev, 1, blocksize) reads the wrong part,
if in reality blocksize was different.

I once submitted a patch for this, but apparently it is not in 2.2.20.
Might do so later this evening, if there is time.

Andries
