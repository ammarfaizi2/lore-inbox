Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUAMUBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUAMUBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:01:09 -0500
Received: from [12.177.129.25] ([12.177.129.25]:12228 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S265268AbUAMUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:00:04 -0500
Message-Id: <200401132021.i0DKLBhg002890@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] /dev/anon
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Jan 2004 15:21:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has a need to free dirty pages in the middle of a file (which is described
in more detail below).  The obvious way to do this, and one which has come up 
before, is a sys_punch system call for making a hole in the middle of a file.
Since I need something like this now, and sys_punch is not immediately 
forthcoming, I implemented a special device which implements the semantics
that UML needs.

/dev/anon acts just like anonymous memory, except for not being anonymous.
It implements the memory freeing semantics by keeping track of how many times
each page is mapped, and freeing pages when the map count goes to zero.

I did it by mashing the map counting into tmpfs.  I've attached the patch
(against 2.4.23) below.  The main additions are
	a munmap file_operation which is called from do_munmap
	map counts in a structure that's parallel to the swap entries in tmpfs
	a new misc device at minor 10

Comments on the implementation are welcome, as I'm not particularly proud of 
it, but nothing else came to mind quickly.

If this should be maintained out-of-tree, should I get an official minor for
it anyway, or just unofficially use the first unused misc minor (10 in 2.4,
11 in 2.6)?

I'd also like opinions on whether this (or something like it) is sane enough to
go into mainline, or whether I should just keep it as a out-of-tree patch until
sys_punch shows up.  

The immediate need for this would go away as soon as we got sys_punch.

On the other hand, a file backing anonymous memory seems superficially 
attractive because it can get rid of the vma->vm_file == NULL special cases
scattered through the VM system.  vm_file is expected to be the backing file
for the data, which doesn't work so well for in-memory filesystems.  tmpfs
seems to know a lot about swapping pages out.  It might be a good idea to
resurrect the old swapfs idea and turn tmpfs into that.  Then I guess vm_pgoff
would become the equivalent of a swp_entry, which raises the question of what
goes into a pte of a swapped-out page.  Current convention says it becomes
0, which seems a bit wasteful.  It's also not clear what vm_pgoff for an
in-memory page would be.  vmas like their data to be contiguous in the backing
file, which suggests that there would be a swapfs file per process, with 
contiguous anonymous memory being contiguous in the swap file, if not on the
actual device.

				Jeff


Rationale:

	UML uses a mmapped tmp file for its physical memory.  When it reads
from disk, it allocates a page of this memory for the page cache, then calls 
the ubd block driver to fill it, which does a read() on the host from the 
file backing the device.  This results in two copies of the data in the host's
memory, one in the host page cache, and one in this tmp file for the UML page
cache.  These duplicate copies can be eliminated by mmapping pages from the
device's file into UML physical memory.  However, in order to get any memory
savings on the host, the tmp file page which was mapped over needs to be
freed, which no filesystem will do.  Hence the need for sys_punch or /dev/anon.

In the testing I've done, booting my Debian image takes about 25% less host
memory with ubd-mmap and /dev/anon than without (~28M vs ~21M), with a 
corresponding 25% increase in the number of UMLs I can boot before the host
starts swapping (20 vs 16).

The patch:

diff -Naur host-2.4.23-skas3/drivers/char/mem.c host-2.4.23-skas3-devanon/drivers/char/mem.c
--- host-2.4.23-skas3/drivers/char/mem.c	2003-12-16 22:16:27.000000000 -0500
+++ host-2.4.23-skas3-devanon/drivers/char/mem.c	2004-01-09 04:09:26.000000000 -0500
@@ -664,6 +664,8 @@
 	write:		write_full,
 };
 
+extern struct file_operations anon_file_operations;
+
 static int memory_open(struct inode * inode, struct file * filp)
 {
 	switch (MINOR(inode->i_rdev)) {
@@ -693,6 +695,9 @@
 		case 9:
 			filp->f_op = &urandom_fops;
 			break;
+		case 10:
+		        filp->f_op = &anon_file_operations;
+			break;
 		default:
 			return -ENXIO;
 	}
@@ -719,7 +724,8 @@
 	{5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},
 	{7, "full",    S_IRUGO | S_IWUGO,           &full_fops},
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
-	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops}
+	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
+	{10, "anon", S_IRUGO | S_IWUSR,             &anon_file_operations},
     };
     int i;
 
