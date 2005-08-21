Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVHULli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVHULli (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 07:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVHULli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 07:41:38 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:65178 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750962AbVHULlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 07:41:36 -0400
Subject: [RFC][PATCH] VFS: update documentation
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Sun, 21 Aug 2005 14:37:30 +0300
Message-Id: <1124624250.5381.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch updates the out-of-date Documentation/filesystems/vfs.txt.
As I am a novice on the VFS, I would much appreciate any comments and
help on this.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 vfs.txt |  314 +++++++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 241 insertions(+), 73 deletions(-)

Index: 2.6-mm/Documentation/filesystems/vfs.txt
===================================================================
--- 2.6-mm.orig/Documentation/filesystems/vfs.txt
+++ 2.6-mm/Documentation/filesystems/vfs.txt
@@ -1,10 +1,9 @@
-/* -*- auto-fill -*-                                                         */
 
 		Overview of the Virtual File System
 
-		Richard Gooch <rgooch@atnf.csiro.au>
+	Original author: Richard Gooch <rgooch@atnf.csiro.au>
 
-			      5-JUL-1999
+		  Last updated on August 21, 2005
 
 
 Conventions used in this document                                     <section>
@@ -15,9 +14,6 @@ right-hand side of the section title. Ea
 "<subsection>" at the right-hand side. These strings are meant to make
 it easier to search through the document.
 
-NOTE that the master copy of this document is available online at:
-http://www.atnf.csiro.au/~rgooch/linux/docs/vfs.txt
-
 
 What is it?                                                           <section>
 ===========
@@ -126,14 +122,18 @@ It's now time to look at things in more 
 struct file_system_type                                               <section>
 =======================
 
-This describes the filesystem. As of kernel 2.1.99, the following
+This describes the filesystem. As of kernel 2.6.13, the following
 members are defined:
 
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-	struct super_block *(*read_super) (struct super_block *, void *, int);
-	struct file_system_type * next;
+        struct super_block *(*get_sb) (struct file_system_type *, int,
+                                       const char *, void *);
+        void (*kill_sb) (struct super_block *);
+        struct module *owner;
+        struct file_system_type * next;
+        struct list_head fs_supers;
 };
 
   name: the name of the filesystem type, such as "ext2", "iso9660",
