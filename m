Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135608AbRDXN2i>; Tue, 24 Apr 2001 09:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135603AbRDXN2U>; Tue, 24 Apr 2001 09:28:20 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:7686 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S135602AbRDXN2G>; Tue, 24 Apr 2001 09:28:06 -0400
Date: Tue, 24 Apr 2001 15:27:30 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@turbolinux.com>, Ed Tomlinson <tomlins@cam.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
Message-ID: <20010424152729.Z2615@arthur.ubicom.tudelft.nl>
In-Reply-To: <200104240356.f3O3ujbI002673@webber.adilger.int> <Pine.GSO.4.21.0104240534440.6992-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104240534440.6992-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Apr 24, 2001 at 06:01:12AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 06:01:12AM -0400, Alexander Viro wrote:
> For fsck sake! HFS patch. Time: 14 minutes, including checking that sucker
> builds (it had most of the accesses to ->u.hfs_i already encapsulated).

Al is right, it is no rocket science. Here is a patch against
2.4.4-pre6 for procfs and isofs. It took me an hour to do because I'm
not familiar with the fs code. It compiles, and the procfs code even
runs (sorry, no CDROM player availeble on my embedded StrongARM
system), though it is possible that there are some bugs in it.


Erik

Index: fs/isofs/inode.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/fs/isofs/inode.c,v
retrieving revision 1.1.1.24
diff -d -u -r1.1.1.24 inode.c
--- fs/isofs/inode.c	2001/04/21 21:24:00	1.1.1.24
+++ fs/isofs/inode.c	2001/04/24 13:13:29
@@ -15,6 +15,7 @@
 #include <linux/stat.h>
 #include <linux/sched.h>
 #include <linux/iso_fs.h>
+#include <linux/iso_fs_i.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/mm.h>
@@ -44,6 +45,8 @@
 static int check_bread = 0;
 #endif
 
+static kmem_cache_t *isofs_cachep;
+
 static int isofs_hashi(struct dentry *parent, struct qstr *qstr);
 static int isofs_hash(struct dentry *parent, struct qstr *qstr);
 static int isofs_dentry_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b);
@@ -74,10 +77,12 @@
 }
 
 static void isofs_read_inode(struct inode *);
+static void isofs_clear_inode(struct inode *);
 static int isofs_statfs (struct super_block *, struct statfs *);
 
 static struct super_operations isofs_sops = {
 	read_inode:	isofs_read_inode,
+	clear_inode:    isofs_clear_inode,
 	put_super:	isofs_put_super,
 	statfs:		isofs_statfs,
 };
@@ -908,9 +913,9 @@
 		goto abort_beyond_end;
 
 	offset    = 0;
