Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbREOIiA>; Tue, 15 May 2001 04:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbREOIhv>; Tue, 15 May 2001 04:37:51 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:6028 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S262681AbREOIhi>; Tue, 15 May 2001 04:37:38 -0400
From: Christoph Rohland <cr@sap.com>
To: schwidefsky@de.ibm.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] allow tmpfs bigger than 1GB on s390x
Organisation: SAP LinuxLab
Date: 15 May 2001 10:33:30 +0200
Message-ID: <m366f3810l.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi Martin,

Here is the patch which implements triple indirect blocks in
tmpfs. 

For the rest of the word: This is needed since s390x is a 64 Bit
platform with pagesize of 4k :-(

It is on top of my other tmpfs fixes which you can find at
ftp://ftp.sap.com/pub/linuxlab/people/cr

Greetings
		Christoph


--=-=-=
Content-Disposition: attachment; filename=patch-7-triple2

diff -uNr 4-mSsas/include/linux/shmem_fs.h 4-mSsasb/include/linux/shmem_fs.h
--- 4-mSsas/include/linux/shmem_fs.h	Mon May 14 08:49:42 2001
+++ 4-mSsasb/include/linux/shmem_fs.h	Mon May 14 09:05:39 2001
@@ -22,9 +22,9 @@
 struct shmem_inode_info {
 	spinlock_t		lock;
 	struct semaphore 	sem;
-	unsigned long		max_index;
+	unsigned long		next_index;
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
-	swp_entry_t           **i_indirect; /* doubly indirect blocks */
+	void		      **i_indirect; /* indirect blocks */
 	unsigned long		swapped;
 	int			locked;     /* into memory */
 	struct list_head	list;
diff -uNr 4-mSsas/mm/shmem.c 4-mSsasb/mm/shmem.c
--- 4-mSsas/mm/shmem.c	Mon May 14 08:49:42 2001
+++ 4-mSsasb/mm/shmem.c	Tue May 15 09:12:00 2001
@@ -34,7 +34,6 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
-#define NR_SINGLE (ENTRIES_PER_PAGE + SHMEM_NR_DIRECT)
 
 static struct super_operations shmem_ops;
 static struct address_space_operations shmem_aops;
@@ -65,7 +64,7 @@
  *
  * So the mm freed 
  * inodes->i_blocks/BLOCKS_PER_PAGE - 
- * 			(inode->i_mapping->nrpages + info->swapped)
+ *			(inode->i_mapping->nrpages + info->swapped)
  *
  * It has to be called with the spinlock held.
  *
@@ -88,9 +87,53 @@
 	}
 }
 
