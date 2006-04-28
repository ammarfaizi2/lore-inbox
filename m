Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWD1RhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWD1RhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWD1RhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:37:07 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:59858 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751422AbWD1RhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:37:05 -0400
Date: Fri, 28 Apr 2006 19:37:08 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: akpm@osdl.org
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-Id: <20060428193708.5853da36.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here the patch with the bugfixes for your and Pekka's comments:

- move some globals into the superblock
- remove some inlines
- fix some error handling functions
- implement diag204_get_buffer() helper function
- "hypfs" prefix for global functions
- use uid_t and gid_t
- use kstrdup()
- Cosmetics

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>

---

 arch/s390/Kconfig            |    2
 arch/s390/hypfs/hypfs_diag.c |  127 +++++++++++++++++++++++++++----------------
 arch/s390/hypfs/hypfs_diag.h |    6 +-
 arch/s390/hypfs/inode.c      |  107 ++++++++++++++++++++----------------
 4 files changed, 145 insertions(+), 97 deletions(-)

diff -urpN linux-2.6.16-hypfs-2006-04-28/arch/s390/Kconfig linux-2.6.16-hypfs-2006-04-28-FIXED/arch/s390/Kconfig
--- linux-2.6.16-hypfs-2006-04-28/arch/s390/Kconfig	2006-04-28 19:16:56.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-FIXED/arch/s390/Kconfig	2006-04-28 19:17:37.000000000 +0200
@@ -447,7 +447,7 @@ config HYPFS_FS
 	default y
 	help
 	  This is a virtual file system intended to provide accounting
