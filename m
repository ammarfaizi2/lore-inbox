Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVF1MCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVF1MCn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVF1MCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:02:43 -0400
Received: from verein.lst.de ([213.95.11.210]:59798 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261402AbVF1MCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:02:14 -0400
Date: Tue, 28 Jun 2005 14:01:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: cotte@de.ibm.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] xip cleanups
Message-ID: <20050628120159.GA1745@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adjust to kernel style and remove some unneeded NULL checks


Index: linux-2.6/fs/ext2/xip.c
===================================================================
--- linux-2.6.orig/fs/ext2/xip.c	2005-06-26 13:26:24.000000000 +0200
+++ linux-2.6/fs/ext2/xip.c	2005-06-26 13:30:39.000000000 +0200
@@ -15,42 +15,39 @@
 #include "xip.h"
 
 static inline int
-__inode_direct_access(struct inode *inode, sector_t sector, unsigned long *data) {
+__inode_direct_access(struct inode *inode, sector_t sector, unsigned long *data)
+{
 	BUG_ON(!inode->i_sb->s_bdev->bd_disk->fops->direct_access);
 	return inode->i_sb->s_bdev->bd_disk->fops
 		->direct_access(inode->i_sb->s_bdev,sector,data);
 }
 
 int
-ext2_clear_xip_target(struct inode *inode, int block) {
-	sector_t sector = block*(PAGE_SIZE/512);
+ext2_clear_xip_target(struct inode *inode, int block)
+{
+	sector_t sector = block * (PAGE_SIZE/512);
 	unsigned long data;
 	int rc;
 
 	rc = __inode_direct_access(inode, sector, &data);
-	if (rc)
-		return rc;
-	clear_page((void*)data);
-	return 0;
+	if (!rc)
+		clear_page(data);
+	return rc;
 }
 
 void ext2_xip_verify_sb(struct super_block *sb)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 
-	if ((sbi->s_mount_opt & EXT2_MOUNT_XIP)) {
-		if ((sb->s_bdev == NULL) ||
-			sb->s_bdev->bd_disk == NULL ||
-			sb->s_bdev->bd_disk->fops == NULL ||
-			sb->s_bdev->bd_disk->fops->direct_access == NULL) {
-			sbi->s_mount_opt &= (~EXT2_MOUNT_XIP);
-			ext2_warning(sb, __FUNCTION__,
-				"ignoring xip option - not supported by bdev");
-		}
+	if ((sbi->s_mount_opt & EXT2_MOUNT_XIP) &&
+	    !sb->s_bdev->bd_disk->fops->direct_access) {
+		sbi->s_mount_opt &= ~EXT2_MOUNT_XIP;
+		ext2_warning(sb, __FUNCTION__,
+			"ignoring xip option - not supported by bdev");
 	}
 }
 
-struct page*
+struct page *
 ext2_get_xip_page(struct address_space *mapping, sector_t blockno,
 		   int create)
 {
@@ -60,7 +57,7 @@
 
 	tmp.b_state = 0;
 	tmp.b_blocknr = 0;
-	rc = ext2_get_block(mapping->host, blockno/(PAGE_SIZE/512) , &tmp,
+	rc = ext2_get_block(mapping->host, blockno/(PAGE_SIZE/512), &tmp,
 				create);
 	if (rc)
 		return ERR_PTR(rc);
@@ -71,7 +68,7 @@
 	}
 
 	rc = __inode_direct_access
-		(mapping->host,tmp.b_blocknr*(PAGE_SIZE/512) ,&data);
+		(mapping->host,tmp.b_blocknr * (PAGE_SIZE/512), &data);
 	if (rc)
 		return ERR_PTR(rc);
 
