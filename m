Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTBFBy4>; Wed, 5 Feb 2003 20:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTBFBy4>; Wed, 5 Feb 2003 20:54:56 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:33681 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264631AbTBFByz>; Wed, 5 Feb 2003 20:54:55 -0500
Message-Id: <200302060204.DAA24234@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: klibc update
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Date: Thu, 06 Feb 2003 02:45:24 +0100
References: <20030205053013$7d61@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Any help with trying to debug init/initramfs.c to figure out what is
> going wrong would be greatly appreciated.

I've managed to mount the initramfs with MS_BIND into my root fs and
found why /sbin/hotplug cannot be run currently. There is some 
off-by-one bug during file extraction that causes the first byte 
of the file to get left out. I.e. the file starts with "ELF\001"
instead of "\577ELF".

This may or may not be related to another off-by-one bug that I'm
seeing sometime when unpacking initramfs on s390x ("panic: length 
error").

The patch below is how I hacked prepare_namespace() to keep 
initramfs visible after boot.

        Arnd <><

--- 1.33/init/do_mounts.c       Sun Jan  5 16:28:41 2003
+++ edited/init/do_mounts.c     Thu Feb  6 01:12:29 2003
@@ -892,6 +892,7 @@
        mount_root();
 out:
        sys_umount("/dev", 0);
+       sys_mount("/", "./initrd", NULL, MS_BIND, NULL);
        sys_mount(".", "/", NULL, MS_MOVE, NULL);
        sys_chroot(".");
        security_sb_post_mountroot();
--- 1.33/fs/namespace.c Thu Nov 28 00:11:14 2002
+++ edited/fs/namespace.c       Thu Feb  6 01:59:20 2003
@@ -460,7 +460,7 @@
 {
        int err;
        if (mnt->mnt_sb->s_flags & MS_NOUSER)
-               return -EINVAL;
+               ; // return -EINVAL;
 
        if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
              S_ISDIR(mnt->mnt_root->d_inode->i_mode))

