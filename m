Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbRGPTbA>; Mon, 16 Jul 2001 15:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbRGPTav>; Mon, 16 Jul 2001 15:30:51 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:57608 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267684AbRGPTai>; Mon, 16 Jul 2001 15:30:38 -0400
From: Nikita Danilov <NikitaDanilov@Yahoo.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15187.16575.830484.493649@beta.namesys.com>
Date: Mon, 16 Jul 2001 23:30:07 +0400
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
CC: torvalds@transmeta.com
Subject: Re: [reiserfs-list] [PATCH] cleanup reiserfs direct->indirect conversions
In-Reply-To: <409690000.994947060@tiny>
In-Reply-To: <409690000.994947060@tiny>
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

following patch for 2.4.7-pre6 implements NFS inode generation support
for ReiserFS. It was ported from earlier patch by Neil Brown and Chris
Mason. Inode generation is persistently stored in the on-disk field
unused for regular files. Generation is filled from global "generation
counter" persistently stored in a super-block and incremented on each
inode deletion. Hopefully this will cure most of reiserfs+knfsd woes for
2.4.6.

Linus, please apply.

On behalf of ReiserFS team,
Nikita.
------------------------------------------------------------
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu Jul 12 17:37:27 2001
+++ b/fs/reiserfs/inode.c	Thu Jul 12 17:37:27 2001
@@ -914,7 +914,6 @@
 
 
     copy_key (INODE_PKEY (inode), &(ih->ih_key));
-    inode->i_generation = INODE_PKEY (inode)->k_dir_id;
     inode->i_blksize = PAGE_SIZE;
 
     INIT_LIST_HEAD(&inode->u.reiserfs_i.i_prealloc_list) ;
@@ -934,6 +933,7 @@
 	inode->i_ctime = le32_to_cpu (sd->sd_ctime);
 
 	inode->i_blocks = le32_to_cpu (sd->u.sd_blocks);
+	inode->i_generation = INODE_PKEY (inode)->k_dir_id;
 	blocks = (inode->i_size + 511) >> 9;
 	blocks = _ROUND_UP (blocks, inode->i_blksize >> 9);
 	if (inode->i_blocks > blocks) {
@@ -968,6 +968,10 @@
 	inode->i_ctime = le32_to_cpu (sd->sd_ctime);
 	inode->i_blocks = le32_to_cpu (sd->sd_blocks);
 	rdev = le32_to_cpu (sd->u.sd_rdev);
+	if( S_ISCHR( inode -> i_mode ) || S_ISBLK( inode -> i_mode ) )
+	    inode->i_generation = INODE_PKEY (inode)->k_dir_id;
+	else
+	    inode->i_generation = le32_to_cpu( sd->u.sd_generation );
     }
 
     /* nopack = 0, by default */
@@ -1005,8 +1009,11 @@
     sd_v2->sd_atime = cpu_to_le32 (inode->i_atime);
     sd_v2->sd_ctime = cpu_to_le32 (inode->i_ctime);
     sd_v2->sd_blocks = cpu_to_le32 (inode->i_blocks);
-    if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+    if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 	sd_v2->u.sd_rdev = cpu_to_le32 (inode->i_rdev);
+    } else {
+	sd_v2->u.sd_generation = cpu_to_le32( inode -> i_generation );
+    }
 }
 
 
@@ -1208,10 +1215,20 @@
 	    key.on_disk_key.k_objectid = data[0] ;
 	    key.on_disk_key.k_dir_id = data[1] ;
 	    inode = reiserfs_iget(sb, &key) ;
+	    if (inode && (fhtype == 3 || fhtype == 6) &&
+		data[2] != inode->i_generation) {
+		    iput(inode) ;
+		    inode = NULL ;
+	    }
     } else {
-	    key.on_disk_key.k_objectid = data[2] ;
-	    key.on_disk_key.k_dir_id = data[3] ;
+	    key.on_disk_key.k_objectid = data[fhtype==6?3:2] ;
+	    key.on_disk_key.k_dir_id = data[fhtype==6?4:3] ;
 	    inode = reiserfs_iget(sb, &key) ;
+	    if (inode && fhtype == 6 &&
+		data[5] != inode->i_generation) {
+		    iput(inode) ;
+		    inode = NULL ;
+	    }
     }
 out:
     if (!inode)
@@ -1246,21 +1263,23 @@
     struct inode *inode = dentry->d_inode ;
     int maxlen = *lenp;
     
-    if (maxlen < 2)
+    if (maxlen < 3)
         return 255 ;
 
     data[0] = inode->i_ino ;
     data[1] = le32_to_cpu(INODE_PKEY (inode)->k_dir_id) ;
