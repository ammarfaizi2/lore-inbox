Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133070AbREGMmg>; Mon, 7 May 2001 08:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135251AbREGMm1>; Mon, 7 May 2001 08:42:27 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:44010 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S133070AbREGMmQ>; Mon, 7 May 2001 08:42:16 -0400
From: Christoph Rohland <cr@sap.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MM mailing list <linux-mm@kvack.org>
Subject: [Patch] Do not account shmem pages to the page cache
Organisation: SAP LinuxLab
Date: 07 May 2001 14:43:28 +0200
Message-ID: <m3y9s9nxcf.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The appended patch does it's own accounting of shmem pages and adjust
the page cache size to take these into account. So now again you will
see shmem pages as used in top/vmstat etc. This confused a lot of
people.

There is a uncertainty in the calculations since the vm may drop pages
behind shmem and the number of shmem pages is estimated too high. This
especially happens on truncate because first the page cache is reduced
and later the shmem readjusts it's count.

To prevent negative cache sizes the adjustment is only done if
shmem_nrpages > page_cache_size.

The latter part of the patch (all the init.c files) also exports the
shmem page number to the shared memory field in meminfo. This means a
change in semantics of this field but apparently a lot of people
interpret this field exactly this way and it was not used any more

The patches are on top of my encapsulation patch.

Greetings
		Christoph

diff -uNr 2.4.4-mSsu/fs/proc/proc_misc.c 2.4.4-mSsua/fs/proc/proc_misc.c
--- 2.4.4-mSsu/fs/proc/proc_misc.c	Sun Apr 29 20:32:52 2001
+++ 2.4.4-mSsua/fs/proc/proc_misc.c	Mon May  7 13:38:53 2001
@@ -140,6 +140,17 @@
 {
 	struct sysinfo i;
 	int len;
+	unsigned int cached, shmem;
+
+	/*
+	 * There may be some inconsistency because shmem_nrpages
+	 * update is delayed to page_cache_size
+	 * We make sure the cached value does not get below zero 
+	 */
+	cached = atomic_read(&page_cache_size);
+	shmem  = atomic_read(&shmem_nrpages);
+	if (shmem < cached)
+		cached -= shmem;
 
 /*
  * display in kilobytes.
@@ -153,8 +164,8 @@
                 "Swap: %8lu %8lu %8lu\n",
                 B(i.totalram), B(i.totalram-i.freeram), B(i.freeram),
                 B(i.sharedram), B(i.bufferram),
-                B(atomic_read(&page_cache_size)), B(i.totalswap),
-                B(i.totalswap-i.freeswap), B(i.freeswap));
+		B(cached), B(i.totalswap),
+		B(i.totalswap-i.freeswap), B(i.freeswap));
         /*
          * Tagged format, for easy grepping and expansion.
          * The above will go away eventually, once the tools
@@ -180,7 +191,7 @@
                 K(i.freeram),
                 K(i.sharedram),
                 K(i.bufferram),
-                K(atomic_read(&page_cache_size)),
+		K(cached),
 		K(nr_active_pages),
 		K(nr_inactive_dirty_pages),
 		K(nr_inactive_clean_pages()),
diff -uNr 2.4.4-mSsu/include/linux/shmem_fs.h 2.4.4-mSsua/include/linux/shmem_fs.h
--- 2.4.4-mSsu/include/linux/shmem_fs.h	Wed May  2 18:36:05 2001
+++ 2.4.4-mSsua/include/linux/shmem_fs.h	Mon May  7 12:52:00 2001
@@ -17,6 +17,8 @@
 	unsigned long val;
 } swp_entry_t;
 
+extern atomic_t shmem_nrpages;
+
 struct shmem_inode_info {
 	spinlock_t		lock;
 	struct semaphore 	sem;
diff -uNr 2.4.4-mSsu/mm/mmap.c 2.4.4-mSsua/mm/mmap.c
--- 2.4.4-mSsu/mm/mmap.c	Sun Apr 29 20:33:01 2001
+++ 2.4.4-mSsua/mm/mmap.c	Mon May  7 13:42:03 2001
@@ -55,13 +55,24 @@
 	 */
 
 	long free;
-	
+	unsigned long cached, shmem;
+
+	/*
+	 * There may be some inconsistency because shmem_nrpages
+	 * update is delayed to the page_cache_size
+	 * We make sure the cached value does not get below zero 
+	 */
+	cached = atomic_read(&page_cache_size);
+	shmem  = atomic_read(&shmem_nrpages);
+	if (cached > shmem)
+		cached -= shmem;
+
         /* Sometimes we want to use more memory than we have. */
 	if (sysctl_overcommit_memory)
 	    return 1;
 
 	free = atomic_read(&buffermem_pages);
-	free += atomic_read(&page_cache_size);
+	free += cached;
 	free += nr_free_pages();
 	free += nr_swap_pages;
 
diff -uNr 2.4.4-mSsu/mm/shmem.c 2.4.4-mSsua/mm/shmem.c
--- 2.4.4-mSsu/mm/shmem.c	Fri May  4 21:37:34 2001
+++ 2.4.4-mSsua/mm/shmem.c	Mon May  7 11:13:27 2001
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2000 Linus Torvalds.
  *		 2000 Transmeta Corp.
- *		 2000 Christoph Rohland
+ *		 2000-2001 Christoph Rohland
+ *		 2000-2001 SAP AG
  * 
  * This file is released under the GPL.
  */
@@ -45,6 +46,7 @@
 
 LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
+atomic_t shmem_nrpages = ATOMIC_INIT(0);
 
 #define BLOCKS_PER_PAGE (PAGE_SIZE/512)
 
@@ -52,6 +54,7 @@
  * shmem_recalc_inode - recalculate the size of an inode
  *
  * @inode: inode to recalc
+ * @swap:  additional swap pages freed externally
  *
  * We have to calculate the free blocks since the mm can drop pages
  * behind our back
@@ -62,12 +65,14 @@
  *
  * So the mm freed 
  * inodes->i_blocks/BLOCKS_PER_PAGE - 
- *			(inode->i_mapping->nrpages + info->swapped)
+ * 			(inode->i_mapping->nrpages + info->swapped)
  *
  * It has to be called with the spinlock held.
+ *
+ * The swap parameter is a performance hack for truncate.
  */
 
-static void shmem_recalc_inode(struct inode * inode)
+static void shmem_recalc_inode(struct inode * inode, unsigned long swap)
 {
 	unsigned long freed;
 
@@ -79,6 +84,7 @@
 		spin_lock (&info->stat_lock);
 		info->free_blocks += freed;
 		spin_unlock (&info->stat_lock);
+		atomic_sub(freed-swap, &shmem_nrpages);
 	}
 }
 