-	  information in a s390 hypervisor environment.
+	  information in an s390 hypervisor environment.
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
diff -urpN linux-2.6.16-hypfs-2006-04-28/arch/s390/hypfs/hypfs_diag.c linux-2.6.16-hypfs-2006-04-28-FIXED/arch/s390/hypfs/hypfs_diag.c
--- linux-2.6.16-hypfs-2006-04-28/arch/s390/hypfs/hypfs_diag.c	2006-04-28 19:16:56.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-FIXED/arch/s390/hypfs/hypfs_diag.c	2006-04-28 19:17:51.000000000 +0200
@@ -322,7 +322,7 @@ static inline __u64 phys_cpu__ctidx(enum
 
 /* Diagnose 204 functions */
 
-static inline int diag204(unsigned long subcode, unsigned long size, void *addr)
+static int diag204(unsigned long subcode, unsigned long size, void *addr)
 {
 	register unsigned long _subcode asm("0") = subcode;
 	register unsigned long _size asm("1") = size;
@@ -345,6 +345,25 @@ static inline int diag204(unsigned long 
 		return _size;
 }
 
+static void *diag204_get_buffer(enum diag204_format fmt, int *pages)
+{
+	void *buf;
+
+	if (fmt == INFO_SIMPLE)
+		*pages = 1;
+	else
+		*pages = diag204(SUBC_RSI | fmt, 0, 0);
+
+	if (*pages <= 0)
+		return ERR_PTR(-ENOSYS);
+
+	buf = kmalloc(*pages * PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	return buf;
+}
+
 /* 
  * diag204_probe() has to find out, which type of diagnose 204 implementation
  * we have on our machine. Currently there are three possible scanarios:
@@ -364,13 +383,14 @@ static int diag204_probe(void)
 	void *buf;
 	int pages, rc;
 
-	pages = diag204(SUBC_RSI | INFO_EXT, 0, 0);
-	if (pages > 0) {
-		buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL);
-		if (!buf) {
-			rc = -ENOMEM;
-			goto err_out;
-		}
+	/*
+	 * We first try to get the number of pages needed to store the extended
+	 * data format. If this already fails, our machine does not support
+	 * subcode 6 and 7. We then continue checking for subcode 4.
+	 */
+
+	buf = diag204_get_buffer(INFO_EXT, &pages);
+	if (!IS_ERR(buf)) {
 		if (diag204(SUBC_STIB7 | INFO_EXT, pages, buf) >= 0) {
 			diag204_store_sc = SUBC_STIB7;
 			diag204_info_type = INFO_EXT;
@@ -382,10 +402,19 @@ static int diag204_probe(void)
 			goto out;
 		}
 		kfree(buf);
+	} else if (PTR_ERR(buf) != -ENOSYS) {
+		/* other error than 'not implemented'. Give up! */
+		return PTR_ERR(buf);
 	}
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!buf) {
-		rc = -ENOMEM;
+
+	/*
+	 * subcode 6 and 7 did not work. Now try subcode 4 with the simple
+	 * data format.
+	 */
+
+	buf = diag204_get_buffer(INFO_SIMPLE, &pages);
+	if (IS_ERR(buf)) {
+		rc = PTR_ERR(buf);
 		goto err_out;
 	}
 	if (diag204(SUBC_STIB4 | INFO_SIMPLE, pages, buf) >= 0) {
@@ -396,9 +425,9 @@ static int diag204_probe(void)
 		rc = -ENOSYS;
 		goto err_out;
 	}
-      out:
+out:
 	rc = 0;
-      err_out:
+err_out:
 	kfree(buf);
 	return rc;
 }
@@ -408,34 +437,26 @@ static void *diag204_store(void)
 	void *buf;
 	int pages;
 
-	if (diag204_store_sc == SUBC_STIB4)
-		pages = 1;
-	else
-		pages = diag204(SUBC_RSI | diag204_info_type, 0, 0);
-
-	if (pages < 0)
-		return ERR_PTR(-ENOSYS);
-
-	buf = kmalloc(pages * PAGE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return ERR_PTR(-ENOMEM);
-
+	buf = diag204_get_buffer(diag204_info_type, &pages);
+	if (IS_ERR(buf))
+		goto out;
 	if (diag204(diag204_store_sc | diag204_info_type, pages, buf) < 0) {
 		kfree(buf);
 		return ERR_PTR(-ENOSYS);
 	}
+out:
 	return buf;
 }
 
 /* Diagnose 224 functions */
 
-static inline void diag224(void *ptr)
+static void diag224(void *ptr)
 {
 	asm volatile("   diag    %0,%1,0x224\n"
 		     : :"d" (0), "d"(ptr) : "memory");
 }
 
-static inline int diag224_get_name_table(void)
+static int diag224_get_name_table(void)
 {
 	/* memory must be below 2GB */
 	diag224_cpu_names = kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
@@ -446,7 +467,7 @@ static inline int diag224_get_name_table
 	return 0;
 }
 
-static inline void diag224_delete_name_table(void)
+static void diag224_delete_name_table(void)
 {
 	kfree(diag224_cpu_names);
 }
@@ -459,7 +480,7 @@ static int diag224_idx2name(int index, c
 	return 0;
 }
 
-int diag_init(void)
+__init int hypfs_diag_init(void)
 {
 	int rc;
 
@@ -475,7 +496,7 @@ int diag_init(void)
 	return rc;
 }
 
-void diag_exit(void)
+__exit void hypfs_diag_exit(void)
 {
 	diag224_delete_name_table();
 }
@@ -590,39 +611,51 @@ static void *hypfs_create_phys_files(str
 	return cpu_info;
 }
 
-int diag_create_files(struct super_block *sb, struct dentry *root)
+int hypfs_diag_create_files(struct super_block *sb, struct dentry *root)
 {
 	struct dentry *systems_dir, *hyp_dir;
 	void *time_hdr, *part_hdr;
-	int i;
-	void *buffer, *rc;
+	int i, rc;
+	void *buffer, *ptr;
 
 	buffer = diag204_store();
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
 	systems_dir = hypfs_mkdir(sb, root, "systems");
-	if (IS_ERR(systems_dir))
-		return PTR_ERR(systems_dir);
+	if (IS_ERR(systems_dir)) {
+		rc = PTR_ERR(systems_dir);
+		goto err_out;
+	}
 	time_hdr = (struct x_info_blk_hdr *)buffer;
 	part_hdr = time_hdr + info_blk_hdr__size(diag204_info_type);
 	for (i = 0; i < info_blk_hdr__npar(diag204_info_type, time_hdr); i++) {
 		part_hdr = hypfs_create_lpar_files(sb, systems_dir, part_hdr);
-		if (IS_ERR(part_hdr))
-			return PTR_ERR(part_hdr);
+		if (IS_ERR(part_hdr)) {
+			rc = PTR_ERR(part_hdr);
+			goto err_out;
+		}
 	}
 	if (info_blk_hdr__flags(diag204_info_type, time_hdr) & LPAR_PHYS_FLG) {
-		void *rc;
-		rc = hypfs_create_phys_files(sb, root, part_hdr);
-		if (IS_ERR(rc))
-			return PTR_ERR(rc);
+		ptr = hypfs_create_phys_files(sb, root, part_hdr);
+		if (IS_ERR(ptr)) {
+			rc = PTR_ERR(ptr);
+			goto err_out;
+		}
 	}
 	hyp_dir = hypfs_mkdir(sb, root, "hyp");
-	if (IS_ERR(hyp_dir))
-		return PTR_ERR(hyp_dir);
-	rc = hypfs_create_str(sb, hyp_dir, "type", "LPAR Hypervisor");
-	if (IS_ERR(rc))
-		return PTR_ERR(rc);
+	if (IS_ERR(hyp_dir)) {
+		rc = PTR_ERR(hyp_dir);
+		goto err_out;
+	}
+	ptr = hypfs_create_str(sb, hyp_dir, "type", "LPAR Hypervisor");
+	if (IS_ERR(ptr)) {
+		rc = PTR_ERR(ptr);
+		goto err_out;
+	}
+	rc = 0;
+
+err_out:
 	kfree(buffer);
-	return 0;
+	return rc;
 }
diff -urpN linux-2.6.16-hypfs-2006-04-28/arch/s390/hypfs/hypfs_diag.h linux-2.6.16-hypfs-2006-04-28-FIXED/arch/s390/hypfs/hypfs_diag.h
--- linux-2.6.16-hypfs-2006-04-28/arch/s390/hypfs/hypfs_diag.h	2006-04-28 19:16:56.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-FIXED/arch/s390/hypfs/hypfs_diag.h	2006-04-28 19:17:51.000000000 +0200
@@ -9,8 +9,8 @@
 #ifndef _HYPFS_DIAG_H_
 #define _HYPFS_DIAG_H_
 
-extern int diag_init(void);
-extern void diag_exit(void);
-extern int diag_create_files(struct super_block *sb, struct dentry *root);
+extern int hypfs_diag_init(void);
+extern void hypfs_diag_exit(void);
+extern int hypfs_diag_create_files(struct super_block *sb, struct dentry *root);
 
 #endif /* _HYPFS_DIAG_H_ */
diff -urpN linux-2.6.16-hypfs-2006-04-28/arch/s390/hypfs/inode.c linux-2.6.16-hypfs-2006-04-28-FIXED/arch/s390/hypfs/inode.c
--- linux-2.6.16-hypfs-2006-04-28/arch/s390/hypfs/inode.c	2006-04-28 19:16:56.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-FIXED/arch/s390/hypfs/inode.c	2006-04-28 19:17:51.000000000 +0200
@@ -28,25 +28,26 @@ static struct dentry *hypfs_create_updat
 					       struct dentry *dir);
 
 struct hypfs_sb_info {
-	int uid;		/* uid used for files and dirs */
-	int gid;		/* gid used for files and dirs */
+	uid_t uid;			/* uid used for files and dirs */
+	gid_t gid;			/* gid used for files and dirs */
+	struct dentry *update_file;	/* file to trigger update */
+	time_t last_update;		/* last update time in secs since 1970 */
+	struct mutex lock;		/* lock to protect update process */
 };
 
-static struct dentry *update_file_dentry;
 static struct file_operations hypfs_file_ops;
 static struct file_system_type hypfs_type;
 static struct super_operations hypfs_s_ops;
-static time_t last_update_time = 0;	/* update time in seconds since 1970 */
-static DEFINE_MUTEX(hypfs_lock);
 
 /* start of list of all dentries, which have to be deleted on update */
 static struct dentry *hypfs_last_dentry;
 
-static void hypfs_update_update(void)
+static void hypfs_update_update(struct super_block *sb)
 {
-	struct inode* inode = update_file_dentry->d_inode;
+	struct hypfs_sb_info *sb_info = sb->s_fs_info;
+	struct inode *inode = sb_info->update_file->d_inode;
 	
-	last_update_time = get_seconds();
+	sb_info->last_update = get_seconds();
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 }
 
@@ -103,7 +104,8 @@ static void hypfs_drop_inode(struct inod
 
 static int hypfs_open(struct inode *inode, struct file *filp)
 {
-	char *data = (char *)filp->f_dentry->d_inode->u.generic_ip;
+	char *data = filp->f_dentry->d_inode->u.generic_ip;
+	struct hypfs_sb_info *fs_info;
 
 	if (filp->f_mode & FMODE_WRITE) {
 		if (!(inode->i_mode & S_IWUGO))
@@ -113,14 +115,17 @@ static int hypfs_open(struct inode *inod
 		if (!(inode->i_mode & S_IRUGO))
 			return -EACCES;
 	}
-	mutex_lock(&hypfs_lock);
-	filp->private_data = kmalloc(strlen(data) + 1, GFP_KERNEL);
-	if (!filp->private_data) {
-		mutex_unlock(&hypfs_lock);
-		return -ENOMEM;
+
+	fs_info = inode->i_sb->s_fs_info;
+	if(data) {
+		mutex_lock(&fs_info->lock);
+		filp->private_data = kstrdup(data, GFP_KERNEL);
+		if (!filp->private_data) {
+			mutex_unlock(&fs_info->lock);
+			return -ENOMEM;
+		}
+		mutex_unlock(&fs_info->lock);
 	}
-	strcpy(filp->private_data, data);
-	mutex_unlock(&hypfs_lock);
 	return 0;
 }
 
@@ -131,7 +136,7 @@ static ssize_t hypfs_aio_read(struct kio
 	size_t len;
 	struct file *filp = iocb->ki_filp;
 
-	data = (char *)filp->private_data;
+	data = filp->private_data;
 	len = strlen(data);
 	if (offset > len) {
 		count = 0;
@@ -145,7 +150,7 @@ static ssize_t hypfs_aio_read(struct kio
 	}
 	iocb->ki_pos += count;
 	file_accessed(filp);
-      out:
+out:
 	return count;
 }
 static ssize_t hypfs_aio_write(struct kiocb *iocb, const char __user *buf,
@@ -153,24 +158,36 @@ static ssize_t hypfs_aio_write(struct ki
 {
 	int rc;
 	struct super_block *sb;
+	struct hypfs_sb_info *fs_info;
 
-	mutex_lock(&hypfs_lock);
 	sb = iocb->ki_filp->f_dentry->d_inode->i_sb;
-	if (last_update_time == get_seconds()) {
+	fs_info = sb->s_fs_info;
+	/*
+	 * Currently we only allow one update per second for two reasons:
+	 * 1. diag 204 is VERY expensive
+	 * 2. If several processes do updates in parallel and then read the
+	 *    hypfs data, the likelihood of collisions is reduced, if we restrict
+	 *    the minimum update interval. A collision occurs, if during the
+	 *    data gathering of one process another process triggers an update
+	 *    If the first process wants to ensure consistent data, it has
+	 *    to restart data collection in this case.
+	 */
+	mutex_lock(&fs_info->lock);
+	if (fs_info->last_update == get_seconds()) {
 		rc = -EBUSY;
 		goto out;
 	}
 	hypfs_delete_tree(sb->s_root);
-	rc = diag_create_files(sb, sb->s_root);
+	rc = hypfs_diag_create_files(sb, sb->s_root);
 	if (rc) {
 		printk(KERN_ERR "hypfs: Update failed\n");
 		hypfs_delete_tree(sb->s_root);
 		goto out;
 	}
-	hypfs_update_update();
+	hypfs_update_update(sb);
 	rc = count;
-      out:
-	mutex_unlock(&hypfs_lock);
+out:
+	mutex_unlock(&fs_info->lock);
 	return rc;
 }
 
@@ -229,9 +246,10 @@ static int hypfs_fill_super(struct super
 	int rc = 0;
 	struct hypfs_sb_info *sbi;
 
-	sbi = kmalloc(sizeof(struct hypfs_sb_info), GFP_KERNEL);
+	sbi = kzalloc(sizeof(struct hypfs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
+	mutex_init(&sbi->lock);
 	sbi->uid = current->uid;
 	sbi->gid = current->gid;
 	sb->s_fs_info = sbi;
@@ -255,23 +273,23 @@ static int hypfs_fill_super(struct super
 		rc = -ENOMEM;
 		goto err_inode;
 	}
-	rc = diag_create_files(sb, sb->s_root);
+	rc = hypfs_diag_create_files(sb, sb->s_root);
 	if (rc)
 		goto err_tree;
-	update_file_dentry = hypfs_create_update_file(sb, sb->s_root);
-	if (IS_ERR(update_file_dentry)) {
-		rc = PTR_ERR(update_file_dentry);
+	sbi->update_file = hypfs_create_update_file(sb, sb->s_root);
+	if (IS_ERR(sbi->update_file)) {
+		rc = PTR_ERR(sbi->update_file);
 		goto err_tree;
 	}
-	hypfs_update_update();
+	hypfs_update_update(sb);
 	return 0;
 
-      err_tree:
+err_tree:
 	hypfs_delete_tree(sb->s_root);
 	dput(sb->s_root);
-      err_inode:
+err_inode:
 	iput(root_inode);
-      err_alloc:
+err_alloc:
 	kfree(sbi);
 	return rc;
 }
@@ -309,7 +327,7 @@ static struct dentry *hypfs_create_file(
 	}
 	if (mode & S_IFREG) {
 		inode->i_fop = &hypfs_file_ops;
-		if(data)
+		if (data)
 			inode->i_size = strlen(data);
 		else
 			inode->i_size = 0;
@@ -344,8 +362,6 @@ static struct dentry *hypfs_create_updat
 
 	dentry = hypfs_create_file(sb, dir, "update", NULL,
 				   S_IFREG | UPDATE_FILE_MODE);
-	if (!dentry)
-		return ERR_PTR(-ENOMEM);
 	/*
 	 * We do not put the update file on the 'delete' list with
 	 * hypfs_add_dentry(), since it should not be removed when the tree
@@ -362,13 +378,12 @@ struct dentry *hypfs_create_u64(struct s
 	struct dentry *dentry;
 
 	snprintf(tmp, TMP_SIZE, "%lld\n", (unsigned long long int)value);
-	buffer = kmalloc(strlen(tmp) + 1, GFP_KERNEL);
+	buffer = kstrdup(tmp, GFP_KERNEL);
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
-	strcpy(buffer, tmp);
 	dentry =
 	    hypfs_create_file(sb, dir, name, buffer, S_IFREG | REG_FILE_MODE);
-	if (!dentry) {
+	if (IS_ERR(dentry)) {
 		kfree(buffer);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -388,7 +403,7 @@ struct dentry *hypfs_create_str(struct s
 	sprintf(buffer, "%s\n", string);
 	dentry =
 	    hypfs_create_file(sb, dir, name, buffer, S_IFREG | REG_FILE_MODE);
-	if (!dentry) {
+	if (IS_ERR(dentry)) {
 		kfree(buffer);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -426,7 +441,7 @@ static int __init hypfs_init(void)
 
 	if (MACHINE_IS_VM)
 		return -ENODATA;
-	if (diag_init()) {
+	if (hypfs_diag_init()) {
 		rc = -ENODATA;
 		goto err_msg;
 	}
@@ -438,18 +453,18 @@ static int __init hypfs_init(void)
 		goto err_sysfs;
 	return 0;
 
-      err_sysfs:
+err_sysfs:
 	subsystem_unregister(&hypervisor_subsys);
-      err_diag:
-	diag_exit();
-      err_msg:
+err_diag:
+	hypfs_diag_exit();
+err_msg:
 	printk(KERN_ERR "hypfs: Initialization failed with rc = %i.\n", rc);
 	return rc;
 }
 
 static void __exit hypfs_exit(void)
 {
-	diag_exit();
+	hypfs_diag_exit();
 	unregister_filesystem(&hypfs_type);
 	subsystem_unregister(&hypervisor_subsys);
 }

