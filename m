Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261925AbREQPIR>; Thu, 17 May 2001 11:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbREQPII>; Thu, 17 May 2001 11:08:08 -0400
Received: from smtpde03.sap-ag.de ([194.39.131.54]:9665 "EHLO
	smtpde03.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261925AbREQPH4>; Thu, 17 May 2001 11:07:56 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] tmpfs accounting cleanup for -ac series
Organisation: SAP LinuxLab
Date: 17 May 2001 17:02:06 +0200
Message-ID: <m3itj0t3wx.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

While looking at the -ac version of ramfs I noticed that there is a
new address operation introduced which I can use to cleanup shmem.

This patch throws away some magic recalculation and makes the
accounting of shmem accurate.

It also encapsulates all accesses to the superblock_info into a macro.

The patch is on top of my previous ones.

Greetings
		Christoph

diff -uNr 4-ac9/fs/proc/proc_misc.c c/fs/proc/proc_misc.c
--- 4-ac9/fs/proc/proc_misc.c	Thu May 17 13:17:37 2001
+++ c/fs/proc/proc_misc.c	Thu May 17 13:11:30 2001
@@ -140,17 +140,9 @@
 {
 	struct sysinfo i;
 	int len;
-	unsigned int cached, shmem;
+	unsigned int cached;
 
-	/*
-	 * There may be some inconsistency because shmem_nrpages
-	 * update is delayed to page_cache_size
-	 * We make sure the cached value does not get below zero 
-	 */
-	cached = atomic_read(&page_cache_size);
-	shmem  = atomic_read(&shmem_nrpages);
-	if (shmem < cached)
-		cached -= shmem;
+	cached = atomic_read(&page_cache_size) - atomic_read(&shmem_nrpages);
 
 /*
  * display in kilobytes.
diff -uNr 4-ac9/mm/mmap.c c/mm/mmap.c
--- 4-ac9/mm/mmap.c	Thu May 17 13:17:37 2001
+++ c/mm/mmap.c	Thu May 17 10:54:22 2001
@@ -56,24 +56,14 @@
 	 */
 
 	long free;
-	unsigned long cached, shmem;
-
-	/*
-	 * There may be some inconsistency because shmem_nrpages
-	 * update is delayed to the page_cache_size
-	 * We make sure the cached value does not get below zero 
-	 */
-	cached = atomic_read(&page_cache_size);
-	shmem  = atomic_read(&shmem_nrpages);
-	if (cached > shmem)
-		cached -= shmem;
 
         /* Sometimes we want to use more memory than we have. */
 	if (sysctl_overcommit_memory)
 	    return 1;
 
 	free = atomic_read(&buffermem_pages);
-	free += cached;
+	free += atomic_read(&page_cache_size) ;
+	free -= atomic_read(&shmem_nrpages);
 	free += nr_free_pages();
 	free += nr_swap_pages;
 
diff -uNr 4-ac9/mm/shmem.c c/mm/shmem.c
--- 4-ac9/mm/shmem.c	Thu May 17 13:17:37 2001
+++ c/mm/shmem.c	Thu May 17 10:54:03 2001
@@ -35,6 +35,8 @@
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
 
+#define SHMEM_SB(sb) (&sb->u.shmem_sb)
+
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
 static struct file_operations shmem_file_operations;
@@ -50,44 +52,6 @@
 #define BLOCKS_PER_PAGE (PAGE_SIZE/512)
 
 /*
- * shmem_recalc_inode - recalculate the size of an inode
- *
- * @inode: inode to recalc
- * @swap:  additional swap pages freed externally
- *
- * We have to calculate the free blocks since the mm can drop pages
- * behind our back
- *
- * But we know that normally
- * inodes->i_blocks/BLOCKS_PER_PAGE == 
- * 			inode->i_mapping->nrpages + info->swapped
- *
- * So the mm freed 
- * inodes->i_blocks/BLOCKS_PER_PAGE - 
- *			(inode->i_mapping->nrpages + info->swapped)
- *
- * It has to be called with the spinlock held.
- *
- * The swap parameter is a performance hack for truncate.
- */
-
-static void shmem_recalc_inode(struct inode * inode, unsigned long swap)
-{
-	unsigned long freed;
-
-	freed = (inode->i_blocks/BLOCKS_PER_PAGE) -
-		(inode->i_mapping->nrpages + SHMEM_I(inode)->swapped);
-	if (freed){
-		struct shmem_sb_info * info = &inode->i_sb->u.shmem_sb;
-		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
-		spin_lock (&info->stat_lock);
-		info->free_blocks += freed;
-		spin_unlock (&info->stat_lock);
-		atomic_sub(freed-swap, &shmem_nrpages);
-	}
-}
-
-/*
  * shmem_swp_entry - find the swap vector position in the info structure
  *
  * @info:  info structure for the inode
@@ -318,6 +282,7 @@
 	unsigned long index;
 	unsigned long freed = 0;
 	struct shmem_inode_info * info = SHMEM_I(inode);
+	struct shmem_sb_info * sbinfo = SHMEM_SB(inode->i_sb);
 
 	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
@@ -328,14 +293,28 @@
 		freed += shmem_truncate_indirect(info, index);
 
 	info->swapped -= freed;
-	shmem_recalc_inode(inode, freed);
+	spin_lock(&sbinfo->stat_lock);
+	sbinfo->free_blocks += freed;
+	spin_unlock(&sbinfo->stat_lock);
 	spin_unlock (&info->lock);
 	up(&info->sem);
 }
 
+static void shmem_truncatepage(struct page *page)
+{
+	struct inode *inode = (struct inode *)page->mapping->host;
+	struct shmem_sb_info * sbinfo = SHMEM_SB(inode->i_sb);
+
+	inode->i_blocks -= BLOCKS_PER_PAGE;
+	spin_lock (&sbinfo->stat_lock);
+	sbinfo->free_blocks++;
+	spin_unlock (&sbinfo->stat_lock);
+	atomic_dec(&shmem_nrpages);
+}
+
 static void shmem_delete_inode(struct inode * inode)
 {
-	struct shmem_sb_info *info = &inode->i_sb->u.shmem_sb;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
 	inode->i_size = 0;
 	if (inode->i_op->truncate == shmem_truncate){ 
@@ -344,9 +323,9 @@
 		spin_unlock (&shmem_ilock);
 		shmem_truncate(inode);
 	}
-	spin_lock (&info->stat_lock);
-	info->free_inodes++;
-	spin_unlock (&info->stat_lock);
+	spin_lock (&sbinfo->stat_lock);
+	sbinfo->free_inodes++;
+	spin_unlock (&sbinfo->stat_lock);
 	clear_inode(inode);
 }
 
@@ -383,7 +362,6 @@
 	entry = shmem_swp_entry(info, page->index, 0);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
-	shmem_recalc_inode(page->mapping->host, 0);
 	error = -EAGAIN;
 	if (entry->val)
 		BUG();
@@ -421,6 +399,7 @@
 static struct page * shmem_getpage_locked(struct shmem_inode_info *info, struct inode * inode, unsigned long idx)
 {
 	struct address_space * mapping = inode->i_mapping;
+	struct shmem_sb_info * sbinfo;
 	struct page * page;
 	swp_entry_t *entry;
 
@@ -487,12 +466,13 @@
 		info->swapped--;
 		spin_unlock (&info->lock);
 	} else {
+		sbinfo = SHMEM_SB(inode->i_sb);
 		spin_unlock (&info->lock);
-		spin_lock (&inode->i_sb->u.shmem_sb.stat_lock);
-		if (inode->i_sb->u.shmem_sb.free_blocks == 0)
+		spin_lock (&sbinfo->stat_lock);
+		if (sbinfo->free_blocks == 0)
 			goto no_space;
-		inode->i_sb->u.shmem_sb.free_blocks--;
-		spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
+		sbinfo->free_blocks--;
+		spin_unlock (&sbinfo->stat_lock);
 
 		/* Ok, get a new page.  We don't have to worry about the
 		 * info->lock spinlock here: we cannot race against
@@ -516,7 +496,7 @@
 		page_cache_get(page);
 	return page;
 no_space:
-	spin_unlock (&inode->i_sb->u.shmem_sb.stat_lock);
+	spin_unlock (&sbinfo->stat_lock);
 	return ERR_PTR(-ENOSPC);
 
 wait_retry:
@@ -638,14 +618,15 @@
 {
 	struct inode * inode;
 	struct shmem_inode_info *info;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
-	spin_lock (&sb->u.shmem_sb.stat_lock);
-	if (!sb->u.shmem_sb.free_inodes) {
-		spin_unlock (&sb->u.shmem_sb.stat_lock);
+	spin_lock (&sbinfo->stat_lock);
+	if (!sbinfo->free_inodes) {
+		spin_unlock (&sbinfo->stat_lock);
 		return NULL;
 	}
-	sb->u.shmem_sb.free_inodes--;
-	spin_unlock (&sb->u.shmem_sb.stat_lock);
+	sbinfo->free_inodes--;
+	spin_unlock (&sbinfo->stat_lock);
 
 	inode = new_inode(sb);
 	if (inode) {
@@ -903,24 +884,26 @@
 
 static int shmem_statfs(struct super_block *sb, struct statfs *buf)
 {
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
+
 	buf->f_type = TMPFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
-	spin_lock (&sb->u.shmem_sb.stat_lock);
-	if (sb->u.shmem_sb.max_blocks == ULONG_MAX) {
+	spin_lock (&sbinfo->stat_lock);
+	if (sbinfo->max_blocks == ULONG_MAX) {
 		/*
 		 * This is only a guestimate and not honoured.
 		 * We need it to make some programs happy which like to
 		 * test the free space of a file system.
 		 */
 		buf->f_bavail = buf->f_bfree = nr_free_pages() + nr_swap_pages + atomic_read(&buffermem_pages);
-		buf->f_blocks = buf->f_bfree + ULONG_MAX - sb->u.shmem_sb.free_blocks;
+		buf->f_blocks = buf->f_bfree + ULONG_MAX - sbinfo->free_blocks;
 	} else {
-		buf->f_blocks = sb->u.shmem_sb.max_blocks;
-		buf->f_bavail = buf->f_bfree = sb->u.shmem_sb.free_blocks;
+		buf->f_blocks = sbinfo->max_blocks;
+		buf->f_bavail = buf->f_bfree = sbinfo->free_blocks;
 	}