-    *lenp = 2;
+    data[2] = inode->i_generation ;
+    *lenp = 3;
     /* no room for directory info? return what we've stored so far */
-    if (maxlen < 4 || ! need_parent)
-        return 2 ;
+    if (maxlen < 6 || ! need_parent)
+        return 3;
 
     inode = dentry->d_parent->d_inode ;
-    data[2] = inode->i_ino ;
-    data[3] = le32_to_cpu(INODE_PKEY (inode)->k_dir_id) ;
-    *lenp = 4;
-    return 4; 
+    data[3] = inode->i_ino ;
+    data[4] = le32_to_cpu(INODE_PKEY (inode)->k_dir_id) ;
+    data[5] = inode->i_generation ;
+    *lenp = 6;
+    return 6; 
 }
 
 
@@ -1447,6 +1466,20 @@
 	return NULL;
     }
     if (old_format_only (sb))
+      /* not a perfect generation count, as object ids can be reused, but this
+      ** is as good as reiserfs can do right now.
+      ** note that the private part of inode isn't filled in yet, we have
+      ** to use the directory.
+      */
+      inode->i_generation = INODE_PKEY (dir)->k_objectid;
+    else
+#if defined( USE_INODE_GENERATION_COUNTER )
+      inode->i_generation = 
+	le32_to_cpu( sb -> u.reiserfs_sb.s_rs -> s_inode_generation );
+#else
+      inode->i_generation = ++event;
+#endif
+    if (old_format_only (sb))
 	make_le_item_head (&ih, 0, ITEM_VERSION_1, SD_OFFSET, TYPE_STAT_DATA, SD_V1_SIZE, MAX_US_INT);
     else
 	make_le_item_head (&ih, 0, ITEM_VERSION_2, SD_OFFSET, TYPE_STAT_DATA, SD_SIZE, MAX_US_INT);
@@ -1536,10 +1569,6 @@
 	return NULL;
     }
 
-    /* not a perfect generation count, as object ids can be reused, but this
-    ** is as good as reiserfs can do right now
-    */
-    inode->i_generation = INODE_PKEY (inode)->k_dir_id;
     insert_inode_hash (inode);
     // we do not mark inode dirty: on disk content matches to the
     // in-core one
diff -Nru a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
--- a/fs/reiserfs/stree.c	Thu Jul 12 17:37:27 2001
+++ b/fs/reiserfs/stree.c	Thu Jul 12 17:37:27 2001
@@ -1560,6 +1560,17 @@
         reiserfs_warning("clm-4001: deleting inode with link count==%d\n", inode->i_nlink) ;
     }
 #endif
+#if defined( USE_INODE_GENERATION_COUNTER )
+    if( !old_format_only ( th -> t_super ) )
+      {
+       __u32 *inode_generation;
+       
+       inode_generation = 
+         &th -> t_super -> u.reiserfs_sb.s_rs -> s_inode_generation;
+       *inode_generation = cpu_to_le32( le32_to_cpu( *inode_generation ) + 1 );
+      }
+/* USE_INODE_GENERATION_COUNTER */
+#endif
     reiserfs_delete_solid_item (th, INODE_PKEY (inode));
 }
 
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Thu Jul 12 17:37:27 2001
+++ b/include/linux/reiserfs_fs.h	Thu Jul 12 17:37:27 2001
@@ -65,6 +65,9 @@
 /* enable journalling */
 #define ENABLE_JOURNAL
 
+#define USE_INODE_GENERATION_COUNTER
+
+
 #ifdef __KERNEL__
 
 /* #define REISERFS_CHECK */
@@ -708,6 +711,7 @@
     __u32 sd_blocks;
     union {
 	__u32 sd_rdev;
+	__u32 sd_generation;
       //__u32 sd_first_direct_byte; 
       /* first byte of file which is stored in a
 				       direct item: except that if it equals 1
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Thu Jul 12 17:37:27 2001
+++ b/include/linux/reiserfs_fs_sb.h	Thu Jul 12 17:37:27 2001
@@ -60,7 +60,8 @@
                                    don't need to save bytes in the
                                    superblock. -Hans */
   __u16 s_reserved;
-  char s_unused[128] ;			/* zero filled by mkreiserfs */
+  __u32 s_inode_generation;
+  char s_unused[124] ;			/* zero filled by mkreiserfs */
 } __attribute__ ((__packed__));
 
 #define SB_SIZE (sizeof(struct reiserfs_super_block))
------------------------------------------------------------
