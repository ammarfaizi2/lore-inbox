Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266621AbRGEFHO>; Thu, 5 Jul 2001 01:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbRGEFHH>; Thu, 5 Jul 2001 01:07:07 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:45298 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266621AbRGEFGv>; Thu, 5 Jul 2001 01:06:51 -0400
Date: Thu, 5 Jul 2001 01:06:47 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: <torvalds@transmeta.com>
cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: [wip-PATCH] rfi: PAGE_CACHE_SIZE suppoort
Message-ID: <Pine.LNX.4.33.0107050054470.5548-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus, Al et al,

I attacked the PAGE_CACHE_SIZE support in the kernel for the last few days
in an attempt to get multipage PAGE_CACHE_SIZE support working and below
is what I've come up with.  It currently boots to single user read only,
doesn't quite have write support fixed properly yet, but is going pretty
well.  The reason for sending this out now is the question of what to do
about kmap() support.  In going through the ext2 dirs in pagecache code, I
had to fix the broken kmap() usage in the code.  Once that was done,
adding support for multipage page cache pages resulted in loops and other
oddities all over the code that might be better hidden from the
filesystem.  So the question is: do we want to make kmap support > order 0
mappings?  I'm looking forward to any input received, as well as feedback
on the patch.  Thanks.

Oh, Al, I'll extract the ext2 fixes for highmem from this patch for you
tomorrow, but have a look over them and see if you can spot anything that
I've missed.  Cheers,

		-ben

.... ~/patches/v2.4.6-pre8-pgc-A0.diff ....
diff -ur /md0/kernels/2.4/v2.4.6-pre8/arch/i386/boot/install.sh pgc-2.4.6-pre8/arch/i386/boot/install.sh
--- /md0/kernels/2.4/v2.4.6-pre8/arch/i386/boot/install.sh	Tue Jan  3 06:57:26 1995
+++ pgc-2.4.6-pre8/arch/i386/boot/install.sh	Wed Jul  4 16:42:32 2001
@@ -21,6 +21,7 @@

 # User may have a custom install script

+if [ -x ~/bin/installkernel ]; then exec ~/bin/installkernel "$@"; fi
 if [ -x /sbin/installkernel ]; then exec /sbin/installkernel "$@"; fi

 # Default install - same as make zlilo
diff -ur /md0/kernels/2.4/v2.4.6-pre8/arch/i386/config.in pgc-2.4.6-pre8/arch/i386/config.in
--- /md0/kernels/2.4/v2.4.6-pre8/arch/i386/config.in	Sun Jul  1 21:45:04 2001
+++ pgc-2.4.6-pre8/arch/i386/config.in	Sun Jul  1 21:49:20 2001
@@ -180,6 +180,8 @@
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
    define_bool CONFIG_HAVE_DEC_LOCK y
 fi
+
+int 'Page cache shift' CONFIG_PAGE_CACHE_SHIFT 0
 endmenu

 mainmenu_option next_comment
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/buffer.c pgc-2.4.6-pre8/fs/buffer.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/buffer.c	Sat Jun 30 14:04:27 2001
+++ pgc-2.4.6-pre8/fs/buffer.c	Thu Jul  5 00:49:54 2001
@@ -774,6 +774,7 @@

 	/* This is a temporary buffer used for page I/O. */
 	page = bh->b_page;
+	page = page_cache_page(page);

 	if (!uptodate)
 		SetPageError(page);