-	buf->f_files = sb->u.shmem_sb.max_inodes;
-	buf->f_ffree = sb->u.shmem_sb.free_inodes;
-	spin_unlock (&sb->u.shmem_sb.stat_lock);
+	buf->f_files = sbinfo->max_inodes;
+	buf->f_ffree = sbinfo->free_inodes;
+	spin_unlock (&sbinfo->stat_lock);
 	buf->f_namelen = 255;
 	return 0;
 }
@@ -1202,26 +1185,26 @@
 	int error;
 	unsigned long max_blocks, blocks;
 	unsigned long max_inodes, inodes;
-	struct shmem_sb_info *info = &sb->u.shmem_sb;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
 	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 
-	spin_lock(&info->stat_lock);
-	blocks = info->max_blocks - info->free_blocks;
-	inodes = info->max_inodes - info->free_inodes;
+	spin_lock(&sbinfo->stat_lock);
+	blocks = sbinfo->max_blocks - sbinfo->free_blocks;
+	inodes = sbinfo->max_inodes - sbinfo->free_inodes;
 	error = -EINVAL;
 	if (max_blocks < blocks)
 		goto out;
 	if (max_inodes < inodes)
 		goto out;
 	error = 0;
-	info->max_blocks  = max_blocks;
-	info->free_blocks = max_blocks - blocks;
-	info->max_inodes  = max_inodes;
-	info->free_inodes = max_inodes - inodes;
+	sbinfo->max_blocks  = max_blocks;
+	sbinfo->free_blocks = max_blocks - blocks;
+	sbinfo->max_inodes  = max_inodes;
+	sbinfo->free_inodes = max_inodes - inodes;
 out:
