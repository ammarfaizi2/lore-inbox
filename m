Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbUKHRHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbUKHRHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUKHRGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:06:37 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:48067 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261924AbUKHQU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:20:56 -0500
Date: Mon, 08 Nov 2004 11:20:27 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH] Mounting on floating mounts is possible
In-reply-to: <20041106060455.0100e3ec@doener>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Message-id: <418F9CCB.1000202@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_GOP4WMSSUPEzexgElK6NQw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20041106060455.0100e3ec@doener>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_GOP4WMSSUPEzexgElK6NQw)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Björn Steinbrink wrote:
> Hi,
> 
> this[1] patch changed check_mnt() so that mounting on a floating mount
> (i.e. one that was unmounted using MNT_DETACH and was still in use) is
> possible, since we no longer check if the mountpoint is actually
> reachable. The problem is that we may lose any reference to the floating
> mount, but the mount on it will keep it alive, thus it will never go
> away. The following patch removes the reference from the mount to its
> namespace when it is unmounted lazily, so that check_mnt protects from
> such mounts.
> 
> Please CC me as I'm not subscribed to the list.
> 
> Bjoern
> 
> [1] http://lwn.net/Articles/91946/
> 
> diff -uNr --minimal a/fs/namespace.c b/fs/namespace.c
> --- a/fs/namespace.c    2004-10-31 00:41:02.000000000 +0200
> +++ b/fs/namespace.c    2004-11-06 04:38:37.299013810 +0100
> @@ -358,6 +358,7 @@
>                 } else {
>                         struct nameidata old_nd;
>                         detach_mnt(mnt, &old_nd);
> +                       mnt->mnt_namespace = NULL;
>                         spin_unlock(&vfsmount_lock);
>                         path_release(&old_nd);
>                 }
> -

I don't think this patch clears mnt_namespace for the root of the
umounted tree.  How about this?



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

iD8DBQFBj5zKdQs4kOxk3/MRAv7FAKCdtASSH1sbq8KX1Yo0IrQZJ25q9gCfUp52
Uy0LxZvoqfJ9bh5jWGv7YM4=
=pce6
-----END PGP SIGNATURE-----

--Boundary_(ID_GOP4WMSSUPEzexgElK6NQw)
Content-type: text/x-patch; name=clear_mnt_namespace.diff
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=clear_mnt_namespace.diff

---

 namespace.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-11-08 11:18:39.980358880 -0500
+++ linux-2.6.9-quilt/fs/namespace.c	2004-11-08 11:19:24.702560072 -0500
@@ -352,6 +352,7 @@ void umount_tree(struct vfsmount *mnt)
 		mnt = list_entry(kill.next, struct vfsmount, mnt_list);
 		list_del_init(&mnt->mnt_list);
 		list_del_init(&mnt->mnt_fslink);
+		mnt->mnt_namespace = NULL;
 		if (mnt->mnt_parent == mnt) {
 			spin_unlock(&vfsmount_lock);
 		} else {

--Boundary_(ID_GOP4WMSSUPEzexgElK6NQw)--
