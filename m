Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267000AbRGMW7s>; Fri, 13 Jul 2001 18:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267060AbRGMW7k>; Fri, 13 Jul 2001 18:59:40 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:25809 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267000AbRGMW72>; Fri, 13 Jul 2001 18:59:28 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Abramo Bagnara <abramo@alsa-project.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        nfs-devel@linux.kernel.org, nfs@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>
Date: Sat, 14 Jul 2001 08:47:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15183.31372.316080.1208@notabene.cse.unsw.edu.au>
Subject: Re: [NFS] [PATCH] Bug in NFS - should init be allowed to set umask???
In-Reply-To: message from Neil Brown on Friday July 13
In-Reply-To: <3B4E93E9.F6506CC0@alsa-project.org>
	<15182.48923.214510.180434@notabene.cse.unsw.edu.au>
	<3B4EDBCE.D2AEAD16@alsa-project.org>
	<15182.58236.133661.221154@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 13, neilb@cse.unsw.edu.au wrote:
> So we have several options:
> 
> 1/ Claim that redhat is broken. Leave them to fix SysVinit.
> 2/ Have nfsd over-write the umask setting that /sbin/init imposed.
>    This is effectively what your patch does.
> 3/ Decide that it is inappropriate for nfsd to share the current->fs
>    fs_struct with init.  Unfortunately this means changing or
>    replacing daemonize().
> 
> None of these seem ideal.  (3) is probably most correct (i.e. protect
> the kernel from user space mucking about) but is the most work.

I've found a 4th option.  We make it so that fs->umask does not affect
nfsd, just as the rest of the fs_struct has no effect on nfsd.
This means moving the " & ~current->fs->umask" up out of the vfs_*
routines and into the sys_* (or open_namei) routines.

The attached patch does this.
The only part that I'm not 100% confident of is the call to vfs_mknod
in net/unix/af_unix.c:unix_bind.  I haven't put an "& ~current->fs->umask"
there, as I suspect that is actually the right thing.  Any comments on
that?

Al, as this is a vfs change, I have cc:ed you.  Are you happy with it?
It allows nfsd to not be effected by any change the init might make to
umask.

This patch also puts the umask for init back to 0022.

NeilBrown


--- ./fs/namei.c	2001/07/13 21:43:03	1.1
+++ ./fs/namei.c	2001/07/13 22:38:31	1.2
@@ -886,7 +886,7 @@
 {
 	int error;
 
-	mode &= S_IALLUGO & ~current->fs->umask;
+	mode &= S_IALLUGO;
 	mode |= S_IFREG;
 
 	down(&dir->i_zombie);
@@ -975,7 +975,8 @@
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode) {
-		error = vfs_create(dir->d_inode, dentry, mode);
+		error = vfs_create(dir->d_inode, dentry,
+				   mode & ~current->fs->umask);
 		up(&dir->d_inode->i_sem);
 		dput(nd->dentry);
 		nd->dentry = dentry;
@@ -1164,8 +1165,6 @@
 {
 	int error = -EPERM;
 
-	mode &= ~current->fs->umask;
-
 	down(&dir->i_zombie);
 	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
 		goto exit_lock;
@@ -1208,6 +1207,8 @@
 		goto out;
 	dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(dentry);
+
+	mode &= ~current->fs->umask;
 	if (!IS_ERR(dentry)) {
 		switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
@@ -1246,7 +1247,7 @@
 		goto exit_lock;
 
 	DQUOT_INIT(dir);
-	mode &= (S_IRWXUGO|S_ISVTX) & ~current->fs->umask;
+	mode &= (S_IRWXUGO|S_ISVTX);
 	lock_kernel();
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	unlock_kernel();
@@ -1276,7 +1277,8 @@
 		dentry = lookup_create(&nd, 1);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
-			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
+			error = vfs_mkdir(nd.dentry->d_inode, dentry,
+					  mode & ~current->fs->umask);
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);

--- ./include/linux/fs_struct.h	2001/07/13 22:46:19	1.1
+++ ./include/linux/fs_struct.h	2001/07/13 22:46:40	1.2
@@ -13,7 +13,7 @@
 #define INIT_FS { \
 	ATOMIC_INIT(1), \
 	RW_LOCK_UNLOCKED, \
-	0000, \
+	0022, \
 	NULL, NULL, NULL, NULL, NULL, NULL \
 }
 