@@ -1252,8 +1253,10 @@

 void set_bh_page (struct buffer_head *bh, struct page *page, unsigned long offset)
 {
+	page += offset >> PAGE_SHIFT;
+	offset &= PAGE_SIZE - 1;
 	bh->b_page = page;
-	if (offset >= PAGE_SIZE)
+	if (offset >= PAGE_CACHE_SIZE)
 		BUG();
 	if (PageHighMem(page))
 		/*
@@ -1280,7 +1283,9 @@

 try_again:
 	head = NULL;
-	offset = PAGE_SIZE;
+	if (!PageCachePage(page))
+		BUG();
+	offset = PAGE_CACHE_SIZE;
 	while ((offset -= size) >= 0) {
 		bh = get_unused_buffer_head(async);
 		if (!bh)
@@ -1664,6 +1669,8 @@
 	unsigned int blocksize, blocks;
 	int nr, i;

+	if (!PageCachePage(page))
+		BUG();
 	if (!PageLocked(page))
 		PAGE_BUG(page);
 	blocksize = inode->i_sb->s_blocksize;
@@ -1688,9 +1695,13 @@
 					continue;
 			}
 			if (!buffer_mapped(bh)) {
-				memset(kmap(page) + i*blocksize, 0, blocksize);
-				flush_dcache_page(page);
-				kunmap(page);
+				struct page *map = page;
+				unsigned offset = i * blocksize;
+				map += offset >> PAGE_SHIFT;
+				offset &= PAGE_SIZE - 1;
+				memset(kmap(map) + offset, 0, blocksize);
+				flush_dcache_page(map);
+				kunmap(map);
 				set_bit(BH_Uptodate, &bh->b_state);
 				continue;
 			}
@@ -2228,7 +2239,7 @@
 		return 0;
 	}

-	page = alloc_page(GFP_NOFS);
+	page = __page_cache_alloc(GFP_NOFS);
 	if (!page)
 		goto out;
 	LockPage(page);
diff -ur /md0/kernels/2.4/v2.4.6-pre8/fs/ext2/dir.c pgc-2.4.6-pre8/fs/ext2/dir.c
--- /md0/kernels/2.4/v2.4.6-pre8/fs/ext2/dir.c	Sat Jun 30 14:04:27 2001
+++ pgc-2.4.6-pre8/fs/ext2/dir.c	Thu Jul  5 00:32:56 2001
@@ -38,7 +38,6 @@

 static inline void ext2_put_page(struct page *page)
 {
-	kunmap(page);
 	page_cache_release(page);
 }

@@ -58,29 +57,38 @@
 	return err;
 }

-static void ext2_check_page(struct page *page)
+static inline void __ext2_check_page(struct page *base, struct page *page)
 {
-	struct inode *dir = page->mapping->host;
+	struct inode *dir = base->mapping->host;
 	struct super_block *sb = dir->i_sb;
 	unsigned chunk_size = ext2_chunk_size(dir);
-	char *kaddr = page_address(page);
+	char *kaddr = NULL;
 	u32 max_inumber = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
 	unsigned offs, rec_len;
-	unsigned limit = PAGE_CACHE_SIZE;
+	unsigned limit = PAGE_SIZE;
 	ext2_dirent *p;
 	char *error;

-	if ((dir->i_size >> PAGE_CACHE_SHIFT) == page->index) {
-		limit = dir->i_size & ~PAGE_CACHE_MASK;
+	kaddr = kmap(page);
+	if ((dir->i_size >> PAGE_CACHE_SHIFT) == base->index) {
+		limit = dir->i_size & (PAGE_CACHE_SIZE-1);
+		if (limit <= ((page - base) << PAGE_SHIFT))
+			goto out;
+		limit -= (page - base) << PAGE_SHIFT;
+		if (!limit)
+			goto out;
+		if (limit > PAGE_SIZE)
+			limit = PAGE_SIZE;
 		if (limit & (chunk_size - 1))
 			goto Ebadsize;
-		for (offs = limit; offs<PAGE_CACHE_SIZE; offs += chunk_size) {
-			ext2_dirent *p = (ext2_dirent*)(kaddr + offs);
+		for (offs = limit; offs<PAGE_SIZE; offs += chunk_size) {
+			ext2_dirent *p;
+			p = (ext2_dirent*)(kaddr + offs);
 			p->rec_len = cpu_to_le16(chunk_size);
 		}
-		if (!limit)
-			goto out;
 	}
+
+printk("limit=%u  idx=%d  size=%Ld\n", limit, page - base, dir->i_size);
 	for (offs = 0; offs <= limit - EXT2_DIR_REC_LEN(1); offs += rec_len) {
 		p = (ext2_dirent *)(kaddr + offs);
 		rec_len = le16_to_cpu(p->rec_len);
@@ -99,7 +107,7 @@
 	if (offs != limit)
 		goto Eend;
 out:
-	SetPageChecked(page);
+	kunmap(page);
 	return;

 	/* Too bad, we had an error */
@@ -127,7 +135,7 @@
 bad_entry:
 	ext2_error (sb, "ext2_check_page", "bad entry in directory #%lu: %s - "
 		"offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
-		dir->i_ino, error, (page->index<<PAGE_CACHE_SHIFT)+offs,
+		dir->i_ino, error, (base->index<<PAGE_CACHE_SHIFT)+offs,
 		(unsigned long) le32_to_cpu(p->inode),
 		rec_len, p->name_len);
 	goto fail;
@@ -136,11 +144,19 @@
 	ext2_error (sb, "ext2_check_page",
 		"entry in directory #%lu spans the page boundary"
 		"offset=%lu, inode=%lu",
-		dir->i_ino, (page->index<<PAGE_CACHE_SHIFT)+offs,
+		dir->i_ino, (base->index<<PAGE_CACHE_SHIFT)+offs,
 		(unsigned long) le32_to_cpu(p->inode));
 fail:
+	kunmap(page);
+	SetPageError(base);
+}
+
+static void ext2_check_page(struct page *page)
+{
+	unsigned i;
+	for (i=0; i<PAGE_CACHE_PAGES; i++)
+		__ext2_check_page(page, page+i);
 	SetPageChecked(page);
-	SetPageError(page);
 }

 static struct page * ext2_get_page(struct inode *dir, unsigned long n)
