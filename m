Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWGZI4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWGZI4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWGZIzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:55:50 -0400
Received: from dea.vocord.ru ([217.67.177.50]:15246 "EHLO
	uganda.factory.vocord.ru") by vger.kernel.org with ESMTP
	id S1030451AbWGZIzr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:55:47 -0400
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev <netdev@vger.kernel.org>
Subject: [3/4] kevent: AIO, aio_sendfile() implementation.
In-Reply-To: <1153905495613@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Wed, 26 Jul 2006 13:18:15 +0400
Message-Id: <11539054952574@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch includes asynchronous propagation of file's data into VFS
cache and aio_sendfile() implementation.
Network aio_sendfile() works lazily - it asynchronously populates pages
into the VFS cache (which can be used for various tricks with adaptive
readahead) and then uses usual ->sendfile() callback.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

diff --git a/fs/bio.c b/fs/bio.c
index 6a0b9ad..a3ee530 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -119,7 +119,7 @@ void bio_free(struct bio *bio, struct bi
 /*
  * default destructor for a bio allocated with bio_alloc_bioset()
  */
-static void bio_fs_destructor(struct bio *bio)
+void bio_fs_destructor(struct bio *bio)
 {
 	bio_free(bio, fs_bio_set);
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 04af9c4..295fce9 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -685,6 +685,7 @@ ext2_writepages(struct address_space *ma
 }
 
 struct address_space_operations ext2_aops = {
+	.get_block		= ext2_get_block,
 	.readpage		= ext2_readpage,
 	.readpages		= ext2_readpages,
 	.writepage		= ext2_writepage,
diff --git a/fs/ext3/inode.c b/fs/ext3/inode.c
index 2edd7ee..e44f5ad 100644
--- a/fs/ext3/inode.c
+++ b/fs/ext3/inode.c
@@ -1700,6 +1700,7 @@ static int ext3_journalled_set_page_dirt
 }
 
 static struct address_space_operations ext3_ordered_aops = {
+	.get_block	= ext3_get_block,
 	.readpage	= ext3_readpage,
 	.readpages	= ext3_readpages,
 	.writepage	= ext3_ordered_writepage,
diff --git a/fs/file_table.c b/fs/file_table.c
index bcea199..8759479 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -113,6 +113,9 @@ struct file *get_empty_filp(void)
 	if (security_file_alloc(f))
 		goto fail_sec;
 
+#ifdef CONFIG_KEVENT_POLL
+	kevent_storage_init(f, &f->st);
+#endif
 	tsk = current;
 	INIT_LIST_HEAD(&f->f_u.fu_list);
 	atomic_set(&f->f_count, 1);
@@ -160,6 +163,9 @@ void fastcall __fput(struct file *file)
 	might_sleep();
 
 	fsnotify_close(file);
+#ifdef CONFIG_KEVENT_POLL
+	kevent_storage_fini(&file->st);
+#endif
 	/*
 	 * The function eventpoll_release() should be the first called
 	 * in the file cleanup chain.
diff --git a/fs/inode.c b/fs/inode.c
index 3a2446a..0493935 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -22,6 +22,7 @@ #include <linux/pagemap.h>
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
 #include <linux/inotify.h>
+#include <linux/kevent.h>
 #include <linux/mount.h>
 
 /*
@@ -166,12 +167,18 @@ #endif
 		}
 		memset(&inode->u, 0, sizeof(inode->u));
 		inode->i_mapping = mapping;
+#if defined CONFIG_KEVENT
+		kevent_storage_init(inode, &inode->st);
+#endif
 	}
 	return inode;
 }
 
 void destroy_inode(struct inode *inode) 
 {
+#if defined CONFIG_KEVENT_INODE || defined CONFIG_KEVENT_SOCKET
+	kevent_storage_fini(&inode->st);
+#endif
 	BUG_ON(inode_has_buffers(inode));
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 9857e50..bbbb578 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2997,6 +2997,7 @@ int reiserfs_setattr(struct dentry *dent
 }
 
 struct address_space_operations reiserfs_address_space_operations = {
+	.get_block = reiserfs_get_block,
 	.writepage = reiserfs_writepage,
 	.readpage = reiserfs_readpage,
 	.readpages = reiserfs_readpages,

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ecc8c2c..248f6a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -236,6 +236,9 @@ #include <linux/mutex.h>
 #include <asm/atomic.h>
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
+#ifdef CONFIG_KEVENT
+#include <linux/kevent_storage.h>
+#endif
 
 struct hd_geometry;
 struct iovec;
@@ -348,6 +351,8 @@ struct address_space;
 struct writeback_control;
 
 struct address_space_operations {
+	int  (*get_block)(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create);
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
 	void (*sync_page)(struct page *);
@@ -526,6 +531,10 @@ #ifdef CONFIG_INOTIFY
 	struct mutex		inotify_mutex;	/* protects the watches list */
 #endif
 
+#ifdef CONFIG_KEVENT_INODE
+	struct kevent_storage	st;
+#endif
+
 	unsigned long		i_state;
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
@@ -659,6 +668,9 @@ #ifdef CONFIG_EPOLL
 	struct list_head	f_ep_links;
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
+#ifdef CONFIG_KEVENT_POLL
+	struct kevent_storage	st;
+#endif
 	struct address_space	*f_mapping;
 };
 extern spinlock_t files_lock;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index cc5dec7..0acc8db 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -15,6 +15,7 @@ #ifdef __KERNEL__
 
 #include <linux/dnotify.h>
 #include <linux/inotify.h>
+#include <linux/kevent.h>
 #include <linux/audit.h>
 
 /*
@@ -79,6 +80,7 @@ static inline void fsnotify_nameremove(s
 		isdir = IN_ISDIR;
 	dnotify_parent(dentry, DN_DELETE);
 	inotify_dentry_parent_queue_event(dentry, IN_DELETE|isdir, 0, dentry->d_name.name);
+	kevent_inode_notify_parent(dentry, KEVENT_INODE_REMOVE);
 }
 
 /*
@@ -88,6 +90,7 @@ static inline void fsnotify_inoderemove(
 {
 	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL, NULL);
 	inotify_inode_is_dead(inode);
+	kevent_inode_remove(inode);
 }
 
 /*
@@ -96,6 +99,7 @@ static inline void fsnotify_inoderemove(
 static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
 {
 	inode_dir_notify(inode, DN_CREATE);
+	kevent_inode_notify(inode, KEVENT_INODE_CREATE);
 	inotify_inode_queue_event(inode, IN_CREATE, 0, dentry->d_name.name,
 				  dentry->d_inode);
 	audit_inode_child(dentry->d_name.name, dentry->d_inode, inode->i_ino);
@@ -107,6 +111,7 @@ static inline void fsnotify_create(struc
 static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
 {
 	inode_dir_notify(inode, DN_CREATE);
+	kevent_inode_notify(inode, KEVENT_INODE_CREATE);
 	inotify_inode_queue_event(inode, IN_CREATE | IN_ISDIR, 0, 
 				  dentry->d_name.name, dentry->d_inode);
 	audit_inode_child(dentry->d_name.name, dentry->d_inode, inode->i_ino);

diff --git a/kernel/kevent/kevent_inode.c b/kernel/kevent/kevent_inode.c
new file mode 100644
index 0000000..3af0e11
--- /dev/null
+++ b/kernel/kevent/kevent_inode.c
@@ -0,0 +1,110 @@
+/*
+ * 	kevent_inode.c
+ * 
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/file.h>
+#include <linux/kevent.h>
+#include <linux/fs.h>
+
+static int kevent_inode_enqueue(struct kevent *k)
+{
+	struct file *file;
+	struct inode *inode;
+	int err, fput_needed;
+
+	file = fget_light(k->event.id.raw[0], &fput_needed);
+	if (!file)
+		return -ENODEV;
+
+	err = -EINVAL;
+	if (!file->f_dentry || !file->f_dentry->d_inode)
+		goto err_out_fput;
+	
+	inode = igrab(file->f_dentry->d_inode);
+	if (!inode)
+		goto err_out_fput;
+
+	err = kevent_storage_enqueue(&inode->st, k);
+	if (err)
+		goto err_out_iput;
+
+	fput_light(file, fput_needed);
+	return 0;
+
+err_out_iput:
+	iput(inode);
+err_out_fput:
+	fput_light(file, fput_needed);
+	return err;
+}
+
+static int kevent_inode_dequeue(struct kevent *k)
+{
+	struct inode *inode = k->st->origin;
+
+	kevent_storage_dequeue(k->st, k);
+	iput(inode);
+
+	return 0;
+}
+
+static int kevent_inode_callback(struct kevent *k)
+{
+	return 1;
+}
+
+int kevent_init_inode(struct kevent *k)
+{
+	k->enqueue = &kevent_inode_enqueue;
+	k->dequeue = &kevent_inode_dequeue;
+	k->callback = &kevent_inode_callback;
+	return 0;
+}
+
+void kevent_inode_notify_parent(struct dentry *dentry, u32 event)
+{
+	struct dentry *parent;
+	struct inode *inode;
+	
+	spin_lock(&dentry->d_lock);
+	parent = dentry->d_parent;
+	inode = parent->d_inode;
+
+	dget(parent);
+	spin_unlock(&dentry->d_lock);
+	kevent_inode_notify(inode, KEVENT_INODE_REMOVE);
+	dput(parent);
+}
+	
+void kevent_inode_remove(struct inode *inode)
+{
+	kevent_storage_fini(&inode->st);
+}
+	
+void kevent_inode_notify(struct inode *inode, u32 event)
+{
+	kevent_storage_ready(&inode->st, NULL, event);
+}
diff --git a/kernel/kevent/kevent_aio.c b/kernel/kevent/kevent_aio.c
new file mode 100644
index 0000000..d4132a3
--- /dev/null
+++ b/kernel/kevent/kevent_aio.c
@@ -0,0 +1,580 @@
+/*
+ * 	kevent_aio.c
+ * 
+ * 2006 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/swap.h>
+#include <linux/pagemap.h>
+#include <linux/bio.h>
+#include <linux/buffer_head.h>
+#include <linux/kevent.h>
+
+#include <net/sock.h>
+
+#define KEVENT_AIO_DEBUG
+
+#ifdef KEVENT_AIO_DEBUG
+#define dprintk(f, a...) printk(f, ##a)
+#else
+#define dprintk(f, a...) do {} while (0)
+#endif
+
+struct kevent_aio_private
+{
+	int			pg_num;
+	size_t			size;
+	loff_t			offset;
+	loff_t			processed;
+	atomic_t		bio_page_num;
+	struct completion	bio_complete;
+	struct file		*file, *sock;
+	struct work_struct	work;
+};
+
+static int kevent_aio_dequeue(struct kevent *k);
+static int kevent_aio_enqueue(struct kevent *k);
+static int kevent_aio_callback(struct kevent *k);
+
+extern void bio_fs_destructor(struct bio *bio);
+
+static void kevent_aio_bio_destructor(struct bio *bio)
+{
+	struct kevent *k = bio->bi_private;
+	struct kevent_aio_private *priv = k->priv;
+
+	dprintk("%s: bio=%p, num=%u, k=%p, inode=%p.\n", __func__, bio, bio->bi_vcnt, k, k->st->origin);
+	schedule_work(&priv->work);
+	bio_fs_destructor(bio);
+}
+
+static void kevent_aio_bio_put(struct kevent *k)
+{
+	struct kevent_aio_private *priv = k->priv;
+	
+	if (atomic_dec_and_test(&priv->bio_page_num))
+		complete(&priv->bio_complete);
+}
+
+static int kevent_mpage_end_io_read(struct bio *bio, unsigned int bytes_done, int err)
+{
+	const int uptodate = test_bit(BIO_UPTODATE, &bio->bi_flags);
+	struct bio_vec *bvec = bio->bi_io_vec + bio->bi_vcnt - 1;
+	struct kevent *k = bio->bi_private;
+
+	if (bio->bi_size)
+		return 1;
+
+	do {
+		struct page *page = bvec->bv_page;
+
+		if (--bvec >= bio->bi_io_vec)
+			prefetchw(&bvec->bv_page->flags);
+
+		if (uptodate) {
+			SetPageUptodate(page);
+		} else {
+			ClearPageUptodate(page);
+			SetPageError(page);
+		}
+
+		unlock_page(page);
+		kevent_aio_bio_put(k);
+	} while (bvec >= bio->bi_io_vec);
+
+	bio_put(bio);
+	return 0;
+}
+
+static inline struct bio *kevent_mpage_bio_submit(int rw, struct bio *bio)
+{
+	if (bio) {
+		bio->bi_end_io = kevent_mpage_end_io_read;
+		dprintk("%s: bio=%p, num=%u.\n", __func__, bio, bio->bi_vcnt);
+		submit_bio(READ, bio);
+	}
+	return NULL;
+}
+
+static struct bio *kevent_mpage_readpage(struct kevent *k, struct bio *bio,
+		struct page *page, unsigned nr_pages, get_block_t get_block, 
+		loff_t *offset, sector_t *last_block_in_bio)
+{
+	struct inode *inode = k->st->origin;
+	const unsigned blkbits = inode->i_blkbits;
+	const unsigned blocks_per_page = PAGE_CACHE_SIZE >> blkbits;
+	const unsigned blocksize = 1 << blkbits;
+	sector_t block_in_file;
+	sector_t last_block;
+	struct block_device *bdev = NULL;
+	unsigned first_hole = blocks_per_page;
+	unsigned page_block;
+	sector_t blocks[MAX_BUF_PER_PAGE];
+	struct buffer_head bh;
+	int fully_mapped = 1, length;
+
+	block_in_file = (*offset + blocksize - 1) >> blkbits;
+	last_block = (i_size_read(inode) + blocksize - 1) >> blkbits;
+
+	bh.b_page = page;
+	for (page_block = 0; page_block < blocks_per_page; page_block++, block_in_file++) {
+		bh.b_state = 0;
+		if (block_in_file < last_block) {
+			if (get_block(inode, block_in_file, &bh, 0))
+				goto confused;
+		}
+
+		if (!buffer_mapped(&bh)) {
+			fully_mapped = 0;
+			if (first_hole == blocks_per_page)
+				first_hole = page_block;
+			continue;
+		}
+
+		/* some filesystems will copy data into the page during
+		 * the get_block call, in which case we don't want to
+		 * read it again.  map_buffer_to_page copies the data
+		 * we just collected from get_block into the page's buffers
+		 * so readpage doesn't have to repeat the get_block call
+		 */
+		if (buffer_uptodate(&bh)) {
+			BUG();
+			//map_buffer_to_page(page, &bh, page_block);
+			goto confused;
+		}
+	
+		if (first_hole != blocks_per_page)
+			goto confused;		/* hole -> non-hole */
+
+		/* Contiguous blocks? */
+		if (page_block && blocks[page_block-1] != bh.b_blocknr-1)
+			goto confused;
+		blocks[page_block] = bh.b_blocknr;
+		bdev = bh.b_bdev;
+	}
+
+	if (!bdev)
+		goto confused;
+
+	if (first_hole != blocks_per_page) {
+		char *kaddr = kmap_atomic(page, KM_USER0);
+		memset(kaddr + (first_hole << blkbits), 0,
+				PAGE_CACHE_SIZE - (first_hole << blkbits));
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr, KM_USER0);
+		if (first_hole == 0) {
+			SetPageUptodate(page);
+			goto out;
+		}
+	} else if (fully_mapped) {
+		SetPageMappedToDisk(page);
+	}
+	
+	/*
+	 * This page will go to BIO.  Do we need to send this BIO off first?
+	 */
+	if (bio && (*last_block_in_bio != blocks[0] - 1))
+		bio = kevent_mpage_bio_submit(READ, bio);
+
+alloc_new:
+	if (bio == NULL) {
+		nr_pages = min_t(unsigned, nr_pages, bio_get_nr_vecs(bdev));
+		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		if (bio == NULL)
+			goto confused;
+
+		bio->bi_destructor = kevent_aio_bio_destructor;
+		bio->bi_bdev = bdev;
+		bio->bi_sector = blocks[0] << (blkbits - 9);
+		bio->bi_private = k;
+	}
+
+	length = first_hole << blkbits;
+	if (bio_add_page(bio, page, length, 0) < length) {
+		bio = kevent_mpage_bio_submit(READ, bio);
+		dprintk("%s: Failed to add a page: nr_pages=%d, length=%d, page=%p.\n", 
+				__func__, nr_pages, length, page);
+		goto alloc_new;
+	}
+	
+	dprintk("%s: bio=%p, b=%d, m=%d, u=%d, nr_pages=%d, offset=%Lu, "
+			"size=%Lu. page_block=%u, page=%p.\n", 
+			__func__, bio, buffer_boundary(&bh), buffer_mapped(&bh), 
+			buffer_uptodate(&bh), nr_pages, *offset, i_size_read(inode), 
+			page_block, page);
+	
+	*offset = *offset + length;
+
+	if (buffer_boundary(&bh) || (first_hole != blocks_per_page))
+		bio = kevent_mpage_bio_submit(READ, bio);
+	else
+		*last_block_in_bio = blocks[blocks_per_page - 1];
+
+out:
+	return bio;
+
+confused:
+	dprintk("%s: confused. bio=%p, nr_pages=%d.\n", __func__, bio, nr_pages);
+	if (bio)
+		bio = kevent_mpage_bio_submit(READ, bio);
+	kevent_aio_bio_put(k);
+	SetPageUptodate(page);
+
+	if (nr_pages == 1) {
+		struct kevent_aio_private *priv = k->priv;
+
+		wait_for_completion(&priv->bio_complete);
+		kevent_storage_ready(k->st, NULL, KEVENT_AIO_BIO);
+		init_completion(&priv->bio_complete);
+		complete(&priv->bio_complete);
+	}
+	goto out;
+}
+
+static int kevent_aio_alloc_cached_page(struct kevent *k, struct page **cached_page)
+{
+	struct kevent_aio_private *priv = k->priv;
+	struct address_space *mapping = priv->file->f_mapping;
+	struct page *page;
+	int err = 0;
+	pgoff_t index = priv->offset >> PAGE_CACHE_SHIFT;
+
+	page = page_cache_alloc_cold(mapping);
+	if (!page) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = add_to_page_cache_lru(page, mapping, index, GFP_KERNEL);
+	if (err) {
+		if (err == -EEXIST)
+			err = 0;
+		page_cache_release(page);
+		goto out;
+	}
+
+	dprintk("%s: page=%p, offset=%Lu, processed=%Lu, index=%lu, size=%zu.\n",
+			__func__, page, priv->offset, priv->processed, index, priv->size);
+
+	*cached_page = page;
+
+out:
+	return err;
+}
+
+static int kevent_mpage_readpages(struct kevent *k, int first,
+		int (* get_block)(struct inode *inode, sector_t iblock,	
+			struct buffer_head *bh_result, int create))
+{
+	struct bio *bio = NULL;
+	struct kevent_aio_private *priv = k->priv;
+	sector_t last_block_in_bio = 0;
+	int i, err = 0;
+
+	atomic_set(&priv->bio_page_num, priv->pg_num);
+
+	for (i=first; i<priv->pg_num; ++i) {
+		struct page *page;
+		
+		err = kevent_aio_alloc_cached_page(k, &page);
+		if (err)
+			break;
+
+		/*
+		 * If there is no error and page is NULL, this means
+		 * that someone added a page into VFS cache.
+		 * We will not process this page, since it is that who
+		 * added a page must read data from disk.
+		 */
+		if (!page)
+			continue;
+
+		bio = kevent_mpage_readpage(k, bio, page, priv->pg_num - i, 
+				get_block, &priv->offset, &last_block_in_bio);
+	}
+
+	if (bio)
+		bio = kevent_mpage_bio_submit(READ, bio);
+
+	return err;
+}
+
+static size_t kevent_aio_vfs_read_actor(struct kevent *k, struct page *kpage, size_t len)
+{
+	struct kevent_aio_private *priv = k->priv;
+	size_t ret;
+	
+	ret = priv->sock->f_op->sendpage(priv->sock, kpage, 0, len, &priv->sock->f_pos, 1);
+
+	dprintk("%s: k=%p, page=%p, len=%zu, ret=%zd.\n", 
+			__func__, k, kpage, len, ret);
+
+	return ret;
+}
+
+static int kevent_aio_vfs_read(struct kevent *k, 
+		size_t (*actor)(struct kevent *, struct page *, size_t))
+{
+	struct kevent_aio_private *priv = k->priv;
+	struct address_space *mapping;
+	size_t isize, actor_size;
+	int i;
+
+	mapping = priv->file->f_mapping;
+	isize = i_size_read(priv->file->f_dentry->d_inode);
+	
+	dprintk("%s: start: size_left=%zd, offset=%Lu, processed=%Lu, isize=%zu, pg_num=%d.\n", 
+			__func__, priv->size, priv->offset, priv->processed, isize, priv->pg_num);
+
+	for (i=0; i<priv->pg_num && priv->size; ++i) {
+		struct page *page;
+		size_t nr = PAGE_CACHE_SIZE;
+
+		cond_resched();
+		page = find_get_page(mapping, priv->processed >> PAGE_CACHE_SHIFT);
+		if (unlikely(page == NULL))
+			break;
+		if (!PageUptodate(page)) {
+			dprintk("%s: %2d: page=%p, processed=%Lu, size=%zu not uptodate.\n", 
+					__func__, i, page, priv->processed, priv->size);
+			page_cache_release(page);
+			break;
+		}
+
+		if (mapping_writably_mapped(mapping))
+			flush_dcache_page(page);
+
+		mark_page_accessed(page);
+
+		if (nr + priv->processed > isize)
+			nr = isize - priv->processed;
+		if (nr > priv->size)
+			nr = priv->size;
+
+		actor_size = actor(k, page, nr);
+		if (actor_size < 0) {
+			page_cache_release(page);
+			break;
+		}
+
+		page_cache_release(page);
+
+		priv->processed += actor_size;
+		priv->size -= actor_size;
+	}
+
+	if (!priv->size)
+		i = priv->pg_num;
+
+	if (i != priv->pg_num)
+		priv->offset = priv->processed;
+
+	dprintk("%s: end: next=%d, num=%d, left=%zu, offset=%Lu, procesed=%Lu, ret=%d.\n", 
+			__func__, i, priv->pg_num, 
+			priv->size, priv->offset, priv->processed, i);
+
+	return i;
+}
+
+static int kevent_aio_callback(struct kevent *k)
+{
+	return 1;
+}
+
+static void kevent_aio_work(void *data)
+{
+	struct kevent *k = data;
+	struct kevent_aio_private *priv = k->priv;
+	struct inode *inode = k->st->origin;
+	struct address_space *mapping = priv->file->f_mapping;
+	int err, ready = 0, num;
+
+	dprintk("%s: k=%p, priv=%p, inode=%p.\n", __func__, k, priv, inode);
+
+	init_completion(&priv->bio_complete);
+	
+	num = ready = kevent_aio_vfs_read(k, &kevent_aio_vfs_read_actor);
+	if (ready > 0 && ready != priv->pg_num)
+		ready = 0;
+
+	dprintk("%s: k=%p, ready=%d, size=%zd.\n", __func__, k, ready, priv->size);
+
+	if (!ready) {
+		err = kevent_mpage_readpages(k, num, mapping->a_ops->get_block);
+		if (err) {
+			dprintk("%s: kevent_mpage_readpages failed: err=%d, k=%p, size=%zd.\n",
+					__func__, err, k, priv->size);
+			kevent_break(k);
+			kevent_storage_ready(k->st, NULL, KEVENT_MASK_ALL);
+		}
+	} else {
+		dprintk("%s: next k=%p, size=%zd.\n", __func__, k, priv->size);
+
+		if (priv->size)
+			schedule_work(&priv->work);
+		else {
+			kevent_storage_ready(k->st, NULL, KEVENT_MASK_ALL);
+		}
+
+		complete(&priv->bio_complete);
+	}
+}
+
+static int kevent_aio_enqueue(struct kevent *k)
+{
+	int err;
+	struct file *file, *sock;
+	struct inode *inode;
+	struct kevent_aio_private *priv;
+	struct address_space *mapping;
+	int fd = k->event.id.raw[0];
+	int num = k->event.id.raw[1];
+	int s = k->event.ret_data[0];
+	size_t size;
+
+	err = -ENODEV;
+	file = fget(fd);
+	if (!file)
+		goto err_out_exit;
+	
+	sock = fget(s);
+	if (!sock)
+		goto err_out_fput_file;
+	
+	mapping = file->f_mapping;
+
+	err = -EINVAL;
+	if (!file->f_dentry || !file->f_dentry->d_inode || !mapping->a_ops->get_block)
+		goto err_out_fput;
+	if (!sock->f_dentry || !sock->f_dentry->d_inode)
+		goto err_out_fput;
+
+	inode = igrab(file->f_dentry->d_inode);
+	if (!inode)
+		goto err_out_fput;
+
+	size = i_size_read(inode);
+	
+	num = (size > num << PAGE_SHIFT) ? num : (size >> PAGE_SHIFT);
+
+	err = -ENOMEM;
+	priv = kzalloc(sizeof(struct kevent_aio_private), GFP_KERNEL);
+	if (!priv)
+		goto err_out_iput;
+
+	priv->pg_num = num;
+	priv->size = size;
+	priv->offset = 0;
+	priv->file = file;
+	priv->sock = sock;
+	INIT_WORK(&priv->work, kevent_aio_work, k);
+	k->priv = priv;
+
+	dprintk("%s: read: k=%p, priv=%p, inode=%p, num=%u, size=%zu, off=%Lu.\n", 
+			__func__, k, priv, inode, priv->pg_num, priv->size, priv->offset);
+	
+	init_completion(&priv->bio_complete);
+	kevent_storage_enqueue(&inode->st, k);
+	schedule_work(&priv->work);
+	
+	return 0;
+
+err_out_iput:
+	iput(inode);
+err_out_fput:
+	fput(sock);
+err_out_fput_file:
+	fput(file);
+err_out_exit:
+
+	return err;
+}
+
+static int kevent_aio_dequeue(struct kevent *k)
+{
+	struct kevent_aio_private *priv = k->priv;
+	struct inode *inode = k->st->origin;
+	struct file *file = priv->file;
+	struct file *sock = priv->sock;
+
+	kevent_storage_dequeue(k->st, k);
+	flush_scheduled_work();
+	wait_for_completion(&priv->bio_complete);
+
+	kfree(k->priv);
+	k->priv = NULL;
+	iput(inode);
+	fput(file);
+	fput(sock);
+
+	return 0;
+}
+
+asmlinkage long sys_aio_sendfile(int ctl_fd, int fd, int s, 
+		size_t size, unsigned flags)
+{
+	struct ukevent ukread, uksend;
+	struct kevent_user *u;
+	struct file *file;
+	int err, fput_needed;
+	int num = (flags & 7)?(flags & 7):8;
+
+	memset(&ukread, 0, sizeof(struct ukevent));
+	memset(&uksend, 0, sizeof(struct ukevent));
+
+	ukread.type = KEVENT_AIO;
+	ukread.event = KEVENT_AIO_BIO;
+
+	ukread.id.raw[0] = fd;
+	ukread.id.raw[1] = num;
+	ukread.ret_data[0] = s;
+
+	dprintk("%s: fd=%d, s=%d, num=%d.\n", __func__, fd, s, num);
+
+	file = fget_light(ctl_fd, &fput_needed);
+	if (!file)
+		return -ENODEV;
+
+	u = file->private_data;
+	if (!u) {
+		err = -EINVAL;
+		goto err_out_fput;
+	}
+
+	err = kevent_user_add_ukevent(&ukread, u);
+	if (err < 0)
+		goto err_out_fput;
+
+err_out_fput:
+	fput_light(file, fput_needed);
+	return err;
+}
+
+int kevent_init_aio(struct kevent *k)
+{
+	k->enqueue = &kevent_aio_enqueue;
+	k->dequeue = &kevent_aio_dequeue;
+	k->callback = &kevent_aio_callback;
+	return 0;
+}

