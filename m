Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUJBPl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUJBPl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 11:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUJBPl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 11:41:58 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:17157 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S266703AbUJBPly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 11:41:54 -0400
Message-ID: <415ECD25.8000901@novell.com>
Date: Sat, 02 Oct 2004 11:45:41 -0400
From: Jeff Mahoney <jeffm@novell.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] Race with iput and umount
References: <415E5EE6.3010800@novell.com> <20041002095254.GH23987@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041002095254.GH23987@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

viro@parcelfarce.linux.theplanet.co.uk wrote:
| On Sat, Oct 02, 2004 at 03:55:18AM -0400, Jeff Mahoney wrote:
|
|>generic_shutdown_super() will happily call the ->put_super fs method,
|>destroying data structures still in use by the iput (->delete_inode) in
|>progress.  That's where Oopsen come into play.
|>
|>The unlink path will call the ->unlink fs method, release the path (thus
|>dropping the reference to the vfsmount, and then call iput. Since the
|>vfsmount reference is dropped back to 1, a umount will succeed, causing
|>the superblock to be cleaned up.
|
|
| Arrgh...
|
| Bug is in the ->i_count hacks in sys_unlink().  1001st proof that VFS has
| no fscking business playing with inode refcount directly...
|
| OK, quick and dirty fix follows.  Note: all places that go to exit1:
or exit:
| will have NULL inode, so we are not leaking anything here and it is OK
do that
| iput() early; indeed, the goal of that kludge was to postpone the final
| iput() past the unlocking the parent for the sake of contention if a wunch
| of bankers is doing parallel unlink() on files in the same directory and
| normally it would happen on dput() after vfs_unlink())
|
| --- linux/fs/namei.c	Mon Sep 13 01:32:00 2004
| +++ linux/fs/namei.c.fix	Sat Oct  2 05:48:21 2004
| @@ -1825,13 +1825,12 @@
|  		dput(dentry);
|  	}
|  	up(&nd.dentry->d_inode->i_sem);
| +	if (inode)
| +		iput(inode);	/* truncate the inode here */
|  exit1:
|  	path_release(&nd);
|  exit:
|  	putname(name);
| -
| -	if (inode)
| -		iput(inode);	/* truncate the inode here */
|  	return error;
|
|  slashes:


Works as expected. Thanks!

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBXs0lLPWxlyuTD7IRAivHAJ4l3GsDxWgQTrTHrMeR7C0CqpomiACgljzB
njBzAn2tP+P5pya1egf9TmU=
=JmTS
-----END PGP SIGNATURE-----
