Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWESRP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWESRP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWESRP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:15:27 -0400
Received: from mx2.mail.ru ([194.67.23.122]:8222 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751377AbWESRPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:15:21 -0400
Date: Fri, 19 May 2006 21:18:33 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ufs: directory and page cache: from blocks to pages
Message-ID: <20060519171833.GA28572@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes function in fs/ufs/dir.c and fs/ufs/namei.c
to work with pages instead of straight work with blocks.
It fixed such bugs:
* for i in `seq 1 1000`; do touch $i; done - crash system
* mkdir create directory without "." and ".." entries

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/dir.c linux-2.6.17-rc4/fs/ufs/dir.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/dir.c	2006-05-19 19:54:24.127061250 +0400
+++ linux-2.6.17-rc4/fs/ufs/dir.c	2006-05-19 18:52:29.806930750 +0400
@@ -11,13 +11,15 @@
  * 4.4BSD (FreeBSD) support added on February 1st 1998 by
  * Niels Kristian Bech Jensen <nkbj@image.dk> partially based
  * on code by Martin von Loewis <martin@mira.isdn.cs.tu-berlin.de>.
+ *
+ * Migration to usage of "page cache" on May 2006 by
+ * Evgeniy Dushistov <dushistov@mail.ru> based on ext2 code base.
  */
 
 #include <linux/time.h>
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
 #include <linux/smp_lock.h>
-#include <linux/buffer_head.h>
 #include <linux/sched.h>
 
 #include "swab.h"
@@ -31,11 +33,6 @@
 #define UFSD(x)
 #endif
 
-static int
-ufs_check_dir_entry (const char *, struct inode *, struct ufs_dir_entry *,
-		     struct buffer_head *, unsigned long);
-
-
 /*
  * NOTE! unlike strncmp, ufs_match returns 1 for success, 0 for failure.
  *
@@ -51,495 +48,540 @@ static inline int ufs_match(struct super
 	return !memcmp(name, de->d_name, len);
 }
 
-/*
- * This is blatantly stolen from ext2fs
- */
-static int
-ufs_readdir (struct file * filp, void * dirent, filldir_t filldir)
+static int ufs_commit_chunk(struct page *page, unsigned from, unsigned to)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
-	int error = 0;
-	unsigned long offset, lblk;
-	int i, stored;
-	struct buffer_head * bh;
-	struct ufs_dir_entry * de;
-	struct super_block * sb;
-	int de_reclen;
-	unsigned flags;
-	u64     blk= 0L;
-
-	lock_kernel();
-
-	sb = inode->i_sb;
-	flags = UFS_SB(sb)->s_flags;
-
-	UFSD(("ENTER, ino %lu  f_pos %lu\n", inode->i_ino, (unsigned long) filp->f_pos))
-
-	stored = 0;
-	bh = NULL;
-	offset = filp->f_pos & (sb->s_blocksize - 1);
-
-	while (!error && !stored && filp->f_pos < inode->i_size) {
-		lblk = (filp->f_pos) >> sb->s_blocksize_bits;
-		blk = ufs_frag_map(inode, lblk);
-		if (!blk || !(bh = sb_bread(sb, blk))) {
-			/* XXX - error - skip to the next block */
-			printk("ufs_readdir: "
-			       "dir inode %lu has a hole at offset %lu\n",
-			       inode->i_ino, (unsigned long int)filp->f_pos);
-			filp->f_pos += sb->s_blocksize - offset;
-			continue;
-		}
-
-revalidate:
-		/* If the dir block has changed since the last call to
-		 * readdir(2), then we might be pointing to an invalid
-		 * dirent right now.  Scan from the start of the block
-		 * to make sure. */
-		if (filp->f_version != inode->i_version) {
-			for (i = 0; i < sb->s_blocksize && i < offset; ) {
-				de = (struct ufs_dir_entry *)(bh->b_data + i);
-				/* It's too expensive to do a full
-				 * dirent test each time round this
-				 * loop, but we do have to test at
-				 * least that it is non-zero.  A
-				 * failure will be detected in the
-				 * dirent test below. */
-				de_reclen = fs16_to_cpu(sb, de->d_reclen);
-				if (de_reclen < 1)
-					break;
-				i += de_reclen;
-			}
-			offset = i;
-			filp->f_pos = (filp->f_pos & ~(sb->s_blocksize - 1))
-				| offset;
-			filp->f_version = inode->i_version;
-		}
-
-		while (!error && filp->f_pos < inode->i_size
-		       && offset < sb->s_blocksize) {
-			de = (struct ufs_dir_entry *) (bh->b_data + offset);
-			/* XXX - put in a real ufs_check_dir_entry() */
-			if ((de->d_reclen == 0) || (ufs_get_de_namlen(sb, de) == 0)) {
-				filp->f_pos = (filp->f_pos &
-				              (sb->s_blocksize - 1)) +
-				               sb->s_blocksize;
-				brelse(bh);
-				unlock_kernel();
-				return stored;
-			}
-			if (!ufs_check_dir_entry ("ufs_readdir", inode, de,
-						   bh, offset)) {
-				/* On error, skip the f_pos to the
-				   next block. */
-				filp->f_pos = (filp->f_pos |
-				              (sb->s_blocksize - 1)) +
-					       1;
-				brelse (bh);
-				unlock_kernel();
-				return stored;
-			}
-			offset += fs16_to_cpu(sb, de->d_reclen);
-			if (de->d_ino) {
-				/* We might block in the next section
-				 * if the data destination is
-				 * currently swapped out.  So, use a
-				 * version stamp to detect whether or
-				 * not the directory has been modified
-				 * during the copy operation. */
-				unsigned long version = filp->f_version;
-				unsigned char d_type = DT_UNKNOWN;
-
-				UFSD(("filldir(%s,%u)\n", de->d_name,
-							fs32_to_cpu(sb, de->d_ino)))
-				UFSD(("namlen %u\n", ufs_get_de_namlen(sb, de)))
-
-				if ((flags & UFS_DE_MASK) == UFS_DE_44BSD)
-					d_type = de->d_u.d_44.d_type;
-				error = filldir(dirent, de->d_name,
-						ufs_get_de_namlen(sb, de), filp->f_pos,
-						fs32_to_cpu(sb, de->d_ino), d_type);
-				if (error)
-					break;
-				if (version != filp->f_version)
-					goto revalidate;
-				stored ++;
-			}
-			filp->f_pos += fs16_to_cpu(sb, de->d_reclen);
-		}
-		offset = 0;
-		brelse (bh);
-	}
-	unlock_kernel();
-	return 0;
+	struct inode *dir = page->mapping->host;
+	int err = 0;
+	dir->i_version++;
+	page->mapping->a_ops->commit_write(NULL, page, from, to);
+	if (IS_DIRSYNC(dir))
+		err = write_one_page(page, 1);
+	else
+		unlock_page(page);
+	return err;
 }
 
