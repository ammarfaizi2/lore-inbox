Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137075AbREKHLy>; Fri, 11 May 2001 03:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137066AbREKHLq>; Fri, 11 May 2001 03:11:46 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:19195 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S137065AbREKHLh>; Fri, 11 May 2001 03:11:37 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105110710.f4B7ArA9001543@webber.adilger.int>
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: "from (env: adilger) at May 10, 2001 02:53:14 pm"
To: adilger@webber.adilger.int
Date: Fri, 11 May 2001 01:10:53 -0600 (MDT)
CC: phillips@bonn-fries.net,
        Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM989565048-1403-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM989565048-1403-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

I previously wrote:
> OK, here are the patches described above.
> 
> Unfortunately, they haven't been tested.  I've given them several
> eyeballings and they appear OK, but when I try to run the ext2 index code
> (even without "-o index" mount option) my system deadlocks somwhere
> inside my ext2i module (tight loop, but SysRQ still works).  I doubt
> it is due to these patches, but possibly because I am also working on
> ext3 code in the same kernel.  I'm just in the process of getting kdb
> installed into that kernel so I can find out just where it is looping.

I've tested again, now with kdb, and the system loops in ext2_find_entry()
or ext2_add_link(), because there is a directory with a zero rec_len.
While the actual cause of this problem is elsewhere, the fact that
ext2_next_entry() will loop forever with a bad rec_len is a bug not in
the old ext2 code.

I have changed ext2_next_entry() to verify rec_len > EXT2_DIR_REC_LEN(0),
and added a helper function ext2_next_empty() which is nearly the same,
but it follows the de links until it finds one with enough space for a
new entry (used in ext2_add_link()).  The former is useful for both Al
and Daniel's code, while the latter may only be useful for Daniel's.

However, the way that I currently fixed ext2_next_entry() is probably
not very safe.  If it detects a bad rec_len, we should probably not
touch that block anymore, but it currently just makes it look like the
block is empty.  That may lead to deleting the rest of the directory
entries in the block, although this is what e2fsck does anyways...  I
at least need to set the error flag in the superblock...  Next patch.

I spotted another bug, namely that when allocating a new directory page
it sets rec_len to blocksize, but does not zero the inode field...  This
would imply that we would skip a bogus directory entry at the start of
a new page.

As yet I haven't found the cause of the real bug, but at least now my
kernel doesn't lock up on (relatively common) bogus data.

Cheers, Andreas

PS - patch has recieved some editing to remove the other INDEX flag stuff,
     so hopefully it is OK
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

--ELM989565048-1403-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=ext2-2.4.5-zerorec.diff
Content-Description: 

diff -ru linux/fs/ext2i.orig/dir.c linux/fs/ext2i/dir.c
--- linux/fs/ext2i.orig/dir.c	Thu May 10 12:10:22 2001
+++ linux/fs/ext2i/dir.c	Fri May 11 00:01:46 2001
@@ -573,20 +599,48 @@
 }
 
 /*
- * p is at least 6 bytes before the end of page
+ * Check record length to ensure we don't loop on a bad directory entry.
+ * de is at least 6 bytes before the end of page.
  */
-static inline ext2_dirent *ext2_next_entry(ext2_dirent *p)
+static inline ext2_dirent *ext2_next_entry(ext2_dirent *de, ext2_dirent *top)
 {
-	return (ext2_dirent *)((char*)p + le16_to_cpu(p->rec_len));
+	int len = le16_to_cpu(de->rec_len);
+	if (len < EXT2_DIR_REC_LEN(0)) {
+		printk(KERN_ERR "EXT2-fs: bad directory record length %d!\n",
+		       len);
+		return top;
+	}
+	return (ext2_dirent *)((char *)de + len);
+}
+
+static inline ext2_dirent *ext2_next_empty(ext2_dirent *de, ext2_dirent *top,
+					   unsigned reclen)
+{
+	while (de <= top) {
+		unsigned nlen = EXT2_DIR_REC_LEN(de->name_len);
+		unsigned rlen = le16_to_cpu(de->rec_len);
+		if (rlen < EXT2_DIR_REC_LEN(0)) {
+			printk(KERN_ERR
+			       "EXT2-fs: bad directory record length %d!\n",
+			       rlen);
+			break;
+		}
+		if ((de->inode? rlen - nlen: rlen) >= reclen)
+			return de;
+		de = (ext2_dirent *) ((char *) de + rlen);
+	}
+	return NULL;
 }
 
 static inline unsigned 
 ext2_validate_entry(char *base, unsigned offset, unsigned mask)
 {
 	ext2_dirent *de = (ext2_dirent*)(base + offset);
 	ext2_dirent *p = (ext2_dirent*)(base + (offset&mask));
-	while ((char*)p < (char*)de)
-		p = ext2_next_entry(p);
+	while (p < de)
+		p = ext2_next_entry(p, de);
 	return (char *)p - base;
 }
 
