Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbUJZORc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbUJZORc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUJZORc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:17:32 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:51372 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262271AbUJZORQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:17:16 -0400
Date: Tue, 26 Oct 2004 10:16:51 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 15/28] VFS: Mountpoint file descriptor umount support
In-reply-to: <20041026102838.GB12026@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Message-id: <417E5C53.7040903@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <10987155332448@sun.com> <10987155691365@sun.com>
 <20041026102838.GB12026@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Mon, Oct 25, 2004 at 10:46:09AM -0400, Mike Waychison wrote:
> 
>>This patch adds functionality to mountfd so that a user can perform the
>>various types of umount (forced umount, not-busy umount, lazy-umount).
>>
>>Signed-off-by: Mike Waychison <michael.waychison@sun.com>
>>---
>>
>> fs/mountfd.c       |   20 ++++++++++++++++++++
>> fs/namespace.c     |    2 +-
>> include/linux/fs.h |    5 ++++-
>> 3 files changed, 25 insertions(+), 2 deletions(-)
>>
>>Index: linux-2.6.9-quilt/fs/mountfd.c
>>===================================================================
>>--- linux-2.6.9-quilt.orig/fs/mountfd.c	2004-10-22 17:17:40.736271288 -0400
>>+++ linux-2.6.9-quilt/fs/mountfd.c	2004-10-22 17:17:41.367175376 -0400
>>@@ -11,6 +11,8 @@
>> 
>> #define VFSMOUNT(filp) ((struct vfsmount *)((filp)->private_data))
>> 
>>+extern int do_umount(struct vfsmount *mnt, int flags);
>>+
>> static struct vfsmount *mfdfs_mnt;
>> 
>> static void mfdfs_read_inode(struct inode *inode);
>>@@ -72,6 +74,18 @@ static int mfd_release(struct inode *ino
>> 	return 0;
>> }
>> 
>>+static long mfd_umount(struct file *mountfilp, int flags)
>>+{
>>+	struct vfsmount *mnt;
>>+	int error;
>>+	
>>+	mnt = mntget(VFSMOUNT(mountfilp));
>>+
>>+	error = do_umount(mnt, flags);
>>+
>>+	return error;
>>+}
>>+
>> static int mfd_ioctl(struct inode *inode, struct file *filp,
>> 		     unsigned int cmd, unsigned long arg);
>> static struct file_operations mfd_file_ops = {
>>@@ -243,6 +257,12 @@ static int mfd_ioctl(struct inode *inode
>> 	switch (cmd) {
>> 	case MOUNTFD_IOC_GETDIRFD:
>> 		return mfd_getdirfd(filp);
>>+	case MOUNTFD_IOC_DETACH:
>>+		return mfd_umount(filp, MNT_DETACH);
>>+	case MOUNTFD_IOC_UNMOUNT:
>>+		return mfd_umount(filp, 0);
>>+	case MOUNTFD_IOC_FORCEDUNMOUNT:
>>+		return mfd_umount(filp, MNT_FORCE);
> 
> 
> Urgg, you don't want to add gazillions of strange ioctls, do you?
> 

Only a couple million ;)

I have toyed with different interfaces.  I have older patches that would
allow you to read/write on the fd to perform ops, but the code is a mess
of parsing/data checks.  I also toyed with a multiplexed syscall, but
realized real quick that it was an ioctl with a different name, that
only worked on mountfds.

ioctl ended up being the cleanest solution (I came up with) in the end.

Alternatives?

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

iD8DBQFBflxTdQs4kOxk3/MRAq0NAJ9leUcfelicGndvtqGXqGgMlNoREACfXmXe
XsmXEDdefmJi7L8XmuKrQSk=
=xWa5
-----END PGP SIGNATURE-----
