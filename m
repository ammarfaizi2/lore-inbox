Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQKQGGc>; Fri, 17 Nov 2000 01:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130070AbQKQGGV>; Fri, 17 Nov 2000 01:06:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46996 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129314AbQKQGGJ>;
	Fri, 17 Nov 2000 01:06:09 -0500
Date: Fri, 17 Nov 2000 00:36:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get_empty_inode cleanup - part 2
Message-ID: <Pine.GSO.4.21.0011162315350.14822-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* Arrgh. Hell knows how, but %s/new_inode/ntfs_&/g in fs/ntfs/inode.c
mentioned in the previous part didn't make it into the patch I've sent.
Mea maxima culpa. Fixed.
	* More duplicated initializations removed:
		* get_empty_inode() sets i_flags to 0. NFS and UDF did the
		  reinitialization immediately after new_inode(). To 0.
		* Ditto for i_size. Redundant stuff was in UDF, sysvfs, FAT.
	* capifs had the following gem:
	capifs_read_inode(struct inode *inode)
	{
		...
		inode->i_op = NULL;
		...  more assignments to fields, then
		if (ino == 1) {
	                inode->i_op = &capifs_root_inode_operations;
			...
			return;
		}
		/* need dummy inode operations .... */
		inode->i_op = &capifs_inode_operations;
		...
	}
	  The first assignment is interesting, indeed, but so is the third
	  one: capifs_inode_operations is empty. Just as the default one
	  placed there by caller of ->read_inode() (empty_iops). Crapectomy
	  performed...
	* shm_read_inode() starts with ->i_op = NULL. After that we attempt
	  shm_lock() and if it fails - return immediately. Correct action:
	  make_bad_inode(). Every other branch initializes ->i_op, so the
	  first assignment is unneeded.
	* JFFS sets ->i_flags to ->s_flags. Atavism, since s_flags is not
	  mirrored in ->i_flags anymore (inherited from 2.0 version). Makes
	  absolutely no sense these days, since nothing (including JFFS)
	  looks for s_flags bits in i_flags - as the matter of fact they are
	  completely independent. Removed.
	* All callers of ->read_inode() (OK, the only caller ;-) call
	  clean_inode() immediately before. Several instances have duplicated
	  initializers for ->i_size (to 0), ->i_nlink (to 1), etc. (obviously,
	  normal filesystems have meaningful initializations there - I'm
	  talking only about devfs/capifs/etc.)

Please, apply.
							Cheers,
								Al
PS: at that point the official tree _never_ has ->i_op == NULL for any
inode. So Tigran's idea about dropping the checks for NULL ->i_op looks
fine, modulo 3rd-party filesystems. For 2.5 it's definitely the right
thing, but it might be OK even now... Comments? 

diff -urN rc11-pre6/drivers/isdn/avmb1/capifs.c rc11-6-new_inode/drivers/isdn/avmb1/capifs.c
--- rc11-pre6/drivers/isdn/avmb1/capifs.c	Thu Nov  2 22:38:31 2000
+++ rc11-6-new_inode/drivers/isdn/avmb1/capifs.c	Fri Nov 17 03:44:58 2000
@@ -119,8 +119,6 @@
 	lookup: capifs_root_lookup,
 };
 
-struct inode_operations capifs_inode_operations;
-
 static struct dentry_operations capifs_dentry_operations = {
 	d_revalidate: capifs_revalidate,
 };
@@ -468,10 +466,8 @@
 	ino_t ino = inode->i_ino;
 	struct capifs_sb_info *sbi = SBI(inode->i_sb);
 
-	inode->i_op = NULL;
 	inode->i_mode = 0;
 	inode->i_nlink = 0;
-	inode->i_size = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
@@ -484,9 +480,6 @@
 		inode->i_nlink = 2;
 		return;
 	} 
-
-	/* need dummy inode operations .... */
-	inode->i_op = &capifs_inode_operations;
 
 	ino -= 2;
 	if ( ino >= sbi->max_ncci )
diff -urN rc11-pre6/fs/autofs/inode.c rc11-6-new_inode/fs/autofs/inode.c
--- rc11-pre6/fs/autofs/inode.c	Thu Apr 27 22:09:22 2000
+++ rc11-6-new_inode/fs/autofs/inode.c	Fri Nov 17 03:46:09 2000
@@ -211,7 +211,6 @@
 	inode->i_fop = &autofs_dir_operations;
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO;
 	inode->i_nlink = 2;
-	inode->i_size = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = 0;
 	inode->i_blksize = 1024;
diff -urN rc11-pre6/fs/devfs/base.c rc11-6-new_inode/fs/devfs/base.c
--- rc11-pre6/fs/devfs/base.c	Fri Nov 17 02:23:19 2000
+++ rc11-6-new_inode/fs/devfs/base.c	Fri Nov 17 03:47:06 2000
@@ -2250,7 +2250,6 @@
 	printk ("%s: read_inode(%d): VFS inode: %p  devfs_entry: %p\n",
 		DEVFS_NAME, (int) inode->i_ino, inode, de);
 #endif
-    inode->i_size = 0;
     inode->i_blocks = 0;
     inode->i_blksize = 1024;
     inode->i_op = &devfs_iops;
diff -urN rc11-pre6/fs/fat/inode.c rc11-6-new_inode/fs/fat/inode.c
--- rc11-pre6/fs/fat/inode.c	Fri Nov 17 02:23:19 2000
+++ rc11-6-new_inode/fs/fat/inode.c	Fri Nov 17 03:14:24 2000
@@ -794,7 +794,6 @@
 			inode->i_nlink = 1;
 		}
 #endif
