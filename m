Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSJLOuS>; Sat, 12 Oct 2002 10:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261246AbSJLOuR>; Sat, 12 Oct 2002 10:50:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:46076 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261242AbSJLOuK>; Sat, 12 Oct 2002 10:50:10 -0400
Date: Sat, 12 Oct 2002 15:56:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Matthias Andree <matthias.andree@gmx.de>
cc: Tigran Aivazian <tigran@veritas.com>, Rob Landley <landley@trommello.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 - (NUMA))
In-Reply-To: <20021012114205.GB32511@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0210121548500.1138-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Matthias Andree wrote:
> On Fri, 11 Oct 2002, Rob Landley wrote:
> > I'm also looking for an "unmount --force" option that works on something 
> > other than NFS.  Close all active filehandles (the programs using it can just 
> > deal with EBADF or whatever), flush the buffers to disk, and unmount.  None 
> > of this "oh I can't do that, you have a zombie process with an open file...", 
> > I want  "guillotine this filesystem pronto, capice?" behavior.
> 
> Seconded.
> 
> The patch at the URL below used to work back with 2.4.9, I did not track
> what has become of it, if it still applies, I haven't needed it recently
> or if so, Alt-SysRq was fair enough for me. Maybe just updating this
> badfs and forced umount patch for 2.4.20 would suffice:
> 
> http://www.moses.uklinux.net/patches/forced-umount-2.4.9.patch
> 
> It gives me one reject in fs/super.c that I don't know how to fix:

Tigran did update his forced umount patch to 2.4.18,
here's a built but untested patch against 2.4.20-pre10 ...

--- 2.4.20-pre10/fs/Makefile	Wed Oct  9 11:53:45 2002
+++ forcedumount/fs/Makefile	Sat Oct 12 15:24:11 2002
@@ -68,6 +68,7 @@
 subdir-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs
 subdir-$(CONFIG_BEFS_FS)	+= befs
 subdir-$(CONFIG_JFS_FS)		+= jfs
