Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSHBTBd>; Fri, 2 Aug 2002 15:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSHBTBd>; Fri, 2 Aug 2002 15:01:33 -0400
Received: from ns.suse.de ([213.95.15.193]:11788 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316715AbSHBTBb>;
	Fri, 2 Aug 2002 15:01:31 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Apply the umask in VFS optionally
Date: Fri, 2 Aug 2002 21:05:00 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_C0D8V2ZS89J5SZP6WFWO"
Message-Id: <200208022105.00362.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C0D8V2ZS89J5SZP6WFWO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

The umask(2) is usually applied to the mode parameters to open(2), mkdir(=
2),=20
creat(2) and mknod(2) in the VFS. With POSIX Access Control Lists the uma=
sk=20
must only be applied in some situations, and must have no effect in other=
s.=20
Currently there is no way for a file system to find out the original mode=
=20
parameter passed to the system calls.

There are two ways to solve this problem, namely, to (1) move the code th=
at=20
applies the umask into the file systems, or to (2) apply the umask in the=
 VFS=20
optionally only. Option (1) is intrusive on existing file systems, and mi=
ght=20
introduce bugs, while (2) slightly complicates the VFS, but leaves file=20
systems unaffected.

I believe that (2) is the more reasonable choice in this case, so I propo=
se=20
this patch, which adds the MS_NOUMASK mount option. The flag is set by th=
e=20
file system, if the file system does not want the VFS to apply the umask,=
=20
after which the file system itself is responsible for applying the umask=20
where appropriate.

Finally, I have a question related to this. We had a bug with kernel task=
s,=20
which don't have a umask associated with them (nfsd in particular). Shoul=
d=20
kernel tasks that create files be required to have a valid fs_struct (whi=
ch=20
includes the umask), or should this be special cased in file systems?

Regards,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany

--------------Boundary-00=_C0D8V2ZS89J5SZP6WFWO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.5.30-ms_noumask.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.5.30-ms_noumask.diff"

Apply the umask in VFS optionally

This patch adds the MS_NOUMASK mount option. This mount option is set by the file system, if the file system does not want the VFS to apply the umask.

diff -Nur linux-2.5.30/include/linux/fs.h linux-2.5.30.patch/include/linux/fs.h
--- linux-2.5.30/include/linux/fs.h	Thu Aug  1 23:16:15 2002
+++ linux-2.5.30.patch/include/linux/fs.h	Fri Aug  2 15:21:29 2002
@@ -110,6 +110,7 @@
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_NOUMASK	(1<<16) /* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
@@ -164,6 +165,7 @@
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
+#define IS_NOUMASK(inode)	__IS_FLG(inode, MS_NOUMASK)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 
diff -Nur linux-2.5.30/fs/namei.c linux-2.5.30.patch/fs/namei.c
--- linux-2.5.30/fs/namei.c	Thu Aug  1 23:16:18 2002
+++ linux-2.5.30.patch/fs/namei.c	Fri Aug  2 15:35:10 2002
@@ -1279,8 +1279,9 @@
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode) {
-		error = vfs_create(dir->d_inode, dentry,
-				   mode & ~current->fs->umask);
+		if (!IS_NOUMASK(dir->d_inode))
+			mode &= ~current->fs->umask;
+		error = vfs_create(dir->d_inode, dentry, mode);
 		up(&dir->d_inode->i_sem);
 		dput(nd->dentry);
 		nd->dentry = dentry;
@@ -1442,7 +1443,8 @@
 	dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(dentry);
 
-	mode &= ~current->fs->umask;
+	if (!IS_NOUMASK(nd.dentry->d_inode))
+		mode &= ~current->fs->umask;
 	if (!IS_ERR(dentry)) {
 		switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
@@ -1508,8 +1510,9 @@
 		dentry = lookup_create(&nd, 1);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
-			error = vfs_mkdir(nd.dentry->d_inode, dentry,
-					  mode & ~current->fs->umask);
+			if (!IS_NOUMASK(nd.dentry->d_inode))
+				mode &= ~current->fs->umask;
+			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);

--------------Boundary-00=_C0D8V2ZS89J5SZP6WFWO--