-	spin_unlock(&info->stat_lock);
+	spin_unlock(&sbinfo->stat_lock);
 	return error;
 }
 
@@ -1238,6 +1221,7 @@
 	unsigned long blocks = ULONG_MAX;	/* unlimited */
 	unsigned long inodes = ULONG_MAX;	/* unlimited */
 	int mode   = S_IRWXUGO | S_ISVTX;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
 #ifdef CONFIG_TMPFS
 	if (shmem_parse_options (data, &mode, &blocks, &inodes)) {
@@ -1246,11 +1230,11 @@
 	}
 #endif
 
-	spin_lock_init (&sb->u.shmem_sb.stat_lock);
-	sb->u.shmem_sb.max_blocks = blocks;
-	sb->u.shmem_sb.free_blocks = blocks;
-	sb->u.shmem_sb.max_inodes = inodes;
-	sb->u.shmem_sb.free_inodes = inodes;
+	spin_lock_init (&sbinfo->stat_lock);
+	sbinfo->max_blocks = blocks;
+	sbinfo->free_blocks = blocks;
+	sbinfo->max_inodes = inodes;
+	sbinfo->free_inodes = inodes;
 	sb->s_maxbytes = (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
@@ -1272,7 +1256,8 @@
 
 
 static struct address_space_operations shmem_aops = {
-	writepage: shmem_writepage
+	truncatepage: shmem_truncatepage,
+	writepage: shmem_writepage,
 };
 
 static struct file_operations shmem_file_operations = {

