Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290032AbSAQQvy>; Thu, 17 Jan 2002 11:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290030AbSAQQvr>; Thu, 17 Jan 2002 11:51:47 -0500
Received: from nat.transgeek.com ([66.92.79.28]:9213 "EHLO smtp.transgeek.com")
	by vger.kernel.org with ESMTP id <S290034AbSAQQvV>;
	Thu, 17 Jan 2002 11:51:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: viro@math.psu.edu
Subject: likely/unlikely -- vfs BUG_ON
Date: Thu, 17 Jan 2002 11:52:30 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020117215152.9044CB581@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Al,

	As a result of the likely/unlikely thread on lkml I would like to change all 
of the BUG() stuff in the VFS to use BUG_ON where possible.   

	Enclosed is a fairly simple transition for everything under fs/, the only 
thing not included is something like a 
BUG_ON_PK(condition,printk-string,...); or something to remove the direct use 
of likely() --> __builtin_expect();




Craig



Index: linux/fs//attr.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/attr.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 attr.c
--- linux/fs//attr.c	16 Jan 2002 18:26:33 -0000	1.1.1.1
+++ linux/fs//attr.c	17 Jan 2002 02:27:10 -0000
@@ -118,8 +118,7 @@
 	time_t now = CURRENT_TIME;
 	unsigned int ia_valid = attr->ia_valid;
 
-	if (!inode)
-		BUG();
+	BUG_ON(!inode);
 
 	attr->ia_ctime = now;
 	if (!(ia_valid & ATTR_ATIME_SET))
Index: linux/fs//bio.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/bio.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 bio.c
--- linux/fs//bio.c	16 Jan 2002 18:26:33 -0000	1.1.1.1
+++ linux/fs//bio.c	17 Jan 2002 02:44:57 -0000
@@ -420,7 +420,7 @@
 	if (total_nr_pages)
 		goto next_chunk;
 