@@ -150,7 +166,6 @@
 				(filler_t*)mapping->a_ops->readpage, NULL);
 	if (!IS_ERR(page)) {
 		wait_on_page(page);
-		kmap(page);
 		if (!Page_Uptodate(page))
 			goto fail;
 		if (!PageChecked(page))
@@ -248,20 +263,24 @@
 	if (EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
 		types = ext2_filetype_table;

+	npages <<= PAGE_CACHE_ORDER;
+
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		ext2_dirent *de;
-		struct page *page = ext2_get_page(inode, n);
+		struct page *page, *map;

+		page = ext2_get_page(inode, n >> PAGE_CACHE_ORDER);
 		if (IS_ERR(page))
 			continue;
-		kaddr = page_address(page);
+		map = page + (n & PAGE_CACHE_PMASK);
+		kaddr = kmap(map);
 		if (need_revalidate) {
 			offset = ext2_validate_entry(kaddr, offset, chunk_mask);
 			need_revalidate = 0;
 		}
 		de = (ext2_dirent *)(kaddr+offset);
-		limit = kaddr + PAGE_CACHE_SIZE - EXT2_DIR_REC_LEN(1);
+		limit = kaddr + PAGE_SIZE - EXT2_DIR_REC_LEN(1);
 		for ( ;(char*)de <= limit; de = ext2_next_entry(de))
 			if (de->inode) {
 				int over;
@@ -272,18 +291,20 @@

 				offset = (char *)de - kaddr;
 				over = filldir(dirent, de->name, de->name_len,
-						(n<<PAGE_CACHE_SHIFT) | offset,
+						(n << PAGE_SHIFT) | offset,
 						le32_to_cpu(de->inode), d_type);
 				if (over) {
+					kunmap(map);
 					ext2_put_page(page);
 					goto done;
 				}
 			}
+		kunmap(map);
 		ext2_put_page(page);
 	}

 done:
-	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
+	filp->f_pos = (n << PAGE_SHIFT) | offset;
 	filp->f_version = inode->i_version;
 	UPDATE_ATIME(inode);
 	return 0;
@@ -313,23 +334,26 @@

 	for (n = 0; n < npages; n++) {
 		char *kaddr;
+		unsigned i;
 		page = ext2_get_page(dir, n);
 		if (IS_ERR(page))
 			continue;

-		kaddr = page_address(page);
-		de = (ext2_dirent *) kaddr;
-		kaddr += PAGE_CACHE_SIZE - reclen;
-		for ( ; (char *) de <= kaddr ; de = ext2_next_entry(de))
-			if (ext2_match (namelen, name, de))
-				goto found;
+		for (i=0; i<PAGE_CACHE_PAGES; i++) {
+			struct page *map = page + i;
+			kaddr = kmap(map);
+			de = (ext2_dirent *) kaddr;
+			kaddr += PAGE_SIZE - reclen;
+			for ( ; (char *) de <= kaddr ; de = ext2_next_entry(de))
+				if (ext2_match (namelen, name, de)) {
+					*res_page = map;
+					return de;
+				}
+			kunmap(map);
+		}
 		ext2_put_page(page);
 	}
 	return NULL;
-
-found:
-	*res_page = page;
-	return de;
 }

 struct ext2_dir_entry_2 * ext2_dotdot (struct inode *dir, struct page **p)