@@ -195,7 +201,7 @@
 out:
 	info->max_index = index;
 	info->swapped -= freed;
-	shmem_recalc_inode(inode);
+	shmem_recalc_inode(inode, freed);
 	spin_unlock (&info->lock);
 	up(&info->sem);
 }
@@ -250,14 +256,15 @@
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
-	shmem_recalc_inode(page->mapping->host);
+	shmem_recalc_inode(page->mapping->host, 0);
 	error = -EAGAIN;
 	if (entry->val)
 		BUG();
 
 	*entry = swap;
 	error = 0;
-	/* Remove the from the page cache */
+	/* Remove the page from the page cache */
+	atomic_dec(&shmem_nrpages);
 	lru_cache_del(page);
 	remove_inode_page(page);
 
@@ -376,6 +383,7 @@
 	}
 
 	/* We have the page */
+	atomic_inc(&shmem_nrpages);
 	SetPageUptodate(page);
 	if (info->locked)
 		page_cache_get(page);
@@ -1275,6 +1283,7 @@
 	return 0;
 found:
 	add_to_page_cache(page, info->inode->i_mapping, offset + idx);
+	atomic_inc(&shmem_nrpages);
 	set_page_dirty(page);
 	SetPageUptodate(page);
 	UnlockPage(page);
diff -uNr 2.4.4-mSsu/arch/alpha/mm/init.c c/arch/alpha/mm/init.c
--- 2.4.4-mSsu/arch/alpha/mm/init.c	Sun Apr 29 20:31:56 2001
+++ c/arch/alpha/mm/init.c	Sun May  6 21:47:25 2001
@@ -402,7 +402,7 @@
 si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/arm/mm/init.c c/arch/arm/mm/init.c