-/*
- * define how far ahead to read directories while searching them.
- */
-#define NAMEI_RA_CHUNKS  2
-#define NAMEI_RA_BLOCKS  4
-#define NAMEI_RA_SIZE        (NAMEI_RA_CHUNKS * NAMEI_RA_BLOCKS)
-#define NAMEI_RA_INDEX(c,b)  (((c) * NAMEI_RA_BLOCKS) + (b))
+static inline void ufs_put_page(struct page *page)
+{
+	kunmap(page);
+	page_cache_release(page);
+}
 
-/*
- *	ufs_find_entry()
- *
- * finds an entry in the specified directory with the wanted name. It
- * returns the cache buffer in which the entry was found, and the entry
- * itself (as a parameter - res_bh). It does NOT read the inode of the
- * entry - you'll have to do that yourself if you want to.
- */
-struct ufs_dir_entry * ufs_find_entry (struct dentry *dentry,
-	struct buffer_head ** res_bh)
+static inline unsigned long ufs_dir_pages(struct inode *inode)
 {
-	struct super_block * sb;
-	struct buffer_head * bh_use[NAMEI_RA_SIZE];
-	struct buffer_head * bh_read[NAMEI_RA_SIZE];
-	unsigned long offset;
-	int block, toread, i, err;
-	struct inode *dir = dentry->d_parent->d_inode;
-	const char *name = dentry->d_name.name;
-	int namelen = dentry->d_name.len;
+	return (inode->i_size+PAGE_CACHE_SIZE-1)>>PAGE_CACHE_SHIFT;
+}
 
