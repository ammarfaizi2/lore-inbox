Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129512AbRBAVeO>; Thu, 1 Feb 2001 16:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129082AbRBAVdz>; Thu, 1 Feb 2001 16:33:55 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:40168 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129288AbRBAVdw>; Thu, 1 Feb 2001 16:33:52 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "J . A . Magallon" <jamagallon@able.es>
Subject: [patch] tmpfs for 2.4.1
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <20010123205315.A4662@werewolf.able.es>
Message-ID: <m3lmrqrspv.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 01 Feb 2001 22:39:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here is the latest version of my tmpfs patch against 2.4.1

Have fun
                Christoph

diff -uNr 2.4.1/Documentation/Changes 2.4.1-tmpfs/Documentation/Changes
--- 2.4.1/Documentation/Changes	Tue Jan 30 11:06:59 2001
+++ 2.4.1-tmpfs/Documentation/Changes	Thu Feb  1 22:04:13 2001
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
 
diff -uNr 2.4.1/Documentation/Configure.help 2.4.1-tmpfs/Documentation/Configure.help
--- 2.4.1/Documentation/Configure.help	Tue Jan 30 11:06:59 2001
+++ 2.4.1-tmpfs/Documentation/Configure.help	Thu Feb  1 22:06:30 2001
@@ -2739,14 +2739,6 @@
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
@@ -10914,23 +10906,44 @@
 
   If unsure, say N.
    
+Virtual memory file system support
+CONFIG_TMPFS
+  Tmpfs is a file system which keeps all files in virtual memory.
+
+  In contrast to RAM disks, which get allocated a fixed amount of
+  physical RAM, tmpfs grows and shrinks to accommodate the files it
+  contains and is able to swap unneeded pages out to swap space.
+
+  Everything is "virtual" in the sense that no files will be created
+  on your hard drive; if you reboot, everything in tmpfs will be
+  lost.
+  
+  You should mount the filesystem somewhere to be able to use
+  POSIX shared memory. Adding the following line to /etc/fstab should
+  take care of things:
+
+  tmpfs		/dev/shm	tmpfs		defaults	0 0
+
+  Remember to create the directory that you intend to mount tmpfs on
+  if necessary (/dev/shm is automagically created if you use devfs).
+
+  You can set limits for the number of blocks and inodes used by the
+  filesystem with the mount options "size", "nr_blocks" and
+  "nr_inodes". These parameters accept a suffix k, m or g for kilo,
+  mega and giga and can be changed on remount.
+  
+  The initial permissions of the root directory can be set with the
+  mount option "mode".
+
 Simple RAM-based file system support
 CONFIG_RAMFS
   Ramfs is a file system which keeps all files in RAM. It allows
   read and write access.
 
-  In contrast to RAM disks, which get allocated a fixed amount of RAM,
-  ramfs grows and shrinks to accommodate the files it contains.
+  It is more of an programming example than a useable filesystem. If
+  you need a file system which lives in RAM with limit checking use
+  tmpfs.
 
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
diff -uNr 2.4.1/arch/i386/kernel/setup.c 2.4.1-tmpfs/arch/i386/kernel/setup.c
--- 2.4.1/arch/i386/kernel/setup.c	Tue Jan 30 11:07:00 2001
+++ 2.4.1-tmpfs/arch/i386/kernel/setup.c	Thu Feb  1 22:02:48 2001
@@ -559,7 +559,7 @@
 				 * blow away any automatically generated
 				 * size
 				 */
