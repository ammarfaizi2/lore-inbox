Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312586AbSDJL2B>; Wed, 10 Apr 2002 07:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSDJL2A>; Wed, 10 Apr 2002 07:28:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60935 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312586AbSDJL17>;
	Wed, 10 Apr 2002 07:27:59 -0400
Message-ID: <3CB421BD.2FF47C46@zip.com.au>
Date: Wed, 10 Apr 2002 04:27:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: [patch] ext2 directory handling
In-Reply-To: <3CB419BB.D7649D52@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That was an old version.  This is it:

--- 2.5.8-pre3/fs/ext2/dir.c~dallocbase-55-ext2_dir	Wed Apr 10 00:42:47 2002
+++ 2.5.8-pre3-akpm/fs/ext2/dir.c	Wed Apr 10 03:11:50 2002
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
 
@@ -326,8 +349,14 @@ struct ext2_dir_entry_2 * ext2_find_entr
 		if (!IS_ERR(page)) {
 			kaddr = page_address(page);
 			de = (ext2_dirent *) kaddr;
-			kaddr += PAGE_CACHE_SIZE - reclen;
+			kaddr += ext2_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
+				if (de->rec_len == 0) {
+					ext2_error(dir->i_sb, __FUNCTION__,
+						"zero-length directory entry");
+					ext2_put_page(page);
+					goto out;
+				}
 				if (ext2_match (namelen, name, de))
 					goto found;
 				de = ext2_next_entry(de);
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
@@ -411,19 +442,41 @@ int ext2_add_link (struct dentry *dentry
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
+			if (de->rec_len == 0) {
+				ext2_error(dir->i_sb, __FUNCTION__,
+					"zero-length directory entry");
+				err = -EIO;
+				goto out_unlock;
+			}
 			name_len = EXT2_DIR_REC_LEN(de->name_len);
 			rec_len = le16_to_cpu(de->rec_len);
 			if (!de->inode && rec_len >= reclen)
@@ -432,6 +485,7 @@ int ext2_add_link (struct dentry *dentry
 				goto got_it;
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
@@ -482,6 +534,12 @@ int ext2_delete_entry (struct ext2_dir_e
 	int err;
 
 	while ((char*)de < (char*)dir) {
+		if (de->rec_len == 0) {
+			ext2_error(inode->i_sb, __FUNCTION__,
+				"zero-length directory entry");
+			err = -EIO;
+			goto out;
+		}
 		pde = de;
 		de = ext2_next_entry(de);
 	}
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
@@ -561,9 +620,15 @@ int ext2_empty_dir (struct inode * inode
 
 		kaddr = page_address(page);
 		de = (ext2_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE-EXT2_DIR_REC_LEN(1);
+		kaddr += ext2_last_byte(inode, i) - EXT2_DIR_REC_LEN(1);
 
 		while ((char *)de <= kaddr) {
+			if (de->rec_len == 0) {
+				ext2_error(inode->i_sb, __FUNCTION__,
+					"zero-length directory entry");
+				printk("kaddr=%p, de=%p\n", kaddr, de);
+				goto not_empty;
+			}
 			if (de->inode != 0) {
 				/* check for . and .. */
 				if (de->name[0] != '.')

-
