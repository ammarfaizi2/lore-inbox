Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSDXIty>; Wed, 24 Apr 2002 04:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSDXItw>; Wed, 24 Apr 2002 04:49:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33551 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293187AbSDXItg>;
	Wed, 24 Apr 2002 04:49:36 -0400
Message-ID: <3CC671BB.5B1B9CC7@zip.com.au>
Date: Wed, 24 Apr 2002 01:50:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] minixfs: don't rely on page contents outside i_size
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the first of a bunch of patches which come after
the big writeback patch.  Most of them are cleanups.
It's all still a couple of weeks out, but I may as well
unload them now, see if anyone has any comments.

This one modifies minixfs to not rely on the contents
of directory data outside i_size.  (Minix actually
doesn't need this, because it works happily when
writepage is clearing the page outside i_size, but it's
neater this way).



--- 2.5.9/fs/minix/dir.c~dallocbase-85-minix_dir	Wed Apr 24 01:06:10 2002
+++ 2.5.9-akpm/fs/minix/dir.c	Wed Apr 24 01:45:06 2002
@@ -24,6 +24,20 @@ static inline void dir_put_page(struct p
 	page_cache_release(page);
 }
 
+/*
+ * Return the offset into page `page_nr' of the last valid
+ * byte in that page, plus one.
+ */
+static unsigned
+minix_last_byte(struct inode *inode, unsigned long page_nr)
+{
+	unsigned last_byte = PAGE_CACHE_SIZE;
+
+	if (page_nr == (inode->i_size >> PAGE_CACHE_SHIFT))
+		last_byte = inode->i_size & (PAGE_CACHE_SIZE - 1);
+	return last_byte;
+}
+
 static inline unsigned long dir_pages(struct inode *inode)
 {
 	return (inode->i_size+PAGE_CACHE_SIZE-1)>>PAGE_CACHE_SHIFT;
@@ -90,7 +104,7 @@ static int minix_readdir(struct file * f
 			continue;
 		kaddr = (char *)page_address(page);
 		p = kaddr+offset;
-		limit = kaddr + PAGE_CACHE_SIZE - chunk_size;
+		limit = kaddr + minix_last_byte(inode, n) - chunk_size;
 		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
 			minix_dirent *de = (minix_dirent *)p;
 			if (de->inode) {
@@ -154,7 +168,7 @@ minix_dirent *minix_find_entry(struct de
 
 		kaddr = (char*)page_address(page);
 		de = (struct minix_dir_entry *) kaddr;
-		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
+		kaddr += minix_last_byte(dir, n) - sbi->s_dirsize;
 		for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
 			if (!de->inode)
 				continue;
@@ -185,23 +199,37 @@ int minix_add_link(struct dentry *dentry
 	unsigned from, to;
 	int err;
 
-	/* We take care of directory expansion in the same loop */
+	/*
+	 * We take care of directory expansion in the same loop
+	 * This code plays outside i_size, so it locks the page
+	 * to protect that region.
+	 */
 	for (n = 0; n <= npages; n++) {
+		char *dir_end;
+
 		page = dir_get_page(dir, n);
 		err = PTR_ERR(page);
 		if (IS_ERR(page))
 			goto out;
+		lock_page(page);
 		kaddr = (char*)page_address(page);
+		dir_end = kaddr + minix_last_byte(dir, n);
 		de = (minix_dirent *)kaddr;
 		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
 		while ((char *)de <= kaddr) {
+			if ((char *)de == dir_end) {
+				/* We hit i_size */
+				de->inode = 0;
+				goto got_it;
+			}
 			if (!de->inode)
 				goto got_it;
 			err = -EEXIST;
 			if (namecompare(namelen,sbi->s_namelen,name,de->name))
-				goto out_page;
+				goto out_unlock;
 			de = minix_next_entry(de, sbi);
 		}
+		unlock_page(page);
 		dir_put_page(page);
 	}
 	BUG();
@@ -210,7 +238,6 @@ int minix_add_link(struct dentry *dentry
 got_it:
 	from = (char*)de - (char*)page_address(page);
 	to = from + sbi->s_dirsize;
-	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
 	if (err)
 		goto out_unlock;
@@ -221,8 +248,7 @@ got_it:
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 out_unlock:
-	UnlockPage(page);
-out_page:
+	unlock_page(page);
 	dir_put_page(page);
 out:
 	return err;
@@ -301,7 +327,7 @@ int minix_empty_dir(struct inode * inode
 
 		kaddr = (char *)page_address(page);
 		de = (minix_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
+		kaddr += minix_last_byte(inode, i) - sbi->s_dirsize;
 
 		while ((char *)de <= kaddr) {
 			if (de->inode != 0) {

-