-	firstext  = inode->u.isofs_i.i_first_extent;
-	sect_size = inode->u.isofs_i.i_section_size >> ISOFS_BUFFER_BITS(inode);
-	nextino   = inode->u.isofs_i.i_next_section_ino;
+	firstext  = ISOFS_I(inode)->i_first_extent;
+	sect_size = ISOFS_I(inode)->i_section_size >> ISOFS_BUFFER_BITS(inode);
+	nextino   = ISOFS_I(inode)->i_next_section_ino;
 
 	i = 0;
 	if (nextino) {
@@ -923,9 +928,9 @@
 			ninode = iget(inode->i_sb, nextino);
 			if (!ninode)
 				goto abort;
-			firstext  = ninode->u.isofs_i.i_first_extent;
-			sect_size = ninode->u.isofs_i.i_section_size;
-			nextino   = ninode->u.isofs_i.i_next_section_ino;
+			firstext  = ISOFS_I(ninode)->i_first_extent;
+			sect_size = ISOFS_I(ninode)->i_section_size;
+			nextino   = ISOFS_I(ninode)->i_next_section_ino;
 			iput(ninode);
 
 			if (++i > 100)
@@ -1025,7 +1030,7 @@
 	struct iso_directory_record * tmpde = NULL;
 
 	inode->i_size = 0;
-	inode->u.isofs_i.i_next_section_ino = 0;
+	ISOFS_I(inode)->i_next_section_ino = 0;
 
 	block = f_pos >> ISOFS_BUFFER_BITS(inode);
 	offset = f_pos & (bufsize-1);
@@ -1077,7 +1082,7 @@
 
 		inode->i_size += isonum_733(de->size);
 		if (i == 1)
-			inode->u.isofs_i.i_next_section_ino = f_pos;
+			ISOFS_I(inode)->i_next_section_ino = f_pos;
 
 		more_entries = de->flags[-high_sierra] & 0x80;
 
@@ -1174,9 +1179,10 @@
 	inode->i_uid = inode->i_sb->u.isofs_sb.s_uid;
 	inode->i_gid = inode->i_sb->u.isofs_sb.s_gid;
 	inode->i_blocks = inode->i_blksize = 0;
+	inode->u.generic_ip = kmem_cache_alloc(isofs_cachep, SLAB_KERNEL);
 
 
-	inode->u.isofs_i.i_section_size = isonum_733 (de->size);
+	ISOFS_I(inode)->i_section_size = isonum_733 (de->size);
 	if(de->flags[-high_sierra] & 0x80) {
 		if(isofs_read_level3_size(inode)) goto fail;
 	} else {
@@ -1230,7 +1236,7 @@
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
 		iso_date(de->date, high_sierra);
 
-	inode->u.isofs_i.i_first_extent = (isonum_733 (de->extent) +
+	ISOFS_I(inode)->i_first_extent = (isonum_733 (de->extent) +
 					   isonum_711 (de->ext_attr_length));
 
 	/*
@@ -1298,6 +1304,16 @@
 	goto out;
 }
 
+
+static void isofs_clear_inode(struct inode *inode)
+{
+	struct iso_inode_info *isofsi = ISOFS_I(inode);
+	inode->u.generic_ip = NULL;
+	if(isofsi)
+		kmem_cache_free(isofs_cachep, isofsi);
+}
+
+
 #ifdef LEAK_CHECK
 #undef malloc
 #undef free_s
@@ -1332,12 +1348,21 @@
 
 static int __init init_iso9660_fs(void)
 {
+	isofs_cachep = kmem_cache_create("isofs_inodes",
+					 sizeof(struct iso_inode_info),
+					 0, SLAB_HWCACHE_ALIGN,
+					 NULL, NULL);
+	if(isofs_cachep == NULL)
+		return -ENOMEM;
+
         return register_filesystem(&iso9660_fs_type);
 }
 
 static void __exit exit_iso9660_fs(void)
 {
         unregister_filesystem(&iso9660_fs_type);
+	if(kmem_cache_destroy(isofs_cachep))
+		printk(KERN_INFO "isofs_inodes: not all structures were freed\n");
 }
 
 EXPORT_NO_SYMBOLS;
Index: fs/isofs/namei.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/fs/isofs/namei.c,v
retrieving revision 1.1.1.10
diff -d -u -r1.1.1.10 namei.c
--- fs/isofs/namei.c	2001/02/21 14:46:02	1.1.1.10
+++ fs/isofs/namei.c	2001/04/24 13:13:29
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/iso_fs.h>
+#include <linux/iso_fs_i.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/stat.h>
@@ -65,7 +66,7 @@
 	unsigned int block, f_pos, offset;
 	struct buffer_head * bh = NULL;
 
-	if (!dir->u.isofs_i.i_first_extent)
+	if (!ISOFS_I(dir)->i_first_extent)
 		return 0;
   
 	f_pos = 0;
Index: fs/isofs/rock.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/fs/isofs/rock.c,v
retrieving revision 1.1.1.53
diff -d -u -r1.1.1.53 rock.c
--- fs/isofs/rock.c	2001/04/21 21:24:00	1.1.1.53
+++ fs/isofs/rock.c	2001/04/24 13:13:29
@@ -9,6 +9,7 @@
 #include <linux/stat.h>
 #include <linux/sched.h>
 #include <linux/iso_fs.h>
+#include <linux/iso_fs_i.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
@@ -349,9 +350,9 @@
 	printk(KERN_WARNING "Attempt to read inode for relocated directory\n");
 	goto out;
       case SIG('C','L'):
-	inode->u.isofs_i.i_first_extent = isonum_733(rr->u.CL.location);
+	ISOFS_I(inode)->i_first_extent = isonum_733(rr->u.CL.location);
 	reloc = iget(inode->i_sb,
-		     (inode->u.isofs_i.i_first_extent <<
+		     (ISOFS_I(inode)->i_first_extent <<
 		      inode -> i_sb -> u.isofs_sb.s_log_zone_size));
 	if (!reloc)
 		goto out;
Index: fs/proc/base.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/fs/proc/base.c,v
retrieving revision 1.1.1.7
diff -d -u -r1.1.1.7 base.c
--- fs/proc/base.c	2001/04/08 21:51:17	1.1.1.7
+++ fs/proc/base.c	2001/04/24 13:13:29
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
+#include <linux/proc_fs_i.h>
 #include <linux/stat.h>
 #include <linux/init.h>
 #include <linux/file.h>
@@ -42,9 +43,9 @@
 
 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {
-	if (inode->u.proc_i.file) {
-		*mnt = mntget(inode->u.proc_i.file->f_vfsmnt);
-		*dentry = dget(inode->u.proc_i.file->f_dentry);
+	if (PROCFS_I(inode)->file) {
+		*mnt = mntget(PROCFS_I(inode)->file->f_vfsmnt);
+		*dentry = dget(PROCFS_I(inode)->file->f_dentry);
 		return 0;
 	}
 	return -ENOENT;
@@ -55,7 +56,7 @@
 	struct mm_struct * mm;
 	struct vm_area_struct * vma;
 	int result = -ENOENT;
-	struct task_struct *task = inode->u.proc_i.task;
+	struct task_struct *task = PROCFS_I(inode)->task;
 
 	task_lock(task);
 	mm = task->mm;
@@ -86,11 +87,11 @@
 {
 	struct fs_struct *fs;
 	int result = -ENOENT;
-	task_lock(inode->u.proc_i.task);
-	fs = inode->u.proc_i.task->fs;
+	task_lock(PROCFS_I(inode)->task);
+	fs = PROCFS_I(inode)->task->fs;
 	if(fs)
 		atomic_inc(&fs->count);
-	task_unlock(inode->u.proc_i.task);
+	task_unlock(PROCFS_I(inode)->task);
 	if (fs) {
 		read_lock(&fs->lock);
 		*mnt = mntget(fs->pwdmnt);
@@ -106,11 +107,11 @@
 {
 	struct fs_struct *fs;
 	int result = -ENOENT;
-	task_lock(inode->u.proc_i.task);
-	fs = inode->u.proc_i.task->fs;
+	task_lock(PROCFS_I(inode)->task);
+	fs = PROCFS_I(inode)->task->fs;
 	if(fs)
 		atomic_inc(&fs->count);
-	task_unlock(inode->u.proc_i.task);
+	task_unlock(PROCFS_I(inode)->task);
 	if (fs) {
 		read_lock(&fs->lock);
 		*mnt = mntget(fs->rootmnt);
@@ -258,7 +259,7 @@
 			      size_t count, loff_t *ppos)
 {
 	struct inode * inode = file->f_dentry->d_inode;
-	struct task_struct *task = inode->u.proc_i.task;
+	struct task_struct *task = PROCFS_I(inode)->task;
 	ssize_t res;
 
 	res = proc_pid_read_maps(task, file, buf, count, ppos);
@@ -278,14 +279,14 @@
 	unsigned long page;
 	ssize_t length;
 	ssize_t end;
-	struct task_struct *task = inode->u.proc_i.task;
+	struct task_struct *task = PROCFS_I(inode)->task;
 
 	if (count > PROC_BLOCK_SIZE)
 		count = PROC_BLOCK_SIZE;
 	if (!(page = __get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
 
-	length = inode->u.proc_i.op.proc_read(task, (char*)page);
+	length = PROCFS_I(inode)->op.proc_read(task, (char*)page);
 
 	if (length < 0) {
 		free_page(page);
@@ -315,7 +316,7 @@
 static ssize_t mem_read(struct file * file, char * buf,
 			size_t count, loff_t *ppos)
 {
-	struct task_struct *task = file->f_dentry->d_inode->u.proc_i.task;
+	struct task_struct *task = PROCFS_I(file->f_dentry->d_inode)->task;
 	char *page;
 	unsigned long src = *ppos;
 	int copied = 0;
@@ -360,7 +361,7 @@
 {
 	int copied = 0;
 	char *page;
-	struct task_struct *task = file->f_dentry->d_inode->u.proc_i.task;
+	struct task_struct *task = PROCFS_I(file->f_dentry->d_inode)->.task;
 	unsigned long dst = *ppos;
 
 	if (!MAY_PTRACE(task))
@@ -418,7 +419,7 @@
 	if (error)
 		goto out;
 
-	error = inode->u.proc_i.op.proc_get_link(inode, &nd->dentry, &nd->mnt);
+	error = PROCFS_I(inode)->op.proc_get_link(inode, &nd->dentry, &nd->mnt);
 	nd->last_type = LAST_BIND;
 out:
 	return error;
@@ -458,7 +459,7 @@
 	if (error)
 		goto out;
 
-	error = inode->u.proc_i.op.proc_get_link(inode, &de, &mnt);
+	error = PROCFS_I(inode)->op.proc_get_link(inode, &de, &mnt);
 	if (error)
 		goto out;
 
@@ -523,7 +524,7 @@
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
 {
 	struct inode *inode = filp->f_dentry->d_inode;
-	struct task_struct *p = inode->u.proc_i.task;
+	struct task_struct *p = PROCFS_I(inode)->task;
 	unsigned int fd, pid, ino;
 	int retval;
 	char buf[NUMBUF];
@@ -585,8 +586,8 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	struct pid_entry *p;
 
-	pid = inode->u.proc_i.task->pid;
-	if (!inode->u.proc_i.task->p_pptr)
+	pid = PROCFS_I(inode)->task->pid;
+	if (!PROCFS_I(inode)->task->p_pptr)
 		return -ENOENT;
 	i = filp->f_pos;
 	switch (i) {
@@ -632,14 +633,16 @@
 
 	/* Common stuff */
 
+	
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_ino = fake_ino(task->pid, ino);
+	inode->u.generic_ip = kmem_cache_alloc(proc_cachep, SLAB_KERNEL);
 
-	inode->u.proc_i.file = NULL;
+	PROCFS_I(inode)->file = NULL;
 	/*
 	 * grab the reference to task.
 	 */
-	inode->u.proc_i.task = task;
+	PROCFS_I(inode)->task = task;
 	get_task_struct(task);
 	if (!task->p_pptr)
 		goto out_unlock;
@@ -673,7 +676,7 @@
  */
 static int pid_base_revalidate(struct dentry * dentry, int flags)
 {
-	if (dentry->d_inode->u.proc_i.task->p_pptr)
+	if (PROCFS_I(dentry->d_inode)->task->p_pptr)
 		return 1;
 	d_drop(dentry);
 	return 0;
@@ -707,7 +710,7 @@
 static struct dentry *proc_lookupfd(struct inode * dir, struct dentry * dentry)
 {
 	unsigned int fd, c;
-	struct task_struct *task = dir->u.proc_i.task;
+	struct task_struct *task = PROCFS_I(dir)->task;
 	struct file * file;
 	struct files_struct * files;
 	struct inode *inode;
@@ -740,7 +743,7 @@
 	if (!files)
 		goto out_unlock;
 	read_lock(&files->file_lock);
-	file = inode->u.proc_i.file = fcheck_files(files, fd);
+	file = PROCFS_I(inode)->file = fcheck_files(files, fd);
 	if (!file)
 		goto out_unlock2;
 	get_file(file);
@@ -749,7 +752,7 @@
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
 	inode->i_mode = S_IFLNK;
-	inode->u.proc_i.op.proc_get_link = proc_fd_link;
+	PROCFS_I(inode)->op.proc_get_link = proc_fd_link;
 	if (file->f_mode & 1)
 		inode->i_mode |= S_IRUSR | S_IXUSR;
 	if (file->f_mode & 2)
@@ -784,7 +787,7 @@
 {
 	struct inode *inode;
 	int error;
-	struct task_struct *task = dir->u.proc_i.task;
+	struct task_struct *task = PROCFS_I(dir)->task;
 	struct pid_entry *p;
 
 	error = -ENOENT;
@@ -817,35 +820,35 @@
 			break;
 		case PROC_PID_EXE:
 			inode->i_op = &proc_pid_link_inode_operations;
-			inode->u.proc_i.op.proc_get_link = proc_exe_link;
+			PROCFS_I(inode)->op.proc_get_link = proc_exe_link;
 			break;
 		case PROC_PID_CWD:
 			inode->i_op = &proc_pid_link_inode_operations;
-			inode->u.proc_i.op.proc_get_link = proc_cwd_link;
+			PROCFS_I(inode)->op.proc_get_link = proc_cwd_link;
 			break;
 		case PROC_PID_ROOT:
 			inode->i_op = &proc_pid_link_inode_operations;
-			inode->u.proc_i.op.proc_get_link = proc_root_link;
+			PROCFS_I(inode)->op.proc_get_link = proc_root_link;
 			break;
 		case PROC_PID_ENVIRON:
 			inode->i_fop = &proc_info_file_operations;
-			inode->u.proc_i.op.proc_read = proc_pid_environ;
+			PROCFS_I(inode)->op.proc_read = proc_pid_environ;
 			break;
 		case PROC_PID_STATUS:
 			inode->i_fop = &proc_info_file_operations;
-			inode->u.proc_i.op.proc_read = proc_pid_status;
+			PROCFS_I(inode)->op.proc_read = proc_pid_status;
 			break;
 		case PROC_PID_STAT:
 			inode->i_fop = &proc_info_file_operations;
-			inode->u.proc_i.op.proc_read = proc_pid_stat;
+			PROCFS_I(inode)->op.proc_read = proc_pid_stat;
 			break;
 		case PROC_PID_CMDLINE:
 			inode->i_fop = &proc_info_file_operations;
-			inode->u.proc_i.op.proc_read = proc_pid_cmdline;
+			PROCFS_I(inode)->op.proc_read = proc_pid_cmdline;
 			break;
 		case PROC_PID_STATM:
 			inode->i_fop = &proc_info_file_operations;
-			inode->u.proc_i.op.proc_read = proc_pid_statm;
+			PROCFS_I(inode)->op.proc_read = proc_pid_statm;
 			break;
 		case PROC_PID_MAPS:
 			inode->i_fop = &proc_maps_operations;
@@ -853,7 +856,7 @@
 #ifdef CONFIG_SMP
 		case PROC_PID_CPU:
 			inode->i_fop = &proc_info_file_operations;
-			inode->u.proc_i.op.proc_read = proc_pid_cpu;
+			PROCFS_I(inode)->op.proc_read = proc_pid_cpu;
 			break;
 #endif
 		case PROC_PID_MEM:
@@ -920,9 +923,10 @@
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
 		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+		inode->u.generic_ip = kmem_cache_alloc(proc_cachep, SLAB_KERNEL);
 		inode->i_ino = fake_ino(0, PROC_PID_INO);
-		inode->u.proc_i.file = NULL;
-		inode->u.proc_i.task = NULL;
+		PROCFS_I(inode)->file = NULL;
+		PROCFS_I(inode)->task = NULL;
 		inode->i_mode = S_IFLNK|S_IRWXUGO;
 		inode->i_uid = inode->i_gid = 0;
 		inode->i_size = 64;
@@ -972,10 +976,10 @@
 
 void proc_pid_delete_inode(struct inode *inode)
 {
-	if (inode->u.proc_i.file)
-		fput(inode->u.proc_i.file);
-	if (inode->u.proc_i.task)
-		free_task_struct(inode->u.proc_i.task);
+	if (PROCFS_I(inode)->file)
+		fput(PROCFS_I(inode)->file);
+	if (PROCFS_I(inode)->task)
+		free_task_struct(PROCFS_I(inode)->task);
 }
 
 #define PROC_NUMBUF 10
Index: fs/proc/generic.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/fs/proc/generic.c,v
retrieving revision 1.1.1.24
diff -d -u -r1.1.1.24 generic.c
--- fs/proc/generic.c	2001/04/21 21:23:54	1.1.1.24
+++ fs/proc/generic.c	2001/04/24 13:13:29
@@ -445,6 +445,9 @@
 	const char *fn = name;
 	int len;
 
+	if (! (S_ISCHR(mode) || S_ISBLK(mode)))
+		BUG();
+
 	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
 		goto out;
 	len = strlen(fn);
Index: fs/proc/inode.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/fs/proc/inode.c,v
retrieving revision 1.1.1.7
diff -d -u -r1.1.1.7 inode.c
--- fs/proc/inode.c	2001/04/21 15:05:27	1.1.1.7
+++ fs/proc/inode.c	2001/04/24 13:13:29
@@ -80,6 +80,14 @@
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 }
 
+static void proc_clear_inode(struct inode *inode)
+{
+	struct proc_inode_info *proci = PROCFS_I(inode);
+	inode->u.generic_ip = NULL;
+	if (proci)
+		kmem_cache_free(proc_cachep, proci);
+}
+
 static int proc_statfs(struct super_block *sb, struct statfs *buf)
 {
 	buf->f_type = PROC_SUPER_MAGIC;
@@ -93,6 +101,7 @@
 
 static struct super_operations proc_sops = { 
 	read_inode:	proc_read_inode,
+	clear_inode:    proc_clear_inode,
 	put_inode:	force_delete,
 	delete_inode:	proc_delete_inode,
 	statfs:		proc_statfs,
Index: fs/proc/procfs_syms.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/fs/proc/procfs_syms.c,v
retrieving revision 1.1.1.12
diff -d -u -r1.1.1.12 procfs_syms.c
--- fs/proc/procfs_syms.c	2001/04/21 21:23:54	1.1.1.12
+++ fs/proc/procfs_syms.c	2001/04/24 13:13:29
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
+#include <linux/proc_fs_i.h>
 #include <linux/init.h>
 
 extern struct proc_dir_entry *proc_sys_root;
@@ -21,18 +22,37 @@
 EXPORT_SYMBOL(proc_root_driver);
 
 static DECLARE_FSTYPE(proc_fs_type, "proc", proc_read_super, FS_SINGLE);
+kmem_cache_t *proc_cachep;
 
 static int __init init_proc_fs(void)
 {
-	int err = register_filesystem(&proc_fs_type);
-	if (!err) {
-		proc_mnt = kern_mount(&proc_fs_type);
-		err = PTR_ERR(proc_mnt);
-		if (IS_ERR(proc_mnt))
-			unregister_filesystem(&proc_fs_type);
-		else
-			err = 0;
+	int err;
+
+	proc_cachep = kmem_cache_create("proc_inodes",
+					sizeof(struct proc_inode_info),
+					0, SLAB_HWCACHE_ALIGN,
+					NULL, NULL);
+
+	if (proc_cachep == NULL)
+		return -ENOMEM;
+
+	err = register_filesystem(&proc_fs_type);
+	if(err)
+		goto badproc;
+		
+	proc_mnt = kern_mount(&proc_fs_type);
+	err = PTR_ERR(proc_mnt);
+	if (IS_ERR(proc_mnt)) {
+		unregister_filesystem(&proc_fs_type);
+		goto badproc;
 	}
+
+	return 0;
+
+badproc:
+	if (kmem_cache_destroy(proc_cachep))
+		printk(KERN_INFO "proc_inodes: not all structures were freed\n");
+
 	return err;
 }
 
@@ -40,6 +60,8 @@
 {
 	unregister_filesystem(&proc_fs_type);
 	kern_umount(proc_mnt);
+	if (kmem_cache_destroy(proc_cachep))
+		printk(KERN_INFO "proc_inodes: not all structures were freed\n");
 }
 
 module_init(init_proc_fs)
Index: include/linux/fs.h
===================================================================
RCS file: /home/erik/cvsroot/elinux/include/linux/fs.h,v
retrieving revision 1.1.1.44
diff -d -u -r1.1.1.44 fs.h
--- include/linux/fs.h	2001/04/21 21:37:02	1.1.1.44
+++ include/linux/fs.h	2001/04/24 13:13:29
@@ -283,7 +283,6 @@
 #include <linux/ntfs_fs_i.h>
 #include <linux/msdos_fs_i.h>
 #include <linux/umsdos_fs_i.h>
-#include <linux/iso_fs_i.h>
 #include <linux/nfs_fs_i.h>
 #include <linux/sysv_fs_i.h>
 #include <linux/affs_fs_i.h>
@@ -300,7 +299,6 @@
 #include <linux/bfs_fs_i.h>
 #include <linux/udf_fs_i.h>
 #include <linux/ncp_fs_i.h>
-#include <linux/proc_fs_i.h>
 #include <linux/usbdev_fs_i.h>
 
 /*
@@ -447,7 +445,6 @@
 		struct ntfs_inode_info		ntfs_i;
 		struct msdos_inode_info		msdos_i;
 		struct umsdos_inode_info	umsdos_i;
-		struct iso_inode_info		isofs_i;
 		struct nfs_inode_info		nfs_i;
 		struct sysv_inode_info		sysv_i;
 		struct affs_inode_info		affs_i;
@@ -464,7 +461,6 @@
 		struct bfs_inode_info		bfs_i;
 		struct udf_inode_info		udf_i;
 		struct ncp_inode_info		ncpfs_i;
-		struct proc_inode_info		proc_i;
 		struct socket			socket_i;
 		struct usbdev_inode_info        usbdev_i;
 		void				*generic_ip;
Index: include/linux/iso_fs.h
===================================================================
RCS file: /home/erik/cvsroot/elinux/include/linux/iso_fs.h,v
retrieving revision 1.1.1.9
diff -d -u -r1.1.1.9 iso_fs.h
--- include/linux/iso_fs.h	2001/01/02 15:20:04	1.1.1.9
+++ include/linux/iso_fs.h	2001/04/24 13:13:29
@@ -203,6 +203,11 @@
 extern void leak_check_brelse(struct buffer_head * bh);
 #endif /* LEAK_CHECK */
 
+static inline struct iso_inode_info *ISOFS_I(struct inode *inode)
+{
+	return (struct iso_inode_info *)inode->u.generic_ip;
+}
+
 #endif /* __KERNEL__ */
 
 #endif
Index: include/linux/proc_fs.h
===================================================================
RCS file: /home/erik/cvsroot/elinux/include/linux/proc_fs.h,v
retrieving revision 1.1.1.15
diff -d -u -r1.1.1.15 proc_fs.h
--- include/linux/proc_fs.h	2001/04/21 21:37:36	1.1.1.15
+++ include/linux/proc_fs.h	2001/04/24 13:13:29
@@ -83,6 +83,8 @@
 extern struct proc_dir_entry *proc_root_driver;
 extern struct proc_dir_entry *proc_root_kcore;
 
+extern kmem_cache_t *proc_cachep;
+
 extern void proc_root_init(void);
 extern void proc_misc_init(void);
 
@@ -162,6 +164,11 @@
 static inline void proc_net_remove(const char *name)
 {
 	remove_proc_entry(name,proc_net);
+}
+
+static inline struct proc_inode_info *PROCFS_I(struct inode * inode)
+{
+	return (struct proc_inode_info *)inode->u.generic_ip;
 }
 
 #else


-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
