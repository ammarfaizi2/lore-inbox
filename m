Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318792AbSICO47>; Tue, 3 Sep 2002 10:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318793AbSICO47>; Tue, 3 Sep 2002 10:56:59 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:29199 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318792AbSICO45>;
	Tue, 3 Sep 2002 10:56:57 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031501.g83F1Oa31142@oboe.it.uc3m.es>
Subject: [RFC] mount flag "direct"
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 3 Sep 2002 17:01:24 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll rephrase this as an RFC, since I want help and comments.

Scenario:
I have a driver which accesses a "disk" at the block level, to which
another driver on another machine is also writing. I want to have
an arbitrary FS on this device which can be read from and written to
from both kernels, and I want support at the block level for this idea.

Question:
What do people think of adding a "direct" option to mount, with the
semantics that the VFS then makes all opens on files on the FS mounted
"direct" use O_DIRECT, which means that file r/w is not cached in VMS,
but instead goes straight to and from the real device? Is this enough
or nearly enough for what I have in mind?

Rationale:
No caching means that each kernel doesn't go off with its own idea of
what is on the disk in a file, at least. Dunno about directories and
metadata.

Wish:
If that mount option looks promising, can somebody make provision for
it in the kernel? Details to be ironed out later? 

What I have explored or will explore:
1) I have put shared zoned read/write locks on the remote resource, so each
kernel request locks precisely the "disk" area that it should, in
precisely the mode it should, for precisely the duration of each block
layer request.

2) I have maintained request write order from individual kernels.

3) IMO I should also intercept and share the FS superblock lock, but thats
for later, and please tell me about it. What about dentries? Does
O_DIRECT get rid of them? What happens with mkdir?

4) I would LIKE the kernel to emit a "tag request" on the underlying
device before and after every atomic FS operation, so that I can maintain
FS atomicity at the block level. Please comment. Can somebody make this 
happen, please? Or do I add the functionality to VFS myself? Where?

I have patched the kernel to support mount -o direct, creating MS_DIRECT
and MNT_DIRECT flags for the purpose.  And it works.  But I haven't
dared do too much to the remote FS by way of testing yet. I have
confirmed that individual file contents can be changed without problem
when the file size does not change.

Comments?

Here is the tiny proof of concept patch for VFS that implements the
"direct" mount option.


Peter

The idea embodied in this patch is that if we get the MS_DIRECT flag when
the vfs do_mount() is called, we pass it across into the mnt flags used
by do_add_mount() as MNT_DIRECT and thus make it a permament part of the
vfsmnt object that is the mounted fs.  Then, in the generic
dentry_open() call for any file, we examine the flags on the mnt
parameter and set the O_DIRECT flag on the file pointer if MNT_DIRECT
is set on the vfsmnt object.

That makes all file opens O_DIRECT on the file system in question,
and makes all file accesses uncached by VMS.

The patch in itself works fine.

--- linux-2.5.31/fs/open.c.pre-o_direct	Mon Sep  2 20:36:11 2002
+++ linux-2.5.31/fs/open.c	Mon Sep  2 17:12:08 2002
@@ -643,6 +643,9 @@
 		if (error)
 			goto cleanup_file;
 	}
+        if (mnt->mnt_flags & MNT_DIRECT)
+            f->f_flags |= O_DIRECT;
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
+		{ MS_DIRECT, ",direct" },
 		{ 0, NULL }
 	};
 	static struct proc_fs_info mnt_info[] = {
@@ -734,7 +741,9 @@
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
-	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
+	if (flags & MS_DIRECT)
+		mnt_flags |= MNT_DIRECT;
+	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_DIRECT);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
--- linux-2.5.31/include/linux/mount.h.pre-o_direct	Mon Sep  2 20:31:16 2002
+++ linux-2.5.31/include/linux/mount.h	Mon Sep  2 18:06:14 2002
@@ -17,6 +17,7 @@
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
 #define MNT_NOEXEC	4
+#define MNT_DIRECT	256
 
 struct vfsmount
 {
--- linux-2.5.31/include/linux/fs.h.pre-o_direct	Mon Sep  2 20:32:05 2002
+++ linux-2.5.31/include/linux/fs.h	Mon Sep  2 18:05:57 2002
@@ -104,6 +104,9 @@
 #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
 #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
 #define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+
+#define MS_DIRECT	256     /* Make all opens be O_DIRECT */
+
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096

