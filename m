Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135839AbRAJPSs>; Wed, 10 Jan 2001 10:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135829AbRAJPSj>; Wed, 10 Jan 2001 10:18:39 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:25280 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S135833AbRAJPSg>; Wed, 10 Jan 2001 10:18:36 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] shmem truncate optimizations and cleanup
From: Christoph Rohland <cr@sap.com>
Date: 10 Jan 2001 16:22:13 +0100
Message-ID: <m3g0iro2je.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

The appended patch speeds up the truncate logic of shmem.c
considerably and makes it more readable. 

Would you apply it to your -ac series?

I will go on with some cache lookup optimizations and probably
read/write support.

Greetings
                Christoph

diff -uNr 4-13-5/include/linux/shmem_fs.h c/include/linux/shmem_fs.h
--- 4-13-5/include/linux/shmem_fs.h	Thu Dec 28 23:19:27 2000
+++ c/include/linux/shmem_fs.h	Thu Dec 28 23:22:58 2000
@@ -19,6 +19,7 @@
 
 struct shmem_inode_info {
 	spinlock_t	lock;
+	unsigned long	max_index;
 	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	swp_entry_t   **i_indirect; /* doubly indirect blocks */
 	unsigned long	swapped;
diff -uNr 4-13-5/mm/shmem.c c/mm/shmem.c
--- 4-13-5/mm/shmem.c	Thu Dec 28 23:19:27 2000
+++ c/mm/shmem.c	Thu Dec 28 23:31:20 2000
@@ -51,11 +51,16 @@
 
 static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index) 
 {
+	unsigned long offset;
+
 	if (index < SHMEM_NR_DIRECT)
 		return info->i_direct+index;
 
 	index -= SHMEM_NR_DIRECT;
-	if (index >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
+	offset = index % ENTRIES_PER_PAGE;
+	index /= ENTRIES_PER_PAGE;
+
+	if (index >= ENTRIES_PER_PAGE)
 		return NULL;
 
 	if (!info->i_indirect) {
@@ -63,13 +68,13 @@
 		if (!info->i_indirect)
 			return NULL;
 	}
-	if(!(info->i_indirect[index/ENTRIES_PER_PAGE])) {
-		info->i_indirect[index/ENTRIES_PER_PAGE] = (swp_entry_t *) get_zeroed_page(GFP_USER);
-		if (!info->i_indirect[index/ENTRIES_PER_PAGE])
+	if(!(info->i_indirect[index])) {
+		info->i_indirect[index] = (swp_entry_t *) get_zeroed_page(GFP_USER);
+		if (!info->i_indirect[index])
 			return NULL;
 	}
 	
-	return info->i_indirect[index/ENTRIES_PER_PAGE]+index%ENTRIES_PER_PAGE;
+	return info->i_indirect[index]+offset;
 }
 
 static int shmem_free_swp(swp_entry_t *dir, unsigned int count)
@@ -99,7 +104,6 @@
  * @dir:	pointer to swp_entries 
  * @size:	number of entries in dir
  * @start:	offset to start from
- * @inode:	inode for statistics
  * @freed:	counter for freed pages
  *
  * It frees the swap entries from dir+start til dir+size
@@ -109,7 +113,7 @@
 
 static unsigned long 
 shmem_truncate_part (swp_entry_t * dir, unsigned long size, 
-		     unsigned long start, struct inode * inode, unsigned long *freed) {
+		     unsigned long start, unsigned long *freed) {
 	if (start > size)
 		return start - size;
 	if (dir)
@@ -121,21 +125,27 @@
 static void shmem_truncate (struct inode * inode)
 {
 	int clear_base;
-	unsigned long start;
+	unsigned long index, start;
 	unsigned long mmfreed, freed = 0;
-	swp_entry_t **base, **ptr;
+	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
 	spin_lock (&info->lock);
-	start = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	if (index >= info->max_index) {
+		info->max_index = index;
+		spin_unlock (&info->lock);
+		return;
+	}
 
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
@@ -145,16 +155,16 @@
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
 
 	/*
 	 * We have to calculate the free blocks since we do not know
@@ -209,16 +219,16 @@
 		return 1;
 
 	spin_lock(&info->lock);
-	entry = shmem_swp_entry (info, page->index);
+	entry = shmem_swp_entry(info, page->index);
 	if (!entry)	/* this had been allocted on page allocation */
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