diff -Naur host-2.4.23-skas3/include/linux/fs.h host-2.4.23-skas3-devanon/include/linux/fs.h
--- host-2.4.23-skas3/include/linux/fs.h	2003-12-16 22:16:36.000000000 -0500
+++ host-2.4.23-skas3-devanon/include/linux/fs.h	2004-01-10 00:59:17.000000000 -0500
@@ -864,6 +864,8 @@
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
+	void (*munmap) (struct file *, struct vm_area_struct *, 
+			unsigned long start, unsigned long len);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
 	int (*release) (struct inode *, struct file *);
diff -Naur host-2.4.23-skas3/include/linux/shmem_fs.h host-2.4.23-skas3-devanon/include/linux/shmem_fs.h
--- host-2.4.23-skas3/include/linux/shmem_fs.h	2003-09-02 15:44:03.000000000 -0400
+++ host-2.4.23-skas3-devanon/include/linux/shmem_fs.h	2004-01-09 04:09:26.000000000 -0500
@@ -22,6 +22,8 @@
 	unsigned long		next_index;
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	void		      **i_indirect; /* indirect blocks */
+	unsigned long		map_direct[SHMEM_NR_DIRECT];
+	void 		      **map_indirect;
 	unsigned long		swapped;    /* data pages assigned to swap */
 	unsigned long		flags;
 	struct list_head	list;
diff -Naur host-2.4.23-skas3/Makefile host-2.4.23-skas3-devanon/Makefile
--- host-2.4.23-skas3/Makefile	2003-12-16 22:16:23.000000000 -0500
+++ host-2.4.23-skas3-devanon/Makefile	2004-01-11 02:39:25.000000000 -0500
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 23
-EXTRAVERSION =
+EXTRAVERSION = -devanon
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 
diff -Naur host-2.4.23-skas3/mm/mmap.c host-2.4.23-skas3-devanon/mm/mmap.c
--- host-2.4.23-skas3/mm/mmap.c	2004-01-09 03:50:00.000000000 -0500
+++ host-2.4.23-skas3-devanon/mm/mmap.c	2004-01-09 04:09:26.000000000 -0500
@@ -995,6 +995,11 @@
 		remove_shared_vm_struct(mpnt);
 		mm->map_count--;
 
+		if((mpnt->vm_file != NULL) && (mpnt->vm_file->f_op != NULL) &&
+		   (mpnt->vm_file->f_op->munmap != NULL))
+		        mpnt->vm_file->f_op->munmap(mpnt->vm_file, mpnt, st, 
+						    size);
+
 		zap_page_range(mm, st, size);
 
 		/*
diff -Naur host-2.4.23-skas3/mm/shmem.c host-2.4.23-skas3-devanon/mm/shmem.c
--- host-2.4.23-skas3/mm/shmem.c	2003-12-16 22:16:36.000000000 -0500
+++ host-2.4.23-skas3-devanon/mm/shmem.c	2004-01-10 01:10:59.000000000 -0500
@@ -128,16 +128,17 @@
  * 	      	       +-> 48-51
  * 	      	       +-> 52-55
  */
