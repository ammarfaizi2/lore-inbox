Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUJYPoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUJYPoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUJYPlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:41:15 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:32925 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261993AbUJYPgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:36:02 -0400
Date: Mon, 25 Oct 2004 11:35:45 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 14/28] VFS: Introduce Mountpoint file descriptors (resend)
In-reply-to: <20041025152521.GA1959@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Cc: raven@themaw.net
Message-id: <417D1D51.8060901@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_rd2cNk1rjZWhMeFlC5fQMA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <10987154731896@sun.com> <10987155032816@sun.com>
 <20041025152521.GA1959@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_rd2cNk1rjZWhMeFlC5fQMA)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:

> You haven't explained why you actually need it, though.
> 

Apparently I used the wrong server and a couple patches bounced :\

I'll try to make the next series more 'forward self-describing' :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfR1RdQs4kOxk3/MRAkVnAKCJXfCmyzk1UaL0GcuPwQsdexHMhgCeMbGl
Wz9LPh+FJbdMpyPPYiVrtoY=
=+WQa
-----END PGP SIGNATURE-----

--Boundary_(ID_rd2cNk1rjZWhMeFlC5fQMA)
Content-type: text/x-patch; name=14-introduce_mountfd.diff
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=14-introduce_mountfd.diff

This patch introduces the concept of a mountpoint file descriptor (mountfd).
All interfacing with mountfds are done through the mountfd(2) syscall (which
currently uses a command op argument to determine what you really are trying
to do.

This patch only adds the following abilities:
 - grab a reference to a mountfd given a directory fd (of the root of the
   mountpoint).
 - get the directory fd of the root of the mountpoint given a mountfd.

NOTE: the entire interface is highly likely to change and
comments/suggestions are more than welcome as the provided api is mostly a
prototype at this stage and far from complete.

Further patches add the following functionalities:
 - attach a mountpoint given a mountfd to a directory (given a dirfd)
 - detach/umount a mountpoint given a mountfd (umount if not busy, forced
   umount, lazy umount)

NOTE AGAIN: most of the interface is half-baked, and really does require
input from others.  Most of this functionality is not neccesarily needed for
autofsng, however I thought I'd start the ball rolling for _some_ interface.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 Documentation/ioctl-number.txt |    1 
 arch/i386/kernel/entry.S       |   17 ++
 fs/Makefile                    |    2 
 fs/mountfd.c                   |  256 +++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c                 |    2 
 include/asm-i386/unistd.h      |    3 
 include/linux/fs.h             |    2 
 7 files changed, 281 insertions(+), 2 deletions(-)

Index: linux-2.6.9-quilt/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.9-quilt.orig/arch/i386/kernel/entry.S	2004-08-14 01:36:32.000000000 -0400
+++ linux-2.6.9-quilt/arch/i386/kernel/entry.S	2004-10-22 17:17:40.735271440 -0400
@@ -886,5 +886,22 @@ ENTRY(sys_call_table)
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* reserved for kexec */
+	.long sys_ni_syscall
+	.long sys_ni_syscall		/* 285 */
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall		/* 290 */
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall		/* 295 */
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_ni_syscall
+	.long sys_mountfd		/* 300 */
 
 syscall_table_size=(.-sys_call_table)
Index: linux-2.6.9-quilt/include/asm-i386/unistd.h
===================================================================
--- linux-2.6.9-quilt.orig/include/asm-i386/unistd.h	2004-08-14 01:37:25.000000000 -0400
+++ linux-2.6.9-quilt/include/asm-i386/unistd.h	2004-10-22 17:17:40.735271440 -0400
@@ -289,8 +289,9 @@
 #define __NR_mq_notify		(__NR_mq_open+4)
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
+#define __NR_mountfd		300
 
-#define NR_syscalls 284
+#define NR_syscalls 301
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
Index: linux-2.6.9-quilt/fs/mountfd.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.9-quilt/fs/mountfd.c	2004-10-22 17:17:40.736271288 -0400
@@ -0,0 +1,256 @@
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/init.h>
+#include <linux/security.h>
+
+#define MFDFS_MAGIC 0x4A9F2E43
+#define MFDFS_ROOT_INO 1
+
+#define VFSMOUNT(filp) ((struct vfsmount *)((filp)->private_data))
+
+static struct vfsmount *mfdfs_mnt;
+
+static void mfdfs_read_inode(struct inode *inode);
+static struct super_operations mfdfs_ops = {
+	.read_inode    = mfdfs_read_inode,
+	.statfs        = simple_statfs,
+};
+
+static struct super_block *mfdfs_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return get_sb_pseudo(fs_type, "mountfd:", &mfdfs_ops, MFDFS_MAGIC);
+}
+
+static struct file_system_type mfd_fs_type = {
+	.name    =	"mfdfs",
+	.get_sb  = 	mfdfs_get_sb,
+	.kill_sb = 	kill_anon_super,
+};
+
+void __init mfdfs_init(void)
+{
+	register_filesystem(&mfd_fs_type);
+	mfdfs_mnt = kern_mount(&mfd_fs_type);
+}
+
+/* TODO: change this list into a hashtable */
+spinlock_t mfd_lock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(mfd_list);
+struct mountfd {
+	struct list_head list;
+	struct vfsmount *mnt;
+	struct dentry   *dentry;
+	atomic_t count;
+};
+
+static int mfd_release(struct inode *inode, struct file *file)
+{
+	struct vfsmount *mnt = VFSMOUNT(file);
+	struct mountfd *mfd, *tofree = NULL;
+
+	spin_lock(&mfd_lock);
+	list_for_each_entry(mfd, &mfd_list, list) {
+		if (mfd->mnt == mnt) {
+			if (atomic_dec_and_test(&mfd->count)) {
+				tofree = mfd;
+				list_del_init(&tofree->list);
+			}
+			break;
+		}
+	}
+	spin_unlock(&mfd_lock);
+
+	if (tofree) {
+		d_delete(tofree->dentry);
+		mntsoftput(tofree->mnt);
+		kfree(tofree);
+	}
+	return 0;
+}
+
+static int mfd_ioctl(struct inode *inode, struct file *filp,
+		     unsigned int cmd, unsigned long arg);
+static struct file_operations mfd_file_ops = {
+	.release  =	mfd_release,
+	.ioctl    =	mfd_ioctl,
+};
+
+static void mfdfs_read_inode(struct inode *inode)
+{
+	inode->i_fop = &mfd_file_ops;
+	inode->i_mode = S_IFREG | S_IRUGO | S_IXUGO;
+	inode->i_nlink = 1;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+
+	inode->i_blocks = 0;
+	inode->i_blksize = 1024;
+}
+
+static struct dentry *get_mfd_dentry(struct vfsmount *mnt)
+{
+	struct mountfd *newmfd, *mfd;
+	struct dentry *dentry;
+	struct qstr qstr;
+	struct inode *inode;
+
+	/* create an new mfd before we lock */
+	newmfd = kmalloc(sizeof(*newmfd), GFP_KERNEL);
+	if (!newmfd)
+		return ERR_PTR(-ENOMEM);
+	if (!mfdfs_mnt->mnt_root)
+		return ERR_PTR(-ENOMEM);
+	/* TODO: how to make this context dependent in proc/<pid>/fd */
+	qstr.name = "DUMMY";
+	qstr.len  = 5;
+	newmfd->dentry = d_alloc(mfdfs_mnt->mnt_root, &qstr);
+	if (IS_ERR(newmfd->dentry)) {
+		struct dentry *err = newmfd->dentry;
+		kfree(newmfd);
+		return err;
+	}
+	inode = iget(mfdfs_mnt->mnt_sb, iunique(mfdfs_mnt->mnt_sb, MFDFS_ROOT_INO));
+	if (IS_ERR(inode)) {
+		int err = PTR_ERR(inode);
+		dput(newmfd->dentry);
+		kfree(newmfd);
+		return ERR_PTR(err);
+	}
+	d_add(newmfd->dentry, inode);
+
+	spin_lock(&mfd_lock);
+	list_for_each_entry(mfd, &mfd_list, list) {
+		if (mfd->mnt == mnt) {
+			dentry = dget(mfd->dentry);
+			atomic_inc(&mfd->count);
+			spin_unlock(&mfd_lock);
+
+			d_delete(newmfd->dentry);
+			kfree(newmfd);
+
+			return dentry;
+		}
+	}
+
+	newmfd->mnt = mntsoftget(mnt);
+	dentry = newmfd->dentry;
+	INIT_LIST_HEAD(&newmfd->list);
+	list_add(&newmfd->list, &mfd_list);
+	atomic_set(&newmfd->count, 1);
+	spin_unlock(&mfd_lock);
+
+	return dget(dentry);
+}
+
+static long open_mfd(struct vfsmount *mnt)
+{
+	struct file *file;
+	int error;
+	int fd;
+	
+	error = -ENOMEM;
+	file = get_empty_filp();
+	if (!file)
+		goto out;
+
+	error = -ENFILE;
+	fd = get_unused_fd();
+	if (fd < 0)
+		goto out_putfilp;
+
+	file->private_data = mnt;
+	file->f_dentry = get_mfd_dentry(mnt);
+	if (IS_ERR(file->f_dentry)) {
+		error = PTR_ERR(file->f_dentry);
+		goto out_putfd;
+	}
+	file->f_vfsmnt = mntget(mfdfs_mnt);
+
+	file->f_op    = &mfd_file_ops;
+	file->f_mode  = FMODE_READ | FMODE_WRITE;
+	file->f_flags = O_RDWR;
+	file->f_pos   = 0;
+
+	fd_install(fd, file);
+	return fd;
+
+out_putfd:
+	put_unused_fd(fd);
+out_putfilp:
+	put_filp(file);
+out:
+	return error;
+}
+
+static long mfd_getmfd(int dirfd)
+{
+	struct file *dir;
+	int error;
+
+	error = -EBADF;
+	dir = fget(dirfd);
+	if (!dir)
+		goto out;
+
+	error = -ENOTDIR;
+	if (!S_ISDIR(dir->f_dentry->d_inode->i_mode))
+		goto out_fput;
+
+	error = -EINVAL;
+	if (dir->f_vfsmnt->mnt_root != dir->f_dentry)
+		goto out_fput;
+
+	error = open_mfd(dir->f_vfsmnt);
+
+out_fput:
+	fput(dir);
+out:
+	return error;
+}
+
+long mfd_getdirfd(struct file *mountfilp)
+{
+	long error, dirfd;
+	struct file *filp;
+	struct vfsmount *mnt;
+
+	mnt = mntget(VFSMOUNT(mountfilp));
+
+	error = -ENFILE;
+	if ((dirfd = get_unused_fd()) < 0)
+		goto out_filp;
+	
+	filp = dentry_open(dget(mnt->mnt_root), mnt, O_DIRECTORY | O_RDONLY);
+	if (IS_ERR(filp)) {
+		error = PTR_ERR(filp);
+		goto out_filp;
+	}
+
+	error = dirfd;
+	fd_install(dirfd, filp);
+
+out_filp:
+	mntput(mnt);
+	return error;
+}
+
+static int mfd_ioctl(struct inode *inode, struct file *filp,
+		     unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case MOUNTFD_IOC_GETDIRFD:
+		return mfd_getdirfd(filp);
+	}
+	return -ENOTTY;
+}
+
+asmlinkage long sys_mountfd(int dirfd)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return mfd_getmfd(dirfd);
+}
Index: linux-2.6.9-quilt/fs/Makefile
===================================================================
--- linux-2.6.9-quilt.orig/fs/Makefile	2004-08-14 01:37:14.000000000 -0400
+++ linux-2.6.9-quilt/fs/Makefile	2004-10-22 17:17:40.736271288 -0400
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o
+		fs-writeback.o mpage.o direct-io.o aio.o mountfd.o
 
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:40.187354736 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:40.738270984 -0400
@@ -34,6 +34,7 @@ static inline int sysfs_init(void)
 	return 0;
 }
 #endif