-				unsigned long start_at, mem_size;
+				unsigned long long start_at, mem_size;
  
 				if (usermem == 0) {
 					/* first time in: zap the whitelist
diff -uNr 2.4.1/fs/Config.in 2.4.1-tmpfs/fs/Config.in
--- 2.4.1/fs/Config.in	Tue Jan 30 11:07:11 2001
+++ 2.4.1-tmpfs/fs/Config.in	Thu Feb  1 22:06:30 2001
@@ -31,6 +31,7 @@
 	int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
 fi
 tristate 'Compressed ROM file system support' CONFIG_CRAMFS
+bool 'Virtual memory file system support (former shm fs)' CONFIG_TMPFS
 tristate 'Simple RAM-based file system support' CONFIG_RAMFS
 
 tristate 'ISO 9660 CDROM file system support' CONFIG_ISO9660_FS
diff -uNr 2.4.1/include/linux/fs.h 2.4.1-tmpfs/include/linux/fs.h
--- 2.4.1/include/linux/fs.h	Thu Feb  1 22:19:59 2001
+++ 2.4.1-tmpfs/include/linux/fs.h	Thu Feb  1 22:23:28 2001
@@ -1213,6 +1213,7 @@
 	}
 	return inode;
 }
+extern void remove_suid(struct inode *inode);
 
 extern void insert_inode_hash(struct inode *);
 extern void remove_inode_hash(struct inode *);
@@ -1260,6 +1261,7 @@
 int block_truncate_page(struct address_space *, loff_t, get_block_t *);
 
 extern int generic_file_mmap(struct file *, struct vm_area_struct *);
+extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
diff -uNr 2.4.1/include/linux/kernel.h 2.4.1-tmpfs/include/linux/kernel.h
--- 2.4.1/include/linux/kernel.h	Sun Dec 17 12:54:01 2000
+++ 2.4.1-tmpfs/include/linux/kernel.h	Thu Feb  1 22:02:48 2001
@@ -62,7 +62,7 @@
 extern int vsprintf(char *buf, const char *, va_list);
 extern int get_option(char **str, int *pint);
 extern char *get_options(char *str, int nints, int *ints);
-extern unsigned long memparse(char *ptr, char **retptr);
+extern unsigned long long memparse(char *ptr, char **retptr);
 extern void dev_probe_lock(void);
 extern void dev_probe_unlock(void);
 
diff -uNr 2.4.1/include/linux/mm.h 2.4.1-tmpfs/include/linux/mm.h
--- 2.4.1/include/linux/mm.h	Thu Feb  1 22:09:11 2001
+++ 2.4.1-tmpfs/include/linux/mm.h	Thu Feb  1 22:23:33 2001
@@ -200,8 +200,8 @@
 					smp_mb__before_clear_bit(); \
 					if (!test_and_clear_bit(PG_locked, &(page)->flags)) BUG(); \
 					smp_mb__after_clear_bit(); \
-					if (waitqueue_active(&page->wait)) \
-						wake_up(&page->wait); \
+					if (waitqueue_active(&(page)->wait)) \
+						wake_up(&(page)->wait); \
 				} while (0)
 #define PageError(page)		test_bit(PG_error, &(page)->flags)
 #define SetPageError(page)	set_bit(PG_error, &(page)->flags)
diff -uNr 2.4.1/include/linux/shmem_fs.h 2.4.1-tmpfs/include/linux/shmem_fs.h
--- 2.4.1/include/linux/shmem_fs.h	Tue Jan  2 21:58:11 2001
+++ 2.4.1-tmpfs/include/linux/shmem_fs.h	Thu Feb  1 22:12:49 2001
@@ -19,6 +19,7 @@
 
 struct shmem_inode_info {
 	spinlock_t	lock;
+	unsigned long	max_index;
 	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	swp_entry_t   **i_indirect; /* doubly indirect blocks */
 	unsigned long	swapped;
diff -uNr 2.4.1/lib/cmdline.c 2.4.1-tmpfs/lib/cmdline.c
--- 2.4.1/lib/cmdline.c	Mon Aug 28 11:42:45 2000
+++ 2.4.1-tmpfs/lib/cmdline.c	Thu Feb  1 22:02:48 2001
@@ -93,9 +93,9 @@
  *	megabyte, or one gigabyte, respectively.
  */
 
-unsigned long memparse (char *ptr, char **retptr)
+unsigned long long memparse (char *ptr, char **retptr)
 {
-	unsigned long ret = simple_strtoul (ptr, retptr, 0);
+	unsigned long long ret = simple_strtoul (ptr, retptr, 0);
 
 	switch (**retptr) {
 	case 'G':
diff -uNr 2.4.1/mm/filemap.c 2.4.1-tmpfs/mm/filemap.c
--- 2.4.1/mm/filemap.c	Tue Jan 30 11:07:14 2001
+++ 2.4.1-tmpfs/mm/filemap.c	Thu Feb  1 22:22:33 2001
@@ -1209,7 +1209,7 @@
 	UPDATE_ATIME(inode);
 }
 
-static int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	char *kaddr;
 	unsigned long left, count = desc->count;
@@ -2408,7 +2408,7 @@
 	return page;
 }
 
-static inline void remove_suid(struct inode *inode)
+inline void remove_suid(struct inode *inode)
 {
 	unsigned int mode;
 
diff -uNr 2.4.1/mm/shmem.c 2.4.1-tmpfs/mm/shmem.c
--- 2.4.1/mm/shmem.c	Tue Jan 30 11:07:14 2001
+++ 2.4.1-tmpfs/mm/shmem.c	Thu Feb  1 22:15:33 2001
@@ -1,5 +1,5 @@
 /*
- * Resizable simple shmem filesystem for Linux.
+ * Resizable virtual memory filesystem for Linux.
  *
  * Copyright (C) 2000 Linus Torvalds.
  *		 2000 Transmeta Corp.
@@ -9,14 +9,12 @@
  */
 
 /*
- * This shared memory handling is heavily based on the ramfs. It
- * extends the ramfs by the ability to use swap which would makes it a
- * completely usable filesystem.
- *
- * But read and write are not supported (yet)
- *
+ * This virtual memory filesystem is heavily based on the ramfs. It
+ * extends ramfs by the ability to use swap and honor resource limits
+ * which makes it a completely usable filesystem.
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
@@ -31,7 +29,8 @@
 
 #include <asm/uaccess.h>
 
-#define SHMEM_MAGIC	0x01021994
+/* This magic number is used in glibc for posix shared memory */
+#define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
 #define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
@@ -42,33 +41,70 @@
 static struct inode_operations shmem_inode_operations;
 static struct file_operations shmem_dir_operations;
 static struct inode_operations shmem_dir_inode_operations;
-static struct vm_operations_struct shmem_shared_vm_ops;
-static struct vm_operations_struct shmem_private_vm_ops;
+static struct inode_operations shmem_symlink_inode_operations;
+static struct vm_operations_struct shmem_vm_ops;
 
 LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 
+/*
+ * shmem_recalc_inode - recalculate the size of an inode
+ *
+ * @inode: inode to recalc
+ *
+ * We have to calculate the free blocks since the mm can drop pages
+ * behind our back
+ *
+ * But we know that normally
+ * inodes->i_blocks == inode->i_mapping->nrpages + info->swapped
+ *
+ * So the mm freed 
+ * inodes->i_blocks - (inode->i_mapping->nrpages + info->swapped)
+ *
+ * It has to be called with the spinlock held.
+ */
+
+static void shmem_recalc_inode(struct inode * inode)
+{
+	unsigned long freed;
+
+	freed = inode->i_blocks -
+		(inode->i_mapping->nrpages + inode->u.shmem_i.swapped);
+	if (freed){
+		struct shmem_sb_info * info = &inode->i_sb->u.shmem_sb;
+		inode->i_blocks -= freed;
+		spin_lock (&info->stat_lock);
+		info->free_blocks += freed;
+		spin_unlock (&info->stat_lock);
+	}
+}
+
 static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index) 
 {
+	unsigned long offset;
+
 	if (index < SHMEM_NR_DIRECT)
 		return info->i_direct+index;
 
 	index -= SHMEM_NR_DIRECT;
-	if (index >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
-		return NULL;
+	offset = index % ENTRIES_PER_PAGE;
+	index /= ENTRIES_PER_PAGE;
+
+	if (index >= ENTRIES_PER_PAGE)
+		return ERR_PTR(-EFBIG);
 
 	if (!info->i_indirect) {
 		info->i_indirect = (swp_entry_t **) get_zeroed_page(GFP_USER);
 		if (!info->i_indirect)
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 	}
-	if(!(info->i_indirect[index/ENTRIES_PER_PAGE])) {
-		info->i_indirect[index/ENTRIES_PER_PAGE] = (swp_entry_t *) get_zeroed_page(GFP_USER);
-		if (!info->i_indirect[index/ENTRIES_PER_PAGE])
-			return NULL;
+	if(!(info->i_indirect[index])) {
+		info->i_indirect[index] = (swp_entry_t *) get_zeroed_page(GFP_USER);
+		if (!info->i_indirect[index])
+			return ERR_PTR(-ENOMEM);
 	}
 	
-	return info->i_indirect[index/ENTRIES_PER_PAGE]+index%ENTRIES_PER_PAGE;
+	return info->i_indirect[index]+offset;
 }
 
 static int shmem_free_swp(swp_entry_t *dir, unsigned int count)
@@ -98,7 +134,6 @@
  * @dir:	pointer to swp_entries 
  * @size:	number of entries in dir
  * @start:	offset to start from
- * @inode:	inode for statistics
  * @freed:	counter for freed pages
  *
  * It frees the swap entries from dir+start til dir+size
@@ -108,7 +143,7 @@
 
 static unsigned long 
 shmem_truncate_part (swp_entry_t * dir, unsigned long size, 
-		     unsigned long start, struct inode * inode, unsigned long *freed) {
+		     unsigned long start, unsigned long *freed) {
 	if (start > size)
 		return start - size;
 	if (dir)
@@ -117,56 +152,27 @@
 	return 0;
 }
 
-/*
- * shmem_recalc_inode - recalculate the size of an inode
- *
- * @inode: inode to recalc
- *
- * We have to calculate the free blocks since the mm can drop pages
- * behind our back
- *
- * But we know that normally
- * inodes->i_blocks == inode->i_mapping->nrpages + info->swapped
- *
- * So the mm freed 
- * inodes->i_blocks - (inode->i_mapping->nrpages + info->swapped)
- *
- * It has to be called with the spinlock held.
- */
-
-static void shmem_recalc_inode(struct inode * inode)
-{
-	unsigned long freed;
-
-	freed = inode->i_blocks -
-		(inode->i_mapping->nrpages + inode->u.shmem_i.swapped);
-	if (freed){
-		struct shmem_sb_info * info = &inode->i_sb->u.shmem_sb;
-		inode->i_blocks -= freed;
-		spin_lock (&info->stat_lock);
-		info->free_blocks += freed;
-		spin_unlock (&info->stat_lock);
-	}
-}
-
 static void shmem_truncate (struct inode * inode)
 {
 	int clear_base;
-	unsigned long start;
+	unsigned long index, start;
 	unsigned long freed = 0;
-	swp_entry_t **base, **ptr;
+	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
 	spin_lock (&info->lock);
-	start = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	if (index > info->max_index)
+		goto out;
 
-	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, start, inode, &freed);
+	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, index, &freed);
 
 	if (!(base = info->i_indirect))
-		goto out;;
+		goto out;
 
 	clear_base = 1;
-	for (ptr = base; ptr < base + ENTRIES_PER_PAGE; ptr++) {
+	last = base + ((info->max_index - SHMEM_NR_DIRECT + ENTRIES_PER_PAGE - 1) / ENTRIES_PER_PAGE);
+	for (ptr = base; ptr < last; ptr++) {
 		if (!start) {
 			if (!*ptr)
 				continue;
@@ -176,16 +182,16 @@
 			continue;
 		}
 		clear_base = 0;
-		start = shmem_truncate_part (*ptr, ENTRIES_PER_PAGE, start, inode, &freed);
+		start = shmem_truncate_part (*ptr, ENTRIES_PER_PAGE, start, &freed);
 	}
 
-	if (!clear_base) 
-		goto out;
-
-	free_page ((unsigned long)base);
-	info->i_indirect = 0;
+	if (clear_base) {
+		free_page ((unsigned long)base);
+		info->i_indirect = 0;
+	}
 
 out:
+	info->max_index = index;
 	info->swapped -= freed;
 	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
@@ -225,16 +231,16 @@
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(page->mapping->host);
-	entry = shmem_swp_entry (info, page->index);
-	if (!entry)	/* this had been allocted on page allocation */
+	entry = shmem_swp_entry(info, page->index);
+	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
 	error = -EAGAIN;
 	if (entry->val) {
-                __swap_free(swap, 2);
+		__swap_free(swap, 2);
 		goto out;
-        }
+	}
 
-        *entry = swap;
+	*entry = swap;
 	error = 0;
 	/* Remove the from the page cache */
 	lru_cache_del(page);
@@ -252,43 +258,27 @@
 }
 
 /*
- * shmem_nopage - either get the page from swap or allocate a new one
+ * shmem_getpage_locked - either get the page from swap or allocate a new one
  *
  * If we allocate a new one we do not mark it dirty. That's up to the
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache
  */
-struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share)
+static struct page * shmem_getpage_locked(struct inode * inode, unsigned long idx)
 {
-	unsigned long size;
-	struct page * page;
-	unsigned int idx;
-	swp_entry_t *entry;
-	struct inode * inode = vma->vm_file->f_dentry->d_inode;
 	struct address_space * mapping = inode->i_mapping;
 	struct shmem_inode_info *info;
+	struct page * page;
+	swp_entry_t *entry;
 
-	idx = (address - vma->vm_start) >> PAGE_SHIFT;
-	idx += vma->vm_pgoff;
-
-	down (&inode->i_sem);
-	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	page = NOPAGE_SIGBUS;
-	if ((idx >= size) && (vma->vm_mm == current->mm))
-		goto out;
-
-	/* retry, we may have slept */
-	page = __find_lock_page(mapping, idx, page_hash (mapping, idx));
+	page = find_lock_page(mapping, idx);;
 	if (page)
-		goto cached_page;
+		return page;
 
 	info = &inode->u.shmem_i;
 	entry = shmem_swp_entry (info, idx);
-	if (!entry)
-		goto oom;
-	spin_lock (&info->lock);
-	shmem_recalc_inode(inode);
-	spin_unlock (&info->lock);
+	if (IS_ERR(entry))
+		return (void *)entry;
 	if (entry->val) {
 		unsigned long flags;
 
@@ -300,15 +290,15 @@
 			page = read_swap_cache(*entry);
 			unlock_kernel();
 			if (!page) 
-				goto oom;
+				return ERR_PTR(-ENOMEM);
 		}
 
 		/* We have to this with page locked to prevent races */
+		lock_page(page);
 		spin_lock (&info->lock);
 		swap_free(*entry);
-		lock_page(page);
-		delete_from_swap_cache_nolock(page);
 		*entry = (swp_entry_t) {0};
+		delete_from_swap_cache_nolock(page);
 		flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_referenced) | (1 << PG_arch_1));
 		page->flags = flags | (1 << PG_dirty);
 		add_to_page_cache_locked(page, mapping, idx);