@@ -338,7 +362,7 @@
 	ext2_dirent *de = NULL;

 	if (!IS_ERR(page)) {
-		de = ext2_next_entry((ext2_dirent *) page_address(page));
+		de = ext2_next_entry((ext2_dirent *) kmap(page));
 		*p = page;
 	}
 	return de;
@@ -361,10 +385,11 @@

 /* Releases the page */
 void ext2_set_link(struct inode *dir, struct ext2_dir_entry_2 *de,
-			struct page *page, struct inode *inode)
+			struct page *map, struct inode *inode)
 {
-	unsigned from = (char *)de-(char*)page_address(page);
+	unsigned from = (char *)de-(char*)page_address(map);
 	unsigned to = from + le16_to_cpu(de->rec_len);
+	struct page *page = page_cache_page(map);
 	int err;

 	lock_page(page);
@@ -375,7 +400,7 @@
 	ext2_set_de_type (de, inode);
 	err = ext2_commit_chunk(page, from, to);
 	UnlockPage(page);
-	ext2_put_page(page);
+	ext2_put_page(map);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 }
@@ -390,7 +415,7 @@
 	int namelen = dentry->d_name.len;
 	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
 	unsigned short rec_len, name_len;
-	struct page *page = NULL;
+	struct page *page = NULL, *map;
 	ext2_dirent * de;
 	unsigned long npages = dir_pages(dir);
 	unsigned long n;
