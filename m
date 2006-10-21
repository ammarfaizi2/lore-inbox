Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992876AbWJUHRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992876AbWJUHRa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992874AbWJUHR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:17:27 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:33927 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992867AbWJUHOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:50 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 01 of 23] VFS: change struct file to use struct path
Message-Id: <b212ecc85fa3ad0382f6.1161411446@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:26 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, jack@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes struct file to use struct path instead of having
independent pointers to struct dentry and struct vfsmount, and converts all
users of f_{dentry,vfsmnt} in fs/ to use f_path.{dentry,mnt}.

Additionally, it adds two #define's to make the transition easier for users
of the f_dentry and f_vfsmnt.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

32 files changed, 140 insertions(+), 138 deletions(-)
fs/binfmt_aout.c         |    8 ++++----
fs/binfmt_elf.c          |    2 +-
fs/binfmt_elf_fdpic.c    |    4 ++--
fs/binfmt_flat.c         |    2 +-
fs/binfmt_misc.c         |   10 +++++-----
fs/block_dev.c           |    8 ++++----
fs/compat.c              |   12 ++++++------
fs/compat_ioctl.c        |    2 +-
fs/dnotify.c             |    4 ++--
fs/dquot.c               |    4 ++--
fs/eventpoll.c           |    4 ++--
fs/exec.c                |   10 +++++-----
fs/fcntl.c               |    2 +-
fs/file_table.c          |   10 +++++-----
fs/inode.c               |    2 +-
fs/inotify_user.c        |    6 +++---
fs/ioctl.c               |   14 +++++++-------
fs/libfs.c               |   14 +++++++-------
fs/locks.c               |   32 ++++++++++++++++----------------
fs/namei.c               |   10 +++++-----
fs/open.c                |   26 +++++++++++++-------------
fs/pipe.c                |   28 ++++++++++++++--------------
fs/read_write.c          |   20 ++++++++++----------
fs/readdir.c             |    2 +-
fs/seq_file.c            |    2 +-
fs/splice.c              |   12 ++++++------
fs/stat.c                |    2 +-
fs/super.c               |    2 +-
fs/sync.c                |    4 ++--
fs/xattr.c               |    8 ++++----
include/linux/fs.h       |   10 ++++++----
include/linux/fsnotify.h |    2 +-

diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
--- a/fs/binfmt_aout.c
+++ b/fs/binfmt_aout.c
@@ -274,7 +274,7 @@ static int load_aout_binary(struct linux
 	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != OMAGIC &&
 	     N_MAGIC(ex) != QMAGIC && N_MAGIC(ex) != NMAGIC) ||
 	    N_TRSIZE(ex) || N_DRSIZE(ex) ||
