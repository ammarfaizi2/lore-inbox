Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbUJYSES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbUJYSES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUJYSDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:03:16 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:63955 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261198AbUJYRZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:25:48 -0400
Date: Mon, 25 Oct 2004 13:25:33 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 13/28] VFS: Introduce soft reference counts
In-reply-to: <417D35F0.1070501@kolumbus.fi>
To: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Message-id: <417D370D.3090700@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <10987154731896@sun.com> <10987155032816@sun.com>
 <417D35F0.1070501@kolumbus.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mika Penttilä wrote:
> Mike Waychison wrote:
> 
>> This patch introduces the concept of a 'soft' reference count for a
>> vfsmount.
>> This type of reference count allows for references to be held on
>> mountpoints
>> that do not affect their busy states for userland unmounting.  Some might
>> argue that this is wrong because 'when I unmount a filesystem, I want the
>> resources associated with it to go away too', but this way of thinking
>> was
>> deprecated with the addition of namespaces and --bind back in the 2.4
>> series.
>>
>> A future addition may see a callback mechanism so that in kernel users
>> can
>> use a given mountpoint and have it deregistered some way (quota and
>> accounting come to mind).
>>
>> These soft reference counts are used by a later patch that adds an
>> interface
>> for holding and manipulating mountpoints using filedescriptors.
>>
>> Signed-off-by: Mike Waychison <michael.waychison@sun.com>
>>
>> +static inline struct vfsmount *mntsoftget(struct vfsmount *mnt)
>> +{
>> +    if (mnt) {
>> +        read_lock(&vfsmountref_lock);
>> +        atomic_inc(&mnt->mnt_softcount);
>> +        mntgroupget(mnt);
>> +        read_unlock(&vfsmountref_lock);
>> +    }
>> +    return mnt;
>> +}
>> +
>> +static inline void mntsoftput(struct vfsmount *mnt)
>> +{
>> +    struct vfsmount *cleanup;
>> +    might_sleep();
>> +    if (mnt) {
>> +        if (atomic_dec_and_test(&mnt->mnt_count))
>> +            __mntput(mnt);
>> +        read_lock(&vfsmountref_lock);
>> +        cleanup = mntgroupput(mnt);
>> +        atomic_dec(&mnt->mnt_softcount);
>> +        read_unlock(&vfsmountref_lock);
>> +        if (cleanup)
>> +            __mntgroupput(cleanup);
>> +    }
>> +}
>> +
>> extern void free_vfsmnt(struct vfsmount *mnt);
>>  
>>
> What is this against? What are mntgroupput and mntgroupget? 

This is against patch [PATCH 11/28] VFS: Allow detachable subtrees.

In that patch, mntgroup(get|put) handles the count of all non-glue
references for a given tree of vfsmounts.


> Why does soft put decrement mnt_count which isn't increment by soft get? 

Ah, thanks for pointing that out.  It got messed up when I created the
patchset from the bk tree. Will fix.

> How do
> soft references allow userland umount? I don't see soft references used
> anywhere...

Soft references are used by the mountpoint file descriptor patch
[14/28].  They allow references to be had on a vfsmount such that the
mountpoint itself is not kept busy in the namespace.  This allows a
program to 'grab a mountpoint' by a magic file (gotten by sys_mountfd),
and perform ops on it.   The mountfd holds a reference to the vfsmount,
but it doesn't keep userspace from trying to umount(2) the path.

Does that help?

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

iD8DBQFBfTcNdQs4kOxk3/MRAnZwAKCTv7SMsT/+o4WLMJGapFVKURsbNwCeI+iF
sZCOzRRNcnesK8rFN2haEww=
=eFwD
-----END PGP SIGNATURE-----