@@ -400,24 +425,28 @@

 	/* We take care of directory expansion in the same loop */
 	for (n = 0; n <= npages; n++) {
+		unsigned i;
 		page = ext2_get_page(dir, n);
 		err = PTR_ERR(page);
 		if (IS_ERR(page))
 			goto out;
-		kaddr = page_address(page);
-		de = (ext2_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE - reclen;
-		while ((char *)de <= kaddr) {
-			err = -EEXIST;
-			if (ext2_match (namelen, name, de))
-				goto out_page;
-			name_len = EXT2_DIR_REC_LEN(de->name_len);
-			rec_len = le16_to_cpu(de->rec_len);
-			if (!de->inode && rec_len >= reclen)
-				goto got_it;
-			if (rec_len >= name_len + reclen)
-				goto got_it;
-			de = (ext2_dirent *) ((char *) de + rec_len);
+		for (i=0; i<PAGE_CACHE_PAGES; i++) {
+			map = page + i;
+			kaddr = kmap(map);
+			de = (ext2_dirent *)kaddr;
+			kaddr += PAGE_SIZE - reclen;
+			while ((char *)de <= kaddr) {
+				err = -EEXIST;
+				if (ext2_match (namelen, name, de))
+					goto out_page;
+				name_len = EXT2_DIR_REC_LEN(de->name_len);
+				rec_len = le16_to_cpu(de->rec_len);
+				if (!de->inode && rec_len >= reclen)
+					goto got_it;
+				if (rec_len >= name_len + reclen)
+					goto got_it;
+				de = (ext2_dirent *) ((char *) de + rec_len);
+			}
 		}
 		ext2_put_page(page);
 	}
@@ -425,7 +454,7 @@
 	return -EINVAL;

 got_it:
-	from = (char*)de - (char*)page_address(page);
+	from = (char*)de - (kaddr - (PAGE_SIZE - reclen));
 	to = from + rec_len;
 	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
@@ -448,6 +477,7 @@
 out_unlock:
 	UnlockPage(page);
 out_page:
+	kunmap(map);
 	ext2_put_page(page);
 out:
 	return err;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/mm.h pgc-2.4.6-pre8/include/linux/mm.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/mm.h	Tue Jul  3 22:00:04 2001
+++ pgc-2.4.6-pre8/include/linux/mm.h	Wed Jul  4 01:57:05 2001
@@ -282,6 +282,7 @@
 #define PG_inactive_clean	11
 #define PG_highmem		12
 #define PG_checked		13	/* kill me in 2.5.<early>. */
+#define PG_pagecache		14
 				/* bits 21-29 unused */
 #define PG_arch_1		30
 #define PG_reserved		31
@@ -298,6 +299,9 @@
 #define TryLockPage(page)	test_and_set_bit(PG_locked, &(page)->flags)
 #define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
 #define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
+#define PageCachePage(page)	test_bit(PG_pagecache, &(page)->flags)
+#define SetPageCache(page)	set_bit(PG_pagecache, &(page)->flags)
+#define ClearPageCache(page)	clear_bit(PG_pagecache, &(page)->flags)

 extern void __set_page_dirty(struct page *);

diff -ur /md0/kernels/2.4/v2.4.6-pre8/include/linux/pagemap.h pgc-2.4.6-pre8/include/linux/pagemap.h
--- /md0/kernels/2.4/v2.4.6-pre8/include/linux/pagemap.h	Tue Jul  3 22:00:04 2001
+++ pgc-2.4.6-pre8/include/linux/pagemap.h	Thu Jul  5 00:50:10 2001
@@ -22,19 +22,53 @@
  * space in smaller chunks for same flexibility).
  *
  * Or rather, it _will_ be done in larger chunks.
+ *
+ * It is now configurable.  -ben 20010702
  */
-#define PAGE_CACHE_SHIFT	PAGE_SHIFT
-#define PAGE_CACHE_SIZE		PAGE_SIZE
-#define PAGE_CACHE_MASK		PAGE_MASK
+#define PAGE_CACHE_ORDER	(CONFIG_PAGE_CACHE_SHIFT)
+#define PAGE_CACHE_PAGES	(1UL << CONFIG_PAGE_CACHE_SHIFT)
+#define PAGE_CACHE_PMASK	(PAGE_CACHE_PAGES - 1)
+#define PAGE_CACHE_SHIFT	(PAGE_SHIFT + CONFIG_PAGE_CACHE_SHIFT)
+#define PAGE_CACHE_SIZE		(1UL << PAGE_CACHE_SHIFT)
+#define PAGE_CACHE_MASK		(~(PAGE_CACHE_SIZE - 1))
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)

+#define __page_cache_page(page)	(page - ((page - mem_map) & PAGE_CACHE_PMASK))
+
+static inline struct page *page_cache_page(struct page *page)
+{
+	if (PageCachePage(page))
+		page = __page_cache_page(page);
+	return page;
+}
+
 #define page_cache_get(x)	get_page(x)
