Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVDTGzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVDTGzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 02:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDTGzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 02:55:39 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:30668 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261382AbVDTGy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 02:54:58 -0400
Date: Wed, 20 Apr 2005 08:55:00 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove some usesless casts
Message-ID: <20050420065500.GA24213@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Squashfs is extremely cast-happy.  This patch makes it less so.

Jörn

-- 
If you're willing to restrict the flexibility of your approach,
you can almost always do something better.
-- John Carmack


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/squashfs/inode.c |   63 ++++++++++++++++++++++------------------------------
 1 files changed, 27 insertions(+), 36 deletions(-)

--- linux-2.6.12-rc2cow/fs/squashfs/inode.c~squashfs_cu1	2005-04-20 07:52:46.000000000 +0200
+++ linux-2.6.12-rc2cow/fs/squashfs/inode.c	2005-04-20 08:11:10.254367656 +0200
@@ -111,7 +111,7 @@ struct inode_operations squashfs_dir_ino
 static struct buffer_head *get_block_length(struct super_block *s,
 				int *cur_index, int *offset, int *c_byte)
 {
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 	unsigned short temp;
 	struct buffer_head *bh;
 
@@ -176,7 +176,7 @@ unsigned int squashfs_read_data(struct s
 			unsigned int index, unsigned int length,
 			unsigned int *next_index)
 {
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 	struct buffer_head *bh[((SQUASHFS_FILE_MAX_SIZE - 1) >>
 			msBlk->devblksize_log2) + 2];
 	unsigned int offset = index & ((1 << msBlk->devblksize_log2) - 1);
@@ -285,7 +285,7 @@ int squashfs_get_cached_block(struct sup
 				int length, unsigned int *next_block,
 				unsigned int *next_offset)
 {
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 	int n, i, bytes, return_length = length;
 	unsigned int next_index;
 
@@ -390,7 +390,7 @@ static int get_fragment_location(struct 
 				unsigned int *fragment_start_block,
 				unsigned int *fragment_size)
 {
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 	unsigned int start_block =
 		msBlk->fragment_index[SQUASHFS_FRAGMENT_INDEX(fragment)];
 	int offset = SQUASHFS_FRAGMENT_INDEX_OFFSET(fragment);
@@ -434,7 +434,7 @@ static struct squashfs_fragment_cache *g
 					int length)
 {
 	int i, n;
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 
 	for (;;) {
 		down(&msBlk->fragment_mutex);
@@ -466,8 +466,7 @@ static struct squashfs_fragment_cache *g
 				SQUASHFS_CACHED_FRAGMENTS;
 			
 			if (msBlk->fragment[i].data == NULL)
-				if (!(msBlk->fragment[i].data =
-						(unsigned char *) kmalloc
+				if (!(msBlk->fragment[i].data = kmalloc
 						(SQUASHFS_FILE_MAX_SIZE,
 						 GFP_KERNEL))) {
 					ERROR("Failed to allocate fragment "
@@ -509,7 +508,7 @@ static struct squashfs_fragment_cache *g
 static struct inode *squashfs_new_inode(struct super_block *s,
 		squashfs_base_inode_header *inodeb, unsigned int ino)
 {
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	struct inode *i = new_inode(s);
 
@@ -535,7 +534,7 @@ static struct inode *squashfs_new_inode(
 static struct inode *squashfs_iget(struct super_block *s, squashfs_inode inode)
 {
 	struct inode *i;
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	unsigned int block = SQUASHFS_INODE_BLK(inode) +
 		sBlk->inode_table_start;
@@ -837,13 +836,12 @@ static int squashfs_fill_super(struct su
 
 	TRACE("Entered squashfs_read_superblock\n");
 
-	if (!(s->s_fs_info = (void *) kmalloc(sizeof(squashfs_sb_info),
-						GFP_KERNEL))) {
+	if (!(s->s_fs_info = kmalloc(sizeof(squashfs_sb_info), GFP_KERNEL))) {
 		ERROR("Failed to allocate superblock\n");
 		return -ENOMEM;
 	}
 	memset(s->s_fs_info, 0, sizeof(squashfs_sb_info));
-	msBlk = (squashfs_sb_info *) s->s_fs_info;
+	msBlk = s->s_fs_info;
 	sBlk = &msBlk->sBlk;
 	
 	msBlk->devblksize = sb_min_blocksize(s, BLOCK_SIZE);
@@ -914,8 +912,7 @@ static int squashfs_fill_super(struct su
 	s->s_op = &squashfs_ops;
 
 	/* Init inode_table block pointer array */
-	if (!(msBlk->block_cache = (squashfs_cache *)
-					kmalloc(sizeof(squashfs_cache) *
+	if (!(msBlk->block_cache = kmalloc(sizeof(squashfs_cache) *
 					SQUASHFS_CACHED_BLKS, GFP_KERNEL))) {
 		ERROR("Failed to allocate block cache\n");
 		goto failed_mount;
@@ -931,15 +928,14 @@ static int squashfs_fill_super(struct su
 					SQUASHFS_METADATA_SIZE :
 					sBlk->block_size;
 
-	if (!(msBlk->read_data = (char *) kmalloc(msBlk->read_size,
-					GFP_KERNEL))) {
+	if (!(msBlk->read_data = kmalloc(msBlk->read_size, GFP_KERNEL))) {
 		ERROR("Failed to allocate read_data block\n");
 		goto failed_mount;
 	}
 
 	/* Allocate read_page block */
 	if (sBlk->block_size > PAGE_CACHE_SIZE) {
-		if (!(msBlk->read_page = (char *) kmalloc(sBlk->block_size,
+		if (!(msBlk->read_page = kmalloc(sBlk->block_size,
 					GFP_KERNEL))) {
 			ERROR("Failed to allocate read_page block\n");
 			goto failed_mount;
@@ -948,7 +944,7 @@ static int squashfs_fill_super(struct su
 		msBlk->read_page = NULL;
 
 	/* Allocate uid and gid tables */
-	if (!(msBlk->uid = (squashfs_uid *) kmalloc((sBlk->no_uids +
+	if (!(msBlk->uid = kmalloc((sBlk->no_uids +
 					sBlk->no_guids) * sizeof(squashfs_uid),
 					GFP_KERNEL))) {
 		ERROR("Failed to allocate uid/gid table\n");
@@ -982,9 +978,7 @@ static int squashfs_fill_super(struct su
 	if (sBlk->s_major == 1 && squashfs_1_0_supported(msBlk))
 		goto allocate_root;
 
-	if (!(msBlk->fragment = (struct squashfs_fragment_cache *)
-					kmalloc(sizeof(struct
-					squashfs_fragment_cache) *
+	if (!(msBlk->fragment = kmalloc(sizeof(struct squashfs_fragment_cache) *
 					SQUASHFS_CACHED_FRAGMENTS,
 					GFP_KERNEL))) {
 		ERROR("Failed to allocate fragment block cache\n");
@@ -1000,8 +994,7 @@ static int squashfs_fill_super(struct su
 	msBlk->next_fragment = 0;
 
 	/* Allocate fragment index table */
-	if (!(msBlk->fragment_index = (squashfs_fragment_index *)
-					kmalloc(SQUASHFS_FRAGMENT_INDEX_BYTES
+	if (!(msBlk->fragment_index = kmalloc(SQUASHFS_FRAGMENT_INDEX_BYTES
 					(sBlk->fragments), GFP_KERNEL))) {
 		ERROR("Failed to allocate uid/gid table\n");
 		goto failed_mount;
@@ -1127,7 +1120,7 @@ static unsigned int read_blocklist(struc
 				int readahead_blks, char *block_list,
 				unsigned short **block_p, unsigned int *bsize)
 {
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)inode->i_sb->s_fs_info;
+	squashfs_sb_info *msBlk = inode->i_sb->s_fs_info;
 	unsigned int *block_listp;
 	int i = 0;
 	int block_ptr = SQUASHFS_I(inode)->block_list_start;
@@ -1182,7 +1175,7 @@ static unsigned int read_blocklist(struc
 static int squashfs_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)inode->i_sb->s_fs_info;
+	squashfs_sb_info *msBlk = inode->i_sb->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	unsigned char block_list[SIZE];
 	unsigned int bsize, block, i = 0, bytes = 0, byte_offset = 0;
@@ -1297,7 +1290,7 @@ skip_read:
 static int squashfs_readpage4K(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)inode->i_sb->s_fs_info;
+	squashfs_sb_info *msBlk = inode->i_sb->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	unsigned char block_list[SIZE];
 	unsigned int bsize, block, bytes = 0;
@@ -1359,7 +1352,7 @@ static int get_dir_index_using_offset(st
 				unsigned int index_offset, int i_count,
 				long long f_pos)
 {
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	int i, length = 0;
 	squashfs_dir_index index;
@@ -1406,7 +1399,7 @@ static int get_dir_index_using_name(stru
 				unsigned int index_offset, int i_count,
 				const char *name, int size)
 {
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)s->s_fs_info;
+	squashfs_sb_info *msBlk = s->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	int i, length = 0;
 	char buffer[sizeof(squashfs_dir_index) + SQUASHFS_NAME_LEN + 1];
@@ -1453,7 +1446,7 @@ static int get_dir_index_using_name(stru
 static int squashfs_readdir(struct file *file, void *dirent, filldir_t filldir)
 {
 	struct inode *i = file->f_dentry->d_inode;
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)i->i_sb->s_fs_info;
+	squashfs_sb_info *msBlk = i->i_sb->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	int next_block = SQUASHFS_I(i)->start_block +
 		sBlk->directory_table_start,
@@ -1562,7 +1555,7 @@ static struct dentry *squashfs_lookup(st
 	const unsigned char *name = dentry->d_name.name;
 	int len = dentry->d_name.len;
 	struct inode *inode = NULL;
-	squashfs_sb_info *msBlk = (squashfs_sb_info *)i->i_sb->s_fs_info;
+	squashfs_sb_info *msBlk = i->i_sb->s_fs_info;
 	squashfs_super_block *sBlk = &msBlk->sBlk;
 	int next_block = SQUASHFS_I(i)->start_block +
 				sBlk->directory_table_start,
@@ -1666,7 +1659,7 @@ static void squashfs_put_super(struct su
 	int i;
 
 	if (s->s_fs_info) {
-		squashfs_sb_info *sbi = (squashfs_sb_info *) s->s_fs_info;
+		squashfs_sb_info *sbi = s->s_fs_info;
 		if (sbi->block_cache)
 			for (i = 0; i < SQUASHFS_CACHED_BLKS; i++)
 				if (sbi->block_cache[i].block !=
@@ -1703,8 +1696,7 @@ static int __init init_squashfs_fs(void)
 	printk(KERN_INFO "squashfs: version 2.1 (2005/03/14) "
 		"Phillip Lougher\n");
 
-	if (!(stream.workspace = (char *)
-				vmalloc(zlib_inflate_workspacesize()))) {
+	if (!(stream.workspace = vmalloc(zlib_inflate_workspacesize()))) {
 		ERROR("Failed to allocate zlib workspace\n");
 		destroy_inodecache();
 		return -ENOMEM;
@@ -1733,8 +1725,7 @@ static kmem_cache_t * squashfs_inode_cac
 static struct inode *squashfs_alloc_inode(struct super_block *sb)
 {
 	struct squashfs_inode_info *ei;
-	ei = (struct squashfs_inode_info *)
-		kmem_cache_alloc(squashfs_inode_cachep, SLAB_KERNEL);
+	ei = kmem_cache_alloc(squashfs_inode_cachep, SLAB_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
@@ -1749,7 +1740,7 @@ static void squashfs_destroy_inode(struc
 
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
-	struct squashfs_inode_info *ei = (struct squashfs_inode_info *) foo;
+	struct squashfs_inode_info *ei = foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 							SLAB_CTOR_CONSTRUCTOR)
