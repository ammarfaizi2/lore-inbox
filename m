Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312573AbSDJKx6>; Wed, 10 Apr 2002 06:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312574AbSDJKx5>; Wed, 10 Apr 2002 06:53:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312573AbSDJKxx>;
	Wed, 10 Apr 2002 06:53:53 -0400
Message-ID: <3CB419BB.D7649D52@zip.com.au>
Date: Wed, 10 Apr 2002 03:53:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: ext2-devel@lists.sourceforge.net
Subject: [patch] ext2 directory handling
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ext2's directory parsing relies on the preservation of the
data outside i_size in the last page of the directory mapping.

But with the stuff I'm doing, ext2 directory pages are marked
dirty, and can be written out at any time via writepage.

And block_write_full_page zaps the data outside i_size, which 
causes the ext2 directory scan code to go into an infinite
loop when it hits rec_len == 0.

The patch teaches ext2 to not look at anything outside
i_size when the backing page is not locked.

It also adds lots of checks for rec_len == 0, which fixes the
lockup.  In a perfect world, those checks are not needed, because
the checking was already performed in ext2_check_page.   But
these checks do help to catch problems which have a tendency to
arise with the stuff I'm doing.

I'd really appreciate it if someone could double-check this
patch, please.


Patch against
2.5.8-pre3+ratcache+readahead+pageprivate+pdflush+pdflush_inodes+pdflush_buffers

--- 2.5.8-pre3/fs/ext2/dir.c~dallocbase-55-ext2_dir	Wed Apr 10 00:42:47 2002
+++ 2.5.8-pre3-akpm/fs/ext2/dir.c	Wed Apr 10 02:44:30 2002
@@ -46,6 +46,21 @@ static inline unsigned long dir_pages(st
 	return (inode->i_size+PAGE_CACHE_SIZE-1)>>PAGE_CACHE_SHIFT;
 }
 
