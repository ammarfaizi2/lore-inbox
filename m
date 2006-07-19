Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030271AbWGSUWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWGSUWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 16:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWGSUWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 16:22:15 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:16573 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1030271AbWGSUWO (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 16:22:14 -0400
Message-ID: <44BE947F.30507@namesys.com>
Date: Wed, 19 Jul 2006 13:22:23 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [PATCH] Reiser4 bug fixes
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully this will make reiser4 stable code again.  Or at least, a lot more stable than v3 (or other FSes) was when it went in....


Signed-off-by: Hans Reiser

From: Vladimir Saveliev <vs@namesys.com>

This patch contains 4 reiser4 bug fixes:
- missing long term lock unlock on read' error handling code path is added
- truncate_inode_pages is now called with embedded mapping. 
  It is needed to deal properly with block device special files.
- copy_to_user might be called for more bytes than was prefaulted with fault_in_pages_writeable.
  That caused undesirable major page faults.
- readdir bug similar to the previous one:
  call to filldir might lead to deadlock due to major page fault.

Signed-off-by: Vladimir Saveliev <vs@namesys.com>



diff -puN fs/reiser4/super_ops.c~reiser4-one-line-fixes fs/reiser4/super_ops.c
--- linux-2.6.18-rc-mm2/fs/reiser4/super_ops.c~reiser4-one-line-fixes	2006-07-19 16:25:49.000000000 +0400
+++ linux-2.6.18-rc-mm2-vs/fs/reiser4/super_ops.c	2006-07-19 16:25:49.000000000 +0400
@@ -202,7 +202,7 @@ static void reiser4_delete_inode(struct 
 			fplug->delete_object(inode);
 	}
 
-	truncate_inode_pages(inode->i_mapping, 0);
+	truncate_inode_pages(&inode->i_data, 0);
 	inode->i_blocks = 0;
 	clear_inode(inode);
 	reiser4_exit_context(ctx);
diff -puN fs/reiser4/plugin/file/file.c~reiser4-one-line-fixes fs/reiser4/plugin/file/file.c
--- linux-2.6.18-rc-mm2/fs/reiser4/plugin/file/file.c~reiser4-one-line-fixes	2006-07-19 16:25:49.000000000 +0400
+++ linux-2.6.18-rc-mm2-vs/fs/reiser4/plugin/file/file.c	2006-07-19 17:35:35.000000000 +0400
@@ -781,9 +781,12 @@ int find_or_create_extent(struct page *p
 
 	lock_page(page);
 	node = jnode_of_page(page);
-	unlock_page(page);
-	if (IS_ERR(node))
+	if (IS_ERR(node)) {
+		unlock_page(page);
 		return PTR_ERR(node);
+	}
+	JF_SET(node, JNODE_WRITE_PREPARED);
+	unlock_page(page);
 
 	if (node->blocknr == 0) {
 		plugged_hole = 0;
@@ -791,6 +794,7 @@ int find_or_create_extent(struct page *p
 				       (loff_t)page->index << PAGE_CACHE_SHIFT,
 				       &plugged_hole);
 		if (result) {
+ 			JF_CLR(node, JNODE_WRITE_PREPARED);
 			jput(node);
 			warning("", "update_extent failed: %d", result);
 			return result;
@@ -806,6 +810,7 @@ int find_or_create_extent(struct page *p
 	}
 
 	BUG_ON(node->atom == NULL);
+	JF_CLR(node, JNODE_WRITE_PREPARED);
 	jput(node);
 
 	if (get_current_context()->entd) {
@@ -1631,14 +1636,18 @@ static size_t read_file(hint_t * hint, s
 			/* error happened */
 			break;
 
-		if (coord->between != AT_UNIT)
+		if (coord->between != AT_UNIT) {
 			/* there were no items corresponding to given offset */
+			done_lh(hint->ext_coord.lh);
 			break;
+		}
 
 		loaded = coord->node;
 		result = zload(loaded);
-		if (unlikely(result))
+		if (unlikely(result)) {
+			done_lh(hint->ext_coord.lh);
 			break;
+		}
 
 		if (hint->ext_coord.valid == 0)
 			validate_extended_coord(&hint->ext_coord,
@@ -1729,7 +1738,9 @@ ssize_t read_unix_file(struct file *file
 			return RETERR(-EFAULT);
 		}
 
-		read = read_file(hint, file, buf, left, off);
+		read = read_file(hint, file, buf,
+				 left > PAGE_CACHE_SIZE ? PAGE_CACHE_SIZE : left,
+				 off);
 
  		drop_nonexclusive_access(uf_info);
 
diff -puN fs/reiser4/plugin/file_ops_readdir.c~reiser4-one-line-fixes fs/reiser4/plugin/file_ops_readdir.c
--- linux-2.6.18-rc-mm2/fs/reiser4/plugin/file_ops_readdir.c~reiser4-one-line-fixes	2006-07-19 16:25:49.000000000 +0400
+++ linux-2.6.18-rc-mm2-vs/fs/reiser4/plugin/file_ops_readdir.c	2006-07-19 16:25:49.000000000 +0400
@@ -349,6 +349,7 @@ feed_entry(struct file *f,
 	 */
 	assert("nikita-3436", lock_stack_isclean(get_current_lock_stack()));
 
+	txn_restart_current();
 	result = filldir(dirent, name, (int)strlen(name),
 			 /* offset of this entry */
 			 f->f_pos,
@@ -630,7 +631,7 @@ int readdir_common(struct file *f /* dir
 	detach_fsdata(f);
 
 	/* try to update directory's atime */
-	if (reiser4_grab_space(inode_file_plugin(inode)->estimate.update(inode),
+	if (reiser4_grab_space_force(inode_file_plugin(inode)->estimate.update(inode),
 			       BA_CAN_COMMIT) != 0)
 		warning("", "failed to update atime on readdir: %llu",
 			get_inode_oid(inode));

_