@@ -323,19 +313,70 @@
 		/* Ok, get a new page */
 		page = page_cache_alloc();
 		if (!page)
-			goto oom;
-		clear_user_highpage(page, address);
+			return ERR_PTR(-ENOMEM);
+		clear_highpage(page);
 		inode->i_blocks++;
 		add_to_page_cache (page, mapping, idx);
 	}
 	/* We have the page */
-	SetPageUptodate (page);
+	SetPageUptodate(page);
 	if (info->locked)
 		page_cache_get(page);
+	return page;
+no_space:
+	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
+	return ERR_PTR(-ENOSPC);
+}
 
-cached_page:
-	UnlockPage (page);
-	up(&inode->i_sem);
+static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
+{
+	struct address_space * mapping = inode->i_mapping;
+	int error;
+
+	*ptr = NOPAGE_SIGBUS;
+	if (inode->i_size <= (loff_t) idx * PAGE_CACHE_SIZE)
+		return -EFAULT;
+
+	*ptr = __find_get_page(mapping, idx, page_hash(mapping, idx));
+	if (*ptr) {
+		if (Page_Uptodate(*ptr))
+			return 0;
+		page_cache_release(*ptr);
+	}
+
+	down (&inode->i_sem);
+	/* retest we may have slept */
+	if (inode->i_size < (loff_t) idx * PAGE_CACHE_SIZE)
+		goto sigbus;
+	*ptr = shmem_getpage_locked(inode, idx);
+	if (IS_ERR (*ptr))
+		goto failed;
+	UnlockPage(*ptr);
+	up (&inode->i_sem);
+	return 0;
+failed:
+	up (&inode->i_sem);
+	error = PTR_ERR(*ptr);
+	*ptr = NOPAGE_OOM;
+	if (error != -EFBIG)
+		*ptr = NOPAGE_SIGBUS;
+	return error;
+sigbus:
+	*ptr = NOPAGE_SIGBUS;
+	return -EFAULT;
+}
+
+struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int no_share)
+{
+	struct page * page;
+	unsigned int idx;
+	struct inode * inode = vma->vm_file->f_dentry->d_inode;
+
+	idx = (address - vma->vm_start) >> PAGE_SHIFT;
+	idx += vma->vm_pgoff;
+
+	if (shmem_getpage(inode, idx, &page))
+		return page;
 
 	if (no_share) {
 		struct page *new_page = page_cache_alloc();
@@ -351,13 +392,45 @@
 
 	flush_page_to_ram (page);
 	return(page);
-no_space:
-	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
-oom:
-	page = NOPAGE_OOM;
-out:
+}
+
+void shmem_lock(struct file * file, int lock)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+	struct shmem_inode_info * info = &inode->u.shmem_i;
+	struct page * page;
+	unsigned long idx, size;
+
+	if (info->locked == lock)
+		return;
+	down(&inode->i_sem);
+	info->locked = lock;
+	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	for (idx = 0; idx < size; idx++) {
+		page = find_lock_page(inode->i_mapping, idx);
+		if (!page)
+			continue;
+		if (!lock) {
+			/* release the extra count and our reference */
+			page_cache_release(page);
+			page_cache_release(page);
+		}
+		UnlockPage(page);
+	}
 	up(&inode->i_sem);
-	return page;
+}
+
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
 }
 
 struct inode *shmem_get_inode(struct super_block *sb, int mode, int dev)
