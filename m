Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSIBSyp>; Mon, 2 Sep 2002 14:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSIBSyp>; Mon, 2 Sep 2002 14:54:45 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:21773 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316408AbSIBSyo>;
	Mon, 2 Sep 2002 14:54:44 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209021859.g82Ix3828853@oboe.it.uc3m.es>
Subject: [PATCH] VFS supports "direct" (O_DIRECT) flag on mount
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Mon, 2 Sep 2002 20:59:03 +0200 (MET DST)
Cc: viro@math.psu.edu
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc'ed Al Viro and kernel list)

I want to pass a flag to mount so that the FS mounted on a block device
passes all reads and writes and other changes through to the underlying
device without caching them in VFS first. I know that at least opening
all files O_DIRECT will pass reads and writes through. Metadata I don't
know about.

I have modified /bin/mount to take the "direct" option and generate a
MS_DIRECT flag as it calls mount(2).

I don't know if this patch is sensible or not, and I'm no expert on VFS,
so take it as an example for discussion ...

The result seems to work on my toy device.  I think I had to make an
extra minor addition to the ext2 parse_opts routine to accept my flag,
but the rest of the patch is here.  What I'd like you to do is to tell
me what remains to be done, or if this is already done, or if I have
done it wrong.  I don't know anything about the VFS layer.

The idea embodied in the patch is that if we get the MS_DIRECT flag when
the vfs do_mount() is called, we pass it across into the mnt flags used
by do_add_mount() as MNT_DIRECT.  Then, in the generic dentry_open() calls
on files, we examine the flags on the mnt parameter and set the O_DIRECT
flag on the file pointer if MNT_DIRECT was set on the vfsmnt object.

Is this right, and is it sufficient? Are there flags which already do
this?

(I'm only guessing at the relationships between all these functions
and parameters. In particular I guestimate that default file flags
may come from somewhere like the superblock, which is a path
I have not investigated).

Thanking you for your comments.

Peter

--- linux-2.5.31/fs/open.c.pre-o_direct	Mon Sep  2 20:36:11 2002
+++ linux-2.5.31/fs/open.c	Mon Sep  2 17:12:08 2002
@@ -643,6 +643,11 @@
 		if (error)
 			goto cleanup_file;
 	}
+        /* PTB file inherits O_DIRECT from mount flags */
+        if ((mnt->mnt_flags & MNT_DIRECT)) {
+            f->f_flags |= O_DIRECT;
+        }
+
 	f->f_ra.ra_pages = inode->i_mapping->backing_dev_info->ra_pages;
 	f->f_dentry = dentry;
 	f->f_vfsmnt = mnt;
--- linux-2.5.31/fs/namespace.c.pre-o_direct	Mon Sep  2 20:37:39 2002
+++ linux-2.5.31/fs/namespace.c	Mon Sep  2 17:12:04 2002
@@ -201,6 +201,7 @@
 		{ MS_MANDLOCK, ",mand" },
 		{ MS_NOATIME, ",noatime" },
 		{ MS_NODIRATIME, ",nodiratime" },
+		{ MS_DIRECT, ",direct" }, /* PTB set opens O_DIRECT */
 		{ 0, NULL }
 	};
 	static struct proc_fs_info mnt_info[] = {
@@ -734,7 +741,11 @@
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
-	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
+        /* PTB move DIRECT flag too */
+	if (flags & MS_DIRECT) {
+		mnt_flags |= MNT_DIRECT;
+       }
+	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_DIRECT);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
--- linux-2.5.31/include/linux/mount.h.pre-o_direct	Mon Sep  2 20:31:16 2002
+++ linux-2.5.31/include/linux/mount.h	Mon Sep  2 18:06:14 2002
@@ -17,6 +17,7 @@
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
 #define MNT_NOEXEC	4
+#define MNT_DIRECT	256         /* PTB O_DIRECT on files */
 
 struct vfsmount
 {
--- linux-2.5.31/include/linux/fs.h.pre-o_direct	Mon Sep  2 20:32:05 2002
+++ linux-2.5.31/include/linux/fs.h	Mon Sep  2 18:05:57 2002
@@ -104,6 +104,9 @@
 #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
 #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
 #define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+
+#define MS_DIRECT	256     /* PTB set all opens to be O_DIRECT */
+
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
