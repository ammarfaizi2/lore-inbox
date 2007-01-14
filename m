Return-Path: <linux-kernel-owner+w=401wt.eu-S1751680AbXANVDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbXANVDp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 16:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbXANVDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 16:03:45 -0500
Received: from galaxy.systems.pipex.net ([62.241.162.31]:57333 "EHLO
	galaxy.systems.pipex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbXANVDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 16:03:44 -0500
Date: Sun, 14 Jan 2007 21:03:40 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@ginsburg.homenet
To: hugh@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: umask ignored in mkdir(2)?
In-Reply-To: <Pine.LNX.4.61.0701142039301.18638@ginsburg.homenet>
Message-ID: <Pine.LNX.4.61.0701142058110.18997@ginsburg.homenet>
References: <Pine.LNX.4.61.0701142034300.18638@ginsburg.homenet>
 <Pine.LNX.4.61.0701142039301.18638@ginsburg.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I figured it out! I thought you might be interested --- the reason is the 
mismatch between the default mount options stored in the superblock on 
disk and the filesystem features compiled into the kernel.

Namely, dumpe2fs on the offending filesystems showed the following default 
mount options:

user_xattr acl

but on good filesystems it showed "(none)". So, I used "tune2fs -o ^acl"
(and ^user_xattr) to clear these in the superblock and mounted the 
filesystem --- and now mkdir system call works as expected, i.e. 
honours the umask.

Maybe the ext3 filesystem should automatically detect this (the mismatch) 
and printk a warning so the user is told that his filesystem is mounted in 
extremely insecure way, i.e. making directories as root will result in 
lots of 0777 places (e.g. try "make modules_install" --- this will create 
lots of security holes in /lib/modules).

I cc'd linux-kernel as someone may wish to fix this. (see below for the 
actual report).

Kind regards
Tigran

On Sun, 14 Jan 2007, Tigran Aivazian wrote:

> I forgot to mention that on another machine running the same kernel version 
> with the same (as close as a UP machine can be to SMP) kernel configuration 
> the umask is honoured properly on ext3 filesystem.
>
> On Sun, 14 Jan 2007, Tigran Aivazian wrote:
>
>> Hi Hugh,
>> 
>> I think I may have found a bug --- on one of my machines the umask value is 
>> ignored by ext3 (but honoured on tmpfs) for mkdir system call:
>> 
>> $ cd /tmp
>> $ df -T .
>> Filesystem    Type   1K-blocks      Used Available Use% Mounted on
>> /dev/hdf1     ext3   189238556 155721568  23749068  87% /
>> $ rmdir ok ; mkdir ok ; ls -ld ok
>> rmdir: ok: No such file or directory
>> drwxrwxrwx 2 tigran tigran 4096 Jan 14 20:36 ok/
>> $ umask
>> 0022
>> $ cd /dev/shm
>> $ df -T .
>> Filesystem    Type   1K-blocks      Used Available Use% Mounted on
>> tmpfs        tmpfs      517988         0    517988   0% /dev/shm
>> $ rmdir ok ; mkdir ok ; ls -ld ok
>> rmdir: ok: No such file or directory
>> drwxr-xr-x 2 tigran tigran 40 Jan 14 20:36 ok/
>> $ uname -a
>> Linux ws 2.6.19.1 #6 SMP Sun Jan 14 20:03:30 GMT 2007 i686 i686 i386 
>> GNU/Linux
>> $ grep -i acl /usr/src/linux/.config
>> # CONFIG_FS_POSIX_ACL is not set
>> # CONFIG_TMPFS_POSIX_ACL is not set
>> # CONFIG_NFS_V3_ACL is not set
>> # CONFIG_NFSD_V3_ACL is not set
>> 
>> As you see, ACL is not configured in, and neither are extended attributes:
>> 
>> $ grep -i xattr /usr/src/linux/.config
>> # CONFIG_EXT2_FS_XATTR is not set
>> # CONFIG_EXT3_FS_XATTR is not set
>> 
>> So, this is something fs-specific. What do you think?
>> 
>> Kind regards
>> Tigran
>> 
>
