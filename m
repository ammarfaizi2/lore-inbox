Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268537AbRHCKh3>; Fri, 3 Aug 2001 06:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268596AbRHCKhU>; Fri, 3 Aug 2001 06:37:20 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:22100 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S268537AbRHCKhM>;
	Fri, 3 Aug 2001 06:37:12 -0400
Date: Fri, 3 Aug 2001 11:38:29 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: "Amit S. Kale" <akale@veritas.com>
cc: Sujal Shah <sujal@sujal.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] (was Re: FS Development (or interrupting ls)
In-Reply-To: <3B6A7A72.C2BF8C26@veritas.com>
Message-ID: <Pine.LNX.4.21.0108031137130.1465-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Amit S. Kale wrote:

> Tigran Aivazian had a patch for doing a forced unmount.
> It will solve your problem.
> You can check whether he has a patch for the kernel you 
> are using.
> 

here it is:

diff -urN -X dontdiff linux/fs/Makefile linux-2.4.7-vmfs/fs/Makefile
--- linux/fs/Makefile	Tue May 22 17:35:42 2001
+++ linux-2.4.7-vmfs/fs/Makefile	Mon Jul 23 19:34:10 2001
@@ -62,6 +62,7 @@
 subdir-$(CONFIG_REISERFS_FS)	+= reiserfs
 subdir-$(CONFIG_DEVPTS_FS)	+= devpts
 subdir-$(CONFIG_SUN_OPENPROMFS)	+= openpromfs
+subdir-y			+= badfs
 
 
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
diff -urN -X dontdiff linux/fs/badfs/Makefile linux-2.4.7-vmfs/fs/badfs/Makefile
--- linux/fs/badfs/Makefile	Thu Jan  1 01:00:00 1970
+++ linux-2.4.7-vmfs/fs/badfs/Makefile	Mon Jul 23 19:34:10 2001
@@ -0,0 +1,8 @@
+#
+# Makefile for badfs filesystem.
+#
+
+O_TARGET := badfs.o
+obj-y   := inode.o
+
+include $(TOPDIR)/Rules.make
diff -urN -X dontdiff linux/fs/badfs/inode.c linux-2.4.7-vmfs/fs/badfs/inode.c
--- linux/fs/badfs/inode.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.7-vmfs/fs/badfs/inode.c	Mon Jul 23 19:34:10 2001
@@ -0,0 +1,274 @@
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
+module_init(init_badfs_fs)
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
diff -urN -X dontdiff linux/fs/super.c linux-2.4.7-vmfs/fs/super.c
--- linux/fs/super.c	Thu Jun 14 22:16:58 2001
+++ linux-2.4.7-vmfs/fs/super.c	Mon Jul 23 19:34:10 2001
@@ -1090,6 +1109,9 @@
 		return retval;
 	}
 
+	if (flags&MNT_FORCE)
+		quiesce_filesystem(mnt);
+
 	spin_lock(&dcache_lock);
 
 	if (mnt->mnt_instances.next != mnt->mnt_instances.prev) {
diff -urN -X dontdiff linux/include/linux/fs.h linux-2.4.7-vmfs/include/linux/fs.h
--- linux/include/linux/fs.h	Fri Jul 20 20:52:18 2001
+++ linux-2.4.7-vmfs/include/linux/fs.h	Mon Jul 23 19:34:10 2001
@@ -1372,6 +1374,8 @@
 extern kdev_t ROOT_DEV;
 extern char root_device_name[];
 
+/* fs/badfs/inode.c - used by forced umount */
+extern void quiesce_filesystem(struct vfsmount *);
 
 extern void show_buffers(void);
 extern void mount_root(void);

