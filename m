Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSHWFz5>; Fri, 23 Aug 2002 01:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSHWFz4>; Fri, 23 Aug 2002 01:55:56 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:11262 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318213AbSHWFzx>; Fri, 23 Aug 2002 01:55:53 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.53087.359373.885484@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 15:59:59 +1000
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Large Block Device patch part 8 of 8
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This patch adds the configuration options for CONFIG_LBD to i386 and
ppc.


It also fixes a couple of things I missed in earlier patches.

(And yes, there are only 8 parts)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.515   -> 1.516  
#	drivers/block/Config.help	1.2     -> 1.3    
#	include/asm-i386/types.h	1.2     -> 1.3    
#	drivers/block/Config.in	1.7     -> 1.8    
#	include/linux/types.h	1.4     -> 1.5    
#	     fs/affs/inode.c	1.15    -> 1.16   
#	 fs/reiserfs/super.c	1.52    -> 1.53   
#	      fs/affs/file.c	1.20    -> 1.21   
#	include/asm-ppc/types.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/23	peterc@numbat.chubb.wattle.id.au	1.516
# The last in the current patch set: enable sector_t larger than 32-bits; and 
# a few compiler warnings fixed up.
# --------------------------------------------
#
diff -Nru a/drivers/block/Config.help b/drivers/block/Config.help
--- a/drivers/block/Config.help	Fri Aug 23 15:43:40 2002
+++ b/drivers/block/Config.help	Fri Aug 23 15:43:40 2002
@@ -258,3 +258,7 @@
   supported by this driver, and for further information on the use of
   this driver.
 
+CONFIG_LBD
+  Say Y here if you want to attach large (bigger than 2TB) discs to
+  your machine, or if you want to have a raid or loopback device
+  bigger than 2TB.  Otherwise say N.
diff -Nru a/drivers/block/Config.in b/drivers/block/Config.in
--- a/drivers/block/Config.in	Fri Aug 23 15:43:40 2002
+++ b/drivers/block/Config.in	Fri Aug 23 15:43:40 2002
@@ -48,4 +48,7 @@
 fi
 dep_bool '  Initial RAM disk (initrd) support' CONFIG_BLK_DEV_INITRD $CONFIG_BLK_DEV_RAM
 
+if [ "$CONFIG_X86" = "y" -o "$CONFIG_PPC32" = "y" ]; then
+   bool 'Support for Large Block Devices' CONFIG_LBD
+fi
 endmenu
diff -Nru a/fs/affs/file.c b/fs/affs/file.c
--- a/fs/affs/file.c	Fri Aug 23 15:43:40 2002
+++ b/fs/affs/file.c	Fri Aug 23 15:43:40 2002
@@ -337,10 +337,11 @@
 	struct buffer_head	*ext_bh;
 	u32			 ext;
 
-	pr_debug("AFFS: get_block(%u, %ld)\n", (u32)inode->i_ino, block);
+	pr_debug("AFFS: get_block(%u, %lu)\n", (u32)inode->i_ino, (unsigned long)block);
 
-	if (block < 0)
-		goto err_small;
+
+	if (block > (sector_t)0x7fffffffUL)
+		BUG();
 
 	if (block >= AFFS_I(inode)->i_blkcnt) {
 		if (block > AFFS_I(inode)->i_blkcnt || !create)
@@ -351,12 +352,12 @@
 	//lock cache
 	affs_lock_ext(inode);
 
-	ext = block / AFFS_SB(sb)->s_hashsize;
+	ext = (u32)block / AFFS_SB(sb)->s_hashsize;
 	block -= ext * AFFS_SB(sb)->s_hashsize;
 	ext_bh = affs_get_extblock(inode, ext);
 	if (IS_ERR(ext_bh))
 		goto err_ext;
-	map_bh(bh_result, sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, block)));
+	map_bh(bh_result, sb, (sector_t)be32_to_cpu(AFFS_BLOCK(sb, ext_bh, block)));
 
 	if (create) {
 		u32 blocknr = affs_alloc_block(inode, ext_bh->b_blocknr);
@@ -421,7 +422,7 @@
 	return cont_prepare_write(page, from, to, affs_get_block,
 		&AFFS_I(page->mapping->host)->mmu_private);
 }
-static int _affs_bmap(struct address_space *mapping, long block)
+static sector_t _affs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,affs_get_block);
 }
diff -Nru a/fs/affs/inode.c b/fs/affs/inode.c
--- a/fs/affs/inode.c	Fri Aug 23 15:43:40 2002
+++ b/fs/affs/inode.c	Fri Aug 23 15:43:40 2002
@@ -416,7 +416,7 @@
 	}
 	affs_fix_checksum(sb, bh);
 	mark_buffer_dirty_inode(bh, inode);
-	dentry->d_fsdata = (void *)bh->b_blocknr;
+	dentry->d_fsdata = (void *)(long)bh->b_blocknr;
 
 	affs_lock_dir(dir);
 	retval = affs_insert_hash(dir, bh);
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Fri Aug 23 15:43:40 2002
+++ b/fs/reiserfs/super.c	Fri Aug 23 15:43:40 2002
@@ -902,7 +902,7 @@
     ll_rw_block(READ, 1, &(SB_AP_BITMAP(s)[i])) ;
     wait_on_buffer(SB_AP_BITMAP(s)[i]) ;
     if (!buffer_uptodate(SB_AP_BITMAP(s)[i])) {
-      printk("reread_meta_blocks, error reading bitmap block number %d at %ld\n", i, SB_AP_BITMAP(s)[i]->b_blocknr) ;
+      printk("reread_meta_blocks, error reading bitmap block number %d at %lld\n", i, (long long)SB_AP_BITMAP(s)[i]->b_blocknr) ;
       return 1 ;
     }
   }
diff -Nru a/include/asm-i386/types.h b/include/asm-i386/types.h
--- a/include/asm-i386/types.h	Fri Aug 23 15:43:40 2002
+++ b/include/asm-i386/types.h	Fri Aug 23 15:43:40 2002
@@ -52,6 +52,11 @@
 #endif
 typedef u64 dma64_addr_t;
 
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#define HAVE_SECTOR_T
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -Nru a/include/asm-ppc/types.h b/include/asm-ppc/types.h
--- a/include/asm-ppc/types.h	Fri Aug 23 15:43:40 2002
+++ b/include/asm-ppc/types.h	Fri Aug 23 15:43:40 2002
@@ -48,6 +48,11 @@
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#define HAVE_SECTOR_T
+#endif
+
 #endif /* __KERNEL__ */
 
 /*
diff -Nru a/include/linux/types.h b/include/linux/types.h
--- a/include/linux/types.h	Fri Aug 23 15:43:40 2002
+++ b/include/linux/types.h	Fri Aug 23 15:43:40 2002
@@ -117,13 +117,11 @@
 #endif
 
 /*
- * transition to 64-bit sector_t, possibly making it an option...
+ * The type used for indexing onto a disc or disc partition.
+ * If required, asm/types.h can override it and define
+ * HAVE_SECTOR_T
  */
-#undef BLK_64BIT_SECTOR
-
-#ifdef BLK_64BIT_SECTOR
-typedef u64 sector_t;
-#else
+#ifndef HAVE_SECTOR_T
 typedef unsigned long sector_t;
 #endif
 
