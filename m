Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280104AbRKRV0f>; Sun, 18 Nov 2001 16:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280095AbRKRV02>; Sun, 18 Nov 2001 16:26:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23184 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280083AbRKRV0R>;
	Sun, 18 Nov 2001 16:26:17 -0500
Date: Sun, 18 Nov 2001 16:26:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-fsdevel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Urban Widmark <urban@teststation.com>,
        Sven Vermeulen <sven.vermeulen@rug.ac.be>,
        Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH][CFT] fs-specific options in /proc/mounts
In-Reply-To: <Pine.GSO.4.21.0111181304361.15361-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0111181603260.15361-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Nov 2001, Alexander Viro wrote:

> On Sun, 18 Nov 2001, Urban Widmark wrote:
>
> > I don't know if there are any plans to change that. Wouldn't be difficult
> > to add something to super_operations.
> > 
> > fs/namespace.c:
> > 	show_vfsmnt
> > 	show_nfs_mount
> 
> Well, now that's easy to do.  With the old code (FVO "old" equal to
> 2.4.15-pre2) you would end up with mind-boggling amount of buffer
> overruns _and_ ugly code in filesystems.
> 
> I would rather start messing with that area with cleaning up mount
> options' parsers - I've got a patch that does it, it just needs to
> be ported to recent trees.

OTOH...  This stuff is really trivial now, so that can easily go into
2.4.
	* new superblock method: ->show_options().  It's optional and if
present - used by show_vfsmnt() (i.e. /proc/mounts) to show fs-specific
options.
	* Prototype: int (*show_options)(struct seq_file *, struct vfsmount *);
Use seq_{putc,puts,printf,escape} for output (see fs/nfs/inode.c for example
of use).  Pointer to seq_file describes the output buffer (first argument
of seq_...().
	* Return 0 in case of success, negative - in case of fatal error
(e.g. your function needs to allocate memory and fails).  read() from
/proc/mounts will fail at that point, so if you see that e.g. server is
all fucked up - say seq_puts(m, "server_all_fucked_up"); and return 0 instead
of returning -EINVAL.
	* The only lock held by caller is mount_sem.  Method may block,
allocate memory, cause IO, yodda, yodda.  It must not call path_walk()
(e.g. filp_open() is off-limits) since that could deadlock if lookup
triggers automount.

	Patch below moves handling of NFS-specific options into such
method; if you want to show some fs-specific options in your fs - add
->show_options() in your super_operations.

diff -urN S15-pre6/fs/namespace.c S15-pre6-mounts/fs/namespace.c
--- S15-pre6/fs/namespace.c	Sat Nov 17 23:06:33 2001
+++ S15-pre6-mounts/fs/namespace.c	Sun Nov 18 16:01:12 2001
@@ -19,9 +19,6 @@
 
 #include <asm/uaccess.h>
 
-#include <linux/nfs_fs.h>
-#include <linux/nfs_fs_sb.h>
-#include <linux/nfs_mount.h>
 #include <linux/seq_file.h>
 
 struct vfsmount *do_kern_mount(char *type, int flags, char *name, void *data);
@@ -198,50 +195,10 @@
 	seq_escape(m, s, " \t\n\\");
 }
 