@@ -141,51 +141,96 @@ struct file_system_type {
 
   fs_flags: various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
 
-  read_super: the method to call when a new instance of this
+  get_sb: the method to call when a new instance of this
 	filesystem should be mounted
 
+  kill_sb: the method to call when an instance of this filesystem
+	should be unmounted
+
+  owner: for internal VFS use: you should initialise this to NULL
+
   next: for internal VFS use: you should initialise this to NULL
 
-The read_super() method has the following arguments:
+The get_sb() method has the following arguments:
 
   struct super_block *sb: the superblock structure. This is partially
 	initialised by the VFS and the rest must be initialised by the
-	read_super() method
+	get_sb() method
+
+  int flags: mount flags
+
+  const char *dev_name: the device name we are mounting.
 
   void *data: arbitrary mount options, usually comes as an ASCII
 	string
 
   int silent: whether or not to be silent on error
 
-The read_super() method must determine if the block device specified
+The get_sb() method must determine if the block device specified
 in the superblock contains a filesystem of the type the method
 supports. On success the method returns the superblock pointer, on
 failure it returns NULL.
 
 The most interesting member of the superblock structure that the
-read_super() method fills in is the "s_op" field. This is a pointer to
+get_sb() method fills in is the "s_op" field. This is a pointer to
 a "struct super_operations" which describes the next level of the
 filesystem implementation.
 
+Usually, a filesystem uses generic one of the generic get_sb()
+implementations and provides a fill_super() method instead. The
+generic methods are:
+
+  get_sb_bdev: mount a filesystem residing on a block device
+
+  get_sb_nodev: mount a filesystem that is not backed by a device
+
+  get_sb_single: mount a filesystem which shares the instance between
+  	all mounts
+
+A fill_super() method implementation has the following arguments:
+
+  struct super_block *sb: the superblock structure. The method fill_super()
+  	must initialise this properly.
+
+  void *data: arbitrary mount options, usually comes as an ASCII
+	string
+
+  int silent: whether or not to be silent on error
+
 
 struct super_operations                                               <section>
 =======================
 
 This describes how the VFS can manipulate the superblock of your
-filesystem. As of kernel 2.1.99, the following members are defined:
+filesystem. As of kernel 2.6.13, the following members are defined:
 
 struct super_operations {
-	void (*read_inode) (struct inode *);
-	int (*write_inode) (struct inode *, int);
-	void (*put_inode) (struct inode *);
-	void (*drop_inode) (struct inode *);
-	void (*delete_inode) (struct inode *);
-	int (*notify_change) (struct dentry *, struct iattr *);
-	void (*put_super) (struct super_block *);
-	void (*write_super) (struct super_block *);
-	int (*statfs) (struct super_block *, struct statfs *, int);
-	int (*remount_fs) (struct super_block *, int *, char *);
-	void (*clear_inode) (struct inode *);
+        struct inode *(*alloc_inode)(struct super_block *sb);
+        void (*destroy_inode)(struct inode *);
+
+        void (*read_inode) (struct inode *);
+
+        void (*dirty_inode) (struct inode *);
+        int (*write_inode) (struct inode *, int);
+        void (*put_inode) (struct inode *);
+        void (*drop_inode) (struct inode *);
+        void (*delete_inode) (struct inode *);
+        void (*put_super) (struct super_block *);
+        void (*write_super) (struct super_block *);
+        int (*sync_fs)(struct super_block *sb, int wait);
+        void (*write_super_lockfs) (struct super_block *);
+        void (*unlockfs) (struct super_block *);
+        int (*statfs) (struct super_block *, struct kstatfs *);
+        int (*remount_fs) (struct super_block *, int *, char *);
+        void (*clear_inode) (struct inode *);
+        void (*umount_begin) (struct super_block *);
+
+        void (*sync_inodes) (struct super_block *sb,
+                                struct writeback_control *wbc);
+        int (*show_options)(struct seq_file *, struct vfsmount *);
+
+        ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
+        ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
 };
 
 All methods are called without any locks being held, unless otherwise
@@ -193,17 +238,25 @@ noted. This means that most methods can 
 only called from a process context (i.e. not from an interrupt handler
 or bottom half).
 
+  alloc_inode: this method is called by inode_alloc() to allocate memory for
+  	struct inode.
+
+  destroy_inode: this method is called by destroy_inode() to free a memory
+  	allocated for struct inode.
+
   read_inode: this method is called to read a specific inode from the
-	mounted filesystem. The "i_ino" member in the "struct inode"
-	will be initialised by the VFS to indicate which inode to
-	read. Other members are filled in by this method
+        mounted filesystem. The "i_ino" member in the "struct inode"
+        will be initialised by the VFS to indicate which inode to
+        read. Other members are filled in by this method
+
+  dirty_inode: this method is called by the VFS to mark an inode dirty.
 
   write_inode: this method is called when the VFS needs to write an
 	inode to disc.  The second parameter indicates whether the write
 	should be synchronous or not, not all filesystems check this flag.
 
   put_inode: called when the VFS inode is removed from the inode
-	cache. This method is optional
+	cache.
 
   drop_inode: called when the last access to the inode is dropped,
 	with the inode_lock spinlock held.
@@ -220,16 +273,22 @@ or bottom half).
 
   delete_inode: called when the VFS wants to delete an inode
 
-  notify_change: called when VFS inode attributes are changed. If this
-	is NULL the VFS falls back to the write_inode() method. This
-	is called with the kernel lock held
-
   put_super: called when the VFS wishes to free the superblock
 	(i.e. unmount). This is called with the superblock lock held
 
   write_super: called when the VFS superblock needs to be written to
 	disc. This method is optional
 
+  sync_fs: called when VFS is writing out all dirty data associated with
+  	a superblock. The second parameter indicates whether the method
+	should wait until the write out has been completed. Optional.
+
+  write_super_lockfs: called when VFS is locking a filesystem and forcing
+  	it into a consistent state.
+
+  unlockfs: called when VFS is unlocking a filesystem and making it writeable
+  	again.
+
   statfs: called when the VFS needs to get filesystem statistics. This
 	is called with the kernel lock held
 
@@ -238,6 +297,17 @@ or bottom half).
 
   clear_inode: called then the VFS clears the inode. Optional
 
+  umount_begin: called when the VFS is unmounting a filesystem.
+
+  sync_inodes: called when the VFS is writing out dirty data associated with
+  	a superblock.
+
+  show_options: called by the VFS to show mount options for /proc/<pid>/mounts.
+
+  quota_read: called by the VFS to read from filesystem quota file.
+
+  quota_write: called by the VFS to write to filesystem quota file.
+
 The read_inode() method is responsible for filling in the "i_op"
 field. This is a pointer to a "struct inode_operations" which
 describes the methods that can be performed on individual inodes.
@@ -247,12 +317,11 @@ struct inode_operations                 
 =======================
 
 This describes how the VFS can manipulate an inode in your
