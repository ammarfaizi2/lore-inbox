Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVCOU63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVCOU63 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVCOU6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:58:15 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:32043 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261793AbVCOUz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:55:57 -0500
Message-ID: <42374C9A.1010000@suse.com>
Date: Tue, 15 Mar 2005 15:59:06 -0500
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
> 
> Or maybe I misunderstood the problem. Jeff?

*smacks head*

Yeah, I think this will fix the problem in a much cleaner way. I wanted
to try to preserve the old behavior, but you validly point out that it's
silly to do so. I don't believe that any opener of a block device has
any expectation that the block size be anything in particular. They
could open a block device that is mounted, or one that isn't. If they
need it a different size, they can explicitly set it. The set_blocksize
in kill_block_super is just being nice and returning it the default.

Here's a quick analysis:

Previous to the superblock being shut down, sget will return a
superblock which will then lead to get_sb_bdev returning -EBUSY as expected.

After the superblock being shut down, bd_release releases the holders.
This could allow another opener to open it exclusively, but then the new
mount would just return -EBUSY, which is safe. Otherwise, we'll take a
holder reference under bdev_lock.

Then, blkdev_put will sync and kill the blkdev under bdev->bd_sem if it
holds the sole opener reference. This is what usually will happen.

If it doesn't hold the only reference, blkdev_get in the new mount beat
us there and won't need to reset the blocksize. The bdev doesn't get
synced and killed either, though. This isn't that big a deal, since
generic_shutdown_super->fsync_super takes care of syncing the fs, but
the ->write_super call following it could leave the superblock unsynced
under certain circumstances[*]. So, rather than completely remove the
set_blocksize, I'd prefer to replace it with a sync_blockdev instead.

- -Jeff

[*]: It's a very specific corner case: Currently, since most filesystems
use a block size that is different than the device block size,
set_blocksize resetting the block size can be counted on to sync any
writes that occured during that final ->write_super call. If we remove
set_blocksize, then that final sync may not occur if there is another
opener (such as a process reading the block device).

Yes, it's a case of shooting-yourself-in-the-foot, but say it's a pen
drive and knowing that it's umounted, the user removes the device. The
final write is lost - because a read-only operation was in progress.
That doesn't seem right to me, and can be fixed pretty easily by
substituting a sync_blockdev for that set_blocksize rather than removing
it completely.

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCN0yaLPWxlyuTD7IRAtp0AJ4xQDNjS+B6wq3sKu2t6c4tj6PHowCeJeqR
54cAg0bsuf1pMU0kSDJLy20=
=t5Vf
-----END PGP SIGNATURE-----
