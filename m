Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135812AbRAMKot>; Sat, 13 Jan 2001 05:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136088AbRAMKok>; Sat, 13 Jan 2001 05:44:40 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:29091 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135812AbRAMKof>; Sat, 13 Jan 2001 05:44:35 -0500
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [Patch] make shm filesystem part configurable
From: Christoph Rohland <cr@sap.com>
Message-ID: <m366jj20si.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 13 Jan 2001 11:49:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The appended patch (additional to my read/write support patch) makes
the shm filesystem configurable and renames it to the more sensible
name swapfs. Since the fs type "shm" is quite established with 2.4 I
register that name also.

It also updates the documentation.

Greetings
                Christoph

diff -uNr 2.4.0-shm_vm_locked-truncate-rw/Documentation/Changes 2.4.0-shm_vm_locked-truncate-rw-swapfs/Documentation/Changes
--- 2.4.0-shm_vm_locked-truncate-rw/Documentation/Changes	Fri Jan  5 10:33:35 2001
+++ 2.4.0-shm_vm_locked-truncate-rw-swapfs/Documentation/Changes	Fri Jan 12 23:08:26 2001
@@ -114,20 +114,6 @@
 DevFS is now in the kernel.  See Documentation/filesystems/devfs/* in
 the kernel source tree for all the gory details.
 
-System V shared memory is now implemented via a virtual filesystem.
-You do not have to mount it to use it. SYSV shared memory limits are
-set via /proc/sys/kernel/shm{max,all,mni}.  You should mount the
-filesystem under /dev/shm to be able to use POSIX shared
-memory. Adding the following line to /etc/fstab should take care of
-things:
-
-none		/dev/shm	shm		defaults	0 0
-
-Remember to create the directory that you intend to mount shm on if
-necessary (The entry is automagically created if you use devfs). You
-can set limits for the number of blocks and inodes used by the
-filesystem with the mount options nr_blocks and nr_inodes.
-
 The Logical Volume Manager (LVM) is now in the kernel.  If you want to
 use this, you'll need to install the necessary LVM toolset.
 
diff -uNr 2.4.0-shm_vm_locked-truncate-rw/Documentation/Configure.help 2.4.0-shm_vm_locked-truncate-rw-swapfs/Documentation/Configure.help
--- 2.4.0-shm_vm_locked-truncate-rw/Documentation/Configure.help	Fri Jan  5 10:33:35 2001
+++ 2.4.0-shm_vm_locked-truncate-rw-swapfs/Documentation/Configure.help	Sat Jan 13 11:02:20 2001
@@ -2695,14 +2695,6 @@
   section 6.4 of the Linux Programmer's Guide, available from
   http://www.linuxdoc.org/docs.html#guide .
 
-  Shared memory is now implemented using a new (minimal) virtual file
-  system. To mount it automatically at system startup just add the
-  following line to your /etc/fstab:
-
-  none	/dev/shm	shm	defaults	0 0
-
-  Saying Y here enlarges your kernel by about 18 KB. Just say Y.
-
 BSD Process Accounting
 CONFIG_BSD_PROCESS_ACCT
   If you say Y here, a user level program will be able to instruct the
@@ -10830,23 +10822,41 @@
 
   If unsure, say N.
    
+Swap file system support
+CONFIG_SWAPFS
+  Swapfs is a file system which keeps all files in RAM and swap space.
+
+  In contrast to RAM disks, which get allocated a fixed amount of
+  physical RAM, swapfs grows and shrinks to accommodate the files it
+  contains and is able to swap unneeded pages out to swap space.
+
+  Everything is "virtual" in the sense that no files will be created
+  on your hard drive; if you reboot, everything in swapfs will be
+  lost.
+  
+  You should mount the filesystem under /dev/shm to be able to use
+  POSIX shared memory. Adding the following line to /etc/fstab should
+  take care of things:
+
+  swapfs	/dev/shm	swapfs		defaults	0 0
+
+  Remember to create the directory that you intend to mount swapfs on
+  if necessary (The entry is automagically created if you use devfs).
+
+  You can set limits for the number of blocks and inodes used by the
+  filesystem with the mount options "nr_blocks" and "nr_inodes". The
+  initial permissions of the root directory can be set with the mount
+  option "mode".
+
 Simple RAM-based file system support
 CONFIG_RAMFS
   Ramfs is a file system which keeps all files in RAM. It allows
   read and write access.
 
-  In contrast to RAM disks, which get allocated a fixed amount of RAM,
-  ramfs grows and shrinks to accommodate the files it contains.
+  It is more of an programming example than a useable filesystem. If
+  you need a file system which lives in RAM with limit checking use
+  swapfs.
 
-  Before you can use this RAM-based file system, it has to be mounted,
-  meaning it has to be given a location in the directory hierarchy. If
-  you want to use the location /ramfiles for example, you would have
-  to create that directory first and then mount the file system by
-  saying "mount -t ramfs ramfs /ramfiles" or the equivalent line in
-  /etc/fstab. Everything is "virtual" in the sense that no files will
-  be created on your hard drive; if you reboot, everything in
-  /ramfiles will be lost.
-  
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
   say M here and read Documentation/modules.txt. The module will be
diff -uNr 2.4.0-shm_vm_locked-truncate-rw/fs/Config.in 2.4.0-shm_vm_locked-truncate-rw-swapfs/fs/Config.in
--- 2.4.0-shm_vm_locked-truncate-rw/fs/Config.in	Thu Nov 30 21:46:55 2000
+++ 2.4.0-shm_vm_locked-truncate-rw-swapfs/fs/Config.in	Fri Jan 12 22:54:46 2001
@@ -29,6 +29,7 @@
 	int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
 fi
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
+bool 'Swap file system support (former shm fs)' CONFIG_SWAPFS
 tristate 'Simple RAM-based file system support' CONFIG_RAMFS
 
 tristate 'ISO 9660 CDROM file system support' CONFIG_ISO9660_FS
diff -uNr 2.4.0-shm_vm_locked-truncate-rw/mm/shmem.c 2.4.0-shm_vm_locked-truncate-rw-swapfs/mm/shmem.c
--- 2.4.0-shm_vm_locked-truncate-rw/mm/shmem.c	Sat Jan 13 11:25:55 2001
+++ 2.4.0-shm_vm_locked-truncate-rw-swapfs/mm/shmem.c	Sat Jan 13 11:29:25 2001
@@ -1,5 +1,5 @@
 /*
- * Resizable simple shmem filesystem for Linux.
+ * Resizable simple swap filesystem for Linux.
  *
  * Copyright (C) 2000 Linus Torvalds.
  *		 2000 Transmeta Corp.
@@ -28,7 +28,7 @@
 
 #include <asm/uaccess.h>
 
-#define SHMEM_MAGIC	0x01021994
+#define SWAPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
 #define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
@@ -370,6 +370,19 @@
 	return(page);
 }
 
+static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
+{
+	struct vm_operations_struct * ops;
+	struct inode *inode = file->f_dentry->d_inode;
+
+	ops = &shmem_vm_ops;
+	if (!inode->i_sb || !S_ISREG(inode->i_mode))
+		return -EACCES;
+	UPDATE_ATIME(inode);
+	vma->vm_ops = ops;
+	return 0;
+}
+
 struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
 {
 	struct inode * inode;
@@ -416,6 +429,7 @@
 	return inode;
 }
 
+#ifdef CONFIG_SWAPFS
 static ssize_t
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
@@ -520,8 +534,8 @@
 			buf += bytes;
 			if (pos > inode->i_size) 
 				inode->i_size = pos;
-                        if (inode->u.shmem_i.max_index < index)
-                                inode->u.shmem_i.max_index = index;
+			if (inode->u.shmem_i.max_index < index)
+				inode->u.shmem_i.max_index = index;
 
 		}
 unlock:
@@ -628,7 +642,7 @@
 
 static int shmem_statfs(struct super_block *sb, struct statfs *buf)
 {
-	buf->f_type = SHMEM_MAGIC;
+	buf->f_type = SWAPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	spin_lock (&sb->u.shmem_sb.stat_lock);
 	if (sb->u.shmem_sb.max_blocks != ULONG_MAX || 
@@ -783,19 +797,6 @@
 	return error;
 }
 
-static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
-{
-	struct vm_operations_struct * ops;
-	struct inode *inode = file->f_dentry->d_inode;
-
-	ops = &shmem_vm_ops;
-	if (!inode->i_sb || !S_ISREG(inode->i_mode))
-		return -EACCES;
-	UPDATE_ATIME(inode);
-	vma->vm_ops = ops;
-	return 0;
-}
-
 static int shmem_parse_options(char *options, int *mode, unsigned long * blocks, unsigned long *inodes)
 {
 	char *this_char, *value;
@@ -828,10 +829,38 @@
 		else
 			return 1;
 	}
-
 	return 0;
 }
 
+static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
+{
+	int error;
+	unsigned long max_blocks, blocks;
+	unsigned long max_inodes, inodes;
+	struct shmem_sb_info *info = &sb->u.shmem_sb;
+
+	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
+		return -EINVAL;
+
+	spin_lock(&info->stat_lock);
+	blocks = info->max_blocks - info->free_blocks;
+	inodes = info->max_inodes - info->free_inodes;
+	error = -EINVAL;
+	if (max_blocks < blocks)
+		goto out;
+	if (max_inodes < inodes)
+		goto out;
+	error = 0;
+	info->max_blocks  = max_blocks;
+	info->free_blocks = max_blocks - blocks;
+	info->max_inodes  = max_inodes;
+	info->free_inodes = max_inodes - inodes;
+out:
+	spin_unlock(&info->stat_lock);
+	return error;
+}
+#endif
+
 static struct super_block *shmem_read_super(struct super_block * sb, void * data, int silent)
 {
 	struct inode * inode;
@@ -840,10 +869,12 @@
 	unsigned long inodes = ULONG_MAX;	/* unlimited */
 	int mode   = S_IRWXUGO | S_ISVTX;
 