-#define page_cache_free(x)	__free_page(x)
-#define page_cache_release(x)	__free_page(x)
+#define __page_cache_free(x)	__free_pages(x, PAGE_CACHE_ORDER)
+#define page_cache_free(x)	page_cache_release(x)
+
+static inline void page_cache_release(struct page *page)
+{
+	if (PageCachePage(page))
+		__page_cache_free(__page_cache_page(page));
+	else
+		__free_page(page);
+}
+
+static inline struct page *__page_cache_alloc(int gfp)
+{
+	struct page *page;
+	page = alloc_pages(gfp, PAGE_CACHE_ORDER);
+	if (page) {
+		unsigned i;
+		for (i=0; i<PAGE_CACHE_PAGES; i++)
+			SetPageCache(page+i);
+	}
+	return page;
+}

 static inline struct page *page_cache_alloc(struct address_space *x)
 {
-	return alloc_pages(x->gfp_mask, 0);
+	return __page_cache_alloc(x->gfp_mask);
 }

 /*
diff -ur /md0/kernels/2.4/v2.4.6-pre8/mm/filemap.c pgc-2.4.6-pre8/mm/filemap.c
--- /md0/kernels/2.4/v2.4.6-pre8/mm/filemap.c	Sat Jun 30 14:04:28 2001
+++ pgc-2.4.6-pre8/mm/filemap.c	Thu Jul  5 00:19:39 2001
@@ -236,13 +236,12 @@
 		if ((offset >= start) || (*partial && (offset + 1) == start)) {
 			list_del(head);
 			list_add(head, curr);
+			page_cache_get(page);
 			if (TryLockPage(page)) {
-				page_cache_get(page);
 				spin_unlock(&pagecache_lock);
 				wait_on_page(page);
 				goto out_restart;
 			}
-			page_cache_get(page);
 			spin_unlock(&pagecache_lock);

 			if (*partial && (offset + 1) == start) {
@@ -1274,9 +1273,28 @@
 	if (size > count)
 		size = count;

-	kaddr = kmap(page);
-	left = __copy_to_user(desc->buf, kaddr + offset, size);
-	kunmap(page);
+	left = size;
+	page += offset >> PAGE_SHIFT;
+	offset &= PAGE_SIZE - 1;
+
+	do {
+		unsigned this = PAGE_SIZE - offset;
+
+		if (left < this)
+			this = left;
+
+		left -= this;
+		kaddr = kmap(page);
+		this = __copy_to_user(desc->buf, kaddr + offset, this);
+		kunmap(page);
+		offset = 0;
+
+		if (this) {
+			left += this;
+			break;
+		}
+		page++;
+	} while (left);

 	if (left) {
 		size -= left;
@@ -1499,8 +1517,11 @@
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page, **hash, *old_page;
 	unsigned long size, pgoff;
+	unsigned long offset;

-	pgoff = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
+	pgoff = ((address - area->vm_start) >> PAGE_SHIFT) + area->vm_pgoff;
+	offset = pgoff & PAGE_CACHE_PMASK;
+	pgoff >>= PAGE_CACHE_ORDER;

 retry_all:
 	/*
@@ -1538,7 +1559,7 @@
 	 * Found the page and have a reference on it, need to check sharing
 	 * and possibly copy it over to another page..
 	 */
-	old_page = page;
+	old_page = page + offset;
 	if (no_share) {
 		struct page *new_page = alloc_page(GFP_HIGHUSER);

@@ -1652,6 +1673,7 @@
 	if (pte_present(pte) && ptep_test_and_clear_dirty(ptep)) {
 		struct page *page = pte_page(pte);
 		flush_tlb_page(vma, address);
+		page = page_cache_page(page);
 		set_page_dirty(page);
 	}
 	return 0;
@@ -1682,7 +1704,7 @@
 	do {
 		error |= filemap_sync_pte(pte, vma, address + offset, flags);
 		address += PAGE_SIZE;
-		pte++;
+		pte ++;
 	} while (address && (address < end));
 	return error;
 }
diff -ur /md0/kernels/2.4/v2.4.6-pre8/mm/memory.c pgc-2.4.6-pre8/mm/memory.c
--- /md0/kernels/2.4/v2.4.6-pre8/mm/memory.c	Sat Jun 30 14:04:28 2001
+++ pgc-2.4.6-pre8/mm/memory.c	Thu Jul  5 00:49:38 2001
@@ -233,6 +233,7 @@
 				if (vma->vm_flags & VM_SHARED)
 					pte = pte_mkclean(pte);
 				pte = pte_mkold(pte);
+				ptepage = page_cache_page(ptepage);
 				get_page(ptepage);

 cont_copy_pte_range:		set_pte(dst_pte, pte);
@@ -268,6 +269,7 @@
 		struct page *page = pte_page(pte);
 		if ((!VALID_PAGE(page)) || PageReserved(page))
 			return 0;
