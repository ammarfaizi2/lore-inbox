Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbUJ0SkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbUJ0SkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUJ0Sj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:39:58 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:25846 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262639AbUJ0Sgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:36:46 -0400
Date: Wed, 27 Oct 2004 14:36:38 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 4/28] VFS: Stat shouldn't stop expire
In-reply-to: <20041026102703.GA12026@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Message-id: <417FEAB6.1020006@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <10987152003432@sun.com> <1098715230634@sun.com>
 <20041026102703.GA12026@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Mon, Oct 25, 2004 at 10:40:30AM -0400, Mike Waychison wrote:
> 
>>This patch fixes the problem where if you have a mountpoint that is going to
>>expire, it fails to expire before somebody keeps stat(2)ing the root of it's
>>filesystem.  For example, consider the case where a user has his home
>>directory automounted on /home/mikew.   Some other user can keep the
>>filesystem mounted forever by simply calling ls(1) in /home, because the stat
>>action resets the marker on each call.
>>
>>Signed-off-by: Mike Waychison <michael.waychison@sun.com>
>>---
>>
>> namei.c |   11 ++++++++++-
>> 1 files changed, 10 insertions(+), 1 deletion(-)
>>
>>Index: linux-2.6.9-quilt/fs/namei.c
>>===================================================================
>>--- linux-2.6.9-quilt.orig/fs/namei.c	2004-08-14 01:36:45.000000000 -0400
>>+++ linux-2.6.9-quilt/fs/namei.c	2004-10-22 17:17:34.762179488 -0400
>>@@ -275,7 +275,16 @@ int deny_write_access(struct file * file
>> void path_release(struct nameidata *nd)
>> {
>> 	dput(nd->dentry);
>>-	mntput(nd->mnt);
>>+	/*
>>+	 * In order to ensure that access to an automounted filesystems'
>>+	 * root does not reset it's expire counter, we check to see if the path
>>+	 * being released here is a mountpoint itself.  If it is, then we call
>>+	 * _mntput which leaves the expire counter alone.
>>+	 */
>>+	if (nd->mnt && nd->mnt->mnt_root == nd->dentry)
>>+		_mntput(nd->mnt);
>>+	else  
>>+		mntput(nd->mnt);
> 
> 
> Why only for the root dentry not any on stat()  This seems highly inconsistant.

I'm not sure.  I need help in understanding the different cases of
path_release: (please add any others/discrepencies you see)

 1) path walk (across a mountpoint)
 2) open / close (of a mountpoint)
 3) stat / xattr (of a mountpoint)

The first case, a path walk, will always touch a non-mountpoint root
dentry.  As such, the above snippet will always reset the expire counter
 as some other dentry got path_released.

Case 2, opening of a mountpoint happens when you readdir a the base of
the mounted filesystem.  In this case, you aren't path_releasing on
close, but are doing an explicit mntput(filp->f_vfsmnt).

Case 3, you are accessing meta information of the root of the
mountpoint.  Assuming the call is made from 'outside' the mounted
filesystem, the expire counter is currently ticking.  Access to grab
meta information of the base directory of the mountpoint shouldn't reset
the counter, and in all cases I looked at (minimal), they called
path_release when done.

The above hack^Wsnippet was intended to deal with case #3, but it may
make more sense to look into the matter further and perform the special
case in vfs_l?stat themselves.

Thoughts?

> Also while you're at it please give _mntput a more sensible name, e.g.
> mntput_no_expire (yes, I know that name isn't your fault)
> 

Will do.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFBf+q2dQs4kOxk3/MRAnlQAJ413gDuQLqF5HgOKSQ/S7LrtlaZqQCYix9y
ogHTca+0B+7+HIuSJsY9kQ==
=Qw5B
-----END PGP SIGNATURE-----