-filesystem. As of kernel 2.1.99, the following members are defined:
+filesystem. As of kernel 2.6.13, the following members are defined:
 
 struct inode_operations {
-	struct file_operations * default_file_ops;
-	int (*create) (struct inode *,struct dentry *,int);
-	int (*lookup) (struct inode *,struct dentry *);
+	int (*create) (struct inode *,struct dentry *,int, struct nameidata *);
+	struct dentry * (*lookup) (struct inode *,struct dentry *, struct nameidata *);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct inode *,struct dentry *,const char *);
@@ -261,25 +330,22 @@ struct inode_operations {
 	int (*mknod) (struct inode *,struct dentry *,int,dev_t);
 	int (*rename) (struct inode *, struct dentry *,
 			struct inode *, struct dentry *);
-	int (*readlink) (struct dentry *, char *,int);
-	struct dentry * (*follow_link) (struct dentry *, struct dentry *);
-	int (*readpage) (struct file *, struct page *);
-	int (*writepage) (struct page *page, struct writeback_control *wbc);
-	int (*bmap) (struct inode *,int);
+	int (*readlink) (struct dentry *, char __user *,int);
+	int (*follow_link) (struct dentry *, struct nameidata *);
+	void (*put_link) (struct dentry *, struct nameidata *);
 	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int);
-	int (*smap) (struct inode *,int);
-	int (*updatepage) (struct file *, struct page *, const char *,
-				unsigned long, unsigned int, int);
-	int (*revalidate) (struct dentry *);
+	int (*permission) (struct inode *, int, struct nameidata *);
+	int (*setattr) (struct dentry *, struct iattr *);
+	int (*getattr) (struct vfsmount *mnt, struct dentry *, struct kstat *);
+	int (*setxattr) (struct dentry *, const char *,const void *,size_t,int);
+	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
+	ssize_t (*listxattr) (struct dentry *, char *, size_t);
+	int (*removexattr) (struct dentry *, const char *);
 };
 
 Again, all methods are called without any locks being held, unless
 otherwise noted.
 
-  default_file_ops: this is a pointer to a "struct file_operations"
-	which describes how to open and then manipulate open files
-
   create: called by the open(2) and creat(2) system calls. Only
 	required if you want to support regular files. The dentry you
 	get should not have an inode (i.e. it should be a negative
@@ -332,27 +398,103 @@ otherwise noted.
 	symbolic links
 
 
+struct address_space_operations                                       <section>
+===============================
+
+This describes how the VFS can manipulate mapping of a file to page cache in
+your filesystem. As of kernel 2.6.13, the following members are defined:
+
+struct address_space_operations {
+	int (*writepage)(struct page *page, struct writeback_control *wbc);
+	int (*readpage)(struct file *, struct page *);
+	int (*sync_page)(struct page *);
+	int (*writepages)(struct address_space *, struct writeback_control *);
+	int (*set_page_dirty)(struct page *page);
+	int (*readpages)(struct file *filp, struct address_space *mapping,
+			struct list_head *pages, unsigned nr_pages);
+	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
+	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
+	sector_t (*bmap)(struct address_space *, sector_t);
+	int (*invalidatepage) (struct page *, unsigned long);
+	int (*releasepage) (struct page *, int);
+	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
+			loff_t offset, unsigned long nr_segs);
+	struct page* (*get_xip_page)(struct address_space *, sector_t,
+			int);
+};
+
+  writepage: called by the VM write a dirty page to backing store.
+
+  readpage: called by the VM to read a page from backing store.
+
+  sync_page: called by the VM to notify the backing store to perform all
+  	queued I/O operations for a page. I/O operations for other pages
+	associated with this address_space object may also be performed.
+
+  writepages: called by the VM to write out all pages associated with the
+  	address_space object.
+
+  set_page_dirty: called by the VM to set a page dirty.
+
+  readpages: called by the VM to read pages associated with the address_space
+  	object.
+
+  prepare_write: called by the generic write path in VM to set up a write
+  	request for a page.
+
+  commit_write: called by the generic write path in VM to write page to
+  	its backing store.
+
+  bmap: called by the VFS to map a logical block offset within object to
+  	physical block number. This method is use by for the legacy FIBMAP
+	ioctl. Other uses are discouraged.
+
+  invalidatepage: called by the VM on truncate to disassociate a page from its
+  	address_space mapping.
+
+  releasepage: called by the VFS to release filesystem specific metadata from
+  	a page.
+
+  direct_IO: called by the VM for direct I/O writes and reads.
+
+  get_xip_page: called by the VM to translate a block number to a page.
+  	This is used by filesystems that want to implement execute-in-place
+	(XIP).
+
+
 struct file_operations                                                <section>
 ======================
 
 This describes how the VFS can manipulate an open file. As of kernel
-2.1.99, the following members are defined:
+2.6.13, the following members are defined:
 
 struct file_operations {
 	loff_t (*llseek) (struct file *, loff_t, int);
-	ssize_t (*read) (struct file *, char *, size_t, loff_t *);
-	ssize_t (*write) (struct file *, const char *, size_t, loff_t *);
+	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
+	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
+	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
+	ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t, loff_t);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
+	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
+	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
+	int (*flush) (struct file *);
 	int (*release) (struct inode *, struct file *);