@@ -396,7 +469,8 @@
 			inode->i_fop = &shmem_dir_operations;
 			break;
 		case S_IFLNK:
-			BUG();
+			inode->i_op = &shmem_symlink_inode_operations;
+			break;
 		}
 		spin_lock (&shmem_ilock);
 		list_add (&inode->u.shmem_i.list, &shmem_inodes);
@@ -405,9 +479,221 @@
 	return inode;
 }
 
+#ifdef CONFIG_TMPFS
+static ssize_t
+shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
+{
+	struct inode	*inode = file->f_dentry->d_inode; 
+	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	loff_t		pos;
+	struct page	*page;
+	unsigned long	written;
+	long		status;
+	int		err;
+
+
+	down(&inode->i_sem);
+
+	pos = *ppos;
+	err = -EINVAL;
+	if (pos < 0)
+		goto out;
+
+	err = file->f_error;
+	if (err) {
+		file->f_error = 0;
+		goto out;
+	}
+
+	written = 0;
+
+	if (file->f_flags & O_APPEND)
+		pos = inode->i_size;
+
+	/*
+	 * Check whether we've reached the file size limit.
+	 */
+	err = -EFBIG;
+	if (limit != RLIM_INFINITY) {
+		if (pos >= limit) {
+			send_sig(SIGXFSZ, current, 0);
+			goto out;
+		}
+		if (count > limit - pos) {
+			send_sig(SIGXFSZ, current, 0);
+			count = limit - pos;
+		}
+	}
+
+	status	= 0;
+	if (count) {
+		remove_suid(inode);
+		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	}
+
+	while (count) {
+		unsigned long bytes, index, offset;
+		char *kaddr;
+		int deactivate = 1;
+
+		/*
+		 * Try to find the page in the cache. If it isn't there,
+		 * allocate a free page.
+		 */
+		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
+		index = pos >> PAGE_CACHE_SHIFT;
+		bytes = PAGE_CACHE_SIZE - offset;
+		if (bytes > count) {
+			bytes = count;
+			deactivate = 0;
+		}
+
+		/*
+		 * Bring in the user page that we will copy from _first_.
+		 * Otherwise there's a nasty deadlock on copying from the
+		 * same page as we're writing to, without it being marked
+		 * up-to-date.
+		 */
+		{ volatile unsigned char dummy;
+			__get_user(dummy, buf);
+			__get_user(dummy, buf+bytes-1);
+		}
+
+		page = shmem_getpage_locked(inode, index);
+		status = PTR_ERR(page);
+		if (IS_ERR(page))
+			break;
+
+		/* We have exclusive IO access to the page.. */
+		if (!PageLocked(page)) {
+			PAGE_BUG(page);
+		}
+
+		kaddr = kmap(page);
+// can this do a truncated write? cr
+		status = copy_from_user(kaddr+offset, buf, bytes);
+		kunmap(page);
+		if (status)
+			goto fail_write;
+
+		flush_dcache_page(page);
+		if (bytes > 0) {
+			SetPageDirty(page);
+			written += bytes;
+			count -= bytes;
+			pos += bytes;
+			buf += bytes;
+			if (pos > inode->i_size) 
+				inode->i_size = pos;
+			if (inode->u.shmem_i.max_index < index)
+				inode->u.shmem_i.max_index = index;
+
+		}
+unlock:
+		/* Mark it unlocked again and drop the page.. */
+		UnlockPage(page);
+		if (deactivate)
+			deactivate_page(page);
+		page_cache_release(page);
+
+		if (status < 0)
+			break;
+	}
+	*ppos = pos;
+
+	err = written ? written : status;
+out:
+	up(&inode->i_sem);
+	return err;
+fail_write:
+	status = -EFAULT;
+	ClearPageUptodate(page);
+	kunmap(page);
+	goto unlock;
+}
+
+static void do_shmem_file_read(struct file * filp, loff_t *ppos, read_descriptor_t * desc)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
+	unsigned long index, offset;
+	int nr = 1;
+
+	index = *ppos >> PAGE_CACHE_SHIFT;
+	offset = *ppos & ~PAGE_CACHE_MASK;
+
+	while (nr && desc->count) {
+		struct page *page;
+		unsigned long end_index, nr;
+
+		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+		if (index > end_index)
+			break;
+		nr = PAGE_CACHE_SIZE;
+		if (index == end_index) {
+			nr = inode->i_size & ~PAGE_CACHE_MASK;
+			if (nr <= offset)
+				break;
+		}
+
+		nr = nr - offset;
+
+		if ((desc->error = shmem_getpage(inode, index, &page)))
+			break;
+
+		if (mapping->i_mmap_shared != NULL)
+			flush_dcache_page(page);
+
+		/*
+		 * Ok, we have the page, and it's up-to-date, so
+		 * now we can copy it to user space...
+		 *
+		 * The actor routine returns how many bytes were actually used..
+		 * NOTE! This may not be the same as how much of a user buffer
+		 * we filled up (we may be padding etc), so we can only update
+		 * "pos" here (the actor routine has to update the user buffer
+		 * pointers and the remaining count).
+		 */
+		nr = file_read_actor(desc, page, offset, nr);
+		offset += nr;
+		index += offset >> PAGE_CACHE_SHIFT;
+		offset &= ~PAGE_CACHE_MASK;
+	
+		page_cache_release(page);
+	}
+
+	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
+	UPDATE_ATIME(inode);
+}
+
+static ssize_t shmem_file_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
+{
+	ssize_t retval;
+
+	retval = -EFAULT;
+	if (access_ok(VERIFY_WRITE, buf, count)) {
+		retval = 0;
+
+		if (count) {
+			read_descriptor_t desc;
+
+			desc.written = 0;
+			desc.count = count;
+			desc.buf = buf;
+			desc.error = 0;
+			do_shmem_file_read(filp, ppos, &desc);
+
+			retval = desc.written;
+			if (!retval)
+				retval = desc.error;
+		}
+	}
+	return retval;
+}
+
 static int shmem_statfs(struct super_block *sb, struct statfs *buf)
 {
-	buf->f_type = SHMEM_MAGIC;
+	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	spin_lock (&sb->u.shmem_sb.stat_lock);
 	if (sb->u.shmem_sb.max_blocks != ULONG_MAX || 
@@ -422,32 +708,6 @@
 	return 0;
 }
 
-void shmem_lock(struct file * file, int lock)
-{
-	struct inode * inode = file->f_dentry->d_inode;
-	struct shmem_inode_info * info = &inode->u.shmem_i;
-	struct page * page;
-	unsigned long idx, size;
-
-	if (info->locked == lock)
-		return;
-	down(&inode->i_sem);
-	info->locked = lock;
-	size = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	for (idx = 0; idx < size; idx++) {
-		page = find_lock_page(inode->i_mapping, idx);
-		if (!page)
-			continue;
-		if (!lock) {
-			/* release the extra count and our reference */
-			page_cache_release(page);
-			page_cache_release(page);
-		}
-		UnlockPage(page);
-	}
-	up(&inode->i_sem);
-}
-
 /*
  * Lookup the data. This is trivial - if the dentry didn't already
  * exist, we know it is negative.
@@ -575,19 +835,66 @@
 	return error;
 }
 
-static int shmem_mmap(struct file * file, struct vm_area_struct * vma)
+static int shmem_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
 {
-	struct vm_operations_struct * ops;
-	struct inode *inode = file->f_dentry->d_inode;
+	int error;
+	int len;
+	struct inode *inode;
+	struct page *page;
+	char *kaddr;
 
-	ops = &shmem_private_vm_ops;
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
-		ops = &shmem_shared_vm_ops;
-	if (!inode->i_sb || !S_ISREG(inode->i_mode))
-		return -EACCES;
-	UPDATE_ATIME(inode);
-	vma->vm_ops = ops;
+	error = shmem_mknod(dir, dentry, S_IFLNK | S_IRWXUGO, 0);
+	if (error)
+		return error;
+
+	len = strlen(symname);
+	if (len > PAGE_SIZE)
+		return -ENAMETOOLONG;
+		
+	inode = dentry->d_inode;
+	down(&inode->i_sem);
+	page = shmem_getpage_locked(inode, 0);
+	if (IS_ERR(page))
+		goto fail;
+	kaddr = kmap(page);
+	memcpy(kaddr, symname, len);
+	kunmap(page);
+	inode->i_size = len;
+	SetPageDirty(page);
+	UnlockPage(page);
+	page_cache_release(page);
+	up(&inode->i_sem);
 	return 0;
+fail:
+	up(&inode->i_sem);
+	return PTR_ERR(page);
+}
+
+static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+	struct page * page;
+	int res = shmem_getpage(dentry->d_inode, 0, &page);
+
+	if (res)
+		return res;
+
+	res = vfs_readlink(dentry,buffer,buflen, kmap(page));
+	kunmap(page);
+	page_cache_release(page);
+	return res;
+}
+
+static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct page * page;
+	int res = shmem_getpage(dentry->d_inode, 0, &page);
+	if (res)
+		return res;
+
+	res = vfs_follow_link(nd, kmap(page));
+	kunmap(page);
+	page_cache_release(page);
+	return res;
 }
 
 static int shmem_parse_options(char *options, int *mode, unsigned long * blocks, unsigned long *inodes)
@@ -600,16 +907,24 @@
 	for ( ; this_char; this_char = strtok(NULL,",")) {
 		if ((value = strchr(this_char,'=')) != NULL)
 			*value++ = 0;
-		if (!strcmp(this_char,"nr_blocks")) {
+		if (!strcmp(this_char,"size")) {
+			unsigned long long size;
 			if (!value || !*value || !blocks)
 				return 1;
-			*blocks = simple_strtoul(value,&value,0);
+			size = memparse(value,&value);
+			if (*value)
+				return 1;
+			*blocks = size >> PAGE_CACHE_SHIFT;
+		} else if (!strcmp(this_char,"nr_blocks")) {
+			if (!value || !*value || !blocks)
+				return 1;
+			*blocks = memparse(value,&value);
 			if (*value)
 				return 1;
 		} else if (!strcmp(this_char,"nr_inodes")) {
 			if (!value || !*value || !inodes)
 				return 1;
-			*inodes = simple_strtoul(value,&value,0);
+			*inodes = memparse(value,&value);
 			if (*value)
 				return 1;
 		} else if (!strcmp(this_char,"mode")) {
@@ -622,10 +937,38 @@
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
@@ -634,10 +977,12 @@
 	unsigned long inodes = ULONG_MAX;	/* unlimited */
 	int mode   = S_IRWXUGO | S_ISVTX;
 
+#ifdef CONFIG_TMPFS
 	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
-		printk(KERN_ERR "shmem fs invalid option\n");
+		printk(KERN_ERR "tmpfs invalid option\n");
 		return NULL;
 	}
