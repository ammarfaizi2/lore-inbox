Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129910AbRBAVey>; Thu, 1 Feb 2001 16:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRBAVej>; Thu, 1 Feb 2001 16:34:39 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:52712 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129656AbRBAVeZ>; Thu, 1 Feb 2001 16:34:25 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] rename swapfs to tmpfs against 2.4.1-ac1
From: Christoph Rohland <cr@sap.com>
Message-ID: <m3u26ertvn.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 01 Feb 2001 22:39:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I decided to rename swapfs to tmpfs for administration but to call it
virtual memory fs in Documentation.

Further on the wine people asked me to export shmem_file_setup.

The attached patch does this an updates the docu.

Greetings
                Christoph

diff -uNr 2.4.1-ac1/Documentation/Configure.help 2.4.1-ac1-tmpfs/Documentation/Configure.help
--- 2.4.1-ac1/Documentation/Configure.help	Thu Feb  1 20:53:21 2001
+++ 2.4.1-ac1-tmpfs/Documentation/Configure.help	Thu Feb  1 21:47:15 2001
@@ -11203,31 +11203,34 @@
 
   If unsure, say N.
    
-Swap file system support
-CONFIG_SWAPFS
-  Swapfs is a file system which keeps all files in RAM and swap space.
+Virtual memory file system support
+CONFIG_TMPFS
+  Tmpfs is a file system which keeps all files in virtual memory.
 
   In contrast to RAM disks, which get allocated a fixed amount of
-  physical RAM, swapfs grows and shrinks to accommodate the files it
+  physical RAM, tmpfs grows and shrinks to accommodate the files it
   contains and is able to swap unneeded pages out to swap space.
 
   Everything is "virtual" in the sense that no files will be created
-  on your hard drive; if you reboot, everything in swapfs will be
+  on your hard drive; if you reboot, everything in tmpfs will be
   lost.
   
-  You should mount the filesystem under /dev/shm to be able to use
+  You should mount the filesystem somewhere to be able to use
   POSIX shared memory. Adding the following line to /etc/fstab should
   take care of things:
 
-  swapfs	/dev/shm	swapfs		defaults	0 0
+  tmpfs		/dev/shm	tmpfs		defaults	0 0
 
-  Remember to create the directory that you intend to mount swapfs on
-  if necessary (The entry is automagically created if you use devfs).
+  Remember to create the directory that you intend to mount tmpfs on
+  if necessary (/dev/shm is automagically created if you use devfs).
 
   You can set limits for the number of blocks and inodes used by the
-  filesystem with the mount options "nr_blocks" and "nr_inodes". The
-  initial permissions of the root directory can be set with the mount
-  option "mode".
+  filesystem with the mount options "size", "nr_blocks" and
+  "nr_inodes". These parameters accept a suffix k, m or g for kilo,
+  mega and giga and can be changed on remount.
+  
+  The initial permissions of the root directory can be set with the
+  mount option "mode".
 
 Simple RAM-based file system support
 CONFIG_RAMFS
@@ -11236,7 +11239,7 @@
 
   It is more of an programming example than a useable filesystem. If
   you need a file system which lives in RAM with limit checking use
-  swapfs.
+  tmpfs.
 
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
diff -uNr 2.4.1-ac1/fs/Config.in 2.4.1-ac1-tmpfs/fs/Config.in
--- 2.4.1-ac1/fs/Config.in	Thu Feb  1 20:53:52 2001
+++ 2.4.1-ac1-tmpfs/fs/Config.in	Thu Feb  1 21:11:56 2001
@@ -31,7 +31,7 @@
    int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
 fi
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
-bool 'Swap file system support (former shm fs)' CONFIG_SWAPFS
+bool 'Virtual memory file system support (former shm fs)' CONFIG_TMPFS
 tristate 'Simple RAM-based file system support' CONFIG_RAMFS
 
 tristate 'ISO 9660 CDROM file system support' CONFIG_ISO9660_FS
diff -uNr 2.4.1-ac1/mm/shmem.c 2.4.1-ac1-tmpfs/mm/shmem.c
--- 2.4.1-ac1/mm/shmem.c	Thu Feb  1 20:54:01 2001
+++ 2.4.1-ac1-tmpfs/mm/shmem.c	Thu Feb  1 22:16:58 2001
@@ -29,7 +29,8 @@
 
 #include <asm/uaccess.h>
 
-#define SWAPFS_MAGIC	0x01021994
+/* This magic number is used in glibc for posix shared memory */
+#define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
 #define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
