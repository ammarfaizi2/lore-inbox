Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbULGWqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbULGWqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 17:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbULGWqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 17:46:22 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:46672 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261957AbULGWqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 17:46:05 -0500
Message-ID: <41B632DD.4030804@suse.com>
Date: Tue, 07 Dec 2004 17:46:53 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Mason <mason@suse.com>
Subject: Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org>	 <1101842310.4401.111.camel@moss-spartans.epoch.ncsc.mil>	 <20041130112903.C2357@build.pdx.osdl.net>	 <20041130194328.GA28126@infradead.org>	 <20041201233203.GA22773@locomotive.unixthugs.org>	 <1101993302.26015.5.camel@moss-spartans.epoch.ncsc.mil>	 <41B60B0F.1080201@suse.com> <1102451289.25488.278.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1102451289.25488.278.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
| On Tue, 2004-12-07 at 14:57, Jeff Mahoney wrote:
|
|>However, selinux itself accesses inode lists internally that circumvent
|>this. I believe I caught the major case that causes this, but I'd prefer
|>someone with more intimate knowledge of selinux verify.
|
|
| inodes are only added to the list (prior to superblock security
| initialization, e.g. before initial policy load or during get_sb) by
| inode_doinit_with_dentry, which in turn is called from
| selinux_d_instantiate.  So if you've marked the inode private prior to
| the d_instantiate call on it, and changed security_d_instantiate to not
| call the security module for private inodes, how would a private inode
| ever get into that list?

In general, this is true. However, there's a case where it's not. During
the initial filesystem mount, the .reiserfs_priv directory is created by
reiserfs_xattr_init(). This directory becomes the root of the private
inode tree, but there is no way to mark it as private until after mkdir
returns. After it returns, d_instantiate has already been called.

Therefore, on the first read-write mount, the inode associated with
.reiserfs_priv will always be on that list. There are a few methods that
could be added to set the inode private before the d_instantiate, but
they're all pretty gross. Basically, of all the potential solutions,
checking IS_PRIVATE in that loop is the simplest.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBtjLdLPWxlyuTD7IRAp+MAJ9bJy32bIcE/uVVdo+T0bNYIWJoLgCfQNyh
pKnLBMAwi3yIeQE2JXlHIKA=
=0Yc7
-----END PGP SIGNATURE-----