-static void show_nfs_mount(struct seq_file *m, struct vfsmount *mnt)
-{
-	static struct proc_nfs_info {
-		int flag;
-		char *str;
-		char *nostr;
-	} nfs_info[] = {
-		{ NFS_MOUNT_SOFT, ",soft", ",hard" },
-		{ NFS_MOUNT_INTR, ",intr", "" },
-		{ NFS_MOUNT_POSIX, ",posix", "" },
-		{ NFS_MOUNT_TCP, ",tcp", ",udp" },
-		{ NFS_MOUNT_NOCTO, ",nocto", "" },
-		{ NFS_MOUNT_NOAC, ",noac", "" },
-		{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
-		{ NFS_MOUNT_BROKEN_SUID, ",broken_suid", "" },
-		{ 0, NULL, NULL }
-	};
-	struct proc_nfs_info *nfs_infop;
-	struct nfs_server *nfss = &mnt->mnt_sb->u.nfs_sb.s_server;
-
-	seq_printf(m, ",v%d", nfss->rpc_ops->version);
-	seq_printf(m, ",rsize=%d", nfss->rsize);
-	seq_printf(m, ",wsize=%d", nfss->wsize);
-	if (nfss->acregmin != 3*HZ)
-		seq_printf(m, ",acregmin=%d", nfss->acregmin/HZ);
-	if (nfss->acregmax != 60*HZ)
-		seq_printf(m, ",acregmax=%d", nfss->acregmax/HZ);
-	if (nfss->acdirmin != 30*HZ)
-		seq_printf(m, ",acdirmin=%d", nfss->acdirmin/HZ);
-	if (nfss->acdirmax != 60*HZ)
-		seq_printf(m, ",acdirmax=%d", nfss->acdirmax/HZ);
-	for (nfs_infop = nfs_info; nfs_infop->flag; nfs_infop++) {
-		if (nfss->flags & nfs_infop->flag)
-			seq_puts(m, nfs_infop->str);
-		else
-			seq_puts(m, nfs_infop->nostr);
-	}
-	seq_puts(m, ",addr=");
-	mangle(m, nfss->hostname);
-}
-
 static int show_vfsmnt(struct seq_file *m, void *v)
 {
 	struct vfsmount *mnt = v;
+	int err = 0;
 	static struct proc_fs_info {
 		int flag;
 		char *str;
@@ -281,10 +238,10 @@
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
-	if (strcmp("nfs", mnt->mnt_sb->s_type->name) == 0)
-		show_nfs_mount(m, mnt);
+	if (mnt->mnt_sb->s_op->show_options)
+		err = mnt->mnt_sb->s_op->show_options(m, mnt);
 	seq_puts(m, " 0 0\n");
-	return 0;
+	return err;
 }
 
 struct seq_operations mounts_op = {
diff -urN S15-pre6/fs/nfs/inode.c S15-pre6-mounts/fs/nfs/inode.c
--- S15-pre6/fs/nfs/inode.c	Sat Nov 17 23:06:33 2001
+++ S15-pre6-mounts/fs/nfs/inode.c	Sun Nov 18 15:59:55 2001
@@ -32,6 +32,7 @@
 #include <linux/nfs_flushd.h>
 #include <linux/lockd/bind.h>
 #include <linux/smp_lock.h>
+#include <linux/seq_file.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -51,6 +52,7 @@
 static void nfs_clear_inode(struct inode *);
 static void nfs_umount_begin(struct super_block *);
 static int  nfs_statfs(struct super_block *, struct statfs *);
+static int  nfs_show_options(struct seq_file *, struct vfsmount *);
 
 static struct super_operations nfs_sops = { 
 	read_inode:	nfs_read_inode,
@@ -60,6 +62,7 @@
 	statfs:		nfs_statfs,
 	clear_inode:	nfs_clear_inode,
 	umount_begin:	nfs_umount_begin,
+	show_options:	nfs_show_options,
 };
 
 /*
@@ -551,6 +554,48 @@
  out_err:
 	printk("nfs_statfs: statfs error = %d\n", -error);
 	buf->f_bsize = buf->f_blocks = buf->f_bfree = buf->f_bavail = -1;
+	return 0;
+}
+
+static int nfs_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	static struct proc_nfs_info {
+		int flag;
+		char *str;
+		char *nostr;
+	} nfs_info[] = {
+		{ NFS_MOUNT_SOFT, ",soft", ",hard" },
+		{ NFS_MOUNT_INTR, ",intr", "" },
+		{ NFS_MOUNT_POSIX, ",posix", "" },
+		{ NFS_MOUNT_TCP, ",tcp", ",udp" },
+		{ NFS_MOUNT_NOCTO, ",nocto", "" },
+		{ NFS_MOUNT_NOAC, ",noac", "" },
+		{ NFS_MOUNT_NONLM, ",nolock", ",lock" },
+		{ NFS_MOUNT_BROKEN_SUID, ",broken_suid", "" },
+		{ 0, NULL, NULL }
+	};
+	struct proc_nfs_info *nfs_infop;
+	struct nfs_server *nfss = &mnt->mnt_sb->u.nfs_sb.s_server;
+
+	seq_printf(m, ",v%d", nfss->rpc_ops->version);
+	seq_printf(m, ",rsize=%d", nfss->rsize);
+	seq_printf(m, ",wsize=%d", nfss->wsize);
+	if (nfss->acregmin != 3*HZ)
+		seq_printf(m, ",acregmin=%d", nfss->acregmin/HZ);
+	if (nfss->acregmax != 60*HZ)
+		seq_printf(m, ",acregmax=%d", nfss->acregmax/HZ);
+	if (nfss->acdirmin != 30*HZ)
+		seq_printf(m, ",acdirmin=%d", nfss->acdirmin/HZ);
+	if (nfss->acdirmax != 60*HZ)
+		seq_printf(m, ",acdirmax=%d", nfss->acdirmax/HZ);
+	for (nfs_infop = nfs_info; nfs_infop->flag; nfs_infop++) {
+		if (nfss->flags & nfs_infop->flag)
+			seq_puts(m, nfs_infop->str);
+		else
+			seq_puts(m, nfs_infop->nostr);
+	}
+	seq_puts(m, ",addr=");
+	seq_escape(m, nfss->hostname, " \t\n\\");
 	return 0;
 }
 
diff -urN S15-pre6/include/linux/fs.h S15-pre6-mounts/include/linux/fs.h
--- S15-pre6/include/linux/fs.h	Sat Nov 17 23:06:36 2001
+++ S15-pre6-mounts/include/linux/fs.h	Sun Nov 18 15:46:24 2001
@@ -853,6 +853,8 @@
 	int (*getattr) (struct dentry *, struct iattr *);
 };
 
+struct seq_file;
+
 /*
  * NOTE: write_inode, delete_inode, clear_inode, put_inode can be called
  * without the big kernel lock held in all filesystems.
@@ -904,6 +906,7 @@
 	 */
 	struct dentry * (*fh_to_dentry)(struct super_block *sb, __u32 *fh, int len, int fhtype, int parent);
 	int (*dentry_to_fh)(struct dentry *, __u32 *fh, int *lenp, int need_parent);
+	int (*show_options)(struct seq_file *, struct vfsmount *);
 };
 
 /* Inode state bits.. */