-	UFSD(("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen))
-	
-	*res_bh = NULL;
-	
-	sb = dir->i_sb;
+ino_t ufs_inode_by_name(struct inode *dir, struct dentry *dentry)
+{
+	ino_t res = 0;
+	struct ufs_dir_entry *de;
+	struct page *page;
 	
-	if (namelen > UFS_MAXNAMLEN)
-		return NULL;
-
-	memset (bh_use, 0, sizeof (bh_use));
-	toread = 0;
-	for (block = 0; block < NAMEI_RA_SIZE; ++block) {
-		struct buffer_head * bh;
-
-		if ((block << sb->s_blocksize_bits) >= dir->i_size)
-			break;
-		bh = ufs_getfrag (dir, block, 0, &err);
-		bh_use[block] = bh;
-		if (bh && !buffer_uptodate(bh))
-			bh_read[toread++] = bh;
+	de = ufs_find_entry(dir, dentry, &page);
+	if (de) {
+		res = fs32_to_cpu(dir->i_sb, de->d_ino);
+		ufs_put_page(page);
 	}
+	return res;
+}
 
-	for (block = 0, offset = 0; offset < dir->i_size; block++) {
-		struct buffer_head * bh;
-		struct ufs_dir_entry * de;
-		char * dlimit;
-
-		if ((block % NAMEI_RA_BLOCKS) == 0 && toread) {
-			ll_rw_block (READ, toread, bh_read);
-			toread = 0;
-		}
-		bh = bh_use[block % NAMEI_RA_SIZE];
-		if (!bh) {
-			ufs_error (sb, "ufs_find_entry", 
-				"directory #%lu contains a hole at offset %lu",
-				dir->i_ino, offset);
-			offset += sb->s_blocksize;
-			continue;
-		}
-		wait_on_buffer (bh);
-		if (!buffer_uptodate(bh)) {
-			/*
-			 * read error: all bets are off
-			 */
-			break;
-		}
 
-		de = (struct ufs_dir_entry *) bh->b_data;
-		dlimit = bh->b_data + sb->s_blocksize;
-		while ((char *) de < dlimit && offset < dir->i_size) {
-			/* this code is executed quadratically often */
-			/* do minimal checking by hand */
-			int de_len;
-
-			if ((char *) de + namelen <= dlimit &&
-			    ufs_match(sb, namelen, name, de)) {
-				/* found a match -
-				just to be sure, do a full check */
-				if (!ufs_check_dir_entry("ufs_find_entry",
-				    dir, de, bh, offset))
-					goto failed;
-				for (i = 0; i < NAMEI_RA_SIZE; ++i) {
-					if (bh_use[i] != bh)
-						brelse (bh_use[i]);
-				}
-				*res_bh = bh;
-				return de;
-			}
-                        /* prevent looping on a bad block */
-			de_len = fs16_to_cpu(sb, de->d_reclen);
-			if (de_len <= 0)
-				goto failed;
-			offset += de_len;
-			de = (struct ufs_dir_entry *) ((char *) de + de_len);
-		}
-
-		brelse (bh);
-		if (((block + NAMEI_RA_SIZE) << sb->s_blocksize_bits ) >=
-		    dir->i_size)
-			bh = NULL;
-		else
-			bh = ufs_getfrag (dir, block + NAMEI_RA_SIZE, 0, &err);
-		bh_use[block % NAMEI_RA_SIZE] = bh;
-		if (bh && !buffer_uptodate(bh))
-			bh_read[toread++] = bh;
-	}
+/* Releases the page */
+void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
+		  struct page *page, struct inode *inode)
+{
+	unsigned from = (char *) de - (char *) page_address(page);
+	unsigned to = from + fs16_to_cpu(dir->i_sb, de->d_reclen);
+	int err;
 
-failed:
-	for (i = 0; i < NAMEI_RA_SIZE; ++i) brelse (bh_use[i]);
-	UFSD(("EXIT\n"))
-	return NULL;
+	lock_page(page);
+	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
+	BUG_ON(err);
+	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
+	ufs_set_de_type(dir->i_sb, de, inode->i_mode);
+	err = ufs_commit_chunk(page, from, to);
+	ufs_put_page(page);
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
+	mark_inode_dirty(dir);
 }
 
-static int
-ufs_check_dir_entry (const char *function, struct inode *dir,
-		     struct ufs_dir_entry *de, struct buffer_head *bh,
-		     unsigned long offset)
+
+static void ufs_check_page(struct page *page)
 {
+	struct inode *dir = page->mapping->host;
 	struct super_block *sb = dir->i_sb;
-	const char *error_msg = NULL;
-	int rlen = fs16_to_cpu(sb, de->d_reclen);
-
-	if (rlen < UFS_DIR_REC_LEN(1))
-		error_msg = "reclen is smaller than minimal";
-	else if (rlen % 4 != 0)
-		error_msg = "reclen % 4 != 0";
-	else if (rlen < UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)))
-		error_msg = "reclen is too small for namlen";
-	else if (((char *) de - bh->b_data) + rlen > dir->i_sb->s_blocksize)
-		error_msg = "directory entry across blocks";
-	else if (fs32_to_cpu(sb, de->d_ino) > (UFS_SB(sb)->s_uspi->s_ipg *
-				      UFS_SB(sb)->s_uspi->s_ncg))
-		error_msg = "inode out of bounds";
-
-	if (error_msg != NULL)
-		ufs_error (sb, function, "bad entry in directory #%lu, size %Lu: %s - "
-			    "offset=%lu, inode=%lu, reclen=%d, namlen=%d",
-			    dir->i_ino, dir->i_size, error_msg, offset,
-			    (unsigned long)fs32_to_cpu(sb, de->d_ino),
-			    rlen, ufs_get_de_namlen(sb, de));
-	
-	return (error_msg == NULL ? 1 : 0);
+	char *kaddr = page_address(page);
+	unsigned offs, rec_len;
+	unsigned limit = PAGE_CACHE_SIZE;
+	struct ufs_dir_entry *p;
+	char *error;
+
+	if ((dir->i_size >> PAGE_CACHE_SHIFT) == page->index) {
+		limit = dir->i_size & ~PAGE_CACHE_MASK;
+		if (limit & (UFS_SECTOR_SIZE - 1))
+			goto Ebadsize;
+		if (!limit)
+			goto out;
+	}
+	for (offs = 0; offs <= limit - UFS_DIR_REC_LEN(1); offs += rec_len) {
+		p = (struct ufs_dir_entry *)(kaddr + offs);
+		rec_len = fs16_to_cpu(sb, p->d_reclen);
+
+		if (rec_len < UFS_DIR_REC_LEN(1))
+			goto Eshort;
+		if (rec_len & 3)
+			goto Ealign;
+		if (rec_len < UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, p)))
+			goto Enamelen;
+		if (((offs + rec_len - 1) ^ offs) & ~(UFS_SECTOR_SIZE-1))
+			goto Espan;
+		if (fs32_to_cpu(sb, p->d_ino) > (UFS_SB(sb)->s_uspi->s_ipg *
+						  UFS_SB(sb)->s_uspi->s_ncg))
+			goto Einumber;
+	}
+	if (offs != limit)
+		goto Eend;
+out:
+	SetPageChecked(page);
+	return;
+
+	/* Too bad, we had an error */
+
+Ebadsize:
+	ufs_error(sb, "ufs_check_page",
+		  "size of directory #%lu is not a multiple of chunk size",
+		  dir->i_ino
+	);
+	goto fail;
+Eshort:
+	error = "rec_len is smaller than minimal";
+	goto bad_entry;
+Ealign:
+	error = "unaligned directory entry";
+	goto bad_entry;
+Enamelen:
+	error = "rec_len is too small for name_len";
+	goto bad_entry;
+Espan:
+	error = "directory entry across blocks";
+	goto bad_entry;
+Einumber:
+	error = "inode out of bounds";
+bad_entry:
+	ufs_error (sb, "ufs_check_page", "bad entry in directory #%lu: %s - "
+		   "offset=%lu, rec_len=%d, name_len=%d",
+		   dir->i_ino, error, (page->index<<PAGE_CACHE_SHIFT)+offs,
+		   rec_len, ufs_get_de_namlen(sb, p));
+	goto fail;
+Eend:
+	p = (struct ufs_dir_entry *)(kaddr + offs);
+	ufs_error (sb, "ext2_check_page",
+		   "entry in directory #%lu spans the page boundary"
+		   "offset=%lu",
+		   dir->i_ino, (page->index<<PAGE_CACHE_SHIFT)+offs);
+fail:
+	SetPageChecked(page);
+	SetPageError(page);
+}
+
+static struct page *ufs_get_page(struct inode *dir, unsigned long n)
+{
+	struct address_space *mapping = dir->i_mapping;
+	struct page *page = read_cache_page(mapping, n,
+				(filler_t*)mapping->a_ops->readpage, NULL);
+	if (!IS_ERR(page)) {
+		wait_on_page_locked(page);
+		kmap(page);
+		if (!PageUptodate(page))
+			goto fail;
+		if (!PageChecked(page))
+			ufs_check_page(page);
+		if (PageError(page))
+			goto fail;
+	}
+	return page;
+
+fail:
+	ufs_put_page(page);
+	return ERR_PTR(-EIO);
 }
 
-struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct buffer_head **p)
+/*
+ * Return the offset into page `page_nr' of the last valid
+ * byte in that page, plus one.
+ */
+static unsigned
+ufs_last_byte(struct inode *inode, unsigned long page_nr)
 {
-	int err;
-	struct buffer_head *bh = ufs_bread (dir, 0, 0, &err);
-	struct ufs_dir_entry *res = NULL;
+	unsigned last_byte = inode->i_size;
 
-	if (bh) {
-		res = (struct ufs_dir_entry *) bh->b_data;
-		res = (struct ufs_dir_entry *)((char *)res +
-			fs16_to_cpu(dir->i_sb, res->d_reclen));
-	}
-	*p = bh;
-	return res;
+	last_byte -= page_nr << PAGE_CACHE_SHIFT;
+	if (last_byte > PAGE_CACHE_SIZE)
+		last_byte = PAGE_CACHE_SIZE;
+	return last_byte;
 }
