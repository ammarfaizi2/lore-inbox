Return-Path: <linux-kernel-owner+w=401wt.eu-S1751400AbXAOWBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXAOWBj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 17:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbXAOWBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 17:01:39 -0500
Received: from extu-mxob-2.symantec.com ([216.10.194.135]:39275 "EHLO
	extu-mxob-2.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXAOWBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 17:01:38 -0500
X-AuditID: d80ac287-9999cbb000003a2b-06-45abfb2f729c 
Date: Mon, 15 Jan 2007 22:01:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: Andrew Morton <akpm@osdl.org>, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: umask ignored in mkdir(2)?
In-Reply-To: <Pine.LNX.4.61.0701142058110.18997@ginsburg.homenet>
Message-ID: <Pine.LNX.4.64.0701152145250.7733@blonde.wat.veritas.com>
References: <Pine.LNX.4.61.0701142034300.18638@ginsburg.homenet>
 <Pine.LNX.4.61.0701142039301.18638@ginsburg.homenet>
 <Pine.LNX.4.61.0701142058110.18997@ginsburg.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Jan 2007 22:01:37.0143 (UTC) FILETIME=[BA404870:01C738F0]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I've rearranged this to avoid a horrid mix of top and bottom posting]

On Sun, 14 Jan 2007, Tigran Aivazian wrote:
> On Sun, 14 Jan 2007, Tigran Aivazian wrote:
> > On Sun, 14 Jan 2007, Tigran Aivazian wrote:
> > > I think I may have found a bug --- on one of my machines the umask value
> > > is ignored by ext3 (but honoured on tmpfs) for mkdir system call:
> > > 
> > > $ cd /tmp
> > > $ df -T .
> > > Filesystem    Type   1K-blocks      Used Available Use% Mounted on
> > > /dev/hdf1     ext3   189238556 155721568  23749068  87% /
> > > $ rmdir ok ; mkdir ok ; ls -ld ok
> > > rmdir: ok: No such file or directory
> > > drwxrwxrwx 2 tigran tigran 4096 Jan 14 20:36 ok/
> > > $ umask
> > > 0022
> > > $ cd /dev/shm
> > > $ df -T .
> > > Filesystem    Type   1K-blocks      Used Available Use% Mounted on
> > > tmpfs        tmpfs      517988         0    517988   0% /dev/shm
> > > $ rmdir ok ; mkdir ok ; ls -ld ok
> > > rmdir: ok: No such file or directory
> > > drwxr-xr-x 2 tigran tigran 40 Jan 14 20:36 ok/
> > > $ uname -a
> > > Linux ws 2.6.19.1 #6 SMP Sun Jan 14 20:03:30 GMT 2007 i686 i686 i386
> > > GNU/Linux
> > > $ grep -i acl /usr/src/linux/.config
> > > # CONFIG_FS_POSIX_ACL is not set
> > > # CONFIG_TMPFS_POSIX_ACL is not set
> > > # CONFIG_NFS_V3_ACL is not set
> > > # CONFIG_NFSD_V3_ACL is not set
> > > 
> > > As you see, ACL is not configured in, and neither are extended attributes:
> > > 
> > > $ grep -i xattr /usr/src/linux/.config
> > > # CONFIG_EXT2_FS_XATTR is not set
> > > # CONFIG_EXT3_FS_XATTR is not set
> > > 
> > > So, this is something fs-specific. What do you think?
> >
> > I forgot to mention that on another machine running the same kernel version
> > with the same (as close as a UP machine can be to SMP) kernel configuration
> > the umask is honoured properly on ext3 filesystem.
> 
> I figured it out! I thought you might be interested --- the reason is the
> mismatch between the default mount options stored in the superblock on disk
> and the filesystem features compiled into the kernel.
> 
> Namely, dumpe2fs on the offending filesystems showed the following default
> mount options:
> 
> user_xattr acl
> 
> but on good filesystems it showed "(none)". So, I used "tune2fs -o ^acl"
> (and ^user_xattr) to clear these in the superblock and mounted the filesystem
> --- and now mkdir system call works as expected, i.e. honours the umask.
> 
> Maybe the ext3 filesystem should automatically detect this (the mismatch) and
> printk a warning so the user is told that his filesystem is mounted in
> extremely insecure way, i.e. making directories as root will result in lots of
> 0777 places (e.g. try "make modules_install" --- this will create lots of
> security holes in /lib/modules).
> 
> I cc'd linux-kernel as someone may wish to fix this.

Good find!  Though I suppose not much of a worry for distros,
whose kernels will always(?) have ACLs configured in.

I get sooo confused when there's multiple ways of switching something
on and off (at the ifdef level and at the mount opts level and at the
tuning level), looks like others do too.  Here's my third version of
a patch, already wondering if a fourth would be better (at the point
where they set s_flags) ... no, I think this one is more robust...


[PATCH] fix umask when noACL kernel meets extN tuned for ACLs

Fix insecure default behaviour reported by Tigran Aivazian: if an ext2
or ext3 or ext4 filesystem is tuned to mount with "acl", but mounted by
a kernel built without ACL support, then umask was ignored when creating
inodes - though root or user has umask 022, touch creates files as 0666,
and mkdir creates directories as 0777.

This appears to have worked right until 2.6.11, when a fix to the default
mode on symlinks (always 0777) assumed VFS applies umask: which it does,
unless the mount is marked for ACLs; but ext[234] set MS_POSIXACL in
s_flags according to s_mount_opt set according to def_mount_opts.

We could revert to the 2.6.10 ext[234]_init_acl (adding an S_ISLNK test);
but other filesystems only set MS_POSIXACL when ACLs are configured.  We
could fix this at another level; but it seems most robust to avoid setting
the s_mount_opt flag in the first place (at the expense of more ifdefs).

Likewise don't set the XATTR_USER flag when built without XATTR support.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/ext2/super.c |    4 ++++
 fs/ext3/super.c |    4 ++++
 fs/ext4/super.c |    4 ++++
 3 files changed, 12 insertions(+)

--- 2.6.20-rc5/fs/ext2/super.c	2007-01-13 08:46:07.000000000 +0000
+++ linux/fs/ext2/super.c	2007-01-15 20:48:38.000000000 +0000
@@ -708,10 +708,14 @@ static int ext2_fill_super(struct super_
 		set_opt(sbi->s_mount_opt, GRPID);
 	if (def_mount_opts & EXT2_DEFM_UID16)
 		set_opt(sbi->s_mount_opt, NO_UID32);
+#ifdef CONFIG_EXT2_FS_XATTR
 	if (def_mount_opts & EXT2_DEFM_XATTR_USER)
 		set_opt(sbi->s_mount_opt, XATTR_USER);
+#endif
+#ifdef CONFIG_EXT2_FS_POSIX_ACL
 	if (def_mount_opts & EXT2_DEFM_ACL)
 		set_opt(sbi->s_mount_opt, POSIX_ACL);
+#endif
 	
 	if (le16_to_cpu(sbi->s_es->s_errors) == EXT2_ERRORS_PANIC)
 		set_opt(sbi->s_mount_opt, ERRORS_PANIC);
--- 2.6.20-rc5/fs/ext3/super.c	2007-01-13 08:46:07.000000000 +0000
+++ linux/fs/ext3/super.c	2007-01-15 20:48:38.000000000 +0000
@@ -1459,10 +1459,14 @@ static int ext3_fill_super (struct super
 		set_opt(sbi->s_mount_opt, GRPID);
 	if (def_mount_opts & EXT3_DEFM_UID16)
 		set_opt(sbi->s_mount_opt, NO_UID32);
+#ifdef CONFIG_EXT3_FS_XATTR
 	if (def_mount_opts & EXT3_DEFM_XATTR_USER)
 		set_opt(sbi->s_mount_opt, XATTR_USER);
+#endif
+#ifdef CONFIG_EXT3_FS_POSIX_ACL
 	if (def_mount_opts & EXT3_DEFM_ACL)
 		set_opt(sbi->s_mount_opt, POSIX_ACL);
+#endif
 	if ((def_mount_opts & EXT3_DEFM_JMODE) == EXT3_DEFM_JMODE_DATA)
 		sbi->s_mount_opt |= EXT3_MOUNT_JOURNAL_DATA;
 	else if ((def_mount_opts & EXT3_DEFM_JMODE) == EXT3_DEFM_JMODE_ORDERED)
--- 2.6.20-rc5/fs/ext4/super.c	2007-01-13 08:46:07.000000000 +0000
+++ linux/fs/ext4/super.c	2007-01-15 20:48:38.000000000 +0000
@@ -1518,10 +1518,14 @@ static int ext4_fill_super (struct super
 		set_opt(sbi->s_mount_opt, GRPID);
 	if (def_mount_opts & EXT4_DEFM_UID16)
 		set_opt(sbi->s_mount_opt, NO_UID32);
+#ifdef CONFIG_EXT4DEV_FS_XATTR
 	if (def_mount_opts & EXT4_DEFM_XATTR_USER)
 		set_opt(sbi->s_mount_opt, XATTR_USER);
+#endif
+#ifdef CONFIG_EXT4DEV_FS_POSIX_ACL
 	if (def_mount_opts & EXT4_DEFM_ACL)
 		set_opt(sbi->s_mount_opt, POSIX_ACL);
+#endif
 	if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_DATA)
 		sbi->s_mount_opt |= EXT4_MOUNT_JOURNAL_DATA;
 	else if ((def_mount_opts & EXT4_DEFM_JMODE) == EXT4_DEFM_JMODE_ORDERED)
