Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbUKHSAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUKHSAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUKHR6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:58:36 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:25595 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261791AbUKHRxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 12:53:30 -0500
Date: Mon, 08 Nov 2004 12:53:00 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH] Mounting on floating mounts is possible
In-reply-to: <20041108182004.267bd72b@doener>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Message-id: <418FB27C.7030300@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20041106060455.0100e3ec@doener> <418F9CCB.1000202@sun.com>
 <20041108182004.267bd72b@doener>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Björn Steinbrink wrote:
> On Mon, 08 Nov 2004 11:20:27 -0500
> Mike Waychison <Michael.Waychison@Sun.COM> wrote:
> 
>>Björn Steinbrink wrote:
>>
>>>Hi,
>>>
>>>this[1] patch changed check_mnt() so that mounting on a floating
>>>mount(i.e. one that was unmounted using MNT_DETACH and was still in
>>>use) is possible, since we no longer check if the mountpoint is
>>>actually reachable. The problem is that we may lose any reference to
>>>the floating mount, but the mount on it will keep it alive, thus it
>>>will never go away. The following patch removes the reference from
>>>the mount to its namespace when it is unmounted lazily, so that
>>>check_mnt protects from such mounts.
>>>
>>>Please CC me as I'm not subscribed to the list.
>>>
>>>Bjoern
>>>
>>>[1] http://lwn.net/Articles/91946/
>>>
>>>diff -uNr --minimal a/fs/namespace.c b/fs/namespace.c
>>>--- a/fs/namespace.c    2004-10-31 00:41:02.000000000 +0200
>>>+++ b/fs/namespace.c    2004-11-06 04:38:37.299013810 +0100
>>>@@ -358,6 +358,7 @@
>>>                } else {
>>>                        struct nameidata old_nd;
>>>                        detach_mnt(mnt, &old_nd);
>>>+                       mnt->mnt_namespace = NULL;
>>>                        spin_unlock(&vfsmount_lock);
>>>                        path_release(&old_nd);
>>>                }
>>>-
>>
>>I don't think this patch clears mnt_namespace for the root of the
>>umounted tree.  How about this?
>>
> 
> 
> The root mount of the umounted tree is not detached yet, i.e. it has
> mnt->mnt_parent != mnt and is detached in the else-branch, so that is
> handled fine (at least my tests said so ;).
> Only detached mounts and the namespace's root mount (that's the rootfs
> mount IIRC) have mnt->mnt_parent==mnt. And we have two cases here:
> a) already detached mount, this cannot happen. The only possibility to
> get a detached mount into umount is the same we currently have with
> mount, some process kept a reference and used a relative path. But
> with the patch we would already bail out in check_mnt earlier in this
> case.
> b) root mount, is not detached so all mounts are still reachable
> and can be unmounted as usual.
> 

Yup.  Okay, I got confused somewhere.

FWIW, the autofsng patchset I sent out a while ago I moved all the
mnt_namespace accounting into attach_mnt and detach_mnt.  It also allows
detached mounts to be trees..

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

iD8DBQFBj7J7dQs4kOxk3/MRAj17AJ4ye0gtvg3YxwcKKT4pMoyAtIcnmQCeIKh/
g9i4P8m94gMFR5djT9G7wYg=
=htws
-----END PGP SIGNATURE-----
