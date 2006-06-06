Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWFFSzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWFFSzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWFFSzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:55:39 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:41115 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750962AbWFFSzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:55:39 -0400
Subject: [patch, 2.6.17-rc5-mm3] Lockdep: Annotate the quota code
From: Arjan van de Ven <arjan@linux.intel.com>
To: akpm@osdl.org
Cc: mingo@elte.hu, jack@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Jun 2006 20:55:20 +0200
Message-Id: <1149620121.2951.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The quota code plays interesting games with the lock ordering; to quote
Jan:

| i_mutex of inode containing quota file is acquired after all other
| quota locks. i_mutex of all other inodes is acquired before quota
| locks. Quota code makes sure (by resetting inode operations and
| setting special flag on inode) that noone tries to enter quota code
| while holding i_mutex on a quota file...

The good news is that all of this special case i_mutex grabbing happens
in the (per filesystem) low level quota write function. For this special
case we need a new I_MUTEX_* nesting level, since this just entirely
outside any of the regular VFS locking rules for i_mutex. I trust Jan on
his blue eyes that this is not ever going to deadlock; and based on that
the patch below is what it takes to inform lockdep of these very
interesting new locking rules.

The new locking rule for the I_MUTEX_QUOTA nesting level is that this is
the deepest possible level of nesting for i_mutex, and that this only
should be used in quota write (and possibly read) function of
filesystems. This makes the lock ordering of the I_MUTEX_* levels:

I_MUTEX_PARENT -> I_MUTEX_CHILD -> I_MUTEX_NORMAL -> I_MUTEX_QUOTA


Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Ingo Molnar <mingo@elte.hu>

---
 fs/dquot.c          |    2 +-
 fs/ext2/super.c     |    2 +-
 fs/ext3/super.c     |    2 +-
 fs/reiserfs/super.c |    2 +-
 fs/ufs/super.c      |    2 +-
 include/linux/fs.h  |    7 ++++++-
 6 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6.17-rc5-mm3/fs/dquot.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/dquot.c
+++ linux-2.6.17-rc5-mm3/fs/dquot.c
@@ -1475,7 +1475,7 @@ static int vfs_quota_on_inode(struct ino
 		goto out_file_init;
 	}
 	mutex_unlock(&dqopt->dqio_mutex);
-	mutex_unlock(&inode->i_mutex);
+	mutex_unlock_non_nested(&inode->i_mutex);
 	set_enable_flags(dqopt, type);
 
 	add_dquot_ref(sb, type);
Index: linux-2.6.17-rc5-mm3/fs/ext2/super.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/ext2/super.c
+++ linux-2.6.17-rc5-mm3/fs/ext2/super.c
@@ -1157,7 +1157,7 @@ static ssize_t ext2_quota_write(struct s
 	struct buffer_head tmp_bh;
 	struct buffer_head *bh;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_QUOTA);
 	while (towrite > 0) {
 		tocopy = sb->s_blocksize - offset < towrite ?
 				sb->s_blocksize - offset : towrite;
Index: linux-2.6.17-rc5-mm3/fs/ext3/super.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/ext3/super.c
+++ linux-2.6.17-rc5-mm3/fs/ext3/super.c
@@ -2614,7 +2614,7 @@ static ssize_t ext3_quota_write(struct s
 	struct buffer_head *bh;
 	handle_t *handle = journal_current_handle();
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_QUOTA);
 	while (towrite > 0) {
 		tocopy = sb->s_blocksize - offset < towrite ?
 				sb->s_blocksize - offset : towrite;
Index: linux-2.6.17-rc5-mm3/fs/reiserfs/super.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/reiserfs/super.c
+++ linux-2.6.17-rc5-mm3/fs/reiserfs/super.c
@@ -2204,7 +2204,7 @@ static ssize_t reiserfs_quota_write(stru
 	size_t towrite = len;
 	struct buffer_head tmp_bh, *bh;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_QUOTA);
 	while (towrite > 0) {
 		tocopy = sb->s_blocksize - offset < towrite ?
 		    sb->s_blocksize - offset : towrite;
Index: linux-2.6.17-rc5-mm3/fs/ufs/super.c
===================================================================
--- linux-2.6.17-rc5-mm3.orig/fs/ufs/super.c
+++ linux-2.6.17-rc5-mm3/fs/ufs/super.c
@@ -1269,7 +1269,7 @@ static ssize_t ufs_quota_write(struct su
 	size_t towrite = len;
 	struct buffer_head *bh;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_QUOTA);
 	while (towrite > 0) {
 		tocopy = sb->s_blocksize - offset < towrite ?
 				sb->s_blocksize - offset : towrite;
Index: linux-2.6.17-rc5-mm3/include/linux/fs.h
===================================================================
--- linux-2.6.17-rc5-mm3.orig/include/linux/fs.h
+++ linux-2.6.17-rc5-mm3/include/linux/fs.h
@@ -563,12 +563,17 @@ struct inode {
  * 0: the object of the current VFS operation
  * 1: parent
  * 2: child/target
+ * 3: quota file
+ *
+ * The locking order between these types is
+ * parent -> child -> normal -> quota
  */
 enum inode_i_mutex_lock_type
 {
 	I_MUTEX_NORMAL,
 	I_MUTEX_PARENT,
-	I_MUTEX_CHILD
+	I_MUTEX_CHILD,
+	I_MUTEX_QUOTA
 };
 
 /*