+#ifdef CONFIG_SWAPFS
 	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
-		printk(KERN_ERR "shmem fs invalid option\n");
+		printk(KERN_ERR "swapfs invalid option\n");
 		return NULL;
 	}
+#endif
 
 	spin_lock_init (&sb->u.shmem_sb.stat_lock);
 	sb->u.shmem_sb.max_blocks = blocks;
@@ -852,7 +883,7 @@
 	sb->u.shmem_sb.free_inodes = inodes;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
-	sb->s_magic = SHMEM_MAGIC;
+	sb->s_magic = SWAPFS_MAGIC;
 	sb->s_op = &shmem_ops;
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
@@ -867,42 +898,16 @@
 	return sb;
 }
 
-static int shmem_remount_fs (struct super_block *sb, int *flags, char *data)
-{
-	int error;
-	unsigned long max_blocks, blocks;
-	unsigned long max_inodes, inodes;
-	struct shmem_sb_info *info = &sb->u.shmem_sb;
-
-	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
-		return -EINVAL;
-
-	spin_lock(&info->stat_lock);
-	blocks = info->max_blocks - info->free_blocks;
-	inodes = info->max_inodes - info->free_inodes;
-	error = -EINVAL;
-	if (max_blocks < blocks)
-		goto out;
-	if (max_inodes < inodes)
-		goto out;
-	error = 0;
-	info->max_blocks  = max_blocks;
-	info->free_blocks = max_blocks - blocks;
-	info->max_inodes  = max_inodes;
-	info->free_inodes = max_inodes - inodes;
-out:
-	spin_unlock(&info->stat_lock);
-	return error;
-}
-
 static struct address_space_operations shmem_aops = {
 	writepage: shmem_writepage
 };
 
 static struct file_operations shmem_file_operations = {
 	mmap:	shmem_mmap,
+#ifdef CONFIG_SWAPFS
 	read:	shmem_file_read,
 	write:	shmem_file_write
+#endif
 };
 
 static struct inode_operations shmem_inode_operations = {
@@ -915,6 +920,7 @@
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
+#ifdef CONFIG_SWAPFS
 	create:		shmem_create,
 	lookup:		shmem_lookup,
 	link:		shmem_link,
@@ -924,11 +930,14 @@
 	rmdir:		shmem_rmdir,
 	mknod:		shmem_mknod,
 	rename:		shmem_rename,
+#endif
 };
 
 static struct super_operations shmem_ops = {
+#ifdef CONFIG_SWAPFS
 	statfs:		shmem_statfs,
 	remount_fs:	shmem_remount_fs,
+#endif
 	delete_inode:	shmem_delete_inode,
 	put_inode:	force_delete,	
 };