+#endif
 
 	spin_lock_init (&sb->u.shmem_sb.stat_lock);
 	sb->u.shmem_sb.max_blocks = blocks;
@@ -646,7 +991,7 @@
 	sb->u.shmem_sb.free_inodes = inodes;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
-	sb->s_magic = SHMEM_MAGIC;
+	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
@@ -661,103 +1006,102 @@
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
-	mmap:		shmem_mmap
+	mmap:	shmem_mmap,
+#ifdef CONFIG_TMPFS
+	read:	shmem_file_read,
+	write:	shmem_file_write
+#endif
 };
 
 static struct inode_operations shmem_inode_operations = {
 	truncate:	shmem_truncate,
 };
 
+static struct inode_operations shmem_symlink_inode_operations = {
+	truncate:	shmem_truncate,
+#ifdef CONFIG_TMPFS
+	readlink:	shmem_readlink,
+	follow_link:	shmem_follow_link,
+#endif
+};
+
 static struct file_operations shmem_dir_operations = {
 	read:		generic_read_dir,
 	readdir:	dcache_readdir,
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
+#ifdef CONFIG_TMPFS
 	create:		shmem_create,
 	lookup:		shmem_lookup,
 	link:		shmem_link,
 	unlink:		shmem_unlink,
+	symlink:	shmem_symlink,
 	mkdir:		shmem_mkdir,
 	rmdir:		shmem_rmdir,
 	mknod:		shmem_mknod,
 	rename:		shmem_rename,
+#endif
 };
 
 static struct super_operations shmem_ops = {
+#ifdef CONFIG_TMPFS
 	statfs:		shmem_statfs,
 	remount_fs:	shmem_remount_fs,
+#endif
 	delete_inode:	shmem_delete_inode,
 	put_inode:	force_delete,	
 };
 