@@ -478,7 +479,7 @@
 	return inode;
 }
 
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 static ssize_t
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
@@ -692,7 +693,7 @@
 
 static int shmem_statfs(struct super_block *sb, struct statfs *buf)
 {
-	buf->f_type = SWAPFS_MAGIC;
+	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	spin_lock (&sb->u.shmem_sb.stat_lock);
 	if (sb->u.shmem_sb.max_blocks != ULONG_MAX || 
@@ -976,9 +977,9 @@
 	unsigned long inodes = ULONG_MAX;	/* unlimited */
 	int mode   = S_IRWXUGO | S_ISVTX;
 
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
-		printk(KERN_ERR "swapfs invalid option\n");
+		printk(KERN_ERR "tmpfs invalid option\n");
 		return NULL;
 	}
 #endif
@@ -991,7 +992,7 @@
 	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
-	sb->s_magic = SWAPFS_MAGIC;
+	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
@@ -1012,7 +1013,7 @@
 
 static struct file_operations shmem_file_operations = {
 	mmap:	shmem_mmap,
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 	read:	shmem_file_read,
 	write:	shmem_file_write
 #endif
@@ -1024,7 +1025,7 @@
 
 static struct inode_operations shmem_symlink_inode_operations = {
 	truncate:	shmem_truncate,
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 	readlink:	shmem_readlink,
 	follow_link:	shmem_follow_link,
 #endif
@@ -1036,7 +1037,7 @@
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 	create:		shmem_create,
 	lookup:		shmem_lookup,
 	link:		shmem_link,
@@ -1050,7 +1051,7 @@
 };
 
 static struct super_operations shmem_ops = {
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 	statfs:		shmem_statfs,
 	remount_fs:	shmem_remount_fs,
 #endif
@@ -1062,12 +1063,12 @@
 	nopage:	shmem_nopage,
 };
 
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 /* type "shm" will be tagged obsolete in 2.5 */
 static DECLARE_FSTYPE(shmem_fs_type, "shm", shmem_read_super, FS_LITTER);
-static DECLARE_FSTYPE(swapfs_fs_type, "swapfs", shmem_read_super, FS_LITTER);
+static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER);
 #else
-static DECLARE_FSTYPE(swapfs_fs_type, "swapfs", shmem_read_super, FS_LITTER|FS_NOMOUNT);
+static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER|FS_NOMOUNT);
 #endif
 
 static int __init init_shmem_fs(void)
@@ -1075,21 +1076,21 @@
 	int error;
 	struct vfsmount * res;
 
-	if ((error = register_filesystem(&swapfs_fs_type))) {
-		printk (KERN_ERR "Could not register swapfs\n");
+	if ((error = register_filesystem(&tmpfs_fs_type))) {
+		printk (KERN_ERR "Could not register tmpfs\n");
 		return error;
 	}
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 	if ((error = register_filesystem(&shmem_fs_type))) {
 		printk (KERN_ERR "Could not register shm fs\n");
 		return error;
 	}
 	devfs_mk_dir (NULL, "shm", NULL);
 #endif
-	res = kern_mount(&swapfs_fs_type);
+	res = kern_mount(&tmpfs_fs_type);
 	if (IS_ERR (res)) {
-		printk (KERN_ERR "could not kern_mount swapfs\n");
-		unregister_filesystem(&swapfs_fs_type);
+		printk (KERN_ERR "could not kern_mount tmpfs\n");
+		unregister_filesystem(&tmpfs_fs_type);
 		return PTR_ERR(res);
 	}
 
@@ -1098,10 +1099,10 @@
 
 static void __exit exit_shmem_fs(void)
 {
-#ifdef CONFIG_SWAPFS
+#ifdef CONFIG_TMPFS
 	unregister_filesystem(&shmem_fs_type);
 #endif
-	unregister_filesystem(&swapfs_fs_type);
+	unregister_filesystem(&tmpfs_fs_type);
 }
 
 module_init(init_shmem_fs)
@@ -1197,7 +1198,7 @@
 	this.name = name;
 	this.len = strlen(name);
 	this.hash = 0; /* will go */
-	root = swapfs_fs_type.kern_mnt->mnt_root;
+	root = tmpfs_fs_type.kern_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
 		goto out;
@@ -1215,7 +1216,7 @@
 	d_instantiate(dentry, inode);
 	dentry->d_inode->i_size = size;
 	shmem_truncate(inode);
-	file->f_vfsmnt = mntget(swapfs_fs_type.kern_mnt);
+	file->f_vfsmnt = mntget(tmpfs_fs_type.kern_mnt);
 	file->f_dentry = dentry;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
@@ -1249,3 +1250,5 @@
 	vma->vm_ops = &shmem_vm_ops;
 	return 0;
 }
+
+EXPORT_SYMBOL(shmem_file_setup);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