@@ -937,32 +946,46 @@
 	nopage:	shmem_nopage,
 };
 
+#ifdef CONFIG_SWAPFS
+/* type "shm" will be tagged obsolete in 2.5 */
 static DECLARE_FSTYPE(shmem_fs_type, "shm", shmem_read_super, FS_LITTER);
+static DECLARE_FSTYPE(swapfs_fs_type, "swapfs", shmem_read_super, FS_LITTER);
+#else
+static DECLARE_FSTYPE(swapfs_fs_type, "swapfs", shmem_read_super, FS_LITTER|FS_NOMOUNT);
+#endif
 
 static int __init init_shmem_fs(void)
 {
 	int error;
 	struct vfsmount * res;
 
+	if ((error = register_filesystem(&swapfs_fs_type))) {
+		printk (KERN_ERR "Could not register swapfs fs\n");
+		return error;
+	}
+#ifdef CONFIG_SWAPFS
 	if ((error = register_filesystem(&shmem_fs_type))) {
-		printk (KERN_ERR "Could not register shmem fs\n");
+		printk (KERN_ERR "Could not register shm fs\n");
 		return error;
 	}
-
-	res = kern_mount(&shmem_fs_type);
+	devfs_mk_dir (NULL, "shm", NULL);
+#endif
+	res = kern_mount(&swapfs_fs_type);
 	if (IS_ERR (res)) {
-		printk (KERN_ERR "could not kern_mount shmem fs\n");
-		unregister_filesystem(&shmem_fs_type);
+		printk (KERN_ERR "could not kern_mount swapfs fs\n");
+		unregister_filesystem(&swapfs_fs_type);
 		return PTR_ERR(res);
 	}
 
-	devfs_mk_dir (NULL, "shm", NULL);
 	return 0;
 }
 
 static void __exit exit_shmem_fs(void)
 {
+#ifdef CONFIG_SWAPFS
 	unregister_filesystem(&shmem_fs_type);
+#endif
+	unregister_filesystem(&swapfs_fs_type);
 }
 
 module_init(init_shmem_fs)
@@ -1058,7 +1081,7 @@
 	this.name = name;
 	this.len = strlen(name);
 	this.hash = 0; /* will go */
-	root = shmem_fs_type.kern_mnt->mnt_root;
+	root = swapfs_fs_type.kern_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
 		goto out;
@@ -1075,7 +1098,7 @@
 
 	d_instantiate(dentry, inode);
 	dentry->d_inode->i_size = size;
-	file->f_vfsmnt = mntget(shmem_fs_type.kern_mnt);
+	file->f_vfsmnt = mntget(swapfs_fs_type.kern_mnt);
 	file->f_dentry = dentry;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