-	int (*fsync) (struct file *, struct dentry *);
-	int (*fasync) (struct file *, int);
-	int (*check_media_change) (kdev_t dev);
-	int (*revalidate) (kdev_t dev);
+	int (*fsync) (struct file *, struct dentry *, int datasync);
+	int (*aio_fsync) (struct kiocb *, int datasync);
+	int (*fasync) (int, struct file *, int);
 	int (*lock) (struct file *, int, struct file_lock *);
+	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *);
+	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *);
+	ssize_t (*sendfile) (struct file *, loff_t *, size_t, read_actor_t, void *);
+	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
+	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+	int (*check_flags)(int);
+	int (*dir_notify)(struct file *filp, unsigned long arg);
+	int (*flock) (struct file *, int, struct file_lock *);
 };
 
 Again, all methods are called without any locks being held, unless
@@ -362,8 +504,12 @@ otherwise noted.
 
   read: called by read(2) and related system calls
 
+  aio_read: called by io_submit(2) and other asynchronous I/O operations
+
   write: called by write(2) and related system calls
 
+  aio_read: called by io_submit(2) and other asynchronous I/O operations
+
   readdir: called when the VFS needs to read the directory contents
 
   poll: called by the VFS when a process wants to check if there is
@@ -372,18 +518,25 @@ otherwise noted.
 
   ioctl: called by the ioctl(2) system call
 
+  unlocked_ioctl: called by the ioctl(2) system call. Filesystems that do not
+  	require the BKL should use this method instead of the ioctl() above.
+
+  compat_ioctl: called by the ioctl(2) system call when 32 bit syscalls are
+  	used on on 64 bit kernels.
+
   mmap: called by the mmap(2) system call
 
   open: called by the VFS when an inode should be opened. When the VFS
-	opens a file, it creates a new "struct file" and initialises
-	the "f_op" file operations member with the "default_file_ops"
-	field in the inode structure. It then calls the open method
-	for the newly allocated file structure. You might think that
-	the open method really belongs in "struct inode_operations",
-	and you may be right. I think it's done the way it is because
-	it makes filesystems simpler to implement. The open() method
-	is a good place to initialise the "private_data" member in the
-	file structure if you want to point to a device structure
+	opens a file, it creates a new "struct file". It then calls the
+	open method for the newly allocated file structure. You might
+	think that the open method really belongs in
+	"struct inode_operations", and you may be right. I think it's
+	done the way it is because it makes filesystems simpler to
+	implement. The open() method is a good place to initialise the
+	"private_data" member in the file structure if you want to point
+	to a device structure
+
+  flush: called by the close(2) system call to flush a file
 
   release: called when the last reference to an open file is closed
 
@@ -392,6 +545,23 @@ otherwise noted.
   fasync: called by the fcntl(2) system call when asynchronous
 	(non-blocking) mode is enabled for a file
 
+  lock: called by the fcntl(2) system call for F_GETLK, F_SETLK, and F_SETLKW
+  	commands.
+
+  readv: called by the readv(2) system call
+
+  writev: called by the readv(2) system call
+
+  sendfile: called by the sendfile(2) system call
+
+  get_unmapped_area: called by the mmap(2) system call
+
+  check_flags: called by the fcntl(2) system call for F_SETFL command
+
+  dir_notify: called by the fcntl(2) system call for F_NOTIFY command
+
+  flock: called by the flock(2) system call
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides. When opening a device node
 (character or block special) most filesystems will call special
@@ -400,9 +570,7 @@ driver information. These support routin
 operations with those for the device driver, and then proceed to call
 the new open() method for the file. This is how opening a device file
 in the filesystem eventually ends up calling the device driver open()
-method. Note the devfs (the Device FileSystem) has a more direct path
-from device node to device driver (this is an unofficial kernel
-patch).
+method.
 
 
 Directory Entry Cache (dcache)                                        <section>
@@ -415,14 +583,14 @@ This describes how a filesystem can over
 operations. Dentries and the dcache are the domain of the VFS and the
 individual filesystem implementations. Device drivers have no business
 here. These methods may be set to NULL, as they are either optional or
-the VFS uses a default. As of kernel 2.1.99, the following members are
+the VFS uses a default. As of kernel 2.6.13, the following members are
 defined:
 
 struct dentry_operations {
-	int (*d_revalidate)(struct dentry *);
+	int (*d_revalidate)(struct dentry *, struct nameidata *);
 	int (*d_hash) (struct dentry *, struct qstr *);
 	int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
-	void (*d_delete)(struct dentry *);
+	int (*d_delete)(struct dentry *);
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
 };