-		inode->i_size = 0;
 		if ((nr = MSDOS_I(inode)->i_start) != 0)
 			while (nr != -1) {
 				inode->i_size += SECTOR_SIZE*sbi->cluster_size;
@@ -818,7 +817,6 @@
 				(CF_LE_W(de->starthi) << 16);
 		}
 		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
-		inode->i_nlink = 1;
 		inode->i_size = CF_LE_L(de->size);
 	        inode->i_op = &fat_file_inode_operations;
 	        inode->i_fop = &fat_file_operations;
diff -urN rc11-pre6/fs/jffs/inode-v23.c rc11-6-new_inode/fs/jffs/inode-v23.c
--- rc11-pre6/fs/jffs/inode-v23.c	Fri Nov 17 02:23:20 2000
+++ rc11-6-new_inode/fs/jffs/inode-v23.c	Fri Nov 17 03:40:40 2000
@@ -349,7 +349,6 @@
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = (inode->i_size + 511) >> 9;
 	inode->i_version = 0;
-	inode->i_flags = sb->s_flags;
 	inode->u.generic_ip = (void *)jffs_find_file(c, raw_inode->ino);
 
 	insert_inode_hash(inode);
diff -urN rc11-pre6/fs/nfs/inode.c rc11-6-new_inode/fs/nfs/inode.c
--- rc11-pre6/fs/nfs/inode.c	Fri Nov 17 02:23:21 2000
+++ rc11-6-new_inode/fs/nfs/inode.c	Fri Nov 17 02:40:51 2000
@@ -723,7 +723,6 @@
 		struct inode *inode = new_inode(sb);
 		if (!inode)
 			goto out;
-		inode->i_flags = 0;
 		inode->i_ino = nfs_fattr_to_ino_t(fattr);
 		nfs_read_inode(inode);
 		nfs_fill_inode(inode, fattr);
diff -urN rc11-pre6/fs/ntfs/inode.c rc11-6-new_inode/fs/ntfs/inode.c
--- rc11-pre6/fs/ntfs/inode.c	Thu Jul 27 09:36:37 2000
+++ rc11-6-new_inode/fs/ntfs/inode.c	Fri Nov 17 02:33:33 2000
@@ -1050,7 +1050,7 @@
 
 /* We have to skip the 16 metafiles and the 8 reserved entries */
 static int 
-new_inode (ntfs_volume* vol,int* result)
+ntfs_new_inode (ntfs_volume* vol,int* result)
 {
 	int byte,error;
 	int bit;
@@ -1236,11 +1236,11 @@
 	ntfs_volume* vol=dir->vol;
 	int byte,bit;
 
-	error=new_inode (vol,&(result->i_number));
+	error=ntfs_new_inode (vol,&(result->i_number));
 	if(error==ENOSPC){
 		error=ntfs_extend_mft(vol);
 		if(error)return error;
-		error=new_inode(vol,&(result->i_number));
+		error=ntfs_new_inode(vol,&(result->i_number));
 	}
 	if(error){
 		ntfs_error ("ntfs_get_empty_inode: no free inodes\n");
diff -urN rc11-pre6/fs/sysv/ialloc.c rc11-6-new_inode/fs/sysv/ialloc.c
--- rc11-pre6/fs/sysv/ialloc.c	Fri Nov 17 02:23:22 2000
+++ rc11-6-new_inode/fs/sysv/ialloc.c	Fri Nov 17 03:08:30 2000
@@ -142,7 +142,6 @@
 	mark_inode_dirty(inode);
 	/* Change directory entry: */
 	inode->i_mode = 0;		/* for sysv_write_inode() */
-	inode->i_size = 0;		/* ditto */
 	sysv_write_inode(inode, 0);	/* ensure inode not allocated again */
 					/* FIXME: caller may call this too. */
 	mark_inode_dirty(inode);	/* cleared by sysv_write_inode() */
diff -urN rc11-pre6/fs/udf/ialloc.c rc11-6-new_inode/fs/udf/ialloc.c
--- rc11-pre6/fs/udf/ialloc.c	Fri Nov 17 02:23:22 2000
+++ rc11-6-new_inode/fs/udf/ialloc.c	Fri Nov 17 03:06:57 2000
@@ -84,7 +84,6 @@
 		*err = -ENOMEM;
 		return NULL;
 	}
-	inode->i_flags = 0;
 	*err = -ENOSPC;
 
 	block = udf_new_block(dir, UDF_I_LOCATION(dir).partitionReferenceNum,
@@ -128,7 +127,6 @@
 	inode->i_ino = udf_get_lb_pblock(sb, UDF_I_LOCATION(inode), 0);
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
-	inode->i_size = 0;
 	UDF_I_LENEATTR(inode) = 0;
 	UDF_I_LENALLOC(inode) = 0;
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_EXTENDED_FE))
diff -urN rc11-pre6/ipc/shm.c rc11-6-new_inode/ipc/shm.c
--- rc11-pre6/ipc/shm.c	Wed Oct  4 03:45:11 2000
+++ rc11-6-new_inode/ipc/shm.c	Fri Nov 17 03:34:34 2000
@@ -376,13 +376,14 @@
 	struct shmid_kernel *shp;
 
 	id = inode->i_ino;
-	inode->i_op = NULL;
 	inode->i_mode = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 
 	if (id < SEQ_MULTIPLIER) {
-		if (!(shp = shm_lock (id)))
+		if (!(shp = shm_lock (id))) {
+			make_bad_inode(inode);
 			return;
+		}
 		inode->i_mode = (shp->shm_flags & S_IALLUGO) | S_IFREG;
 		inode->i_uid  = shp->shm_perm.uid;
 		inode->i_gid  = shp->shm_perm.gid;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