+		page = page_cache_page(page);
 		/*
 		 * free_page() used to be able to clear swap cache
 		 * entries.  We may now have to do it manually.
@@ -508,7 +510,7 @@
 		map = get_page_map(map);
 		if (map) {
 			flush_dcache_page(map);
-			atomic_inc(&map->count);
+			get_page(page_cache_page(map));
 		} else
 			printk (KERN_INFO "Mapped page missing [%d]\n", i);
 		spin_unlock(&mm->page_table_lock);
@@ -551,7 +553,7 @@

 	while (remaining > 0 && index < iobuf->nr_pages) {
 		page = iobuf->maplist[index];
-
+		page = page_cache_page(page);
 		if (!PageReserved(page))
 			SetPageDirty(page);

@@ -574,6 +576,7 @@
 	for (i = 0; i < iobuf->nr_pages; i++) {
 		map = iobuf->maplist[i];
 		if (map) {
+			map = page_cache_page(map);
 			if (iobuf->locked)
 				UnlockPage(map);
 			__free_page(map);
@@ -616,7 +619,7 @@
 			page = *ppage;
 			if (!page)
 				continue;
-
+			page = page_cache_page(page);
 			if (TryLockPage(page)) {
 				while (j--) {
 					page = *(--ppage);
@@ -687,6 +690,7 @@
 			page = *ppage;
 			if (!page)
 				continue;
+			page = page_cache_page(page);
 			UnlockPage(page);
 		}
 	}
@@ -894,12 +898,14 @@
 static int do_wp_page(struct mm_struct *mm, struct vm_area_struct * vma,
 	unsigned long address, pte_t *page_table, pte_t pte)
 {
-	struct page *old_page, *new_page;
+	struct page *old_page, *__old_page, *new_page;
+
+	__old_page = pte_page(pte);
+	old_page = page_cache_page(__old_page);

-	old_page = pte_page(pte);
 	if (!VALID_PAGE(old_page))
 		goto bad_wp_page;
-
+
 	/*
 	 * We can avoid the copy if:
 	 * - we're the only user (count == 1)
@@ -949,7 +955,7 @@
 	if (pte_same(*page_table, pte)) {
 		if (PageReserved(old_page))
 			++mm->rss;
-		break_cow(vma, old_page, new_page, address, page_table);
+		break_cow(vma, __old_page, new_page, address, page_table);

 		/* Free the old page.. */
 		new_page = old_page;
@@ -1016,7 +1022,7 @@
 	if (!mapping->i_mmap && !mapping->i_mmap_shared)
 		goto out_unlock;

-	pgoff = (offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	pgoff = (offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	if (mapping->i_mmap != NULL)
 		vmtruncate_list(mapping->i_mmap, pgoff);
 	if (mapping->i_mmap_shared != NULL)
@@ -1201,25 +1207,30 @@
 static int do_no_page(struct mm_struct * mm, struct vm_area_struct * vma,
 	unsigned long address, int write_access, pte_t *page_table)
 {
-	struct page * new_page;
+	struct page *new_page, *ppage;
 	pte_t entry;
+	int no_share, offset, i;
+	unsigned long addr_min, addr_max;

 	if (!vma->vm_ops || !vma->vm_ops->nopage)
 		return do_anonymous_page(mm, vma, page_table, write_access, address);
 	spin_unlock(&mm->page_table_lock);

+	mm, vma, address, write_access, page_table);
 	/*
 	 * The third argument is "no_share", which tells the low-level code
 	 * to copy, not share the page even if sharing is possible.  It's
 	 * essentially an early COW detection.
 	 */
-	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, (vma->vm_flags & VM_SHARED)?0:write_access);
+	no_share = (vma->vm_flags & VM_SHARED) ? 0 : write_access;
+	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, no_share);

 	spin_lock(&mm->page_table_lock);
 	if (new_page == NULL)	/* no page was available -- SIGBUS */
 		return 0;
 	if (new_page == NOPAGE_OOM)
 		return -1;
+	ppage = page_cache_page(new_page);
 	/*
 	 * This silly early PAGE_DIRTY setting removes a race
 	 * due to the bad i386 page protection. But it's valid
@@ -1231,25 +1242,70 @@
 	 * handle that later.
 	 */
 	/* Only go through if we didn't race with anybody else... */