--- 2.4.4-mSsu/arch/arm/mm/init.c	Sun Apr 29 20:31:56 2001
+++ c/arch/arm/mm/init.c	Sun May  6 21:47:01 2001
@@ -647,7 +647,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram  = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram   = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/cris/mm/init.c c/arch/cris/mm/init.c
--- 2.4.4-mSsu/arch/cris/mm/init.c	Sun Apr 29 20:31:57 2001
+++ c/arch/cris/mm/init.c	Sun May  6 21:47:03 2001
@@ -503,7 +503,7 @@
 
 	i = max_mapnr;
 	val->totalram = 0;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	while (i-- > 0)  {
diff -uNr 2.4.4-mSsu/arch/i386/mm/init.c c/arch/i386/mm/init.c
--- 2.4.4-mSsu/arch/i386/mm/init.c	Sun Apr 29 20:32:08 2001
+++ c/arch/i386/mm/init.c	Sun May  6 20:24:21 2001
@@ -570,7 +570,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = totalhigh_pages;
diff -uNr 2.4.4-mSsu/arch/ia64/mm/init.c c/arch/ia64/mm/init.c
--- 2.4.4-mSsu/arch/ia64/mm/init.c	Sun Apr 29 20:32:11 2001
+++ c/arch/ia64/mm/init.c	Sun May  6 21:47:05 2001
@@ -151,7 +151,7 @@
 si_meminfo (struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/m68k/mm/init.c c/arch/m68k/mm/init.c
--- 2.4.4-mSsu/arch/m68k/mm/init.c	Sat Nov  4 18:11:22 2000
+++ c/arch/m68k/mm/init.c	Sun May  6 21:47:45 2001
@@ -217,7 +217,7 @@
 
     i = max_mapnr;
     val->totalram = totalram_pages;
-    val->sharedram = 0;
+    val->sharedram = atomic_read(&shmem_nrpages);
     val->freeram = nr_free_pages();
     val->bufferram = atomic_read(&buffermem_pages);
     while (i-- > 0) {
diff -uNr 2.4.4-mSsu/arch/mips/mm/init.c c/arch/mips/mm/init.c
--- 2.4.4-mSsu/arch/mips/mm/init.c	Sat Nov  4 18:11:22 2000
+++ c/arch/mips/mm/init.c	Sun May  6 21:47:01 2001
@@ -343,7 +343,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/mips64/mm/init.c c/arch/mips64/mm/init.c
--- 2.4.4-mSsu/arch/mips64/mm/init.c	Sat Nov  4 18:11:22 2000
+++ c/arch/mips64/mm/init.c	Sun May  6 21:47:04 2001
@@ -411,7 +411,7 @@
 si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/parisc/mm/init.c c/arch/parisc/mm/init.c
--- 2.4.4-mSsu/arch/parisc/mm/init.c	Sun Dec 17 12:53:55 2000
+++ c/arch/parisc/mm/init.c	Sun May  6 21:47:02 2001
@@ -458,7 +458,7 @@
 
 	i = max_mapnr;
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 #if 0
diff -uNr 2.4.4-mSsu/arch/ppc/mm/init.c c/arch/ppc/mm/init.c
--- 2.4.4-mSsu/arch/ppc/mm/init.c	Wed Apr 11 12:36:13 2001
+++ c/arch/ppc/mm/init.c	Sun May  6 21:47:05 2001
@@ -336,7 +336,7 @@
 
 	i = max_mapnr;
 	val->totalram = 0;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	while (i-- > 0)  {
diff -uNr 2.4.4-mSsu/arch/s390/mm/init.c c/arch/s390/mm/init.c
--- 2.4.4-mSsu/arch/s390/mm/init.c	Sun Apr 29 20:32:21 2001
+++ c/arch/s390/mm/init.c	Sun May  6 21:47:03 2001
@@ -271,7 +271,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/s390x/mm/init.c c/arch/s390x/mm/init.c
--- 2.4.4-mSsu/arch/s390x/mm/init.c	Sun Apr 29 20:32:22 2001
+++ c/arch/s390x/mm/init.c	Sun May  6 21:47:18 2001
@@ -284,7 +284,7 @@
 void si_meminfo(struct sysinfo *val)
 {
         val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = 0;
diff -uNr 2.4.4-mSsu/arch/sh/mm/init.c c/arch/sh/mm/init.c
--- 2.4.4-mSsu/arch/sh/mm/init.c	Sun Apr 29 20:32:23 2001
+++ c/arch/sh/mm/init.c	Sun May  6 21:47:26 2001
@@ -215,7 +215,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = totalhigh_pages;
diff -uNr 2.4.4-mSsu/arch/sparc/mm/init.c c/arch/sparc/mm/init.c
--- 2.4.4-mSsu/arch/sparc/mm/init.c	Sun Apr 29 20:32:23 2001
+++ c/arch/sparc/mm/init.c	Sun May  6 21:47:04 2001
@@ -534,7 +534,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = totalram_pages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 	val->totalhigh = totalhigh_pages;
diff -uNr 2.4.4-mSsu/arch/sparc64/mm/init.c c/arch/sparc64/mm/init.c
--- 2.4.4-mSsu/arch/sparc64/mm/init.c	Sun Apr 29 20:32:25 2001
+++ c/arch/sparc64/mm/init.c	Sun May  6 21:47:02 2001
@@ -1512,7 +1512,7 @@
 void si_meminfo(struct sysinfo *val)
 {
 	val->totalram = num_physpages;
-	val->sharedram = 0;
+	val->sharedram = atomic_read(&shmem_nrpages);
 	val->freeram = nr_free_pages();
 	val->bufferram = atomic_read(&buffermem_pages);
 

