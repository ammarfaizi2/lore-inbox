Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135689AbREIBck>; Tue, 8 May 2001 21:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135723AbREIBca>; Tue, 8 May 2001 21:32:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33807 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135689AbREIBcT>; Tue, 8 May 2001 21:32:19 -0400
Date: Tue, 8 May 2001 20:53:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.31.0105081635530.3618-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105082036440.11628-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 May 2001, Linus Torvalds wrote:

> 
> 
> On Tue, 8 May 2001, Marcelo Tosatti wrote:
> >
> > There are two issues which I missed yesterday: we have to get a reference
> > on the page, mark it clean, drop the locks and then call writepage(). If
> > the writepage() fails, we'll have to set_page_dirty(page).
> 
> We can move the "mark it clean" into writepage, which would actually
> simplify the error cases for shared memory writepage (no need to mark it
> dirty again etc).
> 
> > I guess this is too much overhead for the common case, don't you?
> 
> You could easily be right.
> 
> On the other hand, remember that a noticeable part of the time you should
> be seeing a real write too, so the CPU overhead compared to the IO might
> not be prohibitive. Ie, let's assuem that 10% of the time we actually end
> up doing writes, then that 10% is going to be _soo_ much more than the
> extra 10 cycles 90% of the time that the cleanup may well be worth it.
> 
> Especially if the cleanup means that we can avoid doing some of the real
> writes altogether, by being better able to release dead memory to the
> system.

Ok, this patch implements thet thing and also changes ext2+swap+shm
writepage operations (so I could test the thing).

The performance is better with the patch on my restricted swapping tests.

In case you don't have any problems with this I'll fix the other
writepage's (so tell me if its ok for you).


diff -Nur --exclude-from=exclude linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Mon May  7 20:47:26 2001
+++ linux/fs/buffer.c	Tue May  8 22:04:00 2001
@@ -1933,12 +1933,17 @@
 	return err;
 }
 
-int block_write_full_page(struct page *page, get_block_t *get_block)
+int block_write_full_page(struct page *page, get_block_t *get_block, int priority)
 {
 	struct inode *inode = page->mapping->host;
 	unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 	unsigned offset;
 	int err;
+
+	if (!priority)
+		return -1;
+
+	ClearPageDirty(page);
 
 	/* easy case */
 	if (page->index < end_index)
diff -Nur --exclude-from=exclude linux.orig/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux.orig/fs/ext2/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/ext2/inode.c	Tue May  8 20:46:54 2001
@@ -650,9 +650,9 @@
 	return NULL;
 }
 
-static int ext2_writepage(struct page *page)
+static int ext2_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,ext2_get_block);
+	return block_write_full_page(page,ext2_get_block,priority);
 }
 static int ext2_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/include/linux/fs.h linux/include/linux/fs.h
