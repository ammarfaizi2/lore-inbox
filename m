Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261656AbTCGPnj>; Fri, 7 Mar 2003 10:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbTCGPnj>; Fri, 7 Mar 2003 10:43:39 -0500
Received: from comtv.ru ([217.10.32.4]:46258 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261656AbTCGPnY>;
	Fri, 7 Mar 2003 10:43:24 -0500
X-Comment-To: "Martin J. Bligh"
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       Daniel Phillips <phillips@arcor.de>, Andrew Morton <akpm@digeo.com>,
       Alex Tomas <bzzz@tmi.comex.ru>
Subject: Re: [Bug 417] New: htree much slower than regular ext3
References: <11490000.1046367063@[10.10.2.4]>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 07 Mar 2003 18:46:55 +0300
Message-ID: <m34r6fyya8.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

The problem is that getdents(2) returns inodes out of order and
du causes many head seeks. I tried to solve the problem by patch
I included in. The idea of the patch is pretty simple: just try
to sort dentries by inode number in readdir(). It works because
inodes sits at fixed places in ext2/ext3. Please, look at results
I just got:

                  real        user         sys

ext3+htree:  7m22.236s    0m0.292s    0m2.204s
ext3-htree:  3m6.539s     0m0.481s    0m2.278s
ext3+sd-05:  3m45.453s    0m0.493s    0m2.265s
ext3+sd-10:  3m35.770s    0m0.514s    0m2.076s
ext3+sd-15:  3m24.235s    0m0.558s    0m2.075s
ext3+sd-20:  3m6.802s     0m0.486s    0m2.214s
ext3+sd-25:  2m55.062s    0m0.490s    0m2.105s
ext3+sd-30:  2m39.658s    0m0.492s    0m2.138s


'sd-N' stands for sortdir, N blocks will be prefetched before
sorting.

Of course, sortdir isn't production-ready and I even don't try
to test it hard. Just to probe the idea.

After applying the patch, use 'sortdir' or 'sortdir=N' as mount
option. 

with best regards, Alex

>>>>> Martin J Bligh (MJB) writes:

 MJB> Problem Description: I created a directory ("test") with 32000
 MJB> (ok, 31998) directories in it, and put a file called 'foo' in
 MJB> each of them (for i in `ls`; do cd $i && touch bar && cd .. ;
 MJB> done). Then I took that ext3 partion, umounted it, did a
 MJB> 'tune2fs -O dir_index', then 'fsck -fD', and remounted. I then
 MJB> did a 'time du -hs' on the test directory, and here are the
 MJB> results.

 MJB> ext3+htree: bwindle@razor:/giant/inodes$ time du -hs 126M .

 MJB> real 7m21.756s user 0m2.021s sys 0m22.190s

 MJB> I then unmounted, tune2fs -O ^dir_index, e2fsck -fD /dev/hdb1,
 MJB> remounted, and did another du -hs on the test directory. It took
 MJB> 1 minute, 48 seconds.

 MJB> bwindle@razor:/giant/test$ time du -hs 126M .

 MJB> real 1m48.760s user 0m1.986s sys 0m21.563s


 MJB> I thought htree was supposed to speed up access with large
 MJB> numbers of directories?



diff -uNr linux/fs/ext3/dir.c edited/fs/ext3/dir.c
--- linux/fs/ext3/dir.c	Thu Mar  6 14:57:50 2003
+++ edited/fs/ext3/dir.c	Fri Mar  7 18:35:32 2003
@@ -33,8 +33,12 @@
 static int ext3_readdir(struct file *, void *, filldir_t);
 static int ext3_dx_readdir(struct file * filp,
 			   void * dirent, filldir_t filldir);
+static int ext3_readdir_sort (struct file * filp,
+                         void * dirent, filldir_t filldir);
 static int ext3_release_dir (struct inode * inode,
 				struct file * filp);
+int ext3_htree_store_dirent_sorted(struct file *dir_file,
+                             struct ext3_dir_entry_2 *dirent);
 
 struct file_operations ext3_dir_operations = {
 	.read		= generic_read_dir,
@@ -104,9 +108,17 @@
 	sb = inode->i_sb;
 
 	if (is_dx(inode)) {
+		if (test_opt(inode->i_sb, SORTDIR)) {
+			err = ext3_readdir_sort(filp, dirent, filldir);
+			unlock_kernel();
+			return err;
+		}
+		
 		err = ext3_dx_readdir(filp, dirent, filldir);
-		if (err != ERR_BAD_DX_DIR)
+		if (err != ERR_BAD_DX_DIR) {
+			unlock_kernel();
 			return err;
+		}
 		/*
 		 * We don't set the inode dirty flag since it's not
 		 * critical that it get flushed back to the disk.
@@ -249,6 +261,8 @@
 	__u32		inode;
 	__u8		name_len;
 	__u8		file_type;
+	loff_t		offs;
+	struct list_head list;
 	char		name[0];
 };
 
@@ -311,6 +325,9 @@
 	p->curr_hash = pos2maj_hash(pos);
 	p->curr_minor_hash = pos2min_hash(pos);
 	p->next_hash = 0;
+	INIT_LIST_HEAD(&p->list);
+	p->list_nr = 0;
+
 	return p;
 }
 
@@ -493,10 +510,193 @@
 
 static int ext3_release_dir (struct inode * inode, struct file * filp)
 {
-       if (is_dx(inode) && filp->private_data)
+       if (is_dx(inode) && filp->private_data) 
 		ext3_htree_free_dir_info(filp->private_data);
 
 	return 0;
 }
 
+int ext3_htree_fill_pool(struct file *dir_file,  struct ext3_dir_entry_2 *dirent)
+{                       
+        struct rb_node **p, *parent = NULL;
+        struct fname * fname, *new_fn, *prev_fname = NULL;
+        struct dir_private_info *info;
+        int len;        
+                
+        info = (struct dir_private_info *) dir_file->private_data;
+        p = &info->root.rb_node; 
+                       
+        /* Create and allocate the fname structure */ 
+        len = sizeof(struct fname) + dirent->name_len + 1;
+        new_fn = kmalloc(len, GFP_KERNEL);         
+        if (!new_fn)            
+                return -ENOMEM;
+        memset(new_fn, 0, len); 
+        new_fn->hash = new_fn->inode = le32_to_cpu(dirent->inode); 
+        new_fn->name_len = dirent->name_len;
+        new_fn->file_type = dirent->file_type;
+        memcpy(new_fn->name, dirent->name, dirent->name_len);
+        new_fn->name[dirent->name_len] = 0;
+        new_fn->offs = dir_file->f_pos;
+                                
+        while (*p) {
+                parent = *p;
+                fname = rb_entry(parent, struct fname, rb_hash);
+                
+                if (new_fn->hash < fname->hash)
+                        p = &(*p)->rb_left;
+                else {          
+                        prev_fname = fname;
+                        p = &(*p)->rb_right;
+                }               
+        }                               
+
+        if (prev_fname)
+                list_add(&new_fn->list, &prev_fname->list);
+        else
+                list_add(&new_fn->list, &info->list);
+
+        rb_link_node(&new_fn->rb_hash, parent, p);
+        rb_insert_color(&new_fn->rb_hash, &info->root);
+        info->list_nr++;
+
+        return 0;
+}
+
+static int ext3_fill_from_sort_pool (struct file * filp, void * dirent, filldir_t filldir)
+{
+	struct super_block * sb = filp->f_dentry->d_inode->i_sb;
+	struct dir_private_info *info = filp->private_data;
+	struct list_head * cur;
+        struct fname *fname;
+	int error;
+
+	list_for_each(cur, &info->list) {
+		fname = list_entry(cur, struct fname, list);
+
+                error = filldir(dirent, fname->name,
+				fname->name_len, fname->offs,
+				fname->inode,
+				get_dtype(sb, fname->file_type));
+		if (error)
+			return 0;
+
+		list_del(&fname->list);
+		info->list_nr--;
+	}
+	
+	if (info->list_nr == 0)
+		free_rb_tree_fname(&info->root);
+
+	return 0;
+}
+
+static int ext3_readdir_sort (struct file * filp,
+                         void * dirent, filldir_t filldir)
+{
+        unsigned long offset, blk;
+        int i, stored, error = 0, blocks = 0, err;
+        struct buffer_head * bh;
+        struct ext3_dir_entry_2 * de;
+        struct inode *inode = filp->f_dentry->d_inode;
+	struct super_block * sb = inode->i_sb;
+	struct dir_private_info *info = filp->private_data;
+
+	if (!info) {
+		info = create_dir_info(filp->f_pos);
+		if (!info)
+			return -ENOMEM;
+		filp->private_data = info;
+	}
+
+	if (info->list_nr > 0) {
+		ext3_fill_from_sort_pool(filp, dirent, filldir);
+		return 0;
+	}
+	
+        stored = 0;
+        bh = NULL;
+        offset = filp->f_pos & (sb->s_blocksize - 1);
+
+        while (!error && (blocks < EXT3_SB(sb)->sortdir_prefetch) &&
+			(filp->f_pos < inode->i_size)) {
+                blk = (filp->f_pos) >> EXT3_BLOCK_SIZE_BITS(sb);
+                bh = ext3_bread (0, inode, blk, 0, &err);
+                if (!bh) {
+                        ext3_error (sb, "ext3_readdir",
+                                "directory #%lu contains a hole at offset %lu",
+                                inode->i_ino, (unsigned long)filp->f_pos);
+                        filp->f_pos += sb->s_blocksize - offset;
+                        continue;
+                }
+
+revalidate:
+                /* If the dir block has changed since the last call to
+                 * readdir(2), then we might be pointing to an invalid
+                 * dirent right now.  Scan from the start of the block
+                 * to make sure. */
+                if (filp->f_version != inode->i_version) {
+                        for (i = 0; i < sb->s_blocksize && i < offset; ) {
+                                de = (struct ext3_dir_entry_2 *)
+                                        (bh->b_data + i);
+                                /* It's too expensive to do a full
+                                 * dirent test each time round this
+                                 * loop, but we do have to test at
+                                 * least that it is non-zero.  A
+                                 * failure will be detected in the
+                                 * dirent test below. */
+                                if (le16_to_cpu(de->rec_len) <
+                                                EXT3_DIR_REC_LEN(1))
+                                        break;
+                                i += le16_to_cpu(de->rec_len);
+                        }
+                        offset = i;
+                        filp->f_pos = (filp->f_pos & ~(sb->s_blocksize - 1))
+                                | offset;
+                        filp->f_version = inode->i_version;
+                }
+
+                while (!error && filp->f_pos < inode->i_size
+                       && offset < sb->s_blocksize) {
+                        de = (struct ext3_dir_entry_2 *) (bh->b_data + offset);
+                        if (!ext3_check_dir_entry ("ext3_readdir", inode, de,
+                                                   bh, offset)) {
+                                /* On error, skip the f_pos to the
+                                 * next block. */
+                                filp->f_pos = (filp->f_pos |
+                                                (sb->s_blocksize - 1)) + 1;
+                                brelse (bh);
+                                return stored;
+                        }
+                        offset += le16_to_cpu(de->rec_len);
+                        if (le32_to_cpu(de->inode)) {
+                                /* We might block in the next section
+                                 * if the data destination is
+                                 * currently swapped out.  So, use a
+                                 * version stamp to detect whether or
+                                 * not the directory has been modified
+                                 * during the copy operation.
+                                 */
+                                unsigned long version = filp->f_version;
+
+				error = ext3_htree_fill_pool(filp, de);
+                                if (error)
+                                        break;
+                                if (version != filp->f_version)
+                                        goto revalidate;
+                                stored ++;
+                        }
+                        filp->f_pos += le16_to_cpu(de->rec_len);
+                }
+                offset = 0;
+                brelse (bh);
+		blocks++;
+        }
+	
+	ext3_fill_from_sort_pool(filp, dirent, filldir);
+	
+        UPDATE_ATIME(inode);
+        return 0;
+}
+
 #endif
diff -uNr linux/fs/ext3/super.c edited/fs/ext3/super.c
--- linux/fs/ext3/super.c	Mon Feb 24 17:47:45 2003
+++ edited/fs/ext3/super.c	Fri Mar  7 17:47:27 2003
@@ -584,6 +584,19 @@
 			continue;
 		if ((value = strchr (this_char, '=')) != NULL)
 			*value++ = 0;
+		if (!strcmp (this_char, "sortdir")) {
+			if (value && *value) {
+				int blocks = simple_strtoul(value, &value, 0);
+				printk("EXT3: has value: %d\n", blocks);
+				if (blocks > 0)
+					sbi->sortdir_prefetch = blocks;
+			}
+			if (sbi->sortdir_prefetch == 0)
+				sbi->sortdir_prefetch = 10; /* default value */
+			set_opt(sbi->s_mount_opt, SORTDIR);
+			printk("EXT3-fs: sortdir (%d blocks prefetch)\n",
+					sbi->sortdir_prefetch);
+		} else
 #ifdef CONFIG_EXT3_FS_XATTR
 		if (!strcmp (this_char, "user_xattr"))
 			set_opt (sbi->s_mount_opt, XATTR_USER);
diff -uNr linux/include/linux/ext3_fs.h edited/include/linux/ext3_fs.h
--- linux/include/linux/ext3_fs.h	Mon Feb 24 17:47:33 2003
+++ edited/include/linux/ext3_fs.h	Fri Mar  7 18:32:53 2003
@@ -330,6 +330,7 @@
 #define EXT3_MOUNT_NO_UID32		0x2000  /* Disable 32-bit UIDs */
 #define EXT3_MOUNT_XATTR_USER		0x4000	/* Extended user attributes */
 #define EXT3_MOUNT_POSIX_ACL		0x8000	/* POSIX Access Control Lists */
+#define EXT3_MOUNT_SORTDIR		0x10000	/* sort indexed dirs in readdir() */
 
 /* Compatibility, for having both ext2_fs.h and ext3_fs.h included at once */
 #ifndef _LINUX_EXT2_FS_H
@@ -656,6 +657,8 @@
 	__u32		curr_hash;
 	__u32		curr_minor_hash;
 	__u32		next_hash;
+	struct list_head list;
+	int		list_nr;
 };
 
 /*
diff -uNr linux/include/linux/ext3_fs_sb.h edited/include/linux/ext3_fs_sb.h
--- linux/include/linux/ext3_fs_sb.h	Mon Nov 11 06:28:30 2002
+++ edited/include/linux/ext3_fs_sb.h	Fri Mar  7 17:30:46 2003
@@ -63,6 +63,7 @@
 	struct timer_list turn_ro_timer;	/* For turning read-only (crash simulation) */
 	wait_queue_head_t ro_wait_queue;	/* For people waiting for the fs to go read-only */
 #endif
+	int sortdir_prefetch;			/* how many blocks to read to fill pool --AT */
 };
 
 #endif	/* _LINUX_EXT3_FS_SB */

