Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVB1VJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVB1VJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVB1VFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:05:45 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:2124 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261751AbVB1VDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:03:42 -0500
Message-ID: <422387C7.5010508@suse.com>
Date: Mon, 28 Feb 2005 16:06:15 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, zensonic@zensonic.dk, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Help tracking down problem --- endless loop in __find_get_block_slow
References: <4219BC1A.1060007@zensonic.dk>	<20050222011821.2a917859.akpm@osdl.org>	<421BB65F.7040306@suse.com> <20050222152833.75fb79a2.akpm@osdl.org> <421FBCD8.7090804@suse.com>
In-Reply-To: <421FBCD8.7090804@suse.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Mahoney wrote:
> Andrew Morton wrote:
> 
>>>Jeff Mahoney <jeffm@suse.com> wrote:
>>>
>>>
>>>>In my experience, the loop is actually outside of
>>>>__find_get_block_slow(), in __getblk_slow(). I've been using xmon to
>>>>interrupt the kernel, and the results vary but are all rooted in the
>>>>for(;;) loop in __getblk_slow. It appears as though grow_buffers is
>>>>finding/creating the page, but then __find_get_block can't locate the
>>>>buffer it needs.
>>>
>>>
>>>Yes, that'll happen.  Because there are still buffers attached to the page
>>>which have the wrong blocksize.  Say, if someone is trying to read a 2k
>>>buffer_head which is backed by a page which already has 1k buffer_heads
>>>attached to it.
>>>
>>>Does your kernel not have that big printk in __find_get_block_slow()?  If
>>>it does, maybe some of the buffers are unmapped.  Try:
> 
> 
> I think it's likely I'm experiencing a different bug than the original
> poster. I've tried making the printk unconditional, and I get no output.
> However, I've continued to track it down, and I believe I've found a
> umount race. I can also reproduce it without subfs, with the attached
> script.
> 
> I added some debug output to aid in my search:
> __find_get_block_slow: find_get_page
> [block=17508,blksize=2048,index=8754,sizebits=1,size=512] returned null
> returning page [index=2188,block=17504,size=512,sizebits=3]
> Couldn't find buffer @ block 17508
> 
> What I'm observing is that __find_get_block_slow is calculating the
> index using the blocksize for the device, and the grow_buffers call is
> using the blocksize handed down from the filesystem via sb_bread(). They
> *should* be the same, but here's where my suspected race comes in. Since
> the buffers are being searched for in the wrong place, they're never
> found, causing the infinite loop.
> 
> The open_bdev_excl() call in get_sb_bdev() should be keeping callers out
> until the block device is actually closed, but it uses the fs_type
> struct as the holder which, given that the filesystem to be mounted is
> the same one as the one being umounted, will be the same. This allows
> the mount attempt to continue. If the superblock for the umounting
> filesystem is already in the process of getting shut down, sget() will
> create a new superblock and the mount attempt will use that one. The
> umount will continue, destroying the old superblock and setting the
> blocksize back to its original value, dropping all buffers in the process.
> 
> If kill_block_super resets the blocksize while an sb_bread is in
> progress, the sizes won't match up and we'll get stuck in the loop.
> 
> I'll be working on a fix, but figured I'd send out a quick update.

To prove the race, I made bd_claim return -EBUSY even if the passed
holder == current holder. This eliminated the race, but made a
potentially unacceptable change to how block devices are handled. [1]

Attached is a patch that isn't pretty but does still allow the
multiple-open semantics of open_bdev_excl() while eliminating the race.
Basically, it creates a call path that allows the device's block size to
be changed only if the caller holds the sole reference to the block
device. This has passed my admittedly small test cases without returning
invalid results.

Only the close case is protected by bdev_lock. This may seem racy, but I
don't believe it to be. The only way a caller could have the opportunity
to reset the block size while the block device is opened is if the
holder value is the same, which means that it must be the same
filesystem type. The same filesystem type opening the same device will
result in finding the same on-disk superblock that the umounting
filesystem was using, so it would be the same block size. set_blocksize
will exit early if the block size is the same, thus avoiding the code
that could cause issues.

I'd appreciate any feedback.

- -Jeff

[1] Currently, mtd is the only non-filesystem caller of open_bdev_excl.
While it's possible for mtd to call open_bdev_excl twice on the same
device, it would require passing the same device more than once as a
module parameter.
- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCI4fHLPWxlyuTD7IRAu5LAKCPaSFb+BCpHRw44YU5j2IE52X5AgCfVHby
4mz96aq70X9VOIccEWvnCko=
=59ut
-----END PGP SIGNATURE-----