+extern void __init mfdfs_init(void);
 
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 spinlock_t vfsmount_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
@@ -1711,6 +1712,7 @@ void __init mnt_init(unsigned long mempa
 		d++;
 		i--;
 	} while (i);
+	mfdfs_init();
 	sysfs_init();
 	init_rootfs();
 	init_mount_tree();
Index: linux-2.6.9-quilt/Documentation/ioctl-number.txt
===================================================================
--- linux-2.6.9-quilt.orig/Documentation/ioctl-number.txt	2004-08-14 01:38:04.000000000 -0400
+++ linux-2.6.9-quilt/Documentation/ioctl-number.txt	2004-10-22 17:17:40.738270984 -0400
@@ -144,6 +144,7 @@ Code	Seq#	Include File		Comments
 'p'	40-7F	linux/nvram.h
 'p'	80-9F				user-space parport
 					<mailto:tim@cyberelk.net>
+'p'	A0-BF				mountpoint file descriptors
 'q'	00-1F	linux/videotext.h	conflict!
 'q'	80-FF				Internet PhoneJACK, Internet LineJACK
 					<http://www.quicknet.net>
Index: linux-2.6.9-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/fs.h	2004-10-22 17:17:37.120820920 -0400
+++ linux-2.6.9-quilt/include/linux/fs.h	2004-10-22 17:17:40.739270832 -0400
@@ -214,6 +214,8 @@ extern int leases_enable, dir_notify_ena
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
 
+#define MOUNTFD_IOC_GETDIRFD _IO('p', 0xa0)
+
 #ifdef __KERNEL__
 
 #include <linux/list.h>

--Boundary_(ID_rd2cNk1rjZWhMeFlC5fQMA)--
