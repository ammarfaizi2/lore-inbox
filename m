Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUEVWsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUEVWsa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 18:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUEVWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 18:48:29 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:20432 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S261951AbUEVWqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 18:46:33 -0400
Message-ID: <40AFD82D.1000805@serice.net>
Date: Sat, 22 May 2004 17:46:05 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs meta-data beyond 4GB
References: <40ACC004.8080308@serice.net> <20040522142851.GA18121@sirius.home>
In-Reply-To: <20040522142851.GA18121@sirius.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Why use a spinlock here?  The filesystem code is always called in a
 > process context, therefore a semaphore is much more appropriate than
 > a spinlock.  BTW, your code allocates memory with SLAB_KERNEL while
 > holding a spinlock, which is wrong; the check for allocation failure
 > is also missing.

Thanks!  I'm attaching a full patch with your recommended changes.



 > Also there are other, more serious problems with your approach:
 >
 > - The inode map can consume a lot of memory, which is never released
 >   until unmount.  Someone could prepare a disk full of zero-length
 >   files and run "find" on it to crash the machine.

I did consider this.  I'm not sure my reasoning is correct, but
because mount is a privileged operation I thought I might have some
leeway.



 > - Inode numbers for the same disk become not stable across mounts
 >   (can be annoying if automounters are used).

I thought about this for a while too, but unlike you, I wasn't smart
enough to think of anything that would break.

I'm convinced to try for a better solution.



 > However, the 4GB limit problem really needs to be solved.  Here is
 > another idea (sorry, no patch yet): instead of the byte offset of
 > the directory entry, use its sector number and index in the sector.
 > isofs_read_inode() then would need to read the sector and skip the
 > specified number of directory entries to find the needed one.
 >
 > The minimum possible size of an ISO9660 directory entry is 34 bytes
 > (33 bytes for struct iso_directory_record, 1 byte for file name).
 > Therefore there cannot be more than 60 directory entries in a single
 > CD-ROM sector (2048 bytes), so the number of a directory entry in the
 > sector can fit into 6 bits.  With 32-bit inode numbers this leaves 26
 > bits for the sector number, which is enough for up to 128GB.

That's clever.  I think I can get this done quickly (if you haven't
already started).


Paul Serice


diff -X dontdiff -uprN linux-2.6.6/fs/isofs/dir.c linux-2.6.6-isofs/fs/isofs/dir.c
--- linux-2.6.6/fs/isofs/dir.c	2004-04-03 21:37:59.000000000 -0600
+++ linux-2.6.6-isofs/fs/isofs/dir.c	2004-05-19 08:24:27.698680016 -0500
@@ -115,6 +115,7 @@ static int do_isofs_readdir(struct inode
  	char *p = NULL;		/* Quiet GCC */
  	struct iso_directory_record *de;
  	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
+	struct isofs_inode_map *inode_map = &sbi->s_inode_map;

  	offset = filp->f_pos & (bufsize - 1);
  	block = filp->f_pos >> bufbits;
@@ -129,8 +130,17 @@ static int do_isofs_readdir(struct inode
  		}

  		de = (struct iso_directory_record *) (bh->b_data + offset);
-		if (first_de)
-			inode_number = (bh->b_blocknr << bufbits) + offset;
+		if (first_de) {
+			inode_number =
+				isofs_inode_map_index_by_phy(inode_map,
+							     bh->b_blocknr,
+							     offset);
+			if (inode_number == 0) {
+				printk(KERN_ERR "iso9660: Unable to index "
+				       "inode!\n");
+				return 0;
+			}
+		}

  		de_len = *(unsigned char *) de;

diff -X dontdiff -uprN linux-2.6.6/fs/isofs/inode.c linux-2.6.6-isofs/fs/isofs/inode.c
--- linux-2.6.6/fs/isofs/inode.c	2004-05-19 07:55:33.751280088 -0500
+++ linux-2.6.6-isofs/fs/isofs/inode.c	2004-05-20 05:53:38.565996600 -0500
@@ -7,6 +7,7 @@
   *      1995  Mark Dobie - allow mounting of some weird VideoCDs and PhotoCDs.
   *	1997  Gordon Chaffee - Joliet CDs
   *	1998  Eric Lammerts - ISO 9660 Level 3
+ *      2004  Paul Serice - Comprehensive Inode Scheme
   */

  #include <linux/config.h>
@@ -585,6 +586,7 @@ static int isofs_fill_super(struct super
  		return -ENOMEM;
  	s->s_fs_info = sbi;
  	memset(sbi, 0, sizeof(struct isofs_sb_info));
+	isofs_inode_map_init(&sbi->s_inode_map);

  	if (!parse_options((char *) data, &opt))
  		goto out_freesbi;
@@ -738,19 +740,18 @@ root_found:
  	/* Set this for reference. Its not currently used except on write
  	   which we don't have .. */
  	
-	/* RDE: data zone now byte offset! */
-
-	first_data_zone = ((isonum_733 (rootp->extent) +
-			  isonum_711 (rootp->ext_attr_length))
-			 << sbi->s_log_zone_size);
+	first_data_zone = isonum_733 (rootp->extent) +
+	                  isonum_711 (rootp->ext_attr_length);
  	sbi->s_firstdatazone = first_data_zone;
+	isofs_inode_map_set_root_inode(&sbi->s_inode_map,
+				       /* block */ sbi->s_firstdatazone,
+				       /* offset */ 0);
  #ifndef BEQUIET
  	printk(KERN_DEBUG "Max size:%ld   Log zone size:%ld\n",
  	       sbi->s_max_size,
  	       1UL << sbi->s_log_zone_size);
  	printk(KERN_DEBUG "First datazone:%ld   Root inode number:%ld\n",
-	       sbi->s_firstdatazone >> sbi->s_log_zone_size,
-	       sbi->s_firstdatazone);
+	       sbi->s_firstdatazone, 1);
  	if(sbi->s_high_sierra)
  		printk(KERN_DEBUG "Disc in High Sierra format.\n");
  #endif
@@ -767,9 +768,8 @@ root_found:
  		pri = (struct iso_primary_descriptor *) sec;
  		rootp = (struct iso_directory_record *)
  			pri->root_directory_record;
-		first_data_zone = ((isonum_733 (rootp->extent) +
-			  	isonum_711 (rootp->ext_attr_length))
-				 << sbi->s_log_zone_size);
+		first_data_zone = isonum_733 (rootp->extent) +
+		                  isonum_711 (rootp->ext_attr_length);
  	}

  	/*
@@ -835,7 +835,7 @@ root_found:
  	 * the s_rock flag. Once we have the final s_rock value,
  	 * we then decide whether to use the Joliet descriptor.
  	 */