@@ -640,8 +706,8 @@
 		types = ext2_filetype_table;
 
 	for ( ; n < npages; n++, offset = 0) {
-		char *kaddr, *limit;
-		ext2_dirent *de;
+		char *kaddr;
+		ext2_dirent *de, *top;
 		struct page *page = ext2_get_page(inode, n);
 
 		if (IS_ERR(page))
@@ -652,8 +718,9 @@
 			need_revalidate = 0;
 		}
 		de = (ext2_dirent *)(kaddr+offset);
-		limit = kaddr + PAGE_CACHE_SIZE - EXT2_DIR_REC_LEN(1);
-		for ( ;(char*)de <= limit; de = ext2_next_entry(de))
+		top = (ext2_dirent *)(kaddr + PAGE_CACHE_SIZE -
+				      EXT2_DIR_REC_LEN(0));
+		for ( ; de < top; de = ext2_next_entry(de, top))
 			if (de->inode) {
 				int over;
 				unsigned char d_type = DT_UNKNOWN;
@@ -691,8 +753,11 @@
 	int namelen = dentry->d_name.len;
 	struct buffer_head *bh;
 	struct super_block *sb = dir->i_sb;
-	unsigned blockshift = sb->s_blocksize_bits, blocksize = sb->s_blocksize, block;
+	unsigned blockshift = sb->s_blocksize_bits;
+	unsigned blocksize = sb->s_blocksize;
+	unsigned block;
 	ext2_dirent *de;
-	char *data, *top;
+	char *data;
+
 	*result = NULL;
 	if (namelen > EXT2_NAME_LEN) return NULL;
@@ -705,13 +770,20 @@
 
 		while (1)
 		{
-			if (IS_ERR(bh = ext2_bread (dir, dx_get_block(frame->at), 0)))
-				goto dxfail;
+			ext2_dirent *top;
+
+			bh = ext2_bread (dir, dx_get_block(frame->at), 0);
+			if (IS_ERR(bh))
+				goto dxfail;
 			data = bh->b_data;
-			top = data + blocksize - EXT2_DIR_REC_LEN(namelen);
-			for (de = (ext2_dirent *) data; (char *) de <= top; de = ext2_next_entry(de))
-				if (ext2_match (namelen, name, de))
+			top = (ext2_dirent *)(data + blocksize -
+					      EXT2_DIR_REC_LEN(0));
+			for (de = (ext2_dirent *) data; de < top;
+			     de = ext2_next_entry(de, top))
+				if (ext2_match (namelen, name, de)) {
+					*result = bh;
 					goto dxfound;
+				}
 			brelse (bh);
 			/* Same hash continues in next block?  Search on. */
 			if (++(frame->at) - frame->entries == dx_get_count(frame->entries))
@@ -735,12 +811,23 @@
 	}
 	for (block = 0; block < dir->i_size >> blockshift; block++)
 	{
-		if (IS_ERR(bh = ext2_bread (dir, block, 0))) break;
+		ext2_dirent *top;
+
+		if (IS_ERR(bh = ext2_bread (dir, block, 0))) {
+			ext2_error(sb, __FUNCTION__,
+				   "reading directory %ld block %d, skipped\n",
+				   dir->i_ino, block);
+			continue;
+		}
 		data = bh->b_data;
-		top = data + blocksize - EXT2_DIR_REC_LEN(namelen);
-		for (de = (ext2_dirent *) data; (char *) de <= top; de = ext2_next_entry(de))
-			if (ext2_match (namelen, name, de))
+		top = (ext2_dirent *)(data + blocksize - EXT2_DIR_REC_LEN(0));
+		for (de = (ext2_dirent *) data; de < top;
+		     de = ext2_next_entry(de, top)) {
+			if (ext2_match (namelen, name, de)) {
+				*result = bh;
 				goto found;
+			}
+		}
 		brelse(bh);
 	}
 	return NULL;
@@ -758,7 +842,8 @@ 
 	struct buffer_head *bh = ext2_bread(dir, 0, 0);
 
 	if (!IS_ERR(bh)) {
-		de = ext2_next_entry((ext2_dirent *) bh->b_data);
+		de = ext2_next_entry((ext2_dirent *) bh->b_data,
+				     (ext2_dirent *) bh->b_data);
 		*p = bh;
 	}
 	return de;
@@ -806,10 +895,10 @@
 	int namelen = dentry->d_name.len;
 	struct buffer_head *bh;
 	ext2_dirent *de, *de2;
-	unsigned blockshift = dir->i_sb->s_blocksize_bits, blocksize = 1 << blockshift;
+	unsigned blockshift = dir->i_sb->s_blocksize_bits;
+	unsigned blocksize = 1 << blockshift;
 	unsigned short reclen = EXT2_DIR_REC_LEN(namelen);
-	unsigned nlen, rlen, i, blocks;
-	char *top;
+	unsigned i, blocks;
 	int err;
 	/* Data for deferred index creation path... */
 	struct dx_entry *entries, *at;
@@ -823,4 +912,5 @@
 		unsigned count, split, hash2, block2;
 		struct buffer_head *bh2;
+		ext2_dirent *top;
 		char *data2;
 		unsigned continued;
@@ -833,17 +923,14 @@
 			goto dx_err;
 		data1 = bh->b_data;
 		de = (ext2_dirent *) data1;
-		top = data1 + (0? 200: blocksize);
-		while ((char *) de < top)
-		{
-			nlen = EXT2_DIR_REC_LEN(de->name_len);
-			rlen = le16_to_cpu(de->rec_len);
-			if ((de->inode? rlen - nlen: rlen) >= reclen) goto dx_add;
-			de = (ext2_dirent *) ((char *) de + rlen);
-		}
+		top = (ext2_dirent *)(data1 + blocksize -
+				      EXT2_DIR_REC_LEN(reclen));
+		if ((de = ext2_next_empty(de, top, reclen)))
+			goto dx_add;
 
 		/* Block full, should compress but for now just split */
-		dxtrace(printk("using %u of %u node entries\n", dx_get_count(entries), dx_get_limit(entries)));
+		dxtrace(printk("using %u of %u node entries\n",
+			       dx_get_count(entries), dx_get_limit(entries)));
 		/* Need to split index? */
 		if (dx_get_count(entries) == dx_get_limit(entries))
 		{
@@ -953,8 +1041,6 @@
 		dx_insert_block (frame, hash2 + continued, block2);
 		mark_buffer_dirty (frame->bh);
 		dxtrace(dx_show_index (frame == frames? "root": "node", frame->entries));
-		nlen = EXT2_DIR_REC_LEN(de->name_len);
-		rlen = le16_to_cpu(de->rec_len);
 dx_add:
 		dx_release (frames);
 		goto add;
@@ -971,28 +1057,25 @@
 		goto fail;
 	}
 	blocks = dir->i_size >> blockshift;
-	for (i = 0; i <= blocks; i++)
-	{
+	for (i = 0; i <= blocks; i++) {
+		ext2_dirent *top;
+
 		if (IS_ERR(bh = ext2_bread (dir, i, i == blocks)))
 			goto fail1;
 		de = (ext2_dirent *) bh->b_data;
-		if (i == blocks)
-		{
+		if (i == blocks) {
 			dir->i_size += blocksize;
+			de->inode = 0;
 			de->rec_len = cpu_to_le16(blocksize);
 		}
-		top = bh->b_data + blocksize - reclen;
-		while ((char *) de <= top)
-		{
-			nlen = EXT2_DIR_REC_LEN(de->name_len);
-			rlen = le16_to_cpu(de->rec_len);
-			if ((de->inode? rlen - nlen: rlen) >= reclen) goto add;
-			de = (ext2_dirent *) ((char *) de + rlen);
-		}
-		if (ext2_dx && blocks == 1 && dir->u.ext2_i.i_flags & EXT2_INDEX_FL)
-		{
+		top = (ext2_dirent *)(bh->b_data + blocksize -
+				      EXT2_DIR_REC_LEN(reclen));
+		if ((de = ext2_next_empty(de, top, reclen)))
+			goto add;
+		if (ext2_dx && blocks == 1 && test_opt(dir->i_sb, INDEX)) {
 			struct dx_root *root;
 			struct buffer_head *newbh, *rootbh = bh;
+			ext2_dirent *top;
 			unsigned len;
 
 			dxtrace_on(printk("Creating index\n"));
@@ -1007,24 +1091,27 @@
 			data1 = newbh->b_data;
 			root = (struct dx_root *) rootbh->b_data;
 
-			/* The 0th block becomes the root, move the dirents out */
+			/* 0th block becomes dx_root, move the dirents out */
 			de = (ext2_dirent *) &root->info;
-			assert(de == ext2_next_entry (ext2_next_entry ((ext2_dirent *) root)));
 			len = ((char *) root) + blocksize - (char *) de;
 			memcpy (data1, de, len);
 			de = (ext2_dirent *) data1;
-			top = data1 + len;
-			while (((char *) de2 = ext2_next_entry (de)) < top)
+			top = (ext2_dirent *)(data1 + len);
+			while ((de2 = ext2_next_entry(de, top)) < top)
 				de = de2;
 			de->rec_len = cpu_to_le16(data1 + blocksize - (char *) de);
 			dxtrace(dx_show_leaf ((ext2_dirent *) data1, len, 1));
 
-			/* Initialize the root; the fake dots already exist */
-			de = ext2_next_entry ((ext2_dirent *) &root->fake1);
-			assert(!strncmp(de->name, "..", 2)); // should fall back, set ext2_error
-			de->rec_len = cpu_to_le16(blocksize - EXT2_DIR_REC_LEN(1));
-			memset(&root->info, 0, sizeof(struct dx_root_info));
-			root->info.info_length = sizeof(struct dx_root_info);
+			/* Initialize the root; the dots already exist */
+			de = (ext2_dirent *)(&root->fake2);
+			assert(!memcmp(de->name, "..", 2)); // fix . and ..
+			de->rec_len = cpu_to_le16(blocksize -
+						  EXT2_DIR_REC_LEN(2));
+			root->info.reserved_zero = 0;
+			root->info.hash_version = 0;
+			root->info.info_length = sizeof(root->info);
+			root->info.indirect_levels = 0;
+			root->info.unused_flags = 0;
 			entries = root->entries;
 			dx_set_block (entries, 1);
 			dx_set_count (entries, 1);
@@ -1046,10 +1135,11 @@
 fail:
 	return -ENOENT;
 add:
-	if (de->inode)
-	{
+	if (de->inode) {
+		unsigned nlen = de->name_len;
+
 		de2 = (ext2_dirent *) ((char *) de + nlen);
-		de2->rec_len = cpu_to_le16(rlen - nlen);
+		de2->rec_len = cpu_to_le16(le16_to_cpu(de->rec_len) - nlen);
 		de->rec_len = cpu_to_le16(nlen);
 		de = de2;
 	}
@@ -1074,7 +1164,7 @@
 	while ((char*) de2 < (char*) de)
 	{
 		pde = de2;
-		de2 = ext2_next_entry(de2);
+		de2 = ext2_next_entry(de2, de);
 	}
 	if (pde)
 		pde->rec_len = cpu_to_le16((char*) de + 
@@ -1143,7 +1221,7 @@
 	
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
-		ext2_dirent * de;
+		ext2_dirent * de, *top;
 		page = ext2_get_page(inode, i);
 
 		if (IS_ERR(page))
@@ -1151,9 +1229,10 @@
 
 		kaddr = (char *)page_address(page);
 		de = (ext2_dirent *)kaddr;
-		kaddr += PAGE_CACHE_SIZE-EXT2_DIR_REC_LEN(1);
+		top = (ext2_dirent *)(kaddr + PAGE_CACHE_SIZE -
+				      EXT2_DIR_REC_LEN(0));
 
-		while ((char *)de <= kaddr) {
+		while (de < top) {
 			if (de->inode != 0) {
 				/* check for . and .. */
 				if (de->name[0] != '.')
@@ -1167,10 +1246,14 @@
 				} else if (de->name[1] != '.')
 					goto not_empty;
 			}
-			de = ext2_next_entry(de);
+			de = ext2_next_entry(de, top);
 		}
 		ext2_put_page(page);
 	}
+	if (!EXT2_DIR_LINK_EMPTY(inode))
+		ext2_warning(inode->i_sb, __FUNCTION__,
+			     "empty directory has too many links (%d)",
+			     inode->i_nlink);
 	return 1;
 
 not_empty:

--ELM989565048-1403-0_--