-ino_t ufs_inode_by_name(struct inode * dir, struct dentry *dentry)
+
+static inline struct ufs_dir_entry *
+ufs_next_entry(struct super_block *sb, struct ufs_dir_entry *p)
 {
-	ino_t res = 0;
-	struct ufs_dir_entry * de;
-	struct buffer_head *bh;
+	return (struct ufs_dir_entry *)((char *)p + 
+					fs16_to_cpu(sb, p->d_reclen));
+}
 
-	de = ufs_find_entry (dentry, &bh);
-	if (de) {
-		res = fs32_to_cpu(dir->i_sb, de->d_ino);
-		brelse(bh);
+struct ufs_dir_entry *ufs_dotdot(struct inode *dir, struct page **p)
+{
+	struct page *page = ufs_get_page(dir, 0);
+	struct ufs_dir_entry *de = NULL;
+
+	if (!IS_ERR(page)) {
+		de = ufs_next_entry(dir->i_sb, 
+				    (struct ufs_dir_entry *)page_address(page));
+		*p = page;
 	}
-	return res;
+	return de;
 }
 
-void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
-		struct buffer_head *bh, struct inode *inode)
+/*
+ *	ufs_find_entry()
+ *
+ * finds an entry in the specified directory with the wanted name. It
+ * returns the page in which the entry was found, and the entry itself
+ * (as a parameter - res_dir). Page is returned mapped and unlocked.
+ * Entry is guaranteed to be valid.
+ */
+struct ufs_dir_entry *ufs_find_entry(struct inode *dir, struct dentry *dentry,
+				     struct page **res_page)
 {
-	dir->i_version++;
-	de->d_ino = cpu_to_fs32(dir->i_sb, inode->i_ino);
-	mark_buffer_dirty(bh);
-	if (IS_DIRSYNC(dir))
-		sync_dirty_buffer(bh);
-	brelse (bh);
+	struct super_block *sb = dir->i_sb;
+	const char *name = dentry->d_name.name;
+	int namelen = dentry->d_name.len;
+	unsigned reclen = UFS_DIR_REC_LEN(namelen);
+	unsigned long start, n;
+	unsigned long npages = ufs_dir_pages(dir);
+	struct page *page = NULL;
+	struct ufs_dir_entry *de;
+
+	UFSD(("ENTER, dir_ino %lu, name %s, namlen %u\n", dir->i_ino, name, namelen));
+
+	if (npages == 0 || namelen > UFS_MAXNAMLEN)
+		goto out;
+
+	/* OFFSET_CACHE */
+	*res_page = NULL;
+
+	/* start = ei->i_dir_start_lookup; */
+	start = 0;
+	if (start >= npages)
+		start = 0;
+	n = start;
+	do {
+		char *kaddr;
+		page = ufs_get_page(dir, n);
+		if (!IS_ERR(page)) {
+			kaddr = page_address(page);
+			de = (struct ufs_dir_entry *) kaddr;
+			kaddr += ufs_last_byte(dir, n) - reclen;
+			while ((char *) de <= kaddr) {
+				if (de->d_reclen == 0) {
+					ufs_error(dir->i_sb, __FUNCTION__,
+						  "zero-length directory entry");
+					ufs_put_page(page);
+					goto out;
+				}
+				if (ufs_match(sb, namelen, name, de))
+					goto found;
+				de = ufs_next_entry(sb, de);
+			}
+			ufs_put_page(page);
+		}
+		if (++n >= npages)
+			n = 0;
+	} while (n != start);
+out:
+	return NULL;
+
+found:
+	*res_page = page;
+	/* ei->i_dir_start_lookup = n; */
+	return de;
 }
 
 /*
- *	ufs_add_entry()
- *
- * adds a file entry to the specified directory, using the same
- * semantics as ufs_find_entry(). It returns NULL if it failed.
+ *	Parent is locked.
  */
 int ufs_add_link(struct dentry *dentry, struct inode *inode)
 {
-	struct super_block * sb;
-	struct ufs_sb_private_info * uspi;
-	unsigned long offset;
-	unsigned fragoff;
-	unsigned short rec_len;
-	struct buffer_head * bh;
-	struct ufs_dir_entry * de, * de1;
 	struct inode *dir = dentry->d_parent->d_inode;
 	const char *name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
+	struct super_block *sb = dir->i_sb;
+	unsigned reclen = UFS_DIR_REC_LEN(namelen);
+	unsigned short rec_len, name_len;
+	struct page *page = NULL;
+	struct ufs_dir_entry *de;
+	unsigned long npages = ufs_dir_pages(dir);
+	unsigned long n;
+	char *kaddr;
+	unsigned from, to;
 	int err;
 
-	UFSD(("ENTER, name %s, namelen %u\n", name, namelen))
-	
-	sb = dir->i_sb;
-	uspi = UFS_SB(sb)->s_uspi;
+	UFSD(("ENTER, name %s, namelen %u\n", name, namelen));
 
-	if (!namelen)
-		return -EINVAL;
-	bh = ufs_bread (dir, 0, 0, &err);
-	if (!bh)
-		return err;
-	rec_len = UFS_DIR_REC_LEN(namelen);
-	offset = 0;
-	de = (struct ufs_dir_entry *) bh->b_data;
-	while (1) {
-		if ((char *)de >= UFS_SECTOR_SIZE + bh->b_data) {
-			fragoff = offset & ~uspi->s_fmask;
-			if (fragoff != 0 && fragoff != UFS_SECTOR_SIZE)
-				ufs_error (sb, "ufs_add_entry", "internal error"
-					" fragoff %u", fragoff);
-			if (!fragoff) {
-				brelse (bh);
-				bh = ufs_bread (dir, offset >> sb->s_blocksize_bits, 1, &err);
-				if (!bh)
-					return err;
-			}
-			if (dir->i_size <= offset) {
-				if (dir->i_size == 0) {
-					brelse(bh);
-					return -ENOENT;
-				}
-				de = (struct ufs_dir_entry *) (bh->b_data + fragoff);
-				de->d_ino = 0;
+	/*
+	 * We take care of directory expansion in the same loop.
+	 * This code plays outside i_size, so it locks the page
+	 * to protect that region.
+	 */
+	for (n = 0; n <= npages; n++) {
+		char *dir_end;
+
+		page = ufs_get_page(dir, n);
+		err = PTR_ERR(page);
+		if (IS_ERR(page))
+			goto out;
+		lock_page(page);
+		kaddr = page_address(page);
+		dir_end = kaddr + ufs_last_byte(dir, n);
+		de = (struct ufs_dir_entry *)kaddr;
+		kaddr += PAGE_CACHE_SIZE - reclen;
+		while ((char *)de <= kaddr) {
+			if ((char *)de == dir_end) {
+				/* We hit i_size */
+				name_len = 0;
+				rec_len = UFS_SECTOR_SIZE;
 				de->d_reclen = cpu_to_fs16(sb, UFS_SECTOR_SIZE);
-				ufs_set_de_namlen(sb, de, 0);
-				dir->i_size = offset + UFS_SECTOR_SIZE;
-				mark_inode_dirty(dir);
-			} else {
-				de = (struct ufs_dir_entry *) bh->b_data;
+				de->d_ino = 0;
+				goto got_it;
 			}
-		}
-		if (!ufs_check_dir_entry ("ufs_add_entry", dir, de, bh, offset)) {
-			brelse (bh);
-			return -ENOENT;
-		}
-		if (ufs_match(sb, namelen, name, de)) {
-			brelse (bh);
-			return -EEXIST;
-		}
-		if (de->d_ino == 0 && fs16_to_cpu(sb, de->d_reclen) >= rec_len)
-			break;
-			
-		if (fs16_to_cpu(sb, de->d_reclen) >=
-		     UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)) + rec_len)
-			break;
-		offset += fs16_to_cpu(sb, de->d_reclen);
-		de = (struct ufs_dir_entry *) ((char *) de + fs16_to_cpu(sb, de->d_reclen));
-	}
-
+			if (de->d_reclen == 0) {
+				ufs_error(dir->i_sb, __FUNCTION__,
+					  "zero-length directory entry");
+				err = -EIO;
+				goto out_unlock;
+			}
+			err = -EEXIST;
+			if (ufs_match(sb, namelen, name, de))
+				goto out_unlock;
+			name_len = UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de));
+			rec_len = fs16_to_cpu(sb, de->d_reclen);
+			if (!de->d_ino && rec_len >= reclen)
+				goto got_it;
+			if (rec_len >= name_len + reclen)
+				goto got_it;
+			de = (struct ufs_dir_entry *) ((char *) de + rec_len);
+		}
+		unlock_page(page);
+		ufs_put_page(page);
+	}
+	BUG();
+	return -EINVAL;
+
+got_it:
+	from = (char*)de - (char*)page_address(page);
+	to = from + rec_len;
+	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
+	if (err)
+		goto out_unlock;
 	if (de->d_ino) {
-		de1 = (struct ufs_dir_entry *) ((char *) de +
-			UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)));
-		de1->d_reclen =
-			cpu_to_fs16(sb, fs16_to_cpu(sb, de->d_reclen) -
-				UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)));
-		de->d_reclen =
-			cpu_to_fs16(sb, UFS_DIR_REC_LEN(ufs_get_de_namlen(sb, de)));
+		struct ufs_dir_entry *de1 = 
+			(struct ufs_dir_entry *) ((char *) de + name_len);
+		de1->d_reclen = cpu_to_fs16(sb, rec_len - name_len);
+		de->d_reclen = cpu_to_fs16(sb, name_len);
+
 		de = de1;
 	}