-static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index) 
+/*
+ * shmem_swp_entry - find the swap vector position in the info structure
+ *
+ * @info:  info structure for the inode
+ * @index: index of the page to find
+ * @page:  optional page to add to the structure. Has to be preset to
+ *         all zeros
+ *
+ * If there is no space allocated yet it will return -ENOMEM when
+ * page == 0 else it will use the page for the needed block.
+ *
+ * returns -EFBIG if the index is too big.
+ *
+ *
+ * The swap vector is organized the following way:
+ *
+ * There are SHMEM_NR_DIRECT entries directly stored in the
+ * shmem_inode_info structure. So small files do not need an addional
+ * allocation.
+ *
+ * For pages with index > SHMEM_NR_DIRECT there is the pointer
+ * i_indirect which points to a page which holds in the first half
+ * doubly indirect blocks, in the second half triple indirect blocks:
+ *
+ * For an artificial ENTRIES_PER_PAGE = 4 this would lead to the
+ * following layout (for SHMEM_NR_DIRECT == 16):
+ *
+ * i_indirect -> dir --> 16-19
+ * 	      |	     +-> 20-23
+ * 	      |
+ * 	      +-->dir2 --> 24-27
+ * 	      |	       +-> 28-31
+ * 	      |	       +-> 32-35
+ * 	      |	       +-> 36-39
+ * 	      |
+ * 	      +-->dir3 --> 40-43
+ * 	       	       +-> 44-47
+ * 	      	       +-> 48-51
+ * 	      	       +-> 52-55
+ */
+
+#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE * ENTRIES_PER_PAGE/2*(ENTRIES_PER_PAGE+1))
+
+static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index, unsigned long page) 
 {
 	unsigned long offset;
+	void **dir;
 
 	if (index < SHMEM_NR_DIRECT)
 		return info->i_direct+index;
@@ -99,23 +142,66 @@
 	offset = index % ENTRIES_PER_PAGE;
 	index /= ENTRIES_PER_PAGE;
 
-	if (index >= ENTRIES_PER_PAGE)
-		return ERR_PTR(-EFBIG);
-
 	if (!info->i_indirect) {
-		info->i_indirect = (swp_entry_t **) get_zeroed_page(GFP_USER);
-		if (!info->i_indirect)
+		info->i_indirect = (void *) page;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dir = info->i_indirect + index;
+	if (index >= ENTRIES_PER_PAGE/2) {
+		index -= ENTRIES_PER_PAGE/2;
+		dir = info->i_indirect + ENTRIES_PER_PAGE/2 
+			+ index/ENTRIES_PER_PAGE;
+		index %= ENTRIES_PER_PAGE;
+
+		if(!*dir) {
+			*dir = (void *) page;
+			/* We return since we will need another page
+                           in the next step */
 			return ERR_PTR(-ENOMEM);
+		}
+		dir = ((void **)*dir) + index;
 	}
-	if(!(info->i_indirect[index])) {
-		info->i_indirect[index] = (swp_entry_t *) get_zeroed_page(GFP_USER);
-		if (!info->i_indirect[index])
+	if (!*dir) {
+		if (!page)
 			return ERR_PTR(-ENOMEM);
+		*dir = (void *)page;
 	}
-	
-	return info->i_indirect[index]+offset;
+	return ((swp_entry_t *)*dir) + offset;
 }
 
+/*
+ * shmem_alloc_entry - get the position of the swap entry for the
+ *                     page. If it does not exist allocate the entry
+ *
+ * @info:	info structure for the inode
+ * @index:	index of the page to find
+ */
+static inline swp_entry_t * shmem_alloc_entry (struct shmem_inode_info *info, unsigned long index)
+{
+	unsigned long page = 0;
+	swp_entry_t * res;
+
+	if (index >= SHMEM_MAX_BLOCKS)
+		return ERR_PTR(-EFBIG);
+
+	if (info->next_index <= index)
+		info->next_index = index + 1;
+
+	while ((res = shmem_swp_entry(info,index,page)) == ERR_PTR(-ENOMEM)) {
+		page = get_zeroed_page(GFP_USER);
+		if (!page)
+			break;
+	}
+	return res;
+}
+
+/*
+ * shmem_free_swp - free some swap entries in a directory
+ *
+ * @dir:   pointer to the directory
+ * @count: number of entries to scan
+ */
 static int shmem_free_swp(swp_entry_t *dir, unsigned int count)
 {
 	swp_entry_t *ptr, entry;
@@ -135,71 +221,112 @@
 }
 
 /*
- * shmem_truncate_part - free a bunch of swap entries
+ * shmem_truncate_direct - free the swap entries of a whole doubly
+ *                         indirect block
  *
- * @dir:	pointer to swp_entries 
- * @size:	number of entries in dir
- * @start:	offset to start from
- * @freed:	counter for freed pages
+ * @dir:	pointer to the pointer to the block
+ * @start:	offset to start from (in pages)
+ * @len:	how many pages are stored in this block
  *
- * It frees the swap entries from dir+start til dir+size
- *
- * returns 0 if it truncated something, else (offset-size)
+ * Returns the number of freed swap entries.
  */
 
-static unsigned long 
-shmem_truncate_part (swp_entry_t * dir, unsigned long size, 
-		     unsigned long start, unsigned long *freed) {
-	if (start > size)
-		return start - size;
-	if (dir)
-		*freed += shmem_free_swp (dir+start, size-start);
+static inline unsigned long 
+shmem_truncate_direct(swp_entry_t *** dir, unsigned long start, unsigned long len) {
+	swp_entry_t **last, **ptr;
+	unsigned long off, freed = 0;
+ 
+	if (!*dir)
+		return 0;
+
+	last = *dir + (len + ENTRIES_PER_PAGE-1) / ENTRIES_PER_PAGE;
+	off = start % ENTRIES_PER_PAGE;
+
+	for (ptr = *dir + start/ENTRIES_PER_PAGE; ptr < last; ptr++) {
+		if (!*ptr) {
+			off = 0;
+			continue;
+		}
+
+		if (!off) {
+			freed += shmem_free_swp(*ptr, ENTRIES_PER_PAGE);
+			free_page ((unsigned long) *ptr);
+			*ptr = 0;
+		} else {
+			freed += shmem_free_swp(*ptr+off,ENTRIES_PER_PAGE-off);
+			off = 0;
+		}
+	}
 	
-	return 0;
+	if (!start) {
+		free_page((unsigned long) *dir);
+		*dir = 0;
+	}
+	return freed;
+}
+
+/*
+ * shmem_truncate_indirect - truncate an inode
+ *
+ * @info:  the info structure of the inode
+ * @index: the index to truncate
+ *
+ * This function locates the last doubly indirect block and calls
+ * then shmem_truncate_direct to do the real work
+ */
+static inline unsigned long
+shmem_truncate_indirect(struct shmem_inode_info *info, unsigned long index)
+{
+	swp_entry_t ***base;
+	unsigned long baseidx, len, start;
+	unsigned long max = info->next_index-1;
+
+	if (max < SHMEM_NR_DIRECT) {
+		info->next_index = index;
+		return shmem_free_swp(info->i_direct + index,
+				      SHMEM_NR_DIRECT - index);
+	}
+
+	if (max < ENTRIES_PER_PAGE * ENTRIES_PER_PAGE/2 + SHMEM_NR_DIRECT) {
+		max -= SHMEM_NR_DIRECT;
+		base = (swp_entry_t ***) &info->i_indirect;
+		baseidx = SHMEM_NR_DIRECT;
+		len = max+1;
+	} else {
+		max -= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2+SHMEM_NR_DIRECT;
+		if (max >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2)
+			BUG();
+
+		baseidx = max & ~(ENTRIES_PER_PAGE*ENTRIES_PER_PAGE-1);
+		base = (swp_entry_t ***) info->i_indirect + ENTRIES_PER_PAGE/2 + baseidx/ENTRIES_PER_PAGE/ENTRIES_PER_PAGE ;
+		len = max - baseidx + 1;
+		baseidx += ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2+SHMEM_NR_DIRECT;
+	}
+
+	if (index > baseidx) {
+		info->next_index = index;
+		start = index - baseidx;
+	} else {
+		info->next_index = baseidx;
+		start = 0;
+	}
+	return shmem_truncate_direct(base, start, len);
 }
 
 static void shmem_truncate (struct inode * inode)
 {
-	int clear_base;
-	unsigned long index, start;
+	unsigned long index;
 	unsigned long freed = 0;
-	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
 	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	if (index > info->max_index)
-		goto out;
 
-	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, index, &freed);
-
-	if (!(base = info->i_indirect))
-		goto out;
+	while (index < info->next_index) 
+		freed += shmem_truncate_indirect(info, index);
 
-	clear_base = 1;
-	last = base + ((info->max_index - SHMEM_NR_DIRECT + ENTRIES_PER_PAGE - 1) / ENTRIES_PER_PAGE);
-	for (ptr = base; ptr < last; ptr++) {
-		if (!start) {
-			if (!*ptr)
-				continue;
-			freed += shmem_free_swp (*ptr, ENTRIES_PER_PAGE);
-			free_page ((unsigned long) *ptr);
-			*ptr = 0;
-			continue;
-		}
-		clear_base = 0;
-		start = shmem_truncate_part (*ptr, ENTRIES_PER_PAGE, start, &freed);
-	}
-
-	if (clear_base) {
-		free_page ((unsigned long)base);
-		info->i_indirect = 0;
-	}
-
-out:
-	info->max_index = index;
 	info->swapped -= freed;
 	shmem_recalc_inode(inode, freed);
 	spin_unlock (&info->lock);
@@ -253,7 +380,7 @@
 		goto out;
 
 	spin_lock(&info->lock);
-	entry = shmem_swp_entry(info, page->index);
+	entry = shmem_swp_entry(info, page->index, 0);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
 	shmem_recalc_inode(page->mapping->host, 0);
@@ -302,13 +429,13 @@
 	if (page)
 		return page;
 
-	entry = shmem_swp_entry (info, idx);
+	entry = shmem_alloc_entry (info, idx);
 	if (IS_ERR(entry))
 		return (void *)entry;
 
 	spin_lock (&info->lock);
 	
-	/* The shmem_swp_entry() call may have blocked, and
+	/* The shmem_alloc_entry() call may have blocked, and
 	 * shmem_writepage may have been moving a page between the page
 	 * cache and swap cache.  We need to recheck the page cache
 	 * under the protection of the info->lock spinlock. */
@@ -671,9 +798,6 @@
 			buf += bytes;
 			if (pos > inode->i_size) 
 				inode->i_size = pos;
-			if (info->max_index <= index)
-				info->max_index = index+1;
-
 		}
 unlock:
 		/* Mark it unlocked again and drop the page.. */
@@ -1127,7 +1251,7 @@
 	sb->u.shmem_sb.free_blocks = blocks;
 	sb->u.shmem_sb.max_inodes = inodes;
 	sb->u.shmem_sb.free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1259,26 +1383,25 @@
 
 static int shmem_unuse_inode (struct shmem_inode_info *info, swp_entry_t entry, struct page *page)
 {
-	swp_entry_t **base, **ptr;
+	swp_entry_t *ptr;
 	unsigned long idx;
 	int offset;
 	
 	idx = 0;
 	spin_lock (&info->lock);
-	if ((offset = shmem_clear_swp (entry,info->i_direct, SHMEM_NR_DIRECT)) >= 0)
+	offset = shmem_clear_swp (entry, info->i_direct, SHMEM_NR_DIRECT);
+	if (offset >= 0)
 		goto found;
 
-	idx = SHMEM_NR_DIRECT;
-	if (!(base = info->i_indirect))
-		goto out;
-
-	for (ptr = base; ptr < base + ENTRIES_PER_PAGE; ptr++) {
-		if (*ptr &&
-		    (offset = shmem_clear_swp (entry, *ptr, ENTRIES_PER_PAGE)) >= 0)
+	for (idx = SHMEM_NR_DIRECT; idx < info->next_index; 
+	     idx += ENTRIES_PER_PAGE) {
+		ptr = shmem_swp_entry(info, idx, 0);
+		if (IS_ERR(ptr))
+			continue;
+		offset = shmem_clear_swp (entry, ptr, ENTRIES_PER_PAGE);
+		if (offset >= 0)
 			goto found;
-		idx += ENTRIES_PER_PAGE;
 	}
-out:
 	spin_unlock (&info->lock);
 	return 0;
 found:

--=-=-=--