-	if (size) {
+	if (unlikely(size)) {
 		printk("ll_rw_kio: size %d left (kio %d)\n", size, kio->length);
 		BUG();
 	}
Index: linux/fs//block_dev.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/block_dev.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 block_dev.c
--- linux/fs//block_dev.c	16 Jan 2002 18:26:31 -0000	1.1.1.1
+++ linux/fs//block_dev.c	17 Jan 2002 02:28:43 -0000
@@ -377,8 +377,7 @@
 {
 	if (atomic_dec_and_lock(&bdev->bd_count, &bdev_lock)) {
 		struct list_head *p;
-		if (bdev->bd_openers)
-			BUG();
+		BUG_ON(bdev->bd_openers);
 		list_del(&bdev->bd_hash);
 		while ( (p = bdev->bd_inodes.next) != &bdev->bd_inodes ) {
 			__bd_forget(list_entry(p, struct inode, i_devices));
@@ -407,8 +406,8 @@
 		inode->i_bdev = bdev;
 		inode->i_mapping = bdev->bd_inode->i_mapping;
 		list_add(&inode->i_devices, &bdev->bd_inodes);
-	} else if (inode->i_bdev != bdev)
-		BUG();
+	} else
+		BUG_ON(inode->i_bdev != bdev);
 	spin_unlock(&bdev_lock);
 	return 0;
 }
Index: linux/fs//buffer.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/buffer.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 buffer.c
--- linux/fs//buffer.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//buffer.c	17 Jan 2002 02:31:09 -0000
@@ -505,7 +505,7 @@
 {
 	struct buffer_head **bhp = &lru_list[blist];
 
-	if (bh->b_prev_free || bh->b_next_free) BUG();
+	BUG_ON(bh->b_prev_free || bh->b_next_free);
 
 	if(!*bhp) {
 		*bhp = bh;
@@ -692,8 +692,7 @@
 
 			write_lock(&hash_table_lock);
 			/* All buffers in the lru lists are mapped */
-			if (!buffer_mapped(bh))
-				BUG();
+			BUG_ON(!buffer_mapped(bh));
 			if (buffer_dirty(bh))
 				printk("invalidate: dirty buffer\n");
 			if (!atomic_read(&bh->b_count)) {
@@ -1195,8 +1194,7 @@
  */
 static void __put_unused_buffer_head(struct buffer_head * bh)
 {
-	if (bh->b_inode)
-		BUG();
+	BUG_ON(bh->b_inode);
 	if (nr_unused_buffer_heads >= MAX_UNUSED_BUFFERS) {
 		kmem_cache_free(bh_cachep, bh);
 	} else {
@@ -1270,8 +1268,7 @@
 void set_bh_page (struct buffer_head *bh, struct page *page, unsigned long 
offset)
 {
 	bh->b_page = page;
-	if (offset >= PAGE_SIZE)
-		BUG();
+	BUG_ON(offset >= PAGE_SIZE);
 	if (PageHighMem(page))
 		/*
 		 * This catches illegal uses and preserves the offset:
@@ -1384,8 +1381,7 @@
 
 int try_to_release_page(struct page * page, int gfp_mask)
 {
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	
 	if (!page->mapping)
 		goto try_to_free;
@@ -1414,8 +1410,7 @@
 	struct buffer_head *head, *bh, *next;
 	unsigned int curr_off = 0;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	if (!page->buffers)
 		return 1;
 
@@ -1458,8 +1453,7 @@
 
 	/* FIXME: create_buffers should fail if there's no enough memory */
 	head = create_buffers(page, blocksize, 1);
-	if (page->buffers)
-		BUG();
+	BUG_ON(page->buffers);
 
 	bh = head;
 	do {
@@ -1520,8 +1514,7 @@
 	unsigned long block;
 	struct buffer_head *bh, *head;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 
 	if (!page->buffers)
 		create_empty_buffers(page, 1 << inode->i_blkbits);
@@ -1599,8 +1592,7 @@
 
 	for(bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {
-		if (!bh)
-			BUG();
+		BUG_ON(!bh);
 		block_end = block_start+blocksize;
 		if (block_end <= from)
 			continue;
@@ -2026,8 +2018,7 @@
 			goto out;
 
 		if (rw == READ) {
-			if (buffer_new(&bh))
-				BUG();
+			BUG_ON(buffer_new(&bh));
 			if (!buffer_mapped(&bh)) {
 				/* there was an hole in the filesystem */
 				blocks[i] = -1UL;
@@ -2036,8 +2027,7 @@
 		} else {
 			if (buffer_new(&bh))
 				unmap_underlying_metadata(&bh);
-			if (!buffer_mapped(&bh))
-				BUG();
+			BUG_ON(!buffer_mapped(&bh));
 		}
 		blocks[i] = bh.b_blocknr;
 	}
@@ -2214,8 +2204,7 @@
 	if (!page)
 		return NULL;
 
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 
 	bh = page->buffers;
 	if (bh) {
@@ -2278,11 +2267,9 @@
 	int sizebits;
 
 	/* Size must be multiple of hard sectorsize */
-	if (size & (get_hardsect_size(to_kdev_t(bdev->bd_dev))-1))
-		BUG();
+	BUG_ON(size & (get_hardsect_size(to_kdev_t(bdev->bd_dev))-1));
 	/* Size must be within 512 bytes and PAGE_SIZE */
-	if (size < 512 || size > PAGE_SIZE)
-		BUG();
+	BUG_ON(size < 512 || size > PAGE_SIZE);
 
 	sizebits = -1;
 	do {
@@ -2390,7 +2377,7 @@
 		struct buffer_head * p = tmp;
 		tmp = tmp->b_this_page;
 
-		if (kdev_same(p->b_dev, B_FREE)) BUG();
+		BUG_ON(kdev_same(p->b_dev, B_FREE));
 
 		remove_inode_queue(p);
 		__remove_from_queues(p);
Index: linux/fs//dcache.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/dcache.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dcache.c
--- linux/fs//dcache.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//dcache.c	17 Jan 2002 02:32:06 -0000
@@ -32,7 +32,7 @@
 spinlock_t dcache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /* Right now the dcache depends on the kernel lock */
-#define check_lock()	if (!kernel_locked()) BUG()
+#define check_lock()	BUG_ON(!kernel_locked())
 
 static kmem_cache_t *dentry_cache; 
 
@@ -125,8 +125,7 @@
 		return;
 
 	/* dput on a free dentry? */
-	if (!list_empty(&dentry->d_lru))
-		BUG();
+	BUG_ON(!list_empty(&dentry->d_lru));
 	/*
 	 * AV: ->d_delete() is _NOT_ allowed to block now.
 	 */
@@ -341,8 +340,7 @@
 		dentry_stat.nr_unused--;
 
 		/* Unused dentry with a count? */
-		if (atomic_read(&dentry->d_count))
-			BUG();
+		BUG_ON(atomic_read(&dentry->d_count));
 
 		prune_one_dentry(dentry);
 		if (!--count)
@@ -651,7 +649,7 @@
  
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
-	if (!list_empty(&entry->d_alias)) BUG();
+	BUG_ON(!list_empty(&entry->d_alias));
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
@@ -834,7 +832,7 @@
 void d_rehash(struct dentry * entry)
 {
 	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-	if (!list_empty(&entry->d_hash)) BUG();
+	BUG_ON(!list_empty(&entry->d_hash));
 	spin_lock(&dcache_lock);
 	list_add(&entry->d_hash, list);
 	spin_unlock(&dcache_lock);
Index: linux/fs//dquot.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/dquot.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dquot.c
--- linux/fs//dquot.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//dquot.c	17 Jan 2002 02:32:26 -0000
@@ -1210,8 +1210,7 @@
 		dquot_incr_inodes(transfer_to[cnt], 1);
 		dquot_incr_blocks(transfer_to[cnt], blocks);
 
-		if (inode->i_dquot[cnt] == NODQUOT)
-			BUG();
+		BUG_ON(inode->i_dquot[cnt] == NODQUOT);
 		inode->i_dquot[cnt] = transfer_to[cnt];
 		/*
 		 * We've got to release transfer_from[] twice - once for dquot_transfer() 
and
Index: linux/fs//exec.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/exec.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 exec.c
--- linux/fs//exec.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//exec.c	17 Jan 2002 02:32:39 -0000
@@ -424,7 +424,7 @@
 		activate_mm(active_mm, mm);
 		mm_release();
 		if (old_mm) {
-			if (active_mm != old_mm) BUG();
+			BUG_ON(active_mm != old_mm);
 			mmput(old_mm);
 			return 0;
 		}
Index: linux/fs//fcntl.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/fcntl.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fcntl.c
--- linux/fs//fcntl.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//fcntl.c	17 Jan 2002 02:32:55 -0000
@@ -435,8 +435,7 @@
 			/* Make sure we are called with one of the POLL_*
 			   reasons, otherwise we could leak kernel stack into
 			   userspace.  */
-			if ((reason & __SI_MASK) != __SI_POLL)
-				BUG();
+			BUG_ON((reason & __SI_MASK) != __SI_POLL);
 			if (reason - POLL_IN >= NSIGPOLL)
 				si.si_band  = ~0L;
 			else
Index: linux/fs//inode.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/inode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 inode.c
--- linux/fs//inode.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//inode.c	17 Jan 2002 02:33:58 -0000
@@ -79,8 +79,7 @@
 	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL))
 static void destroy_inode(struct inode *inode) 
 {
-	if (inode_has_buffers(inode))
-		BUG();
+	BUG_ON(inode_has_buffers(inode));
 	kmem_cache_free(inode_cachep, (inode));
 }
 
@@ -212,8 +211,7 @@
 	list_del(&inode->i_list);
 	list_add(&inode->i_list, &inode->i_sb->s_locked_inodes);
 
-	if (inode->i_state & I_LOCK)
-		BUG();
+	BUG_ON(inode->i_state & I_LOCK);
 
 	/* Set I_LOCK, reset I_DIRTY */
 	dirty = inode->i_state & I_DIRTY;
@@ -509,12 +507,9 @@
 {
 	invalidate_inode_buffers(inode);
        
-	if (inode->i_data.nrpages)
-		BUG();
-	if (!(inode->i_state & I_FREEING))
-		BUG();
-	if (inode->i_state & I_CLEAR)
-		BUG();
+	BUG_ON(inode->i_data.nrpages);
+	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(inode->i_state & I_CLEAR);
 	wait_on_inode(inode);
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->clear_inode)
@@ -1041,8 +1036,7 @@
 		struct super_block *sb = inode->i_sb;
 		struct super_operations *op = NULL;
 
-		if (inode->i_state == I_CLEAR)
-			BUG();
+		BUG_ON(inode->i_state == I_CLEAR);
 
 		if (sb && sb->s_op)
 			op = sb->s_op;
@@ -1072,8 +1066,7 @@
 				delete(inode);
 			} else
 				clear_inode(inode);
-			if (inode->i_state != I_CLEAR)
-				BUG();
+			BUG_ON(inode->i_state != I_CLEAR);
 		} else {
 			if (!list_empty(&inode->i_hash)) {
 				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
Index: linux/fs//locks.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/locks.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 locks.c
--- linux/fs//locks.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//locks.c	17 Jan 2002 02:53:00 -0000
@@ -148,7 +148,7 @@
 /* Free a lock which is not in use. */
 static inline void locks_free_lock(struct file_lock *fl)
 {
-	if (fl == NULL) {
+	if (unlikely(fl == NULL)) {
 		BUG();
 		return;
 	}
Index: linux/fs//open.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/open.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 open.c
--- linux/fs//open.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//open.c	17 Jan 2002 02:34:16 -0000
@@ -804,8 +804,7 @@
 {
 	struct files_struct *files = current->files;
 	write_lock(&files->file_lock);
-	if (unlikely(files->fd[fd] != NULL))
-		BUG();
+	BUG_ON(files->fd[fd] != NULL);
 	files->fd[fd] = file;
 	write_unlock(&files->file_lock);
 }
Index: linux/fs//pipe.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/pipe.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pipe.c
--- linux/fs//pipe.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//pipe.c	17 Jan 2002 02:34:30 -0000
@@ -116,8 +116,7 @@
 		 * room.
 		 */
 		wake_up_interruptible_sync(PIPE_WAIT(*inode));
-		if (!PIPE_EMPTY(*inode))
-			BUG();
+		BUG_ON(!PIPE_EMPTY(*inode));
 		goto do_more_read;
 	}
 	/* Signal writers asynchronously that there is more room.  */
Index: linux/fs//affs/file.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/affs/file.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 file.c
--- linux/fs//affs/file.c	16 Jan 2002 18:26:42 -0000	1.1.1.1
+++ linux/fs//affs/file.c	17 Jan 2002 02:44:35 -0000
@@ -217,8 +217,7 @@
 		ext_key = be32_to_cpu(AFFS_TAIL(sb, bh)->extension);
 		if (ext < AFFS_INODE->i_extcnt)
 			goto read_ext;
-		if (ext > AFFS_INODE->i_extcnt)
-			BUG();
+		BUG_ON(ext > AFFS_INODE->i_extcnt);
 		bh = affs_alloc_extblock(inode, bh, ext);
 		if (IS_ERR(bh))
 			return bh;
@@ -235,8 +234,7 @@
 		struct buffer_head *prev_bh;
 
 		/* allocate a new extended block */
-		if (ext > AFFS_INODE->i_extcnt)
-			BUG();
+		BUG_ON(ext > AFFS_INODE->i_extcnt);
 
 		/* get previous extended block */
 		prev_bh = affs_get_extblock(inode, ext - 1);
Index: linux/fs//coda/cache.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/coda/cache.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cache.c
--- linux/fs//coda/cache.c	16 Jan 2002 18:28:07 -0000	1.1.1.1
+++ linux/fs//coda/cache.c	17 Jan 2002 02:45:12 -0000
@@ -51,7 +51,7 @@
         struct list_head *tmp;
 
         sbi = coda_sbp(sb);
-        if (!sbi) BUG();
+        BUG_ON(!sbi);
 
         list_for_each(tmp, &sbi->sbi_cihead)
         {
Index: linux/fs//coda/cnode.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/coda/cnode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 cnode.c
--- linux/fs//coda/cnode.c	16 Jan 2002 18:28:06 -0000	1.1.1.1
+++ linux/fs//coda/cnode.c	17 Jan 2002 02:45:43 -0000
@@ -84,7 +84,7 @@
 		cii->c_fid = *fid;
 
 	/* we shouldnt see inode collisions anymore */
-	if (!coda_fideq(fid, &cii->c_fid)) BUG();
+	BUG_ON(!coda_fideq(fid, &cii->c_fid));
 
 	/* always replace the attributes, type might have changed */
 	coda_fill_inode(inode, attr);
@@ -132,8 +132,7 @@
 	
 	cii = ITOC(inode);
 
-	if (!coda_fideq(&cii->c_fid, oldfid))
-		BUG();
+	BUG_ON(!coda_fideq(&cii->c_fid, oldfid));
 
 	/* replace fid and rehash inode */
 	/* XXX we probably need to hold some lock here! */
@@ -175,7 +174,7 @@
 	}
 
 	/* we shouldn't see inode collisions anymore */
-	if ( !coda_fideq(fid, &cii->c_fid) ) BUG();
+	BUG_ON( !coda_fideq(fid, &cii->c_fid) );
 
         CDEBUG(D_INODE, "found %ld\n", inode->i_ino);
         return inode;
Index: linux/fs//coda/dir.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/coda/dir.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dir.c
--- linux/fs//coda/dir.c	16 Jan 2002 18:28:07 -0000	1.1.1.1
+++ linux/fs//coda/dir.c	17 Jan 2002 02:46:09 -0000
@@ -502,7 +502,7 @@
 	coda_vfs_stat.readdir++;
 
         cfile = cii->c_container;
-        if (!cfile) BUG();
+        BUG_ON(!cfile);
 
 	cinode = cii->c_container->f_dentry->d_inode;
 	if ( S_ISREG(cinode->i_mode) ) {
Index: linux/fs//coda/file.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/coda/file.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 file.c
--- linux/fs//coda/file.c	16 Jan 2002 18:28:07 -0000	1.1.1.1
+++ linux/fs//coda/file.c	17 Jan 2002 02:46:50 -0000
@@ -37,7 +37,7 @@
 	struct file *cfile;
 
 	cfile = cii->c_container;
-	if (!cfile) BUG();
+	BUG_ON(!cfile);
 
 	if (!cfile->f_op || !cfile->f_op->read)
 		return -EINVAL;
@@ -55,7 +55,7 @@
 	int flags;
 
 	cfile = cii->c_container;
-	if (!cfile) BUG();
+	BUG_ON(!cfile);
 
 	if (!cfile->f_op || !cfile->f_op->write)
 		return -EINVAL;
@@ -83,7 +83,7 @@
 
 	cfile = cii->c_container;
 
-	if (!cfile) BUG();
+	BUG_ON(!cfile);
 
 	if (!cfile->f_op || !cfile->f_op->mmap)
 		return -ENODEV;
@@ -170,7 +170,7 @@
 	inode = file->f_dentry->d_inode;
 	cii = ITOC(inode);
 	cfile = cii->c_container;
-	if (!cfile) BUG();
+	BUG_ON(!cfile);
 
 	cinode = cfile->f_dentry->d_inode;
 
@@ -212,7 +212,7 @@
 
 	cii = ITOC(i);
 	cfile = cii->c_container;
-	if (!cfile) BUG();
+	BUG_ON(!cfile);
 
 	if (--cii->c_contcount) {
 		unlock_kernel();
@@ -245,7 +245,7 @@
 		return -EINVAL;
 
 	cfile = cii->c_container;
-	if (!cfile) BUG();
+	BUG_ON(!cfile);
 
 	coda_vfs_stat.fsync++;
 
Index: linux/fs//coda/inode.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/coda/inode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 inode.c
--- linux/fs//coda/inode.c	16 Jan 2002 18:28:07 -0000	1.1.1.1
+++ linux/fs//coda/inode.c	17 Jan 2002 02:47:05 -0000
@@ -186,7 +186,7 @@
 	struct coda_sb_info *sbi = coda_sbp(inode->i_sb);
 	struct coda_inode_info *cii;
 
-        if (!sbi) BUG();
+        BUG_ON(!sbi);
 
 #if 0
 	/* check if the inode is already initialized */
@@ -221,7 +221,7 @@
 	       inode->i_ino, atomic_read(&inode->i_count));        
 	CDEBUG(D_DOWNCALL, "clearing inode: %ld, %x\n", inode->i_ino, cii->c_flags);
 
-	if (cii->c_container) BUG();
+	BUG_ON(cii->c_container);
 	
         list_del_init(&cii->c_cilist);
 	inode->i_mapping = &inode->i_data;
Index: linux/fs//ext2/dir.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/ext2/dir.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dir.c
--- linux/fs//ext2/dir.c	16 Jan 2002 18:26:36 -0000	1.1.1.1
+++ linux/fs//ext2/dir.c	17 Jan 2002 02:48:31 -0000
@@ -377,8 +377,7 @@
 
 	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	de->inode = cpu_to_le32(inode->i_ino);
 	ext2_set_de_type (de, inode);
 	err = ext2_commit_chunk(page, from, to);
@@ -484,8 +483,7 @@
 		from = (char*)pde - (char*)page_address(page);
 	lock_page(page);
 	err = mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	if (pde)
 		pde->rec_len = cpu_to_le16(to-from);
 	dir->inode = 0;
Index: linux/fs//ext3/super.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/ext3/super.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 super.c
--- linux/fs//ext3/super.c	16 Jan 2002 18:28:22 -0000	1.1.1.1
+++ linux/fs//ext3/super.c	17 Jan 2002 02:48:41 -0000
@@ -1551,8 +1551,7 @@
 {
 	tid_t target;
 	
-	if (down_trylock(&sb->s_lock) == 0)
-		BUG();		/* aviro detector */
+	BUG_ON(down_trylock(&sb->s_lock) == 0);
 	sb->s_dirt = 0;
 	target = log_start_commit(EXT3_SB(sb)->s_journal, NULL);
 
Index: linux/fs//fat/file.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/fat/file.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 file.c
--- linux/fs//fat/file.c	16 Jan 2002 18:26:40 -0000	1.1.1.1
+++ linux/fs//fat/file.c	17 Jan 2002 02:49:01 -0000
@@ -60,7 +60,7 @@
 	}
 	if (!create)
 		return 0;
-	if (iblock << sb->s_blocksize_bits != MSDOS_I(inode)->mmu_private) {
+	if (unlikely(iblock << sb->s_blocksize_bits != 
MSDOS_I(inode)->mmu_private)) {
 		BUG();
 		return -EIO;
 	}
@@ -70,8 +70,7 @@
 	}
 	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
 	phys = fat_bmap(inode, iblock);
-	if (!phys)
-		BUG();
+	BUG_ON(!phys);
 	bh_result->b_state |= (1UL << BH_New);
 	map_bh(bh_result, inode->i_sb, phys);
 	return 0;
Index: linux/fs//freevxfs/vxfs_olt.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/freevxfs/vxfs_olt.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 vxfs_olt.c
--- linux/fs//freevxfs/vxfs_olt.c	16 Jan 2002 18:28:18 -0000	1.1.1.1
+++ linux/fs//freevxfs/vxfs_olt.c	17 Jan 2002 02:49:35 -0000
@@ -42,24 +42,21 @@
 static __inline__ void
 vxfs_get_fshead(struct vxfs_oltfshead *fshp, struct vxfs_sb_info *infp)
 {
-	if (infp->vsi_fshino)
-		BUG();
+	BUG_ON(infp->vsi_fshino);
 	infp->vsi_fshino = fshp->olt_fsino[0];
 }
 
 static __inline__ void
 vxfs_get_ilist(struct vxfs_oltilist *ilistp, struct vxfs_sb_info *infp)
 {
-	if (infp->vsi_iext)
-		BUG();
+	BUG_ON(infp->vsi_iext);
 	infp->vsi_iext = ilistp->olt_iext[0]; 
 }
 
 static __inline__ u_long
 vxfs_oblock(struct super_block *sbp, daddr_t block, u_long bsize)
 {
-	if (sbp->s_blocksize % bsize)
-		BUG();
+	BUG_ON(sbp->s_blocksize % bsize);
 	return (block * (sbp->s_blocksize / bsize));
 }
 
Index: linux/fs//hpfs/file.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/hpfs/file.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 file.c
--- linux/fs//hpfs/file.c	16 Jan 2002 18:26:38 -0000	1.1.1.1
+++ linux/fs//hpfs/file.c	17 Jan 2002 02:49:52 -0000
@@ -77,7 +77,7 @@
 		return 0;
 	}
 	if (!create) return 0;
-	if (iblock<<9 != inode->u.hpfs_i.mmu_private) {
+	if (unlikely(iblock<<9 != inode->u.hpfs_i.mmu_private)) {
 		BUG();
 		return -EIO;
 	}
Index: linux/fs//intermezzo/dcache.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/intermezzo/dcache.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dcache.c
--- linux/fs//intermezzo/dcache.c	16 Jan 2002 18:28:21 -0000	1.1.1.1
+++ linux/fs//intermezzo/dcache.c	17 Jan 2002 02:50:00 -0000
@@ -76,8 +76,7 @@
 void presto_set_dd(struct dentry * dentry)
 {
         ENTRY;
-        if (dentry == NULL)
-                BUG();
+        BUG_ON(dentry == NULL);
 
         if (dentry->d_fsdata) {
                 printk("VERY BAD: dentry: %p\n", dentry);
Index: linux/fs//intermezzo/presto.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/intermezzo/presto.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 presto.c
--- linux/fs//intermezzo/presto.c	16 Jan 2002 18:28:21 -0000	1.1.1.1
+++ linux/fs//intermezzo/presto.c	17 Jan 2002 02:50:12 -0000
@@ -56,7 +56,7 @@
 
 static inline struct presto_file_set *presto_dentry2fset(struct dentry 
*dentry)
 {
-        if (dentry->d_fsdata == NULL) {
+        if (unlikely(dentry->d_fsdata == NULL)) {
                 printk("fucked dentry: %p\n", dentry);
                 BUG();
         }
Index: linux/fs//jbd/journal.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/jbd/journal.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 journal.c
--- linux/fs//jbd/journal.c	16 Jan 2002 18:28:23 -0000	1.1.1.1
+++ linux/fs//jbd/journal.c	17 Jan 2002 02:50:22 -0000
@@ -868,7 +868,7 @@
 		return -EINVAL;
 	}
 
-	if (journal->j_inode == NULL) {
+	if (unlikely(journal->j_inode == NULL)) {
 		/*
 		 * We don't know what block to start at!
 		 */
Index: linux/fs//jbd/transaction.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/jbd/transaction.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 transaction.c
--- linux/fs//jbd/transaction.c	16 Jan 2002 18:28:23 -0000	1.1.1.1
+++ linux/fs//jbd/transaction.c	17 Jan 2002 02:50:30 -0000
@@ -1879,8 +1879,7 @@
 	unsigned int curr_off = 0;
 	int may_free = 1;
 		
-	if (!PageLocked(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
 	if (!page->buffers)
 		return 1;
 
Index: linux/fs//jffs2/background.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/jffs2/background.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 background.c
--- linux/fs//jffs2/background.c	16 Jan 2002 18:28:19 -0000	1.1.1.1
+++ linux/fs//jffs2/background.c	17 Jan 2002 02:50:38 -0000
@@ -64,8 +64,7 @@
 	pid_t pid;
 	int ret = 0;
 
-	if (c->gc_task)
-		BUG();
+	BUG_ON(c->gc_task);
 
 	init_MUTEX_LOCKED(&c->gc_thread_start);
 	init_completion(&c->gc_thread_exit);
Index: linux/fs//jffs2/gc.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/jffs2/gc.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 gc.c
--- linux/fs//jffs2/gc.c	16 Jan 2002 18:28:19 -0000	1.1.1.1
+++ linux/fs//jffs2/gc.c	17 Jan 2002 02:51:21 -0000
@@ -90,7 +90,7 @@
 	list_del(&ret->list);
 	c->gcblock = ret;
 	ret->gc_node = ret->first_node;
-	if (!ret->gc_node) {
+	if (unlikely(!ret->gc_node)) {
 		printk(KERN_WARNING "Eep. ret->gc_node for block at 0x%08x is NULL\n", 
ret->offset);
 		BUG();
 	}
@@ -142,7 +142,7 @@
 	while(raw->flash_offset & 1) {
 		D1(printk(KERN_DEBUG "Node at 0x%08x is obsolete... skipping\n", 
raw->flash_offset &~3));
 		jeb->gc_node = raw = raw->next_phys;
-		if (!raw) {
+		if (unlikely(!raw)) {
 			printk(KERN_WARNING "eep. End of raw list while still supposedly nodes to 
GC\n");
 			printk(KERN_WARNING "erase block at 0x%08x. free_size 0x%08x, dirty_size 
0x%08x, used_size 0x%08x\n", 
 			       jeb->offset, jeb->free_size, jeb->dirty_size, jeb->used_size);
@@ -510,11 +510,11 @@
 			fn->frags--;
 		}
 	}
-	if (fn->frags) {
+	if (unlikely(fn->frags)) {
 		printk(KERN_WARNING "jffs2_garbage_collect_hole: Old node still has 
frags!\n");
 		BUG();
 	}
-	if (!new_fn->frags) {
+	if (unlikely(!new_fn->frags)) {
 		printk(KERN_WARNING "jffs2_garbage_collect_hole: New node has no 
frags!\n");
 		BUG();
 	}
Index: linux/fs//jffs2/nodelist.h
===================================================================
RCS file: /home/Media/cvs/linux/fs/jffs2/nodelist.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 nodelist.h
--- linux/fs//jffs2/nodelist.h	16 Jan 2002 18:28:19 -0000	1.1.1.1
+++ linux/fs//jffs2/nodelist.h	17 Jan 2002 02:51:52 -0000
@@ -191,13 +191,13 @@
 };
 
 #define ACCT_SANITY_CHECK(c, jeb) do { \
-	if (jeb->used_size + jeb->dirty_size + jeb->free_size != c->sector_size) { \
+	if (unlikely(jeb->used_size + jeb->dirty_size + jeb->free_size != 
c->sector_size)) { \
 		printk(KERN_NOTICE "Eeep. Space accounting for block at 0x%08x is 
screwed\n", jeb->offset); \
 		printk(KERN_NOTICE "free 0x%08x + dirty 0x%08x + used %08x != total 
%08x\n", \
 		jeb->free_size, jeb->dirty_size, jeb->used_size, c->sector_size); \
 		BUG(); \
 	} \
-	if (c->used_size + c->dirty_size + c->free_size + c->erasing_size + 
c->bad_size != c->flash_size) { \
+	if (unlikely(c->used_size + c->dirty_size + c->free_size + c->erasing_size 
+ c->bad_size != c->flash_size)) { \
 		printk(KERN_NOTICE "Eeep. Space accounting superblock info is screwed\n"); 
\
 		printk(KERN_NOTICE "free 0x%08x + dirty 0x%08x + used %08x + erasing %08x 
+ bad %08x != total %08x\n", \
 		c->free_size, c->dirty_size, c->used_size, c->erasing_size, c->bad_size, 
c->flash_size); \
@@ -213,7 +213,7 @@
 				my_used_size += ref2->totlen; \
 			ref2 = ref2->next_phys; \
 		} \
-		if (my_used_size != jeb->used_size) { \
+		if (unlikely(my_used_size != jeb->used_size)) { \
 			printk(KERN_NOTICE "Calculated used size %08x != stored used size 
%08x\n", my_used_size, jeb->used_size); \
 			BUG(); \
 		} \
Index: linux/fs//jffs2/nodemgmt.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/jffs2/nodemgmt.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 nodemgmt.c
--- linux/fs//jffs2/nodemgmt.c	16 Jan 2002 18:28:19 -0000	1.1.1.1
+++ linux/fs//jffs2/nodemgmt.c	17 Jan 2002 02:52:10 -0000
@@ -297,12 +297,12 @@
 		return;
 	}
 	blocknr = ref->flash_offset / c->sector_size;
-	if (blocknr >= c->nr_blocks) {
+	if (unlikely(blocknr >= c->nr_blocks)) {
 		printk(KERN_NOTICE "raw node at 0x%08x is off the end of device!\n", 
ref->flash_offset);
 		BUG();
 	}
 	jeb = &c->blocks[blocknr];
-	if (jeb->used_size < ref->totlen) {
+	if (unlikely(jeb->used_size < ref->totlen)) {
 		printk(KERN_NOTICE "raw node of size 0x%08x freed from erase block %d at 
0x%08x, but used_size was already 0x%08x\n",
 		       ref->totlen, blocknr, ref->flash_offset, jeb->used_size);
 		BUG();
Index: linux/fs//jffs2/scan.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/jffs2/scan.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 scan.c
--- linux/fs//jffs2/scan.c	16 Jan 2002 18:28:19 -0000	1.1.1.1
+++ linux/fs//jffs2/scan.c	17 Jan 2002 02:52:18 -0000
@@ -557,8 +557,7 @@
 			D1(printk(KERN_DEBUG "Shifting new node at 0x%08x after other node at 
0x%08x for version %d in list\n",
 				  fn->raw->flash_offset&~3, tn->next->fn->raw->flash_offset &~3, 
ri.version));
 
-			if(tn->fn != fn)
-				BUG();
+			BUG_ON(tn->fn != fn);
 			tn->fn = tn->next->fn;
 			tn->next->fn = fn;
 			tn = tn->next;
Index: linux/fs//jffs2/write.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/jffs2/write.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 write.c
--- linux/fs//jffs2/write.c	16 Jan 2002 18:28:20 -0000	1.1.1.1
+++ linux/fs//jffs2/write.c	17 Jan 2002 02:52:46 -0000
@@ -181,7 +181,7 @@
 	struct iovec vecs[2];
 	int ret;
 
-	D1(if(ri->hdr_crc != crc32(0, ri, sizeof(struct jffs2_unknown_node)-4)) {
+	D1(if(unlikely(ri->hdr_crc != crc32(0, ri, sizeof(struct 
jffs2_unknown_node)-4))) {
 		printk(KERN_CRIT "Eep. CRC not correct in jffs2_write_dnode()\n");
 		BUG();
 	}
@@ -269,7 +269,7 @@
 	D1(printk(KERN_DEBUG "jffs2_write_dirent(ino #%u, name at *0x%p \"%s\"->ino 
#%u, name_crc 0x%08x)\n", rd->pino, name, name, rd->ino, rd->name_crc));
 	writecheck(c->mtd, flash_ofs);
 
-	D1(if(rd->hdr_crc != crc32(0, rd, sizeof(struct jffs2_unknown_node)-4)) {
+	D1(if(unlikely(rd->hdr_crc != crc32(0, rd, sizeof(struct 
jffs2_unknown_node)-4))) {
 		printk(KERN_CRIT "Eep. CRC not correct in jffs2_write_dirent()\n");
 		BUG();
 	}
Index: linux/fs//minix/dir.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/minix/dir.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dir.c
--- linux/fs//minix/dir.c	16 Jan 2002 18:26:34 -0000	1.1.1.1
+++ linux/fs//minix/dir.c	17 Jan 2002 02:53:16 -0000
@@ -236,8 +236,7 @@
 
 	lock_page(page);
 	err = mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	de->inode = 0;
 	err = dir_commit_chunk(page, from, to);
 	UnlockPage(page);
@@ -336,8 +335,7 @@
 
 	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	de->inode = inode->i_ino;
 	err = dir_commit_chunk(page, from, to);
 	UnlockPage(page);
Index: linux/fs//nfs/pagelist.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/nfs/pagelist.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 pagelist.c
--- linux/fs//nfs/pagelist.c	16 Jan 2002 18:26:36 -0000	1.1.1.1
+++ linux/fs//nfs/pagelist.c	17 Jan 2002 02:53:45 -0000
@@ -145,14 +145,10 @@
 	atomic_dec(&cache->nr_requests);
 
 #ifdef NFS_PARANOIA
-	if (!list_empty(&req->wb_list))
-		BUG();
-	if (!list_empty(&req->wb_hash))
-		BUG();
-	if (NFS_WBACK_BUSY(req))
-		BUG();
-	if (atomic_read(&cache->nr_requests) < 0)
-		BUG();
+	BUG_ON(!list_empty(&req->wb_list));
+	BUG_ON(!list_empty(&req->wb_hash));
+	BUG_ON(NFS_WBACK_BUSY(req));
+	BUG_ON(atomic_read(&cache->nr_requests) < 0);
 #endif
 
 	/* Release struct file or cached credential */
@@ -181,7 +177,7 @@
 	unsigned long pg_idx = page_index(req->wb_page);
 
 #ifdef NFS_PARANOIA
-	if (!list_empty(&req->wb_list)) {
+	if (unlikely(!list_empty(&req->wb_list))) {
 		printk(KERN_ERR "NFS: Add to list failed!\n");
 		BUG();
 	}
Index: linux/fs//nfs/read.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/nfs/read.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 read.c
--- linux/fs//nfs/read.c	16 Jan 2002 18:26:35 -0000	1.1.1.1
+++ linux/fs//nfs/read.c	17 Jan 2002 02:53:59 -0000
@@ -452,13 +452,11 @@
 
 	if (!file) {
 		struct address_space *mapping = page->mapping;
-		if (!mapping)
-			BUG();
+		BUG_ON(!mapping);
 		inode = mapping->host;
 	} else
 		inode = file->f_dentry->d_inode;
-	if (!inode)
-		BUG();
+	BUG_ON(!inode);
 
 	dprintk("NFS: nfs_readpage (%p %ld@%lu)\n",
 		page, PAGE_CACHE_SIZE, page->index);
Index: linux/fs//nfs/write.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/nfs/write.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 write.c
--- linux/fs//nfs/write.c	16 Jan 2002 18:26:35 -0000	1.1.1.1
+++ linux/fs//nfs/write.c	17 Jan 2002 02:54:15 -0000
@@ -245,11 +245,9 @@
 	int err;
 	struct address_space *mapping = page->mapping;
 
-	if (!mapping)
-		BUG();
+	BUG_ON(!mapping);
 	inode = mapping->host;
-	if (!inode)
-		BUG();
+	BUG_ON(!inode);
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
 	/* Ensure we've flushed out any previous writes */
Index: linux/fs//ntfs/inode.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/ntfs/inode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 inode.c
--- linux/fs//ntfs/inode.c	16 Jan 2002 18:28:09 -0000	1.1.1.1
+++ linux/fs//ntfs/inode.c	17 Jan 2002 02:54:51 -0000
@@ -1826,8 +1826,7 @@
 			(unsigned long)io.size);
 #ifdef DEBUG
 	/* Check our bit is really zero! */
-	if (*buf & (1 << (bit & 7)))
-		BUG();
+	BUG_ON(*buf & (1 << (bit & 7)));
 #endif
 	*buf |= 1 << (bit & 7);
 	io.param = buf;
@@ -1899,9 +1898,8 @@
 		err = ntfs_allocate_clusters(vol, &lcn2, &nr_lcn2, &rl2,
 				&r2len, MFT_ZONE);
 #ifdef DEBUG
-		if (!err && nr_lcn2 < min_nr)
-			/* Allocated less than minimum needed. Weird! */
-			BUG();
+		/* Allocated less than minimum needed. Weird! */
+		BUG_ON(!err && nr_lcn2 < min_nr);
 #endif
 		if (err) {
 			/*
@@ -1983,9 +1981,8 @@
 			"= 0x%Lx, data->initialized = 0x%Lx.\n",
 			data->allocated, data->size, data->initialized);
 	/* Sanity checks. */
-	if (data->size > data->allocated || data->size < data->initialized ||
-			data->initialized > data->allocated)
-		BUG();
+	BUG_ON(data->size > data->allocated || data->size < data->initialized ||
+			data->initialized > data->allocated);
 #endif
 done_ret:
 	/* Return the number of the allocated mft record. */
Index: linux/fs//ntfs/macros.h
===================================================================
RCS file: /home/Media/cvs/linux/fs/ntfs/macros.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 macros.h
--- linux/fs//ntfs/macros.h	16 Jan 2002 18:28:10 -0000	1.1.1.1
+++ linux/fs//ntfs/macros.h	17 Jan 2002 02:54:59 -0000
@@ -21,8 +21,7 @@
 			((char*)&(((struct inode*)NULL)->u.ntfs_i) -
 			(char*)NULL));
 #ifdef DEBUG
-	if ((char*)NTFS_LINO2NINO(i) != (char*)ntfs_ino)
-		BUG();
+	BUG_ON((char*)NTFS_LINO2NINO(i) != (char*)ntfs_ino);
 #endif
 	return i;
 }
Index: linux/fs//partitions/ibm.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/partitions/ibm.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ibm.c
--- linux/fs//partitions/ibm.c	16 Jan 2002 18:28:12 -0000	1.1.1.1
+++ linux/fs//partitions/ibm.c	17 Jan 2002 02:55:15 -0000
@@ -110,8 +110,7 @@
 	dasd_information_t *info;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
 
-	if ( first_sector != 0 )
-		BUG();
+	BUG_ON( first_sector != 0 );
 
 	info = (struct dasd_information_t *)kmalloc(sizeof(dasd_information_t),
 						    GFP_KERNEL);
Index: linux/fs//proc/array.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/proc/array.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 array.c
--- linux/fs//proc/array.c	16 Jan 2002 18:26:34 -0000	1.1.1.1
+++ linux/fs//proc/array.c	17 Jan 2002 02:55:34 -0000
@@ -659,13 +659,13 @@
 			lineno++;
 		if (retval >= count)
 			break;
-		if (loff) BUG();
+		BUG_ON(loff);
 		map = map->vm_next;
 	}
 	up_read(&mm->mmap_sem);
 	mmput(mm);
 
-	if (retval > count) BUG();
+	BUG_ON(retval > count);
 	if (copy_to_user(buf, kbuf, retval))
 		retval = -EFAULT;
 	else
Index: linux/fs//reiserfs/fix_node.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/reiserfs/fix_node.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fix_node.c
--- linux/fs//reiserfs/fix_node.c	16 Jan 2002 18:28:17 -0000	1.1.1.1
+++ linux/fs//reiserfs/fix_node.c	17 Jan 2002 02:55:43 -0000
@@ -831,8 +831,7 @@
 	    p_s_new_bh);
     
     /* Put empty buffers into the array. */
-    if (p_s_tb->FEB[p_s_tb->cur_blknum])
-      BUG();
+    BUG_ON(p_s_tb->FEB[p_s_tb->cur_blknum]);
 
     mark_buffer_journal_new(p_s_new_bh) ;
     p_s_tb->FEB[p_s_tb->cur_blknum++] = p_s_new_bh;
Index: linux/fs//reiserfs/journal.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/reiserfs/journal.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 journal.c
--- linux/fs//reiserfs/journal.c	16 Jan 2002 18:28:17 -0000	1.1.1.1
+++ linux/fs//reiserfs/journal.c	17 Jan 2002 02:56:04 -0000
@@ -403,7 +403,7 @@
 */
 void reiserfs_check_lock_depth(char *caller) {
 #ifdef CONFIG_SMP
-  if (current->lock_depth < 0) {
+  if (unlikely(current->lock_depth < 0)) {
     printk("%s called without kernel lock held\n", caller) ;
     show_reiserfs_locks() ;
     BUG() ;
Index: linux/fs//reiserfs/tail_conversion.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/reiserfs/tail_conversion.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 tail_conversion.c
--- linux/fs//reiserfs/tail_conversion.c	16 Jan 2002 18:28:17 -0000	1.1.1.1
+++ linux/fs//reiserfs/tail_conversion.c	17 Jan 2002 02:56:28 -0000
@@ -134,9 +134,7 @@
 /* stolen from fs/buffer.c */
 void reiserfs_unmap_buffer(struct buffer_head *bh) {
   if (buffer_mapped(bh)) {
-    if (buffer_journaled(bh) || buffer_journal_dirty(bh)) {
-      BUG() ;
-    }
+    BUG_ON(buffer_journaled(bh) || buffer_journal_dirty(bh));
     mark_buffer_clean(bh) ;
     lock_buffer(bh) ;
     clear_bit(BH_Mapped, &bh->b_state) ;
Index: linux/fs//smbfs/file.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/smbfs/file.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 file.c
--- linux/fs//smbfs/file.c	16 Jan 2002 18:26:39 -0000	1.1.1.1
+++ linux/fs//smbfs/file.c	17 Jan 2002 02:56:40 -0000
@@ -176,11 +176,9 @@
 	unsigned offset = PAGE_CACHE_SIZE;
 	int err;
 
-	if (!mapping)
-		BUG();
+	BUG_ON(!mapping);
 	inode = mapping->host;
-	if (!inode)
-		BUG();
+	BUG_ON(!inode);
 
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
Index: linux/fs//sysv/dir.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/sysv/dir.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 dir.c
--- linux/fs//sysv/dir.c	16 Jan 2002 18:26:38 -0000	1.1.1.1
+++ linux/fs//sysv/dir.c	17 Jan 2002 02:56:58 -0000
@@ -246,8 +246,7 @@
 
 	lock_page(page);
 	err = mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	de->inode = 0;
 	err = dir_commit_chunk(page, from, to);
 	UnlockPage(page);
@@ -343,8 +342,7 @@
 
 	lock_page(page);
 	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
-	if (err)
-		BUG();
+	BUG_ON(err);
 	de->inode = cpu_to_fs16(inode->i_sb, inode->i_ino);
 	err = dir_commit_chunk(page, from, to);
 	UnlockPage(page);
Index: linux/fs//udf/inode.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/udf/inode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 inode.c
--- linux/fs//udf/inode.c	16 Jan 2002 18:28:13 -0000	1.1.1.1
+++ linux/fs//udf/inode.c	17 Jan 2002 02:57:19 -0000
@@ -344,12 +344,10 @@
 	err = 0;
 
 	bh = inode_getblk(inode, block, &err, &phys, &new);
-	if (bh)
-		BUG();
+	BUG_ON(bh);
 	if (err)
 		goto abort;
-	if (!phys)
-		BUG();
+	BUG_ON(!phys);
 
 	if (new)
 		bh_result->b_state |= (1UL << BH_New);
Index: linux/fs//vfat/namei.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/vfat/namei.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 namei.c
--- linux/fs//vfat/namei.c	16 Jan 2002 18:26:40 -0000	1.1.1.1
+++ linux/fs//vfat/namei.c	17 Jan 2002 02:57:54 -0000
@@ -640,7 +640,7 @@
 
 		if (opt_shortname & VFAT_SFN_CREATE_WIN95) {
 			return (base_info.upper && ext_info.upper);
-		} else if (opt_shortname & VFAT_SFN_CREATE_WINNT) {
+		} else if (likely(opt_shortname & VFAT_SFN_CREATE_WINNT)) {
 			if ((base_info.upper || base_info.lower)
 			    && (ext_info.upper || ext_info.lower)) {
 				*lcase = shortname_info_to_lcase(&base_info,