-static struct vm_operations_struct shmem_private_vm_ops = {
-	nopage:	shmem_nopage,
-};
-
-static struct vm_operations_struct shmem_shared_vm_ops = {
+static struct vm_operations_struct shmem_vm_ops = {
 	nopage:	shmem_nopage,
 };
 
+#ifdef CONFIG_TMPFS
+/* type "shm" will be tagged obsolete in 2.5 */
 static DECLARE_FSTYPE(shmem_fs_type, "shm", shmem_read_super, FS_LITTER);
+static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER);
+#else
+static DECLARE_FSTYPE(tmpfs_fs_type, "tmpfs", shmem_read_super, FS_LITTER|FS_NOMOUNT);
+#endif
 
 static int __init init_shmem_fs(void)
 {
 	int error;
 	struct vfsmount * res;
 
+	if ((error = register_filesystem(&tmpfs_fs_type))) {
+		printk (KERN_ERR "Could not register tmpfs\n");
+		return error;
+	}
+#ifdef CONFIG_TMPFS
 	if ((error = register_filesystem(&shmem_fs_type))) {
-		printk (KERN_ERR "Could not register shmem fs\n");
+		printk (KERN_ERR "Could not register shm fs\n");
 		return error;
 	}
-
-	res = kern_mount(&shmem_fs_type);
+	devfs_mk_dir (NULL, "shm", NULL);
+#endif
+	res = kern_mount(&tmpfs_fs_type);
 	if (IS_ERR (res)) {
-		printk (KERN_ERR "could not kern_mount shmem fs\n");
-		unregister_filesystem(&shmem_fs_type);
+		printk (KERN_ERR "could not kern_mount tmpfs\n");
+		unregister_filesystem(&tmpfs_fs_type);
 		return PTR_ERR(res);
 	}
 
-	devfs_mk_dir (NULL, "shm", NULL);
 	return 0;
 }
 
 static void __exit exit_shmem_fs(void)
 {
+#ifdef CONFIG_TMPFS
 	unregister_filesystem(&shmem_fs_type);
+#endif
+	unregister_filesystem(&tmpfs_fs_type);
 }
 
 module_init(init_shmem_fs)
@@ -853,7 +1197,7 @@
 	this.name = name;
 	this.len = strlen(name);
 	this.hash = 0; /* will go */
-	root = shmem_fs_type.kern_mnt->mnt_root;
+	root = tmpfs_fs_type.kern_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
 		goto out;
@@ -870,7 +1214,8 @@
 
 	d_instantiate(dentry, inode);
 	dentry->d_inode->i_size = size;
-	file->f_vfsmnt = mntget(shmem_fs_type.kern_mnt);
+	shmem_truncate(inode);
+	file->f_vfsmnt = mntget(tmpfs_fs_type.kern_mnt);
 	file->f_dentry = dentry;
 	file->f_op = &shmem_file_operations;
 	file->f_mode = FMODE_WRITE | FMODE_READ;
@@ -901,6 +1246,8 @@
 	if (vma->vm_file)
 		fput (vma->vm_file);
 	vma->vm_file = file;
-	vma->vm_ops = &shmem_shared_vm_ops;
+	vma->vm_ops = &shmem_vm_ops;
 	return 0;
 }
+
+EXPORT_SYMBOL(shmem_file_setup);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
