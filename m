Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbTGCJkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 05:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTGCJkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 05:40:42 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:47 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S265664AbTGCJki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 05:40:38 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.74 xattr fixes
From: <ffrederick@prov-liege.be>
Cc: <ffrederick@users.sourceforge.net>
Date: Thu, 3 Jul 2003 12:17:21 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S265664AbTGCJki/20030703094038Z+16122@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Frederick:
-Removed old BKL comments
-Typo fix
-Doc precision 

PS : Someone could check if lock_super is still needed there ?

--- linux-2.5.74/fs/ext2/xattr.c	2003-07-03 09:34:35.000000000 +0200
+++ edited/fs/ext2/xattr.c	2003-07-03 11:09:30.000000000 +0200
@@ -32,7 +32,7 @@
  *   +------------------+
  *
  * The block header is followed by multiple entry descriptors. These entry
- * descriptors are variable in size, and alligned to EXT2_XATTR_PAD
+ * descriptors are variable in size, and aligned to EXT2_XATTR_PAD
  * byte boundaries. The entry descriptors are sorted by attribute name,
  * so that two extended attribute blocks can be compared efficiently.
  *
@@ -184,6 +184,7 @@ static inline struct ext2_xattr_handler 
 ext2_xattr_handler(int name_index)
 {
 	struct ext2_xattr_handler *handler = NULL;
+
 	if (name_index > 0 && name_index <= EXT2_XATTR_INDEX_MAX) {
 		read_lock(&ext2_handler_lock);
 		handler = ext2_xattr_handlers[name_index-1];
@@ -196,7 +197,6 @@ ext2_xattr_handler(int name_index)
  * Inode operation getxattr()
  *
  * dentry->d_inode->i_sem down
- * BKL held [before 2.5.x]
  */
 ssize_t
 ext2_getxattr(struct dentry *dentry, const char *name,
@@ -215,7 +215,6 @@ ext2_getxattr(struct dentry *dentry, con
  * Inode operation listxattr()
  *
  * dentry->d_inode->i_sem down
- * BKL held [before 2.5.x]
  */
 ssize_t
 ext2_listxattr(struct dentry *dentry, char *buffer, size_t size)
@@ -227,7 +226,6 @@ ext2_listxattr(struct dentry *dentry, ch
  * Inode operation setxattr()
  *
  * dentry->d_inode->i_sem down
- * BKL held [before 2.5.x]
  */
 int
 ext2_setxattr(struct dentry *dentry, const char *name,
@@ -248,7 +246,6 @@ ext2_setxattr(struct dentry *dentry, con
  * Inode operation removexattr()
  *
  * dentry->d_inode->i_sem down
- * BKL held [before 2.5.x]
  */
 int
 ext2_removexattr(struct dentry *dentry, const char *name)
@@ -769,7 +766,6 @@ ext2_xattr_set2(struct inode *inode, str
 			set_buffer_uptodate(new_bh);
 			unlock_buffer(new_bh);
 			ext2_xattr_cache_insert(new_bh);
-			
 			ext2_xattr_update_super_block(sb);
 		}
 		mark_buffer_dirty(new_bh);
@@ -892,7 +888,7 @@ ext2_xattr_put_super(struct super_block 
  * Create a new entry in the extended attribute cache, and insert
  * it unless such an entry is already in the cache.
  *
- * Returns 0, or a negative error number on failure.
+ * Returns 0 (ok) or -ENOMEM on failure.
  */
 static int
 ext2_xattr_cache_insert(struct buffer_head *bh)
@@ -933,7 +929,7 @@ ext2_xattr_cmp(struct ext2_xattr_header 
 	       struct ext2_xattr_header *header2)
 {
 	struct ext2_xattr_entry *entry1, *entry2;
-
+	/* First entry available after xattr_header */
 	entry1 = ENTRY(header1+1);
 	entry2 = ENTRY(header2+1);
 	while (!IS_LAST_ENTRY(entry1)) {


___________________________________