+subdir-y			+= badfs
 
 
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
--- 2.4.20-pre10/fs/badfs/Makefile	Thu Jan  1 00:00:00 1970
+++ forcedumount/fs/badfs/Makefile	Sat Oct 12 15:24:11 2002
@@ -0,0 +1,8 @@
+#
+# Makefile for badfs filesystem.
+#
+
+O_TARGET := badfs.o
+obj-y   := inode.o
+
+include $(TOPDIR)/Rules.make
--- 2.4.20-pre10/fs/badfs/inode.c	Thu Jan  1 00:00:00 1970
+++ forcedumount/fs/badfs/inode.c	Sat Oct 12 15:24:11 2002
@@ -0,0 +1,275 @@
+/*
+ *  badfs - the Bad Filesystem
+ *
+ *  Author - Tigran Aivazian <tigran@veritas.com>
+ *
+ *  Thanks to:
+ *  	Manfred Spraul <manfred@colorfullife.com>, for useful comments.
+ *
+ *  This file is released under the GPL.
+ *
+ *  The badfs filesystem is used by forced umount ('umount -f' command)
+ *  to move inodes that keep the filesystem being umounted busy to it.
+ *
+ *  The entry point into this module is via quiesce_filesystem() called
+ *  from fs/super.c:do_umount() if MNT_FORCE is passed.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/file.h>
+
+#define BADFS_MAGIC	0xBADF5001
+
+static struct super_block *badfs_read_super(struct super_block *,void *,int);
+
+#define FS_FLAGS_BADFS	(FS_NOMOUNT | FS_SINGLE)
+static DECLARE_FSTYPE(badfs_fs_type,"badfs",badfs_read_super,FS_FLAGS_BADFS);
+
+static struct vfsmount *badfs_mnt;	/* returned by kern_mount() */
+static struct super_block *badfs_sb;	/* badfs_mnt->mnt_sb */
+static struct dentry *badfs_root;	/* badfs_sb->s_root */
+
+static int __init init_badfs_fs(void)
+{
+	int err = register_filesystem(&badfs_fs_type);
+
+	if (!err) {
+		badfs_mnt = kern_mount(&badfs_fs_type);
+		if (IS_ERR(badfs_mnt)) {
+			err = PTR_ERR(badfs_mnt);
+			unregister_filesystem(&badfs_fs_type);
+		} else {
+			badfs_sb = badfs_mnt->mnt_sb;
+			err = 0;
+		}
+	}
+	return err;
+}
+
+static struct inode *badfs_get_inode(struct super_block *sb, int mode)
+{
+	struct inode *inode = get_empty_inode();
+
+	if (inode) {
+		make_bad_inode(inode);
+		inode->i_sb = sb;
+		inode->i_dev = sb->s_dev;
+		inode->i_mode = mode;
+		inode->i_nlink = 1;
+		inode->i_size = 0;
+		inode->i_blocks = 0;
+	}
+	return inode;
+}
+
+/* VFS ->read_super() method */
+static struct super_block *badfs_read_super(struct super_block * sb, 
+		void * data, int silent)
+{
+	static struct super_operations badfs_ops = {};
+	struct inode * root = badfs_get_inode(sb, S_IFDIR|S_IRUSR|S_IWUSR);
+
+	if (!root)
+		return NULL;
+	sb->s_blocksize = 1024;
+	sb->s_blocksize_bits = 10;
+	sb->s_magic = BADFS_MAGIC;
+	sb->s_op = &badfs_ops;
+	badfs_root = sb->s_root = d_alloc(NULL, 
+			&(const struct qstr){ "bad:", 5, 0});
+	if (!badfs_root) {
+		iput(root);
+		return NULL;
+	}
+	sb->s_root->d_sb = sb;
+	sb->s_root->d_parent = sb->s_root;
+	d_instantiate(sb->s_root, root);
+	return sb;
+}
+
+static void disable_pwd(struct fs_struct *fs)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+
+	inode = badfs_get_inode(badfs_sb, S_IFDIR|0755);
+	if (!inode) {
+		printk(KERN_ERR "disable_pwd(): can't allocate inode\n");
+		return;
+	}
+	dentry = d_alloc(badfs_root, &(const struct qstr){"dead_pwd", 8, 0});
+	if (!dentry) {
+		iput(inode);
+		printk(KERN_ERR "disable_pwd(): can't allocate dentry\n");
+		return;
+	}
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	set_fs_pwd(fs, badfs_mnt, dentry);
+}
+
+static void disable_root(struct fs_struct *fs)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+
+	inode = badfs_get_inode(badfs_sb, S_IFDIR|0755);
+	if (!inode) {
+		printk(KERN_ERR "disable_root(): can't allocate inode\n");
+		return;
+	}
+	dentry = d_alloc(badfs_root, &(const struct qstr){"dead_root", 9, 0});
+	if (!dentry) {
+		iput(inode);
+		printk(KERN_ERR "disable_root(): can't allocate dentry\n");
+		return;
+	}
+	d_instantiate(dentry, inode);
+	dget(dentry);
+	set_fs_root(fs, badfs_mnt, dentry);
+}
+
+/* called from do_umount() if MNT_FORCE is specified */
+void quiesce_filesystem(struct vfsmount *mnt)
+{
+	struct task_struct *p;
+	struct file *file;
+	struct inode *inode;
+
+	/* we do three passes through the task list, examining:
+	 *   1. p->fs{->pwd,root} that can keep this mnt busy
+	 *   2. p->files, i.e. open files (we do_close them)
+	 *   3. p->mm, i.e. mmaped files (we simply do_munmap them)
+	 * There is no guarantee that by the time we restart the loop
+	 * the amount of work to do in the loop has not increased.
+	 */
+repeat1:
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		struct fs_struct *fs;
+
+		/* get a reference to p->fs */
+		task_lock(p);
+		fs = p->fs;
+		if (!fs) {
+			task_unlock(p);
+			continue;
+		} else
+			atomic_inc(&fs->count);
+		task_unlock(p);
+
+		if (fs->pwdmnt == mnt) {
+			read_unlock(&tasklist_lock);
+			disable_pwd(fs); /* may sleep */
+			put_fs_struct(fs);
+			goto repeat1;
+		}
+		if (fs->rootmnt == mnt) {
+			read_unlock(&tasklist_lock);
+			disable_root(fs); /* may sleep */
+			put_fs_struct(fs);
+			goto repeat1;
+		}
+		put_fs_struct(fs);
+	}
+	read_unlock(&tasklist_lock);
+
+repeat2:
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		unsigned int fd, j = 0;
+		struct files_struct *files;
+
+		/* get a reference to p->files */
+		task_lock(p);
+		files = p->files;
+		if (!files) {
+			task_unlock(p);
+			continue;
+		} else {
+			atomic_inc(&files->count);
+			write_lock(&files->file_lock);
+		}
+		task_unlock(p);
+
+		/* check if this process has open files here */
+		while (1) {
+			unsigned long set;
+
+			fd = j * __NFDBITS;
+			if (fd >= files->max_fdset || fd >= files->max_fds)
+				break;
+			set = files->open_fds->fds_bits[j++];
+			while (set) {
+				if (set & 1) {
+					file = files->fd[fd];
+					if (file) {
+						inode = file->f_dentry->d_inode;
+						if (inode && (file->f_vfsmnt==mnt)) {
+							files->fd[fd] = NULL;	
+							FD_CLR(fd, files->close_on_exec);
+							__put_unused_fd(files, fd);
+							write_unlock(&files->file_lock);
+							read_unlock(&tasklist_lock);
+							put_files_struct(files);
+							filp_close(file, files);
+							goto repeat2;
+						}
+					}
+				}
+				fd++;
+				set >>= 1;
+			}
+		}
+		write_unlock(&files->file_lock);
+		put_files_struct(files);
+	}
+	read_unlock(&tasklist_lock);
+
+repeat3:
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		struct mm_struct *mm;
+		struct vm_area_struct *vma;
+
+		/* get a reference to p->mm */
+		task_lock(p);
+		mm = p->mm;
+		if (!mm) {
+			task_unlock(p);
+			continue;
+		} else
+			atomic_inc(&mm->mm_users);
+		task_unlock(p);
+
+		/* check for mmap'd files and unmap them */
+		spin_lock(&mm->page_table_lock);
+		for (vma = mm->mmap; vma; vma=vma->vm_next) {
+			file = vma->vm_file;
+			if (!file)
+				continue;
+			inode = file->f_dentry->d_inode;
+			if (!inode || !inode->i_sb)
+				continue;
+			if (file->f_vfsmnt == mnt) {
+				spin_unlock(&mm->page_table_lock);
+				read_unlock(&tasklist_lock);
+				down_write(&mm->mmap_sem);
+				do_munmap(mm, vma->vm_start, 
+					vma->vm_end - vma->vm_start);
+				up_write(&mm->mmap_sem);
+				mmput(mm);
+				goto repeat3;
+			}
+		}
+		spin_unlock(&mm->page_table_lock);
+		mmput(mm);
+	}
+	read_unlock(&tasklist_lock);
+}
+
+module_init(init_badfs_fs)
+MODULE_LICENSE("GPL");
--- 2.4.20-pre10/fs/namespace.c	Wed Oct  9 11:53:48 2002
+++ forcedumount/fs/namespace.c	Sat Oct 12 15:24:11 2002
@@ -298,10 +298,14 @@
 	 * about for the moment.
 	 */
 
-	lock_kernel();
-	if( (flags&MNT_FORCE) && sb->s_op->umount_begin)
-		sb->s_op->umount_begin(sb);
-	unlock_kernel();
+	if (flags & MNT_FORCE) {
+		lock_kernel();
+		if (mnt != current->fs->rootmnt)
+			quiesce_filesystem(mnt);
+		if (sb->s_op->umount_begin)
+			sb->s_op->umount_begin(sb);
+		unlock_kernel();
+	}
 
 	/*
 	 * No sense to grab the lock for this test, but test itself looks
--- 2.4.20-pre10/include/linux/fs.h	Wed Oct  9 11:58:21 2002
+++ forcedumount/include/linux/fs.h	Sat Oct 12 15:24:11 2002
@@ -1479,6 +1479,8 @@
 extern kdev_t ROOT_DEV;
 extern char root_device_name[];
 
+/* fs/badfs/inode.c - used by forced umount */
+extern void quiesce_filesystem(struct vfsmount *);
 
 extern void show_buffers(void);
 

