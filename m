Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbULBBKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbULBBKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 20:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbULBBKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 20:10:37 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:64852 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261538AbULBBK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 20:10:28 -0500
Message-ID: <41AE6BAC.5030906@suse.com>
Date: Wed, 01 Dec 2004 20:11:08 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@redhat.com>,
       mason@suse.com
Subject: Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org> <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil> <20041130112903.C2357@build.pdx.osdl.net> <20041130194328.GA28126@infradead.org> <20041201233203.GA22773@locomotive.unixthugs.org> <20041201170141.V2357@build.pdx.osdl.net>
In-Reply-To: <20041201170141.V2357@build.pdx.osdl.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chris Wright wrote:
| * Jeffrey Mahoney (jeffm@suse.com) wrote:
|
|>I took some more time to find a more optimal solution. Since ReiserFS is
|>currently the only filesystem that cares about this, it's far easier
to keep
|>the whole mess internal to ReiserFS. The issue isn't about the treating of
|>"private" files in reiserfs, but rather just to avoid the looping of xattr
|>calls that selinux would create.
|
|
| This sounds a bit better.  BTW, which is the call chain that locks?
smth like
|
open->permission->selinux_hook_does_getxattr->reiser_getxattr->open->permission?

For the most part yes. The locking stops at reiserfs_getxattr when it
tries to lock the xattr dir.

|>As part of the reiserfs xattr subsystem initialization process, this patch
|>copies the existing inode_operations structs and NULLs out the xattr
|>operations.
|
|
| This seems unecessary, just define the reiserfs_priv_foo structures
| statically, like other inode ops.  As it is, looks like it will get
| re-run once for each mounted superblock.

Yes, you're absolutely right. The copies would be better placed in
reiserfs_xattr_register_handlers, which gets run on module load. I'm
ambivalent with respect to copying them at runtime or in the source. The
advantage to copying them is that they automatically inherit any changes
made and don't need to be considered separately.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBrmusLPWxlyuTD7IRAoPjAJ0d9+QXKmcYg9rM3sCwrgRV2qx8cACeOARi
QkHEpWCCcA7DBjvadyXsD30=
=q/Rh
-----END PGP SIGNATURE-----