-static swp_entry_t *shmem_swp_entry(struct shmem_inode_info *info, unsigned long index, unsigned long *page)
+static void *shmem_block(unsigned long index, unsigned long *page,
+			 unsigned long *direct, void ***indirect)
 {
 	unsigned long offset;
 	void **dir;
 
 	if (index < SHMEM_NR_DIRECT)
-		return info->i_direct+index;
-	if (!info->i_indirect) {
+		return direct+index;
+	if (!*indirect) {
 		if (page) {
-			info->i_indirect = (void **) *page;
+			*indirect = (void **) *page;
 			*page = 0;
 		}
 		return NULL;			/* need another page */
@@ -146,7 +147,7 @@
 	index -= SHMEM_NR_DIRECT;
 	offset = index % ENTRIES_PER_PAGE;
 	index /= ENTRIES_PER_PAGE;
-	dir = info->i_indirect;
+	dir = *indirect;
 
 	if (index >= ENTRIES_PER_PAGE/2) {
 		index -= ENTRIES_PER_PAGE/2;
@@ -169,7 +170,21 @@
 		*dir = (void *) *page;
 		*page = 0;
 	}
-	return (swp_entry_t *) *dir + offset;
+	return (unsigned long **) *dir + offset;
+}
+
+static swp_entry_t *shmem_swp_entry(struct shmem_inode_info *info, unsigned long index, unsigned long *page)
+{
+	return((swp_entry_t *) shmem_block(index, page, 
+					   (unsigned long *) info->i_direct, 
+					   &info->i_indirect));
+}
+
+static unsigned long *shmem_map_count(struct shmem_inode_info *info, 
+				      unsigned long index, unsigned long *page)
+{
+	return((unsigned long *) shmem_block(index, page, info->map_direct, 
+					     &info->map_indirect));
 }
 
 /*
@@ -838,6 +853,7 @@
 	ops = &shmem_vm_ops;
 	if (!S_ISREG(inode->i_mode))
 		return -EACCES;
+
 	UPDATE_ATIME(inode);
 	vma->vm_ops = ops;
 	return 0;
@@ -1723,4 +1739,131 @@
 	return 0;
 }
 
+static int adjust_map_counts(struct shmem_inode_info *info, 
+			     unsigned long offset, unsigned long len, 
+			     int adjust)
+{
+	unsigned long idx, i, *count, page = 0;
+
+	spin_lock(&info->lock);
+	len >>= PAGE_SHIFT;
+	for(i = 0; i < len; i++){
+		idx = (i + offset) >> (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+
+		while((count = shmem_map_count(info, idx, &page)) == NULL){
+			spin_unlock(&info->lock);
+			page = get_zeroed_page(GFP_KERNEL);
+			if(page == 0)
+				return(-ENOMEM);
+			spin_lock(&info->lock);
+		}
+
+		if(page != 0)
+			free_page(page);
+
+		*count += adjust;
+	}
+	spin_unlock(&info->lock);
+	return(0);
+}
+
 EXPORT_SYMBOL(shmem_file_setup);
+
+struct file_operations anon_file_operations;
+
+static int anon_mmap(struct file *file, struct vm_area_struct *vma)
+{
+        struct file *new;
+	struct inode *inode;
+	loff_t size = vma->vm_end - vma->vm_start;
+	int err;
+
+	if(file->private_data == NULL){
+	        new = shmem_file_setup("dev/anon", size);
+		if(IS_ERR(new))
+			return(PTR_ERR(new));
+
+		new->f_op = &anon_file_operations;
+		file->private_data = new;
+	}
+	
+	if (vma->vm_file)
+		fput(vma->vm_file);
+	vma->vm_file = file->private_data;
+	get_file(vma->vm_file);
+
+	inode = vma->vm_file->f_dentry->d_inode;
+	err = adjust_map_counts(SHMEM_I(inode), vma->vm_pgoff, size, 1);
+	if(err)
+		return(err);
+
+	vma->vm_ops = &shmem_vm_ops;
+	return 0;
+}
+
+static void anon_munmap(struct file *file, struct vm_area_struct *vma, 
+			unsigned long start, unsigned long len)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	swp_entry_t *entry;
+	struct page *page;
+	unsigned long addr, idx, *count;
+
+	for(addr = start; addr < start + len; addr += PAGE_SIZE){
+	        idx = ((addr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
+
+		count = shmem_map_count(info, idx, NULL);
+		if(count == NULL)
+			continue;
+
+		(*count)--;
+		if(*count > 0)
+			continue;
+
+		pgd = pgd_offset(vma->vm_mm, addr);
+		if(pgd_none(*pgd))
+			continue;
+
+		pmd = pmd_offset(pgd, addr);
+		if(pmd_none(*pmd))
+			continue;
+
+		pte = pte_offset(pmd, addr);
+		if(!pte_present(*pte))
+			continue;
+
+		*pte = pte_mkclean(*pte);
+
+		page = pte_page(*pte);
+
+		LockPage(page);
+		lru_cache_del(page);
+		ClearPageDirty(page);
+		ClearPageUptodate(page);
+		remove_inode_page(page);
+		UnlockPage(page);
+
+		entry = shmem_swp_entry(info, idx, 0);
+		if(entry != NULL)
+			shmem_free_swp(entry, 1);
+
+		page_cache_release(page);
+	}
+}
+
+int anon_release(struct inode *inode, struct file *file)
+{
+	if(file->private_data != NULL)
+		fput(file->private_data);
+	return(0);
+}
+
+struct file_operations anon_file_operations = {
+	.mmap		= anon_mmap,
+	.munmap 	= anon_munmap,
+	.release	= anon_release,
+};