--- linux.orig/include/linux/fs.h	Tue May  8 16:45:42 2001
+++ linux/include/linux/fs.h	Tue May  8 22:22:38 2001
@@ -362,7 +362,7 @@
 struct address_space;
 
 struct address_space_operations {
-	int (*writepage)(struct page *);
+	int (*writepage)(struct page *, int);
 	int (*readpage)(struct file *, struct page *);
 	int (*sync_page)(struct page *);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
@@ -1268,7 +1268,7 @@
 /* Generic buffer handling for block filesystems.. */
 extern int block_flushpage(struct page *, unsigned long);
 extern int block_symlink(struct inode *, const char *, int);
-extern int block_write_full_page(struct page*, get_block_t*);
+extern int block_write_full_page(struct page*, get_block_t*, int);
 extern int block_read_full_page(struct page*, get_block_t*);
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
diff -Nur --exclude-from=exclude linux.orig/mm/filemap.c linux/mm/filemap.c
--- linux.orig/mm/filemap.c	Mon May  7 20:47:26 2001
+++ linux/mm/filemap.c	Tue May  8 22:22:50 2001
@@ -411,7 +411,7 @@
  */
 void filemap_fdatasync(struct address_space * mapping)
 {
-	int (*writepage)(struct page *) = mapping->a_ops->writepage;
+	int (*writepage)(struct page *, int) = mapping->a_ops->writepage;
 
 	spin_lock(&pagecache_lock);
 
@@ -430,8 +430,7 @@
 		lock_page(page);
 
 		if (PageDirty(page)) {
-			ClearPageDirty(page);
-			writepage(page);
+			writepage(page, 1);
 		} else
 			UnlockPage(page);
 
diff -Nur --exclude-from=exclude linux.orig/mm/shmem.c linux/mm/shmem.c
--- linux.orig/mm/shmem.c	Mon May  7 20:47:26 2001
+++ linux/mm/shmem.c	Tue May  8 22:23:01 2001
@@ -221,13 +221,16 @@
  * once.  We still need to guard against racing with
  * shmem_getpage_locked().  
  */
-static int shmem_writepage(struct page * page)
+static int shmem_writepage(struct page * page, int priority)
 {
 	int error = 0;
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
 	struct inode *inode;
 
+	if (!priority)
+		return -1;
+
 	if (!PageLocked(page))
 		BUG();
 	
@@ -243,6 +246,8 @@
 	if (!swap.val)
 		goto out;
 
+	ClearPageDirty(page);	
+
 	spin_lock(&info->lock);
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
@@ -265,7 +270,6 @@
 
 	spin_unlock(&info->lock);
 out:
-	set_page_dirty(page);
 	UnlockPage(page);
 	return error;
 }
diff -Nur --exclude-from=exclude linux.orig/mm/swap_state.c linux/mm/swap_state.c
--- linux.orig/mm/swap_state.c	Mon May  7 20:47:26 2001
+++ linux/mm/swap_state.c	Tue May  8 21:39:44 2001
@@ -21,7 +21,7 @@
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
  */
-static int swap_writepage(struct page *page)
+static int swap_writepage(struct page *page, int priority)
 {
 	/* One for the page cache, one for this user, one for page->buffers */
 	if (page_count(page) > 2 + !!page->buffers)
@@ -30,10 +30,14 @@
 		goto in_use;
 
 	/* We could remove it here, but page_launder will do it anyway */
+	ClearPageDirty(page);
 	UnlockPage(page);
 	return 0;
 
 in_use:
+	if (!priority) 
+		return -1;
+	ClearPageDirty(page);
 	rw_swap_page(WRITE, page);
 	return 0;
 }
diff -Nur --exclude-from=exclude linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Mon May  7 20:47:26 2001
+++ linux/mm/vmscan.c	Tue May  8 22:23:32 2001
@@ -472,33 +472,30 @@
 		}
 
 		/*
-		 * Dirty swap-cache page? Write it out if
+		 * Dirty page? Write it out if
 		 * last copy..
 		 */
 		if (PageDirty(page)) {
-			int (*writepage)(struct page *) = page->mapping->a_ops->writepage;
+			int (*writepage)(struct page *, int) = 
+				page->mapping->a_ops->writepage;
 
 			if (!writepage)
 				goto page_active;
-
-			/* First time through? Move it to the back of the list */
-			if (!launder_loop) {
-				list_del(page_lru);
-				list_add(page_lru, &inactive_dirty_list);
+			
+			page_cache_get(page);
+			list_del(page_lru);
+			list_add(page_lru, &inactive_dirty_list);
+			spin_unlock(&pagemap_lru_lock);
+		
+			if (writepage(page, launder_loop)) {
+				spin_lock(&pagemap_lru_lock);
 				UnlockPage(page);
+				page_cache_release(page);
 				continue;
 			}
-
-			/* OK, do a physical asynchronous write to swap.  */
-			ClearPageDirty(page);
-			page_cache_get(page);
-			spin_unlock(&pagemap_lru_lock);
-
-			writepage(page);
-			page_cache_release(page);
-
-			/* And re-start the thing.. */
+		
 			spin_lock(&pagemap_lru_lock);
+			page_cache_release(page);
 			continue;
 		}
 