-	de->d_ino = 0;
+
 	ufs_set_de_namlen(sb, de, namelen);
-	memcpy (de->d_name, name, namelen + 1);
+	memcpy(de->d_name, name, namelen + 1);
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);
-	mark_buffer_dirty(bh);
-	if (IS_DIRSYNC(dir))
-		sync_dirty_buffer(bh);
-	brelse (bh);
+
+	err = ufs_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
-	dir->i_version++;
+	
 	mark_inode_dirty(dir);
+	/* OFFSET_CACHE */
+out_put:
+	ufs_put_page(page);
+out:
+	return err;
+out_unlock:
+	unlock_page(page);
+	goto out_put;
+}
+
+static inline unsigned 
+ufs_validate_entry(struct super_block *sb, char *base, 
+		   unsigned offset, unsigned mask)
+{
+	struct ufs_dir_entry *de = (struct ufs_dir_entry*)(base + offset);
+	struct ufs_dir_entry *p = (struct ufs_dir_entry*)(base + (offset&mask));
+	while ((char*)p < (char*)de) {
+		if (p->d_reclen == 0)
+			break;
+		p = ufs_next_entry(sb, p);
+	}
+	return (char *)p - base;
+}
+
+
+/*
+ * This is blatantly stolen from ext2fs
+ */
+static int
+ufs_readdir(struct file *filp, void *dirent, filldir_t filldir)
+{
+	loff_t pos = filp->f_pos;
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
+	unsigned int offset = pos & ~PAGE_CACHE_MASK;
+	unsigned long n = pos >> PAGE_CACHE_SHIFT;
+	unsigned long npages = ufs_dir_pages(inode);
+	unsigned chunk_mask = ~(UFS_SECTOR_SIZE - 1);
+	int need_revalidate = filp->f_version != inode->i_version;
+	unsigned flags = UFS_SB(sb)->s_flags;
+
+	UFSD(("BEGIN"));
 
-	UFSD(("EXIT\n"))
+	if (pos > inode->i_size - UFS_DIR_REC_LEN(1))
+		return 0;
+
+	for ( ; n < npages; n++, offset = 0) {
+		char *kaddr, *limit;
+		struct ufs_dir_entry *de;
+
+		struct page *page = ufs_get_page(inode, n);
+
+		if (IS_ERR(page)) {
+			ufs_error(sb, __FUNCTION__,
+				  "bad page in #%lu",
+				  inode->i_ino);
+			filp->f_pos += PAGE_CACHE_SIZE - offset;
+			return -EIO;
+		}
+		kaddr = page_address(page);
+		if (unlikely(need_revalidate)) {
+			if (offset) {
+				offset = ufs_validate_entry(sb, kaddr, offset, chunk_mask);
+				filp->f_pos = (n<<PAGE_CACHE_SHIFT) + offset;
+			}
+			filp->f_version = inode->i_version;
+			need_revalidate = 0;
+		}
+		de = (struct ufs_dir_entry *)(kaddr+offset);
+		limit = kaddr + ufs_last_byte(inode, n) - UFS_DIR_REC_LEN(1);
+		for ( ;(char*)de <= limit; de = ufs_next_entry(sb, de)) {
+			if (de->d_reclen == 0) {
+				ufs_error(sb, __FUNCTION__,
+					"zero-length directory entry");
+				ufs_put_page(page);
+				return -EIO;
+			}
+			if (de->d_ino) {
+				int over;
+				unsigned char d_type = DT_UNKNOWN;
+
+				offset = (char *)de - kaddr;
+
+				UFSD(("filldir(%s,%u)\n", de->d_name,
+				      fs32_to_cpu(sb, de->d_ino)));
+				UFSD(("namlen %u\n", ufs_get_de_namlen(sb, de)));
+
+				if ((flags & UFS_DE_MASK) == UFS_DE_44BSD)
+                                        d_type = de->d_u.d_44.d_type;
+
+				over = filldir(dirent, de->d_name, 
+					       ufs_get_de_namlen(sb, de),
+						(n<<PAGE_CACHE_SHIFT) | offset,
+					       fs32_to_cpu(sb, de->d_ino), d_type);
+				if (over) {
+					ufs_put_page(page);
+					return 0;
+				}
+			}
+			filp->f_pos += fs16_to_cpu(sb, de->d_reclen);
+		}
+		ufs_put_page(page);
+	}
 	return 0;
 }
 
