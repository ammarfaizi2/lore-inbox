Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVBZABm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVBZABm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbVBZABl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:01:41 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:17414 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262807AbVBZABN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:01:13 -0500
Message-ID: <421FBCD8.7090804@suse.com>
Date: Fri, 25 Feb 2005 19:03:36 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: zensonic@zensonic.dk, dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Help tracking down problem --- endless loop in __find_get_block_slow
References: <4219BC1A.1060007@zensonic.dk>	<20050222011821.2a917859.akpm@osdl.org>	<421BB65F.7040306@suse.com> <20050222152833.75fb79a2.akpm@osdl.org>
In-Reply-To: <20050222152833.75fb79a2.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000503090503000308090208"
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000503090503000308090208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> Jeff Mahoney <jeffm@suse.com> wrote:
> 
>>In my experience, the loop is actually outside of
>>__find_get_block_slow(), in __getblk_slow(). I've been using xmon to
>>interrupt the kernel, and the results vary but are all rooted in the
>>for(;;) loop in __getblk_slow. It appears as though grow_buffers is
>>finding/creating the page, but then __find_get_block can't locate the
>>buffer it needs.
> 
> 
> Yes, that'll happen.  Because there are still buffers attached to the page
> which have the wrong blocksize.  Say, if someone is trying to read a 2k
> buffer_head which is backed by a page which already has 1k buffer_heads
> attached to it.
> 
> Does your kernel not have that big printk in __find_get_block_slow()?  If
> it does, maybe some of the buffers are unmapped.  Try:

I think it's likely I'm experiencing a different bug than the original
poster. I've tried making the printk unconditional, and I get no output.
However, I've continued to track it down, and I believe I've found a
umount race. I can also reproduce it without subfs, with the attached
script.

I added some debug output to aid in my search:
__find_get_block_slow: find_get_page
[block=17508,blksize=2048,index=8754,sizebits=1,size=512] returned null
returning page [index=2188,block=17504,size=512,sizebits=3]
Couldn't find buffer @ block 17508

What I'm observing is that __find_get_block_slow is calculating the
index using the blocksize for the device, and the grow_buffers call is
using the blocksize handed down from the filesystem via sb_bread(). They
*should* be the same, but here's where my suspected race comes in. Since
the buffers are being searched for in the wrong place, they're never
found, causing the infinite loop.

The open_bdev_excl() call in get_sb_bdev() should be keeping callers out
until the block device is actually closed, but it uses the fs_type
struct as the holder which, given that the filesystem to be mounted is
the same one as the one being umounted, will be the same. This allows
the mount attempt to continue. If the superblock for the umounting
filesystem is already in the process of getting shut down, sget() will
create a new superblock and the mount attempt will use that one. The
umount will continue, destroying the old superblock and setting the
blocksize back to its original value, dropping all buffers in the process.

If kill_block_super resets the blocksize while an sb_bread is in
progress, the sizes won't match up and we'll get stuck in the loop.

I'll be working on a fix, but figured I'd send out a quick update.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCH7zXLPWxlyuTD7IRAr/WAJ9B6MLsKl6cv48Qlcklx1saYERv7ACdHWGW
UBXAsQBiEAge3T1R4akLKd0=
=w1zP
-----END PGP SIGNATURE-----

--------------000503090503000308090208
Content-Type: application/x-sh;
 name="test.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.sh"

#!/bin/sh

DEV=/dev/sda1
MNT=/media/testdev

mount $DEV $MNT
find $MNT > /tmp/files
umount $DEV $MNT

for i in 1 2; do
    (
    while true; do
        mount $DEV $MNT
        umount $DEV $MNT
    done
    )&
done

IFS='
'
for file in `cat /tmp/files`; do
    md5sum $file > /dev/null
done

--------------000503090503000308090208--
