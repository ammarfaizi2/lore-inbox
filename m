Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUI1Rkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUI1Rkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268004AbUI1Rkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:40:40 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:53171 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S267928AbUI1RiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:38:22 -0400
Date: Tue, 28 Sep 2004 13:38:15 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC][PATCH] inotify 0.10.0
In-reply-to: <1096250524.18505.2.camel@vertex>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, iggy@gentoo.org
Message-id: <4159A187.3060402@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1096250524.18505.2.camel@vertex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

John McCutchan wrote:
|
| --Why Not dnotify and Why inotify (By Robert Love)--
|

| * inotify has an event that says "the filesystem that the item you were
|   watching is on was unmounted" (this is particularly cool).

| +++ linux/fs/super.c	2004-09-18 02:24:33.000000000 -0400
| @@ -36,6 +36,7 @@
|  #include <linux/writeback.h>		/* for the emergency remount stuff */
|  #include <linux/idr.h>
|  #include <asm/uaccess.h>
| +#include <linux/inotify.h>
|
|
|  void get_filesystem(struct file_system_type *fs);
| @@ -204,6 +205,7 @@
|
|  	if (root) {
|  		sb->s_root = NULL;
| +		inotify_super_block_umount (sb);
|  		shrink_dcache_parent(root);
|  		shrink_dcache_anon(&sb->s_anon);
|  		dput(root);

This doesn't seem right.  generic_shutdown_super is only called when the
last instance of a super is released.  If a system were to have a
filesystem mounted in two locations (for instance, by creating a new
namespace), then the umount and ignore would not get propagated when one
is unmounted.

How about an approach that somehow referenced vfsmounts (without having
a reference count proper)?  That way you could queue messages in
umount_tree and do_umount..

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

iD8DBQFBWaGHdQs4kOxk3/MRAr22AJ0SHDUiIXKRKE/TBFmTYBL5J7KD9gCbBoso
DYRg+SjnO8urCKLmDbehvkM=
=5fMW
-----END PGP SIGNATURE-----