+
 /*
  * ufs_delete_entry deletes a directory entry by merging it with the
  * previous entry.
  */
-int ufs_delete_entry (struct inode * inode, struct ufs_dir_entry * dir,
-	struct buffer_head * bh )
-	
+int ufs_delete_entry(struct inode *inode, struct ufs_dir_entry *dir,
+		     struct page * page)
 {
-	struct super_block * sb;
-	struct ufs_dir_entry * de, * pde;
-	unsigned i;
-	
-	UFSD(("ENTER\n"))
+	struct super_block *sb = inode->i_sb;
+	struct address_space *mapping = page->mapping;	
+	char *kaddr = page_address(page);
+	unsigned from = ((char*)dir - kaddr) & ~(UFS_SECTOR_SIZE - 1);
+	unsigned to = ((char*)dir - kaddr) + fs16_to_cpu(sb, dir->d_reclen);
+	struct ufs_dir_entry *pde = NULL;
+	struct ufs_dir_entry *de = (struct ufs_dir_entry *) (kaddr + from);
+	int err;
+
+	UFSD(("ENTER\n"));
 
-	sb = inode->i_sb;
-	i = 0;
-	pde = NULL;
-	de = (struct ufs_dir_entry *) bh->b_data;
-	
 	UFSD(("ino %u, reclen %u, namlen %u, name %s\n",
-		fs32_to_cpu(sb, de->d_ino),
-		fs16_to_cpu(sb, de->d_reclen),
-		ufs_get_de_namlen(sb, de), de->d_name))
-
-	while (i < bh->b_size) {
-		if (!ufs_check_dir_entry ("ufs_delete_entry", inode, de, bh, i)) {
-			brelse(bh);
-			return -EIO;
-		}
-		if (de == dir)  {
-			if (pde)
-				fs16_add(sb, &pde->d_reclen,
-					fs16_to_cpu(sb, dir->d_reclen));
-			dir->d_ino = 0;
-			inode->i_version++;
-			inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
-			mark_inode_dirty(inode);
-			mark_buffer_dirty(bh);
-			if (IS_DIRSYNC(inode))
-				sync_dirty_buffer(bh);
-			brelse(bh);
-			UFSD(("EXIT\n"))
-			return 0;
-		}
-		i += fs16_to_cpu(sb, de->d_reclen);
-		if (i == UFS_SECTOR_SIZE) pde = NULL;
-		else pde = de;
-		de = (struct ufs_dir_entry *)
-		    ((char *) de + fs16_to_cpu(sb, de->d_reclen));
-		if (i == UFS_SECTOR_SIZE && de->d_reclen == 0)
-			break;
-	}
-	UFSD(("EXIT\n"))
-	brelse(bh);
-	return -ENOENT;
+	      fs32_to_cpu(sb, de->d_ino),
+	      fs16_to_cpu(sb, de->d_reclen),
+	      ufs_get_de_namlen(sb, de), de->d_name));
+
+	while ((char*)de < (char*)dir) {
+		if (de->d_reclen == 0) {
+			ufs_error(inode->i_sb, __FUNCTION__,
+				  "zero-length directory entry");
+			err = -EIO;
+			goto out;
+		}
+		pde = de;
+		de = ufs_next_entry(sb, de);
+	}
+	if (pde)
+		from = (char*)pde - (char*)page_address(page);
+	lock_page(page);
+	err = mapping->a_ops->prepare_write(NULL, page, from, to);
+	BUG_ON(err);
+	if (pde)
+		pde->d_reclen = cpu_to_fs16(sb, to-from);
+	dir->d_ino = 0;
+	err = ufs_commit_chunk(page, from, to);
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;	
+	mark_inode_dirty(inode);
+out:
+	ufs_put_page(page);
+	UFSD(("EXIT\n"));
+	return err;
 }
 
 int ufs_make_empty(struct inode * inode, struct inode *dir)
 {
 	struct super_block * sb = dir->i_sb;
-	struct buffer_head * dir_block;
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page = grab_cache_page(mapping, 0);
 	struct ufs_dir_entry * de;
+	char *base;
 	int err;
 
-	dir_block = ufs_bread (inode, 0, 1, &err);
-	if (!dir_block)
-		return err;
+	if (!page)
+		return -ENOMEM;
+	kmap(page);
+	err = mapping->a_ops->prepare_write(NULL, page, 0, UFS_SECTOR_SIZE);
+	if (err) {
+		unlock_page(page);
+		goto fail;
+	}
+
+
+	base = (char*)page_address(page);
+	memset(base, 0, PAGE_CACHE_SIZE);
+
+	de = (struct ufs_dir_entry *) base;
 
-	inode->i_blocks = sb->s_blocksize / UFS_SECTOR_SIZE;
-	de = (struct ufs_dir_entry *) dir_block->b_data;
 	de->d_ino = cpu_to_fs32(sb, inode->i_ino);
 	ufs_set_de_type(sb, de, inode->i_mode);
 	ufs_set_de_namlen(sb, de, 1);
@@ -552,72 +594,65 @@ int ufs_make_empty(struct inode * inode,
 	de->d_reclen = cpu_to_fs16(sb, UFS_SECTOR_SIZE - UFS_DIR_REC_LEN(1));
 	ufs_set_de_namlen(sb, de, 2);
 	strcpy (de->d_name, "..");
-	mark_buffer_dirty(dir_block);
-	brelse (dir_block);
-	mark_inode_dirty(inode);
-	return 0;
+	
+	err = ufs_commit_chunk(page, 0, UFS_SECTOR_SIZE);
+fail:
+       kunmap(page);
+       page_cache_release(page);
+       return err;
 }
 
 /*
  * routine to check that the specified directory is empty (for rmdir)
  */
-int ufs_empty_dir (struct inode * inode)
+int ufs_empty_dir(struct inode * inode)
 {
-	struct super_block * sb;
-	unsigned long offset;
-	struct buffer_head * bh;
-	struct ufs_dir_entry * de, * de1;
-	int err;
-	
-	sb = inode->i_sb;
+	struct super_block *sb = inode->i_sb;
+	struct page *page = NULL;
+	unsigned long i, npages = ufs_dir_pages(inode);
+
+	for (i = 0; i < npages; i++) {
+		char *kaddr;
+		struct ufs_dir_entry *de;
+		page = ufs_get_page(inode, i);
 
-	if (inode->i_size < UFS_DIR_REC_LEN(1) + UFS_DIR_REC_LEN(2) ||
-	    !(bh = ufs_bread (inode, 0, 0, &err))) {
-	    	ufs_warning (inode->i_sb, "empty_dir",
-			      "bad directory (dir #%lu) - no data block",
-			      inode->i_ino);
-		return 1;
-	}
-	de = (struct ufs_dir_entry *) bh->b_data;
-	de1 = (struct ufs_dir_entry *)
-		((char *)de + fs16_to_cpu(sb, de->d_reclen));
-	if (fs32_to_cpu(sb, de->d_ino) != inode->i_ino || de1->d_ino == 0 ||
-	     strcmp (".", de->d_name) || strcmp ("..", de1->d_name)) {
-	    	ufs_warning (inode->i_sb, "empty_dir",
-			      "bad directory (dir #%lu) - no `.' or `..'",
-			      inode->i_ino);
-		return 1;
-	}
-	offset = fs16_to_cpu(sb, de->d_reclen) + fs16_to_cpu(sb, de1->d_reclen);
-	de = (struct ufs_dir_entry *)
-		((char *)de1 + fs16_to_cpu(sb, de1->d_reclen));
-	while (offset < inode->i_size ) {
-		if (!bh || (void *) de >= (void *) (bh->b_data + sb->s_blocksize)) {
-			brelse (bh);
-			bh = ufs_bread (inode, offset >> sb->s_blocksize_bits, 1, &err);
-	 		if (!bh) {
-				ufs_error (sb, "empty_dir",
-					    "directory #%lu contains a hole at offset %lu",
-					    inode->i_ino, offset);
-				offset += sb->s_blocksize;
-				continue;
+		if (IS_ERR(page))
+			continue;
+
+		kaddr = page_address(page);
+		de = (struct ufs_dir_entry *)kaddr;
+		kaddr += ufs_last_byte(inode, i) - UFS_DIR_REC_LEN(1);
+
+		while ((char *)de <= kaddr) {
+			if (de->d_reclen == 0) {
+				ufs_error(inode->i_sb, __FUNCTION__,
+					"zero-length directory entry: "
+					"kaddr=%p, de=%p\n", kaddr, de);
+				goto not_empty;
 			}
-			de = (struct ufs_dir_entry *) bh->b_data;
-		}
-		if (!ufs_check_dir_entry ("empty_dir", inode, de, bh, offset)) {
-			brelse (bh);
-			return 1;
-		}
-		if (de->d_ino) {
-			brelse (bh);
-			return 0;
+			if (de->d_ino) {
+				u16 namelen=ufs_get_de_namlen(sb, de);
+				/* check for . and .. */
+				if (de->d_name[0] != '.')
+					goto not_empty;
+				if (namelen > 2)
+					goto not_empty;
+				if (namelen < 2) {
+					if (inode->i_ino !=
+					    fs32_to_cpu(sb, de->d_ino))
+						goto not_empty;
+				} else if (de->d_name[1] != '.')
+					goto not_empty;
+			}
+			de = ufs_next_entry(sb, de);
 		}
-		offset += fs16_to_cpu(sb, de->d_reclen);
-		de = (struct ufs_dir_entry *)
-			((char *)de + fs16_to_cpu(sb, de->d_reclen));
+		ufs_put_page(page);
 	}
-	brelse (bh);
 	return 1;
+
+not_empty:
+	ufs_put_page(page);
+	return 0;
 }
 
 const struct file_operations ufs_dir_operations = {
diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/namei.c linux-2.6.17-rc4/fs/ufs/namei.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/namei.c	2006-05-19 19:59:32.162312250 +0400
+++ linux-2.6.17-rc4/fs/ufs/namei.c	2006-05-19 18:57:18.648982250 +0400
@@ -1,5 +1,8 @@
 /*
  * linux/fs/ufs/namei.c
+ * 
+ * Migration to usage of "page cache" on May 2006 by
+ * Evgeniy Dushistov <dushistov@mail.ru> based on ext2 code base.
  *
  * Copyright (C) 1998
  * Daniel Pirkl <daniel.pirkl@email.cz>
@@ -28,7 +31,6 @@
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
 #include <linux/smp_lock.h>
-#include <linux/buffer_head.h>
 #include "swab.h"	/* will go away - see comment in mknod() */
 #include "util.h"
 
@@ -232,19 +234,18 @@ out_dir:
 	goto out;
 }
 
-static int ufs_unlink(struct inode * dir, struct dentry *dentry)
+static int ufs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode * inode = dentry->d_inode;
-	struct buffer_head * bh;
-	struct ufs_dir_entry * de;
+	struct ufs_dir_entry *de;
+	struct page *page;
 	int err = -ENOENT;
 
-	lock_kernel();
-	de = ufs_find_entry (dentry, &bh);
+	de = ufs_find_entry(dir, dentry, &page);
 	if (!de)
 		goto out;
 
-	err = ufs_delete_entry (dir, de, bh);
+	err = ufs_delete_entry(dir, de, page);
 	if (err)
 		goto out;
 
@@ -252,7 +253,6 @@ static int ufs_unlink(struct inode * dir
 	inode_dec_link_count(inode);
 	err = 0;
 out:
-	unlock_kernel();
 	return err;
 }
 
@@ -274,42 +274,42 @@ static int ufs_rmdir (struct inode * dir
 	return err;
 }
 
-static int ufs_rename (struct inode * old_dir, struct dentry * old_dentry,
-	struct inode * new_dir,	struct dentry * new_dentry )
+static int ufs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		      struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct inode *old_inode = old_dentry->d_inode;
 	struct inode *new_inode = new_dentry->d_inode;
-	struct buffer_head *dir_bh = NULL;
-	struct ufs_dir_entry *dir_de = NULL;
-	struct buffer_head *old_bh;
+	struct page *dir_page = NULL;
+	struct ufs_dir_entry * dir_de = NULL;
+	struct page *old_page;
 	struct ufs_dir_entry *old_de;
 	int err = -ENOENT;
 
-	lock_kernel();
-	old_de = ufs_find_entry (old_dentry, &old_bh);
+	old_de = ufs_find_entry(old_dir, old_dentry, &old_page);
 	if (!old_de)
 		goto out;
 
 	if (S_ISDIR(old_inode->i_mode)) {
 		err = -EIO;
-		dir_de = ufs_dotdot(old_inode, &dir_bh);
+		dir_de = ufs_dotdot(old_inode, &dir_page);
 		if (!dir_de)
 			goto out_old;
 	}
 
 	if (new_inode) {
-		struct buffer_head *new_bh;
+		struct page *new_page;
 		struct ufs_dir_entry *new_de;
 
 		err = -ENOTEMPTY;
-		if (dir_de && !ufs_empty_dir (new_inode))
+		if (dir_de && !ufs_empty_dir(new_inode))
 			goto out_dir;
+
 		err = -ENOENT;
-		new_de = ufs_find_entry (new_dentry, &new_bh);
+		new_de = ufs_find_entry(new_dir, new_dentry, &new_page);
 		if (!new_de)
 			goto out_dir;
 		inode_inc_link_count(old_inode);
-		ufs_set_link(new_dir, new_de, new_bh, old_inode);
+		ufs_set_link(new_dir, new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME_SEC;
 		if (dir_de)
 			new_inode->i_nlink--;
@@ -330,24 +330,32 @@ static int ufs_rename (struct inode * ol
 			inode_inc_link_count(new_dir);
 	}
 
-	ufs_delete_entry (old_dir, old_de, old_bh);
+	/*
+	 * Like most other Unix systems, set the ctime for inodes on a
+ 	 * rename.
+	 * inode_dec_link_count() will mark the inode dirty.
+	 */
+	old_inode->i_ctime = CURRENT_TIME_SEC;
 
+	ufs_delete_entry(old_dir, old_de, old_page);
 	inode_dec_link_count(old_inode);
 
 	if (dir_de) {
-		ufs_set_link(old_inode, dir_de, dir_bh, new_dir);
+		ufs_set_link(old_inode, dir_de, dir_page, new_dir);
 		inode_dec_link_count(old_dir);
 	}
-	unlock_kernel();
 	return 0;
 
+
 out_dir:
-	if (dir_de)
-		brelse(dir_bh);
+	if (dir_de) {
+		kunmap(dir_page);
+		page_cache_release(dir_page);
+	}
 out_old:
-	brelse (old_bh);
+	kunmap(old_page);
+	page_cache_release(old_page);
 out:
-	unlock_kernel();
 	return err;
 }
 
diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/include/linux/ufs_fs.h linux-2.6.17-rc4/include/linux/ufs_fs.h
--- linux-2.6.17-rc4-vanilla/include/linux/ufs_fs.h	2006-05-19 19:59:25.265881250 +0400
+++ linux-2.6.17-rc4/include/linux/ufs_fs.h	2006-05-18 21:49:41.305834500 +0400
@@ -888,11 +888,12 @@ extern struct inode_operations ufs_dir_i
 extern int ufs_add_link (struct dentry *, struct inode *);
 extern ino_t ufs_inode_by_name(struct inode *, struct dentry *);
 extern int ufs_make_empty(struct inode *, struct inode *);
-extern struct ufs_dir_entry * ufs_find_entry (struct dentry *, struct buffer_head **);
-extern int ufs_delete_entry (struct inode *, struct ufs_dir_entry *, struct buffer_head *);
+extern struct ufs_dir_entry *ufs_find_entry(struct inode *, struct dentry *, struct page **);
+extern int ufs_delete_entry(struct inode *, struct ufs_dir_entry *, struct page *);
 extern int ufs_empty_dir (struct inode *);
-extern struct ufs_dir_entry * ufs_dotdot (struct inode *, struct buffer_head **);
-extern void ufs_set_link(struct inode *, struct ufs_dir_entry *, struct buffer_head *, struct inode *);
+extern struct ufs_dir_entry *ufs_dotdot(struct inode *, struct page **);
+extern void ufs_set_link(struct inode *dir, struct ufs_dir_entry *de,
+			 struct page *page, struct inode *inode);
 
 /* file.c */
 extern struct inode_operations ufs_file_inode_operations;

-- 
/Evgeniy

