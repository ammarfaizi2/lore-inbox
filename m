Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVHLPLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVHLPLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVHLPLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:11:08 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:1302 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1750941AbVHLPLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:11:07 -0400
Message-ID: <42FCBC00.2040903@suse.com>
Date: Fri, 12 Aug 2005 11:10:56 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: =?ISO-8859-1?Q?Tarmo_T=E4nav?= <tarmo@itech.ee>, Jan Kara <jack@suse.cz>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, mason@suse.com,
       grev@namesys.com
Subject: Re: BUG: reiserfs+acl+quota deadlock
References: <1123643111.27819.23.camel@localhost> <20050810130009.GE22112@atrey.karlin.mff.cuni.cz> <1123684298.14562.4.camel@localhost> <20050810144024.GA18584@atrey.karlin.mff.cuni.cz> <42FCB873.8070900@namesys.com>
In-Reply-To: <42FCB873.8070900@namesys.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1




Vladimir V. Saveliev wrote:
> Hello
> 
> Jan Kara wrote:
>>> Tried the attached patch but it changed nothing, I trying to create
>>> a new file as a user whose quota grace time has ran out will still
>>> cause everything accessing the users homedir (the one with the quota)
>>> to hang in D state.
>>>
>>> Also note that the bug I reported only exists when acl is also
>>> enabled (does not have to be used). And although my kernel is not
>>> built with debug (or reiserfs debug) support, I don't get any
>>> oopses or reiserfs errors.. it just hangs.
>>
> 
> It looks like the problem is that reiserfs_new_inode can be called
> either having xattrs locked or not.
> It does unlocking/locking xattrs on error handling path, but has no idea
> about whether
> xattrs are locked of not.
> The attached patch seems to fix the problem.
> I am not sure whether it is correct way to fix this problem, though.

Does this patch actually fix it? It shouldn't.

The logic is like this: If a default ACL is associated with the parent
when the inode is created, xattrs will be locked so that the ACL can be
inherited. Since reiserfs_new_inode is called from the VFS layer with
inode->i_sem downed, {set,remove}xattr is locked out. The default ACL
can't be removed/added/changed while reiserfs_new_inode is running.
Therefore, if there is a default ACL, xattrs must be locked.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFC/LwALPWxlyuTD7IRAl1hAJ9dVKCWPYdMO85+EKjL+2kq9dy3ngCfdS9w
56060gxdR2z0d6UFP79yQ1A=
=S8+3
-----END PGP SIGNATURE-----