-	if (pte_none(*page_table)) {
-		++mm->rss;
+	if (!pte_none(*page_table)) {
+		/* One of our sibling threads was faster, back out. */
+		page_cache_release(ppage);
+		return 1;
+	}
+
+	addr_min = address & PMD_MASK;
+	addr_max = address | (PMD_SIZE - 1);
+
+	if (vma->vm_start > addr_min)
+		addr_min = vma->vm_start;
+	if (vma->vm_end < addr_max)
+		addr_max = vma->vm_end;
+
+	/* The following implements PAGE_CACHE_SIZE prefilling of
+	 * page tables.  The technique is essentially the same as
+	 * a cache burst using
+	 */
+	offset = address >> PAGE_SHIFT;
+	offset &= PAGE_CACHE_PMASK;
+	i = 0;
+	do {
+		if (!pte_none(*page_table))
+			goto next_page;
+
+		if ((address < addr_min) || (address > addr_max))
+			goto next_page;
+
+		if (!i)
+			page_cache_get(ppage);
+
+		mm->rss++;
 		flush_page_to_ram(new_page);
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		if (write_access) {
+		if (write_access && !i)
 			entry = pte_mkwrite(pte_mkdirty(entry));
-		} else if (page_count(new_page) > 1 &&
+		else if (page_count(ppage) > 1 &&
 			   !(vma->vm_flags & VM_SHARED))
 			entry = pte_wrprotect(entry);
+		if (i)
+			entry = pte_mkold(entry);
 		set_pte(page_table, entry);
-	} else {
-		/* One of our sibling threads was faster, back out. */
-		page_cache_release(new_page);
-		return 1;
-	}

-	/* no need to invalidate: a not-present page shouldn't be cached */
-	update_mmu_cache(vma, address, entry);
+		/* no need to invalidate: a not-present page shouldn't be cached */
+		update_mmu_cache(vma, address, entry);
+
+next_page:
+		if (!PageCachePage(ppage))
+			break;
+		if ((ppage + offset) != new_page)
+			break;
+
+		/* Implement wrap around for the address, page and ptep. */
+		address -= offset << PAGE_SHIFT;
+		page_table -= offset;
+		new_page -= offset;
+
+		offset = (offset + 1) & PAGE_CACHE_PMASK;
+
+		address += offset << PAGE_SHIFT;
+		page_table += offset;
+		new_page += offset;
+	} while (++i < PAGE_CACHE_PAGES) ;
 	return 2;	/* Major fault */
 }

diff -ur /md0/kernels/2.4/v2.4.6-pre8/mm/page_alloc.c pgc-2.4.6-pre8/mm/page_alloc.c
--- /md0/kernels/2.4/v2.4.6-pre8/mm/page_alloc.c	Sat Jun 30 14:04:28 2001
+++ pgc-2.4.6-pre8/mm/page_alloc.c	Wed Jul  4 02:46:12 2001
@@ -87,6 +87,13 @@
 		BUG();
 	if (PageInactiveClean(page))
 		BUG();
+	if (PageCachePage(page) && (order != PAGE_CACHE_ORDER)) {
+		printk("PageCachePage and order == %lu\n", order);
+		BUG();
+	}
+
+	for (index=0; index < (1<<order); index++)
+		ClearPageCache(page+index);

 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
 	page->age = PAGE_AGE_START;
diff -ur /md0/kernels/2.4/v2.4.6-pre8/mm/vmscan.c pgc-2.4.6-pre8/mm/vmscan.c
--- /md0/kernels/2.4/v2.4.6-pre8/mm/vmscan.c	Sat Jun 30 14:04:28 2001
+++ pgc-2.4.6-pre8/mm/vmscan.c	Mon Jul  2 17:08:34 2001
@@ -38,8 +38,11 @@
 /* mm->page_table_lock is held. mmap_sem is not held */
 static void try_to_swap_out(struct mm_struct * mm, struct vm_area_struct* vma, unsigned long address, pte_t * page_table, struct page *page)
 {
-	pte_t pte;
 	swp_entry_t entry;
+	pte_t pte;
+
+	if (PageCachePage(page))
+		page = page_cache_page(page);

 	/* Don't look at this pte if it's been accessed recently. */
 	if (ptep_test_and_clear_young(page_table)) {

