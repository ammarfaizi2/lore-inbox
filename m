Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVCQTsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVCQTsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 14:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVCQTsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 14:48:46 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:4171 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261408AbVCQTsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 14:48:40 -0500
Message-ID: <4239DFDC.40302@suse.com>
Date: Thu, 17 Mar 2005 14:51:56 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] blockdev: fix for racing mount/umount
References: <20050315141449.GA13653@locomotive.unixthugs.org> <Pine.LNX.4.58.0503150746320.6119@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503150746320.6119@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
> 
> On Tue, 15 Mar 2005, Jeff Mahoney wrote:
> 
>>This patch is another take at fixing the race between mount and umount
>>resetting the blocksize and causing buffer errors, infinite loops in
>>__getblk_slow, and possibly other undiscovered effects.
> 
> 
> Ok. I had to go back and look up the original problem, and having looked 
> at this a bit more, I wonder whether the real problem is not that we do 
> that silly "set blocksize back to the original one" at umount time in the 
> first place.
> 
> (It happens very indirectly, though the "->kill_sb()" fn pointer, which 
> ends up doing kill_block_super on a regular block device).
> 
> Maybe we should just get rid of it entirely? There's really no point to 
> it.
> 
> Instead, to make things repeatable, we'd always just set the blocksize to
> its default value at the first open. We already do that anyway, don't we?
> 
> Wouldn't that approach also just fix things? And then the fix would 
> literally be to just remove the set_blocksize() call in kill_block_super. 
> At that point, we know that the only people who set the block size are 
> either
>  - a first opener
>  - somebody who got exclusive access (ie a filesystem that sets it at 
>    mount-time)
> 
> (Yeah, it's a bit more complex than that one-liner, since somebody would 
> need to back me up on not being totally tripping on some 'shrooms. But Al 
> can probably do that trivially)

I replaced the set_blocksize with a sync_blockdev as I mentioned in my
previous reply and then ran a 24+ hour test that used to fail within a
few minutes. It passed.

As for resetting the block size either before the mount or on final
close, I don't think it's necessary.

Every block filesystem either calculates block numbers using the current
blocksize or explicitly sets the block size itself. Further, the default
blocksize isn't related at all to some "ideal" blocksize for any
particular device, it's just 1k.

It seems to me that the only case restoring the block size seems to
cover is this:
1. process opens the block device non-exclusively, and may set the block
size
2. kernel mounts filesystem, resetting the blocksize to its need
[...]
3. kernel umounts filesystem, returning blocksize to previous value
4. userspace closes block device

The problem with this is that userspace has no expectation whatsoever
that the block size be anything in particular unless it has exclusive
access to the device. If the device isn't open with exclusive access,
the kernel can and will change the blocksize while the userspace process
has the device open. O_EXCL works on block devices (see blkdev_open),
and if it is opened with exclusive access, the kernel can't claim the
device to mount the filesystem.

Therefore, I propose that simply changing the set_blocksize to a
sync_blockdev is sufficient.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCOd/cLPWxlyuTD7IRAkbbAKCEop3QXJq0/TbllPeEw412wrPZ1gCeIoz5
5sVOoyorGhKs78WFdPLhRHs=
=CGT7
-----END PGP SIGNATURE-----