+/*
+ * Return the offset into page `page_nr' of the last valid
+ * byte in that page, plus one.
+ */
+static unsigned
+ext2_last_byte(struct inode *inode, unsigned long page_nr)
+{
+	unsigned last_byte = inode->i_size;
+
+	last_byte -= page_nr << PAGE_CACHE_SHIFT;
+	if (last_byte > PAGE_CACHE_SIZE)
+		last_byte = PAGE_CACHE_SIZE;
+	return last_byte;
+}
+
 static int ext2_commit_chunk(struct page *page, unsigned from, unsigned to)
 {
 	struct inode *dir = page->mapping->host;
@@ -78,10 +93,6 @@ static void ext2_check_page(struct page 
 		limit = dir->i_size & ~PAGE_CACHE_MASK;
 		if (limit & (chunk_size - 1))
 			goto Ebadsize;
-		for (offs = limit; offs<PAGE_CACHE_SIZE; offs += chunk_size) {
-			ext2_dirent *p = (ext2_dirent*)(kaddr + offs);
-			p->rec_len = cpu_to_le16(chunk_size);
-		}
 		if (!limit)
 			goto out;
 	}
@@ -197,8 +208,11 @@ ext2_validate_entry(char *base, unsigned
 {
 	ext2_dirent *de = (ext2_dirent*)(base + offset);
 	ext2_dirent *p = (ext2_dirent*)(base + (offset&mask));
-	while ((char*)p < (char*)de)
+	while ((char*)p < (char*)de) {
+		if (p->rec_len == 0)
+			break;
 		p = ext2_next_entry(p);
+	}
 	return (char *)p - base;
 }
 
@@ -245,6 +259,7 @@ ext2_readdir (struct file * filp, void *
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
 	unsigned char *types = NULL;
 	int need_revalidate = (filp->f_version != inode->i_version);
+	int ret = 0;
 
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
 		goto done;
@@ -265,8 +280,15 @@ ext2_readdir (struct file * filp, void *
 			need_revalidate = 0;
 		}
 		de = (ext2_dirent *)(kaddr+offset);
-		limit = kaddr + PAGE_CACHE_SIZE - EXT2_DIR_REC_LEN(1);
-		for ( ;(char*)de <= limit; de = ext2_next_entry(de))
+		limit = kaddr + ext2_last_byte(inode, n) - EXT2_DIR_REC_LEN(1);
+		for ( ;(char*)de <= limit; de = ext2_next_entry(de)) {
+			if (de->rec_len == 0) {
+				ext2_error(sb, __FUNCTION__,
+					"zero-length directory entry");
+				ret = -EIO;
+				ext2_put_page(page);
+				goto done;
+			}
 			if (de->inode) {
 				int over;
 				unsigned char d_type = DT_UNKNOWN;
@@ -283,6 +305,7 @@ ext2_readdir (struct file * filp, void *
 					goto done;
 				}
 			}
+		}
 		ext2_put_page(page);
 	}
 
@@ -326,10 +349,16 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		if (!IS_ERR(page)) {
 			kaddr = page_address(page);
 			de = (ext2_dirent *) kaddr;
-			kaddr += PAGE_CACHE_SIZE - reclen;
+			kaddr += ext2_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
 				if (ext2_match (namelen, name, de))
 					goto found;
+				if (de->rec_len == 0) {
+					ext2_error(dir->i_sb, __FUNCTION__,
+						"zero-length directory entry");
+					ext2_put_page(page);
+					goto out;
+				}
 				de = ext2_next_entry(de);
 			}
 			ext2_put_page(page);
@@ -337,6 +366,7 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		if (++n >= npages)
 			n = 0;
 	} while (n != start);
+out:
 	return NULL;
 
 found:
@@ -401,6 +431,7 @@ int ext2_add_link (struct dentry *dentry
 	struct inode *dir = dentry->d_parent->d_inode;
 	const char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
+	unsigned chunk_size = ext2_chunk_size(dir);
 	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
 	unsigned short rec_len, name_len;
 	struct page *page = NULL;
@@ -411,27 +442,50 @@ int ext2_add_link (struct dentry *dentry
 	unsigned from, to;
 	int err;
 
-	/* We take care of directory expansion in the same loop */
+	/*
+	 * We take care of directory expansion in the same loop.
+	 * This code plays outside i_size, so it locks the page
+	 * to protect that region.
+	 */
 	for (n = 0; n <= npages; n++) {
+		char *dir_end;
+
 		page = ext2_get_page(dir, n);
 		err = PTR_ERR(page);
 		if (IS_ERR(page))
 			goto out;
+		lock_page(page);
 		kaddr = page_address(page);
+		dir_end = kaddr + ext2_last_byte(dir, n);
 		de = (ext2_dirent *)kaddr;
 		kaddr += PAGE_CACHE_SIZE - reclen;
 		while ((char *)de <= kaddr) {
 			err = -EEXIST;
 			if (ext2_match (namelen, name, de))
-				goto out_page;
+				goto out_unlock;
+			if ((char *)de == dir_end) {
+				/* We hit i_size */
+				name_len = 0;
+				rec_len = chunk_size;
+				de->rec_len = cpu_to_le16(chunk_size);
+				de->inode = 0;
+				goto got_it;
+			}
 			name_len = EXT2_DIR_REC_LEN(de->name_len);
 			rec_len = le16_to_cpu(de->rec_len);
 			if (!de->inode && rec_len >= reclen)
 				goto got_it;
 			if (rec_len >= name_len + reclen)
 				goto got_it;
+			if (de->rec_len == 0) {
+				ext2_error(dir->i_sb, __FUNCTION__,
+					"zero-length directory entry");
+				err = -EIO;
+				goto out_unlock;
+			}
 			de = (ext2_dirent *) ((char *) de + rec_len);
 		}
+		unlock_page(page);
 		ext2_put_page(page);
 	}
 	BUG();
@@ -440,7 +494,6 @@ int ext2_add_link (struct dentry *dentry
 got_it:
 	from = (char*)de - (char*)page_address(page);
 	to = from + rec_len;
-	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		goto out_unlock;
@@ -460,7 +513,6 @@ got_it:
 	/* OFFSET_CACHE */
 out_unlock:
 	UnlockPage(page);
-out_page:
 	ext2_put_page(page);
 out:
 	return err;
@@ -484,6 +536,12 @@ int ext2_delete_entry (struct ext2_dir_e
 	while ((char*)de < (char*)dir) {
 		pde = de;
 		de = ext2_next_entry(de);
+		if (de->rec_len == 0) {
+			ext2_error(inode->i_sb, __FUNCTION__,
+				"zero-length directory entry");
+			err = -EIO;
+			goto out;
+		}
 	}
 	if (pde)
 		from = (char*)pde - (char*)page_address(page);
@@ -496,9 +554,10 @@ int ext2_delete_entry (struct ext2_dir_e
 	dir->inode = 0;
 	err = ext2_commit_chunk(page, from, to);
 	UnlockPage(page);
-	ext2_put_page(page);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
+out:
+	ext2_put_page(page);
 	return err;
 }
 
@@ -550,7 +609,7 @@ int ext2_empty_dir (struct inode * inode
 {
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
-	
+
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		ext2_dirent * de;
@@ -561,7 +620,7 @@ int ext2_empty_dir (struct inode * inode
 
 		kaddr = page_address(page);
 		de = (ext2_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE-EXT2_DIR_REC_LEN(1);
+		kaddr += ext2_last_byte(inode, i) - EXT2_DIR_REC_LEN(1);
 
 		while ((char *)de <= kaddr) {
 			if (de->inode != 0) {
@@ -578,6 +637,11 @@ int ext2_empty_dir (struct inode * inode
 					goto not_empty;
 			}
 			de = ext2_next_entry(de);
+			if (de->rec_len == 0) {
+				ext2_error(inode->i_sb, __FUNCTION__,
+					"zero-length directory entry");
+				goto not_empty;
+			}
 		}
 		ext2_put_page(page);
 	}

-
