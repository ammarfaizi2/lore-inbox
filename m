Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318865AbSHEUiH>; Mon, 5 Aug 2002 16:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318866AbSHEUiH>; Mon, 5 Aug 2002 16:38:07 -0400
Received: from h-64-105-137-168.SNVACAID.covad.net ([64.105.137.168]:60880
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318865AbSHEUiF>; Mon, 5 Aug 2002 16:38:05 -0400
Date: Mon, 5 Aug 2002 13:41:30 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: aia21@cantab.net, linux-ntfs-dev@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.30/fs/ntfs BUG_ON(cond1 || cond2) bugs(!) and clean ups
Message-ID: <20020805134130.A2627@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch replaces all BUG_ON(condition1 || condition2)
statements in fs/ntfs with separate BUG_ON statements, usually like so:

		BUG_ON(condition1);
		BUG_ON(condition2);

	This provides more information if the BUG_ON statement is every
tripped.

	In addition, the fs/ntfs code had some
BUG_ON(...atomic_dec_and_test(...)) statements.  BUG_ON conditions should
not have side effects, because you are supposed to be able to compile out
BUG_ON statements to have the code run faster (which is an important
guarantee for encouraging developers to write BUG_ON statements).  I
have translated the offending cases to statements of the following form:

	if(...atomic_dec_and_test(...))
		BUG();

	I have attached the patch below.  I would like to get these
changes into Linus's 2.5 tree.  Please let me know if you want to take
it from here, if you want me to submit this patch to Linus or if you
want me to do something else.  Thanks for your time, and for maintaining
the NT file system on Linux.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ntfs.diff"

diff -u linux-2.5.30/fs/ntfs/attrib.c linux/fs/ntfs/attrib.c
--- linux-2.5.30/fs/ntfs/attrib.c	2002-08-01 14:16:26.000000000 -0700
+++ linux/fs/ntfs/attrib.c	2002-08-05 13:27:51.000000000 -0700
@@ -110,7 +110,8 @@
 static inline BOOL ntfs_are_rl_mergeable(run_list_element *dst,
 		run_list_element *src)
 {
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	if ((dst->lcn < 0) || (src->lcn < 0))     /* Are we merging holes? */
 		return FALSE;
@@ -192,7 +193,8 @@
 	BOOL right;
 	int magic;
 
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	/* First, check if the right hand end needs merging. */
 	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
@@ -258,7 +260,8 @@
 	BOOL hole = FALSE;	/* Following a hole */
 	int magic;
 
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	/* disc => Discontinuity between the end of @dst and the start of @src.
 	 *         This means we might need to insert a hole.
@@ -362,7 +365,8 @@
 	BOOL right;
 	int magic;
 
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	/* First, merge the left and right ends, if necessary. */
 	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
@@ -423,7 +427,8 @@
 static inline run_list_element *ntfs_rl_split(run_list_element *dst, int dsize,
 		run_list_element *src, int ssize, int loc)
 {
-	BUG_ON(!dst || !src);
+	BUG_ON(!dst);
+	BUG_ON(!src);
 
 	/* Space required: @dst size + @src size + one new hole. */
 	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize + 1);
diff -u linux-2.5.30/fs/ntfs/compress.c linux/fs/ntfs/compress.c
--- linux-2.5.30/fs/ntfs/compress.c	2002-08-01 14:16:26.000000000 -0700
+++ linux/fs/ntfs/compress.c	2002-08-05 13:27:51.000000000 -0700
@@ -467,7 +467,8 @@
 	 * Bad things happen if we get here for anything that is not an
 	 * unnamed $DATA attribute.
 	 */
-	BUG_ON(ni->type != AT_DATA || ni->name_len);
+	BUG_ON(ni->type != AT_DATA);
+	BUG_ON(ni->name_len);
 
 	pages = kmalloc(nr_pages * sizeof(struct page *), GFP_NOFS);
 
diff -u linux-2.5.30/fs/ntfs/inode.c linux/fs/ntfs/inode.c
--- linux-2.5.30/fs/ntfs/inode.c	2002-08-01 14:16:19.000000000 -0700
+++ linux/fs/ntfs/inode.c	2002-08-05 13:27:51.000000000 -0700
@@ -278,7 +278,9 @@
 	ntfs_inode *ni = NTFS_I(inode);
 
 	ntfs_debug("Entering.");
-	BUG_ON(atomic_read(&ni->mft_count) || !atomic_dec_and_test(&ni->count));
+	BUG_ON(atomic_read(&ni->mft_count));
+	if (!atomic_dec_and_test(&ni->count))
+		BUG();
 	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
 }
 
@@ -298,7 +300,11 @@
 void ntfs_destroy_extent_inode(ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
-	BUG_ON(atomic_read(&ni->mft_count) || !atomic_dec_and_test(&ni->count));
+
+	BUG_ON(atomic_read(&ni->mft_count));
+	if (!atomic_dec_and_test(&ni->count))
+		BUG();
+
 	kmem_cache_free(ntfs_inode_cache, ni);
 }
 
diff -u linux-2.5.30/fs/ntfs/mft.c linux/fs/ntfs/mft.c
--- linux-2.5.30/fs/ntfs/mft.c	2002-08-01 14:16:07.000000000 -0700
+++ linux/fs/ntfs/mft.c	2002-08-05 13:27:51.000000000 -0700
@@ -132,7 +132,9 @@
 	struct page *page;
 	unsigned long index, ofs, end_index;
 
-	BUG_ON(atomic_read(&ni->mft_count) || ni->page);
+	BUG_ON(atomic_read(&ni->mft_count));
+	BUG_ON(ni->page);
+
 	/*
 	 * The index into the page cache and the offset within the page cache
 	 * page of the wanted mft record. FIXME: We need to check for
@@ -190,8 +192,10 @@
  */
 static inline void unmap_mft_record_page(ntfs_inode *ni)
 {
-	BUG_ON(atomic_read(&ni->mft_count) || !ni->page);
-	// TODO: If dirty, blah...
+	BUG_ON(atomic_read(&ni->mft_count));
+	BUG_ON(!ni->page);
+
+	/* TODO: If dirty, blah... */
 	ntfs_unmap_page(ni->page);
 	ni->page = NULL;
 	ni->page_ofs = 0;
@@ -316,7 +320,8 @@
 {
 	struct page *page = ni->page;
 
-	BUG_ON(!atomic_read(&ni->mft_count) || !page);
+	BUG_ON(!atomic_read(&ni->mft_count));
+	BUG_ON(!page);
 
 	ntfs_debug("Entering for mft_no 0x%lx, unmapping from %s.", ni->mft_no,
 			rw == READ ? "READ" : "WRITE");

--HlL+5n6rz5pIUxbD--
