Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBRRtw>; Sun, 18 Feb 2001 12:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129993AbRBRRtm>; Sun, 18 Feb 2001 12:49:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:14047 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129144AbRBRRta>;
	Sun, 18 Feb 2001 12:49:30 -0500
Date: Sun, 18 Feb 2001 18:49:26 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102181749.SAA171185.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, zzed@cyberdude.com
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
Cc: alan@lxorguk.ukuu.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jon Forsberg <zzed@cyberdude.com>

    I have two ext2 CD-ROMs. One of them I can mount the normal way,
    the other I can't. Both are ok according to debugfs and e2fsck
    and if I do
	'mount -t ext2 -o loop /dev/cdrom /cdrom'
    instead, both work.

    The one that doesn't work have a blocksize of 1024 according to debugfs:
      Block size = 1024, fragment size = 1024
    And the other:
      Block size = 4096, fragment size = 4096

    What happens:

    # mount -t ext2 /dev/cdrom /cdrom        
    mount: block device /dev/cdrom is write-protected, mounting read-only
    mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
           or too many mounted file systems

    kern.log:
    Feb 18 14:54:34 pc1 kernel: VFS: Unsupported blocksize on dev sr(11,0).

    I'm pretty sure both worked with 2.2.17.

You are being bitten by two bugs. By some coincidence I sent a
patch for the first one to Linus and Alan yesterday.
(That was fs/ext2/super.c - the same bug occurs in both 2.2 and 2.4.)
However, the second one will then still prevent you from mounting,
and it occurs only in 2.4.

Someone has added
        /*
         * These are good guesses for the time being.
         */
        for (i = 0; i < sr_template.dev_max; i++) {
                sr_blocksizes[i] = 2048;
                sr_hardsizes[i] = 2048;
        }
        blksize_size[MAJOR_NR] = sr_blocksizes;
        hardsect_size[MAJOR_NR] = sr_hardsizes;
setting of hardsect_size to drivers/scsi/sr.c.

A value of hardsect_size[] means: this is the smallest size
the hardware can work with. It is therefore a serious mistake
just to come with "a good guess". This value is used only
to reject impossible sizes, and everywhere the kernel accepts 0
meaning "don't know".

So, probably all will work fine if you change the second
2048 here to say 512 or 0. Or, if you, more drastically,
remove all references to sr_hardsizes[] from sr.c.

Andries
