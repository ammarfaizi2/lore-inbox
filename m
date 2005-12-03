Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVLCRmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVLCRmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVLCRmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:42:19 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:15164 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S932092AbVLCRmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:42:18 -0500
Message-ID: <4391D910.206@suse.com>
Date: Sat, 03 Dec 2005 12:42:40 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] fs: remove s_old_blocksize from struct super_block
References: <1133558437.31065.6.camel@localhost>  <Pine.LNX.4.64.0512031058350.11664@hermes-1.csi.cam.ac.uk> <1133609645.7989.3.camel@localhost> <Pine.LNX.4.64.0512031429360.11664@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0512031429360.11664@hermes-1.csi.cam.ac.uk>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Anton Altaparmakov wrote:
> I have no idea why Jeff (Mahoney) considered the setting to be 
> unnecessary, when Al Viro added the resetting code a few years ago it 
> was done precisely because utilities were behaving randomly/erratically...
> 
> IMHO the above commit consitutes a regression in 2.6 kernel.

Anton -

Linus and I discussed[1] this briefly on the list in March. Here's my
conclusion[2]. My initial attempts tried to preserve the behavior, but
keeping it at the VFS level made the fix more complex. Linus pointed out
that the file systems explicitly set the block size to a known value
before doing anything. Userspace utilities that don't open the block
device with O_EXCL can have the block size changed underneath them in
mid-execution - by the kernel or another userspace process using the
BLKBSZSET ioctl. Incidentally, the ioctl doesn't save the old value either.

I don't think any userspace utility can expect a particular block size
without an exclusive open and explicit set of the block size.

Pushing the resetting of the block size up into the file system doesn't
eliminate the race. The race exists when get_sb_bdev_excl opens the
block device, which it is allowed to do since it's the same file system
type, and then tries to get the super block. If deactivate_super has
already changed sb->s_count -= S_BIAS -1, sget will ignore the
superblock and allocate a new one. It will then call the file system's
fill_super(). Once a new superblock is allocated, the only thing that
the two have in common is the block device and there is nothing
preventing ->fill_super() from running concurrently with anything under
- ->kill_sb(). This includes ->put_super() as well, so pushing the reset
up into the individual file systems would just preserve/reintroduce the
race.

bdev->bd_mount_sem might be a workable synchronization point for this if
you truly want to preserve the old behavior.

- -Jeff

[1]: http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/2369.html
[2]: http://www.ussg.iu.edu/hypermail/linux/kernel/0503.2/0460.html

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDkdkQLPWxlyuTD7IRAo0uAJ4+JQOz5g47rVlGZzwoaELY1G3q1QCfWSi+
HfGC1KAvRhm+YXU47cTK83U=
=JHuY
-----END PGP SIGNATURE-----