-	inode = iget(s, sbi->s_firstdatazone);
+	inode = iget(s, 1);

  	/*
  	 * If this disk has both Rock Ridge and Joliet on it, then we
@@ -853,8 +853,11 @@ root_found:
  			sbi->s_firstdatazone = first_data_zone;
  			printk(KERN_DEBUG
  				"ISOFS: changing to secondary root\n");
+			isofs_inode_map_set_root_inode(&sbi->s_inode_map,
+				       /* block */ sbi->s_firstdatazone,
+				       /* offset */ 0);
  			iput(inode);
-			inode = iget(s, sbi->s_firstdatazone);
+			inode = iget(s, 1);
  		}
  	}

@@ -1044,7 +1047,7 @@ static int isofs_get_block(struct inode
  	return isofs_get_blocks(inode, iblock, &bh_result, 1) ? 0 : -EIO;
  }

-static int isofs_bmap(struct inode *inode, int block)
+static int isofs_bmap(struct inode *inode, sector_t block)
  {
  	struct buffer_head dummy;
  	int error;
@@ -1097,22 +1100,31 @@ static inline void test_and_set_gid(gid_

  static int isofs_read_level3_size(struct inode * inode)
  {
-	unsigned long f_pos = inode->i_ino;
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	int high_sierra = ISOFS_SB(inode->i_sb)->s_high_sierra;
+	struct isofs_sb_info* sbi = ISOFS_SB(inode->i_sb);
+	int high_sierra = sbi->s_high_sierra;
  	struct buffer_head * bh = NULL;
-	unsigned long block, offset;
+	unsigned long block, offset, block_offset;
  	int i = 0;
  	int more_entries = 0;
  	struct iso_directory_record * tmpde = NULL;
  	struct iso_inode_info *ei = ISOFS_I(inode);
+	struct isofs_inode_map *map = &sbi->s_inode_map;
+	struct isofs_inode_map_node *map_node;
+
+	/* Map the inode number to its block and offset. */
+	map_node = isofs_inode_map_find_by_ino(map, inode->i_ino);
+	if (map_node == NULL) {
+		printk(KERN_ERR "iso9660: Internal Error: Unable to find "
+			"inode (%lu) in map.\n", inode->i_ino);
+		return 0;
+	}
+	block = map_node->block;
+	offset = map_node->block_offset;

  	inode->i_size = 0;
  	ei->i_next_section_ino = 0;

-	block = f_pos >> ISOFS_BUFFER_BITS(inode);
-	offset = f_pos & (bufsize-1);
-
  	do {
  		struct iso_directory_record * de;
  		unsigned int de_len;
@@ -1128,12 +1140,12 @@ static int isofs_read_level3_size(struct
  		if (de_len == 0) {
  			brelse(bh);
  			bh = NULL;
-			f_pos = (f_pos + ISOFS_BLOCK_SIZE) & ~(ISOFS_BLOCK_SIZE - 1);
-			block = f_pos >> ISOFS_BUFFER_BITS(inode);
+			++block;
  			offset = 0;
  			continue;
  		}

+		block_offset = offset;
  		offset += de_len;

  		/* Make sure we have a full directory entry */
@@ -1159,12 +1171,15 @@ static int isofs_read_level3_size(struct
  		}

  		inode->i_size += isonum_733(de->size);
-		if (i == 1)
-			ei->i_next_section_ino = f_pos;
+		if (i == 1) {
+			ei->i_next_section_ino =
+				isofs_inode_map_index_by_phy(map,
+							     block,
+							     block_offset);
+		}

  		more_entries = de->flags[-high_sierra] & 0x80;

-		f_pos += de_len;
  		i++;
  		if(i > 100)
  			goto out_toomany;
@@ -1190,8 +1205,8 @@ out_noread:
  out_toomany:
  	printk(KERN_INFO "isofs_read_level3_size: "
  		"More than 100 file sections ?!?, aborting...\n"
-	  	"isofs_read_level3_size: inode=%lu ino=%lu\n",
-		inode->i_ino, f_pos);
+	  	"isofs_read_level3_size: inode=%lu\n",
+		inode->i_ino);
  	goto out;
  }

@@ -1200,7 +1215,7 @@ static void isofs_read_inode(struct inod
  	struct super_block *sb = inode->i_sb;
  	struct isofs_sb_info *sbi = ISOFS_SB(sb);
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	int block = inode->i_ino >> ISOFS_BUFFER_BITS(inode);
+	sector_t block;
  	int high_sierra = sbi->s_high_sierra;
  	struct buffer_head * bh = NULL;
  	struct iso_directory_record * de;
@@ -1209,12 +1224,21 @@ static void isofs_read_inode(struct inod
  	unsigned long offset;
  	int volume_seq_no, i;
  	struct iso_inode_info *ei = ISOFS_I(inode);
+	struct isofs_inode_map *map = &sbi->s_inode_map;
+	struct isofs_inode_map_node *map_node;
+
+	/* Map the inode number to its block and offset. */
+	map_node = isofs_inode_map_find_by_ino(map, inode->i_ino);
+	if (map_node == NULL) {
+		goto fail;
+	}
+	block = map_node->block;
+	offset = map_node->block_offset;

  	bh = sb_bread(inode->i_sb, block);
  	if (!bh)
  		goto out_badread;

-	offset = (inode->i_ino & (bufsize - 1));
  	de = (struct iso_directory_record *) (bh->b_data + offset);
  	de_len = *(unsigned char *) de;

@@ -1424,11 +1448,17 @@ static struct super_block *isofs_get_sb(
  	return get_sb_bdev(fs_type, flags, dev_name, data, isofs_fill_super);
  }

+static void isofs_kill_sb(struct super_block *sb)
+{
+	isofs_inode_map_destroy(&ISOFS_SB(sb)->s_inode_map);
+	kill_block_super(sb);
+}
+
  static struct file_system_type iso9660_fs_type = {
  	.owner		= THIS_MODULE,
  	.name		= "iso9660",
  	.get_sb		= isofs_get_sb,
-	.kill_sb	= kill_block_super,
+	.kill_sb	= isofs_kill_sb,
  	.fs_flags	= FS_REQUIRES_DEV,
  };

@@ -1437,20 +1467,25 @@ static int __init init_iso9660_fs(void)
  	int err = init_inodecache();
  	if (err)
  		goto out;
+	err = init_inode_map_node_cache();
+	if (err)
+		goto out1;
  #ifdef CONFIG_ZISOFS
  	err = zisofs_init();
  	if (err)
-		goto out1;
+		goto out2;
  #endif
  	err = register_filesystem(&iso9660_fs_type);
  	if (err)
-		goto out2;
+		goto out3;
  	return 0;
-out2:
+out3:
  #ifdef CONFIG_ZISOFS
  	zisofs_cleanup();
-out1:
+out2:
  #endif
+	destroy_inode_map_node_cache();
+out1:
  	destroy_inodecache();
  out:
  	return err;
@@ -1462,6 +1497,7 @@ static void __exit exit_iso9660_fs(void)
  #ifdef CONFIG_ZISOFS
  	zisofs_cleanup();
  #endif
+	destroy_inode_map_node_cache();
  	destroy_inodecache();
  }

diff -X dontdiff -uprN linux-2.6.6/fs/isofs/inode_map.c linux-2.6.6-isofs/fs/isofs/inode_map.c
--- linux-2.6.6/fs/isofs/inode_map.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.6-isofs/fs/isofs/inode_map.c	2004-05-22 15:53:13.525356296 -0500
@@ -0,0 +1,413 @@
+#include <linux/buffer_head.h>
+#include <linux/iso_fs.h>
+#include <linux/rbtree.h>
+
+/*
+ * File meta-data can appear at almost any byte location on an ISO
+ * 9660 file system.  The previous version of the linux iso9660 file
+ * system addressed this problem by using the byte offset (relative to
+ * the beginning of the file system) as the inode number.  It then
+ * used the inode number to locate the meta-data.  This worked well
+ * until DVDs broke the 4GB barrier causing the byte offset to
+ * overflow its "unsigned long" on architectures where an unsigned
+ * long is only 32-bits wide.
+ *
+ * What follows is designed to allow access to all meta-data
+ * regardless of its location on the file system by assigning a
+ * simple, sequentially allocated inode number.  It then creates a
+ * mapping between the inode number and the block and block_offset
+ * where the meta-data can be found.  The mapping is stored in
+ * sbi->s_inode_map which uses two standard linux rbtrees to index by
+ * physical layout of the media and by the inode number.
+ *
+ * Where you see "inode_map_node" below, read it as "inode-map node,"
+ * i.e., a node for the rbtree that maps inodes to physical layout.  I
+ * am not altogether happy with the name, but it leaves room in the
+ * name space if other mappings are needed.
+ */
+
+static kmem_cache_t *isofs_inode_map_node_cachep;
+
+int init_inode_map_node_cache(void)
+{
+	isofs_inode_map_node_cachep =
+		kmem_cache_create("isofs_inode_map_node_cache",
+				  sizeof(struct isofs_inode_map_node),
+				  /* offset */ 0,
+				  SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT,
+				  /* ctor */ NULL,
+				  /* dtor */ NULL);
+
+	if (isofs_inode_map_node_cachep == NULL) {
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void destroy_inode_map_node_cache(void)
+{
+	if (kmem_cache_destroy(isofs_inode_map_node_cachep)) {
+		printk(KERN_INFO "isofs: Unable to destroy"
+		       "node cache for the inode map.\n");
+	}
+}
+
+static inline void
+isofs_inode_map_node_destroy_unlocked(struct isofs_inode_map_node *node)
+{
+	kmem_cache_free(isofs_inode_map_node_cachep, node);
+}
+
+static inline struct isofs_inode_map_node *
+isofs_inode_map_node_alloc_unlocked(void)
+{
+	struct isofs_inode_map_node *rv =
+		kmem_cache_alloc(isofs_inode_map_node_cachep, SLAB_KERNEL);
+        if (rv) {
+            memset(rv, 0, sizeof(*rv));
+        }
+	return rv;
+}
+
+void isofs_inode_map_init(struct isofs_inode_map *map)
+{
+	init_rwsem(&map->lock);
+	map->next_inode_number = 1;
+	map->index_by_phy = RB_ROOT;
+	map->index_by_ino = RB_ROOT;
+}
+
+/* This function returns 0 if the inode_number overflows.
+ *
+ * Because the root inode is always the first inode loaded, it will
+ * always be assigned 1 as its inode number.
+ *
+ * You should already hold the rwsem for writing when calling this
+ * function. */
+static inline unsigned long
+isofs_next_inode_number_unlocked(struct isofs_inode_map *map)
+{
+	unsigned long rv = 0;
+	if (map->next_inode_number) {
+		rv = map->next_inode_number++;
+	}
+	return rv;
+}
+
+/* Allow internal code to put back an inode number if an error occurs
+ * after taking a number.  Do not try to put back an inode if
+ * isofs_next_inode_number_unlocked() returned 0.  You must hold the
+ * rwsem for writing continuously from the time you call
+ * isofs_next_inode_number() until the time you call this function. */
+static inline void
+isofs_prev_inode_number_unlocked(struct isofs_inode_map *map)
+{
+    --map->next_inode_number;
+}
+
+/* Returns the map node that stores the same inode number as
+ * "inode_number".  If no node is found, NULL is returned.  This code
+ * is unlocked to allow for code reuse by routines that are holding
+ * the rwsem for writing (for example). */
+static inline struct isofs_inode_map_node *
+isofs_inode_map_find_by_ino_unlocked(struct isofs_inode_map *map,
+                                     unsigned long inode_number)
+{
+	struct rb_node *n = NULL;
+	struct isofs_inode_map_node *tmp = NULL;
+	struct isofs_inode_map_node *rv = NULL;
+
+	n = map->index_by_ino.rb_node;
+
+	while (n) {
+		tmp = rb_entry(n, struct isofs_inode_map_node, node_for_ino);
+		if (inode_number < tmp->inode_number) {
+			n = n->rb_left;
+		} else if (inode_number > tmp->inode_number) {
+			n = n->rb_right;
+		} else {
+			rv = tmp;
+			break;
+		}
+	}
+
+	return rv;
+}
+
+/* Returns the map node that stores the same inode number as
+ * "inode_number".  If no node is found, NULL is returned. */
+struct isofs_inode_map_node *
+isofs_inode_map_find_by_ino(struct isofs_inode_map *map,
+                            unsigned long inode_number)
+{
+	struct isofs_inode_map_node *rv;
+	down_read(&map->lock);
+	rv = isofs_inode_map_find_by_ino_unlocked(map, inode_number);
+	up_read(&map->lock);
+	return rv;
+}
+
+/* Returns the map node that stores the same block and block offset as
+ * "block" and "block_offset".	If no node is found, NULL is returned.
+ * This code is unlocked to allow for code reuse by routines that are
+ * holding the rwsem for writing (for example). */
+static inline struct isofs_inode_map_node *
+isofs_inode_map_find_by_phy_unlocked(struct isofs_inode_map *map,
+                                     sector_t block,
+                                     unsigned long block_offset)
+{
+	struct rb_node *n = NULL;
+	struct isofs_inode_map_node *tmp = NULL;
+	struct isofs_inode_map_node *rv = NULL;
+
+	n = map->index_by_phy.rb_node;
+
+	while (n) {
+		tmp = rb_entry(n, struct isofs_inode_map_node, node_for_phy);
+		if (block < tmp->block) {
+			n = n->rb_left;
+		} else if (block > tmp->block) {
+			n = n->rb_right;
+		} else if (block_offset < tmp->block_offset) {
+			n= n->rb_left;
+		} else if (block_offset > tmp->block_offset) {
+			n = n->rb_right;
+		} else {
+			rv = tmp;
+			break;
+		}
+	}
+
+	return rv;
+}
+
+/* Returns the map node that stores the same block and block offset as
+ * "block" and "block_offset".	If no node is found, NULL is
+ * returned. */
+struct isofs_inode_map_node *
+isofs_inode_map_find_by_phy(struct isofs_inode_map *map,
+                            sector_t block,
+                            unsigned long block_offset)
+{
+	struct isofs_inode_map_node *rv;
+	down_read(&map->lock);
+	rv = isofs_inode_map_find_by_phy_unlocked(map, block, block_offset);
+	up_read(&map->lock);
+	return rv;
+}
+
+/* This function does not allocate any memory. It simply inserts
+ * "node" into the ino tree.  It is really just an extension of
+ * isofs_inode_map_index_by_phy_unlocked().  You must hold the rwsem
+ * for writing when calling this function. */
+static inline void
+isofs_inode_map_index_by_ino_unlocked(struct isofs_inode_map *map,
+                                      struct isofs_inode_map_node *node)
+{
+	struct rb_node **child = NULL;
+	struct rb_node *parent = NULL;
+	struct isofs_inode_map_node *tmp = NULL;
+	unsigned long inode_number = node->inode_number;
+
+	child = &map->index_by_ino.rb_node;
+
+	/* Find the node's sorted location in the rbtree. */
+	while (*child) {
+		parent = *child;
+		tmp = rb_entry(parent,
+			       struct isofs_inode_map_node,
+			       node_for_ino);
+		if (inode_number < tmp->inode_number) {
+			child = &(*child)->rb_left;
+		} else if (inode_number > tmp->inode_number) {
+			child = &(*child)->rb_right;
+		} else {
+			break;
+		}
+	}
+
+	if (*child == NULL) {
+		/* Insert */
+		rb_link_node(&node->node_for_ino, parent, child);
+		/* Balance */
+		rb_insert_color(&node->node_for_ino, &map->index_by_ino);
+	} else {
+		printk(KERN_ERR "isofs: Internal error: "
+		       "node already indexed!\n");
+	}
+}
+
+/* Returns the inode number assigned for "block" and "block_offset."
+ * If no inode number is currently assigned, it automatically assigns
+ * the next available number in sequence and returns that as the inode
+ * number.  If an error occurs, 0 is returned. You must hold the rwsem
+ * for writing when calling this function. */
+static inline unsigned long
+isofs_inode_map_index_by_phy_unlocked(struct isofs_inode_map *map,
+                                      sector_t block,
+                                      unsigned long block_offset)
+{
+	unsigned long rv = 0;
+	struct rb_node **child = NULL;
+	struct rb_node *parent = NULL;
+	struct isofs_inode_map_node *tmp = NULL;
+	struct isofs_inode_map_node *node = NULL;
+
+	child = &map->index_by_phy.rb_node;
+
+	/* Find the node's sorted location in the rbtree. */
+	while (*child) {
+		parent = *child;
+		tmp = rb_entry(parent,
+			       struct isofs_inode_map_node,
+			       node_for_phy);
+		if (block < tmp->block) {
+			child = &(*child)->rb_left;
+		} else if (block > tmp->block) {
+			child = &(*child)->rb_right;
+		} else if (block_offset < tmp->block_offset) {
+			child = &(*child)->rb_left;
+		} else if (block_offset > tmp->block_offset) {
+			child = &(*child)->rb_right;
+		} else {
+			node = tmp;
+			break;
+		}
+	}
+
+	if (node == NULL) {
+		/* Grab the next inode number. */
+		unsigned long ino = isofs_next_inode_number_unlocked(map);
+		if (ino == 0) {
+			printk(KERN_ERR "isofs: Inode number overflowed.\n");
+			goto out;
+		}
+		/* Create new node. */
+		node = isofs_inode_map_node_alloc_unlocked();
+		if (node == NULL) {
+			printk(KERN_ERR "isofs: Unable to allocate "
+			       "map node.\n");
+			isofs_prev_inode_number_unlocked(map);
+			goto out;
+		}
+		node->inode_number = ino;
+		node->block = block;
+		node->block_offset = block_offset;
+		/* Insert */
+		rb_link_node(&node->node_for_phy, parent, child);
+		/* Balance */
+		rb_insert_color(&node->node_for_phy, &map->index_by_phy);
+		/* Atomically update the other tree while the rwsem
+		 * is still held. */
+		isofs_inode_map_index_by_ino_unlocked(map, node);
+	}
+
+	rv = node->inode_number;
+
+ out:
+	return rv;
+}
+
+/* Returns the inode number assigned for "block" and "block_offset."
+ * If an error occurs, 0 is returned.  If no inode number is currently
+ * assigned, it automatically assigns the next available number in
+ * sequence and returns that as the inode number. */
+unsigned long
+isofs_inode_map_index_by_phy(struct isofs_inode_map *map,
+                             sector_t block,
+                             unsigned long block_offset)
+{
+	unsigned long rv = 0;
+	down_write(&map->lock);
+	rv = isofs_inode_map_index_by_phy_unlocked(map, block, block_offset);
+	up_write(&map->lock);
+	return rv;
+}
+
+/* The code in isofs_fill_super() needs to be able to change the
+ * location of the root inode. */
+void isofs_inode_map_set_root_inode(struct isofs_inode_map *map,
+                                    sector_t block,
+                                    unsigned long block_offset)
+{
+	struct isofs_inode_map_node *map_node;
+
+	down_write(&map->lock);
+
+	map_node = isofs_inode_map_find_by_ino_unlocked(map, 1);
+	if (map_node) {
+		map_node->block = block;
+		map_node->block_offset = block_offset;
+	} else {
+		if (!isofs_inode_map_index_by_phy_unlocked(map,
+							   block,
+							   block_offset))
+		{
+			printk(KERN_ERR "isofs: Unable to map root inode!\n");
+		}
+	}
+
+	up_write(&map->lock);
+}
+
+/* This function is called when the super block is killed. It returns
+ * each node used in the mapping to the inode map cache. */
+void isofs_inode_map_destroy(struct isofs_inode_map *map)
+{
+	struct rb_node *n = NULL;
+	struct rb_node *parent = NULL;
+	struct isofs_inode_map_node *tmp = NULL;
+
+	down_write(&map->lock);
+
+	n = map->index_by_ino.rb_node;
+
+	if (n == NULL) {
+		BUG_ON(map->index_by_phy.rb_node != NULL);
+		goto out_unlock;
+	}
+
+	for( ;; ) {
+
+		/* Traverse the tree until you find a leaf node. */
+		if (n->rb_left != NULL) {
+			n = n->rb_left;
+			continue;
+		}
+		if (n->rb_right != NULL) {
+			n = n->rb_right;
+			continue;
+		}
+
+		/* Dereference n while the pointer is still valid. */
+		tmp = rb_entry(n, struct isofs_inode_map_node, node_for_ino);
+		parent = n->rb_parent;
+
+		/* Free the leaf node from the rbtree. */
+		isofs_inode_map_node_destroy_unlocked(tmp);
+
+		/* Exit Here */
+		if (parent == NULL) {
+			break;
+		}
+
+		/* Update child of parent. */
+		if (parent->rb_left == n) {
+			parent->rb_left = NULL;
+		} else {
+			parent->rb_right = NULL;
+		}
+
+		/* Walk up the rbtree as a substitute for recursion. */
+		n = parent;
+	}
+
+	/* Both trees shared the nodes. */
+	map->index_by_ino = RB_ROOT;
+	map->index_by_phy = RB_ROOT;
+
+ out_unlock:
+
+	up_write(&map->lock);
+}
diff -X dontdiff -uprN linux-2.6.6/fs/isofs/Makefile linux-2.6.6-isofs/fs/isofs/Makefile
--- linux-2.6.6/fs/isofs/Makefile	2004-04-03 21:38:26.000000000 -0600
+++ linux-2.6.6-isofs/fs/isofs/Makefile	2004-05-19 08:24:27.715677432 -0500
@@ -4,7 +4,7 @@

  obj-$(CONFIG_ISO9660_FS) += isofs.o

-isofs-objs-y 			:= namei.o inode.o dir.o util.o rock.o
+isofs-objs-y 			:= namei.o inode.o inode_map.o dir.o util.o rock.o
  isofs-objs-$(CONFIG_JOLIET)	+= joliet.o
  isofs-objs-$(CONFIG_ZISOFS)	+= compress.o
  isofs-objs			:= $(isofs-objs-y)
diff -X dontdiff -uprN linux-2.6.6/fs/isofs/namei.c linux-2.6.6-isofs/fs/isofs/namei.c
--- linux-2.6.6/fs/isofs/namei.c	2004-04-03 21:37:38.000000000 -0600
+++ linux-2.6.6-isofs/fs/isofs/namei.c	2004-05-19 08:24:27.716677280 -0500
@@ -65,6 +65,8 @@ isofs_find_entry(struct inode *dir, stru
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(dir);
  	unsigned char bufbits = ISOFS_BUFFER_BITS(dir);
  	unsigned int block, f_pos, offset;
+	sector_t abs_block;
+        unsigned long abs_block_offset;
  	struct buffer_head * bh = NULL;
  	struct isofs_sb_info *sbi = ISOFS_SB(dir->i_sb);

@@ -87,7 +89,8 @@ isofs_find_entry(struct inode *dir, stru
  		}

  		de = (struct iso_directory_record *) (bh->b_data + offset);
-		inode_number = (bh->b_blocknr << bufbits) + offset;
+		abs_block = bh->b_blocknr;
+                abs_block_offset = offset;

  		de_len = *(unsigned char *) de;
  		if (!de_len) {
@@ -151,6 +154,10 @@ isofs_find_entry(struct inode *dir, stru
  		}
  		if (match) {
  			if (bh) brelse(bh);
+			inode_number =
+				isofs_inode_map_index_by_phy(&sbi->s_inode_map,
+							     abs_block,
+							     abs_block_offset);
  			return inode_number;
  		}
  	}
diff -X dontdiff -uprN linux-2.6.6/fs/isofs/rock.c linux-2.6.6-isofs/fs/isofs/rock.c
--- linux-2.6.6/fs/isofs/rock.c	2004-05-19 07:55:33.752279936 -0500
+++ linux-2.6.6-isofs/fs/isofs/rock.c	2004-05-20 06:50:05.763064376 -0500
@@ -164,6 +164,8 @@ int parse_rock_ridge_inode_internal(stru
    int len;
    unsigned char * chr;
    int symlink_len = 0;
+  unsigned long inode_number = 0;
+  struct isofs_inode_map *map = &(ISOFS_SB(inode->i_sb)->s_inode_map);
    CONTINUE_DECLS;

    if (!ISOFS_SB(inode->i_sb)->s_rock) return 0;
@@ -306,9 +308,16 @@ int parse_rock_ridge_inode_internal(stru
  	goto out;
        case SIG('C','L'):
  	ISOFS_I(inode)->i_first_extent = isonum_733(rr->u.CL.location);
-	reloc = iget(inode->i_sb,
-		     (ISOFS_I(inode)->i_first_extent <<
-		      ISOFS_SB(inode->i_sb)->s_log_zone_size));
+	inode_number =
+		isofs_inode_map_index_by_phy(map,
+					     ISOFS_I(inode)->i_first_extent,
+					     0);
+	if (inode_number == 0) {
+		printk(KERN_ERR "Inode number overflowed while "
+		       "parsing rock ridge inode.\n");
+		goto out;
+	}
+	reloc = iget(inode->i_sb, inode_number);
  	if (!reloc)
  		goto out;
  	inode->i_mode = reloc->i_mode;
@@ -447,37 +456,43 @@ int parse_rock_ridge_inode(struct iso_di
  static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
  {
  	struct inode *inode = page->mapping->host;
+	struct isofs_sb_info* sbi = ISOFS_SB(inode->i_sb);
  	char *link = kmap(page);
  	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	unsigned char bufbits = ISOFS_BUFFER_BITS(inode);
  	struct buffer_head *bh;
  	char *rpnt = link;
  	unsigned char *pnt;
  	struct iso_directory_record *raw_inode;
  	CONTINUE_DECLS;
-	int block;
+	struct isofs_inode_map *map;
+	struct isofs_inode_map_node *map_node;
  	int sig;
  	int len;
  	unsigned char *chr;
  	struct rock_ridge *rr;

-	if (!ISOFS_SB(inode->i_sb)->s_rock)
+	if (!sbi->s_rock)
  		panic ("Cannot have symlink with high sierra variant of iso filesystem\n");

-	block = inode->i_ino >> bufbits;
+	map = &sbi->s_inode_map;
+	map_node = isofs_inode_map_find_by_ino(map, inode->i_ino);
+	if (map_node == NULL) {
+		goto out_eio;
+	}
+
  	lock_kernel();
-	bh = sb_bread(inode->i_sb, block);
+	bh = sb_bread(inode->i_sb, map_node->block);
  	if (!bh)
  		goto out_noread;

-	pnt = (unsigned char *) bh->b_data + (inode->i_ino & (bufsize - 1));
+	pnt = (unsigned char *) bh->b_data + map_node->block_offset;

  	raw_inode = (struct iso_directory_record *) pnt;

  	/*
  	 * If we go past the end of the buffer, there is some sort of error.
  	 */
-	if ((inode->i_ino & (bufsize - 1)) + *pnt > bufsize)
+	if (map_node->block_offset + *pnt > bufsize)
  		goto out_bad_span;

  	/* Now test for possible Rock Ridge extensions which will override
@@ -543,6 +558,7 @@ static int rock_ridge_symlink_readpage(s
  	SetPageError(page);
  	kunmap(page);
  	unlock_page(page);
+      out_eio:
  	return -EIO;
  }

diff -X dontdiff -uprN linux-2.6.6/include/linux/iso_fs.h linux-2.6.6-isofs/include/linux/iso_fs.h
--- linux-2.6.6/include/linux/iso_fs.h	2004-04-03 21:37:24.000000000 -0600
+++ linux-2.6.6-isofs/include/linux/iso_fs.h	2004-05-19 17:00:04.749359160 -0500
@@ -2,6 +2,7 @@
  #ifndef _ISOFS_FS_H
  #define _ISOFS_FS_H

+#include <linux/rbtree.h>
  #include <linux/types.h>
  /*
   * The isofs filesystem constants/structures
@@ -155,6 +156,18 @@ struct iso_directory_record {
  	char name			[0];
  } __attribute__((packed));

+
+/* Inode Map Node Cache -- Explicitly map 32-bit inode numbers to the
+ * arbitrary block and offset of an ISO 9660 Directory Record. */
+struct isofs_inode_map_node {
+	unsigned long inode_number;
+	sector_t block;
+	unsigned long block_offset;
+	struct rb_node node_for_phy;
+	struct rb_node node_for_ino;
+};
+
+
  #define ISOFS_BLOCK_BITS 11
  #define ISOFS_BLOCK_SIZE 2048

@@ -231,6 +244,31 @@ extern struct dentry *isofs_lookup(struc
  extern struct buffer_head *isofs_bread(struct inode *, sector_t);
  extern int isofs_get_blocks(struct inode *, sector_t, struct buffer_head **, unsigned long);

+extern int init_inode_map_node_cache(void);
+extern void destroy_inode_map_node_cache(void);
+
+extern void isofs_inode_map_init(struct isofs_inode_map *map);
+
+extern void isofs_inode_map_set_root_inode(struct isofs_inode_map *map,
+                                           sector_t block,
+                                           unsigned long block_offset);
+
+extern struct isofs_inode_map_node *
+isofs_inode_map_find_by_ino(struct isofs_inode_map *map,
+			    unsigned long inode_number);
+
+extern struct isofs_inode_map_node *
+isofs_inode_map_find_by_phy(struct isofs_inode_map *map,
+			    sector_t block,
+			    unsigned long block_offset);
+
+extern unsigned long
+isofs_inode_map_index_by_phy(struct isofs_inode_map *map,
+			     sector_t block,
+			     unsigned long block_offset);
+
+extern void isofs_inode_map_destroy(struct isofs_inode_map *map);
+
  extern struct inode_operations isofs_dir_inode_operations;
  extern struct file_operations isofs_dir_operations;
  extern struct address_space_operations isofs_symlink_aops;
diff -X dontdiff -uprN linux-2.6.6/include/linux/iso_fs_sb.h linux-2.6.6-isofs/include/linux/iso_fs_sb.h
--- linux-2.6.6/include/linux/iso_fs_sb.h	2004-04-03 21:38:28.000000000 -0600
+++ linux-2.6.6-isofs/include/linux/iso_fs_sb.h	2004-05-22 15:48:41.181758816 -0500
@@ -1,6 +1,15 @@
  #ifndef _ISOFS_FS_SB
  #define _ISOFS_FS_SB

+
+struct isofs_inode_map {
+	struct rw_semaphore lock;
+	unsigned long next_inode_number;
+	struct rb_root index_by_phy;
+	struct rb_root index_by_ino;
+};
+
+
  /*
   * iso9660 super-block data in memory
   */
@@ -29,6 +38,8 @@ struct isofs_sb_info {
  	gid_t s_gid;
  	uid_t s_uid;
  	struct nls_table *s_nls_iocharset; /* Native language support table */
+
+	struct isofs_inode_map s_inode_map;
  };

  #endif