-	    i_size_read(bprm->file->f_dentry->d_inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
+	    i_size_read(bprm->file->f_path.dentry->d_inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
 		return -ENOEXEC;
 	}
 
@@ -389,7 +389,7 @@ static int load_aout_binary(struct linux
 		{
 			printk(KERN_WARNING 
 			       "fd_offset is not page aligned. Please convert program: %s\n",
-			       bprm->file->f_dentry->d_name.name);
+			       bprm->file->f_path.dentry->d_name.name);
 			error_time = jiffies;
 		}
 
@@ -469,7 +469,7 @@ static int load_aout_library(struct file
 	int retval;
 	struct exec ex;
 
-	inode = file->f_dentry->d_inode;
+	inode = file->f_path.dentry->d_inode;
 
 	retval = -ENOEXEC;
 	error = kernel_read(file, 0, (char *) &ex, sizeof(ex));
@@ -506,7 +506,7 @@ static int load_aout_library(struct file
 		{
 			printk(KERN_WARNING 
 			       "N_TXTOFF is not page aligned. Please convert library: %s\n",
-			       file->f_dentry->d_name.name);
+			       file->f_path.dentry->d_name.name);
 			error_time = jiffies;
 		}
 		down_write(&current->mm->mmap_sem);
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1186,7 +1186,7 @@ static int maydump(struct vm_area_struct
 
 	/* Dump shared memory only if mapped from an anonymous file. */
 	if (vma->vm_flags & VM_SHARED)
-		return vma->vm_file->f_dentry->d_inode->i_nlink == 0;
+		return vma->vm_file->f_path.dentry->d_inode->i_nlink == 0;
 
 	/* If it hasn't been written to, don't write it out */
 	if (!vma->anon_vma)
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -858,7 +858,7 @@ static int elf_fdpic_map_file(struct elf
 
 dynamic_error:
 	printk("ELF FDPIC %s with invalid DYNAMIC section (inode=%lu)\n",
-	       what, file->f_dentry->d_inode->i_ino);
+	       what, file->f_path.dentry->d_inode->i_ino);
 	return -ELIBBAD;
 }
 
@@ -1189,7 +1189,7 @@ static int maydump(struct vm_area_struct
 
 	/* Dump shared memory only if mapped from an anonymous file. */
 	if (vma->vm_flags & VM_SHARED) {
-		if (vma->vm_file->f_dentry->d_inode->i_nlink == 0) {
+		if (vma->vm_file->f_path.dentry->d_inode->i_nlink == 0) {
 			kdcore("%08lx: %08lx: no (share)", vma->vm_start, vma->vm_flags);
 			return 1;
 		}
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -429,7 +429,7 @@ static int load_flat_file(struct linux_b
 	int ret;
 
 	hdr = ((struct flat_hdr *) bprm->buf);		/* exec-header */
-	inode = bprm->file->f_dentry->d_inode;
+	inode = bprm->file->f_path.dentry->d_inode;
 
 	text_len  = ntohl(hdr->data_start);
 	data_len  = ntohl(hdr->data_end) - ntohl(hdr->data_start);
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -542,7 +542,7 @@ static ssize_t
 static ssize_t
 bm_entry_read(struct file * file, char __user * buf, size_t nbytes, loff_t *ppos)
 {
-	Node *e = file->f_dentry->d_inode->i_private;
+	Node *e = file->f_path.dentry->d_inode->i_private;
 	loff_t pos = *ppos;
 	ssize_t res;
 	char *page;
@@ -576,7 +576,7 @@ static ssize_t bm_entry_write(struct fil
 				size_t count, loff_t *ppos)
 {
 	struct dentry *root;
-	Node *e = file->f_dentry->d_inode->i_private;
+	Node *e = file->f_path.dentry->d_inode->i_private;
 	int res = parse_command(buffer, count);
 
 	switch (res) {
@@ -584,7 +584,7 @@ static ssize_t bm_entry_write(struct fil
 			break;
 		case 2: set_bit(Enabled, &e->flags);
 			break;
-		case 3: root = dget(file->f_vfsmnt->mnt_sb->s_root);
+		case 3: root = dget(file->f_path.mnt->mnt_sb->s_root);
 			mutex_lock(&root->d_inode->i_mutex);
 
 			kill_node(e);
@@ -610,7 +610,7 @@ static ssize_t bm_register_write(struct 
 	Node *e;
 	struct inode *inode;
 	struct dentry *root, *dentry;
-	struct super_block *sb = file->f_vfsmnt->mnt_sb;
+	struct super_block *sb = file->f_path.mnt->mnt_sb;
 	int err = 0;
 
 	e = create_entry(buffer, count);
@@ -699,7 +699,7 @@ static ssize_t bm_status_write(struct fi
 	switch (res) {
 		case 1: enabled = 0; break;
 		case 2: enabled = 1; break;
-		case 3: root = dget(file->f_vfsmnt->mnt_sb->s_root);
+		case 3: root = dget(file->f_path.mnt->mnt_sb->s_root);
 			mutex_lock(&root->d_inode->i_mutex);
 
 			while (!list_empty(&entries))
diff --git a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -190,7 +190,7 @@ static int blkdev_commit_write(struct fi
 
 /*
  * private llseek:
- * for a block special file file->f_dentry->d_inode->i_size is zero
+ * for a block special file file->f_path.dentry->d_inode->i_size is zero
  * so we compute the size by hand (just as in block_read/write above)
  */
 static loff_t block_llseek(struct file *file, loff_t offset, int origin)
@@ -1071,7 +1071,7 @@ int blkdev_get(struct block_device *bdev
 	struct dentry fake_dentry = {};
 	fake_file.f_mode = mode;
 	fake_file.f_flags = flags;
-	fake_file.f_dentry = &fake_dentry;
+	fake_file.f_path.dentry = &fake_dentry;
 	fake_dentry.d_inode = bdev->bd_inode;
 
 	return do_open(bdev, &fake_file, BD_MUTEX_NORMAL);
@@ -1092,7 +1092,7 @@ blkdev_get_whole(struct block_device *bd
 	struct dentry fake_dentry = {};
 	fake_file.f_mode = mode;
 	fake_file.f_flags = flags;
-	fake_file.f_dentry = &fake_dentry;
+	fake_file.f_path.dentry = &fake_dentry;
 	fake_dentry.d_inode = bdev->bd_inode;
 
 	return do_open(bdev, &fake_file, BD_MUTEX_WHOLE);
@@ -1111,7 +1111,7 @@ blkdev_get_partition(struct block_device
 	struct dentry fake_dentry = {};
 	fake_file.f_mode = mode;
 	fake_file.f_flags = flags;
-	fake_file.f_dentry = &fake_dentry;
+	fake_file.f_path.dentry = &fake_dentry;
 	fake_dentry.d_inode = bdev->bd_inode;
 
 	return do_open(bdev, &fake_file, BD_MUTEX_PARTITION);
diff --git a/fs/compat.c b/fs/compat.c
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -230,7 +230,7 @@ asmlinkage long compat_sys_fstatfs(unsig
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs(file->f_dentry, &tmp);
+	error = vfs_statfs(file->f_path.dentry, &tmp);
 	if (!error)
 		error = put_compat_statfs(buf, &tmp);
 	fput(file);
@@ -301,7 +301,7 @@ asmlinkage long compat_sys_fstatfs64(uns
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs(file->f_dentry, &tmp);
+	error = vfs_statfs(file->f_path.dentry, &tmp);
 	if (!error)
 		error = put_compat_statfs64(buf, &tmp);
 	fput(file);
@@ -363,7 +363,7 @@ static void compat_ioctl_error(struct fi
 	/* find the name of the device. */
 	path = (char *)__get_free_page(GFP_KERNEL);
 	if (path) {
-		fn = d_path(filp->f_dentry, filp->f_vfsmnt, path, PAGE_SIZE);
+		fn = d_path(filp->f_path.dentry, filp->f_path.mnt, path, PAGE_SIZE);
 		if (IS_ERR(fn))
 			fn = "?";
 	}
@@ -414,7 +414,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 	case FIBMAP:
 	case FIGETBSZ:
 	case FIONREAD:
-		if (S_ISREG(filp->f_dentry->d_inode->i_mode))
+		if (S_ISREG(filp->f_path.dentry->d_inode->i_mode))
 			break;
 		/*FALL THROUGH*/
 
@@ -436,7 +436,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 			goto found_handler;
 	}
 
-	if (S_ISSOCK(filp->f_dentry->d_inode->i_mode) &&
+	if (S_ISSOCK(filp->f_path.dentry->d_inode->i_mode) &&
 	    cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 		error = siocdevprivate_ioctl(fd, cmd, arg);
 	} else {
@@ -1255,7 +1255,7 @@ out:
 	if (iov != iovstack)
 		kfree(iov);
 	if ((ret + (type == READ)) > 0) {
-		struct dentry *dentry = file->f_dentry;
+		struct dentry *dentry = file->f_path.dentry;
 		if (type == READ)
 			fsnotify_access(dentry);
 		else
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1173,7 +1173,7 @@ static int vt_check(struct file *file)
 static int vt_check(struct file *file)
 {
 	struct tty_struct *tty;
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	
 	if (file->f_op->ioctl != tty_ioctl)
 		return -EINVAL;
diff --git a/fs/dnotify.c b/fs/dnotify.c
--- a/fs/dnotify.c
+++ b/fs/dnotify.c
@@ -42,7 +42,7 @@ void dnotify_flush(struct file *filp, fl
 	struct dnotify_struct **prev;
 	struct inode *inode;
 
-	inode = filp->f_dentry->d_inode;
+	inode = filp->f_path.dentry->d_inode;
 	if (!S_ISDIR(inode->i_mode))
 		return;
 	spin_lock(&inode->i_lock);
@@ -74,7 +74,7 @@ int fcntl_dirnotify(int fd, struct file 
 	}
 	if (!dir_notify_enable)
 		return -EINVAL;
-	inode = filp->f_dentry->d_inode;
+	inode = filp->f_path.dentry->d_inode;
 	if (!S_ISDIR(inode->i_mode))
 		return -ENOTDIR;
 	dn = kmem_cache_alloc(dn_cache, SLAB_KERNEL);
diff --git a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c
+++ b/fs/dquot.c
@@ -694,9 +694,9 @@ restart:
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
 		struct file *filp = list_entry(p, struct file, f_u.fu_list);
-		struct inode *inode = filp->f_dentry->d_inode;
+		struct inode *inode = filp->f_path.dentry->d_inode;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
-			struct dentry *dentry = dget(filp->f_dentry);
+			struct dentry *dentry = dget(filp->f_path.dentry);
 			file_list_unlock();
 			sb->dq_op->initialize(inode, type);
 			dput(dentry);
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -795,8 +795,8 @@ static int ep_getfd(int *efd, struct ino
 		goto eexit_4;
 	dentry->d_op = &eventpollfs_dentry_operations;
 	d_add(dentry, inode);
-	file->f_vfsmnt = mntget(eventpoll_mnt);
-	file->f_dentry = dentry;
+	file->f_path.mnt = mntget(eventpoll_mnt);
+	file->f_path.dentry = dentry;
 	file->f_mapping = inode->i_mapping;
 
 	file->f_pos = 0;
diff --git a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -912,7 +912,7 @@ int prepare_binprm(struct linux_binprm *
 int prepare_binprm(struct linux_binprm *bprm)
 {
 	int mode;
-	struct inode * inode = bprm->file->f_dentry->d_inode;
+	struct inode * inode = bprm->file->f_path.dentry->d_inode;
 	int retval;
 
 	mode = inode->i_mode;
@@ -922,7 +922,7 @@ int prepare_binprm(struct linux_binprm *
 	bprm->e_uid = current->euid;
 	bprm->e_gid = current->egid;
 
-	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
+	if(!(bprm->file->f_path.mnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
 		if (mode & S_ISUID) {
 			current->personality &= ~PER_CLEAR_ON_SETID;
@@ -1518,10 +1518,10 @@ int do_coredump(long signr, int exit_cod
 				 O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
 	if (IS_ERR(file))
 		goto fail_unlock;
-	inode = file->f_dentry->d_inode;
+	inode = file->f_path.dentry->d_inode;
 	if (inode->i_nlink > 1)
 		goto close_fail;	/* multiple links - don't dump */
-	if (!ispipe && d_unhashed(file->f_dentry))
+	if (!ispipe && d_unhashed(file->f_path.dentry))
 		goto close_fail;
 
 	/* AK: actually i see no reason to not allow this for named pipes etc.,
@@ -1532,7 +1532,7 @@ int do_coredump(long signr, int exit_cod
 		goto close_fail;
 	if (!file->f_op->write)
 		goto close_fail;
-	if (!ispipe && do_truncate(file->f_dentry, 0, 0, file) != 0)
+	if (!ispipe && do_truncate(file->f_path.dentry, 0, 0, file) != 0)
 		goto close_fail;
 
 	retval = binfmt->core_dump(signr, regs, file);
diff --git a/fs/fcntl.c b/fs/fcntl.c
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -204,7 +204,7 @@ asmlinkage long sys_dup(unsigned int fil
 
 static int setfl(int fd, struct file * filp, unsigned long arg)
 {
-	struct inode * inode = filp->f_dentry->d_inode;
+	struct inode * inode = filp->f_path.dentry->d_inode;
 	int error = 0;
 
 	/*
diff --git a/fs/file_table.c b/fs/file_table.c
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -152,8 +152,8 @@ EXPORT_SYMBOL(fput);
  */
 void fastcall __fput(struct file *file)
 {
-	struct dentry *dentry = file->f_dentry;
-	struct vfsmount *mnt = file->f_vfsmnt;
+	struct dentry *dentry = file->f_path.dentry;
+	struct vfsmount *mnt = file->f_path.mnt;
 	struct inode *inode = dentry->d_inode;
 
 	might_sleep();
@@ -176,8 +176,8 @@ void fastcall __fput(struct file *file)
 		put_write_access(inode);
 	put_pid(file->f_owner.pid);
 	file_kill(file);
-	file->f_dentry = NULL;
-	file->f_vfsmnt = NULL;
+	file->f_path.dentry = NULL;
+	file->f_path.mnt = NULL;
 	file_free(file);
 	dput(dentry);
 	mntput(mnt);
@@ -271,7 +271,7 @@ int fs_may_remount_ro(struct super_block
 	file_list_lock();
 	list_for_each(p, &sb->s_files) {
 		struct file *file = list_entry(p, struct file, f_u.fu_list);
-		struct inode *inode = file->f_dentry->d_inode;
+		struct inode *inode = file->f_path.dentry->d_inode;
 
 		/* File with pending delete? */
 		if (inode->i_nlink == 0)
diff --git a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1200,7 +1200,7 @@ EXPORT_SYMBOL(touch_atime);
 
 void file_update_time(struct file *file)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	struct timespec now;
 	int sync_it = 0;
 
diff --git a/fs/inotify_user.c b/fs/inotify_user.c
--- a/fs/inotify_user.c
+++ b/fs/inotify_user.c
@@ -570,9 +570,9 @@ asmlinkage long sys_inotify_init(void)
 	dev->ih = ih;
 
 	filp->f_op = &inotify_fops;
-	filp->f_vfsmnt = mntget(inotify_mnt);
-	filp->f_dentry = dget(inotify_mnt->mnt_root);
-	filp->f_mapping = filp->f_dentry->d_inode->i_mapping;
+	filp->f_path.mnt = mntget(inotify_mnt);
+	filp->f_path.dentry = dget(inotify_mnt->mnt_root);
+	filp->f_mapping = filp->f_path.dentry->d_inode->i_mapping;
 	filp->f_mode = FMODE_READ;
 	filp->f_flags = O_RDONLY;
 	filp->private_data = dev;
diff --git a/fs/ioctl.c b/fs/ioctl.c
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -31,7 +31,7 @@ static long do_ioctl(struct file *filp, 
 		goto out;
 	} else if (filp->f_op->ioctl) {
 		lock_kernel();
-		error = filp->f_op->ioctl(filp->f_dentry->d_inode,
+		error = filp->f_op->ioctl(filp->f_path.dentry->d_inode,
 					  filp, cmd, arg);
 		unlock_kernel();
 	}
@@ -45,7 +45,7 @@ static int file_ioctl(struct file *filp,
 {
 	int error;
 	int block;
-	struct inode * inode = filp->f_dentry->d_inode;
+	struct inode * inode = filp->f_path.dentry->d_inode;
 	int __user *p = (int __user *)arg;
 
 	switch (cmd) {
@@ -137,17 +137,17 @@ int vfs_ioctl(struct file *filp, unsigne
 			break;
 
 		case FIOQSIZE:
-			if (S_ISDIR(filp->f_dentry->d_inode->i_mode) ||
-			    S_ISREG(filp->f_dentry->d_inode->i_mode) ||
-			    S_ISLNK(filp->f_dentry->d_inode->i_mode)) {
-				loff_t res = inode_get_bytes(filp->f_dentry->d_inode);
+			if (S_ISDIR(filp->f_path.dentry->d_inode->i_mode) ||
+			    S_ISREG(filp->f_path.dentry->d_inode->i_mode) ||
+			    S_ISLNK(filp->f_path.dentry->d_inode->i_mode)) {
+				loff_t res = inode_get_bytes(filp->f_path.dentry->d_inode);
 				error = copy_to_user((loff_t __user *)arg, &res, sizeof(res)) ? -EFAULT : 0;
 			}
 			else
 				error = -ENOTTY;
 			break;
 		default:
-			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
+			if (S_ISREG(filp->f_path.dentry->d_inode->i_mode))
 				error = file_ioctl(filp, cmd, arg);
 			else
 				error = do_ioctl(filp, cmd, arg);
diff --git a/fs/libfs.c b/fs/libfs.c
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -63,7 +63,7 @@ int dcache_dir_open(struct inode *inode,
 {
 	static struct qstr cursor_name = {.len = 1, .name = "."};
 
-	file->private_data = d_alloc(file->f_dentry, &cursor_name);
+	file->private_data = d_alloc(file->f_path.dentry, &cursor_name);
 
 	return file->private_data ? 0 : -ENOMEM;
 }
@@ -76,7 +76,7 @@ int dcache_dir_close(struct inode *inode
 
 loff_t dcache_dir_lseek(struct file *file, loff_t offset, int origin)
 {
-	mutex_lock(&file->f_dentry->d_inode->i_mutex);
+	mutex_lock(&file->f_path.dentry->d_inode->i_mutex);
 	switch (origin) {
 		case 1:
 			offset += file->f_pos;
@@ -84,7 +84,7 @@ loff_t dcache_dir_lseek(struct file *fil
 			if (offset >= 0)
 				break;
 		default:
-			mutex_unlock(&file->f_dentry->d_inode->i_mutex);
+			mutex_unlock(&file->f_path.dentry->d_inode->i_mutex);
 			return -EINVAL;
 	}
 	if (offset != file->f_pos) {
@@ -96,8 +96,8 @@ loff_t dcache_dir_lseek(struct file *fil
 
 			spin_lock(&dcache_lock);
 			list_del(&cursor->d_u.d_child);
-			p = file->f_dentry->d_subdirs.next;
-			while (n && p != &file->f_dentry->d_subdirs) {
+			p = file->f_path.dentry->d_subdirs.next;
+			while (n && p != &file->f_path.dentry->d_subdirs) {
 				struct dentry *next;
 				next = list_entry(p, struct dentry, d_u.d_child);
 				if (!d_unhashed(next) && next->d_inode)
@@ -108,7 +108,7 @@ loff_t dcache_dir_lseek(struct file *fil
 			spin_unlock(&dcache_lock);
 		}
 	}
-	mutex_unlock(&file->f_dentry->d_inode->i_mutex);
+	mutex_unlock(&file->f_path.dentry->d_inode->i_mutex);
 	return offset;
 }
 
@@ -126,7 +126,7 @@ static inline unsigned char dt_type(stru
 
 int dcache_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct dentry *cursor = filp->private_data;
 	struct list_head *p, *q = &cursor->d_u.d_child;
 	ino_t ino;
diff --git a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -321,7 +321,7 @@ static int flock_to_posix_lock(struct fi
 		start = filp->f_pos;
 		break;
 	case SEEK_END:
-		start = i_size_read(filp->f_dentry->d_inode);
+		start = i_size_read(filp->f_path.dentry->d_inode);
 		break;
 	default:
 		return -EINVAL;
@@ -371,7 +371,7 @@ static int flock64_to_posix_lock(struct 
 		start = filp->f_pos;
 		break;
 	case SEEK_END:
-		start = i_size_read(filp->f_dentry->d_inode);
+		start = i_size_read(filp->f_path.dentry->d_inode);
 		break;
 	default:
 		return -EINVAL;
@@ -672,7 +672,7 @@ posix_test_lock(struct file *filp, struc
 	struct file_lock *cfl;
 
 	lock_kernel();
-	for (cfl = filp->f_dentry->d_inode->i_flock; cfl; cfl = cfl->fl_next) {
+	for (cfl = filp->f_path.dentry->d_inode->i_flock; cfl; cfl = cfl->fl_next) {
 		if (!IS_POSIX(cfl))
 			continue;
 		if (posix_locks_conflict(cfl, fl))
@@ -734,7 +734,7 @@ static int flock_lock_file(struct file *
 {
 	struct file_lock *new_fl = NULL;
 	struct file_lock **before;
-	struct inode * inode = filp->f_dentry->d_inode;
+	struct inode * inode = filp->f_path.dentry->d_inode;
 	int error = 0;
 	int found = 0;
 
@@ -1018,7 +1018,7 @@ static int __posix_lock_file_conf(struct
  */
 int posix_lock_file(struct file *filp, struct file_lock *fl)
 {
-	return __posix_lock_file_conf(filp->f_dentry->d_inode, fl, NULL);
+	return __posix_lock_file_conf(filp->f_path.dentry->d_inode, fl, NULL);
 }
 EXPORT_SYMBOL(posix_lock_file);
 
@@ -1033,7 +1033,7 @@ int posix_lock_file_conf(struct file *fi
 int posix_lock_file_conf(struct file *filp, struct file_lock *fl,
 			struct file_lock *conflock)
 {
-	return __posix_lock_file_conf(filp->f_dentry->d_inode, fl, conflock);
+	return __posix_lock_file_conf(filp->f_path.dentry->d_inode, fl, conflock);
 }
 EXPORT_SYMBOL(posix_lock_file_conf);
 
@@ -1333,8 +1333,8 @@ int fcntl_getlease(struct file *filp)
 	int type = F_UNLCK;
 
 	lock_kernel();
-	time_out_leases(filp->f_dentry->d_inode);
-	for (fl = filp->f_dentry->d_inode->i_flock; fl && IS_LEASE(fl);
+	time_out_leases(filp->f_path.dentry->d_inode);
+	for (fl = filp->f_path.dentry->d_inode->i_flock; fl && IS_LEASE(fl);
 			fl = fl->fl_next) {
 		if (fl->fl_file == filp) {
 			type = fl->fl_type & ~F_INPROGRESS;
@@ -1359,7 +1359,7 @@ static int __setlease(struct file *filp,
 static int __setlease(struct file *filp, long arg, struct file_lock **flp)
 {
 	struct file_lock *fl, **before, **my_before = NULL, *lease;
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct inode *inode = dentry->d_inode;
 	int error, rdlease_count = 0, wrlease_count = 0;
 
@@ -1448,7 +1448,7 @@ out:
 
 int setlease(struct file *filp, long arg, struct file_lock **lease)
 {
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct inode *inode = dentry->d_inode;
 	int error;
 
@@ -1482,7 +1482,7 @@ int fcntl_setlease(unsigned int fd, stru
 int fcntl_setlease(unsigned int fd, struct file *filp, long arg)
 {
 	struct file_lock fl, *flp = &fl;
-	struct dentry *dentry = filp->f_dentry;
+	struct dentry *dentry = filp->f_path.dentry;
 	struct inode *inode = dentry->d_inode;
 	int error;
 
@@ -1692,7 +1692,7 @@ int fcntl_setlk(unsigned int fd, struct 
 	if (copy_from_user(&flock, l, sizeof(flock)))
 		goto out;
 
-	inode = filp->f_dentry->d_inode;
+	inode = filp->f_path.dentry->d_inode;
 
 	/* Don't allow mandatory locks on files that may be memory mapped
 	 * and shared.
@@ -1835,7 +1835,7 @@ int fcntl_setlk64(unsigned int fd, struc
 	if (copy_from_user(&flock, l, sizeof(flock)))
 		goto out;
 
-	inode = filp->f_dentry->d_inode;
+	inode = filp->f_path.dentry->d_inode;
 
 	/* Don't allow mandatory locks on files that may be memory mapped
 	 * and shared.
@@ -1922,7 +1922,7 @@ void locks_remove_posix(struct file *fil
 	 * posix_lock_file().  Another process could be setting a lock on this
 	 * file at the same time, but we wouldn't remove that lock anyway.
 	 */
-	if (!filp->f_dentry->d_inode->i_flock)
+	if (!filp->f_path.dentry->d_inode->i_flock)
 		return;
 
 	lock.fl_type = F_UNLCK;
@@ -1951,7 +1951,7 @@ EXPORT_SYMBOL(locks_remove_posix);
  */
 void locks_remove_flock(struct file *filp)
 {
-	struct inode * inode = filp->f_dentry->d_inode; 
+	struct inode * inode = filp->f_path.dentry->d_inode; 
 	struct file_lock *fl;
 	struct file_lock **before;
 
@@ -2020,7 +2020,7 @@ static void lock_get_status(char* out, s
 	struct inode *inode = NULL;
 
 	if (fl->fl_file != NULL)
-		inode = fl->fl_file->f_dentry->d_inode;
+		inode = fl->fl_file->f_path.dentry->d_inode;
 
 	out += sprintf(out, "%d:%s ", id, pfx);
 	if (IS_POSIX(fl)) {
diff --git a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -295,7 +295,7 @@ int vfs_permission(struct nameidata *nd,
  */
 int file_permission(struct file *file, int mask)
 {
-	return permission(file->f_dentry->d_inode, mask, NULL);
+	return permission(file->f_path.dentry->d_inode, mask, NULL);
 }
 
 /*
@@ -331,7 +331,7 @@ int get_write_access(struct inode * inod
 
 int deny_write_access(struct file * file)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 
 	spin_lock(&inode->i_lock);
 	if (atomic_read(&inode->i_writecount) > 0) {
@@ -366,7 +366,7 @@ void path_release_on_umount(struct namei
  */
 void release_open_intent(struct nameidata *nd)
 {
-	if (nd->intent.open.file->f_dentry == NULL)
+	if (nd->intent.open.file->f_path.dentry == NULL)
 		put_filp(nd->intent.open.file);
 	else
 		fput(nd->intent.open.file);
@@ -1136,7 +1136,7 @@ static int fastcall do_path_lookup(int d
 		if (!file)
 			goto out_fail;
 
-		dentry = file->f_dentry;
+		dentry = file->f_path.dentry;
 
 		retval = -ENOTDIR;
 		if (!S_ISDIR(dentry->d_inode->i_mode))
@@ -1146,7 +1146,7 @@ static int fastcall do_path_lookup(int d
 		if (retval)
 			goto fput_fail;
 
-		nd->mnt = mntget(file->f_vfsmnt);
+		nd->mnt = mntget(file->f_path.mnt);
 		nd->dentry = dget(dentry);
 
 		fput_light(file, fput_needed);
diff --git a/fs/open.c b/fs/open.c
--- a/fs/open.c
+++ b/fs/open.c
@@ -165,7 +165,7 @@ asmlinkage long sys_fstatfs(unsigned int
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs_native(file->f_dentry, &tmp);
+	error = vfs_statfs_native(file->f_path.dentry, &tmp);
 	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
@@ -186,7 +186,7 @@ asmlinkage long sys_fstatfs64(unsigned i
 	file = fget(fd);
 	if (!file)
 		goto out;
-	error = vfs_statfs64(file->f_dentry, &tmp);
+	error = vfs_statfs64(file->f_path.dentry, &tmp);
 	if (!error && copy_to_user(buf, &tmp, sizeof(tmp)))
 		error = -EFAULT;
 	fput(file);
@@ -302,7 +302,7 @@ static long do_sys_ftruncate(unsigned in
 	if (file->f_flags & O_LARGEFILE)
 		small = 0;
 
-	dentry = file->f_dentry;
+	dentry = file->f_path.dentry;
 	inode = dentry->d_inode;
 	error = -EINVAL;
 	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
@@ -448,8 +448,8 @@ asmlinkage long sys_fchdir(unsigned int 
 	if (!file)
 		goto out;
 
-	dentry = file->f_dentry;
-	mnt = file->f_vfsmnt;
+	dentry = file->f_path.dentry;
+	mnt = file->f_path.mnt;
 	inode = dentry->d_inode;
 
 	error = -ENOTDIR;
@@ -503,7 +503,7 @@ asmlinkage long sys_fchmod(unsigned int 
 	if (!file)
 		goto out;
 
-	dentry = file->f_dentry;
+	dentry = file->f_path.dentry;
 	inode = dentry->d_inode;
 
 	audit_inode(NULL, inode);
@@ -662,7 +662,7 @@ asmlinkage long sys_fchown(unsigned int 
 	if (!file)
 		goto out;
 
-	dentry = file->f_dentry;
+	dentry = file->f_path.dentry;
 	audit_inode(NULL, dentry->d_inode);
 	error = chown_common(dentry, user, group);
 	fput(file);
@@ -688,8 +688,8 @@ static struct file *__dentry_open(struct
 	}
 
 	f->f_mapping = inode->i_mapping;
-	f->f_dentry = dentry;
-	f->f_vfsmnt = mnt;
+	f->f_path.dentry = dentry;
+	f->f_path.mnt = mnt;
 	f->f_pos = 0;
 	f->f_op = fops_get(inode->i_fop);
 	file_move(f, &inode->i_sb->s_files);
@@ -723,8 +723,8 @@ cleanup_all:
 	if (f->f_mode & FMODE_WRITE)
 		put_write_access(inode);
 	file_kill(f);
-	f->f_dentry = NULL;
-	f->f_vfsmnt = NULL;
+	f->f_path.dentry = NULL;
+	f->f_path.mnt = NULL;
 cleanup_file:
 	put_filp(f);
 	dput(dentry);
@@ -822,7 +822,7 @@ struct file *nameidata_to_filp(struct na
 	/* Pick up the filp from the open intent */
 	filp = nd->intent.open.file;
 	/* Has the filesystem initialised the file for us? */
-	if (filp->f_dentry == NULL)
+	if (filp->f_path.dentry == NULL)
 		filp = __dentry_open(nd->dentry, nd->mnt, flags, filp, NULL);
 	else
 		path_release(nd);
@@ -965,7 +965,7 @@ long do_sys_open(int dfd, const char __u
 				put_unused_fd(fd);
 				fd = PTR_ERR(f);
 			} else {
-				fsnotify_open(f->f_dentry);
+				fsnotify_open(f->f_path.dentry);
 				fd_install(fd, f);
 			}
 		}
diff --git a/fs/pipe.c b/fs/pipe.c
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -222,7 +222,7 @@ pipe_read(struct kiocb *iocb, const stru
 	   unsigned long nr_segs, loff_t pos)
 {
 	struct file *filp = iocb->ki_filp;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct pipe_inode_info *pipe;
 	int do_wakeup;
 	ssize_t ret;
@@ -335,7 +335,7 @@ pipe_write(struct kiocb *iocb, const str
 	    unsigned long nr_segs, loff_t ppos)
 {
 	struct file *filp = iocb->ki_filp;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct pipe_inode_info *pipe;
 	ssize_t ret;
 	int do_wakeup;
@@ -520,7 +520,7 @@ pipe_ioctl(struct inode *pino, struct fi
 pipe_ioctl(struct inode *pino, struct file *filp,
 	   unsigned int cmd, unsigned long arg)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct pipe_inode_info *pipe;
 	int count, buf, nrbufs;
 
@@ -548,7 +548,7 @@ pipe_poll(struct file *filp, poll_table 
 pipe_poll(struct file *filp, poll_table *wait)
 {
 	unsigned int mask;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct pipe_inode_info *pipe = inode->i_pipe;
 	int nrbufs;
 
@@ -601,7 +601,7 @@ static int
 static int
 pipe_read_fasync(int fd, struct file *filp, int on)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	int retval;
 
 	mutex_lock(&inode->i_mutex);
@@ -618,7 +618,7 @@ static int
 static int
 pipe_write_fasync(int fd, struct file *filp, int on)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	int retval;
 
 	mutex_lock(&inode->i_mutex);
@@ -635,7 +635,7 @@ static int
 static int
 pipe_rdwr_fasync(int fd, struct file *filp, int on)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct pipe_inode_info *pipe = inode->i_pipe;
 	int retval;
 
@@ -902,8 +902,8 @@ struct file *create_write_pipe(void)
 
 	dentry->d_op = &pipefs_dentry_operations;
 	d_add(dentry, inode);
-	f->f_vfsmnt = mntget(pipe_mnt);
-	f->f_dentry = dentry;
+	f->f_path.mnt = mntget(pipe_mnt);
+	f->f_path.dentry = dentry;
 	f->f_mapping = inode->i_mapping;
 
 	f->f_flags = O_WRONLY;
@@ -923,8 +923,8 @@ struct file *create_write_pipe(void)
 
 void free_write_pipe(struct file *f)
 {
-	mntput(f->f_vfsmnt);
-	dput(f->f_dentry);
+	mntput(f->f_path.mnt);
+	dput(f->f_path.dentry);
 	put_filp(f);
 }
 
@@ -935,9 +935,9 @@ struct file *create_read_pipe(struct fil
 		return ERR_PTR(-ENFILE);
 
 	/* Grab pipe from the writer */
-	f->f_vfsmnt = mntget(wrf->f_vfsmnt);
-	f->f_dentry = dget(wrf->f_dentry);
-	f->f_mapping = wrf->f_dentry->d_inode->i_mapping;
+	f->f_path.mnt = mntget(wrf->f_path.mnt);
+	f->f_path.dentry = dget(wrf->f_path.dentry);
+	f->f_mapping = wrf->f_path.dentry->d_inode->i_mapping;
 
 	f->f_pos = 0;
 	f->f_flags = O_RDONLY;
diff --git a/fs/read_write.c b/fs/read_write.c
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -64,13 +64,13 @@ loff_t remote_llseek(struct file *file, 
 	lock_kernel();
 	switch (origin) {
 		case 2:
-			offset += i_size_read(file->f_dentry->d_inode);
+			offset += i_size_read(file->f_path.dentry->d_inode);
 			break;
 		case 1:
 			offset += file->f_pos;
 	}
 	retval = -EINVAL;
-	if (offset>=0 && offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
+	if (offset>=0 && offset<=file->f_path.dentry->d_inode->i_sb->s_maxbytes) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_version = 0;
@@ -95,7 +95,7 @@ loff_t default_llseek(struct file *file,
 	lock_kernel();
 	switch (origin) {
 		case 2:
-			offset += i_size_read(file->f_dentry->d_inode);
+			offset += i_size_read(file->f_path.dentry->d_inode);
 			break;
 		case 1:
 			offset += file->f_pos;
@@ -203,7 +203,7 @@ int rw_verify_area(int read_write, struc
 	if (unlikely((pos < 0) || (loff_t) (pos + count) < 0))
 		goto Einval;
 
-	inode = file->f_dentry->d_inode;
+	inode = file->f_path.dentry->d_inode;
 	if (unlikely(inode->i_flock && MANDATORY_LOCK(inode))) {
 		int retval = locks_mandatory_area(
 			read_write == READ ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE,
@@ -273,7 +273,7 @@ ssize_t vfs_read(struct file *file, char
 			else
 				ret = do_sync_read(file, buf, count, pos);
 			if (ret > 0) {
-				fsnotify_access(file->f_dentry);
+				fsnotify_access(file->f_path.dentry);
 				current->rchar += ret;
 			}
 			current->syscr++;
@@ -331,7 +331,7 @@ ssize_t vfs_write(struct file *file, con
 			else
 				ret = do_sync_write(file, buf, count, pos);
 			if (ret > 0) {
-				fsnotify_modify(file->f_dentry);
+				fsnotify_modify(file->f_path.dentry);
 				current->wchar += ret;
 			}
 			current->syscw++;
@@ -628,9 +628,9 @@ out:
 		kfree(iov);
 	if ((ret + (type == READ)) > 0) {
 		if (type == READ)
-			fsnotify_access(file->f_dentry);
+			fsnotify_access(file->f_path.dentry);
 		else
-			fsnotify_modify(file->f_dentry);
+			fsnotify_modify(file->f_path.dentry);
 	}
 	return ret;
 }
@@ -722,7 +722,7 @@ static ssize_t do_sendfile(int out_fd, i
 	if (!(in_file->f_mode & FMODE_READ))
 		goto fput_in;
 	retval = -EINVAL;
-	in_inode = in_file->f_dentry->d_inode;
+	in_inode = in_file->f_path.dentry->d_inode;
 	if (!in_inode)
 		goto fput_in;
 	if (!in_file->f_op || !in_file->f_op->sendfile)
@@ -754,7 +754,7 @@ static ssize_t do_sendfile(int out_fd, i
 	retval = -EINVAL;
 	if (!out_file->f_op || !out_file->f_op->sendpage)
 		goto fput_out;
-	out_inode = out_file->f_dentry->d_inode;
+	out_inode = out_file->f_path.dentry->d_inode;
 	retval = rw_verify_area(WRITE, out_file, &out_file->f_pos, count);
 	if (retval < 0)
 		goto fput_out;
diff --git a/fs/readdir.c b/fs/readdir.c
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -21,7 +21,7 @@
 
 int vfs_readdir(struct file *file, filldir_t filler, void *buf)
 {
-	struct inode *inode = file->f_dentry->d_inode;
+	struct inode *inode = file->f_path.dentry->d_inode;
 	int res = -ENOTDIR;
 	if (!file->f_op || !file->f_op->readdir)
 		goto out;
diff --git a/fs/seq_file.c b/fs/seq_file.c
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -269,7 +269,7 @@ EXPORT_SYMBOL(seq_lseek);
 /**
  *	seq_release -	free the structures associated with sequential file.
  *	@file: file in question
- *	@inode: file->f_dentry->d_inode
+ *	@inode: file->f_path.dentry->d_inode
  *
  *	Frees the structures associated with sequential file; can be used
  *	as ->f_op->release() if you don't have private data to destroy.
diff --git a/fs/splice.c b/fs/splice.c
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -941,7 +941,7 @@ long do_splice_direct(struct file *in, l
 	 * randomly drop data for eg socket -> socket splicing. Use the
 	 * piped splicing for that!
 	 */
-	i_mode = in->f_dentry->d_inode->i_mode;
+	i_mode = in->f_path.dentry->d_inode->i_mode;
 	if (unlikely(!S_ISREG(i_mode) && !S_ISBLK(i_mode)))
 		return -EINVAL;
 
@@ -1052,7 +1052,7 @@ static long do_splice(struct file *in, l
 	loff_t offset, *off;
 	long ret;
 
-	pipe = in->f_dentry->d_inode->i_pipe;
+	pipe = in->f_path.dentry->d_inode->i_pipe;
 	if (pipe) {
 		if (off_in)
 			return -ESPIPE;
@@ -1073,7 +1073,7 @@ static long do_splice(struct file *in, l
 		return ret;
 	}
 
-	pipe = out->f_dentry->d_inode->i_pipe;
+	pipe = out->f_path.dentry->d_inode->i_pipe;
 	if (pipe) {
 		if (off_out)
 			return -ESPIPE;
@@ -1231,7 +1231,7 @@ static long do_vmsplice(struct file *fil
 static long do_vmsplice(struct file *file, const struct iovec __user *iov,
 			unsigned long nr_segs, unsigned int flags)
 {
-	struct pipe_inode_info *pipe = file->f_dentry->d_inode->i_pipe;
+	struct pipe_inode_info *pipe = file->f_path.dentry->d_inode->i_pipe;
 	struct page *pages[PIPE_BUFFERS];
 	struct partial_page partial[PIPE_BUFFERS];
 	struct splice_pipe_desc spd = {
@@ -1475,8 +1475,8 @@ static long do_tee(struct file *in, stru
 static long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags)
 {
-	struct pipe_inode_info *ipipe = in->f_dentry->d_inode->i_pipe;
-	struct pipe_inode_info *opipe = out->f_dentry->d_inode->i_pipe;
+	struct pipe_inode_info *ipipe = in->f_path.dentry->d_inode->i_pipe;
+	struct pipe_inode_info *opipe = out->f_path.dentry->d_inode->i_pipe;
 	int ret = -EINVAL;
 
 	/*
diff --git a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -109,7 +109,7 @@ int vfs_fstat(unsigned int fd, struct ks
 	int error = -EBADF;
 
 	if (f) {
-		error = vfs_getattr(f->f_vfsmnt, f->f_dentry, stat);
+		error = vfs_getattr(f->f_path.mnt, f->f_path.dentry, stat);
 		fput(f);
 	}
 	return error;
diff --git a/fs/super.c b/fs/super.c
--- a/fs/super.c
+++ b/fs/super.c
@@ -552,7 +552,7 @@ static void mark_files_ro(struct super_b
 
 	file_list_lock();
 	list_for_each_entry(f, &sb->s_files, f_u.fu_list) {
-		if (S_ISREG(f->f_dentry->d_inode->i_mode) && file_count(f))
+		if (S_ISREG(f->f_path.dentry->d_inode->i_mode) && file_count(f))
 			f->f_mode &= ~FMODE_WRITE;
 	}
 	file_list_unlock();
diff --git a/fs/sync.c b/fs/sync.c
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -93,7 +93,7 @@ long do_fsync(struct file *file, int dat
 	 * livelocks in fsync_buffers_list().
 	 */
 	mutex_lock(&mapping->host->i_mutex);
-	err = file->f_op->fsync(file, file->f_dentry, datasync);
+	err = file->f_op->fsync(file, file->f_path.dentry, datasync);
 	if (!ret)
 		ret = err;
 	mutex_unlock(&mapping->host->i_mutex);
@@ -222,7 +222,7 @@ asmlinkage long sys_sync_file_range(int 
 	if (!file)
 		goto out;
 
-	i_mode = file->f_dentry->d_inode->i_mode;
+	i_mode = file->f_path.dentry->d_inode->i_mode;
 	ret = -ESPIPE;
 	if (!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISDIR(i_mode) &&
 			!S_ISLNK(i_mode))
diff --git a/fs/xattr.c b/fs/xattr.c
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -261,7 +261,7 @@ sys_fsetxattr(int fd, char __user *name,
 	f = fget(fd);
 	if (!f)
 		return error;
-	dentry = f->f_dentry;
+	dentry = f->f_path.dentry;
 	audit_inode(NULL, dentry->d_inode);
 	error = setxattr(dentry, name, value, size, flags);
 	fput(f);
@@ -344,7 +344,7 @@ sys_fgetxattr(int fd, char __user *name,
 	f = fget(fd);
 	if (!f)
 		return error;
-	error = getxattr(f->f_dentry, name, value, size);
+	error = getxattr(f->f_path.dentry, name, value, size);
 	fput(f);
 	return error;
 }
@@ -416,7 +416,7 @@ sys_flistxattr(int fd, char __user *list
 	f = fget(fd);
 	if (!f)
 		return error;
-	error = listxattr(f->f_dentry, list, size);
+	error = listxattr(f->f_path.dentry, list, size);
 	fput(f);
 	return error;
 }
@@ -477,7 +477,7 @@ sys_fremovexattr(int fd, char __user *na
 	f = fget(fd);
 	if (!f)
 		return error;
-	dentry = f->f_dentry;
+	dentry = f->f_path.dentry;
 	audit_inode(NULL, dentry->d_inode);
 	error = removexattr(dentry, name);
 	fput(f);
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -269,6 +269,7 @@ extern int dir_notify_enable;
 #include <linux/types.h>
 #include <linux/kdev_t.h>
 #include <linux/dcache.h>
+#include <linux/namei.h>
 #include <linux/stat.h>
 #include <linux/cache.h>
 #include <linux/kobject.h>
@@ -723,8 +724,9 @@ struct file {
 		struct list_head	fu_list;
 		struct rcu_head 	fu_rcuhead;
 	} f_u;
-	struct dentry		*f_dentry;
-	struct vfsmount         *f_vfsmnt;
+	struct path		f_path;
+#define f_dentry	f_path.dentry
+#define f_vfsmnt	f_path.mnt
 	const struct file_operations	*f_op;
 	atomic_t		f_count;
 	unsigned int 		f_flags;
@@ -1259,7 +1261,7 @@ static inline void file_accessed(struct 
 static inline void file_accessed(struct file *file)
 {
 	if (!(file->f_flags & O_NOATIME))
-		touch_atime(file->f_vfsmnt, file->f_dentry);
+		touch_atime(file->f_path.mnt, file->f_path.dentry);
 }
 
 int sync_inode(struct inode *inode, struct writeback_control *wbc);
@@ -1650,7 +1652,7 @@ static inline void allow_write_access(st
 static inline void allow_write_access(struct file *file)
 {
 	if (file)
-		atomic_inc(&file->f_dentry->d_inode->i_writecount);
+		atomic_inc(&file->f_path.dentry->d_inode->i_writecount);
 }
 extern int do_pipe(int *);
 extern struct file *create_read_pipe(struct file *f);
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -164,7 +164,7 @@ static inline void fsnotify_open(struct 
  */
 static inline void fsnotify_close(struct file *file)
 {
-	struct dentry *dentry = file->f_dentry;
+	struct dentry *dentry = file->f_path.dentry;
 	struct inode *inode = dentry->d_inode;
 	const char *name = dentry->d_name.name;
 	mode_t mode = file->f_mode;


